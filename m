Return-Path: <linux-kernel+bounces-9745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E1A81CAA0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF061F2121D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66FD19BD1;
	Fri, 22 Dec 2023 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftP/gdMV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C2199A7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d408d0bb87so12213415ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703251381; x=1703856181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYxof2/rTBfFuSZEZhakbi3xLEy7HENc6qarIC+O1fw=;
        b=ftP/gdMVM9zl34Vnq/v+onS9hHoUukYOGA3idy0HUoFakBZPrEXDAPKZPiyila/wyx
         vSykgPpls2uDa+p8SDvm0qQxmR1KhTPnFlSx7wt1O1cgHs4GrjiHtbsXyqdOdfPxVM0E
         XCLV3J5i45paLCQqvxcy528yS/divd+dixVgGo5DJ24jxayv+gMd2qxi0FCbGj06B2BK
         D8YvjkKFhz7INyvE6GUzrWuBla2xuPRXFo1b9jaU9rFGn8gIzlECUV8EgigWLI+xtRcz
         ZEJCQGzl8cmAP7DySbOCQD8aW9uoICb8BInC79mzke7Kc6BCn6EhcuCYpjBpo2LbdaxI
         N/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703251381; x=1703856181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYxof2/rTBfFuSZEZhakbi3xLEy7HENc6qarIC+O1fw=;
        b=BZEKyZaLt7aIwGwzm09JghpbUp1+96IUcYggyuj6n84QhfXbbVodrjrlaUofG9oS4+
         fKRIQF/OFCFsPAwvTbwR7bMgQoipTAQPgxqHuXv2sA9/iTLA1qEjTd6k594G50Lhjr2v
         /ou7H0TlxXbteq+WzMLRWqsRbpas/JcZHiBoshoS/RCKIh6RrS+JIVa+ZKCc95evdc4/
         lRg4FZHOkLMnSut7aCE+rKhbJJ/jickojW/CO/wlHK1RR9jPXQS0Lwoi/1u0PhZDiual
         bKclMwr8YAD/oUelgPIXEVmmDsaoI03Wy7w93HaHviy9HgQB1nUI9tgOOFbUgTIhvqQP
         s2ww==
X-Gm-Message-State: AOJu0YyzSIYwhVciLhgYbOtoP4KZxLm6XzcZ5Y/D91Of3E7WcXJhrkFP
	m0w0PRtdJsbEqs9vH5FbLbk=
X-Google-Smtp-Source: AGHT+IFY3LdkSyu7KV8Q3eOvxgBVMkcej97B64oi77ewLqhVFu+FPFkbdufWDS/BiO5IR/VhOeo+tQ==
X-Received: by 2002:a17:902:6844:b0:1d3:eb97:9446 with SMTP id f4-20020a170902684400b001d3eb979446mr1208172pln.9.1703251381180;
        Fri, 22 Dec 2023 05:23:01 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902748900b001d3e13dc9c4sm3434304pll.162.2023.12.22.05.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 05:23:00 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 854B51024D744; Fri, 22 Dec 2023 20:22:55 +0700 (WIB)
Date: Fri, 22 Dec 2023 20:22:55 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Dan Moulding <dan@danm.net>
Cc: Alex Henrie <alexhenrie24@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] net/ipv6/addrconf: Temporary addresses with short
 lifetimes generating when they shouldn't, causing applications to fail
Message-ID: <ZYWNr_4P-je2uVDe@archie.me>
References: <20231221231115.12402-1-dan@danm.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vni8xhQwWxIq5ZfM"
Content-Disposition: inline
In-Reply-To: <20231221231115.12402-1-dan@danm.net>


--Vni8xhQwWxIq5ZfM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 04:10:57PM -0700, Dan Moulding wrote:
> I started running v6.7-rc5 on a desktop and began having problems
> where Chromium would frequently fail to load pages and give an
> "ERR_NETWORK_CHANGED" message instead. I also noticed instability in
> avahi-daemon (it would stop resolving local names and/or consume 100%
> CPU). Eventually I discovered that what is happening is that new
> temporary IPv6 addresses for a ULA address are being generated once
> every second, with very short preferred lifetimes (and I had an
> interface with thousands of such temporary addresses). I also found
> that it seems to be triggered when one of the devices on the network
> sends a router advertisement with a prefix that has a preferred
> lifetime of 0 (presumably it's sending that because it wants to
> deprecate that prefix).
>=20
> I bisected it to commit 629df6701c8a ("net: ipv6/addrconf: clamp
> preferred_lft to the minimum required"). Upon reviewing that change, I
> see that it has changed when generation of temporary addresses will be
> allowed. I believe that change might have inadvertently caused the
> kernel to violate RFC 4941 and might need to be reverted.

Can you verify that by actually reverting 629df6701c8a91 on top of net
tree?

--=20
An old man doll... just what I always wanted! - Clara

--Vni8xhQwWxIq5ZfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYWNrAAKCRD2uYlJVVFO
oxAMAP9lltebRi7sgtxnXr9tOtoEH00eLNEKjA5Xx/oeq4m7cQD+PrCMNymm/dwF
wf9vH36BMIISVma6/Mlh804YTHD2DgQ=
=H5nD
-----END PGP SIGNATURE-----

--Vni8xhQwWxIq5ZfM--

