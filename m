Return-Path: <linux-kernel+bounces-131446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 846018987F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036D81F22684
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2A285269;
	Thu,  4 Apr 2024 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kw4yzzKd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7666B84FD4;
	Thu,  4 Apr 2024 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234153; cv=none; b=dStGDfEEFjhD69aHrcO+UUE1g8dXPl5YYk1sL0a2uPW2MMDK9Zns6WI7YMuGEzZXjE6atBCmt3FxTDM6eJYlNhbirqPCougkAbymyBKWzzoxVz8vzo0GDoqYOtvjgghVadKwgA50Z6dro/ku+C4dW6VXpvkZn1Ig4vpdpfHbyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234153; c=relaxed/simple;
	bh=650U72Rh4qLVQ5aCi/OaEWjX6StIDX/W1l1bWU5Sz8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejsCSRpZQPVnlsDxNnDkTNKY+o2/w1n+9X9+oG4/yaLIcQJNokKdNoJ8vyISqwlGeY6iVOVx+9rrB3cKwBDuTAiqnfrcUA+QH24WcKWG4eTloNsDsKZ82aZjIDbIKbH9ESnyB2d0KwP8NUZYM1sciCJ2CO5/sb6+XUvLcDqmtn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kw4yzzKd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712234151; x=1743770151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=650U72Rh4qLVQ5aCi/OaEWjX6StIDX/W1l1bWU5Sz8g=;
  b=Kw4yzzKdoQC7yZy8dwq2wvl7h61Xwls+9d+2QPr1KLnGCB21rXlHn4uY
   bwGrMOWk6VU5lKJ8JPf79TcypPDnVP8SfxSOskp0UGj59RGf4Sg/HIEK3
   diPH7JAOMlGb3OXkdSUbO0+T7VHuKf/kfgBIZ8dc6RaRbu7/Q2T+0WjwJ
   JlN+gAOr2/dxFBg3lHfbpFO6oEeak76/2Fs/cMPsN8K9Gpniev6DUfxzc
   zwJyyubVXQhTem/GpdnH21o3GumOkYmEAWEEQBXPINI5nsih+gpxtzJtQ
   DiMKwRth0S0zU31K2eW6uBM0NEVaju3AD7zvO+UAwrAOkP1ifvcmcJhs8
   Q==;
X-CSE-ConnectionGUID: Xlpo/3paScq6bpppctnNMg==
X-CSE-MsgGUID: dvUUJv5HSAabUhmC0zdPow==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="24965520"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="24965520"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:35:50 -0700
X-CSE-ConnectionGUID: lOVE5SZ1TuaGzehYMwzxbA==
X-CSE-MsgGUID: /3zls3PdR4KgWC1pd/28nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="19228191"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Apr 2024 05:35:49 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsMJm-00013l-1p;
	Thu, 04 Apr 2024 12:35:46 +0000
Date: Thu, 4 Apr 2024 20:35:39 +0800
From: kernel test robot <lkp@intel.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH 1/1] iio:imu: adis16475: Fix sync mode setting
Message-ID: <202404042009.uygCzG2i-lkp@intel.com>
References: <20240403111357.1074511-2-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240403111357.1074511-2-ramona.gradinariu@analog.com>

Hi Ramona,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.9-rc2 next-20240404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Gradinariu/ii=
o-imu-adis16475-Fix-sync-mode-setting/20240403-201755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240403111357.1074511-2-ramona.gr=
adinariu%40analog.com
patch subject: [PATCH 1/1] iio:imu: adis16475: Fix sync mode setting
config: arm64-randconfig-004-20240404 (https://download.01.org/0day-ci/arch=
ive/20240404/202404042009.uygCzG2i-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20240404/202404042009.uygCzG2i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404042009.uygCzG2i-lkp@i=
ntel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'adis16475_config_sync_mode',
       inlined from 'adis16475_probe' at drivers/iio/imu/adis16475.c:1439:8:
>> include/linux/compiler_types.h:449:45: error: call to '__compiletime_ass=
ert_616' declared with attribute error: BUILD_BUG_ON failed: sizeof(({ ({ d=
o { __attribute__((__noreturn__)) extern void __compiletime_assert_611(void=
) __attribute__((__error__("FIELD_PREP: " "mask is not constant"))); if (!(=
!(!__builtin_constant_p(((((int)(sizeof(struct { int:(-!!(__builtin_choose_=
expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) :=
 (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1)=
 & (~((0UL)) >> (64 - 1 - (4))))))))) __compiletime_assert_611(); } while (=
0); do { __attribute__((__noreturn__)) extern void __compiletime_assert_612=
(void) __attribute__((__error__("FIELD_PREP: " "mask is zero"))); if (!(!((=
((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=
=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4=
), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - =
1 - (4)))))) =3D=3D 0))) __compiletime_assert_612(); } while (0); do { __at=
tribute__((__noreturn__)) extern void __compiletime_assert_613(void) __attr=
ibute__((__error__("FIELD_PREP: " "value too large for the field"))); if (!=
(!(__builtin_constant_p(sync->sync_mode) ? ~((((((int)(sizeof(struct { int:=
(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((lon=
g)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) -=
 (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))) >> (__builtin_ffsl=
l(((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=
=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4=
), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - =
1 - (4)))))) - 1)) & (0 + (sync->sync_mode)) : 0))) __compiletime_assert_61=
3(); } while (0); do { __attribute__((__noreturn__)) extern void __compilet=
ime_assert_614(void) __attribute__((__error__("FIELD_PREP: " "type of reg t=
oo small for mask"))); if (!(!(((typeof( _Generic((((((int)(sizeof(struct {=
 int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)=
((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL=
))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))), char: (unsig=
ned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0,=
 unsigned short: (unsigned short)0, signed short: (unsigned short)0, unsign=
ed int: (unsigned int)0, signed int: (unsigned int)0, unsigned long: (unsig=
ned long)0, signed long: (unsigned long)0, unsigned long long: (unsigned lo=
ng long)0, signed long long: (unsigned long long)0, default: (((((int)(size=
of(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 =
? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) =
+ (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))))))=
(((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=
=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4=
), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - =
1 - (4))))))) > ((typeof( _Generic((0ULL), char: (unsigned char)0, unsigned=
 char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (un=
signed short)0, signed short: (unsigned short)0, unsigned int: (unsigned in=
t)0, signed int: (unsigned int)0, unsigned long: (unsigned long)0, signed l=
ong: (unsigned long)0, unsigned long long: (unsigned long long)0, signed lo=
ng long: (unsigned long long)0, default: (0ULL))))(~0ull))))) __compiletime=
_assert_614(); } while (0); do { __attribute__((__noreturn__)) extern void =
__compiletime_assert_615(void) __attribute__((__error__("BUILD_BUG_ON faile=
d: " "(((((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(i=
nt) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (=
2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >>=
 (64 - 1 - (4)))))) + (1ULL << (__builtin_ffsll(((((int)(sizeof(struct { in=
t:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((l=
ong)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL)))=
 - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))) - 1))) & (((((((=
int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D si=
zeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))=
); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4=
)))))) + (1ULL << (__builtin_ffsll(((((int)(sizeof(struct { int:(-!!(__buil=
tin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4=
)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) <=
< (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))) - 1))) - 1)) !=3D 0"))); if (=
!(!((((((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int=
) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2)=
 > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (=
64 - 1 - (4)))))) + (1ULL << (__builtin_ffsll(((((int)(sizeof(struct { int:=
(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((lon=
g)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) -=
 (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))) - 1))) & (((((((in=
t)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D size=
of(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0)));=
 })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4))=
)))) + (1ULL << (__builtin_ffsll(((((int)(sizeof(struct { int:(-!!(__builti=
n_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4))=
 * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << =
(2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))) - 1))) - 1)) !=3D 0))) __compil=
etime_assert_615(); } while (0); }); ((typeof(((((int)(sizeof(struct { int:=
(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((lon=
g)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) -=
 (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))))(sync->sync_mode) =
<< (__builtin_ffsll(((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr=
( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (in=
t *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (=
~((0UL)) >> (64 - 1 - (4)))))) - 1)) & (((((int)(sizeof(struct { int:(-!!(_=
_builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2)=
 > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1U=
L)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))); })) !=3D 2 && sizeof(({=
 ({ do { __attribute__((__noreturn__)) extern void __compiletime_assert_611=
(void) __attribute__((__error__("FIELD_PREP: " "mask is not constant"))); i=
f (!(!(!__builtin_constant_p(((((int)(sizeof(struct { int:(-!!(__builtin_ch=
oose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0=
l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2))=
 + 1) & (~((0UL)) >> (64 - 1 - (4))))))))) __compiletime_assert_611(); } wh=
ile (0); do { __attribute__((__noreturn__)) extern void __compiletime_asser=
t_612(void) __attribute__((__error__("FIELD_PREP: " "mask is zero"))); if (=
!(!((((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =
=3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) >=
 (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64=
 - 1 - (4)))))) =3D=3D 0))) __compiletime_assert_612(); } while (0); do { _=
_attribute__((__noreturn__)) extern void __compiletime_assert_613(void) __a=
ttribute__((__error__("FIELD_PREP: " "value too large for the field"))); if=
 (!(!(__builtin_constant_p(sync->sync_mode) ? ~((((((int)(sizeof(struct { i=
nt:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((=
long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))=
) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))) >> (__builtin_f=
fsll(((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =
=3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) >=
 (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64=
 - 1 - (4)))))) - 1)) & (0 + (sync->sync_mode)) : 0))) __compiletime_assert=
_613(); } while (0); do { __attribute__((__noreturn__)) extern void __compi=
letime_assert_614(void) __attribute__((__error__("FIELD_PREP: " "type of re=
g too small for mask"))); if (!(!(((typeof( _Generic((((((int)(sizeof(struc=
t { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void=
 *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((=
0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))), char: (un=
signed char)0, unsigned char: (unsigned char)0, signed char: (unsigned char=
)0, unsigned short: (unsigned short)0, signed short: (unsigned short)0, uns=
igned int: (unsigned int)0, signed int: (unsigned int)0, unsigned long: (un=
signed long)0, signed long: (unsigned long)0, unsigned long long: (unsigned=
 long long)0, signed long long: (unsigned long long)0, default: (((((int)(s=
izeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*=
(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); }))=
)) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4))))))=
)))(((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =
=3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) >=
 (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64=
 - 1 - (4))))))) > ((typeof( _Generic((0ULL), char: (unsigned char)0, unsig=
ned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: =
(unsigned short)0, signed short: (unsigned short)0, unsigned int: (unsigned=
 int)0, signed int: (unsigned int)0, unsigned long: (unsigned long)0, signe=
d long: (unsigned long)0, unsigned long long: (unsigned long long)0, signed=
 long long: (unsigned long long)0, default: (0ULL))))(~0ull))))) __compilet=
ime_assert_614(); } while (0); do { __attribute__((__noreturn__)) extern vo=
id __compiletime_assert_615(void) __attribute__((__error__("BUILD_BUG_ON fa=
iled: " "(((((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeo=
f(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8)))=
, (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL))=
 >> (64 - 1 - (4)))))) + (1ULL << (__builtin_ffsll(((((int)(sizeof(struct {=
 int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)=
((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL=
))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))) - 1))) & ((((=
(((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D=
 sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), =
0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 -=
 (4)))))) + (1ULL << (__builtin_ffsll(((((int)(sizeof(struct { int:(-!!(__b=
uiltin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) >=
 (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)=
) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))) - 1))) - 1)) !=3D 0"))); i=
f (!(!((((((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(=
int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), =
(2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >=
> (64 - 1 - (4)))))) + (1ULL << (__builtin_ffsll(((((int)(sizeof(struct { i=
nt:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((=
long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))=
) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))) - 1))) & ((((((=
(int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D s=
izeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0)=
)); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (=
4)))))) + (1ULL << (__builtin_ffsll(((((int)(sizeof(struct { int:(-!!(__bui=
ltin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (=
4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) =
<< (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))) - 1))) - 1)) !=3D 0))) __com=
piletime_assert_615(); } while (0); }); ((typeof(((((int)(sizeof(struct { i=
nt:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((=
long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))=
) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))))(sync->sync_mod=
e) << (__builtin_ffsll(((((int)(sizeof(struct { int:(-!!(__builtin_choose_e=
xpr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : =
(int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) =
& (~((0UL)) >> (64 - 1 - (4)))))) - 1)) & (((((int)(sizeof(struct { int:(-!=
!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(=
(2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - ((=
(1UL)) << (2)) + 1) & (~((0UL)) >> (64 - 1 - (4)))))); })) !=3D 4
     449 |         _compiletime_assert(condition, msg, __compiletime_assert=
_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:430:25: note: in definition of macro '__c=
ompiletime_assert'
     430 |                         prefix ## suffix();                     =
        \
         |                         ^~~~~~
   include/linux/compiler_types.h:449:9: note: in expansion of macro '_comp=
iletime_assert'
     449 |         _compiletime_assert(condition, msg, __compiletime_assert=
_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletim=
e_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), =
msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_O=
N_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #con=
dition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/iio/imu/adis.h:402:9: note: in expansion of macro 'BUILD_B=
UG_ON'
     402 |         BUILD_BUG_ON(sizeof(val) !=3D 2 && sizeof(val) !=3D 4); =
            \
         |         ^~~~~~~~~~~~
   drivers/iio/imu/adis16475.c:1353:15: note: in expansion of macro '__adis=
_update_bits'
    1353 |         ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_MSG_=
CTRL,
         |               ^~~~~~~~~~~~~~~~~~


vim +449 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  435 =20
eb5c2d4b45e3d2 Will Deacon 2020-07-21  436  #define _compiletime_assert(con=
dition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  437  	__compiletime_assert(condition=
, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  438 =20
eb5c2d4b45e3d2 Will Deacon 2020-07-21  439  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  440   * compiletime_assert - break b=
uild and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  441   * @condition: a compile-time c=
onstant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  442   * @msg:       a message to emi=
t if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  443   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  444   * In tradition of POSIX assert=
, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  445   * supplied condition is *false=
*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  446   * compiler has support to do s=
o.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  447   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  448  #define compiletime_assert(cond=
ition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @449  	_compiletime_assert(condition,=
 msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  450 =20

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

