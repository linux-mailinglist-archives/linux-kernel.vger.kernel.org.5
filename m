Return-Path: <linux-kernel+bounces-19887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83682763A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9188B1C228B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0584E54672;
	Mon,  8 Jan 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bQ2o5NeC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2075465E;
	Mon,  8 Jan 2024 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 408HM1KT113925;
	Mon, 8 Jan 2024 11:22:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704734521;
	bh=E7eWPFddByOeMt7UVW2EkJOA2jFds+EnthHgXdFdU3Q=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=bQ2o5NeCCj6bOH8tTJKuDMVemOhymoaLA7/S4pSRSqo5EBIM0JUs3EP8Uh4wD+8Uj
	 jR9RYZ8PKy+x77Wkrn4xaC/HFeJn/U0WyCcdjUDTMhXX/qxlS9JHjIWbbyY/AdhWT8
	 e0NsQu4UcZZzGqbDKwB31osW0r2ENFqMmx3K9txY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 408HM1bi000351
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jan 2024 11:22:01 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 11:22:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 11:22:01 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 408HM1v6030676;
	Mon, 8 Jan 2024 11:22:01 -0600
Date: Mon, 8 Jan 2024 11:22:01 -0600
From: Nishanth Menon <nm@ti.com>
To: "Li, Hua Qian" <HuaQian.Li@siemens.com>
CC: "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net"
	<linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "huaqianlee@gmail.com"
	<huaqianlee@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "Kiszka, Jan"
	<jan.kiszka@siemens.com>,
        "Su, Bao Cheng" <baocheng.su@siemens.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: ti: Add reserved memory for watchdog
Message-ID: <20240108172201.pifo74t23deuq4vr@cresting>
References: <20230713095127.1230109-1-huaqian.li@siemens.com>
 <20230713095127.1230109-3-huaqian.li@siemens.com>
 <20230714225240.dvlwqaodp2l3cczm@disfigure>
 <AS8PR10MB6993F047652F40675BDA689D9F6B2@AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <AS8PR10MB6993F047652F40675BDA689D9F6B2@AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 08:16-20240108, Li, Hua Qian wrote:
> Hi Nishanth,
> 
> The maintainers have picked up the driver and bindings, as follows:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29057cc5bddc785ea0a11534d7ad2546fa0872d3

Not sure what you want us to look at here.

> 
> Do you have time to work on the "DONOTMERGE" dts patch?

If the binding has hit master. please resubmit from the closest rc1 - at
this time, see if you can rebase on linux-next or wait till 6.8-rc1 is
tagged to rebase and re-submit.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

