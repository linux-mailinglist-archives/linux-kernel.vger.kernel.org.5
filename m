Return-Path: <linux-kernel+bounces-24720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E50982C14B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A54E285ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BA26D1CB;
	Fri, 12 Jan 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpLx4LW0"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED06BB3E;
	Fri, 12 Jan 2024 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4610133a12.3;
        Fri, 12 Jan 2024 06:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705068230; x=1705673030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O088ye5Vczz+Cex9AYDIz9lw484DzSeXBcQhFwm7euY=;
        b=SpLx4LW0KhbAWhI/zwklsOpY0CiwX1oi7lrNMT37dCXW/mnhSJEqt03mtnD2nWoaxR
         FtMI8l/I/vP9Id+tchNZd84FHya+4MK91wbBCm/dkF3XnFNwKgNkruvJaxxYDrh9aPP0
         6SAb1dYnRSheukqO7Futeig/YHjky8YaRgHjIHTee8DWM3cdnIbpd8aAeQ+6w4LW5ByV
         Bu/8Z1bAQoRFGIXi8ekJCxTqj3PEliIQteAditJaW+7Sr1mfFvz9n4EMYRT4jW3UzD5m
         3FB4c06GV9DD+2OO9vcFVAOocfhwAlsHg6okTikjA61XIxbc3sD4H/jkJ5vm6JwJn7sk
         i+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705068230; x=1705673030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O088ye5Vczz+Cex9AYDIz9lw484DzSeXBcQhFwm7euY=;
        b=puKrDaGMPZ4kvGXXorejmjIgf6TEkOxxQNVbzis6+tp4sQN9cXf3jnQkCmGvSVw3ak
         1DrcZ39GZNsqaIdYXasS4h6He26bNmgiUy+aUKCnSKH49hcGj0ewZUg5ai+4SMM2IGXp
         PhOE1qJXCtGdtKR3EG/cvG+sfjBlTTnAGhw3yLzyMqAI8sngUt0GtZqrDRrSqEXddJqT
         A8dRMganNf8Roq/Z98/B39l3cGWy8jxgOEwzDJLiraLMbofoZbz72gjCRqMVXwDlUs1X
         YX2jI2eaRPH2JdMAEI+1dYEfMVPaArKj2t6P/n2WsxPNEKFwzfnp6Wrd2WdgPTLoluCg
         GFZA==
X-Gm-Message-State: AOJu0Yy8tr7zUxddO5cVBNRDD7JYHLR0ujIGr2h3pSWpR+Q29ompJdIC
	nUgebWrwvenc09hV2xmaA5o=
X-Google-Smtp-Source: AGHT+IFb65ZbUbd5LdSxD4vK9Kx1NokhkW3hZLtNs1TCetui1BAjq6vV8mvo7uqTFUSb7P/g0K/iqw==
X-Received: by 2002:a17:90a:318a:b0:28b:e124:1b00 with SMTP id j10-20020a17090a318a00b0028be1241b00mr1276932pjb.4.1705068229859;
        Fri, 12 Jan 2024 06:03:49 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id cz13-20020a17090ad44d00b0028c8a2a9c73sm4141066pjb.25.2024.01.12.06.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 06:03:49 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 527C818503882; Fri, 12 Jan 2024 21:03:43 +0700 (WIB)
Date: Fri, 12 Jan 2024 21:03:42 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: What to do on MIA maintainers?
Message-ID: <ZaFGvkA-ZoZ1OTID@archie.me>
References: <ZZ_JuZd0RJUzIrgY@archie.me>
 <20240111094055.3efa6157@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vVBsWQof3GLpBVhI"
Content-Disposition: inline
In-Reply-To: <20240111094055.3efa6157@kernel.org>


--vVBsWQof3GLpBVhI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 09:40:55AM -0800, Jakub Kicinski wrote:
> On Thu, 11 Jan 2024 17:58:01 +0700 Bagas Sanjaya wrote:
> > Earlier in late last December, I sent a patch removing Karsten Keil
> > <isdn@linux-pingi.de> from MAINTAINERS due to inactivity [1], but Greg =
was
> > unsure about that [2]. So I privately tried to reach Karsten (asking for
> > confirmation), but until now he is still not responding to my outreach,=
 hence
> > IMO he is MIA.
> >=20
> > What to do on this situation? Should he be removed from MAINTAINERS?
>=20
> Well. I'm not sure you should do anything about it.. In an ideal world
> with properly set up maintainer structure it should be up to the next
> level maintainer to decide when to do the cleanups. Random people
> initiating that sort of work can backfire in too many ways. IDK what
> a good analogy would be here, but you wouldn't for example come up
> to an employee in a store, when you think they aren't doing anything,
> and tell them to go stock shelves.
>=20
> If there are patches on the list that needs reviewing and the person
> is not reviewing them, or questions being asked / regressions being
> reported and they go unanswered - the upper level maintainer can act.
> But trust me, it's impossible for someone who is not an upper
> maintainer to judge the situation.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--vVBsWQof3GLpBVhI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZaFGugAKCRD2uYlJVVFO
o6McAP4pJHlnOCwtmMryoqnye3GFaq011ELb3GasFQdH8Yu5FwEA5vZbESmCEPLz
ulK8wueqFc4PAcM6CyWfFekrKDX0JQI=
=saio
-----END PGP SIGNATURE-----

--vVBsWQof3GLpBVhI--

