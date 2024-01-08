Return-Path: <linux-kernel+bounces-19418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55F4826CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C1E1C21956
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1D614A9F;
	Mon,  8 Jan 2024 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpB9BKZk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6B1429B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557c46872d3so366267a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 03:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704713158; x=1705317958; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RO7JSB3/Xq9PGPLwpAVAxp7jWLegIWH0CnFSRPnQ6/o=;
        b=mpB9BKZk+7G9XHnt6vlaC38//eojmTQ13buhaDhbYpSpNi9nYjA9WWjzCWz1fwjaIB
         mJ3++m10DQFNUbijPDubqcH0sA96+U7sGGld3xCK6vZz96bro+T4lr8MFeVk5LilKaRx
         JDyqbDcdqIiWildLKdOrgYEsiTqVyKBbhjSM4ibrt2sKvnHIr9PY4v+7WkCPv5wKBmMZ
         dwXUSSzRWeBtcJlVYrGAqWk9fW247zR1waODOLii2KxLm/F0dHBha6LCOvI8PvbjToM0
         BoDgtf0EKFhpD2ZxNwd0e9PFgy2y0nPcpZ1uPy7FOMIv0HmWSWVAjByDO29GzNs9KUTv
         XBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704713158; x=1705317958;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RO7JSB3/Xq9PGPLwpAVAxp7jWLegIWH0CnFSRPnQ6/o=;
        b=JMRjb4JP6iUVQKo7mxCyyFYgZL1+4ThYyt0EsI4vRCfLGcKdyjDtayqNn6la+EdYOV
         b0PwDLG6MmtQ+iY5DX1UCzAy6ID69DL2AcIegWr0ep9BLzgXNugJmAR/UvDtvECbc4zB
         Vj1ZjIpm66t+6+UyaFCc08H16IV3xhdz5hYkszBorxKjFcOav/1Vw4OWBx5BRfowHMgJ
         nbO7HO2GvNwU8v5HysD6sBrb3TMbfWH3PRXpDQJA8+AbehXPQ9pwkfIllqyWapVyawBv
         pYCJTA9Qj5CsvslfNRv5eob0XbXGSxI2x+JHLHeb/CoEjQJbKpId3USovkBrCkOJdjje
         YMpg==
X-Gm-Message-State: AOJu0YyHaBhkqD8kuzGn2cWf9q5GuD52pxELvy3gwthqi1ikW96soLRn
	5iUyTAIoZ7ufGWsbzfDiiMtjxniOm90=
X-Google-Smtp-Source: AGHT+IFD5OdxipsBj9n31IIhAi0XoHoIXgM1ccQefFGex6bH4alegnlvuwz3ymxqwv52q1SxkF4W6A==
X-Received: by 2002:a50:d742:0:b0:554:79d1:d9dc with SMTP id i2-20020a50d742000000b0055479d1d9dcmr2384747edj.69.1704713158042;
        Mon, 08 Jan 2024 03:25:58 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id n19-20020aa7c453000000b005550844cd1dsm4190179edr.30.2024.01.08.03.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:25:57 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 12:25:55 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL] x86/core changes for v6.8
Message-ID: <ZZvbw0RICmvVvGtP@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2024-01-08

   # HEAD: edc8fc01f608108b0b7580cb2c29dfb5135e5f0e x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram

x86/core changes for v6.8:

 - Fix possible unintended timer delays caused by a race in
   mwait_idle_with_hints().

 - Add comments about the magic behind the shadow STI
   before MWAIT in __sti_mwait().

 Thanks,

	Ingo

------------------>
Frederic Weisbecker (1):
      x86: Add a comment about the "magic" behind shadow sti before mwait

Peter Zijlstra (1):
      x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram


 arch/x86/include/asm/mwait.h | 20 ++++++++++++++++++--
 drivers/idle/intel_idle.c    | 19 +++++++------------
 2 files changed, 25 insertions(+), 14 deletions(-)

