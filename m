Return-Path: <linux-kernel+bounces-144220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6BD8A434D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD01C20CFC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FE8134759;
	Sun, 14 Apr 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHaZKdxA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE83134733;
	Sun, 14 Apr 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713107943; cv=none; b=klneLsLFx8RgZB4rdy+0OLh9jdJBgGu36sEo+eNZY4abcHuoBBiRQVQkPL/vLsqL1+tmijfvZKQDKHr4gTPb3wGock3riPXd5+cntKDpMOmK1nmpxxqtkZS3cPPv8vkI5/A3rj9K7KY3ragPA70SU/JrAMtSsQYYqZaGyFjOuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713107943; c=relaxed/simple;
	bh=Vn4OKD2x5O2W06aQlBmyQAhXdE5m76uzb6Faw5X3sYk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ClWGHG1FsZ0a6tu3ePmsObMmcTdznLSaam1h0E+S/JMcTyCrL20I+z5AKh6hCjGyeF3CcBN6lUc7RoHZCt9WQZoAvHw499JqNnzTkOCUQNkCR67PuX6OoLLA2a+18jn4alC+w+94vX/TBx0MwoCdiSW+R0fJXn8YNOd7v6QkeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHaZKdxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0E4C072AA;
	Sun, 14 Apr 2024 15:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713107943;
	bh=Vn4OKD2x5O2W06aQlBmyQAhXdE5m76uzb6Faw5X3sYk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=YHaZKdxATqJxvyVuYXVuH91QQrxkBawFpsDHaKmEAa/q6cSB5eO+0oQpLXQAmkq9y
	 Vul99IHl33YJFziANhBakRNMEgtVikC0eiMAJ5EEHs6ZoF7ohWI8jWosRlOsFiQejX
	 HxEgsDQidkF7d1z6++YSff3vC/dbLliULfZKl9f9XbHTgKi/xeEZBU4ThDNyngwNuQ
	 ADRVMoUNfb9abcNyiyhFciWkppOPu3kuCxSUftcqFbUYFWOceKHO2ISxZUVCWVShaw
	 JOyue3bXgHLRVMXXTB+KPt5ER+1ryqN6nSz7Y+ebZSMZJD816gPFenk7m5Wj9fOcd7
	 40vdBaPpRg+Jg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Apr 2024 18:18:58 +0300
Message-Id: <D0JY2YLCE7ML.3JI9B0BS0UGTC@kernel.org>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Lukas Wunner" <lukas@wunner.de>, "Alexander
 Sverdlin" <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: tpm: Add st,st33ktpm2xi2c
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Michael Haener"
 <michael.haener@siemens.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240414074440.23831-1-michael.haener@siemens.com>
 <20240414074440.23831-2-michael.haener@siemens.com>
 <e64ac8ae-befe-4631-960c-c33290f40e5b@kernel.org>
In-Reply-To: <e64ac8ae-befe-4631-960c-c33290f40e5b@kernel.org>

On Sun Apr 14, 2024 at 12:11 PM EEST, Krzysztof Kozlowski wrote:
> On 14/04/2024 09:44, Michael Haener wrote:
> > Add the ST chip st33ktpm2xi2c to the supported compatible strings of th=
e
> > TPM TIS I2C schema. The Chip is compliant with the TCG PC Client TPM
> > Profile specification.
> >=20
> > For reference, a datasheet is available at:
> > https://www.st.com/resource/en/data_brief/st33ktpm2xi2c.pdf
>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Best regards,
> Krzysztof

Thanks!

I have the following tags now:

    Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
    Signed-off-by: Michael Haener <michael.haener@siemens.com>
    Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
    Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

For sanity check: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/li=
nux-tpmdd.git/log/

[did not put direct link to the commit as master branch gets updates and
rewrites often]

BR, Jarkko

