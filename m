Return-Path: <linux-kernel+bounces-23713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD482B0AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC0928727D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF953D3AB;
	Thu, 11 Jan 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NhAGUF3f"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB123C092;
	Thu, 11 Jan 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BA26F2006046;
	Thu, 11 Jan 2024 15:27:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=wTVjmGwYeV5sAYER1puGnO1qZuq5/BoWjcAmcf+ualw=; b=Nh
	AGUF3fPYpTsl7KrzeNza89HbQL5gIOWEJu4JgU4OsDIdqfk5iPWv+L8iCA5vdmaw
	aSu0ZLbk6oP4EYKRL26SirDEN2eH7SVdog8UqvXxvMh8fFfRCe8nLaasV0JbIK3P
	KEsUG8bz62RV5fbPSS8krfWb3955BZX/zdco9Gue5dTWpbvOFyesF4WGYMXGSmTy
	N8/XX/UC0XtT+pldsoQwjGG8GFCojFgw6k55uFkHc6CsosqCIr4b1BnuNEbw/jlG
	R98GfhMueBKa0HPQ+1YCoXF2UerVAZLhMZ47P0yb/VBLzNWJyhY8bITnyHGIfp3s
	0uvB0cu1lUxcJ1V/mfjw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vexrcdgku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 15:27:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE0D910002A;
	Thu, 11 Jan 2024 15:27:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C09EA27DAAE;
	Thu, 11 Jan 2024 15:27:55 +0100 (CET)
Received: from [10.252.29.122] (10.252.29.122) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Jan
 2024 15:27:54 +0100
Message-ID: <a0888e25-4427-420c-a14d-d6504440805c@foss.st.com>
Date: Thu, 11 Jan 2024 15:27:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] ARM: dts: add
 stm32f769-disco-mb1225-revb03-mb1166-reva09
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-amarula@amarulasolutions.com>, Lee Jones <lee@kernel.org>,
        Andre
 Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert
 Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?=
	<l.goehrs@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Michal Simek <michal.simek@amd.com>, Rob Herring <robh+dt@kernel.org>,
        Sean Nyekjaer <sean@geanix.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240111113146.16011-1-dario.binacchi@amarulasolutions.com>
 <20240111113146.16011-6-dario.binacchi@amarulasolutions.com>
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20240111113146.16011-6-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02


On 1/11/24 12:31, Dario Binacchi wrote:
> As reported in the section 8.3 (i. e. Board revision history) of document
> UM2033 (i. e. Discovery kit with STM32F769NI MCU) these are the changes
> related to the board revisions addressed by the patch:
> - Board MB1225 revision B-03:
>   - Memory MICRON MT48LC4M32B2B5-6A replaced by ISSI IS42S32400F-6BL
> - Board MB1166 revision A-09:
>   - LCD FRIDA FRD397B25009-D-CTK replaced by FRIDA FRD400B25025-A-CTK
>
> The patch only adds the DTS support for the new display which belongs to
> to the Novatek NT35510-based panel family.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
Hi Dario,


Reviewed-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>


Regards,

Raphaël


