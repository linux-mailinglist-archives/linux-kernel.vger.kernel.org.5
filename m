Return-Path: <linux-kernel+bounces-26079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6043F82DB2F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E7A1F2281B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54F417596;
	Mon, 15 Jan 2024 14:23:30 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E06917586;
	Mon, 15 Jan 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C848D1FD35;
	Mon, 15 Jan 2024 14:23:26 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAD36132FA;
	Mon, 15 Jan 2024 14:23:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aTZ6J94/pWUYcgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 15 Jan 2024 14:23:26 +0000
Date: Mon, 15 Jan 2024 15:22:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Waldemar Brodkorb <wbx@openadk.org>
Cc: Petr Vorel <pvorel@suse.cz>, Greg Ungerer <gerg@linux-m68k.org>,
	Rob Landley <rob@landley.net>, Tim Bird <tim.bird@sony.com>,
	Niklas Cassel <niklas.cassel@wdc.com>,
	Andrea Cervesato <andrea.cervesato@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	Christophe Lyon <christophe.lyon@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Li Wang <liwang@redhat.com>,
	"linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	"buildroot@buildroot.org" <buildroot@buildroot.org>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>,
	"automated-testing@lists.yoctoproject.org" <automated-testing@lists.yoctoproject.org>
Subject: Re: [Buildroot] [Automated-testing] Call for nommu LTP maintainer
 [was: Re: [PATCH 00/36] Remove UCLINUX from LTP]
Message-ID: <ZaU_oMTrmXxy0Dub@rei>
References: <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik>
 <ZZvJXTshFUYSaMVH@yuki>
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <20240110141455.GC1698252@pevik>
 <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
 <81c07a13-305a-404b-b14c-3aff8fde3f67@linux-m68k.org>
 <d3a26b8e-8823-8f3c-b815-4396cbac1dc3@landley.net>
 <ZaU2Ag1wg1Sne9zZ@waldemar-brodkorb.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaU2Ag1wg1Sne9zZ@waldemar-brodkorb.de>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: C848D1FD35
X-Spam-Flag: NO

Hi!
> RANLIB libltp.a
> /home/wbx/arm/toolchain_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/usr/lib/gcc/arm-openadk-uclinuxfdpiceabi/13.2.0/../../../../arm-openadk-uclinuxfdpiceabi/bin/ld: ../../lib/libltp.a(tst_res.o): in function `tst_fork':
> /home/wbx/arm/build_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/w-ltp-20230929-1/ltp-full-20230929/lib/tst_res.c:430:(.text+0x952): undefined reference to `fork'
> /home/wbx/arm/toolchain_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/usr/lib/gcc/arm-openadk-uclinuxfdpiceabi/13.2.0/../../../../arm-openadk-uclinuxfdpiceabi/bin/ld: ../../lib/libltp.a(tst_test.o): in function `fork_testrun':
> /home/wbx/arm/build_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/w-ltp-20230929-1/ltp-full-20230929/lib/tst_test.c:1597:(.text+0xf4e): undefined reference to `fork'
> /home/wbx/arm/toolchain_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/usr/lib/gcc/arm-openadk-uclinuxfdpiceabi/13.2.0/../../../../arm-openadk-uclinuxfdpiceabi/bin/ld: ../../lib/libltp.a(tst_test.o): in function `safe_fork':
> /home/wbx/arm/build_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/w-ltp-20230929-1/ltp-full-20230929/lib/tst_test.c:435:(.text+0x345c): undefined reference to `fork'
> collect2: error: ld returned 1 exit status
> gmake[8]: *** [../../include/mk/rules.mk:45: test01] Error 1
> gmake[7]: *** [../include/mk/generic_trunk_target.inc:108: all] Error 2
> gmake[6]: *** [Makefile:94: lib-all] Error 2
> gmake[5]: *** [/home/wbx/arm/mk/pkg-bottom.mk:141: /home/wbx/arm/build_st-stm32f746g_uclibc-ng_cortex_m7_soft_eabi_thumb_nommu/w-ltp-20230929-1/ltp-full-20230929/.build_done] Error 2
> gmake[4]: *** [Makefile:61: ltp-compile] Error 2
> gmake[3]: *** [mk/build.mk:221: package/compile] Error 2
> gmake[2]: *** [/home/wbx/arm/mk/build.mk:176: world] Error 2
> 
> So there is really work to be done to make the existing code work on noMMU.

The new test library in LTP runs the actuall test in a child process,
which provides all kinds of benefits, most notably isolation of the
setup/cleanup/result reporting from actuall test code that may crash.
This is of course useless on nommu targets, so I suppose that we would
need a test library tailored for nommu first. However the testcases
themselve fork quite often too. Which means that some kind of parameter
marshaling into a string needs to be done for such tests as well each
test needs to be adjusted to use that in a case of nommu. All in all
getting into a state where majority of tests runs on nommu would be a
major effort.

-- 
Cyril Hrubis
chrubis@suse.cz

