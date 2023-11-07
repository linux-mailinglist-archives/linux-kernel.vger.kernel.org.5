Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6977E49EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbjKGUeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbjKGUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:34:40 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22811702
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:34:37 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a87ac9d245so73965777b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncf.edu; s=google; t=1699389277; x=1699994077; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:organization:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWp5Pb+/LdzWJWf4DW8IBglT8Le0ScvSI5TXWdEwNqg=;
        b=n8C8txHOJBRMO50qXHXTqN3QJ+ZXK1GiARcrHelqpI2qz2ElJyziOHqgfFgtNQ4ch+
         DG3xM/n8Jovv5wdHAuIY3mh8quCFmMuYu/zzVEb83xaMnBtvEYQys2+4O2YzMwXdnetd
         ngt1QyG6ec2ShYEYLLGSw4KyMtXRXxIs+p2ZR2vdxSwkRPwSH2D9YxSlsp5daGR5FNlV
         LFnEmZ2PR1qdkbne8qFyrHKO9yh2nKHbMU/AsSgMVrH0GppibjDI1+eF1GoZNJcz4cy1
         F4NbrHFQ7E1WPHEnWCazBvwDIZjxIFwR9nXr2M3QVrrsH8GPCPlDshz2xmVKceul2rD/
         x2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699389277; x=1699994077;
        h=mime-version:references:in-reply-to:organization:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWp5Pb+/LdzWJWf4DW8IBglT8Le0ScvSI5TXWdEwNqg=;
        b=ZnqlYtNE+PIsWNhie8dfWerpfBVoNOQwVzvnoiDVPOKg8OWEAewcZ/FG7PdlFpkFiy
         5Slb2WL1JI4lzapNqSjsKPEN81YV66DKSJ9aKD4tv/+nDgol8WGRgkBxFbPyIbnirQfE
         dTHOSizp6+jaDJOo2VKznWdOco0NFGhQLolpKpSkDP1hDaohCRX4FKmWQOBhndswfSVZ
         +x28UfijRMhcoN3jPKKugotuQwHKyA5db7BPEaig877JFvaa6AYZFStlrDGJQEEVc9RJ
         KB07jwsnoh49iuVWyManAERUILfU/SKmnLAtuyIpuaNIi6n7AyWLcHCECw5iEQol2b+I
         zg6w==
X-Gm-Message-State: AOJu0YzyPPBhZXtCRMwjK9qSuXyN2kfehFRzfcBnwgcXF2u7nV9hKaTo
        B9P4wGQOftTAqOkLGELCL6C6DKzI5Irfi+s5bzVE/621hXktU95lSsra9WgPdHjRb9jIEz/JAXk
        lvHU6O7fkbjP2Hzca+HbSpbHTFxxmb4dYVbC6k5EiWLnfvPSWHozjqj9FLNR/qVT7TQa678KkCi
        9ExLlggLArjxRbnW8=
X-Google-Smtp-Source: AGHT+IFCLuTnYPZoOwFZ96oW9PizZC3cqb+219coA5tTSa7FD5yZSWjW9IZIkFPmXv9f3dw6ESaCng==
X-Received: by 2002:a0d:cb16:0:b0:5a7:c6bd:7ac0 with SMTP id n22-20020a0dcb16000000b005a7c6bd7ac0mr14965043ywd.13.1699389276735;
        Tue, 07 Nov 2023 12:34:36 -0800 (PST)
Received: from lux.localnet ([2601:580:8201:d0::4174])
        by smtp.gmail.com with ESMTPSA id u82-20020a816055000000b0059c0629d59csm6051836ywb.115.2023.11.07.12.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 12:34:36 -0800 (PST)
From:   Hunter Chasens <hunter.chasens18@ncf.edu>
To:     linux-kernel@vger.kernel.org, "Lazar, Lijo" <lijo.lazar@amd.com>
Cc:     linux-doc@vger.kernel.org, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, alexander.deucher@amd.com, airlied@gmail.com,
        christian.koenig@amd.com
Subject: Re: [PATCH v2] drm: amd: Resolve Sphinx unexpected indentation warning
Date:   Tue, 07 Nov 2023 10:34:35 -0500
Message-ID: <22087039.EfDdHjke4D@lux>
Organization: New College of Florida
In-Reply-To: <6bd4f6d9-07c9-9ac1-2f3f-bb083b9c8085@amd.com>
References: <20231106201739.29507-1-hunter.chasens18@ncf.edu>
 <6bd4f6d9-07c9-9ac1-2f3f-bb083b9c8085@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7603761.EvYhyI6sBW";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7603761.EvYhyI6sBW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Hunter Chasens <hunter.chasens18@ncf.edu>
To: linux-kernel@vger.kernel.org, "Lazar, Lijo" <lijo.lazar@amd.com>
Date: Tue, 07 Nov 2023 10:34:35 -0500
Message-ID: <22087039.EfDdHjke4D@lux>
Organization: New College of Florida
In-Reply-To: <6bd4f6d9-07c9-9ac1-2f3f-bb083b9c8085@amd.com>
MIME-Version: 1.0

On Monday, November 6, 2023 11:45:24 PM EST Lazar, Lijo wrote:
> On 11/7/2023 1:47 AM, Hunter Chasens wrote:
> > Resolves Sphinx unexpected indentation warning when compiling
> > documentation (e.g. `make htmldocs`). Replaces tabs with spaces and
> > adds
> > a literal block to keep vertical formatting of the
> > example power state list.
> > 
> > Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>
> > ---
> > 
> >   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 13 +++++++------
> >   1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > b/drivers/gpu/drm/amd/pm/amdgpu_pm.c index 517b9fb4624c..81b8ceb26890
> > 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -989,12 +989,13 @@ static ssize_t amdgpu_get_pp_features(struct
> > device *dev,> 
> >    * Reading back the files will show you the available power levels
> >    within
> >    * the power state and the clock information for those levels. If
> >    deep sleep is * applied to a clock, the level will be denoted by a
> >    special level 'S:'> 
> > - * E.g.,
> > - *	S: 19Mhz *
> > - *	0: 615Mhz
> > - *	1: 800Mhz
> > - *	2: 888Mhz
> > - *	3: 1000Mhz
> 
> > + * E.g.::
> This will be like E.g.: Could you keep it like E.g.,<space>:: so that ::
> is taken out?
> 
> Thanks,
> Lijo
> 
> > + *
> > + *  S: 19Mhz *
> > + *  0: 615Mhz
> > + *  1: 800Mhz
> > + *  2: 888Mhz
> > + *  3: 1000Mhz
> > 
> >    *
> >    *
> >    * To manually adjust these states, first select manual using

No problem. I'll send a v3 out in a bit.

--nextPart7603761.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEFaTi3I3XEd+IzfdZZz/o+CKADX8FAmVKWQsACgkQZz/o+CKA
DX8MxQf+OReDu+tIzKqafU63tL2/DgaIr4JodkrKVsbt+QyEfbmSWS9mwP5KsOgf
3Rzv37K/A2OTkRbuWMKE1k+ZJHp/2qrZUJIzZHEE/P9g/LV91biimlgXl9/OI2cp
nAKt6aPapq6ZqyZrVt+5kmIGgUc+7p71dMJ8H89BLTTx29/mOziAHEV38FdWbQO7
OEYDa4c1ugKbxqsnU3ni18PFdMxapGIT6mmr4P7GtD+ikCqireQ1zY+VkeefDOu7
uppL3QTO+AXMNkwhiR6NbaLYyX98pcg6d7Gq3LeGf9CShx+Pz6c28aIiF4KcSk4W
JBL1EslGewkEHY9C3LlIuow9Pkg30Q==
=sA05
-----END PGP SIGNATURE-----

--nextPart7603761.EvYhyI6sBW--



