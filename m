Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953C175EB7A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGXG1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGXG1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:27:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A48A9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:27:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6687096c6ddso2094217b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690180025; x=1690784825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HfDDHnCKWhdZT7WnmbTsFLDNkDDnfliPEm42Q1iIO1E=;
        b=Uj1BQcrbEcHyq/7C73guHDmA5J5L0a4dtwU0SmnX3qKIHEZ/yqJ5oLO2F7eLAhur5M
         Fo+DWNAsWb64a7DyhqoMcpEOOxg3RHeHzmWKdnjVYVf9QpF8sr6xAZOjfkadG/kPxwJ8
         jHuFE8jsDZtlQ4y8wr2a7CAaAZ5yLE6YylQCLV6ghBNk4oLxSrPJ8gSP9+dWeaNBZbq/
         EqSXjn2SwqXak0RbXkfm778C7FEmzX1ntnjo/P/lA0+ZMPf15ojjMjYV+IqH7ASsTUKg
         HCDyq01v5iasPyEeIUDCF9eUS1nzYE7rPAEVfh13FcR80ANKR27dStUTxFqakOjps7jo
         2G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690180025; x=1690784825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HfDDHnCKWhdZT7WnmbTsFLDNkDDnfliPEm42Q1iIO1E=;
        b=A3fC/y9PZUvj/HdTYdK2Uu+b4bNUURIYrYF+73upvveoUgFjYeYnSPWXUkVb25OipB
         OER4hiyMAtkZwIyC/ThlB9T/ECC6FhyuEWlcfDxKVceATweaOMaoL8Ix4yaFfbKolrMN
         FBFT2/4WjoPDks9V2A3ETOzJnqDOJjUe57xPVCUyEsl8FtMviXK6qb9SwKXSdEvV6698
         J/Pj3q7yfo17t0gY/D83k/BTigIhiAyekYLUtxaMZDJxih8945CitbPg5h3ME4uQAK8w
         KkJDQDddU+1pmO8h7l6MZqgx7JHj9VejKduTEvj/sGIGDOispdqYjJt78h0MSew4Dv3N
         PMSQ==
X-Gm-Message-State: ABy/qLbn8JXx2n6fHaVrHPzAoGCTQXgl0VpAKSOU6OU1+A/sULZec57+
        sWky1HmXSE0LSATOejHxg8/8
X-Google-Smtp-Source: APBJJlE3/Al5UAXKEW44LeHM76v7K4EvCJ1qp2x4AM9HUJmAfcTkFwhsbcTxhmRxYtsaYqpwXvzf1w==
X-Received: by 2002:a05:6a00:1398:b0:662:f0d0:a77d with SMTP id t24-20020a056a00139800b00662f0d0a77dmr5282853pfg.30.1690180024787;
        Sun, 23 Jul 2023 23:27:04 -0700 (PDT)
Received: from thinkpad ([117.206.118.29])
        by smtp.gmail.com with ESMTPSA id s21-20020a62e715000000b00678afd4824asm7082283pfh.175.2023.07.23.23.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 23:27:04 -0700 (PDT)
Date:   Mon, 24 Jul 2023 11:56:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] OPP: Reuse dev_pm_opp_get_freq_indexed()
Message-ID: <20230724062657.GL2370@thinkpad>
References: <cover.1689932341.git.viresh.kumar@linaro.org>
 <5ddded46303f9d034ecb79f1fcc48abcc590f7db.1689932341.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ddded46303f9d034ecb79f1fcc48abcc590f7db.1689932341.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 03:10:59PM +0530, Viresh Kumar wrote:
> Reuse dev_pm_opp_get_freq_indexed() from dev_pm_opp_get_freq().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/opp/core.c     | 21 ---------------------
>  include/linux/pm_opp.h | 12 +++++-------
>  2 files changed, 5 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 95f49fbe431c..16a103e6695b 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -176,27 +176,6 @@ unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_power);
>  
> -/**
> - * dev_pm_opp_get_freq() - Gets the frequency corresponding to an available opp
> - * @opp:	opp for which frequency has to be returned for
> - *
> - * Return: frequency in hertz corresponding to the opp, else
> - * return 0
> - */
> -unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
> -{
> -	if (IS_ERR_OR_NULL(opp)) {
> -		pr_err("%s: Invalid parameters\n", __func__);
> -		return 0;
> -	}
> -
> -	if (!assert_single_clk(opp->opp_table))
> -		return 0;
> -
> -	return opp->rates[0];
> -}
> -EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
> -
>  /**
>   * dev_pm_opp_get_freq_indexed() - Gets the frequency corresponding to an
>   *				   available opp with specified index
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 23e4e4eaaa42..91f87d7e807c 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -103,8 +103,6 @@ int dev_pm_opp_get_supplies(struct dev_pm_opp *opp, struct dev_pm_opp_supply *su
>  
>  unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp);
>  
> -unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
> -
>  unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index);
>  
>  unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
> @@ -214,11 +212,6 @@ static inline unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
>  	return 0;
>  }
>  
> -static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
> -{
> -	return 0;
> -}
> -
>  static inline unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index)
>  {
>  	return 0;
> @@ -669,4 +662,9 @@ static inline void dev_pm_opp_put_prop_name(int token)
>  	dev_pm_opp_clear_config(token);
>  }
>  
> +static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
> +{
> +	return dev_pm_opp_get_freq_indexed(opp, 0);
> +}
> +
>  #endif		/* __LINUX_OPP_H__ */
> -- 
> 2.31.1.272.g89b43f80a514
> 

-- 
மணிவண்ணன் சதாசிவம்
