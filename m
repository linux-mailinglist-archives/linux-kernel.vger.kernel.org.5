Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC50E807E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442173AbjLGBnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjLGBnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:43:14 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E719E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:43:18 -0800 (PST)
X-UUID: 5aa9ead4bf7f45ebb64da22b7e64f6e2-20231207
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:8fb5be05-f92e-467d-8ff9-69eadee6c510,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:1,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:5
X-CID-INFO: VERSION:1.1.33,REQID:8fb5be05-f92e-467d-8ff9-69eadee6c510,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:1,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:5
X-CID-META: VersionHash:364b77b,CLOUDID:6768e760-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:2312070943101BF84CQB,BulkQuantity:0,Recheck:0,SF:100|66|24|72|19|42|
        101|74|64|102,TC:nil,Content:1,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil
        ,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 5aa9ead4bf7f45ebb64da22b7e64f6e2-20231207
X-User: jiangyunshui@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <jiangyunshui@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 733524998; Thu, 07 Dec 2023 09:43:08 +0800
From:   jiangyunshui <jiangyunshui@kylinos.cn>
To:     christophe.leroy@csgroup.eu
Cc:     ajd@linux.ibm.com, fbarrat@linux.ibm.com, jiangyunshui@kylinos.cn,
        kernel-bot@kylinos.cn, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ocxl: fix driver function comment typo
Date:   Thu,  7 Dec 2023 09:43:07 +0800
Message-Id: <20231207014307.12256-1-jiangyunshui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2f2aca95-f5a6-45fa-9e3b-37aecf657299@csgroup.eu>
References: <2f2aca95-f5a6-45fa-9e3b-37aecf657299@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 5 Dec 2023 11:00:16 +0000	[thread overview]
> Message-ID: <2f2aca95-f5a6-45fa-9e3b-37aecf657299@csgroup.eu> (raw)
> In-Reply-To: <20231205094319.32114-1-jiangyunshui@kylinos.cn>

> Please add a description explaining why you want to do that change.

> When I grep I see cxlflash driver, I don't know what ocxlflash driver is:

> $ git grep ocxl_config_read_afu
> ...
> drivers/scsi/cxlflash/ocxl_hw.c:        rc = ocxl_config_read_afu(pdev, 
> fcfg, acfg, 0);
> drivers/scsi/cxlflash/ocxl_hw.c:                dev_err(dev, "%s: 
> ocxl_config_read_afu failed rc=%d\n",
> include/misc/ocxl.h:int ocxl_config_read_afu(struct pci_dev *dev,

> Christophe

I checked my commit again and found I'd mismatched the driver's name with other things.
As you said it doesn't make sense to change cxlflash to ocxlflash.
Sorry for the inconvenience, you could just drop my commit please.
Thanks,

Yunshui

> ---
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: yunshui <jiangyunshui@kylinos.cn>
> ---
>   include/misc/ocxl.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 3ed736da02c8..ef7d26009a36 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -324,7 +324,7 @@ int ocxl_global_mmio_clear32(struct ocxl_afu *afu, size_t offset,
>   int ocxl_global_mmio_clear64(struct ocxl_afu *afu, size_t offset,
>                               enum ocxl_endian endian, u64 mask);
>
> -// Functions left here are for compatibility with the cxlflash driver
> +// Functions left here are for compatibility with the ocxlflash driver
>
>   /*
>    * Read the configuration space of a function for the AFU specified by
> --
> 2.25.1
>
