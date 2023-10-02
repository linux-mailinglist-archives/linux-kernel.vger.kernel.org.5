Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC71C7B59C1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbjJBSJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbjJBSJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:09:36 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7588BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:09:29 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7741bffd123so7270185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1696270169; x=1696874969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfCq6MAu8bRwi9TEgatpoY4BVdbPJq248wgHhwcLCxU=;
        b=o4IDCPuTM8iyeYj8RegdYI1xVjbpUCBHKWJXxY37aNY4dpbT3l0sPIoh+rKuDDRw+8
         bPpPesxNPTMPMM5TJCKsQWxG5Cr0oVocEO5vfZFLTmh0RDl8fUvSchVFArSFLYhap/v3
         2I/F7mh+85TUWvxMMFChlOr7Wp8CiwrvMq6FLo4tCDFK2U+OFPucTnZ5fCDD9nAiW2+V
         66tRvMqNJFNe2zgJpxOPLCex4rB9ydbdMaZwF/u4c6irMu6TVAALJO+yT14Hbu6uew5U
         MmnFEvbmHoqTyaW69kW5qWsKLgSKnm+XWfeGf309RayaU/6RbMnkhGvmMvxKREpUIzWA
         K+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696270169; x=1696874969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfCq6MAu8bRwi9TEgatpoY4BVdbPJq248wgHhwcLCxU=;
        b=FDn/RjrJ/17laXCLi/fvo1yWkzo/b4KEhlgPE9no3BY33msKLUfp2q93pO55QYGJDS
         /5ikL4Clbw30QdtDu7PL3D62AbnTOSP/YKh4vAP1DhBRQc6/8FCM/wnUw5rdIcxmL0dl
         AMvMmn3wklJKti+BHvrm/QyGgq5XolrCm/wqNq+QiFlCBYGZ9mrr1G+xy0YMb7jMB8Lj
         172HET/hxMsSK3nXr1r+pNfsQaHPiyA20PzQzyh/PW/NiRB46OduHEtmwA9urhSLLzMW
         WBnZV+nZXXCrs1/laJAPdXOku41v/iEV4JBAcChbiwNqwMZXtJS9XoYVeyHZfc4SMNLU
         j9vw==
X-Gm-Message-State: AOJu0YzKBBnasoN/S4ybGYeVZ5uBXLLgmD9vAkw6BKx9pKBMx6u+62cH
        sFl3QmXt2J3fxiEBzD+ozUhzgA==
X-Google-Smtp-Source: AGHT+IHop+Asiy9bLSfXRnllAQF/F67qbTBnzT0eLQO8TWH47NHOTuxYVaMToaBRfrPoZTYvNxMALg==
X-Received: by 2002:a05:620a:40c4:b0:774:1ac2:79be with SMTP id g4-20020a05620a40c400b007741ac279bemr16806248qko.53.1696270168810;
        Mon, 02 Oct 2023 11:09:28 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id w15-20020ae9e50f000000b0077423f849c3sm7390255qkf.24.2023.10.02.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:09:28 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 0/2] ARM: stm32: add clock for pwrcfg syscon
Date:   Mon,  2 Oct 2023 14:08:52 -0400
Message-ID: <20231002180854.1603452-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32F4/7 pwrcfg syscon was missing its clock, making it impossible
to use after clk_disable_unused(). Simply adding the clock creates a
circular dependency, because the syscon is used by the clock driver.
This series resolves this dependency and then adds the clock.

I tested this on a STM32F746 and verified that syscon writes now
succeed even after clk_disable_unused().

Ben Wolsieffer (2):
  clk: stm32: initialize syscon after clocks are registered
  ARM: dts: stm32: add pwrcfg clock for stm32f4/7

 arch/arm/boot/dts/st/stm32f429.dtsi |  1 +
 arch/arm/boot/dts/st/stm32f746.dtsi |  1 +
 drivers/clk/clk-stm32f4.c           | 12 ++++++------
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.42.0

