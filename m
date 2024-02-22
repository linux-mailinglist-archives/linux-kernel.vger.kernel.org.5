Return-Path: <linux-kernel+bounces-76101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD1885F2EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6851F24DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257CF1B59F;
	Thu, 22 Feb 2024 08:29:22 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9893117F3;
	Thu, 22 Feb 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590561; cv=none; b=TG2R3igHeL8roR2v2rqKemcwalLd9AxfxSeb/5ieekQZjYTsVVP8uh8pn07b5JnWQcODT3bsWftoxFEgGN7urpwGyH/2aLj88me74bd5cVHaZ6wsJlDXnJwTfb8/a2hgn9gEXqhnPyPqEMSwsSslwJNcZOOtesIMA7HrHhn1spA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590561; c=relaxed/simple;
	bh=5mjPQkEkMqV4tvrQqZa3eUo6bLhvA/Eax+OBmTANIps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLn4xXK2VEzPNzSjELActtmryRK70t8Y6sk3TqnGnBPQy6RRMUHwjn7qMSKNONc3YHKtwYClWP5ZW1KK260QgURAJrvdoYHfbfAAYgV7WK5KuOXRPgtQShbBccZzdy2wIJsd4sBqnAWmId+y6OekBU4bxI47Bb6NVru3VWcYdpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-607e60d01b2so34295477b3.1;
        Thu, 22 Feb 2024 00:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708590558; x=1709195358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3E80Fr+PQHplyVIuytgLvVqlKEcgK1zfDCm4lydbgb8=;
        b=bXB3Ivu1QhbGJ+LqJTX/+6po8ho0uh+NaJgeDHvd74z2WleFOM+F/S/e0yVJGyjLGT
         cftaeWjG5+hPX2yZjt/HuUCUbNU1F65qb+7ZWQxU6ky6V4Gd9Ia1u9QSuzBiVFbOuzfY
         UFftF16HzpRK2uo3epcPimNLUMboLICFVDmyBvGsJDR0BzJBr0pKGih5ZAgtTAJPU8Dr
         ib91q2YsTNfri+xCsCjswF51kStwb6mBqHT3uStz39nDfarnVuAztbCtnUcQFKLM7Qdq
         8ytNVdeS+vvbU45rMO7IgDfp1M4C+tujAZwJwp+uQcNY3b+KJYzb2GOAEXc+SRuQ9Qt1
         fsWw==
X-Forwarded-Encrypted: i=1; AJvYcCV2l7YHiZvSqwU6vz8hiALjtrsqJP12nzAGxfynwyb0pc5W++ZIIP7e+JjZJVmjy4sHDTw5LdUHYTJ32lx7qSwlEXDkqBPWpDvIfDwXOyyPBSBgJvlBrVkJ1J0erdn83WS2NZLbJqKe4Q==
X-Gm-Message-State: AOJu0YyZigsDWu9mlRn0xPcEpYVvQ00TtyoLDFX7UNIRIdnvQAcqDW2p
	wlvpAi16WiLqvE6RT/yFhE+XsNG47v8JQfQ1eOS1iQICtfZeGQtgvCX+4XaRy6w=
X-Google-Smtp-Source: AGHT+IEaf9m52rkqAwSwbyA9KZsEw9SeHzIBg6FcoeD3eMSarcMRvaZcGU8KwDfJyC42Aj51GuhH2g==
X-Received: by 2002:a25:8292:0:b0:dc2:1dd0:1d1b with SMTP id r18-20020a258292000000b00dc21dd01d1bmr1715388ybk.19.1708590557664;
        Thu, 22 Feb 2024 00:29:17 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id v40-20020a25abab000000b00dce0f2db9acsm2705951ybi.34.2024.02.22.00.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 00:29:16 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6085b652fc8so32585667b3.2;
        Thu, 22 Feb 2024 00:29:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2XrZ6tZe0afzDUYPxNmo06RWwliozLbQVdjNFcuFwXdI2hoCXaamm9hl/76fi+rQXcJKvXZwWVFAuk9XRrBMlcevCGYMTIvVgJ/S8mm8zvrhrcVfbk4VaWH+Db1W8C0px2fXS/6gzqg==
X-Received: by 2002:a05:690c:714:b0:608:98d:6f77 with SMTP id
 bs20-20020a05690c071400b00608098d6f77mr12592435ywb.0.1708590556168; Thu, 22
 Feb 2024 00:29:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222124610.383e1ce3@canb.auug.org.au> <TYCPR01MB11269B83A59650E230F4DD97F86562@TYCPR01MB11269.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB11269B83A59650E230F4DD97F86562@TYCPR01MB11269.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2024 09:29:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV0nftTZ6WuEkcS9h0d1bx_haR==roB1gwbaS2fzooO_A@mail.gmail.com>
Message-ID: <CAMuHMdV0nftTZ6WuEkcS9h0d1bx_haR==roB1gwbaS2fzooO_A@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	Intel Graphics <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>, 
	Maxime Ripard <mripard@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Thu, Feb 22, 2024 at 9:14=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
> > -----Original Message-----
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Sent: Thursday, February 22, 2024 1:46 AM
> > Subject: linux-next: build failure after merge of the drm-misc tree
> >
> > After merging the drm-misc tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c:47:6: error: redefinition =
of
> > 'rzg2l_du_vsp_enable'
> >    47 | void rzg2l_du_vsp_enable(struct rzg2l_du_crtc *crtc)
> >       |      ^~~~~~~~~~~~~~~~~~~
> > In file included from drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h:18,
> >                  from drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c:30:
> > drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h:72:20: note: previous
> > definition of 'rzg2l_du_vsp_enable' with type 'void(struct rzg2l_du_crt=
c
> > *)'
> >    72 | static inline void rzg2l_du_vsp_enable(struct rzg2l_du_crtc *cr=
tc)
> > { };
> >       |                    ^~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c:61:6: error: redefinition =
of
> > 'rzg2l_du_vsp_disable'
> >    61 | void rzg2l_du_vsp_disable(struct rzg2l_du_crtc *crtc)
> >       |      ^~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h:73:20: note: previous
> > definition of 'rzg2l_du_vsp_disable' with type 'void(struct rzg2l_du_cr=
tc
> > *)'
> >    73 | static inline void rzg2l_du_vsp_disable(struct rzg2l_du_crtc
> > *crtc) { };
> >       |                    ^~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c:66:6: error: redefinition =
of
> > 'rzg2l_du_vsp_atomic_flush'
> >    66 | void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc)
> >       |      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h:74:20: note: previous
> > definition of 'rzg2l_du_vsp_atomic_flush' with type 'void(struct
> > rzg2l_du_crtc *)'
> >    74 | static inline void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_cr=
tc
> > *crtc) { };
> >       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c:76:19: error: redefinition=
 of
> > 'rzg2l_du_vsp_get_drm_plane'
> >    76 | struct drm_plane *rzg2l_du_vsp_get_drm_plane(struct rzg2l_du_cr=
tc
> > *crtc,
> >       |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h:75:33: note: previous
> > definition of 'rzg2l_du_vsp_get_drm_plane' with type 'struct drm_plane
> > *(struct rzg2l_du_crtc *, unsigned int)'
> >    75 | static inline struct drm_plane *rzg2l_du_vsp_get_drm_plane(stru=
ct
> > rzg2l_du_crtc *crtc,
> >       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c:302:5: error: redefinition=
 of
> > 'rzg2l_du_vsp_init'
> >   302 | int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_n=
ode
> > *np,
> >       |     ^~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h:66:19: note: previous
> > definition of 'rzg2l_du_vsp_init' with type 'int(struct rzg2l_du_vsp *,
> > struct device_node *, unsigned int)'
> >    66 | static inline int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp,
> > struct device_node *np,
> >       |                   ^~~~~~~~~~~~~~~~~
> >
> > Caused by commit
> >
> >   768e9e61b3b9 ("drm: renesas: Add RZ/G2L DU Support")
> >
> > I have used the drm-misc tree from next-20240221 for today.
>
> I will send an incremental patch to fix this build error with x86 on drm-=
next.
>
> I need to use the macro #if IS_ENABLED(CONFIG_VIDEO_RENESAS_VSP1)
> in drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h to fix this error.

Looks like you're also missing an EXPORT_SYMBOL_GPL(rzg2l_du_vsp_enable)?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

