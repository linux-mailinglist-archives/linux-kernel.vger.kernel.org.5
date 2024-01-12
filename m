Return-Path: <linux-kernel+bounces-24189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44C082B8C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3EF1F24E20
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5657C81C;
	Fri, 12 Jan 2024 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nvw7rRSi"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37214657
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28cec7ae594so4907610a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705020540; x=1705625340; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JelUZkP5gzSzq1BGY+RoKqSc/xeLIVQS1YkCDnW4VYI=;
        b=Nvw7rRSiRhhixp8FUmd3X7FOHWEo2Glswn17hDthB67rN26QCGzYSRFMtTrISEvvm9
         +cG8kklUyiEHLObpKBgwDBcpSVJQkRtreAdNQliCN3/MsCRhnh++5eScEC6ePKVHxCdH
         +icqbKXilydb5Nt/jjx3Vz3idwSQAhISDQ4OpIDqZcEZKxjAujY4D8v4RrhmA9AKWSGN
         /vZ5phQe4orcgGSN84RBImv/sD5trS5D0C9arCO/x9KvU8glh8gaTPegQME0tMPMdcHh
         rrnSoeHQjiFgBdIVXFSnrFx2PP6jJSUm2yd0YbSEcb4bGgzJPU1OdjhEKJM8zkqwpq5c
         6Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705020540; x=1705625340;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JelUZkP5gzSzq1BGY+RoKqSc/xeLIVQS1YkCDnW4VYI=;
        b=STukxH3KElf00FRexKHPk0N87v6AUoIO954Nuxp8GCXxU8bUoaEEaaazfs44nPZJrB
         O4+IYwGhEVcZdc54DAOtgWgWwT67Ta6lK5S9njqUOQUlBBRp7hrCsW5dijk3MbvgG6ld
         JVK4jm6/V3BdljpYa7Ae1ersbb0DyJjGjqsrbnIXlhg6mK/DOrrz29ko1jcDrA9lOy/w
         cGAIigGEOsfLJCNRiuQOxbl42WMKbkHCW2zE2Towg9ls2HGEAvkHGYtLzVZwnmtvSKiZ
         r0eGx80ejOVToWICVbpn6qZaGHZbQRRebaU7Rgkvt/l9KBXW7G9yohfD3MKhSysMcUj7
         2RGg==
X-Gm-Message-State: AOJu0YyvhtgsOQVJLyGZVSAO5UY7YZ5tC0+R2hVVwQls3LWSqCk9nENy
	b+IzCo+Y5qBxIezaQ6LHdEFZ/wJvNRZLLA==
X-Google-Smtp-Source: AGHT+IEqcFkyZMbMTtgQE90DfUJQHB5WqCQhsY9hjzYgUY5O69TSooP92vAUC0w6CH1OxX9HOQDJqg==
X-Received: by 2002:a17:90b:4f46:b0:28c:90e:1b4c with SMTP id pj6-20020a17090b4f4600b0028c090e1b4cmr577169pjb.5.1705020539984;
        Thu, 11 Jan 2024 16:48:59 -0800 (PST)
Received: from smtpclient.apple ([187.120.157.179])
        by smtp.gmail.com with ESMTPSA id oe4-20020a17090b394400b0028e04eb997dsm260486pjb.4.2024.01.11.16.48.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jan 2024 16:48:59 -0800 (PST)
From: =?utf-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: new library
Message-Id: <5AFF5BF9-BD11-4A60-BD42-7EC516164D41@gmail.com>
Date: Thu, 11 Jan 2024 21:48:46 -0300
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3774.200.91.1.1)

 Hi,

im a software developer and i have been studying and writing device =
drivers on an amateur basis.

I discovered that the float points are not easy to work in kernel land, =
for an obvious reason: Each CPU has a its owner way dealing with float =
points in FPU,

and somes CPUs don't have an FPU.

Although, with the kernel_fpu_begin/end, I can do arithmetic with float =
points....

But i wanted to show this in printk(), and unless im very mistaken this =
is not possible. What i can do is show a float point as an int number.

For ex: 12.34, changed to 1234. In dmesg output: [123432] 1234.


This is make never implemented, because probably dealing with floating =
points at the kernel land is extremely rare.

But, in my kernel fork I writed a library to change an integer number, =
to string with float point.

For ex: 1234 -> "12.34", and i show this in dmesg output: [09876] 12.34


I really don't know if this is useful, but here it is my initial =
sugestion is


include/linux/int2fpstr.h ++++++++


+ #ifndef _LINUX_INT2FPSTR_H
+ #define _LINUX_INT2FPSTR_H
+
+ #include <linux/kernel.h>
+ #include <linux/slab.h>
+ #include <linux/string.h>
+
+ inline __kernel_size_t size_alloc(int number)
+ {
+     const int neg =3D  number < 0;
+     if(neg) number *=3D -1;
+
+     int ret =3D neg ? 2 : 1;
+     for(;
+         number;
+         number /=3D 10, ret++
+     );
+
+     return ret;
+ }
+
+ inline void int2fpstr(int number,
+         const int decimal_places, char* dest)
+ {
+     if(!number)    {
+         strncpy(dest, "0", 1);
+         return;
+     }
+
+     const __kernel_size_t size_alloc_n =3D size_alloc(number);
+     char* buffer =3D kmalloc(size_alloc_n, GFP_KERNEL);
+
+     int buf_index =3D size_alloc_n;
+     *(buffer + buf_index) =3D '\0';
+
+     int c_dec_places =3D 0;
+     int point_include =3D decimal_places < 1;
+
+     int neg =3D number < 0;
+     if(neg)
+         number *=3D -1;
+
+     for (; number && buf_index;
+         --buf_index, number /=3D 10)
+     {
+         c_dec_places++;
+         if (!point_include
+             && c_dec_places > decimal_places)
+         {
+             *(buffer + buf_index--) =3D '.';
+             point_include =3D 1;
+         }
+
+         *(buffer + buf_index) =3D "0123456789"[number % 10];
+     }
+
+     if(neg)
+         *(buffer + buf_index--) =3D '-';
+
+     strncpy(dest, &buffer[buf_index+1], size_alloc_n);
+ }
+
+ #endif



so, i create a unitest to library:

lib/int2fpstr_kunit.c ++++++

+ #include <kunit/test.h>
+ #include <linux/slab.h>
+ #include <linux/errno.h>
+ #include <linux/string.h>
+
+ #include <linux/int2fpstr.h>
+
+ static void should_return_2345_without_errors(struct kunit *test)
+ {
+     char *dest =3D kmalloc(size_alloc(2345), GFP_KERNEL);
+     int2fpstr(2345, 2, dest);
+     int ret =3D strncmp(dest, "23.45", 5);
+     KUNIT_EXPECT_EQ(test, 0, ret);
+     kfree(dest);
+ }
+
+ static void should_return_2_without_errors_and_float_point(struct =
kunit *test)
+ {
+     char *dest =3D kmalloc(size_alloc(2), GFP_KERNEL);
+     int2fpstr(2, 0, dest);
+     int ret =3D strncmp(dest, "2", 1);
+     KUNIT_EXPECT_EQ(test, 0, ret);
+     kfree(dest);
+ }
+
+ static void should_return_0_without_errors(struct kunit *test)
+ {
+     char *dest =3D kmalloc(size_alloc(1), GFP_KERNEL);
+     int2fpstr(0, 0, dest);
+     int ret =3D strncmp(dest, "0", 1);
+     KUNIT_EXPECT_EQ(test, 0, ret);
+     kfree(dest);
+ }
+
+ static void should_return_12_without_errors_and_float_point(struct =
kunit *test)
+ {
+     char *dest =3D kmalloc(size_alloc(12), GFP_KERNEL);
+     int2fpstr(12, 0, dest);
+     int ret =3D strncmp(dest, "12", 2);
+     KUNIT_EXPECT_EQ(test, 0, ret);
+     kfree(dest);
+ }
+
+ static void should_return_12_without_errors(struct kunit *test)
+ {
+     char *dest =3D kmalloc(size_alloc(12) + 1, GFP_KERNEL);
+     int2fpstr(-12, 0, dest);
+     int ret =3D strncmp(dest, "-12", 3);
+     KUNIT_EXPECT_EQ(test, 0, ret);
+     kfree(dest);
+ }
+
+ static void should_return_125_without_errors(struct kunit *test)
+ {
+     char *dest =3D kmalloc(size_alloc(125), GFP_KERNEL);
+     int2fpstr(-125, 1, dest);
+     int ret =3D strncmp(dest, "-12.5", 5);
+     KUNIT_EXPECT_EQ(test, 0, ret);
+     kfree(dest);
+ }
+
+ static struct kunit_case int_to_fp_str_test_case[] =3D {
+     KUNIT_CASE(should_return_12_without_errors_and_float_point),
+     KUNIT_CASE(should_return_0_without_errors),
+     KUNIT_CASE(should_return_2_without_errors_and_float_point),
+     KUNIT_CASE(should_return_2345_without_errors),
+     KUNIT_CASE(should_return_12_without_errors),
+     KUNIT_CASE(should_return_125_without_errors),
+     { /* sentinel */ }
+ };
+
+ static struct kunit_suite int_to_fp_str_test =3D {
+     .name =3D "int2fpstr",
+     .test_cases =3D int_to_fp_str_test_case
+ };
+
+ kunit_test_suite(int_to_fp_str_test);
+
+ MODULE_AUTHOR("Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>");
+ MODULE_LICENSE("GPL");


This library can help the drivers writers, and (perhaps and very rarely) =
the subsystems writers.=20


