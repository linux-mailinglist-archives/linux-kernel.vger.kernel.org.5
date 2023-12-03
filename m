Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE248020D6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjLCEwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjLCEvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:51:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54850D40
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC07C433C9;
        Sun,  3 Dec 2023 04:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579110;
        bh=jQ9uX2NqNz2mpAo8MQUUZUsit67Uq9hXoV0xcPByrrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fT+DR9C31YjC0vlS5Hl8QELS1xzDeDvaK/VDnXa6sjFObpuNaTayaa+6CLba6dodz
         r7asff2T4SHC+xlwg93vsXZcV3yV3SffUicMK/LIOqRP/ljhBcv+7PKhfM51FcB2TD
         oOwRNMsv2fSl97GfMIz4Oa3CKrt6fcAbFrGu68WM+NFzowNMY/sDLM6ov9oNApJiMO
         OILF2QWW4FaZ2MPRsEGs+N5QJjG994FcVRNYp1mjbug+l5DN5z9DDce1xi8l6keBrn
         5D4bASjicEO5qoDzvjxtA+gI93vhFPfTaS369X+qOoDDercrsVzMEfks7lc9DyS2fz
         Yy/E4y/DlMK2Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Subject: Re: (subset) [PATCH 0/3] Add watchdog nodes to msm8226 & msm8974
Date:   Sat,  2 Dec 2023 20:54:39 -0800
Message-ID: <170157925797.1717511.7301998654173050568.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz>
References: <20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Oct 2023 18:33:12 +0200, Luca Weiss wrote:
> Document the compatible for the watchdog found on both SoCs, and add
> them to the SoC dtsi file. And especially for the case where the
> bootloader has already enabled the watchdog we need to start petting it
> on time, otherwise the system gets rebooted.
> 
> It's worth noting that the watchdog behaves a bit unexpectedly.
> It appears the watchdog counts down significantly slower when there's no
> load on the system and can last far longer than 30 seconds until they
> bark. Only when putting load on the system, e.g. with stress-ng does the
> watchdog interrupt fire and kill the system within an expected amount of
> time.
> 
> [...]

Applied, thanks!

[3/3] ARM: dts: qcom: msm8974: Add watchdog node
      commit: 95053f6bc8ffca438a261400d7c06bd74e3f106e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
