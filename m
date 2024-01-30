Return-Path: <linux-kernel+bounces-44581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B684249A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B74B2EE8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F5867E7B;
	Tue, 30 Jan 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b="CHdy3mk5"
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6C679EF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.91.1.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616473; cv=none; b=Rvdrp1pz3XhqKR1BZcJ1ExVNEfd5kSL2o2uLrSsxbhFE8jJ5BhtMPzrA7jASFNS7nGB5twGy84foUEVqlVxBB6UGV45Xf9fRS8Gvz3EZc9RaSaoY2H51wnpULYvp/X+YumGJqJ71/H0+Ydlvwd0f3oD6WVKfWBb9uLbgkgMCR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616473; c=relaxed/simple;
	bh=Iq4El0XupAdJ9EMVA4rv5oTgmdh7tQX13verRpi39oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bb/HFxHp+bDEKRLoitBdvS4CmGOiYtU1wyaNE+4vWgbhIAjMcTSYQ5n0OF5Kl3d21QOPt9GCxva7dYyhQhp/90sOs1Xm2u45FZjSDBNHtRMXIRmSFDaABLa2ITvdT6wmbgt+0fx2kId3k5KVBh3KvfEQcPQ6pPzU8dnhRapBd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr; spf=pass smtp.mailfrom=ics.forth.gr; dkim=pass (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b=CHdy3mk5; arc=none smtp.client-ip=139.91.1.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ics.forth.gr
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
	by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 40UC7mdS004455
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:07:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
	q=dns/txt; i=@ics.forth.gr; t=1706616463; x=1709208463;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Iq4El0XupAdJ9EMVA4rv5oTgmdh7tQX13verRpi39oo=;
	b=CHdy3mk5F4tOU97XzSzXGQavQKwBFR4D+11W2UOQRa4bKsd730xr4qEgV3PNHrgi
	G/fisWOMS09IhzoFkEVWDGK+iRAHm+CX55sS29DmuKJgVBcvuYuiO/NZZbzaxKV0
	P2CcKbxoT6Aa5hvTshClLGVC5PbBC76NiCMFChl8g6Konpd152Z2Tf9yyzSWDDtU
	DOtNDJ0AWwqdmKkmuDYyVeVbAVOEhhJQyru9USxruIZmDIorPqr3Kuym0zV2QSh5
	4ihjBpmLY+Bu3AR4Iklw1OVph2LF4tmWIxVuwl3kWCaXws8pPVgLW/Oz9+4J5n7J
	qGxg08BG/oSg1IginLhMnQ==;
X-AuditID: 8b5b014d-a17eb70000002178-22-65b8e68eb329
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
	by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 79.C1.08568.E86E8B56; Tue, 30 Jan 2024 14:07:42 +0200 (EET)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <b7ae944c-2b7c-4c8d-8623-a8387b8d4e02@ics.forth.gr>
Date: Tue, 30 Jan 2024 14:07:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] riscv: optimized memset
Content-Language: el-GR
To: Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt
 <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matteo Croce <mcroce@microsoft.com>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240128111013.2450-4-jszhang@kernel.org>
From: Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <20240128111013.2450-4-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXSHT1dWbfv2Y5Ug4P7LSy2/p7FbtF8bD2b
	xeVdc9gstn1uYbP4++s/q8XLyz3MFm2z+B3YPd68fMnicbjjC7vHplWdbB6bl9R7tO74y+5x
	qfk6u8fnTXIB7FFcNimpOZllqUX6dglcGUc/NDIXrBWrmDG9h7GBcYFgFyMnh4SAicT89iUs
	XYxcHEICRxkljj7cywiRsJTY/OklC4jNK2AvcXPKW2YQm0VAVeL5+ymMEHFBiZMzn4DViArI
	S9y/NYMdxBYWMJCYeK4frJ5ZQFziyPnfzCALRAS2MkpsffWWHSKRL7GkbQHYICGBZImnKy6A
	DWIT0JSYf+kgmM0pYC7x8fg+Joh6M4murV2MELa8xPa3c5gnMArMQnLHLCT7ZiFpmYWkZQEj
	yypGgcQyY73M5GK9tPyikgy99KJNjOAoYPTdwXh781u9Q4xMHIyHGCU4mJVEeH9qbk0V4k1J
	rKxKLcqPLyrNSS0+xCjNwaIkznvCdkGykEB6YklqdmpqQWoRTJaJg1Oqgan9657llraK/57O
	4z1YprTuYdGPkiUfS0+LCm5+MaEyM2uxr8ftyVmfPu42Uua8z8eko2vU894xXeCefZJJlbHH
	ga7X/zq0+tyOmQar7He48cCh6vnypRtztd4WSPF+yshgWSMuufippH9h1czjH9Oep5/f+7Hf
	Q9Z3568K6Rqjq66fvh1vUbrG0fubWSh5d2XgDs3uVyWr5k2Kz/p+x+FE281ZH15F+ShMtOuz
	myE+UU25cH9T8/1LLR/KXNTytJ5kpW3/FxNfsWBKYYjbnHM3Mp4eFD9r8cWivfz8X+7yIAHB
	E1dfeK1PiVz5L/1PvcCvl2f9zTasNuZbLxFmE/nklKZD4YGL65+unro+yE+JpTgj0VCLuag4
	EQCq+/Hb8QIAAA==

On 1/28/24 13:10, Jisheng Zhang wrote:
> diff --git a/arch/riscv/lib/string.c b/arch/riscv/lib/string.c
> index 20677c8067da..022edda68f1c 100644
> --- a/arch/riscv/lib/string.c
> +++ b/arch/riscv/lib/string.c
> @@ -144,3 +144,44 @@ void *memmove(void *dest, const void *src, size_t count) __weak __alias(__memmov
>   EXPORT_SYMBOL(memmove);
>   void *__pi_memmove(void *dest, const void *src, size_t count) __alias(__memmove);
>   void *__pi___memmove(void *dest, const void *src, size_t count) __alias(__memmove);
> +
> +void *__memset(void *s, int c, size_t count)
> +{
> +	union types dest = { .as_u8 = s };
> +
> +	if (count >= MIN_THRESHOLD) {
> +		unsigned long cu = (unsigned long)c;
> +
> +		/* Compose an ulong with 'c' repeated 4/8 times */
> +#ifdef CONFIG_ARCH_HAS_FAST_MULTIPLIER
> +		cu *= 0x0101010101010101UL;
> +#else
> +		cu |= cu << 8;
> +		cu |= cu << 16;
> +		/* Suppress warning on 32 bit machines */
> +		cu |= (cu << 16) << 16;
> +#endif

I guess you could check against __SIZEOF_LONG__ here.

> +		if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
> +			/*
> +			 * Fill the buffer one byte at time until
> +			 * the destination is word aligned.
> +			 */
> +			for (; count && dest.as_uptr & WORD_MASK; count--)
> +				*dest.as_u8++ = c;
> +		}
> +
> +		/* Copy using the largest size allowed */
> +		for (; count >= BYTES_LONG; count -= BYTES_LONG)
> +			*dest.as_ulong++ = cu;
> +	}
> +
> +	/* copy the remainder */
> +	while (count--)
> +		*dest.as_u8++ = c;
> +
> +	return s;
> +}
> +EXPORT_SYMBOL(__memset);

BTW a similar approach could be used for memchr, e.g.:

#if __SIZEOF_LONG__ == 8
#define HAS_ZERO(_x) (((_x) - 0x0101010101010101ULL) & ~(_x) & 
0x8080808080808080ULL)
#else
#define HAS_ZERO(_x) (((_x) - 0x01010101UL) & ~(_x) & 0x80808080UL)
#endif

void *
memchr(const void *src_ptr, int c, size_t len)
{
	union const_data src = { .as_bytes = src_ptr };
	unsigned char byte = (unsigned char) c;
	unsigned long mask = (unsigned long) c;
	size_t remaining = len;

	/* Nothing to do */
	if (!src_ptr || !len)
		return NULL;

	if (len < 2 * WORD_SIZE)
		goto trailing;

	mask |= mask << 8;
	mask |= mask << 16;
#if __SIZEOF_LONG__ == 8
	mask |= mask << 32;
#endif

	/* Search by byte up to the src's alignment boundary */
	for(; src.as_uptr & WORD_MASK; remaining--, src.as_bytes++) {
		if (*src.as_bytes == byte)
			return (void*) src.as_bytes;
	}

	/* Search word by word using the mask */
	for(; remaining >= WORD_SIZE; remaining -= WORD_SIZE, src.as_ulong++) {
		unsigned long check = *src.as_ulong ^ mask;
		if(HAS_ZERO(check))
			break;
	}

  trailing:
	for(; remaining > 0; remaining--, src.as_bytes++) {
		if (*src.as_bytes == byte)
			return (void*) src.as_bytes;
	}

	return NULL;
}

Regards,
Nick

