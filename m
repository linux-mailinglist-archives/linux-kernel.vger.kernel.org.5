Return-Path: <linux-kernel+bounces-165669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE298B8F46
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08B61F22AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A38146D6C;
	Wed,  1 May 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb7E4SxH"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9FA748D;
	Wed,  1 May 2024 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586283; cv=none; b=SQieEnkuO6a1CI+3jDgyFqNGu4SH/KWLzETXIfPuILkVTdsZ8ZBk+nte50oi4Q9toUg2v9PjNvahEyiz6EjbzQjCha/EtucI3gPDj8Y8mQCc/p+UT9W/IQF49/wytw2bZNUSKGrrXfCMbJfBBOPuyCapikJOs5ANDvFnWjbR5gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586283; c=relaxed/simple;
	bh=wPz8gz9fdNMhqbvWjuPfZ+k8F+pcSH6WWATe+mVvD8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOGlAm86KQlfHosJsqLXdmdbt50oad7Qj2v6wZjljAVwQ3CvgVgKzo2/zTeI3mkEgDZB6xdyTCRaarLixOUoKsqzTt1OuaC/Kzt1scL5ID5nVQy1Swro0uSe9+ez2JLp+H66ICTPpUEfCtZmY6Lv3PsRX86VgZBLcju7g+IDOqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vb7E4SxH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso5750495b3a.0;
        Wed, 01 May 2024 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714586281; x=1715191081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4rOKnsNhG1Q1vhr4pc7ubFIt+2tsJXhdN/DYA8iQLw=;
        b=Vb7E4SxHTSrGx+33Mai5xTM1VzUO6SwhdfsJINnOqFUddUf4cGeXFqhujOyawXziiW
         zhRBrS6VvID9uZpAOvsgWQH38Ow7yz+bYpbJqJgkfgIoq5MxyaHhdu379jMOtslx6PdY
         Z6iT7wF2/KwlVylnJRBCpKpnzTAggBrSX0ZqJTSERb1D+gahliK6JlNCYb2uSDv4cfEW
         Yzw5n8seVGmEDKcnm9EhGz2Kvz05uzrsSEXqE+WsTdBOM11TxzVWQl00bGjaKdEaxdYY
         Wu9c5Su2Xs6qTiUCa6SNFVamXHFsJPRbNeHtLvpf27JPfEoCGt0hng0bXvSA8v1S4G2L
         h6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714586281; x=1715191081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4rOKnsNhG1Q1vhr4pc7ubFIt+2tsJXhdN/DYA8iQLw=;
        b=WrYWuwYPxnUARbSXi2ATxenfpqguTVuoFWdoj3hAMmMWQwg5dA8ClRa1BR871XtXVU
         w1ZAgnCMtbLcl2FkjWBIejyaFnftvANz9U6CxTZ3H/Sa3oF4Go6EscTFMTNu76NdEtWz
         4OwqdA4yr5bxNMyV6RRIeieRo8cr8xebtQB6dFz3pf5F32HDUib1NvjOO+P/38jOkynW
         d+bbKLWMXqlqB2nWhWIYhVdd0w/KbqHUxfq9w7cyccg29n8yqcEDJViECtAaT7wBh93S
         gzm3+PWIfNA8vPhyWygFRI4P9gybdy3mNt6xaSYtNzJog/ol6BsPAkuGZy9VGHi61nCX
         gMKg==
X-Forwarded-Encrypted: i=1; AJvYcCWtymM198+eDT5LfA3ZLqtMp+FsFukX3C46Dt1pjdwaDovh+BvTPwPSrtgWIZHgHq88R1bZJWdk55QFwkH9Cjp/RF2iiMYtYBh6d59MIOB0iVIiM4QmGo2Qo/RD+HOaIl45HygHy0NT
X-Gm-Message-State: AOJu0Yzno2p9CrS3iLjze2Wb3fQzmQPLC2SltKaoJhQiwCUeC//V87tb
	XxFgXuPvzLd56rI70FzkBHn192tJ7CHiu7HeuHLD+9O+lrFCWPY=
X-Google-Smtp-Source: AGHT+IGqS6uE4xVjWbe8+ml+8Z6WT8GiuaF7BBzcpLLyVnyizp7pmn8/IyGwfSKof+aWeUQjW0XGCA==
X-Received: by 2002:a05:6a20:6a24:b0:1ad:92e0:f5d7 with SMTP id p36-20020a056a206a2400b001ad92e0f5d7mr4244462pzk.46.1714586281223;
        Wed, 01 May 2024 10:58:01 -0700 (PDT)
Received: from utkarsh-ROG-Zephyrus-G14-GA401II-GA401II.. ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id v2-20020aa78082000000b006eab6ac1f83sm22981821pff.0.2024.05.01.10.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:58:00 -0700 (PDT)
From: Utkarsh Tripathi <utripathi2002@gmail.com>
To: corbet@lwn.net,
	akiyks@gmail.com
Cc: Utkarsh Tripathi <utripathi2002@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2] Sphinx error fixed for inline literal end-string by changing $type_constant2 in kernel-doc script to include "*" unicode character in highlights_rst.
Date: Wed,  1 May 2024 23:27:30 +0530
Message-Id: <20240501175730.23326-1-utripathi2002@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b9e4bedb-6678-42ed-9ac1-c10179be5b69@gmail.com>
References: <b9e4bedb-6678-42ed-9ac1-c10179be5b69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc script uses the $type_constant2 variable to match
expressions used to find embedded type information. The current
implementation of $type_constant2 does not include the "*" unicode
character, which is used to highlight inline literals in the
documentation. This causes a Sphinx error when the inline literal
end-string is used in the documentation.

This commit follows the pattern of the commit
8aaf297a0dd6 ("docs: scripts: kernel-doc: accept bitwise negation like ~@var")
and takes inspiration from the following commit
69fc23efc7e5 ("kernel-doc: Add unary operator * to $type_param_ref").

Thanks Akira, for your suggestions, I have made the required changes.
I am fairly new to the kernel community, so if I am making 
any mistakes while making patches and replying to mails,
please let me know, it will be very helpful.

Signed-off-by: Utkarsh Tripathi <utripathi2002@gmail.com>
Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
Suggested-by: Akira Yokosawa <akiyks@gmail.com>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index cb1be22afc65..58129b1cf3f4 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -62,7 +62,7 @@ my $anon_struct_union = 0;
 
 # match expressions used to find embedded type information
 my $type_constant = '\b``([^\`]+)``\b';
-my $type_constant2 = '\%([-_\w]+)';
+my $type_constant2 = '\%([-_*\w]+)';
 my $type_func = '(\w+)\(\)';
 my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
 my $type_param_ref = '([\!~\*]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';

base-commit: 4d2008430ce87061c9cefd4f83daf2d5bb323a96
-- 
2.34.1


