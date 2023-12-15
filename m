Return-Path: <linux-kernel+bounces-593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2234814357
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225CA1C225D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05061805D;
	Fri, 15 Dec 2023 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNk9e8PW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895017981
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ce7632b032so155642b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702627803; x=1703232603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sICzlYhaSfeV+0O8ybAajGk8fmRoPkGoJtHOPJtKgUM=;
        b=cNk9e8PWUD7XMBzEF6I6Z+tin57f8mtN7o0Fx7D5m0klA/J+2RzSk+V2DzetjkuPMy
         HYLHHwwgkmvj6kVkf1rNpB6I7jLv3TDiTUZ+tf6mhelO9p2opaQSZemmNMDVRd6Bzamb
         BU0Nu8ZSF/r0lLeuk4z9uyDfM7bglBilia2E3WePKrMXsAWEBL/ufk52HtMpMZJq9PC8
         ViWF/Dz+O7IFPYm5Ld3sTPDZ2FrSDgrHa2ekAimw79SLTJu7BgNT4gFeFLXlBMCwL1Qb
         4QOz1fVV0HEEfdvhBUFqUwLHkAneSnC4+8vhPrwPpkTF7SsXjHVPb3MkPWiKN6bVGfyH
         a9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702627803; x=1703232603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sICzlYhaSfeV+0O8ybAajGk8fmRoPkGoJtHOPJtKgUM=;
        b=YlERiJ64IPUQ5eDqJSVaim9Ka3RvhSVe8TGy/IdHj10P/U6B8uss1iKFNADwv5ciyT
         2ZZMP956tinXlhK+gX8mK9O+mHxt6eJ32jEZFYHlFLT6ElxYmLYBh5B8wv8MTY1uy/ON
         9cx7j3Wk1hRYGHWgTVI0WT35VKUhJp0gf9tQmNeL1NIch10B8Lxajhj//u73V8tmLUFA
         jmxNf5AwrdHKlisbCbyX0mTOnF6iZryCgIiODPZ2AZCRGANd0DYS64AJWO4hvZlU0/wu
         1AAeKr0nkgBxt8WxiJMT34Psg7p7O9Oz3kiJ4vukB0dPNc5lKP4GCXV98ZCw4+FpicDt
         oQvg==
X-Gm-Message-State: AOJu0YxLJsow9Nr4d4jK+W0rUBI5Cjj7vh+qKSoZW0zHkAgdZIbFnh+9
	5KEHvv3bC6HxoErdajWLrqjzz+b6/Fs=
X-Google-Smtp-Source: AGHT+IHxPXj3XYid69vOvuBnwTPo836bhjrwQT+9xxJqSFiSTCYQpfkUC3ihozMaJJmBd/eshU7Vng==
X-Received: by 2002:a05:6a00:d76:b0:6ce:f665:ab1 with SMTP id n54-20020a056a000d7600b006cef6650ab1mr3875430pfv.11.1702627802891;
        Fri, 15 Dec 2023 00:10:02 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b006cee656cb35sm11783792pfl.156.2023.12.15.00.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:10:02 -0800 (PST)
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
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 2/3] kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()
Date: Fri, 15 Dec 2023 16:09:09 +0800
Message-ID: <20231215080910.173338-3-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215080910.173338-1-ytcoode@gmail.com>
References: <20231215080910.173338-1-ytcoode@gmail.com>
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
index 26be070d3bdd..c3bf52a9a8ad 100644
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


