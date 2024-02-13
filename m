Return-Path: <linux-kernel+bounces-63174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE6C852BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F6928358E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD3020B02;
	Tue, 13 Feb 2024 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="SlMwwo4n"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063E41C687
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815166; cv=none; b=pvav+Ub9uPSoYxT+/1BEh7jWfaO+XbLte/kAFRd7GWZ24RABVBZaeFFabq+3tvDi08FUbwlGvxb35XLTyBOtEuqpiac6+yHusyYVGBfeSZ82iLEKOUBp5WMlJ64plWzvV+mp12G9O0frbRw6Um8e7Wviq6LoyshF16+rpbMiM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815166; c=relaxed/simple;
	bh=HSrUZ41VNdnvYhAQ/IMyr9Isrfz3FJedb6hFHGlYTKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jbGrUZRCW36bU1VEK1nnzH4+Hc2X33hltCmjp9JpTJkjt22itZdH4HDD4oO17Ce0Nc9+qBUQlZZTvkutDdn4BNp7rmgKqv9wBc3TA/cTlVWH2LzMfbzRvXwECI1H48bGnpmDEEMamLlBpA0CnUckbt7/UaRtJJgrOZdNRf+TFK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=SlMwwo4n; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1707815154; x=1710407154;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HSrUZ41VNdnvYhAQ/IMyr9Isrfz3FJedb6hFHGlYTKQ=;
	b=SlMwwo4nhAQzaFmynwxVbAymD6XokuxWcrXhHbMTM3LGui/Mh38yj3ReNTzcdeoI
	qXvX0xY6OoLnhGKAF5I1WRPTqs83gq5hyOGxhdoAMnxkZ7iWYpT9UJciNi8PUULF
	9hObejOjRqLLTWEBuIVNIrkL+FFiruw0tsQGVGfgpow=;
X-AuditID: ac14000a-fbefe7000000290d-1a-65cb30f2ff50
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 82.8E.10509.2F03BC56; Tue, 13 Feb 2024 10:05:54 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 13 Feb
 2024 10:05:49 +0100
Message-ID: <0d8d8b85-1208-4021-b1f8-1c1c593ddbfe@phytec.de>
Date: Tue, 13 Feb 2024 10:05:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] arm64: dts: ti: k3-am6*: Fix bus-width property in
 MMC nodes
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>
CC: Judith Mendez <jm@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Francesco Dolcini
	<francesco.dolcini@toradex.com>
References: <20240213002416.1560357-1-jm@ti.com>
 <20240213002416.1560357-9-jm@ti.com>
 <c6ad3a3e-330c-40cd-8e25-fd259fd1e398@phytec.de>
 <20240213081953.GB3810@francesco-nb>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240213081953.GB3810@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWyRpKBR/eTwelUg2lzzSzW7D3HZDH/yDlW
	i7tLfzJavD22ksni04dMi+WfZ7Nb9L14yGyx6fE1VovLu+awWbz5cZbJonXvEXaL/2c/sDvw
	eGzZ85PFY9OqTjaPO9f2sHlsXlLvcfzGdiaPTa88PD5vkgtgj+KySUnNySxLLdK3S+DK6Dk4
	h6XgJWfFhLsPmBsY77B3MXJySAiYSLxr7GHtYuTiEBJYzCSxYNs6RgjnLqPEk9vTWEGqeAVs
	JJauXMYCYrMIqEpM+zCVDSIuKHFy5hOwuKiAvMT9WzPApgoLREncefAEzGYWEJe49WQ+E4gt
	IqAjceXyMrAFzAJLmSWabrcyQWzbyCixYc9BsCo2AXWJOxu+gW3mFDCU+DD7FDPEJAuJxW8O
	Qk2Vl9j+dg5YXAjIfnFpOQvEP/IS0869ZoawQyW2ftnONIFReBaSY2chOWoWkrGzkIxdwMiy
	ilEoNzM5O7UoM1uvIKOyJDVZLyV1EyMoCkUYuHYw9s3xOMTIxMF4iFGCg1lJhPfSjBOpQrwp
	iZVVqUX58UWlOanFhxilOViUxHlXdwSnCgmkJ5akZqemFqQWwWSZODilGhi3GkYej6+WsPuh
	9T2KK76msbfK57fvs4jCwPJZF6V+ypuy7te+7Ntpfm2SwcozFpfd7sxsPtXaE7bQ5GR6sokU
	v0mztLJTguXEI6v/uWXv0rQ2jbC+xP2xUmb+UaH1qcevW08Uuv7tRY0v24XShQkFclOfcRhl
	LljtbhJ4bd332iLzxTEnq5VYijMSDbWYi4oTAcDzcWiwAgAA


Am 13.02.24 um 09:19 schrieb Francesco Dolcini:
> On Tue, Feb 13, 2024 at 06:07:28AM +0100, Wadim Egorov wrote:
>> Hi Judith,
>>
>> Am 13.02.24 um 01:24 schrieb Judith Mendez:
>>> Move bus-width property to *main.dtsi, above the OTAP/ITAP
>>> delay values. While there is no error with where it is
>>> currently at, it is easier to read the MMC node if the
>>> bus-width property is located above the OTAP/ITAP delay
>>> values consistently across MMC nodes.
>>>
>>> Add missing bus-width for MMC2 in k3-am62-main.
>>>
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> ---
>>>    arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 5 +++--
>>>    arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 1 -
>>>    arch/arm64/boot/dts/ti/k3-am62a-main.dtsi      | 2 +-
>>>    arch/arm64/boot/dts/ti/k3-am64-main.dtsi       | 2 ++
>>>    arch/arm64/boot/dts/ti/k3-am642-evm.dts        | 2 --
>>>    arch/arm64/boot/dts/ti/k3-am642-sk.dts         | 1 -
>> I think you missed to update all non TI boards.
> Not sure which boards are you referring to.
>
> I would not change the verdin-am62 boards, the bus-width there is
> consistent with the schematics, it's just correct and in the right place
> IMO.

Ah, yes. Agree.


>
> Francesco
>

