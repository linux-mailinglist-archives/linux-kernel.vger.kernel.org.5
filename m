Return-Path: <linux-kernel+bounces-18369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EAC825C23
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452E11C21BD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24383609A;
	Fri,  5 Jan 2024 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbRtEuf1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD935F0F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28c183f8205so35825a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 13:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704490297; x=1705095097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3tSCCtKg4tLGAyt7wKuCSJvaiw+wnRuGVc/o8uSv7zQ=;
        b=YbRtEuf1sf/3qzXer2hX8C0YOlf3AUxHAPtBImApsKyWLDrnkayRYVKfmeeVa94hHz
         GNmSPMCQM/z0tfE4IvDWl9a0mj08RzPjoPGCY9i/w6UPbUPrB5FlQxqqWMO2/+SBSXyG
         0h62MagUGqxDnCsrNI5MPepr863ewvg66MVanIIfO+J/7MS6bNssT+bDXy1h+UYOYYeK
         6vhPzZJtC3lciZkuColL1ZGVpiuKtgCW4lUXfB9Px01jL75bGZ53plIDRCshuj1m3sNB
         OK63ZqW8Cd5Gsex6C4UL4YAZvRM0D6I+6hV9Ar+wvm/uecCxzNxv7XMKuHDLh5dTMr0/
         Gxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704490297; x=1705095097;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tSCCtKg4tLGAyt7wKuCSJvaiw+wnRuGVc/o8uSv7zQ=;
        b=jt3S2Tb86AuhZ4fOC9vdL9bDOGZ2yuKTfJG0j4m0IjkUM4nl04x5XlZjHLAynrfPhd
         pHtxE5+vAkW3HBBzLk8H7GZz6bQsyAuW2C1uy/A61HAYZkF+VOVQDV+ZFTGC4GpyfUD3
         GsqiKkGPRHej3vhsg5eCbgLB5l5EdJz8FDjfLnuNRxLTYjasHiyp0GstPah/rDrEjdPP
         FsniedMerosIRhPi9OYAHfU7nbPd29532mtvEONz7BtT0gd2Owfj5MnvgHbJ0XQys2zi
         GJdkRgMcOeoSyG3Hy5UYNYukG19DQGh4BHWcFr4qX+qCEeQW9hvs/9g/JPR2qun8Sl8O
         AAaw==
X-Gm-Message-State: AOJu0Yxloro7Dx4F+MEMifHlMswt3qJ/zLXubMPrVllgzBWFMK4rEWo+
	jZgI0OaYn1mAOAKsLXqzJWCmhHnKAN6wnzbAc6k=
X-Google-Smtp-Source: AGHT+IFoMikayf86jCxDnBuRaHuBHI9tImHPDb7roN2uZ+BIHtOUvjeV9DbekfSPuX/d3S09c20RhwRLO3ce
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a17:90b:3b8e:b0:28d:1c42:4a24 with SMTP id
 pc14-20020a17090b3b8e00b0028d1c424a24mr659pjb.9.1704490296782; Fri, 05 Jan
 2024 13:31:36 -0800 (PST)
Date: Fri, 05 Jan 2024 21:30:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA91mGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQwNT3bzU8tTcxMwc3eTkFJNE05QkcwODFCWg8oKi1LTMCrBR0bG1tQD WdBewWgAAAA==
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704490295; l=754;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=a/fwgzHOstq1uzG74l4oSrzlM8OR+zO1LFFpbm8CjuY=; b=ZpGfXPZ+dkvClc+PwjWLvXzIGOPkgVI+L74+RX6yZh57DYZcpI6HWgRs7/f+vHsBj6KdhkSuQ
 iS9jBp6cd/kACg843svW7LrvUF0xNI3EVuPFl95lgl/LYBQPvNQx0nO
X-Mailer: b4 0.12.4
Message-ID: <20240105-newemail-v1-1-c4e0ba2c7c11@google.com>
Subject: [PATCH] mailmap: Switch email for Tanzir Hasan
From: Tanzir Hasan <tanzirh@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>, 
	Tanzir Hasan <tanzhasanwork@gmail.com>
Content-Type: text/plain; charset="utf-8"

From: Tanzir Hasan <tanzhasanwork@gmail.com>

Access to the tanzirh@google.com email will be revoked upon the end of
the internship.

Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 9a9069235f0d..109c0eca1da5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -639,3 +639,4 @@ Wolfram Sang <wsa@kernel.org> <wsa@the-dreams.de>
 Yakir Yang <kuankuan.y@gmail.com> <ykk@rock-chips.com>
 Yusuke Goda <goda.yusuke@renesas.com>
 Zhu Yanjun <zyjzyj2000@gmail.com> <yanjunz@nvidia.com>
+Tanzir Hasan <tanzhasanwork@gmail.com> <tanzirh@google.com>

---
base-commit: ac865f00af293d081356bec56eea90815094a60e
change-id: 20240105-newemail-ccd4a5db700d

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


