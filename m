Return-Path: <linux-kernel+bounces-93481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5880587305E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E745AB2455F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FC65CDFF;
	Wed,  6 Mar 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="r2ZsXmv+"
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E525199DC;
	Wed,  6 Mar 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712892; cv=none; b=E9ThCOyLl0+a7O81E1IM3YpWE2J2sUxGDXU0kfPLKsZyxT4Xs3CHlESC5kri+B4G+YQF5chM1ZF7GjCv22zC2snM+oNC4tC+2qZRNv1Bh4B/O/QHmJTRExkOcEBSxoj8lM9iF2Qjy81KYfSR66XsTfslTOwoyY9BtNt52FsXPtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712892; c=relaxed/simple;
	bh=pPMJnH0jCizktLagCZ8sCvRmAhlYwiHpXpjh0p5Cjuw=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=pK1PbPRyP+Jba45GDr/A4/hgstmkaSP8FowjLheN8sEGZ1P+xoQoFpzMeIAdK9ZOjTQv06x8gDHITJ2uUzaqr1uwAxpqMb4/S38O2w4PLI8XLQBaSJDjXg+hkTnSwF5bkaXvBYBGJY3GOSbLfwdx4pO409WlUgrIEef69DJpivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=r2ZsXmv+; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709712887; bh=9ZDgt5gLIY11SLql3p/ig4kBiaTGNRUoEIGN2lKaRXU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=r2ZsXmv+5w0eHtCGI8p4hI9qOsBODQFlhj7zPbD9ZDOLngvhrssOinr1vJbvjs4G5
	 qll6pevem8iMGrWjkqEacXvvorEMlI0qeGPvPx0uoM4AX1D2cP/dOuPz2HEeIW2uG3
	 5IRtc2faS6pdPVF/sYtgaH4dvxE/wVQBaTFbkEqs=
Received: from smtpclient.apple ([2001:da8:c800:d084:84f7:c158:bab8:8899])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 3AB9F6A4; Wed, 06 Mar 2024 16:14:43 +0800
X-QQ-mid: xmsmtpt1709712883txjjbm2qe
Message-ID: <tencent_91E604E3B4D51DA37045625242A81B07F909@qq.com>
X-QQ-XMAILINFO: NMiAo2azIaDAtuI0CHS+mfpvOPYmsI2MiZYibrr/Tsqdm+I3ZxIzjMsk3qNcep
	 bVa+c/igwFVBE7LJiCeCBXQQIdVsJFCeHTu/UXDofThdVgjwzC4yaytc+SKptboVVzHmBORSmUky
	 dXxngSHahP3Q1cTkzvkZPXhWa1KXSNjSfLVelBBevdNZtcouoYJVLJi4k8D30fUe33u3+uMQMvLm
	 BDxoto3LUqeCA4yDGbRlnoQyvn8PWnKGljzgvv+5wbDOXWP3ULy5zeouxE09pb5s3gboRlLe/q4X
	 /TXzDxuqCh+R0SIQXumhb1PnhlhVzmptBKZyHs9f3ilHa2arjn+BDrV7h5/5yUh8JrIHnyGY1gdu
	 tHx3JTfCf+EEtneSZOoMIH+1hFGiEx+Bi6zQaPhoWdR/is811MseSHUO/ni4GYDn0KHi2K8IPdiC
	 sE+CVL5hrQJw758Np+RfPCOdy5DgSQd3Dy0FP2KC31gEeXlkItCVGN2vemAl9IeG8ohDdZysZoF7
	 +iofmHf8wTvz2Fj1NyBgZCINVb9d9jQ8kht4zHUR+M0nHxq0zo57sLDSLaXTeK07wmVrZPMNHjZ5
	 KnjQg17qFfzyJSoqcBnYB06lc6VsI8WTrbJUr3Zr85Sd9gAnhzv1CiVE1eYMJ9Q3omrihXhjONu5
	 /yq9labyj23RC0xT0ggp8sLrTh3H/RQIpaK8+zI/ykjQ53jEMfzbuBBLB7pXShvl6PkeMXitcaYk
	 CXCZdvzryDdnZ5Kzr57l2GaKXXsecCFV4VXyfnWGq+YG4uheKooDCB+zQzOJ013FuzoJ0OcIg8eU
	 7cf/fZvY99GxeE+jJfDea/azin5FF0gOpZzGLeIZ8op0vwiPBS5tde2QXoJyq3msRVW5MhF4g9c5
	 yggGyaKG7nDUBJKq8lnrMF6rh7pF0s5iWgcbcTcE9OgTc21DljLiVXskBbxbNo7YGelP+fZSJvvm
	 DhjeoXvsc0r1Mu2lfAHUZTxUmjMxcrxhrlNvPrQcNOrd9vu0A/mvrYBvUdxRGFK7j846MxlPg=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v5 5/7] riscv: Kconfig.socs: Split ARCH_CANAAN and
 SOC_CANAAN_K210
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240306-scowling-mortify-9b427c80e8ab@wendy>
Date: Wed, 6 Mar 2024 16:14:33 +0800
Cc: Guo Ren <guoren@kernel.org>,
 linux-riscv@lists.infradead.org,
 Conor Dooley <conor@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <AEDFD00A-160A-4237-99C0-A3A50929E4A1@cyyself.name>
References: <tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com>
 <tencent_6F35FEF31908DE6AEB385AE30AC658863C0A@qq.com>
 <CAJF2gTS1-VQP=gQBx=SoUWsdap153EGOObKVn+2L7=kbP2CqFg@mail.gmail.com>
 <20240306-scowling-mortify-9b427c80e8ab@wendy>
To: Conor Dooley <conor.dooley@microchip.com>
X-Mailer: Apple Mail (2.3774.400.31)



> On Mar 6, 2024, at 16:01, Conor Dooley <conor.dooley@microchip.com> =
wrote:
>=20
> On Wed, Mar 06, 2024 at 07:38:52AM +0800, Guo Ren wrote:
>=20
>> On Wed, Mar 6, 2024 at 7:04=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> =
wrote:
>>>=20
>>> Since we have Canaan Kendryte K230 with MMU now. The use of =
SOC_CANAAN
>>> is no longer only referred to K210. Split them and add _K210 suffix
>>> to the name for old SOC_CANAAN. And allows ARCH_CANAAN to be =
selected
>>> for other Canaan SoCs.
>>>=20
>>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>>> ---
>>> arch/riscv/Kconfig.socs                        | 8 +++++---
>>> arch/riscv/Makefile                            | 2 +-
>>> arch/riscv/configs/nommu_k210_defconfig        | 3 ++-
>>> arch/riscv/configs/nommu_k210_sdcard_defconfig | 3 ++-
>>> drivers/clk/Kconfig                            | 4 ++--
>>> drivers/pinctrl/Kconfig                        | 4 ++--
>>> drivers/reset/Kconfig                          | 4 ++--
>>> drivers/soc/Makefile                           | 2 +-
>>> drivers/soc/canaan/Kconfig                     | 4 ++--
>>> 9 files changed, 19 insertions(+), 15 deletions(-)
>=20
>> This patch cross so many subsystems, I am not sure about it. If I =
were
>> you, I would keep SOC_CANAAN and just add SOC_CANAAN_K230.
>=20
> Right. That is why I didn't try to rename the symbol, and just left it
> as SOC_CANAAN, but if the relevant people ack it, the chances of a
> significant conflict are low.
>=20

Maybe I should split this patch into different subsystems for better
review. I think at least drivers/soc/Makefile should changed to use
ARCH_CANAAN. Because we need some SoC drivers for K230 in the future.
And arch/riscv/Makefile should use SOC_CANAAN_K210 instead of
ARCH_CANAAN.  Because we should avoid the M-Mode loader build for
other Canaan SoCs except for K210.=


