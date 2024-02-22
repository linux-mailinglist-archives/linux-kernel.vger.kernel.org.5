Return-Path: <linux-kernel+bounces-76005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2A485F1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DEE1C215C8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C01799C;
	Thu, 22 Feb 2024 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="PhxnvUIn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="prgZW/Qc"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2131.outbound.protection.outlook.com [40.107.20.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE58F9D8;
	Thu, 22 Feb 2024 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.131
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585838; cv=fail; b=lL8yDvtRbv3iExJs0Req9J0PoueMS+6fltNTqfPQ87h6xZW9yIhWwrnIkMZL1cDiovRqYocD/gkMQlxlhNbcTL5zaDvvDZP2cncewSYrOQDfPMzpT2d3kirEHvCznFV+K+C0vzRbJlYpIUjrngc6diUGp4+lhIuoNhI1Yu4MYXk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585838; c=relaxed/simple;
	bh=iOraMhF52f18WnZK2bX+hIKqdWN8Sz4C8vw6ckoz964=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L+vnCAJARedlAIlUuEy4W8FVAMOIkoOEy4noLUyNMX63nMXik3/BwpqvtIiCGtIpPpsofnb6gTOQdw+JOBa5/sBY1I4mP1rdoGc08yEdgbQgHvX+oTrHFFlR+0wOswvjG5n6oNCjdx23zl+pP7H21KyNGb4DfomlQ7SiSz9rXjg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=PhxnvUIn; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=prgZW/Qc reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=iuTCAI9F0o8zrHWv6zW7REK18xtJDMjlZPt08WEHUyWKJprS2LDzcxBL0Bin1cg/JxNHF32FK3muBT9hx+5GGmx1YwzbVsArrI1zH0+z+cVPAjLV9omom+rYIrLMmbkYRxEu5REJsRJiq8AV/59IUnM9DeDy/7O2ZqX4Bj8XLwPxKpfMAeQebvQZUuAvh7LkKHdkJOlMMd4gBa+0gGYavEkBbQA7+9rV53g7n9uvPw2k9spc5ozKKm8Si7QbSHOdMc0QWvbIDnWeDJ7nt4IAxAgXhqjRPdTLtxILd40dJR6mE4QKAS6CJtS8xwE5imBGhr6nPR3Cj/kAXuKZbWPqMw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t65O5H4sI/xl2sldwo+Hpp9T00o2YBn8KAi6Og+nkI=;
 b=jJiUVUncI8qVEr3MOWV4YvZfn9fX393Gd2wU8Yv3UFLbYaIHx8grww7NOGFpnGGmRS8KFzojne8Cyfb2HinN3lKWvQ6HASI/CW+oNRnq8ehS3G6S53f/gLhb1V2l1y+azC/F34ekDzytD7H05i3+P2XpVjkxRCdyynfrb+XYJ3sMxLBSaKu36Ic5h4H2SD6ldkKP3fDQPouUZQKOr6eJ7hv9tAMfklwhzlerl8k9e7rEtMLMmimRh9y6aWaivZF6NvnhJtCwwKkvRY/126gsQ3FMhl05Lffd1ljpn2Cg8IZv9I7feQ9aDKxW04RO06WRb8ZiE3B5GEcx9OdZRp6F0A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6t65O5H4sI/xl2sldwo+Hpp9T00o2YBn8KAi6Og+nkI=;
 b=PhxnvUIn9hMKPq8XqgF2uu43I196cjxwKLx6LjVRMNTOouT1no4eyA3HvGllntSnvnkSoUq8vPgDAwguEodY+wXKgF2WB6r/iBiAu8GquNXL6osi7rH6VufOQPjRNBTQhjPflEsNVpl4MwYMlJNGKzw4nVVc/5Gnzls5IttwQg7mV+4qr7WguL0ziQs+Hm/xw6qLNGppujCDBV1lRwweFG8zUrS1zaZVaWivK2/+1NYNpdiFGhKRZNOt0tPazOwQnAK/Cn7MZRCFrCETWjWYlu8YT5MMsVIPoUBJYHVZDKjrjgQJ7rD45u4iejJh4r0Wbf5ddJV4qFykPYpWYwVR8A==
Received: from AM0PR04CA0136.eurprd04.prod.outlook.com (2603:10a6:208:55::41)
 by DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 07:10:32 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:208:55:cafe::a6) by AM0PR04CA0136.outlook.office365.com
 (2603:10a6:208:55::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 07:10:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 07:10:32 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.168) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 22 Feb 2024 07:10:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6bzNTlu8R979bQnbIIWIcC+33m10WUKb8mAjRwGuHYjekyGA8mqu19cMfGZlHvI6zs+PI9pLUMN+TxdOkmhFdlO8Sea/Z37dgNCeDaJ0UMWe1xvTI3Nec/ec94KjwfgEiuyKPvD8sCWvPaWgLYFN9BjOYMIF1aFB/jkYfGO1rMJ4Tp7yVIte1dnGOy4jvNfU6ADuKIHREjI2+j1tt3dc8SgMBmfoqsQRpCGKw5NJwjlahE9Ncsdt0i85qNGMSnCelKWS4fax8H0UFu7YoQObJNDKGqWpx66MKF0O67MGMJh5qBe+zJWIjhttn7d8Xk/NFJTzoRR3ABvvruacEPDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8ej8XF2e4+mBoG/UKQGflfU6U4LBjZAvVaU2L+xU9I=;
 b=k8pNHpgy8ra0J9f3+1+def380KdORPahlblqLodxC2B0314oduV3Jl1YOa39srkFUAIvBdcAxJXLzRW5yWaIXtOvo5ZPjQPbjhUzlJboJ0OmOLWNYhjOTyfB0pZ7LJIltn4TWbCwXJQVjfsXkpnMvpmi5fiUIy6OiiALcA2e1ilwnXY3f7hT9Sr39jHgZwzKjqc60vVYS2p1oifgPjo3d1gEMvK1VWQo267DkEeDHhGGxOaArjOAbJVmozJXBRtsr1T1+KYK21qgGLR0BewelYA1lDpIz35MgUHIMJjdQvnmBPLZs58QVm7orEiU+1nr2MgGsikd61zj8v0qe8kEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8ej8XF2e4+mBoG/UKQGflfU6U4LBjZAvVaU2L+xU9I=;
 b=prgZW/QckanGgHi05mLAD9ylZzUTI75S7DoZPbTqytTnclpFARmE8RrONcGHKC15fUd5JottzM8eebLl3AFVd5Bghzw83rkU17JEaDV59TkcvVLz5uludw0+qIMclfDz1xkqdodbqrCdoU2ZCl1E/lZB/W00GYJsB1OzoZr7wFNtmDIdvh4kq+TgjafaP9kVVyKgcz2MxxnwXNC+NaM87T3uU+mr+vtCzsG2w34OI8rErVT+VgXOZXzD0b9tStV/cRQKqSpg4L0Xhy1l6VO2ULkZblD0ytQMY32i3u48CiAIeQpHHk0leHTL9R+4oFD75eVIepwbp0c8szJBrAKdjg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS5PR04MB9730.eurprd04.prod.outlook.com (2603:10a6:20b:677::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 07:10:27 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7292.027; Thu, 22 Feb 2024
 07:10:27 +0000
Message-ID: <e315c126-619c-48a1-a5d8-001e5ed01930@topic.nl>
Date: Thu, 22 Feb 2024 08:10:25 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 1/2] iio: adc: ti-ads1298: Fix error code in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <5f393a87-ca8b-4e68-a6f4-a79f75a91ccb@moroto.mountain>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <5f393a87-ca8b-4e68-a6f4-a79f75a91ccb@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM4PR07CA0032.eurprd07.prod.outlook.com
 (2603:10a6:205:1::45) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AS5PR04MB9730:EE_|AMS0EPF00000191:EE_|DBAPR04MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: bfaa3389-ab48-43e3-2dcb-08dc33755bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 orI2Dh0n4q2VGdtEeX8ARYiPS+OjRd+hUqWbodbRjONVYsgs20K1FppZUtC9F6g3Sma4X7Cf1Mvs/28Os/NzHHAQWWngHM0R5BuzFU1gpzr3T91AE/8LbaTgG/NY8jqusmafVXDipZXi8BuXlKmiKwSCturY9iR+wBTwIV4jjrk9EqGqg6HobJ1X2sFKMRci1RuIR2SFyHFAdSra37RQhc8qtPQUW6ZMbsNJAecGnDG4ieOY5OatIyILn1nI0BuQd72gd6SqguxuMfjCf2qdyiD+j8MUFg4FKfijETvhCFhdsh3INr2WbBSVNWDGtocKjgacD17GoCnMIV1a7oCiDqyxmHi9xQvPDUU/ANHDnOedZZLnMUKYqg6/ciZgeVkY8UYbLtakjVYeUYAo88of3Mku7zo1kQ0caFCPAC2C5QkCPjst4ee4iIMttQHoBHqQX7kfIZ5ewEDcGTLm9w00TUysWvLpt1rY9ZwD0x6HNSfa223dtbipMHbqu4PXpeoI3BPaBeC7GfhrCcSE26vyPeVpaFncmzIU3/W7qJC6fgmFTm92ci0HMUOe3Ktx+haSrQHv385JYcok968Xq6ZCtTkJaTAwxWGzAKV7BsbzHQI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9730
X-CodeTwo-MessageID: a37575f4-1e39-407a-9179-1a443c50a3df.20240222071031@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ed3ac3e0-f193-44ce-fa81-08dc33755887
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GEjA+rAuyTWxI2buB5BeFXAtqPswoOkSyfqXQvSbBBOvstcQ/WiY7j8dMFgOqPWZM2Epooh8JaBYZCVQl7WuTMknfd3Tnr6EMtSuNNarRj/kOKyprIi4qru2bM5M3NJ3z+cMfMWn5ylt9Ps5XBJTuHVjGP5A9p6m1NYHXLaG537G8Xs7HMXHXCZ1nXEdBq+pV6+hzt/hQDX8T9qaCFtYgez3qAJMPQDP7Lf9IkF3fe6YpcTsrHqK6UDYU7coxArcWhTe+sC9+EA1yaCU0WdKS7g43rd+lsRU+AfYq9pPUXQic6uyU6+R06IOzbtGczOPqk0sW1qrGbOmh1XT28zgDXFlu7pAzshbvePwj5eTGQd2L89NCEKo6KxDyYqW/Ff3u36PNoSTM4aMsHE8caUZGnGd1ws6QJ2m8rEvqMFGp88lN+zUFYEhGNFhdUOzY12+Y9cUXcPe+df4UWOAdixPlu2p6r523YjcyTSBQx2/a3KUeKZzOkTh5/Lgm4RZRwgfRAZp540SW/t6lJbMovdbVI3rDgEWGFt2DTVRRv9C8WONXcas3TyTgsIop4tV+yR+3ZsCQYX93AcNnnrWFOSl0I9bBgHTKLkjJ22zdaOnusN7Lqjh+sdOxg6pT/sQ5mnQLt30lyHr23lf7j0LLIT5/Q==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(36860700004)(46966006);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 07:10:32.2679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfaa3389-ab48-43e3-2dcb-08dc33755bbe
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7207

Good catch on both patches.

If so desired, you have my

Acked-by: Mike Looijmans <mike.looijmans@topic.nl>



On 22-02-2024 07:14, Dan Carpenter wrote:
> There is a copy and paste bug here, it should be "reg_vref" instead of
> "reg_avdd".  The "priv->reg_avdd" variable is zero so it ends up
> returning success.
>
> Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/iio/adc/ti-ads1298.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index ed895a30beed..67637f1abdc7 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -657,7 +657,7 @@ static int ads1298_probe(struct spi_device *spi)
>   	priv->reg_vref =3D devm_regulator_get_optional(dev, "vref");
>   	if (IS_ERR(priv->reg_vref)) {
>   		if (PTR_ERR(priv->reg_vref) !=3D -ENODEV)
> -			return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
> +			return dev_err_probe(dev, PTR_ERR(priv->reg_vref),
>   					     "Failed to get vref regulator\n");
>  =20
>   		priv->reg_vref =3D NULL;


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




