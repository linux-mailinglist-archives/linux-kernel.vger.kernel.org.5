Return-Path: <linux-kernel+bounces-32864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0DC836112
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2F41F25D97
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481963C694;
	Mon, 22 Jan 2024 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="s3yUnW4R"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D494A989;
	Mon, 22 Jan 2024 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921603; cv=fail; b=P33jmsk31Owclfz3qkALFYFjMxuof7k+X+eIHPS06RRhwhpESUrBSMrbgiR85tqbCvhEGAdSGIHrAejOEB3+p8aTyyjgm6LsEn+ca2K3PpBgSTPDOfekwGiN4RQUJ6ELvOz5yo4Qu3BsUBzwSmfQX/K2nE8sVlsRUrFDJmFpUQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921603; c=relaxed/simple;
	bh=faW5RWR/u+kxBc8TMstJMbmhQEca0faOuPgH9ZY+viU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T0OCrk6INpjYErXjn9zOA1aMJR2pgaBc6QC9eTMHYxfkEQkaqY/YOlMdhH1KAhmGkusmIVTGgPY2MS02UQRAxCmRNoVLKQdqPkI/b56ZY7ooKg4UEpqw2yUS4cgb5iikh/k4AbK2vHSK2OpAyHZexXtd8BBxAR3ke1nPzRExqAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b=s3yUnW4R; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M9EpAs006472;
	Mon, 22 Jan 2024 06:06:11 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vrby6xs0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 06:06:11 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dx5BOw9UN41ec/qYlqGDmIzSGyEAP/JlMfvse0bcJGSLEtNmKFvvxchDlRZBgB8G+/GZZjD/8ofBaTbR+lWJJ+S5N7uX7Pqq/lw32q489NdafSAoeR2npW2WhQl+ewusCrKOPpTCnTtxDMSvlhmaOZBHKr6tooFwcHOqCeZ3WKoD9phr71DY8S7zFqjm8zWaIM19HuEKAw1z2J/IXYzaYE9xZ6FkoEDgvRuZIGqqS7z4TTPUnxYR6tBZWj6Dnh05HoLi7PbVBGvBnd60UzLsU9D2MrOXMexXc7u7Y8JNJtVo4L+xM8D+3hDi4mgmt2pjT0iilvBYr7Uy8flbmkEXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTdDsnpSRPVep3uIBzQy61Fyqo3QljuM7USY9eytxfo=;
 b=OqhbonjaFPt0yLD9bDYiXM/Q46/oRJ4TqlPvYOlYVNZQ6VG1mVHRLOn+SOzKA9bY79y5nXg/Cl6Q4VdCNSNXWdsp22NLXwtMELxRZqEYqCkVG0UJWRw3k10ZlbydhQQuVh5/5PJuszfTW3yMOZ6woAf7WLw3juWi0/fdJLZcAnpXBFmV3wHEnuY1TA4PZXiOhp1fgJ5FXN6/YEiXn64HjRI97um+wZf5XiOSXZcLHQ9pg8C94E3QkKY21TRTqJAWX7R2vssU88WLu0fv0QCRNHwK8OkHP/4Ay8QHOIxgdAjc3PyYc6eXNRuCNUk2yxOO+jdvePxaTTeNK1bolLxSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTdDsnpSRPVep3uIBzQy61Fyqo3QljuM7USY9eytxfo=;
 b=s3yUnW4Ru1LcH63qs3or73LKE9zsyUaWc+qvPUguO5HqRHTFqUduHGD3wMjB/sKLp6gaA9meJs13DoJ/hh8JP7jdMxE2EEUuTd7ULXaF/TtDgUlen3sU6CdUuua24qEtYmPiuBTP+6948Icg1kJM3BvO9Qvh1tVsqNhvwi/7C34=
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by SN4PR03MB6750.namprd03.prod.outlook.com (2603:10b6:806:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 11:06:08 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::ad49:e4d6:441b:28cb]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::ad49:e4d6:441b:28cb%5]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 11:06:08 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan
 Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Crt Mori <cmo@melexis.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?iso-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>
Subject: RE: [PATCH v7 1/2] dt-bindings: iio: frequency: add admfm2000
Thread-Topic: [PATCH v7 1/2] dt-bindings: iio: frequency: add admfm2000
Thread-Index: AQHaTRHL38sLnWxA1EGaHMlrfAP5/LDllQgAgAAHLsA=
Date: Mon, 22 Jan 2024 11:06:08 +0000
Message-ID: 
 <PH0PR03MB7141A46C8DD0041775CD0E96F9752@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240122090228.28363-1-kimseer.paller@analog.com>
 <20240122-legible-fossil-25349ef9ad6c@spud>
In-Reply-To: <20240122-legible-fossil-25349ef9ad6c@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcj?=
 =?iso-8859-1?Q?JcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy0zYzgzNWNjMS1iOTE2LTExZWUtYWFjZS?=
 =?iso-8859-1?Q?0xNDc1NWIzNWRkYzhcYW1lLXRlc3RcM2M4MzVjYzMtYjkxNi0xMWVlLWFh?=
 =?iso-8859-1?Q?Y2UtMTQ3NTViMzVkZGM4Ym9keS50eHQiIHN6PSIzNjI4IiB0PSIxMzM1MD?=
 =?iso-8859-1?Q?M5NTE2NjA5NjQwMTkiIGg9IjJtOWRDSnpnR3ZraFIwZC95RzB4R21iRHJC?=
 =?iso-8859-1?Q?MD0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBQ3oyTnorSWszYUFkbENJNERJWnZxRjJVSWpnTWhtK29V?=
 =?iso-8859-1?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBbEdUR1ZnQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-1?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-1?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-1?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-1?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-1?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-1?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|SN4PR03MB6750:EE_
x-ms-office365-filtering-correlation-id: c65b4c97-f7e1-4d33-db53-08dc1b3a22e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Mm2idhapaI+c5T9ro9qLHhebwzsWm2pQiGEEmAiJJ+YrEJESGWh8gzC7/gPOuipNmBEVjz7MWiwa4xMfVo4K67seQJLcxZtggJnxJROfjcahyqReubanUXYj3aZVF7jI8btQV6pzWEuBVgxns2lqeQZjv54eOXXGUrjiYgEZ7Enq++LoRXBA2th1xYgG0eiHP4Y5KQva0zL2Rr5QltbaqZ6YAshXhzKvVcHl4a6h3Kd16W25hVdKmLzFcVhd2gIHGXvFRtzZE49LaCFvvfojJH56qUFNXhUfbnpoLVBM7GtNVmC52S+pHefSGIM9ua6s6Vf06SgvcRsf2YbTxj5j33PlWWHx+7VEmNRnJbbLQqCAyChEx9taCrJJVpFRIxEZgpC4d4xYSzXM7j2a85pKQLjSUcoN8A3y3Oa/qkLzf9BfHIdyY1Q9+G2ek3ug+OLh6xdnseUtMovWC0/1kLhlwdGhzyAbe7I3WJniClBBBP6KjBXwzCmJY6i3R8AMA1GxtCesqMmpN/KfZGQ/y0hf4CpBihMgfWa/MlaiM8pr0GRC9spoUNdvRoURXX0ICkDnkMRJCgHgCb1Mhi63pMhYbDkfs35BFCZpeBfPzqgu0kmfXJs4abcROfJCdf7EE6Q3
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8676002)(52536014)(8936002)(5660300002)(7416002)(4326008)(33656002)(2906002)(316002)(86362001)(54906003)(66946007)(66556008)(76116006)(66476007)(66446008)(64756008)(38070700009)(478600001)(38100700002)(6916009)(122000001)(7696005)(9686003)(6506007)(71200400001)(83380400001)(26005)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?kJ1I6SSqsnh6fBTkSZjEBKx5BFAnbtL0+a7BDYQXWB8i41Zml3+HQyi8lI?=
 =?iso-8859-1?Q?+d8pBgdHKzCUGxS+WsE3iUpmNL0jOISxvGcR8jC9HLYTtIO6ceakA2nTZm?=
 =?iso-8859-1?Q?8Payj0rOyQeUDQxzfWMQSbBlMNvzwBSbHmRrGABj1qIK4Yly/8iaOU6syV?=
 =?iso-8859-1?Q?qxrHQwKhlNStxB3xheDVeHIZjmlPEQSJ3AluVZX5HAkZN8SuQewm/cTBzu?=
 =?iso-8859-1?Q?YToxBJcJH3Dw069rNJEAK73OMtK6QayFkkvS6c47LafxLlxKBaVb0Q/9nN?=
 =?iso-8859-1?Q?H0ezTyxtzGmxE4CnJpl0/Wkl+d/5n2EFSW8fUZnoHojG9xNSuv8sNVq2so?=
 =?iso-8859-1?Q?RXWgdKcj1wLf0k+FB7B7qw6tcGDqx6r1Sn7gX22+L2DgNS6w25LYKAksVM?=
 =?iso-8859-1?Q?vOZO3B+UArzpMo++JOUc+tLqN9FfKJ7WF7Cqb8tikyc8J/hcFAUbBhsPbU?=
 =?iso-8859-1?Q?in9WYNuEPhnMdfQS0xHv4tgxzVvn5sYhwKWBY9SD3vANwUZZHrj7Mue41Q?=
 =?iso-8859-1?Q?6iJvNnVujJg8h4YR1i6gbL24DcnKzzjSnJ/wsgzLPVeimBh7asreuEEuYE?=
 =?iso-8859-1?Q?DXbtdyJ7HZGMX8uU26YiC/+0S8edMzDuzgnN+Qlj3AIba62/lSi3pmRa4/?=
 =?iso-8859-1?Q?BpWFRAunqhE+xsJ3qe/0saQFa0RlY7KmISKwp5zphWqr/3t0g+aSKG92np?=
 =?iso-8859-1?Q?oa4/+W5ihZdtSwb7DQbw2LLhPOcWPH4buLPSjeYp2+tCR6Bz3epmzJ2F3X?=
 =?iso-8859-1?Q?cBMYrj+pKJYKdTNKM17gsm+Z6XPRcwySQSYT7Uqgl7EVi2CWo4Prau6Six?=
 =?iso-8859-1?Q?wdT1+dNpDDrzSZ+jBDPktIRD9SgF+7uBXZwaMESe9tP12blRxpc8KkKCAR?=
 =?iso-8859-1?Q?opdeCWh+gJmk83Z2P/Id3q/T8sT9yAyi4X8aqVC+7OrPCgbJjnJsU/x4OQ?=
 =?iso-8859-1?Q?I7PdGPqhOf4LbNdNn8KeL6W/f2RtblhjHkQLl07AvfMhzivcyNOfUrPv9J?=
 =?iso-8859-1?Q?Slr2Z4mTLEHpY/cux5ky4L8xN61WcHfKUK1R3USoQlT8UDd/mtspxhw/mn?=
 =?iso-8859-1?Q?e3e17kCAE5eaAta24vRrcvL/ymnrQnl+9cY7hTOspfeTbfmDA8kEwcYwX0?=
 =?iso-8859-1?Q?1ra80YJvrKg/c6npgQUE6oNxngG839tzJpedMAlhZk+WqSepGNbKxumwF8?=
 =?iso-8859-1?Q?kKzn3n1OVsTtTM54NfAwJ7PgLBFHJIcFdBGyb8IbJmOC91ytBleErLbbPX?=
 =?iso-8859-1?Q?hgWqjHgP1JEh05wtsChqMO+b1TgZaXEQypo5u4XCxfLbc0mAxODIlfamWG?=
 =?iso-8859-1?Q?5P+ELia8cSE1qqVvGFFhlaJrmlii4VWyrJrx2NxGc9jnftSMpLPuc1dCTo?=
 =?iso-8859-1?Q?KyxWmjTSnOi0xn3WFdBufnT/5YQWqTA+TfQQyjeVbCjfTgViDpPpc4nkzc?=
 =?iso-8859-1?Q?pBGRhVpvmWprCmJa+R0q8kTyOdUduz60dnFpmz5Wxz5ZWM0kxrAx9QPfpi?=
 =?iso-8859-1?Q?YeJQz8QwP5MTZGtg5VQOsUXv7qL7Txmuhmv1K4uulKbmz4NfUaWxKzl17f?=
 =?iso-8859-1?Q?4UCpfXtptaGLy8I6cCHsut4/jxNm9z7oAYa/D0Yi9VX+Kw2raUl382sv0P?=
 =?iso-8859-1?Q?yMCpnPsnX2UIVJimBgkiltKnEY2FKtLjnk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65b4c97-f7e1-4d33-db53-08dc1b3a22e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 11:06:08.6867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIKiefBJ85sfQtZXFmjAKIbyY/aOAmv+W2E/xbxRLYcca7IANWr8JZrOYz+YT8p0KE8PQ3YEvQBL3kr0+tvA+EXj0I0U1m+fGe+KX5Q4+eM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB6750
X-Proofpoint-GUID: BksP4qGj7YGOpP0_6MQHapVcC5I3a4gA
X-Proofpoint-ORIG-GUID: BksP4qGj7YGOpP0_6MQHapVcC5I3a4gA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_01,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=980 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401220079

> > +      adi,mixer-mode:
> > +        description:
> > +          Enable mixer mode.
> > +        type: boolean
> > +
> > +      switch-gpios:
> > +        description: |
> > +          GPIOs to select the RF path for the channel.
> > +          SW-CH1   CTRL-A   CTRL-B
> > +          SW-CH2   CTRL-A   CTRL-B    CH1 Status        CH2 Status
> > +                   1        0         Direct IF mode    Mixer mode
> > +                   0        1         Mixer mode        Direct IF mode
>=20
> I cannot make sense of this table you have here, the double header row yo=
u
> have going on is hard to follow. There's also no mention here of what hap=
pens
> when both GPIOs are 0 or both GPIO are 1. Are these configurations permit=
ted?

I also feel that it's quite hard to understand without the gridlines. In th=
e preliminary
datasheet, it's a switch control table, and I'm trying to replicate the way=
 it is presented.

On the table, each channel has control pins (CTRL-A and CTRL-B). For a mixe=
r mode
configuration on channel 1, CTRL-A GPIO should be 0, and CTRL-B GPIO should=
 be 1.
It's not permitted when both GPIOs are 0 or both GPIOs are 1. The state for=
 the GPIO
should strictly follow the truth table.

I'm considering making it much easier to understand by creating two separat=
e tables for
each channel, just like the example below. Or is it preferred if it could b=
e discussed in=20
a sort of paragraph form?

SW-CH1   CTRL-A   CTRL-B    CH1 Status            CH2 Status
	   1              0              Direct IF mode     Mixer

SW-CH2   CTRL-A   CTRL-B    CH1 Status            CH2 Status
          	    0            1               Direct IF mode     Mixer

Best regards,
Kim

