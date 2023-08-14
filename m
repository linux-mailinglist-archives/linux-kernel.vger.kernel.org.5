Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36F377BCB8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjHNPNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjHNPMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:12:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCED01B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:12:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so40935835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692025966; x=1692630766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RL8uW/i+vD2pJKOZ8MhjURQoVYYBJH2Wn25O5mxE3sc=;
        b=W8sSGddp3Db1uk2FUMTNriElEU8D3HcGTFl7rl8i+0hlJlD3CzmGogjI/BP1Z6wNTi
         txd4E13/vQqJJzXoVf0qde/UHdikHRGvLI1T7GsABcFfNeOlc3B7SSTA5wTPtzwBrGCC
         HaBSppcnEJPfFOFPs8tuY/TXDlDMzhvoJPA13lgGIPZ1/c56ESx7AhQZ5pw1u6HoriXG
         Md1orUzCfWpgZuZZt4Ldk8OkusX7k6y0vJwlFkQbsUeeCS7cGxtliSTD7yNaQ4HixjQR
         0TL9CwVP3MPSWtulwZAEG5x0LSsRp3HYUf3t5s1AW5x9wqW9OfgcNx5XVDn6nc43uig8
         CaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025966; x=1692630766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RL8uW/i+vD2pJKOZ8MhjURQoVYYBJH2Wn25O5mxE3sc=;
        b=KYpJCrBE606ttioDJbc/tw8xxdziUZVn9bcVtwRi2nFNKSJf+gwCWOuoegE0lzX/xc
         R9gSQOUKs52zu0r5ZSnJ6v3XmA1aF1g+U9HPm7RhIfWS01drLrmTXNcRoPdwftRlpa0M
         7g4csn7Z647LoYsaPs67VQ5BvTaWhDPTUyK5bsIYCUPg3St9ZBUttxV/K7B+M+dnLfQJ
         XOSK1GG4sJLx7nQhyVqB5CQHOwZDJKORa5y37TsQaU7Q99JCys3xEkQTSKCx0ndmTahE
         3QqOYyYORDhh8cdtHRhWQd1V9J91m2vBt4zYAdnn9OoocVWJGvM+2URin9bUrCLTd05P
         Iheg==
X-Gm-Message-State: AOJu0YyuLsr++ei6Y8GNwRnOfwqZnw/5d3I6X2V5kFjVr++uAQHUKXhn
        ELAIu5qW8vmd9tmhYma2g+kK8w==
X-Google-Smtp-Source: AGHT+IGrWi8yDMGvnyI/h/pnxgHlDDJk4q/bcPsOgY+08reUDpTPRq24qQX5JfjBEfXa12qO5HYr/g==
X-Received: by 2002:adf:e685:0:b0:316:f25c:d0c0 with SMTP id r5-20020adfe685000000b00316f25cd0c0mr7714740wrm.16.1692025966328;
        Mon, 14 Aug 2023 08:12:46 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003fe1c332810sm17644572wmi.33.2023.08.14.08.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:12:45 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 00/13] media: qcom: camss: Add parameter passing to remove several outstanding bugs
Date:   Mon, 14 Aug 2023 16:12:30 +0100
Message-ID: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Bryan O'Donoghue (13):
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

 .../media/platform/qcom/camss/camss-csid.c    |  24 +-
 .../qcom/camss/camss-csiphy-3ph-1-0.c         |   8 +-
 .../media/platform/qcom/camss/camss-csiphy.c  |  67 ++--
 .../media/platform/qcom/camss/camss-ispif.c   |  32 +-
 .../media/platform/qcom/camss/camss-ispif.h   |   4 +-
 .../media/platform/qcom/camss/camss-vfe-170.c |   6 +-
 .../media/platform/qcom/camss/camss-vfe-4-1.c |   2 -
 .../media/platform/qcom/camss/camss-vfe-4-7.c |   2 -
 .../media/platform/qcom/camss/camss-vfe-4-8.c |   2 -
 .../media/platform/qcom/camss/camss-vfe-480.c |   5 +-
 drivers/media/platform/qcom/camss/camss-vfe.c |  78 +++--
 .../media/platform/qcom/camss/camss-video.c   |  16 +-
 drivers/media/platform/qcom/camss/camss.c     | 292 +++++++++---------
 drivers/media/platform/qcom/camss/camss.h     |  31 +-
 14 files changed, 315 insertions(+), 254 deletions(-)

-- 
2.41.0

