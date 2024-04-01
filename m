Return-Path: <linux-kernel+bounces-126408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C6B8936E6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 04:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB5D1F21603
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 02:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D1C1C2D;
	Mon,  1 Apr 2024 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYbdwBxE"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45EA10E5;
	Mon,  1 Apr 2024 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711938061; cv=none; b=gtWSG3DIvuxe9mg8jvdT3iji2hEl3crl6yoPX654MGpjRRe+NHQ4ksG51IvFfM+vXZ1J/PpvsQLq/zbFOPWVXW6fDBYUtGybwegBPaD0VpYkhKlU6TvkUVodk6bVSZmLpJQJMVMtOvLcZmiTHdKty6dHQkx+qO4hYmihs4XkIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711938061; c=relaxed/simple;
	bh=9JDO4Cagwi3lP7gijNA6peSXaTD5GczAGmK9Wgoo/bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGrVWzq+yfLRT1TkDmg/9obRXRVQzj9ovWC1+OXHXK6Rc/YDP5kT+EMTAKhOtoMVWtVeownfnCVdPUYtfsadIz4LRymNbTm/1ZllbCyz157Fi6lxXzThGDBxPw1xqF44UDSJX+PkFwdRszPlI8P0VA953v1bmqMsKt/ONb0nwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYbdwBxE; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-697bd743062so13384306d6.0;
        Sun, 31 Mar 2024 19:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711938059; x=1712542859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JDO4Cagwi3lP7gijNA6peSXaTD5GczAGmK9Wgoo/bo=;
        b=FYbdwBxEoe+gJMUx6GvsmDeC4LhJ/H0LYfw5wE7b4JtNMqiQ7wqvgQ1mEo906VoJWk
         bsqC2GTKfaYG38lqWbwQPn3nA+w72llz9krpXNNA8iLlHNV8V/fLyVuVOC5feQe+t2UX
         2lAZ+lmTx+n8xAQcOS4NkM1i38yxx3F+4v8JoDOenvkxij/nLvXTMFF/pc+wHtd8m8+h
         4Pz2RjM3MjupTq1GANnPg4YqoNEyaXOjofUiBBCzMYIngSTsnN/8hFLtaqbYuYytLswD
         VG3pd421DuZ5WcsZhQSKlVSYN48CXlkrv5GUHN5x9umB5cRA6yAAlSYVbxTvwLbMbXKp
         gLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711938059; x=1712542859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JDO4Cagwi3lP7gijNA6peSXaTD5GczAGmK9Wgoo/bo=;
        b=ClM/I8qAwp+rSsKK82Oz8NIi0V6QV69ivrzif+q0udmI4ygvDehFzWbLv73rW+/ZCi
         y6kzsEvveLkp+uQCID/oFaIXIPtmCxNYbKX197htqAVOYqGmczxcmad1HyavkKbzHCrr
         zY8qpB8phdDEEwUNFpp4omAJyQsToTxuPhu8a5smccTdNdU1eWmZn3W+ym6UePmw22Ia
         D9AFIkrfx5FoD/8uoy0VS9gc0sjR71ohXeR3SObzaySHseaIar1UvoHk4u5/XzNDIAvC
         ZsJHp/9uJ5WrY0pbn+b/VXDq2OWTsjxrszYpW168pTauZEVk0Rx+smTwxKv9H4vur1Ro
         lZYg==
X-Forwarded-Encrypted: i=1; AJvYcCUNOLhbpl/pweVFnz9mmoJx20siAPLNqU1F5PWOalgVejg7E5Tk72Jn+oidz1FxJRmVAK7UmsxhX4wF81Lb0FwxACbOa9NmNfT15+JJvVafvR/b5pzXDXzDSf0jZaTgHrxDuOXx
X-Gm-Message-State: AOJu0YxseOq/1cJquNYj/PCC+Gh5zfhRomPqrdiknSuI6uECFLQp94ew
	y9WP6XZ2JysXOq6+/GEoADFVbn4+8fhz1kXjc8Rw/xIWQmhCjShyMdpM59KDIVFJGy8/Y60KQla
	Obw5Jxq3y0d9dL/lX3sB0QqJDI2o=
X-Google-Smtp-Source: AGHT+IF9CHspS/+4YIVUPThHfX60fsGTHH+icfepuaGZgKOX1lU41zLd0obIn/KQWOfp2D7L66KAVzHs3F7WzTa27BY=
X-Received: by 2002:a0c:c783:0:b0:698:feb6:3d2 with SMTP id
 k3-20020a0cc783000000b00698feb603d2mr3792497qvj.10.1711938058772; Sun, 31 Mar
 2024 19:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325033515.814-1-jammy_huang@aspeedtech.com>
 <c04ebd16-f0b0-45be-a831-fae8b50b7011@redhat.com> <5df1d391-7683-4d9c-accc-9b446d46a150@suse.de>
In-Reply-To: <5df1d391-7683-4d9c-accc-9b446d46a150@suse.de>
From: =?UTF-8?B?6buD56uL6YqY?= <orbit.huang@gmail.com>
Date: Mon, 1 Apr 2024 10:20:48 +0800
Message-ID: <CAOj9kT3=UA-5wkVXb8Rk2h3D=vtZDbhzxe4MY=Nwzod96DeppA@mail.gmail.com>
Subject: Re: [PATCH] drm/ast: Fix soft lockup
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, airlied@redhat.com, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jammy Huang <jammy_huang@aspeedtech.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas and Jocelyn,

What we do in ast_dp_set_on_off() is a handshake between host driver
and bmc-fw to confirm
the operation, on/off, is completed.

We use some scratch registers in bmc to handshake with host. This
handshake only work if
BMC's scu-lock is opened. If scu-lock is opened too late, then it
could lead to this issue.

Best regards
Jammy

Thomas Zimmermann <tzimmermann@suse.de> =E6=96=BC 2024=E5=B9=B43=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:28=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi
>
> Am 27.03.24 um 09:53 schrieb Jocelyn Falempe:
> > Hi,
> >
> > Thanks for your patch.
> > I'm wondering how you can trigger this infinite loop ?
>
> Yeah, a bit more context for this bug would be welcome. It's hard to
> judge the fix without.
>
> Best regards
> Thomas
>
> >
> > Also this looks like a simple fix, that can be easily backported, so
> > I'm adding stable in Cc.
> >
> > If Thomas has no objections, I can push it to drm-misc-fixes.
> >
> > Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> >
>
>
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>

