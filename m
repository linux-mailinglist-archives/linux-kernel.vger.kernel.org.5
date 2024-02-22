Return-Path: <linux-kernel+bounces-76274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8EB85F505
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991AA1F23FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FD7383AE;
	Thu, 22 Feb 2024 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VCbKYGtd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c7qnRiXU"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484C381CF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595555; cv=none; b=B3jQ7HsWhbTWNiQxUgoYetkEbYXt/PI94P0Efho4cmhjzjgSOWVglQkVjRMcnL6Lst7NJUOLBcMDflf8naDht4c9+GOunYRm7QHLdt1FU+NLO/RVa2GZmLApnE1SZ6ozEEPoz5DGYtQWeo5xRu6OelzxTmodqwnqpKM2mD/2vkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595555; c=relaxed/simple;
	bh=HOZYXhL4vcrBK8qYEIzFcy8lZeDLT7hOe+iAX+muuHI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=k/z5MGGQeS0GMR+1uPOs3FcXGpCwotrlITpjx14l2GFFNg+D6t9iE8CIcn683l20NWoNHXKLJI1fOnYtYy0gItxNfDj0/84K3NED2lhe/A5HMwQa96OXOHuCAiLZrFyN9QAG/k2SN1Ov0oD6dCR7/N4nogR69kQI0Vp82cLh4TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VCbKYGtd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c7qnRiXU; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2C94411400F7;
	Thu, 22 Feb 2024 04:52:32 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 22 Feb 2024 04:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708595552; x=1708681952; bh=sWqOg9vqpF
	/hATM4kd4bO7A1Fp4iMXPUWdfKEDmsH50=; b=VCbKYGtdzIHr+0g+rlNOS5k/W3
	pVHXdbxW1T/nVnGxOjRO1BNzN0h/eZzFVRU2rHWZPpDrqYMenFU7TRVzAQV2qFQJ
	toCDTvlMV94atjLQYej4fdAFmOUjNCJQlLtIoK3BknDQQ0HR7gtzr6SvShsZg0Is
	T2ucCngQE4R2m0SnT/FHuam1nPKStjR6PXbHODwcuywWu7wAG1YgpOmOa2k3DP5x
	fo1TatQGblmjDZWXA/x5r5JrUcs23Mk3ZViUjezdpOuDE5HjpBT2WLOpWPZa4aRM
	OOekMPZ27KGM2aBzEDMmCt73WEvEHjM8tGm+RKKKSyLUeD7fN5LdT65chIag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708595552; x=1708681952; bh=sWqOg9vqpF/hATM4kd4bO7A1Fp4i
	MXPUWdfKEDmsH50=; b=c7qnRiXUdnRXNntvvqaicsu0Ht3K94DQavYXoGixf8xo
	cBXptEi5DFQACFBfKScv62ahqOLz/hKjwTeVfn18LtC56S9k70XWrncjvvnEpBG5
	7fv2Lpr4cVNy9ZIl4MKHbWnr6rmBvMjzMxZu4bAvRaf3awoyLuV8hbKIek1fBFhn
	2lIXpqPf4ZoC/vh+1frUtBujwVQDg7z2nPEh1XmLjDskgcDSiA0Ymc8T53xoIoi2
	UAjde8cxUW6S9F+apIf/QeKxthl/whi3T/RtplrIPwAfYBShCX3bDxn+Unl6a+UY
	rbBiiQM/JC5Bu3//4RkIrkc11FWLlzm50PRVewWy9A==
X-ME-Sender: <xms:XxnXZfOwSLQvhFUH8BkRctSBE1Yjh3RO1mYNkUY98Wdbz37qaR4hGg>
    <xme:XxnXZZ_F5zNTBmdUX0d1gIT3gNP02Xgbq0ay2bq4tYRpZTOc_q3AEeFjikgaEj_-7
    8bUuBmXsBrYzQDOFjk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevgeehleejvdefgefftdevvedtudffudefffeggfdvgeffleefudehgffgledu
    heenucffohhmrghinheplhgushdrshdqqddqrgdprghrtghhrdhinhhfohenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggv
X-ME-Proxy: <xmx:XxnXZeRWMF2ERI0jtoNbgLizDGzK2xmuZ3kyvmSGqV3_QarYUoj6cQ>
    <xmx:XxnXZTtDuTKGZs6U_uirjxiNcSKQxLH2RuefSVPSYRYVn0-tdF_1gA>
    <xmx:XxnXZXdm8GtyFREM7qQv-LeLk_23E_0k6c0_qspkZm7bjOghzTmvfQ>
    <xmx:YBnXZS9smOznPuldPy-RvHsy-uv1UJjExVnkHxmX6hbhSFSRrWhq5w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 319EBB6008F; Thu, 22 Feb 2024 04:52:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f5326293-b446-49e5-9cc0-78c9009af136@app.fastmail.com>
In-Reply-To: <30b01c65-12f2-4ee0-81d5-c7a2da2c36b4@app.fastmail.com>
References: <20240220081527.23408-1-liuyuntao12@huawei.com>
 <1342759e-b967-4ec4-98d5-48146f81f695@app.fastmail.com>
 <38c09a4b-69cc-4dc5-8a68-e5f5597613ac@huawei.com>
 <30b01c65-12f2-4ee0-81d5-c7a2da2c36b4@app.fastmail.com>
Date: Thu, 22 Feb 2024 10:52:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yuntao Liu" <liuyuntao12@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Russell King" <linux@armlinux.org.uk>, "Andrew Davis" <afd@ti.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Jonathan Corbet" <corbet@lwn.net>, "Mike Rapoport" <rppt@kernel.org>,
 "Eric DeVolder" <eric.devolder@oracle.com>, "Rob Herring" <robh@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Linus Walleij" <linus.walleij@linaro.org>
Subject: Re: [PATCH -next] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Type: text/plain

On Wed, Feb 21, 2024, at 16:51, Arnd Bergmann wrote:
> I have given your patch some build testing with random
> configurations in my build setup and it seems to work
> fine with gcc/binutils, but unfortunately I came across
> a link failure using clang/lld:

I ran into another bug now, this time with CONFIG_XIP_KERNEL=y:

no __ex_table in file: vmlinux
Failed to sort kernel tables
make[4]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1

Essentially you have to modify arch/arm/kernel/vmlinux-xip.lds.S
the same way as vmlinux.lds.S:

--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -63,7 +63,7 @@ SECTIONS
        . = ALIGN(4);
        __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
                __start___ex_table = .;
-               ARM_MMU_KEEP(*(__ex_table))
+               ARM_MMU_KEEP(KEEP(*(__ex_table)))
                __stop___ex_table = .;
        }
 
@@ -83,7 +83,7 @@ SECTIONS
        }
        .init.arch.info : {
                __arch_info_begin = .;
-               *(.arch.info.init)
+               KEEP(*(.arch.info.init))
                __arch_info_end = .;
        }
        .init.tagtable : {


The pv_table is not needed for XIP_KERNEL=y because that
requires not patching the kernel.

    Arnd

