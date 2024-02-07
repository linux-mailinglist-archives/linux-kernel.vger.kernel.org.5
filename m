Return-Path: <linux-kernel+bounces-56023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF3A84C50A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDC7B264A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D02C1CD32;
	Wed,  7 Feb 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="dkbOrG1X"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F61CF8B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707287765; cv=none; b=BxD7N87rSvz5Ugb9Qiuzur0VIAhDOLTcnVJ/EpJvY+Q0hKWbgFj7Z3sO+nwj2q1fhM53bF+LD72MU9C52B86XDLlerJr7xttMfPPHtTxwLbNX2jI16ZMfswBNwf5hf8ED0tlbUlCQDpMMZZhFRPjBcpGXbBiVIX9q7fpwv9oBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707287765; c=relaxed/simple;
	bh=QiVRFoKs2wFwGHvDewmSG3cFDRhh5i4srunXDFEJBWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOVMS3B3A2RZbnBIT+9hb8mQBfVhSd738oWGE27v2vo41/ECuELPYzvfNO9WFSdIsK9oyB/cw46k9estEWkZtEsd0FkKNvFKvdcoYhERpDDiRLU0LuV1Ewfw5pGfc73FPUhWZX+gMrAV60UZXAcszZbmbc6UVIW+DF1ldZqAVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=dkbOrG1X; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6047bb0d20fso3055017b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 22:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707287761; x=1707892561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttQuRjkrOA882sgmcciq24ruU2hERRsTyaxuyMWHbh8=;
        b=dkbOrG1XWijAb1mBt+e3Tcvk3fXB3L3EU9yeLVWg2gni89iNrWb7y6cjMyiX3LSCos
         xbNyCbAx9EZJgaL4IifEyBZuY9hX2CsWYM49q6rsegjTH8E24Te0SgJ+99jTKVLpC2pU
         CaDeggoeOw62ANnwErHSpHo7z/oavJDgGraeU2KDsRmvY3fTatdH0B3C7z2+LbTtd/7G
         2rCtkjujVlK2LZbfkTnXVubgSSjr0Qq5KifEN2bAb7tqgyHKordpQ1HwklesJqBsv0ds
         bT+ZHV8j4ZtT9aw+oR2RUEO409HCg+75Rv3+haNTsPXhbTjKzDo0Y6gcXa0Altwbk85q
         HoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707287761; x=1707892561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttQuRjkrOA882sgmcciq24ruU2hERRsTyaxuyMWHbh8=;
        b=FaSjMosd6d3pYyRUClJTXZ2SUNkARK4BVDCmNbMbySSd5A6/A26yn9Zr1MpRMBCdhC
         Sg1MoRlPlKAETkZ3OSOOTHd44OaY6Q103asKKSfLBpfLAUV2lVnZ3CoCctqM2vrIL7Co
         eOP4aJCHD5DA6ZJvz+KD8dnQymwzW/2KQRtBwVzhRks17ZQMHeKZfoiLiKhijSTllja6
         5Kd8e+Ql+t5lmh+7hHxWtPLp5zCqBGmbXGEw1unwC3KubTxh/qGi4pKzG16Ds7u1RXUC
         dYSHUAk/rD3Mrw5f4TRf6q2BCbegMYsG7csKWCKb33rgno6XdpAJB8EOJnZV+qR8GQRK
         zpfQ==
X-Gm-Message-State: AOJu0YxSNyinQZzi7lsOelWnUxyV+fjvoLUwMT4r5ueZzlJv51P6d9oy
	0U0fLquBF0T6YD/iijF434XeuN4KG+Se0ID9cCPJGqXGvvwt+ck1aFzgvfKhTE4iumYBJAY/n30
	I6TfgA6M54T3GXOGmGlCfsdu/rw92Vek2gEB7PiklCAAhDURzKeHUwg==
X-Google-Smtp-Source: AGHT+IGRQSD7/G3US7FQsqMFcZuSRjgmauTOX5yuwX13yVK8gg7Th7dxWZX6pUSaCG+Bw69sRmzn3MOyMNmGk0SRIJ4=
X-Received: by 2002:a81:7e11:0:b0:603:d575:e2e8 with SMTP id
 o17-20020a817e11000000b00603d575e2e8mr3720535ywn.10.1707287761664; Tue, 06
 Feb 2024 22:36:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130101335.GU2543524@black.fi.intel.com> <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com>
 <Zbonprq/1SircQon@x1-carbon> <CAD8Lp47SH+xcCbZ9qdRwrk2KOHNoHUE5AMieVHoSMbVsMrdiNg@mail.gmail.com>
 <ZbrNLxHL03R66PxQ@x1-carbon> <ZbuyVbMEBWKi729y@x1-carbon> <CAPpJ_efmzy_FU0urdHDmO5htOBCPaX-T5W+Er7AmWYhqUTwnyA@mail.gmail.com>
 <ZcDHjsYJNlJ/9nNT@x1-carbon> <CAPpJ_ec0H6zr6wcNstFn9dRcFgPXspU3MYvgGMNAS5wnw-0pTw@mail.gmail.com>
 <ZcIwMb0WPZLG85LR@x1-carbon> <ZcKtqs2Usj99FRPE@x1-carbon>
In-Reply-To: <ZcKtqs2Usj99FRPE@x1-carbon>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 7 Feb 2024 14:35:25 +0800
Message-ID: <CAPpJ_ecHqxWWEOChiS3AopAaQR3FdaxjXqUtvGRAk53dMwe--w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS B1400CEAE
To: Niklas Cassel <cassel@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Daniel Drake <drake@endlessos.org>, 
	Vitalii Solomonov <solomonov.v@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	David Box <david.e.box@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-ide@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Niklas Cassel <cassel@kernel.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=886:07=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Feb 06, 2024 at 02:12:17PM +0100, Niklas Cassel wrote:
> > On Tue, Feb 06, 2024 at 04:39:02PM +0800, Jian-Hong Pan wrote:
> > > Niklas Cassel <cassel@kernel.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:33=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> (snip)
>
> >
> > It seems that at least Intel AHCI controllers that also have Intel VMD
> > enabled break when this quirk is applied.
> >
> > I guess one way would be to do a:
> > git show c312ef176399:drivers/ata/ahci.c | grep "PCI_VDEVICE(INTEL"
> > and replace everything that is not: board_ahci_pcs7
> > with a board_ahci_pcs_quirk, board_ahci_low_power_pcs_quirk, and
> > board_ahci_avn_pcs_quirk, and after that change all board_ahci_pcs7
> > entries to board_ahci, and assume that entries added since c312ef176399
> > do not need the quirk.
> >
> > But it would be nice if someone from Intel could clean this up.
>
> While it would still be nice if someone cleaned up the intel_pcs_quirk.
>
>
> Jian-Hong, perhaps you can try my series:
> https://lore.kernel.org/linux-ide/20240206211352.1664816-1-cassel@kernel.=
org/
>
> Also available here:
> https://github.com/floatious/linux/tree/external-port-v2
>
> With that series, you should not need an explicit "board_ahci_low_power"
> entry for Tiger Lake to get working LPM.
>
> If fact, you want to ensure that you do not have any Tiger Lake entry in
> ahci_pci_tbl, as that will apply intel_pcs_quirk and break your platform.
>
> Testing is appreciated :)
>
> Let's hope that LPM is enabled and that you can also enter low-power
> C-states.

Yes!  That patch series binds LPM policy by default and avoids
disappeared SATA storage issue.

Thanks!
Jian-Hong Pan

