Return-Path: <linux-kernel+bounces-136871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6FF89D943
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E9F28481C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6963212D20E;
	Tue,  9 Apr 2024 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="EbA068HJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="cd0Orsaq"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2092.outbound.protection.outlook.com [40.107.8.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D1384;
	Tue,  9 Apr 2024 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.92
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666086; cv=fail; b=h0IhZ7Zua+PQ3EWFJ8Hftjh3+uO+lkpWtYjsp6pcOd3nwiRQDa0XNjdMd7j1/e1aEjzwpM9IOd3leExWRnid8Z8pJiJNwKGGGf+/7CXchHpCpt152GvIw/s+zK7NOS23jbxb+7uLW7OgMn1FQWntrRIcBQBYjdnrrCUOCmT+6NE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666086; c=relaxed/simple;
	bh=SA+Fg/xKq9Pv9tnXwWugqUHFhKgM2DTteLRehODu/kQ=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BIwOUldU7V3Ut+3St8D90XoSasi6s+RZ9toggvgE6Yqf0u8KZHZluB+xzNXVzUBlRbzhtu2jsHbX3caHdFiwA96VI3/5w3YOynlZwuomDA11+zdg2w7hU/3N5g4WFJtBvEpa7xDO50ehMM+B4AwnTh2+siwAPY9h7LoWzvvHpQU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=EbA068HJ; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=cd0Orsaq reason="signature verification failed"; arc=fail smtp.client-ip=40.107.8.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=LY2S0AUslWsGr4k/sIM0HZp+HVu/tlWc9oupjhppMTeyrOEoQfqLruOyCMUnKa8RVa5rziZEkTnuR7FyGBMjiWl2VM3xRAq8c8327FO6zLyVjylijX1m4EUTfaGjH3wkefTgB0Jg5zrcXkJMihdDZPaVHukhmlbGyYjdRIWDlEicDXTLCzOcwKKBWHEne86RvaarHEQ9FSantkwCfRjElzDwfu8bU5K+KHtRl6YSiSr0zGs54dxjZMl1mxRs6C8lHRCWf3BSMKAf5DlXXo6whKNy9zXpaUpHCJf7y+l2iYvjHRkFrFtJI4yDRznLRBIrwREv10ttWIozo35U1gitHw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq5LiJPfIWisRA1HqlROpBdfyxVgbrerPh76/LqMsWM=;
 b=Vyxkxt0KI3bVgdDLRmwPlxti4qm3ORwe8AhNg09FWkR4ku9NPkdOsPmvYyN88kxAvbBDgCKRiBNyTRLGhhPwb/B3hHgx3MS5gBwclKYXWYSpFB2qvkSo5sRhww8lnpDGbZtwofHt6/H/a+5ANtizQCPYmJIsC4r35dqjDH2VMnG0UUYgnK9EZByC3IQhjpWlLl/7XikxoZsREb1WEu7WcZkePFzxyyQWGhzlU9Tr2z1CJlBmoPlVYuaQO7CJUgINEXxZ5I8sYCQTjRcdiDxwrveLjj0YSa/Kj/oO1aTTXhjKjrsBxy7f/z0ht4I43EXm1SDcumGtMEKS7SGmeZVmiA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=linaro.org smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=fail
 (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq5LiJPfIWisRA1HqlROpBdfyxVgbrerPh76/LqMsWM=;
 b=EbA068HJE0mUkzHRatw1cJiyw9iJ4JXiTBVSLp0n2K8WNLtihLEDxCrTN04GiZFiKB0ENKNC4JKPGTYzvJv5ItCS0DZbk97CwEIcDbl82apwnxNLMB5iZtKg+uVfjaHfGvbOZXZv4r2SKvZCVlgOUH7YnCY+rtzzdKOH9D6EFqCBab+gBHhDSHI/+hqfCCYAPVczn0JHKt+cYxaPxuI+F5t23RrOyrJOKLO9O3jNmFu0zMDoxn/J797Tiuw5NrYNqfjklQlgkC1RlqQSY3oNm5OzCkHvaOf319of1Dj05cuUPWrZNVKfQs1mgmf61Py66tndNfuqMo8uJDUpSp9bKA==
Received: from DU2PR04CA0023.eurprd04.prod.outlook.com (2603:10a6:10:3b::28)
 by GV1PR04MB9152.eurprd04.prod.outlook.com (2603:10a6:150:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 12:34:37 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::92) by DU2PR04CA0023.outlook.office365.com
 (2603:10a6:10:3b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 9 Apr 2024 12:34:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 12:34:36 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (104.47.2.51) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 09 Apr 2024 12:34:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCjfm/hLciKGdhLhSe0NRV8UW+w3DZL+sFN8GqLrl98RxN9TwTeoYXPPNsSpVY20oLLSTKdW1PiQW4DkUUnNuK17zf6VxkIz3MCZG18UZsQxWR5TO7TNF2pVb3xqzkp3qawwss9F7vjE9xJtkEeYbPRlwtWJezK3DZpIlMOeqXZ5wz06YVsY8P5nRVvTCYjylWaZ+oHBPzK81+nzojcm3qTpRFismOdtevy5ll2EN+kDqWSCu7X2D8VxODpp210w7lzRBTBnnV15Jnql+DaYSa4tPDWNE2dj2fGtdpT59M+Y4DMwJ6N4/8+IkHP66EnmnUnl3qTpSHogD9EmOnemJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDl/D6OtQW/3PFtCXh3D3kXlNarVDlqy7e1Zp3GJQTo=;
 b=arguS8FWi2iAf2Ry5wnOycRjfAr0xhWNwRhMnDF8ii8y0/zYNrj0sr3NH+KVcGup3qzq39N5OUDGhjtnNZ3F/3uCO97nyHeVUbE5CiA2uGOiqaVBwNbJup4d/41iYi+PcaMqc742wzzDWSh4szsy3OYTD/R65q6AyFZa5gqGZFZq+phEn7/TC8Hcv8n1Yl9RxGIXMQf0aa7vxd21l/XLeRjYdMls2xZgv+iYLBwRc4I73lLp0HN0g+Id4ChNFmgxibNedSQ2b9Fv/PjolhDdmIJ4Td4LPP3i3LD5AnjnByxNUhgCQhc9hB88rUzuQgn7mD5PdWck2STjycumg5GRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDl/D6OtQW/3PFtCXh3D3kXlNarVDlqy7e1Zp3GJQTo=;
 b=cd0OrsaqFs7G7G0hCa5RZXowo17Xi4H64ztsT3Lxm5bbi+RjXCfFHk70WpnYPZFiJ9l+K5RBWbdFjpASHvJ0q5eavasuz3leoQyL4jSnXMCPh6KfTXC6rop8ZZGohT8rmzwSa0mpUe6B+L14if2yQl09m8jdU99WztmYkxCbWMsVjKOm56xp4eq4CrIBq5jPbb+6dieqz4Fl3KHeRV1uVaAkgsIF/naWM+FgMrY+GBEQGzd5bGvNa8IqY5WUHjgeHRlOd7D2vnujDvz7rs5dmoWC9bRJLG6RbyV2WV2iXLGrtYE1YCWoyNPt13kohtmqtgMLny0icv5E7g7UX9fXQQ==
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8302.eurprd04.prod.outlook.com (2603:10a6:102:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 12:34:30 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 12:34:30 +0000
Message-ID: <3ff7ab51-b671-4a77-9abd-f4683fcc744d@topic.nl>
Date: Tue, 9 Apr 2024 14:34:29 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: ltc3350-charger: Add
 bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-pm@vger.kernel.org
CC: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.3bc97c8f-843d-4e46-84f9-469b7ba2489d@emailsignatures365.codetwo.com>
 <20240408064905.20298-1-mike.looijmans@topic.nl>
 <a4a9f949-ecc7-4603-8c8b-90a1e309570a@linaro.org>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <a4a9f949-ecc7-4603-8c8b-90a1e309570a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::7) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PAXPR04MB8302:EE_|DB5PEPF00014B9A:EE_|GV1PR04MB9152:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 KkHl9Xjkg/zEALNHNJE9P5Abpasc2Hyw0HRiWIi0pZTjHr6PL4G3XMETytTwSFnuKBRNJfvjo6EUIISNN1bwFJPhWcOwxWspxrX75xbMH1WthvyiZPaOgwTl4i67iTTGxTpl32/k1pB1Jr52OSOjs1q1iVArio0a74tjwG4y4Lm7Nl8Gp+OqCwQMA1uEfkkScZID2ptgd/ouypOy4hUfCXwL4D3ZqAl4h+6vSm0HVXZeRc6r1KsjbepJbxtl4/Is5m4x8pVJNtfBnKoM/OM6XboUj+ahpCmkPWlwGfedhFuRK7hTlxw+CxAKHOj3Jq2BOeUogVSU80kF8r/kNWqKuqgRbpBflu5MhBgmqg9vEdy71dP3YoEFenlhtrqsln/YUI0c9TMSkWCihoA3ghi90byFriQ4LY+3dSRFg00kS5FgPGhmw7T1kqHysUwcAFA9Uq7+Rzw4uizKUpOsoOVqzOggrlHGAN6RW/+qCJiuW2gbu+0cGq8Bcb8DyMJZCNwHJ+vfhHhZkMajMVk4AHkXhoXwD6gQRr0AZjcvnHK/KfdxyzwohbTo3JIXHvOf5PGMPfM2EzMj+i89u7B6c+cYHz+cx2DrpkLJ7JsquTXyK7iWGj2+NTXWTL4ATLXj201VK7jlKxNPHN0uwxEMFkYFBLGwv1z6il2ZyRurNttB7Nc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8302
X-CodeTwo-MessageID: f0f6f95e-04a7-49dd-bdbb-b7c5cf7be4af.20240409123434@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bbeca07-a488-41bf-3d29-08dc58916ad8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N33Dex8qwimty8y1PPH15Q0xRcm6jufimzRZPpxxiGrnTbJS5DLfo8bAn+XF9XmGqixQXm6P0YEf6NIgVSXYcxS8Sg/BCyrA+c8t7kmr7gO0S5iFMo8+pdY5TsPyyNxCvXEeonlM1Q+NJdEoptkmQzbFrmMCD2R8veItDSkNevz7CU5dlcZThAdNIcQIBYffGRLaWacGyBCtAu8GIDSob+EaOxXKBvI76yW+BcJNuKO1jzo4gbgjUwg770V7imfLhOA8ryIgWFjviqFMk+d8SMDojHC+QUGL48DfaescjIOJShNcxsj7Y/UqmFYft+/i+mgfpODP2e2lT2FrA2BbdRWoJYF4YawkmkyxBzlZgMx/xOAleZRDwX+XwXuVMWLoRLBTwgsqM3BTZ7XvUVxipyyjiRNV0svmAlUieNv1evIwQz9RZIvEdkQ9HX4+ye3ykBaHGglPzNi3qoJQ0PhzfdmdtetLh2h5eC6Jaao3tg5/ZDzyVYK+/lzRQnRG6YnSqoIg9pHDHMzTap+tZWj5+qz78hdHPA54lmHXKrnBypMrvcj5a9dsw42JyKoLsKlDWT0oDe3xGkpJGIklT5aI/iZiCmYxjqQeQmN4j4mM4hhX+XRTglxhj6fXR/wGfwbrxU5j/W8QEi45GzGxnDmczzLC0+mpu1SVRoZASMoGFl4IpiWQSw4fw/0MgtXTSpe9/wVjhmM7cOQUXIJZUu169g==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 12:34:36.4107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbeca07-a488-41bf-3d29-08dc58916ad8
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9152


Thanks for your feedback. Will fix them all, except see below.

I'll send a v2


On 09-04-2024 10:27, Krzysztof Kozlowski wrote:
..
>> +
>> +  lltc,rsnsc-micro-ohms:
>> +    description: Capacitor charger sense resistor in microohm.
>> +    minimum: 1000
>> +
>> +  lltc,rsnsi-micro-ohms:
>> +    description: Input current sense resistor in microohm.
>> +    minimum: 1000
> Looks like it is shunt-resistor-micro-ohms. Unless it is something
> different?

It's a shunt, but different and there's two of them (akin to the=20
ltc4162-l which has the same property with the same meaning). One to=20
measure input, one to measure charge current.

When the datasheet talks about "shunt" it means the resistor that can be=20
used to balance or discharge the caps. So I'd rather avoid the word=20
completely so users aren't tempted to put the wrong resistor value there.

The datasheet uses "rsnsi" and "rsnsc" whenever referring to these=20
resistors.


..


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




