Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542887A2AD7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 01:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbjIOXEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 19:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237147AbjIOXES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 19:04:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AF1106;
        Fri, 15 Sep 2023 16:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=cWkLx1FjP+Lml75ZLA4kvkFhgrEW3VnuXCDwF1rvx/Q=; b=m2I2Kqwk28JhzI8Cuj0bitp2Tn
        DdfHzPF7GUNs7Rl1MTlWLZfVLFl/k8+EOhoEXb0C5UEHwWBinBpbylttG83+xHCkZq6ecLHogJb4J
        2lC8bpb5tGPMSnpiqht5HqYe28ZwGjYREZhPmlWZNOEe7F+b1kVG5p5P0uB2JykgijYexcqqbnxc0
        JX2KO5n8R0ctcMkVznZlB4WjJyUAGJUadVzeIicMqg/U0YjCilhHhwvExIowwNMDV4EFYyUIqZBES
        ycLyR6Z5mc8VpBoEDxO4kFV2befTEZip8x3ZD16Xmu1xuXCX+0T2evCvCptXnnJiRO2GfPOkK5/Au
        kqX2WJCw==;
Received: from [2601:1c2:980:9ec0:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qhHr8-00BWIr-0s;
        Fri, 15 Sep 2023 23:04:10 +0000
Message-ID: <b13b9dde-a748-44d2-8d80-d5119ffdffd4@infradead.org>
Date:   Fri, 15 Sep 2023 16:04:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom: qseecom: Add missing AUXILIARY_BUS
 dependency
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230915-qseecom-auxiliary-fix-v1-1-38a46cfbfdb0@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230915-qseecom-auxiliary-fix-v1-1-38a46cfbfdb0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 15:50, Bjorn Andersson wrote:
> The newly introduced QSEECOM driver fail to link if the system is built
> without CONFIG_AUXILIARY_BUS, make sure it is selected.
> 
> Fixes: 00b1248606ba ("firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/r/9f156fa6-e5aa-4cb2-ab2b-b67fd8fc4840%40infradead.org
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/firmware/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index a94202229a71..8c608be30060 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -229,6 +229,7 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>  config QCOM_QSEECOM
>  	bool "Qualcomm QSEECOM interface driver"
>  	depends on QCOM_SCM=y
> +	select AUXILIARY_BUS
>  	help
>  	  Various Qualcomm SoCs have a Secure Execution Environment (SEE) running
>  	  in the Trust Zone. This module provides an interface to that via the
> 
> ---
> base-commit: dfa449a58323de195773cf928d99db4130702bf7
> change-id: 20230915-qseecom-auxiliary-fix-1574abe3bc98
> 
> Best regards,

-- 
~Randy
