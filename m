Return-Path: <linux-kernel+bounces-29944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1806983159D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF58286819
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554D1BDFC;
	Thu, 18 Jan 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="HJg9pC/o"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F151A279
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569427; cv=none; b=ar4uXjr23nmo1z1Cx/OrERjo6r8OAOtXfvlqpEe3RC2TuYb0EsJmTT8u3nKNe9aYUtgAhA+kXul3EbNqg2JdRmCX3l0SWMQou3N7wBdj/vEHJec8xYkKraGHuqOAvWfQ25V4+vvDT1nZaUi/Z0hUZpHdJ+QD5mxhTS1I/fArQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569427; c=relaxed/simple;
	bh=lVkjC/ZLl8R8eZuIiDN/2uM+qjLm5gj/0S4GI1CxecM=;
	h=DKIM-Signature:X-AuditID:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Brightmail-Tracker; b=QbqbMUHPt65XVDPu9TRTpD+eTwL90Dp/po3oki4jQKYVrsOvAaBRGSMCenNmdCMa0d0K/oczAhU4CyA/7OAQJXx/clYgjASa+L6DfI6dUZGl8D6Li1QsOZ+TknN/cfaIHim6nFnTo0ST/+MyC14CXLFuav7kGMvHVmz8954SXiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=HJg9pC/o; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1705569413; x=1708161413;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lVkjC/ZLl8R8eZuIiDN/2uM+qjLm5gj/0S4GI1CxecM=;
	b=HJg9pC/oK/5Z6z4KBLX3Bn1XB49OSt6HEY73Qf9j9wbjwxI29Dd/xokm/0Brsqko
	WmE3jyWzHTtoddLRdbR9wq26cpsvaFNDIRWZrUV7TxCwFuRo4GtziVUEr2PGrCFs
	K+1oCwbXvXU/tTpwYXr8ElIV+2ts0KYuXRf4mjU7Txw=;
X-AuditID: ac14000a-fadff7000000290d-df-65a8ec851e3a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 91.A4.10509.58CE8A56; Thu, 18 Jan 2024 10:16:53 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 18 Jan
 2024 10:16:53 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 18 Jan 2024 10:16:53 +0100
From: Wadim Egorov <W.Egorov@phytec.de>
To: Conor Dooley <conor@kernel.org>
CC: "lee@kernel.org" <lee@kernel.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "miquel.raynal@bootlin.com"
	<miquel.raynal@bootlin.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>
Subject: AW: [PATCH] dt-bindings: mfd: ti,am3359-tscadc: Make dmas & dma-names
 optional
Thread-Topic: [PATCH] dt-bindings: mfd: ti,am3359-tscadc: Make dmas &
 dma-names optional
Thread-Index: AQHaSVgzUZ+jpApWjkav8+Rj3OKhUrDfSofH
Date: Thu, 18 Jan 2024 09:16:52 +0000
Message-ID: <759974970efd4042989e5ffb77c129b1@phytec.de>
References: <20240117052104.747333-1-w.egorov@phytec.de>,<20240117-moistness-directory-e3dc0cd1c7c0@spud>
In-Reply-To: <20240117-moistness-directory-e3dc0cd1c7c0@spud>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWyRpKBR7f1zYpUg01LRS3W7D3HZLFy6io2
	i/lHzrFa9L14yGyxo20hi8XlXXPYLA6372O1aN17hN2i+526A6fHvDXVHptWdbJ53Lm2h82j
	v7uF1ePzJrkA1igum5TUnMyy1CJ9uwSujNsPVAvO81QcfNXH0sB4i6uLkZNDQsBEYtmS06xd
	jFwcQgKLmSROn3gN5dxnlPj55wszhLOBUWJRbx8zSAubgLrExL8nWEFsEQFliStrZzGCFDEL
	7GOWaHn/HKxIWCBSYtKvKWwQRVESjW1T2CFsI4m9fxaDNbMIqEo0Lr/ICGLzClhIPDjxlKWL
	kQNoW6bExfn8IGFOAVuJ47dvgI1hFJCV2LDhPNh4ZgFxiU3PvrNCvCAgsWQPRFxCQFTi5eN/
	UHF5iRO3pjFB1OtILNj9iQ3C1pZYtvA1M8RaQYmTM5+wTGAUm4Vk7CwkLbOQtMxC0rKAkWUV
	o1BuZnJ2alFmtl5BRmVJarJeSuomRlBkijBw7WDsm+NxiJGJg/EQowQHs5IIr7/BslQh3pTE
	yqrUovz4otKc1OJDjNIcLErivKs7glOFBNITS1KzU1MLUotgskwcnFINjNH6V3naJEPeKkyf
	naUvzddRPtHF4a3A/Y6LR1g3avedZToVEZC/40DJxzufT3c5Fc1iLmRkub+875l3zfMzHwwP
	qqh18ezV2Tsp/UzV/SSzGfMfeGxtPW01Jcjr+izXnVWNPn9j1V8fNfm+b9mRgB/zjp26Yp8S
	wimQnsXQUtjI8U5K0ORjnhJLcUaioRZzUXEiAN7w7we6AgAA

Please ignore, a similar patch was already accepted

https://lore.kernel.org/linux-arm-kernel/20231124045019.21003-1-s-k6@ti.com=
/T/
________________________________________
Von: Conor Dooley <conor@kernel.org>
Gesendet: Mittwoch, 17. Januar 2024 16:16:45
An: Wadim Egorov
Cc: lee@kernel.org; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; =
conor+dt@kernel.org; miquel.raynal@bootlin.com; devicetree@vger.kernel.org;=
 linux-kernel@vger.kernel.org; upstream@lists.phytec.de
Betreff: Re: [PATCH] dt-bindings: mfd: ti,am3359-tscadc: Make dmas & dma-na=
mes optional

On Wed, Jan 17, 2024 at 06:21:04AM +0100, Wadim Egorov wrote:
> The driver does not require dmas or dma-names to be configured for the
> ADC to work properly. Remove dmas and dma-names from the required
> property list.

You say "the driver" - I assume that this is the linux driver. What
about drivers for other operating systems?

Thanks,
Conor.

>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml =
b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> index 23a63265be3c..70b5dfce07d2 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> @@ -61,8 +61,6 @@ required:
>    - interrupts
>    - clocks
>    - clock-names
> -  - dmas
> -  - dma-names
>
>  additionalProperties: false
>
> --
> 2.25.1
>

