Return-Path: <linux-kernel+bounces-19846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB15E827535
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89DF11F23986
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3930242AB2;
	Mon,  8 Jan 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLX5sBLD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45853E2E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7ce674ccdf1so140595241.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704731527; x=1705336327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+F9WB1cD1EVCMMKl9VxjGral4G2NFKzygjNdXJMFJbI=;
        b=OLX5sBLD+qAY/Gf5Jpsp5MYjy0/vXLvQDn1lkZt2l+AHCduD37/mpuNTLR7Mrch2w0
         BwZQnodxjXji/NRbkomIV7z7Rv9Vi8zYfLbALmeuZziFYNbFWnMc1UF/FSKDv1rVkkW1
         IgRL8kQ1UVqB7QUnkBVIVBxCT0zl3xGfT1ikGO1wHZham+7R02s25p2SLaGirCePC38V
         bfcDet14k1///R4Pkz78+bBgeVk2eIMD7R6UskG9/xdEFFHvrv4bIc7xO/UGkZNL7nWP
         OJiUjfgXJPMBgpEvcK9f4bsRqmoygaDwM4btWSmXi9QpKsizIvFNfA69a0HgTiyJvbij
         wgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704731527; x=1705336327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+F9WB1cD1EVCMMKl9VxjGral4G2NFKzygjNdXJMFJbI=;
        b=jbn9sNq/oBPF64FtmM3G3A5XYZ3TgCrh6f2LvslYrkdVyDQgK41BLOITg2RKnftsFm
         LOnUyMddd+pmbJNJoV3bgM6yH8X7f3IUNy5iU6lCGZvYhcf/Z7Dvvq5kF9bK7AZdJsIc
         /Rko5I+K6m1b5MX/VSOeXeff6nlES02UQgMWLlu7qQVIWY8cmolirKPa3XW3nyWK4cA9
         TboR6+P5VE7LMyRQgipwPmCTIIaRIIoOy/CNs1bDuQd7eH9bXuur3CPgK5ffgk5lyaxE
         0mpanybJypeA1neu4OjdJvPjjuhfNMKJJeyhL0XyqIVow6Ykkop92nCZmheTgr5DBlSm
         kBuA==
X-Gm-Message-State: AOJu0YyaMa3fxCveq/OdK5GRA7Jk9fmE3cGX97FEQ4keqlHo1OmK2c/9
	lMAYqGEgV76n0ZKjFrFJLABtTfv90/2MIw==
X-Google-Smtp-Source: AGHT+IHjN+WbVK9JAkFtDdDezP/x5omy7VsA5M78/4m+F6BC7AM8ehHjZYak29PwPVwxPKMyZS6KAA==
X-Received: by 2002:a05:6122:3687:b0:4b6:c7e6:c669 with SMTP id ec7-20020a056122368700b004b6c7e6c669mr1324232vkb.17.1704731527327;
        Mon, 08 Jan 2024 08:32:07 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id bk40-20020a0561220e2800b004b6bd431c00sm24430vkb.31.2024.01.08.08.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 08:32:06 -0800 (PST)
Date: Mon, 8 Jan 2024 16:32:04 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tools: counter: add counter_watch_events
Message-ID: <ZZwjhDp6axjWgBNj@ubuntu-server-vm-macos>
References: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
 <ZZwi944O0O2AlckN@ubuntu-server-vm-macos>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z/xlxDSiVzioO2Mv"
Content-Disposition: inline
In-Reply-To: <ZZwi944O0O2AlckN@ubuntu-server-vm-macos>


--z/xlxDSiVzioO2Mv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:29:43PM +0000, William Breathitt Gray wrote:
> On Wed, Dec 06, 2023 at 05:47:24PM +0100, Fabrice Gasnier wrote:
> > Introduces a new tool that can be used for testing. Also
> > add MAINTAINERS entry as per William's recommendations.
> >=20
> > Changelog:
> > - This is a split of another series [1].
> > [1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasni=
er@foss.st.com/
> >=20
> > Fabrice Gasnier (2):
> >   tools/counter: add a flexible watch events tool
> >   MAINTAINERS: add myself as counter watch events tool maintainer
> >=20
> >  MAINTAINERS                          |   5 +
> >  tools/counter/Build                  |   1 +
> >  tools/counter/Makefile               |  12 +-
> >  tools/counter/counter_watch_events.c | 372 +++++++++++++++++++++++++++
> >  4 files changed, 388 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/counter/counter_watch_events.c
> >=20
> > --=20
> > 2.25.1
> >=20
>=20
> Hi Fabrice,
>=20
> I'm going to reply to some of these patches with my Reviewed-by tag for
> my own sake, so that I know I've already reviewed them before picking
> them up at a later point.
>=20
> William Breathitt Gray

Oops, please ignore. I sent this as a reply to the wrong patchset.

William Breathitt Gray

--z/xlxDSiVzioO2Mv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZZwjhAAKCRC1SFbKvhIj
K0nQAPsEubmpKP2WHLtxzI4sjL4v4lNtmndyJWgSMeTUervYPQEAxovkfz6SThpK
4YfUAP/jTV+z3VRggDO2GkGya4wBIgQ=
=66lm
-----END PGP SIGNATURE-----

--z/xlxDSiVzioO2Mv--

