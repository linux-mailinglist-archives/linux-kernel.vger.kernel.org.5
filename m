Return-Path: <linux-kernel+bounces-155436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573EB8AEA82
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123582871E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6AD13C9B9;
	Tue, 23 Apr 2024 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd/C/ZUW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541813C800;
	Tue, 23 Apr 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885323; cv=none; b=bkcv3OT4VU6GdqwWU8Gt0BYYL341Ihl9IlByXl9hrMhv2HwUrUwzeu2wKtElAmZB7uriPaYvGAjzGFUkOWcMYy5EUccKWxjnzgVKKCqRKTOPduppSJKqvvSmPdEKKrjeq1GMPQEOTjV1ZRla82n5MAMZCYq4rHO/aZyQowHlUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885323; c=relaxed/simple;
	bh=/uZufZpRdzmKtH5MYtzbvHBmXWUpN1v5Z9C3xo4IXg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDMmhvMWWRRZudOm7VGR1CvB28p0IJBRL5dIxMG6YXtUqIqtEHXZ6PAWtPt5EwvCbAoXiwTBKyfa1YNcqTw4B6GO49acyCDVmV+ARYXEft/zrMUx6sgs4TSTZPxV+rUSCPn8KeUXpgCXbHtCMQVpRGdBEntpdBZzz2wvQQXn3SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd/C/ZUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183E8C116B1;
	Tue, 23 Apr 2024 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713885323;
	bh=/uZufZpRdzmKtH5MYtzbvHBmXWUpN1v5Z9C3xo4IXg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cd/C/ZUWihPFiTeqkbSPjPoxuc35Ean5B5EqaOiqlljGnI8Et2f13lYPEHClFeaEj
	 Ka5f9gpsw3fMlwpW9Dd4zQXRZ7ipMFUzAaRO+46LIKp41CEPVivWgjVRUkK4iFBriX
	 PtC3pTOXcdpyUmkenMxYGD7RWGsv+Hv+PMqyMQXBy5J+Q3XfPcrWt7HFzXf2RN48vz
	 sooPOEp/vRLXDBxxUab+CnD0MpKyDwvte6Wc09gOsDKtrZXkFKRBd6vy4GctPVIS++
	 WxLrP9OwB8obqYeXqmm6Ey1k+anY86Uidz0PZPLrgKwVyRyZxNlNHYw3/0ednUOI69
	 cr4e0+jb+dDDA==
Date: Tue, 23 Apr 2024 10:15:21 -0500
From: Rob Herring <robh@kernel.org>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] spi: dt-bindings: nxp,sc18is602: add compatible for
 SC18IS606
Message-ID: <171388530766.315956.8731620414643797177.robh@kernel.org>
References: <20240423-sc18is606-v1-0-094ef37d5a59@bang-olufsen.dk>
 <20240423-sc18is606-v1-2-094ef37d5a59@bang-olufsen.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423-sc18is606-v1-2-094ef37d5a59@bang-olufsen.dk>


On Tue, 23 Apr 2024 13:35:31 +0200, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The compatible string is nxp,sc18is606. It is a functional replacement
> for the SC18IS602B with a larger data buffer, three (rather than four)
> chip selects, and lacks support for quasi-directional GPIO.
> 
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>  Documentation/devicetree/bindings/spi/nxp,sc18is602.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


