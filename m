Return-Path: <linux-kernel+bounces-20581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3215B8281DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEAC62867D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5946F33CED;
	Tue,  9 Jan 2024 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jJ+erWAu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1hYQ7UgD"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881114AA9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B33023200AC9;
	Tue,  9 Jan 2024 03:25:45 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Jan 2024 03:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1704788745;
	 x=1704875145; bh=hBMKB+Dkk2kBQqM04++7OqyTsEwWPWK3GWq70OG+7Eg=; b=
	jJ+erWAuc1/3ehk7PkR7NYTchmB94azb/q2Fkw22xWHw42diWo6cIbcWlXlejMud
	NJ/plXA23rA123lhW0Pnf1nqBPJBKgwJFWzziEag+lzvhVxEM+DswGhFk9VD71TJ
	zqbVZhwF5X/xd0tPijaPzYguJRpWMo1MrFGx/DfKMhyLhNwzBKZZeJJ3XyfN0UMc
	o3WXTkJXf/7bJsO83wrNqw91f+TJZ4wqtXLdw+Hxklu6Fq9NtgNSjUFAeSKeLbK/
	0gxN925pco7FUihI8zj2fE4KdSss2gGb8R/PHr+JHIW8ya3pDxNIxnEibstO3bYn
	gkAArTK8+eq8dcuRdFUfsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704788745; x=
	1704875145; bh=hBMKB+Dkk2kBQqM04++7OqyTsEwWPWK3GWq70OG+7Eg=; b=1
	hYQ7UgDZ/2dNLgU2obJugCGqdDgITW3X5b/e7rKs10uv23h9LqGaeOefXIRjDju7
	D1PFCt+oVxKpqS3HQA45kNsTzpSpsStDLsgXjkUlLPEGkCQA8qnf/F4RIe3q2AHJ
	fab4cJ/V0nlx7LJPAhf82G21kAVxwW4w8UbV1Y5ozp3LpXNJXqDDD0fNlwlojtGp
	ZD5NacK2f5ovYh17trpSc/RFuuJap8By+OEtmrj6SNM0dUYTxYh1HwTItstjszWZ
	4lVXAxeqTfR0m7RVXCbNDmxdAHn2NrDQxsCxf1DxTepoC9j6eDfXyOqRYjtJwhDv
	IWqeyHjp90JITL23xTKpg==
X-ME-Sender: <xms:CAOdZQ7FEJWR8jJoWOt7cEMzYexz-uiW39Gzcmprc9M97e3JPmxmjQ>
    <xme:CAOdZR6XDJ63ehbXd_dp_O6U9WDOv1Esd9EEeGFMDRkTTo0FgpdQBEBY2zGVMnTbV
    bheU7a-1b0MJcVkjYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehkedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeehgfegudeuvddvgfeigfffheeftdffvddvudethfdvvddthffgteev
    teeuveehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:CAOdZfejKeZq0sg3UMu0Q5IA8BWR7_yaFIDkN_8D032MWlXv6hkt_A>
    <xmx:CAOdZVImogcMaM6TxUsDEOmyZ_0akC0DwORR0Bny1g11MSq85eLbRQ>
    <xmx:CAOdZULBU5quxaUbhehtzln917TjyQQUWGSrI_7lGrknibiOFI9YXg>
    <xmx:CQOdZehms4A0l6ZKDk_03hzLGFRcwhlvsiQX0AJ485utKGJJfsNz9w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 49D0EB6008D; Tue,  9 Jan 2024 03:25:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d9d3dbe5-1f5a-45cd-a5cc-a54836d8e077@app.fastmail.com>
In-Reply-To: <ZZvGxhON7wNBgyg5@yujie-X299>
References: <202401061736.yM5FZ2oV-lkp@intel.com>
 <CACRpkdbx=qgdy1JRyxzFGW+8Ojj+g2tLKU4dD8oWX9V0xH2-JQ@mail.gmail.com>
 <ZZvGxhON7wNBgyg5@yujie-X299>
Date: Tue, 09 Jan 2024 09:23:57 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <yujie.liu@intel.com>,
 "Linus Walleij" <linus.walleij@linaro.org>
Cc: "kernel test robot" <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>
Subject: Re: arch/alpha/include/asm/core_t2.h:587:23: warning: no previous prototype
 for 't2_ioread64'
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024, at 10:56, Yujie Liu wrote:
> On Sun, Jan 07, 2024 at 09:09:21PM +0100, Linus Walleij wrote:
>> Hi robot,
>>=20
>> On Sat, Jan 6, 2024 at 10:40=E2=80=AFAM kernel test robot <lkp@intel.=
com> wrote:
>>=20
>>=20
>> > Hi Arnd,
>> >
>> > FYI, the error/warning still remains.
>>=20
>> FYI I have already said I can't reproduce this at all. Not using
>> allnoconfig, not using the .config attached to the report.
>>=20
>> I have no idea what this is.
>
> We double checked this, and looks like it needs to be reproduced by
> "make W=3D1". Could you please recheck with W=3D1?
>
> The following link has some hints of handling W=3D1 warnings:
>
> https://github.com/intel/lkp-tests/wiki/LKP-FAQ#how-is-one-meant-to-ac=
t-on-w1-reports-like--wmissing-prototypes
>
> Please kindly let us know if you'd like to ignore these W=3D1 warnings,
> and we will configure the bot for you to avoid further bothering.

This warning used to be part of the W=3D1 set (as well as C=3D1
with sparse) but is now enabled by default once my patch from
linux-mm makes it into mainline, but there are more things going
on here:

- the particular warning about t2_ioread64() gets flagged by lkp
  because it was introduced when I extended the ioread family
  to also include the 64-bit access rather than just 8/16/32 bit
  functions. The other ones were always there but are ignored
  by lkp.

- Someone who cares about alpha should just address all
  the warnings, including the old one about 'clone3' that needs
  to be done by someone that understands the alpha calling
  conventions, see below for the current output in linux-next.

- part of the problem of the missing-prototypes warnings on
  alpha is the extensive use of 'extern inline' on this
  architecture that should be replaced with 'static inline' in
  almost all cases (as we did on all other architectures
  decades ago).

    Arnd

8<---
<stdin>:1521:2: warning: #warning syscall clone3 not implemented [-Wcpp]
/home/arnd/arm-soc/arch/alpha/kernel/traps.c:178:1: warning: no previous=
 prototype for 'do_entArith' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/traps.c:200:1: warning: no previous=
 prototype for 'do_entIF' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/traps.c:341:1: warning: no previous=
 prototype for 'do_entDbg' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/traps.c:377:1: warning: no previous=
 prototype for 'do_entUna' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/traps.c:662:1: warning: no previous=
 prototype for 'do_entUnaUser' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/irq.c:96:1: warning: no previous pr=
ototype for 'handle_irq' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/irq_alpha.c:45:1: warning: no previ=
ous prototype for 'do_entInt' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/signal.c:205:1: warning: no previou=
s prototype for 'do_sigreturn' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/signal.c:233:1: warning: no previou=
s prototype for 'do_rt_sigreturn' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/signal.c:523:1: warning: no previou=
s prototype for 'do_work_pending' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/ptrace.c:322:26: warning: no previo=
us prototype for 'syscall_trace_enter' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/ptrace.c:334:1: warning: no previou=
s prototype for 'syscall_trace_leave' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/io.c:654:1: warning: no previous pr=
ototype for 'scr_memcpyw' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/bugs.c:19:9: warning: no previous p=
rototype for 'cpu_show_meltdown' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/bugs.c:28:9: warning: no previous p=
rototype for 'cpu_show_spectre_v1' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/bugs.c:37:9: warning: no previous p=
rototype for 'cpu_show_spectre_v2' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/pci.c:285:1: warning: no previous p=
rototype for 'pcibios_claim_one_bus' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:457:20: warning: no =
previous prototype for 't2_readb' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:468:21: warning: no =
previous prototype for 't2_readw' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:483:21: warning: no =
previous prototype for 't2_readl' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:494:21: warning: no =
previous prototype for 't2_readq' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:507:22: warning: no =
previous prototype for 't2_writeb' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:518:22: warning: no =
previous prototype for 't2_writew' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:533:22: warning: no =
previous prototype for 't2_writel' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:542:22: warning: no =
previous prototype for 't2_writeq' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:554:31: warning: no =
previous prototype for 't2_ioportmap' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:559:31: warning: no =
previous prototype for 't2_ioremap' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:565:21: warning: no =
previous prototype for 't2_is_ioaddr' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:570:21: warning: no =
previous prototype for 't2_is_mmio' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:579:23: warning: no =
previous prototype for 't2_ioread8' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:586:22: warning: no =
previous prototype for 't2_iowrite8' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:579:23: warning: no =
previous prototype for 't2_ioread16' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:586:22: warning: no =
previous prototype for 't2_iowrite16' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:579:23: warning: no =
previous prototype for 't2_ioread32' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:586:22: warning: no =
previous prototype for 't2_iowrite32' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:579:23: warning: no =
previous prototype for 't2_ioread64' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:586:22: warning: no =
previous prototype for 't2_iowrite64' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/include/asm/core_t2.h:606:33: warning: no =
previous prototype for 't2_iounmap' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/srmcons.c:267:1: warning: no previo=
us prototype for 'register_srm_console' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/srmcons.c:277:1: warning: no previo=
us prototype for 'unregister_srm_console' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/console.c:39:1: warning: no previou=
s prototype for 'locate_and_init_vga' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/console.c:72:1: warning: no previou=
s prototype for 'find_console_vga_hose' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/core_cia.c:284:1: warning: no previ=
ous prototype for 'cia_pci_tbi_try2' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/core_cia.c:580:1: warning: no previ=
ous prototype for 'cia_save_srm_settings' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/core_cia.c:606:1: warning: no previ=
ous prototype for 'cia_restore_srm_settings' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/sys_nautilus.c:82:1: warning: no pr=
evious prototype for 'nautilus_kill_arch' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/sys_nautilus.c:131:1: warning: no p=
revious prototype for 'nautilus_machine_check' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/sys_nautilus.c:201:1: warning: no p=
revious prototype for 'nautilus_init_pci' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/smc37c669.c:2434:1: warning: no pre=
vious prototype for 'SMC37c669_dump_registers' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/smc37c669.c:2467:13: warning: no pr=
evious prototype for 'SMC669_Init' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/kernel/smc37c93x.c:238:12: warning: no pre=
vious prototype for 'SMC93x_Init' [-Wmissing-prototypes]
/home/arnd/arm-soc/arch/alpha/mm/init.c:261:1: warning: no previous prot=
otype for 'srm_paging_stop' [-Wmissing-prototypes]

