Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E077DF7D5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377088AbjKBQhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKBQht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:37:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEAE19D;
        Thu,  2 Nov 2023 09:37:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5709EC433C8;
        Thu,  2 Nov 2023 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698943065;
        bh=qvOVCM5IgQflaA5f7AYT2wFzjqGywSPcCDJvjeJKZc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yc/gvEa51TgPuaboK/BESRlcaeX+G5Fis1TYjltmRS7skKUXyn5SCDo8BgeVcpqH3
         5e7QJkrrsJ72bnBHvB/7ljY/GSojYQ4korVtZkD4UW3eQ4mKsHhflkPZNgmHGJsV9T
         qQMihW/BnXwyS5KPz6Y76NR49VItwH8Ulz0rhgcsepOSZlGkYMONGIO1m6oa9Qeakj
         jCAGUyr+5l+t4YqP/5SppicQEHvFoj47dzkDmFN3F0a6DaMJEnTVeWvAKG3Ag+iAxE
         hx/ikWexecIQL6g32a/tofRoTt6F1pi2OuiLrO1/qaAIJHaFn+CscP6/Xdvvc2GLhg
         YfqyBqVr8pykA==
Date:   Thu, 2 Nov 2023 22:07:28 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     naomi.chu@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>, wsd_upstream@mediatek.com,
        peter.wang@mediatek.com, casper.li@mediatek.com,
        powen.kao@mediatek.com, alice.chao@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        eddie.huang@mediatek.com
Subject: Re: [PATCH v3 1/1] ufs: core: Expand MCQ queue slot to
 DeviceQueueDepth + 1
Message-ID: <20231102163728.GB20943@thinkpad>
References: <20231102052426.12006-1-naomi.chu@mediatek.com>
 <20231102052426.12006-2-naomi.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231102052426.12006-2-naomi.chu@mediatek.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 01:24:24PM +0800, naomi.chu@mediatek.com wrote:
> From: Naomi Chu <naomi.chu@mediatek.com>
> 
> The UFSHCI 4.0 specification mandates that there should always be at
> least one empty slot in each queue for distinguishing between full and
> empty states. Enlarge the `hwq->max_entries` to `DeviceQueueDepth +1`
> to allow UFSHCI 4.0 controllers to fully utilize MCQ queue slots.
> 
> Fixes: 4682abfae2eb ("scsi: ufs: core: mcq: Allocate memory for MCQ mode")
> Signed-off-by: Naomi Chu <naomi.chu@mediatek.com>
> ---

Where is the changelog?

- Mani

>  drivers/ufs/core/ufs-mcq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 2ba8ec254dce..5c75ab9d6bb5 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -436,7 +436,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
>  
>  	for (i = 0; i < hba->nr_hw_queues; i++) {
>  		hwq = &hba->uhq[i];
> -		hwq->max_entries = hba->nutrs;
> +		hwq->max_entries = hba->nutrs + 1;
>  		spin_lock_init(&hwq->sq_lock);
>  		spin_lock_init(&hwq->cq_lock);
>  		mutex_init(&hwq->sq_mutex);
> -- 
> 2.18.0
> 

-- 
மணிவண்ணன் சதாசிவம்
