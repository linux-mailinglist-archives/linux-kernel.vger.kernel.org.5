Return-Path: <linux-kernel+bounces-68071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C6857599
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7BC1F24B96
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F4212E70;
	Fri, 16 Feb 2024 05:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1oezMxk"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E812E47;
	Fri, 16 Feb 2024 05:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708061105; cv=none; b=ewmZc3jYt+a8Dwmc5gqUPyoeGIxivvZHTjY0scA9PQm8Pn4V/n00BNsw6pNlEe01sEmLAgKb4FDUGP3yMX68xByIfVQcab3vg+oKkq/4BcCjxVxHRNffrMfiLCvoQEUiEPL3/F0vSH0WXvMG+kklxIglXHay+kNiyi1VGOyogm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708061105; c=relaxed/simple;
	bh=rUg6ZFfwUKtv14xjQgr7IX90k7VSLNddTK8RPxqtVdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ngv+MGupJvmC4SDl9ABBZ2WGK7En8x1aINqFR8hAJD1VwgusLwHNoOvOaTlytjxaf0eYxtK/cCxqowvk8XYiVOq0Bu5XJnsYjMYwHe0NlMntb0gA4n1ApL7GuW7AHVQDwNtq3qd6KIjYvOoDHJxdZf9L2KYWb2vKxYt6ErgRdfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1oezMxk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e0f4e3bc59so214852b3a.0;
        Thu, 15 Feb 2024 21:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708061103; x=1708665903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3mWIQ7D+pLVN07S5/RpUdrrZDU46psA9pYkkZCoUhY=;
        b=P1oezMxkWoW4Cltjq7BA5mIz458QreXXcMPdj0jz+uZIl+jgYeao/N2NziEl9uGfii
         ljgUHWmkLfD7aHUJCmcwHSJ41nRvQTsKxuQtiPn+LDqymJwI9P4jCznA7dvm/5BcTotT
         Mc302g2P3hnEjm1L/LrblobIgqOXnbBQjDFhX3vfa70Z92uL25410E2hKq9YHDL4wN1j
         efu6+2bDTuoXbO/aEo0VRoJMbB3o7gwkIt9cWLV+yvCP5rRVnqymlN8T+tL1XYKSDzB9
         SMNinVhaqugGTNkFzI5qWOvagNcW6VwHWxz5iKh13GYgoXliTRrQzVX/o2XkxGI16cH0
         VBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708061103; x=1708665903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3mWIQ7D+pLVN07S5/RpUdrrZDU46psA9pYkkZCoUhY=;
        b=NYl4v6DeKdFKSJfjtnTgO4fae50XcdSQ8KTN+GifwU6AY77/Uiv88CpmkeO7u0YHqO
         7OrZKqBvJeZ7amHFEYO/gFrLiendCKEJ9Kqinfs8C3oJYg4Jvy68e3iiHNF3ZiJipDBb
         iooIX/J9/TjtbOnrT4RtgkBa2ijZUKOc+xqTDMYYJD0CxDMCevasJIXZd8WTS+px2Zpp
         RxfLwF6zcyqhjiF4bN4TFUPR1+AcH+s0sa3jAmN+FV361hQqU6Tk1SEVZ5KUtItjcToY
         OufdMTL8ntw9J4rxqlcbdKOBkwntJ0jdXie8QEnbVKc3xytcJAmxf2A3bHT9c1PPgUil
         Bi/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXy4NOAoMfzVDx0wMJZRJXZpuKeSSpBYsp5dRihiTNEb9z+BZRAAS9PTzZO9cDi4SF2woHcwHeat8OKL9o+EuuxU5oQDqQLvg8BzS0q2X4yKMA78ou3oNusDfrmlEpLdLjwhczf5XfEqjYo
X-Gm-Message-State: AOJu0YzaaSFqULj4KTzFF8Nz0ysDM8bG2tQkZmw+MgwMCYQ0xunkW5Td
	gAM/LZE8jBra6mhSmVJirfLcGekLAzeRdpX3HJTKoIblWgPXRfOgvDX6N2Hm
X-Google-Smtp-Source: AGHT+IEDIbyxDQfttuCUZtaKqFdALB1hFroyepppIXLzFOSGpxGiR3GXf3WOqPK9ItuIJ4N3I+fAJw==
X-Received: by 2002:a05:6a20:c90a:b0:19c:ad6b:e1c2 with SMTP id gx10-20020a056a20c90a00b0019cad6be1c2mr4138691pzb.12.1708061102954;
        Thu, 15 Feb 2024 21:25:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902ed0500b001d9773a198esm2102486pld.201.2024.02.15.21.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 21:25:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 15 Feb 2024 21:25:00 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Helge Deller <deller@gmx.de>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Parisc List <linux-parisc@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <b8065a61-f5eb-4ec5-a9af-6d6bcdf1ee9b@roeck-us.net>
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net>
 <Zc1pSi59aDOnqz++@ghost>
 <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
 <25f108d1-827f-4a18-bee4-4105fbd45974@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25f108d1-827f-4a18-bee4-4105fbd45974@gmx.de>

On Fri, Feb 16, 2024 at 06:54:55AM +0100, Helge Deller wrote:
> 
> Can you please give a pointer to this test code?
> I'm happy to try it on real hardware.
> 
See below.

Guenter

---
From 0478f35f02224994e1d81e614b66219ab7539f7f Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 14 Feb 2024 11:25:18 -0800
Subject: [PATCH] carry tests

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 lib/checksum_kunit.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index 72c313ba4c78..8f7925396e53 100644
--- a/lib/checksum_kunit.c
+++ b/lib/checksum_kunit.c
@@ -546,12 +546,88 @@ static void test_csum_ipv6_magic(struct kunit *test)
 #endif /* !CONFIG_NET */
 }
 
+#ifdef CONFIG_64BIT
+
+static __inline__ int get_carry64(void *addr)
+{
+	int carry = 0;
+	unsigned long sum = 0xffffffff;
+	unsigned long tmp;
+
+	__asm__ __volatile__ (
+"	add	%0, %0, %0\n"	/* clear carry			*/
+"	ldd	0(%2), %3\n"	/* load from memory		*/
+"	add	%1, %3, %1\n"	/* optionally generate carry	*/
+"	ldd	0(%2), %3\n"	/* load from memory again	*/
+"	add,dc	%0, %0, %0\n"	/* return carry			*/
+	: "=r" (carry), "=r" (sum), "=r" (addr), "=r" (tmp)
+	: "0" (carry), "1" (sum), "2" (addr)
+	: "memory");
+
+	return carry;
+}
+
+static __inline__ int get_carry32(void *addr)
+{
+	int carry = 0;
+	unsigned int sum = 0xffffffff;
+	unsigned int tmp;
+
+	__asm__ __volatile__ (
+"	add	%0, %0, %0\n"	/* clear carry			*/
+"	ldw	0(%2), %3\n"	/* load from memory		*/
+"	add	%1, %3, %1\n"	/* optionally generate carry	*/
+"	ldw	0(%2), %3\n"	/* load from memory again	*/
+"	addc	%0, %0, %0\n"	/* return carry			*/
+	: "=r" (carry), "=r" (sum), "=r" (addr), "=r" (tmp)
+	: "0" (carry), "1" (sum), "2" (addr)
+	: "memory");
+
+	return carry;
+}
+
+static void test_bad_carry(struct kunit *test)
+{
+	int carry;
+
+	memset(tmp_buf, 0xff, sizeof(tmp_buf));
+	carry = get_carry64(&tmp_buf[0]);
+	pr_info("#### carry64 aligned, expect 1 -> %d\n", carry);
+	carry = get_carry64(&tmp_buf[4]);
+	pr_info("#### carry64 unaligned 4, expect 1 -> %d\n", carry);
+
+	carry = get_carry64(&tmp_buf[2]);
+	pr_info("#### carry64 unaligned 2, expect 1 -> %d\n", carry);
+
+	carry = get_carry32(&tmp_buf[0]);
+	pr_info("#### carry32 aligned, expect 1 -> %d\n", carry);
+	carry = get_carry32(&tmp_buf[2]);
+	pr_info("#### carry64 unaligned, expect 1 -> %d\n", carry);
+
+	memset(tmp_buf, 0, sizeof(tmp_buf));
+	carry = get_carry64(&tmp_buf[0]);
+	pr_info("#### carry64 aligned, expect 0 -> %d\n", carry);
+	carry = get_carry64(&tmp_buf[4]);
+	pr_info("#### carry64 unaligned 4, expect 0 -> %d\n", carry);
+	carry = get_carry64(&tmp_buf[2]);
+	pr_info("#### carry64 unaligned 2, expect 0 -> %d\n", carry);
+
+	carry = get_carry32(&tmp_buf[0]);
+	pr_info("#### carry32 aligned, expect 0 -> %d\n", carry);
+	carry = get_carry32(&tmp_buf[2]);
+	pr_info("#### carry32 unaligned, expect 0 -> %d\n", carry);
+}
+#else
+static void test_bad_carry(struct kunit *test) {}
+#endif /* CONFIG_64BIT */
+
 static struct kunit_case __refdata checksum_test_cases[] = {
 	KUNIT_CASE(test_csum_fixed_random_inputs),
 	KUNIT_CASE(test_csum_all_carry_inputs),
 	KUNIT_CASE(test_csum_no_carry_inputs),
 	KUNIT_CASE(test_ip_fast_csum),
 	KUNIT_CASE(test_csum_ipv6_magic),
+	KUNIT_CASE(test_bad_carry),
 	{}
 };
 
-- 
2.39.2


