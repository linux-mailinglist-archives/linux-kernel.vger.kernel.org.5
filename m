Return-Path: <linux-kernel+bounces-135290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3489289BE79
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659291C21469
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0636A8CF;
	Mon,  8 Apr 2024 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="CBmEiw7h"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BFC6A328;
	Mon,  8 Apr 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577171; cv=none; b=J8y9BFtTLjCI6iRC3LAvs8qKs8xHP4nTFfMGdQ4wt8qiMJ+7DQkBfcw3vEqtz7wPssMHtW3PeFcxVCvuAu6M9AqyZYE8UwDnMwnF9Il8x3pj+PuJWmC0EE712wpVmqTG1uPHD7whquTbtbAwWuGonnhP+rgWBxktlRym8tfHqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577171; c=relaxed/simple;
	bh=XnOP/Yo4Ki+3xP7wAvLN+cYpAm2XEbcV9ngJZcqHHvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibdCNobrC7Mal6m3yEc3oA18w5+DYoSQ04ut631+PellM9xa6GZd8KCjVBL70oHz9aW36YImLa8P9+RVnK2dJKZvoFXiaxaly4flHzdsDQHOnlj3bPNH39ghQG7F/i9Dy+z/ktQWcBcuH2oIqxO/ii8DnVXmzF6sTe1pLd3g3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=CBmEiw7h; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1712577166; bh=XnOP/Yo4Ki+3xP7wAvLN+cYpAm2XEbcV9ngJZcqHHvI=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=CBmEiw7het+I/nBCvFK1K120++eabgAV16YDUplp8qcAiOsrMvqf0YorPW5pTS/4i
	 uNUY+cAbyDvjkfxkP/lXsLxXnUpOSTNa3il3AHG77S3w+TCIGF4JXJ0Ihu8A69d6y9
	 sSAUJ9UA0WMj+kUn3Lydae0Ecl+Ng3Yee15nF7Kg=
Date: Mon, 8 Apr 2024 13:52:46 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCHv3 1/2] dt-bindings: usb: typec: anx7688: start a binding
 document
Message-ID: <e6vvuttix5k5fioy7q44ick5wj6u5gleh7mht36s4zjjcym7vy@bziejyohtc4b>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <ZhPMHdt6r/4D99Zg@duo.ucw.cz>
 <ab9affc8-de68-4ec9-bdfc-02131191bc3a@linaro.org>
 <ZhPTTxI4oTF3pgrk@duo.ucw.cz>
 <e7841ad2-fa3d-442d-804d-51f12e05c234@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7841ad2-fa3d-442d-804d-51f12e05c234@linaro.org>

On Mon, Apr 08, 2024 at 01:24:03PM GMT, Krzysztof Kozlowski wrote:
> On 08/04/2024 13:21, Pavel Machek wrote:
> > Hi!
> > 
> >>> Add binding for anx7688 usb type-c bridge. I don't have a datasheet,
> >>> but I did best I could.
> >>>
> >>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >>
> >> ...
> >>
> >>> +  cabledet-gpios:
> >>> +    maxItems: 1
> >>> +    description: GPIO controlling CABLE_DET (C3) pin.
> >>> +
> >>> +  avdd10-supply:
> >>> +    description: 1.0V power supply going to AVDD10 (A4, ...) pins
> >>> +
> >>> +  dvdd10-supply:
> >>> +    description: 1.0V power supply going to DVDD10 (D6, ...) pins
> >>> +
> >>> +  avdd18-supply:
> >>> +    description: 1.8V power supply going to AVDD18 (E3, ...) pins
> >>> +
> >>> +  dvdd18-supply:
> >>> +    description: 1.8V power supply going to DVDD18 (G4, ...) pins
> >>> +
> >>> +  avdd33-supply:
> >>> +    description: 3.3V power supply going to AVDD33 (C4, ...) pins
> >>> +
> >>> +  i2c-supply: true
> >>> +  vconn-supply: true
> >>
> >> There are no such supplies like i2c and vconn on the schematics.
> >>
> >> I think this represents some other part of component which was added
> >> here only for convenience.
> > 
> > Can you give me pointer to documentation you are looking at?
> 
> The schematics you linked in the document at the beginning. Page 13. Do
> you see these pins there? I saw only VCONN1_EN, but that's not a supply.

The supply is U1308.

regards,
	o.

> Best regards,
> Krzysztof
> 

