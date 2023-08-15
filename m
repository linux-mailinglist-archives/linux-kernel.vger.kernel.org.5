Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9530577C566
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjHOBtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjHOBs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:48:56 -0400
Received: from email.cn (m218-171.88.com [110.43.218.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08B11FC0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=5oiZq/6VBinqxL9ViYc/YPptGSlrXSgjxoo0E
        latgsY=; b=EgZOlgV2hUqLaHDMtY/WZi9wVGTV2IjZbJSsSvGwfSF7w781BIvxl
        bPYt+Q6y2CeZO9hFqQPCkcI81JHNopMcb565sZdDAAZCl9/whr459mbiUnImo+nN
        E5NrDumyuIra8PsP2XBUF8H0/Y2rpnW0CVMaoC/PlRhcPEhmNoeQNs=
Received: from localhost (unknown [119.3.119.20])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgBnOIRU2dpkdMQhAA--.59811S3;
        Tue, 15 Aug 2023 09:48:04 +0800 (CST)
Date:   Tue, 15 Aug 2023 09:48:04 +0800
From:   Liang Li <liliang6@email.cn>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     will@kernel.org, mark.rutland@arm.com, liliang6@email.cn,
        21cnbao@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
        linuxarm@huawei.com, yangyicong@hisilicon.com
Subject: Re: [PATCH v2] perf/smmuv3: Add MODULE_ALIAS for module auto loading
Message-ID: <ZNrZVD1lwGM4LC+i@localhost>
Reply-To: Liang Li <liliang6@email.cn>
References: <20230814131642.65263-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814131642.65263-1-yangyicong@huawei.com>
X-CM-TRANSID: LCKnCgBnOIRU2dpkdMQhAA--.59811S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4rZr1rCw45ur1rJw4ruFg_yoW8ZF17p3
        y8Cr9Fkrn8Gr1ay3Z7Xw47XFyDW3W7ZF98JrWY9a4Yv34DAr98Wrn7Ka1Yg34DCF1UKFs2
        vFn7uw4fC3s8Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxV
        A2Y2ka0xkIwI1lc7CjxVAKzI0EY4vE52x082I5MxkIecxEwVAFwVWkMxAIw28IcxkI7VAK
        I48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        fU489NDUUUU
X-Originating-IP: [119.3.119.20]
X-CM-SenderInfo: 5oloxttqjwqvhpdlzhdfq/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-14 21:16, Yicong Yang <yangyicong@huawei.com> wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> On my ACPI based arm64 server, if the SMMUv3 PMU is configured as
> module it won't be loaded automatically after booting even if the
> device has already been scanned and added. It's because the module
> lacks a platform alias, the uevent mechanism and userspace tools
> like udevd make use of this to find the target driver module of the
> device. This patch adds the missing platform alias of the module,
> then module will be loaded automatically if device exists.
> 
> Before this patch:
> [root@localhost tmp]# modinfo arm_smmuv3_pmu | grep alias
> alias:          of:N*T*Carm,smmu-v3-pmcgC*
> alias:          of:N*T*Carm,smmu-v3-pmcg
> 
> After this patch:
> [root@localhost tmp]# modinfo arm_smmuv3_pmu | grep alias
> alias:          platform:arm-smmu-v3-pmcg
> alias:          of:N*T*Carm,smmu-v3-pmcgC*
> alias:          of:N*T*Carm,smmu-v3-pmcg
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> Change since v1:
> - Further illustrate the issues and how to fix this
> - Use MODULE_ALIAS instead of MODULE_DEVICE_TABLE
> Link: https://lore.kernel.org/all/20230807122233.28563-1-yangyicong@huawei.com/
> 
>  drivers/perf/arm_smmuv3_pmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 25a269d431e4..4c32b6dbfe76 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -984,6 +984,7 @@ static void __exit arm_smmu_pmu_exit(void)
>  
>  module_exit(arm_smmu_pmu_exit);
>  
> +MODULE_ALIAS("platform:arm-smmu-v3-pmcg");
>  MODULE_DESCRIPTION("PMU driver for ARM SMMUv3 Performance Monitors Extension");
>  MODULE_AUTHOR("Neil Leeder <nleeder@codeaurora.org>");
>  MODULE_AUTHOR("Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>");
> -- 
> 2.24.0

Looks good to me. :) Thanks.

Regards.
Liang Li

