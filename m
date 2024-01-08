Return-Path: <linux-kernel+bounces-19272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C41E826A9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE96A28524D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B509E1170E;
	Mon,  8 Jan 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l52M+8wb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E311709
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3376555b756so662170f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704705728; x=1705310528; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+aNf0ONfT0OVx2CSa9LE4n/iyyMFxmXonlJaWIN/fw0=;
        b=l52M+8wbf0xYAdmXFiReiF48zvuWUIBj7/QzD+DAy3MBXUUi166EejChonRN8i8ACH
         cumFsxAPe4ntcmehWQoX1zCvpIlb+nBdsP7HM45S9WU/6dL5FuhL2J95O7mqSIMBIr4y
         NNk1JOa2VdFHqVLvA03xg38/qKuy8ahNq8psyYxyAKgqkZxrvHuQBdafChrOGbHPFJ5J
         5lzTjCoNUl99jjC1s7PJrBxe875FJsLHnRHxwZWZddKMe8EQ2CH4OJcm3oJbcGOALVWn
         +lPmps4Mw31Ofp39TMNagrMmnD4Pl8WLfFWGjJk2UME92YtboWqBvlBtiKM2T6+PZ4Mm
         Ehxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705728; x=1705310528;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aNf0ONfT0OVx2CSa9LE4n/iyyMFxmXonlJaWIN/fw0=;
        b=VZhr5gg52ndhHE34VTWWZDITiR9DSYU6v8IexTtIeIor1C4P+wah9KIVZbjEb7udzT
         JWOAKS98YwxrfkEib6Bfg2h6TDcyH/8w57Sz1k6koy7FPXHaPPozHehjrsyA1p42lgti
         nNbHvXapTAHyJjiJYcHC8Y8s4cFIfNXHjQsvejbZ9FvzPOoub0QZGH0jV6goY2yPtpeZ
         wr4KtxliobYBxcFn/z3AW7Fxe0ACF7AycrSJis2jCaF2+pX9ddnZgKC//tpBqr1+1pSe
         cFqcp/2pIjnVj7oJsWIccE5jdNRvUqD9lMKoffc3Ab2n4FPi3XC9NhXma6kQBFL05FfS
         dbKw==
X-Gm-Message-State: AOJu0YyCsozcx3ZdzUdtUY1Gavbz6vnNh6LrFlxHlJxYL0bPorQH2fcB
	06Fyx17f4PEdYk4JdGRXW0k=
X-Google-Smtp-Source: AGHT+IG3J2NDcoL+pAGmq5yzhfb7lS0Vfry2JDYl+r077bCMnLFT8mgIQTwUeqVWfy3ltzfWP3Tw+g==
X-Received: by 2002:a5d:4522:0:b0:337:3c46:6f79 with SMTP id j2-20020a5d4522000000b003373c466f79mr1383373wra.6.1704705727564;
        Mon, 08 Jan 2024 01:22:07 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id d1-20020adfa341000000b0033662fb321esm7299216wrb.33.2024.01.08.01.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:22:07 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 10:22:05 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool change for v6.8
Message-ID: <ZZu+vWxAfJiAOjFP@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Linus,

Please pull the latest objtool/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2024-01-08

   # HEAD: e2e13630f93d942d02f3b3f98660228a3545c60e objtool: Fix calloc call for new -Walloc-size

Address a GCC-14 warning: there's no real bug, but indeed the calloc order doesn't match
the prototype.

(Side note: we should really add zalloc() for such cases.)

 Thanks,

	Ingo

------------------>
Sam James (1):
      objtool: Fix calloc call for new -Walloc-size


 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e94756e09ca9..548ec3cd7c00 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -291,7 +291,7 @@ static void init_insn_state(struct objtool_file *file, struct insn_state *state,
 
 static struct cfi_state *cfi_alloc(void)
 {
-	struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
+	struct cfi_state *cfi = calloc(1, sizeof(struct cfi_state));
 	if (!cfi) {
 		WARN("calloc failed");
 		exit(1);

