Return-Path: <linux-kernel+bounces-23785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E8882B1B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F03E1F22A56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4284CB43;
	Thu, 11 Jan 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGYvglm5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E04D127;
	Thu, 11 Jan 2024 15:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927C8C433C7;
	Thu, 11 Jan 2024 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704986755;
	bh=ZxKTB6mPR4ix+a5ENOF86x5FJJZQzDK6U+BnWyQUhHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGYvglm5SvsGaIX8jj41feRKiWaLnkbslwd+C0Nj0jUfukuNGaUYasmp5QmGDe7y0
	 ewHud30NKqW9DIIgYVLfQWx98OM9QIyR8rr0FPAH4iQ5utMdS5VD1Y7EOKfgEsF3f3
	 aiqUs+f7+G/vf2N1HVpuWiRh3y8JbnsYrVGtUSV4Ug/xrDdoQXPqevdrfDVI99cyd1
	 9S7DXiiv/TcjrgWCln5PaMpd2yxhKAMr/foS1v7d/cokr1aA+QRIm9KiT0lVEo+gpL
	 WjG1TiVboaTKXVwwTCR3ix5HZYaUTblwvXGt/pynPCEh73h81sdyF/kiysLc6kTzJs
	 Xozzz7bgZ8bng==
Date: Thu, 11 Jan 2024 15:25:49 +0000
From: Lee Jones <lee@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] mfd: 88pm88x: differences with respect to the
 PMIC RFC series
Message-ID: <20240111152549.GL1678981@google.com>
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
 <20231228100208.2932-2-karelb@gimli.ms.mff.cuni.cz>
 <20240111105426.GA1678981@google.com>
 <CYBYXXCP3O1O.2M5YMCRW3SIMY@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CYBYXXCP3O1O.2M5YMCRW3SIMY@gimli.ms.mff.cuni.cz>

On Thu, 11 Jan 2024, Karel Balej wrote:

> Lee,
> 
> On Thu Jan 11, 2024 at 11:54 AM CET, Lee Jones wrote:
> > The subject needs work.  Please tell us what the patches is doing.
> >
> > On Thu, 28 Dec 2023, Karel Balej wrote:
> >
> > > From: Karel Balej <balejk@matfyz.cz>
> >
> > A full an complete commit message is a must.
> 
> I have not provided a detailed description here because as I have noted
> in the cover letter, this patch will be squashed into the MFD series. I
> sent it only as a bridge between the two series, sorry for the
> confusion.
> 
> > > diff --git a/include/linux/mfd/88pm88x.h b/include/linux/mfd/88pm88x.h
> > > index a34c57447827..9a335f6b9c07 100644
> > > --- a/include/linux/mfd/88pm88x.h
> > > +++ b/include/linux/mfd/88pm88x.h
> > > @@ -49,6 +49,8 @@ struct pm88x_data {
> > >  	unsigned int whoami;
> > >  	struct reg_sequence *presets;
> > >  	unsigned int num_presets;
> > > +	struct mfd_cell *devs;
> > > +	unsigned int num_devs;
> >
> > Why are you adding extra abstraction?
> 
> Right, this is probably not necessary now since I'm only implementing
> support for one of the chips - it's just that I keep thinking about it
> as a driver for both of them and thus tend to write it a bit more
> abstractly. Shall I then drop this and also the `presets` member which
> is also chip-specific?

Even if you were to support multiple devices, this strategy is unusual
and isn't likely to be accepted.

With respect to the other variables, you are in a better position to
know if they are still required.  By the sounds of it, I'd suggest it
might be better to remove them.

-- 
Lee Jones [李琼斯]

