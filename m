Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BC57FD6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjK2MZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjK2MZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:25:54 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C810D48;
        Wed, 29 Nov 2023 04:26:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a0b65cbf096so590787566b.1;
        Wed, 29 Nov 2023 04:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701260759; x=1701865559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9viodrxXNdj6asj6Vfl3mqqfWCQOtvTzy3eNWtRL9A=;
        b=PcvSGuGRu6sFiAPRQw6vLr/QVEujyUaj7EqIVSbM3k4W9HIXYsiJCieSF5QpsGrXHQ
         kS01Ih3lNWCXGN1AifGlewO3+7Tb1e4uFXc6uINqvvFoDpq5B1qA9q060HD8Xr4PemlJ
         oZZqYcUKKH/wdbbbT3m5vuJOIdrVq0o1HjujdfZbrAl6b0v9kqZLGdblPyH5mL7ygB67
         lJaZCpItwZIs4x/fvJvtlb6+C4r0HTKjNTsp8FheD6fcCOvQcTmdw5xHgr126TwS0aCq
         +fjmYC+rytda+v52mfB6oIm8cQ94rE7C8pZfOgIYH0X7j+qrNtcj/ZL6bn0uoX2CCK+k
         EgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260759; x=1701865559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9viodrxXNdj6asj6Vfl3mqqfWCQOtvTzy3eNWtRL9A=;
        b=sGjTAFMWRqYlpWI2FlCkeO/mnT5ztPYdm5be1qdgIz/6qD6d5qvPIF5dYJ/Hj+Ng6T
         QrUViHpw1OCgdnyy1SpY9Z+SUflOhlEhSOP49HjLtPNUD++M2Amua23yTwaN5noKVkaD
         VP7m9gUw/a8NsF3ec7x2XRVDAw3WYWbnJLPaOubW6Um38CayJAY2ji7iihf095BqDsET
         X2nE1+7xGM0eE/AXrR0oYR54LWnjq4P5KTeZpoPC9X0PIMwSz3PeZsA/9V9fzNemvNHl
         flSkLr+aJtWmDvzPFtJwmK+HNbZXWNJ8aDZPYcLccZ+H3GfC2drEgPCrXd8Fty1/c5O1
         9/1A==
X-Gm-Message-State: AOJu0Ywt+2oR+w0aKuYvXPSnuJhvsgB7zsS7/jK1etssO3p38PxcU/ZU
        55RCPm+oadvMwuOI+a99UXU=
X-Google-Smtp-Source: AGHT+IEBEwayUX3L1ODBT+6O5vVXOFdRqoNGbEWVmreIV4DlK+MXeF07PXVsw0SwKDECv7o5u5qYTg==
X-Received: by 2002:a17:906:6d8b:b0:a00:b4ab:cb6d with SMTP id h11-20020a1709066d8b00b00a00b4abcb6dmr10449582ejt.69.1701260758454;
        Wed, 29 Nov 2023 04:25:58 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709064f1200b00a173547a28dsm642734eju.195.2023.11.29.04.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:25:57 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kernel@pengutronix.de, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] pwm: Update kernel doc for struct pwm_chip
Date:   Wed, 29 Nov 2023 13:25:52 +0100
Message-ID: <170126072780.448555.17859780866289805734.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129101831.908952-2-u.kleine-koenig@pengutronix.de>
References: <20231129125826.08d7d178@canb.auug.org.au> <20231129101831.908952-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Wed, 29 Nov 2023 11:18:32 +0100, Uwe Kleine-König wrote:
> Commit c572f3b9c8b7 ("pwm: Replace PWM chip unique base by unique ID")
> changed the members of struct pwm_chip, but failed to update the
> documentation accordingly. Catch up and document the new member and drop
> description for the two removed ones.
> 
> 

Applied, thanks!

[1/1] pwm: Update kernel doc for struct pwm_chip
      commit: 53a2eaaf19c4e652ac53b5b2441582a555768516

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
