Return-Path: <linux-kernel+bounces-106421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9CA87EE6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77552844BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274B554FA4;
	Mon, 18 Mar 2024 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EyYVsoBt"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3354BE3;
	Mon, 18 Mar 2024 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781722; cv=none; b=q5QTMRO2OtDaqDpkQMhAt0yaRMyaJ8J5Ufvgbq8ein6YKDbw7DW6Npb6PMFJ5CE9+0Sm52NtzTXzmCqVeOa73EayRCJ1SrT+CXN1IePWs7tPN7otblri7DT/pB6ro0oZYYjLAZiiUfhAPP1nA2s5gDIoRlw1soCZ5PGx3WKpb90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781722; c=relaxed/simple;
	bh=csfGXu0EWEcGL5ePQfSyH5tdpesgMuSg44rfciEFOI4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=IXCVqJNS63PzEPnlc2ZwBtAcJ+TL8F7JDwD8ZYVJ8eNuxnMoHl+pdRwKs6aG9ocQGDqIvMLeC2r7NeYFTJkBeKLffO+wq3FNKOOpByTdsMCApW0s681jFrcXE9c6cuc0T6iFU2C7GKd4zMDbHkjOlHVNy1MyTfMcS4AbxAbLQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=EyYVsoBt; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42IH88Hc1164799
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 18 Mar 2024 10:08:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42IH88Hc1164799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1710781689;
	bh=JRcslQbBBy25t2ecH3v5hmHDMj6oYi/MjZqtWbG+464=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EyYVsoBtIpTAYhSFDMsIjz0KBKEuA9sbKtazXEpjj3QKzXWzR0agsMxBEBjymxfo9
	 2lGHpdcdRVS94hZhmVbcvlgB5/lYZVZKnvs6gyObdocctnqrbYZMp08sglVXB2XTUy
	 klhJON12j0UierOgiDKkkgLsmogEjQwe57no3nRNmSuhhxQjBm4ZYpsyT3O7jX66TK
	 tnbDEwTY/QIAwSLie0c2DAllNmpZ33T1Z6yUy+zie5FOuvOPJzvgu4vvgBoOM/yU3y
	 GxXA3HLg58tN1ls0VXhJyDLFVXrtF5OPhFhkbyOnOEMAtZ5U8/dl/hRL5Yt2PeI8hG
	 GQZB4bNZ8IT6w==
Date: Mon, 18 Mar 2024 10:08:04 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org,
        namhyung@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_0/3=5D_x86/cpufeatures=3A_Automatical?=
 =?US-ASCII?Q?ly_generate_required_and_disabled_feature_masks?=
User-Agent: K-9 Mail for Android
In-Reply-To: <642a5625-126d-40f8-b4fc-df88172f1127@zytor.com>
References: <20240201054629.3816748-1-xin@zytor.com> <642a5625-126d-40f8-b4fc-df88172f1127@zytor.com>
Message-ID: <7339AA55-A360-4AE5-9CAE-961EA6A80FBE@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 18, 2024 10:01:19 AM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 1/31/2024 9:46 PM, Xin Li (Intel) wrote:
>> When a CPU feature is not configured, e=2Eg=2E, CONFIG_X86_FRED=3Dn, in=
 a
>> build config, its feature disable flag, e=2Eg=2E DISABLE_FRED, needs to
>> be defined and added to a specific disabled CPU features mask in
>> <asm/disabled-features=2Eh>, as the following commit:
>> https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/tip/tip=2Egit/commi=
t/?h=3Dx86/fred&id=3De554a8ca49d6d6d782f546ae4d7f036946e7dd87
>>=20
>> This patch set adds an awk script to automatically generate a header
>> with required and disabled CPU features masks based on build config=2E
>
>A gentle ping=2E
>
>This is an infrastructural improvement which has a lower priority,
>however it would be nice to get some feedback first=2E
>
>Thanks!
>    Xin
>
>
>>=20
>>=20
>> H=2E Peter Anvin (Intel) (2):
>>    x86/cpufeatures: Add {required,disabled} feature configs
>>    x86/cpufeatures: Generate a feature mask header based on build confi=
g
>>=20
>> Xin Li (Intel) (1):
>>    x86/cpufeatures: Remove {disabled,required}-features=2Eh
>>=20
>>   arch/x86/Kconfig                              |   4 +-
>>   arch/x86/Kconfig=2Ecpu                          |  16 +-
>>   arch/x86/Kconfig=2Ecpufeatures                  | 149 +++++++++++++++=
++
>>   arch/x86/Makefile                             |  17 +-
>>   arch/x86/boot/cpucheck=2Ec                      |   3 +-
>>   arch/x86/boot/cpuflags=2Ec                      |   1 -
>>   arch/x86/boot/mkcpustr=2Ec                      |   3 +-
>>   arch/x86/include/asm/Kbuild                   |   1 +
>>   arch/x86/include/asm/asm-prototypes=2Eh         |   2 +-
>>   arch/x86/include/asm/atomic64_32=2Eh            |   2 +-
>>   arch/x86/include/asm/bitops=2Eh                 |   4 +-
>>   arch/x86/include/asm/cmpxchg_32=2Eh             |   4 +-
>>   arch/x86/include/asm/cpufeature=2Eh             |   1 +
>>   arch/x86/include/asm/cpufeatures=2Eh            |   8 -
>>   arch/x86/include/asm/disabled-features=2Eh      | 154 ---------------=
---
>>   arch/x86/include/asm/required-features=2Eh      | 104 ------------
>>   arch/x86/kernel/verify_cpu=2ES                  |   1 +
>>   arch/x86/lib/Makefile                         |   2 +-
>>   arch/x86/lib/cmpxchg8b_emu=2ES                  |   2 +-
>>   arch/x86/tools/featuremasks=2Eawk               | 108 ++++++++++++
>>   lib/atomic64_test=2Ec                           |   2 +-
>>   tools/arch/x86/include/asm/cpufeatures=2Eh      |   8 -
>>   =2E=2E=2E/arch/x86/include/asm/disabled-features=2Eh  | 154 ---------=
---------
>>   =2E=2E=2E/arch/x86/include/asm/required-features=2Eh  | 104 ---------=
---
>>   tools/perf/check-headers=2Esh                   |   2 -
>>   25 files changed, 303 insertions(+), 553 deletions(-)
>>   create mode 100644 arch/x86/Kconfig=2Ecpufeatures
>>   delete mode 100644 arch/x86/include/asm/disabled-features=2Eh
>>   delete mode 100644 arch/x86/include/asm/required-features=2Eh
>>   create mode 100755 arch/x86/tools/featuremasks=2Eawk
>>   delete mode 100644 tools/arch/x86/include/asm/disabled-features=2Eh
>>   delete mode 100644 tools/arch/x86/include/asm/required-features=2Eh
>>=20
>>=20
>> base-commit: 078b7b997b47c7166c1240cf1d39db9f646a56be
>

A key pay of this is that it eliminates the need to manually assign featur=
es to cpufeature words=2E It was one thing when there were four of them, bu=
t with over 20 it is going to cause mistakes=2E

