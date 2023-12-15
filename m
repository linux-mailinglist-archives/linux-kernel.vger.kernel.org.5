Return-Path: <linux-kernel+bounces-466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25352814198
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07141F22ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DA5CA6F;
	Fri, 15 Dec 2023 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP/wLE+c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA46ECA64
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ba40df6881so96700b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702619675; x=1703224475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCJOW0HTWFqTjpEhxTj1el+zslba+C9AgKBFgvSSX8M=;
        b=IP/wLE+ckmTYWdZBSu35s6LuXSILrbL7HyMsjSbbGpgoqfcHxPSlN7yNx9B86VjCTq
         Phb85DpWslefw71iMw+nlfX0ln+bM6s+gNQfUS/VqLwjLEeB+Hs/DVpgzkCD543vRJOo
         VNA2AI4vNbHb+30Rr4eOViyLpkgHZBRe6KHQORAdOusgMCFYzvaza6nsxnHaz6SJaE+T
         pDXOrpPs/PNrivp3CLfZhGpkgkXnqQE1VKPOvezEeOZRYfkkSf1QOtNTIUiXjMUnDRlL
         viTodVoWxr5TlPYY9mxdUHB0MNBvBSpmP+jQGsKVdke30PwSYqwPaEbTn9usSL7Ch9H5
         qcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702619675; x=1703224475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCJOW0HTWFqTjpEhxTj1el+zslba+C9AgKBFgvSSX8M=;
        b=NllW8cLcHkg0PDH8a87Z5k+R5Mn2c73IwfnQII2aZXAw6V8P0QdmKTbKo1+t+zcPMi
         ucUS7zIw8ofK2zp8pNldFN3ospzsMT9dYsUEMLNXGFr/saq4ve/t3RUv78Js0TxIaSWA
         x37VdC5GVvmZesMYuLeIRm5POItfPVS/+26Lq5VUqvrqJfEoK2sWxrbe4cCArveD0z/R
         nT5Z96QPJkuY49VEr9pZIE9Bz07bm13/BWh+ksuRT47+2gRLEKx+pfeTP1zhqvAHwquT
         DUxT+ItKebFflh3IbTfM1MWf5o89cL/0eyS8486ThSKYfVYdbvt64n1XV7My+jkm/ALR
         b5HQ==
X-Gm-Message-State: AOJu0YxZGX9gq7XSOaIxSBRxr+buiRR9KrKOjh/ApR4Y3IYYqsPUWNvC
	y3UfKsHb0cEI05snJqs48eVK8O/YkBDFriSuh4I=
X-Google-Smtp-Source: AGHT+IFSHbIbrncQrnBc79uTTFBIB1KX1UP5iOvBoXKujoMLbJ+yAfaSq9uVSeyXU4SFuEsOkGxbg5LqUQlxNV+crJ4=
X-Received: by 2002:a05:6808:1250:b0:3b8:b063:9b6f with SMTP id
 o16-20020a056808125000b003b8b0639b6fmr12501939oiv.97.1702619674806; Thu, 14
 Dec 2023 21:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215053016.552019-1-ghanshyam1898@gmail.com> <346d12b2-a78e-4372-880a-e522fdca7169@infradead.org>
In-Reply-To: <346d12b2-a78e-4372-880a-e522fdca7169@infradead.org>
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date: Fri, 15 Dec 2023 11:23:58 +0530
Message-ID: <CAG-Bmod7tsFzh=5vzHCy6CUy5FFBGfg19NYmbVUsvniC4hGiaQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpu: drm: vmwgfx: fixed typos
To: Randy Dunlap <rdunlap@infradead.org>
Cc: zackr@vmware.com, linux-graphics-maintainer@vmware.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 11:05=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 12/14/23 21:30, Ghanshyam Agrawal wrote:
> > Fixed some typos in vmwgfx_execbuf.c
> >
> > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > ---
> >  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/=
vmwgfx/vmwgfx_execbuf.c
> > index 36987ef3fc30..272141b6164c 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> > @@ -621,10 +621,10 @@ static int vmw_resources_reserve(struct vmw_sw_co=
ntext *sw_context)
> >   * @sw_context: Pointer to the software context.
> >   * @res_type: Resource type.
> >   * @dirty: Whether to change dirty status.
> > - * @converter: User-space visisble type specific information.
> > + * @converter: User-space visible type specific information.
>
> ack.
>
> >   * @id_loc: Pointer to the location in the command buffer currently be=
ing parsed
> >   * from where the user-space resource id handle is located.
> > - * @p_res: Pointer to pointer to resource validalidation node. Populat=
ed on
> > + * @p_res: Pointer to pointer to resource validation node. Populated o=
n
> >   * exit.
>
> ack.
>
> >   */
> >  static int
>
> Please also fix this one:
> vmwgfx_execbuf.c:1072: asynchronus =3D=3D> asynchronous
>
> I suggest that you try codespell.
>
> Thanks.
> --
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html

Hi Randy,

Thanks for your acknowledgements and feedback. Codespell did suggest one
more change but I am not sure if it should be applied. Let me ask someone.
I will make changes and resend the second patch.

Thanks & Regards,
Ghanshyam Agrawal

