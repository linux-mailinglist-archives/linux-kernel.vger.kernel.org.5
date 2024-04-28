Return-Path: <linux-kernel+bounces-161550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC0C8B4D9B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E912CB21286
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F774438;
	Sun, 28 Apr 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cEXU6/jd"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBCC64CC0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714331669; cv=none; b=A1JYqyRH/Fkxk5gmwZGTX+Fu2sAPLwvtyt2vl6Ozw9KLOuh2D7usP1lmJuPFQcRGNWTNdWBAmpC/KdaM9xpIVdtuUu97nsQxcM141W7dtLvvX7Nc+cYiojISJn0ygy6O7H7tdXNsSu2vbxLoclWW/la3FnDVEihiUkhQQnl9vvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714331669; c=relaxed/simple;
	bh=9Nj/lKy8oIw619xnOAq8MNoRmoqsDX21M1ok9ISgCK4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bWIj84/N3J0ira/eAHwQkKXgCNYDVawqgVTM8m1YCh6rJSAC2VTSqLM2oKG8yPRUOpyCRn7Eq8RBBi2kzLh6hezZlMhrCZVCecl2E4L2YB8TWssrxcIHKeLUCSyYo6oTMmckf2mB/D5dDfg8rhmGV5w8p6xeUFKRKmHT3jolWV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cEXU6/jd; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.56.209.56])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43SJDO2r3973779
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 28 Apr 2024 12:13:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43SJDO2r3973779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1714331607;
	bh=xxrADio/aNUzLdnPx8MOcg3D2EVsDHPLMECIw5Ickt4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cEXU6/jdGzjGctbaX1uJmc9/c+IpwEhnvGaBTFhDGvl1Q4m04fu8GP0txGBmIfqrw
	 VB2JQzW0ToMdyVtT5Z73kmc141v1oouP4YESItK04abET58pihX0Bc5zHtccBONBES
	 /ZHIpWF8Y/Db/izvzzm/yFMy7/7G9aT9Tkg8w7KGlUMcSQqQnkUi19GuZTmyFixcV3
	 u7jHWg+b7UZtV4sDkOHz/f4DhwN0cFO0SajY7gVccjIPLy5caoMBXS70PaTz48XPhD
	 PKgmZTU4eNSjQqdp/ot/CGGsdQsL5F33G++8a1xJrfOioO7Sggu2aLko8VIBT775YK
	 UtsL5d1Jj0WVQ==
Date: Sun, 28 Apr 2024 12:13:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Jules Irenge <jbi.octave@gmail.com>, mingo@redhat.com
CC: tglx@linutronix.de, bp@alien8.de, x86@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/tsc: Use div64_ul instead of do_div()
User-Agent: K-9 Mail for Android
In-Reply-To: <Zi6H5P_mc6DPR_v3@octinomon.home>
References: <Zi6H5P_mc6DPR_v3@octinomon.home>
Message-ID: <7EE9AB38-3103-4091-A558-BF0DEAF61E1D@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 28, 2024 10:31:16 AM PDT, Jules Irenge <jbi=2Eoctave@gmail=2Ecom> =
wrote:
>do_div() truncates a u64 divisor to 32 bit=2E
>This can lead to non-zero being truncated to zero for division=2E
>
>Fix coccinelle warning
>WARNING: do_div() does a 64-by-32 division, please consider using div64_u=
l instead
>
>Signed-off-by: Jules Irenge <jbi=2Eoctave@gmail=2Ecom>
>---
> arch/x86/kernel/tsc=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/kernel/tsc=2Ec b/arch/x86/kernel/tsc=2Ec
>index 5a69a49acc96=2E=2E2da37f33dd17 100644
>--- a/arch/x86/kernel/tsc=2Ec
>+++ b/arch/x86/kernel/tsc=2Ec
>@@ -484,7 +484,7 @@ static unsigned long pit_calibrate_tsc(u32 latch, uns=
igned long ms, int loopmin)
>=20
> 	/* Calculate the PIT value */
> 	delta =3D t2 - t1;
>-	do_div(delta, ms);
>+	div64_ul(delta, ms);
> 	return delta;
> }
>=20

Are you sure this is not a false positive? This is a *much* more expensive=
 operation on 32 bits=2E

