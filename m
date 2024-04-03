Return-Path: <linux-kernel+bounces-129779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F2896FD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442421C26B3A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58462147C79;
	Wed,  3 Apr 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1YzI3v//"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE91487EA;
	Wed,  3 Apr 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149473; cv=none; b=DjFWMq/Kbi9m41o7CE6WasaEeZra5lKpVp92HU7Bh9U1+p1ui1T+ughYiKPOwt8Y60euIkTLQ4YcezmTvbXlVc9mLgbHF0PSeZJG7UTwU3b05DpbiRKpCdWIZg2GM9cnVZhBG1sN2qG93v0pWok6U6badRdvUCgg0xl8hFcIjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149473; c=relaxed/simple;
	bh=eDdKg+EPcfPUcnk0ccMKWaBuF1uiH7d4loF9OmNXI34=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IxCDCEd9mfcf5O+whCz4ZM0/Rn7ATqoOxLvoBNH+hV2g8/bkjuOnUBxP8PlHw141yP5u9Jfng+V4Q7iQeNiu5A4cQcWK2pI1A7/HRn5q31qf0pdNJ2mdr2Ki1ZLbhILT9LxuDDE5IIyMlfKhRwZYwfpATxyYHOSFeutqUtzuvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1YzI3v//; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712149472; x=1743685472;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eDdKg+EPcfPUcnk0ccMKWaBuF1uiH7d4loF9OmNXI34=;
  b=1YzI3v///t5f5U/69ZTjrvGyafRgpR24Ytpv3o2oZ5XBnt9v3Drt83hl
   hytTBuk3xDEyu5LnktO0pfr3hu7X0fXfBAi8+grhmYTtHB2MlHMsXPEXe
   7rX/xEuwSwZmKEO7b3WflCsBSRefDKBmW76Pbkdmbo/7m0R87v/+fzHHi
   zBr1yEFP1aSXXFkIxNhcz0YzJKeNs6OKNACmeAyclfoI7iC9GwsQfHvA7
   fXFO6jiGIfcBEfLiGWcH691MlE0Ik7dZhwsOAVgOb+EDjen/SdkGiS8oF
   XOrLKJrj9oc5G++7RMWVOfKPRkPZXLyWPM9jLLrkxCKjM3DdlJbTT5WgL
   w==;
X-CSE-ConnectionGUID: WiDwnpziQWCeuc4PBVIHSg==
X-CSE-MsgGUID: xXWRCYEhSYqjDgzsmQv5sA==
X-IronPort-AV: E=Sophos;i="6.07,177,1708412400"; 
   d="scan'208";a="19307536"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2024 06:04:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 06:04:01 -0700
Received: from DEN-DL-M31857.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 06:03:59 -0700
Message-ID: <bab4fb2c961a45a52fbc198c1c9b9d2b07d3ea73.camel@microchip.com>
Subject: Re: [PATCH RFT 01/10] arm64: dts: microchip: sparx5: fix mdio reg
From: Steen Hegelund <steen.hegelund@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"Rob Herring" <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Lars Povlsen
	<lars.povlsen@microchip.com>, Daniel Machon <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Date: Wed, 3 Apr 2024 15:03:58 +0200
In-Reply-To: <20240402-drizzly-risotto-eac556bbe95b@spud>
References: <20240401153740.123978-1-krzk@kernel.org>
	 <b3d818df8819d2fb3e96fa61b277d49941d9b01b.camel@microchip.com>
	 <20240402-drizzly-risotto-eac556bbe95b@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Connor,

On Tue, 2024-04-02 at 18:46 +0100, Conor Dooley wrote:
> [Some people who received this message don't often get email from
> conor@kernel.org. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification=C2=A0]
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe


I will also be looking at the other RFT marked patches, I just have not
had the time to do it yet...

BR
Steen


