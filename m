Return-Path: <linux-kernel+bounces-15631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AECD822F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF96283068
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF551A584;
	Wed,  3 Jan 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2J+pDgm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EC31A27A;
	Wed,  3 Jan 2024 14:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F94C433C8;
	Wed,  3 Jan 2024 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704290922;
	bh=8STg3Kx2J6yqlRXBOOKEOorT+GMOZhm31ChqbfyAWOA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=R2J+pDgmkHz9o++b5W+X2sx7lREKndM61/mu2CLnDDaxWOTWlYQvEmR6sx4ianrnx
	 fhteG6T01DsvuTBvgVexqHfr2HLgK3dCQFJnhv/Ul/dw98LAJFlHaG0Tm7d8OpqEgQ
	 +f+YC1CNb7MmCKL33qE8XMCKHc4ooU++l7GwWapoJzVFFrBNyzAekqupJYn+uedm+p
	 9J85Xaw1758M/BTHsnz5qbGpfgZlbGPTDgZzftHSBlJrALwIuNx0YBQuj7+kdmD4O/
	 RZdvDH/QN0XUKSC/3SpfgDZBpoTfKM8VdsP9UEasZk0wCkRDdRc8C25CyVPrhsvmb8
	 YC3I4zqj0QOAQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 16:08:39 +0200
Message-Id: <CY54PJM8KY92.UOCXW1JQUVF7@suppilovahvero>
To: =?utf-8?q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>
Cc: "l.sanfilippo@kunbus.com" <l.sanfilippo@kunbus.com>,
 "Alexander.Steffen@infineon.com" <Alexander.Steffen@infineon.com>
Subject: Re: TPM interrupt patch on LTS
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <4fc16271420c578cdafea70e005a2b4381c555d3.camel@toradex.com>
In-Reply-To: <4fc16271420c578cdafea70e005a2b4381c555d3.camel@toradex.com>

On Tue Dec 26, 2023 at 4:50 PM EET, Jo=C3=A3o Paulo Silva Gon=C3=A7alves wr=
ote:
> Hello,=20
>
> We are integrating a SPI TPM from Infineon with 6.1/5.15 LTS kernels for =
an=20
> embedded platform and it is giving an error message that interrupts are n=
ot working.=20
> There is a correction from [1] already on upstream but the patch that mak=
es=20
> interrupts work, commit e644b2f498d2 ("tpm, tpm_tis: Enable interrupt tes=
t"), was=20
> not backported to LTS. This seems to be the only patch that was no backpo=
rted=20
> from [1]. I read some discussion on lkml about TPM interrupts problems bu=
t did=20
> not get if it is related or the reason for not backporting the patch.=20
>
> Do you know the reason this single patch was not backported? =20
>
> [1] https://lore.kernel.org/lkml/20221124135538.31020-1-LinoSanfilippo@gm=
x.de/
>
> Thanks!
>
> Regards,
> Joao Paulo Goncalves

You can disable interrupts with "interrupts" kernel command-line
parameter. It's not backported because essentialy it is a feature,
i.e. interrupts have been never working before properly.

BR, Jarkko

