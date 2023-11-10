Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18027E8017
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjKJSFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjKJSEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:04:42 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C0C2B7FA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:17:32 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b709048f32so1692390b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699607852; x=1700212652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qMFA/4LVo9MaNuOmPJbDYsQ8leCjxXQe4RXEqsi7Vk=;
        b=esARizgsre9kqI3zGeoLlST7/KVBkc09g1O66V8dft3tiL0cdPjQXa3/eEpBNtrjMl
         9g57WteRLr177S2wGvOmavsFhopumQGUNMyhnFQZhmDZc6SjyaFqYByMWoe3Wp9q/OHJ
         alsEFXvJrXZbXz8Z7MBEXyeOF6p70Q/9tBPnJkvD1pNreWgKtj4dTD0Q6GLyAQG8evmK
         vvPpOM+6qr9361SziZG1CcmUi+sap15huml2Mu56zIoQSxUlxL9/wV/h4fPbJRSQnLS+
         aYwoZf0Jb9EgehdeM/LphyuRJU1h9xY0dNlCLRRD24EfeC54slXfiedr4/it0W6uu5dd
         z/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699607852; x=1700212652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qMFA/4LVo9MaNuOmPJbDYsQ8leCjxXQe4RXEqsi7Vk=;
        b=ALfhSdO5aNhDKRm7XfPOTCksGuKSoiE5ScKEd3nKvXZpTitKX3dcWxi1+0sxgyQfl/
         arLF5g83juOi+eZ0a5mK/WwpX2qLuKh3cWisLV3yUoVBkmVcRFFHQPZ7VMu0bXeADyPT
         DFtGxTB8POwJ60pmms78EZO8t9lXTergcDzWmFJ7ZDJ6Ahb0atqmhhCFJ2nDHq/7I61l
         jKFSj1zpsPWRJ5oIIUaZ7dmjflEUnxm+2Qyl8+yY04jmFeA/Dn99hmUMn+xQ9rUvUwUq
         Ghj7g1MWnKHF/Q9TuLYpA3nD7uguC48pgdJDaw1W93fRqC8RHR3HsBZo2YAVHLxa/+sV
         AXfA==
X-Gm-Message-State: AOJu0YyIGQuuEZLRAG4w/kzanR9aQovJgA70Wd78cUkSQ8EMH14wfc1f
        XsC32DaWDJyGOXeJ/56cRrebTg==
X-Google-Smtp-Source: AGHT+IEf6ivgAkw6yVi3FBgNRxGS3TsVvGiByXO2mRhR+nd07TngiWoOOOYFgaeien5HK7d1Y0M7oA==
X-Received: by 2002:a05:6a20:f3af:b0:153:353e:5e39 with SMTP id qr47-20020a056a20f3af00b00153353e5e39mr5947121pzb.51.1699607851729;
        Fri, 10 Nov 2023 01:17:31 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709026b4800b001c771740da4sm4889837plt.195.2023.11.10.01.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 01:17:31 -0800 (PST)
Date:   Fri, 10 Nov 2023 14:47:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        beata.michalska@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v6 5/7] cpufreq/cppc: Move and rename
 cppc_cpufreq_{perf_to_khz|khz_to_perf}
Message-ID: <20231110091729.jssgofhlcye4juev@vireshk-i7>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
 <20231109101438.1139696-6-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109101438.1139696-6-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-11-23, 11:14, Vincent Guittot wrote:
> Move and rename cppc_cpufreq_perf_to_khz and cppc_cpufreq_khz_to_perf to
> use them outside cppc_cpufreq in topology_init_cpu_capacity_cppc().
> 
> Modify the interface to use struct cppc_perf_caps *caps instead of
> struct cppc_cpudata *cpu_data as we only use the fields of cppc_perf_caps.
> 
> cppc_cpufreq was converting the lowest and nominal freq from MHz to kHz
> before using them. We move this conversion inside cppc_perf_to_khz and
> cppc_khz_to_perf to make them generic and usable outside cppc_cpufreq.
> 
> No functional change
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> ---
>  drivers/acpi/cppc_acpi.c       | 104 ++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 139 ++++-----------------------------
>  include/acpi/cppc_acpi.h       |   2 +
>  3 files changed, 123 insertions(+), 122 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
