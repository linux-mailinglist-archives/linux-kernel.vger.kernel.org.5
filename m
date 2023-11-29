Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A3A7FCD94
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376818AbjK2DnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjK2Dm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:42:56 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C0A19AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:42:57 -0800 (PST)
X-UUID: 5e2ae1268e6911ee8051498923ad61e6-20231129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MFrmkl3FpVdv2jTHH29SfVBZoqzJBE5Ed5AoaMdUtQc=;
        b=hri4SC49SLNS2OovdCBAAq3/u6RqdCRIeb0lqxkXX5/mMfBHWf1P5e1mkcnBC0k71js22z1gng7N6tTtjbG9294Vzh1HUuQEm5FxbYSAu7ophEC8eIboHRdfhqlK7jERn2omXw46ojJyPJUdC61qB4kt8I+7B+9AzmMjMOYNprc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:48c3a553-c321-4064-bbc9-c944b9c6db31,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:54083173-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:0|-5,EDM:-3,I
        P:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
        :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5e2ae1268e6911ee8051498923ad61e6-20231129
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1607420559; Wed, 29 Nov 2023 11:42:49 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 Nov 2023 11:42:48 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 Nov 2023 11:42:48 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     <andreyknvl@gmail.com>
CC:     <akpm@linux-foundation.org>,
        <angelogioacchino.delregno@collabora.com>, <dvyukov@google.com>,
        <glider@google.com>, <haibo.li@mediatek.com>,
        <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mm@kvack.org>,
        <lkp@intel.com>, <matthias.bgg@gmail.com>,
        <ryabinin.a.a@gmail.com>, <vincenzo.frascino@arm.com>,
        <xiaoming.yu@mediatek.com>
Subject: Re: [PATCH] fix comparison of unsigned expression < 0
Date:   Wed, 29 Nov 2023 11:42:47 +0800
Message-ID: <20231129034247.226365-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <CA+fCnZcLwXn6crGF1E1cY3TknMaUN=H8-_hp0-cC+s8-wj95PQ@mail.gmail.com>
References: <CA+fCnZcLwXn6crGF1E1cY3TknMaUN=H8-_hp0-cC+s8-wj95PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.269300-8.000000
X-TMASE-MatchedRID: L8tZF6zWW2q0m/IROg5s5fHkpkyUphL9HTzSJQBZgdFqI8duabhZa/79
        6l+IAtl+w8XU8bLzT9L5qR7J2CotBvww9Stut6YHmNvbnzNu6oLTDXgcUlCNowFbHA9TqNLQmtk
        ZkOzLak8jjoep8ZitK6EZtwWhhaEgAYINegaglbBc/msUC5wFQX4rryovYbmmQ4pQeOTu+8UY20
        f1wrB11n4I3WRiw3QYqULTfmF5uZHqi7LDVhVKr51U1lojafr//5QRvrl2CZCo+b+yOP0oGFC9o
        pMYDUg2585VzGMOFzA9wJeM2pSaRbxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.269300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9998098F6E1CA8C593C63DD30B494B533A460EDFA2BA4999AF9EE84F9D7D46BD2000:8
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Nov 29, 2023 at 2:22 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 28 Nov 2023 15:55:32 +0800 Haibo Li <haibo.li@mediatek.com> wrote:
> >
> > > Kernel test robot reported:
> > >
> > > '''
> > > mm/kasan/report.c:637 kasan_non_canonical_hook() warn:
> > > unsigned 'addr' is never less than zero.
> > > '''
> > > The KASAN_SHADOW_OFFSET is 0 on loongarch64.
> > >
> > > To fix it,check the KASAN_SHADOW_OFFSET before do comparison.
> > >
> > > --- a/mm/kasan/report.c
> > > +++ b/mm/kasan/report.c
> > > @@ -634,10 +634,10 @@ void kasan_non_canonical_hook(unsigned long addr)
> > >  {
> > >       unsigned long orig_addr;
> > >       const char *bug_type;
> > > -
> > > +#if KASAN_SHADOW_OFFSET > 0
> > >       if (addr < KASAN_SHADOW_OFFSET)
> > >               return;
> > > -
> > > +#endif
> >
> > We'd rather not add ugly ifdefs for a simple test like this.  If we
> > replace "<" with "<=", does it fix?  I suspect that's wrong.
>
> Changing the comparison into "<=" would be wrong.
>
> But I actually don't think we need to fix anything here.
>
> This issue looks quite close to a similar comparison with 0 issue
> Linus shared his opinion on here:
>
> https://lore.kernel.org/all/Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org/
>
> I don't know if the common consensus with the regard to issues like
> that changed since then. But if not, perhaps we can treat this kernel
> test robot report as a false positive.
>
> Thanks!

Thanks for the information.Let's keep it as unchanged.

