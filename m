Return-Path: <linux-kernel+bounces-131487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B1189888A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B4DB255B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EC3126F21;
	Thu,  4 Apr 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1tqs8ab"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5D76023;
	Thu,  4 Apr 2024 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236083; cv=none; b=t+4rRD9bIP5CMYU7VYXzrE3fa5GQM+sEp+TAny67w5oADH25FZUzFwJwJLBF3XNdttLqbZRkXSL7scw3zYV/4Zk1xaduVNFhOBYCxrMM2waUU0+olVeNlM1zb9fSVrd5uKDBnNaDZpYLWQPNS/TZ0n6DQQ3moJs2dUuqn7qa4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236083; c=relaxed/simple;
	bh=1hEQj/oWWyx0J1J6VGsp6XnfJEApArtnARvf2ByUOyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qbpyun2zvBW/bAni4/e2YUtvq3pt3v0UXT5QxY+1SsqAp+Sk+yt9NCGEd3QOkRdoD+2WiHo/fdMGTrc3AK9QA5Y8Tl5vfKn8+E6OGKPTqk86K9ERxVCXE+O+20U5dHR2RKbIsrA47iT3HzuuaZPruTdWc5HJDCHC57RCQmCdbhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1tqs8ab; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712236080; x=1743772080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1hEQj/oWWyx0J1J6VGsp6XnfJEApArtnARvf2ByUOyc=;
  b=J1tqs8abJBQ4OxF4CZYenO6O8moNslc+1Nadk/kHdKFzk9cvMUFinwI+
   Rx839OFnVXgr5HzTgzPVOPSgkd8WRWBAmXxVhF7I1FMFADGQixm2IY+OO
   N5iyFnTpQMxFh8aTmruL34O3HcAVd86a/xpx0END4QPwLaJcoEVz4QtWc
   W/KmdP15NnYh461mAkbRSmzw90bvrwKRfCMVH+osZ0QzbQyTA6fG5RDnN
   Mix1fbFhLX6ZArvIBBagMEcESSzawhIho/+gJVeShX/4D3MHGZ88a0L8J
   4n33q1UK87GHLYsyZBaajhPmp7vHX3LLvnpBs5BotjXjDm7Fdda6Haziz
   g==;
X-CSE-ConnectionGUID: a92jq0IoSJakB7X/4gSHAA==
X-CSE-MsgGUID: yIcoph0vSXCROe7YEG6jgg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7410622"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7410622"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 06:07:51 -0700
X-CSE-ConnectionGUID: 2zC0UZcJTrKDQoBX7whFdQ==
X-CSE-MsgGUID: DcQegI9RQtiZuliCmSsEtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="19217383"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 Apr 2024 06:07:50 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsMol-00015E-10;
	Thu, 04 Apr 2024 13:07:47 +0000
Date: Thu, 4 Apr 2024 21:07:40 +0800
From: kernel test robot <lkp@intel.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH 1/1] iio:imu: adis16475: Fix sync mode setting
Message-ID: <202404042023.NqdNbrAI-lkp@intel.com>
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
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/202=
40404/202404042023.NqdNbrAI-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20240404/202404042023.NqdNbrAI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404042023.NqdNbrAI-lkp@i=
ntel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/iio/imu/adis16475.c: In function 'adis16475_config_sync_mode':
>> include/linux/compiler_types.h:449:45: error: call to '__compiletime_ass=
ert_494' declared with attribute error: BUILD_BUG_ON failed: sizeof(({ ({ d=
o { __attribute__((__noreturn__)) extern void __compiletime_assert_489(void=
) __attribute__((__error__("FIELD_PREP: " "mask is not constant"))); if (!(=
!(!__builtin_constant_p(((((int)(sizeof(struct { int:(-!!(__builtin_choose_=
expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) :=
 (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1)=
 & (~((0UL)) >> ((8 * 8) - 1 - (4))))))))) __compiletime_assert_489(); } wh=
ile (0); do { __attribute__((__noreturn__)) extern void __compiletime_asser=
t_490(void) __attribute__((__error__("FIELD_PREP: " "mask is zero"))); if (=
!(!((((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =
=3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) >=
 (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8=
 * 8) - 1 - (4)))))) =3D=3D 0))) __compiletime_assert_490(); } while (0); d=
o { __attribute__((__noreturn__)) extern void __compiletime_assert_491(void=
) __attribute__((__error__("FIELD_PREP: " "value too large for the field"))=
); if (!(!(__builtin_constant_p(sync->sync_mode) ? ~((((((int)(sizeof(struc=
t { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void=
 *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((=
0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) >> (_=
_builtin_ffsll(((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (si=
zeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8=
))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0U=
L)) >> ((8 * 8) - 1 - (4)))))) - 1)) & (0 + (sync->sync_mode)) : 0))) __com=
piletime_assert_491(); } while (0); do { __attribute__((__noreturn__)) exte=
rn void __compiletime_assert_492(void) __attribute__((__error__("FIELD_PREP=
: " "type of reg too small for mask"))); if (!(!(((typeof( _Generic((((((in=
t)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D size=
of(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0)));=
 })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 -=
 (4)))))), char: (unsigned char)0, unsigned char: (unsigned char)0, signed =
char: (unsigned char)0, unsigned short: (unsigned short)0, signed short: (u=
nsigned short)0, unsigned int: (unsigned int)0, signed int: (unsigned int)0=
, unsigned long: (unsigned long)0, signed long: (unsigned long)0, unsigned =
long long: (unsigned long long)0, signed long long: (unsigned long long)0, =
default: (((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(=
int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), =
(2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >=
> ((8 * 8) - 1 - (4)))))))))(((((int)(sizeof(struct { int:(-!!(__builtin_ch=
oose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0=
l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2))=
 + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4))))))) > ((typeof( _Generic((0ULL), =
char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsi=
gned char)0, unsigned short: (unsigned short)0, signed short: (unsigned sho=
rt)0, unsigned int: (unsigned int)0, signed int: (unsigned int)0, unsigned =
long: (unsigned long)0, signed long: (unsigned long)0, unsigned long long: =
(unsigned long long)0, signed long long: (unsigned long long)0, default: (0=
ULL))))(~0ull))))) __compiletime_assert_492(); } while (0); do { __attribut=
e__((__noreturn__)) extern void __compiletime_assert_493(void) __attribute_=
_((__error__("BUILD_BUG_ON failed: " "(((((((int)(sizeof(struct { int:(-!!(=
__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2=
) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1=
UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) + (1ULL << (__buil=
tin_ffsll(((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(=
int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), =
(2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >=
> ((8 * 8) - 1 - (4)))))) - 1))) & (((((((int)(sizeof(struct { int:(-!!(__b=
uiltin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) >=
 (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)=
) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) + (1ULL << (__builtin=
_ffsll(((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int=
) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2)=
 > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> (=
(8 * 8) - 1 - (4)))))) - 1))) - 1)) !=3D 0"))); if (!(!((((((((int)(sizeof(=
struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? (=
(void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (=
((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) =
+ (1ULL << (__builtin_ffsll(((((int)(sizeof(struct { int:(-!!(__builtin_cho=
ose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l=
)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) =
+ 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) - 1))) & (((((((int)(sizeof(str=
uct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((vo=
id *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~=
((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) + (=
1ULL << (__builtin_ffsll(((((int)(sizeof(struct { int:(-!!(__builtin_choose=
_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) =
: (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1=
) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) - 1))) - 1)) !=3D 0))) __compileti=
me_assert_493(); } while (0); }); ((typeof(((((int)(sizeof(struct { int:(-!=
!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(=
(2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - ((=
(1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))))(sync->sync_mode=
) << (__builtin_ffsll(((((int)(sizeof(struct { int:(-!!(__builtin_choose_ex=
pr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (=
int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) &=
 (~((0UL)) >> ((8 * 8) - 1 - (4)))))) - 1)) & (((((int)(sizeof(struct { int=
:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((lo=
ng)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) =
- (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))); })) !=3D 2 =
&& sizeof(({ ({ do { __attribute__((__noreturn__)) extern void __compiletim=
e_assert_489(void) __attribute__((__error__("FIELD_PREP: " "mask is not con=
stant"))); if (!(!(!__builtin_constant_p(((((int)(sizeof(struct { int:(-!!(=
__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2=
) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1=
UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4))))))))) __compiletime_a=
ssert_489(); } while (0); do { __attribute__((__noreturn__)) extern void __=
compiletime_assert_490(void) __attribute__((__error__("FIELD_PREP: " "mask =
is zero"))); if (!(!((((((int)(sizeof(struct { int:(-!!(__builtin_choose_ex=
pr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (=
int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) &=
 (~((0UL)) >> ((8 * 8) - 1 - (4)))))) =3D=3D 0))) __compiletime_assert_490(=
); } while (0); do { __attribute__((__noreturn__)) extern void __compiletim=
e_assert_491(void) __attribute__((__error__("FIELD_PREP: " "value too large=
 for the field"))); if (!(!(__builtin_constant_p(sync->sync_mode) ? ~((((((=
int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D si=
zeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))=
); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1=
 - (4)))))) >> (__builtin_ffsll(((((int)(sizeof(struct { int:(-!!(__builtin=
_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) =
* 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (=
2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) - 1)) & (0 + (sync->sync_mo=
de)) : 0))) __compiletime_assert_491(); } while (0); do { __attribute__((__=
noreturn__)) extern void __compiletime_assert_492(void) __attribute__((__er=
ror__("FIELD_PREP: " "type of reg too small for mask"))); if (!(!(((typeof(=
 _Generic((((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof=
(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))),=
 (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) =
>> ((8 * 8) - 1 - (4)))))), char: (unsigned char)0, unsigned char: (unsigne=
d char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0,=
 signed short: (unsigned short)0, unsigned int: (unsigned int)0, signed int=
: (unsigned int)0, unsigned long: (unsigned long)0, signed long: (unsigned =
long)0, unsigned long long: (unsigned long long)0, signed long long: (unsig=
ned long long)0, default: (((((int)(sizeof(struct { int:(-!!(__builtin_choo=
se_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)=
) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) +=
 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))))))(((((int)(sizeof(struct { int:=
(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((lon=
g)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) -=
 (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4))))))) > ((typeof( =
_Generic((0ULL), char: (unsigned char)0, unsigned char: (unsigned char)0, s=
igned char: (unsigned char)0, unsigned short: (unsigned short)0, signed sho=
rt: (unsigned short)0, unsigned int: (unsigned int)0, signed int: (unsigned=
 int)0, unsigned long: (unsigned long)0, signed long: (unsigned long)0, uns=
igned long long: (unsigned long long)0, signed long long: (unsigned long lo=
ng)0, default: (0ULL))))(~0ull))))) __compiletime_assert_492(); } while (0)=
; do { __attribute__((__noreturn__)) extern void __compiletime_assert_493(v=
oid) __attribute__((__error__("BUILD_BUG_ON failed: " "(((((((int)(sizeof(s=
truct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((=
void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + ((=
(~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) +=
 (1ULL << (__builtin_ffsll(((((int)(sizeof(struct { int:(-!!(__builtin_choo=
se_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)=
) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) +=
 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) - 1))) & (((((((int)(sizeof(stru=
ct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((voi=
d *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~(=
(0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) + (1=
ULL << (__builtin_ffsll(((((int)(sizeof(struct { int:(-!!(__builtin_choose_=
expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) :=
 (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1)=
 & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) - 1))) - 1)) !=3D 0"))); if (!(!(((=
(((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=
=3D sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4=
), 0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * =
8) - 1 - (4)))))) + (1ULL << (__builtin_ffsll(((((int)(sizeof(struct { int:=
(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((lon=
g)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) -=
 (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) - 1))) & ((((=
(((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D=
 sizeof(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), =
0))); })))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) =
- 1 - (4)))))) + (1ULL << (__builtin_ffsll(((((int)(sizeof(struct { int:(-!=
!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(=
(2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - ((=
(1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) - 1))) - 1)) !=
=3D 0))) __compiletime_assert_493(); } while (0); }); ((typeof(((((int)(siz=
eof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8=
 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); }))))=
 + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))=
))))(sync->sync_mode) << (__builtin_ffsll(((((int)(sizeof(struct { int:(-!!=
(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)((=
2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); })))) + (((~((0UL))) - (((=
1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (4)))))) - 1)) & (((((int)=
(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeof(int) =3D=3D sizeof=
(*(8 ? ((void *)((long)((2) > (4)) * 0l)) : (int *)8))), (2) > (4), 0))); }=
)))) + (((~((0UL))) - (((1UL)) << (2)) + 1) & (~((0UL)) >> ((8 * 8) - 1 - (=
4)))))); })) !=3D 4
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

eb5c2d4b45e3d2d Will Deacon 2020-07-21  435 =20
eb5c2d4b45e3d2d Will Deacon 2020-07-21  436  #define _compiletime_assert(co=
ndition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  437  	__compiletime_assert(conditio=
n, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  438 =20
eb5c2d4b45e3d2d Will Deacon 2020-07-21  439  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  440   * compiletime_assert - break =
build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  441   * @condition: a compile-time =
constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  442   * @msg:       a message to em=
it if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  443   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  444   * In tradition of POSIX asser=
t, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  445   * supplied condition is *fals=
e*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  446   * compiler has support to do =
so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  447   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  448  #define compiletime_assert(con=
dition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @449  	_compiletime_assert(condition=
, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  450 =20

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

