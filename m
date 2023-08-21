Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24926782737
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjHUKjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjHUKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1F2D9;
        Mon, 21 Aug 2023 03:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE9863028;
        Mon, 21 Aug 2023 10:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9CEC433C7;
        Mon, 21 Aug 2023 10:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692614344;
        bh=BgiNR9RpM2+q1vYXwkC4kkzk6YXihubC56QnYIv0X2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kSd5GNK4joCrYftvsv8yoydMGSB0oJ/s6aKzkAL6fxqUW5uIsut+79d6rTstIikjv
         dDsgad+u/a2KxK4Bt1zf0GTXTJ30ZoPstJJfaWpw5aduoX3GPgJAKYyNytz4SSx5p6
         RVXKz87nBm/+5rgbAepEoKfvHoEicTNbT4cLGF9i3qinUb4HJYopdkI1Jomm6ZH3+O
         HF0JDXCwecplXgS4YqHPZ+M1QbNbNKnPih4bSf9D43/Pv8fTe6wta6ya0UlVlB/m8e
         fVut9ZTp3XmasgSgT1WFgVj4xnobz0nOVIZmeDSAf429JC1KzCw6nh0JfBzpTZVxm5
         PuLHKNP4fNh8A==
Date:   Mon, 21 Aug 2023 16:08:51 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: ufs-qcom: clear qunipro_g4_sel for HW major
 version > 5
Message-ID: <20230821103851.GB36455@thinkpad>
References: <20230821-topic-sm8x50-upstream-ufs-major-5-plus-v1-1-c14cce209f21@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821-topic-sm8x50-upstream-ufs-major-5-plus-v1-1-c14cce209f21@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:41:54AM +0200, Neil Armstrong wrote:
> The qunipro_g4_sel clear is also needed for new platforms with
> major version > 5, fix the version check to take this in account.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

This is a fix, isn't it? With the fixes tag for 9c02aa24bf40,

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index f88febb23123..d1149b1c3ed5 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -365,7 +365,7 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
>  		   ufs_qcom_cap_qunipro(host) ? QUNIPRO_SEL : 0,
>  		   REG_UFS_CFG1);
>  
> -	if (host->hw_ver.major == 0x05)
> +	if (host->hw_ver.major >= 0x05)
>  		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
>  
>  	/* make sure above configuration is applied before we return */
> 
> ---
> base-commit: 47d9bb711707d15b19fad18c8e2b4b027a264a3a
> change-id: 20230821-topic-sm8x50-upstream-ufs-major-5-plus-4eaad3f3d857
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்
