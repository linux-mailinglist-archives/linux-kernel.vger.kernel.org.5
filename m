Return-Path: <linux-kernel+bounces-55404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A22D84BC4C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744451F255ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AED613FE5;
	Tue,  6 Feb 2024 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="fykfsBJi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="xn4I5d0V"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2092.outbound.protection.outlook.com [40.107.105.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7013AC8;
	Tue,  6 Feb 2024 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.92
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241121; cv=fail; b=NPfr4O51UHE0GeQ4oGi1YXbPRm5YQQG54ckA03KiHO9czTKuPbBpyRgArHcILzA0y68MNAjCjoW5KVGTt65qHCNP5jwwQcn5aLp5hK9gvgJhKs93FnjUrD3qFX8KEfZeJF1pVmLw1s74WRPYZU/wTWi/zXFz9oXJzbvJQcyviPw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241121; c=relaxed/simple;
	bh=/+H2yHQIuRKziQ74RK0pr/hLJiS7h9FP/KCKA4W0HiI=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YW+QtID+5PW1r+fNOzqsa8QlO6ISkb9bNADVqrGFJtGEv2EXeeACEBto227BuQ6NrrnZpsb/9ZPJNMuFVbXbKeLkU0S4TS/EqO9/4enggMGozDmaQlaasZwreDQkej3LPFBqI4lFDKV0YRhlnjQm5NIgZuaiHKNBllgAwqHug80=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=fykfsBJi; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=xn4I5d0V reason="signature verification failed"; arc=fail smtp.client-ip=40.107.105.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=RkqcwsF+aJmT0Ud83/mc+bsh49DmgjWkYu5y46cCKwSwynAEABuyzh74K9/pKWwNVfzPLwee4xBOt23L1V1rZSionkgU5kQpNI482+zidAx1YTHWCso7WwKajQZCx/p/1WLV0LNzZ0Ou+taYiDh60QLvNs2qxbdEYnyo+Pb1ygGNQiHcE43t18mXT1PAM4vnN9IuwB4xeSZBn0JO8+yXlIXIkcn4OhYlANyIqm1X1yXi/XjpBwOL4k4yfXq4r5AZoGaui/3afF5AKKDBa1PDpjWqw85zNLbfAjocl3LxcqTEjXekOpOV++uV/DyQ9FTzSYlyPxBU3HJsPn+xPCVirg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+H2yHQIuRKziQ74RK0pr/hLJiS7h9FP/KCKA4W0HiI=;
 b=gbygwb/OX0+qO7MB3BmTJK3/VEnQMlZBJ98kqFPmAFQN9xh16RaLt6kWCUHV0LNrAlx1RNtb9yGF4lhbxlhiDfbzkpk2kdynUPEu90+/ssk7XwOjiqAODCzElwKWDnQsPnLA2jRI+S5m6GVc0tNhuZ4Oi6zE2FbSPtqG3Aa7hXkAsjgdNbsoQlIKM3F3zhLPYG04FWknAg0lUHrWDeNUUiKJQTeoJt9Tq5efO8+1IVvpey0LvOZdpbQXGENL/Ad01YgR5GjXo6nyT4Pxi9bXVRPOvX4XUp3+J8vRfDXZXssJj02lxRv59ezH2HmAtnwXV/FKf2k1Es0iyonM4qq8aw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+H2yHQIuRKziQ74RK0pr/hLJiS7h9FP/KCKA4W0HiI=;
 b=fykfsBJitFpwWxrQ8AzwA0cs0nr1HXTjnvNDFFjpPza7Fv1bdL+KEg4m/SyKOr/+MLYkLe/JAY6Hj+wNRpjd03oD//m0i5YR6OsPp0R4ukF1k7GUWrbtCSqeoMn94nrBZv6QaR5VcjgdEXqoE7SO5Yz1kB6UgYnHGVk4h9Wa+SBWPjs7b+oITGtTKOhJ1Uu3SVeAQQoooBoHWrlNbGMluqRZ2AxqTvsNVwlPw6SzPU/QIo368Nz/az8wWYgn6OOQtdk6rTxu4JVq9n8Z1cKCiIjLCeZBsc74DxYVxbROkTq3wkuxw2Ac3Krjh+ViS79QfAJbWlZJvUrlD3B5c0Cc/Q==
Received: from DU6P191CA0062.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::11)
 by PA4PR04MB7904.eurprd04.prod.outlook.com (2603:10a6:102:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 17:38:35 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::49) by DU6P191CA0062.outlook.office365.com
 (2603:10a6:10:53e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 17:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 17:38:34 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (104.47.0.50) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 06 Feb 2024 17:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2Lm3C4wGx9mfDEzn/L7A9Xj798+F+ktw5fPQv/JWQDv9/bOpcqJzZ500SHxfKgcdLrxhnHLvIKqR/Gmj024WHtCbP5g3KG0OF0SM5OveomxfSixqDsObA5CAAjnfsa+N9Epy6e17QuSbiJM2980E3lTGm53BVaH4yxj+zT1YDbAPGAmCFwoqw92wKfkojKaHK0czdiq69LbRZkoD18F3qYhkYTPcHDLhSifZ84H1/g/JSItLm2XZQVa3g0IEDzLmmsTzdvyIt66OlmhtCORIDE4YZV2EZI1RlH3jkO/Hp3OhlOjvGgdU71uEa8Thmi0HYidDnYmR1jewJQsNelh9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlLIs7B7xgmHNTVGYvDTEAb9D3cZrdwwBwWCKEEUjbQ=;
 b=WN5ITa1WbSr5kUf/gfY4n3HUng9CNQIrelRx1yXl0NcgRouJDwGupiTpX8UAtSh7SnOVzJryPPDAc22ks/zDq+wkuagF3cjqKoYA5mC5xoic+jE9gJ8aFhFGEhdnGHiJdSc5zltjPOih3D7L5ZBNZlx/2lMj3zQO08PeZf5BPzB2kdX402iAABv53FDvs8Q6q+s13pBCRDf1fEtnqOZAc6G1VKoVZS2CoTNO6XNlBXDYUQsRT9LRC0ekssp5LXZLT4GBdCDLZcZPjHmSqSvjTvPnC8Vlh9P2RHkazjAf1iAmOcDzLhHAyUerblUHfFpXScdS2Hf4Betz4HSBSzur4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlLIs7B7xgmHNTVGYvDTEAb9D3cZrdwwBwWCKEEUjbQ=;
 b=xn4I5d0Vk/t/whQQ6fSRSnUpr+kCWu3HsU6WnKaZ5GXRWBCB/7szNSaTC0/5KQQBiyVbfFEcI12+cZlYYMbJdWIP2JdP82RwIahh7IqQJakE9J6gLywz+f7USzpRzWzyRG+g5X1QxP5acTFEW1YKaSeaBJbSDf35vfDEzFzLtKUVr0wW2TqYJGOWnSQur2ICoZ/z+5F3c9dPVAXwKfCoOpy0QwtmnIMxSqJc52l3LZs5NlK0dEm5PuhIU4YVoeVvLhtSpzU5VC3+0fC4RlDUVQ8cEq4IyYXxw6e2Y4IjzfKWzYT4PtNVnbJU7nr+URAfNA7+7Oo8U6rxI9j8T6FhIA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 17:38:30 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 17:38:30 +0000
Message-ID: <11613ba7-fc14-46bd-84ba-a0b5d966cbfc@topic.nl>
Date: Tue, 6 Feb 2024 18:38:29 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1298: Add driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Liam Beguin <liambeguin@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Mark Brown <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
References: <20240206065818.2016910-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fd628a1a-a926-426e-a239-bfd8c9858b94@emailsignatures365.codetwo.com>
 <20240206065818.2016910-2-mike.looijmans@topic.nl>
 <ZcIsuiuisQjTIxJv@smile.fi.intel.com>
 <4c6654f5-2d9e-4c1b-a5de-7bdeacf5e99f@topic.nl>
 <ZcI5PoWojKRrdpVl@smile.fi.intel.com>
 <67387cf4-1065-4313-b4c6-054128ba8f3a@topic.nl>
 <40a3a47b-1388-4ed0-a24b-2c0bcef3be3d@topic.nl>
 <ZcJLnOiFoaABami1@smile.fi.intel.com>
 <e04ca010-289c-4216-95ea-2f2418613378@topic.nl>
 <ZcJfOgDMmLBpEho2@smile.fi.intel.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <ZcJfOgDMmLBpEho2@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR01CA0097.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::38) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AS1PR04MB9429:EE_|DB1PEPF000509EF:EE_|PA4PR04MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 837f963e-c95c-40a9-210a-08dc273a718f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 G+XMQjOhcWYQBDlmnRXzibHZOaVW0Bgs5lUFmfIpz4K9F2HWlwQl4+PebaPvOa/S9NCatpXb6msE1EqIqeeAy5+dcNX3fNmmENYS5pcCJ7Qmqb9tCX+oyYfejDT0G1sJbdmrs/mEvZy0rBMXZFZuN7AYiAR2deYAGZhjtKujkvkcUw+junECLd+pJU1apGRC3InCorgFex6fkdAxAKdZH6cJov0bF2Db3crrMJcI+zrcBBPiSPnRUj6b+ABj8MqHXkH4vPuhf22/5t0O8AX7jIwbuVJcnGrEhOCelQGxxSaEJPW6ugkoaQS0Q7rqnwW7ATHAoHQqaz236SaYvEzJ3dF8BazIpJH7BPTZb5hF2g63RjLt5pNWuMDWrylzDToWuYK+ux66AQ5WOlG7VAgQlwNjkbckAX6MDFYQtWXIn0tpZDjYNvtlAQs5aKg/V3WWCFz5z7w32zwe3Ye8rNXnajOivKA1ILKVrS2aZKndvEabpBMPioZkT27EixGPpa3NsxW0+F5BCyd/P6YnD++jB43mi+I0bK9BN2zDZkilJRKD0zE5mY1RU9YMg0TG6TAXCswgbiDUHpQTH9k9V2CLssfHUo/j+2fcwHHB5QZk97Fd8sh0mWsilu0pkco1A1HxJfbC6iWvKdaDGsW6ouEmcYqEHCT+hEVGCPqtOruNXeE=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39840400004)(396003)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(15974865002)(41300700001)(2616005)(86362001)(26005)(5660300002)(6486002)(2906002)(478600001)(54906003)(66476007)(38350700005)(6916009)(44832011)(66556008)(66946007)(36756003)(8936002)(4326008)(6512007)(7416002)(8676002)(6506007)(36916002)(53546011)(52116002)(316002)(31686004)(31696002)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429
X-CodeTwo-MessageID: 765fddbb-3afc-4436-ac2b-fba68025782e.20240206173833@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c2a617d1-3fa9-43d6-d99c-08dc273a6ed9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iz3JjotVZ566klpI+1DNpS5beTjLOgvZ1AVS8M9Tjyl5cs+pjiyIqQdJQXINn7D4O31sshlqOsrnEEw1pRkwemVjJgKjsY3kSLaeDDwx7X5MbipCvqyIa7KXZdKXs7votF3pnt7Q+taDq7yy9ifWvCcuEzfZ6Uh7XqJzXY9U9JKT4PQ/kqKBEcQeQx9ftat6cDYbAwEwH0dxB2hC6+4toKxSszOu6CHycti7LA4FmrCeFEYVzyuFKLlZ9JEY7Jav3CoS51gIdHi8ZM9vvSDfrfnyJk8vkgpZmK6q9wCNFL1vQCGeKwJgxIQErfXMWKRS2ZOsRmHlb4/vmSfPvFSarJlbKZWDgQRNHyYga/G/sV+cp7IfOYSlZ3AFyaX30YghzwK7Uc4ekEGbEnBQID1XvO7CCIr96WFTJXcBiEQzQIbCcEjRPei8KZnJKxIySJiotkc4QJ775FyD8mGxmo0vLl8E7kKqNq+CyI/Igj1CEUw1OjdnKhE/P4cgO5Oy9fHbCyBtnC+aO8XaNcuOyQCdpb4Y1MZkNDVO55USADfg2Wn73BULR6rbIgJlKKtOdsVLQSlDXXspbmoBRA4gkfUn3+AqIwiBDAp2SemsHCDOQZVMBs43A1Xk110B48mpPH2bA65DVlHQdLnP7XDlibDNc7Xrd1wI0V5CUL7dcKX3gAt9f3WQ7RqfxGwQivkVP2XNC+EPEuXpzZdYGusSBjl4V93Hlbze4o4I37QSfPLnSw6ZDLl4nqzB94gEjyLLxuSA
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39840400004)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(46966006)(36840700001)(86362001)(41300700001)(6486002)(70206006)(53546011)(70586007)(36756003)(6916009)(54906003)(6506007)(6512007)(478600001)(356005)(7636003)(8676002)(4326008)(8936002)(316002)(36916002)(36860700001)(7596003)(2616005)(336012)(15974865002)(31696002)(26005)(47076005)(83380400001)(5660300002)(7416002)(44832011)(2906002)(40480700001)(31686004)(43740500002)(18886075002);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 17:38:34.2964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 837f963e-c95c-40a9-210a-08dc273a718f
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7904

On 06-02-2024 17:32, Andy Shevchenko wrote:
> On Tue, Feb 06, 2024 at 04:44:03PM +0100, Mike Looijmans wrote:
>> On 06-02-2024 16:09, Andy Shevchenko wrote:
>>> On Tue, Feb 06, 2024 at 03:47:45PM +0100, Mike Looijmans wrote:
> ...
>
>>> But it's up to you what to do with that.
>>> Maybe Jonathan can advice something different.
>>>
>> The spinlock also protects the call to spi_async().
> I don't get this. Locks usually protect the data and not the code.
> Can you elaborate?
>
Either the DRDY or SPI completion handler will call spi_async(), the=20
lock assures that it's only called by one.

Usually the DRDY handler will call spi_async(). If the next DRDY arrives=20
before the spi_async transfer finishes, the SPI completion handler must=20
call spi_async() a.s.a.p. to also read the newly arrived sample. There's=20
no way to ask the chip whether there's data to read, so all the driver=20
can do is use the ISR to remember that DRDY did trigger.

The lock protects that the "busy" counter matches the actual pending=20
calls to spi_async, and also protects that only one handler will call=20
spi_async (and update the counter).

Maybe this picture helps:

DRDY ---+-----+-----+-----+-

SPI ------+------------+-+--

busy 00001100011111112211101


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




