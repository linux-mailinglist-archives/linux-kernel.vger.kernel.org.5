Return-Path: <linux-kernel+bounces-68686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95A4857E67
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E70928A7A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DC112C7F2;
	Fri, 16 Feb 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="KqTjFmvF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="bFLUtQ+d"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2109.outbound.protection.outlook.com [40.107.20.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD512C53C;
	Fri, 16 Feb 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.109
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092102; cv=fail; b=d7NdO2l52lCn9jnKpDzADSlBA5dmCWfFRp/vsLyqQoVpEQa9GLJzt8BNn9GWKFUvjVL4d/3qZNsLsH30yfpvqUChJFhAM8sj0Lp0yhO8xjAACRh8FKfFdaVhjhJyPYcdTRy3WhN3gbF1QSFRYEBsavyXIrZnAbN2MvKE/BMw3nM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092102; c=relaxed/simple;
	bh=aLUHSIBAXH3YijtgeAJNHF+uguqQn6+tAt1FT85Du80=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l47ktPAeoCAD3JKYJ+TSdwICX5eJdgzebGqr2ZNAIDAM9BpiWPGNXhIDOGWqHhoO+sfBCNPkE7Uj5roEvImdE6BBoNQXz3zFkTUYfYF8/QHqp3dWxs+NmFT1duuLgJugiXfnseerZVXJUyNDuI/xPI0f4hAy1qQvbNh6eERKreA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=KqTjFmvF; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=bFLUtQ+d reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=D5O/bPOpBC5Q5dP6EnmJNRXMSreDE9VVD+qTkp2d22I8fo5PKZRKloFGUiCXxJYtTrF6Y/B9w8wccg5XtNXZjfiC4XqQgs5uO8BlvjRtIZ+3fLbyPZCwRiR00pGeUs7unZCC+uWjLHNwVWSYeOcs0O+vItB0VMvzJGdTRUKTgVZJpWPNo02GJzlYdg7dcU3ZiweesVVVyTghIRjuuZ0b1/Z6SFhKUMIFRxHw8eF8Q72+Z38XmyvNwRpRLPwVwO5f95jPdlM2KLkho1slpWCcEujIUpezCe8Qhb5R1svQ0g5LD3VJkOE/K6eJr2T+XQQpvVnqSmqpjcobAPVqwlZcNA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SoK2QpK45Uo2vZdEJGE8ywTETWs1JgI9tFwdQtV1Lo=;
 b=FEucRzK6+1md0Hq/SnZZPADd9uUg/n3YhqwuiMcBmaoTVOZ0jrGD1SrVD9caJIcdQjClF4LxTzPt8CB5yxCJQgQ0iFRxzXFJy0cMJ3eIqNQSQAFjTTprdjOQfpuDpH2LiUCF0/v7gev8CWuyV4VDsWWvg/RXjR/WjqcCTGIInVws+d+xzMkX9UCD2EAWGq/xU08MQs0TpXPQgbyzGij8joBWPlkSnJcd1A/Jfp71PYm4NuJOosQ764wiH3YuYsuz8+M0yRmjlTIoT320D3zS+ekW4EiXTVGZgMx1UvfTbl6d1MLm807pORQISB9zm/UjO+wiwAE+U3BcL/Uds7QS0g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SoK2QpK45Uo2vZdEJGE8ywTETWs1JgI9tFwdQtV1Lo=;
 b=KqTjFmvFZXg6wzxQOC0i1SEl/Y2wxmDrTwPg5B1XxTsz6v0GZ4RZ2b8zPdzA6zBh1TrlOBmagGD9Fp9EpWXpBIdmw6vDNl0IZgGsdPYT6L1bRLcSCBx0iyAcFdZbCQRXDoS3datIPdELXJAcqTN0ZlBXaxFwRJkeZwIHFzVMpaFMO7KoqEnrSFmKYx/3WfG8DlyvhclPSJ5X3Ue0mSZIjMVoJpkqviHTUqYqrIzWycj2U+iVXJQ2Qmhi4ay3evmj8juMSoBooRQ6zfQ5gzzeSDdmH52yJoKRW4UWG8ou41Nm5ixErZylW5uPWez2c68fBZlHFL8c89xnY43ztz9gSA==
Received: from DUZPR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::20) by PA4PR04MB9391.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 14:01:32 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::fc) by DUZPR01CA0004.outlook.office365.com
 (2603:10a6:10:3c3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Fri, 16 Feb 2024 14:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 14:01:31 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.50) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 16 Feb 2024 14:01:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3sX8XaJPGPXdklGigqr0lyEzaT7UtB2InNNsjEfg0VrR+mi6a1lqN0s7Dvofb9J5ba9neh/rORqteBwLOIx+G6rnzPW/BP/U8BpH/DvGSXtQp8EyfifhqMqrpVRvVJmUzJFpXLHhYIA2GFhQLxp7DolTgdF71pUu5mXAa06ZbaZ8I9hFSEaPgejQJeodkRr6U5gQY/r3Z8vOZmjQnqMq53vJiExmAPAcPnKMKs63wsbZt8uH1owfw4XpsUzJLPLwVPcm2ltrwj1KB9UFhp08vmc/rAUeleCQnEub1lrsslDhksJnfTyB3B2j5uLW9rU+Fm771SB7YkJ5aGh93pZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbLUSVIn+h+dVTY6V0pnK8i0aSdSh9/O1WMdVRdZvpo=;
 b=FgAQWq4mfySDbrzkxzpVVXywWhCeXvYIdRXP15YmD526gVbpsCHbdJaPyJm/5AFvYz6EGq8iABX7mGr3JICf5UpezIAiCz63rUruQJNFQecIzsNV1k0SukM8sigTK0Ilt4mjbjy72QjItFIpJPWL+p91QYOlJrfxLsEFt+nSoLPZHjBiGB1IAtagPmztbxVjGHdE4WpmsmC3JobUyaCPaxYorv5T8vdlMOw9Iv+u/X8aboHk7Fm6zd4Cl7LnwhX1Z8JNZLZBhHCZ3flg6gzwNHu1FLUJ53vQ6RnTo94CuNP2dYwHMltf/iQxVbfgj/fQyIElYhAk44lj1z7zgY1j3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbLUSVIn+h+dVTY6V0pnK8i0aSdSh9/O1WMdVRdZvpo=;
 b=bFLUtQ+dwnmH8zTmk5RLK9nRLege8qm+Tlcutqmq42MgzY8DKD3SC1JUBKN5WFe4nC/HpJ0/49aY/OOKJPCOH+8P0Tzi7nS8vbjfLbJUGfdYA+ck6wPAYr58+W9g006LVC3ABEQNhZamy+jDkFUBmkpByCNnGqrUYusSW6l6erx+XFbq/Dd4wj0PLYt8CN6JZhfzmWnUYSPKM1wUagGBDHGvus/271Vi22JvoyloL9apXJD6roG7dk+zx99kOI6ERgfu/LhJRUIcSDVSfMUYuNVgp/PUh+TrDRIWe+i2kmxWQpEFcq06Fp7C/fAARBaLwiMDpGMQZ+fNmRQRDBoXXA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8784.eurprd04.prod.outlook.com (2603:10a6:102:20f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 14:01:28 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7292.027; Fri, 16 Feb 2024
 14:01:28 +0000
Message-ID: <8a215799-c7cb-491e-8318-76d7e7f64bd5@topic.nl>
Date: Fri, 16 Feb 2024 15:01:26 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads1298: Add driver
To: Jonathan Cameron <jic23@kernel.org>
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Beguin <liambeguin@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Mark Brown <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
References: <20240214063736.88283-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.da2f422c-5c6b-41b4-8916-d1a90f0f0973@emailsignatures365.codetwo.com>
 <20240214063736.88283-2-mike.looijmans@topic.nl>
 <20240216133816.18c42c99@jic23-huawei>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20240216133816.18c42c99@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR06CA0137.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::42) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PAXPR04MB8784:EE_|DB5PEPF00014B93:EE_|PA4PR04MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf93b90-1b28-42af-5df5-08dc2ef7c7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 7sMFTz1yCxcHofPl0X0c3E7+vOgiULiDwXpdbJfFPJwn9s+hea/v+CyuxSz/o7sIx1sl4SdLYrxEnbzPbvyOhwcFODLnlLKICMVZM7nWSjdwexK/K/Q9Mklo3ShHar5Sqs5Sm9uBPfmRQOdpTgyV1JwYTV+CXDmu+z3G5jUhQsYIxydG7BUY+UqnQp3YnjZUm5DUoqwlPhzRroHBxgfX/KIEQbYw59v7+E4wJSe9KMo1g+8A+6DaHeRMtnyashHmOax7ELfrO/U+jn+5DNwQzMRHylA+6Shmkf7f2QKJ8QZwjrqOJ8dhj+pmGOvPGNEkb8TBza5vGhjJbpXmNk2QBZIR2dYcj1Xcxozx1PPuPBT1BdM6T6X25dd5Jy0egbT7hvMRH11z5b/t22HLEu9zp1p1YS8ekxzk8Asj9hBnAIrbosJU4iqL/7Q4x7UQaFAQFmZDhSziPPYFo3YMZV1PTDDIM2COL+lQ383Tkd0Qsya0eQeFxTI3cOESSJfOIphWZ9TIO2GMKPi0OcGYBouMYuxU3Rpjo1rqHdwqH+UVbBVDi/pq8l+Df6HwVsSAQNzaB9tqosjP6cqMTovn6dHLMg2GZsXoBZBVh6ISI9cgtzE=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39840400004)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(15974865002)(31696002)(36756003)(86362001)(53546011)(36916002)(52116002)(316002)(478600001)(41300700001)(6506007)(6512007)(54906003)(83380400001)(26005)(2616005)(38100700002)(6486002)(38350700005)(44832011)(8676002)(8936002)(4326008)(2906002)(7416002)(6916009)(66946007)(31686004)(5660300002)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8784
X-CodeTwo-MessageID: 35f08e41-1b7c-48aa-91f0-fcba0ea311e6.20240216140130@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e0a70c5d-2dea-4895-ee5f-08dc2ef7c512
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dv5Io9LtfmwItufyB4oseOiHIqp85/pizQrPEagU1yaUYp/W6GY0EN586+VHm3CiVggcDvxtHjfaifoYz/h0oW5+Yy3eGol7qchEILoFaRYI9F2j9/14pBD/bkTxF3FnmWyrwG3RJgXqOP2zxQ13m/An5M9y+jI3u2Ov5TmuL2djDrr/xAdGfLUXQKHL5wIJoPki3hOxGROWihmtZMkMDZEHqp5mAc90MoaxsjbaUCOmqiz6//9FiclKqC7nJxT68avfycnOb35o09kOyUAHl5zEunoAAAs61HcoRsgTwSQIAA8Cp6Qm13Qg4XrKdtJ+fXGZAw4EpU+DODdZM5NcHeimS9+CetR2mwWsboQ/7SGFK8LIsofqJeII7n7yYKLHGzbibz/4/53PHpgKO8dUOT+gOqlRWziP6TIu0ZzvgqtOkYIdxCBjC2oy5v/eO5BHKfNttLkRQH4FIj8/GZJu8nw0jhGCRGeq/cjnqEYJIX1qEfNWhinDGV6GyS+3TWI1CtzGGhLDOA1HMb04vqbEpTKg84moOugCp+nGQnuM5lAMgIApWqYbR2khOc14BYHo7dGYehZipxbKV4eiWTPv+UB1+v4iep8sj7aVAdPLfwUisKZ9sCEFWm41btyzCfMDIPYYBgwdHkgx4L9VbFZOuA==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39840400004)(396003)(230273577357003)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(36860700004)(46966006)(6512007)(53546011)(2616005)(6486002)(478600001)(6506007)(336012)(26005)(7416002)(41300700001)(2906002)(4326008)(5660300002)(44832011)(6916009)(36916002)(316002)(70206006)(70586007)(8676002)(8936002)(86362001)(31696002)(15974865002)(36756003)(83380400001)(7636003)(7596003)(356005)(54906003)(31686004);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 14:01:31.9781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf93b90-1b28-42af-5df5-08dc2ef7c7c1
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9391

On 16-02-2024 14:38, Jonathan Cameron wrote:
> On Wed, 14 Feb 2024 07:37:36 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>
>> Skeleton driver for the TI ADS1298 medical ADC. This device is
>> typically used for ECG and similar measurements. Supports data
>> acquisition at configurable scale and sampling frequency.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
> Hi Mike,
>
> One final thing noticed on a (hopefully) last read through.
>
> /sys/bus/iio:device0/name is going to read ads1298 whichever
> chip is detected.
>
> Would be more useful to users if it identified the actual
> part given that is easily read from the ID register.

Makes sense. So It would say "ads1296" or "ads1298r" for example. I=20
guess we prefer all lower-case here.


>
> Jonathan
>
>> ---
>>
>> Changes in v4:
>> Explain rdata_xfer_busy better and remove post-decrement
>> Reset assert explanation and add cansleep
>> Additional style changes
>>
>> Changes in v3:
>> Indentation fixups
>> Remove unused headers
>> Remove #define leftovers
>> Use devm_get_clk_optional_enabled
>> Use ilog2 instead of fls()-1
>> Magic "23" replaced
>> Explain the extra "0" in read/write register
>> use guard() from cleanup.h
>> use REGCACHE_MAPLE
>>
>> Changes in v2:
>> Remove accidental "default y" in Kconfig
>> Indentation and similar cosmetic fixes
>> Magic numbers into constants
>> Short return paths in read_raw and write_raw
>> DMA buffer alignment
>> Bounce buffer is u32 instead of u8
>> Avoid races using claim_direct_mode
>> Check errors on all register accesses
>> Immediate SPI restart to reduce underruns
>> "name" is chip name, not unique
> I missed this until having a final read through but it's not the chip nam=
e
> in the driver currently - the name is always ads1298 despite there being =
a handy
> ID register that tells us what we actually have.
>
>
>>   drivers/iio/adc/Kconfig      |  11 +
>>   drivers/iio/adc/Makefile     |   1 +
>>   drivers/iio/adc/ti-ads1298.c | 766 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 778 insertions(+)
>>   create mode 100644 drivers/iio/adc/ti-ads1298.c
>> +
>> +static const char *ads1298_family_name(unsigned int id)
>> +{
>> +	switch (id & ADS1298_MASK_ID_FAMILY) {
>> +	case ADS1298_ID_FAMILY_ADS129X:
>> +		return "ADS129x";
>> +	case ADS1298_ID_FAMILY_ADS129XR:
>> +		return "ADS129xR";
>> +	default:
>> +		return "(unknown)";
>> +	}
>> +}
> ...
>
>> +static int ads1298_probe(struct spi_device *spi)
>> +{
> ...
>
>> +
>> +	priv->tx_buffer[0] =3D ADS1298_CMD_RDATA;
>> +	priv->rdata_xfer.tx_buf =3D priv->tx_buffer;
>> +	priv->rdata_xfer.rx_buf =3D priv->rx_buffer;
>> +	priv->rdata_xfer.len =3D ADS1298_SPI_RDATA_BUFFER_SIZE;
>> +	/* Must keep CS low for 4 clocks */
>> +	priv->rdata_xfer.delay.value =3D 2;
>> +	priv->rdata_xfer.delay.unit =3D SPI_DELAY_UNIT_USECS;
>> +	spi_message_init_with_transfers(&priv->rdata_msg, &priv->rdata_xfer, 1=
);
>> +	priv->rdata_msg.complete =3D &ads1298_rdata_complete;
>> +	priv->rdata_msg.context =3D indio_dev;
>> +
>> +	indio_dev->name =3D spi_get_device_id(spi)->name;
> I was going to just tweak this whilst applying.  Using the spi device id =
often
> ends up being fragile in the long term because of the split between the d=
ifferent
> ID tables and the mess that happens if fallback compatibles are in use an=
d
> the spi IDs are missing (you will get a warning about this at runtime
> but it'll carry on anyway).
>
> Easier to just hard code the name for now and when you have multiple
> devices supported, add this to a chip_info type structure.
> Or we could make it support the more specific name given the detection ab=
ove.
> Is there a reason to not do that given a more accurate name is
> easy to work out and may be useful to a user?
>
The only reason I tried to make the "name" unique is that IIO=20
oscilloscope (ab)uses "name" as a unique identifier. That's something=20
that ought to be fixed in IIO oscilloscope.

Giving the chip name would reveal the actual detected hardware, there's=20
currently no other way for the user to find that out.

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




