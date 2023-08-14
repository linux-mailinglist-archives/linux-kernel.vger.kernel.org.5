Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4327677BDFA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjHNQ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjHNQ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:29:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F503E63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:29:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3197b461bb5so690002f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692030550; x=1692635350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7Uon9thVZJImSisyN+YyQEaB3LuhCDn4wA1y8xGo9Q=;
        b=Xr2IjLhKqxWFbq1DWZcp4z3EvEbXQtzTLdEvPVu2jzPqKY72xix5gG0oOmNk2HTrzZ
         2OvjlMHLVz2wEr1KKWhKkToEOdZKmJFS/WOqa3JsXzWHUqDixUM3ubnHkvbhmBCGgDhO
         ore+ZjNOfKS76yb+pGw3DTMm3jMeUnzQXw4dhMjLZrpomo+OOoO9vakOKWLIOuYImUpY
         It2zvCSDHfX2AW+K+3PEXVBz/HRrvwkJp4sdQUaqeWtNjWfISXNZ6VsbUCEhHsKwDs9M
         yOV0IaaoEvKYIrbBBiuK6AejLVqhcUVGVhjt6K18UMIbuvk9RyEFT0PDvqoO1Rq8Z0lx
         O+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692030550; x=1692635350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7Uon9thVZJImSisyN+YyQEaB3LuhCDn4wA1y8xGo9Q=;
        b=WeGp/YKugxDYOKB0CFrkJlsb3kNMk0ee66DT8V22Bovq+nEBXCfuA9uQin6zaW09fB
         t+ENBkn3xwAPISaFEqfn+YTrUPZV9M9Xp7o4esRSornxQDlQwtOO8UjQgr3q6oJeSzFW
         OinblcWE6n065mlhQeBAQ9I6wpk51yMIHdg1247fW66A5l/ZxnamxSlTR9aRUvOb3eFm
         A05Jmv+9obx9hekt2gqR0mnBs/D5z5eLDFENl+GsZee7pudaiKeLL2CVr3uRm6uEihks
         +kNdTYWtSGxZtQLzVTrH9tud1uEjftGoSaFCflsKq34mluIa/Jy9Es9O6aHqzvwgyjJm
         8pmg==
X-Gm-Message-State: AOJu0Yx16q9mssA9EBQjijRCq9eeWYfPvNbPe12UHURGBPf8b4z21TPN
        bQbLYrL8TKrJ80P9dIWYsXvSzQ==
X-Google-Smtp-Source: AGHT+IHmepKYitWxiUS/1KqWuUAH0hbLa57b3SdO6NVl+jcZZYhnzc8l/OEtLqQH9ylaxBy0CggBnw==
X-Received: by 2002:adf:f143:0:b0:319:5719:c91b with SMTP id y3-20020adff143000000b003195719c91bmr7010668wro.50.1692030549680;
        Mon, 14 Aug 2023 09:29:09 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id l14-20020a1c790e000000b003fc16ee2864sm14743475wme.48.2023.08.14.09.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:29:08 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/14] media: qcom: camss: Add parameter passing to remove several outstanding bugs
Date:   Mon, 14 Aug 2023 17:28:53 +0100
Message-ID: <20230814162907.3878421-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1:
- I forgot to include patch # 14 in V0 of this series.
  This patch leverages previous changes to unwind the fixed polling of
  RDI[0..2] allowing driver data to articulate on a per-VFE basis how many
  RDIs to poll.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts-v3+maintenance-bugfixes-v1

V0:
This second series of bugfixes stacks ontop of the Fixes series sent earlier.

Link: https://lore.kernel.org/linux-arm-msm/20230814141007.3721197-1-bryan.odonoghue@linaro.org/T/#t

Rather than send both series as one giant series, I opted to send a pure
Fixes series above, with this second series a non-backport series i.e. no
Fixes tags in this series.

The existing CAMSS code relies on some hard-coded parameters buried inside
of the driver, instead of passed via compat .data as arguably ought to be
the case.

This brittle model is an extending morass of spaghetti code. More than that
in CAMSS Video Front Ends (VFEs) and the number of Raw Data Interfaces
(RDIs) per VFE can vary from SoC to SoC. Indeed sm8250 has VFE and VFE Lite
blocks which have a different number of RDIs per block.

The use of defines as opposed to per-compat parameters inside of ISRs leads
to either under-polling or over-polling the number of RDIs.

On top of all of that we have some hard-coded statements for clock names
which breaks easily.

We can solve the under/over polling loop problem by transitioning loop
controls from macros to parameters passed via probe().

Similarly and unsurprisingly we can also solve the hard-coded clock problem
by adding some string processing routines that take passed arguments.

There is still some additional maintenance work to be done in this driver
but before adding one more SoC the code needs to be made more extensible
and less brittle.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/dc346c7f46c0680bcfb84fded6db97497fffe49a

Bryan O'Donoghue (14):
  media: qcom: camss: Amalgamate struct resource with struct
    resource_ispif
  media: qcom: camss: Start to move to module compat matched resources
  media: qcom: camss: Drop useless NULL assignment for ispif resources
  media: qcom: camss: Pass icc bandwidth table as a platform parameter
  media: qcom: camss: Pass remainder of variables as resources
  media: qcom: camss: Pass line_num from compat resources
  media: qcom: camss: Assign the correct number of RDIs per VFE
  media: qcom: camss: Use >= CAMSS_SDM845 for vfe_get/vfe_put
  media: qcom: camss: Untangle if/else spaghetti in camss
  media: qcom: camss: Improve error printout on icc_get fail
  media: qcom: camss: Allow clocks vfeN vfe_liteN or vfe_lite
  media: qcom: camss: Functionally decompose CSIPHY clock lookups
  media: qcom: camss: Add support for setting CSIPHY clock name csiphyX
  media: qcom: camss: Support RDI3 for VFE 17x

 .../media/platform/qcom/camss/camss-csid.c    |  24 +-
 .../qcom/camss/camss-csiphy-3ph-1-0.c         |   8 +-
 .../media/platform/qcom/camss/camss-csiphy.c  |  67 ++--
 .../media/platform/qcom/camss/camss-ispif.c   |  32 +-
 .../media/platform/qcom/camss/camss-ispif.h   |   4 +-
 .../media/platform/qcom/camss/camss-vfe-170.c |  17 +-
 .../media/platform/qcom/camss/camss-vfe-4-1.c |   2 -
 .../media/platform/qcom/camss/camss-vfe-4-7.c |   2 -
 .../media/platform/qcom/camss/camss-vfe-4-8.c |   2 -
 .../media/platform/qcom/camss/camss-vfe-480.c |   5 +-
 drivers/media/platform/qcom/camss/camss-vfe.c |  78 +++--
 .../media/platform/qcom/camss/camss-video.c   |  16 +-
 drivers/media/platform/qcom/camss/camss.c     | 292 +++++++++---------
 drivers/media/platform/qcom/camss/camss.h     |  31 +-
 14 files changed, 321 insertions(+), 259 deletions(-)

-- 
2.41.0

