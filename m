Return-Path: <linux-kernel+bounces-27339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4494582EDFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59A5B21A15
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5898F1B94C;
	Tue, 16 Jan 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izK5MYuz"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150821A731;
	Tue, 16 Jan 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2c375d2430so669774566b.1;
        Tue, 16 Jan 2024 03:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705405328; x=1706010128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ETa/IB76FnSUzUMCNIjO0OPtMyIpkffhHAQmKw0f14=;
        b=izK5MYuz703M5UOYhLdBRF1ePTMhRaHY+jQSx3EIXzgXnUZHM/vQl1/lYfiPOoEumq
         Bac8PpBT8l2IbOgxuiwp5W/EaogsdciJ+bumkKLO5aL7kw+ltXBCt2gwW6tYXvxyHQIP
         /DQHqpnv2eGUY87u64U9OE7+a6Jb6OnaBdjBP6PiRT922SR/ffziwn7NhK9cvbLutibq
         WeaUcUSEJz1t55YGjgIW9X3m2K8DbsiHgXqOGJdDiI21edB1RWWXIkQXx06FgID2+Yqz
         KGvG03gaR/eTM5MDBbbMS3PZzVWFYx5HGes3kmDzkQ7+aYgBW2w/ff+mPX+XZ9PKy9Ji
         D6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705405328; x=1706010128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ETa/IB76FnSUzUMCNIjO0OPtMyIpkffhHAQmKw0f14=;
        b=oJyAsxcsCOh3Nxv/Y2ETe20pZ3NKoCQ6SeXI6qcrmVcrOFCy9xoVsnSN/RMTQX0PFZ
         DIor3ph3P93vxy9CrzoOnsrgm9OMbUJ47pPgXG49c1esESyUABafe06gwFpdV32ajQQi
         zJAs0s3rJ8R1wC/q9XNjUKIBkli1hg3I68Zqni6QYDPFai8k+6dJLjwc6nsIBvlyOM/f
         HJKumqy5AKUKsX7P/6748k+Rk7HbWUJJk3BRVSGbsOoFaaV/3Nl00hgPGSico2NMUK2N
         2dKJXWW6aqn8lUvR6XW6DeGcm9Bq5X+mngyhRIyokuLBAIyepd73aWDRfDZ7ftrR59dk
         /9fg==
X-Gm-Message-State: AOJu0YzBQV9iUpkTwANjKmU+VlyXb6ac6lc1m1v3uQsV1vRBJiYqYmY4
	3L/fwlOUav5QIUcamVB+BlXaSblSus8B3bYqkRw=
X-Google-Smtp-Source: AGHT+IFIdXVTOsU0yGpd1l5hqqYw5SvEntjk0/FMvYbowcSgHq4IbAXkUksATwXJ85XfgfUxAQrwrtF3G0v3Xv8URCg=
X-Received: by 2002:a17:907:8b93:b0:a23:4e3f:a2fd with SMTP id
 tb19-20020a1709078b9300b00a234e3fa2fdmr4050086ejc.5.1705405327664; Tue, 16
 Jan 2024 03:42:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218124058.2047167-1-elinor.montmasson@savoirfairelinux.com>
 <CAEnQRZAwk-USZqXwLOVuN3iTn7r-55BJH=Sqq5+2Od+DhrK0iw@mail.gmail.com>
 <347346270.284192.1702989565367.JavaMail.zimbra@savoirfairelinux.com> <361044647.7067.1703857544284.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <361044647.7067.1703857544284.JavaMail.zimbra@savoirfairelinux.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 16 Jan 2024 13:41:55 +0200
Message-ID: <CAEnQRZDaGazi8j4LYEoWmSTORET89DVjEwD+2EdTizKGFp0CAg@mail.gmail.com>
Subject: Re: [PATCHv3 RESEND 00/10] ASoC: fsl-asoc-card: compatibility
 integration of a generic codec use case for use with S/PDIF controller
To: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	shengjiu wang <shengjiu.wang@gmail.com>, Xiubo Lee <Xiubo.Lee@gmail.com>, 
	Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound <linux-sound@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinux.com>, 
	"S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 3:45=E2=80=AFPM Elinor Montmasson
<elinor.montmasson@savoirfairelinux.com> wrote:
>
> Hello
>
> On Monday, 18 December, 2023 14:54:03, Daniel Baluta wrote
> > I know this is extra-work but we would greatly appreciate if you first
> > convert fsl-asoc-card.txt
> > to yml format and then add your new properties.
>
> DT schema must have at least one maintainer in the "maintainers" field.
> Who should I put for fsl-asoc-card.yaml ?

I think it should be Shengjiu Wang, if he is OK with that.

