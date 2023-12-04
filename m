Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E893A8038E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbjLDPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjLDPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:35:50 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749D4C3;
        Mon,  4 Dec 2023 07:35:56 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bc8a9503fso6124235e87.3;
        Mon, 04 Dec 2023 07:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701704155; x=1702308955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xqmn56t4S0FY+90Mo/LoUaieX3Kd58AJtohExc/I0y0=;
        b=GcTRv6OopZ9McParB6ovzu0W7XpYoTQwfOk47AgTWTfr/zmdsQGyTlw7NlhW3bCFeL
         B5KVKoEJ/Is/uxZCvMkWT+DqD7KZJRL3vi8rJXDmkfsHxwIW0JZaS1U1+Fm20LyIIE/k
         NrCuhK9NgOBGQqYGeOMAWafFqCQxPV9cO+cfhM4OZfBVteVT6vc8i3U7aMXAmbedYTmX
         Gi0mGvyG6QRdzsGqDP3JyaYKdds0/qcHcj+yY42v6QVyEE9krqv2bNcxmvNxy3mX+Zsa
         58LnPAZYdlnQ9UOvrGf5s/XTfH7V6MU/xEfoQsmWRDP11ctvRUMaILCGxr9gmnMGd5r6
         Rphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704155; x=1702308955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqmn56t4S0FY+90Mo/LoUaieX3Kd58AJtohExc/I0y0=;
        b=gjnYzfktVF5BxbpdcqE9ITkiUWYrmFVl49IkYrKk/pDuODf/ni5w9xFDeW/K8s4Boa
         ysmQ8lUtvaKJ5ktUszajoiqgbw6qesmWLBgjLFdw6QH7g6DvjdivK2czO4YAzVfarHMU
         VBHFphiQ0Z6PNpRD7mxTV5dMCaW06BW9q6u7Q/5/onfGocD/40xrQw6IZzshNLWw5WI6
         TQ3ErZc6VaTznr67Wuq3wGJuNrn2dLwgtJNLBDgpkAzzlYWqMN4fjiC3N96DbHzBALtc
         ivYVLq7ngo4tK4XqBp4QxOZju2mdbXaRnfqJsDlxQky5mtlrPLPmeGMbe6zfjh3ZYqRH
         tlpQ==
X-Gm-Message-State: AOJu0Yxnvh+WfsiWGsDqnywmUPl0nGAt2MdeScCY2fS8EQxbU5nc+w3/
        Qe9BqEYSHgrNH/MPQM/nyw==
X-Google-Smtp-Source: AGHT+IGBhLtxslcjLGRyx0hVDNS9dk7oEruIspupZ8AqpVd6HTktgYB9nKcGugo2+u7VfHcL6JP/qg==
X-Received: by 2002:a05:6512:2fc:b0:50b:e3ee:5433 with SMTP id m28-20020a05651202fc00b0050be3ee5433mr1534642lfq.24.1701704154631;
        Mon, 04 Dec 2023 07:35:54 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:55ff:210b:5393:c9d7])
        by smtp.gmail.com with ESMTPSA id h20-20020a05640250d400b0054c77ac01f4sm693194edb.51.2023.12.04.07.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:35:54 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 0/3] Add power-controller and gpu for RK3128
Date:   Mon,  4 Dec 2023 16:35:44 +0100
Message-ID: <20231204153547.97877-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the power-controller and the gpu to RK3128's SoC
devicetree - both are already supported by the respective drivers.
Patch 3 enables the gpu for XPI-3128 board.

changes in v3:
 - dropped patches for not-yet needed power domains
 - dropped dt-bindings patches which was already merged

Alex Bee (3):
  ARM: dts: rockchip: Add power-controller for RK3128
  ARM: dts: rockchip: Add GPU node for RK3128
  ARM: dts: rockchip: Enable GPU for XPI-3128

 .../arm/boot/dts/rockchip/rk3128-xpi-3128.dts |   5 +
 arch/arm/boot/dts/rockchip/rk3128.dtsi        | 132 ++++++++++++++++++
 2 files changed, 137 insertions(+)

-- 
2.43.0

