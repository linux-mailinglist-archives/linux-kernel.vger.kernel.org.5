Return-Path: <linux-kernel+bounces-3142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439C78167EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D576A1F20FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD135101D4;
	Mon, 18 Dec 2023 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/ABmEuz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE29101C0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d39e2f1089so12758245ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702887603; x=1703492403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0YAACVwh6LABjx2cqfwoLGdttQf359RVTJ+eJIipT0M=;
        b=m/ABmEuz8IzLpgGAUXd1fZ6C3yGgxLNQrkvOIn4j0PaI6OG6r0pdJ1E9Foneeg23uD
         FYxmXNUY5cF8dGJDl1wGbVlRKn+jSC/lVfkLr8aiwWhgfJE5jvHVv+BoWsicEFwsr8Nk
         uEsY1EHeA4eROYEnfyq39wp+etzg4J5UfOO6nE/xoBm8Dqwe1I4QpfvHYCpZ1N5mNg6w
         v45ify5T3fMRppuE3pGPcgqflF7oit6GogwfAbACbUGcORXBqdpk9zWelG3EkSFs9dSJ
         feqFosNQv2q1Lt2uy74GcR1xT24/3HFkqvhfLvl89WhCaalQAayE8Q3Xtkq/oOvPNLZ/
         1R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702887603; x=1703492403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YAACVwh6LABjx2cqfwoLGdttQf359RVTJ+eJIipT0M=;
        b=DPggObEvk0ncGmiHM6BUCwl+RFOIyPyG+dkDLYsPNulAZRDaRA/Uy17yfT37v5gL58
         oetvCa7elfMP9Y+5u9GXrdvPpsQ6LpIoFiTmCV7pG9GGSVbOwQFaAn+OwGP+In2Anojq
         NbQ3vY4C9g929O2Ux3WSvVXF+OzmJj4LnrHiq88Iv09dimrMi4jyDW5n8dSot1i2MOGy
         6fMf9Xd+3ErN/OtKpjcaGCFpcDWhk7QQyye6TqYsTq5NDExaRQy+nQ3WsThdGSkwBYC9
         XPg+NpmN0tAajaMiyJbcxaz/avh6OChfvijMifQDVB+JoIMGOeLUp84w1PMua7aigoBe
         k8+g==
X-Gm-Message-State: AOJu0YwrEJDlLG/BS3RXO0Lx9aKyv7VK5wQtDsZJa85WkiXXBOSVJEn7
	WEbEgNJJcLpyZWTs/zzTle4c4FtQvXQ=
X-Google-Smtp-Source: AGHT+IFeEZ0CLf+tmohh8vFRK+lWimcFHZcpXRQDADFKOc/fvOLCMjwl0B5vCWo/kYvEqzDk0IxC+A==
X-Received: by 2002:a17:902:dac1:b0:1cf:a70b:39cd with SMTP id q1-20020a170902dac100b001cfa70b39cdmr20550839plx.39.1702887602965;
        Mon, 18 Dec 2023 00:20:02 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001d06b63bb98sm18426954plt.71.2023.12.18.00.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:20:02 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 0/2] crash: fix potential cmem->ranges array overflow
Date: Mon, 18 Dec 2023 16:19:13 +0800
Message-ID: <20231218081915.24120-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series tries to fix the potential cmem->ranges array overflow.

Yuntao Wang (2):
  x86/crash: fix potential cmem->ranges array overflow
  crash_core: fix out-of-bounds access check in
    crash_exclude_mem_range()

 arch/x86/kernel/crash.c | 9 +++++----
 kernel/crash_core.c     | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.43.0


