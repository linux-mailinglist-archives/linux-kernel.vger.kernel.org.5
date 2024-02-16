Return-Path: <linux-kernel+bounces-68110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ED9857619
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233C41C22742
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495E114290;
	Fri, 16 Feb 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="FVYsROmv"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2313FF9;
	Fri, 16 Feb 2024 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708065772; cv=none; b=itdwxkWPPkVUt508/vFYHpqROfp5+RKGwDmyHJdQEO+rGca6cz9W03Hg12g7MonnJY0HulOWijqlqkkGJwTyKYetHkhpCzPT+ry+WWXdVsOnS12XGKKMBRw7Y5EolRI06eklt+nNJKFJRQ3A7vz7OZf4GCD4Ygk0bsQWpZOVdyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708065772; c=relaxed/simple;
	bh=+ppAndhy56yHpAB08Sissrk+DRqOIFueYsJJQrGan+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqnwHRjCMag7OJFb7kM11nNV7F71TW4gEMHzGkNFxr+E8519cHrfVn7tVRrIHUwo9IzqKJwijWu5Ed6clgrVLgVat0mH7KUjMmLOFxtzSVvZqsuWSvEUvRF5RsKl2KTFonXEIFzg43zmjt1Bc+XylJCNI+t71FA+IW2DI8V0nVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=FVYsROmv; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708065749; x=1708670549; i=deller@gmx.de;
	bh=+ppAndhy56yHpAB08Sissrk+DRqOIFueYsJJQrGan+4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=FVYsROmv0Mk2RKVnNhrqNIgzV2nLCammBvybq31nRfh5RyHD5EFTeRLXxVt4dppy
	 qzqDbtEU24HQYDvMg+cruG7gV1TTVa7yGpLRpjTYRQWXPBtBzRQA2VQCyKByxdXFV
	 EOeLYU6h3X3bd1TPSvLOK6G0UF5KOL2EWp51afvucZ88PMG6NIyu36qu1vvlRFRuT
	 2kzjVM5N5A6bAI8ULqPS3B0StYqgIU+CnCAlaqLQOVC70DqhUaqLFlMMV1Ua9kXE3
	 p20+Q17p4Ka1kingh9uOFBv1GfJC2YvVZkZmtSmBulV4lfJz48y7SBN2E1fGl2MKT
	 mD73uR95UNPduej2Cg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.214]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1qq5mA1fUB-012ozJ; Fri, 16
 Feb 2024 07:42:29 +0100
Message-ID: <7b207808-10e7-44b0-9a9f-253e2349011d@gmx.de>
Date: Fri, 16 Feb 2024 08:31:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net> <Zc1pSi59aDOnqz++@ghost>
 <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
 <25f108d1-827f-4a18-bee4-4105fbd45974@gmx.de>
 <b8065a61-f5eb-4ec5-a9af-6d6bcdf1ee9b@roeck-us.net>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <b8065a61-f5eb-4ec5-a9af-6d6bcdf1ee9b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qpXBod9bXxS2T8jn9XN6dbwuj5M+rRQo/Ok/2qBy1QSdbTwhlsZ
 Uz8ROPCQIByE4gloE6TKAtrU4bPf9A9hsMUe2j0vKSZMLjOqiz2PxlTVJiF/f+xTh5IHstx
 lTpWlA2tSf6m/btenXKImyHSnMIWMJqYRgh1buKqD8pZt4rufNm4CWoKvKjPnW+R5hXF1Ds
 MZSoOZ/GPduU0XtVDkOqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SqHXkZsnsPA=;2CY5VvjB4RPL+Gwuy7KiKeraDUy
 8Uvs8XioprXTdnmhU9QqOXYhQFj5cnZKd2z10yZ+f0IK3001/0hRMZeLOSEnP0DbipJ4eJZZc
 jQI0tEt/3VzcvYkF0lH8s+9FPwEVIVsiRZJniX4Stn4wAiYYuhjWvQftskJr0rSODe0az4swi
 GwANnm4F9gilCUyM+VmZv0tyt3X8ap4aUWBf++ApJYYYSo3557Fph1ezr/tvxYa+t7laeTcIg
 Rt5kOtRYunjTkKPjle69Aa5uPXBblq53WYizxmRRnAPJwzLndu+x0J1ZyVmDsg2iu6eg9yj3x
 Qhj+tV2rbOe7y/qCDksV4Z7tjcYvRNpLEV4Lkh8KsdLC4kaRfudYcrsbbjm0BDgFrs0IvOLLM
 Ya/qaYQQB7ZVq95E1O4XFFu7G++2PtbFG0Ja1U2aCBub2qk0nPJ8V+8mLhniECHTugTFu2d2W
 6xPnubS/xUBqfHF09zqTOOuXYgoLSxZPtjxlUnZKhqfMvMO/OqoxJDfC97pzWyG/ZWXADv898
 XTOCZwWJ2kZee7pQRVBfiF4jZT+eY32NRMsZtDgHWtrd76CSmwoj4z2WCthcWxjgxVFy2DZdZ
 Qnc9KkC7V657Vsev2LiZixXoS3kYExkqC9uGfkkZ8SH5MYZOGfRJupRWttGdmPtwXCI/KJ2Tr
 /gp4uJJAcdXHdfMRaZO/Vr8wyEihNK2kY06oeBzuARyfioz1Uzv0CPb4DQrz9SZRU0qquehiP
 WFMTojctz/ABwo1kOfIiOJvbBoOkVEIwo49rEulcuPDaY7tu3XBdQWtydwkBHQI6tyu7g2tSL
 aNyfyVJfJY59StyXAPUbN1UeNLIGNZuM0gIp68Cpf7VWg=

On 2/16/24 06:25, Guenter Roeck wrote:
> On Fri, Feb 16, 2024 at 06:54:55AM +0100, Helge Deller wrote:
>>
>> Can you please give a pointer to this test code?
>> I'm happy to try it on real hardware.
>>
> See below.

Testcase runs OK on physical machine:

#### carry64 aligned, expect 1 -> 1
#### carry64 unaligned 4, expect 1 -> 1
#### carry64 unaligned 2, expect 1 -> 1
#### carry32 aligned, expect 1 -> 1
#### carry64 unaligned, expect 1 -> 1
#### carry64 aligned, expect 0 -> 0
#### carry64 unaligned 4, expect 0 -> 0
#### carry64 unaligned 2, expect 0 -> 0
#### carry32 aligned, expect 0 -> 0
#### carry32 unaligned, expect 0 -> 0
     ok 6 test_bad_carry

Helge

> ---
>  From 0478f35f02224994e1d81e614b66219ab7539f7f Mon Sep 17 00:00:00 2001
> From: Guenter Roeck <linux@roeck-us.net>
> Date: Wed, 14 Feb 2024 11:25:18 -0800
> Subject: [PATCH] carry tests
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   lib/checksum_kunit.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
>
> diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
> index 72c313ba4c78..8f7925396e53 100644
> --- a/lib/checksum_kunit.c
> +++ b/lib/checksum_kunit.c
> @@ -546,12 +546,88 @@ static void test_csum_ipv6_magic(struct kunit *tes=
t)
>   #endif /* !CONFIG_NET */
>   }
>
> +#ifdef CONFIG_64BIT
> +
> +static __inline__ int get_carry64(void *addr)
> +{
> +	int carry =3D 0;
> +	unsigned long sum =3D 0xffffffff;
> +	unsigned long tmp;
> +
> +	__asm__ __volatile__ (
> +"	add	%0, %0, %0\n"	/* clear carry			*/
> +"	ldd	0(%2), %3\n"	/* load from memory		*/
> +"	add	%1, %3, %1\n"	/* optionally generate carry	*/
> +"	ldd	0(%2), %3\n"	/* load from memory again	*/
> +"	add,dc	%0, %0, %0\n"	/* return carry			*/
> +	: "=3Dr" (carry), "=3Dr" (sum), "=3Dr" (addr), "=3Dr" (tmp)
> +	: "0" (carry), "1" (sum), "2" (addr)
> +	: "memory");
> +
> +	return carry;
> +}
> +
> +static __inline__ int get_carry32(void *addr)
> +{
> +	int carry =3D 0;
> +	unsigned int sum =3D 0xffffffff;
> +	unsigned int tmp;
> +
> +	__asm__ __volatile__ (
> +"	add	%0, %0, %0\n"	/* clear carry			*/
> +"	ldw	0(%2), %3\n"	/* load from memory		*/
> +"	add	%1, %3, %1\n"	/* optionally generate carry	*/
> +"	ldw	0(%2), %3\n"	/* load from memory again	*/
> +"	addc	%0, %0, %0\n"	/* return carry			*/
> +	: "=3Dr" (carry), "=3Dr" (sum), "=3Dr" (addr), "=3Dr" (tmp)
> +	: "0" (carry), "1" (sum), "2" (addr)
> +	: "memory");
> +
> +	return carry;
> +}
> +
> +static void test_bad_carry(struct kunit *test)
> +{
> +	int carry;
> +
> +	memset(tmp_buf, 0xff, sizeof(tmp_buf));
> +	carry =3D get_carry64(&tmp_buf[0]);
> +	pr_info("#### carry64 aligned, expect 1 -> %d\n", carry);
> +	carry =3D get_carry64(&tmp_buf[4]);
> +	pr_info("#### carry64 unaligned 4, expect 1 -> %d\n", carry);
> +
> +	carry =3D get_carry64(&tmp_buf[2]);
> +	pr_info("#### carry64 unaligned 2, expect 1 -> %d\n", carry);
> +
> +	carry =3D get_carry32(&tmp_buf[0]);
> +	pr_info("#### carry32 aligned, expect 1 -> %d\n", carry);
> +	carry =3D get_carry32(&tmp_buf[2]);
> +	pr_info("#### carry64 unaligned, expect 1 -> %d\n", carry);
> +
> +	memset(tmp_buf, 0, sizeof(tmp_buf));
> +	carry =3D get_carry64(&tmp_buf[0]);
> +	pr_info("#### carry64 aligned, expect 0 -> %d\n", carry);
> +	carry =3D get_carry64(&tmp_buf[4]);
> +	pr_info("#### carry64 unaligned 4, expect 0 -> %d\n", carry);
> +	carry =3D get_carry64(&tmp_buf[2]);
> +	pr_info("#### carry64 unaligned 2, expect 0 -> %d\n", carry);
> +
> +	carry =3D get_carry32(&tmp_buf[0]);
> +	pr_info("#### carry32 aligned, expect 0 -> %d\n", carry);
> +	carry =3D get_carry32(&tmp_buf[2]);
> +	pr_info("#### carry32 unaligned, expect 0 -> %d\n", carry);
> +}
> +#else
> +static void test_bad_carry(struct kunit *test) {}
> +#endif /* CONFIG_64BIT */
> +
>   static struct kunit_case __refdata checksum_test_cases[] =3D {
>   	KUNIT_CASE(test_csum_fixed_random_inputs),
>   	KUNIT_CASE(test_csum_all_carry_inputs),
>   	KUNIT_CASE(test_csum_no_carry_inputs),
>   	KUNIT_CASE(test_ip_fast_csum),
>   	KUNIT_CASE(test_csum_ipv6_magic),
> +	KUNIT_CASE(test_bad_carry),
>   	{}
>   };
>


