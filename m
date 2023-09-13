Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C3179DD26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjIMA2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjIMA2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:28:41 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A4C10CC;
        Tue, 12 Sep 2023 17:28:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fcb4dc8a9so2321455b3a.2;
        Tue, 12 Sep 2023 17:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694564917; x=1695169717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vhVRggmduCOuF925CMHCHBXtEyOEK3orQpWlelUcV6E=;
        b=LGpV93vWkpvMs/YgmURAJNwIbCzZwxaHa8EImci5CMi/dfpHDDiTPFe1S1oLQovC1Y
         RV8OOuSMd4TXT2GW5tLdILTN0kNOdh/Z4eETruq61Mr+M+aNjq/hRddMXtJ3/hOOUaDG
         OregxVU+pLtvrPyEBxIeB7WnvL2x33qMRYJQajsbX6EKOrC2UtqwKLxTegr0Xcpqi6yN
         +uyaOasOCwOcrbJPrhoX3c9M8j0JN1X9lFY94vN+gtmE5J79AAhoSsHAEcKdu/StNcYS
         DNTsQN5e0NyvvYHC18xpvvsDKBUxFHq1m05qJRpy4b9+rHNyQzlk0iHN7V5NXqRxR0x0
         LaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694564917; x=1695169717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhVRggmduCOuF925CMHCHBXtEyOEK3orQpWlelUcV6E=;
        b=qDNDFcyjYAydCx5m0mpukJxKPRZ328+vVElGo6JR15sNmbgLnuULclbzsn57pfcGEn
         fjC9bBwNm8upq1+RHKvu6koya17zaXaNpW7hVw+I9xOqidzV0L9AHdxLKOk/BAmvHzS0
         54RD3hpCyz7NuOsJA44TDQJXcLINH9ezdFoo2uUdEIQ6RFkvhDpO1uT0Z54Xdgwua3Ax
         69rL+hvMCW/ZqeZ/pMgnZkKk+++BVntzoLpVZvjN5iF8vFFY4SdOI7vU4Btpf1Hv4ACR
         TQvNuf+Y5OBwB8o0i45xVDTqTFBg+5WGgZnFs5RWUTK4jFy59TdTbkFK1HTL6qS9gpG/
         ijcQ==
X-Gm-Message-State: AOJu0YyZVIvsGIq8diUwO+85nvqqF7JZd4dJBMWeaEzF6t8dT3ts5Yi4
        SJT/3WGfdSJVouw/Af5aFVJke72fXBQ=
X-Google-Smtp-Source: AGHT+IEBZnQLXEt0KIbDgCMgCEh4GuL17Auf1WF5BNJZ8qXAnnanaFv1TrLKJDks+1AinRVyeTf32Q==
X-Received: by 2002:a05:6a00:178c:b0:68e:482b:5a9d with SMTP id s12-20020a056a00178c00b0068e482b5a9dmr1592567pfg.8.1694564917147;
        Tue, 12 Sep 2023 17:28:37 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id cl8-20020a056a0032c800b0068fb783d0c6sm5234168pfb.141.2023.09.12.17.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 17:28:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DEF7383061BF; Wed, 13 Sep 2023 07:25:54 +0700 (WIB)
Date:   Wed, 13 Sep 2023 07:25:54 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Linux PARISC <linux-parisc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Possible 6.5 regression: Huge values for "commited memory"
Message-ID: <ZQEBkjSgdXSOMq3t@debian.me>
References: <1694366957@msgid.manchmal.in-ulm.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z/ZVDhp9NzC+/dQk"
Content-Disposition: inline
In-Reply-To: <1694366957@msgid.manchmal.in-ulm.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z/ZVDhp9NzC+/dQk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 10, 2023 at 07:48:23PM +0200, Christoph Biedl wrote:
> Hello,
>=20
> For the time being, just an observation: I monitor various parameters on
> my systems, and among them is "Committed memory", the Committed_AS value
> in /proc/meminfo.
>=20
> Since upgrading to the 6.5.x series, I noticed the value there grows way
> higher values then previously in hppa, even if the machine is idle.
> Values seem to rise up to around 1.6 Gbyte, long-term average is rather
> 200-300 Mbyte. Also, I cannot see any memory hogs in top. The workload
> hasn't changed in months.

Upgrading from what version?

Also, can you describe your setup? And what is the value of `Committed_AS`
on the kernel before you upgrade? (Hint: paste full /proc/meminfo from
both old and new kernel.)

>=20
> To sum it up, I reckon something went wrong in the memory usage
> accounting. Is this already on radar, or should I start bisecting? That
> might take a lot of time, though.
>=20

You can certainly do bisection (see Documentation/admin-guide/bug-bisect.rst
in the kernel sources for how to do that).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--z/ZVDhp9NzC+/dQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQEBjQAKCRD2uYlJVVFO
o8oPAQCr9xeAJQEx9/dp7rTccFhd5ag5yJt8QisGJVRhdwx9EgD9HuyG6/uCcvwy
gP90l2jBVPt1HLUeUt6BY7VMcLZvPwg=
=C/3F
-----END PGP SIGNATURE-----

--z/ZVDhp9NzC+/dQk--
