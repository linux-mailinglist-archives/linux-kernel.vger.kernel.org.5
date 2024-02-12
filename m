Return-Path: <linux-kernel+bounces-62065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F594851AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E71B25C00
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D584176B;
	Mon, 12 Feb 2024 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtsLql02"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F93E479
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757836; cv=none; b=tVqs8nrcy3QdfZhWlKoy3yc6kHADiH6zeEqQcXz+wVZ8qLAyFDtBa2XZxhYolMATIaT8mk6ZI/ecZLxYrBIdhwnvtaW4ZiIEHQKKZRWrLhjEtHZmH0PbeI9of3uXgRAazlw0lnaFpR6OwhXWQ8u9hOXPtrmr8PyomkZMPdKowNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757836; c=relaxed/simple;
	bh=pn8eoFLMHZvAr8t7cRS+n4YGOq7Xs55KoD+4fPG0SAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcrV+/VCmsmRNfbgUQPm9x5tagGBLwHcWsnsuGVLYr+5ReDTJcVzFEdObNYSsZJZuolc+pxf8UmAQwGZzL7Nf9usRLExj+LRsm4s1Gb5Y33/MQHbfcaXfr62zMeYZZTwD2BUjGnVJVeXXdWYhyxDrMCy9PffeSARTF8aIHBPARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtsLql02; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso26704875ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707757834; x=1708362634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+ts8fdvoSYB+/fLpCiw94whp5U2uTdk3ycU3xX4fXw=;
        b=KtsLql0262EFBm/gsjDXS7U5luFqdacdRXzT3KTrISfoqGe9JBbrK+gZ8w0jipe/+h
         gNhWYNeIGRcrpAnDsK0PiZQ+Q8wNwj5QbmaJ3FmyvmF1vVD9lKZdyNOenIo+q/iL0MoE
         hYR8hCBieBPFFT5jGQ+VZfe6Vvj8Tpk3mff3yjppytKWlmnKDDOfF1xWDLgnas2HJSlb
         zV2Sbb2JV0OrsfvFY0ptGIo5ITqtnshvpgJPAANQE/kVLNKuPviZZDf8RMEla7ztSuGz
         CPySao9643wegcSyZBDNvUTcnIQhrDyXtwGWZ9lQjk064iHl/hv9NLGiq73G8YV6FLR3
         tOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757834; x=1708362634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+ts8fdvoSYB+/fLpCiw94whp5U2uTdk3ycU3xX4fXw=;
        b=E90h2eIDbnhjUBXq2Z6CY8TGS5x0lfbQr0PsAdo7I65R1NFI/DSVPLmX5G71FA9CRC
         xti0IXrFjik2TRVardhuPsrp7LPJ4Nlkp0s/bVnA4l3NPXieTZUSapJMLSQ9qt2T+ecd
         yFjT7L8V6turzxPxGGLfGrvgeFtlFk/U++1OdtjiIeuB7vLaKgw7opY8vrCk78n65PS/
         1tGl/ClHCHM2ZA64RWUwBeL15j9D0AgzoM2WeBqp1nBHbgszi+bJhxV+f/4G0Bl0Z2po
         5FRrYtK5RzLyE+Jp76BVhlVYC5PEKbzaEMtJlODyITM0k5p/me/1NynaRFEYQazZRNF1
         CCVw==
X-Gm-Message-State: AOJu0Yy92CQmtk4nJWeiUfKKNXAzpatGCuOkTRwzVukYnVHGnYIAkHp9
	tB+8XwgxUF0SvlT5/N9dIZODIauj6+UJ4fmmHkTfqPlUxxIsf137
X-Google-Smtp-Source: AGHT+IF/Cwh6mkRDc/NbLNUI7qzwVdngCIXWOq6oUAobyu+EEQh60BbcfywVxfnjZuovwGxHqUrqKA==
X-Received: by 2002:a17:902:a3cc:b0:1d9:6fce:54f7 with SMTP id q12-20020a170902a3cc00b001d96fce54f7mr125331plb.9.1707757833885;
        Mon, 12 Feb 2024 09:10:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVIZMUa5bmYjdMh9Z08PdMuoqJbh5Jhivd4P4AGKMYxb9wnpKzyIwEE+zqTXJAXm/m2kgI0KghyQ4PT6duTGm5WthMPhbvLfyd+3rKab04+lC3G0V+N5LTA0mjRy21ewAtheEBRR9DWJi7vjUeno+rgCW3XMLCKPJrgjwCK24kTR9x2YR155Y/V+3w=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ks8-20020a170903084800b001d94ee4af40sm587725plb.106.2024.02.12.09.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:10:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 12 Feb 2024 09:10:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 0/2] lib: checksum: Fix issues with checksum tests
Message-ID: <cbee3cb7-04bc-43bf-95af-774fb72f7905@roeck-us.net>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <8dedf370-47e1-405d-85cf-53f3acfa16a0@roeck-us.net>
 <Zcmr8C1dTuaPvXqJ@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcmr8C1dTuaPvXqJ@ghost>

On Mon, Feb 12, 2024 at 12:26:08AM -0500, Charlie Jenkins wrote:
> On Sun, Feb 11, 2024 at 11:18:36AM -0800, Guenter Roeck wrote:
> > Hi,
> > 
> > On 2/7/24 16:22, Charlie Jenkins wrote:
> > > The ip_fast_csum and csum_ipv6_magic tests did not have the data
> > > types properly casted, and improperly misaligned data.
> > > 
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > 
> > I sorted out most of the problems with this version, but I still get:
> > 
> >     # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:513
> >     Expected ( u64)csum_result == ( u64)expected, but
> >         ( u64)csum_result == 16630 (0x40f6)
> >         ( u64)expected == 65535 (0xffff)
> >     not ok 5 test_csum_ipv6_magic
> > 
> > on m68k:q800. This is suspicious because there is no 0xffff in
> > expected_csum_ipv6_magic[]. With some debugging information:
> > 
> > ####### num_tests=86 i=84 expect array size=84
> > ####### MAX_LEN=512 WORD_ALIGNMENT=4 magic data size=42
> > 
> > That means the loop
> > 
> > 	for (int i = 0; i < num_tests; i++) {
> > 		...
> > 		expected = (__force __sum16)expected_csum_ipv6_magic[i];
> > 		...
> > 	}
> > 
> > will access data beyond the end of the expected_csum_ipv6_magic[] array,
> > possibly because m68k doesn't pad struct csum_ipv6_magic_data to 44 bytes.
> 
> Okay I will check that out.
> 
> > 
> > In this context, is the comment about proto having to be 0 really true ?
> > It seems to me that the calculated checksum must be identical on both
> > little and big endian systems. After all, they need to be able to talk
> > to each other.
> 
> I agree, but I couldn't find a solution other than setting it to zero.
> Maybe I am missing something simple...
> 

Try the patch below on top of yours. It should work on both big and little
endian systems.

Key changes:
- use random_buf directly instead of copying anything
- no need to convert source / destination addresses
- csum in the buffer is in network byte order and needs
  to stay that way
- len in the buffer is in network byte order and needs to be
  converted to host byte order since that is expected by
  csum_ipv6_magic()
- the expected value is in host byte order and needs to be
  converted to network byte order for comparison
- protocol is just fine and converted by csum_ipv6_magic()
  as needed

Hope this helps,
Guenter

---
diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index acce285a4959..dec60e97e87a 100644
--- a/lib/checksum_kunit.c
+++ b/lib/checksum_kunit.c
@@ -217,16 +217,19 @@ static const u32 init_sums_no_overflow[] = {
 };
 
 static const u16 expected_csum_ipv6_magic[] = {
-	0x3045, 0xb681, 0xc210, 0xe77b, 0x41cc, 0xa904, 0x4367, 0xe8d8, 0x5809,
-	0x5901, 0x5a40, 0xd3f4, 0xe467, 0xddde, 0xa609, 0xae05, 0xed14, 0x9133,
-	0x8007, 0x89b6, 0x97b0, 0x8927, 0x1e43, 0x7903, 0x4772, 0xd3a4, 0x457b,
-	0x83d0, 0x4ce1, 0x3656, 0x2dfc, 0xb678, 0x9a83, 0xd523, 0x61db, 0x379e,
-	0x3880, 0xbb23, 0xa38b, 0xd2eb, 0x991a, 0xcf73, 0x13ea, 0x890f, 0x20ce,
-	0x60ad, 0x5688, 0x4b13, 0x9399, 0x8a36, 0x75ae, 0x513a, 0xb222, 0xf3bb,
-	0x80d4, 0x1f98, 0xc2bc, 0xf566, 0x796a, 0x268a, 0xe67f, 0xb917, 0xd716,
-	0x3a16, 0x1858, 0x9d5b, 0x6fb4, 0x72b4, 0x1196, 0xb3d0, 0x89dc, 0xdd07,
-	0x1a8d, 0xfa6d, 0x1507, 0xafab, 0x7d37, 0xa623, 0x72dd, 0x2083, 0xdfc4,
-	0xa267, 0x92c9, 0xc8ad,
+	0x2fbd, 0xb5d0, 0xc16e, 0xe6c1, 0x412e, 0xa836, 0x433b, 0xe87c, 0x57ea,
+	0x5875, 0x5a21, 0xd361, 0xe422, 0xdd50, 0xa57f, 0xad6b, 0xecd1, 0x90b5,
+	0x7fda, 0x88db, 0x979e, 0x8916, 0x1df0, 0x7853, 0x473e, 0xd2b3, 0x4526,
+	0x8304, 0x4c34, 0x363d, 0x2dc1, 0xb66c, 0x9a28, 0xd4f2, 0x615d, 0x36dd,
+	0x3784, 0xbadd, 0xa2c6, 0xd293, 0x9830, 0xcea8, 0x1349, 0x886d, 0x20a3,
+	0x6001, 0x5607, 0x4a30, 0x9365, 0x893c, 0x7505, 0x50a1, 0xb200, 0xf3ad,
+	0x80bf, 0x1f48, 0xc1d9, 0xf55d, 0x7871, 0x262a, 0xe606, 0xb894, 0xd6cd,
+	0x39ed, 0x1817, 0x9d20, 0x6f93, 0x722d, 0x1116, 0xb3b4, 0x88ec, 0xdcb5,
+	0x1a46, 0xfa1d, 0x141e, 0xaef7, 0x7cee, 0xa583, 0x72ad, 0x201b, 0xdece,
+	0xa1ee, 0x92bd, 0xc7ba, 0x403e, 0x50a9, 0xcb5a, 0xff3b, 0x1b41, 0xa06b,
+	0xcf2d, 0xcc9a, 0xf42a, 0x0c61, 0x7654, 0xf3d4, 0xcc25, 0x4985, 0x7606,
+	0xc8a2, 0x6636, 0x610e, 0xc454, 0xefa4, 0xf3a6, 0x43a7, 0xd8e2, 0xe31e,
+	0x150b, 0x445d, 0x57d5, 0x253c, 0x6adf, 0x3c53, 0x502c, 0x9ee5, 0x8422,
 };
 
 static const u16 expected_fast_csum[] = {
@@ -465,44 +468,36 @@ static void test_ip_fast_csum(struct kunit *test)
 	}
 }
 
+#define IPV6_NUM_TESTS ((MAX_LEN - sizeof(struct in6_addr) * 2 - sizeof(int) * 3) / WORD_ALIGNMENT)
+
 static void test_csum_ipv6_magic(struct kunit *test)
 {
 #if defined(CONFIG_NET)
+	const struct in6_addr *saddr;
+	const struct in6_addr *daddr;
+	unsigned int len;
 	__sum16 csum_result, expected;
-	struct csum_ipv6_magic_data {
-		const struct in6_addr saddr;
-		const struct in6_addr daddr;
-		unsigned int len;
-		__wsum csum;
-		unsigned char proto;
-	} data, *data_ptr;
-	int num_tests = MAX_LEN / WORD_ALIGNMENT - sizeof(struct csum_ipv6_magic_data);
+	unsigned char proto;
+	unsigned int csum;
 
-	for (int i = 0; i < num_tests; i++) {
-		data_ptr = (struct csum_ipv6_magic_data *)(random_buf + (i * WORD_ALIGNMENT));
+	const int daddr_offset = sizeof(struct in6_addr);
+	const int len_offset = sizeof(struct in6_addr) + sizeof(struct in6_addr);
+	const int csum_offset = sizeof(struct in6_addr) + sizeof(struct in6_addr) +
+	  sizeof(int);
+	const int proto_offset = sizeof(struct in6_addr) + sizeof(struct in6_addr) +
+	  sizeof(int) * 2;
 
-		cpu_to_be32_array((__be32 *)&data.saddr, (const u32 *)&data_ptr->saddr,
-				  sizeof_field(struct csum_ipv6_magic_data, saddr) / 4);
-		cpu_to_be32_array((__be32 *)&data.daddr, (const u32 *)&data_ptr->daddr,
-				  sizeof_field(struct csum_ipv6_magic_data, daddr) / 4);
-		data.len = data_ptr->len;
-		data.csum = (__force __wsum)htonl((__force u32)data_ptr->csum);
-		/*
-		 * proto must be zero to be compatible between big-endian and
-		 * little-endian CPUs. On little-endian CPUs, proto is
-		 * converted to a big-endian 32-bit value before the checksum
-		 * operation. This causes proto to be in the most significant
-		 * 8 bits on a little-endian CPU. On big-endian CPUs proto will
-		 * remain in the least significant 8 bits. There does not exist
-		 * a transformation to an arbitrary proto that will allow
-		 * csum_ipv6_magic to return the same value on a big-endian and
-		 * little-endian CPUs.
-		 */
-		data.proto = 0;
-		csum_result = csum_ipv6_magic(&data.saddr, &data.daddr,
-					      data.len, data.proto,
-					      data.csum);
-		expected = (__force __sum16)expected_csum_ipv6_magic[i];
+	for (int i = 0; i < IPV6_NUM_TESTS; i++) {
+		int index = i * WORD_ALIGNMENT;
+
+		saddr = (const struct in6_addr *)(random_buf + index);
+		daddr = (const struct in6_addr *)(random_buf + index + daddr_offset);
+		len = ntohl(*(unsigned int *)(random_buf + index + len_offset));
+		csum = *(unsigned int *)(random_buf + index + csum_offset);
+		proto = *(random_buf + index + proto_offset);
+
+		csum_result = csum_ipv6_magic(saddr, daddr, len, proto, csum);
+		expected = (__force __sum16)htons(expected_csum_ipv6_magic[i]);
 		CHECK_EQ(csum_result, expected);
 	}
 #endif /* !CONFIG_NET */

