Return-Path: <linux-kernel+bounces-35093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C000C838C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB621F26245
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE605C606;
	Tue, 23 Jan 2024 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="hoIDVh0D"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772E38386;
	Tue, 23 Jan 2024 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005893; cv=fail; b=sg6O3ruWuDcnhStvO4p0d/Ty5oi1UQlmgGCgirQ2sjFQ2r8jb0FbrjX0MuTtRpivM7mzOh0OWx8/I2V5KStzqFasVvBEpR2qO+8qQyFVCfT25A9HQEp+9MboNt+dnRvwZCMBl2tTHmKV6m48x/fvy86Fmmvlbjio9Mvmq5JTgxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005893; c=relaxed/simple;
	bh=oGvKSZQ1n1My8icKAOj7SDiStct3BNB0u4H1fZ65lhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I0cvyT1rVLtxLMqIRqL6SaTOiCZa1X5zNR9pBfCy5ErY1UilJ3qgW10kAcXMnAXjwEvHY6g/PDvW/vIYBlbO1vxmH3OdwNib/Ml8sTeBpnsjpr2bQfcSmYExEyaGx2a/NYl111Qn3fja9aTjOfNmWXj+gDte6RTfdHT170VzugE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b=hoIDVh0D; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N83Cpl026945;
	Tue, 23 Jan 2024 05:31:14 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3vr8tcub5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 05:31:14 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5yLBqzi+PiAgL0MJf1FWdntvyvTsFAHXJuB3/iH/vwF+qLeFnF8bKPbqMyJ2mGd6E2O6/wAAsM5oU0OJL4bJ8JcPEzCRb1zbZVXf1htesn0SOWDBXXZVFcINfzMr7AxSVmm5/q2jwCFwxmRvgbIvFszGZl7W+DUEuOqacW8UmiMiAM0mWlB6vBpoi4vEUnCS5pC/pVZmP428sNA141csb1wZtESWUlVg+rsUssRjNJg91e5IY0No8wwYoRiYAZztHedwCfRcZPSGt8dqeMQ9JBtEIFyz8IGO4ogKy0/1ZR1ekyRvwEf3KtsZzE/Ljtq5NCNYp5IsT/V6fRWPzK9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGvKSZQ1n1My8icKAOj7SDiStct3BNB0u4H1fZ65lhI=;
 b=d1/iZOLvnAfSj8dXrycQ3K4Xn3lfJBtqPELrnkzc3suHbk4hhyAlGw9YVA1ZeaRU/iy4ilUkgY9ZngeW1mq+NN157W2JLWA+88qnLrJ5iSBIywNEB8xu2J1RsVXUjtsZn7Y/LpFk6FymbBqIO1alOH+KDpFzdyAxhEIg33LHl663+W/jx6lphPx0KxV6vy9toI3jdzZYKowklOUopl1nRCJua+JCNwjve8pg+uhMCMwU0cF3W5wciPbcA8yXg7XbB2S8hR25KKAa+T9NHFGf3lLg/hTdL7zTc1mGWwlUcMNU8+qTKytpapYNi8lusNlf8hc1ko3O0P3DrpG3mzVeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGvKSZQ1n1My8icKAOj7SDiStct3BNB0u4H1fZ65lhI=;
 b=hoIDVh0DO/m0irMXOoXKkwJwjbiKQweVKsmKD49KxYsEYH3eRE+T4dpKJEV4y5dBO/19A4rRNC5iy+NBo/13wgmCvOlcqtnRnKgJCCjNDZwTFotsmfYYc+WADW6SBBM/QPnIzdi5dp5iF0GNUcq1QjPGZ/q5X4cAygYAbcikySQ=
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by CH2PR03MB5368.namprd03.prod.outlook.com (2603:10b6:610:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 10:31:12 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::ad49:e4d6:441b:28cb]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::ad49:e4d6:441b:28cb%5]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 10:31:11 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
Subject: RE: [PATCH 2/2] gpio: gpio-adg1414: New driver
Thread-Topic: [PATCH 2/2] gpio: gpio-adg1414: New driver
Thread-Index: AQHaTFWO6BctQx5jpU+9EjWi7po2DrDlzS2AgAFfGbA=
Date: Tue, 23 Jan 2024 10:31:11 +0000
Message-ID: 
 <PH0PR03MB7141E0C8822D4887E04A3F06F9742@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240121103505.26475-1-kimseer.paller@analog.com>
 <20240121103505.26475-3-kimseer.paller@analog.com>
 <CAMRc=MeGVAO8Fr4U5ai-OgEmX5gXeddLDKyRC+FQia1TH64m+Q@mail.gmail.com>
In-Reply-To: 
 <CAMRc=MeGVAO8Fr4U5ai-OgEmX5gXeddLDKyRC+FQia1TH64m+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTA0TlRVMVlXUXhaaTFpT1dSaExURXhaV1V0WVdGalpTMHhORGMx?=
 =?utf-8?B?TldJek5XUmtZemhjWVcxbExYUmxjM1JjT0RVMU5XRmtNakV0WWpsa1lTMHhN?=
 =?utf-8?B?V1ZsTFdGaFkyVXRNVFEzTlRWaU16VmtaR000WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STVOekF3SWlCMFBTSXhNek0xTURRM09UUTJPVFl5TmpJNU5UVWlJR2c5SWps?=
 =?utf-8?B?b1dVTlRNak5zUWtsWlVHOXZUbUV3WW10eFIxRnRUVmhDY3owaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVhKd1lUVklOVEF6WVVGWlZtVjBXWGwyZURSemJt?=
 =?utf-8?B?aFdOakZxU3k5SWFYbGpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQmJFZFVSMVpuUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|CH2PR03MB5368:EE_
x-ms-office365-filtering-correlation-id: 04e513e2-b1bf-4111-681b-08dc1bfe6b3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0OnXuRkW5bd0Fd0M/rHEcbIs90XR3SMeJEDpR66A2+1efaHijx0TF37OyRoFGhxnHrpGsWNF4p1lTxkYAoC+UgLyJHaqNGR+7PyzTE1EgYMQCJfGbEEYp3LnMhJSn3WQxOuzuCr+DB9P30xO/77K1275POK+EY4GblzXC0gtBULRVqOhZSfqAO7GR/BUBysT38tun0La/ciLSwWKfdsvm/6Qurz+F4CoMV9ItbsDgPm2aabuF0iNWdL2HRyKIjRQ0dywWFZH2ZIKFFenZ78B3nQI9ADEFo9bH1Vrn6ySlBveGzed8bLOuEMC3ZGa37G/WmYS+jmXQdY2GfxEx18tnolhVb4Q3E7LAbnkBd7u/QN4tAxdAobDliLYb2tOUXBSo030Rl5yWYPbovKExS+5f1Tp5ICugEUtQSYvL96sTGCwZk/fmt91/EAJwnMdNxRrqauxf8sG5zgfM54EynvzGq5qSVcLq/ALZqtox620zsjC0kofCr37tSPAPIVtJ4BFrVRtwSoQVUTWotr/L8/5HZOVwRORCY2ViRcRtA/gVgUETUaESu1A8QU6Pdo8KoGX+KLVPLC3f+8JypIL+hJwezUm1pJuU4egKaYk1vi8iTHoCvqyGQQfNfE0eejHsCNm8EzB/jUkFu7x9UvSyWhfIw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(7696005)(64756008)(6506007)(71200400001)(478600001)(966005)(53546011)(6916009)(66446008)(66476007)(66556008)(9686003)(66946007)(8936002)(76116006)(54906003)(8676002)(316002)(26005)(83380400001)(2906002)(4326008)(5660300002)(52536014)(41300700001)(38070700009)(38100700002)(122000001)(33656002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TWNTOWNOV0xwalFaam9VVHZDWUs3Y3RLVXBJZHY2dUlUQnNBeUVlVStHajQv?=
 =?utf-8?B?a1h5cUxTODNEdStaaTZpVmpZV0hnTFpZcWYxcTdlTEZ3aVF3SG02d2FSZVJW?=
 =?utf-8?B?Y2dqY1J1TGRveDN3S2VWOTU4VVV0WXVWaE1nenhIbGordm1rWjkvQzRQbnRw?=
 =?utf-8?B?WVVVYmdTWnN6bm1WRjEyL0JwRGZVR0tBaVNVZmtyY0dWNlhGTEVzVGVGalRr?=
 =?utf-8?B?NXIwNHdidW5PbGxSbWUxU1ZyNE4yRTlBSjZKTm5VM1V4TDZIRWJCSEtwYnBl?=
 =?utf-8?B?Y3dQb1JQck5RMlJOakVYdnQ4bEEyNHRYYkpnN0FQYWhiU05qd1NzZzY4SjB4?=
 =?utf-8?B?cWxERXg2Q3oxOGNKc1BPNmJhOWQwRjJCR3NnRThSTmQ1bnJoYndFbUtHWnZC?=
 =?utf-8?B?TEFjdHlXZzlmNUUydEhRZk5yNFNpZ2Q2b1g5VG5hNWdnc01mbVdSZ2IzRjgy?=
 =?utf-8?B?M2pVSnNLenozZDJEbGZEcXVkWmw4N1FFZ1BlQnZ6dDJBNkpjaWUvcnlQVkQw?=
 =?utf-8?B?UWRvMXMrRE4rU2R0TUJYQ2dnTm9kWVovenpOYjZpbjRiMFBzK2FKTmVzOE5h?=
 =?utf-8?B?bEphSUhVdlNENXJJUFJWalIyMTY4VEVrZy93czA2Tk83VFcrQUVuSm9ZUzB2?=
 =?utf-8?B?L2ZQYXlBZ0NCb1FtRGcxNlcxRzdmSjh1MW90YXpveFJnYkhuVG91MFI4azBD?=
 =?utf-8?B?aHJWcWNJQitzU2poczBkY1RiK1c2cEZxNGFCYUJOV2N3Z3dRbVlQampEY0dK?=
 =?utf-8?B?dUJuVG1DRlR2V0NJNzNJS3lIYVdKSFhHTDVCV3pGUEZtdmtoOXBQQ3RIdndC?=
 =?utf-8?B?NE5ZOStoMkthajNJYW8wQ0thQWZLc3JpTEczZG40cmVsa0UzcjZCMjYydExy?=
 =?utf-8?B?TWJVYXpVY2dFT0hvbUR3OEhuSGhMZVlWRlpJUDN1bEFSbStIVjlKcG82UDdt?=
 =?utf-8?B?Ny85K0o4VjVkZHRuYmUzMTQ1WjdFOUY4dzVJTFVmY1NTZS9NdzhrNFhIcEox?=
 =?utf-8?B?VWtQTTNVSU9QUGUrT3NKdmtzQkp5R0ZCYjlhY3FlcmVEcU9vS0krb2xmeXZ6?=
 =?utf-8?B?ZFRlTVQ5Y3BuUVZ0Vk1raVV6aXlRYlArSVJoL3JEdHpHWGY1T28zdjVYTUUr?=
 =?utf-8?B?TmQ3VVI0bkNBS3l4am9ZWjB0ZmoxTzRBNW85TkR2dGZhL05QdkFhYkI5Y0t4?=
 =?utf-8?B?eW5ZNDlFU0RxTEIrZWJGRXM2VzI5eUFkRDFOMGtBajBLVkozaFhEK3B5OTl1?=
 =?utf-8?B?cFFvQ2ZPVXFsb2tSUlA1YUl3QnBQUTg3bjVEVkJsRjdOempVc1NLM2orbERJ?=
 =?utf-8?B?Q21HYWtBaVpXdFJVNjN1MkQ1OWdzRzVFR3RSbkEzUzNuaC8vWlNQYUdiTmlK?=
 =?utf-8?B?N0NYcHNNOUhzbjFjSGNSUU1hUjdYdWNuU1hvMnF4UGdlcUExMGlrOFg1cW5i?=
 =?utf-8?B?Wkl4K2htNU5BOUNqaW5ndHNkeEtFdGdmOW5pY1ExaFVpK2drNTBnOFFsc3Qr?=
 =?utf-8?B?MHV0SEpEWHhtWVFoNXAvaDYwTXBxZ2R2RVZlUCtFVVJObkZ0OHNPRzZqYWhw?=
 =?utf-8?B?amhxMjFyajU3VythaE9ESUFJUjBIbUpqY3pKQTdURDhKcjg2MG50U0lMSHI2?=
 =?utf-8?B?emtwQlVSS2VaUXc5TUtBbThIM21VYW9EQTRGZC9YTGdKd1h4eXNVK3RJdmJu?=
 =?utf-8?B?MzVGZXcvRFpWdnZaKy9yUHhlL1VqYWlIR0JyN212dGVzYnh2MTVYY3A3N0cy?=
 =?utf-8?B?TVlMRzZpczlNZmdGckxkUUZMdUdFeEhLUENTV2tReUM1TVB6NFAxTG5Dc25S?=
 =?utf-8?B?L3NVazJJL1cwMk1RVGdCMFB2bFN3bEhkQ0ZUR0xGWWlwTkJPS09PSkZBTm5G?=
 =?utf-8?B?VXM0TnQvMFBEWURva2EwZkM2WnR3SkR2ck4vemltT2ZUOTlqVjdYbG8wV2Rj?=
 =?utf-8?B?OCtsZW8zVVE5YkVLZ1g0dHcvd0o2RGk5RE5IdGdCSlE0aTZLWmx2Z3dhRWVw?=
 =?utf-8?B?Z0VTUXZmNWVhU3dycDdWNVVmMU90cWo3TzNpQlJXaUxhZXBKejI4aHJZUmU1?=
 =?utf-8?B?MCtqWWl1aVVmd2tiZTRNUllLQlpqamhFRUk2N01DVXg3MHFyWDdPMWlVZE53?=
 =?utf-8?Q?xfHg/c//bWuT24TlrbKJk9n71?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e513e2-b1bf-4111-681b-08dc1bfe6b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 10:31:11.4014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6A/iYyY140c3bPEL7pJtd9xopRHn6aEv90ZZF6BEUx9sdf0ndMHiBayT2gn3O3/0yib4fqjin7qv7xTuqFvubsKLMo5MmMRh+MHiy9RD0Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5368
X-Proofpoint-GUID: bXKwaO-22XLZUuo7xQzIXXx6z4aUIhd9
X-Proofpoint-ORIG-GUID: bXKwaO-22XLZUuo7xQzIXXx6z4aUIhd9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_05,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230076

SGkgQmFydCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCYXJ0b3N6
IEdvbGFzemV3c2tpIDxicmdsQGJnZGV2LnBsPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjIs
IDIwMjQgOTowMCBQTQ0KPiBUbzogUGFsbGVyLCBLaW0gU2VlciA8S2ltU2Vlci5QYWxsZXJAYW5h
bG9nLmNvbT4NCj4gQ2M6IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExpbnVzIFdh
bGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz47IFJvYiBIZXJyaW5nDQo+IDxyb2JoK2R0
QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnp5c3p0b2Yua296bG93c2tp
K2R0QGxpbmFyby5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBncGlvOiBncGlvLWFkZzE0MTQ6IE5ldyBkcml2ZXINCj4g
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFN1biwgSmFuIDIxLCAyMDI0IGF0IDExOjM14oCvQU0g
S2ltIFNlZXIgUGFsbGVyDQo+IDxraW1zZWVyLnBhbGxlckBhbmFsb2cuY29tPiB3cm90ZToNCj4g
Pg0KPiA+IFRoZSBBREcxNDE0IGlzIGEgOS41IM6pIFJPTiDCsTE1IFYvKzEyIFYvwrE1IFYgaUNN
T1MgU2VyaWFsbHktQ29udHJvbGxlZA0KPiA+IE9jdGFsIFNQU1QgU3dpdGNoZXMNCj4gDQo+IFN3
aXRjaD8gKHNpbmd1bGFyKQ0KDQpJdCdzIG1vc3QgbGlrZWx5IHRvIGJlIGluIHBsdXJhbCBzaW5j
ZSB0aGUgZGV2aWNlIGhhcyA4IGluZGl2aWR1YWwgU1BTVCBzd2l0Y2hlcywNCmFzIGFsc28gc3Rh
dGVkIGluIHRoZSBkYXRhc2hlZXQuDQoNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtpbSBTZWVy
IFBhbGxlciA8a2ltc2Vlci5wYWxsZXJAYW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gPiAgTUFJTlRB
SU5FUlMgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVycy9ncGlvL0tjb25maWcg
ICAgICAgIHwgIDEwICsrKw0KPiA+ICBkcml2ZXJzL2dwaW8vTWFrZWZpbGUgICAgICAgfCAgIDEg
Kw0KPiA+ICBkcml2ZXJzL2dwaW8vZ3Bpby1hZGcxNDE0LmMgfCAxNDENCj4gKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTUzIGluc2Vy
dGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3Bpby9ncGlvLWFkZzE0
MTQuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4g
PiBpbmRleCA1MjYxNDVlNjkuLjI1NGJhN2VhNSAxMDA2NDQNCj4gPiAtLS0gYS9NQUlOVEFJTkVS
Uw0KPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gQEAgLTQ2Niw2ICs0NjYsNyBAQCBNOiAgS2lt
IFNlZXIgUGFsbGVyIDxraW1zZWVyLnBhbGxlckBhbmFsb2cuY29tPg0KPiA+ICBTOiAgICAgU3Vw
cG9ydGVkDQo+ID4gIFc6ICAgICBodHRwczovL2V6LmFuYWxvZy5jb20vbGludXgtc29mdHdhcmUt
ZHJpdmVycw0KPiA+ICBGOiAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dw
aW8vZ3Bpby1hZGcxNDE0LnlhbWwNCj4gPiArRjogICAgIGRyaXZlcnMvZ3Bpby9ncGlvLWFkZzE0
MTQuYw0KPiA+DQo+ID4gIEFETTEwMjUgSEFSRFdBUkUgTU9OSVRPUiBEUklWRVINCj4gPiAgTTog
ICAgIEplYW4gRGVsdmFyZSA8amRlbHZhcmVAc3VzZS5jb20+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3Bpby9LY29uZmlnIGIvZHJpdmVycy9ncGlvL0tjb25maWcNCj4gPiBpbmRleCAxMzAx
Y2VjOTQuLjI1ZDQ2N2Q3MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwaW8vS2NvbmZpZw0K
PiA+ICsrKyBiL2RyaXZlcnMvZ3Bpby9LY29uZmlnDQo+ID4gQEAgLTE3MjgsNiArMTcyOCwxNiBA
QCBjb25maWcgR1BJT183NFgxNjQNCj4gPiAgICAgICAgICAgc2hpZnQgcmVnaXN0ZXJzLiBUaGlz
IGRyaXZlciBjYW4gYmUgdXNlZCB0byBwcm92aWRlIGFjY2Vzcw0KPiA+ICAgICAgICAgICB0byBt
b3JlIEdQSU8gb3V0cHV0cy4NCj4gPg0KPiA+ICtjb25maWcgR1BJT19BREcxNDE0DQo+ID4gKyAg
ICAgICB0cmlzdGF0ZSAiQURHMTQxNCBTUFNUIFN3aXRjaCBEcml2ZXIiDQo+ID4gKyAgICAgICBk
ZXBlbmRzIG9uIFNQSQ0KPiA+ICsgICAgICAgaGVscA0KPiA+ICsgICAgICAgICBTYXkgeWVzIGhl
cmUgdG8gYnVpbGQgc3VwcG9ydCBmb3IgQW5hbG9nIERldmljZXMgQURHMTQxNCBTUFNUDQo+ID4g
KyAgICAgICAgIFN3aXRjaCBEcml2ZXINCj4gPiArDQo+ID4gKyAgICAgICAgIFRvIGNvbXBpbGUg
dGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQ0KPiA+ICsgICAgICAg
ICBtb2R1bGUgd2lsbCBiZSBjYWxsZWQgZ3Bpby1hZGcxNDE0Lg0KPiA+ICsNCj4gPiAgY29uZmln
IEdQSU9fTUFYMzE5MVgNCj4gPiAgICAgICAgIHRyaXN0YXRlICJNYXhpbSBNQVgzMTkxeCBpbmR1
c3RyaWFsIHNlcmlhbGl6ZXIiDQo+ID4gICAgICAgICBzZWxlY3QgQ1JDOA0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwaW8vTWFrZWZpbGUgYi9kcml2ZXJzL2dwaW8vTWFrZWZpbGUNCj4gPiBp
bmRleCA5ZTQwYWYxOTYuLjlhYjQ1ZDEyOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwaW8v
TWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL2dwaW8vTWFrZWZpbGUNCj4gPiBAQCAtMjQsNiAr
MjQsNyBAQCBvYmotJChDT05GSUdfR1BJT18xMDRfSURJXzQ4KSAgICAgICAgICs9IGdwaW8tMTA0
LWlkaS0NCj4gNDgubw0KPiA+ICBvYmotJChDT05GSUdfR1BJT18xMDRfSURJT18xNikgICAgICAg
ICArPSBncGlvLTEwNC1pZGlvLTE2Lm8NCj4gPiAgb2JqLSQoQ09ORklHX0dQSU9fNzRYMTY0KSAg
ICAgICAgICAgICAgKz0gZ3Bpby03NHgxNjQubw0KPiA+ICBvYmotJChDT05GSUdfR1BJT183NFhY
X01NSU8pICAgICAgICAgICArPSBncGlvLTc0eHgtbW1pby5vDQo+ID4gK29iai0kKENPTkZJR19H
UElPX0FERzE0MTQpICAgICAgICAgICAgICs9IGdwaW8tYWRnMTQxNC5vDQo+ID4gIG9iai0kKENP
TkZJR19HUElPX0FETlApICAgICAgICAgICAgICAgICAgICAgICAgKz0gZ3Bpby1hZG5wLm8NCj4g
PiAgb2JqLSQoQ09ORklHX0dQSU9fQURQNTUyMCkgICAgICAgICAgICAgKz0gZ3Bpby1hZHA1NTIw
Lm8NCj4gPiAgb2JqLSQoQ09ORklHX0dQSU9fQUdHUkVHQVRPUikgICAgICAgICAgKz0gZ3Bpby1h
Z2dyZWdhdG9yLm8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncGlvL2dwaW8tYWRnMTQxNC5j
IGIvZHJpdmVycy9ncGlvL2dwaW8tYWRnMTQxNC5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gPiBpbmRleCAwMDAwMDAwMDAuLjZjMDgzMGVlMg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiAr
KysgYi9kcml2ZXJzL2dwaW8vZ3Bpby1hZGcxNDE0LmMNCj4gPiBAQCAtMCwwICsxLDE0MSBAQA0K
PiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICsvKg0KPiA+ICsg
KiBBREcxNDE0IFNQU1QgU3dpdGNoIERyaXZlcg0KPiA+ICsgKg0KPiA+ICsgKiBDb3B5cmlnaHQg
MjAyNCBBbmFsb2cgRGV2aWNlcyBJbmMuDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUg
PGxpbnV4L2RlbGF5Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9ncGlvL2NvbnN1bWVyLmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9ncGlvL2RyaXZlci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgv
c3BpL3NwaS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+IA0KPiBDYW4geW91
IGtlZXAgdGhlIGhlYWRlcnMgaW4gYWxwaGFiZXRpY2FsIG9yZGVyIHBsZWFzZT8NCj4gDQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9wcm9wZXJ0eS5oPg0KPiA+ICsNCj4gPiArI2RlZmluZSBBREcxNDE0
X01BWF9ERVZJQ0VTICAgICAgICAgICAgNA0KPiA+ICsNCj4gPiArc3RydWN0IGFkZzE0MTRfc3Rh
dGUgew0KPiA+ICsgICAgICAgc3RydWN0IHNwaV9kZXZpY2UgICAgICAgICAgICAgICAqc3BpOw0K
PiA+ICsgICAgICAgc3RydWN0IGdwaW9fY2hpcCAgICAgICAgICAgICAgICBjaGlwOw0KPiA+ICsg
ICAgICAgc3RydWN0IG11dGV4ICAgICAgICAgICAgICAgICAgICBsb2NrOyAvKiBwcm90ZWN0IHNl
bnNvciBzdGF0ZSAqLw0KPiANCj4gTG9ja2luZyBoZXJlIGlzIHNpbXBsZSBlbm91Z2ggdGhhdCB5
b3UgY291bGQgdXNlIHRoZSBTUEkgcmVnbWFwIGFuZA0KPiBnZXQgaXQgdG8gZG8gdGhlIHNlcmlh
bGl6YXRpb24gZm9yIHlvdS4gQW5kIHRoZW4geW91IGNvdWxkIHBvc3NpYmx5DQo+IHJldXNlIHRo
ZSBncGlvLXJlZ21hcCBhYnN0cmFjdGlvbiBhbmQgZ2V0IGFuIGV2ZW4gc21hbGxlciBmb290cHJp
bnQuDQoNCkkgY291bGQgbm90IHNlZW0gdG8gZmlndXJlIG91dCBob3cgdG8gdXNlIHRoZSBTUEkg
cmVnbWFwIGluIHRoaXMgY2FzZS4NClNpbmNlIHRoZSBudW1iZXIgb2YgZGFpc3ktY2hhaW5lZCBk
ZXZpY2VzIGRlcGVuZHMgb24gdGhlIGxlbmd0aCBvZg0KZGF0YSB0cmFuc2ZlcnJlZCB3aXRoIGNv
bnRpbnVvdXMgdHJhbnNhY3Rpb24sIEkgY291bGQgbm90IGRldGVybWluZQ0KaG93IHRvIGltcGxl
bWVudCB0aGF0IHVzaW5nIHRoZSBTUEkgcmVnbWFwLiBPciBtYXliZSBJIG1pc3VuZGVyc3Rvb2QN
CnRoZSBzdGF0ZW1lbnQuIEhvd2V2ZXIsIGlzIGl0IHN0aWxsIGFjY2VwdGFibGUgdG8gdXNlIHRo
ZSBjdXJyZW50IGFwcHJvYWNoPw0KDQpCZXN0IHJlZ2FyZHMsDQpLaW0NCg0K

