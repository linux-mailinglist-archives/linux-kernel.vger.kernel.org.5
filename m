Return-Path: <linux-kernel+bounces-19439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBAB826CEA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E588281B71
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA472941F;
	Mon,  8 Jan 2024 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQgPv8Iu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A22F29410
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d4f5d902dso19047905e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 03:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704713703; x=1705318503; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CCbzvMSP53KUgOmOhE8yp5XexmFsT2hAeja2IF/7EwY=;
        b=AQgPv8Iurut33ukpgk4muR7nys4MqP0o2zCMRdjSh4OSEw+/Olt4j/WmOW1yTZUxJL
         sLVY8qokY8+S+DJmWa+ItXUp/Uyf6qxDxvWrgheRkJ55wGv2mLwcypvF3j08ofwe0TUF
         Kvg/TjhH/PTDJQtxcgRI9fusgipG0LdclJbn641i+TYziGS/c/bBEyPfSPFXPQLWW9Ga
         FebgYfq2o0gPvNb4e3YTQbDXshNHYGFcO5Z2xTH5LbcndwnRy6aMvSzBMMy7NYYg0DWw
         u8xsvoobCn1qCd7DWJDqWBLVpQ4J/NkqIesO0osGu4tdk2ytKGsJ+LwmfnRUnKYpyTuf
         rY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704713703; x=1705318503;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCbzvMSP53KUgOmOhE8yp5XexmFsT2hAeja2IF/7EwY=;
        b=PVQlZwBnTgtEDG1qJcrnGkxaY5AA4M0irJpTeYSlRMJwkJr+JPYgMwqGTP4nyIm87T
         2Q4DGMaa/cJhSnawYjyHUZsjMButUNW3T6q46p2Tw6PJ883/y7MSFPQYQdmmd3rOTfRe
         cYRmw0wJTVWihUyDivQcve1k7LBWSJreLRywoAkVBgR0eRBGfk5KIlCTQpnIR+mxRPkC
         1X/NsTtOjBBszDL5+5VDfKG81IwKppQlCT4Ygq2Qcyd37IkZ+n0EVXQI8spNW7GxIsY9
         bHQ2aJuRqNaxaFlBjJrElTby44i0ckfinEHuijaBaVlJbREwf66TNPwgNyqcFjM+bK6u
         oivQ==
X-Gm-Message-State: AOJu0YwWC6F5/8B2mwL9hGCsoXD/2/1AyZ9QxSivsV7WGTwqE2Ph4a+1
	aMyenoXd92msEHLiU8m2sR3fqFu3Ofw=
X-Google-Smtp-Source: AGHT+IFXJcY0byDiI2DYtaN2Spm/TBGmaU48O1htQWSVQl/prLbkHdJscgY+TG0vBEr0TJf/XN9RRw==
X-Received: by 2002:a05:600c:248:b0:40e:4ab8:639b with SMTP id 8-20020a05600c024800b0040e4ab8639bmr107621wmj.39.1704713703086;
        Mon, 08 Jan 2024 03:35:03 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id fl13-20020a05600c0b8d00b0040e490cb666sm1585535wmb.12.2024.01.08.03.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:35:02 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 12:35:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL] x86/mm changes for v6.8
Message-ID: <ZZvd5KZKVXAtM1+F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/mm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2024-01-08

   # HEAD: 91c17d7b04498ffb52939a18eb7e28fd23c9b654 x86/percpu: Use %RIP-relative address in untagged_addr()

x86/mm changes for v6.8:

 - Robustify pfn_to_kaddr()

 - Improve the __untagged_addr() code: RIP-relative addresses are fine these days
   and generate better code, and update misleading/outdated comments as well.

 Thanks,

	Ingo

------------------>
Michael Roth (1):
      x86/mm: Ensure input to pfn_to_kaddr() is treated as a 64-bit type

Uros Bizjak (1):
      x86/percpu: Use %RIP-relative address in untagged_addr()


 arch/x86/include/asm/page.h       |  6 +++++-
 arch/x86/include/asm/uaccess_64.h | 11 ++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

