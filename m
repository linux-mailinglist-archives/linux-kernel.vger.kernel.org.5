Return-Path: <linux-kernel+bounces-44586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC07684248C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F61288945
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34B167A08;
	Tue, 30 Jan 2024 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b="nDl6kfhJ"
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E7E60888
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.91.1.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616719; cv=none; b=nuMKT+WKMCSjOk5Dh5cdzxMI8J67G0W89PnwuaTpqrq82d9PMbQkauYDCIa8btJug5ShbxTE40N79gAZgtGFDYliMaHWgg+H2j1+27TGo9JlmLLpG39ZpoRcRpuBOKmvbqkyOMTcVs0hUraawu82qbC2Eg2g19gxIqhgTeWuxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616719; c=relaxed/simple;
	bh=DR8mJtB7WNxNUhWRpsM7rBg5lln2GXOsSgg1uvNlsCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nle4lHGabnrbEudUiExVzbYi+ft0QpEle8FMEChGDMPh7wJruKe1IwOm3Jg+V5ntdsg73PgaiDXH0+4YiDdzgVB60iqR+/ODYphqGMdgL9lXvih4MAynfI0NelmkvijXU73z/AKlD/EbkkaKK/zoT8EBPZTccaiMdrRMrVPLD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr; spf=pass smtp.mailfrom=ics.forth.gr; dkim=pass (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b=nDl6kfhJ; arc=none smtp.client-ip=139.91.1.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ics.forth.gr
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
	by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 40UCBtMI004598
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:11:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
	q=dns/txt; i=@ics.forth.gr; t=1706616710; x=1709208710;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DR8mJtB7WNxNUhWRpsM7rBg5lln2GXOsSgg1uvNlsCg=;
	b=nDl6kfhJQ02DeGg5OawmcpY+NNvEqvjHZZvEeME3tplt54NNhE2GyHk0NNoA0+06
	OK3+K9AZhmhWMT8+q+PoPumK3WKzXmjpdq/o/lowGD4+Ysl/GC/tt2TIZwBdMrHy
	ZB+BSXO0RwEJvzhqqIV7HlKtUpRPKnbVffLKiOI6+Tu9cJFNg5txRR2f4fxgAjB0
	P8v4RepXzT/X1pvgkB0m4xKrGMkTpD2eh/5F1UZ6vfGUByldv+g2ilk9LPdbzlpr
	Mdm0hNYtABTf5DYiZSYuIQYkpHeXn1Sn0fX3MLfJVgOrgp1BvFApLT4d7Dvq7a3W
	+Vw1WUqApR2l3kIpDUtI1w==;
X-AuditID: 8b5b014d-a23ec70000002178-63-65b8e785d017
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
	by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 52.D1.08568.587E8B56; Tue, 30 Jan 2024 14:11:50 +0200 (EET)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <150b69a0-5f4e-49ce-af31-6a3f2cea02bf@ics.forth.gr>
Date: Tue, 30 Jan 2024 14:11:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] riscv: optimized memcpy
Content-Language: el-GR
To: Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt
 <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matteo Croce <mcroce@microsoft.com>, kernel test robot <lkp@intel.com>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240128111013.2450-2-jszhang@kernel.org>
From: Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <20240128111013.2450-2-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXSHT1dWbft+Y5Ug9cPmCy2/p7FbtF8bD2b
	xeVdc9gstn1uYbN41fyIzeLvr/+sFi8v9zBbtM3id+DwePPyJYvH4Y4v7B6L97xk8ti0qpPN
	Y/OSeo/WHX/ZPS41X2f3+LxJLoAjissmJTUnsyy1SN8ugSvj7rn4gncSFUtnfGFrYGwW6mLk
	5JAQMJFof/iKrYuRi0NI4CijxKWLuxkhEpYSmz+9ZAGxeQXsJU6c38UKYrMIqEpMmPKaGSIu
	KHFy5hOwGlEBeYn7t2awg9jCAgYSuw/sZgKxmQXEJY6c/80MskBEYCujxNZXb9lBHGaBSYwS
	k79+ApsqJJAs8eJcK9hUNgFNifmXDoJN5RQwl2j//o0VYpKZRNfWLkYIW15i+9s5zBMYBWYh
	OWQWkoWzkLTMQtKygJFlFaNAYpmxXmZysV5aflFJhl560SZGcGQw+u5gvL35rd4hRiYOxkOM
	EhzMSiK8PzW3pgrxpiRWVqUW5ccXleakFh9ilOZgURLnPWG7IFlIID2xJDU7NbUgtQgmy8TB
	KdXA1Ga7Unbr67dHfb9pPdnJq2jpF5Ewo6H/zdaY2epHDi7by+5weeOxSZfi5eXvvlO705Hs
	5KXzrn5LopDmlouh2zjSK09uijJeor/jQd4upr2rBKoe3khboczfUndh6R+7xa3hwifve9tU
	zci/L3mbOWpjZfDK/j0zph87dFA/o0D9/deHRTcNv/7cwirzYfbJKxX8385l3Hspx5z3Q8Ol
	8HH6Z+9Ny/wi2u0Od8s9LOBs05Yq3vj5mcv2Ls6TX4z/WHDN3lXgz9by6bfJ+YUSdiedTrF2
	cd+1+3JA+yjDU+k7TlNv8rQyeWnOk65ss5HWbu55aqFYdG2B/e6AnzUL09+HWnyQvj2H3/nt
	xEXqv5VYijMSDbWYi4oTAWG8Txb7AgAA

On 1/28/24 13:10, Jisheng Zhang wrote:
> +
> +void *__memcpy(void *dest, const void *src, size_t count)
> +{
> +	union const_types s = { .as_u8 = src };
> +	union types d = { .as_u8 = dest };
> +	int distance = 0;
> +
> +	if (count < MIN_THRESHOLD)
> +		goto copy_remainder;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
> +		/* Copy a byte at time until destination is aligned. */
> +		for (; d.as_uptr & WORD_MASK; count--)
> +			*d.as_u8++ = *s.as_u8++;
> +
> +		distance = s.as_uptr & WORD_MASK;
> +	}
> +
> +	if (distance) {
> +		unsigned long last, next;
> +
> +		/*
> +		 * s is distance bytes ahead of d, and d just reached
> +		 * the alignment boundary. Move s backward to word align it
> +		 * and shift data to compensate for distance, in order to do
> +		 * word-by-word copy.
> +		 */
> +		s.as_u8 -= distance;
> +
> +		next = s.as_ulong[0];
> +		for (; count >= BYTES_LONG; count -= BYTES_LONG) {
> +			last = next;
> +			next = s.as_ulong[1];
> +
> +			d.as_ulong[0] = last >> (distance * 8) |
> +					next << ((BYTES_LONG - distance) * 8);
> +
> +			d.as_ulong++;
> +			s.as_ulong++;
> +		}
> +
> +		/* Restore s with the original offset. */
> +		s.as_u8 += distance;
> +	} else {
> +		/*
> +		 * If the source and dest lower bits are the same, do a simple
> +		 * aligned copy.
> +		 */
> +		size_t aligned_count = count & ~(BYTES_LONG * 8 - 1);
> +
> +		__memcpy_aligned(d.as_ulong, s.as_ulong, aligned_count);
> +		d.as_u8 += aligned_count;
> +		s.as_u8 += aligned_count;
> +		count &= BYTES_LONG * 8 - 1;
> +	}
> +
> +copy_remainder:
> +	while (count--)
> +		*d.as_u8++ = *s.as_u8++;
> +
> +	return dest;
> +}
> +EXPORT_SYMBOL(__memcpy);
> +

We could also implement memcmp this way, e.g.:

int
memcmp(const void *s1, const void *s2, size_t len)
{
	union const_data a = { .as_bytes = s1 };
	union const_data b = { .as_bytes = s2 };
	unsigned long a_val = 0;
	unsigned long b_val = 0;
	size_t remaining = len;
	size_t a_offt = 0;

	/* Nothing to do */
	if (!s1 || !s2 || s1 == s2 || !len)
		return 0;

	if (len < 2 * WORD_SIZE)
		goto trailing_fw;

	for(; b.as_uptr & WORD_MASK; remaining--) {
		a_val = *a.as_bytes++;
		b_val = *b.as_bytes++;
		if (a_val != b_val)
			goto done;
	}

	a_offt = a.as_uptr & WORD_MASK;
	if (!a_offt) {
		for (; remaining >= WORD_SIZE; remaining -= WORD_SIZE) {
			a_val = *a.as_ulong++;
			b_val = *b.as_ulong++;
			if (a_val != b_val)
				break;

		}
	} else {
		unsigned long a_cur, a_next;
		a.as_bytes -= a_offt;
		a_next = *a.as_ulong;
		for (; remaining >= WORD_SIZE; remaining -= WORD_SIZE, b.as_ulong++) {
			a_cur = a_next;
			a_next = *++a.as_ulong;
			a_val = a_cur >> (a_offt * 8) |
				a_next << ((WORD_SIZE - a_offt) * 8);
			b_val = *b.as_ulong;
			if (a_val != b_val) {
				a.as_bytes += a_offt;
				break;
			}
		}
		a.as_bytes += a_offt;
	}

  trailing_fw:
	while (remaining-- > 0) {
		a_val = *a.as_bytes++;
		b_val = *b.as_bytes++;
		if (a_val != b_val)
			break;
	}

  done:
	if (!remaining)
		return 0;

	return (int) (a_val - b_val);
}

Regards,
Nick

