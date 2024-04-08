Return-Path: <linux-kernel+bounces-135532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0514889C742
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84189285984
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E9013F003;
	Mon,  8 Apr 2024 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rc/hsJsx"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE9E13E8AB;
	Mon,  8 Apr 2024 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587268; cv=none; b=HTbXixyb6jF5UNVYscLyv5UkFahJdZJyktcRwc0553JQi4W0MkxWfrcvtrpwW0Mz79oSfRHKOswf3qY9B/NCHbxjx6eslSiZ1skcwv3/ccomLK5cH3xHEuBPzMQ49gbm9USZ7a+sCMt0qSStBmVsZP2Jc+3XDDq4NcG2YIOEvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587268; c=relaxed/simple;
	bh=0jHV2atfMCFH7kbPbCAtT4ZpB0B4fwpk/IZxZ+9Ny+c=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=j83DyGqye9Je/KKDMBw7faWVbg9fdGDrq22xVjC/uDlbMtID23xYZdGiBTUw5sJTknWpjEFwl5Ss4pga4YlK2UIpAXH6ZUMv+hjbjjS+fURg9CJgYEgibKbfv09b4TFfuMAwCeMn3lx+POVAeroR9NAImJ+ElT04Buk7i99gXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rc/hsJsx; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EEE2D2000B;
	Mon,  8 Apr 2024 14:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712587263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdjuZYzz4AD6KxgkM3stOzUQbhIkDEUieomkwHFI+Js=;
	b=Rc/hsJsxK+KTTl/IdGpI6oT2jlCuaQ1aZufQzrUctxKP8DN0AGcmgL1wYgkjsteFF1pD2Q
	F3gDv2fgc9264wJD0pfwQcBx//HMp0qIR3ndhg7MNv9hYw6DcI2iXKjpogYEH4IWmYbVTj
	ri2gAvVz8ZZPqssjOUEC9Q5j7kEXkpOKiDRwpyLgSJToSqFOu8I0EwexvJuVs6BKaAwWtE
	kGsY9GpvY3nj0/BhFPFfxhBnyGOzRWlleQua6GIGjGbcydJY9rZukcFIULgyuYONhYVduz
	+075Yc8mFs0MNr53QYSW/7nuJB5i+3ypSZgo/QD0S3oBXKkgC6vBPENhJyIPSw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Apr 2024 16:41:02 +0200
Message-Id: <D0ETINAEWXQP.2VIPSSSM1PTMD@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 02/11] spi: dt-bindings: cdns,qspi-nor: sort
 compatibles alphabetically
Cc: "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Vaishnav Achath" <vaishnav.a@ti.com>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>, "Rob Herring" <robh@kernel.org>,
 <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
 <20240405-cdns-qspi-mbly-v2-2-956679866d6d@bootlin.com>
 <37d89b59-d94e-47aa-8841-f2758b8e18b2@sirena.org.uk>
In-Reply-To: <37d89b59-d94e-47aa-8841-f2758b8e18b2@sirena.org.uk>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Mon Apr 8, 2024 at 4:14 PM CEST, Mark Brown wrote:
> On Fri, Apr 05, 2024 at 05:02:12PM +0200, Th=C3=A9o Lebrun wrote:
> > Compatibles are ordered by date of addition.
> > Switch to (deterministic) alphabetical ordering.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b=
/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > index 5509c126b1cf..e53d443c6f93 100644
> > --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > @@ -79,13 +79,13 @@ properties:
> >        - items:
> >            - enum:
> >                - amd,pensando-elba-qspi
> > -              - mobileye,eyeq5-ospi
> > -              - ti,k2g-qspi
> > -              - ti,am654-ospi
> >                - intel,lgm-qspi
> > -              - xlnx,versal-ospi-1.0
> >                - intel,socfpga-qspi
> > +              - mobileye,eyeq5-ospi
> >                - starfive,jh7110-qspi
> > +              - ti,am654-ospi
> > +              - ti,k2g-qspi
> > +              - xlnx,versal-ospi-1.0
>
> In general it's better to sort trivial cleanup patches like this before
> new functionality in order to avoid spurious dependencies.

It wasn't clear to me if this patch was desired. I therefore put it
afterwards to avoid conflicts if "spi: dt-bindings: cdns,qspi-nor: add
mobileye,eyeq5-ospi compatible" was applied.

Now that I know it is desired, I'll move it first in the series.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


