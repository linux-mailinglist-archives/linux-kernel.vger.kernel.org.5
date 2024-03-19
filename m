Return-Path: <linux-kernel+bounces-108066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CDA88057C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA37283557
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E273A1C5;
	Tue, 19 Mar 2024 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WKGO0nhG"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF5A39FE0;
	Tue, 19 Mar 2024 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876769; cv=none; b=XVfAuNtUpembcZ1yyQTMHTdx5rEvoX68VkLAuGVo57JZshXkDaDp2e5gLHzXZckrZictQoixWVlrdN5NSDVdsT0D2HZYwxpWvSF5U5M3HZ6YxJw+IW9P+T0e2kM/XYwmsx7090upM8TiiCSs+Y4Ty6kDzIxjqFJOGujous70Lvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876769; c=relaxed/simple;
	bh=bP1qlyOG88O5FIK8qk2VLScBc9y3aMAR1attNx5WHCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbvQARyUredJefko9PwCq2qudwNoEkGinXZNZ+5GcwBz/Yc/CvdEkeWfTCEcHKv2mXFHXIcc7bpML1IzIWHCcDGApf0V/aVEVBarYUzWxeju6cqLIqRXpsmy89KMUR87pb2JH6e/jp2gTzjzMs+PXX9JofswLfpshxpAS1oEiCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WKGO0nhG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OO7uML1Z2PdYpEH6GwB/4xv+t93363Unqf1BF9eTMPE=; b=WKGO0nhGrYwmy2NQqzHnFyuENl
	4tU0RnWs/u4b3pq88sqKVy5BJQcetyfl8xcX++bePlFOKEhc/zfKaJok18lfkVdUNZEHjnm/JjNeJ
	vLEyRsY5RlcgCCGyiTUtGTeHYdZ1tF6GKNVcXXazOXE8kEcajhorO1yKxQVr/8nHroC8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rmfCL-00Ajh8-Cv; Tue, 19 Mar 2024 20:32:33 +0100
Date: Tue, 19 Mar 2024 20:32:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: Vaishnav Achath <vaishnav.a@ti.com>, Michael Walle <mwalle@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	open list <linux-kernel@vger.kernel.org>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, lorforlinux@beagleboard.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
	Vaishnav M A <vaishnav@beagleboard.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Message-ID: <f53cd006-5eb0-47f2-8f84-e7915154f12d@lunn.ch>
References: <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
 <0f3f56d4-3381-44f1-91bc-c126f3ced085@linaro.org>
 <c8031e17-5ae8-4794-8b8c-1736be6452d3@gmail.com>
 <CZXMK3W52AFO.1APK080GVJESK@kernel.org>
 <5a9b1cd9-05ec-4606-92b6-eadbc7af6202@gmail.com>
 <CZXPQZY8PUGE.QZM8XSOUNMT4@kernel.org>
 <81ec4156-8758-406e-876b-5acf13951d09@gmail.com>
 <CZXSKOLK6S1S.N86E2AZG2V90@kernel.org>
 <2eec6437-dd11-408d-9bcb-92ba2bee4487@ti.com>
 <28c995cb-1660-435f-9ee4-1195439231f0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c995cb-1660-435f-9ee4-1195439231f0@gmail.com>

> Yes, after discussion with Vaishnav and trying to brainstorm some way to do
> the same thing with dt overlays, it seems that trying to use dt overlays
> will mean need to have completely separate implementation of mikroBUS for
> local ports and mikroBUS over greybus.

Could you explain why please?

Are greybus I2C bus masters different from physical I2C bus masters?
Are greybus SPI bus masters different from physical SPI bus masters?

> Additionally, trying to put dt overlays in EEPROM would mean they
> will be incompatible with use in local ports and vice versa.

I don't think you need to put the DT overlay in the EEPROM. All you
need to do is translate the manifest into DT for those simple devices
which can be described by the limited manifest format. For more
complex devices, you use the ID to go find a DT fragment which
describes the board, and skip the manifest to DT transformation.

	Andrew

