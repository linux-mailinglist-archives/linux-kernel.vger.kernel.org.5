Return-Path: <linux-kernel+bounces-3225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9F5816972
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8491F21B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B50B13AE3;
	Mon, 18 Dec 2023 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="QvhJpSWc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E414267;
	Mon, 18 Dec 2023 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI7qjW9002411;
	Mon, 18 Dec 2023 04:09:01 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3v2d4psdr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 04:09:00 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgWjEAFMKIwCWTSlHfpmOD3X68oyaWXGKtL0BI+ZwYsjtLfmDu4r+SH4Y6eTEZm8bYZc7pRIwboQ1foe+1U/jPCaG5uxXmKOZXxm8eLhYWld78mRwzk7NifaqxEfZNlRH5Hkew8ErT+odCEMnDfbi2Nb++rtek/NUl3YqnxqNzi4iRFupTiQDYJuBLAdqxnoGbyxG2WkHPo9Ul/5ag1bfCyzaOqiR7LCdRQ9ifICTRzNx6d8jK+9VD3WA+Ckw3aRObHfmKldTXmkY51xE4R6g1M+DnPdjNuBQ1o/qyNR9kQKITp3GHiFoeJTPiPGd/Z+1oWk+h68nKPhM7vBohmDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2WhlB/vqxYkWZI6wBeCTEkuSvyXWEFRInet67RDMQU=;
 b=RhrI6/hNYca2xC/bvJb7CeoQyEty9K/rYOYmsWGxu1OM/Iuzz3K2n6ptHOmOCvVG4t9zx6dHeFgESrVzaV5dEbq5X4qkM3iTj3+x8M3dcdjYoaEZXnLbXkQpIXaEu/8CofA14TL8iXFR3ZwARe/Z7ZvPKSeEQYmnwxJUgNw0CZFtaa36TgBlFfGE1kapR2HxzRJulzNhTtse54B5kIx8p/70yL7x07nj77aEfOB0T1k4WauknoYlCEZymHkmSiZeLPka4mKqYC1u6SivrEBBOPRwzp7nY2fGtjBNA/ue5nvT7wXDW7NPnszk/5bzSH96p+ETXcGWZu1gjF5RbHLKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2WhlB/vqxYkWZI6wBeCTEkuSvyXWEFRInet67RDMQU=;
 b=QvhJpSWc1ckRTmRmsmh6vjcE5opapkaBwt7joYg6SuWgM9FU4bfIZJuMlw5IATWFBsPf0CsIwZF1LGbzDsrMEDbVz0LLl/6FyOmEbr5CHeoduZQtlLkDoznlA9LKp/LIPKhidZ+eoMWCu9BYP+KWa5xZtWtHXDKmPWaWGjbP+9o=
Received: from SJ0PR03MB6764.namprd03.prod.outlook.com (2603:10b6:a03:40b::5)
 by PH0PR03MB7160.namprd03.prod.outlook.com (2603:10b6:510:294::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 09:08:58 +0000
Received: from SJ0PR03MB6764.namprd03.prod.outlook.com
 ([fe80::9f91:f8ce:6169:9246]) by SJ0PR03MB6764.namprd03.prod.outlook.com
 ([fe80::9f91:f8ce:6169:9246%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 09:08:57 +0000
From: "Matyas, Daniel" <Daniel.Matyas@analog.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH 2/3] bindings: hwmon: Add adi,adaq4224_temp as compatible
 string
Thread-Topic: [PATCH 2/3] bindings: hwmon: Add adi,adaq4224_temp as compatible
 string
Thread-Index: AQHaLpsLpQ9klqsewUuhbQre1ZPqQLCqChWAgAB5EwCAAEzuwA==
Date: Mon, 18 Dec 2023 09:08:57 +0000
Message-ID: 
 <SJ0PR03MB67643A8DD1F7AD8CEF66BBBE8990A@SJ0PR03MB6764.namprd03.prod.outlook.com>
References: <20231214143648.175336-1-daniel.matyas@analog.com>
 <20231214143648.175336-2-daniel.matyas@analog.com>
 <43c3f6cb-aeb2-40c8-a79d-c2222414b49c@linaro.org>
 <a5bc25d5-f59c-43ce-a44a-3eabc4b2d06c@roeck-us.net>
In-Reply-To: <a5bc25d5-f59c-43ce-a44a-3eabc4b2d06c@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWkcxaGRIbGhjMXhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MVEJtT1dVNVltSXpMVGxrT0RVdE1URmxaUzFpTnpVMkxURTRNV1Js?=
 =?utf-8?B?WVdGbU1UTTBNVnhoYldVdGRHVnpkRnd3WmpsbE9XSmlOUzA1WkRnMUxURXha?=
 =?utf-8?B?V1V0WWpjMU5pMHhPREZrWldGaFpqRXpOREZpYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?azFNVGdpSUhROUlqRXpNelEzTXpZME1UTXlORFF4TmpBM01DSWdhRDBpZEhk?=
 =?utf-8?B?TmJ5OUxXR2hxYlc1SlMwNVZOM2w0TjFKdEx6aDBVRVJOUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlJXOURRVUZDUjBSQldGTnJWRWhoUVdKMFdYSjRTV2RxT0hBM2RU?=
 =?utf-8?B?RnBka1ZwUTFCNWJuTkVRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUkdGQlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGc1IxUkhWbWRCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
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
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6764:EE_|PH0PR03MB7160:EE_
x-ms-office365-filtering-correlation-id: cfdc328f-cc2a-44c4-1e22-08dbffa8f752
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Y9FWSdUcbGMmuZgfEVZpOamOndPcjtNsZ2dEoceiG3mIKhTg3fUgb6iBFREg7Z8F6DynTuiUuI3ziLQyvKu4v7IZk5a+UG1pmOrR1Ywvsc0BbCL6WQebsWSauFaYd8TOh5jVQryOsVQeFXfxZ1InsrO2bMYtsuK+dniwsomGvTRnAmifXzFgZ5O2f82Ah3bTvr3MHoj4C+L7XepvuS+5nMc73buceAsVPnY5eUpP3dYRVHpgS0u9Yp3+XzW6j4TDBZrGmcRGaRYYV+KlBtwrXP420uzKUzBojDCWgplX837IkMwid37vKPxSv+uWuUSaJ3M3o9avKeo4ggri5QGuor9C+iEBvQ5YCu4OYtfVdcqt57d8YwJeYQo1qWKoJp4To2TKeOLWpb54caF8x2OXmDsKH7VTGsI9+x1GUJvtslfl7QZXqY9cR2lYg2kNzwaEbnlIV6O0JXXtuVYKv+CVdGOaHgxnOw/3oN8fu56nuFetWUHbaU9Va1mv5N68be/kEuEMr3mNN5q5CBkHLcZIcUZL7ghkOz0lvJWGAIewlanrQ7p+IqkdzIGUwrPxK7RO7hxEnZLszHCsbBjRUyhgKemHrhPKcaO/klqaD3UHVJVMZBm9d6BI/W/SkgJBkRyIAlagMpC1ReoUApfg6x4elg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6764.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(396003)(346002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(7416002)(5660300002)(38070700009)(41300700001)(33656002)(86362001)(122000001)(38100700002)(26005)(966005)(55016003)(83380400001)(66556008)(66946007)(76116006)(110136005)(478600001)(54906003)(316002)(66446008)(64756008)(66476007)(53546011)(7696005)(6506007)(9686003)(71200400001)(4326008)(8676002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dy8ycnJBcitqVFk2WkpISEZzR1F0Wm1LeklXYmM1eWlmZlkxY2lhMkppUkxn?=
 =?utf-8?B?ZFA3VUk4SmZ4OFIwb1BjNndscVNWVWRpMUQ3dWxVbXlVRjZyZkJQSEdlNXh5?=
 =?utf-8?B?RWNNSSt4MytLZXc3b2VHR3JCWmRRRXN4MnZNVlhsaGU2Mit1cHhRbjN6UlYx?=
 =?utf-8?B?L2VQU01KY2RoUHhpeUxqa0pyYmhpSHVkejVyZlA4cjA4eUZqMjVtQVpLZytN?=
 =?utf-8?B?aElGOU5zVW1xSlZEQkNxMC9JM1AvL3Y4YWRWaE5UdFJ4aWRwM1ZQMDdFRDcv?=
 =?utf-8?B?RHNxaDIzOTUrQmNmOTFLY291UGVzTDExKzRUenkvelcxVVNyMWFBVWk4SW9S?=
 =?utf-8?B?VWVkY2xYSDBBcFg5WXBSKzZMTXc4a0pJeDNHRjZac2hVb2lRTTVtOW1CR25C?=
 =?utf-8?B?L3VZWnZYRFRWb1NGbC9hemo5SmQ5SExjWWxtSGY2V2pYclphTlp0eURSWXFC?=
 =?utf-8?B?QVJBTzR6NlYydW1uMlNMbE15d3dwUjlYN1RXSFZINlFhTXFjNCtkd3k1MXVj?=
 =?utf-8?B?RStOQlE4M3h4bGI3MXltdmxWWXUyMnpCekN2ajhMYXBidXExL2cwdnhDa29r?=
 =?utf-8?B?SEdQb2ljemFzVnVqSkJsVUpyUFlPRUpGbTFLaXlWYnp1M0gwUE1FaG12MHo5?=
 =?utf-8?B?cFFyV3oySzBBVzdGbk9kaFVqYzBqb29mR3hIUG9vVXJIZ25JUzdrbGNENDd1?=
 =?utf-8?B?MXBNaC8yQko0VkpNYUx4V2ZIZ2ZFM2s0YU1mQ0NyM3d5VWlWekpzb0NpZGY5?=
 =?utf-8?B?aFk0UUVONUkzSXEzRGE3QnljV2h2aUZRRFdOa2hWOUlzQThnU1VLY3NVZWp0?=
 =?utf-8?B?dXJldUxFQXlNOWxDTjNEQkRzYmFGUXIwcEJycEhpSnl3OTRrQ05WTWpRMHRW?=
 =?utf-8?B?UFJtRm5oMlRYYy9SWklzSTdBMURRMWNyT1RWdWVyU3YxNFVrK2lpWFFOd0lm?=
 =?utf-8?B?K0xLRU53UkNDWTRQMTNCeDdtU21abHA2cEhVeFRvK2hBcTFINi92ZnBUWVpJ?=
 =?utf-8?B?VUZuaG1ic2oxOVloSkhGbk9aVGEvbTRFQ3VvQnYwN3JxakZSMEFReDd0ZDho?=
 =?utf-8?B?cXpmMkhCM2s4S0kyUUZOOHlvNC9zbU94dG9HTnBKZVd0STdaTmNwUGg3aXAy?=
 =?utf-8?B?U1drYkIwVEtDSWhUeVFYL3Z4T1pKUFZMQmpzWUZBaW1vcUNINGsvU0U4clZp?=
 =?utf-8?B?Rkp4djlsZDdmUE5RZCs2RkdlYzI5WTBsc1U1RUtUWGI3M0dUbXdqMWs2QUZR?=
 =?utf-8?B?RHpxR0l3ZUl1TGcrUXBrNThUdG5Ob2hmWlNaMGNrL01vWmNUclhWUU1FZVp5?=
 =?utf-8?B?L0VqRW5FcmFVZmtEdG8vUVVnN0FlbW5MS09xa2R5L05Sd2Q5bVNsUzdYSkFO?=
 =?utf-8?B?UWZJK1hBRFlPU1ljc3F3S0hha0tRNnFiZkFZd1FRYThlYVJnT1BLNDVBaERS?=
 =?utf-8?B?YlRmWTJRaDlLVWxrS0liclBqSmF3UHpDSHc5MmdyMTZ5UVVxMGluYmFoYTJo?=
 =?utf-8?B?MUdBeFlyRGpiMHZ4N2s3aGNmd25ZdHRxWEtQOFpXTDdwNHlSOFl0WlJTR2c2?=
 =?utf-8?B?UzlDYkZaY2VKSWhiTEI2enV6VWRVaS9hN3pVZVl6ODZkc3BuK1BWb1dnZFlX?=
 =?utf-8?B?VWUxUDBlOFdXNXlDT1ladWFqbkJoeng2NzJiU2x6UjNsQm9nTWVnTWlnY084?=
 =?utf-8?B?b0d2YlBkTVRacUp2TWFtc2pVb25qNnZLQ1VkWVo0Q1plYmNGemZsOWNEeEpY?=
 =?utf-8?B?UVNTNXkvT3pVVUZWZGNPdzdDRDlsVjIvb0hiU0wrTUpPWW85MWVRbU5xOFpr?=
 =?utf-8?B?VDAxRjUwcVZPZGVHc3pvaUlKVlo5bVJXanZLVTdjYXZ3KzZQSTcrVEtuS2N1?=
 =?utf-8?B?OTRhdy9vZlVRcTZFYzJWR2dSL2cwazc5ZmNuODZ3Z0ltUFVYblRVVHhVb2My?=
 =?utf-8?B?aFVpNUVVZGdTVjFHcFRDcUk1ZTcrQzhneVNOSWxURzRtTldkTlV1aXFQVkVN?=
 =?utf-8?B?VHZzT0RmTHNmOTdieVBUU05Bd0pleWtveVpMYTlBYTBoZjhiMTNGSFU5TThW?=
 =?utf-8?B?Z3QwWG9VTVBncGx6SGwrcjhlTHNkU0FWdE9hYTdNSW5zZlYvenl3TEJPSVh3?=
 =?utf-8?Q?W1peSTpolfbTxTP2qEQVOiCAe?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6764.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdc328f-cc2a-44c4-1e22-08dbffa8f752
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 09:08:57.1361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Il1DAdYdUoCljPMRlPYjIJiHBOthK1ynVM23bm4KXbYaTGqwHW1YEyjwf0lLjH6d9F0BCjW0EwhhMRfCuncTQuAPPXmEvvw52yTnOVOswl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7160
X-Proofpoint-ORIG-GUID: JdsXxfEYeljBkIZKEzqfEe0stZc1PIsz
X-Proofpoint-GUID: JdsXxfEYeljBkIZKEzqfEe0stZc1PIsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180065

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayA8
Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6IEZy
aWRheSwgRGVjZW1iZXIgMTUsIDIwMjMgNjowMyBQTQ0KPiBUbzogS3J6eXN6dG9mIEtvemxvd3Nr
aSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPjsgTWF0eWFzLCBEYW5pZWwNCj4gPERh
bmllbC5NYXR5YXNAYW5hbG9nLmNvbT4NCj4gQ2M6IEplYW4gRGVsdmFyZSA8amRlbHZhcmVAc3Vz
ZS5jb20+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtv
emxvd3NraQ0KPiA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9v
bGV5DQo+IDxjb25vcitkdEBrZXJuZWwub3JnPjsgSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHdu
Lm5ldD47IGxpbnV4LQ0KPiBod21vbkB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtZG9jQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gYmluZGluZ3M6IGh3bW9u
OiBBZGQgYWRpLGFkYXE0MjI0X3RlbXAgYXMNCj4gY29tcGF0aWJsZSBzdHJpbmcNCj4gDQo+IFtF
eHRlcm5hbF0NCj4gDQo+IE9uIDEyLzE1LzIzIDAwOjQ5LCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiA+IE9uIDE0LzEyLzIwMjMgMTU6MzYsIERhbmllbCBNYXR5YXMgd3JvdGU6DQo+ID4+
IEluIHRoZSBkZXZpY2UgYWRhNDIyNCB0aGUgbWF4MzE4MjcgdGVtcGVyYXR1cmUgc2Vuc29yIHdp
bGwgYmUgdXNlZCwNCj4gPj4gc28gdGhlIGRlZmF1bHQgdmFsdWVzIGNvcnJlc3BvbmRpbmcgdG8g
YWRhcTQyMjRfdGVtcCBhcmUgdGhlIHNhbWUNCj4gZm9yDQo+ID4+IG1heDMxODI3Lg0KPiA+Pg0K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgTWF0eWFzIDxkYW5pZWwubWF0eWFzQGFuYWxvZy5j
b20+DQo+ID4NCj4gPiBQbGVhc2UgdXNlIHN1YmplY3QgcHJlZml4ZXMgbWF0Y2hpbmcgdGhlIHN1
YnN5c3RlbS4gWW91IGNhbiBnZXQgdGhlbQ0KPiA+IGZvciBleGFtcGxlIHdpdGggYGdpdCBsb2cg
LS1vbmVsaW5lIC0tIERJUkVDVE9SWV9PUl9GSUxFYCBvbiB0aGUNCj4gPiBkaXJlY3RvcnkgeW91
ciBwYXRjaCBpcyB0b3VjaGluZy4NCj4gPg0KPiA+PiAtLS0NCj4gPj4gICBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWRpLG1heDMxODI3LnlhbWwgfCA1DQo+ICsrKyst
DQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+Pg0KPiA+PiBkaWZmIC0tZ2l0DQo+ID4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2h3bW9uL2FkaSxtYXgzMTgyNy55YW1sDQo+ID4+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FkaSxtYXgzMTgyNy55YW1sDQo+ID4+IGluZGV4IGY2MGUw
NmFiN2QwYS4uOWYzYjA4MzlhYTQ2IDEwMDY0NA0KPiA+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWRpLG1heDMxODI3LnlhbWwNCj4gPj4gKysrDQo+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FkaSxtYXgzMTgyNy55YW1s
DQo+ID4+IEBAIC0yMCw2ICsyMCw3IEBAIHByb3BlcnRpZXM6DQo+ID4+ICAgICAgICAgLSBjb25z
dDogYWRpLG1heDMxODI3DQo+ID4+ICAgICAgICAgLSBpdGVtczoNCj4gPj4gICAgICAgICAgICAg
LSBlbnVtOg0KPiA+PiArICAgICAgICAgICAgICAtIGFkaSxhZGFxNDIyNF90ZW1wDQo+ID4NCj4g
PiBVbmRlcnNjb3JlcyBhcmUgbm90IGFsbG93ZWQNCj4gPg0KPiANCj4gVGhhdCBpc24ndCB0aGUg
bWFpbiBwcm9ibGVtIHdpdGggdGhpcyBwYXRjaC4NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHBzOi8vZ2l0aHViLmNvbS9hbmFsb2dkZXZpY2VzaW5jL2xpbnV4Lw0KPiB0cmVlL2Rl
dl9hZGFxNDIyNF9kdHNfXzshIUEzTmk4Q1MweTJZIV8yRDF3MURENXNqSnJOeUFyWllaM1FXOQ0K
PiBuUzhVUm1QNlgwbjZSN3Exc0JuREIxSFBMNmpST2hEX3c5dTNmSml4dDJoREROdE82VnBnTE0x
SmthDQo+IFEkDQo+IHN1Z2dlc3RzIHRoYXQgaXQgbWF5IGJlIGEgZGV2ZWxvcG1lbnQgc3lzdGVt
IHdoaWNoIHV0aWxpemVzIHRoZQ0KPiBtYXgzMTgyNy4NCj4gIEZyb20gdGhlcmUsIHdlIGNhbiBz
ZWUgdGhhdCB0aGVyZSBpcyBhIGRldmljZXRyZWUgZGVzY3JpcHRpb24gb2YgYSBib2FyZA0KPiB3
aXRoIHRoYXQgbmFtZSB3aGljaCB1c2VzDQo+IA0KPiAgICAgICAgICAgICAgICAgIHRlbXBlcmF0
dXJlMTogdGVtcGVyYXR1cmVANWYgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0
aWJsZSA9ICJhZGksYWRhcTQyMjRfdGVtcCI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBy
ZWcgPSA8MHg1Zj47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICB2cmVmLXN1cHBseSA9IDwm
dmlvPjsNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBhZGksY29tcC1pbnQ7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICBhZGksYWxhcm0tcG9sID0gPDA+Ow0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgYWRpLGZhdWx0LXEgPSA8MT47DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICBhZGksdGltZW91dC1lbmFibGU7DQo+ICAgICAgICAgICAgICAgICAgfTsNCj4gDQo+IFRo
YXQgZG9lc24ndCBtYWtlIHNlbnNlIHRvIG1lLiBJIGRvbid0IGtub3cgd2h5IHRoZXkgZG9uJ3Qg
anVzdA0KPiByZWZlcmVuY2UgbWF4MzE4MjcuDQo+IEkgYW0gbW9zdCBkZWZpbml0ZWx5IG5vdCBn
b2luZyB0byBhY2NlcHQgYSBkcml2ZXIgY2hhbmdlIGp1c3QgdG8gbWFwDQo+IGFkaSxhZGFxNDIy
NF90ZW1wIChvciBhZGksYWRhcTQyMjQtdGVtcCkgdG8gdGhlIGFjdHVhbGx5IHVzZWQNCj4gdGVt
cGVyYXR1cmUgc2Vuc29yIGNoaXAuIElmIHdlIHN0YXJ0IGFjY2VwdGluZyB0aGF0LCB3ZSdkIGVu
ZCB1cCB3aXRoIG5vDQo+IGVuZCBvZiAiPHZlbmRvcj4sPGJvYXJkX25hbWU+LXt0ZW1wLHZvbHRh
Z2UsY3VycmVudCxwb3dlciwuLi59Ig0KPiBjb21wYXRpYmxlcy4NCj4gDQo+IExvb2tpbmcgbW9y
ZSBpbnRvIHRoZSBhYm92ZSBtZW50aW9uZWQgcmVwb3NpdG9yeS9icmFuY2gsIGFuIGVhcmxpZXIN
Cj4gdmVyc2lvbiBvZiB0aGUgZHRzIGZpbGUgZGlkIHJlZmVyZW5jZSBhZGksbWF4MzE4MjcgZm9y
IHRoYXQgY2hpcC4gSXQgYWxzbw0KPiBsb29rcyBsaWtlIHRoZXJlIG1heSBiZSBhbiBhZGFxNDIy
NCBBREMgKHBlciBkcml2ZXJzL2lpby9hZGMvYWQ0NjMwLmMpLA0KPiBidXQgdGhhdCB3b3VsZCBi
ZSBhIFNQSSBjaGlwLiBJdCBzZWVtcyBoaWdobHkgdW5saWtlbHkgdGhhdCBhIFNQSSBBREMgd291
bGQNCj4gaGF2ZSBhIHNlcGFyYXRlIEkyQyBpbnRlcmZhY2UgY29ubmVjdGVkIHRvIGEgdGVtcGVy
YXR1cmUgc2Vuc29yLg0KPiBDb25mdXNpbmcuDQo+IA0KPiBUaGVyZSBpcyBhbHNvIHNvbWUgaW5k
aWNhdGlvbiB0aGF0IHRoaXMgbWF5IHNvbWUgSVAgdG8gYmUgbG9hZGVkIGludG8gYW4NCj4gRlBH
QS4NCj4gd2hpY2ggdXRpbGl6ZXMgYW4gRlBHQSBpbXBsZW1lbnRhdGlvbiBvZiBtYXgzMTgyNyAo
b3IgbWF5YmUgY29ubmVjdHMNCj4gdG8gb25lKS4NCj4gSWYgdGhhdCBpcyB0aGUgY2FzZSwgaXQg
c2hvdWxkIHN0aWxsIGJlIHJlZmVyZW5jZWQgYXMgbWF4MzE4MjcuDQo+IA0KPiBBbGwgdGhhdCB3
YXN0ZWQgdGltZSBiZWNhdXNlIG9mICJsZXQncyBwcm92aWRlIGFzIGxpdHRsZSBhcyBwb3NzaWJs
ZQ0KPiBpbmZvcm1hdGlvbiBhYm91dCB3aGF0IHdlIGFyZSBhY3R1YWxseSBkb2luZyIgOi0oLg0K
PiANCj4gR3VlbnRlcg0KDQpJIGFza2VkIGFyb3VuZCB0byBnZXQgc29tZSBtb3JlIGNsYXJpZmlj
YXRpb24gb24gdGhlIG1hdHRlci4gVGhlcmUgd2lsbCBiZSBhIG5ldyBjaGlwIHJlbGVhc2VkLCBu
YW1lZCBhZGFxNDIyNC4gVGhpcyBjaGlwIHdpbGwgaGF2ZSB0aGUgbWF4MzE4MjcgaW1wbGVtZW50
ZWQgaW4gdGhlIHNpbGljb24sIHNvIHRoZSBkcml2ZXIgdXNlZCB0byBnZXQgdGVtcGVyYXR1cmUg
aW5mb3JtYXRpb24gd291bGQgYmUgbWF4MzE4MjcuYy4gVGhlIGNoaXAgd2lsbCBoYXZlIHNwaSBh
bmQgaTJjIGNvbW11bmljYXRpb24gdG9vLiBUaGUgb3RoZXIgZHJpdmVyIHlvdSBtZW50aW9uZWQs
IHRoZSBhZDQ2MzAuYyB3aWxsIGNvbW11bmljYXRlIHRocm91Z2ggc3BpLg0KDQpCZWNhdXNlIHRo
ZSBjaGlwIGhhcyBhIGRpZmZlcmVudCBuYW1lLCBJIHdhcyBhc2tlZCB0byBhZGQgYSBuZXcgbGFi
ZWwgZm9yIHRoZSBtYXgzMTgyNywgc28gdGhhdCBpdCB3aWxsIGJlIGNsZWFyIGZvciB0aGUgdXNl
ciwgdGhhdCB0aGUgbWF4MzE4MjcgaXMgcGFydCBvZiB0aGUgY2hpcC4NCg0KSW4gYWQ0NjMwLmMg
dGhlIGluZGlvX2Rldi0+bmFtZSBpcyBjaGFuZ2VkLiBXb3VsZCBpdCBiZSBvaywgaWYgSSBkaWQg
c29tZXRoaW5nIHNpbWlsYXI/IElzIHRoZXJlIHNvbWV0aGluZyBzaW1pbGFyIGluIGh3bW9uPyBN
YXliZSBkZXYtPmluaXRfbmFtZT8NCg0KRGFuaWVsDQoNCg==

