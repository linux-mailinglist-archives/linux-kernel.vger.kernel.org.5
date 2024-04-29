Return-Path: <linux-kernel+bounces-162557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AFC8B5D54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885B61C21686
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF5682D9F;
	Mon, 29 Apr 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="PybrW8QL"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9127FBD3;
	Mon, 29 Apr 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403602; cv=fail; b=HMlouqpwPBOpNXwPx2MRI1SEh/RH+NIn7zX34aYJ+b9zS7Z3O6SkrFjpkGvlWu6Z8qjXkYOuM9NaS1vakjYpYW08WPhiyB6E11MheEv2hAZNjYr6xY8CKZmuPkdTFLts6qIVcjW/a3cMkofABPXl2u6anASexHzMwqeEJmtkQGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403602; c=relaxed/simple;
	bh=0i2x+1O0ux1txoHj9YZifg2+zxZ4D8SvEc39hY7H03s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bMBTmZAbKbGnQM767veW3Z+UMopgS7Zr1zsiqA+a88xny6JLP21Uhkt/ocsZVaDJWZPJCJzFw50iEq5RwIBK9LpkBXtVdwPqunjusjczx3TYASwFr8efv9zkXo6/5TtZ/ddig0qL3sKpdd/OLNj9DQlmz9q74q6guvRxHGc/6e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=PybrW8QL; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T3w5ID005626;
	Mon, 29 Apr 2024 08:13:16 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xt43aug16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 08:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2wPpgNgJNFrnAzYrZn3gkKMY/a8WfryldRVtliwJ14s17+uGe9P+7I7GocmYcvxgqpaabLt06HuVGiV3lqemueKEhZsXquJtlcHrZXSp0BiGLoWuHXu3WlJ0t9HueZKjGyiXu+v7/9j31csaiOMoK4W4vtjix08fh7lV8iKNc/vDryt9O1UaDJmanUXxzCfn2RXUxmcLF48rW4K5+4zc8DqemGEiwA0suAMMfUiTP9CzdMIVC1nXAXwJCyOZ3VRBQ63criQRBEi9VDTxNpHh0QE46ZZGoe4ZwRV1DaY7YpHmyWrMHqXkSN2I6J1x9RmSE9OzCx66DXy72WSag4xcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i2x+1O0ux1txoHj9YZifg2+zxZ4D8SvEc39hY7H03s=;
 b=HpiQ9SYA0vjLCIOWFAzwSTrgl9y8GYONxI/Dxstt4SXDAHW14xUS+r5HjWFeoaporBnN7k//G7GgSR2NQbg+YgDfoFFu2spnMTu84T39hfhOfldCg+z5v7kKaM4LXQrT7TEB11qkwSFBn8Ey3tXQreIUr84MjylRrXuWWfISEaW1aZf1wYHzhcS7YdzEuvQ0S3UNr+rc9b6Dgz7UCXbfRH56a94VAMWM20OqxWKzy3Fe7zE2trngupMt+18iSY/NANzaEwvLW52Y+wwqf0w3XI0+tfE3sWQaEgmOxVEGlfQnBpXurJ8drh4Ap9GFoWhjngACwrTQCZd6PnraBbWwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i2x+1O0ux1txoHj9YZifg2+zxZ4D8SvEc39hY7H03s=;
 b=PybrW8QL9JIXd1iQISYyYWeeWN0qhE6l63GhdvB/TEYyNvzJzFED+7nG2i9bVHoYHy1xCbvOCnAKrDXBo3uSrkiEO/z/a1evEwe5qjfxPv+hTza5SmTHR2jSEJ4jjGJXbgXAz4xztlRISHn/SxvLO20p22Tq3cyLE1ZiGxfOXpo=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 MW5PR18MB5150.namprd18.prod.outlook.com (2603:10b6:303:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:13:13 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 15:13:13 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "broonie@kernel.org"
	<broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "pthombar@cadence.com"
	<pthombar@cadence.com>,
        "konrad@cadence.com" <konrad@cadence.com>,
        Wojciech
 Bartczak <wbartczak@marvell.com>,
        Wojciech Zmuda <wzmuda@marvell.com>
Subject: RE: [EXT] Re: [PATCH 4/7] spi: cadence: Change dt-bindings
 documentation for Cadence XSPI controller
Thread-Topic: [EXT] Re: [PATCH 4/7] spi: cadence: Change dt-bindings
 documentation for Cadence XSPI controller
Thread-Index: AQHZE7g6JEJMP4HivU24epqxDA42Zq520eSAgwuVibA=
Date: Mon, 29 Apr 2024 15:13:13 +0000
Message-ID: 
 <CO6PR18MB4098ACA74130C6471AD35E52B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20221219144254.20883-1-wsadowski@marvell.com>
 <20221219144254.20883-5-wsadowski@marvell.com>
 <65e1f6da-d0eb-2fa1-1457-8a3afe714a9b@kernel.org>
In-Reply-To: <65e1f6da-d0eb-2fa1-1457-8a3afe714a9b@kernel.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|MW5PR18MB5150:EE_
x-ms-office365-filtering-correlation-id: 00d211f5-7c59-45d4-5a00-08dc685ee392
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MC84TTFDSGExWHpqeldZRnRSbTNZa0FkY0tpWWhKR3ZpWmFwV3FSL0dGS3JI?=
 =?utf-8?B?RlJXLy9lNWdzajV0WFdsN0NtN1M2TGsrc01QS0JFMGtJcVhabFNiUVAvdUQw?=
 =?utf-8?B?eGJmMENyVS9mQ3BWd3lRZnZZODltS3JjOTVBeDBneW43R3V0Wk8yMWZ1QXlO?=
 =?utf-8?B?NkxobWgrRzlKbVVKcjNVdXMxaHB5WXpjeXhpMHdpMFVEenlOb1JyamNId3Zs?=
 =?utf-8?B?aHFxWXhnTjRZMDJTUk92bVNpc0FFcUN5MDNUd1VWV0prVE9ENmZJZTZ4N3BB?=
 =?utf-8?B?NURIUXdjK0UrOWRucEQ0a0owaFlSVWNkNDZBcStxSGdFTWJwYk9QNnoxd2Nq?=
 =?utf-8?B?OWNjUkkwMFczakJTVXZRTnUzL1QrSktDRGZtVzJFSTFqaVBSYVRpdVhxeTZV?=
 =?utf-8?B?bkt0aENoTzUrZDN4ajBkVk5yYWNxM1JRbXlrbFNXcjN1NG0ySW1ZOUlmWUJ5?=
 =?utf-8?B?OUUzSVFUUnkwV25QUzU3UzVHalhIRno4UnBLbW5wQnhKaUN5bWFXSmJYZkZx?=
 =?utf-8?B?aVVKNTVHSFo4UDRKODdtaTBqeTVLdElXdVdtbHF3S2I4V1NRUDdZN1hkeWZB?=
 =?utf-8?B?TVJsMmJqK0Z0NlhpSWxsaFhlUzc2M1ZuZ01WSHd1SmIyR1hEbnkyL0xZRkp5?=
 =?utf-8?B?aFB0V20xazhXOXFTVnF5a0xEQ0FJMi9TVnY4enFDSDZ3WmEvR3RZeVVjT3NB?=
 =?utf-8?B?OFFHSGZDYk1UUXNHRThQa3FEbk9HaGlwWUhCb3VmRGhsdjNvaWtyQUE1T1Na?=
 =?utf-8?B?VHI5Sy9STlVaSVozNHN6U2xXK1NxdTlhM3BvMDM4OGIwNHRtSkQxZUlyRlBB?=
 =?utf-8?B?OXg3V1FZZm16YTVWUTZGREthRU52WU0yQXg1bmtBM1JCV2E5eEpwSDZ0VVFH?=
 =?utf-8?B?S2kyTzB1MTY0d2NObVNEc05NNXZtVjdUdVk4SkY0RStURmRCNXNVTVltQllH?=
 =?utf-8?B?ZXIvbzRaOHkzMU9QTkZlbkpxL284NGJRTWNUd3VLdjQ0dm5pWHRzUEo3L3Zx?=
 =?utf-8?B?RGx1VlV1a2NJTVFvTzFjVHhHOFliTVBIR0NraFN4SG9Lb1ZGQjJkbk5DVWR0?=
 =?utf-8?B?ZjlFeW1Yd3lQdENGamhrRWVXeGlqY3hMSFpTRUNuRXJDNnpJUHJaYzdHYnp6?=
 =?utf-8?B?cm1PMGdXSFhSd1ZmQXVCVHIzdE01RXpVUWV5eWZKaE1MVHhvQVZMaUcyMm1q?=
 =?utf-8?B?MTBRckJyM2djeU11bCtJSzFyUTg3RXBsRE5VU01vbnJ1SC9PeTF2Ym9oaDA5?=
 =?utf-8?B?TVQvd1lsMzdEUjlnZHN6NlFSa083c3h0NlI0SHgyOXVBZ2I5VVB3emRLQnhH?=
 =?utf-8?B?aXZ4Rm5BWHYrazFiOEZ3bzJSVzBmUHlNcjdVeXZyaTk4Y1FHTUFTQzNJUDZp?=
 =?utf-8?B?ekpxSWJKdDM3S0lSYU1jYmdGZ044M2x4Qnlubi8vSDdXK1YwYm0yUWRoNzRT?=
 =?utf-8?B?YlBhRjRIMmNTOGx1ZmdmTnBIMDFjSkpPc1VMZTN1dlJSemJMUDZReUJ1QzRJ?=
 =?utf-8?B?eXAyWFJxZDU0OU4wdnhjWENacjNnamJJZW5vclIrTTEydGlGVzdVZHp1Rk43?=
 =?utf-8?B?Wk1tR2NwVVlFM2lSNzA3bHg3dksxemZ2cUJ5dE9qeUZrUGtkT3hLMTdpNkJj?=
 =?utf-8?B?ek9RYlJYckZvV2ZGeWFDeCsxb2ZkSG1WQ0VseGozVzdIVkRZdnR2VVBGREhY?=
 =?utf-8?B?NGZlbXd6YlNOd0V3UGVvVGpIL3dhZUNVaHc5ZHZOUFlTeGxrTkFnTThGSXF3?=
 =?utf-8?B?bHpmMUVrYmJGRTBHSmxYa2NqaExNS0pRM1VrZ09Kb0tFbUtSSlpzZXhlUEIz?=
 =?utf-8?B?OTR0SzBENENHQVZwN1E5UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YWwyeFF2TmtveUIrNk9FWlBBWGtEcndxajArVDBvRFFOYjNHWUhWK0ZDTlh5?=
 =?utf-8?B?WGorZHNKNEQycDkwQW1saUZoWit2cURsMUY2aHlaWnZuTVQrTUdJV3U0dGZ6?=
 =?utf-8?B?NkNadllMYkJXUmJoenliR3FWZnhQeFlpcEgrUHE2dWNXb0FocjBNdW8rOVpp?=
 =?utf-8?B?T3JJR2ZJOGhjUnVBRTlsNWRXZVlNa09tQlJldkd4UTRMaXh0OVZBQUxiMWRK?=
 =?utf-8?B?RHAyR0hHUGtjcFdFSkt2MXord3FSanNuOHR0c1BTOUs3cTNWNCtaZDM3eE1t?=
 =?utf-8?B?bGVGS2JVcGFKMFVxSnpMR3V2OVF6Yjk4ZjhtNlE2MmpPT09jblRraS83Ulh6?=
 =?utf-8?B?Sk1TZ1FScGZiSXM4RUJHVDFsZEJLM25pOUxBWk9qNUFSZWdFRUxjN05aMUdB?=
 =?utf-8?B?TkMvWUFKQlRGeFl4UGdXZkh6K29qZ3MyRkw0L1lCcjZjMjB2eldUc01rbXJG?=
 =?utf-8?B?TlpGTmUrQjBGUXlqb2FuT3pnenRZdUtkMUVqU2d3QXdYYXFKK25DMllOTjJJ?=
 =?utf-8?B?dStic1V4YXVLRmRLTUtqcDdacklnTXFZUDA1WEwrV2FWenNwSXlkRVBrK1I0?=
 =?utf-8?B?T1ZVOVduSGo5Z2RMNStZdWJ3MzZRRVNBSGxldDBNdTFpd2RZQjFkTWcwUnBq?=
 =?utf-8?B?aDJsWnpjOER5SnBxa2JISStpSVAyMXozV3RFWlMzQXNiMnlMMWlUQTNEaFFH?=
 =?utf-8?B?cVZrckZrcEVoTW03S1dnbndMb1V0V2JEMEJ4WHc3NXFSazhMMllmazN1V3lr?=
 =?utf-8?B?a2xTVFNqclpVRUxRYXIyeGVyc1pGUkVKTm1UcmlDVG5hSUR1cGx5eldzUnlv?=
 =?utf-8?B?MlBDSTdkQmIxRHh6TXJtV2tQTmZaZmxYZlVBUVlwcitKOE5HbUlDTytlVWlT?=
 =?utf-8?B?MGsrSXBGdDFuTVJhaFA1MHRYTFBPcUgvN3JKV1cvbjkvYXl1UUJzTkxPK1hr?=
 =?utf-8?B?U0VPNjlpblpHNmVCUi9uTS9pdXFrV2ZaeERtVXFTbDZ6aDZ1cDZ6TVF2VHpR?=
 =?utf-8?B?ejJPenVraHlnU3FPanRtMWRRYXpVQUpHWG01bUEyS1J5SUh1bFV3bXBDZnpj?=
 =?utf-8?B?TnVNaHNpZkhmckRDVzExaXBsSzRjWVk5Q1VyN1Z1NEpYeVBlZmNmSmRsTXFS?=
 =?utf-8?B?cGZqSmdadms4T0FuNDRWYzhkS2hLOHIySVovNUx0cEptNU45OHEyK2NkY1Zj?=
 =?utf-8?B?R1BBMkQ3TmMxRkF3b090M09CZGNwN291dkl4M3hkNXhFTFdZbkR4d1VXZXZV?=
 =?utf-8?B?bU0xQmtsRllJK0ttSE9OdkdvTjNRUERIT2tuUFd0RHB2Mk41aUFISi9MKzVq?=
 =?utf-8?B?WEErMkJaSGNzbzhmaTh1L0Eydkk5Q3NWZWhRU1pObC9uL1pFZk5NbHpQWlNu?=
 =?utf-8?B?aXJFVnAyTUdNdFJRQitmeW9JZWhNQ1BFaE9Ib1pyMW5pd2JVTVc5YTFxTVhp?=
 =?utf-8?B?Ly9ZMTNlcHlPczNLQTFSUlNKdTBhbnNNMWJRTXM0WDdHRUl1a1ozWHU3b1Er?=
 =?utf-8?B?a2REMGQzem8xdUFrUWw0LzhCSU9MczhLV1VDRElBTllNSEFhOW9OYVVrMzFN?=
 =?utf-8?B?REVIUWFuRDRKUmtnNVlYRTZuSUNFOUpUbGVwK29IaFY0R3FCZjRnMzMzK0Nm?=
 =?utf-8?B?VThBVGIzcWdsMVFUYlpiSVhqeVNHek15QkhjbVN1TWxRTkVzRzdsT0llOURh?=
 =?utf-8?B?RXpodDEyWVc0ZlZMLzh1MVZKd1kxVlVWWFFMOWhrVkE3R21MelBoNnQza3la?=
 =?utf-8?B?ay80a0JXc0I2TGlDdlBUVFE5Z0Iya3lsRXFDVHpoZVVCakdKM2JIUFR0amFD?=
 =?utf-8?B?OE1pRHVRTVpNZm5aZFpCWnMvMnZTYWVrVHoxdDV3bUx6cWdvdDZEcS9icWRQ?=
 =?utf-8?B?UDlsZytSVHF0Qm5LNk1sUzRhL2pTenRZQVJaQkxabFdhd3NoOG5uWnhQNzdo?=
 =?utf-8?B?QVJVbGt5Ynl2aytGUzIzT2VINUVuWm1qb2RPNTNtZDUrbUp2cUxuQjZhbjQz?=
 =?utf-8?B?WDNjYSt0YXRZUE5GaHl3TGZaeXFIeUF5YlViSStBZnJJTTl2NlUrZUJpSi9i?=
 =?utf-8?B?c1FKdDUySnhTTTNyZzBNWXY5V3J1QWk4OTdpbTBsR2pWd3dLbmVQNlFhOGRI?=
 =?utf-8?Q?L36pzZbIAF9wbu91aTmwOPsxp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d211f5-7c59-45d4-5a00-08dc685ee392
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 15:13:13.3827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MVBLQCl3mapS0gHqrtBiG5hcLHxYod5b3KgOmIf3VJW9nMJvp3iT33W0465u/Ob0zAcwnTdxeGXnRZ6nsCq84Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5150
X-Proofpoint-ORIG-GUID: DNCsKpWJ2e-BXKzezgVUXnwsNq1NAlMV
X-Proofpoint-GUID: DNCsKpWJ2e-BXKzezgVUXnwsNq1NAlMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_12,2024-04-29_01,2023-05-22_02

PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+IE9uIDE5LzEyLzIwMjIgMTU6NDIsIFdpdG9sZCBTYWRvd3NraSB3
cm90ZToNCj4gPiBBZGQgcGFyYW1ldGVyIGNkbnMscmVhZC1zaXplLg0KPiA+IFBhcmFtZXRlciBp
cyBjb250cm9sbGluZyBTRE1BIHJlYWQgc2l6ZSBsZW5ndGguDQo+IA0KPiBVc2Ugc3ViamVjdCBw
cmVmaXhlcyBtYXRjaGluZyB0aGUgc3Vic3lzdGVtIChnaXQgbG9nIC0tb25lbGluZSAtLSAuLi4p
Lg0KPiANCj4gUGxlYXNlIHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBs
aXN0IG9mIG5lY2Vzc2FyeSBwZW9wbGUNCj4gYW5kIGxpc3RzIHRvIENDLiAgSXQgbWlnaHQgaGFw
cGVuLCB0aGF0IGNvbW1hbmQgd2hlbiBydW4gb24gYW4gb2xkZXINCj4ga2VybmVsLCBnaXZlcyB5
b3Ugb3V0ZGF0ZWQgZW50cmllcy4gIFRoZXJlZm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UgYmFzZQ0K
PiB5b3VyIHBhdGNoZXMgb24gcmVjZW50IExpbnV4IGtlcm5lbC4NCj4gDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBXaXRvbGQgU2Fkb3dza2kgPHdzYWRvd3NraUBtYXJ2ZWxsLmNvbT4NCj4gPiAt
LS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9jZG5zLHhzcGku
eWFtbCB8IDUgKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkv
Y2Rucyx4c3BpLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
cGkvY2Rucyx4c3BpLnlhbWwNCj4gPiBpbmRleCBmNzFhOWM3NGUyY2EuLjEyNzRlM2JmNjhlNiAx
MDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2Nk
bnMseHNwaS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NwaS9jZG5zLHhzcGkueWFtbA0KPiA+IEBAIC0zNyw2ICszNywxMCBAQCBwcm9wZXJ0aWVzOg0K
PiA+ICAgIGludGVycnVwdHM6DQo+ID4gICAgICBtYXhJdGVtczogMQ0KPiA+DQo+ID4gKyAgY2Ru
cyxyZWFkLXNpemU6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjog
c2l6ZSBvZiBzaW5nbGUgU0RNQSByZWFkIG9wZXJhdGlvbg0KPiANCj4gV2h5IGlzIHRoaXMgYSBw
cm9wZXJ0eSBvZiBEVD8NCg0KUmVtb3ZlZCwgcmVhZCBzaXplIGNoZWNrIHdpbGwgYmUgYmFzZWQg
b24gbWF0Y2hpbmcuDQpUaGUgcHJvYmxlbSBpcyBpbnRlcm5hbCBidXMgY29ubmVjdGlvbiB0byB4
U1BJIElQLg0KDQo+IA0KPiA+ICsNCj4gPiAgcmVxdWlyZWQ6DQo+ID4gICAgLSBjb21wYXRpYmxl
DQo+ID4gICAgLSByZWcNCj4gPiBAQCAtNjAsNiArNjQsNyBAQCBleGFtcGxlczoNCj4gPiAgICAg
ICAgICAgICAgcmVnLW5hbWVzID0gImlvIiwgInNkbWEiLCAiYXV4IjsNCj4gPiAgICAgICAgICAg
ICAgaW50ZXJydXB0cyA9IDwwIDkwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICAgICAgICAg
ICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZnaWM+Ow0KPiA+ICsgICAgICAgICAgICBjZG5zLHJl
YWQtc2l6ZT08MD47DQo+IA0KPiBUaGF0J3Mgbm90IERUIGNvZGluZyBzdHlsZS4NCj4gDQo+ID4N
Cj4gPiAgICAgICAgICAgICAgZmxhc2hAMCB7DQo+ID4gICAgICAgICAgICAgICAgICBjb21wYXRp
YmxlID0gImplZGVjLHNwaS1ub3IiOw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cg0KUmVnYXJkcw0KV2l0ZWsNCg0K

