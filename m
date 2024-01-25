Return-Path: <linux-kernel+bounces-39354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B491A83CF50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A9128F862
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2927613B790;
	Thu, 25 Jan 2024 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="AGnJnqfL"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB164130E52;
	Thu, 25 Jan 2024 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221696; cv=none; b=JvIwLETK6gFJSiAvW1ZP5c/lzOBF3uNp9Ud6bgIm5sEsuUJ6N/12CfF7KsDEMQ6cV5CpVcmB66xW1kNAxUfz8JKNov9+D3PJji+dxptBNhX7pLJODi96DqELdz8CQAVyqOr7/Itks24YT9BEXgLkFSZ0SagPFkwaQnD1Q32j0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221696; c=relaxed/simple;
	bh=8Fg5wzV/zWi3X3/7QI+GDnnFrxDg8S26sTMGICYZLxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X16uXVIf9izzErgAwqQUGW5LwRkB9unavFC3Etn62/5xsEughJVtwlSqi8/6j2O173F+Q8cQIAcdPOaNo5mjc7Rv3tHD2PPqfQ3KnLFy+B6V0l89XxzYuOXl9OTwwL9g6NxA8rzZy195wigsaB/GeSjgpSTgI1p04+1wX17weGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=AGnJnqfL reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21481a3de56so1923934fac.2;
        Thu, 25 Jan 2024 14:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706221693; x=1706826493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCBEPBMWeoB0j3nSR/jMBslDMArDbAfdSvio61olzTA=;
        b=T7JW9aZbEA8/ecHOZElb7UBGQh6bFiqXEx2aMg9s/OLjpf1dWX3LhqjbGQwSDwyrH8
         Q1XkTN/ko78itTO+KqTTjZLf3q1Ym7hVnxxhavV3yozauxkHa8SheJtkLCGn9H3Vm+/r
         2aSsQDuDrFEsKp2iF+mSJGxpDFv7tPWn15euUWiBh21Ep1tu1gqyPlgph7XL51AAPk5C
         eDw3WL0+GzFFYX2SkentZ7NAxNmMrK9KilLIRzBi1GTEwMp8oEx3w0f3TVAtJHVqX32M
         cY9UiIWR16zMDSvWgKGPEV0bG07LhgISfqNh/cfBDQKIhir1xuABDoBSmSJNuEqm3Ini
         eN2w==
X-Gm-Message-State: AOJu0YzyZFhUdn3Wcgkrztg3PfmcfPacSQePphz3n1H1yspoankkaO/6
	WdlcQ33jgDwRwj0YdNMXPrYb8G3fjVS6oxwCUfZOO/h7ph4KjUYNcrbljAajWCn3Eg==
X-Google-Smtp-Source: AGHT+IF4qBxUIhsYywPcLzbdW7m6jMldIetTOju8HNk2XHw5jsToO75OY7FZwm9WPxxrgkrLnqTfYw==
X-Received: by 2002:a05:6870:3323:b0:214:837f:dc with SMTP id x35-20020a056870332300b00214837f00dcmr409077oae.93.1706221693722;
        Thu, 25 Jan 2024 14:28:13 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id f11-20020a63f74b000000b005cd821a01d4sm14002272pgk.28.2024.01.25.14.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:28:13 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706221691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wCBEPBMWeoB0j3nSR/jMBslDMArDbAfdSvio61olzTA=;
	b=AGnJnqfLLiG2/EahRorCHFwJDmBV6JZF7uwTBllKlPoq3BtwWe2ngomH/BSIC06j1Sejau
	yNYSGu5u8CH67Kc6ZWpUX2i+6JH3UC/MPxDW1Lxb63KMkUhWGBHjHM/p2jB7bkZYUnaq7w
	SMW9k8Aqhyz6dJBqCmm1q4qa8tiNeHmg4W5CBRCQeDpRZb5MI08yovzANxWaj5iLpemPDC
	idIPLyRoLP50aoFQxk8jPiuoyAsUXvR/+T+c67MQeWCHGkxPNVBkwQarVoJItTBHxJ1ngM
	Zkff8SydUH8PJyOjF/9pMZ7lCFG/iUzgFdWfHxX9Bq5gTeL0KvK1xlDuUNCWJg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] tracing: add trace_seq_reset function
Date: Thu, 25 Jan 2024 19:28:15 -0300
Message-ID: <20240125222818.7425-1-ricardo@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a prerequisite for a later effort of making trace_seq more
flexible about its buffer size. To achieve that, initializing and resetting
the buffers need to be differentiated.

Changes in v3:
- Reordered commits so it doesn't produce a failing build in-between.
- Improved changelogs.

Changes in v2:
- Added a WARN_ON_ONCE to __trace_seq_init to catch possible misuses.
- Properly initialized trace_seq buffers.

Ricardo B. Marliere (3):
  tracing: initialize trace_seq buffers
  tracing: add trace_seq_reset function
  tracing: convert __trace_seq_init to use WARN_ON_ONCE

 include/linux/trace_seq.h    | 11 +++++++++++
 include/trace/trace_events.h |  2 +-
 kernel/trace/trace.c         | 24 +++++++++++++++++++-----
 kernel/trace/trace_output.c  |  2 +-
 kernel/trace/trace_seq.c     |  4 ++--
 5 files changed, 34 insertions(+), 9 deletions(-)

-- 
2.43.0


