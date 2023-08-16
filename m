Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A8577E22C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245375AbjHPNHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245407AbjHPNH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:07:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2F4E270C;
        Wed, 16 Aug 2023 06:07:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACD63D75;
        Wed, 16 Aug 2023 06:08:06 -0700 (PDT)
Received: from [192.168.178.38] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6211D3F6C4;
        Wed, 16 Aug 2023 06:07:23 -0700 (PDT)
Message-ID: <7f4afadb-da77-8edd-f6ef-6c3d68c14801@arm.com>
Date:   Wed, 16 Aug 2023 15:07:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 10/12] PM: EM: Add runtime update interface to modify
 EM power
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        mhiramat@kernel.org
References: <20230721155022.2339982-1-lukasz.luba@arm.com>
 <20230721155022.2339982-11-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230721155022.2339982-11-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 17:50, Lukasz Luba wrote:

[...]

> @@ -381,6 +383,12 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
>  {
>  	return 0;
>  }
> +static inline
> +int em_dev_update_perf_domain(struct device *dev, struct em_data_callback *cb,
> +			      void *priv)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #endif
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 4596bfe7398e..10180c776c5b 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -185,6 +185,101 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>  	return 0;
>  }
>  
> +/**
> + * em_dev_update_perf_domain() - Update run-time EM table for a device

nit pick: s/run-time/runtime

there are multiple occurrences in this file (maybe more in the entire set?)

[...]
