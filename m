Return-Path: <linux-kernel+bounces-24742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC9E82C1AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C3E1C21CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309E76D1C3;
	Fri, 12 Jan 2024 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ME1AYTsv"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446C6BB45;
	Fri, 12 Jan 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CEPcfP087825;
	Fri, 12 Jan 2024 08:25:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705069538;
	bh=vrIOR55d4f+zfTazwATsPkDxflsXmVUUyKRUlABLwvg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ME1AYTsvVj3lKj9pYvLghfQ+lD9PzIZLGhBDfKBUCivY8xPfTe6SoGYa9I5/g4Zkt
	 IWKiKAe+kga5wit/ikFBY84ECh6uJfDIeHIRjP52o2VeVwpLtDlhFKk03u4tqE8/fh
	 viMXw0uGjV6gS6Rji4FaZg3UJihU94LW94DvRs+8=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CEPbCg100103
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jan 2024 08:25:38 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 08:25:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 08:25:37 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CEPbwF030055;
	Fri, 12 Jan 2024 08:25:37 -0600
Date: Fri, 12 Jan 2024 08:25:37 -0600
From: Nishanth Menon <nm@ti.com>
To: Sjoerd Simons <sjoerd@collabora.com>
CC: <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@kernel.org>,
        <kernel@collabora.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-beagleplay: Use the builtin
 mdio bus
Message-ID: <20240112142537.axjy5risfe5lpnqc@quintet>
References: <20240112124505.2054212-1-sjoerd@collabora.com>
 <20240112135000.b54xz3boeua7y2jf@music>
 <2ce27ed917b9bd569ee4a7f87b3d9b78d07cecbd.camel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ce27ed917b9bd569ee4a7f87b3d9b78d07cecbd.camel@collabora.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 15:20-20240112, Sjoerd Simons wrote:
> On Fri, 2024-01-12 at 07:50 -0600, Nishanth Menon wrote:
> > On 13:44-20240112, Sjoerd Simons wrote:
> > > The beagleplay dts was using a bit-bang gpio mdio bus as a work-
> > > around
> > > for errata i2329. However since commit d04807b80691 ("net:
> > > ethernet: ti:
> > > davinci_mdio: Add workaround for errata i2329") the mdio driver
> > > itself
> > > already takes care of this errata for effected silicon, which
> > > landed
> > > well before the beagleplay dts. So i suspect the reason for the
> > > workaround in upstream was simply due to copying the vendor dts.
> > > 
> > > Switch the dts to the ti,cpsw-mdio instead so it described the
> > > actual
> > > hardware and is consistent with other AM625 based boards
> > > 
> > > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > > 
> > > ---
> > 
> > We have had issues with the ethernet integration previously (also why
> > ethernet in u-boot is not yet functional on beagleplay[1]).
> > 
> > https://openbeagle.org/beagleplay/beagleplay/-/issues/101
> > 
> > we should probably do a 1000 boot nfs test or something to ensure
> > this
> > doesn't introduce regressions (I recollect mdio wasn't stable on
> > beagleplay) and switching to bitbang driver stopped all complains.
> 
> I can do a longer test with that over the weekend sure; For reference
> I'm seeing issues in u-boot as well on initial probe with these
> changes, but i've not seen the same on the linux side.
> 
> Do you remember with what kernel versions users saw the mdio
> instabilities? I wonder if that was a version with the commit mentioned
> that includes the errata fix for the mdio driver.
> 

we were on TI 5.10 kernel (the image that went into production) and it
did have errata fix (I am not sure if it is similar or same as what
finally went into upstream now).. I have started an automated multiple
boot test on my end as well..

The signature as I recollect was spurious link Down and Up logs
(though the cable is not physically disconnected).. been a bit of
time.. so my memory on exact signature might be vague.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

