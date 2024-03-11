Return-Path: <linux-kernel+bounces-99527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7BF878999
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEF1281B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6EF58AA3;
	Mon, 11 Mar 2024 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="met2E4kd"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03657861
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189654; cv=none; b=hDtBoxf7/VHd59Xrb3Ii85zBdbBzMK1aHTY3kZ4jdhC4rM1c6Ljg/7m00V0TCMZXInnIm8tIO+5H9GFoNxYZ+VtN6VW0+eiwaPKZf4wcCyiIeN0555UTHM+9fUHsVqA7jjh+LcyFr0NURQDPcQkeA10cvaY2eRyCqE49T0DFXpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189654; c=relaxed/simple;
	bh=l6+vGocoJjKBZ6LjvyKw3EB2dMWQhPWbCAUhatHdqDE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k5T9qxUKLpg+9gjaVQaq4D8J5c50rdQgXM/lvGH2Sh4QVzrhDEPlLrb/62d1gfc0wTLRwQalDGJl/Lz/jq9JbSS4anWOIa21kCPoMHpX5TzMlldVaadp6q5NNxLVtB9TT1uAp5uYYA9YHiNdAzzLTqi6yrs6obaT5CJBIRCxOUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=met2E4kd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e8f906f3dso1887298f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710189651; x=1710794451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hysh3fJNhJmvp1Mvqbl3AfXFa72LgQZtPG4AlifhcO0=;
        b=met2E4kdu7Dtzsz0EKXTMl/JmsybqY7YxI3Tu85dHRsR0t41/YZoNVpdwZUEp1JLGZ
         o8gYjn0bafuG/2e6hTtgi+aWrXDRyInawILP6lshtqyTPzln8MsI8YlO5+d6hkC/jv6D
         y/ouxqsi0jEqFHPkoaaULOLh/IHm55cz3sOdkD3mnPMeBycVN5P7hJXri9aCGWxgtlfX
         Jo2Ryk2WUF/o3Zf5cD/x2hR/7O/teFepxp82oFfN3PEx/p6xQ2QHNKUQu7cpHEmsbROO
         ej+y5eY3ItEURlu/Krkj91OnTeRlQYhyXPfnr5X8Bff/d9CT6ebQw7Z0vbX2WU6TbYUg
         uShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710189651; x=1710794451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hysh3fJNhJmvp1Mvqbl3AfXFa72LgQZtPG4AlifhcO0=;
        b=remTTVgRssRUkJQcu632rN42/pTdfuYNf8mfcOLk6SwnfxIgCrzIfPt5alkXBd9f3q
         plSl8M/OL+DOnCpY1VP6eXKGmfe53Zzd8YuW4kRoundxbTPUgPGnXFov88wQ7GU3+DXe
         hF10iIvdgyDEfLNgv7bjMDlBYNU+QMbVv/BVnV+DTGJLEYk+ygT0g59zVdoPTyyw3M+S
         Fhi7cxvzFG/6baL9syMRzYyxIj3dZKaFwqnTFkYzYA23Vuwc+F5hz4vju5/NCSBdiD3B
         q+YfeN5iDJmaVB4+62ytZYskww/m0dmaFhQx8gueRlqyxgOluPSnbvwu87EgXQjQcITn
         HKnA==
X-Forwarded-Encrypted: i=1; AJvYcCXnoocIj6yH2zBVtQUjlEetscb7g30b02UfCHtI+6MSZnYuda9ARw/pa+rkWCS/j1HclcbEetV203cK3R9NqK40yVA8HzNd/3s8ob7w
X-Gm-Message-State: AOJu0YzF7IRMjjc31LI9Xcb4oOvlDsLR95LljtuxnA33tnKyjqPFuYNS
	XzlCuny3a39NAnnDuqZ22mFJ/JONdsCY0uTuk7pwH0lDA7lES8uhL9fN0Tj0WBs=
X-Google-Smtp-Source: AGHT+IGY2G4F8cTa0D/fyd+ZIT6Qbr8F168RDRZDJAMNFqzAzGHgWGWYgTpGdTGLt80U7pXeR2kYjg==
X-Received: by 2002:a5d:5012:0:b0:33e:1560:71a8 with SMTP id e18-20020a5d5012000000b0033e156071a8mr5271323wrt.7.1710189650835;
        Mon, 11 Mar 2024 13:40:50 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b0041312c4865asm14929355wmq.2.2024.03.11.13.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:40:50 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH 7/7] scripts/faddr2line: Check only two symbols when calculating symbol size
Date: Mon, 11 Mar 2024 21:40:19 +0100
Message-Id: <20240311204019.1183634-8-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>
References: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than looping through each symbol in a particular section to
calculate a symbol's size, grep for the symbol and its immediate
successor, and only use those two symbols.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 1fa6beef9f97..70d5a4602a92 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -252,7 +252,7 @@ __faddr2line() {
 				found=2
 				break
 			fi
-		done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
+		done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2 | ${GREP} -A1 " ${sym_name}$")
 
 		if [[ $found = 0 ]]; then
 			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
-- 
2.34.1


