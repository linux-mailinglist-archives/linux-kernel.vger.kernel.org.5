Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722167DCF21
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjJaOOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjJaOOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:14:53 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852C3ED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:14:50 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 853023F6A0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698761688;
        bh=Q44keJVGaKBkwqEmz1WVH/8yD9sVBY1cid355hx4DyI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=u2/fHIpxX7oV3xb7sTNGwfikZAELdYus/PJ3sbIzSsqCNjn7aarcuY2dDj6Vmgk/G
         UpQ9LvF4SNPFFKT5vfgMdZS80mSbgnUvhMJgQ0hX8rQbTU0JTJ1/X79Jey+8iqgf+T
         LnB86wKYULQh9m8kLO2F7TaqQu9tRr6J+Q1q1LmLXQl7x19FwwG6SPubO6PWvTicXN
         RNh0Ih8AkIv30B6USd1eMm1i2rz0JYhdtN/Vn3ifuHJ/UFJ/xtC/ZkhV0Y6jUz0pzc
         vCQ4bUctGKQblyh30Jrn1CYUbnPFWBoVUeQjPxha+Aqz8Q/HBnyHLwIn84LuDRcqeC
         ES4mTj7LcFNlQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae57d8b502so395288966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698761688; x=1699366488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q44keJVGaKBkwqEmz1WVH/8yD9sVBY1cid355hx4DyI=;
        b=Iojskp0a0lcJeKGNttz+f9RdAAzKJj+sQ3D26LlFd9lvhaY9G8YuuGundChcIfAh4b
         FxUdpCAqWpbJrVNuC6nrwjLHnqCN8atyP8o8Ei17UlwpU+bktjiCcPlYsuTvGKyuz74Y
         BbxWbIuXbCCU5Tq9KTZD5P8sNTdU3N/mmP3LwiWGBHvRwT+pGLmkLoI3HM9OfjtpDEh4
         5m7AjRAZsYArbkMVBo0qhGwPwFP/RWU4NxBdXx1kUTlpLsVlL44ka4FtPJdDRVntNd9n
         wXmlTf6gxtO3MNzxNZ/hl/0v9e/bGczZsJXkTXCJCG32gI9232dTdavgZgHxz4h3TgRL
         q+rQ==
X-Gm-Message-State: AOJu0YyHSFmlo8Glw54jP/MzS8m3n0Dlnrx+wjn8TGsV1zvf9L/WMcmX
        9578FwuMW5qVUAqBnXnaX8T/LPOuOaG1i88eD7Gw0YFgdAqaXwJpN/pkUB2YOn20WVCUhfHIzIq
        hUNyaK8bmuFBvUZ444S6pVY7KsjuR9UN8bEO1BVAo8rEGwDj+dg==
X-Received: by 2002:a17:907:1c0f:b0:9bf:2f84:5de7 with SMTP id nc15-20020a1709071c0f00b009bf2f845de7mr12150621ejc.4.1698761687880;
        Tue, 31 Oct 2023 07:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNNB1kOl40YNNgulYED6HWdQEMfYH4dxGn6uxtPiyveTyL8eA57XZ6tGygKxqqCZcI7GLzSg==
X-Received: by 2002:a17:907:1c0f:b0:9bf:2f84:5de7 with SMTP id nc15-20020a1709071c0f00b009bf2f845de7mr12150604ejc.4.1698761687590;
        Tue, 31 Oct 2023 07:14:47 -0700 (PDT)
Received: from stitch.. ([2a02:aa7:4003:190e:bd47:7b6e:876:4bdc])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709061b4500b009d23e00a90esm1037395ejg.24.2023.10.31.07.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 07:14:47 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 0/2] soc: sifive: ccache: Add StarFive JH7100 support
Date:   Tue, 31 Oct 2023 15:14:42 +0100
Message-Id: <20231031141444.53426-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the StarFive JH7100 SoC to the SiFive cache
controller driver. The JH7100 was a "development version" of the JH7110
used on the BeagleV Starlight and VisionFive V1 boards. It has
non-coherent peripheral DMAs but was designed before the standard RISC-V
Zicbom extension, so it neeeds support in this driver for non-standard
cache management.

Since v1:
- Fix email threading, hopefully.
- Drop sifive,ccache-ops device tree property and just match on the
  compatible. (Conor)

Emil Renner Berthing (2):
  dt-bindings: cache: sifive,ccache0: Add StarFive JH7100 compatible
  soc: sifive: ccache: Add StarFive JH7100 support

 .../bindings/cache/sifive,ccache0.yaml        |  6 +-
 drivers/soc/sifive/sifive_ccache.c            | 62 ++++++++++++++++++-
 2 files changed, 65 insertions(+), 3 deletions(-)

-- 
2.40.1

