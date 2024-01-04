Return-Path: <linux-kernel+bounces-17234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216AE824A3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20781F24C7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160CF2C842;
	Thu,  4 Jan 2024 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hqoqay1H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064442C6B2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e744f7ca3bso15205177b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 13:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704403476; x=1705008276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=onZJJ0p7bA1O18bnzOb7QEzuO2YArUzN5u9fFaWOrIg=;
        b=Hqoqay1HIT5WOZo2whBFWAyj2Pa3m+0EoqzKCYRx+f21h/P7/EQux97ivA27UeIhWi
         0rLU0hmxxCgNffAD7MAj+K3/xmjD4o7ibCn+Dr/eK3FUjxaooojhH/WdBHPzJks0sPu1
         7QSSc6or9JXBat2wsk8p+2tOyE+8ux1rp4t27D/SUygwYHo3H2uj83XGp+2ozGij1ZBJ
         qPTMl64EhXDErdRBdRAD/zf0jUHzZ5T+4/OKPcmSDmhXPmwdc1mQcuO226q61S7Tx6lh
         lENTohR4ZmDJrUANSyEFYkVnI55/BwJB3nhTAU0po9h1myX0VpCJS/LURoKRzxhzJ5DD
         qQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403476; x=1705008276;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=onZJJ0p7bA1O18bnzOb7QEzuO2YArUzN5u9fFaWOrIg=;
        b=CT4NRqg9m5as8h1vcKxHk3OBg+Ps4Y4gKTonyv05zzqxghP4E88wxABwQkNjzXI41Y
         lkoppC5h/wJ7r59WPpd23KkiPrmSMWXaT0p2ReCn9cx954X1CAJkQ/iUUcnE1HOI6cJH
         NB5isMm2T6/RhhnDtPBBO+dnVCgfvtlAH2iCGtyGt1jjLOvFBUUXBLOY37SKL1F4NV2Z
         PmCQlT8iRazRmGYG/B+hKsy9fasYchT8NS+QZyZ1OksC9j750bj5l06+3Mkw3WWs4lmn
         TsEvYyMbG33qfMGUvr3SxTpTFKPUtLMgRDlIxtHH4AWn9kFBFZiKumGIFcBGI9IOai36
         /JnQ==
X-Gm-Message-State: AOJu0YzWFF/UcHnaFy1xOgSFNJ5UTQDXx8/2Bp2F8QuUq6V7taFjwHiC
	1IQ1L3MByNIzH+N2SYJE4Ox+s8af7u0pYFD5liQ=
X-Google-Smtp-Source: AGHT+IESqMAgsrfrSy70rvzKsqlSxftHc2rbuuCAnnkSXGk0yOPCxr6StcAQ6Ugfo71RUtIAFPEgeAFMdEJM
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a05:690c:3692:b0:5e7:1536:f4b3 with SMTP
 id fu18-20020a05690c369200b005e71536f4b3mr484304ywb.9.1704403475921; Thu, 04
 Jan 2024 13:24:35 -0800 (PST)
Date: Thu,  4 Jan 2024 13:24:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.195.gebba966016-goog
Message-ID: <20240104212431.3275688-1-maheshb@google.com>
Subject: [PATCHv3 net-next 0/3] add ptp_gettimex64any() API
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>, Richard Cochran <richardcochran@gmail.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

Applications that are very sensitive to time precision
always measure the latency of the PHC (hardware clock) read.
The best suited API for this is getcrosststamp(), however,
not all platforms can architecturally support it, hence
sandwich-ts APIs become more important for these categories
of applications.  The purpose of the sandwich API is to
measure the width of the PHC-read syscall. The current API
that reads PHC supports only one timebase for it (CLOCK_REALTIME).
CLOCK_REALTIME is disciplined by NTP or NTP-like service,
and hence the value is subject to change. This makes some
applications want the sandwich TS to be delivered in other
timebases.

Ideally, there should be only one API that delivers the
PHC-read with the sandwich-TS of the timebase given by the
user, but modifying the existing API (gettimex64) would
break compatibility.

This series implements an API similar to gettimex64() with
a parameter that allows the user to choose the timebase
needed for these sandwich timestamps.

About the name: This is a superset of the current gettimex64().
Since the timebase for gettimex64 is fixed and is only
sys-time (CLOCK_REALTIME), I'm appending 'any' to add the
choice factor. So gettimex64any() would give you eXtended
time with sandwich TS of a timebase of your choice. If there
is a better name, I won't mind changing.

The timebase options are:
   CLOCK_REALTIME, CLOCK_MONOTONIC, and CLOCK_MONOTONIC_RAW

The CLOCK_REALTIME option is equivalent to using the current
gettimex64() method.

The first patch adds this new PTP method, while the second
patch adds the ioctl support for this PTP method. The last
patch in the series updates the selftest to exercise this
new API.

Mahesh Bandewar (3):
  ptp: add new method ptp_gettimex64any()
  ptp: add ioctl interface for ptp_gettimex64any()
  selftest/ptp: extend test to include ptp_gettimex64any()

 drivers/ptp/ptp_chardev.c             | 37 +++++++++++
 include/linux/ptp_clock_kernel.h      | 50 +++++++++++++-
 include/uapi/linux/ptp_clock.h        | 14 ++++
 tools/testing/selftests/ptp/testptp.c | 96 ++++++++++++++++++++++++++-
 4 files changed, 193 insertions(+), 4 deletions(-)

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: Richard Cochran <richardcochran@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: John Stultz <jstultz@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: "Willem de Bruijn" <willemb@google.com>
CC: netdev@vger.kernel.org
-- 
2.43.0.195.gebba966016-goog


