Return-Path: <linux-kernel+bounces-165676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 434EB8B8F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D517B22406
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F1B1474B1;
	Wed,  1 May 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhjwguJ6"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549F1474C3;
	Wed,  1 May 2024 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586757; cv=none; b=EQBL84uxn9ykF9dd1l05JLBV1zRbl/O93OXJ3Td/yrMWi+cmtLSkMksmuXLL+Qt+16a1ii6/TM8dJVpwzJ6We9jR6nmDQ29mA3S+iyiqEbhjxK/dYe9bpjNdkoZleznh6xtDIMiRQgJCQmTJg+tx0mlC0fLVUFPsyQBZhUTzhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586757; c=relaxed/simple;
	bh=hHIvEQ62EVYxaVwUmggRp5VXC2JBbn6OtLN3ohkV6u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iOICGu8qyHslukfWPA41z2AuWmN7xJSWAjQ9rkxTcLtp9FgFRoTcUsGLRcjGTLXCOjOPmi52+qtP4pmRLXhl7Lh6FTUDjaiUGnSf9KRHBu0NbfpCw3VafhKZE6MQOtRbyyVnSX6Vlh2THahNtDES7+V+m+u33Y+Lx770C4j9tEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhjwguJ6; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce2aada130so4922375a12.1;
        Wed, 01 May 2024 11:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714586755; x=1715191555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR53KWHGuwP1KvXLEas31HXBzXPK5rB5SP4fkg7uyBw=;
        b=GhjwguJ6FSB1v5XjWy4L6/dpiBmf4nb9icMnxiU/U5Fc+gaEchaqEfu856kBKZErSj
         bntZS+vgJWdMu+KnCStn/BaeSgzbNJMAp49jqO74QMYobIlLXTFvsN9eMZ5uIlxRxtI3
         Vv5N9JufwQEeVw8fKvCrnaqrTxle8L2/DNSiU8SwPlu8yatU1C36tkOxikeK+Y79jNlk
         vhMtsNRiYuAbKv8kamgljJoF4s8Ok1FKY4exgfjhi7hHkEqw465u1cOJ79HQy4Ot+VJa
         4/ra3hwqTwZMHrV/RN0wStY4m3e82ot9tqF0GciP0ft8Ju/V0dpAcJJxmZcUBdgTmlOf
         Wxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714586755; x=1715191555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR53KWHGuwP1KvXLEas31HXBzXPK5rB5SP4fkg7uyBw=;
        b=Nqs46RB5VEYckTvNwzHxtOm2uCkE8wDaEJ+Ef24NOJwU5KEyeJQTYUhPUWW7flmdMR
         rjrVw85dbRoNMUkaccQvrkq8eZrvn9ccffGBTScPGWFQBSw2pYCu60CzbWiuhzMKVDaX
         2q5DbJFloL0jC/9r4qppbWzrdnyHQhm6tGRAiLclCGxxrr4OzFYHjb3USBrmdZdBPlNQ
         ap00JflNkmcRRXS+z4CZ2xD0FNc6nvw/A1TQ+2tvfLj1epXEb5H3asAh5/6V7/jMMso+
         1fqunCts+77SFWUu81iEKkabyctiBPULccbEG1ROepWX9cO5uiKRq4AuOcnIme/DuWeS
         wTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPkGPVtZau9aAjAVu6Tz/cvUdCPFJ+cDoQapqfcztu7ckk3rQhQxgxXPi/JRNMM0jaUmjKsD9oG/P+hAXD6vdww2b1rAqMvsqsafBqUTONc0qvpf8Qja3U+chNdmAtJLTKa1KqUZBk
X-Gm-Message-State: AOJu0Yzx0Http9B9w9tG0AJseCJmUY4qeDNPGL1g0ZTVHxJBO2kGxy8H
	bkXbwlB/22ZY1ZpbOBbzXRuWHwLSg6cYIMF6r9MfkJ3/KjFMXNM=
X-Google-Smtp-Source: AGHT+IHw4AIBDPK368UPCLWl0k5njEuu1tSORmgBszoOjr8eJTlL7+p1+fH0mQihT2Pt8H3eOjsfyA==
X-Received: by 2002:a05:6a20:a897:b0:1af:3d3f:83f1 with SMTP id ca23-20020a056a20a89700b001af3d3f83f1mr3295373pzb.44.1714586755038;
        Wed, 01 May 2024 11:05:55 -0700 (PDT)
Received: from utkarsh-ROG-Zephyrus-G14-GA401II-GA401II.. ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id sp8-20020a17090b52c800b002a6e67e197dsm1618140pjb.45.2024.05.01.11.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 11:05:54 -0700 (PDT)
From: Utkarsh Tripathi <utripathi2002@gmail.com>
To: corbet@lwn.net,
	akiyks@gmail.com
Cc: Utkarsh Tripathi <utripathi2002@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2] Sphinx error fixed for inline literal end-string by changing $type_constant2 in kernel-doc script to include "*" unicode character in highlights_rst.
Date: Wed,  1 May 2024 23:35:47 +0530
Message-Id: <20240501180547.23752-1-utripathi2002@gmail.com>
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

Hello,

On Wed,  1 May 2024 19:02:40 +0530, Utkarsh Tripathi wrote:
> Fixed Error in Workqueue Documentation in the kernel-doc comment 
> for alloc_workqueue function in include/linux/workqueue.h, 
> the error was "Inline literal start-string without end-string" 
> which was fixed by removing the inline literal.
> Kernel Version - 6.9.0-rc5
> 
> Signed-off-by: Utkarsh Tripathi <utripathi2002@gmail.com>

There was a slightly different patch submission on the same issue the
other day.  You might be interested in seeing my response to it [1].

[1]: https://lore.kernel.org/r/6875fb17-f781-4594-803a-c11969f36022@gmail.com/

Quoting below for your convenience:

> In my opinion, reST-specific clutters like these should be avoided in
> kernel-doc comments as far as possible.
>
> Instead, I think you can educate kernel-doc (script) so that "*" is
> allowed in the %CONSTANT pattern, meaning %WQ_* can be converted
> to ``WQ_*`` in reST.
>
> For similar changes made against the @param pattern, see commits
> 69fc23efc7e5 ("kernel-doc: Add unary operator * to $type_param_ref")
> and 8aaf297a0dd6 ("docs: scripts: kernel-doc: accept bitwise negation
> like ~@var").
>
> I guess it is $type_constant2 that needs a tweak in this case.

Unfortunately, there's been no patch submission in this direction so far.
I'd be delighted if you can try this approach instead.

Thanks, Akira

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
Sorry, I mailed without adding the previous replies in the mail.

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


