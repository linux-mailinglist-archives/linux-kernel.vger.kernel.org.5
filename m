Return-Path: <linux-kernel+bounces-30943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF883266C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C662285D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5B826AEC;
	Fri, 19 Jan 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="7duhyToJ"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D25E1E89B;
	Fri, 19 Jan 2024 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655827; cv=fail; b=tiV+185xf21QtjYW/DDjaADrDC+QdlTkYRKE290zF/pg/pga05ByJpx4lUF6+25vkgySWcOTlQwAL6RO90v3EYoLmFjFLLeCz47S833yX/z3ap7QCIR229e73vz3SO97qbdy9PRrwmBMJEIED/NollHfPStCXKFRuImclbHXCuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655827; c=relaxed/simple;
	bh=58gr/a/lmRDbt+lja/o6XAxjpPd/jVFNPxh+GzUzHL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VOBQAaKZBIsza6MF0crG4rYW9PPSGrhVWuLhUOgGR2yKfyBv+0rS/u/z+gIlO1JF2nXHXxC2L35wBjTv7+yoDKzxVb9OdV6kbnDAZ/apy6KT1XFIFrrg7spaPo/Ytc1C3/3d/eTIW2xRLZE1t5UwZa31KWIb5mERYRmuVd5uXQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b=7duhyToJ; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J8CajK003299;
	Fri, 19 Jan 2024 04:16:48 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3vkr17r9f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 04:16:47 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2d/C9/KeRMgoTB+f5+rgRHxzgYg7DZqc1hXo05DP47yr13D6ogqAcvV2707yyX3VH0BN92B33QvOrQgGmPrRn+3/bQ3C9mF9uQaIT3/S2GtDyqHnF5kf2DIXIQXSFFECwPhe4ohrNnr3PpdRNUxFP2Vaj4Nfa9rYFEePOXfw70lg69r7rO6PEuJv2fQY2Mk8l8SSYxcRXBakJyh7isg34mTFkv7zfqEFedQiZRPRoDbFWc8ocIGg6ObzdTqA/RGmCFImHP5N1pwDJ9gTAZwV7Sdrcer1LAStmkAFhtmQyY56sS3115/C7OnfOdL7cD+M0fqdzDoW0ftBzvSbKS4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp165DVykPT777nq6G5tTw4dAt+J0VoFrdwX2PQrI1o=;
 b=KXeAvxzvGbG1hyi21AyAObjTv6sDQjVU6HdjVfXSqaI0JxL0R0Enr89ZJR/4BYilhaObNuOvBFHSZPPmBn9S0WEkAKl8VKqQs5OrvKBEHZAuTNs3lhEf22Y+0V/tiYn4/FzS4kDbmuMMLAQ8rV0MlpML76uzQX+OyqJD18ilYkpiE3mmpMid+k/j+JctnsIifR8g9XEic3mw6lelHXAlXycEtfOYlL/ML6NrJP0XyeWx1vy3RwuZoBF6tT+LDUmytOWW4iK4n0wUgjuP95VEwkPSoQCoT6D03oG4TRj83xdNm264Ai3BNE4wY4Rd2KtRJ0a869p3s7e2gAYhVuRSPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp165DVykPT777nq6G5tTw4dAt+J0VoFrdwX2PQrI1o=;
 b=7duhyToJ2nRfonpBZkRJyc+WCoIdEz3PG+TnlXRxU0j5/JOP+wE1Y47F2uvwHKKG33GpGvbb1O8zfvlVkzogvqJVVaKxZuedZB1eSYPmZuN5fJUqG0MrXx7HDmHzTQjYdZGT9cNkQrcq0e63Fy9gGvDODF8G693cozy96x6tvKQ=
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by MW4PR03MB6635.namprd03.prod.outlook.com (2603:10b6:303:12a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 09:16:45 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::ad49:e4d6:441b:28cb]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::ad49:e4d6:441b:28cb%5]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 09:16:45 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Conor Dooley <conor.dooley@microchip.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<noname.nuno@gmail.com>
CC: Conor Dooley <conor@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Crt Mori <cmo@melexis.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: RE: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2000
Thread-Topic: [PATCH v6 1/2] dt-bindings: iio: frequency: add admfm2000
Thread-Index: AQHaSeyhcow0swT57keZetZEWhgOabDfvaqAgACHJ3CAAIftgIAAAzMAgAALT+A=
Date: Fri, 19 Jan 2024 09:16:44 +0000
Message-ID: 
 <PH0PR03MB7141990D32CE5544397384F9F9702@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240118085856.70758-1-kimseer.paller@analog.com>
 <20240118085856.70758-2-kimseer.paller@analog.com>
 <20240118-steadily-coauthor-de8275118901@spud>
 <PH0PR03MB71410860593D3C7253B200FCF9702@PH0PR03MB7141.namprd03.prod.outlook.com>
 <0f32caa9a11305333f1f18b97c97d775f4a5bb9a.camel@gmail.com>
 <20240119-squad-unflawed-934627f0e394@wendy>
In-Reply-To: <20240119-squad-unflawed-934627f0e394@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcj?=
 =?iso-8859-1?Q?JcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy03NjA0NTRkZC1iNmFiLTExZWUtYWFjZC?=
 =?iso-8859-1?Q?0xNDc1NWIzNWRkYzhcYW1lLXRlc3RcNzYwNDU0ZGYtYjZhYi0xMWVlLWFh?=
 =?iso-8859-1?Q?Y2QtMTQ3NTViMzVkZGM4Ym9keS50eHQiIHN6PSI0MDM2IiB0PSIxMzM1MD?=
 =?iso-8859-1?Q?EyOTQwNDA4ODU1OTQiIGg9InpJdU1aWGZvZWFSRG11SFJ6cGdHNkpnb3FE?=
 =?iso-8859-1?Q?RT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBQmFxVnc0dUVyYUFmM1NFZUxqN1hXVi9kSVI0dVB0ZFpV?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|MW4PR03MB6635:EE_
x-ms-office365-filtering-correlation-id: 4e3710f0-bb02-48c0-8481-08dc18cf5b57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 P7FiqVsU5p/7KcRQvs1TthMH7Wu5lapax0ed92Zg0lY4X3qBk4kndIAxZpFRKfM1A+5TCEf81OyfXxkg6ViCWfKBRmZTeNEjov3Uf489y+JBHzOY4CB54idr7RNa/fFtO5ogTywx+GEMj7McnHfegT6IywPIpWoxvrgi2Y8SYlkD6OPkp5P8A+9Jm1qQ2ALJutB2dhNrBZwCsEOq7uZYhXewU5eeuO1/kxKBhPz72/J7lSgwmLA66Hrbf8jvhf0UnmnwTHFYTI5B/NXo2RRLPmr+46KcOnC58poL4KJjkze2Led5cswa9OzuiUB/koDb8944P8e0hB0wS0HtqWh5UdvD2uRNyowcfXdoroQ+jWJkevP6j6REwJrpwGlwunFXpavENL4EGoPEVaKySHY4yVclGKGvrw67IZCsfYfgJz5E4Qir4rRIgBC4B36av8wNYjAUsQdfL2JO0dRMBHgg7Ej6pA9uR2RfG8tH6uqmb9WJZZTU10vSKjXD7++pk+2+GY1SxtmA5KaG9gHSiIhxR6o+xU/PPl48O4kHN+N6fJdCHVm/bQXEwbm+N3HfA7FnrEBkYsB7AZClbujvnUjSseDH1xGgGplSjB+9EcnILdFUjPNdMo5JJybP9srzmis/
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66476007)(54906003)(66946007)(66556008)(110136005)(76116006)(64756008)(66446008)(316002)(478600001)(122000001)(4326008)(8676002)(8936002)(5660300002)(7416002)(2906002)(55016003)(41300700001)(38100700002)(52536014)(26005)(38070700009)(83380400001)(33656002)(9686003)(7696005)(6506007)(86362001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?lVoAwVNNgKFB0QN94z9gziO3YmZdD6qIP7fvv0jZoLP5qAye8X+Prnfmhn?=
 =?iso-8859-1?Q?PHS9LkvCPm0cWzeOG5nHSigNaAu3+CjYRELCrWFPJgRG+fxb94FECePd7p?=
 =?iso-8859-1?Q?EPXRrKTr3AiZ9vawxDb40+kK3W9jP/NJdqFxJClFrNR5vE3XTE0Ap+q9OQ?=
 =?iso-8859-1?Q?LbHMy8be1sYV47OTTlaoc0BLS9RYAJGTGKu1mZyetHjAgCAg2bH6CMcad4?=
 =?iso-8859-1?Q?lUxI1Nbrqckd9l4rKH3LCRSqBJ58ndXEHpwrPEIfMNZnZnDv0ppFhyH6Gs?=
 =?iso-8859-1?Q?uZkrlAQ7xJt8h7JHR5i4YoyD43TPR4KeOhUXc0NjSvSIvqdKB5sEym3jzH?=
 =?iso-8859-1?Q?tYnvSRve8d6TS5jHaeiGy/TvoatBYXVuBEavxaYzqT3AEbgUFKqZ+cEfI0?=
 =?iso-8859-1?Q?0fSbh7TgyQHTgx4iIn5Do714BhOD3OZkwZV/ZOlNragKG41XMmPIFWFi7S?=
 =?iso-8859-1?Q?ccrfYB1RAv5vCI4DBXNwbUCfeaUTCh6ycW0/FVk9F/oNxrG5yHZ+w1Prbc?=
 =?iso-8859-1?Q?9SGmUkBVtJoHGaXXycvhrEdSSaA2yKqSZfG6xlipuy341VUFWLKZAxnVda?=
 =?iso-8859-1?Q?TLrgAeVSMfTH66Y/K7P7iG68hJqB+1m885ekhJzqYZvsaJGT7wgZJgleg7?=
 =?iso-8859-1?Q?qgwsS9JAdu7965q3T3flWArl7xtrls8Fu0HNM3qFsP1yYc7zHWqAEWiO1j?=
 =?iso-8859-1?Q?2SB/MK+cpvxswp4I8XBodE87l0Q71/K+EMYvSx+q4zw7M12drWW0Ou+7V7?=
 =?iso-8859-1?Q?+7wz40H4fgtn90E9y5kQQ7P7M4Ozx/X/vW7ZNzEkIZWbdZJYg7CJtpNXnX?=
 =?iso-8859-1?Q?LcJeAIZpUfF2DTacYXxJsZNR3TB/N/r2BLD1RviS/gXLVBF1v3kH9n2JB6?=
 =?iso-8859-1?Q?npyYPRtG8fj8i8CLN2j3IpoYUFBHTRMht5a13Dy7uwfOCNDCyPVwo1eXmn?=
 =?iso-8859-1?Q?qU+SPMEZm16YFcOyzg36PVHKxORHA5OUfhiku1d3WAEnRiN7hhV4A5iZSK?=
 =?iso-8859-1?Q?P0Y5wX6i7arSlra7//KCb/+Agvr1ah+3vCyR6KnwrPW9PtCOs+LnKu1AkE?=
 =?iso-8859-1?Q?u+j2MXCxx1wgQwAnjSlaCnrhs7+UGtRDdZLwKMMUfoFxb9euTxnwbzLmPh?=
 =?iso-8859-1?Q?aQebK/ZwnYuOv+Xfhl0kXEXmVA4bmQVky95VAQNS+/c7xXAWV1V/+/DFzs?=
 =?iso-8859-1?Q?5smEEqguJYWgb+n+4SGF2agS+GHTE/qg0UiG+XU/jvgs0j5r1JId0x467j?=
 =?iso-8859-1?Q?AGdPEg/UdseBhkCTO558hEyXKfQnnCw3k7eqXkvUGo4XbAKDM8/klNqCEp?=
 =?iso-8859-1?Q?+7OlxbAGk0zWaCkhUisUfxZC1kzx+OGmXGNfU4Fhw9sZtRZG92JZFWq0KH?=
 =?iso-8859-1?Q?/Ux5KLGOmdgQF2VtAdmZnryb/dCYPagAYXgSAfECStI5bgn94GYxORjG+j?=
 =?iso-8859-1?Q?1I2aG3uHMc1fxjid/VgFppHBvy+7IiKfV3EQpI0N0zWH8ZrkB7qKwyrbyD?=
 =?iso-8859-1?Q?Ux5hMGvPWKeZl5bQhGJFkN0UymUy7bRQG/t6k1BK3vs7fBzCT0HPkp0jBr?=
 =?iso-8859-1?Q?F57/+psv6ld/rx5N892siISzGnoOv934ejaa3HC7rFE0GSUqpfY/ciNKRq?=
 =?iso-8859-1?Q?RIZvr9HE2Xr+hvv6NPFDRMf+X+6trdF92mqKxleomjeUdrKHefD7fD+A?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3710f0-bb02-48c0-8481-08dc18cf5b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 09:16:44.9315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uc4R2yqv1ilrVjFPVGgpPzI15ODnx1hbb9CKUDD+N1+ghPs4j/c/Y5OT858E7iZP2FRqSZFcpVnNXw8iesrjyVqDPut75rFeo9WSsdYGmDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6635
X-Proofpoint-GUID: T7jP5F8A-v0L9jM4Avjq_iklX5ZUz5Es
X-Proofpoint-ORIG-GUID: T7jP5F8A-v0L9jM4Avjq_iklX5ZUz5Es
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190038

> > > > > +patternProperties:
> > > > > +=A0 "^channel@[0-1]$":
> > > > > +=A0=A0=A0 type: object
> > > > > +=A0=A0=A0 description: Represents a channel of the device.
> > > > > +
> > > > > +=A0=A0=A0 additionalProperties: false
> > > > > +
> > > > > +=A0=A0=A0 properties:
> > > > > +=A0=A0=A0=A0=A0 reg:
> > > > > +=A0=A0=A0=A0=A0=A0=A0 description:
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 The channel number.
> > > > > +=A0=A0=A0=A0=A0=A0=A0 minimum: 0
> > > > > +=A0=A0=A0=A0=A0=A0=A0 maximum: 1
> > > > > +
> > > > > +=A0=A0=A0=A0=A0 adi,mode:
> > > > > +=A0=A0=A0=A0=A0=A0=A0 description:
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 RF path selected for the channel.
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 - Direct IF mode
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 - Mixer mode
> > > > > +=A0=A0=A0=A0=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/uin=
t32
> > > > > +=A0=A0=A0=A0=A0=A0=A0 enum: [0, 1]
> > > >
> > > > How come this is an enum, rather than a boolean property such as
> > > > "adi,mixer-mode"?
> > >
> > > I used an enum, perhaps because it was easier to implement. However,
> > > this could be changed if a boolean property might be more suitable in=
 this
> case.
> > > Is that the preferred option?
> > >
> >
> > Hmmm, How is the enum easier than a boolean property :)? I guess the
> > device has a default mode. So, if it is Direct IF mode you have
> > 'adi,mixer-mode' to enable that mode and that's it. So the code is pret=
ty
> much just:
> >
> > if (device_property_read_bool()) {
>=20
> device_property_present() is preferred I think.
>=20
> > 	/* enable mixer mode */
> > }
> >
> > Also remember that from a bindings point of view being easier to
> > implement or not in the driver does not matter much. Take for an
> > example, properties with well know units like 'microamp'. It would be
> > much easier to just have an enum with the device register values but
> > that's not how we should do it since it wouldn't be intuitive at all fo=
r people
> reading devicetrees.

Hi Conor, Nuno,

Thanks for the input, I'll take note of that.

Best,
Kim


