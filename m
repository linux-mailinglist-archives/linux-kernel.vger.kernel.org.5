Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3297F7F7126
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbjKXKQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345574AbjKXKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:16:29 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1F9170C;
        Fri, 24 Nov 2023 02:16:27 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a002562bd8bso336032966b.0;
        Fri, 24 Nov 2023 02:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700820986; x=1701425786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQhIen8bUSqCDzW7zy5bjryP0TL4VgTr4AnDnzWte8c=;
        b=K3NOkIAcM6cvI+byTsQb+wnl+lA60J0Mx5TyV51B3hwahDIrANoISkUn4esd3sA2Vu
         mLtnVGazWfPsmp/T+uq4c1AwlB1Iwj/1enhd9tAOeZ+4IAztmkIjp064RtkdNCzDHxBd
         iaMimqRkJf6ngwqocqqLmZxPaV7DYRbAtX9PkeeNPTwWqbH0SBCE57nj1M/JcrxJloDl
         xHK567ucl7bJSNdYQbsXczRiGkD2Doz3uxBetXUVmbvwBSpYx7/U5Gf2QSh1ZUWvWajy
         /wT5JhEhxo2pwVTC8awD/sCnIGF1Ai8mZL5aT1kuEhNoZjLf9YzY266VeSFQc+K+tvvD
         vX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700820986; x=1701425786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQhIen8bUSqCDzW7zy5bjryP0TL4VgTr4AnDnzWte8c=;
        b=bEBA0A7la7czxERNTgNYDKqtV43tPT0YpJykWyO6+oyOOkgsTDec6FS+hwxBf4dqYs
         PdSLYI+vusO0d4AZPXFt9vMs2HvCx8GcUTPYUw+4KZ+A0LVzOtThaS3OKpzUiHqL0bmG
         IBLrbjmvG/FxcBQNYAtFAM4ALjACxqj1fM5JA0Yr4lsNqUmuZL7ECqJWLq5hIFvGq7nj
         9cWz8xZyBh1n/mrALKxVKfgqHTgryTAAi0sZR9cq+fvJhesZZf6j6NeubpixUaqnff2r
         K+HLZyyr4dWWakPDj+ubmoj0RZA8LLteW3Q7wGCrOOsULaJ0uHoCtc9uKbLeW2+08+3E
         xbbw==
X-Gm-Message-State: AOJu0YwECQObZCgd3FC8Na794Q0fYsQCWLo3nNr6OObhpSLkAg70JBMN
        YccUFTaLckHsuFuj5ltOwW8=
X-Google-Smtp-Source: AGHT+IHz9/ZoaYSQJbFyOHsePDZMaOznbJoXwDJXSZ85fMNDrqkQyfPkDwrbhFLw3bibv4ewkyWC7g==
X-Received: by 2002:a17:906:78c:b0:a04:e1e7:d14c with SMTP id l12-20020a170906078c00b00a04e1e7d14cmr4941004ejc.32.1700820985634;
        Fri, 24 Nov 2023 02:16:25 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-72cf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:72cf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id oq12-20020a170906cc8c00b009fbf15cee7fsm1887801ejb.69.2023.11.24.02.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:16:25 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] staging: greybus: Don't let i2c adapters declare I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Date:   Fri, 24 Nov 2023 11:16:11 +0100
Message-ID: <20231124101619.6470-3-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124101619.6470-1-hkallweit1@gmail.com>
References: <20231124101619.6470-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of the legacy eeprom driver the only remaining I2C
client device driver supporting I2C_CLASS_SPD is jc42. Because this
driver also supports I2C_CLASS_HWMON, adapters don't have to
declare support for I2C_CLASS_SPD if they support I2C_CLASS_HWMON.
It's one step towards getting rid of I2C_CLASS_SPD mid-term.

Series was created supported by Coccinelle and its splitpatch.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/staging/greybus/i2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/i2c.c b/drivers/staging/greybus/i2c.c
index de2f6516d..22325ab9d 100644
--- a/drivers/staging/greybus/i2c.c
+++ b/drivers/staging/greybus/i2c.c
@@ -264,7 +264,7 @@ static int gb_i2c_probe(struct gbphy_device *gbphy_dev,
 	/* Looks good; up our i2c adapter */
 	adapter = &gb_i2c_dev->adapter;
 	adapter->owner = THIS_MODULE;
-	adapter->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	adapter->class = I2C_CLASS_HWMON;
 	adapter->algo = &gb_i2c_algorithm;
 
 	adapter->dev.parent = &gbphy_dev->dev;

