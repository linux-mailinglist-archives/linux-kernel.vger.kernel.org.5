Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C3A7C6FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347190AbjJLN4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjJLN4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:56:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C43BB7;
        Thu, 12 Oct 2023 06:56:06 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so1780157a12.1;
        Thu, 12 Oct 2023 06:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697118964; x=1697723764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwLb5IoImv+l9r0nNUSKQQeC8H4qDyTEH6gowJi1i4U=;
        b=OAj4J6bezorOWDp/EqXTosWUje48jkTEsdPhpqZ3F6scD3WigGqEWSIBcojVG2qW1m
         Vr4wIVmj/w7PhNOSOqSKedvI3R8rukJ3Q/pfgIWHyPaVoAgH7VYz3YDrzSy4A2e04jj7
         HYkyJ9/NOv1wkQgwEkSRofMoFcfzozLNTftKeiIBkirBBH5pcy6n6uDCaWqZJge7WhaY
         83PUyp2OLvetetL0Ez5GrONVdJQCaj7UyR1prkWb0hwvWTqO8RZyfmyqe1oKroGRll5A
         FNtrGyWfQYR38wdeaHanYlfE0c6yPUPFG2j25A+o5e5VMJkwHiEUDO1FEOzEQ2uKnoyR
         sZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118964; x=1697723764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwLb5IoImv+l9r0nNUSKQQeC8H4qDyTEH6gowJi1i4U=;
        b=mkgC9yNTEcuPxl+dSY2EBscuVmWHu5rpiB9hQUm7TG+6HzN8L25oopQod7AiMOs1aU
         H74BLpGKbmlPXNBc7EFc4wa5QvvdieBd8ikDjJoEr0E1YPSP7ubkIUExn6tK/bv4cPrS
         aGbdqhiCIFJNPD6CKLY47bs8i6lyAgtvLoVNohJte82SdnXq1WDre1KPYsxznoaB9Q7O
         V7omXqeGDdKgCN9/BpzEiZXcsaim18zfhroPQXkfmHApaIS9oWgqwTV3pHHcFug3Izet
         AI26x33YjyGYqoAnxxN3+i4K05RfSa+LOxqqOkQLjhg7vD5akG6CPNO0dubmDUJSnRxa
         yu9w==
X-Gm-Message-State: AOJu0YzTXHb7Rs6ujVCBwTgR94MyRIdOgq6a/znkit8hxxCqIIyupSoU
        3s+w64grc+jLpB9yfH2Ji041WtqGQok=
X-Google-Smtp-Source: AGHT+IG28NmReyEW+gUCUyDjdZYc37sSm5OUldzkGMJTj2/CQMfofCTX+B6qYlpg0hN0QQJD/vS4CA==
X-Received: by 2002:aa7:c48d:0:b0:531:1f3b:cb3b with SMTP id m13-20020aa7c48d000000b005311f3bcb3bmr20468406edq.6.1697118964319;
        Thu, 12 Oct 2023 06:56:04 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u25-20020aa7db99000000b0053116e45317sm10086499edt.44.2023.10.12.06.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:56:03 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     linux-pwm@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: brcmstb: Checked clk_prepare_enable() return value
Date:   Thu, 12 Oct 2023 15:55:57 +0200
Message-ID: <169711894379.3084011.10781106942300098863.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005164728.1846726-1-florian.fainelli@broadcom.com>
References: <20231005164728.1846726-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Thu, 05 Oct 2023 09:47:27 -0700, Florian Fainelli wrote:
> Check the clk_prepare_enable() return value and propagate it.
> 
> 

Applied, thanks!

[1/1] pwm: brcmstb: Checked clk_prepare_enable() return value
      commit: d559f11591900a283b2a0b1087d68992e6c2062a

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
