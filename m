Return-Path: <linux-kernel+bounces-133272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D8389A181
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846D9B265BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAEE16FF30;
	Fri,  5 Apr 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8m4Jnch"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBF1DFE4;
	Fri,  5 Apr 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331618; cv=none; b=di4i/MvBc3mFgzeWo4h1+2PSv7X9FOzJHPFHdy5CncGQmYkJqlF9DUQ872pYTVHFh1p45clamp/s/zMf8I/B4SlG2cd8OADCva9hmWrjSDA7fpyGOIkdNDCRCIWfUa9vItfVgr0zBxQpJsYflq8XKcF7XbYyzxAe+bbhOA5u1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331618; c=relaxed/simple;
	bh=3LkYbeUb1w/NqnyBxbOoR6oK2HB39Z/ResRRJH1BY+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpvubVHvZYEqx+6lRP7b0tC5WeVsIbwtZPd4gCIslXTYPQalGrubdh/v9CLDYI/2ThWT4jqYje3OY45K8vqYmP1NrOlWSk8WEXQ4Ixq67HO5O2RrvGCZ2NDso3vhGtq3FUawuo/TKqZ9JWK/pr2chMQlPKnnjArNaE+lSYaB57U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8m4Jnch; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6098a20ab22so21565117b3.2;
        Fri, 05 Apr 2024 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712331616; x=1712936416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogv59Vf9u5J8t0ixBshAYpHXdn+pLcWIJ4jwyLOs3hk=;
        b=D8m4JnchPWDZw4NX2d548lNQKFFh1DmPSAoyAJrRnTdhQLe9hKjxUXCKn6bJtHIhw4
         xrbGGChfgycjmNoXvNmp/T9N3xdLcHvJvOUWMHS/bwdmDGTmJnHjYG7lbN69IuqQhTg5
         +pNQjSWcP49CIP8GAAbnkQ2q1OctCqfUv1eQR20qxRu5EjY08vYenC+MiMRnax5MxikX
         GDEAPqrBmII0MBjrdNb+2LmQspm2IA/ZbEtMAzyb6At9FscH+3f8irVHdGSby2y+F1Cx
         oaZDCj4diZvMo8ceoAOTnyODDvq3DnxV8Kp2l/CCPbe0CasDsLEn4uWUBWSYKDrdDBGd
         Kz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331616; x=1712936416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ogv59Vf9u5J8t0ixBshAYpHXdn+pLcWIJ4jwyLOs3hk=;
        b=BPrGkwrNtd12gAdGaPRb5QEkbbNyCCZav6Lpe8ssg1rjla9suT8iI2KMownYd8mf21
         /htNK+LGPdN+6qZ9wVbh9912YJecyxQiU4rRRZpEfo/qOFTp0+Z6Ag4RtfnbW+WJmr2C
         Aakcn7zTfkZ0+pZUO42Z6YZhE8juQDcuomNnf7QlZxWizZxytWn1r9KkxPB2CgYQa/sE
         PGHIEUtX9d9c7h+bQ/tbWl7X2dR9P59sqNYWuVE6aM8AS6GuDefnfDg8wBWV4TUqQmQm
         kPsUXyqfjoYpqOVmBb7tX7tc/cohUXHK6WAnUHaYvxWFGn8VwioK8w52pwKaoXNYGMmC
         qvGw==
X-Forwarded-Encrypted: i=1; AJvYcCV1ZbqHWEdADZVvroBi9SoObzBeDunZWInAdafqUyDNRjs0qf5aLzv2O+fa8cib8pq9UU27Z2BMX78DuxVkJhcT6DcHnV845qJ4qrGxeDqOP9MQ1K69qlPsi4gBpVVkv23Z60GRxT9fow==
X-Gm-Message-State: AOJu0Yxrnr8uWsZ01RxiB9pPIO2cQ2DDHsVkeTwDFIA7tlGMwb28xqzM
	DiIuqZ0ruQGf0AJwdTRAiyakqOzR3MxjjTjZJDX75dpAGy/7UvlDtYFQcM0Z5UGG8JP80kTGySZ
	3aM/vImEj3ev7MbxVM5YilBjthKs=
X-Google-Smtp-Source: AGHT+IGMLYfLt/nzZblhciR4azfPG3X++K/H/tSTaEsWOtc/7p2fTRz7WVsDs3bk0MLnksajj7+32achn/AzNMNvamI=
X-Received: by 2002:a81:bf50:0:b0:615:11c0:e9c1 with SMTP id
 s16-20020a81bf50000000b0061511c0e9c1mr1738689ywk.36.1712331616228; Fri, 05
 Apr 2024 08:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325210045.153827-1-afd@ti.com> <2024032631-excursion-opposing-be36@gregkh>
 <CAOCHtYjauA+BAxZJBMTaxxaMGcvipP9=ZPeWe4FiNFs_jpq6dg@mail.gmail.com>
 <ZgME0qSL3KXCD07I@chinchilla> <ceb391d3-c7f4-4d46-9f97-b651e1f5451c@ti.com>
In-Reply-To: <ceb391d3-c7f4-4d46-9f97-b651e1f5451c@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 5 Apr 2024 10:39:49 -0500
Message-ID: <CAOCHtYhODiMHWA17EQD7YsZ08Uocy5A=kbjH5vjUUaXAopnxeA@mail.gmail.com>
Subject: Re: [PATCH] uio: pruss: Deprecate use of this driver
To: Andrew Davis <afd@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Kridner <jkridner@beagleboard.org>, 
	Drew Fustini <drew@beagleboard.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 12:36=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> On 3/26/24 12:24 PM, Matthijs van Duin wrote:
> > I'll write a more in-depth reply when I have a moment, but right now I'=
d
> > like to point out that the uio-pruss driver in mainline linux is for th=
e
> > pru subsystem on the freon/primus family of ARM9-based SoCs (OMAP-L1xx =
/
> > AM17xx / AM18xx / TMS320C674x / DA8xx), which is not currently supporte=
d
> > by remoteproc-pru.
> >
>
> I'll wait for your full reply, but a quick note, for those devices listed
> this driver isn't usable either after they all moved to DT. As this drive=
r
> never got a DT port and relies on platform data (which is gone for those
> couple devices).
>
> Andrew

Andrew, I think we are okay with nuking the whole uio driver in
mainline, I'll ack it..

 I figured we'd have more community response..  We gave them a chance..

The only issue I personally have with supporting remoteproc-pruss

We have a few users on 4.19.x-ti, 5.10.x-ti (remoteproc_pruss) can we
please make sure this project:

https://git.ti.com/gitweb?p=3Dpru-software-support-package/pru-software-sup=
port-package.git;a=3Dsummary

actually works on mainline remoteproc_pruss ?

Watching the shortlog, it must break on every single TI LTS release:

https://git.ti.com/gitweb?p=3Dpru-software-support-package/pru-software-sup=
port-package.git;a=3Dshortlog

Whereas uio... well same firmware from 3.8.x ;)

(i will keep our uio fork alive, but we just use an overlay to switch
to between remoteproc_pruss and uio)

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

