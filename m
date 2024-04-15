Return-Path: <linux-kernel+bounces-145892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59638A5C71
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B3B2818B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90100156974;
	Mon, 15 Apr 2024 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b="Bsfv5Qfs"
Received: from mr3.vodafonemail.de (mr3.vodafonemail.de [145.253.228.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6F7F7FF;
	Mon, 15 Apr 2024 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.253.228.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214209; cv=none; b=R4Zfah8VbVaa2SJqecUSXp5bzBvfa8yCts4qCev7IUEAJssDjLN+uzBwAePNosVhR8U7XSBqb+bWf44TmGl3+2SoqsrVhGChGaBS0cZEUCcojapTHr0kEJJ5Waf6f/rXvr+F/oH9li68URpFCDeyecswkU7qQAPaGSRLlGp8yQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214209; c=relaxed/simple;
	bh=gAWfBjMv/u1hM1ri7vb4WcKTVN9s+CRx5IVlFNsdewU=;
	h=Message-ID:From:To:Cc:References:In-Reply-To:Subject:Date:
	 MIME-Version:Content-Type; b=DnoTX85xAwo01nKZhzY5x775pnkjZIkG9bX9B5uJV2rYcNpJyOASWD3xt0abzhWGCiWUJbbKIb7+otGLw8y6STL36TWgCQc6LE7pFdMGjtzKIws8iaT74PxsN2e6oiynhixX1LWc7jbq9MJ3MKyJvM1s9oueYaFA0Cw1aljU+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=nexgo.de; dkim=pass (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b=Bsfv5Qfs; arc=none smtp.client-ip=145.253.228.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexgo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1713214198;
	bh=sdWOScoNOqhnKs7wXEoboT4q95JQ4ewNRcGo/88he5M=;
	h=Message-ID:From:To:References:In-Reply-To:Subject:Date:
	 Content-Type:X-Mailer:From;
	b=Bsfv5QfsBPQjeBsyl3aUbwapcSPbTKuD4IMziRyplvzfZKp4VflHnCEegQxmAouMF
	 YReqiqSToV1MAqPEfmVGew4sJje9nW1D4W9b3+gziaOkU4F4ay01HG6EBC6LL9lxxd
	 souZnilJjfzKPHSr1r4oU+btY/YaaxgroOnUUfig=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr3.vodafonemail.de (Postfix) with ESMTPS id 4VJK6t6Ftwz1yVn;
	Mon, 15 Apr 2024 20:49:58 +0000 (UTC)
Received: from H270 (p54805648.dip0.t-ipconnect.de [84.128.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4VJK6h4LtKz9thr;
	Mon, 15 Apr 2024 20:49:45 +0000 (UTC)
Message-ID: <2ECD48ACEA9540C083E6B797CFD18027@H270>
From: "Stefan Kanthak" <stefan.kanthak@nexgo.de>
To: "Eric Biggers" <ebiggers@kernel.org>,
	<linux-crypto@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
References: <20240411162359.39073-1-ebiggers@kernel.org> <20240411162359.39073-5-ebiggers@kernel.org>
In-Reply-To: <20240411162359.39073-5-ebiggers@kernel.org>
Subject: Re: [PATCH v2 4/4] crypto: x86/sha256-ni - simplify do_4rounds
Date: Mon, 15 Apr 2024 22:41:07 +0200
Organization: Me, myself & IT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6002.18197
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.24158
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 2536
X-purgate-ID: 155817::1713214194-6CFF7A4B-F57EC3D5/0/0

"Eric Biggers" <ebiggers@kernel.org> wrote:

> Instead of loading the message words into both MSG and \m0 and then
> adding the round constants to MSG, load the message words into \m0 and
> the round constants into MSG and then add \m0 to MSG.  This shortens the
> source code slightly.  It changes the instructions slightly, but it
> doesn't affect binary code size and doesn't seem to affect performance.

At last the final change: write the macro straightforward and SIMPLE,
closely matching NIST.FIPS.180-4.pdf and their order of operations.

@@ ...
+.macro  sha256  m0 :req, m1 :req, m2 :req, m3 :req
+.if \@ < 4
+        movdqu  \@*16(DATA_PTR), \m0
+        pshufb  SHUF_MASK, \m0          # \m0 = {w(\@*16), w(\@*16+1), w(\@*16+2), w(\@*16+3)}
+.else
+                                        # \m0 = {w(\@*16-16), w(\@*16-15), w(\@*16-14), w(\@*16-13)}
+                                        # \m1 = {w(\@*16-12), w(\@*16-11), w(\@*16-10), w(\@*16-9)}
+                                        # \m2 = {w(\@*16-8),  w(\@*16-7),  w(\@*16-6),  w(\@*16-5)}
+                                        # \m3 = {w(\@*16-4),  w(\@*16-3),  w(\@*16-2),  w(\@*16-1)}
+        sha256msg1 \m1, \m0
+        movdqa     \m3, TMP
+        palignr    $4, \m2, TMP
+        paddd      TMP, \m0
+        sha256msg2 \m3, \m0             # \m0 = {w(\@*16), w(\@*16+1), w(\@*16+2), w(\@*16+3)}
+.endif
+        movdqa      (\@-8)*16(SHA256CONSTANTS), MSG
+        paddd       \m0, MSG
+        sha256rnds2 STATE0, STATE1      # STATE1 = {f', e', b', a'}
+        punpckhqdq  MSG, MSG
+        sha256rnds2 STATE1, STATE0      # STATE0 = {f", e", b", a"},
+                                        # STATE1 = {h", g", d", c"}
+.endm

JFTR: you may simplify this further using .altmacro and generate \m0 to \m3
      as MSG%(4-\@&3), MSG%(5-\@&3), MSG%(6-\@&3) and MSG%(7-\@&3) within
      the macro, thus getting rid of its 4 arguments.

@@ ...
+.rept 4                                 # 4*4*4 rounds
+        sha256  MSG0, MSG1, MSG2, MSG3
+        sha256  MSG1, MSG2, MSG3, MSG0
+        sha256  MSG2, MSG3, MSG0, MSG1
+        sha256  MSG3, MSG0, MSG1, MSG2
+.endr

Now that all code written by Tim Chen and Sean Gulley is gone,
remove their copyright notice and insert your and my name instead.

regards
Stefan

PS: see <https://skanthak.homepage.t-online.de/fips-180.html>
    (which I still polish) not just for this implementation.

PPS: if MASM had a counter like \@, I'd used it there.

