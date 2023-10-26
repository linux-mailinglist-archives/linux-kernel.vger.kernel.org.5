Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5484F7D8638
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345490AbjJZPux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjJZPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:50:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BB51A6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:50:47 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c515527310so14832061fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698335446; x=1698940246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSmLSLc0O5qJoQEWMuotYo96+8Yt2HHCvZl015/TvAc=;
        b=uBrNyJMhmnINkVfyU/5ikbl+vS/4VWt9jOtsQmM4pKjRXne/hodkk65wAWkKqsz5VO
         91mwupiBlmhqnkpGKUDhW9udDUmyZDtVFpNWmYfXRmBANhlUkKCQl/7j+660f186d/T2
         S2gjKm8eZkMU9yLV/E9PRDKKOT5bB9NPFCwKsPW9CpfXSlvbqpGRru/AeihwxBIm5N8r
         8DRKvrms7EEgWZ4wEM7IpcHLXEIDIPOgzqf2X6AYI7YlZ9BlsNvYs7x6qSX5cqp/bw2e
         unmVAgIj25qcE04JBVVk1yxsNtTfQ2C9MB2jX4DDRnuYI6ajjL/+eFPmUuwQ5XGfVGoj
         RDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335446; x=1698940246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSmLSLc0O5qJoQEWMuotYo96+8Yt2HHCvZl015/TvAc=;
        b=beQiPXbsAg24aP6KTqacKBvOCHl1A0c+CLPJsxAAyj+WBn4rdcSdKFHkQnXnHLsP+p
         vOcUrmvJBJ25FlCC9ZVBc8gMHkXFzAoy20qc5yDhF88LWPHuFwGBuXcANOAh91uwUNQK
         klALGd6Yr9dUQ1o/Hwe7/lDPVeHLfprvgQrtHXeItyLp40CVaL4AYGR6DGKfh/OnvbxD
         hpFlbhQWxuLknot8d2a+y4OlkVjiDRlor8zmGesAflyKO47KDEnkc9Mc9kA1YfKRHZ91
         DijnxjY5PpsuIoXglEptqXpEDpuc62PufPogsAyELXCmHkghtwfbaua/lF/e7wepFCEq
         fSxw==
X-Gm-Message-State: AOJu0Yw+zbrgtbA0fwnEXoa5WLClQq8yssUq4rVNJu2NYYSXw71wVfW6
        SqyYabjMEXHBecpSygAeTowm1w==
X-Google-Smtp-Source: AGHT+IHZ+CkYUIz5F3AENNG8fu1G70dYKnAQWoKiZIN+YRHegsVbhu2ZRUF94W/RkNT/VI+LxyPdzA==
X-Received: by 2002:a2e:3204:0:b0:2bc:b557:cee9 with SMTP id y4-20020a2e3204000000b002bcb557cee9mr12943284ljy.43.1698335445678;
        Thu, 26 Oct 2023 08:50:45 -0700 (PDT)
Received: from sagittarius-a.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b003feae747ff2sm2938289wms.35.2023.10.26.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:50:45 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v2 0/5] media: qcom: camss: Introduce support for named power-domains
Date:   Thu, 26 Oct 2023 16:50:37 +0100
Message-ID: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2:
- Incorporates Konrad's suggestion re: removing 'id'
- Adds RB - Konrad
- Adds in a flag to indicate if a VFE has a power domain.
  As I rebased this series I realised we had some magic indexing for VFE v
  VFE Lite, which isn't the root cause of my bug bear in this series but is
  the same sin - inferring functionality from indexing.
  Once we transition fully to named pds we won't need a 'has_pd' to flag
  which VFEs need power-domain attachment and which don't.
  That transition will require populating all upstream dtsi with pd-names
  and then deprecating the old way.
  has_pd is a far better choice than inferring from indexes so, I've added.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/aa45a2b58aa1e187a2698a65164d694251f08fa1

V1:
At the moment the Qcom CAMSS driver relies on the declaration order of
power-domains within the dtsi to determine which power-domain relates to a
VFE and which power-domain relates to the top-level (top) CAMSS
power-domain.

VFE power-domains must be declared prior to the top power-domain. The top
power-domain must be declared last. Early SoCs have just one top
power-domain with later SoCs introducing VFE specific power-domains.

Differentiating between the number of power-domains results in lots of code
which is brittle and which we can mostly get rid of with named
power-domains.

The reliance on declaration ordering is in-effect magic number indexing.

This series introduces named power-domains for CAMSS and refactors some of
the code in CAMSS to support the new named power-domains. We continue to
support the legacy indexing model with an intention to remove after a
reasonable transition period.

New SoC additions should use named power-domains from now on.

Tested on x13s, rb5, db410c

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-10-23-camss-named-power-domains

Bryan O'Donoghue (5):
  media: qcom: camss: Flag which VFEs require a power-domain
  media: qcom: camss: Convert to per-VFE pointer for power-domain
    linkages
  media: qcom: camss: Use common VFE pm_domain_on/pm_domain_off where
    applicable
  media: qcom: camss: Move VFE power-domain specifics into vfe.c
  media: qcom: camss: Add support for named power-domains

 .../media/platform/qcom/camss/camss-vfe-170.c | 36 --------
 .../media/platform/qcom/camss/camss-vfe-4-1.c |  8 +-
 .../media/platform/qcom/camss/camss-vfe-4-7.c | 36 --------
 .../media/platform/qcom/camss/camss-vfe-4-8.c | 31 -------
 .../media/platform/qcom/camss/camss-vfe-480.c | 36 --------
 drivers/media/platform/qcom/camss/camss-vfe.c | 77 ++++++++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.h | 16 ++++
 drivers/media/platform/qcom/camss/camss.c     | 87 ++++++++++++-------
 drivers/media/platform/qcom/camss/camss.h     |  7 +-
 9 files changed, 156 insertions(+), 178 deletions(-)

-- 
2.42.0

