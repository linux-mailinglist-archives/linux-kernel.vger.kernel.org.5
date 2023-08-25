Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635CB7882BE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242395AbjHYI4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbjHYI4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:56:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62241BCD;
        Fri, 25 Aug 2023 01:56:23 -0700 (PDT)
X-UUID: 40ca513c432511eeb20a276fd37b9834-20230825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MHN0S3NVXg6tu8IUhj0JOWDrZPMV2zreJoNkVEz3ogg=;
        b=SZrw6RlHMOTZx8N1x/e51+/uQV0Pb3ZOpxc9JsldkO2MXT3evA3IMmK3JX99o4zwOTe9YhzMmLbl4P28mDBTDztyBldaJjfNkuPtm8u7nN3lFFSQgzxx4cWOdfpKYi0G7w4ah8PxE/eNlm+jnxMiNCjArFh6W7oZT1oE6ag8u/0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:86890a58-b60b-4e05-b52b-b6f78873ae62,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.31,REQID:86890a58-b60b-4e05-b52b-b6f78873ae62,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:0ad78a4,CLOUDID:7db42e13-4929-4845-9571-38c601e9c3c9,B
        ulkID:230824185604G6OMGZAT,BulkQuantity:27,Recheck:0,SF:28|17|19|48|64|29|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: 40ca513c432511eeb20a276fd37b9834-20230825
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <sharp.xia@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 582389376; Fri, 25 Aug 2023 16:56:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Aug 2023 16:56:12 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Aug 2023 16:56:11 +0800
From:   <Sharp.Xia@mediatek.com>
To:     <shawn.lin@rock-chips.com>
CC:     <Sharp.Xia@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <matthias.bgg@gmail.com>, <ulf.hansson@linaro.org>,
        <wsd_upstream@mediatek.com>
Subject: Re: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
Date:   Fri, 25 Aug 2023 16:39:18 +0800
Message-ID: <20230825083918.24334-1-Sharp.Xia@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <c8c059ce-53a9-3627-8984-dff771dff1de@rock-chips.com>
References: <c8c059ce-53a9-3627-8984-dff771dff1de@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-25 at 16:11 +0800, Shawn Lin wrote:
>  	 
>  Hi Sharp,
> 
> On 2023/8/25 15:10, Sharp Xia (夏宇彬) wrote:
> > On Thu, 2023-08-24 at 12:55 +0200, Ulf Hansson wrote:
> >>   
> >> External email : Please do not click links or open attachments
> until
> >> you have verified the sender or the content.
> >>   On Fri, 18 Aug 2023 at 04:45, <Sharp.Xia@mediatek.com> wrote:
> >>>
> >>> From: Sharp Xia <Sharp.Xia@mediatek.com>
> >>>
> >>> MMC does not set readahead and uses the default
> VM_READAHEAD_PAGES
> >>> resulting in slower reading speed.
> >>> Use the max_req_size reported by host driver to set the optimal
> >>> I/O size to improve performance.
> >>
> >> This seems reasonable to me. However, it would be nice if you
> could
> >> share some performance numbers too - comparing before and after
> >> $subject patch.
> >>
> >> Kind regards
> >> Uffe
> >>
> >>>
> >>> Signed-off-by: Sharp Xia <Sharp.Xia@mediatek.com>
> >>> ---
> >>>   drivers/mmc/core/queue.c | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> >>> index b396e3900717..fc83c4917360 100644
> >>> --- a/drivers/mmc/core/queue.c
> >>> +++ b/drivers/mmc/core/queue.c
> >>> @@ -359,6 +359,7 @@ static void mmc_setup_queue(struct mmc_queue
> >> *mq, struct mmc_card *card)
> >>>                  blk_queue_bounce_limit(mq->queue,
> BLK_BOUNCE_HIGH);
> >>>          blk_queue_max_hw_sectors(mq->queue,
> >>>                  min(host->max_blk_count, host->max_req_size /
> >> 512));
> >>> +       blk_queue_io_opt(mq->queue, host->max_req_size);
> >>>          if (host->can_dma_map_merge)
> >>>                  WARN(!blk_queue_can_use_dma_map_merging(mq-
> >queue,
> >>>                                                          mmc_dev(
> hos
> >> t)),
> >>> --
> >>> 2.18.0
> >>>
> > 
> > I test this patch on internal platform(kernel-5.15).
> 
> I patched this one and the test shows me a stable 11% performance
> drop.
> 
> Before:
> echo 3 > proc/sys/vm/drop_caches && dd if=/data/1GB.img of=/dev/null 
> 
> 2048000+0 records in
> 2048000+0 records out
> 1048576000 bytes (0.9 G) copied, 3.912249 s, 256 M/s
> 
> After:
> echo 3 > proc/sys/vm/drop_caches && dd if=/data/1GB.img of=/dev/null
> 2048000+0 records in
> 2048000+0 records out
> 1048576000 bytes (0.9 G) copied, 4.436271 s, 225 M/s
> 
> > 
> > Before:
> > console:/ # echo 3 > /proc/sys/vm/drop_caches
> > console:/ # dd if=/mnt/media_rw/8031-130D/super.img of=/dev/null
> > 4485393+1 records in
> > 4485393+1 records out
> > 2296521564 bytes (2.1 G) copied, 37.124446 s, 59 M/s
> > console:/ # cat /sys/block/mmcblk0/queue/read_ahead_kb
> > 128
> > 
> > After:
> > console:/ # echo 3 > /proc/sys/vm/drop_caches
> > console:/ # dd if=/mnt/media_rw/8031-130D/super.img of=/dev/null
> > 4485393+1 records in
> > 4485393+1 records out
> > 2296521564 bytes (2.1 G) copied, 28.956049 s, 76 M/s
> > console:/ # cat /sys/block/mmcblk0/queue/read_ahead_kb
> > 1024
> > 
Hi Shawn,

What is your readahead value before and after applying this patch?

