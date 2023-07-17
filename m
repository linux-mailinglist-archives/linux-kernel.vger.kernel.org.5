Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41660755948
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 03:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGQB5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 21:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGQB5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 21:57:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C34DE52;
        Sun, 16 Jul 2023 18:57:36 -0700 (PDT)
X-UUID: 496abba0244511eeb20a276fd37b9834-20230717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iWG5WrewmZyGOqX9g3fBInai637V8c0IB0YAxIq934s=;
        b=erb0pqvQU+77Z4XObw+hivyQ+0zdsAr1thX+qnIhHLllmdUuYUWQwIN5eNfMcJYYmVXNudGBrDHyZtR1wf8NfP1wtPNZ7PQbv/PUQeIapz+UetzG7QI22VfF1OiE8L7J+khBQoLo/cBvzSpzVGMTkE3b/CTpJuizmLqEOhGYqWM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:77017d85-47d1-496b-a3d9-dd56ef0fafbd,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:79
X-CID-INFO: VERSION:1.1.28,REQID:77017d85-47d1-496b-a3d9-dd56ef0fafbd,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:79
X-CID-META: VersionHash:176cd25,CLOUDID:6c33c64c-06c1-468b-847d-5b62d44dbb9b,B
        ulkID:2307162316286AMI74JA,BulkQuantity:18,Recheck:0,SF:19|48|29|28|17|102
        ,TC:nil,Content:0|-5,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_FCD,
        TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC
X-UUID: 496abba0244511eeb20a276fd37b9834-20230717
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1800077516; Mon, 17 Jul 2023 09:57:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 17 Jul 2023 09:57:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 17 Jul 2023 09:57:28 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <snitzer@redhat.com>
CC:     <agk@redhat.com>, <corbet@lwn.net>, <dm-devel@redhat.com>,
        <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <peter@korsgaard.com>,
        <snitzer@kernel.org>, <stable@vger.kernel.org>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH 5.15] dm init: add dm-mod.waitfor to wait for asynchronously probed block devices
Date:   Mon, 17 Jul 2023 09:57:28 +0800
Message-ID: <20230717015728.12641-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAH6w=aztzhm3Sa-afN2Xk-7mp1BVtTKNXJ=JyXqJvm3wtEnd3Q@mail.gmail.com>
References: <CAH6w=aztzhm3Sa-afN2Xk-7mp1BVtTKNXJ=JyXqJvm3wtEnd3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Jul 16, 2023, 11:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Jul 13, 2023 at 01:58:37PM +0800, Mark-PK Tsai wrote:
> > > From: Peter Korsgaard <peter@korsgaard.com>
> > > 
> > > Just calling wait_for_device_probe() is not enough to ensure that
> > > asynchronously probed block devices are available (E.G. mmc, usb), so
> > > add a "dm-mod.waitfor=<device1>[,..,<deviceN>]" parameter to get
> > > dm-init to explicitly wait for specific block devices before
> > > initializing the tables with logic similar to the rootwait logic that
> > > was introduced with commit  cc1ed7542c8c ("init: wait for
> > > asynchronously scanned block devices").
> > > 
> > > E.G. with dm-verity on mmc using:
> > > dm-mod.waitfor="PARTLABEL=hash-a,PARTLABEL=root-a"
> > > 
> > > [    0.671671] device-mapper: init: waiting for all devices to be 
> > available before creating mapped devices
> > > [    0.671679] device-mapper: init: waiting for device PARTLABEL=hash-a 
> > ...
> > > [    0.710695] mmc0: new HS200 MMC card at address 0001
> > > [    0.711158] mmcblk0: mmc0:0001 004GA0 3.69 GiB
> > > [    0.715954] mmcblk0boot0: mmc0:0001 004GA0 partition 1 2.00 MiB
> > > [    0.722085] mmcblk0boot1: mmc0:0001 004GA0 partition 2 2.00 MiB
> > > [    0.728093] mmcblk0rpmb: mmc0:0001 004GA0 partition 3 512 KiB, 
> > chardev (249:0)
> > > [    0.738274]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
> > > [    0.751282] device-mapper: init: waiting for device PARTLABEL=root-a 
> > ...
> > > [    0.751306] device-mapper: init: all devices available
> > > [    0.751683] device-mapper: verity: sha256 using implementation 
> > "sha256-generic"
> > > [    0.759344] device-mapper: ioctl: dm-0 (vroot) is ready
> > > [    0.766540] VFS: Mounted root (squashfs filesystem) readonly on 
> > device 254:0.
> > > 
> > > Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > > ---
> > >  .../admin-guide/device-mapper/dm-init.rst     |  8 +++++++
> > >  drivers/md/dm-init.c                          | 22 ++++++++++++++++++-
> > >  2 files changed, 29 insertions(+), 1 deletion(-)
> >
> > What is the git commit id of this change in Linus's tree?
> >
> > thanks,
> >
> > greg k-h
> >
> >
> 
> Hey Greg,
> 
> This change shouldn't be backported to stable@. It is a feature, if
> Mark-PK feels they need it older kernels they need to carry the change
> in their own tree. Or at a minimum they need to explain why this
> change is warranted in stable@.

Thanks for your comment.
The reason why we think this should be backported to stable kernel is
that it actually fix the potential race condition when make block
device probe async in stable kernel.
And we'd like to fix this upstream rather than just take it in
our custom tree.

> 
> But to answer your original question the upstream commit is:
> 
> 035641b01e72 dm init: add dm-mod.waitfor to wait for asynchronously probed block devices
> 
> Thanks,
> Mike
