Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA59805E02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjLESsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjLESr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:47:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1377C1BC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:48:05 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d0481b68ebso10158865ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701802084; x=1702406884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9X0r27/UbN68GCjekZeYhwtKfth61JxLqxfjcWsu3w=;
        b=YV2NNP5+YFYUnHdaeV4f6/85wPAFHWoasarITInW0kh+SFHFbfPwIyYU6WgGtvE98P
         xP9YrLa2YLFqpTVvsguubIcm9Sd+HxuIE7XW252He/6OiWRYT3v1NJlneHu/1WjpqFU6
         Z+LWKyT9WKAFwEFMpEA9SLzDKtQdfj+td3nEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701802084; x=1702406884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9X0r27/UbN68GCjekZeYhwtKfth61JxLqxfjcWsu3w=;
        b=GhIhKnshYeL/kYgkpATmks+h9qj/kQUs/GE3T20B5t4YN7j2Sw69tCRSpBRQ/QqjEr
         7hyEYk+KGEm++A0wrayP+XbZa48ULiMpKVqynmHeGtvEpq6AxUCpuCTcBrXTFhWN5Iff
         BYTkpsYPFpaKDrbHxbY1IOFBVxqfY5N89Cfpw1qGk68tk2CDIhl1adtXT4FPGSehGVAN
         gT2FJBSAbq+MPT8JmF8sZFmuErtowVur5xbIUeH5XdRNjW7wUsi3Ey14cW2N+rxCT3jS
         zmmLmieKTddedkP+64+nMt9jyYDOTb83pwZDc/kB547dIehC4bqnINXzKsh47IBrE8lx
         iZew==
X-Gm-Message-State: AOJu0YwbOIxhOYdKFR0OoyNx+L1i31/6J06hraBzLqH9SbdZG1uDVc0v
        D0kRpdUsKw9GQ8/xESRvUtLPTQ==
X-Google-Smtp-Source: AGHT+IE1+yOzhmVcL8taX+gYSSTqB7TcNtmGAbJ+dH168Aul+Cu6lmHkkattSuS8hRhsTx9zw4Jk4g==
X-Received: by 2002:a17:903:41c1:b0:1d0:6eae:8e57 with SMTP id u1-20020a17090341c100b001d06eae8e57mr12590444ple.1.1701802084368;
        Tue, 05 Dec 2023 10:48:04 -0800 (PST)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709027e0b00b001bbb7af4963sm10726422plm.68.2023.12.05.10.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:48:03 -0800 (PST)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
        id 7555AD00; Tue,  5 Dec 2023 10:48:02 -0800 (PST)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] memory: brcmstb_dpfe: support DPFE API v4
Date:   Tue,  5 Dec 2023 10:47:33 -0800
Message-ID: <20231205184741.3092376-1-mmayer@broadcom.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has become necessary to distinguish between the various DPFE API
versions by version number. Having just chip-specific compatible strings
and one generic version is no longer meeting our needs.

Also, a new DPFE API version, v4, needs to be supported by the driver.

As a result, an intermediate compatible string format is being
introduced: brcm,dpfe-cpu-v<N> where <N> represents the API version
number. This is more specific than the catch-all "brcm,dpfe-cpu" and
more generic than chip-specific compatible strings, such as
"brcm,bcm7271-dpfe-cpu".

The changes are split into several steps.

First, we update the binding and introduce the versioned compatible
strings.

Secondly, we add support for brcm,dpfe-cpu-v1 through brcm,dpfe-cpu-v3
in the driver to match existing API versions.

Thirdly, we introduce DPFE API v4.

Lastly, there is a change that isn't directly related to the
introduction of the new binding format or DPFE API v4. However, with the
increasing number of API versions, broadening compatibility can be
helpful. If registering the driver using the DT-provided compatible
string fails, the driver will try all DPFE APIs (except for v1) to see
if one might end up working. This can come in handy if the driver moves
on and learns about new API versions while Device Tree cannot be
updated.

Markus Mayer (4):
  dt-bindings: memory: additional compatible strings for Broadcom DPFE
  memory: brcmstb_dpfe: introduce version-specific compatible strings
  memory: brcmstb_dpfe: support DPFE API v4
  memory: brcmstb_dpfe: introduce best-effort API detection

 .../memory-controllers/brcm,dpfe-cpu.yaml     |  8 +-
 drivers/memory/brcmstb_dpfe.c                 | 95 ++++++++++++++++++-
 2 files changed, 100 insertions(+), 3 deletions(-)

-- 
2.43.0

