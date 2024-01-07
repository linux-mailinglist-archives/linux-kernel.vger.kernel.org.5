Return-Path: <linux-kernel+bounces-18750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D552826286
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1E91F21E0F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 00:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A31E15A0;
	Sun,  7 Jan 2024 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC1TDUBr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B417D8;
	Sun,  7 Jan 2024 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7b7f6caf047so41371339f.3;
        Sat, 06 Jan 2024 16:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704588155; x=1705192955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0iwKIfolPiCJkop7a8HKvHjc7MC8O77M50KordKa/cE=;
        b=eC1TDUBrlMzzCT/HI1+M2gMxnDub3QO2y2abRff9CEANGiwy5YMq/Z3X1Pg5jmeIZ6
         dOICJQEssg88X0lxEYL+3ucFVLHmwm5gfi3F3mHFMfPCyq0Mso6y4ZYJPWjVYvINFJiq
         jUmAAz2R45hRY0PAl6sr4/AsSq0jpxMvxedEPStIqPENfIQ0WRnIwsCNnHVYh02kBjg4
         ZanKXMIQlKm8yrqRxny7zJ9zIs+HO66mUoxLi1P6mlIgvHiwu9OpTKUS1wDfiuPtUafC
         ins6Dd37NQGD+ASn58R4hAcSJ/cPdpvJlzct7lUYaRq+mHNBoJ2lSRFVeF2ppDq7hqIX
         2mlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704588155; x=1705192955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iwKIfolPiCJkop7a8HKvHjc7MC8O77M50KordKa/cE=;
        b=gAugwz3KE9A+EMv1cEyUesqdEmbnyT1i3kaojQKCpf4VesSQekvk7//9++5cxkXWJC
         CZdM0E6YnSSE1MPRaUqGvqAfM1QIm35xYxMykbwlAI6uzfsqu3ZXrruGYebZ67yUvAMm
         YtKOmy3Uy2ZNESKbYJzPNgJ59/bZGBvIijym+gYxAgeEnkzU9KHgwAGGhmXbEl6c41+9
         PE2HGpGODhEputqvTATKR5mLVuq3yaVav6/zIfcMlaIVoUAzjxr5kzhX1Qk6Eqc1jxwl
         M3XPR52TH8DJHTOgkRLh3oeRBXoGS71Y/Hy98Jvm/FP4JA8SN64fI8OVCiSPboFdEmqb
         A5fQ==
X-Gm-Message-State: AOJu0YxapCEEeuNhMS1BbbftTepmG62+vo5iEKeewy/BD2yhIM003jqT
	qAZUR9wXWa3Pxqy/KZwLYRc=
X-Google-Smtp-Source: AGHT+IGONh6fpIe76vM5bhUIqZ5BR/LTulgSn88TZBukeiKV2aanxgat8TSGukezge2OOI3ubq0obA==
X-Received: by 2002:a5e:8c0c:0:b0:7ba:9191:e263 with SMTP id n12-20020a5e8c0c000000b007ba9191e263mr2350537ioj.41.1704588154675;
        Sat, 06 Jan 2024 16:42:34 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:e05d:9c84:c3e5:2daf])
        by smtp.gmail.com with ESMTPSA id l2-20020a056a00140200b006d9aa4b65fasm3668862pfu.98.2024.01.06.16.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 16:42:34 -0800 (PST)
Date: Sat, 6 Jan 2024 16:42:31 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-sparse@vger.kernel.org
Cc: Chris Morgan <macromorgan@hotmail.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: include/asm-generic/unaligned.h:119:16: sparse: sparse: cast
 truncates bits from constant value (aa01a0 becomes a0)
Message-ID: <ZZnzd3s2L-ZwGOlz@google.com>
References: <202401070147.gqwVulOn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401070147.gqwVulOn-lkp@intel.com>

On Sun, Jan 07, 2024 at 01:41:34AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
> commit: 66603243f5283f7f28c795f09e7c2167233df0bd Input: add driver for Hynitron cstxxx touchscreens
> date:   1 year, 2 months ago
> config: x86_64-randconfig-x051-20230705 (https://download.01.org/0day-ci/archive/20240107/202401070147.gqwVulOn-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070147.gqwVulOn-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401070147.gqwVulOn-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    drivers/input/touchscreen/hynitron_cstxxx.c: note: in included file (through arch/x86/include/generated/asm/unaligned.h):
> >> include/asm-generic/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (aa01a0 becomes a0)
>    include/asm-generic/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (aa01 becomes 1)
> >> include/asm-generic/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (ab00d0 becomes d0)
>    include/asm-generic/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (ab00 becomes 0)
> 
> vim +119 include/asm-generic/unaligned.h
> 
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08  116  
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08  117  static inline void __put_unaligned_le24(const u32 val, u8 *p)
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08  118  {
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08 @119  	*p++ = val;
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08  120  	*p++ = val >> 8;
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08  121  	*p++ = val >> 16;
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08  122  }
> 803f4e1eab7a89 Arnd Bergmann 2021-05-08  123  

This is not really a kernel/driver bug, just sparse being over-eager
with truncation detection. I wonder if we could make sparse skip this
check on forced casts like this:

diff --git a/expand.c b/expand.c
index f14e7181..5487e8b3 100644
--- a/expand.c
+++ b/expand.c
@@ -96,6 +96,7 @@ static long long get_longlong(struct expression *expr)
 
 void cast_value(struct expression *expr, struct symbol *newtype, struct expression *old)
 {
+	enum expression_type cast_type = expr->type;
 	struct symbol *oldtype = old->ctype;
 	int old_size = oldtype->bit_size;
 	int new_size = newtype->bit_size;
@@ -133,7 +134,7 @@ Int:
 	expr->value = value & mask;
 
 	// Stop here unless checking for truncation
-	if (!Wcast_truncate || conservative)
+	if (cast_type == EXPR_FORCE_CAST || !Wcast_truncate || conservative)
 		return;
 	
 	// Check if we dropped any bits..

and then in the kernel we would do this:

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 699650f81970..034237d12d70 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -104,9 +104,9 @@ static inline u32 get_unaligned_le24(const void *p)
 
 static inline void __put_unaligned_be24(const u32 val, u8 *p)
 {
-	*p++ = val >> 16;
-	*p++ = val >> 8;
-	*p++ = val;
+	*p++ = (__force u8)(val >> 16);
+	*p++ = (__force u8)(val >> 8);
+	*p++ = (__force u8)val;
 }
 
 static inline void put_unaligned_be24(const u32 val, void *p)
@@ -116,9 +116,9 @@ static inline void put_unaligned_be24(const u32 val, void *p)
 
 static inline void __put_unaligned_le24(const u32 val, u8 *p)
 {
-	*p++ = val;
-	*p++ = val >> 8;
-	*p++ = val >> 16;
+	*p++ = (__force u8)val;
+	*p++ = (__force u8)(val >> 8);
+	*p++ = (__force u8)(val >> 16);
 }
 
 static inline void put_unaligned_le24(const u32 val, void *p)
@@ -128,12 +128,12 @@ static inline void put_unaligned_le24(const u32 val, void *p)
 
 static inline void __put_unaligned_be48(const u64 val, u8 *p)
 {
-	*p++ = val >> 40;
-	*p++ = val >> 32;
-	*p++ = val >> 24;
-	*p++ = val >> 16;
-	*p++ = val >> 8;
-	*p++ = val;
+	*p++ = (__force u8)(val >> 40);
+	*p++ = (__force u8)(val >> 32);
+	*p++ = (__force u8)(val >> 24);
+	*p++ = (__force u8)(val >> 16);
+	*p++ = (__force u8)(val >> 8);
+	*p++ = (__force u8)val;
 }
 
 static inline void put_unaligned_be48(const u64 val, void *p)

What do you think?

Thanks.

-- 
Dmitry

