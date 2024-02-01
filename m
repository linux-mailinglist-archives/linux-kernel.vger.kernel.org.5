Return-Path: <linux-kernel+bounces-48983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC3F84645C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0431C22528
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6887447F52;
	Thu,  1 Feb 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqqy/x+M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186B41211;
	Thu,  1 Feb 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706829543; cv=none; b=iyW9+bkl2xlFi99GxnMx6VpmQrkHbp/is4ZnezT5qccoerXSj4pLJ96Sr/Elwj/OgBKeagu0vmjPvhhrVgESWwx76xjqYCbC7/6ko5NTGEh+sWZvAVSE9+XImp/A4kAbzfKc1D/dWIHWGVdd/yoEVc7STQWe3EoDa6TYJrXjVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706829543; c=relaxed/simple;
	bh=g/Fqx31XYNOhlJ9ECDsRvPPG0ycRV++0qSKtdAFxaxg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=j7q64ct7GQoCzq3G60HLUc3rHYgI40LznWLYPD01VbGb8kKjb2T+/mETz6ksWxciMe3BEcbsplAyfIU3IeuFXfCrobJuStQu4iXLGD3vztnIrnsvb/TGpfLuCYZ/bkFh/Anq0abc4OTpJ/LJtcy238kD8rXbofXY92moLM7a424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqqy/x+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11851C433F1;
	Thu,  1 Feb 2024 23:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706829543;
	bh=g/Fqx31XYNOhlJ9ECDsRvPPG0ycRV++0qSKtdAFxaxg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=lqqy/x+M6PKHk6qI+VElPsSLnPfv79iVSVo15fdzGE+KkQVXj0k0Dn/SX+Nhs7L1y
	 ALMVaX8aNE8nK9WpHt/gRv9iGbN+u7SuAjEOWMHqkqHETQTp8PuMwatsnEbk3yK/pt
	 p6BnBx5jtRywsHk9i8AhB+Q4h55A4CI18bz7tZ+QG3MSD6/hKDPpP75aB7D5H+s/z6
	 kR/9AAHAtEuU4H539UqLw/9QHF7Lu8N3LPuJyQsUsrYyTYVPp8LOFXgYGV4OeXGxbX
	 8zhxfLIwyMNzmtgPBRN0/zbNecijFMwAsh+4iJnYubwkK5gM4D3+qNzst+Juz8Unmc
	 sPRp/H03he1yw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 01:18:59 +0200
Message-Id: <CYU4KPJIDWTI.1ZPBLGOCZR0BK@suppilovahvero>
Cc: "LinoSanfilippo@gmx.de" <LinoSanfilippo@gmx.de>,
 "p.rosenberger@kunbus.com" <p.rosenberger@kunbus.com>, "lukas@wunner.de"
 <lukas@wunner.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] tpm,tpm_tis: Avoid warning splat at shutdown
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Elliott, Robert (Servers)" <elliott@hpe.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "peterhuewe@gmx.de" <peterhuewe@gmx.de>
X-Mailer: aerc 0.15.2
References: <20240201113646.31734-1-l.sanfilippo@kunbus.com>
 <MW5PR84MB184274E28D83DC337B486CEFAB432@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW5PR84MB184274E28D83DC337B486CEFAB432@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>

On Thu Feb 1, 2024 at 6:40 PM EET, Elliott, Robert (Servers) wrote:
> > From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > Sent: Thursday, February 1, 2024 5:37 AM
> > Subject: [PATCH] tpm,tpm_tis: Avoid warning splat at shutdown
> >=20
> > If interrupts are not activated the work struct 'free_irq_work' is not
> > initialized. This results in a warning splat at module shutdown.
> >=20
> > Fix this by always initializing the work regardless of whether interrup=
ts
> > are activated or not.
>
> That's using flush_work(), which just waits for one to complete. Is there
> any case where multiple work entries could be queued, and cancel_work_syn=
c()=20
> would be necessary?

Questions are cool but please explain how this aligns with the patch
review because I already accepted the patch.

Should I drop it based on this question, and if so, why?

> tpm_tis_probe_irq() has a loop calling tpm_tis_probe_irq_single()
> for 3 to 15. Could each of those could trigger an interrupt storm and
> call tpm_tis_revert_interrupts(), which calls schedule_work()?

AFAIK no based on that TPM_CHIP_FLAG_IRQ should take care of this.

BR, Jarkko

