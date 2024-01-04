Return-Path: <linux-kernel+bounces-16937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5A824645
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F99282456
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B73D25567;
	Thu,  4 Jan 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Fsqp38m9";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Fsqp38m9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02hn2246.outbound.protection.outlook.com [52.100.201.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF842555E;
	Thu,  4 Jan 2024 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=VtPbfw1t2DcsLAIKLi5RmG39Ue7fQNHUcd6XSV+geQrjFTyBELDcbROAvxiI/gCIhu2mZCf1gj1Q32neKdnocHAZ+t5pYY/+aac4+aqw18E4MJWpcyTsUyXNZV1fiLQXxkxui5dsSvNcOF7gNPp8H1HE2ov3XG6oy7x2AXnK93ea9naI1FWHjOZo921TdxjaGafAyHj8Yjd9iSh1yET0jBENracQxtXrOK6XFyubL9mMR5Jx48FaiJ10wBUpXa4VaNuAgcmZnNJpm9T/PYOrziNYcqyw10F2utq002C3CvOXY8gVLbklWCPD9XTkeT3z8oWLTlIjaGw/AJztsvexcw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPVVVkDBdXERxfMzZx6Bup79SPFOyhxGWQiej0pyXKE=;
 b=VQUkJqNTvElBpx2PstyWfALO41FE3kW9WnHoTZCdklrEh+Yq+I2l5GQmPQV7JAWUWC0JMtl86oTAzoejuihBkLY9eV7iIPLN5/ZhJamnl/Y0cV4Ao9kz5/0Hlc9eIGiVdq21FfX8R/v8LEQmCbY+P8b/V4SIuEYJYDmB6aaif+Uhs2ZP33+W874CwKs/eNGgl6YDVI3qmmGDTqHwLMBhTyq00sffnI+yWXS5TMBrJeaDyT36eNx/g7nYKFddok+EowiizLwyU4M9zvgk3L8cJKrOO6aZZDDl/OiNJP4d79PznFf1VrT0SZyR1LZBLJPrPLjzqlaiCTPt7eUGPU6RQw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPVVVkDBdXERxfMzZx6Bup79SPFOyhxGWQiej0pyXKE=;
 b=Fsqp38m9vufIG0djldRIBxm+sr++QT8ZgV4x8xc8Fi148HSQPlL1/itMR2k5UDi0UwhSswodRPpKBlBqSCPypQ3yRVRbk8W5WlqNMNh7Q1vrhDg1UtM4gVBxf9UUcYmpqUyyTmWTVSR4QHfD0g8eZ7ekikYGct0tWrCWSiByetq0EK/mqMedv65fPqpuAo+vnSqCXzifmOPdn+ke7R29DOdI95x2DQveZCpsSlQJQo3PejyV3fwwhgQuXScGF3Ef+LSwf2gNgxrn+bJCz5Z65P9vUyNcPxJ58PRdoex4l8ZumUqdlhkX3UPWxG8WFwmKAlM3HT0ntp9Zh4wIUWH3cQ==
Received: from FR5P281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:f2::10)
 by PAXPR03MB7700.eurprd03.prod.outlook.com (2603:10a6:102:206::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 16:30:56 +0000
Received: from VI1EUR05FT068.eop-eur05.prod.protection.outlook.com
 (2603:10a6:d10:f2:cafe::1f) by FR5P281CA0008.outlook.office365.com
 (2603:10a6:d10:f2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 16:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 VI1EUR05FT068.mail.protection.outlook.com (10.233.242.179) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.27 via Frontend Transport; Thu, 4 Jan 2024 16:30:56 +0000
Received: from outmta (unknown [192.168.82.135])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id CEDA92009538C;
	Thu,  4 Jan 2024 16:30:55 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (unknown [104.47.2.50])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id DCC9A2008006F;
	Thu,  4 Jan 2024 16:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3cQGuvC5+XnraYbPDazH4Wrt4HlamFMKCuYn2RGVQSQqSeSV0aR0VzNPTLYJiNng9oYy5mEKYxtBb+kEqkoCoLHIn0+MaRe1o7XJ6rqON5KadeWyr7bsjJZYcXxx34R6kGV/WfKabh1tycw2njI5X9oi0QSbg9Tihvsa25xwHPTCr0sAvKGchYrz4fyChI9Tjm2sDpWjgpkyw7hCwhAT2Rt8o13i17jnDGnNkRgGHMkTpi3uB/sNJaLpBU9jqqq0ygyMuQM/g1qO3zvJy5P5qDf7LNpPp/vILZOoqft/kp2Qrx6UTkpFC2B9e1QIwtmUaS7cE8BHDBc7+akbdP7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPVVVkDBdXERxfMzZx6Bup79SPFOyhxGWQiej0pyXKE=;
 b=BMO6YXnXaaOCPygHNnLL8XPmTmedpNrSo/Z8sSXhP4ann249RraiDcnRJKsZdJMqesRHqGx03f7stEsXk6IRgyXYoglEFpI959Y5djlg0jQIx4Rcw/Z6DQ6EwjnwCd1SNuUu+I9Dr6Gxg613hJXDLVTqfUkZIP3J2h2P07zXfGDxR572NNlJgtH0mP3gvhqUxKxCFsUJQ9smVL/2VNI2RoUVrp55ucK830uSd0FJAMUftn2Fquw+UJTyjIVCb1zwJ/pV2P0SG5iDS26X49ZAV5p3KjIDF6OO/0aFhhI8X1twQWjgOrq+6mmnrf7xaZvZwESV2eKDg30X1zGeijWYcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPVVVkDBdXERxfMzZx6Bup79SPFOyhxGWQiej0pyXKE=;
 b=Fsqp38m9vufIG0djldRIBxm+sr++QT8ZgV4x8xc8Fi148HSQPlL1/itMR2k5UDi0UwhSswodRPpKBlBqSCPypQ3yRVRbk8W5WlqNMNh7Q1vrhDg1UtM4gVBxf9UUcYmpqUyyTmWTVSR4QHfD0g8eZ7ekikYGct0tWrCWSiByetq0EK/mqMedv65fPqpuAo+vnSqCXzifmOPdn+ke7R29DOdI95x2DQveZCpsSlQJQo3PejyV3fwwhgQuXScGF3Ef+LSwf2gNgxrn+bJCz5Z65P9vUyNcPxJ58PRdoex4l8ZumUqdlhkX3UPWxG8WFwmKAlM3HT0ntp9Zh4wIUWH3cQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by VI1PR03MB6608.eurprd03.prod.outlook.com (2603:10a6:800:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 16:30:48 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::5cfa:9e05:d8dc:ba0f%7]) with mapi id 15.20.7135.028; Thu, 4 Jan 2024
 16:30:48 +0000
Message-ID: <2be19fbf-4c73-4594-be42-31587dc7b747@seco.com>
Date: Thu, 4 Jan 2024 11:30:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reset: add GPIO-based reset controller
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
References: <20231222150133.732662-1-krzysztof.kozlowski@linaro.org>
 <20231222150133.732662-3-krzysztof.kozlowski@linaro.org>
 <530e3473-eb3b-477c-8599-e7aa12779640@seco.com>
 <88bd6668-7e67-42c7-97b6-d7029f371349@linaro.org>
 <075990bb-5fdb-4d30-9484-9df6b978e805@seco.com>
 <fcbae47b-3b28-42f0-b93f-f83932025dc1@linaro.org>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <fcbae47b-3b28-42f0-b93f-f83932025dc1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0203.namprd05.prod.outlook.com
 (2603:10b6:a03:330::28) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|VI1PR03MB6608:EE_|VI1EUR05FT068:EE_|PAXPR03MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8e4d7a-c016-4ef7-bd97-08dc0d4286e7
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 m2P8j/O13P7fe+yD4o4VrTAlehiT9xzvci8PVkjql4qdC8LOzmQY+ApyqEpoOwY1HrUCiQau6h4XW2TYjSY4Ce+BcBpbQURo6hb+L53+CNOkF64PCZuIOj5XAVc1I+aJjqSYE+kZe420w4OxP3Sn6qB769WUe9AVf3+1xBAbkhZz4UNYCM6oq0UTRn1EhU9/gV9aMgeCmk8R8H9P4gatcqYyuhE3NmM7stK+KZ70uV5EcE6aAaLew26nEwjVW9PwopRpa/H7WMcQawbnlYLjkbSqBGUqPuTyZSjfAcnAlBMu98KxKOJDGE5hfaN/BML+I0ap78kZs2r9Lajfc5OQHlb7d5T1Rf5Bd4IZqBUKeXLbozw18Eaj9J9w0nnCjbxK6NK3OTDVnAOXLW0g1p8/SxZ1/OC4BqyUrNLAbMjzjxddXsfpUYE+NbLKI2tEp9clPs+vWLdC3DTkewsQ/a1Jh8Wvx8lrz6N/HOcRz4dYzvqLBJEZjnUDJ1NiuiYVY9eUlf3YvsgAeZ96ErBcqD3rcZxxVgP/jXYoevUD5cLHnPg4zYLCusmmsWP9iaiszNJ2VTxaWS3Scb+PF/eBP8bRh/+d5B2RKKOX3urQrjW5AR/g4H7sn1QLdS9bjMnN5xKmpo5+Eh0FBa5dadlhbDANCdHHlU2mLFmGNcOB//KohhmbtI1FZymIs3ZnwDFZRpWAnU89CtykNWL1P32ZkwJ8rA==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39840400004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(4326008)(31686004)(7416002)(44832011)(5660300002)(2906002)(8676002)(8936002)(316002)(110136005)(66946007)(66476007)(66556008)(6486002)(41300700001)(6506007)(478600001)(921011)(6512007)(38350700005)(53546011)(6666004)(2616005)(36756003)(26005)(83380400001)(86362001)(38100700002)(31696002)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6608
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 VI1EUR05FT068.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b5505bf8-1c52-4d98-8724-08dc0d428223
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AO3Xav7poDkee0ANy7aPd1LajgCvdWKJcVcXhwWCte4lzqfqOw0x8R4yTcQ5lDaL/DUfRRe++C3oYf9QMrqha4D5Xd51eHEeNJuwfZ4yPOnxejRkLp7bTy4gFinBpDJ/AMMv6f/U0KubdPzZoAkexP7vheYM1EE6DheF2+W1zmBl/x5WG8SzXn2VZ+JvxF0OMXzHhZeiMxGUluvSEUfWDd1H7nnrtgVC+YjZ2RSls1TwdZic9jYIIo5HxNzri0vmQGisfg23iGqCZnUByexk+NUm/ZMeSgFg9T5P+CdaX1yebUykU6gpaCD0AO9T2Ax8dxHFQhQXBpe14h142J73Z2psGVRth5cUNr6FqJPN46er8m8sDvHVkQz5pweoF5r83uteKMQhdroMh5kPk08jd4VPvx/lrFb4Zpv7rv2Ojy/+j9p9StmyLockIrO1KP5agdgxu1yRd+ozQ8Vt0BAn4IHxOrsfvdcGyOKWPFNcvqYFupt8IwMght8XoZq2s9DXr8NT4Nb8zgFtgTIo9+p9k7tSl5b1vDhwoAFTHBIF9Vu1DWmRD4ng6awTQW51hCem+/2sYKKCFy06L2NFci0A/7o7/mmh612brfL81gKjvAPbSzaJyjpRRrHNPPYt2ptqqWpSp8BNfzU1sj3O02yzeEPL/WL8/la9dSpljVds92pZhMQRq8VwlNPyu6LtXbdvVl/0PkLmSUg8oZqNCz+IDlUANlIoaQ9uZOMKaZKhxe25DBKgWfuW18TxenSe6pivCPtz7cBKy4aDnNEROkYkUWprWX5Z6BGPAMcMmMwWSPl6F3Dcgg1mG1FA8g+7zrPBJ6MiW8fqmMa1U0hdzQesdEf85WQo7uY5gdjAyZ2SxxI=
X-Forefront-Antispam-Report:
	CIP:20.160.56.80;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(39850400004)(346002)(396003)(136003)(376002)(230922051799003)(1800799012)(451199024)(5400799018)(82310400011)(64100799003)(186009)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(36756003)(31686004)(6486002)(921011)(53546011)(70206006)(478600001)(6506007)(6512007)(70586007)(86362001)(31696002)(336012)(83380400001)(2616005)(356005)(7636003)(7596003)(26005)(47076005)(34020700004)(7416002)(2906002)(5660300002)(316002)(6666004)(36860700001)(44832011)(4326008)(82740400003)(41300700001)(110136005)(8936002)(8676002)(43740500002)(12100799051);DIR:OUT;SFP:1501;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:30:56.1010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8e4d7a-c016-4ef7-bd97-08dc0d4286e7
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.80];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT068.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7700

On 1/4/24 11:08, Krzysztof Kozlowski wrote:
> On 04/01/2024 17:04, Sean Anderson wrote:
>> On 1/4/24 03:57, Krzysztof Kozlowski wrote:
>>> On 28/12/2023 17:05, Sean Anderson wrote:
>>>> On 12/22/23 10:01, Krzysztof Kozlowski wrote:
>>>>> Add simple driver to control GPIO-based resets using the reset
>>>>> controller API for the cases when the GPIOs are shared and reset should
>>>>> be coordinated.  The driver is expected to be used by reset core
>>>>> framework for ad-hoc reset controllers.
>>>>
>>>> How do we handle power sequencing? Often GPIOs need some pre/post delay in
>>>> order to ensure proper power sequencing. For regular reset drivers, this is
>>>> internal to the driver.
>>>
>>> It's not part of this patchset. Power sequencing is an old topic and
>>> generic solutions were failing, rejected, did not solve the problems,
>>> etc (choose your reason).
>>>
>>> Delays are device specific, so they go to drivers (depending on the
>>> compatible). Complex power sequencing is way too much for simplified
>>> reset-framework handling, so anyway it is expected you do it in your driver.
>> 
>> Well, the reason to bring it up is twofold:
>> 
>> - Traditionally, drivers expect the reset controller to handle all
>>   necessary delays. For example, reset-k210 includes a 10us delay
>>   between asserting and deasserting the reset. There's a similar thing
>>   in reset-imx7, and several other reset drivers.
>> - We would need to add custom assert/deassert delays to every driver
>>   using this interface. These are not always added, since any given
>>   device may require delays which can be inferred from its compatible.
>>   However, an integrated system may require delays to be different from
>>   what any individual device requires.
>> 
>>>>
>>>> Maybe something like
>>>>
>>>> my-device {
>>>> 	reset-gpios = <&gpio 555 GPIO_ACTIVE_LOW>;
>>>>         reset-gpios-post-deassert-us = <100>;
>>>
>>> Feel free to add it later. This patchset, and actually all patches
>>> should, solves one problem while allowing you to extend it later.
>> 
>> Yes, but we should try to avoid creating problems for ourselves in the
>> future.
>> 
>>> If there is a architectural problem in my approach not allowing you to
>>> extend it later, then we should discuss it.
>> 
>> Well, I brought up just such an architectural issue below...
> 
> Sorry, but where the issue? You did not present any arguments stating
> that it is not possible to add your feature.
> 
> What is the problem to parse that property?
> 
>> 
>>>> };
>>>>
>>>> Of course, this is a bit ambiguous if you have multiple devices using the same
>>>> GPIO with different delays.
>> 
>> This is the most concerning one to me.
>> 
>>>> Maybe we take the max? But the driver below seems
>>>> to only have access to one device. Which I suppose begs the question: how do
>>>> we know when it's safe to deassert the reset (e.g. we've gotten to the point
>>>> where all devices using this reset gpio have gotten far enough to detect that
>>>> they use it)?
>>>
>>> The driver (reset consumer) knows when it is safe or not. You must
>>> implement proper reset handling in your driver.
>> 
>> The driver has no idea whether it is safe or not. It just calls
>> reset_assert/deassert at the appropriate time, and the reset
>> framework/controller is supposed to coordinate things so e.g. the device
>> doesn't get reset multiple times as multiple drivers all probe.
> 
> 
> Sorry, then I don't get what you refer to. The driver calls deassert
> when it is safe for it to do it, so the driver *knows*. Now, you claim
> that driver does not know that... core also does not know, so no one knows.

Yes! That is the problem with this design. Someone has to coordinate the
reset, and it can't be the driver. But the core also doesn't have enough
information. So no one can do it.

For example, say we want to share a reset GPIO between two devices. Each
device has the following constraints:

device post-assert delay post-deassert delay
====== ================= ===================
A                  500us                 1ms
B                    1ms               300us

If we leave things up to the drivers, then whoever probes first will get
to decide the reset sequence.

So if we choose the post-assert delay to be 1ms and the post-deassert
delay to be 1ms then everyone is happy. How can we make sure the reset
controller enforces this? Well, we can do the above thing and specify
something like

A {
    reset-gpios = <&gpio 555 GPIO_ACTIVE_LOW>;
    reset-gpios-post-assert-us = <1000>;
    reset-gpios-post-deassert-us = <1000>;
};

B {
    reset-gpios = <&gpio 555 GPIO_ACTIVE_LOW>;
};

But what if B gets probed first? Then we will have to also specify the
delays on B as well. I'm not a big fan of this because

- We have to specify (identical) delays in every consumer (instead of
  having a central place to put the delays)
- Having the delays depend on the probe order (if one of the consumers'
  delays don't match) will result in bugs for board maintainers. Maybe
  we should just warn in that case and that is enough?
- Actually, the same problem exists for reset-gpios (e.g. if one driver
  specifies ACTIVE_HIGH and another specifies ACTIVE_LOW).

Maybe the delays should go instead on the gpio controller? So something
like (taking inspiration from gpio-hog):

gpio {
	gpio-controller;
	#gpio-cells = <2>;

	my-reset {
		gpio-reset;
		gpio = <555 GPIO_ACTIVE_LOW>;
		post-assert-us = <1000>;
		post-deassert-us = <1000>;
	};
};

> Hm, wait, now maybe I understand your concern. Did you read the
> patchset? This is for the coordinated, shared, non-exclusive reset by
> design.  And as stated during previous discussions: that's the driver's
> job to be sure it is called like that.

Well, one of the major advantages of moving GPIO resets to a reset
controller is that the reset framework can coordinate things if we want.
This is a rather natural extension of this patchset IMO. Even if you are
not adding this functionality now, it is good not to make it difficult
for future work.

--Sean

