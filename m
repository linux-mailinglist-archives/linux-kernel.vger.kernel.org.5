Return-Path: <linux-kernel+bounces-161454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEC28B4C2C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744412819E7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B7E1BC40;
	Sun, 28 Apr 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld4cb47W"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C9115CB;
	Sun, 28 Apr 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714314703; cv=none; b=AiKahFsa3HYOpcdcLyjqaMoHcExphKCK+ij4H1+y9uvzTTL2X3iyeWZAKeLzxAsc2jHWQY8JK/NKNSHWj0yiqsuNVGxVVQiWVDbDAfMG0RHyIBWP//iH81t07p24/UUWAbn2acBsWVY+18PDIZMrTKw6z1UpUvu8UQB70Radpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714314703; c=relaxed/simple;
	bh=RyHWL+XRGVS0rZg5h5NCb1i3rPQiPd34sfifnrFYfOg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=pnn6/vibFqbcp0nwIeHUMsmPzuDr96U55bHnuEb9Q3c1GFsxxP4kozVSVPHW6CzTKoPB3K8tSzfU2jOB3nBMBlIrys4ZDnWM/OgPUc8U9+oYWwj7d5C32QDGgIq1AjQZKTGUGZ/onLhONuE0D28IJvt5tItF/711KBGYXL/cQUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ld4cb47W; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso3446630b3a.1;
        Sun, 28 Apr 2024 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714314701; x=1714919501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=59EuPpmQZ2ij22OGvTjuvfEIHIx/+kEAdk6lJgaolM0=;
        b=ld4cb47WEc5JJoHZt6Nxozx2BXnZptd7ysmgD9HRZ/8VRZ/mZ3wgypSMK3AP1u/wbW
         RmVcwaNQY8HDNbzv9etAhYf+gFzVgxwZhetdWwhw5zzoiM9XHFcO1oRn4UjaxzM0dC0G
         sQNQ3011YHbG33YexhIzahstvDGrj4x1JifsfJami/+4uwKztLjqsL7cFwP+qYqbwPMD
         81SQ6u13U/5ti2Vwfbdcs3rpG1xgO8KNQEPetMTB2+P/JWbfVsXdD0uAUwbJ6ss20dkl
         9VUTma2hVIvZq+X26WS1Xj+aZwtOF6JiBfxVVUufdewzLzZRoU7Ak87FvrMQHd/uQZa8
         7j4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714314701; x=1714919501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59EuPpmQZ2ij22OGvTjuvfEIHIx/+kEAdk6lJgaolM0=;
        b=Smoz/pHL4PgCBEnqOHR132MFSj0gPanq2IXOlr17QqDsRsvXZdXtxxtGdwQBlpwBD2
         ji5DZeulhrxJT88B98NSLM5Dk+39One9Y39gB1P4Wb/zyPoL7E/Q+XiRZMR6CDKtKGB5
         G3AoflzbJzP2SMfXzCVoWf4+m7T814REmHXsLvtp5kk20PqEzAdGrS90S0WU6jzqtcjq
         2SX9u6NjO2xwFbuIIv1c7/vgpgKqA0KzB43CRfgryyO+z/DJFo/ek4wPrwXNllweI0H3
         +gJmALmCS7U9rL+ZOb+e4ga6KP7KePgEXf4Zm00dkxZWJHY7KKmaW62nAb9svzKojeoD
         PZXw==
X-Forwarded-Encrypted: i=1; AJvYcCWLDUkpbkXLYQuhAhf+Rn7vqscbczYw/2/F53/hPpKbCrZqBYHDmlRuUIDl9gABcX23Peg5awXR9pElpBq0ryVKI7DuIEx5w1yZflqR7EoAchcqgNM4qHMPCs3bWWdBi1mwEkvtJWLuD6X7nsw=
X-Gm-Message-State: AOJu0Yw/r3OFQoSno4MsaNF2ZvAv1ZK0ZO+m4P1o/exNEyrvo9yl20ub
	eIfJCwPVRLvQ+34c85hp/voqP62JrS0nZEhFH91S2hNfbw4qy54D
X-Google-Smtp-Source: AGHT+IF8P9xi3Y/OKCRwo4517T0rc2kzeu7K9T9yHbVaapsQ6rwWWUZLFHeMRWJrF/Apg+3rTcbhgA==
X-Received: by 2002:a05:6a20:5528:b0:1aa:a421:4239 with SMTP id ko40-20020a056a20552800b001aaa4214239mr6779394pzb.15.1714314700978;
        Sun, 28 Apr 2024 07:31:40 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id h6-20020a636c06000000b00612dc2ec375sm1034834pgc.16.2024.04.28.07.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 07:31:40 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/1] drivers: watchdog: revise watchdog bootstatus
Date: Sun, 28 Apr 2024 22:29:35 +0800
Message-Id: <20240428142937.785925-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. Bit 1 of the status register indicates
on ast2500 if the boot was from the second boot source.
It does not indicate that the most recent reset was triggered by
the watchdog. The code should just be changed to set WDIOF_CARDRESET
if bit 0 of the status register is set. However, this bit can be clear when
watchdog register 0x0c bit1(Reset System after timeout) is enabled.
Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRESET
in ast2600 SCU74 or ast2400/ast2500 SCU3C.

Change Log:

v7 -> v8
   - Simplify the code.

v6 -> v7
   - To use syscon_regmap_lookup_by_compatibleys to get scu base
   - Power on reset is set when triggered by AC or SRSRST.
     Thereforce, we clear flag to ensure next boot cause is a real watchdog case.
     We use the external reset flag to determine
     if it is an external reset or card reset.

v5 -> v6
  - Fixed missing WDT_TIMEOUT_STATUS_EVENT.

v4 -> v5
  - Revert indentation.

v3 -> v4
  - Add error handling for syscon_regmap_lookup_by_phandle and
  regmap_read.

v2 -> v3
  - Fixed WDIOF_CARDRESET status bit check and added support
  for WDIOF_EXTERN1 on ast2500 and ast2600.

v1 -> v2
  - Add comment and support WDIOF_CARDRESET in ast2600

v1
  - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
---

 drivers/watchdog/aspeed_wdt.c | 109 ++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 6 deletions(-)

-- 
2.25.1


