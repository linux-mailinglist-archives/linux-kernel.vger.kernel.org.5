Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE107F59EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344912AbjKWIYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKWIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:24:37 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6AEB0;
        Thu, 23 Nov 2023 00:24:41 -0800 (PST)
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AN21dDD023756;
        Thu, 23 Nov 2023 03:24:25 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3uhwkfh1mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 03:24:25 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTt5Ecqqf8XflnsckHimWl5um5/pTWy2Azw/SGXLX0YCWwQOjMrMfYW7q5OJrZ51t4bXw+Gx9eF1F6RlWcRcT2AMCNIIjnOhJsbwiSOXTb98pbhkAb/jL1ay1iLC3z4dZurDOLzg3zLibu/We/Bg/vCKjR7c1cwSKlZLmyrGp//uIirBphhlMpn6KCCzQTk1EHKoLxpfE+J8EFOisqO3awnil44k9kHwJfUP6gcpLhQSH1SXifdDAZ5fkBOSyYNCskhJtvackFTiZWpsEes1DNN0ATnmB+U2rNmSH/qeWF27c7B9U38f6Rd9vX8n5oOGw/xNT/oRKO0TJMQ2TYoN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhDE4s7iAozXf8p6PS6zrKufj0xiByLP6jIapT1Bia4=;
 b=kyNg59Fxu6l7RSLODxrxgH6pC28Gg2J9irmglXPIQPDWoPkcfu1ZUc+hCJiIj1X42QPhXp5h/GhL175AVj6eoNqLIv/yr6HHv6Jd0y/hhw2+2i+c5a+WzZwdWWV3s2/7Xeco2ttvMj0zWUlBeamVj90qlJouVPWnfOIdDOo+28LAIVU/dp3kDNMBJKH3uyWxpW+bmSFGZtj1XfKTiFVX4OcVGeBodBGimxi2EZfMYICqLqeXYIKEgDX5CBbeK8rEANHdgXyL/YyWAivq4t3rPPe87I73Q3SSUL0drjpttCDzDNUzZGowd3zqeSOGOCJK9r3aLPEzbWCC6w3vXuFcCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhDE4s7iAozXf8p6PS6zrKufj0xiByLP6jIapT1Bia4=;
 b=rjxcYapjZwueS24MAfNQv/wR5uWsvZrnq/Y8OaPM6CxHzjFg5zNGs7ObGw9c/EbK0ByMzw8tUvqP5NRZQYDXXlQZujl1B9XFkdIYELk6EGYbbPsbqztDuvQCBRBHaDc/psoi28URQyzmMZmV16J6UjgDaU/dt1kljcVzQxYsLvM=
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by MN2PR03MB5103.namprd03.prod.outlook.com (2603:10b6:208:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 08:24:15 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::f174:c671:b889:ef4d]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::f174:c671:b889:ef4d%4]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 08:24:14 +0000
From:   "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: iio: frequency: add admfm2000
Thread-Topic: [PATCH v3 1/2] dt-bindings: iio: frequency: add admfm2000
Thread-Index: AQHaHTLkJQIaFrxP9UKeDbTwdHULIrCGpx0AgADAP/CAABlMgIAACnmw
Date:   Thu, 23 Nov 2023 08:24:14 +0000
Message-ID: <PH0PR03MB7141957ABE612DB1275B1309F9B9A@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20231122105831.182570-1-kimseer.paller@analog.com>
 <f66a3dc3-a0a5-457b-a68a-efd6577aa210@linaro.org>
 <PH0PR03MB7141C58C008920173B3AE998F9B9A@PH0PR03MB7141.namprd03.prod.outlook.com>
 <676c55c7-1477-4c59-a1fe-2b50e37018a0@linaro.org>
In-Reply-To: <676c55c7-1477-4c59-a1fe-2b50e37018a0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFoWkRnNFpEbGtZeTA0T1dRNUxURXhaV1V0WVdWaU1pMHhORGMx?=
 =?utf-8?B?TldJek5XUmtZemhjWVcxbExYUmxjM1JjWVdRNE9HUTVaR1F0T0Rsa09TMHhN?=
 =?utf-8?B?V1ZsTFdGbFlqSXRNVFEzTlRWaU16VmtaR000WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STBPRGd3SWlCMFBTSXhNek0wTlRJd01UUTFNVGt6TmpRNU5USWlJR2c5SWtS?=
 =?utf-8?B?RGJUYzRiVlF5ZFRaWVlUVmxVbTF0UkhKclpFdE5lVUpaWXowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUWxseVpuaDJOV2d6WVVGa2QzbERMM1pDYVhCWWRU?=
 =?utf-8?B?TkVTVXdyT0VkTGJHVTBSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|MN2PR03MB5103:EE_
x-ms-office365-filtering-correlation-id: 9eed7161-c959-4b1d-6fb6-08dbebfd93ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vHFBpQd6rHCQSO59tCRe73iacDgx4WC7uuNnbfrDsSbvqx8vLm5RfcjKU64O20K2amK5xXnD8vAhxBm4WTYyNWukbH8zJy/7YD/NY9iRyuz6DhH74O8namC3Dt4qaxdft7LjMPNjX8/z/5Ir7GCuQMUe/+r4xMazuob7sidDfZ6SaiUb5pv9p+29BNYngzyMSYJhuL1Zlf1J8CqrtNTP00BPDLjlODKkmukfCgJasIKeP5CMGWI04LGFa4RUXsd/renrq+LwuciVjCbxrIKjOq8cqORt5VXf+F9fUXsJCNTbBXepaNTHbH0Iyv//i8II7ol+bbhO+tA0sFEcRFAjL1ptjT489wiW4MpOr/OMSMf8Kwh52kylKwbFmCTb4K9orXu4A9ssR+43rORzSmpJ5hDtQC+l7bzYNw2a+bXiPd5QEG7AxIDOMuwm54t80dTwz9qmdYX5OgjbNjqYLhcXEjEhXfyLKv2UuFxbjYeNWEoQnSEliGdupxlaCPYBBZTA6gLjJTyLp5QUR0DKiR5RkKG4ycnijlwiWTldW0pSh13pORNJXTmqolC6KawARMsNvpXzNQ89WcI495au9CzQCj6irqSaU+xnXZq2i9pz+ph8gPPInqWx/dHr6ss1C0DolL/9pm5o7PT8SJwzHzMwbTYx+97mAa+KyTVH4CSrcQA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(66556008)(76116006)(66476007)(64756008)(6916009)(316002)(2906002)(66446008)(54906003)(66946007)(26005)(38100700002)(52536014)(4326008)(8676002)(8936002)(38070700009)(41300700001)(122000001)(86362001)(7416002)(33656002)(5660300002)(83380400001)(55016003)(9686003)(478600001)(6506007)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGdETXRLdmtUTkc5RGtJR3Q1aVhYNFd1NmpYR09qNmpzc01La09wWmJvWURm?=
 =?utf-8?B?cVZpdklDYlA5WWVPc0x4dmsxVVg5aEVDeWhadjY0K0lRdy9YTEVXN2tNdnRS?=
 =?utf-8?B?ODRoVkd5QmhwbGg5eXg2VVhBQVh0MkpScDJFek1EY3FrSGlJNkhtYStDb2Vh?=
 =?utf-8?B?UUhDWVdheEVjZncxTndYTGwxMzZqZVNHb0NyQXVVRWZybnJseDFOclEvVlZ2?=
 =?utf-8?B?ZEFEZjE5eDNnRm5qN0FhRFBsbVRiZGE5REdaVytOWDl6V1FwRDZyR1g1Kzht?=
 =?utf-8?B?UDFYaUp2U3FiVDJTTURKamZ2NTJpL29HeHlNeU5HZmt4OGhpS0xXMTlnK2ZX?=
 =?utf-8?B?cG1zREJPallTSXRBZHAySURmRWpweHljNUh6SkNGY0RrRHRkekpIZDFoT05x?=
 =?utf-8?B?bVZVd0lncTdSS0owdkJMNmlEMHRDSGhSQnIzemllam9kdyt1Z0JiMUJXUWVj?=
 =?utf-8?B?UU8yU3o1REsrU0J1Mlg3VUovWFRiSytvQkFHK284R0NHOUw5NXJkSURSUHpx?=
 =?utf-8?B?T3BCZjJHazA1WnNJL3JKVWU3d2o0VnpGU3ZWZW1OR3dsWEdsTGVOME9nSXdx?=
 =?utf-8?B?eFRQTW12S2JPYld3TlRaZDAvVnh2dUNXWUM2ZDZia2tqbitRUHRiT2k4M01K?=
 =?utf-8?B?VHNxeE95ODY5R1gxQTNqSWs4cDdGNE0ySGcwNnJPK3BDY01qNjVnbVpXUzIw?=
 =?utf-8?B?ZjY5a1orejVZanBJT0ZVdmh3cjkwcE5sNVYrUUM0RXJHYW1Vcnl6RnNEcVh5?=
 =?utf-8?B?N3ZkT2laYmNoSVNCaFR0M1hjOTQ5bmVwUlc5NHR5UE92UWVBYkdtYWROZ3BW?=
 =?utf-8?B?dWFtM0hZQytqSTYrcDREaTM5RWdOZVNrRXU1bU14N0lJMDFJQm5VZ2dmVGR2?=
 =?utf-8?B?L1JwUjVYMG9vRmUyYWYrYzFBYVBOSmFJQUxBUEJlQ2FsQ01ESVlNWXpOd01o?=
 =?utf-8?B?bmdIU3RUQUhNbm1TUEp3c2tIbTZZTkJNUjFlTGZiMW1RSndOTlNOSnhpNity?=
 =?utf-8?B?MFdHSGNKVGpneGZEcy9Bemp3WE9nc1k1eExSMWhwQUtmL2pEaGg4eWNWT3VP?=
 =?utf-8?B?UE91akYvSG12MWJSYllONFVCdkpPdDZWQ2Q4ektCZWQvVmtPZlkwaWpHVVV6?=
 =?utf-8?B?Q2Rwekk2MzYwYnR2cDg3UVdwZ09ib3FYMlVKRmE1Q05uVm1MRGxXaEdHeHcw?=
 =?utf-8?B?MXVDUkk1UWt2N3VpK085R1FzeXdXTFQ2SmgzRFBwMjYvR2xOWXltd1Y1eVZr?=
 =?utf-8?B?QlpjbTNzMkQrTDdlRHk4UVB4RFVaa2tPMDduYlN4VVBLeXdqQnNBU1Rhaitu?=
 =?utf-8?B?ajgyNFpqMWw3YjJhZ0VxbzVwL3BQaGR6MmVVQ2VNM3ZNU3A0S1pSdXluM3U2?=
 =?utf-8?B?TVlLNldRSFRSWlJjNjEwNHBVRnEvTUtXNzNQSW53UmFoTmVkMGxHemc4MXZv?=
 =?utf-8?B?RnFHVGd0QzkwdUdiRXFUcy9wdTR4TzRWaWg2ZDh5cVR0R0pZaUFNTGMxUXow?=
 =?utf-8?B?aFY5OGdUZFJ2Rm12ZzRPOWZKQzFxNWhTejJ6NXFacm1lWE9yaFdhRm92OGI5?=
 =?utf-8?B?RHZONURsNEx6SDhYRlM2cld4TEh2ZjRYYjFPWUlHb2NybklYZENFNXVXeUJp?=
 =?utf-8?B?TGdIME5yanBaR0lKM0M2dGVVOXpZMjdiSUY4eDBzck11NnFtNFdIaDdXNnA1?=
 =?utf-8?B?TSt6YkY4eHJ0SjhUUkhZNU9ZREkvbmZ4SnR1UHluMGhjOEVxdnBvQ2VnazBE?=
 =?utf-8?B?QUp5MWJoSFordmx4RFVCU0FHazZrTnY3MnRQbFBqQWtLaHZ4cXNaN0dsZlNY?=
 =?utf-8?B?VTU0dkcwSWJpUFBidnl4NE8ybmtodmk4UGdOWG9hM25QODZITFRlUmVqbEZE?=
 =?utf-8?B?VnhiUGRna29mbzB4c1VwSlFRUGdnT21xV0lhWXIzZmwvVi9aWUV0d0w2ejlW?=
 =?utf-8?B?eEJxU29XNW9iU2FYanMzVGhFM3JONjNzTHBZcEdNWFkxc3IwOGswRkp3djFQ?=
 =?utf-8?B?TWEveFNqUVJySUZ1UWZFTHF0RTBTZ1ZOUWdOc3BKcnlRWUxMZkFnS1h6MWY5?=
 =?utf-8?B?eVV1dDQrTW10UmREVkRlOWlXNTM4US9rRjc4aTdSS3dIZU9vZ1F5aTVuMU9v?=
 =?utf-8?Q?bFo4EVN/nqVBLkFOD57fIMvqc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eed7161-c959-4b1d-6fb6-08dbebfd93ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 08:24:14.1327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrJWR1OmVKUoY3++JLNrv/7Fl6DhfSAWS8+PbP793IStD85saRjJBVETpC/sBuzBYfgS5R9gZ3XeRK8XLZabcoK7k859k0aB6Nc37mig80U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5103
X-Proofpoint-GUID: dXyyNS0cxzWWH2RamFyZx2KLOlS8WA7h
X-Proofpoint-ORIG-GUID: dXyyNS0cxzWWH2RamFyZx2KLOlS8WA7h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_06,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311230059
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4gLS0tDQo+ID4+PiBWMiAtPiBWMzogQWRqdXN0ZWQgaW5kZW50YXRpb24gdG8gcmVzb2x2
ZSB3cm9uZyBpbmRlbnRhdGlvbiB3YXJuaW5nLg0KPiA+Pj4gICAgICAgICAgIENoYW5nZWQgbm9k
ZSBuYW1lIHRvIGNvbnZlcnRlci4gVXBkYXRlZCB0aGUgZGVzY3JpcHRpb25zIHRvIGNsYXJpZnkN
Cj4gPj4+ICAgICAgICAgICB0aGUgcHJvcGVydGllcy4NCj4gPj4NCj4gPj4NCj4gPj4+ICt0aXRs
ZTogQURNRk0yMDAwIER1YWwgTWljcm93YXZlIERvd24gQ29udmVydGVyDQo+ID4+PiArDQo+ID4+
PiArbWFpbnRhaW5lcnM6DQo+ID4+PiArICAtIEtpbSBTZWVyIFBhbGxlciA8a2ltc2Vlci5wYWxs
ZXJAYW5hbG9nLmNvbT4NCj4gPj4+ICsNCj4gPj4+ICtkZXNjcmlwdGlvbjoNCj4gPj4+ICsgIER1
YWwgbWljcm93YXZlIGRvd24gY29udmVydGVyIG1vZHVsZSB3aXRoIGlucHV0IFJGIGFuZCBMTyBm
cmVxdWVuY3kNCj4gPj4gcmFuZ2VzDQo+ID4+PiArICBmcm9tIDAuNSB0byAzMiBHSHogYW5kIGFu
IG91dHB1dCBJRiBmcmVxdWVuY3kgcmFuZ2UgZnJvbSAwLjEgdG8gOCBHSHouDQo+ID4+PiArICBJ
dCBjb25zaXN0cyBvZiBhIExOQSwgbWl4ZXIsIElGIGZpbHRlciwgRFNBLCBhbmQgSUYgYW1wbGlm
aWVyIGZvciBlYWNoIGRvd24NCj4gPj4+ICsgIGNvbnZlcnNpb24gcGF0aC4NCj4gPj4+ICsNCj4g
Pj4+ICtwcm9wZXJ0aWVzOg0KPiA+Pj4gKyAgY29tcGF0aWJsZToNCj4gPj4+ICsgICAgZW51bToN
Cj4gPj4+ICsgICAgICAtIGFkaSxhZG1mbTIwMDANCj4gPj4+ICsNCj4gPj4+ICsgIHN3aXRjaDEt
Z3Bpb3M6DQo+ID4+PiArICAgIGl0ZW1zOg0KPiA+Pj4gKyAgICAgIC0gZGVzY3JpcHRpb246DQo+
ID4+PiArICAgICAgICAgIFNldHRpbmcgQjE1IEdQSU8gdG8gaGlnaCBhbmQgQjE2IEdQSU8gdG8g
bG93IHdpbGwgcmVzdWx0IGluIGNoYW5uZWwNCj4gMQ0KPiA+Pj4gKyAgICAgICAgICBiZWluZyBp
biBEaXJlY3QgSUYgbW9kZS4NCj4gPj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOg0KPiA+Pj4gKyAg
ICAgICAgICBTZXR0aW5nIEIxNSBHUElPIHRvIGxvdyBhbmQgQjE2IEdQSU8gdG8gaGlnaCB3aWxs
IHJlc3VsdCBpbiBjaGFubmVsDQo+IDENCj4gPj4+ICsgICAgICAgICAgYmVpbmcgaW4gTWl4ZXIg
bW9kZS4NCj4gPj4NCj4gPj4gVGhpcyBzdGlsbCBkb2VzIG5vdCB0ZWxsIHdoaWNoIG9uZSBpcyBC
MTUgYW5kIHdoaWNoIGlzIEIxNi4gSSBhbSBhc2tpbmcNCj4gPj4gdGhpcyBmb3IgdGhpcmQgdGlt
ZS4NCj4gPj4NCj4gPj4gaXRlbXM6DQo+ID4+ICAgLSBkZXNjcmlwdGlvbjogQjE1IEdQSU8sIHdo
ZW4gaGlnaCAoYW5kIEIxNiBsb3cpIGNoYW5uZWwgMSBpcyBpbg0KPiA+PiBEaXJlY3QgSUYgbW9k
ZQ0KPiA+DQo+ID4gSSB1bmRlcnN0YW5kIG5vdywgdGhhbmsgeW91LiBJIHdhcyBhbHNvIHdvbmRl
cmluZyBpZiB0aGlzIGFwcGxpZXMgdG8gdGhlDQo+ID4gYXR0ZW51YXRpb24tZ3Bpb3MsIG9yIGlm
IEkgc2hvdWxkIGtlZXAgaXQgYXMgaXM/DQo+IA0KPiBZZXMsIHNvbWV0aGluZyBsaWtlIHRoaXMg
YXBwbGllcyB0byBhbGwgeW91ciBwcm9wZXJ0aWVzIHdpdGggbXVsdGlwbGUNCj4gZW50cmllcy4g
WW91IG5lZWQgdG8gZGVmaW5lIHRoZSBvcmRlci4NCg0KQmVmb3JlIEkgc2VuZCBhIG5ldyBwYXRj
aC9jb21taXQsIGNvdWxkIHlvdSBwbGVhc2UgY2hlY2sgdGhpcyBvbmUgaWYgaXQgaXMgDQpwcm9w
ZXJseSBkZWZpbmVkPw0KDQogIGF0dGVudWF0aW9uMS1ncGlvczoNCiAgICBpdGVtczoNCiAgICAg
IC0gZGVzY3JpcHRpb246IEMxNCBHUElPLCB3aGVuIGxvdyAoYW5kIEMxNSwgQzE2LCBEMTQsIEQx
NSBoaWdoKQ0KICAgICAgICAgIGNoYW5uZWwgMSBhdHRlbnVhdGlvbiBpcyAxIGRCLg0KICAgICAg
LSBkZXNjcmlwdGlvbjogQzE1IEdQSU8sIHdoZW4gbG93IChhbmQgQzE0LCBDMTYsIEQxNCwgRDE1
IGhpZ2gpDQogICAgICAgICAgY2hhbm5lbCAxIGF0dGVudWF0aW9uIGlzIDIgZEIuDQogICAgICAt
IGRlc2NyaXB0aW9uOiBDMTYgR1BJTywgd2hlbiBsb3cgKGFuZCBDMTQsIEMxNSwgRDE0LCBEMTUg
aGlnaCkNCiAgICAgICAgICBjaGFubmVsIDEgYXR0ZW51YXRpb24gaXMgNCBkQi4NCiAgICAgIC0g
ZGVzY3JpcHRpb246IEQxNCBHUElPLCB3aGVuIGxvdyAoYW5kIEMxNCwgQzE1LCBDMTYsIEQxNSBo
aWdoKQ0KICAgICAgICAgIGNoYW5uZWwgMSBhdHRlbnVhdGlvbiBpcyA4IGRCLg0KICAgICAgLSBk
ZXNjcmlwdGlvbjogRDE1IEdQSU8sIHdoZW4gbG93IChhbmQgQzE0LCBDMTUsIEMxNiwgRDE0IGhp
Z2gpDQogICAgICAgICAgY2hhbm5lbCAxIGF0dGVudWF0aW9uIGlzIDE2IGRCLg0KDQpUaGFua3Ms
DQpLaW0NCg0K
