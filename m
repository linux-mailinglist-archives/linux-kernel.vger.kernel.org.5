Return-Path: <linux-kernel+bounces-161347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B418B4B02
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9C11C20EDB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378CF5576D;
	Sun, 28 Apr 2024 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXgk+ZaC"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AD554904;
	Sun, 28 Apr 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714296825; cv=none; b=Dj7Wy7HTABvquxg31CJRD5AvQk7Imw1YVJE1imLbuKkamETOrO/1ByMGdZP23fz5rhU+Yri95RZnP5EXp1OzOejCCjpQisaT8Q0SPtTT5grbUkWBSokU4GXYBatAdZjg3G6SgXjeyiE/CUJNbbfMu/8nAiyEYnTlE6QArtctp7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714296825; c=relaxed/simple;
	bh=9/H4hIcmfu3JjOnIknoqVVHVuWndxPUkScSTTOjWtG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW0PxVdwZz3+lN679IMlUBpHHU41f/63cNBWc3ly6DSXzq49NrD9PC/7JcedrhyAhdMAZSUtWk9KHlSnJPfoIxRqASmsaNkZ+KHTWTs364Q3dLYY6YxiwXruJCcmpJak70Yv6Ql7R1FBd8Plb4Mr1qkrHetfgtcY8nyMR4fv250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXgk+ZaC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e5715a9ebdso29934785ad.2;
        Sun, 28 Apr 2024 02:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714296823; x=1714901623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8y4J2jKG4zMmITnzKwBDxurX5+DaqJx/4k4xBWp5hO0=;
        b=EXgk+ZaCl+3bGpJ2C7A0ZIR8drscLI/4k97m8HeskipOVmmbf8SqmWNc31qCC508m7
         3Y7YbqWiYZ2OINXnufQ5LSkiYsplF/Xf03193/DkTciTbe1F7AWbyNzLSHfNh41+P9MU
         LtUAu796OO3rT3OOF+CVJ3jhdUhDR89ZZ4noscO57r71bFmjO0V+rx6MphyCJyIkHDHG
         QLentiqDwocZM4vTBOF3yKGbCfzuChl4D6zw45HbB7KLSXfsMKqehV4QfxrNbCOkNaQf
         bqygTaGSMStwOCg2vUuDt0NJVpgYswIHqVNxENokl8wC6aswB24ytHBdywH6mY3MWut4
         9GMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714296823; x=1714901623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y4J2jKG4zMmITnzKwBDxurX5+DaqJx/4k4xBWp5hO0=;
        b=JQV6oHQORGkn3zzQIyAIxvJ7/dk9wSYnMTiKlihRqKfJwkRSxWkvO7hg9hyCY8aN1K
         OP8ltKqvOBXlpr1UQQjNntk+4HB6SQlim5LKiHeahiBrg28nouC5xCOqQBYoa/ki2p03
         GfjYTO9dqxXl0FJNG3UckbX3S4c/BWws4JJQARUC/p1PMvd6GB+Jm82+ddDFp1HvE15k
         nsWIcYjXWNSZY5/L2ZZOKMIv5fITR2bY1N6Umtsb4Kv386SrGF5prLz5hUJc1Udztm2A
         3vMwwr0KcLXs9HtZb39u5RTbapu16vd/U5XKSpXsraIUf6Qa7p/BvFc/GDRAJU83M4dM
         tPYg==
X-Forwarded-Encrypted: i=1; AJvYcCWHhXQe/e13LyOGTfM4/rtKMvKEYY7/MKyilp0bhodmfemOeGTfkQSybJ26mOCUSzVQIxW/8/QzJOmJlK52jr+HfGBHBpy+0pS1AWvY/+PxEdHKrj2s31NtZMVflbRbh2YmqagW6UMNDuIPdrq8grcJ0fk554A0xxsafn72zAQ4TkA/b1vtY9EaE4JzFtUVmY/XSe/lkw8C1zQQhg==
X-Gm-Message-State: AOJu0YyJzGg3y6J34AN4SlFX64rZKMWPkHIhUXIlA7WQBPnlNNO5jv3a
	3LOULX57KB/aMULPGt8DoD1U2tRdNPA1eYdEcTqNxQsHLjF2gzIx
X-Google-Smtp-Source: AGHT+IGY8wQOviArarfgPhxPvt9bnQiBDGjv4NNlhGEdkQKoEG2Trea3tp+JYSu9ILqwtee0EG7LMA==
X-Received: by 2002:a17:902:bb83:b0:1de:fbc8:53af with SMTP id m3-20020a170902bb8300b001defbc853afmr3761373pls.25.1714296823253;
        Sun, 28 Apr 2024 02:33:43 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903005200b001e85cf937ffsm18171609pla.101.2024.04.28.02.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 02:33:42 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A981B184692DC; Sun, 28 Apr 2024 16:33:36 +0700 (WIB)
Date: Sun, 28 Apr 2024 16:33:36 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com
Cc: UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 01/12] Documentation: networking: add OPEN
 Alliance 10BASE-T1x MAC-PHY serial interface
Message-ID: <Zi4X8NO9SkhffJ98@archie.me>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-2-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5Fqs5imMNEU2vqXw"
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-2-Parthiban.Veerasooran@microchip.com>


--5Fqs5imMNEU2vqXw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 06:26:37PM +0530, Parthiban Veerasooran wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04e5f7c20e30..79fa7abb4ec9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16400,6 +16400,12 @@ L:	linux-rdma@vger.kernel.org
>  S:	Supported
>  F:	drivers/infiniband/ulp/opa_vnic
> =20
> +OPEN ALLIANCE 10BASE-T1S MACPHY SERIAL INTERFACE FRAMEWORK
> +M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/networking/oa-tc6-framework.rst
> +
>  OPEN FIRMWARE AND FLATTENED DEVICE TREE
>  M:	Rob Herring <robh+dt@kernel.org>
>  M:	Frank Rowand <frowand.list@gmail.com>

I can't apply this series on top of current net-next due to MAINTAINERS diff
above (on context line 16400 I have Omnivision entries). Care to reroll?
(Hint: also specify --base=3D to git-send-email(1) so that I and other
reviewers know where to apply this series.)

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--5Fqs5imMNEU2vqXw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZi4X5gAKCRD2uYlJVVFO
o1AvAP4nLo1+SkG4LHoDx0UG7x2GO8EAVGWa2xA0bfEy+LmYZwD+Nkv8oXNIABg7
t7tyeXn5/fcA0D6fn+xGvTd0RKT37g0=
=jFZ9
-----END PGP SIGNATURE-----

--5Fqs5imMNEU2vqXw--

