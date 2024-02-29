Return-Path: <linux-kernel+bounces-86909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3106786CCAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4351F239F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFF213F015;
	Thu, 29 Feb 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxpbQsSk"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224907CF14;
	Thu, 29 Feb 2024 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219757; cv=none; b=LGlA54hjXM7bty4sxUEhtQuENPqwTTFVhx2nHi8yqeA9VjDpzU0jRkth/nUlZPzSZx421ddXzWyxlikvOQWgLO9ZZXP4OrlsBRaniVmQL25+obQHRPL9zGATq9FuT09FJsCttJ5TbAKSe0Ssm/q5FFZ8nirL27DXROYtzg8b3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219757; c=relaxed/simple;
	bh=CMg56geOOc7u+9Ot72DBWXSDwNyJX1YOqqE0Ry+xNaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnQEdMDtwX+VEPpI0bg7OpYEGgUeMO/Y48h77M24VzTXoTXv9PxXplJEtFBgpSmV2LlTDn4l/Bvpy4/lStZ8Ag6yyKPepbeXzM8WyuaeSJquTZ4Oyx1rt7cJyhtWM/NnAsDEvHCaRWKDAryRPuWrxSYLFYmMy292LMgwBO+5eEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxpbQsSk; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d7b8f563eso730081f8f.0;
        Thu, 29 Feb 2024 07:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709219754; x=1709824554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wui/V5y8FOLo8YiI+83F7lgNFV8HwNcsEwhvDRA3dk=;
        b=gxpbQsSkRYJnUbt4SPTbDLFw5ZfyvsBxyRth3M930ToKT90Eg2PVIfzYYYuqSClTdZ
         wpXWegEJUNHmoCaXVUCWUFxYChZR1pOPCJ9+gyX8jfBlu9cdzCQJQEsQhWHuqzKrtXjH
         2RvHspDLFpnyYaRh9Z5N5EzuccZviWIJVPO/6b4rsOmOnxOFwYXzrmDg3FQFtkfK+fl2
         BXwemPBdEQi1yWaELdu3TcCNfur/BpC2MADKYXbpyc3Y2cxs6uF0LidByUtbvLvZSF87
         5HVulwysbpUm47RAytBicMWYd9qMwNRXotG1Yjd1ZIOkEjGu66hX+2JUUMVe5xVEqYxf
         kujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219754; x=1709824554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wui/V5y8FOLo8YiI+83F7lgNFV8HwNcsEwhvDRA3dk=;
        b=XjuMLrXiGU0fLWiD/F8CJePqXw3XW2FyJ7O2Y5xbbC0gnkusaQf8u2xb0ips6BMrBw
         sySxTPflHKodS8ZN8plF7kBCyy3uR2bQ5rLARvlAUgnC2eyo5BytsTRTOa2RPh7ggq7F
         mS3mDbMKs7Yuvx633sNpTMtSCBs62ETCdhUs9jXIgIhXoCBKbwRFcmOFKSkP3RS0CbAk
         fRHUDkZT44lp0mq0Ry/Abi/9VSyTdgOrXVPm569oXPuGkD2+pdfmR8t3hgJr62zjUsRm
         QZaAu1f1jVj6E+hxAdIF9lUZ+svwTeWkvMGrj7XS6bHTcqppJFWvZFX4I3OVGb6LHLg3
         oTKg==
X-Forwarded-Encrypted: i=1; AJvYcCXZs2JFy6qfE6KvITCPuRWkiq0VN31AHN0Rv6Al0BfIU2gpAt72MX+WvLsiJcsPWJQpVeuyqqkZjxFNhbIf6yMTcSIOFUmxYevitmPYhHR+m+/7EWPzDJMbix80bjH9CRaoYsEw4k+1h2qrQg2w
X-Gm-Message-State: AOJu0Yy0+C1NLnTtXQsBl/qat31Tab6cORRwQz8KY7bGnxbop9NqEZcb
	8y/N9cp77PC2O8ezDOXKQyOZPS4PJSAfn7Lah+YC+g9bEOk5YIdWAiOqp5U2Iyx7Fv+YJwNHD+y
	Fu/tTL3sG64wn7CpvftcVu4x+kOM=
X-Google-Smtp-Source: AGHT+IHBfx8h6PdIH43PxYY+wWK3aRQjRg+CgGijUqZHtNSgcpoCMEjUhxFG+Ur8m68bSm1/0QI0M0MWqrtcFGzwaAY=
X-Received: by 2002:adf:ed89:0:b0:33d:afbc:6c76 with SMTP id
 c9-20020adfed89000000b0033dafbc6c76mr1609517wro.1.1709219754260; Thu, 29 Feb
 2024 07:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229120541.219429-1-colin.i.king@gmail.com> <f7b36055-a710-4d57-b952-33431876e221@ieee.org>
In-Reply-To: <f7b36055-a710-4d57-b952-33431876e221@ieee.org>
From: Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date: Thu, 29 Feb 2024 20:45:17 +0530
Message-ID: <CAAs3649g_nr5-6PLnGL31ouo5GMhn7o0zuDOjSO+HmG6vUnkXQ@mail.gmail.com>
Subject: Re: [PATCH][next] staging: greybus: Remove redundant variable 'mask'
To: Alex Elder <elder@ieee.org>
Cc: Colin Ian King <colin.i.king@gmail.com>, Mark Greer <mgreer@animalcreek.com>, 
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, greybus-dev@lists.linaro.org, 
	linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:51=E2=80=AFPM Alex Elder <elder@ieee.org> wrote:
>
> On 2/29/24 6:05 AM, Colin Ian King wrote:
> > The variable mask is being assigned and bit-set but it is never
> > being used apart from this. The variable is redundant and can
> > be removed.
> >
> > Cleans up clang scan build warning:
> > drivers/staging/greybus/audio_topology.c:764:15: warning: variable 'mas=
k'
> > set but not used [-Wunused-but-set-variable]
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks Colin for sharing this patch.

>
>
> This is a reasonable change, but I don't know this code that
> well and would like to hear from Vaibhav (if possible) or
> someone else whether they think the mask value *should* have
> been used in this spot.  It doesn't look like it to me, but
> I'd like you to get a second opinion...

The original intent was use the mask field while maintaining regmap entries=
.
However, I could not push changes on "maintain regmap" during ARA days :(
Anyways, for now it makes sense to drop the unused mask variable.

>
>                                         -Alex
>
> > ---
> >   drivers/staging/greybus/audio_topology.c | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging=
/greybus/audio_topology.c
> > index 08e6a807c132..5dc4721105d4 100644
> > --- a/drivers/staging/greybus/audio_topology.c
> > +++ b/drivers/staging/greybus/audio_topology.c
> > @@ -761,7 +761,6 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kco=
ntrol *kcontrol,
> >   {
> >       int ret, wi, ctl_id;
> >       unsigned int val, mux, change;
> > -     unsigned int mask;
> >       struct snd_soc_dapm_widget_list *wlist =3D snd_kcontrol_chip(kcon=
trol);
> >       struct snd_soc_dapm_widget *widget =3D wlist->widgets[0];
> >       struct gb_audio_ctl_elem_value gbvalue;
> > @@ -802,7 +801,6 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kco=
ntrol *kcontrol,
> >
> >       mux =3D ucontrol->value.enumerated.item[0];
> >       val =3D mux << e->shift_l;
> > -     mask =3D e->mask << e->shift_l;
> >
> >       if (le32_to_cpu(gbvalue.value.enumerated_item[0]) !=3D
> >           ucontrol->value.enumerated.item[0]) {
> > @@ -815,7 +813,6 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kco=
ntrol *kcontrol,
> >               if (ucontrol->value.enumerated.item[1] > e->items - 1)
> >                       return -EINVAL;
> >               val |=3D ucontrol->value.enumerated.item[1] << e->shift_r=
;
> > -             mask |=3D e->mask << e->shift_r;
> >               if (le32_to_cpu(gbvalue.value.enumerated_item[1]) !=3D
> >                   ucontrol->value.enumerated.item[1]) {
> >                       change =3D 1;
>

Acked-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>

