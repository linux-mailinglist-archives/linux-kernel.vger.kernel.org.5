Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B6476531D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjG0MCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjG0MCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:02:21 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDA52D45;
        Thu, 27 Jul 2023 05:02:18 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RBALMg027968;
        Thu, 27 Jul 2023 08:02:11 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3s36a9dutb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 08:02:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbHuBBLEyGOXB6rZNebtWlkqtCMHPrSOypOIkhCVYy8Dpw7JvSdMQkAdsiCObnwV4/Eo8VcEVD9U6kaTDjqR6/Xbs1NjKvFf5CDzD5opWD8gMlN9j4CElecNMIznAlfOmlqf/unyefom4cqkM/vA2bJjJgj4sUdyj1T+moh6UYkPHIhTFTVc2CnG0qy6C6UREuYbRLN21YgDMDP0a4B05EFWDX0TEtcQSDsrPgOw+suvp6hrjUAjhE9PY54UEhaQqhUYZJmOs5TSL7ZMeNoHjraRzqW1C2vowbk1B/kI6oBNCEtmFkUYlChwSArz5MNM8llkJpmG/gYkU+Hd/G+n2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=968tf/7KvgC+ZEBw4IZUtvIkeyNDfdW5+qsxxegTGu4=;
 b=gdn7eOPT4XSZj+fH4HgzulW0LUpyL+tkcz7AKDANhOtWKg+5tRefjNAyFcmothkzdapS3MaH5rM53VykEDgPVtYeT7KXCrv+COkDENMqr/4282Evs2w9wHAsUCxnENgI6UBr2yA2nOsrBGv8NhDmkMY8zyuybn2gh3X9fpggeoBx/bRHJk4lE/jTtOZy0FZ5cgFZ7C4/kj9+HmXzpwW51hut0su2943UW7n3ocIUonzKhfGTGmUwcGyg42LV5DQDBUe4gJww3yR2Vs8tjh45+DjYpvPBfXK2sje7amS49B1E08UxGzuNWkbgDg6ShSMWCdVbmJql2kWtT3/VF7Gwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=968tf/7KvgC+ZEBw4IZUtvIkeyNDfdW5+qsxxegTGu4=;
 b=UNqyzX6iogF6xiTSqyF346MUoo5hJjrlN+fKUV3P7ls1mhJrRShySo3/UbVQgT5NlLhna12MYFCq8kI0/Dt85PbivhZV3j3kkofVo/QBxjdKNF+YmRRWVnwaa8lGKaCJtcjIRZi/YaS7is6bE4yzF+em9o1ujMPM+Fbhi48JBPI=
Received: from BN6PR03MB3395.namprd03.prod.outlook.com (2603:10b6:405:3f::23)
 by SJ0PR03MB5790.namprd03.prod.outlook.com (2603:10b6:a03:2dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Thu, 27 Jul
 2023 12:02:04 +0000
Received: from BN6PR03MB3395.namprd03.prod.outlook.com
 ([fe80::728d:be5a:be21:90cf]) by BN6PR03MB3395.namprd03.prod.outlook.com
 ([fe80::728d:be5a:be21:90cf%7]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 12:02:04 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: iio: admv1014: make all regs required
Thread-Topic: [PATCH] dt-bindings: iio: admv1014: make all regs required
Thread-Index: AQHZwH4RV2JH17iyYkyP+nPY8DJsEq/NfymAgAABKCA=
Date:   Thu, 27 Jul 2023 12:02:04 +0000
Message-ID: <BN6PR03MB3395F9139A225AA97A100B829B01A@BN6PR03MB3395.namprd03.prod.outlook.com>
References: <20230727113136.98037-1-antoniu.miclaus@analog.com>
 <7f7d1c90-9969-66bd-fd71-defffe0e05d6@linaro.org>
In-Reply-To: <7f7d1c90-9969-66bd-fd71-defffe0e05d6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAyTW1Wa1lUY3hNQzB5WXpjMUxURXhaV1V0WVdVeVlpMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjTmpKbFpHRTNNVEV0TW1NM05TMHhN?=
 =?utf-8?B?V1ZsTFdGbE1tSXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhNVE0xSWlCMFBTSXhNek16TkRrek1qa3hPVEEzTXpVeE5UQWlJR2c5SWpC?=
 =?utf-8?B?b1kyUmlialIzYW1wRFRpdHBPVXBhT0V0aGIzb3pWVlZsVVQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVhWVVdFMXNaM05FV2tGYVNsUlFWVE5XVTFrclVX?=
 =?utf-8?B?dHNUVGxVWkZaS2FqVkJSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQmNXVjRNVlpSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR03MB3395:EE_|SJ0PR03MB5790:EE_
x-ms-office365-filtering-correlation-id: 018a3874-016e-439c-d604-08db8e994b12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qIhFE3FL/q3pYRj6lcGfSsYxJx89sNFAlqoOig/enuDb3pSzyXInvizqqWgVfcVSq33g8GJW8HBtxPXCx/CrPqX503RPOskRH5t6ivBZuNlXdCdT3LNc9zXCbv+E5mHEa5yZjJst7hm6xtc4zHVBwau6j0cTOdXH/KpxyCkJIO5s06CMvOpV8H6ETXHbfBvHKnhRBpXUHtN8BfRTAsZyh4af3hC1EJd1zP2gK0MSkMmICNt8qiC4Qs/zjRVLGYiu4Zvx4YFZpsJndSLWvLQ0+5yYe4Xd0c2SoWhXVcMYn/evEQhfe0ju0z0pPD2mBeczsIZKNm+68+EuvZF2Kzp6PYbLUdoDtnm8S9pKGXJkfio6J0EjV52bJJ0kZ1M2JKpsmQZjlrqzXN9WZM0VKayvqPJgIeczeVhfgLY+821uukCsX5l+gt77xX9262YIlozx+Ga/P//f/7IA/N2NlWjKXHkaIS8RZUr2Fe4nzXluScXLViZ7+eYky8KwYyhFn9erB3HFaxvglg2P/N0GSjl1hkXik7CuGWw9kYL5zzyv3A4DwZa8VpY2yMhyrsIDer0HZvFkbNCLlU6qSEw99BkEwR5oP2pgXTtlXoqnucw9tUk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3395.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(38100700002)(6506007)(53546011)(186003)(86362001)(26005)(71200400001)(83380400001)(122000001)(38070700005)(9686003)(7696005)(66446008)(64756008)(66476007)(316002)(76116006)(66946007)(8936002)(478600001)(41300700001)(5660300002)(55016003)(8676002)(4744005)(110136005)(52536014)(2906002)(33656002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2xud29PUEEra1EwUDF0NzVJNGx2c21URTZ4LzRFVE9UTzJ3U0FOMyt4dlVN?=
 =?utf-8?B?TmFuR2hSU1g4TS9TUVowbEtUMkhmcTAwcUxHVGR3WFFRZ3NTbVBBQTRKNklT?=
 =?utf-8?B?WWM3WURIQlkyYnZsaUt2UWtDcndtcjFYNFp6bGNHWEx5UndaK2JRL2h0VVdJ?=
 =?utf-8?B?UkZIWUFka1lYTXNIbWtuSURsbG1Qa1RUZ2gzTkgyTDIwemNYZ3M5UlNBeHQx?=
 =?utf-8?B?aUFzSHhOTGc0SG1EZ24zUUIyU3NBcktqSjUzaktqdHZ5bzBVSFU2OGRRVnhK?=
 =?utf-8?B?TCtCbk9HUGdPL3ZoRUxtejN1Qy9tWDA3NWpTeGFZQXlVZEZvZjM0enh3ZWho?=
 =?utf-8?B?ZUJHQk5OcGxySzR6bTdPZC9sNTlXU0dubVkvVnNwa1VIT1NKeG5VR0Y5UHpr?=
 =?utf-8?B?QjNhdHU0Zzk3ZDRsb0hHYnNlZ3BoeFpiWUpnVnBNbmErMWdrS2RHVlg3cUVD?=
 =?utf-8?B?YnVHTm5IeXplVENyUzJuaHhkczNubk1YUSsyK3Jtb2phRnBKMHAzcmpSNFBs?=
 =?utf-8?B?WEZ0YXUyWlNYa3kydGNzc01ncC9OM293enBuWkIweHE4TGplZXM3b2ZrY1No?=
 =?utf-8?B?YUd0TUxlR29UVUczcE5ENTBQNUFmOVhuMHJhaXUydWtKWWc2aFZ2a0xjNjhU?=
 =?utf-8?B?RktSSm9jNkN0ZDl0T2lObmlqOXdIUldpNWkwME03dDF0eXRhbGQ4eHg1MnBq?=
 =?utf-8?B?MjMrd0U0bklyN0lNZHNrcTNiTEE5S0NtWWhhTUFmRSsyUHdPZURVb1hJUVo4?=
 =?utf-8?B?bG5kaFUra3IrcmNNR2Yyc201TjU5VXF1d01nR0FsaHJ0ajlDRDZnRUQxOElG?=
 =?utf-8?B?TC8yNEZMOGdpbUFINi9vN1hoTVFvQURVZzFiNmVrRlcveFBoYXZGM0lsSDY5?=
 =?utf-8?B?OWpYc3F3N2NvNjNNVllSdDNJUVpCZU9hSnNOTkRlaEFrU0gxYkJ4clgvaGJY?=
 =?utf-8?B?TjdHbmI2Tk1tVUx0UWY2YWhQSktFczVMdVZyM2RYRm9LcGtwRk90bWZ2NUVR?=
 =?utf-8?B?T2xrbkNaSWF6bHhtRmwyMnY2YXdKS2hDWjdnUHUzZVMvRXM3RlVBaXNJRi9a?=
 =?utf-8?B?eUVPK1lVL1M1bDN4eUVialduL2d1b3piMmlBV1lwRmNnMzlBTXpHSEtyckZ0?=
 =?utf-8?B?bm5TeTY2amluNXZGVDZDc2Y5Rk13UFg4NUFSNE1IVzg2aVdXRGRvTUZPQXB4?=
 =?utf-8?B?UldlbFZJRTEzWXZPVlUzM21MYkpsSW1qZ0x6Q1NmNzlEWm80NkgyRFVrSUxR?=
 =?utf-8?B?Q0JXNFZJRGpqc0J5T0huTXRIeGtLVmliWHZiVXp5M0hPdXpSSEF0a2NMTTJK?=
 =?utf-8?B?Vk9HdG9Rc0k1QnZNcHpibURRNzl0SFk3NVVLVEJ5M2xJNHZ0ejdFOU4waVJp?=
 =?utf-8?B?c254cHJxS2FJYVYrMVhLN3RZMU9hdmphaEpIQ3hZZ3U1alllWEFWdTkxbGY2?=
 =?utf-8?B?eVZEa0RvR1d6SU5FS0lNbHNRN0M5aHJGUVZZSFgvdEYrZUZPTWZBU1lhcDRs?=
 =?utf-8?B?SU1STFE4eTY0ZGtWanBPeUpFbldPYm5VT2xVQTBBclUzc0NjaVJSMVdSMjRO?=
 =?utf-8?B?TzVVVVVOaG84dUhCMXVoYVpWUmZDK1BZNUcwakVYT2dPMWVIQWlYUVYzMjlW?=
 =?utf-8?B?Tnl3TkFoZDdHWXR1eE9FMUYxWHBGeFZydnU2QTJveDhwY1FwY1dLa2hHUWJB?=
 =?utf-8?B?dGNIQUtsU0t1a3ZwZnV1dSswM1RxWGQ2TEJZMUdZWCtob3AvSm9vbG9PTTRG?=
 =?utf-8?B?NGtHVjdDdnoxQVBBWjhoNVByaFA0L0N4WDI3cnE3eFBhbTlUbXd6WDRSY1ZQ?=
 =?utf-8?B?YUJtOEdCRnhJVHI4VEIrRDVENDBsNGhiVHZZai9VaVV2NFZOSWtuQUlBbWJH?=
 =?utf-8?B?SThEa0NMRHh1bEJsSkFyRmp4NHppOVA2M1pYakhtOWhmRGVTZzBINW9HaCtX?=
 =?utf-8?B?MzFqLzQreXA5S242R01yb3c5UXREYTlSLzB5RUF1OXdPYWkyaGhLczlKVVdL?=
 =?utf-8?B?MGVWU000L1RZZEJxTnBiQ0RKeGFEMHlnb0RuUG0rZTFEZ3E2d1c0MjVsbGsx?=
 =?utf-8?B?Z01uYXZGRUkxM3UwUk11bW9Cc1RFc3RXYkxPMExlRk1iVlJkWFFXQ3dDRFgz?=
 =?utf-8?B?dFc1MS9ycnlUeUdxVjdPTkZSK0ltbVdlUTNhdzZaOGdVdkRqWVRreVpBem0z?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR03MB3395.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018a3874-016e-439c-d604-08db8e994b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 12:02:04.3133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l09TbN7acfBJZomgVtnR4xkPN9rZVIXlTJftiCykc6TSO6KkQ8wAHaavn6ACo9NJNT4tZZQo4SYzB5k9O/7tYPwPBjDBqPqWFAYLFj51+fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5790
X-Proofpoint-GUID: HXly-nqVClNgqlM5199Ah4WZ8H8QAJ7r
X-Proofpoint-ORIG-GUID: HXly-nqVClNgqlM5199Ah4WZ8H8QAJ7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=555
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307270107
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5
IDI3LCAyMDIzIDI6NDcgUE0NCj4gVG86IE1pY2xhdXMsIEFudG9uaXUgPEFudG9uaXUuTWljbGF1
c0BhbmFsb2cuY29tPjsgamljMjNAa2VybmVsLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBr
cnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7
IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGR0
LWJpbmRpbmdzOiBpaW86IGFkbXYxMDE0OiBtYWtlIGFsbCByZWdzIHJlcXVpcmVkDQo+IA0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiBPbiAyNy8wNy8yMDIzIDEzOjMxLCBBbnRvbml1IE1pY2xhdXMgd3Jv
dGU6DQo+ID4gU2luY2UgdGhlIHJlZ3VsYXRvcnMgYXJlIHJlcXVpcmVkIGluIHRoZSBkcml2ZXIg
aW1wbGVtZW50YXRpb24sIG1ha2UNCj4gPiB0aGVtIHJlcXVpcmVkIGFsc28gaW4gdGhlIGJpbmRp
bmdzLg0KPiA+DQo+IA0KPiBUaGUgdHJ1ZSByZWFzb24gc2hvdWxkIGJlIHdoZXRoZXIgdGhlIGhh
cmR3YXJlIHJlcXVpcmVzIHRoZW0uIEJlY2F1c2UgaWYNCj4gaGFyZHdhcmUgZG9lcyBub3QgbmVl
ZCBzb21lLCB0aGUgZHJpdmVyIHNob3VsZCBiZSBmaXhlZC4NClRoZSBkYXRhc2hlZXQgaXMgbm90
IHZlcnkgZXhwbGljaXQgb24gdGhpcyB0b3BpYywgYnV0IGFsbCB0aGUgc3BlY2lmaWNhdGlvbnMg
b2YgdGhlDQpwYXJ0IGFyZSBidWlsdCBhcm91bmQgdGhlc2UgcGlucyBiZWluZyBzdXBwbGllZC4N
Ck1vcmVvdmVyLCB0aGUgZXZhbHVhdGlvbiBib2FyZCBvciB0aGUgcGFydCBjb21lcyB3aXRoIGFs
bCBWQ0MgcGlucyBjb25uZWN0ZWQNCnRvIGZpeGVkIHN1cHBsaWVzLg0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0KDQo=
