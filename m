Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF747E41AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjKGOSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjKGOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:18:20 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9B6C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:18:17 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc0d0a0355so43222915ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 06:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699366696; x=1699971496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LokR2In5but8jyud9htPlJIMHwX8ulAmv8zW9GufO3w=;
        b=Ry63AyoYkU7xHexhnJGhJTkVGYZ0bDwkQ9M/75AtijV2lPdsXcTKNwMgxUVVa41zMV
         6RtPLef02veVGMEifmq/Vn4aHUFP08yTqqP8Q4VDKEH1jny18uFO5ILiJTsxv+mV/p+z
         ntouc+QsmkizH0jZjk2WJw7QvvJibaaN20FGDpYEVnOJ02nc/UEUAwOFDuiLuLTkswMp
         RnDmxB2o/I9NkbvJzurTKioZoneRlrXChLSvqvMhHPi/1CLsnz28H4J7yewLbBQ+dvQA
         aez8g8LfDeYhbtHbwYsl/5XYY/oexL9fKSjhj4w/cZi4nPZPV33pIHc5s3NzZsX/ErEy
         HsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699366696; x=1699971496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LokR2In5but8jyud9htPlJIMHwX8ulAmv8zW9GufO3w=;
        b=DspLWU5nt1sKcWtXbx2t0OqKBl6cktGJEEPNL1FxLKpa5ZjQyR1Y8N6obm97hJTO0W
         AQq9WVqf8rCbUwlfBwFv1VIrH1O+ShU5liMnLDqEXQtu9jYPBL8rlaLEgNRE4rqcACbn
         aM/OzQfGkA1yslQ3IJbHFgUcQy7nF7z41V0a/U9XAWPzHC3K2BXMcGLN4wISXYEio+kN
         DlCc47AAmGlVeZx0ABnr2rdVYbtRdn2DvNbA87PqsE+ScPn2oVle7spKgWHcUipKckdk
         xcyQ8RwGu3OOB2SXbtTTme7Vfk2LPwElIrWmlXmfhrFyDhfuu+NxptILsjrslXuVEslI
         v82g==
X-Gm-Message-State: AOJu0YzdFlys2xctyNjwVrtHZuPfidNtdELlgrfebIXoBjp+or/f2k8E
        6o8d6FFU8hw+/QKQu1DZQ/vz3A==
X-Google-Smtp-Source: AGHT+IEtU1KARV4Zk2ARD7mFDAaJeX+tha3NUS3ZlAYsGGqdsPJUcnn0plzPUqAFyLv8zYIw//6+mA==
X-Received: by 2002:a17:902:d2c7:b0:1cc:4efc:c87d with SMTP id n7-20020a170902d2c700b001cc4efcc87dmr27909272plc.55.1699366696544;
        Tue, 07 Nov 2023 06:18:16 -0800 (PST)
Received: from leoy-yangtze.lan ([98.98.115.250])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b001cc131c65besm7740361pla.168.2023.11.07.06.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 06:18:16 -0800 (PST)
Date:   Tue, 7 Nov 2023 22:18:08 +0800
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
Message-ID: <20231107141808.GD656098@leoy-yangtze.lan>
References: <20231014074513.1668000-1-leo.yan@linaro.org>
 <20231014074513.1668000-2-leo.yan@linaro.org>
 <8a2ea58f-f835-4d1a-8bd6-3a63b3b0db94@intel.com>
 <ZUlgM8pgf19UeyM9@kernel.org>
 <2940af18-8bcd-4456-a8ed-e77cade1b160@intel.com>
 <20231107094852.GA656098@leoy-yangtze.lan>
 <6fc8bc4c-abc3-45d5-a8c8-045f91adfebf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fc8bc4c-abc3-45d5-a8c8-045f91adfebf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 12:16:25PM +0200, Adrian Hunter wrote:

[...]

> >>>> "If users know" <- how would users know?  Could the kernel
> >>>> or tools also figure it out?
> >>>
> >>> Adrian, I'm trying to go all the outstanding patches, do you still have
> >>> any issues with this series?
> >>
> >> No, although the question wasn't actually answered.  I presume users
> >> just have to try the 'T' option and see if it helps.
> > 
> > Sometimes, users are software developers in SoC companies, they can
> > know well for the hardware design but are confused why current
> > implementation cannot use timestamp trace.  This is the main reason
> > I sent this patch set.
> > 
> > An example hardware platform is DB410c [1], we know its CoreSight can
> > support timestamp trace, but if without this adding option 'T', we
> > have no chance to use it due to it its CPU arch is prior to Armv8.4.
> 
> perf config might be better than an itrace option, but you decide.

I understand perf config is a better approach due to users don't need
to bother inputting options after set it once.  I will look at it and
respin new patch set.

Thanks for suggestion!

Leo
