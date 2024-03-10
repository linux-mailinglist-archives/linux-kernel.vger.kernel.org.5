Return-Path: <linux-kernel+bounces-98113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B92877548
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FE91C21236
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 04:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F42EEAB;
	Sun, 10 Mar 2024 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdduhlcN"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF37FE;
	Sun, 10 Mar 2024 04:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710046334; cv=none; b=Bo2b1jIESXZVeqfruewIdEzUmOpWbyLkcRy94M4A4QbrNWe49f6i/Pz77uDy1p2IIIHYssI764Esky70KchewTAwjlorOONhDd9v8Wr5+qAGKoEpuu0SjVjalCkEjDA/Of7mnDwNIEq2gaY9+mxGwtk7lMhM1MQMlOsahpnMEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710046334; c=relaxed/simple;
	bh=rnZBnPJXAGMiv3hAs+IMwlsVDiOimgyYd0AQtEQwYQ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rhrR5HHIk6NP/QUr0N2fSh80xN1WqN33tFbjkrGiamc9eOVt60NEGDDIAhBm/vrY8s5Znm8BGfnX3HnvzDKrDMiZVaWajVHFqZEpFqAWeq5g34/6NkV/pfppYph9/3WANKBxtT1JjLjgFF1MP1lhLCFpVxvsmxyPqb69QiRgGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdduhlcN; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22181888b88so2601276fac.1;
        Sat, 09 Mar 2024 20:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710046331; x=1710651131; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e39ug9A3ukLDXoGd4+CBUyAmYkxnieiDNoXwF240hBs=;
        b=hdduhlcNU3FvE0K+wqFCSdNRdQ5wpzP4hFAs3cZOe7ziXhE0pYoWKl+EK5il6d+z+j
         z1s6yPOPj/+US8u6QqIlCMAVs2npNFa1MBpK2CEf2abUKgFzpJclYiXvp777kHQCvxUp
         vkpw2mzQKjFQeZlGcHFOYfwJhVL8Q3i0r+AcZ1HqnlX8ldJafC8IyVTcGH4Vs1r3ka5v
         ihT6NH1w8Be6c78KiTVvQUXTT0JTvLeulGyFki3dwtEerOE+DyBzVL+ZEmt0Ecj36/gB
         z9nSsmWvGu+N9OXVir0bNYiI1t9BLdlLXOsdyhowqL+Cc0Opfm/OvZFJ7C3Ow3UqwsDy
         dByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710046331; x=1710651131;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e39ug9A3ukLDXoGd4+CBUyAmYkxnieiDNoXwF240hBs=;
        b=gnTNLKoWMbGGT+y1dWcYD5Wx/Z/q+i/V4oPgIgQFCv/EAfC6D4TCRKPlH/nuDVG7EV
         N5Q/ThUXygpO/nfnBtoisqT6FvrnqdUPPc0QZKabeuEGv/NyB35YCMPzePUNGcVfNm1x
         O9uTOCk892VzIk1u7xgAsCMWZxURyhOV1OuZxmTXXXbZtKbV6yYbjz5VSZ5HXuA7SoHg
         WePKehVblnBa6vND2HJU1YvgFrlwruBlbXFdjxOCG2PPVCR6RufsiEw0IkAFBnpEMbqj
         WR7FwswtTPjCfXWU45mT3R12V2Bk/lKQ8opw+ZSYbQSH3U1/ZIlCnNYN5cXwETHnDesN
         Prag==
X-Forwarded-Encrypted: i=1; AJvYcCXEDtYBHX6OHehgl+Wdwfwq0wYrZMmCoyLTdIb2xN0owAFfN8Pc8NZfiLQd6jQTHy/VK7nvPeWCsBHLIhXplLt2qv2kZRG6RMkZ1/ZQexqhtyLv1mO7VhwH5E1oijEtlU8S/6n19OBdkg==
X-Gm-Message-State: AOJu0YyQV1nRLoY6D1k/9pdaYNyG7KV5QeKfMHzYc4zaDVtEGvkT6vKw
	8BSyXq3+HaF+Ftno9Oa4NTp+zvAx+W3G7y1Hx3Ek7U0pDsGgTKUu
X-Google-Smtp-Source: AGHT+IH5LLU/u/cQ7yF6/mCXiOI4Ui0zwopOeA4lWCTqcZf2+jyBLCPeco+OEP2URzT0XSiiuBRP9w==
X-Received: by 2002:a05:6870:a709:b0:221:c58f:a8b with SMTP id g9-20020a056870a70900b00221c58f0a8bmr2718734oam.17.1710046331584;
        Sat, 09 Mar 2024 20:52:11 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id e11-20020a63e00b000000b005dc48e56191sm1984659pgh.11.2024.03.09.20.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 20:52:10 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next 0/4] net: dsa: realtek: fix LED support for
 rtl8366
Date: Sun, 10 Mar 2024 01:51:57 -0300
Message-Id: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG087WUC/x3MSwqAMAxF0a1Ixga0fkC3Ig6CPjUoVdoiBXHvF
 odncO9DHk7hqc8ecrjV62kTyjyjaRO7gnVOJlOYujClYQc5AnY+MLO0bSOoOummhlJxOSwa/9t
 AFoEtYqDxfT/HorxUZwAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, devicetree@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2258; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=rnZBnPJXAGMiv3hAs+IMwlsVDiOimgyYd0AQtEQwYQ0=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBl7Tx2bRUkh1Rqj+L30uudk4LMjxkBp5s6EgSZC
 G1b0eljfMaJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZe08dgAKCRC7Edu60Qc7
 VvcqCACbcZpA9vlXsdmIQnr2ellxRNzxmSYnz0WXfwE38MzGfGB+JnzlnUZ0OIHbEfj0mDJX8EI
 PVCDmrM2y04jYTcEeoazXZXiRgP72LHf1ZrjUktoBc2c4upAMBby33kFnBV4n446swJhxNyBN82
 9sCL01ZIRZ/tb+cAq7iBX2Y12a21z7x95uQko48Xc3H+Vgm7hly2h1dstRH4d0QhuUJlQ7jVhhA
 X37PnX1tADgfePyc/SztGh/YwzCNqmJPIYYAdZy0Hy+ROL3be3RxNwoCUS41XHNxh/1h0ZznQNe
 SuRuHZ7kKUx6NooS2MUcXxSATE2ophEi6xsmwgDThb1Jjq+j
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

This series fixes the LED support for rtl8366. The existing code was not
tested in a device with switch LEDs and it was using a flawed logic.

The driver now keeps the default LED configuration if nothing requests a
different behavior. This may be enough for most devices. This can be
achieved either by omitting the LED from the device-tree or configuring
all LEDs in a group with the default state set to "keep".

The hardware trigger for LEDs in Realtek switches is shared among all
LEDs in a group. This behavior doesn't align well with the Linux LED
API, which controls LEDs individually. Once the OS changes the
brightness of a LED in a group still triggered by the hardware, the
entire group switches to software-controlled LEDs. This shared behavior
also prevents offloading the trigger to the hardware as it would require
an orchestration between LEDs in a group, not currently present in the
LED API.

The assertion of device hardware reset during driver removal was removed
because it was causing an issue with the LED release code. Devres
devices are released after the driver's removal is executed. Asserting
the reset at that point was causing timeout errors during LED release
when it attempted to turn off the LED.
 

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
Changes in v1:
- Rebased on new relatek DSA drivers
- Improved commit messages
- Added commit to remove the reset assert during .remove
- Link to RFC: https://lore.kernel.org/r/20240106184651.3665-1-luizluca@gmail.com

---
Luiz Angelo Daros de Luca (4):
      dt-bindings: net: dsa: realtek: describe LED usage
      net: dsa: realtek: keep default LED state in rtl8366rb
      net: dsa: realtek: do not assert reset on remove
      net: dsa: realtek: add LED drivers for rtl8366rb

 .../devicetree/bindings/net/dsa/realtek.yaml       |  46 +++
 drivers/net/dsa/realtek/rtl8366rb.c                | 341 ++++++++++++++++-----
 drivers/net/dsa/realtek/rtl83xx.c                  |   7 +-
 3 files changed, 306 insertions(+), 88 deletions(-)
---
base-commit: d7e14e534493328cc5f67baaff2b0c23d32b0a57
change-id: 20240212-realtek-led-a665ae39a9c5

Best regards,
-- 
Luiz Angelo Daros de Luca <luizluca@gmail.com>


