Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5588E7E4566
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbjKGQGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbjKGQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:06:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5F310FF;
        Tue,  7 Nov 2023 07:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=5vVjpIK/xSOI0XfHhUdCNQN5Ynt+pxBZ4C8bQOCgVkM=; b=IORmO3pEwqpO41NPi9ZsB4XeQ3
        2LFuVrsr7iLUoljFBrgU12y1gIvqJR+UczOz0yAGgM5PKNtdPlhwA3XdiBhLLVer9B9EBZ8BqM5up
        AkKnifJ87rzrz22sl/9g6eA54G5FjQX9NKrB3K5h+XEkU11Pl5IC+eDzAmnIjf8+7iD/+YFwLQsEl
        vTzJCT+j3YYTqktCrV2y5s+uCvMHrRrqamailCon2Hp4DMKvDGfdL4p66s7FCnbn/C+F9b+ZR09x0
        CTaHi4oWQm15vpAOF8L2HWrdSa+nPKcYC6Tz0Rp4gyfgRKLq/M+fxzMcFyx2JEBpIGIMIkYC/h+Xv
        376COy6Q==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0OSI-001w95-2I;
        Tue, 07 Nov 2023 15:57:30 +0000
Message-ID: <2a50dc4b-2b8b-4685-82f9-c521c665abff@infradead.org>
Date:   Tue, 7 Nov 2023 07:57:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: Fix SM_CAMCC_8550 dependencies
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        kernel test robot <lkp@intel.com>
References: <20231107064545.13120-1-quic_jkona@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231107064545.13120-1-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/23 22:45, Jagadeesh Kona wrote:
> SM_GCC_8550 depends on ARM64 but it is selected by
> SM_CAMCC_8550, which should have the same dependencies
> as SM_GCC_8550 to avoid the below Kconfig warning reported
> by kernel test robot.
> 
> WARNING: unmet direct dependencies detected for SM_GCC_8550
>   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=y] && (ARM64 || COMPILE_TEST [=n])
>   Selected by [y]:
>   - SM_CAMCC_8550 [=y] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=y]
> 
> Fixes: ccc4e6a061a2 ("clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311062309.XugQH7AH-lkp@intel.com/
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/clk/qcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index ad1acd9b7426..dbc3950c5960 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -767,6 +767,7 @@ config SM_CAMCC_8450
>  
>  config SM_CAMCC_8550
>  	tristate "SM8550 Camera Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SM_GCC_8550
>  	help
>  	  Support for the camera clock controller on SM8550 devices.

-- 
~Randy
