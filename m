Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65FD7B591B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbjJBROO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJBRON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:14:13 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4227A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:14:10 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7741b18a06aso2528485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1696266850; x=1696871650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vIApzqx7RSqfv9G4qO6eh847tMk8NOWVGPEc61q9ek=;
        b=hyHGKvKu0WUl0mYMLep4im3oeXdVijVjlL/T3dd3whaKcDs121krpwqDDXLTTGEtP7
         Tw99tkUqHTS3ruXr5JfD40ZeLD8RRMCXgt2OBbhl39GR3YkwkhdDew1SOmzQyEs705N+
         LO2pHT7pFcb51hgcfkxeFWVUw05eq75GeZvu/KGYp2Vok7mevg+VzCA9fP2PlMHyH4z/
         zzxr0s43W0C6lwgiPz6E119N7QKXVrfe0ZjCoWC8za92UDGucobPeIxLn8hcRr1T11ES
         pxbTP8FYmg7vvi42nfBij87HHI4bXK3nvZ3CLd6AnPjrD4eYfVMjHoFZmAI+OAWe7uB8
         UR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696266850; x=1696871650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vIApzqx7RSqfv9G4qO6eh847tMk8NOWVGPEc61q9ek=;
        b=a+d3EA/QwAtLOhoHqdQzm98vKc7cE7/gsDGCmtrboZP8aaWVOrNeL/nS2WRrBA1HgI
         f9K2m/UdhTuMiMY7pm7pJJMKstF95b2RaB+/ZOtAu2VVQ0RAvHV4R91lLjYv2NnDVnhH
         mlkpLST6m4SvZrYMnISC9KohKxTj6qj91NuVi0t3Jhbx/dPg0mlBvQ76TcHKLXRHw1O+
         cq80AbcWfpoDP4K4Mb0OfYPM+Jz0g3amIaiycJ8Bsp+grWE8mfibSDqdEbmUnPVY3lWy
         o66qYsp0JO+c7s156Yxe0lS5VgXG2BAT1tTwif1oxkSFrkpti5GrHfoP3eOsZsNg3XyN
         +MtA==
X-Gm-Message-State: AOJu0Yzn2frzeZikjUhc5g9+H+LBsPe/GWRLkrOFHqsPGvRCQtkCAPhi
        tLQyQdR7s7rEqdhpDiqHmf4J/g==
X-Google-Smtp-Source: AGHT+IFZurT7JngeQirwA2jtLYPng4babEnnQLl5D2Ptls5BdYYfh6ahjHWl685659a+Wn7KA9QJDA==
X-Received: by 2002:a05:620a:31a5:b0:775:8040:ede6 with SMTP id bi37-20020a05620a31a500b007758040ede6mr14551196qkb.21.1696266849865;
        Mon, 02 Oct 2023 10:14:09 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id dy52-20020a05620a60f400b007678973eaa1sm9132660qkb.127.2023.10.02.10.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:14:09 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 0/2] ARM: dts: stm32: add SDIO pinctrl sleep support on stm32f7
Date:   Mon,  2 Oct 2023 13:13:37 -0400
Message-ID: <20231002171339.1594470-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for switching the SDIO pins on the STM32F7 series to analog
mode when not in use to save power.

I don't have any of the disco/eval boards to test, but I have tested
this on an Emcraft STM32F746 SOM with a UCL-SOM-BSB carrier (using an
out-of-tree DT) and our custom carrier board.

Ben Wolsieffer (2):
  ARM: dts: stm32: add stm32f7 SDIO sleep pins
  ARM: dts: stm32: add SDIO pinctrl sleep support on stm32f7 boards

 arch/arm/boot/dts/st/stm32746g-eval.dts   |  3 ++-
 arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/st/stm32f746-disco.dts  |  3 ++-
 arch/arm/boot/dts/st/stm32f769-disco.dts  |  3 ++-
 4 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.42.0

