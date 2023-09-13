Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B108C79EDA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjIMPtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjIMPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:49:08 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79D9CE;
        Wed, 13 Sep 2023 08:49:04 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38DD3ZJD006426;
        Wed, 13 Sep 2023 11:48:44 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3t2y8f5b7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 11:48:43 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJnlMwvG5stofTwU8/VoNaRb5ddHQHS+gu/SwSYNaNat1CIhmGZNLHPDgRJuUmGj3Fb0OM8fhgethQkHVjZ0dktv8hBfnGFsM8slvFMP94MtSi795eO6oJ3DxUvzjwbIyj33dQdbe6zwcY7NMNM0gPNa1pvNzNiLZh23dGG+eoPfEWwAjYJ8f07WEaqW7ihf4/brXiQiqQKWT0CmqnWZuYcPtDuWw/WHy1ecWubRp233xL7sBNS1TVQCxnBNZ8VFRpVg6D5jC2kr42nB5XDFA254pXCq4P/drHzrItzammaO8PajkHkM7Zgr4JTANNzMFvwXEri+KZxv8ns3hJg0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7Hw2f/pe3o/VHrPPrrrlek9IUbFe6uWPjE0W1pcX+0=;
 b=OfEVLdP2n0JT1WEa2m3YwzxhzoOD8HnyzT64jbyDrYbOxytLK3Ld0U5S2jKf4QVik0ziUnoZZ0qWKwu6NBc4Z0jwt0o2RHdJEKxA08FGXLfLgPtzV8GE6bbhlr41Z0aYHcBMZWFlenGeQpgUa5W215m8KcNKfthCl0WkCfZUSYQ3luuEh+BTaLgR7BskmjwmzUiZ5oDLlb7KygstGNhGL8dd0ttjlX6kUm9Ip39FjInCEhHz4usMb6mSx1E4EJl8bXsPEkUGNTpndQuMs/W5hWKzRgDXYykeaKFFC8iM6nPWZ3MoxmQVhxWVVuSjVDW1oq25WEh50U5xNVe2C8KQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7Hw2f/pe3o/VHrPPrrrlek9IUbFe6uWPjE0W1pcX+0=;
 b=b4HylbrmSP6zjBZojnuZl4bMkaZUKvNi5sqPqzCGGYa78kBP7zJzVUhyg35IpvZVtr4Y1KHPZa7oGmgKP1QDWgLtuAFkyq5bpGlR2pzFJwkKOtJ98DXKWvz6d9gDzzbVZ651Yvblvca7A5N6e2P/TwPYjOBnjjbmVl0DXQ8v9Hs=
Received: from PH0PR03MB6771.namprd03.prod.outlook.com (2603:10b6:510:122::17)
 by PH7PR03MB7136.namprd03.prod.outlook.com (2603:10b6:510:2b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 15:48:41 +0000
Received: from PH0PR03MB6771.namprd03.prod.outlook.com
 ([fe80::4134:3c8a:c35e:3d4a]) by PH0PR03MB6771.namprd03.prod.outlook.com
 ([fe80::4134:3c8a:c35e:3d4a%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 15:48:41 +0000
From:   "Matyas, Daniel" <Daniel.Matyas@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH 2/4] dt-bindings: hwmon: Added new properties to the
 devicetree
Thread-Topic: [PATCH 2/4] dt-bindings: hwmon: Added new properties to the
 devicetree
Thread-Index: AQHZ5lYkIsiOGL6qF0yUOvCqqNlnVLAY5JmAgAABkUA=
Date:   Wed, 13 Sep 2023 15:48:41 +0000
Message-ID: <PH0PR03MB67716A8AA5139C407BB0712989F0A@PH0PR03MB6771.namprd03.prod.outlook.com>
References: <20230913152135.457892-1-daniel.matyas@analog.com>
 <20230913152135.457892-3-daniel.matyas@analog.com>
 <177ef05b-0cca-be25-afad-ac518d9f6473@linaro.org>
In-Reply-To: <177ef05b-0cca-be25-afad-ac518d9f6473@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWkcxaGRIbGhjMXhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MVEF3WkRJek9XVXdMVFV5TkdRdE1URmxaUzFpTnpJeUxUQXdaVEF5?=
 =?utf-8?B?TW1ReE9HRTRZVnhoYldVdGRHVnpkRnd3TUdReU16bGxNaTAxTWpSa0xURXha?=
 =?utf-8?B?V1V0WWpjeU1pMHdNR1V3TWpKa01UaGhPR0ZpYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?YzJPREFpSUhROUlqRXpNek01TURrek56RTRORGc1TlRrMU1pSWdhRDBpU1dS?=
 =?utf-8?B?VGVIbFNiWGhuV25aT1NUUjJRak15UVdSVFpuaGFTR3c0UFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlJXOURRVUZFVVdkNWJrUlhaV0phUVdFcllXNXNUMDVoVDFKaWNq?=
 =?utf-8?B?VnhaVlUwTVc4MVJuTkVRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: PH0PR03MB6771:EE_|PH7PR03MB7136:EE_
x-ms-office365-filtering-correlation-id: 37937064-302f-4242-acd4-08dbb470e753
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bxSFBCVlrJdrfsO4Bq3Tuc1FwnguGRxJ63M6WOloWRoahOvFSspZh38i59/4Yav8N6PXHKZUmbhUbxe5o/xcIp7g7nBcdCsT/neutCttlYn+47+8e5CQ9fONt5ZEhhcAPtQMGNV2+uVn1j9+Ro22RigrFVNyAnpGGwzw7jYw6LW22gt0V5XtPTyCFsE84nRhW0b9A52vZFzfVjhZFwQKC6TBQt5iamVTj1qqVEoNW7GebA3XF08OPJbt45D55OWC+gEC+r/Ax1xjKTUqLN9maKmMDaflnMoR0HuwkOGoMaAXe9b0C7nRqXP9V4LOl5uYHOFeC52fW1WO0WQ4XZEA6fgrHY2GYQbd87Uy3pBSFToXCTupMNQ1Yguf3YrjGmYq+a7WcR8630A1g8eqFhoUf2DlMpSrff2fK3D7jJbo/jZoMWe7w4UmczckXAqfVlelbgodOvdiZGvEZPXjOOt/Au722BaI98NvYo3wnOFF2RpmtZqNI63gqJpy1Uh1+tMKisc/OfAxa8A8IqF/yPW4rb30m+vj7/C84eFa9eRVDw0RNvUhD1TBor9gzryUNQC7LanXa7DizVJuBztThyG06uvaWEVqJ9hXa06G4ZAkoa8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6771.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199024)(1800799009)(186009)(38100700002)(38070700005)(122000001)(33656002)(86362001)(55016003)(7696005)(6506007)(478600001)(53546011)(54906003)(52536014)(64756008)(66446008)(66476007)(66946007)(76116006)(66556008)(2906002)(8676002)(8936002)(71200400001)(4326008)(966005)(9686003)(83380400001)(5660300002)(7416002)(41300700001)(316002)(6916009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFdZbm9QYld1dkxlRWIvRzRpd3Q0SEMvMThScXM2VjZtWlVLaVlibFFIMytq?=
 =?utf-8?B?TGVKYVF6QjdpY0NNT1gzcFRBWkJZZEIyNzJlWTIvWlpJQ0VYdEhlbjZiZTY5?=
 =?utf-8?B?eFFvSDh4cVFSV2RpNU01ckJEZDd1WXZGNHhqR0RYcnRlcEJkcEduR1AxQWZL?=
 =?utf-8?B?eEh4aHIyY2dyVHdHTkNOamo0M3VCVkppbzl3S1JzaVZFd3ZsT1J6NVZpcFdC?=
 =?utf-8?B?cDlGMm5EcCtXYWRUa1pZVXpEZGt5OHdwZEdHQnltUmFiZkpGSklrQkV5TEh0?=
 =?utf-8?B?anFxNDNGaEFSVzNNUklPUUxka1A0dnd6cVhUbGZsamZNbmMvNnZUS3piVWpF?=
 =?utf-8?B?Q2NIeGFQVGhLclhTVlI0SThHd3U4THFpSENuaFdkN1dTa1Z6S3BFek5uTnUy?=
 =?utf-8?B?YnU0eTZQK0I2ODNydWhzSTJOKzYycVN0R2hLSk44WkZsWXB2ek9oZVd1QWZs?=
 =?utf-8?B?OW5NTjVLSmRBdWc5Z3dKNDJPTFY0eC9SeitQSjZ3d0hNNVNmUStYNmNGUVgv?=
 =?utf-8?B?ZThPTS90YTFLNmR3UlBPbDN4VVlvREdhaDFrZG9uRmlqaGpEK0ZxS2pjejlt?=
 =?utf-8?B?TkJMbEk1dDBaeEhrUHU4VzJ2SkVVbUN2S1hra04vdEZZVzR3dVAvYkRRSjF2?=
 =?utf-8?B?aHBEZkFUUldVSVBaK1JJOTlGd0U5RVZ3NEh0TDlBb1pHTnF4aVZFdkc2RTc1?=
 =?utf-8?B?eHNyc2NVOHFqY2ZKSUd6MEpvUkxsaEhsNVB4M25NK2tEM0JnYWErSEhEaThj?=
 =?utf-8?B?WUswRXlROXpVMXd5RTAzTzgrSE1RMXlhdUZ2VGR5NzRmdURGMmZUZmVFNUds?=
 =?utf-8?B?WTVNTmlUa0hNQXA5UkJCRGN5MDJUbk1yNHdTVkFabjFSNkF1aUxacWN6cDJh?=
 =?utf-8?B?SjlqblRhVUVkV2RCbmJlOE5GU1ZJbzhQOG05UnY0c3FFS1grUXZMZHNHblRR?=
 =?utf-8?B?L0trVDN4RDZ5WDZLRE5icDIrYS9Ec1FCc2cwelhRODFkcVhvaElVVUZQNXJI?=
 =?utf-8?B?ZWJUT1l6RU9obDF1OFVqSWpySFc1QkJEL09yNW9BNjAyUFBia2Nib3hUTys3?=
 =?utf-8?B?bTFKbWJCUVVzYi8weTVycjIySEpEcUw4R01LTjRZRHJvY2wzcFQrRGIvc0Rl?=
 =?utf-8?B?M0JOa0hXRHFrV2VSOVp1OW5oSTlWNmFvbTI1QW1pd0FHS3Y2cnVDQ2R1aHQw?=
 =?utf-8?B?eklNMkpQbWtFLzExaTJ3cDVZd1l4bFpCRStXZTRST2VWdEJVQ0ZkNGcrRVJU?=
 =?utf-8?B?Y1JYekhGb2xvMmZaR2g0MTVvL1RNWUk1ZmdSQWlEWmJFN2tWS09tTWpYaDNY?=
 =?utf-8?B?N0lKYzRPTkV0YTFpUTBQRTQ2MTZWQ25YTXErbzNBTWVNdFRkTXoza1dVZm1V?=
 =?utf-8?B?K1ZoSzBvWXVWZkJMTTFWaFhMVkYrdlFWVFU4ZmpTOWZYc0NDVFNSTVFpdEJY?=
 =?utf-8?B?Y1prZGFWRmErT2hzdGdQcVczVzNoMVROQ0RJcnBZSUNCdWozMXIyaVFadGJp?=
 =?utf-8?B?bFREcWkyanM0L1RKSHp1dkRaUDUrMHJmVUxEYm5hdG9rWkhGSmJxUTd3aVJG?=
 =?utf-8?B?RUpWRkRoSkFXY2h1UGErTzZnNi9pUnRvT2JDTzhqSWRvaXdVOXIxckw1OHJE?=
 =?utf-8?B?RXJBa0hpR2Z0MnhsRFZmUGdKVEloNnpaRyt3Z0p5dDJ5dHVLNDJpQ2IwSTNW?=
 =?utf-8?B?V2tYU21TVzh1TG83TnBGVE1ETEFMVFhFVEJVZUV3K1llZlBBaEg3bmZ3cTRq?=
 =?utf-8?B?K3g3eElVWFVSeStXMnY0ZFBCN3FGNFVWMXJLZHk4Wlk2R2tnUlViUjBCbXhS?=
 =?utf-8?B?ZnNoS0V4d1dtWURFMXkzeW9XbHlDUlRaQi9RRG9iR3IzQnZtSzdDRE9TVWRh?=
 =?utf-8?B?VzlLdE9VRTlNa1FROTNod2w0bEUwVVJjMzlCQ2owRS9lZHc2cWdCek01QlZF?=
 =?utf-8?B?d3dLdm5HYk5QWXFURXJxcmtZcGZNMzY1NjhzL1R3WGEyaW1MR3FieWZqa3Vv?=
 =?utf-8?B?SGFabVNkWElkcUplWHhyaFVzSXp2cU9ZNWhveWdHV01vYklvY05Gb0g0bEp4?=
 =?utf-8?B?NzR6dm1YRUpmclgxaHZTdXQyclMvNjQ0R0lXaGloZXF2a3htZ1ZMSERWTDhl?=
 =?utf-8?Q?yfsiF0GdGlHcbRXKLtLoad3VB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6771.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37937064-302f-4242-acd4-08dbb470e753
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 15:48:41.3134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: azzxXnF5ZJxB1XeciA5aryXj55yLcCRlWjArwklBvlN1V3F2NmMtsNDgQfBSOq9x2KZ1/X4LkQSde4nNDork1g6eVLw+efsHXmBGiyeE2Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7136
X-Proofpoint-ORIG-GUID: mBjv6yMrwdWlz3UDtzvxyhB6CTTcmDKv
X-Proofpoint-GUID: mBjv6yMrwdWlz3UDtzvxyhB6CTTcmDKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_10,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309130130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IFNlcHRlbWJlciAxMywgMjAyMyA2OjQxIFBNDQo+IFRvOiBNYXR5YXMsIERhbmllbCA8RGFuaWVs
Lk1hdHlhc0BhbmFsb2cuY29tPg0KPiBDYzogSmVhbiBEZWx2YXJlIDxqZGVsdmFyZUBzdXNlLmNv
bT47IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLQ0KPiB1cy5uZXQ+OyBSb2IgSGVycmluZyA8
cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3IgRG9vbGV5DQo+IDxjb25vcitkdEBrZXJuZWwu
b3JnPjsgSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD47IGxpbnV4LQ0KPiBod21vbkB2
Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDIvNF0gZHQtYmluZGluZ3M6IGh3bW9uOiBBZGRlZCBuZXcgcHJvcGVydGll
cyB0bw0KPiB0aGUgZGV2aWNldHJlZQ0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gT24gMTMvMDkv
MjAyMyAxNzoyMSwgRGFuaWVsIE1hdHlhcyB3cm90ZToNCj4gDQo+IFN1YmplY3Q6IG5vdCBtdWNo
IGltcHJvdmVkLiBJIGFtIHNvcnJ5LCBidXQgeW91IGFyZSBub3QgYWRkaW5nIG5ldw0KPiBwcm9w
ZXJ0aWVzIHRvIGVudGlyZSBkZXZpY2V0cmVlIG9mIGVudGlyZSB3b3JsZC4gWW91IGFyZSBhY3R1
YWxseSBub3QNCj4gYWRkaW5nIGFueXRoaW5nIHRvIGFueSBkZXZpY2V0cmVlLCBiZWNhdXNlIHRo
ZXNlIGFyZSBiaW5kaW5ncyAod2hpY2ggaXMNCj4gb2J2aW91cywgYXMgc2FpZCBieSBwcmVmaXgp
Lg0KPiANCj4gWW91IGdvdCBjb21tZW50cyBvbiB0aGlzLg0KPiANCj4gPiBUaGVzZSBhdHRyaWJ1
dGVzIGFyZToNCj4gPiAJLSBhZGksY29tcC1pbnQgLSBib29sZWFuIHByb3BlcnR5DQo+ID4gCS0g
YWRpLGFscm0tcG9sIC0gY2FuIGJlIDAsIDEgKGlmIG5vdCBwcmVzZW50LCBkZWZhdWx0IHZhbHVl
KQ0KPiA+IAktIGFkaSxmbHQtcSAtIGNhbiBiZSAxLCAyLCA0LCA4IChpZiBub3QgcHJlc2VudCwg
ZGVmYXVsdCB2YWx1ZSkNCj4gPiAJLSBhZGksdGltZW91dC1lbmFibGUgLSBib29sZWFuIHByb3Bl
cnR5DQo+IA0KPiBEb24ndCByZXBlYXQgd2hhdCB0aGUgY29kZSBkb2VzLiBFeHBsYWluIHdoeSB5
b3UgYXJlIGFkZGluZyBpdCwgd2hhdCBpcw0KPiB0aGUgcHVycG9zZS4NCj4gDQo+ID4NCj4gPiBU
aGVzZSBtb2RpZnkgdGhlIGNvcnJlc3BvbmRpbmcgYml0cyBpbiB0aGUgY29uZmlndXJhdGlvbiBy
ZWdpc3Rlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBNYXR5YXMgPGRhbmllbC5t
YXR5YXNAYW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL2h3bW9uL2FkaSxt
YXgzMTgyNy55YW1sICAgICAgICAgIHwgMzUNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZGksbWF4MzE4MjcueWFt
bA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FkaSxtYXgz
MTgyNy55YW1sDQo+ID4gaW5kZXggMmRjOGIwN2I0ZDNiLi42YmRlNzFiZGI4ZGQgMTAwNjQ0DQo+
ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FkaSxtYXgz
MTgyNy55YW1sDQo+ID4gKysrDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2h3bW9uL2FkaSxtYXgzMTgyNy55YW1sDQo+ID4gQEAgLTMyLDYgKzMyLDM3IEBAIHByb3BlcnRp
ZXM6DQo+ID4gICAgICAgIE11c3QgaGF2ZSB2YWx1ZXMgaW4gdGhlIGludGVydmFsICgxLjZWOyAz
LjZWKSBpbiBvcmRlciBmb3IgdGhlIGRldmljZQ0KPiB0bw0KPiA+ICAgICAgICBmdW5jdGlvbiBj
b3JyZWN0bHkuDQo+ID4NCj4gPiArICBhZGksY29tcC1pbnQ6DQo+ID4gKyAgICBkZXNjcmlwdGlv
bjoNCj4gPiArICAgICAgSWYgcHJlc2VudCBpbnRlcnJ1cHQgbW9kZSBpcyB1c2VkLiBJZiBub3Qg
cHJlc2VudCBjb21wYXJhdG9yIG1vZGUNCj4gaXMgdXNlZA0KPiA+ICsgICAgICAoZGVmYXVsdCku
DQo+IA0KPiBXaHkgdGhpcyBpcyBhIHByb3BlcnR5IG9mIGhhcmR3YXJlPw0KPiANCj4gPiArICAg
IHR5cGU6IGJvb2xlYW4NCj4gPiArDQo+ID4gKyAgYWRpLGFscm0tcG9sOg0KPiA+ICsgICAgZGVz
Y3JpcHRpb246DQo+ID4gKyAgICAgIFNldHMgdGhlIGFsYXJtcyBhY3RpdmUgc3RhdGUuDQo+ID4g
KyAgICAgICAgICAgIC0gMCA9IGFjdGl2ZSBsb3cNCj4gPiArICAgICAgICAgICAgLSAxID0gYWN0
aXZlIGhpZ2gNCj4gPiArICAgICAgRm9yIG1heDMxODI3IGFuZCBtYXgzMTgyOCB0aGUgZGVmYXVs
dCBhbGFybSBwb2xhcml0eSBpcyBsb3cuIEZvcg0KPiBtYXgzMTgyOQ0KPiA+ICsgICAgICBpdCBp
cyBoaWdoLg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
dWludDMyDQo+ID4gKyAgICBlbnVtOiBbMCwgMV0NCj4gPiArDQo+ID4gKyAgYWRpLGZsdC1xOg0K
PiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFNlbGVjdCBob3cgbWFueSBjb25zZWN1
dGl2ZSB0ZW1wZXJhdHVyZSBmYXVsdHMgbXVzdCBvY2N1cg0KPiBiZWZvcmUNCj4gPiArICAgICAg
b3ZlcnRlbXBlcmF0dXJlIG9yIHVuZGVydGVtcGVyYXR1cmUgZmF1bHRzIGFyZSBpbmRpY2F0ZWQg
aW4gdGhlDQo+ID4gKyAgICAgIGNvcnJlc3BvbmRpbmcgc3RhdHVzIGJpdHMuDQo+ID4gKyAgICAg
IEZvciBtYXgzMTgyNyBkZWZhdWx0IGZhdWx0IHF1ZXVlIGlzIDEuIEZvciBtYXgzMTgyOCBhbmQg
bWF4MzE4MjkNCj4gaXQgaXMgNC4NCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwj
L2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgZW51bTogWzEsIDIsIDQsIDhdDQo+ID4gKw0K
PiA+ICsgIGFkaSx0aW1lb3V0LWVuYWJsZToNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsg
ICAgICBFbmFibGVzIHRpbWVvdXQuIEJ1cyB0aW1lb3V0IHJlc2V0cyB0aGUgSTJDLWNvbXBhdGli
bGUgaW50ZXJmYWNlDQo+IHdoZW4gU0NMDQo+ID4gKyAgICAgIGlzIGxvdyBmb3IgbW9yZSB0aGFu
IDMwbXMgKG5vbWluYWwpLg0KPiANCj4gV2h5IHRoaXMgaXMgYSBwcm9wZXJ0eSBvZiBoYXJkd2Fy
ZT8NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpUaGFuayB5b3UgZm9y
IHlvdXIgcXVpY2sgcmVwbHksIEtyenlzenRvZiEgSSBkbyBub3Qga25vdyBleGFjdGx5IHdoeSBk
b2VzIGFyZQ0KYSBwcm9wZXJ0eSBvZiBoYXJkd2FyZS4gSSBqdXN0IGRpZCB3aGF0IEd1ZW50ZXIg
c3VnZ2VzdGVkIGhlcmU6DQpodHRwczovL21hcmMuaW5mby8/bD1saW51eC1pMmMmbT0xNjkyMDE3
OTU3MTU2ODcmdz0yDQphbmQgaGVyZToNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC1od21vbi9wYXRjaC8yMDIzMDkxMTA4MzczNS4xMTc5NS0yLWRhbmllbC5tYXR5
YXNAYW5hbG9nLmNvbS8NCg0KRGFuaWVsDQoNCg==
