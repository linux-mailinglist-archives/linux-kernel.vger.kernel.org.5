Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269A177CB49
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjHOKoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbjHOKnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:43:53 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3201999;
        Tue, 15 Aug 2023 03:43:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso78565441fa.3;
        Tue, 15 Aug 2023 03:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692096224; x=1692701024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYPNsi1tl/0GDFSQd4trv1IQAjRIoOCldAj6utrHW9I=;
        b=BVKJ4NC6xl0b1hX2so1zEeLI80BttQqOaJJyHBsOGOuvRXY8c8dxINOxFuKYbf9jhP
         EjCKxzPRkWjXWjruArltN16oYzHMemcM2agGEg4LfQZtlWt4Jq+TEeVlFlZdJBGYgRtd
         aLGlHPINgwzso84nmkL9XgwcuMNZjsMftwwMFrzzxF8CuQ5PbJVkcjkU9EFt3MQL9+Q5
         qUAEDmHAOh6pIglsVggtcSFVoPKYKtiOuH5HiD8pspPYOSJTNojCfh/weACdsFWNz/79
         2CJRnq52jNNgoTK383dzKaV7VsW26JXbkO5Sx6gYWYxD+rSWEq6Y+WNPemWtfMC5BtkC
         lCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692096224; x=1692701024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYPNsi1tl/0GDFSQd4trv1IQAjRIoOCldAj6utrHW9I=;
        b=LvDUkcOUrOGAg3arQdhN+tSofYc3Vk94tldOle63n1CnFfwcmkkpxIEzLfUuJCA2H0
         QkvbW7ZpCWEu8ul2TvlFK6OnulKBPZ7BbM6BNVgEZ6fVen5HCbuIpItVZ6WOeC5MzaT3
         bRFnLonASf6D39LDkkhVr6OjrIF8+BkAK4h/Fd6Epb1S6JryA1YQTJub+tQ0fmYSAx9o
         UB3dvXWH9ROAbVybwWUXr24W3HjnuTe7phtWmPUpIGNI71dRvbaVNfy9Dp9cu43H6gew
         CKycPZSv4N7zKr/DvVoZnVVB0syacLKbXJrRxV6W4KGK4t2E+sX3bkUeays6vYd9vETz
         YM7w==
X-Gm-Message-State: AOJu0YyXm6vAwV3amv1tpqtp7Y2zGUbWYZyya3FxBLy+BCVsayioWgM5
        DAxgckVlWcsQT5ddwZyaB6s=
X-Google-Smtp-Source: AGHT+IFT/ZySzwqKc9Vu47m3NtHFJhQcTa+4fAaJxkK4zkHQORY0GTYEDGrh/4x7l50Qp9yA/a1reg==
X-Received: by 2002:a2e:b011:0:b0:2b5:7a87:a85a with SMTP id y17-20020a2eb011000000b002b57a87a85amr8385283ljk.13.1692096223533;
        Tue, 15 Aug 2023 03:43:43 -0700 (PDT)
Received: from localhost.localdomain (pd9e9e2b1.dip0.t-ipconnect.de. [217.233.226.177])
        by smtp.gmail.com with ESMTPSA id md15-20020a170906ae8f00b0098d486d2bdfsm6944627ejb.177.2023.08.15.03.43.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Aug 2023 03:43:43 -0700 (PDT)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
X-Google-Original-From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Leif Middelschulte <Leif.Middelschulte@gmail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] pwm: imx27: avoid PWM consumer API
Date:   Tue, 15 Aug 2023 12:43:30 +0200
Message-Id: <20230815104332.55044-2-Leif.Middelschulte@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230815104332.55044-1-Leif.Middelschulte@gmail.com>
References: <20230310174517.rb7xxrougkse2lrc@pengutronix.de>
 <20230815104332.55044-1-Leif.Middelschulte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access struct members directly as adviced[0].

[0] https://lore.kernel.org/lkml/20230310174517.rb7xxrougkse2lrc@pengutronix.de/T/#ec9560c1f613d9c0d7b77d72ad9051768812f80db

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
---
 drivers/pwm/pwm-imx27.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 32389ca2da3e..c2a1e2030072 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -124,7 +124,7 @@ static int pwm_imx27_wait_fifo_empty(struct pwm_chip *chip,
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
 	struct device *dev = chip->dev;
-	unsigned int period_ms = DIV_ROUND_UP_ULL(pwm_get_period(pwm), NSEC_PER_MSEC);
+	unsigned int period_ms = DIV_ROUND_UP_ULL(pwm->state.period, NSEC_PER_MSEC);
 	int tries = MX3_PWM_FIFOAV_EMPTY_LOOP;
 	int fifoav;
 	u32 sr;
@@ -248,7 +248,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 	sr = readl(imx->mmio_base + MX3_PWMSR);
 	fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
 	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
-		period_ms = DIV_ROUND_UP_ULL(pwm_get_period(pwm),
+		period_ms = DIV_ROUND_UP_ULL(pwm->state.period,
 					 NSEC_PER_MSEC);
 		msleep(period_ms);
 
-- 
2.39.2 (Apple Git-143)

