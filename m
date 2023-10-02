Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAE87B4ACA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 04:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbjJBCaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 22:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBCax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:30:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2101.outbound.protection.outlook.com [40.107.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6875F99;
        Sun,  1 Oct 2023 19:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrygjNw7jhG+23s1p7oBw3oqru1XMyH82NhbvpKVvw6+9UpPYziaS66Z2ewU7IwvC2MDfloL3p0mwMCyBUEKYb1VSRXfBLtJiFW6UvCUynN7qCmr57njLMgU+Hf/4NQPrHNGQMhgjhGfbHMh26aZqsojC6YlIYqthNTwEZxaWa48RMb2FoZZ5mSPwKHW8k6GwCFDcDJ27agy0MaviKS0oCr+EFcOXkBl5ZzG469ZlRUaKsdLMzPKO+fINCPXQ5VwlTNOfxwHPaEIn5UJhyYX8T5cm1wDC3BkxzJbBoamtMMiIadksV5vzHRL6BuS3PusnTnJl6JLITA8edCTq0t5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ17g/BqyVgQ76Nk/IP2YK7W2TXWpTYadijN1Lb/LLw=;
 b=XPzij7AM/EQa9ege8fH8Yk87QIqL15pJZG08RAdd/rV62iJttM5rgsenltCyvMVxMs5ReVn/VrT+POX8ti6z31ap06e0PR2E8Q37I/xZMGMTp3ddcnwjWEw37qDROYGNd5zL97RYmRzmeV7rsllqIpAHT5Z0txi0263/CpKWnRThE0bPyz634I4n6uqPPt1fejPAwu0zjzG7LoXVyxEQ04aXWb+E2BXib4wnxzI5ifqt/hnrkGy33YY5o7QfuH7okcSrZfY6h8pLgyBW0RZ8QL9pncn4MdJ/DsO2De2kmULNUSX8tjFG3LPcz8PHsIpppa83YDSMYbMM0g3eayTesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ17g/BqyVgQ76Nk/IP2YK7W2TXWpTYadijN1Lb/LLw=;
 b=Yjt4rRvFgedrqcuqW7Evg/hsbA8C8CEYM8G9d2xtSHI5YEtUKC5IQboP3t4LIL5HK7rjp5n+FeTd/pIpxpu1vaHaAsiOZeZZEBOAB0nlTnCJRLZ/XTREdsXiR/YliSjFFOvcF5PRG+nbD+eDtUaZWlwOSSqrZvGUOZbVyM5z9dV9ILOQ5tlLMcmR1RU6nUTaARrs7qsWbbO8cfEo4bUqo4+kNOLu44iF0Zmq75bVHLAzHzEZDF29hHi+DUg6Xi0mpGf3KFonb4HB6mG/TiHAt06eBKCwttTkOGqHh7ZLJM+raSyTJVh76ptzzJ7BVN6teQxVkNrSkO4ySzPNR0ie3w==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 TYZPR06MB4397.apcprd06.prod.outlook.com (2603:1096:400:73::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.28; Mon, 2 Oct 2023 02:30:44 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::956c:2f06:be93:fc3e]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::956c:2f06:be93:fc3e%5]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 02:30:44 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Potin.Lai@quantatw.com" <Potin.Lai@quantatw.com>,
        "patrickw3@meta.com" <patrickw3@meta.com>
Subject: Re: [PATCH v1] iio: adc: aspeed: Support deglitch feature.
Thread-Topic: [PATCH v1] iio: adc: aspeed: Support deglitch feature.
Thread-Index: AQHZ74jrjlOSMsUvo0yNgHQbGiIz5LAzm9aAgAIo4C8=
Date:   Mon, 2 Oct 2023 02:30:43 +0000
Message-ID: <SG2PR06MB3365E89B1543B770AC2EE7E78BC5A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230925081845.4147424-1-billy_tsai@aspeedtech.com>
 <20230930174501.039095da@jic23-huawei>
In-Reply-To: <20230930174501.039095da@jic23-huawei>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|TYZPR06MB4397:EE_
x-ms-office365-filtering-correlation-id: 2b017593-95cf-45de-811f-08dbc2ef93ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PMrsKkeKSF8GhzKmEJaUs2i0QQsnPOat4Lk8ocC5nWbb3y0V3Ok5JPkK+8ZE0j35a5M1BlyQfnhDeRhUStQAWHi0NB1hjTYGEC9E/tEbg3YqWM+for1HjpETF0TN0MnM/7gI5Tj5WJYh67fAV9H3K2+LxgzlvSWhxkGY34r4nw17i3oEy60hHk9PAaRfm+yCQe3ShLNnc9h1qIc/67MFsVLt+g2aZUrKjgMwJxw+o/lZXPrc21pBBBW8bk8mLK81yz7xTiLSXUzYBgPkbr2vkbtY2pDLOCBG6fJMBEafsEYeziCb9Z6tqJn+m4my0mN7PxefwFdgUnJBhPoOTtNN5Xi7iNOv49yHI8pdHCB1+o/O6rZBoHzYYvt9ZpbYaWQ5VzIcDdqVxfha8+kBG7hkrb67+6IP3fzrvIPgIgtKN9pD+7kRqUoEBNjQUirB4D8JycfvHKoAushbojXw4t/z9hUMN3RXT/4pYjNtmZkMV3XWKMm3r+W5I4sudxqX6f7TngxGAipO1NlY5xjBxNqQcG79+sq4cAsyev7uNM73s8VJjlnR4J9+zqyi1deFUk1odnsGV5kPtxVovxRC34GXW6th2r5q+ryHivEnPmb0i9rO2nVvB3JOrsm6Adj9Dgh0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39840400004)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(33656002)(52536014)(41300700001)(8936002)(5660300002)(4326008)(8676002)(83380400001)(26005)(71200400001)(86362001)(9686003)(7696005)(6506007)(55016003)(7416002)(122000001)(2906002)(64756008)(54906003)(91956017)(38100700002)(38070700005)(66946007)(66446008)(66476007)(76116006)(66556008)(316002)(478600001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KGw/+fhA2tmoCZGOL8C3rkqfpMsm0cPxFCS/RYSbxQ97TZGs+u9+jDQllJ?=
 =?iso-8859-1?Q?e/hNLgdGJIubSPriUWHF2CCtWJUWFCqbDNLZh6jVPsimsSMeY/6GJwAGR2?=
 =?iso-8859-1?Q?FGDZUbesBaDwELcfFDDRL5S1SfmvfERZ5Tyk0US4DApNLZdiN20hFAAhdn?=
 =?iso-8859-1?Q?Fi0LG/SyQ7D0cQAQLir3IdlBiHStWfsTGkURVEh+h8WyCvLfpgo4A/YTWr?=
 =?iso-8859-1?Q?66XzNdVv516nK1w077eLTvLuOY0SsGXV/vLCF6wIelx2y1WaOdrctx/yhg?=
 =?iso-8859-1?Q?cIBYa7aKDZJS770+aQm4fxIpJ0aYvk9Ro/t1wWhzYdWgAjH0iU5C2OUKfp?=
 =?iso-8859-1?Q?f7pd5kZi8yLBdxRb6ENOTrxcoEKpLFdqK2El57/1SN/y2NwaiDtQQy9U5W?=
 =?iso-8859-1?Q?UhyI6zB7r2RnFjO+3vFScvciQaBDvisLomV1m6s0kpDv/NMi8ZyC7ShqZ+?=
 =?iso-8859-1?Q?C4w0yV7UN+s8UapmwN0XYP8kT3YE2OkqMLxRj6ny1xJlCPfwhyF+uLVKY5?=
 =?iso-8859-1?Q?mOI3taeCudogSfjJVcnXcALAl4tDfaJ41LfL7D+EmmX0ytvCl5D4qYaaQh?=
 =?iso-8859-1?Q?RCLWjM4JZ1LlBT2++1rdtazrE1suxA/uhyEttYeiBYqgfo5cPPEGzS8HNi?=
 =?iso-8859-1?Q?oA6FZRwwXG1jYWjoNxl64mV1Y9vfxbM7oSoUuiN2s1c6hIkKFIRj24O+Vn?=
 =?iso-8859-1?Q?+fFYdx9MvPLd/nqviBdXOSvpc/j6A5eHHBK+fL4wbAjuy5ILPw75ItkPkP?=
 =?iso-8859-1?Q?OEwPFgUg82B3oWezbbnOi6KExVFh4H4P9rPqBJ8SwOsStvRftpST16CMS1?=
 =?iso-8859-1?Q?xAOh1JZpsQ5Yfyj+8eS54ALyvoozxcaoTrgzXWat4gQYwrkUJjdjrkGMBu?=
 =?iso-8859-1?Q?VzzeOlVb8L/oDMRsWxFzqJIX75G07DZ9dXsA5zvMU2/2DSbVB5RaE0GdEz?=
 =?iso-8859-1?Q?cc5REHmHUFl6uhyZEoiBSG4tHxRjtbfhzBWSN9EgTt/te4teVAFbMUcK8S?=
 =?iso-8859-1?Q?g/K/e/w2J7wzt5v3FYOP3yL/nxd/qIUMbVrD3i2WNQbiC+vtZbgd5jWoiu?=
 =?iso-8859-1?Q?KomNrYeD1tIKIj1C4tx6ypKaU0MGs9GgAphBYe33ghuoUCANy8k0KKIg1T?=
 =?iso-8859-1?Q?aKo19p7IkbInZ09CKIydXvbu5KciAWKpBqCJUFZqBZe6atUtshMFpnrkJF?=
 =?iso-8859-1?Q?nRNqmIuJeOqe3P9iHKpluZPU8tDiwopekp3L5xjklzhb8vFpUnxFVSLRtv?=
 =?iso-8859-1?Q?hfEmpeFf+tMXC9arnxNCgcbUjKu6u++I3ocVXxVArGXi+BhRLZXiwTfTn8?=
 =?iso-8859-1?Q?19vo8NEzPe0C1t8YCsgX7cQml3Lo06IW1ItLmzlJMxc37xUEiOExQdJrN7?=
 =?iso-8859-1?Q?K1BLxXHsuw7VbMLA3zoxRocNun1yu9/u2HSQ2H5/l92DEMM+TIK6fKZRDW?=
 =?iso-8859-1?Q?gSqqHRTE89RnTK/KMjO8nuSniotbi60vs8s3OxzMlBi4+wY++PIFL51FSr?=
 =?iso-8859-1?Q?3e+EEfLN2H98S4X4zJJnKH/wSbjKgeueutMCvucXx1+y1FlgRVuQMHlGfW?=
 =?iso-8859-1?Q?Yer7WuTcxJnyIDSq47f5grCGwYpzQ+w/lwTt3OjV26MI7FmI60djb2lbJI?=
 =?iso-8859-1?Q?CLYkg2iwQiJp527TTF5SdlV6nr9A0bN0TK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b017593-95cf-45de-811f-08dbc2ef93ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 02:30:43.7904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QpoIkP3z+D4FcOeEOdQEHxb+pv8yZBUYDqrCayXtJ2qhxpuW+9jaC/W0G9RjDGKBKsj4P5LaSHKYt2wSL/zYG6Jrdh2xdJtMyGIF7vC8d0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4397
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 16:18:45 +0800=0A=
Billy Tsai <billy_tsai@aspeedtech.com> wrote:=0A=
=0A=
> > Create event sysfs for applying the deglitch condition. When=0A=
> > in_voltageY_thresh_rising_en/in_voltageY_thresh_falling_en is set to tr=
ue,=0A=
> > the driver will use the in_voltageY_thresh_rising_value and=0A=
> > in_voltageY_thresh_falling_value as threshold values. If the ADC value=
=0A=
> > falls outside this threshold, the driver will wait for the ADC sampling=
=0A=
> > period and perform an additional read once to achieve the deglitching=
=0A=
> > purpose.=0A=
> >=0A=
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
=0A=
> Hi Billy=0A=
=0A=
> This is pushing the meaning of the events interface too far.=0A=
> You can't use it to hide a value you don't like from userspace.=0A=
=0A=
> If you can explain what the condition is that you are seeing=0A=
> and what you need to prevent happening if it is seen that would help=0A=
> us figure out if there is another way to do this.=0A=
=0A=
> Jonathan=0A=
=0A=
Hi Jonathan,=0A=
=0A=
Currently, we are experiencing some voltage glitches while reading from our=
=0A=
controller, but we do not wish to report these false alarms to the user spa=
ce.=0A=
Instead, we want to retry the operation as soon as possible. This is why th=
e=0A=
driver requires this patch to handle retries internally, rather than relyin=
g on user=0A=
space which could introduce unpredictable timing for retrying the reading p=
rocess.=0A=
This software approach aims to minimize the possibility of false alarms as =
much as possible.=0A=
=0A=
If you have any suggestions or recommendations regarding this situation, pl=
ease feel free to=0A=
share them with me.=0A=
=0A=
Thanks =0A=
=0A=
> > ---=0A=
> >  drivers/iio/adc/aspeed_adc.c | 193 ++++++++++++++++++++++++++++++++++-=
=0A=
> >  1 file changed, 189 insertions(+), 4 deletions(-)=0A=
> >=
