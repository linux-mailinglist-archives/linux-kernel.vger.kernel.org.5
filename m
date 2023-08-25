Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306C97885A5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242315AbjHYL11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242246AbjHYL06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:26:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519331FFA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:26:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ffa248263cso1247221e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962812; x=1693567612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fBY/HtUs9K9shLxFz87/yhgWybEcdjCy9Ovc6VbYJDM=;
        b=mO8BvDUU1/immKzeAsfPPrAA491wEj/9AIdCzi62+OFRBSSsvECRTHqmGuK0KhGAy0
         zwCARHJgAxUcbQkRTeKoM7d7nClDP75436sEQoxl4HwtzLyTrBgj6sGseJv9lG2gyWw6
         hQSBuZ/FUOBUV8f55HO5SbcW4YxGHj+nUPRfSqDOSASVsT3XfRwhGqTvfVDBV0g7p2b+
         i2m3erXWZS3R1dEkQI0AdrhbiruzPxQNw/txgyht2ORflP39Tnd0I8CPBLDThwjRTb+k
         s8G/E3xocw6dm8BU7+qVTFCeeShdjq36psItS4gLJvcL1TZJdzS6VURHNbfVZlwfaV58
         +9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962812; x=1693567612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBY/HtUs9K9shLxFz87/yhgWybEcdjCy9Ovc6VbYJDM=;
        b=RuahMAbVyNxzZOfIIa9ASA2XM1g4hMpQ2NpjXA0BGrossBsfiDYVxYkOmT0+itxBT+
         PrtkrlXsGZ3adKkWpzopA3hwhAzCvQhL6MaLM3ZXSotbhWOYWCpAdeS2y1BOOkSLitD/
         L29XUrof+MSMhKijHE9LOKXyxmaQJJSeVkEfr+4Wk7npejLaaZgz+pYyQJ7Kj4JNE9Sc
         zz3ByABirhll/ElamEPezm3vY0MgM8dpm6MqTeGm18bSPpaQ9DaOAZ4GrRorK8ZFy9AB
         WbA5tfHmsnxrANGe9j/4xoOigJ8lcFfYyt4Hj2D4dwc9ujICt2l9gNIhqt0hF3jnhF0Y
         +esQ==
X-Gm-Message-State: AOJu0YzlGOBqWqprrQJBcBuREw9kwhgDpQ1I5r2+IVKzlZNYRr791PJw
        0xxpNT4lNjNNvuiXa/iz6HqHhA==
X-Google-Smtp-Source: AGHT+IGGJdkUEbzPSl8I64Rn0u5xOF5sgGb4L+rFAZnxKgpB/IhJ0oB2oEC1OpMXYM9Cz/aMQ88c3w==
X-Received: by 2002:a05:6512:32cc:b0:4ff:7e1e:b4b4 with SMTP id f12-20020a05651232cc00b004ff7e1eb4b4mr14760796lfg.39.1692962812488;
        Fri, 25 Aug 2023 04:26:52 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004fb7ac67bbdsm259164lfh.41.2023.08.25.04.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:26:52 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/13] arm_scmi/cpufreq: Add generic performance scaling support
Date:   Fri, 25 Aug 2023 13:26:20 +0200
Message-Id: <20230825112633.236607-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
	- Re-based upon the for-next/scmi/updates branch.
	- Re-ordered some of the patches in the series, to eas review.
	- Added some new DT doc patches in the series, according to comments.
	- Fixed other comments, see version history for each patch.

Changes in v2:
	- Split up the series, to get the basic support in place as the first
	step. The part that remains is the integration with the OPP library, to
	allow consumer drivers to change performance level using the OPP lib.
	- Re-based on top v6.5-rc1.
	- Other changes will be described for each patch.

The current SCMI performance scaling support is limited to cpufreq. This series
extends the support, so it can be used for all kind of devices and not only for
CPUs.

The changes are spread over a couple of different subsystems, although the
changes that affects the other subsystems than the arm_scmi directory are
mostly smaller, except for last patch which is in the new genpd directory.

The series is based upon the for-next/scmi/updates branch, but to enable the
genpd provider in patch 13 (the actual scmi performance domain driver) to be
placed in the new genpd directory, I have also merged an immutable branch [1],
which is queued for v6.6.

Note that, I am runing this on the Qemu virt platform with Optee running an SCMI
server. If you want some more details about my test setup, I can share this with
you, just let me know.

Looking forward to your feedback!

Kind regards
Ulf Hansson

[1]
git.kernel.org/pub/scm/linux/kernel/git/people/ulf.hansson/linux-pm.git genpd_create_dir


Ulf Hansson (13):
  firmware: arm_scmi: Extend perf protocol ops to get number of domains
  firmware: arm_scmi: Extend perf protocol ops to get information of a
    domain
  cpufreq: scmi: Prepare to move OF parsing of domain-id to cpufreq
  firmware: arm_scmi: Align perf ops to use domain-id as in-parameter
  firmware: arm_scmi: Drop redundant ->device_domain_id() from perf ops
  cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
  cpufreq: scmi: Drop redundant ifdef in scmi_cpufreq_probe()
  dt-bindings: arm: cpus: Add a power-domain-name for a
    performance-domain
  dt-bindings: firmware: arm,scmi: Extend bindings for protocol@13
  dt-bindings: power: Clarify performance capabilities of power-domains
  cpufreq: scmi: Add support to parse domain-id using
    #power-domain-cells
  PM: domains: Allow genpd providers to manage OPP tables directly by
    its FW
  genpd: arm: Add the SCMI performance domain

 .../devicetree/bindings/arm/cpus.yaml         |   4 +-
 .../bindings/firmware/arm,scmi.yaml           |  11 +-
 .../bindings/power/power-domain.yaml          |  17 +-
 MAINTAINERS                                   |   1 +
 drivers/base/power/domain.c                   |  11 +-
 drivers/cpufreq/scmi-cpufreq.c                |  55 +++++--
 drivers/firmware/arm_scmi/Kconfig             |  12 ++
 drivers/firmware/arm_scmi/perf.c              |  90 +++++------
 drivers/genpd/Makefile                        |   1 +
 drivers/genpd/arm/Makefile                    |   3 +
 drivers/genpd/arm/scmi_perf_domain.c          | 150 ++++++++++++++++++
 include/linux/pm_domain.h                     |   5 +
 include/linux/scmi_protocol.h                 |  18 ++-
 13 files changed, 293 insertions(+), 85 deletions(-)
 create mode 100644 drivers/genpd/arm/Makefile
 create mode 100644 drivers/genpd/arm/scmi_perf_domain.c

-- 
2.34.1

