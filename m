Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BA97A1139
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjINWpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjINWpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:45:43 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9A81FD6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:45:38 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d7b79a4899bso1511003276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694731538; x=1695336338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A5vZJNq08TeNOWQ034lbMsaCbZ2JIeyPBNL9fz/Gkc4=;
        b=DLYbSu9SAMpArJVnnKtemuBH4UG2pc2baYzf+ISWDdtsmQF3CFpBD/HERwEWZOxUgW
         LbtyBAdTEh2bPaRDeOAt+dJZ+6YFT2VqK4jJerYJOcw6phi1ngQIndLLgL4w2HoEU11h
         rrwvxJIYoY04y2rR1FE8RvHoQPxw8bJREFZO41u8/NJQMyvDtHazY6c/fzEzCKGQzfex
         DTJDpn8GEYRDg13CvDv+gYfpZckXJ62WpuWSOzm9SvxgTKBTmPRKC/h6WzpJRMVN1Qbv
         NKFe7oli+D0DI2C3pMiz3cduP3DpGcrBN5hCuG+jtC9kkirvKVaOTU2Uh15DxUg8bndy
         pmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694731538; x=1695336338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5vZJNq08TeNOWQ034lbMsaCbZ2JIeyPBNL9fz/Gkc4=;
        b=OjY50CUsJ5kNJL0re6mWAEnRTsxlHCCbzqs69h3Cwsqea40KvdM7fjtjDWJik8wICt
         WEiLteuongO14NChDOMJEaU4I2RbaKuxT6KPiN+74UhggrLXUua08KHYCGtE6oOVt3XA
         km6MMniXGe+v4aXT3KnCkg9pvtnnsAoYTCGw4JpMvNUXohQvJ1y/M2DsqyC/kxjeJ9bk
         i3Kd+z09RzEoE3ARoZC4B4/FKOHmbwiHoQXSyHfkCMdc48PVJl86UerYQYIkugLORwqv
         olWWVghCVUor4gWv72382QUE6ytjNziwCRIJvC3ruP7HMzdEQ8z4MpKarVHJZKqj/Dz8
         koUg==
X-Gm-Message-State: AOJu0YzKk5PLHh+T7T6TBEtMDVssQHOzorO1Ku2sISS/PWYHMuh3P6Wx
        08J8KEVNXvDWG6L37EII7Rw0zOmGesCzxrHjFJJ8tA==
X-Google-Smtp-Source: AGHT+IG0nZGJyegDk1SVCFp9hbtZsoKEbrZagRFwA2Y6awLjCs8leER4f/EZsvN3tkI84VDbuUVkEQe54i6cmxY4hrM=
X-Received: by 2002:a25:4d0:0:b0:d7f:374b:638f with SMTP id
 199-20020a2504d0000000b00d7f374b638fmr6486200ybe.23.1694731537714; Thu, 14
 Sep 2023 15:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
In-Reply-To: <20230825112633.236607-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Sep 2023 00:45:02 +0200
Message-ID: <CAPDyKFpn93YU78fRg02Avb3g=W2=+Cn=HD4tUbzTYq9WKGVOKw@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] arm_scmi/cpufreq: Add generic performance
 scaling support
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sudeep, Christian,

On Fri, 25 Aug 2023 at 13:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v3:
>         - Re-based upon the for-next/scmi/updates branch.
>         - Re-ordered some of the patches in the series, to eas review.
>         - Added some new DT doc patches in the series, according to comments.
>         - Fixed other comments, see version history for each patch.
>
> Changes in v2:
>         - Split up the series, to get the basic support in place as the first
>         step. The part that remains is the integration with the OPP library, to
>         allow consumer drivers to change performance level using the OPP lib.
>         - Re-based on top v6.5-rc1.
>         - Other changes will be described for each patch.
>
> The current SCMI performance scaling support is limited to cpufreq. This series
> extends the support, so it can be used for all kind of devices and not only for
> CPUs.
>
> The changes are spread over a couple of different subsystems, although the
> changes that affects the other subsystems than the arm_scmi directory are
> mostly smaller, except for last patch which is in the new genpd directory.
>
> The series is based upon the for-next/scmi/updates branch, but to enable the
> genpd provider in patch 13 (the actual scmi performance domain driver) to be
> placed in the new genpd directory, I have also merged an immutable branch [1],
> which is queued for v6.6.
>
> Note that, I am runing this on the Qemu virt platform with Optee running an SCMI
> server. If you want some more details about my test setup, I can share this with
> you, just let me know.
>
> Looking forward to your feedback!
>
> Kind regards
> Ulf Hansson
>
> [1]
> git.kernel.org/pub/scm/linux/kernel/git/people/ulf.hansson/linux-pm.git genpd_create_dir
>
>
> Ulf Hansson (13):
>   firmware: arm_scmi: Extend perf protocol ops to get number of domains
>   firmware: arm_scmi: Extend perf protocol ops to get information of a
>     domain
>   cpufreq: scmi: Prepare to move OF parsing of domain-id to cpufreq
>   firmware: arm_scmi: Align perf ops to use domain-id as in-parameter
>   firmware: arm_scmi: Drop redundant ->device_domain_id() from perf ops
>   cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
>   cpufreq: scmi: Drop redundant ifdef in scmi_cpufreq_probe()
>   dt-bindings: arm: cpus: Add a power-domain-name for a
>     performance-domain
>   dt-bindings: firmware: arm,scmi: Extend bindings for protocol@13
>   dt-bindings: power: Clarify performance capabilities of power-domains
>   cpufreq: scmi: Add support to parse domain-id using
>     #power-domain-cells
>   PM: domains: Allow genpd providers to manage OPP tables directly by
>     its FW
>   genpd: arm: Add the SCMI performance domain
>
>  .../devicetree/bindings/arm/cpus.yaml         |   4 +-
>  .../bindings/firmware/arm,scmi.yaml           |  11 +-
>  .../bindings/power/power-domain.yaml          |  17 +-
>  MAINTAINERS                                   |   1 +
>  drivers/base/power/domain.c                   |  11 +-
>  drivers/cpufreq/scmi-cpufreq.c                |  55 +++++--
>  drivers/firmware/arm_scmi/Kconfig             |  12 ++
>  drivers/firmware/arm_scmi/perf.c              |  90 +++++------
>  drivers/genpd/Makefile                        |   1 +
>  drivers/genpd/arm/Makefile                    |   3 +
>  drivers/genpd/arm/scmi_perf_domain.c          | 150 ++++++++++++++++++
>  include/linux/pm_domain.h                     |   5 +
>  include/linux/scmi_protocol.h                 |  18 ++-
>  13 files changed, 293 insertions(+), 85 deletions(-)
>  create mode 100644 drivers/genpd/arm/Makefile
>  create mode 100644 drivers/genpd/arm/scmi_perf_domain.c
>

Unless you have some additional comments, I think patch 1 -> 12 should
be ready to be applied to your scmi tree, as is. I tried to apply it
today and did not encounter any problem.

Patch 13 needs a rebase so I will submit a new version of it. For you
to apply it to your tree, you need to move your scmi branch to
v6.6-rc2 (on Monday), would that be okay for you to manage?

Kind regards
Uffe
