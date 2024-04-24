Return-Path: <linux-kernel+bounces-157043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3132C8B0BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45031F28F01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C9915EFC9;
	Wed, 24 Apr 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZaabQzwt"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5715ECFB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967564; cv=none; b=cFZufJSJ3mCDjI3CKeL91WdRFcmw1OQ6a0OisG67vObiJJrpgP8dUa17nbqagdNIn5TwYhVtnhd05MduRfe3ugtyKKindmUa1Q3SlLtgCWFCp28uDst8Jlie4XwGRUZhSDGcQNfyD4lDzvDqOGnsAgOGEfUwTr+yF46G1PTh1HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967564; c=relaxed/simple;
	bh=4y/UfQeo9BB5p962BWa2HGfLqeDinyewUKR63C4ycb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=acUs/8ck/0bXabEeNMtyTwSe6zbGX7zM540jqKFnice6pHdpU5ipvY6EYlYmyocQJ9l74h8zzFd3K/fVdL2UhUdn2hcSoD5WRWrcnin+NhC7wcGlIoOvF6jOfyIFqF18krQCfunLMuGCoGkSRHeLAEsi5+dVxc0bfj8sUvtBKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZaabQzwt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41aa21b06b3so27274435e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713967559; x=1714572359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xf6jJgGtYoURMWCLwezA7KydSJS05u43a8wuFVX3hek=;
        b=ZaabQzwtshVQhlaHpD1qSz5Rs3rcSlgfeviWAADug8QqpFq2hCK2t3gUPFkpPMgMYL
         0CALT5OXAdVkP9VuM+oQUMnh5thbwo1Rn/9+J+rQZaUbyTEGyRLU/73nhSLpOGlea7Zn
         Pqp6jt+FD+I05LvU7ophQMvD6emoX8slmInQ+LYt5hs3vc8SqatUJLSYcprpz1w81cRE
         0b+okow2Ix2nD2aBICdlypxIjSIF9J9CKHCrpZrso7Ss/QmLEN1BGGUPipY9K7FQmJOv
         2bbm+EM+Q21JtevzuosHDQJxD5V1W0QEpPeLa/aMitCaMLufbNdUp2zUA0NfGwUER0M+
         +dZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967559; x=1714572359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xf6jJgGtYoURMWCLwezA7KydSJS05u43a8wuFVX3hek=;
        b=Eo3lxUv/I0LJQryLdZfvyToWEzh+YXdSsxIQGKFUCJoUlLkP2sMfTZsEczn+HwkVAy
         3GnfnQDONh8Db5RIZI+oiE/hfFpHi93x45lFI4ZxS9yejZGi1IfuFaCqED6ifNXq+meQ
         xrMmaX25ZSIlCgIrAGvEkMcy8EMQzNp61NmNe8TP/eYoqm9UWNFUCUjQ8LjbXfVWaZJq
         MHWgomoK3LRYMK0CjDD+Gv9NQn/M/Hv+5kjeUZfuRCI5zq0j3JR1yrRs8d5Dg+uT/VG0
         7Z/P27dzAvUqXp/cmgqwWkFdP0MpYaaeBY94+2voJAjqkjz/tBM/lp572gAsRZAHtxcZ
         iMig==
X-Forwarded-Encrypted: i=1; AJvYcCWU8SGpwR5dDPLd61CCIDyTnj+AUmNDtF+npnb57arJ5ALLu2fBz9fOA5SXJheurWEg52CwlyFgpLmjmu/EHrYMUdecsQeHIkwq5TuI
X-Gm-Message-State: AOJu0YzBf2F6gvvsAAQafHDm9WQZvFI/uLhcvdLbrJpST3rvXhictpD5
	x/OQ94AWUD7WTvdB6nhwsLIKy4gtWmBmm0u2v5foTt1XS3HuElnLnPkRIUXu+t0dsGgUXR4DgoH
	QwGs=
X-Google-Smtp-Source: AGHT+IGd68kgcf+HjE1TmNyFnjhhLSnTd0wJKFJJOgOaYKRHvfSqLflyrYYA/pJTiUGWJpppqsdsMQ==
X-Received: by 2002:adf:f1c4:0:b0:34a:5663:40b with SMTP id z4-20020adff1c4000000b0034a5663040bmr2105456wro.3.1713967559219;
        Wed, 24 Apr 2024 07:05:59 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm9105325wrs.108.2024.04.24.07.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:05:58 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 24 Apr 2024 15:03:40 +0100
Subject: [PATCH v3 7/7] kdb: Simplify management of tmpbuffer in kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-kgdb_read_refactor-v3-7-f236dbe9828d@linaro.org>
References: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
In-Reply-To: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Justin Stitt <justinstitt@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3701;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=4y/UfQeo9BB5p962BWa2HGfLqeDinyewUKR63C4ycb0=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmKRGudf5inuoD8Nr656uwiWRZbIEHdLW4JrDeZ
 lJMHhMk9KiJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZikRrgAKCRB84yVdOfeI
 occbD/4pjpqPwrvEP/0VZBZncv0hccI6KG89x6KIdf9GTGF2RcxcXf908MP/MhPdHqHFBCKrIGY
 bwVl552feyjt0cvHDl0S56uvymM/PvQxvJ3Qx8Ab1xhRjlcd1VaFc3pCcJMEBFV9sLu1mr3N0wA
 aR+TyTxX3/BmHeHaveZEGP6aRDBQMn3W7tXBBleJzEA1L/8paW1XXFHgmtDSJ47IwQVcKZc4PsM
 P/B/8sISlay8zMAquHSal2ZwU0wOwMCfxv4qBsBhw2Alxvu/e+gAS529cnmSB32PLwbaysgB+rm
 v1Ydibd2VHGovJbY/waI07V1iakoEW5rirxS8CQfqR1jBlktMhovMvBvx/+fpEeMmjwlbxFFo19
 cPe/AALhutiwT+aNLLlqevg40bpOh0ZH7GsNJLAxiiO+UyH3nQzQS0UQgEEJZFu0kmVuxogQZg2
 17nnnbk1rs668oOA3XIoKzJU1Uc5EQTVu1WaU+snMQoswNX9P11elp0QaP+/8qNBE3Q2w17ucmU
 Eyqd66QjcvOnSIjunait0JmRcYstZD4ue+WcwJT54S6xdFDGWfT8K53szVurX20Zzmv4kO3ngEi
 fbe/ENy4aF9CQZ9YSZOdkXuHBeUaF81uJTxhwnkX5dMZqa+kK0V6AMNAWhPMFSwzGJUF5Yfo2GC
 /DiMt47Qrii1YYg==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

The current approach to filling tmpbuffer with completion candidates is
confusing, with the buffer management being especially hard to reason
about. That's because it doesn't copy the completion canidate into
tmpbuffer, instead of copies a whole bunch of other nonsense and then
runs the completion search from the middle of tmpbuffer!

Change this to copy nothing but the completion candidate into tmpbuffer.

Pretty much everything else in this patch is renaming to reflect the
above change:

    s/p_tmp/tmpbuffer/
    s/buf_size/sizeof(tmpbuffer)/

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 40617f36a6db4..3131334d7a81c 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -239,6 +239,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 						 * and null byte */
 	char *lastchar;
 	char *p_tmp;
+	char tmp;
 	static char tmpbuffer[CMD_BUFLEN];
 	int len = strlen(buffer);
 	int len_tmp;
@@ -246,8 +247,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 	int count;
 	int i;
 	int diag, dtab_count;
-	int key, buf_size, ret;
-
+	int key, ret;
 
 	diag = kdbgetintenv("DTABCOUNT", &dtab_count);
 	if (diag)
@@ -329,21 +329,16 @@ static char *kdb_read(char *buffer, size_t bufsize)
 	case 9: /* Tab */
 		if (tab < 2)
 			++tab;
-		p_tmp = buffer;
-		while (*p_tmp == ' ')
-			p_tmp++;
-		if (p_tmp > cp)
-			break;
-		memcpy(tmpbuffer, p_tmp, cp-p_tmp);
-		*(tmpbuffer + (cp-p_tmp)) = '\0';
-		p_tmp = strrchr(tmpbuffer, ' ');
-		if (p_tmp)
-			++p_tmp;
-		else
-			p_tmp = tmpbuffer;
-		len = strlen(p_tmp);
-		buf_size = sizeof(tmpbuffer) - (p_tmp - tmpbuffer);
-		count = kallsyms_symbol_complete(p_tmp, buf_size);
+
+		tmp = *cp;
+		*cp = '\0';
+		p_tmp = strrchr(buffer, ' ');
+		p_tmp = (p_tmp ? p_tmp + 1 : buffer);
+		strscpy(tmpbuffer, p_tmp, sizeof(tmpbuffer));
+		*cp = tmp;
+
+		len = strlen(tmpbuffer);
+		count = kallsyms_symbol_complete(tmpbuffer, sizeof(tmpbuffer));
 		if (tab == 2 && count > 0) {
 			kdb_printf("\n%d symbols are found.", count);
 			if (count > dtab_count) {
@@ -355,14 +350,14 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			}
 			kdb_printf("\n");
 			for (i = 0; i < count; i++) {
-				ret = kallsyms_symbol_next(p_tmp, i, buf_size);
+				ret = kallsyms_symbol_next(tmpbuffer, i, sizeof(tmpbuffer));
 				if (WARN_ON(!ret))
 					break;
 				if (ret != -E2BIG)
-					kdb_printf("%s ", p_tmp);
+					kdb_printf("%s ", tmpbuffer);
 				else
-					kdb_printf("%s... ", p_tmp);
-				*(p_tmp + len) = '\0';
+					kdb_printf("%s... ", tmpbuffer);
+				tmpbuffer[len] = '\0';
 			}
 			if (i >= dtab_count)
 				kdb_printf("...");
@@ -373,14 +368,14 @@ static char *kdb_read(char *buffer, size_t bufsize)
 				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		} else if (tab != 2 && count > 0) {
 			/* How many new characters do we want from tmpbuffer? */
-			len_tmp = strlen(p_tmp) - len;
+			len_tmp = strlen(tmpbuffer) - len;
 			if (lastchar + len_tmp >= bufend)
 				len_tmp = bufend - lastchar;
 
 			if (len_tmp) {
 				/* + 1 ensures the '\0' is memmove'd */
 				memmove(cp+len_tmp, cp, (lastchar-cp) + 1);
-				memcpy(cp, p_tmp+len, len_tmp);
+				memcpy(cp, tmpbuffer+len, len_tmp);
 				kdb_printf("%s", cp);
 				cp += len_tmp;
 				lastchar += len_tmp;

-- 
2.43.0


