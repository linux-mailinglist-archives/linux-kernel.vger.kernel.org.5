Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2804E78A6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjH1HjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjH1HjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41B0102;
        Mon, 28 Aug 2023 00:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A0B463284;
        Mon, 28 Aug 2023 07:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C86C433C7;
        Mon, 28 Aug 2023 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693208344;
        bh=kubI8wRsCR0nVJtyvbh285B2jMOThWMaipa2QvUikhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oANzl7bqy6ZNGSslsTBmAQlBRNYjUAqu/L7RRH+PcvLDW0GdzhFWJAXMbXchylv/p
         WTtpGrZtDJ3/VbNcpgw+MUdMViEbSQNYLoMR7kbeH6BmodXWxrB+gcmKmlJ7GqUPUf
         PZ+Ke7Yt1vVOc6w42txjqrlq8YbSrRPBLKkFosPZTK83+oQq7SnnnzeFWWKUTPKKDS
         hhKBAjUyJbhL8+WwT1JVhKHe/OkUbsaqVtMaRUVsW2HbPx2h3PxjVv/9HeCvyHl4SB
         YnvvM5V2l6johY6Ub1ZAxAs0ORxs+7xXypQMA3fJf2CZZU+rfIkiyDblZhSYxQh/V2
         4mODoEtf/7wcQ==
Date:   Mon, 28 Aug 2023 13:08:49 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: Re: [PATCH V5 1/6] scsi: ufs: qcom: Update offset for
 core_clk_1us_cycles
Message-ID: <20230828073849.GB5148@thinkpad>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
 <20230823154413.23788-2-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823154413.23788-2-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 09:14:08PM +0530, Nitin Rawat wrote:
> This Patch updates offset for core_clk_1us_cycles in DME_VS_CORE_CLK_CTRL

Please do not use "This patch" in commit message. Just reword it in imperative
form.

> register. Offset for core_clk_1us_cycles is changed from Qualcomm UFS
> Controller V4.0.0 onwards.
> 
> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 19 ++++++++++++++-----
>  drivers/ufs/host/ufs-qcom.h |  2 ++
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index f88febb23123..1108b0cd43b3 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1297,12 +1297,21 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>  }
> 
>  static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
> -						       u32 clk_cycles)
> +						       u32 clk_1us_cycles)

How about "cycles_in_1us", since this value specifies "Number of clk cycles in
1us"?

>  {
> -	int err;
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	u32 mask = DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
>  	u32 core_clk_ctrl_reg;
> +	u32 offset = 0;
> +	int err;
> +
> +	/* Bit mask and offset changed on UFS host controller V4.0.0 onwards */

This is not offset value, but rather shift. Still, if you use bitfield macros
as I suggested below, you could get rid of this variable.

> +	if (host->hw_ver.major >= 4) {
> +		mask = MAX_CORE_CLK_1US_CYCLES_MASK_V4;
> +		offset = MAX_CORE_CLK_1US_CYCLES_OFFSET_V4;
> +	}
> 
> -	if (clk_cycles > DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK)
> +	if (clk_1us_cycles > mask)
>  		return -EINVAL;

	if (!FIELD_FIT(mask, cycles_in_1us))
		return -ERANGE;

> 
>  	err = ufshcd_dme_get(hba,
> @@ -1311,8 +1320,8 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>  	if (err)
>  		return err;
> 
> -	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
> -	core_clk_ctrl_reg |= clk_cycles;
> +	core_clk_ctrl_reg &= ~(mask << offset);
> +	core_clk_ctrl_reg |= clk_1us_cycles << offset;
> 

	core_clk_ctrl_reg &= ~mask;
	core_clk_ctrl_reg |= FIELD_PREP(mask, cycles_in_1us);

>  	/* Clear CORE_CLK_DIV_EN */
>  	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index d6f8e74bd538..a829296e11bb 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -129,6 +129,8 @@ enum {
>  #define PA_VS_CONFIG_REG1	0x9000
>  #define DME_VS_CORE_CLK_CTRL	0xD002
>  /* bit and mask definitions for DME_VS_CORE_CLK_CTRL attribute */

> +#define MAX_CORE_CLK_1US_CYCLES_MASK_V4		0xFFF

#define MAX_CORE_CLK_1US_CYCLES_MASK_V4				GENMASK(27, 16)
#define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	GENMASK(7, 0)

- Mani

> +#define MAX_CORE_CLK_1US_CYCLES_OFFSET_V4	0x10
>  #define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT		BIT(8)
>  #define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	0xFF
> 
> --
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
