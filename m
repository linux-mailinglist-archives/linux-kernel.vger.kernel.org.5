Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A767E0999
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377811AbjKCTnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjKCTnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:43:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0DADB;
        Fri,  3 Nov 2023 12:43:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2585BC433C7;
        Fri,  3 Nov 2023 19:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699040592;
        bh=CFSrDlVUM0+gZalq2vpH/rAxg1gkP2kOq+1l1toyv8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pVm9iB9VSfX2kugsBsG83Jfa0Q0eQcbYrBFjmoWBQ+Bcv11MmJzm7e1r1RkqnT4j9
         MiBichAfocfVllA5cJ8OatOs/qcC8tMZui00fM7kvRtNQI8Ro1u1UuXEOdmNPOf91z
         EeR2ix+M0s+c2qv/f2crxX9+9JTXOQUOeVXtICN4lOPpKeJBn+WJNDJCFr1A7xFpCY
         B0VRQ5E+DMIL07jvMTyUZp4MBU3wdxEDiylzRNQRehq4rKELlvEAoxhGkr/4U0s7qO
         MbHQPoF0ltnidEH1wcl3qufWnQtH59YTis/hXEBL9KhulanOJwwJ/A4TJxZU2pS5F8
         BjAxKgvBjudMQ==
Date:   Fri, 3 Nov 2023 12:47:17 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [PATCH RESEND v3 2/5] PM: domains: Add the domain HW-managed
 mode to the summary
Message-ID: <7ep4opcrephg3iyfpvwtuwqxjsw3jx6mgeapjz4ryawt5w7xzq@qluhryilt2nl>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
 <20231101-gdsc-hwctrl-v3-2-0740ae6b2b04@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-gdsc-hwctrl-v3-2-0740ae6b2b04@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 11:04:08AM +0200, Abel Vesa wrote:
> Now that genpd supports dynamically switching the control for an
> attached device between hardware- and software-mode,  let's add this
> information to the genpd summary in debugfs.
> 
> Suggested-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/base/power/domain.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 3fb1a234c7f2..7044271ec93b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -3181,6 +3181,15 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
>  	seq_printf(s, "%-25s  ", p);
>  }
>  
> +static void mode_status_str(struct seq_file *s, struct device *dev)
> +{
> +	struct generic_pm_domain_data *gpd_data;
> +
> +	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
> +
> +	seq_printf(s, "%20s", gpd_data->hw_mode ? "HW" : "SW");
> +}
> +
>  static void perf_status_str(struct seq_file *s, struct device *dev)
>  {
>  	struct generic_pm_domain_data *gpd_data;
> @@ -3239,6 +3248,7 @@ static int genpd_summary_one(struct seq_file *s,
>  		seq_printf(s, "\n    %-50s  ", kobj_path);
>  		rtpm_status_str(s, pm_data->dev);
>  		perf_status_str(s, pm_data->dev);
> +		mode_status_str(s, pm_data->dev);
>  		kfree(kobj_path);
>  	}
>  
> @@ -3255,8 +3265,9 @@ static int summary_show(struct seq_file *s, void *data)
>  	int ret = 0;
>  
>  	seq_puts(s, "domain                          status          children                           performance\n");
> -	seq_puts(s, "    /device                                             runtime status\n");
> -	seq_puts(s, "----------------------------------------------------------------------------------------------\n");
> +	seq_puts(s, "    /device                                             runtime status                           managed by\n");
> +	seq_puts(s, "------------------------------------------------------------------------------------------------------------\n");
> +
>  
>  	ret = mutex_lock_interruptible(&gpd_list_lock);
>  	if (ret)
> 
> -- 
> 2.34.1
> 
