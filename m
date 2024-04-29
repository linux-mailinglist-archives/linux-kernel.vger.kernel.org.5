Return-Path: <linux-kernel+bounces-161819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062FD8B51A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3481F21118
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1206D1400B;
	Mon, 29 Apr 2024 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cXEUreo7"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1B125AE;
	Mon, 29 Apr 2024 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372939; cv=none; b=WpyK4Mmuc4AxXALz0jQvmfGJapvyZfeg6aQSfJgIg/jTzh0gpbv2zEO0YJowkgilHdbfxdy0uE3n3GPRtCcscF4KM6cOx/wyo/6z4I7d+GAxgpUVLXmDw74V8WxANHMgxfnfP4CaQVBylvq5jYKoxN3rharRx2egXJXqKEskWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372939; c=relaxed/simple;
	bh=8jsgvFEERJihQU96KoTLfBV7WFVGszlFf0yD0+61nXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uHWLJcdMx3xfmH1xi9CNpE4OUjRvG8M+uFtI8aKumd1QFvc4Zi0LH8LGISuu4wxruyL91FxXzLanzLQtzKbKOtT1d+W4eccrtj7FBsXq7n5D84Mh4pSZsx1PWtCjYUzetL01/VMM8rHTq/3GR7plzpiGH4KjYJz6dpwYRU9gZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cXEUreo7; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43T6gCEc066719;
	Mon, 29 Apr 2024 01:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714372932;
	bh=8jsgvFEERJihQU96KoTLfBV7WFVGszlFf0yD0+61nXM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cXEUreo7MAFBL1gZf73zes0ZScVL2y1YPO3Sup6sTrbDFdbbf/QyLD9ucPKXb8PK2
	 g0GSJKbHP3qXDax5GJz1XCEWaLRE8PmtPiVgWW8OwQxi/UKLr2r/odzYjhuo+Y/QXo
	 wvg0jqnvA3Y2gQrRGMO4IUci0AAo0uTVR3WNyPLo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43T6gCuW019347
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 01:42:12 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 01:42:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 01:42:11 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43T6g8TM111797;
	Mon, 29 Apr 2024 01:42:08 -0500
Message-ID: <4b3d2578-06ea-4feb-aa31-3968063953e8@ti.com>
Date: Mon, 29 Apr 2024 12:12:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am625-sk: Add bootph-all property
 in phy_gmii_sel node
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>,
        <s-vadapalli@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240429061600.2723904-1-c-vankar@ti.com>
 <c17d8123-e9cb-45b5-84df-9fe102ddeddc@kernel.org>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <c17d8123-e9cb-45b5-84df-9fe102ddeddc@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 29/04/24 12:08, Krzysztof Kozlowski wrote:
> Are you sure you kept proper ordering of nodes or just stuffed this to
> the end?

Yes, I added this node at the end.

