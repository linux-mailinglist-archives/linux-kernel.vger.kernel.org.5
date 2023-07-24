Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C57575F470
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjGXLGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjGXLGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:06:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0CB1716
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:05:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8bd586086so33958275ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690196718; x=1690801518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpxURfuWp3r5Ssob6loqWYQQFhjk0gJ6ECoUdgMqL14=;
        b=un2xrlfulQ60r5LNtbniiOXopwA1QpticHFI9Z2zxzQzWpvsCPDJJPPAsCmwKD2NaT
         K/uslkw72sylRSvpmpxRU7IK4i9V0uLsdPnImxRifausJsXUi2K2tRtDn6dIrNCFqlUD
         37RAZooOBfu6EzzwKwHTZP1sgGF5vgYZ4qJq6RC5XAizwH+p4bB+65JYQ/vgmd+TvNIo
         +F6kGEn/08nEwEtzPQpIcs4hwlXkjsZCUWoiht+7djiqoqmiYGzIGM8YemL900T4VcOG
         vK6idTJJ4PRJ5AebtEfZEhb31hy7fHi+6rdZDM/nbajzjX7M3cduvvF5wS4jPG6QnEh6
         +rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690196718; x=1690801518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpxURfuWp3r5Ssob6loqWYQQFhjk0gJ6ECoUdgMqL14=;
        b=WhQJHtOBDY1mFlRo7pyR/PmJ4PGJAMqIGa7+RfJqaWsJNNMPPdNDPvJPbN0qmssh/y
         t5BT5UUMwr7k6ZQVYjQmDzsNXrcQxzrMztP3Tx3Yixp7KQg//olGkArtcLoIWWyn9g+W
         kJZqymHjHY92zL8FlU4Sk86rGCYMaCO4leV1NgrOrPKHvjtAO/QfHFXIUXTWlS2sbHSP
         gZ8Y165xHfSrkt8D73vRyLUGXfVLflSfC7SRTgxECXunnJmJyr/tQQJw8bDAj02FPtzM
         9WdlTO9/NENwm2Vqo0UUEM8ydZ0kNDgIHdrLvIcqKhDTPiKLtj68BLs4JSYknbr518Kk
         Z7Bg==
X-Gm-Message-State: ABy/qLYy5nyTxQPekeBdQYJaEWulwhgf2+a0lCUFy0q8jjxVnYUU6MDI
        jfpdQmb/V2xNNJ2HwidJ4lZMIA==
X-Google-Smtp-Source: APBJJlGA44bODADkLZ5hak+A6OwmDzkd/9b58o+y7b29LZMHVRBPqxm+Xq1Qj7IzTWfiP9T+HIz3dg==
X-Received: by 2002:a17:902:e841:b0:1b7:e355:d1ea with SMTP id t1-20020a170902e84100b001b7e355d1eamr12777292plg.24.1690196717804;
        Mon, 24 Jul 2023 04:05:17 -0700 (PDT)
Received: from leoy-huanghe.lan (n058152048165.netvigator.com. [58.152.48.165])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902b08700b001b3d0aff88fsm8558457plr.109.2023.07.24.04.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:05:16 -0700 (PDT)
Date:   Mon, 24 Jul 2023 19:05:09 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Marc Zyngier <maz@kernel.org>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, fissure2010@gmail.com
Subject: Re: [PATCH v1 3/3] perf arm-spe: Support data source for Cortex-X4
 CPU
Message-ID: <20230724110509.GA76473@leoy-huanghe.lan>
References: <20230717054327.79815-1-leo.yan@linaro.org>
 <20230717054327.79815-4-leo.yan@linaro.org>
 <c784911e-72f4-8150-530b-234978546a45@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c784911e-72f4-8150-530b-234978546a45@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Mon, Jul 24, 2023 at 12:27:31PM +0530, Anshuman Khandual wrote:

[...]

> > -static const struct midr_range neoverse_spe[] = {
> > +static const struct midr_range cpus_use_default_data_src[] = {
> 
> Is not 'cpus_use_default_data_src' too long ? 'use' could be dropped ?

Okay, I can drop 'use'.

> >  	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
> >  	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> >  	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
> > +	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
> >  	{},
> >  };

[...]

> >  static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
> >  {
> >  	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
> > -	bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
> > +	bool is_default_dc =
> 
> _dc stands for ?

Thanks for pointing out this; actually I mean '_ds' which stands for
data source.  Will spin a new patch for this.

Thanks for review!

Leo
