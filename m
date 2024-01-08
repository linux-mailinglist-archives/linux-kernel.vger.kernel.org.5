Return-Path: <linux-kernel+bounces-19355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 000CE826BD5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932871F2249A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010514004;
	Mon,  8 Jan 2024 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PplsqnML"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A713FF5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD43DC433C8;
	Mon,  8 Jan 2024 10:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704710999;
	bh=msBQzy8EdMXnugGPo4MmTZym97iZCC/FNO8Rtfp4LrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PplsqnMLWNoDx8j5PNwnqLMTBx/buVSkZ/pvtitJ6KXcXJ2nkJkXYJyXlRVUY9IEd
	 sm8uoGHbXSPxN1E/llIhLXkavj+tsn0WLpA+RQK6Ryab8F/XaSJgtb0jf+HKGPDpkS
	 pAlFznsbM94rEiztQRoSSt/Ws+56yRVd2PyzPLxXSbm3GnT/tx16CcSFynvq27fE/C
	 CPGkBbA+m1Iw/LkenFktXnZTgrE+KyWGVsB1z/pAAqY81ZDBIoKfJ45CYdZiVxhCqG
	 dOX3JDP8KWuOpmGk/0isJEqbI0BoPG/GU4ktwf3qSq0QiKC1xBBObs1o1ANQJC1Yyj
	 FKPllksIVNiGA==
Date: Mon, 8 Jan 2024 11:49:56 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dipam Turkar <dipamt1729@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, mairacanal@riseup.net, javierm@redhat.com, 
	arthurgrillo@riseup.net, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/tests: Add KUnit tests for
 drm_mode_create_dvi_i_properties()
Message-ID: <ki4pqpxiww5oylbanlfzflv5raxeykrty2ubx5sgysiqrh55pr@lkgaq5lz72fj>
References: <20231110192452.734925-1-dipamt1729@gmail.com>
 <goxsh3zfoaacariu2dst5ww6ta7g2ubk24impowabvmfte5d4a@fxemdptwshzs>
 <CALHmwspWRT=pj+mPDhf8YTwSpTz6LiNjq18wbUk7wCW3ijKU4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oyi4gxr57md66oka"
Content-Disposition: inline
In-Reply-To: <CALHmwspWRT=pj+mPDhf8YTwSpTz6LiNjq18wbUk7wCW3ijKU4A@mail.gmail.com>


--oyi4gxr57md66oka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 23, 2023 at 03:59:33PM +0530, Dipam Turkar wrote:
> I needed some help regarding introducing a separate test for testing if the
> function still works if called a second time as suggested. Wouldn't we need
> to call it on the same object we called in the first time. So, that will
> bring redundancy in the two functions. Is this correct? Or am I
> understanding this wrong?

There will be redundancy indeed, but you're also not testing the same
thing so it's fine.

A test should be there to test one thing and one thing only.

Maxime

--oyi4gxr57md66oka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZZvTVAAKCRDj7w1vZxhR
xUygAQDTDS5T2olmHPXgg/cu40l6g9mbUBbKsTi64iKCkGOo1wEA6ZGY6WRaLNB3
u8lK+1DyyIjC5HPJmVYd2HPrUh6cZgg=
=F9YB
-----END PGP SIGNATURE-----

--oyi4gxr57md66oka--

