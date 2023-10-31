Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB587DD054
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344391AbjJaPTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344626AbjJaPTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:19:04 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836D91717;
        Tue, 31 Oct 2023 08:17:34 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39VF7tBd008084;
        Tue, 31 Oct 2023 11:16:37 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3u32ynrruy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 11:16:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfrXMZdOv+A4O8tqo8wd7A+dmcYJp7TkI7TYYFM6vjDf4CGq90PQqEl+jGleLI0bfpn3e+86OB9dBc2DLZLPE4j1XXjQikzh66ZrZX5gl+6YMD9YXC30ESaQbij5PL/8AEOd6BNbzuo1rp4YIRz5o7XaoLw7lrqk9JU9Dlo3fBl5uje3hk1WapR5JYVrf3Gpk7D7j3rSZgSGpmQ+60IDV/HmjNBTxv+1c/f9Kc+g7n+dUPD+Ra8ke7Y5gfLUOCDNoCKyPvIub3srJAXKiiXA9IOC2pZuVlscFhb+KaU7US2Lta5mQEI3QFs9A1TN9chlyIEmdECRK5NFl0rq+nYlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrxqPRF2Qmgt8w9DkUtNSsPnDPB4r7ADi5UAoL4K6cI=;
 b=hSJaAkGG6fUR/AGLJYmA71OFG7ifmRlulF+T0EACF9WzUlG5MZsJib7c9Fzsj37Ev72kXTPrhU0MvCDO0uMhjI2TZDAFFY3jiUZP+K1diQCQqmhjhiqh50KvHMf5CVLct2ZCVO2R/Tt53cZPhvwIFOvbBeN8cYC3QmuEIJPkYD/wZlf7MRh/kGVVD95sy9aRX5F6TakytdFX4ss2XN0UB9B+69FcG6CmGEuBXFLWWfvL+jWKFZOJo6JgNUa0zCDK39BzKkGk4bfHAHUWEKbTAFAB5a+vdq2mNMn73RmWunKsl6tiZgMkp+OJ5VfX2DxMvaqp93uIb2H2CXVVGmFXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrxqPRF2Qmgt8w9DkUtNSsPnDPB4r7ADi5UAoL4K6cI=;
 b=86mpr3QTrtszwjB9JIp0rrB8udx717rN+/8Sl5R0djp/huIuK1hFEqqob6hWic7ufQzBtEJuILYZHIh1nvfTmzCIhFkuKHfH7Glnd17kCdGYQT4NfCncICQcyLoVkiC6OTv/kqacwJGFPMTSNLpPuA64Iwq86V/8ofAw5dgBtJE=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SN4PR03MB6750.namprd03.prod.outlook.com (2603:10b6:806:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Tue, 31 Oct
 2023 14:44:05 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321%3]) with mapi id 15.20.6954.014; Tue, 31 Oct 2023
 14:44:05 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: rtc: max31335: add max31335 bindings
Thread-Topic: [PATCH 1/2] dt-bindings: rtc: max31335: add max31335 bindings
Thread-Index: AQHaCyeKLCuMriAqW0+5lr1vn1bC0LBilZ4AgAEdooCAADmbAIAADg5w
Date:   Tue, 31 Oct 2023 14:44:05 +0000
Message-ID: <CY4PR03MB3399163E5D76A53927EEA9509BA0A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20231030115016.97823-1-antoniu.miclaus@analog.com>
 <20231030115016.97823-2-antoniu.miclaus@analog.com>
 <11906efc-e16a-40bc-98a5-db32fefbf355@linaro.org>
 <CY4PR03MB3399A0D6DCA419936B024D759BA0A@CY4PR03MB3399.namprd03.prod.outlook.com>
 <680e77cf-a930-4eb8-9987-67f748a424e3@linaro.org>
In-Reply-To: <680e77cf-a930-4eb8-9987-67f748a424e3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFsWmpReU9URTFNeTAzTjJaaUxURXhaV1V0WVdVM09DMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjWldZME1qa3hOVFV0TnpkbVlpMHhN?=
 =?utf-8?B?V1ZsTFdGbE56Z3RaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STNOellpSUhROUlqRXpNelF6TWpNM01EUXpPVGt6TXpVNU15SWdhRDBpZW14?=
 =?utf-8?B?TWNGbFNZMVpGVldoQmFIVTJTUzlyVUd4dmVEZzNZMjVGUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlJXOURRVUZEV2xSd2VYaERRWHBoUVZZeFZqWlRNVFExY0RSd1dG?=
 =?utf-8?B?WlljRXhZYW0xdWFXdEVRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUkdGQlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGRlQzQnNUMmRCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKb1FVZFJRV0ZSUW1aQlNFMUJXbEZDYWtGSVZVRmpaMEpzUVVZNFFX?=
 =?utf-8?B?TkJRbmxCUnpoQllXZENiRUZIVFVGa1FVSjZRVVk0UVZwblFtaEJSM2RCWTNk?=
 =?utf-8?B?Q2JFRkdPRUZhWjBKMlFVaE5RV0ZSUWpCQlIydEJaR2RDYkVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhSVUZhUVVKd1FVWTRRV04zUW14QlIwMUJaRkZD?=
 =?utf-8?B?ZVVGSFZVRllkMEozUVVoSlFXSjNRbkZCUjFWQldYZENNRUZJVFVGWWQwSXdR?=
 =?utf-8?B?VWRyUVZwUlFubEJSRVZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV1ZGQ2EwRkhhMEZZZDBKNlFV?=
 =?utf-8?B?ZFZRVmwzUWpGQlNFbEJXbEZDWmtGSVFVRmpaMEoyUVVkdlFWcFJRbXBCU0ZG?=
 =?utf-8?B?QlkzZENaa0ZJVVVGaFVVSnNRVWhKUVUxblFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUU5UFNJdlBqd3ZiV1Yw?=
 =?utf-8?Q?YT4=3D?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SN4PR03MB6750:EE_
x-ms-office365-filtering-correlation-id: 3d0f4175-bc8b-4363-a8c6-08dbda1fd509
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yU051CA3SPd2qzHUK5eH3wTh/DmHb5foEFgIwgDVrHl4GTcSqTdnE1MfH6YAzoTRO3H2HZwR1AfQmZlfMa6cGZwrg/zKrOiduV07zXHcdRM7NzJMQlpa5Ebs8NLCLxok97FFiWy2aDiYyRUCwJMnxvzhAJ3b4yflng8A/JvgQn2oX2ZYT92ayUhoOfYm5TKkgCKjLbQMlb8wjb9dXUG+zjkN8Y2EUw5tnlc+/Gju7Qt3zaNfWGznlbcm+WrDO9vvNdliofLyRwvg4HJC449L5F/3tJULtgG0PafRcPyKAzyVSmzrT9xOCDCEohUBQbCpx7imGszStrw2VESEhvSb8LS/uh0DagdOGXfw54tIS42+0YGOO9TzhNfnEzfCILzxtXvzMoigqnYAGQBgXu0ONUNW0jVR7qH/mHrR7CWJSNs9DnJ3T3GnxyZcV8EbroJMxWJrSK5lkuACbi7F/iv+0m/Zopit9zGy5XkVZ3fnf5CX9204zHez76j9w+ZXb0OWyCc7URvpmx5pJqDV4BV8E//FLR3mWXRrGvwo4u6OI2DEWhcgsiothZzoBnDbNeVzS04ajp9Lin3b9D1tKf2DCWhcl8uZB9U7D8IbLiPrNnEIa6TZWz0UNDTIR8lnwdw76FFpMHzxZpDSg8AViC4YJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(122000001)(921008)(38070700009)(7696005)(478600001)(9686003)(53546011)(66446008)(8676002)(66556008)(64756008)(66476007)(76116006)(66946007)(8936002)(6506007)(316002)(52536014)(4744005)(7416002)(2906002)(5660300002)(110136005)(41300700001)(83380400001)(71200400001)(26005)(55016003)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDhybGRDQmM0a3krRzQwMForOW9FSTVVb0FZYUtJa3dIWThLZERQeWlJemJp?=
 =?utf-8?B?N2NOWW5Mc0c5eklnMEtwNXE4b2FLN2ZkQk1FVkdteGJBeUViMUN0Z0JiNHd6?=
 =?utf-8?B?bytYd3BvUDR5NmE4MXVCWDUxSldHVVYwSkF6L1JBYWx3VU8yc2llaFp4U0dF?=
 =?utf-8?B?Y1JUUEEzK1dyR2U4eno0N2NHYWlqNHBqUTF5Wnh1MGZvVFE2ZXN5eTNya1NI?=
 =?utf-8?B?UEdqY1lnUmorYmoxaHd3SU03OXdKRzFEUENTTnRHRHhRajVUZUMydUl0YnBR?=
 =?utf-8?B?YjF5cTZOOEc2MW9VOWFjcHg3RDlYZWtyd1I3NmxZclczS0V0OUw0NE13dUxs?=
 =?utf-8?B?cDZCSG8xMStLSHc3enJ2UzJ4Q09qbkwzaS95MloveGs4TVpxRVpiSGdQT05N?=
 =?utf-8?B?Y2VCRHJsM3lpUUp5S1NlMUxmdDJqODl4eGR0dGFSZzBUYmM4SzR4R0RzZzhV?=
 =?utf-8?B?aEp3U0h6cnFjSFFPWHBSNnJ4S05kQVZKU09lYXpOSkJibkUydVRiTmtudVJm?=
 =?utf-8?B?S2ZZUGpNSGFvQlAxMkRhcU44azdtREM1RDlmRVlXZVRWbHIwN0pEY3VMeHRQ?=
 =?utf-8?B?d3Q0Z2lFVVN5RENmb2Z1emZ1UWpLQk5LTkhaZGdBOGRTK1NjbHpENHM2SGxj?=
 =?utf-8?B?dEJWdE9YMmJhUFVNeU5CZGhNR0FqOXdMcDdwb0lBNURLU2ZYa1lNcnRQQWlC?=
 =?utf-8?B?VzUyaVYvUXExc1hmdmVYVGhXaEQ2aFIrQWNrdHV1S1NBRDlLdW12Rmpzckgy?=
 =?utf-8?B?d2RCK0hlaU5NaHRaUEpYY3l6U1MwcGduMzRRZDQxdWNObXJ4TlI2LzltY2dV?=
 =?utf-8?B?c09tZitQbkU2V0o0SEVEK3JYd3hlWEQwTVVKOUFiNExwT1BaeHpSRXJ3cXFm?=
 =?utf-8?B?UTFJTi9lK2xvcmVkZ1pMM2hIL2RUcms5dWNFVklKbWFyVmExcFdiTS96ZjFs?=
 =?utf-8?B?T0pIY3lZSy8zWUZCTW13V3ZhUGpVUnpodldKK05iaXY2U2k4eE1DQzZXY2xV?=
 =?utf-8?B?V2xJV2RWVU5tZHFQUDVwcWxUd0d5ZWhQQ0tZQU1UdEx1RjRrQnlBNU5WQW5p?=
 =?utf-8?B?T2dNZEFnajZJOTBlZnVYVVN4R0ppSm1qaElSM0ZJRm4zd1lTTVpzK2J0WnRl?=
 =?utf-8?B?c0E2VkloR3J4SGh3dEFBWWxWZmxFUURCcGRxRmdMY3JxdlVCT2E1Z2VvNWth?=
 =?utf-8?B?Znl0TU9JUnJuaDlWZTdUdmR2bG13K0ZySEx5Umc1RWpnZHhmR1Vvc1Fybjls?=
 =?utf-8?B?aDRVNkw2MC9RTmRoOFE3QXlVbi9XL1J0ZXcxc3Rxa1FnOWh0RnNuNUg1djI3?=
 =?utf-8?B?Y05ldEplWWt6WDRxUEl1TU44RkRybGFDbkZNTHhINnkxdmhiNzRIeDRGakha?=
 =?utf-8?B?VmlPTU45ekI2OEExMklhQlZ3anNBQkcwVDRvejNJS2xrdE9RaTc4eW1nWGtI?=
 =?utf-8?B?cUh3K3VwTVQwRE9ZTEJERDc0NGw5TWFRajJJV1REbTBIZFUyQ2JjaEl4MWFx?=
 =?utf-8?B?cFdlSEVFM0NJd3ZMeGppY25Tb2lBelNGaW9QRjBXc0xtQUpNWXM4LzQwZlh5?=
 =?utf-8?B?Y21pMHZuckZvN1ZZTi9zZzZjZSsvK25kYnFadDVMeFErSjdMR2kwQzhPSEJp?=
 =?utf-8?B?YlpmWlFpbGZPUVJ0RTh2cmJpUmQwQ3ZGS3N3VHova2x0MmpGWG5LUlpEWHNa?=
 =?utf-8?B?ZXd5R09TZ1hqdVNOQWR2dldqUzlFTmdnTVJacjA0ZXdUMzdTZW5FaFVodDdV?=
 =?utf-8?B?U3RwbkJaYS9VQjhreW5nRG1laUNxYWFFZTdkT1lUMGFuclNGellUYW4rMi9r?=
 =?utf-8?B?aEZyRU9Kb2JVd2ZJNFFQZkJDM3FRZkZIUzZaS00rYjBUdGMrQmJZYmpnMTN6?=
 =?utf-8?B?Q0ZUMFJlcEVTdDZhVHJBcFBaS2hsVWg3SVZ1NjUwcEt5bXhwamtKdTMxcmZv?=
 =?utf-8?B?OC9IQ01JUFZBUlE5UGU2bTJJR01PdGpVQzM3MVVtV2ZhUlptN0RRajJnM3M2?=
 =?utf-8?B?RGlpcHliMWhwbDVrODlXQjdwMlByRk9WK2QyaGpiSThRelUzVXh4UTh0Yklh?=
 =?utf-8?B?N1U5SXdsWC9URTdpR2tKSW1VS0V0R3FRdEgrcFIxOTZmb3dpeGJuMXFPbE1S?=
 =?utf-8?B?WVBuN3JPQ05QZ0Y2dDFCWW5qVDc3VXl2TnJxY2hqWDJJenZjTWUvVWUxWG91?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0f4175-bc8b-4363-a8c6-08dbda1fd509
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 14:44:05.5951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06CCopeFCBdnazdTlfiBRlP5V2u1Tz4YgdNCl8dXRzYUBUUQSBCag0Gny44znZ0gcaTVvmaASZF7UgmlxESJOrVcBedBFGZf43xUr1hee+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB6750
X-Proofpoint-GUID: YifaPaU4ZOEyHchOFze2fuwHm2rKAJJL
X-Proofpoint-ORIG-GUID: YifaPaU4ZOEyHchOFze2fuwHm2rKAJJL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_02,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=873
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2310310120
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAzMS8xMC8yMDIzIDExOjI5LCBNaWNsYXVzLCBBbnRvbml1IHdyb3RlOg0KPiANCj4gPj4+
ICsgICAgbWF4SXRlbXM6IDENCj4gPj4+ICsNCj4gPj4+ICsgIGludGVycnVwdHM6DQo+ID4+PiAr
ICAgIG1heEl0ZW1zOiAxDQo+ID4+PiArDQo+ID4+PiArICAiI2Nsb2NrLWNlbGxzIjoNCj4gPj4+
ICsgICAgZGVzY3JpcHRpb246DQo+ID4+PiArICAgICAgUlRDIGNhbiBiZSB1c2VkIGFzIGEgY2xv
Y2sgc291cmNlIHRocm91Z2ggaXRzIGNsb2NrIG91dHB1dCBwaW4uDQo+ID4+PiArICAgIGNvbnN0
OiAwDQo+ID4+PiArDQo+ID4+PiArICB0cmlja2xlLXJlc2lzdG9yLW9obXM6DQo+ID4+PiArICAg
IGRlc2NyaXB0aW9uOiBTZWxlY3RlZCByZXNpc3RvciBmb3IgdHJpY2tsZSBjaGFyZ2VyLg0KPiA+
Pj4gKyAgICBlbnVtOiBbMzAwMCwgNjAwMCwgMTEwMDBdDQo+ID4+DQo+ID4+IGRlZmF1bHQ/IE9y
IG1pc3NpbmcgcHJvcGVydHkgaGFzIG90aGVyIG1lYW5pbmcuLi4NCj4gPg0KPiA+IElmIHRyaWNr
bGUtcmVzaXN0b3Itb2htcyBwcm9wZXJ0eSBpcyBtaXNzaW5nLCB0aGVuIHRoZSB0cmlja2xlIGNo
YXJnZXIgc2V0dXAgaXMNCj4gc2tpcHBlZC4NCj4gDQo+IFRoZW4gbWVudGlvbiB0aGlzLg0KPiAN
Cg0KIFdpbGwgZG8gaW4gdjMuDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
