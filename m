Return-Path: <linux-kernel+bounces-66564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60D9855E68
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C242AB2746C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014D918AE0;
	Thu, 15 Feb 2024 09:37:46 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667F17993;
	Thu, 15 Feb 2024 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989865; cv=none; b=fW64di+cY4Ex21cUWiqZ180WSIN3PZbsmcFeRMrhDrWhptti4Uy3N1dR7WmzWiiNkkBPS+F2ZQL1+t37AL6Ynff3VzUW4HR16BXxGuBo6d02y989d02TMagk12UlMpAR7ONBso0g3ZFzMjIYmNbYiJlC0jVmp3zljr5jGIFE4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989865; c=relaxed/simple;
	bh=wvLiPqtIwRGFF2cil8jfxLt3kJn7dK1Twukm5qMnnp0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MucDB/MA6qRkFjG86fb68ZOgQsrQNzhyjnKiWXY/L7K7tpprloMlXcX+uytpdv0O8jjXLQT9WCvrQWsI0/tgZeFsYShTMS5keZqIVvAhG8ruDkHGDvVxAkxVwmFrxz6OC/BhBfCrnq4dReZ3FHZujTAX09B6kohGzhqmKfsBiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tb8ck5jvQz9xHMp;
	Thu, 15 Feb 2024 17:18:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 8EF87140636;
	Thu, 15 Feb 2024 17:37:29 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBXkSVI281l9NOGAg--.64666S2;
	Thu, 15 Feb 2024 10:37:28 +0100 (CET)
Message-ID: <ee6f959ec1dfeb72c6b2902cbc352f97e384ca8c.camel@huaweicloud.com>
Subject: Re: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Petr =?UTF-8?Q?Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>, "H. Peter Anvin"
	 <hpa@zytor.com>
Cc: Xin Li <xin@zytor.com>, Dave Hansen <dave.hansen@intel.com>, Petr
 Tesarik <petrtesarik@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Xin Li <xin3.li@intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>,  Kees Cook <keescook@chromium.org>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Pengfei Xu
 <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Ze Gao
 <zegao2021@gmail.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>,  Kai Huang <kai.huang@intel.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Brian Gerst <brgerst@gmail.com>,  Jason
 Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>
Date: Thu, 15 Feb 2024 10:37:10 +0100
In-Reply-To: <20240215103058.52461397@meshulam.tesarici.cz>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
	 <c424618c-d6c6-430a-8975-8851a617204e@intel.com>
	 <20240214192214.78734652@meshulam.tesarici.cz>
	 <c66fa3f4-13f0-4355-9bf4-34fec31182de@zytor.com>
	 <20240215075932.66fef954@meshulam.tesarici.cz>
	 <5434F240-2F74-4D9F-8BEE-220C8EC53C0F@zytor.com>
	 <20240215103058.52461397@meshulam.tesarici.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBXkSVI281l9NOGAg--.64666S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1kuFW8tw1fZr47Zw18Zrb_yoWrWrWUpF
	W3JayFkF4Dtry5Z3Wxtw1xZFy0yry3Ar1DXFn5Gryvvrn0yr9rXr1ftw15uFW7urs7Gr1j
	vr4jqF9rua45Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUFfHUDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5pehQAAs7

On Thu, 2024-02-15 at 10:30 +0100, Petr Tesa=C5=99=C3=ADk wrote:
> On Thu, 15 Feb 2024 00:16:13 -0800
> "H. Peter Anvin" <hpa@zytor.com> wrote:
>=20
> > On February 14, 2024 10:59:32 PM PST, "Petr Tesa=C5=99=C3=ADk" <petr@te=
sarici.cz> wrote:
> > > On Wed, 14 Feb 2024 10:52:47 -0800
> > > Xin Li <xin@zytor.com> wrote:
> > > =20
> > > > On 2/14/2024 10:22 AM, Petr Tesa=C5=99=C3=ADk wrote: =20
> > > > > On Wed, 14 Feb 2024 06:52:53 -0800
> > > > > Dave Hansen <dave.hansen@intel.com> wrote:
> > > > >    =20
> > > > > > On 2/14/24 03:35, Petr Tesarik wrote:   =20
> > > > > > > This patch series implements x86_64 arch hooks for the generi=
c SandBox
> > > > > > > Mode infrastructure.   =20
> > > > > >=20
> > > > > > I think I'm missing a bit of context here.  What does one _do_ =
with
> > > > > > SandBox Mode?  Why is it useful?   =20
> > > > >=20
> > > > > I see, I split the patch series into the base infrastructure and =
the
> > > > > x86_64 implementation, but I forgot to merge the two recipient li=
sts.
> > > > > :-(
> > > > >=20
> > > > > Anyway, in the long term I would like to work on gradual decompos=
ition
> > > > > of the kernel into a core part and many self-contained components=
.
> > > > > Sandbox mode is a useful tool to enforce isolation.
> > > > >=20
> > > > > In its current form, sandbox mode is too limited for that, but I'=
m
> > > > > trying to find some balance between "publish early" and reaching =
a
> > > > > feature level where some concrete examples can be shown. I'd rath=
er
> > > > > fail fast than maintain hundreds of patches in an out-of-tree bra=
nch
> > > > > before submitting (and failing anyway).
> > > > >=20
> > > > > Petr T
> > > > >    =20
> > > >=20
> > > > What you're proposing sounds a gigantic thing, which could potentia=
lly
> > > > impact all subsystems. =20
> > >=20
> > > True. Luckily, sandbox mode allows me to move gradually, one componen=
t
> > > at a time.
> > > =20
> > > >  Unless you prove it has big advantages with real
> > > > world usages, I guess nobody even wants to look into the patches.
> > > >=20
> > > > BTW, this seems another attempt to get the idea of micro-kernel int=
o
> > > > Linux. =20
> > >=20
> > > We know it's not feasible to convert Linux to a micro-kernel. AFAICS
> > > that would require some kind of big switch, affecting all subsystems =
at
> > > once.
> > >=20
> > > But with a growing code base and more or less constant bug-per-LOC ra=
te,
> > > people will continue to come up with some ideas how to limit the
> > > potential impact of each bug. Logically, one of the concepts that com=
e
> > > to mind is decomposition.
> > >=20
> > > If my attempt helps to clarify how such decomposition should be done =
to
> > > be acceptable, it is worthwile. If nothing else, I can summarize the
> > > situation and ask Jonathan if he would kindly accept it as a LWN
> > > article...
> > >=20
> > > Petr T
> > > =20
> >=20
> > I have been thinking more about this, and I'm more than ever convinced =
that exposing kernel memory to *any* kind of user space is a really, really=
 bad idea. It is not a door we ever want to open; once that line gets muddl=
ed, the attack surface opens up dramatically.
>=20
> Would you mind elaborating on this a bit more?
>=20
> For one thing, sandbox mode is *not* user mode. Sure, my proposed
> x86-64 implementation runs with the same CPU privilege level as user
> mode, but it is isolated from user mode with just as strong mechanisms
> as any two user mode processes are isolated from each other. Are you
> saying that process isolation in Linux is not all that strong after all?
>=20
> Don't get me wrong. I'm honestly trying to understand what exactly
> makes the idea so bad. I have apparently not considered something that
> you have, and I would be glad if you could reveal it.
>=20
> > And, in fact, we already have a sandbox mode in the kernel =E2=80=93 it=
 is called eBPF.=20
>=20
> Sure. The difference is that eBPF is a platform of its own (with its
> own consistency model, machine code etc.). Rewriting code for eBPF may
> need a bit more effort.
>=20
> Besides, Roberto wrote a PGP key parser as an eBPF program at some
> point, and I believe it was rejected for that reason. So, it seems
> there are situations where eBPF is not an alternative.
>=20
> Roberto, can you remember and share some details?

eBPF programs are not signed.

And I struggled to have some security bugs fixed, so I gave up.

Roberto


