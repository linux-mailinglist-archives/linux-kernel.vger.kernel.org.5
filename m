Return-Path: <linux-kernel+bounces-68990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5A785830F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A41284A84
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9991132C15;
	Fri, 16 Feb 2024 16:53:38 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B1130E2B;
	Fri, 16 Feb 2024 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102418; cv=none; b=Zu66BY4xl0rrT5AM5zvXzgV7AaSl5PsOWcjTaysncTvoxJqGEGgTqeUlpF1aCtpSNs6hd3lBssdIMCmF/6BI1xAyR77krJAAU3oZIn0WYtE3haUlNRX0mmhtpS1U1R6Mb8naeK2ywL/UHbcoXW5aBa9Hvh8MKcT53nxflJPJz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102418; c=relaxed/simple;
	bh=p+T7UhwuH1nBkWMxDYvNjDDJXqUPMgBVuhPNeXJWCME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E4cSg50v4hHWe+NZ5SU1PO5Fuwf21hmGRdlM3m+0mk9wbfiMVsDZOalk5XFMVPI6dTzZRBMEuHGbJu9OuXp8C07xbKWCzYEqtIk0KFngCggoXUeWsErwJk0LWSewjs+91PGnANQMr7HFvI/zqjhSLCXQuby1kBoBiqc52XsXGE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TbyKh0XDHz9xFH8;
	Sat, 17 Feb 2024 00:38:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id ECBB614059D;
	Sat, 17 Feb 2024 00:53:22 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCX0SXwks9lALGbAg--.29869S2;
	Fri, 16 Feb 2024 17:53:22 +0100 (CET)
Message-ID: <5916fa3ac3d0ce2ade71e7ed1c9eb6923e374c1f.camel@huaweicloud.com>
Subject: Re: [RFC 6/8] KEYS: PGP data parser
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Matthew Wilcox <willy@infradead.org>, Petr Tesarik
	 <petrtesarik@huaweicloud.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Petr =?UTF-8?Q?Tesa=C5=99=C3=ADk?=
 <petr@tesarici.cz>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "maintainer:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov
 <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Xin Li
 <xin3.li@intel.com>, Arnd Bergmann <arnd@arndb.de>,  Andrew Morton
 <akpm@linux-foundation.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kees Cook <keescook@chromium.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>,  Pengfei Xu <pengfei.xu@intel.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Ze Gao <zegao2021@gmail.com>,  "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, David
 Woodhouse <dwmw@amazon.co.uk>,  Brian Gerst <brgerst@gmail.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Date: Fri, 16 Feb 2024 17:53:01 +0100
In-Reply-To: <Zc-Q5pVHjngq9lpX@casper.infradead.org>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
	 <20240216152435.1575-1-petrtesarik@huaweicloud.com>
	 <20240216152435.1575-7-petrtesarik@huaweicloud.com>
	 <Zc-Q5pVHjngq9lpX@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCX0SXwks9lALGbAg--.29869S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw45Cr4kJF4ruF4rZFWkWFg_yoWDtFg_ZF
	WIqw4qkw4DGrZ3u3W29Fs3XFZ3KFWUA34UJw1UWFZFyr93JF93JFZ3Ww1rZ3Z3GayIyrnr
	G3s5Xr95tw129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n
	5UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj5ZtzAABsO

On Fri, 2024-02-16 at 16:44 +0000, Matthew Wilcox wrote:
> On Fri, Feb 16, 2024 at 04:24:33PM +0100, Petr Tesarik wrote:
> > From: David Howells <dhowells@redhat.com>
> >=20
> > Implement a PGP data parser for the crypto key type to use when
> > instantiating a key.
> >=20
> > This parser attempts to parse the instantiation data as a PGP packet
> > sequence (RFC 4880) and if it parses okay, attempts to extract a public=
-key
> > algorithm key or subkey from it.
>=20
> I don't understand why we want to do this in-kernel instead of in
> userspace and then pass in the actual key.

Sigh, this is a long discussion.

PGP keys would be used as a system-wide trust anchor to verify RPM
package headers, which already contain file digests that can be used as
reference values for kernel-enforced integrity appraisal.

With the assumptions that:

- In a locked-down system the kernel has more privileges than root
- The kernel cannot offload this task to an user space process due to
  insufficient isolation

the only available option is to do it in the kernel (that is what I got
as suggestion).

Roberto


