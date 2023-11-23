Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623E97F580C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbjKWGON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjKWGOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:14:11 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA621B2;
        Wed, 22 Nov 2023 22:14:17 -0800 (PST)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AN3QDFS014078;
        Thu, 23 Nov 2023 01:13:54 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ugda53d94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 01:13:54 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJemBooWP7RQSZaFm8Zss9aM//hjDn1MwaQozkk4Sm6ITWpPLg1wlKOlWdqELmyhcBxQ6UXteeKpChTVxk+Iy9mlKefV7n/LqyHwOacrVd1ktiuhiL5AoBjk46eJKadRhq1u7OcF+9ZzPBZbmNXYHMkjXIUKc2/cNu+W6bo270qqyVPU5mRQw4Nt2TUVzI+swkWxrmM+0lIQ4ycOoL9owNkJ/e/8IyfuEOP5IWMa35LaPmWQ9s1uP4qBOLN8H4gr9GJgth5TEctdN+CrjhPeOMjjC6T/TByk4KtqQ34ShmrujmAH2qESLW4tNtBzs73ozxh50DY31zAlPc6Xb2vF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClDtFb2IA65TA0W6AW1W8+K+GYOhmq5XNmRoXsw34yc=;
 b=Bfv/OAQKeMBR8nkEWmUr+htn3j51Fny3GTZiGghY4vVj/XMIam+UZVIL85Za0rb5aoGyu3ej9/xwXeyJFOp5OZ+O6lzacHnpXPXBvdyPCV56RKpd0KO2AtJV5X98oIpiFTUthjNpJIGe6dFCC2Oh7o952oZWIBBYfNJJr6futQpAGoMiWiZheiAsY8Xsc7Odjpq7n0Fv+5R8JB8xfHaBz4z31d1XIb3F/pHfI8WCGM3Wf1l6iLPTJukc+f3H+AeaqMVxdO6F/t+P1mpqaAvMpVgVRWo6j7y/xmhNkvr/RT0zCi/Cb97HBOyFKzCKgMKFDYVtAVVYqR38Z+t5JUsuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClDtFb2IA65TA0W6AW1W8+K+GYOhmq5XNmRoXsw34yc=;
 b=2EUixSzeUnFjzVPmYKZx5v7FbrTQ6hlRwXS6Eq4LZ84oEf8XhrppA9eqPtkCSNnB+P5a994ip6zlBmtEuqwzHUTHF7r32nSkS+BiQjBHoRwwrASfFGIjj2V+RVxaNWzSQOeIBUXtj5CoN3G2zjJ6B7vbh/s/H59yxgEz2qgNYxw=
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by CO1PR03MB5875.namprd03.prod.outlook.com (2603:10b6:303:90::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 06:13:52 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::f174:c671:b889:ef4d]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::f174:c671:b889:ef4d%4]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 06:13:52 +0000
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
Thread-Index: AQHaHTLkJQIaFrxP9UKeDbTwdHULIrCGpx0AgADAP/A=
Date:   Thu, 23 Nov 2023 06:13:52 +0000
Message-ID: <PH0PR03MB7141C58C008920173B3AE998F9B9A@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20231122105831.182570-1-kimseer.paller@analog.com>
 <f66a3dc3-a0a5-457b-a68a-efd6577aa210@linaro.org>
In-Reply-To: <f66a3dc3-a0a5-457b-a68a-efd6577aa210@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAzTnpJeE5HRTNNeTA0T1dNM0xURXhaV1V0WVdWaU1pMHhORGMx?=
 =?utf-8?B?TldJek5XUmtZemhjWVcxbExYUmxjM1JjTnpjeU1UUmhOelV0T0Rsak55MHhN?=
 =?utf-8?B?V1ZsTFdGbFlqSXRNVFEzTlRWaU16VmtaR000WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpNRFUySWlCMFBTSXhNek0wTlRFNU16WXlPVFUxTWpreE1UQWlJR2c5SW5a?=
 =?utf-8?B?VGNITnFWMHB2WTNZclVuTmhOR1JPZUZGSE9UWlRZa1pMUVQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTFkeGJuTTFNVUl6WVVGVlJtUlBXalp1UVc5elIx?=
 =?utf-8?B?RldNRFZ1Y1dORGFYZFpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|CO1PR03MB5875:EE_
x-ms-office365-filtering-correlation-id: 2b759820-722e-40f0-abe2-08dbebeb5d77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYOCz8lM8lhY+qTfycv0KHCOSLQgfRIGwevY+66OD1vG9w9j/eRq5sTFDdD4B4kJnmbnLLrt+VDvrvhw+NWC3OXlBRdUW7ALQGbVOYRL/30/U98kgzNg2AmWZTsJTaRcHoLej+L9vG18Xy+sMPlRkVorNMJ5LicWQxkoXU4yJ7H89Zcn5KjZ6GHRfwKuIt5L/W3t4AjRqT2bs7zwbZrgERKe3fTwicR26OscmZFcpVKqkGdvCryJ/vk9wR0/M/IHhOP5DcvBDDo+bug2s0Ftqw3t8XqnlAxkKL0HZ82dY5Sf7ffwkvcsqjpg6qrcXHTiHmoytRbwz60EzjO7xRfjnOKnJx/iv29OctJOGaXN2EmAiYWuJupgF7UP8JmCGwTyZEPvOXlW1njF+FLzuaYnYYJC4VnbsndhP5WRRDGOznPKo0whWdseBsp+ElFvwu7LBFqiqneVipxGl5Kj1z9D3ceYf8YOLAcZo5JOg/M40+vVXQ4OusFKGRD2rl3hGKQpIIE9yd6PwgwUdLobOiY7t/z3PAbmEqf3jll3wdydTsn6tfTgFulmOeF3e5NZaL2AnS5xACtHeaWyXj/oXGHXV8iS3hZ5YYyQieHRqvMERc6JW4leR1x2DccS+FIFoFFiGaODP/E0+d8nLhtCesQdXwwXNqRLREwE2heICEjGsNM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38070700009)(55016003)(76116006)(66946007)(66476007)(66446008)(64756008)(54906003)(122000001)(38100700002)(33656002)(86362001)(66556008)(316002)(6506007)(71200400001)(26005)(83380400001)(9686003)(7696005)(478600001)(7416002)(2906002)(6916009)(4326008)(5660300002)(8936002)(8676002)(52536014)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWZRd200aHZUVDlHYzQ2aGdlczVCK09tNmtlSW5RR0RNa2ZxRVpjcFFTSVR2?=
 =?utf-8?B?V21iYUd6WklqUy91c2hmNjVSbzhOYzB3c3l3SlI3NFZualg1NW1pczRsbVR1?=
 =?utf-8?B?WGtYcUFwV2xGNW15NnM1TmdHdktkdmZ3bTZybWxvWFZHNm9DREIycUYvUjhQ?=
 =?utf-8?B?Y0plNGUvL1ZkNlZDS0NKRFlWK2h0WnRkdGhiRFlWTEdpY3NjdHhERHpRbDJF?=
 =?utf-8?B?dU9sd3JFbmFJQngxWGVzVmN2cXA3N3V3K2JXUUFPMTkzeWpKZURvMnIvWk56?=
 =?utf-8?B?M1RCQ1VMT2luZFIyWC9WTGcrZkVYclhxMFlGWGMxQS9hYnVPa0RwZnVWUzho?=
 =?utf-8?B?YlZ3TEh4SGo4T09zOUlDdnp4cW42UEJ1bC9GajFtUFBrUHpxTzZ6WTY3enZy?=
 =?utf-8?B?aFlSeE00QnBiYVZrdkdEa1Z3amRmeUorVUdGaVhyRHlIZkwzS1RQTUo5YTJX?=
 =?utf-8?B?ZjRoZjNoY1dyWjFQTmF5ZlNvbitidE1TSjhHK0F1M1JMVlBDNy8zUW1vU0I1?=
 =?utf-8?B?UnFpZjhranNXZFQ5MUxHakxmUW8xSEcwL3JiQ1VsSjV4TThhRXZNT09IMk13?=
 =?utf-8?B?TldmWTJCYWdSdkVnZE50WkVWMWt6ZUtGQ01MemwzcERUbWltK0tqNDJlekwz?=
 =?utf-8?B?b1FEVTU0Nkk3ZS90WU9RejlsNzZRYVVFcHh0OTVkOXJyZ3hIZTI2RWZzQktV?=
 =?utf-8?B?bVdFYmdJOUlYY21Ud0tqUFVNcUhKOEEzL2pwSXVIanBQdGZZSjZNOFZ6MGgv?=
 =?utf-8?B?clZXSktBUHY5U0xxTkdBZ3RQKzY4UE9FTE5QQnlKeTBKMUtZQ0N4ZU5yK1d6?=
 =?utf-8?B?QXFFbllpZVZhSGNuSkV1NlUyVzNwTFhIMnFpQjJRVHE1OGdqZ1BrRVlpN3Jr?=
 =?utf-8?B?dHpzMldFVlhCajRqK0VrVnhlVlliT0VHQ1EwUENXdHBac01kRDE5S1lFbEpR?=
 =?utf-8?B?THZnc2FiZGVpdElYeldzVDN5elZmRFA2VS9YOGQrMFFNK3BIU3pCbDRxZXRM?=
 =?utf-8?B?czFIYzBDZWFHMmxxV0Q1S2lBOS96TkdhUG1LbUp1ME5EYXB2OUw3cmJrZWRV?=
 =?utf-8?B?T0tONFNrRVVsYm1mTGFKSXlvV0hFb3MwcUdHQk5lOUR6dUl1NmwzU1gvVTVE?=
 =?utf-8?B?Z3V0MitoemQzQUtyaFBDUUJGTjlXeU1wNU9CeWtHbnp3aUd3V1dZaDdpQ2tI?=
 =?utf-8?B?UGppdS9IUmNyNmJTS25Mc0xnK0lKTlEzYkdxaXo3TU5PL3VWZ3B3dGtmUHJE?=
 =?utf-8?B?MlNoNUhaTlJoV000VWd4L3cwbC9iczJtWHdmWmtrdEdkQk5JK0doWTlDVVkw?=
 =?utf-8?B?MkxndkZrRHJJVzJ2bnN4eHc0RmlyY200cHJPMFVsM0VOOW56Q2VSQXhGMmlV?=
 =?utf-8?B?MDRSK2pZV0daU1BLUE5ObkJhdE9Qd1NTaFZlNlpwVjBNc04xT0dXdnhKenNE?=
 =?utf-8?B?Zy93QXlLbzBTL2lyQWlreklVUW1xVmZBaUVLSFVqU0dFd0ExSE5XV0FuM0VM?=
 =?utf-8?B?NG40WlgzRG1Bek9FWXFGK01sY3JBUElqNGtCZlpnMkEwNDU1UGRncmJXa3pV?=
 =?utf-8?B?QlhFb08xdHR2MktVTm5WMmJKamlGY25saXltNS8xbFZmVnlnZWJDM1cxTUFW?=
 =?utf-8?B?VXdYaVpxMkRUa2E5L0hqRXpCWHh3dk96bGo0cG9rRHZUYWRKZmRDZlowam5l?=
 =?utf-8?B?aC9hSElFZ0V2MlBlaS9uQTVKTG9oZTdLcUhSZGZrRXg3RU1JSTRuTXdnSlVw?=
 =?utf-8?B?am1ocmFFUVcyN0h0VzRuOW1Raks2NGpFUm9ycXM5bkF2eThDeWhaMmUwNEVB?=
 =?utf-8?B?cFFRY0hrdHA5WW03RWFHcnZVVVdjUHh5ZUFJY0F3QzlYU1pHa0tGSHhwaXJm?=
 =?utf-8?B?eDJSQ2xWMEYxc2FHeFhaVW51OERXZnhMQTF1RHJXUEwwVHBUVElrVTlhY1Q0?=
 =?utf-8?B?RnBOak5LQk0rTGFPbEwrRnN1Y0ZaRXU5eU16akNralB6V2dibzIvbDIyYzZC?=
 =?utf-8?B?am5vdzRtc1JuL1BndnpoeUtuSUNyWGZqdUtmSG5XMEtoNW44NnhaNkpoUTRw?=
 =?utf-8?B?ZWMrekZCNTZwQjVvRXJ0NEZDQmZzMXd0UnJMamZkQ1duUm01TGR6UnJ2elU3?=
 =?utf-8?Q?Y2t98DAaQhX6dB1cLpr93whM1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b759820-722e-40f0-abe2-08dbebeb5d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 06:13:52.0607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RA9QDd23qnawCI57OmvlT20VWJfPNAZK7mMHauHh3gzodXH00VPDHTpRi3xPBy9BrfaIO5VGpvWXFe/xqYVUr3E2CQ0X5gXR+VCXhZQ/Lao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5875
X-Proofpoint-GUID: MdePLxKYuTPKmYQMD3549Kzeh67R0Pb1
X-Proofpoint-ORIG-GUID: MdePLxKYuTPKmYQMD3549Kzeh67R0Pb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_03,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311060001
 definitions=main-2311230042
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IC0tLQ0KPiA+IFYyIC0+IFYzOiBBZGp1c3RlZCBpbmRlbnRhdGlvbiB0byByZXNvbHZlIHdy
b25nIGluZGVudGF0aW9uIHdhcm5pbmcuDQo+ID4gICAgICAgICAgIENoYW5nZWQgbm9kZSBuYW1l
IHRvIGNvbnZlcnRlci4gVXBkYXRlZCB0aGUgZGVzY3JpcHRpb25zIHRvIGNsYXJpZnkNCj4gPiAg
ICAgICAgICAgdGhlIHByb3BlcnRpZXMuDQo+IA0KPiANCj4gPiArdGl0bGU6IEFETUZNMjAwMCBE
dWFsIE1pY3Jvd2F2ZSBEb3duIENvbnZlcnRlcg0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+
ID4gKyAgLSBLaW0gU2VlciBQYWxsZXIgPGtpbXNlZXIucGFsbGVyQGFuYWxvZy5jb20+DQo+ID4g
Kw0KPiA+ICtkZXNjcmlwdGlvbjoNCj4gPiArICBEdWFsIG1pY3Jvd2F2ZSBkb3duIGNvbnZlcnRl
ciBtb2R1bGUgd2l0aCBpbnB1dCBSRiBhbmQgTE8gZnJlcXVlbmN5DQo+IHJhbmdlcw0KPiA+ICsg
IGZyb20gMC41IHRvIDMyIEdIeiBhbmQgYW4gb3V0cHV0IElGIGZyZXF1ZW5jeSByYW5nZSBmcm9t
IDAuMSB0byA4IEdIei4NCj4gPiArICBJdCBjb25zaXN0cyBvZiBhIExOQSwgbWl4ZXIsIElGIGZp
bHRlciwgRFNBLCBhbmQgSUYgYW1wbGlmaWVyIGZvciBlYWNoIGRvd24NCj4gPiArICBjb252ZXJz
aW9uIHBhdGguDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+
ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIGFkaSxhZG1mbTIwMDANCj4gPiArDQo+ID4gKyAg
c3dpdGNoMS1ncGlvczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9u
Og0KPiA+ICsgICAgICAgICAgU2V0dGluZyBCMTUgR1BJTyB0byBoaWdoIGFuZCBCMTYgR1BJTyB0
byBsb3cgd2lsbCByZXN1bHQgaW4gY2hhbm5lbCAxDQo+ID4gKyAgICAgICAgICBiZWluZyBpbiBE
aXJlY3QgSUYgbW9kZS4NCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgICAg
IFNldHRpbmcgQjE1IEdQSU8gdG8gbG93IGFuZCBCMTYgR1BJTyB0byBoaWdoIHdpbGwgcmVzdWx0
IGluIGNoYW5uZWwgMQ0KPiA+ICsgICAgICAgICAgYmVpbmcgaW4gTWl4ZXIgbW9kZS4NCj4gDQo+
IFRoaXMgc3RpbGwgZG9lcyBub3QgdGVsbCB3aGljaCBvbmUgaXMgQjE1IGFuZCB3aGljaCBpcyBC
MTYuIEkgYW0gYXNraW5nDQo+IHRoaXMgZm9yIHRoaXJkIHRpbWUuDQo+IA0KPiBpdGVtczoNCj4g
ICAtIGRlc2NyaXB0aW9uOiBCMTUgR1BJTywgd2hlbiBoaWdoIChhbmQgQjE2IGxvdykgY2hhbm5l
bCAxIGlzIGluDQo+IERpcmVjdCBJRiBtb2RlDQoNCkkgdW5kZXJzdGFuZCBub3csIHRoYW5rIHlv
dS4gSSB3YXMgYWxzbyB3b25kZXJpbmcgaWYgdGhpcyBhcHBsaWVzIHRvIHRoZSANCmF0dGVudWF0
aW9uLWdwaW9zLCBvciBpZiBJIHNob3VsZCBrZWVwIGl0IGFzIGlzPw0KDQpCZXN0IHJlZ2FyZHMs
DQpLaW0NCg0K
