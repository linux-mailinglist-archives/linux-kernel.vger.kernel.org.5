Return-Path: <linux-kernel+bounces-67371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A3D856A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D371C22BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73022136981;
	Thu, 15 Feb 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ9PHbZv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A049B1353FE;
	Thu, 15 Feb 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016822; cv=none; b=Gtvf+OEies4ZLV5ifMOygC+/OOCtKKRmj5WM7tMqBS1GAYfQjF+Jj0qZ5gjOd7R2yjlTU7lYqc86MxGxaUAIW6AkyI8lrB+vlamcI5EkwrThurXphI06j+tJy5+acjQVSYG0n5zKZ54iKcupYDQbE85IDG8wvnbfA7QG1sh+Xts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016822; c=relaxed/simple;
	bh=/lPHGMlMraWwekZu9daDqcJ1WWR6U7gKnKG370LJpYg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hBpIlgreQsj3X2ET4aqg40NBIscngfE0GuqSRnr60rUJuwsjenrKYIsRFKffFRadnK4nZ2FD9vYx9VetVdf5q4WTqe1Cgd7sUbTm1E2+Sg5hJ7hxGOZxedUrPfRj9IBqEgOoCtiJ3RGNTkhh8hRCS0PS8AClrDxRTUNnlM/BM1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ9PHbZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21184C433F1;
	Thu, 15 Feb 2024 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708016822;
	bh=/lPHGMlMraWwekZu9daDqcJ1WWR6U7gKnKG370LJpYg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OQ9PHbZvPKaIOMWZI7B2WnRJ8sl2j9jzTfcKoq0HtGHzmIiwuoljRuOTizQ7Fv9x0
	 HEZZlkZ178uCcyMrg4O4U5x1wMNmWUABpvVH99z8DTsHd7OX1vAPjHEG0jU1+RSmKC
	 AAJxKL8cAeharrfFdkxvbODYHJHiZNKBuE4/r7o38R72GGM9mkGB0PZcn8am8fsYwo
	 3oARqMkDLplp4gn/IR2Q/PpVJ+LFnnoc8XTAjTfDS/tkFcgsQ9j95EiPd5QSa/eyJ2
	 AXbcO2SAZUVhuL5i4GSsInKtCNa6WPlEh9tCFke83JHav5Qx4IRLfPqMVZgd8v2Dhf
	 I8p/lFir8OB+w==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,  Ajay Singh
 <ajay.kathat@microchip.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Igor Mitsyanko <imitsyanko@quantenna.com>,
  Sergey Matyukevich <geomatsi@gmail.com>,  kernel test robot
 <lkp@intel.com>,  Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 srini.raju@purelifi.com
Subject: wireless: orphan qfnfmac and plfxlc drivers?
References: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
	<02c155ff-f880-4e88-b600-9d632019729f@bootlin.com>
Date: Thu, 15 Feb 2024 19:06:58 +0200
In-Reply-To: <02c155ff-f880-4e88-b600-9d632019729f@bootlin.com> ("Alexis
	=?utf-8?Q?Lothor=C3=A9=22's?= message of "Thu, 15 Feb 2024 16:50:39 +0100")
Message-ID: <875xypejwt.fsf_-_@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(changing subject)

Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

> Also, my mail provider returns error 550 (No Such User Here) for quantenna
> driver maintainer (<imitsyanko@quantenna.com>, taken from MAINTAINERS). I=
've
> seen no recent activity from him on the ML, is he still around ?

I found a bounce for imitsyanko@quantenna.com from 2022 so I guess it's
time to orphan qtnfmac?

Also the purelife maintainer Srini Raju (CCed) is bouncing, that's
another candidate to orphan.

PURELIFI PLFXLC DRIVER
M:      Srinivasan Raju <srini.raju@purelifi.com>
L:      linux-wireless@vger.kernel.org
S:      Supported
F:      drivers/net/wireless/purelifi/plfxlc/

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

