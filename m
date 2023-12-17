Return-Path: <linux-kernel+bounces-2448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331A815D4D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377052839C1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 03:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F5D23A2;
	Sun, 17 Dec 2023 03:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoeD5l9w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACD20E3
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7b7039d30acso166613539f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 19:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702784195; x=1703388995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3V8gSp8bUEZWRGRAcmamI1zQxxCYsLgl6TFXIZtXR8g=;
        b=EoeD5l9wXRKiqhPFr4HMPiqmhgEy/nUK37cKf/nqi7mVT00rz4Ic9rvd7x6GkSfbOK
         0bzULEUQ1C6eW/Qj0YXEn2PP2XhXOnmVIktm714VE3h65fs24IxVMna6G1Iw+kpk3GqB
         2xQumGTaD/EAZGpRsRt65e5atV8IE5/ly3zK2YWh40xFDxM7PEm9CV1zNvp4frqUWAEB
         f9wPcOO3EurGvi0sxzPGvHBE+bafgcQnLaZM1N67aC425bnTQQPStY2kJLppZTEdPLqW
         bX5GnktwTrL1XJc3fgrTgoak+9ZOOH30NhbbP2MIbLU5hior0iJUaIaySTmxnRLKugUP
         tdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702784195; x=1703388995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3V8gSp8bUEZWRGRAcmamI1zQxxCYsLgl6TFXIZtXR8g=;
        b=dLJoRVXL/GEi2oXxrbXzmEQpQlgBWGssME9e1WcBgO9V/BkxMFxUlHcw8n/lmhXtJu
         dSdM0FipyigyX3+HfhjqrnCCpChSHlRkYqG1E0oajjpluhdKeP58N/WHsbYa1yhcMyAQ
         qaDgyvPK+9tyq4DcPPuICELAPSVfvZPFZpQXIg6xVmHEEuete1Qff1+njEz/JtvqajOa
         oGERM51fqYz4IG8663dkCarRQ9aeLVp1ry6xo8SCEuKzj0Sgu4o2aENYDwuuirYEqwPL
         Jml78m5ZMYEnZmg0eYy244tY6KFDKyrey7idQDonUOTrUTclb/7GPLdRLDke1FZzptEZ
         TrWA==
X-Gm-Message-State: AOJu0Yy0Tof/wGgCI/OoMkWpaizTn2r8QDfmtZqkcO1YRUEZSsdiOjIv
	uXBsnli5fPbczFOJI+zg7ZYojffcjOw=
X-Google-Smtp-Source: AGHT+IF19Uou+JFEzXr0eitLYlv+ldY8dy1/12JKbWr/jE+2XcuM/gbK5TyaB6a5sCN/Nkm2axS0Jw==
X-Received: by 2002:a5d:8850:0:b0:7b4:28f8:526 with SMTP id t16-20020a5d8850000000b007b428f80526mr16927258ios.38.1702784195510;
        Sat, 16 Dec 2023 19:36:35 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x26-20020a62fb1a000000b006ce48a0b7c6sm15768820pfm.109.2023.12.16.19.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 19:36:35 -0800 (PST)
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
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v5 2/3] kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()
Date: Sun, 17 Dec 2023 11:35:27 +0800
Message-ID: <20231217033528.303333-3-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217033528.303333-1-ytcoode@gmail.com>
References: <20231217033528.303333-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

temp_end represents the address of the last available byte. Therefore, the
starting address of the memory segment with temp_end as its last available
byte and a size of `kbuf->memsz`, that is, the value of temp_start, should
be `temp_end - kbuf->memsz + 1` instead of `temp_end - kbuf->memsz`.

Additionally, use the ALIGN_DOWN macro instead of open-coding it directly
in locate_mem_hole_top_down() to improve code readability.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/kexec_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9a419cd22d4..336d085cbc47 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -426,11 +426,11 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_end = min(end, kbuf->buf_max);
-	temp_start = temp_end - kbuf->memsz;
+	temp_start = temp_end - kbuf->memsz + 1;
 
 	do {
 		/* align down start */
-		temp_start = temp_start & (~(kbuf->buf_align - 1));
+		temp_start = ALIGN_DOWN(temp_start, kbuf->buf_align);
 
 		if (temp_start < start || temp_start < kbuf->buf_min)
 			return 0;
-- 
2.43.0


