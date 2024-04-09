Return-Path: <linux-kernel+bounces-137026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBC089DB4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E141C2095C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187DC131E38;
	Tue,  9 Apr 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="OsUHF8XD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="MaFnBsGh"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2134.outbound.protection.outlook.com [40.107.20.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE97113281D;
	Tue,  9 Apr 2024 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.134
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670617; cv=fail; b=TnUjra/alEGdmrR10ce+2mvrZ9q3CItAefRl/KYkMtpfw5aYPjvDZ7xIkj4szZ+hZPeV/x12crnhqH4GZ9csESOsIWxsQn4mQB9U/ckG+5sGc0NKzKvjsPV/8PsQ5F1inwViOwajARghKk9rZqzldv1rD1o70yALP3xzaOIGMzA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670617; c=relaxed/simple;
	bh=26+JnhS/7gZYFsDPOjzU35Fo0JuMocwli6/ri+iTnoI=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b4r59ffsRt5UJx4rD39Bun+QSTOdlH69oasExFqkfe6J5FpAOPaQPIcMQlqn4iQd41iowU8dJ3b1Ot/PcV0MdYdV09WIBVmw/DkRt4Gm/Vy0sfMSQo4gE9LjcM1lAZokgtMeNlKf3JN8WgFbgD2CaWdD2k84mcPJ9xMArmP/6gc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=OsUHF8XD; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=MaFnBsGh reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=N3FWw0kVAEStqzXFC46NKWE90fVteezfBE9A6wf4bgJToIYTXxrS0i4w2Du2KTVY3clqixw04HIU1ux9gOAhoxFIyIo0Qfa4ZEs8cFQ3dgkwhYPdLOzFt9PUh/MpltPC8yXWuNSIVpnTuOjA2ALPmR91+AVPGc8+UoWaXmDCXbP1ow5HGa8RCdRBVT3r1GzMEFAkG8QqjkmsmBmNXXvHuflGi1ro12HSnh3X1sJR/EGqKdZbwSw9HqoWljfl8RG2aIPCHkMp8LjBgZbAdq7eCAPZ0NxtPMYpDVLAuCU/LffE81LsUHBv1/9umuOmhSH/J1CnH5aIYu42fbyWAlvX4g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtKzJNyj7XldUvX5QrCxAK82ayPEG+/vmxREJEzfJQE=;
 b=AkaIglxoBAWCzIEADFRGK7Yb6bC2ex7ybrS+xYfu6JzWtvsAgE3beN21KyRM8szj72KOOwyFvSGYGP61S2DbjzXy2UPreRg+XSiBi8q9ZjXemdWZ2VqaXPAuL0oFkD/CKdWtw+QhTpUwWrl20zwa8fJ3lgCfMiZmRqvZX9y2aT/iZqjho8fHdwrX5rGbb9Or5oAhIba1pfTd8igq8+2s1I7LH2nfNZJds1ulcePpKVf8aVhJ4xefhK4XUQFlBscikVZ+WRNdMf3ZUZuZ/5cb176wAIOUnAbtd7hdAgC0Ls7U60MzErS2ZVRXb+EMVW0RI+C3LOG8vDaGuiHURuZM7g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=fail
 (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtKzJNyj7XldUvX5QrCxAK82ayPEG+/vmxREJEzfJQE=;
 b=OsUHF8XDumpTGi+g6sZe0OibnQ7oJ7ui4dBNiyAScWpIsKB/NZaB0MkQdhr3uESIzNpVYa/rlZ574rUZNATI7X/s6/5j6W8tMI5qRGAaS5NrFm1naE07oFcUA/LxTXzO7dTnXjLrIwN2oUKD0IIfks1FssycvgOzdt9v4fmwF/8qWAf/xVh7eEanx7pbVybfvJyIWSAm7t7qe3v9+/AbcfuK2oC/9M9eRysEbw9fC/mTj24UtTUtZUmPASPD4YUFtG3wnXP17TS5Q9++nzYvWZ98BbMEYFg7B2fK/uSSquKNdO2y9imiZ1WllV829KMms03UYMUBPQu1SS+lsbjR8w==
Received: from AS4P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::16)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 13:50:11 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::25) by AS4P191CA0030.outlook.office365.com
 (2603:10a6:20b:5d9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.30 via Frontend
 Transport; Tue, 9 Apr 2024 13:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 13:50:10 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.51) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 09 Apr 2024 13:50:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecaT8Ji61g/7VpgAKCfGylIsoX7itQroJlBM6cbA3FYrnTfPNWswwIRTw7SfYoywihBA3qY2mzXtHJtLT4lgMPdtEddx8bpEHf0b90XaM60UDF90WE7q8fDRssroEshtmzJUCRcpKuBCVA9Crt9xiOYHDXm33OBbpw/4lztiYefARA6thJJKqAnOlMtnzatRbDZCxTEMDf9DvrkCo5PNAs5vNZInEwpYnlN/hYr486FJYfTcn6qJPSFmgPD90la1Ybf9rACrDiauTSwqHBsP1toA35bB9C4BGo/Vrvf8ox2iQSLH5nyIjZljrYZoVaavlu/5lpMZAAufSKp/CviRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17Jsg2MKI73qQSgFthm6IxVXV6lhvc2pRy/Yuc1AIuc=;
 b=LlL9h6hNhjoP3NQKWFJYWTt5UUtMc1nsn/G3JLze1DqnbYNdXdUkmrbx1CZcdq2XX163n6upunpMQn0x870pu7ZrDgbgGqhANcZHJ5hts4YsFD8yxbMKCMNd7Nzz/+FNcDk+nFfSFjrOOygVplLRdPgpAXE1QgwRlJnog8scHB2XI3AKrUoi1JW6H7IZHEddSViYdZlS5EE2+qX/jZBIHzjw1PNvNvgUBjeyndkI0BGHDnPEmHjVmDMAEIfu+xVayjT7eAZpRhxWX97fUlp5e8C5hajsCUO3Xh+/yc1NaejKZBtr5ocXgpM3/4LPl2Xtkl1h9GDa383UCNB4z8Ifmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17Jsg2MKI73qQSgFthm6IxVXV6lhvc2pRy/Yuc1AIuc=;
 b=MaFnBsGhbSj79/P0JQIWCG4jGgFsWfEapHIbxu1K3i5aL8lza8NpWCFyZjAjnqs7UJp1TIn3HdfFaZa1K6gbOHEHQIRJ0GCDN+iBt9CpF8jb4OmcnjWlXMiravFpLU2aJNlCKeQONd4xmHcktHp1asLGH2LMpELwu7DbhmeZy+rdeGFGrA0D8f255avM1a/9VvuONZy9rjpeR7+E7Qq6APcp8/7PUEhhaIaKHHURmrhGD0RkTcie7BQbf3p9X767riCP9KUOXEF31a0WrhFs7+OK+L4NXke2d/mrAkWFLrnbdFg68jOV/aIQaBNUX+DcYO/dzu5KUahYGL03R4KJRA==
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM8PR04MB7265.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 13:50:07 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 13:50:06 +0000
Message-ID: <ea1aca25-e1fd-46ec-8268-f8322746ad6d@topic.nl>
Date: Tue, 9 Apr 2024 15:50:06 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: ltc3350-charger: Add
 bindings
To: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.67250ca5-6a79-4048-b845-3d240ff83a75@emailsignatures365.codetwo.com>
 <20240409123556.34299-1-mike.looijmans@topic.nl>
 <171266946179.1029796.4237832991239731761.robh@kernel.org>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <171266946179.1029796.4237832991239731761.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR03CA0098.eurprd03.prod.outlook.com
 (2603:10a6:208:69::39) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM8PR04MB7265:EE_|AMS0EPF000001AC:EE_|PAWPR04MB10007:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 oQI2mvSgSI3CQewY7moFjGys22CET9HmTDy/wecuKV8BPXN6PQwdBgw3nBWmsYqZ8KtxolM2HUKvHlh5rYQXu9LrRDb6kDh4DaJMWenmwve6KHjQKs9YhubvZkeanS6yPrul7i0maI69XQFG7jyDrwUkCcviV6QgU+Yi1weP89NYCo0AdYa4PIcoRpn2NTfHOi65csPAG89Y8UopqGLBXH9BYXOY1v9yS9rNDTPjkMMqYzOiQqTLSBJmapxNfevXvROn7sDoBiZhtsaHJt3vpOfQPgdpQaYsxOwLOz5nPiqfGwkXFr/q00zYHK3ZKLlrglv2RQvmGA9Klqif7LMt4C+RZvrsLKl1rvgP/ZLh07CLP12CFLre3jd7ziBwOZ1KtlbT5KzYntaZNSwLKe52XsmG7oSt1UNAEu1/qOPx1WMVvnFjfbm6udnYCrqU9xvZ/KJDRD2LAkgXV/2uf/S6X+ZAN3M+QZzmqU5KHg9e7eQefanwcEdP/kBZ/7S0QXM8PEzpIphJ1zEUSNYCxnPq6ST4ErlDN6S7cvC6PPElBN6HSj1ghM3AHjd1498pCRBLejYDmghIQz461Y2ZLLD+JD2e2QB+6W5vnUdEKbqlI3k75vaoymZYssGOKJ3kev/kX/ZTYB0FrUyZFDfwujrVO40tV3DDS09olmzxdSiSwjE=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7265
X-CodeTwo-MessageID: 3ebaf344-fe19-4fcc-b5ca-683eedcf8014.20240409135009@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fce68844-c5be-4da2-29a2-08dc589bf97b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pyv/l3l7b1XUFmoZs6hbzC08DbEu36I1rB8RNnA57RSqkRUAD9ZFXUYuFoTKxv1L53GBd1lMC7HAfN4g1Ewd/lZlySjyBElnQcRQ3ERJR3lj3M2buXjHA/tLqIw6FbDdAOfzcWj/u5XMVvh58ZwC2Iv2/LwwwSGE1aOhh4EgtgVp2/QKvOoUYHh957ukiS6CCr03exd6Rsa8tjAG5qBB8Oa3FQSoGeugj5TA6vzQunKJTK6ePeukhJEjQv8NODBtwK0EgwGj4zRlDV3k2bkk5UePTD7tFMOFB8P3yLLW1ZOO+oE7TuZOsFPnflNQaDtEsb3DS6J3/X9a/TPRz9JdHE1/gWRvBSZflkaaZEjwC8IRcYqufnCRmNz/KuYr5VNriHhqXwQG5oSXp8Xo1a7Mz6Gzl4dSBXVtnJcDN+dG0T28rJx68XwNrCc5p+ayo6ZsokiKX2vZZfzgJvo4BOZY5j2PJaYNkNL8XIxPQQo8c0j4JhbIK8WOsbbcNiLNhH8Ib1vPOP+QUooWn5gk7vO2RMkvIpiFN0q0WcU1prgX+/GRMNw354wXVOcYPLEfjpefblbC302rq8KGa3GmgWRNIK6Hw8PuSpASTmUYboB6oYAxXksg1yCQwmcPiRz2c+/0xHwZ9or4Ri/aFB47sQhQhWlqRl7QjhBoORUGqSrNtJt+yXn8AuW5FtKVSrje9UYS3EWUFbk89AFscUiYx3XbmQ==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 13:50:10.6978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce68844-c5be-4da2-29a2-08dc589bf97b
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007

On 09-04-2024 15:31, Rob Herring wrote:
> On Tue, 09 Apr 2024 14:35:54 +0200, Mike Looijmans wrote:
>> The LTC3350 is a backup power controller that can charge and monitor
>> a series stack of one to four supercapacitors.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>> Changes in v2:
>> Rename to lltc,ltc3350.yaml
>> Fix spaces and indentation
>>
>>   .../bindings/power/supply/lltc,ltc3350.yaml   | 54 +++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/lltc=
,ltc3350.yaml
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ower/supply/lltc,ltc3350.yaml: $id: Cannot determine base path from $id, re=
lative path/filename doesn't match actual path or filename
>   	 $id: http://devicetree.org/schemas/power/supply/ltc3350.yaml
>   	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/b=
indings/power/supply/lltc,ltc3350.yaml

Ah, should have run the test AFTER renaming...

Need a v3 then.

--=20

Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




