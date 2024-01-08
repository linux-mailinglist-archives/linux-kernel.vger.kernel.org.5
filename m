Return-Path: <linux-kernel+bounces-19843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3A0827527
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C76282F6A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6801D45C1B;
	Mon,  8 Jan 2024 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLwlSTCX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7432054BC3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7cc92a83200so402557241.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704731386; x=1705336186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hT5RihLVZ6pdmIOZO3I4HwZe6d+t4eo6mHHQbGnw45s=;
        b=fLwlSTCXwgaXLc8B7LdCHdFkPu22vc2trGAzbei8BfnpgOq0CBFJAEsPeSGjtoNj0+
         LEGQhNQo8ZsuCcIe1QY9yt1CT1pJnsoBR7mPotXP1W8q6RDr2hFl8PV/kXb3UFxjv8DK
         jacJ8Dtb4S62v/OlifRS32q1VTmf+83m9AtpMmwzn47b3JnJEjIvXxDawqXg/6cJehMO
         19O8ocO37WThkmRTOaNIN23hUt15nd+g0ClAbJ31+nbs30wRCR5gpeM7XxYLz2oJet92
         FbR4fCFjiFz2PCpYHUQW7NfcOrSzd7J1bmyd2Uqn4XFSEciGABEfH8PB3Sz1Fcw5DVPA
         c/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704731386; x=1705336186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT5RihLVZ6pdmIOZO3I4HwZe6d+t4eo6mHHQbGnw45s=;
        b=RQwDtggr70AsCgyaIGT3T4a/cJJvg+8K0lSCjWzXx5h+6WxIokzSozOyUk95/Wbooo
         drqUKfI+VtAnj1JSWDYPBXEh/UbfzXkP6QJ2MRcIAys59yMcY9OMrz8YmT3An6DSD/jH
         LIFYT+lKdTi0R4Q/lSi63YGnX493/jjzysk9ChDubuPYPh854QaHEvbEwGjntdk40Fm1
         zehL/x14gs0ccI97dWfR9UfUxSfoldC+KkAzWpOMW5DybawPSX+NEJRicPS0YNvsiIku
         ipgyP1AprvOFCi9s+967vBNpOSrETQa08BnuN30zbZM88iCmUOKGLCsEn3uYUwFfenkK
         I5Ew==
X-Gm-Message-State: AOJu0YzCNZp9uoEsOq0zLx4o8d9swBXf4V8biI9krLlqERm6iIHITocs
	w9kg2HOqpYehlpmTXZWbb3a3fY8U6FbGyDq1JKHf58cHjWs=
X-Google-Smtp-Source: AGHT+IE1YQHcy6e8n1tq1lbfLcK9JM25Lp1bfmlHIT4nZ9l04SI3Alzffg2MLOaAT8NfsRDRtgoygQ==
X-Received: by 2002:a05:6102:3eca:b0:467:b195:6f68 with SMTP id n10-20020a0561023eca00b00467b1956f68mr793643vsv.30.1704731386246;
        Mon, 08 Jan 2024 08:29:46 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id f1-20020ab06f81000000b007cb869908b0sm16080uav.6.2024.01.08.08.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 08:29:45 -0800 (PST)
Date: Mon, 8 Jan 2024 16:29:43 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tools: counter: add counter_watch_events
Message-ID: <ZZwi944O0O2AlckN@ubuntu-server-vm-macos>
References: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vez9kyFd2T+wrLnY"
Content-Disposition: inline
In-Reply-To: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>


--vez9kyFd2T+wrLnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 05:47:24PM +0100, Fabrice Gasnier wrote:
> Introduces a new tool that can be used for testing. Also
> add MAINTAINERS entry as per William's recommendations.
>=20
> Changelog:
> - This is a split of another series [1].
> [1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier=
@foss.st.com/
>=20
> Fabrice Gasnier (2):
>   tools/counter: add a flexible watch events tool
>   MAINTAINERS: add myself as counter watch events tool maintainer
>=20
>  MAINTAINERS                          |   5 +
>  tools/counter/Build                  |   1 +
>  tools/counter/Makefile               |  12 +-
>  tools/counter/counter_watch_events.c | 372 +++++++++++++++++++++++++++
>  4 files changed, 388 insertions(+), 2 deletions(-)
>  create mode 100644 tools/counter/counter_watch_events.c
>=20
> --=20
> 2.25.1
>=20

Hi Fabrice,

I'm going to reply to some of these patches with my Reviewed-by tag for
my own sake, so that I know I've already reviewed them before picking
them up at a later point.

William Breathitt Gray

--vez9kyFd2T+wrLnY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZZwi9wAKCRC1SFbKvhIj
K0k3AQCe8ZmmLm3SGKy3zItu8XwD5EcVCyCSjxQLoK0sqWEYnAEAiZSlr+EX/vyn
yWQEOi56Tq27zvaC7dvLVkRvAx5GhgU=
=OkFg
-----END PGP SIGNATURE-----

--vez9kyFd2T+wrLnY--

