Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF5B8112FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379255AbjLMNdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379108AbjLMNdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:33:43 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0555B2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:33:46 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce939ecfc2so6292950b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702474426; x=1703079226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYQgNGHaRrpY+Wzp3aSG5+VQ1YpOK/vVXGi05N8iFZ4=;
        b=i6dOedma24OxCrURy8X0NOGrpa8K6yDUht2r0TwauswdGJxcf1FfVCcPCB5l8sSOi+
         z6qbzIbKz4LpY4ksZ3GlYjlW22+iVQT6A4708wEWUZlhFiUGPat8Yheg5ayK2Yh6ykn0
         vubhmk7ZvTeY/sZgm0C1plsdkSuZewXc4tQy788qZV4X8HGyIjwMw1C9txLB2jQ2/OeM
         woveuhNSyz81EvU+czoqLyeuCoaXXS+kee6aBnYsW4XuWWAwnEP+GFPUUUUIFhz0BqSt
         TCwrVRIhoOKx7cmDvd0AXZrdRDO7LwJU1r5B5SqgigAe7uEW0tY87F5/uMstw94Ot0Kb
         YJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474426; x=1703079226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYQgNGHaRrpY+Wzp3aSG5+VQ1YpOK/vVXGi05N8iFZ4=;
        b=b1qyoffvrge+NmUXobj5+ORdN+ers/c0/ixOvz1lXuKAgROBuQoV2I5+NtpxidFE9J
         rfB39NNT1968H1TeAceWdfmLh/0Yjn4bMKTNP+iGcI4HIfauRAY5kqgmzajbDKSjWZBQ
         o+tVgyw/OaM1co5PvJz49r2Hj62G/IkzloW0a04YUayt368IeiW9bptbrDJppfjgXpCi
         WUBRKbCPcfFJavBhzZoVHSOES3l1r+AwQgrNohi6ZcT65eV0jyp99CJnS199ktZkBrWp
         9yhqQ0o+7OCxTWgcOi+iIhMUeDhAFmOU/14q6InxyxNWFMX1ksuMCAUPylXCJYi8hRvj
         Hhrg==
X-Gm-Message-State: AOJu0Yy7OCHy8FjZ12MgDezsuykOZvN0H4Y8EMcRFY1Qj4+zroSXTgEE
        4Je8pBlabci7k1HnhOXpKFA21Q==
X-Google-Smtp-Source: AGHT+IH6DEOObknaiSG6YEqSKldI3VGHE1uZ2U6q53P+BJ/pdYK33tfE7UtwiB8OaBOkyB9ia8pCjw==
X-Received: by 2002:a05:6a00:23ce:b0:6ce:4623:ef99 with SMTP id g14-20020a056a0023ce00b006ce4623ef99mr9090525pfc.43.1702474426155;
        Wed, 13 Dec 2023 05:33:46 -0800 (PST)
Received: from leoy-yangtze.lan ([94.177.131.71])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7870f000000b006cdd507ca2esm9953829pfo.167.2023.12.13.05.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:33:45 -0800 (PST)
Date:   Wed, 13 Dec 2023 21:33:36 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 3/5] perf mem: Clean up perf_mem_events__name()
Message-ID: <20231213133336.GA3895246@leoy-yangtze.lan>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-4-kan.liang@linux.intel.com>
 <20231209054809.GB2116834@leoy-yangtze.lan>
 <3b67c2de-741d-4d5e-8c8f-87b8b9e08825@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b67c2de-741d-4d5e-8c8f-87b8b9e08825@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 01:39:36PM -0500, Liang, Kan wrote:
> On 2023-12-09 12:48 a.m., Leo Yan wrote:
> > On Thu, Dec 07, 2023 at 11:23:36AM -0800, kan.liang@linux.intel.com wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Introduce a generic perf_mem_events__name(). Remove the ARCH-specific
> >> one.
> > 
> > Now memory event naming is arch dependent, this is because every arch
> > has different memory PMU names, and it appends specific configurations
> > (e.g. aarch64 appends 'ts_enable=1,...,min_latency=%u', and x86_64
> > appends 'ldlat=%u', etc).  This is not friendly for extension, e.g. it's
> > impossible for users to specify any extra attributes for memory events.
> > 
> > This patch tries to consolidate in a central place for generating memory
> > event names, its approach is to add more flags to meet special usage
> > cases, which means the code gets more complex (and more difficult for
> > later's maintenance).
> > 
> > I think we need to distinguish the event naming into two levels: in
> > util/mem-events.c, we can consider it as a common layer, and we maintain
> > common options in it, e.g. 'latency', 'all-user', 'all-kernel',
> > 'timestamp', 'physical_address', etc.  In every arch's mem-events.c
> > file, it converts the common options to arch specific configurations.
> > 
> > In the end, this can avoid to add more and more flags into the
> > structure perf_mem_event.
> 
> The purpose of this cleanup patch set is to remove the unnecessary
> __weak functions, and try to make the code more generic.

I understand weak functions are not very good practice.  The point is
weak functions are used for some archs have implemented a feature but
other archs have not.

I can think a potential case to use a central place to maintain the
code for all archs - when we want to support cross analysis.  But this
patch series is for supporting cross analysis, to be honest, I still
don't see benefit for this series, though I know you might try to
support hybrid modes.

> The two flags has already covered all the current usage.
> For now, it's good enough.
> 
> I agree that if there are more flags, it should not be a perfect
> solution. But we don't have the third flag right now. Could we clean up
> it later e.g., when introducing the third flag?
> 
> I just don't want to make the patch bigger and bigger. Also, I don't
> think we usually implement something just for future possibilities.

Fine for me, but please address two main concerns in next spin:

- Fix building failure in patch 01;
- Fix the concerned regression on Arm64/AMD archs in patch 04.  I will
  give a bit more explanation in another reply.


[...]

> >> -#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
> >> +#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
> >>  
> >>  struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
> >> -	E("spe-load",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
> >> -	E("spe-store",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
> >> -	E("spe-ldst",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
> >> +	E("spe-load",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0",	true,	0),
> >> +	E("spe-store",	"%s/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0",	false,	0),
> >> +	E("spe-ldst",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0",	true,	0),
> > 
> > Arm SPE is AUX event, should set '1' to the field '.aux_event'.
> 
> It actually means whether an extra event is required with a mem_loads
> event.  I guess for ARM the answer is no.

Thanks for confirmation.

> > I am a bit suspect if we really need the field '.aux_event', the
> > '.aux_event' field is only used for generating event string.
> 
> No, it stores the event encoding for the extra event.
> ARM doesn't need it, so it's 0.

I searched a bit and confirmed '.aux_event' is only used in
util/mem-events.c and for 'perf record'.

I failed to connect the code with "it stores the event encoding for the
extra event".  Could you elaborate a bit for this?

Thanks,
Leo
