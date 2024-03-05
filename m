Return-Path: <linux-kernel+bounces-92752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8A2872588
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC4E1F2219B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F3214A9F;
	Tue,  5 Mar 2024 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hgZ84nEx"
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D36944F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659136; cv=none; b=oWAtEVIw7rofoC1eo+dFxkBVF2sgw2WY3HxEHJRj6O4RXVjZ0pvE017VF6t2zaekxq14upbPibRPOaPELxbj4DnG7UZmtuGfQVCBF5lAknACgcEiSmswYb+8w2Ykd7fudCpBDxpKWjGd9UeMdSJbKA4aZ/kZmZ1cuNmeA0RguuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659136; c=relaxed/simple;
	bh=aTcTcwCsojcYgR2q6qRJNGp5j8F3+tgkYmGHqLDcQQE=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=UN/bF1+QlGYWNmCFcqJnn8+nPL4rps5bHMwaaAuHsLBCmu8KqMLP7QMzgNTlEhX1IdAXrl4mqZXtmqEDKUS/khR2BxePdZe/5xCITPWv/6lBwTX3u9m4h6QFDhAchEPy1tjxzLx6GAk0Bbuha/vkFbuGka+hOardX4Z+R8GWzro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hgZ84nEx; arc=none smtp.client-ip=203.205.251.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709659129; bh=h1LTH6JlAYoOApJUnNVPyf95mfcxBxOkhaNODYU3s9k=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=hgZ84nExgpVx9cZxZBYiXvEzN/CZRuVloDj18WaTl/EgsrBFJmLX0m29J8EN2Dioy
	 A9g9LetEvlKbiYpmsFuAV+IfXORIoEtY7QMQZn6en0E0iTlntyZ5V1rlozAY00ggRB
	 keTpJ7/KT5Un/zhWWlUrYF3GZQoMFlzdiVSBXajs=
Received: from smtpclient.apple ([2001:da8:c800:d084:84f7:c158:bab8:8899])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 467314A0; Wed, 06 Mar 2024 01:17:39 +0800
X-QQ-mid: xmsmtpt1709659059trsahnpa9
Message-ID: <tencent_3638D6E106C784859837E6F3C10BDA688F0A@qq.com>
X-QQ-XMAILINFO: NJZTpFGUMYNFt/STRSnmNanLRlv+mPJcdXyrQHRC4MjkD977hfF0dHwRU2EIfN
	 XYxgfzvRrE1brWIIjF9OhanlPDr/oV/0DRHZbKq0zvC5CElI6a/9pcvvC7DHhU5hCOxNzIX+/53r
	 ZC7wqApkEdQFmPMO6NVOdxLzHr8fSuZJZwBIWn09pu7QF0Wn9gMD1VZHp7z3aejWh+5b1Yc1Qrur
	 zph6NdrWlPwC/CfyjHzPCF/74IxvIBYIaQcBNGtqT7LV+tg6smhRg/zHfzJKzx8ANPo5XwR/x1+Q
	 /j67DOdbeDSKFQQxVsBIeUWK6XhgHdqi6TiUVf5FbEX2jrXRa5UdcvIgUb7yYwtv8YsUgMxJBSx3
	 ESAhAQ1L2qpHT9tangOTIRFCxkwfVIuVxtFnWNqD6xmdtlU5f5F4bW/6cOoBrGWhtsdwr3SjvdcC
	 +rcBicfEKa7ikuzs5fY/zcP7uDtbkCR1CjSyQUaOCqNXvHM+hsFHAFfRWc5AUmEmDv2vkYxAHo1R
	 SYnNQjVo5/6CafYVSsJ6XHquDhCia4psSafXx/2BWIAWx6E2Aio9laQviGiAu3LK17iSmxs/9fSA
	 3EOf16UtX6eewIUvAVi2cwVMnZnz8A9m1PpBtfBaMVMDCnvNHhRlF2e72AQfH2fizfvNZ1yvtnhB
	 vBdBiwwHBPSr2yC5YHD7hBwOZWpiBCP3ZcmxUx8TAcdFBUebftxRc35BxBPZW6pjfEhH8gRk4tuA
	 lrIRHSQOLNFJRZQm44/DqAFgxty2jWM3No1kbCnZ2WLIkfkaxdnaYh8mCE+ObvKd8LVgbXAyznrb
	 KJuyr/UZ0T5BHVP+gOKS2IdTXam4tMQtRAfQ/MqRFW+rr/kKdM5L0ZMsV4hY1dXBE3Qxco+GruWs
	 ACUqKmA00dv8/UAuyFb4sVAjqFHV+EIZnEP36LZboNpHbAAcO4zrPGexYIiHTCRhiUui7xlGmA6j
	 I+JE8+cN52VXFCb4EbN/qLTcBeRU88cKXK5SbzohC6ntp5x3VjM2OvasBe5lq/yLV1lQ2nSkLIPc
	 S8r8djg6HeLjADlWd6
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v3 6/7] riscv: dts: add initial canmv-k230 and k230-evb
 dts
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240305-shorten-disallow-eae65fdc8fdb@spud>
Date: Wed, 6 Mar 2024 01:17:29 +0800
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 krzysztof.kozlowski+dt@linaro.org,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 guoren@kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <C39896C7-3E16-48AF-8368-84BB10671CD4@cyyself.name>
References: <mhng-f1aa91d4-211f-4eb4-a94d-a9d88b0d3f6a@palmer-ri-x1c9>
 <7A86D933-B85F-4B29-8D6D-AB414A42AC06@cyyself.name>
 <tencent_B2C1146D4947315C8018AE90EDC64F3E6207@qq.com>
 <20240305-shorten-disallow-eae65fdc8fdb@spud>
To: Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)



> On Mar 6, 2024, at 01:01, Conor Dooley <conor@kernel.org> wrote:
>=20
> Hey,
>=20
> Just chiming so that things don't get misinterpreted.
>=20
> On Wed, Mar 06, 2024 at 12:37:16AM +0800, Yangyu Chen wrote:
>>> On Mar 6, 2024, at 00:22, Yangyu Chen <cyy@cyyself.name> wrote:
>>>> On Mar 5, 2024, at 23:54, Palmer Dabbelt <palmer@dabbelt.com> =
wrote:
>>>> On Mon, 04 Mar 2024 13:06:00 PST (-0800), cyy@cyyself.name wrote:
>>>>> - Svpbmt and T-Head MAEE both supported
>>>>>=20
>>>>> T-Head C908 does support both Svpbmt and T-Head MAEE for =
page-based memory
>>>>> attributes and is controlled by csr.mxstatus. If the kernel wants =
to use
>>>>> svpbmt, the m-mode software should set BIT(21) of csr.mxstatus to =
zero
>>>>> before entering the s-mode kernel. Otherwise, the kernel will not =
boot as 0
>>>>> on T-Head MAEE represent to NonCachable Memory and it will lose =
dirty cache
>>>>> lines modification that haven't been written back to the memory.
>>>>=20
>>>> So I guess we need the bootloader to just be accurate here?  ie: =
whatever
>>>> extension it tells S-mode kernels is enabled is how S-mode behaves, =
and
>>>> then this should just work itself out.
>=20
> Correct, the bootloader/firmware "just" needs to write this bit to =
match
> what it passes to onwards in the devicetree.
>=20
>>> Yes. Currently, I have patched OpenSBI to disable MAEE. Conor Dooley =
said
>>> from a public irc group that he wants to control the enable of =
T-Head
>=20
> (#riscv on libera, the usual location)
>=20
> I also suggested that that, given we can use the standard extensions,
> we should use them instead of the custom extensions/errata.
>=20
>>> variation of zicbom and svpbmt from dts, in addition to mimplid or
>>> something now.
>=20
> Correct. I'm find with the impid =3D=3D archid =3D=3D 0 condition, =
given that's
> what we need to keep to avoid regressions, but if any future T-Head =
CPUs
> want to enable MAEE (ERRATA_THEAD_PBMT) or the custom CMOs
> (ERRATA_THEAD_CMO) these should be enabled from DT. Particularly when
> these CPUs can be configured to either use the T-Head versions or the
> standard extensions.
>=20
>>> I think that will be a better way for the bootloader to tell
>>> the kernel whether the T-Head MAEE should be enabled.
>=20
> You've got three options I guess. You could patch the DT in the =
bootloader,
> or use a fixed DT that matches the bootloader, or you could use the DT
> passed to the bootloader and parse the extensions to decide whether or =
not
> to enable MAEE or Svpbmt. Seems you're going for option 2.
>=20

The patched opensbi is only for work around now as the factory-provided
M-Mode uboot will enable MAEE. I would like option 1 to let the =
bootloader
choose what to use and patch the DT to tell the linux whether should use
T-Head MAEE as T-Head is likely to use this feature on TEE
(Trusted Execution Environment), so it might never be removed.

>>> Link: =
https://github.com/cyyself/opensbi/commit/b113c1c01d700314a4a696297ec09031=
a9399354
>>>=20
>>> Furthermore, I wonder whether a CPU node like this would be =
acceptable.
>>> I don't have any other details of how another CPU from K230 SoC =
works on
>>> Linux.
>=20
> A CPU node like what? It is not clear to me.

It in the k230.dtsi file. Only has big core there.


