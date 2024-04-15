Return-Path: <linux-kernel+bounces-145228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F77A8A511D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529131C21FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB07378C6B;
	Mon, 15 Apr 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="h9hvqnQW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="tFt/Net6"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2095.outbound.protection.outlook.com [40.107.15.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7712D1FA;
	Mon, 15 Apr 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.95
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186496; cv=fail; b=tRNz9nokgPudXBf1VwwE2kGy+kK6lG4NsjZBsmZphe0sah7UP+E+rCD8Nms+57tKANu2n6l3jQX9l0V8/SoWfYsdTXGjvH1KgiaFZMWRC0zGPpzn5/1o2qvvtJ2P/VcVaRPjnCb50QiIUmLTNIT36eFURhQx7299nCVQrRjTF7Y=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186496; c=relaxed/simple;
	bh=qANgG2yFiMUgu619FPM265DpW9s4nS6aszVBojnJqfQ=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mFanexI01KkhN29B6iJkomQZlEkKwa9+JpmaG7CupNL51AVPfJNVJzkeXhWH8tSt/LjwOHEIL+IqREodZVhH9sEg8R6LlZA2D1iWIdnD79HQvTMEB+qudZ/hPeoXwlLwuy34NEhdE33gsr0ywD40R/D8widWHuFfD9rn4mb5amg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=h9hvqnQW; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=tFt/Net6 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.15.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=STsfugZSZytRwpDBGbCpVPg2UmHLoOJkd0BVx3avBZdKxN8hAtXy2gtH6utSjDoh0vTjEZtsY0de5U7h1RwiUwdNuX6ruY1NWnQvE4hjDYE4uZzz5ByJsmTFRXGeEycgQWMEvnyip22KiMwJNzLq+r2lfrYswQV7OD55xulDbGw2lQGl7jbY63VkxYYXtpSxI+R2mB5lKPlzQ51SW7z5bEGkbGRt2NNyKNw9i97HgEwzP6lhEzqudtY2AJxj0iI/BDteMvTqTZf+ys8GDF8l1XDHM80kdtO2a9JWND3/SlTRID1GQ+CJ+loQeDpqd1ssnlTNW+0xYYAFrBgIQlyKPg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qANgG2yFiMUgu619FPM265DpW9s4nS6aszVBojnJqfQ=;
 b=HjsWSHFZaGUYrB8iVgYHhmNRUmglPFfNPwCcv2wjayCOCV5O7zaW8pbHj/gog0A7IpKK/kJAPF82m3fwDYqK7ddITaLQstyvW33CjNyRu7pl+nAWTffYl8JcNxCzpspTw5sjcA7wxL9EGhLOzLGtFhR9syUnTvfZ0FTwc71ExfVG5FY45ZQxoliaUICRMjg/6nvTRNcoz9EbRXZcpkcJepoudApIYDg/u8CuNEHgVnT5hHuDgdVoBl2LaF1GJk5f8+1XgpT1QJu2SBI97pCHl9yymkcMowo45pPnGa5fp4STvoIaWAsvyNSje440Lstwv2PHERBZg3O8oV4nC2Z6Aw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=collabora.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qANgG2yFiMUgu619FPM265DpW9s4nS6aszVBojnJqfQ=;
 b=h9hvqnQWMdUxfDg5Lg6lZ85JRtOGMMTxjDiI+xeNUwAVsKp9KxDhdTKJ09WfSDZjReiHx0nf0X33giiuqHvvkOVHHpmJLJpLnNLITItlC2hfOCgFGMSHPFjy+MUhY5nvApHeKqPHEhJJBtShYPZTj0ffavD751GXMCJ8jiQT9Nz/Y4fTwYbqQr61XxLIah/yQuQ7+7JZ8qXVSnMsy0VXm2fnvH+KKyRPubdWKUR/RDhb8sXfao2dRWIMojhA5ZoztkEGbO0oXC6dLM+UwGt/ZG/5uCKe6h+S/zXYo9gZY4kERr2Ojp2DfvEHsorRK9w1ZZxfqJWLEZRNLVRn56FNow==
Received: from AM0PR01CA0132.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::37) by AM9PR04MB8955.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 13:08:07 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:208:168:cafe::6f) by AM0PR01CA0132.outlook.office365.com
 (2603:10a6:208:168::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 13:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 13:08:06 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (104.47.11.40) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 15 Apr 2024 13:08:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inE0O+rjmX+OQT5vJx8Ui6rlHWRAmwFvjxL5S7wpRRaQBAZQ6tfw2ywfl4Oz2jRljpn6uXFjxHfUapttDnHHJIJB2AUt2c7EbwzXeJTZDNeE/KC0tsBKE6NoIHuj/NjWRHOhDTRsbYVqrRrKwCkwyFNhkkhJvam9SiyOA2dQ5QBIXQ8ufOT3Czh7oxnZuE5zU/U7dOnt+6PTEgTVsji7N8zbgAtDfVdFb+ShBhQEEZjCh2dB1TEdS8Ko0/Lm2WWFMnAk5S7w5WlT0B9r/Vdh+7lbx/BeTuQlVKJ/wPj1YkRrnJYrcf8L3JRhc4YL1oMrcEkud1Cb9nOhWtVpgis7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBp3AcsV1raVpxzOsn2Dxnleit1dCbLTEeLMT9uIGjo=;
 b=eSZ1NCdtwgdsw7UhUc7c4til8SYwCa8QxmAE/GNEpHezexAfpKJ/s/WdKZBRoQ5Pbg+w2mxkAyxuGojfdYJY7uUb4FdkaIWRGoYYdwNL+c7dru5CrKaZ9wwaPjyjVP7dUw62IjYGEoCsdK15mgqxGIk/rn/nGL8R6tl7G1cjIaJEDXrQ8uGSMnPXrXerXHQbfUAMgH4nEEjU+8IQ4SszHY5vVnJPRXjW5p1Yik3g/zv515XpsKRM2lUGQLDMvR6dajw/F4bLWoYVb6q8Yb7fZL/RqoQ1cmlLB/oaif6NRAAmWNtTo9rnGmb06+Qz833suBQz3/6FRIERQD365hr1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBp3AcsV1raVpxzOsn2Dxnleit1dCbLTEeLMT9uIGjo=;
 b=tFt/Net6uR4uDaa5TFrRLAzmw1X69m8pg/PtXOgOl10YwoGp6qgQ+VOkHPiAkKoWQzpX/iu23OBP8Ak8OdhYKoBD6gcgUte+DtcMHBLkjvaJIm+ACevRNZ5o9qGIHsOoyhAsTdMiz4qSYUaFp0IzCD8oYekTfJ8bsHhKYnaw0G77a4YJnGW/x5+DOwq3xw9KA6G4VXxmN7gDa/ZpNEKKk97hqlPQWu/OOQnCNkt93r75d95r2ALoaVoGvWHNBO0ggCIJt/owOqaUFtOhkJXJSEHf2XVO8yTjPyP7yuertWiKUJxkAuSVOdFzVsJSqYqyGfjqSDCLkr/4cHMrSUiwAg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM9PR04MB8908.eurprd04.prod.outlook.com (2603:10a6:20b:40b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 13:08:01 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 13:08:01 +0000
Message-ID: <cda9f2ff-d13f-4421-ad10-72ab29fa0024@topic.nl>
Date: Mon, 15 Apr 2024 15:08:01 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 2/2] power: supply: ltc3350-charger: Add driver
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
References: <20240409135442.37732-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.dab85cfc-973d-4930-8fea-324aa26b5801@emailsignatures365.codetwo.com>
 <20240409135442.37732-2-mike.looijmans@topic.nl>
 <5hpl2kspf667hmmxgg36ahiux5rs364qzrg2itpljspspa47vp@dsbnhdnq5s54>
 <efae4037-c22a-40be-8ba9-7c1c12ece042@topic.nl>
 <lxxwadaf2mrghy2kygm3cucb7ygl5qu4dxnmpbancrm2hwjm4g@5eudactyudca>
Content-Language: en-US
Organization: Topic
In-Reply-To: <lxxwadaf2mrghy2kygm3cucb7ygl5qu4dxnmpbancrm2hwjm4g@5eudactyudca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR02CA0083.eurprd02.prod.outlook.com
 (2603:10a6:208:154::24) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM9PR04MB8908:EE_|AM2PEPF0001C70E:EE_|AM9PR04MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: dc285e89-b9b8-4793-a220-08dc5d4d1717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 sU1NNXxnzZdk2uwIWSWwOLhqFubfBO9ISzakgI2hCt+k8Up7RwK89p+Ef/3pgxDxWEpLx7hd+MsUbWH4+7yjRSLy7FZe9ZGigHiW1shvVJWDCsDe+Ez/pL/JXPUqOtXKg+6wfcPlDGeazLDeLrCI/D8x3to7IgHrcQRwpfC+6z9taKpKAXFXW8uENmDshNCBbqTfKAxC81hho/1YHUnvjeXmiK4bCg78xiyyDR/MZhpP4N/SFEmlDpzgdS1XYgM4o3xkZ9d3YFhzpYQget0DSQte98EVM9wZgUZC5zJBRxbvwMESvV4u4Fg3FUvqSa2if+sNGsyXxmTvmMMHcw0mjaSlT1j3hVF6LlVmJ9Xbb9VTtPKOA6QiJ89ZRAm/A66wxmpkcBL8kZdipGFMyBrZ11M7YVt6GzwwgCaaZKMFmmvH8HTFdVjZoqRTBa7HcjnDmCfYEAxZ150SrcsZ3wVroBp2yQHQ6kRjWx6oQtYonD6udItqOIKqANlbawaHRBCjK3G8uO2yG63nADSxNAlQbBM13Fh2vKI8V5GZAj9Edkr5cNqvcRiiZL+4gCqSu9+IJDbOFy5q1ZMt5XPl0V3AU/xS1JTZjAJLoURrOtWP7spt79dDIj0B3kkhjyTmPzZHqaQhxeoI40hwTYqf+GOD2Lw4H3UxafkBtzQmQ6Zq5iQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8908
X-CodeTwo-MessageID: 74090fe1-71e6-421f-98bc-f237d2f3e2d0.20240415130804@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	44c1086a-c4f9-48df-6c70-08dc5d4d1455
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZHpmRPx8zWfek9nyMvR5CeU8jtxCH6P9sTGBzoZkTyfbiZEY112gluGElgOybL6SA9p42gEHoxoNscBb+aTXecMDS+zmwxGD9Sf5K83RFmxeBzJzn3gLbfUbRoCZ1WKllyGaAmSuGWXHqJ5hdyMopUz2YHNAKAI8dcuGpGJRZvJqYhNcE8sRHpxwgxKF0ZhtinBh0qDkty33dEQnOoF8Z9ec01H50kET+Viczgiu9sCaRoar/yIH4kXySMKgfpZLG4N9LZrDNOCjynMjnvQs2VEHz3qUARDeUq2q+KfEd14S/rDbo1Z8htRDPWeH39LPZ1wBpTJo3uIVyJ9rZXfNn6CUOK4jvbCZhVa8vsQMd+lEBr2WB/BlZZXhQLJWDJ97z2ydPqP+NpP3CXswpiAseMGxf6hThVjGOIqZfD2B22BLcBBBRVLbTExEKxjXAxQKWLnHEmIC9c4iQTx1qE84ogKjCgezPK8PuCbrT+4qZ4nGZ2oerG17YQ4upjxYp59Onj2V+ZgBz8M6qKHFAQ9DZpP6TQoYq4Ot88Utl7vsNHJEhLBHhFqaOUdUOywmO30z3AwLQqZlwjnQPj4c2Ru3gscBjG6dZQlWkPSc64QRKyB3Jd4zIYgArqba/g41VhpdO1NsZsrk4mzBQKhSdfd/wG5uaylHd01EAeo8y9ZbUtHKbql8BdvenIfOXSU63ElUgKJDQ8awDNMJCJqh+bJXBw==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 13:08:06.0120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc285e89-b9b8-4793-a220-08dc5d4d1717
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8955

On 14-04-2024 19:29, Sebastian Reichel wrote:
> [+cc Nicolas]
>
> Hello Mike,
>
> On Fri, Apr 12, 2024 at 08:53:58AM +0200, Mike Looijmans wrote:
>>> please share output of
>>> ./tools/testing/selftests/power_supply/test_power_supply_properties.sh
>>> below the fold with your next submission. It's useful for verifying,
>>> that you got the unit scaling correct for the standard properties :)
>> Will do. Did a quick run on the driver as it is now, that yields the
>> following output:
>>
>> (Any thoughts on the "arithmetic syntax error" messages?)
> The script contains some bash specific shell extensions and should
> use /bin/bash instead of /bin/sh in the shebang. Just call it with
> /bin/bash ./tools/testing/... and you should get rid of them :)

Yeah, installing full bash (instead of busybox ash) on the board fixes=20
these messages.


>
> Nicolas, do you want to send a fix for that to Shuah with Reported-by
> from Mike?
>
> [...]
>
>> # Reported: '1' ()
>> ok 6 ltc3350.sysfs.online
> [...]
>
>> # Reported: '711600' uA (711.6 mA)
>> ok 24 ltc3350.sysfs.current_now
> So it's full, but still getting charged with 0.7 Amps at ~23V
> (i.e. 16W)? That seems quite high.

The "current" is also feeding the system, not just the capacitors.=20
(panel backlight being the main consumer)

I modeled the current into the caps as=20
POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT but in retrospect, that may=20
not be the right place.=C2=A0 Maybe that should be the "CURRENT_NOW" of the=
=20
battery component?




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




