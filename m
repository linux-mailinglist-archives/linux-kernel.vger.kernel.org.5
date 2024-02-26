Return-Path: <linux-kernel+bounces-81226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 374DF867245
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685FD1C25285
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268BD20DE5;
	Mon, 26 Feb 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgAUKIdo"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625731BF28;
	Mon, 26 Feb 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944874; cv=none; b=dOMfxemERjx4qtx+7r7b8ERXXurEFWQ0tcyxb2WTeKou+WhUFtxh3cZQmKK+8SPL5UsnWtTJm4ReuW9mf947wkqsnP9QaTHORIJIAXd9I1kTWksHdITLoQ4013gsjs9EEU3e8EvZhZPUScsi+Z8v50rOYQAxuu/lYHrZKrSXi8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944874; c=relaxed/simple;
	bh=6SCmyOJPuFJZyFUt0o8qqfRRoIIzi/k6DEnO/K7o4Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JDIeQPvtu++HB1OiZJTlKwVoLryifeM3JFN6otyj5v9I9/HmsempR8Gx+pqTdqtauS+9IA72pbyzKAMDsPisy872HsMRUPmi7NH4jtjX0vKkn8v1cb2WbNLNZccoEtBCB3cahg2DfA4PWIM4suMncpQYYcws36M7ssq8mpC8hRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgAUKIdo; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d29111272eso2518081fa.0;
        Mon, 26 Feb 2024 02:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708944870; x=1709549670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1W5kmNMiDZm/lE4t2XFLv0Kqr9pksGJeyoNuaP9sm74=;
        b=jgAUKIdoeD/Vv8bDwHzUhUVUBeFUiGOCUlQD6uw8f8pR2twL5SpW98vl47dWThD97c
         QzqE/Ng+jGAzM2k9VXx9l31M1dbSPthC672IYuVr3jON0ZUDjRLafkWiAb42ZHLJZzUq
         NeSE54QPKfwMka1Y00R5gdlT9wQyhazMiQc1yw6NkpxiJ5qczwB8BdJvODkfINj/Zvq6
         3866lugdH03/ufPdU9TBRjuLrLa0S6q5NAOckGhje6LrAl61ct/5+u7lNgACtIZlMs0X
         lFd0dHp1tC8ACbPXkm7D3B+75jd90n6YHXiDdo+aLzxZqG/CC20RcCpRYIAXEg/CxTmK
         8sLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708944870; x=1709549670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1W5kmNMiDZm/lE4t2XFLv0Kqr9pksGJeyoNuaP9sm74=;
        b=Z4KLuRedpkmncsLdkcbfHY6dLM9qq3tl+RIy421uLDaDpZFJTXbsFRthRUHAWqkz2o
         kP2uUvC+CCcr2rjJZxvWAD/V60HCQ6iBfaPmDLx/Kr73aRl+XaQZIhsPZoYX5MqJYd/b
         azekM59/DzpI/O4cGIB90myhUTRPJXAMpL82arMeU4pajlSPfEpeooEZp9+pye2b+EFF
         inLRjINyZMPQAvmm6AYInpZFxY3A+LA81ut3C1dExPYAp5QJMyd8aEMKxiB3nib1vu2g
         DpbGEFO1PEcQ5nRN3Vd8rChXXV9nSx3Xi+oOqEf1RZfALKHf4xzZtUBMyimoSEJowhfd
         CyOA==
X-Forwarded-Encrypted: i=1; AJvYcCXI/ygAbYC93Hq+pDiaLbORcLRXS8qIEZuCQYrH5pcw9HMoMM0tXYeTItG2r/LQcJu0YTo0MbB2suF93opJAZcnKHJmfH8OluaPVHTCifDctAo+kAq+KWq2D7Qir7sTpTsjO5ncssFNZQ==
X-Gm-Message-State: AOJu0YyuCw7/QxUiVgcbzn9JNlJJ8t4CZAO8c+rUXsQrapCCFZw6fYKc
	Yhfbu7YfrRisPDKzYS2TfrtAeeXAJshjDf4+X/KSX2KGtt/fxxhE7wq2GWs8
X-Google-Smtp-Source: AGHT+IHbiONncUkrJn+4o3oqsBqD5qb2+Lir7SECSi4lXPECTfPVYHcaltuPX7nTs7CHyXx9GMOJsg==
X-Received: by 2002:a05:651c:124b:b0:2d2:5126:5a51 with SMTP id h11-20020a05651c124b00b002d251265a51mr3500492ljh.19.1708944870283;
        Mon, 26 Feb 2024 02:54:30 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t12-20020a2e9c4c000000b002d21f1f1e82sm837149ljj.3.2024.02.26.02.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:54:29 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] MIPS: Fix missing proto and passing arg warnings
Date: Mon, 26 Feb 2024 13:54:20 +0300
Message-ID: <20240226105427.7191-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After getting my local tree rebased onto the kernel 6.8-rc3 the MIPS32
kernel build procedure produced a couple of warnings which I suggest to
fix in the framework of this series.

A first warning is of the "no previous prototype for `<func>`" type. In
particular my arch-specific code has the mips_cm_l2sync_phys_base() method
re-defined, but even though the function is global it' prototype isn't
declared anywhere. Fix that by moving the __mips_cm_l2sync_phys_base()
body to a weak implementation of mips_cm_l2sync_phys_base() and adding the
method prototype declaration to the mips/include/asm/mips-cm.h header
file. For the sake of unification a similar solution was provided for the
mips_cm_phys_base()/__mips_cm_phys_base() couple.

The following text describes the patches which have already merged in at
v1 stage of the patchset (see changelog v2).

One more case of the denoted earlier warning I spotted in the
self-extracting kernel (so called zboot) with the debug printouts enabled.
In particular there are several putc() method re-definitions available in:
arch/mips/boot/compressed/uart-prom.c
arch/mips/boot/compressed/uart-16550.c
arch/mips/boot/compressed/uart-alchemy.c
All of these files lacked the prototype declaration what caused having the
"no previous prototype for ‘putc’" printed on my build with the next
configs enabled:
CONFIG_SYS_SUPPORTS_ZBOOT=y
CONFIG_SYS_SUPPORTS_ZBOOT_UART_PROM=y
CONFIG_ZBOOT_LOAD_ADDRESS=0x85100000
CONFIG_DEBUG_ZBOOT=y

The second warning is of the "passing argument <x> of ‘<func>’ from
incompatible pointer type" type which I discovered in the
drivers/tty/mips_ejtag_fdc.c driver. The problem most likely happened due
to the commit ce7cbd9a6c81 ("tty: mips_ejtag_fdc: use u8 for character
pointers").

That's it for today.) Thanks for review in advance. Any tests are very
welcome.

Link: https://lore.kernel.org/linux-mips/20240215171740.14550-1-fancer.lancer@gmail.com
Changelog v2:
- Drop aleady applied pateches:
  [PATCH 3/4] mips: zboot: Fix "no previous prototype" build warning
  [PATCH 4/4] tty: mips_ejtag_fdc: Fix passing incompatible pointer type warning
- Drop Linux serial mailing list and the respective maintainers from the
  Cc-list.
- Covert the underscored versions of the CM2/L2-sync base address
  getters to being the body of the weakly defined original methods.

Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (2):
  mips: cm: Convert __mips_cm_l2sync_phys_base() to weak function
  mips: cm: Convert __mips_cm_phys_base() to weak function

 arch/mips/include/asm/mips-cm.h | 20 ++++++++++++++++----
 arch/mips/kernel/mips-cm.c      | 10 ++--------
 2 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.43.0


