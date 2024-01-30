Return-Path: <linux-kernel+bounces-44544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47215842401
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31D8287D71
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5699A679F2;
	Tue, 30 Jan 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b="bGzFyDI1"
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E1866B5B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.91.1.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615109; cv=none; b=F3bdp7yYlXHYV60rGYHcEw0DcMgra4PalzrH/PT2/K648isvlNXWNg3UuMSaxxtri+8FpDqf7BLd3fyy6wIrOOLFamHtx+Gs07pdtwXuHg1KGDKO5tgZ+scKTzw1vnuiBFdFtps/fOxy78BG7DrkcLP6TDxX8N2eG6KR6gAz04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615109; c=relaxed/simple;
	bh=5S10mTZhZbQFsJIaNUVqS3Tw0Ln3OPHQISVKPpP1DH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYGnqMlZNDrLwh1pZtdxPhg5+f+/UvfEdHMFGzyMwrhPvuWlEl4J1KVr2rszC71jVgSIdKeBS4cBTQL6z041NfQeA1N685cYxIFTfWqWMf21XMbdCAz2/Z8PNP+DEswZEaNpFFVqsDsziXBFP9i73bYsr4vvi9UdqjYipQyU0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr; spf=pass smtp.mailfrom=ics.forth.gr; dkim=pass (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b=bGzFyDI1; arc=none smtp.client-ip=139.91.1.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ics.forth.gr
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
	by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 40UBdFrK003642
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:39:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
	q=dns/txt; i=@ics.forth.gr; t=1706614760; x=1709206760;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5S10mTZhZbQFsJIaNUVqS3Tw0Ln3OPHQISVKPpP1DH0=;
	b=bGzFyDI1hgZjW/BNzyYMSkN6f7dy/0ICzqVsXoXa39feXN+oKyTNU65lm9rUh9E3
	J8hcVp4VH9GZbUAonayFCSEG1wan8nT5WnsnYPPSqaWd5z342lTBpY5TQ/FAo0/o
	GH8olK3wGaB0VZ9wJrGWUuae46+ZAvgGbH7vxLaQ5OxAkhGUj9iwJ+PD1cbTxoU9
	qct0kmC3fSfgkya6UU8BopS+oXr78gFwBQgxkwGZ5mZeZCpXcXU0qkCtPQNT1L9i
	hE8qaOFtNeF/2zAkE/Dz1awjXvtvoGe0qeT+mNZkFx6ztsDex69GcbnuB+RvR2m/
	h9no2V6FOB21fo599aeV2A==;
X-AuditID: 8b5b014d-a23ec70000002178-80-65b8dfe81b6b
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
	by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 71.91.08568.8EFD8B56; Tue, 30 Jan 2024 13:39:20 +0200 (EET)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <fa36b871-43d7-413c-82a2-0ecc0ebce9b4@ics.forth.gr>
Date: Tue, 30 Jan 2024 13:39:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] riscv: optimized memmove
To: Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt
 <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matteo Croce <mcroce@microsoft.com>, kernel test robot <lkp@intel.com>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240128111013.2450-3-jszhang@kernel.org>
Content-Language: el-GR
From: Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <20240128111013.2450-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXSHT1dWffF/R2pBru3KVps/T2L3aL52Ho2
	i8u75rBZbPvcwmbxqvkRm8XfX/9ZLV5e7mG2aJvF78Dh8eblSxaPwx1f2D0W73nJ5LFpVSeb
	x+Yl9R6tO/6ye1xqvs7u8XmTXABHFJdNSmpOZllqkb5dAlfGrO6ygjPCFb/fZTQwLufvYuTg
	kBAwkXi726eLkYtDSOAoo8TR3g72LkZOoLilxOZPL1lAbF4Be4mWg9PZQGwWAVWJOWtPMUPE
	BSVOznwCViMqIC9x/9YMdpCZwgKGErtvV4LMFBHYyiix9dVbdhCHWWASo8Tkr59YQYqEBJIl
	Hn+3BellFhCXOHL+N9hMNgFNifmXDoLN5BQwl+ia8YAVosZMomtrFyOELS+x/e0c5gmMArOQ
	nDELyahZSFpmIWlZwMiyilEgscxYLzO5WC8tv6gkQy+9aBMjOCIYfXcw3t78Vu8QIxMH4yFG
	CQ5mJRHen5pbU4V4UxIrq1KL8uOLSnNSiw8xSnOwKInznrBdkCwkkJ5YkpqdmlqQWgSTZeLg
	lGpgiv3TdzOY44tz/7NOfz9mpx7OT7wXiy0Df+YkaJ5TX3k0dNFhzUU9tT+bfrF1bJzuvmGL
	xZuFjIKdxe9XblAWrTqwdNqWubLGgkJ7N6XzTKl32hKlLKJ1qObp5bctbkEP3zOnXti6+f5K
	7ttLGtuetSUtUzzBEbbH6fZE3buHo+sffbRql9+TzVjSWZZ+e+HSj21rr7R6eWW6mP0OTFNy
	PpH14c/NdXHF99h+z46TaD+05JB1Pau4yPmbTndS2Qr+5fdd/8XF0NB+PJ13ym8JE5e6ojUP
	Vx73e3Bw4n6nb0ncvS/yXobPdrbqu+yhfM5znfrDbyH2l49cUlh5UP/JteOeVxmF1D78rDqi
	mP4zSYmlOCPRUIu5qDgRAOLlaxz3AgAA

On 1/28/24 13:10, Jisheng Zhang wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> When the destination buffer is before the source one, or when the
> buffers doesn't overlap, it's safe to use memcpy() instead, which is
> optimized to use a bigger data size possible.
> 
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

I'd expect to have memmove handle both fw/bw copying and then memcpy 
being an alias to memmove, to also take care when regions overlap and 
avoid undefined behavior.


> --- a/arch/riscv/lib/string.c
> +++ b/arch/riscv/lib/string.c
> @@ -119,3 +119,28 @@ void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy)
>   EXPORT_SYMBOL(memcpy);
>   void *__pi_memcpy(void *dest, const void *src, size_t count) __alias(__memcpy);
>   void *__pi___memcpy(void *dest, const void *src, size_t count) __alias(__memcpy);
> +
> +/*
> + * Simply check if the buffer overlaps an call memcpy() in case,
> + * otherwise do a simple one byte at time backward copy.
> + */
> +void *__memmove(void *dest, const void *src, size_t count)
> +{
> +	if (dest < src || src + count <= dest)
> +		return __memcpy(dest, src, count);
> +
> +	if (dest > src) {
> +		const char *s = src + count;
> +		char *tmp = dest + count;
> +
> +		while (count--)
> +			*--tmp = *--s;
> +	}
> +	return dest;
> +}
> +EXPORT_SYMBOL(__memmove);
> +

Here is an approach for the backwards case to get things started...

static void
copy_bw(void *dst_ptr, const void *src_ptr, size_t len)
{
	union const_data src = { .as_bytes = src_ptr + len };
	union data dst = { .as_bytes = dst_ptr + len };
	size_t remaining = len;
	size_t src_offt = 0;

	if (len < 2 * WORD_SIZE)
		goto trailing_bw;

	for(; dst.as_uptr & WORD_MASK; remaining--)
		*--dst.as_bytes = *--src.as_bytes;

	src_offt = src.as_uptr & WORD_MASK;
	if (!src_offt) {
		for (; remaining >= WORD_SIZE; remaining -= WORD_SIZE)
			*--dst.as_ulong = *--src.as_ulong;
	} else {
		unsigned long cur, prev;
		src.as_bytes -= src_offt;
		for (; remaining >= WORD_SIZE; remaining -= WORD_SIZE) {
			cur = *src.as_ulong;
			prev = *--src.as_ulong;
			*--dst.as_ulong = cur << ((WORD_SIZE - src_offt) * 8) |
					  prev >> (src_offt * 8);
		}
		src.as_bytes += src_offt;
	}

  trailing_bw:
	while (remaining-- > 0)
		*--dst.as_bytes = *--src.as_bytes;
}

Regards,
Nick

