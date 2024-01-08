Return-Path: <linux-kernel+bounces-19301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7113B826B17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FC72828E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF2012B98;
	Mon,  8 Jan 2024 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9mhllVt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FDD12B84
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e43e4890cso12471315e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704707483; x=1705312283; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8RkRozTY1veR0tBHYBI23lEvIQeGjftu+YjSb+RyP1g=;
        b=D9mhllVtOlYfDf7M49nMV71n/TkUpabEmbxAroLQkrzbXsAf1PfCa1k5vISec9ZNDT
         +p1fHJaznT+eTR4TC2V0aURC6V6OYz8iMGSt9hiVwzXJ25gexnO/v6EFjHJQ5qj5s9aM
         Ea9D+fbrpSLCcnPDvLY438fM1vQ9m/tDotZQXMFdmR5Ts/9cZjFks4TDAoP0lORd2sib
         vWXxirt0TQJfYh1U6LdmhgxiAPTFsYonTahchhaMlmNAZIZMcqzzZ1Ymiqy6mpzJB7ob
         CXVbmDG7uSVFekiSU+JB6cl869ovybV6ZflJAecEEShwcbY3o9VCnEpVqg0yyXhWo8QA
         7Y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704707483; x=1705312283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RkRozTY1veR0tBHYBI23lEvIQeGjftu+YjSb+RyP1g=;
        b=YFaOAIS/RurllMyydTqaRZDcZ6YOSMlQBmQvBY5FPT/oEYy5npLjm1SDuJKI0iwIgo
         Iuck6cc8LSlqM+Qd2e0e9vRO0QZnIbUteeIBWmfFr1xlm+p8z/Cn6477U97TjCLfVMWe
         6Fzr8stM78oW8eVHeF5EQrz/AoSmlnQbc8Ncy2ApZXXX8wMo2lRe0RRzUTM5kCgynf5t
         7E+YJxqgjOr+37t8E0M6l3nb6dL6pI57SDjHAXVtLA2QE4k5CSvFkoHhEabgaOuwDqNL
         oziLPcRdGXwwEa9O1Dv+u0RvJJ2lwySabX8YkYuDDXpD1VtyrDTylhNm5mpoMYKQPjqQ
         eJnA==
X-Gm-Message-State: AOJu0Yxsy07ts6jx1ULWUNGn9ZSVdmGtKq+5XcrOGE3Y128LRVz1zbiB
	Hkf26a69C61GiNx67u/K2FQ=
X-Google-Smtp-Source: AGHT+IGQwI0zsMhwz6cEoKtLClqOM9M44TCPTCw5O7F5SuepIJbz23+NhjXkBt93aLjCrVIgocy4Iw==
X-Received: by 2002:a05:600c:2241:b0:40e:437c:7db2 with SMTP id a1-20020a05600c224100b0040e437c7db2mr759146wmm.211.1704707483402;
        Mon, 08 Jan 2024 01:51:23 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5948000000b00336898daceasm7341388wri.96.2024.01.08.01.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:51:22 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 10:51:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: [GIT PULL] Generic syscall entry code changes for v6.8
Message-ID: <ZZvFimN17XOmnb1c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest core/entry git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2024-01-08

   # HEAD: 221a164035fd8b554a44bd7c4bf8e7715a497561 entry: Move syscall_enter_from_user_mode() to header file

Move various entry functions from kernel/entry/common.c to <linux/entry-common.h>,
and always-inline them, to improve syscall entry performance on s390 by ~11%.

 Thanks,

	Ingo

------------------>
Sven Schnelle (3):
      entry: Move exit to usermode functions to header file
      entry: Move enter_from_user_mode() to header file
      entry: Move syscall_enter_from_user_mode() to header file


 include/linux/entry-common.h |  95 +++++++++++++++++++++++++++++++++++--
 kernel/entry/common.c        | 108 +++++--------------------------------------
 2 files changed, 103 insertions(+), 100 deletions(-)

