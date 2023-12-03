Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6AC80287C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 23:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjLCWi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 17:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjLCWi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 17:38:57 -0500
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DA5C8;
        Sun,  3 Dec 2023 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
        t=1701643112; bh=AesBkNxA252D4AbyjH4t7j7mkstu5vSTutkNPCSMK78=;
        h=From:Subject:Date:To:Cc;
        b=3jRWZPOBQ37sHriz6gJx599YjztV6LFvoSQ0pTXrIhS46EGq7gtibm4g8vUEbRIp6
         VkLNDF04yENFofs7e5viAMajLAqrBBnuy/vraP4zqq0gI4XrFBgRv2JG5MpChKPjJu
         07wm5kRHgOuEWpPXkaUiHoS/L/7giHo4xVjRp8HM=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/2] Bring up more CPU cores on MSM8226
Date:   Sun, 03 Dec 2023 23:38:16 +0100
Message-Id: <20231203-msm8226-cpu-v1-0-d18e83340b32@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFgDbWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIwNj3dziXAsjIzPd5IJSXQsDw6TUpKTUFAsLMyWgjoKi1LTMCrBp0bG
 1tQCaFWvOXQAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=676; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=AesBkNxA252D4AbyjH4t7j7mkstu5vSTutkNPCSMK78=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlbQNet1Qkqw9icqh7x2TvysX/TZVC/88Bqf31s
 /lVyLhq3H+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZW0DXgAKCRBy2EO4nU3X
 VmSFD/0e+mfQbG/JfIugUj5C5g3aoUlvE2k2qSJIqwdVUZs2s94HVcpvzmdGMebPy3rGV5PhjYv
 S5+mzX/0+9rJvZvGByZ4C8g4zdjSpYI/X4KlqHn0TBCJudMwaUOSuHJkvpfxXGQfSuIaga37lJ/
 StIhoXuj2PddYFI5RRQkkJnoU5sNTVzPJ3TxizFc/B4nKkiZC7eAAN+shaxQuYRFnW6RT7/ZLMH
 6gUrEkiu6zs356DZWQaWWOTyybJlNlFsrA+H6rWsCFi8PLivi7LFrox3fsvIQWoROlTXTGGOkn1
 TTL+1cpqrL0/3ybgVtJHdej9B4McYAG+A0xFij91pSbT5914T7OBEF4zr1tl+XaYNX6b3EJj3bV
 jryo686MpC8IBz6A35osCKmF/ENzxPJ1PHyqWepgt2RSA0Jqe08MzRORzs5RFhaMhO3U7biiyO4
 bMx8xxQyWscNUzyZ6DqvuAPomv0gAAzHFwRwNoeVA609R1WLGRgxCIZ8DCG85m+BrdwghlKeU6e
 Loep7pnWqWRH+ntLyhjs/mWuJjh88BznsBHdAyu5KIi8gQXW3m6gYulIOsZibFWUxEdqfnr6NMj
 Xx/GHdlyzvt852f+y4WfiNhVLq4sDvEkvVLn0P6BfRJXhDDiqJYSE8RnfeQisI5Uz0nEh17K9rS
 7UJYr3cZtY0hgBQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some nodes to bring up SMP on msm8226 SoC. Another commit to fix the
sorting of the nodes is also included since the ordering is currently a
bit all over the place.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Ivaylo Ivanov (1):
      ARM: dts: qcom: msm8226: Add CPU and SAW/ACC nodes

Matti Lehtimäki (1):
      ARM: dts: qcom: msm8226: Sort and clean up nodes

 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 751 +++++++++++++++++--------------
 1 file changed, 421 insertions(+), 330 deletions(-)
---
base-commit: 63b325612c1e996a107fc156db8ea9b756a9f65c
change-id: 20231203-msm8226-cpu-801bebbed886

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

