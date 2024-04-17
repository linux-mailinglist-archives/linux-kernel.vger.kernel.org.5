Return-Path: <linux-kernel+bounces-148201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C098A7F26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B0D1F26799
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C25D12C490;
	Wed, 17 Apr 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1Cd+oao"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC812837C;
	Wed, 17 Apr 2024 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344731; cv=none; b=GJ9X2LgNbb/qFnzFtAwDMesb6pY5KicJ/fDz5ciQX3LMG6C21znkUIuHHfnwqi43wmrFGQqlr553wnLsFBWPq7bkUoxVS8RCaZ/F/fgWJZzeLnwmwLEmb1upPJXBoZelIk/qw0ZOJajSZC8Chgl3y2pdA3BjXZUoJDHxfcpkRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344731; c=relaxed/simple;
	bh=qEvEcdnHm8khTYsI96xtmLJDTERDUDkkzMTZ8zo0B4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V+dxIIareGuTOY3oKWhUZCH3FbG6mp+qB67a38awaRvNuQV6dKcMTbjlfWtO3JjM2sO2vYuGMZ3U6invn4yL+Gwq5w7CxrMCfeGqF2MmJnQEOhutb1Ql8Ye6OWT4T7STB0zzwQRxMoC0JHWf8XUyxG+taQf22rWEzS1NLLfq/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1Cd+oao; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a526a200879so421753066b.1;
        Wed, 17 Apr 2024 02:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713344728; x=1713949528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGmjfmjvJt/yjSXYMBDNTlpob7e25JoHrGjnnPxXC80=;
        b=H1Cd+oaoPb6W0GDN/4ufwqSpC8tTEQpAHKP0VVrgQXpnFl0FMtFO1D6avJIYftOsY7
         3xhydxO+bp854oQRWLgAOXwz5KemvU2ucaT9hesAhQs3wuoho+pQxF78kevSTC5P/+EF
         vBLUGvckF9ctbDlclroiUOEdtRG5WbnXpbb2i8GIqmDSsKO1uoAZs0y3duhvEBJMs4oB
         7lU9goWeYXLga9gjxCJxzwmkVL6bN4Mz2iKqx7ezXhdakXALoojfxBdCIBAH40QaJs6a
         GnoRxf2lnUeWxReL8qFj98Uz191ke4+St7qtclTbG0b6vuBeHojeY6HtEYTGtr7rb7Vs
         UJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344728; x=1713949528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGmjfmjvJt/yjSXYMBDNTlpob7e25JoHrGjnnPxXC80=;
        b=GIkv6iEO3lcD/lgHO4OWrgas/QxUB9QWpltu4gScqiwtM1Ezd64ttkNwYtkJo+PMX/
         h+wuu5FW0yrPXJh12w/JTQo41S3pEeAVHm+1p/cRf1V53vVh+lM5wXaiL/9nLS3Rbi6J
         JvlBKYrVM9C1/cdr42hNXhswaWkfXvJeFm8zNGTt4Rlgf6wb/DPZgEqpEtsH1KKFAiJQ
         ssu8QuV5aWGVVuwGIt8SWMgF1otP++9kTJZqiYQtwrxhOYRk0P+X0y/On9meKuVKX8Y0
         kLngvmwjnyeXY9hTMMisGwblgdoUfFVFOzdIZLB6+dkPGLVShKkeBb9OkqYq+eEbF4c8
         G7wg==
X-Forwarded-Encrypted: i=1; AJvYcCXx7w/WTKhbLkdIokr1lwc8cJPvTal/VoSwlCvXkCcCpVEda1Jag8VSlzxc318AInvI5eTiOOyemZcQPc6lCgqZrZRmpeV0Cbcbja6LbaotUMvBZgP9xw2c37CfVYN09WsEjxIkLBbwIQ==
X-Gm-Message-State: AOJu0Yy+8YI+v/8fvTaNAzEO6Mx5Rh4IOyhGZqP1huZ71GtvOtJ4O+SR
	ozQLNkBIe6q53ycTX4CG58+d0tmUdMT1sPtW//uXPW2kA79JYdh5
X-Google-Smtp-Source: AGHT+IGEiY2JB0qdptuZ7ccCF8KInrVw1xa3h+hNmYB4Kd7mL5BMZwNGp6ps35fhUTL0Ra2SxLpEew==
X-Received: by 2002:a17:906:46ca:b0:a55:36d7:d0ff with SMTP id k10-20020a17090646ca00b00a5536d7d0ffmr3787755ejs.46.1713344728114;
        Wed, 17 Apr 2024 02:05:28 -0700 (PDT)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b00a51a7832a7asm7897814ejb.199.2024.04.17.02.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 02:05:27 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linus.walleij@linaro.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Add a property to turn off the max touch controller if not used 
Date: Wed, 17 Apr 2024 11:05:23 +0200
Message-Id: <20240417090527.15357-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our hardware has a shared regulator that powers various peripherals such
as the display, touch, USB hub, etc. Since the Maxtouch controller
doesn't currently allow it to be turned off, this regulator has to stay
on when not used. This increases the overall power consumption. In order
to turn off the controller when the system does not use it, this series
adds a device tree property to the maxtouch driver that allows the
controller to be turned off completely and ensurs that it can resume
from the power off state.

Changes since v3:
- Move the power on part to mxt_start and the power off part to
  mxt_stop. This allows to turn the touch controller off even when not
  in use and not only when being suspended (Dmitry)

Changes since v2:
- Add Reviewed-by tags from Linus and Krzysztof to the dt-bindings patch

Changes since v1:
- Rename the property and change the description (Krzysztof, Linus,
Dmitry, Conor)

Stefan Eichenberger (4):
  Input: atmel_mxt_ts - add power off and power on functions
  Input: atmel_mxt_ts - move calls to register the input device to
    separate function
  dt-bindings: input: atmel,maxtouch: add poweroff-sleep property
  Input: atmel_mxt_ts - add support for poweroff-sleep

 .../bindings/input/atmel,maxtouch.yaml        |   6 +
 drivers/input/touchscreen/atmel_mxt_ts.c      | 162 +++++++++++++-----
 2 files changed, 124 insertions(+), 44 deletions(-)

-- 
2.40.1


