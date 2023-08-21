Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D39D7826CA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjHUKKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjHUKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:10:01 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7430CA;
        Mon, 21 Aug 2023 03:09:59 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37L7owkM016734;
        Mon, 21 Aug 2023 06:09:49 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3skxpw1ngu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 06:09:48 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVyY1S4rqmVEyN3Ddnp8YlJ+PW9dThJ6a5MIJTzK/3LoQoxzfVaVryHLwIuE/lN6YSfvZ0PPOf+SrKRsHnAi9AreuW7DV/llYNdRMyEsD44bad56fcEfQoX+LgcCIYolFILdo0AUeyaXBSWRREBAqmRG9Sy982P/lR6/6v87timDTxsZCTJzFCvI/401Y2eOcfobmsCoMGB2mvifNhcKiQO20TnZezBA0FEqBBz4J1mRT1sDENpG++UIdJH43aQgMnf4ByRqp9b2kgXiJDVqC0aUkXkOHACCUJE7F4TNsPfJw2Um+PK5IlUquAb4al+0FLcIUVnEjufnm8QyiDhA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljGM8LHQG9BMBvB2uM1FuA+atfSU+i4b+7c1trzGMZs=;
 b=b1rJIrRHhZwvctyRe7i6tx2UlWmt82XhbNdPmqQa1Qqn+S64kVNyzI0FYA4d8C0R30A1trGd6o1xvBfBiRpGdwv7XHrRPcUql8+iXlTiP6JXjcwcv42k80zGZB8PZb2DtU24t71NoUT6nPO5vWTGsECJZCf8JmQ+PTjac4wxBHJtsPSn+qCbnRmtb3tFkCI/AFMS/hwx4rxUokIex4mpar2aXNh7PRqhBDqAU5NuxGh096uuCPlgpDK6rJTct3Rodc+QtyRfp88yZKLshkWj6SmYiRHUMexTeL9Yfo19xAWai4owNWqB1fUP6LlfEJPqy98tgfeuCjCZstrdNzWxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljGM8LHQG9BMBvB2uM1FuA+atfSU+i4b+7c1trzGMZs=;
 b=Q2U+O/HMdj4qitZlSxcBTTK4lNQ8g6hKH/aaC5YYWzI/fDaeSIyhWbQCFzw41MB2AyeBiLviFefwATqwwxvE/IsAwy8F3dXuYdVb2y8SOay5Cl+qcpnfo5x8EwVltW1y2B22upFK6dJCP+D4hOVNtN/XynzmRicD3ys05Qmwzcc=
Received: from PH7PR03MB7391.namprd03.prod.outlook.com (2603:10b6:510:2e6::5)
 by SA1PR03MB6322.namprd03.prod.outlook.com (2603:10b6:806:1b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 10:09:46 +0000
Received: from PH7PR03MB7391.namprd03.prod.outlook.com
 ([fe80::e475:2c6e:6502:2c0e]) by PH7PR03MB7391.namprd03.prod.outlook.com
 ([fe80::e475:2c6e:6502:2c0e%6]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 10:09:45 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] dt-bindings: gpio: ds4520: Add ADI DS4520
Thread-Topic: [PATCH v5 1/2] dt-bindings: gpio: ds4520: Add ADI DS4520
Thread-Index: AQHZwHBubxMKk5eWYEOZfGI8WO61ga/QyFwAgCPlDnA=
Date:   Mon, 21 Aug 2023 10:09:45 +0000
Message-ID: <PH7PR03MB7391911157B3AEAAC9DA44B3E71EA@PH7PR03MB7391.namprd03.prod.outlook.com>
References: <20230727095432.82591-1-okan.sahin@analog.com>
 <20230727095432.82591-2-okan.sahin@analog.com>
 <CAMRc=MeLaadEVM1UBaGSJ=cUcJ=ub7_kOc=97t37+oU6+RMuhA@mail.gmail.com>
In-Reply-To: <CAMRc=MeLaadEVM1UBaGSJ=cUcJ=ub7_kOc=97t37+oU6+RMuhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYjJ0aGJpNXpZV2hwYmx4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFdRNE9USXdNek5oTFRRd01HRXRNVEZsWlMxaVpqQTNMVFU0?=
 =?utf-8?B?Tm1NeU5XUXpZek5sTkZ4aGJXVXRkR1Z6ZEZ4a09Ea3lNRE16WXkwME1EQmhM?=
 =?utf-8?B?VEV4WldVdFltWXdOeTAxT0Raak1qVmtNMk16WlRSaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJakkwTVRZaUlIUTlJakV6TXpNM01EZzJNVGd6TWpRMk16azJNeUlnYUQw?=
 =?utf-8?B?aVdIZGlSRTUyTkZWWVkyWXdhRXc0YWpOcVlqbHVaMVYwTTBaclBTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSVzlEUVVGQ1lscDFiV0ZHT1ZSYVFWSm5VRWxxY1VreU9H?=
 =?utf-8?B?NXNSMEU0YVU5dmFtSjVaVlZFUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVkZCUWtGQlFVRnNSMVJIVm1kQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZLTkVGQlFVSm9RVWRSUVdGUlFtWkJTRTFCV2xGQ2FrRklWVUZqWjBKc1FV?=
 =?utf-8?B?WTRRV05CUW5sQlJ6aEJZV2RDYkVGSFRVRmtRVUo2UVVZNFFWcG5RbWhCUjNk?=
 =?utf-8?B?QlkzZENiRUZHT0VGYVowSjJRVWhOUVdGUlFqQkJSMnRCWkdkQ2JFRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRm5RVUZCUVVGQmJtZEJRVUZIUlVGYVFVSndRVVk0UVdOM1FteEJSMDFC?=
 =?utf-8?B?WkZGQ2VVRkhWVUZZZDBKM1FVaEpRV0ozUW5GQlIxVkJXWGRDTUVGSVRVRllk?=
 =?utf-8?B?MEl3UVVkclFWcFJRbmxCUkVWQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQldWRkNhMEZIYTBGWWQw?=
 =?utf-8?B?SjZRVWRWUVZsM1FqRkJTRWxCV2xGQ1prRklRVUZqWjBKMlFVZHZRVnBSUW1w?=
 =?utf-8?B?QlNGRkJZM2RDWmtGSVVVRmhVVUpzUVVoSlFVMW5RVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZCUVVFOVBTSXZQand2?=
 =?utf-8?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7391:EE_|SA1PR03MB6322:EE_
x-ms-office365-filtering-correlation-id: 3dbbbac0-15e0-47a8-83c4-08dba22ebee9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwXrKyrTAaSPkZCTec53AFExXDt3BfdTUalPennLhKOp9SCftou3DdTTxUSIL0wbJxAxcQsFSu0FdPmw8khJsqyhYZE7vSuF//djLcxaf6L0sFjKEGAbcwEDDxQ3048+7PSgV7FcqzxVfpAe2MbJcpZ995pB9KuyaLIwsIUOc/dmELDtxg/Zyh0uRewDbu4f9uDjOl8O+aqq197Ekzd+6z/Rn2VrW7To1EjzHV7F5HAQuhnNZJipnMJGbFfO7LD6DMoQDQsQDxj7oz4+Eql1RKc5Y47yon7oVfJXUC9+6ntzQP3By7yhx9raiPD3fcsVCYXmUvoWVkw79Dxd2BeInC+xilJPNBPPhbWQnx6Wj2OyjVvjJCoX8dN4CM4QlCvrfW2UAjpK4J+E96IRn/oUEx3Wo9E0A1DcAFPvHEWmc1CAbwleld3NG+hRUA3m7cRFUaI00qYufYo6RNR/Ex4LsyUm3WFCeN2BznusFXGG2w1Ig0J6AEVyfxRVgrDETK05SWMU5d+XthXUaiCIu/UTgdQHRgwzdyY5oqyomF3n/3KjmwIw5OARxTqER7BNJ6ZHzxfcvqrqOHeswVVIOyY9OhUYwSiWvbEMMresvDzpLAJ4hi6G8dQ0SPGEfahBrBGe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR03MB7391.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(4744005)(7696005)(38100700002)(38070700005)(6506007)(5660300002)(52536014)(33656002)(26005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(64756008)(54906003)(6916009)(66446008)(66556008)(76116006)(66476007)(478600001)(122000001)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGZiQ2FtTU84N2hhS3Bhd3RrR21FSkVWKzNHbUtjZXpISGhZQWIxajFQZzlJ?=
 =?utf-8?B?b2I4cG1kV2xCWktTNWY5ODluYXY3S0tIZnlyaFpjWjRWSzBzZmpSUWdVTFFi?=
 =?utf-8?B?NENjZ3JKSExyUjg2Vm45am5USEM4SkRMamhzQTVkQW5TbFkwK3pvTHVlblFn?=
 =?utf-8?B?SlJJaklXVjNPelIvVThrNEF1SExBUGZlb21VdHJiL0dlK3M4RVBORExCUWNr?=
 =?utf-8?B?RjdvQThyS1FxVVEyL1dLaFdmOW5PNkk0RER1QzdqaUY5QzRsNmRYMFUrTy8y?=
 =?utf-8?B?anZLNFpDNFNIWlgwMHVMNGVON1lTQ3lDSW52bmVYY3IvSVZWbWxaSk9ON3pO?=
 =?utf-8?B?UEM5OGRnam5DQUxBZnJGM0V4OHhaMFN0QkQwa1d2azZZdVZzRW1yT0ZNL2Mx?=
 =?utf-8?B?N2pHV1VXaGt5Q0hpWmt2N3IvUzh5QlVhL2tsRE5oaUV5MkszaVloWlVqKzBa?=
 =?utf-8?B?MVdXbkZQZnBhL09qQjRKWlNOZE9BTlJyUkZJMVFEaXErMXQxSDRCVTMxWGhr?=
 =?utf-8?B?eVJvc0RCUFRka1c5bXBGUXk0QmVJeE1CYUZXRTBCZVR5R2xwQ3o4VXN6RlBQ?=
 =?utf-8?B?Y1lwQStxTk9ZeC9xMi82MG5sU3U0dTRkMnd3bDV0WEUvcHZ5ZjJRUUZjUGRy?=
 =?utf-8?B?TUwzeE90a0laaURGempnWkhkdTB0WnRRT0UyekZNUm5jK3RiamJ2TnFRNWcw?=
 =?utf-8?B?b3grcTRTMDJ4U3licGhQSkhyRGY1TkpkbHRZRWRYdmM5NGNMNDViTGpURm5q?=
 =?utf-8?B?NGN1Y2w2NHFpWnpiVUFPaUdyUE5UakdNcFFneS9Kd1NCTHlxcEd6Wkt0cnZN?=
 =?utf-8?B?ZFF4ZFpQSUE2MzlMYm91WmRlVzM5K1BQT1JaMkF5dVhHZUFHa0hab0J3M2FS?=
 =?utf-8?B?UFBvMkNxT2JCVCt6a0c2aE83eHpvT0txcnBrN3J1RTg5bkFnem1lTThNVHRN?=
 =?utf-8?B?azI4dm5Nc1Z1MmRNa3BqQzE2OVhiZzRpYXJZdC9xTGNqVEtINE01Q2dDWnM4?=
 =?utf-8?B?WUtNYmVBM2RndW9mQzNVajlRUHg2REJyMis1VUhEeG9qTTVZbU94NEhFUWwx?=
 =?utf-8?B?aFVPRG4yN204SDR1UFNQbS90T0thVm1pdGQzVXBFTjFqZ29Cc1c1SUpBSlY1?=
 =?utf-8?B?aXFJdTlJblZEZ1ZDdnU1cFFkbkJub2hvZTVZSThTb3hTT3R2dFBoeGJVdTlD?=
 =?utf-8?B?L05jRXhvR0VQeHlYMWNQeEZuZ1JzR2J3Njl4UXkvTXFmaVlDRWxHVkdWVGVK?=
 =?utf-8?B?SXN1OVlEZDVpM0J3dTZvMmdjRDJYbTc4dkRKT1QyNWphRHl4cVF3cFdHcmlw?=
 =?utf-8?B?a0VKZnFmaEpudVNTN2Y5VGpYYTVmSGRpaStHL1RieC9xMVpDYy9BZTZGbHlx?=
 =?utf-8?B?WDFoMFNWRDIwS2gzaWZaVkRVT0NIZkE3dnBzUHA2eHcvZ2dodnkyRi9TSHBU?=
 =?utf-8?B?NUtQMHVmTEc2S1JGMWFubm5nNTdkT2prSnE3eXBwamJTWnFBLzR4b0tzS1Fi?=
 =?utf-8?B?bTkzYUlaWm1OL1VSNWFjVUR1bnE5UnVXRUZMdGJSRnM2ay9SUUEwNWhsZms0?=
 =?utf-8?B?T0NqQ1VNa1g4cytHZVBvNkNyemhqOUxzOElwQkttYWc1Wmc0VU03VDVaOEpQ?=
 =?utf-8?B?MUwzM09kTFlZMTBuQVJkbzl2bHhNVHFsS0M1Qy9lT0t0ZlJuenMzMllvY0Z3?=
 =?utf-8?B?Wmx3KzNOMkJNekZtMStlZjVPTTFqeDNZY1dmT3lHV2Y5bDMwV2FPa0sxUjhZ?=
 =?utf-8?B?RXhLdk92aTYwMUJHbXM0MmQ2ak1GVXdaWE9wNndJMXBJVmlDaHRxSFZRbWp1?=
 =?utf-8?B?YklxSWFlUGYvZ0hLeGRyakVlU2lFek1xYWpIT2ZyZFJLUlYrZWc3S2V1RXB2?=
 =?utf-8?B?UGdyeTlWMXhwNWhkL1ZYVk5hWUlucGRkckkwYjk5NlpuZE1iNDl4eG1KTFJ5?=
 =?utf-8?B?QXREeG5IVWU1SDZ6NEhKQWZjb1k5dlBueUVGeThIS0FXWFpIdDBIS0hjYmxk?=
 =?utf-8?B?enM4YWpxUzd3b3ZHSTVuREFtTlE5TXE1YnkxdnNHSGR2ZFV2cXY5YUNTdFE4?=
 =?utf-8?B?Mjd4REdpSkt0OHVBR0o1OWlvSEtQTUdSVitBeDFldERka0VHZHZRQk9JV0dJ?=
 =?utf-8?Q?ysE4hJbFVDRFq8LZf+ttZiXMO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7391.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbbbac0-15e0-47a8-83c4-08dba22ebee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 10:09:45.8097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jm2Wu6PO3gYXBKagKk/PXg+Zyio1A6W+9a4z/2EubgIWvC5/rzZB6sBr59M02apPRx2IW+GHQSubgKLfgpQ3kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6322
X-Proofpoint-GUID: vBalZDBXhD2tvyFkAurToYj3RS9nK0zE
X-Proofpoint-ORIG-GUID: vBalZDBXhD2tvyFkAurToYj3RS9nK0zE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308210093
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+T24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgMTE6NTXigK9BTSBPa2FuIFNhaGluIDxva2FuLnNh
aGluQGFuYWxvZy5jb20+IHdyb3RlOg0KPj4NCj4+IEFkZCBBREkgRFM0NTIwIGRldmljZXRyZWUg
ZG9jdW1lbnQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogT2thbiBTYWhpbiA8b2thbi5zYWhpbkBh
bmFsb2cuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRv
Zi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4+IFJldmlld2VkLWJ5OiBMaW51cyBXYWxsZWlqIDxs
aW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+ICAuLi4vYmluZGluZ3MvZ3Bpby9h
ZGksZHM0NTIwLWdwaW8ueWFtbCAgICAgICAgfCA1MSArKysrKysrKysrKysrKysrKysrDQo+PiAg
MSBmaWxlIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vYWRpLGRzNDUyMC0NCj5ncGlv
LnlhbWwNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2dwaW8vYWRpLGRzNDUyMC1ncGlvLnlhbWwNCj5iL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9ncGlvL2FkaSxkczQ1MjAtZ3Bpby55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi4yNWIzMTk4YzRkM2UNCj4+IC0tLSAvZGV2L251
bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL2FkaSxk
czQ1MjAtZ3Bpby55YW1sDQo+PiBAQCAtMCwwICsxLDUxIEBADQo+PiArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+PiArJVlBTUwgMS4y
DQo+PiArLS0tDQo+PiArJGlkOg0KDQouLi4NCg0KPj4NCj4NCj5BcHBsaWVkIHRoaXMgYW5kIHRo
ZSBkcml2ZXIsIHRoYW5rcyENCj4NCj5CYXJ0DQoNCkhpIEJhcnQsDQoNCldoZW4gd2lsbCBpdCBi
ZSByZWxlYXNlZD8gSSBjb3VsZCBub3QgZmluZCB5b3VyIHRyZWUgdGhhdCdzIHdoeSBJIGFtIGFz
a2luZyBpdC4NCg0KUmVnYXJkcywNCk9rYW4gU2FoaW4NCg==
