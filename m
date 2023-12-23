Return-Path: <linux-kernel+bounces-10338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966F81D30A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8341F242D0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAADC8BE5;
	Sat, 23 Dec 2023 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWbKmFSR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDD76FB0;
	Sat, 23 Dec 2023 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d2350636d6so2318000b3a.2;
        Fri, 22 Dec 2023 23:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703317698; x=1703922498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U06iT0QzKoxdvh42FREax0PEoODypkUM7QQs1+dJhvI=;
        b=KWbKmFSRHuyXWiHwsQycHmEWSvfN9ufWvN8XLxuO+6LdlPRFJBdZqTg4rVQ013VaUE
         9Hppg1ewfSWJwk8OYZR0Cxv9w0Q56aVXfMJOhhfaXmCScMFL5vjo48oZ18XgGaHlZ3zu
         DW11wyRwadMw9Bu33Tm8KtjL3i73F64w8ShmUy7xhSBDZFJM+LjQzpsOhS/M6L7ZWkjf
         x8dGlbF89yw9kKObUR5WiaqjzUAGTgBdRkeRrqA90Fp45R8YbqwynoR5jPtBSaLXYs7X
         6ghZYjtDmNp31jVO2MGvXsvOw+n050AFxf5OA+yH6GPJE5JyeIzWZrQbl9RR5taMc+5Q
         WFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703317698; x=1703922498;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U06iT0QzKoxdvh42FREax0PEoODypkUM7QQs1+dJhvI=;
        b=lmj+trJIAC6iFqQtGfW3CS2+b8giLLFTz6pWQiG3vR1RCAoY3Cw/5up+UXWdmRmMlE
         0e7aVf8wT+FSWxnWWQ15dhlIG4NHX+xTT0rglfnGsrTS8Tsqfn4x7JTGg0MFcsp+GwIF
         Pf7jonjcY/jACqB2F1MZkBz37fqBSrEoKWqEn1c4HpiCQ2akU+vYVLBmeI7d8QaiAPJ+
         vA6cc1GYySzyM1/plooT6wpythRSlaPYWtzfxR4gAPPOtCnx36xOJwlGRngn23NolHk0
         sw6BJ3XaLcjKlQ/fC3PPlyTIIUstNBNVyJuoxnPkp88oPN3SS4JF3Z+rrfE7veJUEnCg
         Wp7g==
X-Gm-Message-State: AOJu0Yyy0Xxm8unKU8BwaKeB64/wpcLhslN8dP3Tcy0o90GdpU92IJvS
	AfqKrc4N1dC5ou2hDidqEmpxYx7B2vo=
X-Google-Smtp-Source: AGHT+IF6rJ4rk3yzD5l1y1nCrF6oZWxMrA92daejnn4J6NtSo8pTGBH0kJVKCf/eFKOHEAikP6G1fg==
X-Received: by 2002:aa7:838d:0:b0:6d6:aa3d:b44 with SMTP id u13-20020aa7838d000000b006d6aa3d0b44mr2660493pfm.53.1703317697994;
        Fri, 22 Dec 2023 23:48:17 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6810:f806:ab04:8efd])
        by smtp.gmail.com with ESMTPSA id n16-20020aa78a50000000b006cb98a269f1sm1274848pfa.125.2023.12.22.23.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 23:48:17 -0800 (PST)
Date: Fri, 22 Dec 2023 23:48:14 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.7-rc6
Message-ID: <ZYaQvgIr99ixMKBS@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.7-rc6

to receive updates for the input subsystem. You will get:

- a quirk to AT keyboard driver to skip issuing "GET ID" command when 8042
  is in translated mode and the device is a laptop/portable, because the
  "GET ID" command makes a bunch of recent laptops unhappy

- a quirk to i8042 to disable multiplexed mode on Acer P459-G2-M which
  causes issues on resume

- psmouse will activate native RMI4 protocol support for touchpad on
  ThinkPad L14 G1

- addition of Razer Wolverine V2 ID to xpad gamepad driver

- mapping for airplane mode button in soc_button_array driver for TUXEDO
  laptops

- improved error handling in ipaq-micro-keys driver

- amimouse being prepared for platform remove callback returning void

Changelog:
---------

Christoffer Sandberg (1):
      Input: soc_button_array - add mapping for airplane mode button

Esther Shimanovich (1):
      Input: i8042 - add nomux quirk for Acer P459-G2-M

Hans de Goede (1):
      Input: atkbd - skip ATKBD_CMD_GETID in translated mode

Haoran Liu (1):
      Input: ipaq-micro-keys - add error handling for devm_kmemdup

José Pekkarinen (1):
      Input: psmouse - enable Synaptics InterTouch for ThinkPad L14 G1

Luca Weiss (1):
      Input: xpad - add Razer Wolverine V2 support

Uwe Kleine-König (1):
      Input: amimouse - convert to platform remove callback returning void

Diffstat:
--------

 drivers/input/joystick/xpad.c            |  1 +
 drivers/input/keyboard/atkbd.c           | 46 +++++++++++++++++++++++++++++---
 drivers/input/keyboard/ipaq-micro-keys.c |  3 +++
 drivers/input/misc/soc_button_array.c    |  5 ++++
 drivers/input/mouse/amimouse.c           |  5 ++--
 drivers/input/mouse/synaptics.c          |  1 +
 drivers/input/serio/i8042-acpipnpio.h    |  8 ++++++
 7 files changed, 62 insertions(+), 7 deletions(-)

Thanks.


-- 
Dmitry

