Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA22B7E381C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjKGJtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjKGJtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:49:03 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3CD11A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:49:00 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so4112898b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699350539; x=1699955339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKDbEWjNDihVEusNrHvP99SNchk1IxSs3nYi8Mg0EtY=;
        b=Lc9/MO/jJzI7wSJKM/5lFFxeU6s5HIV2rlzQHt7lQ1BQZlZJUtTVMQml20We2BomRG
         P+SaMiR8oWtz+e3UIJPpVLwYHfJkN3TohTQoREaGVUIE3sC56yl+k0/agQumSOPyZhN6
         cNqIhOTyDsl90FmKLjl2C6lMEJ+kkwgxMXoQ57sEAM4tYtkW+8HOzrFYahAeq0nz6N8E
         7wN3/7uYFavnkYhDr7QhYBz3abV9NKM4NHqKMb3QkNtO1AnvTj6/R4Nu1uLwlaFJX2m1
         UUnxCykIPtirdY0aFmIIPQ2x8GsEpYfl0zxT5wL82d3bNXZSNvLEDbpvIYeV3mm29zXc
         6iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350539; x=1699955339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKDbEWjNDihVEusNrHvP99SNchk1IxSs3nYi8Mg0EtY=;
        b=k7MYLiTUj6gmvFamH1RKmMOLesbqMgqiYI4ApX0ZtrElHCa9v0qpfQejqbJNY2ybWg
         YywuaTIXRdwCsypSdToN2x2ruCT6vzX4qhtgUl8T4g4hcz+TZFIUyXwx4oDtAAh+prd0
         KfB9+vERnOUzx5oh/U33A7fO9aekSf9gtQ7KidCAJ1Ibr3QiZjiBmwxSHs1/oZZ4Bs+r
         APTToC2rR+DjuWTIrKuF7m7mpd7SyUIpzl+Vu52ssrLhn08YVfj3kA5WFx5YPfTSGgnr
         uTAXAI50N1vvwplQFq7dm6b7WJTIDHUsH90tKp0auDv1JsKf6JN/VmRzhxPACSKQ/4i9
         grUA==
X-Gm-Message-State: AOJu0YxDLVT2Jo7MBcoyR2STxwQ68A7gi8W1Vnsi+iloV8fWblTqcSp9
        xLiQfCLDAiQbcrehA6UbAOdZYw==
X-Google-Smtp-Source: AGHT+IFytYM9dTytfxK06/FWlQFdFksipje5fVp6slwpg8pspDEos+KIlzPl7KMJ0OEB8RCbv33JIA==
X-Received: by 2002:a05:6a00:15d4:b0:68e:3eb6:d45 with SMTP id o20-20020a056a0015d400b0068e3eb60d45mr30066840pfu.30.1699350539364;
        Tue, 07 Nov 2023 01:48:59 -0800 (PST)
Received: from leoy-yangtze.lan ([98.98.115.250])
        by smtp.gmail.com with ESMTPSA id x10-20020aa793aa000000b006bff78b7526sm6874040pff.20.2023.11.07.01.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:48:58 -0800 (PST)
Date:   Tue, 7 Nov 2023 17:48:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf auxtrace: Add 'T' itrace option for
 timestamp trace
Message-ID: <20231107094852.GA656098@leoy-yangtze.lan>
References: <20231014074513.1668000-1-leo.yan@linaro.org>
 <20231014074513.1668000-2-leo.yan@linaro.org>
 <8a2ea58f-f835-4d1a-8bd6-3a63b3b0db94@intel.com>
 <ZUlgM8pgf19UeyM9@kernel.org>
 <2940af18-8bcd-4456-a8ed-e77cade1b160@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2940af18-8bcd-4456-a8ed-e77cade1b160@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Nov 07, 2023 at 09:19:10AM +0200, Adrian Hunter wrote:
> On 6/11/23 23:52, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Oct 19, 2023 at 01:47:15PM +0300, Adrian Hunter escreveu:
> >> On 14/10/23 10:45, Leo Yan wrote:
> >>> An AUX trace can contain timestamp, but in some situations, the hardware
> >>> trace module (e.g. Arm CoreSight) cannot decide the traced timestamp is
> >>> the same source with CPU's time, thus the decoder can not use the
> >>> timestamp trace for samples.
> >>>
> >>> This patch introduces 'T' itrace option. If users know the platforms
> >>
> >> "If users know" <- how would users know?  Could the kernel
> >> or tools also figure it out?
> > 
> > Adrian, I'm trying to go all the outstanding patches, do you still have
> > any issues with this series?
> 
> No, although the question wasn't actually answered.  I presume users
> just have to try the 'T' option and see if it helps.

Sometimes, users are software developers in SoC companies, they can
know well for the hardware design but are confused why current
implementation cannot use timestamp trace.  This is the main reason
I sent this patch set.

An example hardware platform is DB410c [1], we know its CoreSight can
support timestamp trace, but if without this adding option 'T', we
have no chance to use it due to it its CPU arch is prior to Armv8.4.

@Arnaldo, since James gave comments in his replying, I will respin new
patch set and send out.  Thanks for popping up this patch set!

Leo

[1] https://developer.qualcomm.com/hardware/dragonboard-410c
