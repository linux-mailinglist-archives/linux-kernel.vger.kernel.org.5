Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E667B370E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjI2Pmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjI2Pmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:42:53 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D5FDD;
        Fri, 29 Sep 2023 08:42:48 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 0A9F482388;
        Fri, 29 Sep 2023 17:42:47 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 29 Sep 2023 17:41:57 +0200
Subject: [PATCH RESEND v5 1/8] gpio: pxa: disable pinctrl calls for
 MMP_GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230929-pxa1908-lkml-v5-1-5aa5a1109c5f@skole.hr>
References: <20230929-pxa1908-lkml-v5-0-5aa5a1109c5f@skole.hr>
In-Reply-To: <20230929-pxa1908-lkml-v5-0-5aa5a1109c5f@skole.hr>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de, balejk@matfyz.cz
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=717;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=yNr4Eqx9Bi0YeNPlA8O02XTVqPtmRaJFN4LA8s4bBdA=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlFvByWVc9E8OD4qhhAbUIxeBnSccOKCeOL4dds
 BFOjRd1vQSJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRbwcgAKCRCaEZ6wQi2W
 4Xt+D/0TkYMy0YcQtgCw1tS6bwfNQts/LWwksqUegyHiR+8ItFU8dUPsHHhVUyUETy+QZnZ9yFe
 fdDylRoUvEPfTKXyX1aba+iNDXCNtiRslTIq10o3WgqjhYn7xiZap6MNQw2/npQLRrEv83R2vGN
 BCWApSlXUs3+XcCxU2IJeM1zh6wtZtpwHi+ibfA3DK6e5BW1npgmhlZ+agh8eIwWg8oN/LB6l+x
 H0rBmWO1tykmEqLGz1DoWulk60a94q6PbDUzYVrC1cSjiCLMfIG3lp6cc/Y/Z3TyF/rhLxipy3O
 Q34V5ttDxgT4JRmG4Xw7fQODVW1A9nGsT1KIXRSR17ElB+DtvgA3ySHXSMTrgK+Wgpu9XgraUn2
 9LfmdNeBPeLfiQqkZLbyEagThieqKEhH/o6yDal+VKtFXOXGUPmQPadERGaW27Z0Ecd8mvwW9a4
 TF/sWvOK3xwfzmVehdYNbpnmxUUsSHWYaCfWmhsxW3s4bBB1ZDTdFba11tBR2Uq89fX3XMc3M3g
 bUbLNE8hrGfkQqklQJokC5iqgpM37srWx3bM49TvzinFl0qr7ljxxwxqkbeUJa5mGSXNSWcuVXs
 53Qpht9sYMVXc+0oNC06dEs+XGnqgq85xBEGmo2m8AvoiwF5pAh8+Z59UrvM0P4CgWAjZp7CQbt
 oTYCARrGmyFRdVQ==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to PXA3xx and MMP2, pinctrl-single isn't capable of setting
pin direction on MMP either.

Fixes: a770d946371e ("gpio: pxa: add pin control gpio direction and request")
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
 drivers/gpio/gpio-pxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index a1630ed4b741..d92650aecb06 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -238,6 +238,7 @@ static bool pxa_gpio_has_pinctrl(void)
 	switch (gpio_type) {
 	case PXA3XX_GPIO:
 	case MMP2_GPIO:
+	case MMP_GPIO:
 		return false;
 
 	default:

-- 
2.42.0


