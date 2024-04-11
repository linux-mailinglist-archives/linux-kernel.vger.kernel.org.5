Return-Path: <linux-kernel+bounces-140038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2E18A0AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7ABB2B3F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E1913EFE9;
	Thu, 11 Apr 2024 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b="ByEFufFF"
Received: from mr4.vodafonemail.de (mr4.vodafonemail.de [145.253.228.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E213E8A1;
	Thu, 11 Apr 2024 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.253.228.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822116; cv=none; b=suzdeQ1cKqkg7pCtrxPieW+wfgSp3koHs5fZ5ArJKnoVAe4kNpZ4Yy0+by6pQ6WHh0A+6bNBFLtXQDG8CbeZU6ij5OiY3kXa6OtMljVb+L8eq5FeUlHghl2FreDXfOYyx7aZrvRCSbF+w/B/+XF/J3ZoHKGxXni33sZMoKFldwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822116; c=relaxed/simple;
	bh=Vf9bYYGypv9FbN+9XbupcrTchpbiruWl7TSDs4c4LfQ=;
	h=Message-ID:From:To:Cc:References:In-Reply-To:Subject:Date:
	 MIME-Version:Content-Type; b=JVXHMgt/vdqUo8x76dVzo5C7iWjg1dGnKCd3YeaqW+tiZv8UiSq9XcfpRn9IFpG9x9pWjulwb3UZ7Ei+2bl2JhW0L8UFk2eEaxG2+ux/LGbVzubyFP8oGJoq9ozEDs47liJqpPpdo49nSK1+popBlyz88rxTNlDFE00yJR79Wxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=nexgo.de; dkim=pass (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b=ByEFufFF; arc=none smtp.client-ip=145.253.228.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexgo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1712821648;
	bh=OHW+Te4LEk/4CfJcGxAerYIwwgEc8XtDQqYGwFWpVHY=;
	h=Message-ID:From:To:References:In-Reply-To:Subject:Date:
	 Content-Type:X-Mailer:From;
	b=ByEFufFFulZirbqQeBZHlqXY/Jt5tnRFDkQIpQ21oMYmMcSqWeJi8oBsBpYvxQKg3
	 xPt2XQk6DQkxqeBzpr1a0u/Y/Ci0ColXtbI7oL1UsjQSDeaDAZLXcM10UN1QQXdTc1
	 yNF2w359+AjUfuTCnJVElyJrpBzdJSwk2qRAGLdY=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr4.vodafonemail.de (Postfix) with ESMTPS id 4VFWxr0RwVz1y9W;
	Thu, 11 Apr 2024 07:47:28 +0000 (UTC)
Received: from H270 (p54805648.dip0.t-ipconnect.de [84.128.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4VFWxZ4RxJz9scP;
	Thu, 11 Apr 2024 07:47:11 +0000 (UTC)
Message-ID: <450F5ED9B5834B2EA883786C32E1A30E@H270>
From: "Stefan Kanthak" <stefan.kanthak@nexgo.de>
To: "Eric Biggers" <ebiggers@kernel.org>
Cc: <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<ardb@kernel.org>
References: <20240409124216.9261-1-ebiggers@kernel.org> <20240409124216.9261-2-ebiggers@kernel.org> <C0FA88ECA90F43B1BF9E7849C53440D7@H270> <20240409233650.GA1609@quark.localdomain>
In-Reply-To: <20240409233650.GA1609@quark.localdomain>
Subject: Re: [PATCH 1/2] crypto: x86/sha256-ni - convert to use rounds macros
Date: Thu, 11 Apr 2024 09:42:00 +0200
Organization: Me, myself & IT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6002.18197
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.24158
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 4380
X-purgate-ID: 155817::1712821643-BCFF7A47-8CAAE437/0/0

"Eric Biggers" <ebiggers@kernel.org> wrote:

> On Tue, Apr 09, 2024 at 06:52:02PM +0200, Stefan Kanthak wrote:
>> "Eric Biggers" <ebiggers@kernel.org> wrote:
>> 
>> > +.macro do_4rounds i, m0, m1, m2, m3
>> > +.if \i < 16
>> > +        movdqu  \i*4(DATA_PTR), MSG
>> > +        pshufb  SHUF_MASK, MSG
>> > +        movdqa  MSG, \m0
>> > +.else
>> > +        movdqa  \m0, MSG
>> > +.endif
>> > +        paddd   \i*4(SHA256CONSTANTS), MSG
>> 
>> To load the round constant independent from and parallel to the previous
>> instructions which use \m0 I recommend to change the first lines of the
>> do_4rounds macro as follows (this might save 1+ cycle per macro invocation,
>> and most obviously 2 lines):
>> 
>> .macro do_4rounds i, m0, m1, m2, m3
>> .if \i < 16
>>         movdqu  \i*4(DATA_PTR), \m0
>>         pshufb  SHUF_MASK, \m0
>> .endif
>>         movdqa  \i*4(SHA256CONSTANTS), MSG
>>         paddd   \m0, MSG
>> ...
> 
> Yes, your suggestion looks good.  I don't see any performance difference on
> Ice Lake, but it does shorten the source code.  It belongs in a separate patch
> though, since this patch isn't meant to change the output.

Hmmm... the output was already changed: 2 palignr/pblendw and 16 pshufd
have been replaced with punpck?qdq, and 17 displacements changed.

Next simplification, and 5 more lines gone: replace the macro do_16rounds
with a repetition

@@ ...
-.macro do_16rounds i
-        do_4rounds (\i + 0),  MSGTMP0, MSGTMP1, MSGTMP2, MSGTMP3
-        do_4rounds (\i + 4),  MSGTMP1, MSGTMP2, MSGTMP3, MSGTMP0
-        do_4rounds (\i + 8),  MSGTMP2, MSGTMP3, MSGTMP0, MSGTMP1
-        do_4rounds (\i + 12), MSGTMP3, MSGTMP0, MSGTMP1, MSGTMP2
-.endm
-
@@ ...
-        do_16rounds 0
-        do_16rounds 16
-        do_16rounds 32
-        do_16rounds 48
+.irp i, 0, 16, 32, 48
+        do_4rounds (\i + 0),  MSGTMP0, MSGTMP1, MSGTMP2, MSGTMP3
+        do_4rounds (\i + 4),  MSGTMP1, MSGTMP2, MSGTMP3, MSGTMP0
+        do_4rounds (\i + 8),  MSGTMP2, MSGTMP3, MSGTMP0, MSGTMP1
+        do_4rounds (\i + 12), MSGTMP3, MSGTMP0, MSGTMP1, MSGTMP2
+.endr

This doesn't change the instructions generated, so it belongs to this patch.


The following suggestion changes instructions: AFAIK all processors which
support the SHA extensions support AVX too

@@ ...
+.ifnotdef AVX
         movdqa          STATE0, MSGTMP4
         punpcklqdq      STATE1, STATE0                  /* FEBA */
         punpckhqdq      MSGTMP4, STATE1                 /* DCHG */
         pshufd          $0x1B, STATE0,  STATE0          /* ABEF */
         pshufd          $0xB1, STATE1,  STATE1          /* CDGH */
+.else
+        vpunpckhqdq     STATE0, STATE1, MSGTMP0         /* DCHG */
+        vpunpcklqdq     STATE0, STATE1, MSGTMP1         /* BAFE */
+        pshufd          $0xB1, MSGTMP0, STATE0          /* CDGH */
+        pshufd          $0xB1, MSGTMP1, STATE1          /* ABEF */
+.endif
@@ ...
+.ifnotdef AVX
         movdqa  \i*4(SHA256CONSTANTS), MSG
         paddd   \m0, MSG
+.else
+        vpaddd  \i*4(SHA256CONSTANTS), \m0, MSG
+.endif
@@ ...
+.ifnotdef AVX
         movdqa  \m0, MSGTMP4
         palignr $4, \m3, MSGTMP4
+.else
+        vpalignr $4, \m3, \m0, MSGTMP4
+.endif
@@ ...
+.ifnotdef AVX
         movdqa          STATE1, MSGTMP4
         punpcklqdq      STATE0, STATE1                  /* EFGH */
         punpckhqdq      MSGTMP4, STATE0                 /* CDAB */
         pshufd          $0x1B, STATE0,  STATE0          /* DCBA */
         pshufd          $0xB1, STATE1,  STATE1          /* HGFE */
+.else
+        vpunpckhqdq     STATE0, STATE1, MSGTMP0         /* ABCD */
+        vpunpcklqdq     STATE0, STATE1, MSGTMP1         /* EFGH */
+        pshufd          $0x1B, MSGTMP0, STATE0          /* DCBA */
+        pshufd          $0x1B, MSGTMP1, STATE1          /* HGFE */
+.endif


And last: are the "#define ... %xmm?" really necessary?

- MSG can't be anything but %xmm0;
- MSGTMP4 is despite its prefix MSG also used to shuffle STATE0 and STATE1,
  so it should be named TMP instead (if kept);
- MSGTMP0 to MSGTMP3 are the circular message schedule, they should be named
  MSG0 to MSG3 instead (if kept).

I suggest to remove at least those which are now encapsulated in the macro
and the repetition.


regards
Stefan

