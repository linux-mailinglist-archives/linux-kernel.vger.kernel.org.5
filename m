Return-Path: <linux-kernel+bounces-145964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0495B8A5D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A561F22EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA14A157A68;
	Mon, 15 Apr 2024 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b="BMZzzMtO"
Received: from mr3.vodafonemail.de (mr3.vodafonemail.de [145.253.228.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934625601;
	Mon, 15 Apr 2024 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.253.228.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713218963; cv=none; b=lhgOP5KkAK+FHUWmrpOk/usac7/kZ4j0GwuCYT1uSVG7SUbu5Lsj6gUERs7p8w93CAAt+epQV2QRpYJrYfqy3OzMMj73KsSRgbRw0llriQZq7jT7UJQCr6QMBosvQPjqmhyCYS4CwSpolFQcj3k7yIAGzDginYHEExKAzTooY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713218963; c=relaxed/simple;
	bh=0mTE8PnlCQ1wdA4wzRAi2+Rr4Bdb3Hxd7XqVlI6u7Rk=;
	h=Message-ID:From:To:Cc:References:In-Reply-To:Subject:Date:
	 MIME-Version:Content-Type; b=iXNOTOXBANmSSHJihKZXxIbp8qsyc2Fld5R/lcsPtNf4QlCKNCMCtR+yHQNeRWe51KT7W2MMwtxgtTgU1bzvNDkdNr3ZjDgg7Hq6zwiN6knrbwCDVg7TXYggyHpDP3BKsrmQCrD95lJeY9bwmVmxS4GrUtcOxHlOsMoLlasNkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=nexgo.de; dkim=pass (1024-bit key) header.d=nexgo.de header.i=@nexgo.de header.b=BMZzzMtO; arc=none smtp.client-ip=145.253.228.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexgo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1713218958;
	bh=emoFhdkFz5RJ0/RyTC4V6sFSuslEbob2BZ/wjfJB4So=;
	h=Message-ID:From:To:References:In-Reply-To:Subject:Date:
	 Content-Type:X-Mailer:From;
	b=BMZzzMtOtuz0aiD2q1FFtg7ASRoElNd/+BDp17Uzt8sZYDTt1IIKkWSyKORz+bT5G
	 Xsm3nz6TIfASjfSWX1IHB0WYSKyX5y1XEbufWjlvUQiNsOej+itrUjAqoABNMeAvE5
	 6LeeNUJIhjLmXYKyxFNFSTycKL1R8FkmUQ2IuDqk=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr3.vodafonemail.de (Postfix) with ESMTPS id 4VJLtQ25vsz1ybY;
	Mon, 15 Apr 2024 22:09:18 +0000 (UTC)
Received: from H270 (p54805648.dip0.t-ipconnect.de [84.128.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4VJLtC63M9zKm4D;
	Mon, 15 Apr 2024 22:09:04 +0000 (UTC)
Message-ID: <65E53E4DD09F41CDA7EBCBD970E23C23@H270>
From: "Stefan Kanthak" <stefan.kanthak@nexgo.de>
To: "Eric Biggers" <ebiggers@kernel.org>
Cc: <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240411162359.39073-1-ebiggers@kernel.org> <20240411162359.39073-5-ebiggers@kernel.org> <2ECD48ACEA9540C083E6B797CFD18027@H270> <20240415212121.GA5206@sol.localdomain>
In-Reply-To: <20240415212121.GA5206@sol.localdomain>
Subject: Re: [PATCH v2 4/4] crypto: x86/sha256-ni - simplify do_4rounds
Date: Tue, 16 Apr 2024 00:04:56 +0200
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
X-purgate-size: 2866
X-purgate-ID: 155817::1713218953-16BA2B22-EB43FB4D/0/0

"Eric Biggers" <ebiggers@kernel.org> wrote:

> On Mon, Apr 15, 2024 at 10:41:07PM +0200, Stefan Kanthak wrote:
[...]
>> At last the final change: write the macro straightforward and SIMPLE,
>> closely matching NIST.FIPS.180-4.pdf and their order of operations.
>> 
>> @@ ...
>> +.macro  sha256  m0 :req, m1 :req, m2 :req, m3 :req
>> +.if \@ < 4
>> +        movdqu  \@*16(DATA_PTR), \m0
>> +        pshufb  SHUF_MASK, \m0          # \m0 = {w(\@*16), w(\@*16+1), w(\@*16+2), w(\@*16+3)}
>> +.else
>> +                                        # \m0 = {w(\@*16-16), w(\@*16-15), w(\@*16-14), w(\@*16-13)}
>> +                                        # \m1 = {w(\@*16-12), w(\@*16-11), w(\@*16-10), w(\@*16-9)}
>> +                                        # \m2 = {w(\@*16-8),  w(\@*16-7),  w(\@*16-6),  w(\@*16-5)}
>> +                                        # \m3 = {w(\@*16-4),  w(\@*16-3),  w(\@*16-2),  w(\@*16-1)}
>> +        sha256msg1 \m1, \m0
>> +        movdqa     \m3, TMP
>> +        palignr    $4, \m2, TMP
>> +        paddd      TMP, \m0
>> +        sha256msg2 \m3, \m0             # \m0 = {w(\@*16), w(\@*16+1), w(\@*16+2), w(\@*16+3)}
>> +.endif
>> +        movdqa      (\@-8)*16(SHA256CONSTANTS), MSG
>> +        paddd       \m0, MSG
>> +        sha256rnds2 STATE0, STATE1      # STATE1 = {f', e', b', a'}
>> +        punpckhqdq  MSG, MSG
>> +        sha256rnds2 STATE1, STATE0      # STATE0 = {f", e", b", a"},
>> +                                        # STATE1 = {h", g", d", c"}
>> +.endm
>> 
>> JFTR: you may simplify this further using .altmacro and generate \m0 to \m3
>>       as MSG%(4-\@&3), MSG%(5-\@&3), MSG%(6-\@&3) and MSG%(7-\@&3) within
>>       the macro, thus getting rid of its 4 arguments.
>> 
>> @@ ...
>> +.rept 4                                 # 4*4*4 rounds
>> +        sha256  MSG0, MSG1, MSG2, MSG3
>> +        sha256  MSG1, MSG2, MSG3, MSG0
>> +        sha256  MSG2, MSG3, MSG0, MSG1
>> +        sha256  MSG3, MSG0, MSG1, MSG2
>> +.endr
> 
> Could you please send a real patch, following
> Documentation/process/submitting-patches.rst?  It's hard to understand what
> you're proposing here.

1) I replace your macro (which unfortunately follows Tim Chens twisted code)
   COMPLETELY with a clean and simple implementation: message schedule first,
   update of state variables last.
   You don't need ".if \i >= 12 && \i < 60"/".if \i >= 4 && \i < 52" at all!

2) I replace the .irp which invokes your macro with a .rept: my macro uses \@
   instead of an argument for the round number.

<https://sourceware.org/binutils/docs/as.html#Macro>

| \@
|    as maintains a counter of how many macros it has executed in this pseudo-
|    variable; you can copy that number to your output with '\@', but only
|    within a macro definition. 

That's all.

regards
Stefan

