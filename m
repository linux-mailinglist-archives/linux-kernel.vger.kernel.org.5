Return-Path: <linux-kernel+bounces-110925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B04EC8865C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C591C22A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26FBBE4C;
	Fri, 22 Mar 2024 04:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="vefxQOaK"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A723B667
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711081784; cv=none; b=WHIJ1/t17hvTtPhAWQSzDKyA2pZzVqR27B+oa2iBnsPDKQ5z0az793c2jTFYAz2uyK9hbLxyPYDW+HwN7A22EnWPWOsDUQpm/72TQySbgPd4E+Oj2lhnePGF+o/2NYlyfQzzux1Gs9boQreEet3U3OO2QuDAjCvA7Z1eIFVH/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711081784; c=relaxed/simple;
	bh=WKeW5SVx9I/1SNDn8Q631fHcTzsHu6OM+OXFVUe+N8k=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=P2S4NWMOMs/bB7insrGfaJkAIINMYrTXsalE2TCDTUkKvk3aUmJMFCmBMiL/3Mfmy1t0rcwuHBD+/0iMkcT790mM/bWeNO7MOh7Uq4oKMkNMckHHGVZxOG+Jc4PCUDod3c0XNdEkB95CauMb8a6sYGMO1XKM0i/eUkBCkT/Av8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=vefxQOaK; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d46c4e1578so645323e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1711081781; x=1711686581; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dlgOtFf30CJTd4GqEyOuu3ps9l0iPKfFitKCgiV4tFo=;
        b=vefxQOaKIjtGza+m7jt5SXjtRjLS5nCfxreVYVf1R5CNSprn8zDCEetWaHDnEDIil1
         l7VB/YHiva/xPrelVspIJCZTq35bq6exEfmv4rhLjuZWKBcbnbNpjAjEJFZfraWln/UT
         QiYtQcOdOnMHeKcZhThdYBiD602dh7XPBU9DqF/z7DKYoXNerRYFBggnAWtUykeoG3OW
         isnggv9f9AFICcTCAqQgx0/aOO0TkLUI8k9VbyAD84uLdj8bj1kJLnUyBISsuT8TABui
         QO22XNZLXuu1jqsTqhBv9NMpR1mEXdEvoRwnQMOe4ijzVHniA42HhBMbpjrnCLLTouJk
         fypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711081781; x=1711686581;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlgOtFf30CJTd4GqEyOuu3ps9l0iPKfFitKCgiV4tFo=;
        b=E+3U5a4TLn5trXMOhhYSHFBvyBznQNuR48SvtdViuMpRViug/kwnhLj71SflWXKOpf
         y/fwkk278+ksbdjgsoYfqn0ZEHTVU5Pz3dLSYcOphi0WjVmr4zGnaf9pp23lfUvV2zV8
         r4I37ms4OMk8oEGTDOcJiIm1BNWXNkXzEGDObr8kyUfVM8KSHGdtwdpJWi9O8c5+bzOi
         1JU6Qtsww4CKGBoOgvlgKslreDMBY9ur9Qu8MWPPY14SwDIN3Yp7rqFUpxg0Okx/vmjQ
         x7WsBCeA99+TYmxFPvaLnh4mqemNxA5C9cjVQINEhuJUKo7iwwi0RZX9n7cxkTu5QRiC
         8OcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJQ+nGds1ihjXuJq4ft11hlegUpXZufZw3Q3n0CFXQUA8t/8+ECWKKUO9WFhxqxpT6IKsNuq8EICTtP8i2DPfGufa7wnIgf0CuEFfi
X-Gm-Message-State: AOJu0YyLErodqU85vndeWi9L6xl1UnAgQFgIXw5Qbp2KAtGhzeqG3OZO
	BZYC/z4oTzJTumtsEF2GcvY6XLzk9wx5U+Fcb0YZTIF0BMHdypHdELK6S5o4bW5EGMzk5Lm2EEQ
	7
X-Google-Smtp-Source: AGHT+IEQooTC2WRASiCgjiYEC06CcXrIMP8nS2CHcPR5FYbXy6E2EliqFsJ8nbYhCIa2yd4FzRz++Q==
X-Received: by 2002:a05:6122:268d:b0:4d3:4aad:1b9c with SMTP id eh13-20020a056122268d00b004d34aad1b9cmr1599264vkb.0.1711081781063;
        Thu, 21 Mar 2024 21:29:41 -0700 (PDT)
Received: from [192.168.0.51] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id gs6-20020a056214226600b0069160557ec1sm673470qvb.136.2024.03.21.21.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 21:29:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------08m1azXTYLEOxgaXrylsW0kh"
Message-ID: <d84baa5d-a092-3647-8062-ed7081d329d4@draconx.ca>
Date: Fri, 22 Mar 2024 00:29:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, regressions@lists.linux.dev
From: Nick Bowler <nbowler@draconx.ca>
Subject: PROBLEM: Sun Ultra 60 hangs on boot since Linux 6.8

This is a multi-part message in MIME format.
--------------08m1azXTYLEOxgaXrylsW0kh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Linux 6.8 (and 6.8.1) are hanging on boot on my Ultra 60, right after
mounting the root filesystem.  This is a regression from 6.7, which
boots without any such problem.

Everything looks pretty normal, up to:

  [...]
  Run /sbin/init as init process
  INIT:

and the abnormal behaviour is that the boot appears to be stuck at
this point with no further output on the console.

I bisected to this commit:

  commit 45a3a8ef81291b63a2b50a1a145857dd9fc05e89
  Author: Tony Lindgren <tony@atomide.com>
  Date:   Mon Nov 13 10:07:53 2023 +0200
  
      serial: core: Revert checks for tx runtime PM state

Reverting this commit on top of Linux 6.8 is sufficient to get the
system booting again.

The console output related to the serial port (or anything else) does
not appear to be any different on a failing versus working kernel:

  f0061e88: ttyS0 at MMIO 0x1fff1400000 (irq = 7, base_baud = 115200) is a SAB82532 V3.2
  Console: ttyS0 (SAB82532)
  printk: legacy console [ttyS0] enabled
  f0061e88: ttyS1 at MMIO 0x1fff1400040 (irq = 7, base_baud = 115200) is a SAB82532 V3.2
  Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
  serial 0000:00:05.0: enabling device (0000 -> 0001)
  0000:00:05.0: ttyS2 at I/O 0x1fe02010c00 (irq = 17, base_baud = 115200) is a 16550A

In case it helps, I attached the complete console output from a failing
boot (gzipped).

Let me know if you need any more info!

Thanks,
  Nick
--------------08m1azXTYLEOxgaXrylsW0kh
Content-Type: application/gzip; name="console-boot.log.gz"
Content-Disposition: attachment; filename="console-boot.log.gz"
Content-Transfer-Encoding: base64

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

--------------08m1azXTYLEOxgaXrylsW0kh--

