Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8C27FB13F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343536AbjK1Fbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjK1Fbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:31:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B9E1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:31:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA92EC433C7;
        Tue, 28 Nov 2023 05:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701149515;
        bh=v86g/w5UVdKRwoRwl5qtMmOEiCat+JZJrejLbCzYiFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRi3Vek1IJ6VsndC2Zvoo8Q3JSVLSaHY9DSPcgRKora82lOBcHGlpY6f8Z/xnr5xM
         NI6rMqvQ2FGAczTVvGabzprYc9lzTM/Y/r+DSpjcoZ7reM+sxoc25NcEKo/7J/NFtg
         Ep+xrpBtdF93Fgizi5II01JViLtuXluILmpOw/J0y1zg6SGInJlcR6hbqpjvxAxKNb
         UFvON1qygUSFmUSIbttmIjKdYykwQP1M8Xvzhpg783fCd4BvEzq2x1UZiXNjrK5ZJQ
         1W9P5uxASKywYx5shIlSt/e9hEqBNP3pdzEPAKJUElgqV6ikbro6mcBrWgOFeVbkP8
         OkgYKrVZ+cGVA==
Date:   Tue, 28 Nov 2023 11:01:36 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, adrian.hunter@intel.com, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Brian Masney <bmasney@redhat.com>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v5 01/10] scsi: ufs: host: Rename structure
 ufs_dev_params to ufs_host_params
Message-ID: <20231128053136.GE3088@thinkpad>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-2-git-send-email-quic_cang@quicinc.com>
 <20231128051917.GB3088@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128051917.GB3088@thinkpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:49:36AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Nov 23, 2023 at 12:46:21AM -0800, Can Guo wrote:
> > Structure ufs_dev_params is actually used in UFS host vendor drivers to
> > declare host specific power mode parameters, like ufs_<vendor>_params or
> > host_cap, which makes the code not very straightforward to read. Rename the
> > structure ufs_dev_params to ufs_host_params and unify the declarations in
> > all vendor drivers to host_params.
> > 
> > In addition, rename the two functions ufshcd_init_pwr_dev_param() and
> > ufshcd_get_pwr_dev_param() which work based on the ufs_host_params to
> > ufshcd_init_host_param() and ufshcd_negotiate_pwr_param() respectively to
> > avoid confusions.
> > 
> > This change does not change any functionalities or logic.
> > 
> > Acked-by: Andrew Halaney <ahalaney@redhat.com>
> > Signed-off-by: Can Guo <quic_cang@quicinc.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 
> > ---
> >  drivers/ufs/host/ufs-exynos.c    |  7 ++--
> >  drivers/ufs/host/ufs-hisi.c      | 11 +++----
> >  drivers/ufs/host/ufs-mediatek.c  | 12 +++----
> >  drivers/ufs/host/ufs-qcom.c      | 12 +++----
> >  drivers/ufs/host/ufshcd-pltfrm.c | 69 ++++++++++++++++++++--------------------
> >  drivers/ufs/host/ufshcd-pltfrm.h | 10 +++---
> >  6 files changed, 57 insertions(+), 64 deletions(-)
> > 

[...]

> > diff --git a/drivers/ufs/host/ufshcd-pltfrm.h b/drivers/ufs/host/ufshcd-pltfrm.h
> > index a86a3ad..2d4d047 100644
> > --- a/drivers/ufs/host/ufshcd-pltfrm.h
> > +++ b/drivers/ufs/host/ufshcd-pltfrm.h
> > @@ -10,7 +10,7 @@
> >  #define UFS_PWM_MODE 1
> >  #define UFS_HS_MODE  2
> >  
> > -struct ufs_dev_params {
> > +struct ufs_host_params {
> >  	u32 pwm_rx_gear;        /* pwm rx gear to work in */
> >  	u32 pwm_tx_gear;        /* pwm tx gear to work in */
> >  	u32 hs_rx_gear;         /* hs rx gear to work in */
> > @@ -25,10 +25,10 @@ struct ufs_dev_params {
> >  	u32 desired_working_mode;
> >  };
> >  
> > -int ufshcd_get_pwr_dev_param(const struct ufs_dev_params *dev_param,
> > -			     const struct ufs_pa_layer_attr *dev_max,
> > -			     struct ufs_pa_layer_attr *agreed_pwr);
> > -void ufshcd_init_pwr_dev_param(struct ufs_dev_params *dev_param);
> > +int ufshcd_negotiate_pwr_param(const struct ufs_host_params *host_param,
> > +			       const struct ufs_pa_layer_attr *dev_max,
> > +			       struct ufs_pa_layer_attr *agreed_pwr);
> > +void ufshcd_init_host_param(struct ufs_host_params *host_param);

Noticed this after giving my R-b tag. Could you please rename the functions to:

int ufshcd_negotiate_pwr_params(const struct ufs_host_params *host_params,...
void ufshcd_init_host_params(struct ufs_host_params *host_params);

Not a big deal, but since the argument passed to both functions are 'params',
it'd be good if the function definition also use the same plural form.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
