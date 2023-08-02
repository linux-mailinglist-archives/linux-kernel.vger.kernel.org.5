Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB92476C3E0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjHBEGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjHBEF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F0E1FEE;
        Tue,  1 Aug 2023 21:05:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04740617A1;
        Wed,  2 Aug 2023 04:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A21EC433C7;
        Wed,  2 Aug 2023 04:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690949154;
        bh=JyzHdJqaECArYyPuQGdQ/VsUhFVeIi7mNUoSwXnmSv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoVGQ4WYiuRnFC6Q31mpCML8IE4xHKVWx55iKFd47w7YzWf/Mbj4lcPUyCFKIzjKF
         Q7/sZKqb/ujOeOWtrdwnZqBtHOPTQKHxuWdTvRXZSE9JFOs5q7Ecf7nrdYwrenEM/C
         fNv8ZPeIuEQEn62094R8Txxwrnt6icD0pogfF0QChDzzTqlCSGZu35JwVBPihLqVQJ
         +UZFXLnfAgM+jWD/Ynx6uo0rryvJG6OugsxCXBGcWG2htx6DiE/XYBTmwc/k9Y1ldm
         HX8MqV3hN8pS1RVocBsQl0bicrCL/Tft41ljX0xug2DoLRvuEzKzQ7d/7YpOP3ojo+
         HsxXXonfRl7KQ==
Date:   Wed, 2 Aug 2023 09:35:38 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     powen.kao@mediatek.com, bvanassche@acm.org,
        alim.akhtar@samsung.com, adrian.hunter@intel.com,
        jejb@linux.ibm.com, stanley.chu@mediatek.com,
        asutoshd@codeaurora.org, quic_cang@quicinc.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        ebiggers@google.com, agross@kernel.org, Arthur.Simchaev@wdc.com,
        konrad.dybcio@linaro.org, quic_ziqichen@quicinc.com,
        quic_nguyenb@quicinc.com, quic_narepall@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 1/2] scsi: ufs: core: Export ufshcd_is_hba_active
Message-ID: <20230802040538.GB2370@thinkpad>
References: <20230726134140.7180-1-quic_nitirawa@quicinc.com>
 <20230726134140.7180-2-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230726134140.7180-2-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 07:11:39PM +0530, Nitin Rawat wrote:
> Export ufshcd_is_hba_active() to allow vendor driver modules
> to check the state of host controller.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/ufs/core/ufshcd.c | 3 ++-
>  include/ufs/ufshcd.h      | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 983fae84d9e8..962aa5c1fe69 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -995,10 +995,11 @@ static inline void ufshcd_hba_start(struct ufs_hba *hba)
>   *
>   * Returns true if and only if the controller is active.
>   */
> -static inline bool ufshcd_is_hba_active(struct ufs_hba *hba)
> +bool ufshcd_is_hba_active(struct ufs_hba *hba)
>  {
>  	return ufshcd_readl(hba, REG_CONTROLLER_ENABLE) & CONTROLLER_ENABLE;
>  }
> +EXPORT_SYMBOL_GPL(ufshcd_is_hba_active);
> 
>  u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba)
>  {
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 6dc11fa0ebb1..ef04c3363be8 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -1398,6 +1398,7 @@ int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable);
>  int ufshcd_suspend_prepare(struct device *dev);
>  int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm);
>  void ufshcd_resume_complete(struct device *dev);
> +bool ufshcd_is_hba_active(struct ufs_hba *hba);
> 
>  /* Wrapper functions for safely calling variant operations */
>  static inline int ufshcd_vops_init(struct ufs_hba *hba)
> --
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
