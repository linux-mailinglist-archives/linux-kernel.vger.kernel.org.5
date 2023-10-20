Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497327D130E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377761AbjJTPmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377733AbjJTPl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:41:59 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC66BF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:41:56 -0700 (PDT)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.184.89])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id A870D10001326;
        Fri, 20 Oct 2023 15:41:54 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1697816511.985000
X-TM-MAIL-UUID: 2c320545-a808-4557-848e-ec72e759bff5
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id F095710000E35;
        Fri, 20 Oct 2023 15:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uu954gGXfMludsIr2VtZBT4by5RlyJSKj8NgvOqM6Whz94FCzO93tzbwVtU0RDMZT0FKBdpr5tQMaomoimkH0gsWyoqu6S9aLq5eHZXz0X1ByBtIXx9dFdbNskI3U5u49Ujk1dKsS4CRSiBouFtgChj+9XF2w/Q8DLoxKuBlAvzxiYZ6VAkQXkcpAK66Eg4dPdjPQYIHV7H6jXaCAwYbrNWTJsFlCzYRmk2ca7AyPkU8FEcYvrtQcS11wQt9gca/JWwssoPKYvZoUwgmrUiZugAtremGq90wgP0dDjkQigQumjeNAa88SpLsU6xPJanjDhwzV6+2vRA9q2hJsoiiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytnl/gEptJu8EcX45u4dJLB+rYEffdjr2D6MbjqXmn8=;
 b=H33guu8eKjDYdv6MN5B17YmTzMTF5ulfuLRT3nIOuzURCONdiztpoU6RqowZ1Gn8xQgNKdGWP1ovWhig9PcGNWJMso5mIazKlOLSyOYNGDJpUgdrWLHiBjGFIN4e7AaCeqVjoXGw9J9q3CRe3EbXlAlT4OzwTG4+5huqeUKnOXWDzzuYc1w/bLXyJIDW5Ho/DSmcpyVi1299ifHYo5YX+IpyFKX/wXkZ2SnK95uJjo905G34W01pkHO1lmqb75w8muGd3B8ZLoBpXS89+u0K2EjeoaF/rA9Q7465keobwxiuIMwq/d4tTKmkjEeFbqtBWReEFZTdUszZQkxNd0lL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <c032b7f7-ccea-4e3d-a3fc-d772d034b195@opensynergy.com>
Date:   Fri, 20 Oct 2023 17:41:49 +0200
Subject: Re: [PATCH v1 4/6] pps: generators: Add PPS Generator TIO Driver
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, lakshmi.sowjanya.d@intel.com,
        jstultz@google.com, giometti@enneenne.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
        christopher.s.hall@intel.com, pandith.n@intel.com,
        mallikarjunappa.sangannavar@intel.com, thejesh.reddy.t.r@intel.com
References: <87lec15i4b.ffs@tglx>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 xsDNBFuyHTIBDAClsxKaykR7WINWbw2hd8SjAU5Ft7Vx2qOyRR3guringPRMDvc5sAQeDPP4
 lgFIZS5Ow3Z+0XMb/MtbJt0vQHg4Zi6WQtEysvctmAN4JG08XrO8Kf1Ly86Z0sJOrYTzd9oA
 JoNqk7/JufMre4NppAMUcJnB1zIDyhKkkGgM1znDvcW/pVkAIKZQ4Be3A9297tl7YjhVLkph
 kuw3yL8eyj7fk+3vruuEbMafYytozKCSBn5pM0wabiNUlPK39iQzcZd8VMIkh1BszRouInlc
 7hjiWjBjGDQ2eAbMww09ETAP1u38PpDolrO8IlTFb7Yy7OlD4lzr8AV+a2CTJhbKrCJznDQS
 +GPGwLtOqTP5S5OJ0DCqVHdQyKoZMe1sLaZSPLMLx1WYAGN5R8ftCZSBjilVpwJ3lFsqO5cj
 t5w1/JfNeVBWa4cENt5Z0B2gTuZ4F8j0QAc506uGxWO0wxH1rWNv2LuInSxj8d1yIUu76MqY
 p92TS3D4t/myerODX3xGnjkAEQEAAc07cGV0ZXIuaGlsYmVyQG9wZW5zeW5lcmd5LmNvbSA8
 cGV0ZXIuaGlsYmVyQG9wZW5zeW5lcmd5LmNvbT7CwQ4EEwEIADgCGwMFCwkIBwIGFQoJCAsC
 BBYCAwECHgECF4AWIQTj5TCZN1jYfjl5iwQiPT9iQ46MNwUCXXd8PQAKCRAiPT9iQ46MN1PT
 C/4mgNGlWB1/vsStNH+TGfJKt3eTi1Oxn6Uo0y4sXzZg+CHXYXnrG2OdLgOa/ZdA+O/o1ofU
 v/nLKki7XH/cGsOtZ6n3Q5+irkLsUI9tcIlxLCZZlgDPqmJO3lu+8Uf2d96udw/5JLiPyhk/
 DLtKEnvIOnn2YU9LK80WuJk7CMK4ii/bIipS6WFV6s67YG8HrzMKEwIzScf/7dC/dN221wh0
 f3uUMht0A7eVOfEuC/i0//Y+ytuoPcqyT5YsAdvNk4Ns7dmWTJ8MS2t2m55BHQnYh7UBOIqB
 BkEWLOxbs2zZnC5b/yjg7FOhVxUmSP4wU1Tp/ye+MoVhiUXwzXps5JmOuKahLbIysIpeRNxf
 B8ndHEjKRl6YglPtqwJ45AF+BFEcblLe4eHk3Gl43jfoBJ43jFUSkge9K7wddB2FpaXrpfwM
 KupTSWeavVwnjDb+mXfqr4e7C4CX3VoyBQvoGGPpK/93cVZInu5zV/OAxSayXt6NqZECkMBu
 mg7W7hbcQezOwM0EW7IdMwEMANZOEgW7gpZr0l4MHVvEZomKRgHmKghiKffCyR/cZdB5CWPE
 syD0QMkQCQHg0FUQIB/SyS7hV/MOYL47Zb+QUlBosMGkyyseEBWx0UgxgdMOh88JxAEHs0gQ
 FYjL13DFLX/JfPyUqEnmWHLmvPpwPy2Qp7M1PPYb/KT8YxQEcJ0agxiSSGC+0c6efziPLW1u
 vGnQpBXhbLRdmUVS9JE390vQLCjIQWQP34e6MnKrylqPpOeaiVSC9Nvr44f7LDk0X3Hsg3b4
 kV9TInGcbskXCB9QnKo6lVgXI9Q419WZtI9T/d8n5Wx54P+iaw4pISqDHi6v+U9YhHACInqJ
 m8S4WhlRIXhXmDVXBjyPvMkxEYp9EGxT5yeu49fN5oB1SQCf819obhO7GfP2pUx8H3dy96Tv
 KFEQmuh15iXYCxgltrvy9TjUIHj9SbKiaXW1O45tjlDohZJofA0AZ1gU0X8ZVXwqn3vEmrML
 DBiko3gdBy7mx2vl+Z1LJyqYKBBvw+pi7wARAQABwsD2BBgBCAAgAhsMFiEE4+UwmTdY2H45
 eYsEIj0/YkOOjDcFAl13fD0ACgkQIj0/YkOOjDfFhwv9F6qVRBlMFPmb3dWIs+QcbdgUW9Vi
 GOHNyjCnr+UBE5jc0ERP3IOzcgqavcL5YpuWadfPn4/LyMDhVcl5SQGIdk5oZlRWQRiSpqS+
 IIU8idu+Ogl/Hdsp4n9S8GiINNwNh5KzWoCNN0PpcrjuMTacJnZur9/ym9tjr+mMvW7Z0k52
 lnS9L+CRHLKHpVJSnccpTpShQHa335c5YvRC8NN+Ygj1uZL/98+1GmP1WMZ6nc1LSFDUxR60
 cxnlbgH7cwBuy8y5DBeCCYiPHKBglVIp5nUFZdLG/HmufQT3f4/GVoDEo2Q7H0lq3KULX1xE
 wHFeXHw4NXR7mYeX/eftz/9GFMVU29c72NTw8UihOy9qJgNo19wroRYKHLz1eWtMVcqS3hbX
 m0/QcrG9+C9qCPXVxpC/L0YLAtmdvEIyaFtXWRyW7UQ3us6klHh4XUvSpsQhOgzLHFJ1Lpfc
 upeBYECJQdxgIYyhgFAwRHeLGIPxjlvUmk22C0ualbekkuPTQs/m
In-Reply-To: <87lec15i4b.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::12) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|FR4P281MB3591:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa9370a-820f-45ba-6749-08dbd18313eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6LXYDyfCwCeW+t3Ma4ktOHiPKP0BQDdhcrLkwffd1HQ+ruhjtmc0T2exAawsE6wtgYq5jEjy1/cKjhy5QsEO+eAVlHqe0KDaoROVVRLNipP/1jl4L/BuRy3korkM8taszl1faJI6/VDuOvPVQT/fCjzHjUp2Ynf8S66vLi+gq9qmaUkhXeeSMsgwWrAohOWo6uhqTKtIF+5nYPrYlWthvhP//VhzQG4HpOwVa3/HsAKxOyViS3L0WukoMyEHkolbwmw9Kul4tm5M9A+ZHb9zyAOxOjclIWMbrQbq3CBW0JYZQZoNzDDgBa5vj4EA0z20+L1FhEFi6gbx4Y0mbFF56epnnJyKQh3+KVIxlKKTZtVwlfUZi2aqEuL/Tk7gpkcVcGs2JkPWhYolzLE44ZVarPemze3ENaNoczn8HI5/yCzT9uSIZmYuE3VzTyL2kDZ8flUUoAQNIGqXGBPcEXWb1Kb0CQT6VU37R6wd4Oc/BpXD2IPEO/o8EjPgIQtLK7Kbcng5qMWPoXa6DsWYzPuoVHPJ/DQlGqPV8+yXFRn3KG9NmwYuRMdLE7gjzfxKDcB++l+MczPS/5WkJ/Ln4CTujph6qp0PInfPhiVPuFh99cNJfrOdtoyzYY2fj7UkwX5GqX5aGezq25EnacCvgGhsAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(396003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66476007)(38100700002)(478600001)(966005)(2906002)(66946007)(316002)(7416002)(66556008)(8936002)(42186006)(44832011)(8676002)(2616005)(53546011)(83380400001)(41300700001)(5660300002)(4326008)(31686004)(36756003)(86362001)(31696002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bERIVHJWVDI5THN4WHN5bjZrYWZQK013MlZLS2MrSkJzY3BKM1FqRTViUDRJ?=
 =?utf-8?B?ODhEOXFwVEpURWYvYmttY2ZYb1JyeC9CK0JJUkVOVCtianR3U0J2d0NET0hv?=
 =?utf-8?B?bWJLR1JkcGVVOG1yb2lWWmlRUDQ0bTB1ckhLRFZLeDh4b3l3TzdWZlY5N01M?=
 =?utf-8?B?aFg0N1FUYVZ4M3hzZXBYSzVpS3Z2RHNLTWdyaklPYVovNVJmTERFdUFwc0N0?=
 =?utf-8?B?TTk5RllXZTIyV0F2ZTk5SE00dDVRUzNSR2d4cDUxV2N1b1pzL0YxaUxGZDk4?=
 =?utf-8?B?MGMvY3lxOHd0ZnpwaWVGSSsydldFM0JuZW96L1ovME9YNldZeFNDT3dtOTA4?=
 =?utf-8?B?aTNtM1FITFkzZGhqS3ZRd3lYSjh3Ung5MWt5MVIrMVNPaWtLdlVQNXJWWkNO?=
 =?utf-8?B?Z2M5b0tyZGRmSTFpYjBvWUhxU0dYbno1OC9zWGE3cDJTNlV2b212ZE45NUZ3?=
 =?utf-8?B?ZlFCdTJ3S3lYanJwUTBLeHhuYVBvYlViS3B5NFhuUVd3ZGNUZ3d0UklFVDJq?=
 =?utf-8?B?SjBSQkRRY0hNVGlQWTQycnhmU1lrSTY3SUVZS3hMVUVGNFVvd3llZHYrU1dI?=
 =?utf-8?B?dTlhOEdsMUt1dXhLc0MvSEx2WkhnNFBJWG5zVkllVTRUVGV1UFBoMGYvYklk?=
 =?utf-8?B?Ly83MStoZzNsMk9NL0IwWTdYT2V0VXFzS2JocThTWTQvK01CczlzOHRqN3VZ?=
 =?utf-8?B?ZnV0L3drRGZmY1BIOVlTd2N1bHRGeEFDbjQrVXBoSG90WWI4cWRkci9FWUlh?=
 =?utf-8?B?N3k5QTBTR1dsQlJaTFVQZnZjMmNxZnkybThsbStrcjhwMVNsdjFtaDJvK0JK?=
 =?utf-8?B?cWU0K3kwb21FSTUyRExOM2o1cjRiVXdncm1kN1Q0Zk5QT1AvWmFCZ3R5bytV?=
 =?utf-8?B?cUN5OU1Mb1U4VER1WFNrTXIydy9EWEJtdFJSanZicmZKbDZDV3FrRmxTbUln?=
 =?utf-8?B?cTh3SGtUR0h2eDZjajhOdGRrSFo1OWhKWWRBREhld05YMCtVZTNmOVJEWGV5?=
 =?utf-8?B?MDAxRkVmallMQVBPcDRmMW5MRGZ2ejZCWnBWUEt6VXZYaUx4VmM4ZmFTUTc5?=
 =?utf-8?B?VVJBM0EzZ1VLeDFYenZXZ1VvOGFPZHlyR21RNnhIa3VwWkxuYnZBK0Vab3d3?=
 =?utf-8?B?SmpkK1dBMmI2RFJzUEFjekU0TWsvK3p3M3dIazY5WU1mR2hVdm1PaUxjMUQ2?=
 =?utf-8?B?Q0pWUzJpTXBqbUNQckhxY3ZjMU9zUmpGL2hRTG0rSlkwSm04UHAvRFlheW9Q?=
 =?utf-8?B?UzZSeFQxblQ0SkhDelhiN1NGcHd1aHJsL1VnbjNDcnB2OTREWkNQWjU4dVhx?=
 =?utf-8?B?dE1NRGJaMFBTY1NveVhQVHBNZjUyaUxXdWpPQm9TczF6NFFhWlNNcUFCOGs0?=
 =?utf-8?B?NE0rN0dHMkZWSkROMDByL3hLUzJ2R1ROOUJHMFFDNWFFbjZzKzJCbWhJd3lz?=
 =?utf-8?B?aTRXamVNV1lEcHE3Y1NjWlc0YVhrV3IxckxOWDVkeS95Qjc3WjR2OHBkbFk3?=
 =?utf-8?B?TUdkeUVMQ1Y2NzZOMmN5WFhzdmhHUTJUeTlHNEloKzNUU2Jicmw0WCtVTy9v?=
 =?utf-8?B?M25kNkNGVXB5MC9wZUo3cXZPV00xdUcvbVdOcWM3YnRTcTltRTJpWTM0Qm90?=
 =?utf-8?B?R21XNTg3bkc4cVZtWnJlQkxxU2MxaEIrLzkvTHFlSjJCRHB2QjgweTlzendC?=
 =?utf-8?B?cFYzU0tiUHRjaEx0b24rNXgyWjhLdUExRG5nQVZ1TE1OcVBsTXBsU1V2WSsr?=
 =?utf-8?B?cmtub1o4YnZvOEx0ZTUyQjkzamE1Z1FRaUExa3NzMjNCd2dZMVk2OXREQTNH?=
 =?utf-8?B?bXdlaEVPV3pLWEtILzQrWXBxTXJpWU9kQlF6V3AzemtWU1ZZVW9CNHJWdVlX?=
 =?utf-8?B?ZjdKVHAvODJjLzZZcy8rMm4vcDFwSDBZQ2RZWFN3WDM4WW9UVkI2eUV0WHVE?=
 =?utf-8?B?VHFHU3pZcVNXbnIwYTRCVEoyYm42THhFUGRKaFNrUWcxY0lJd3hqb1dDUlIr?=
 =?utf-8?B?R1dOaEFFU0kxY0psUlNlZmhyREgzWDlaN3lzak9JR09EOWZVbWJnNEIyQits?=
 =?utf-8?B?YS9PbU9RU3lQb0pVeEtIc3VuaW1Zb0F1MElRdTNoSlpuTEJtOXRLY3l5VWlO?=
 =?utf-8?B?c1ZuTExOWUlpWXRIelBoTWpDSW9McVNhaHlqNXl0cmNPMjhCKzRMdFBoZDRV?=
 =?utf-8?Q?Wr634f5sQ0NSPOFKqB+pjuUivNOVV/m+pIPeNlghgJWa?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa9370a-820f-45ba-6749-08dbd18313eb
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 15:41:51.0290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ut4yOo70pAew12ZgUsV84BEgqZ36UKRNgOiznbigrDoDeQoMAgV7vB8aN3KxERrRyp1Z3aUiGArc+RpE46xrNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3591
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27948.000
X-TMASE-Result: 10--13.651500-4.000000
X-TMASE-MatchedRID: 6otD/cJAac35ETspAEX/ngw4DIWv1jSVbU+XbFYs1xK78y8e/xyoiUbn
        veBAkQO2LfgCWmpP5eMqcNc79lakdmychE78+cDjNqQSQG2vXfoNi5sB0+4vp3miaGC762CcQDn
        GaQeD/Ws8bMhr/mPoW9E44JbP4MvvpCkfTcAJL1bPO44lG1LRiKAO3SYYHGfQvrLRu/dDv14Y8d
        8wv8ZjpMzT1ruzWS4DvbV2+Y9NUjia5lUWqS1Ubenf5L1UVWyvE5Ag1ujdxTbhGW8X92XIsq4HX
        gANsgPqhdu1Wlu/mY7H+Uih9rzERcddJPEKsqAMkcN38V3mAjajg0lrtKMWyg2h/xVLZG6HTvOS
        XKE9MP1gjJAzgl+daTTMjv56Jlnw86j63TYg0YDtb0jbZCNASoDXhna8Lb5i3S+oEXSaeq3m3R7
        I3/TUVw==
X-TMASE-XGENCLOUD: e254ab14-b8c9-4152-87e1-c8964e7b9132-0-0-200-0
X-TM-Deliver-Signature: 554392A2052FF8EA2BE726EA5BA18168
X-TM-Addin-Auth: JlcYh0t5sRy+wPRZOQdM55kqGn+CpB/lL15XKs/hPRvl8jFGFCQn0KlCDHR
        AQCnKSomOjuGtaYo3cjeifWrWhxqYjKGhhaOEqVXY4HZHDDxzwem9Ikw3Xq5adGHXZ/i+NhWuM1
        k8fCWF395Sra5BL4AiMyYyWuqyVxXYOVJnobw9VlvlRrwR8gqL+eJ4pktmWvYMQAwC4GhNfY4UN
        dxi3LG+/VdBlvt4m3DPyVMRhl8Hg/rB+ZTY5Q7wo5bxzMCgntrWBOi/4u8hwXS1Goi/prywg46G
        UA2HNj+OH24iLvk=.SKMYqZH0Uq/dXDouLPX9Cfv6K3QQGvDwEdN2N+3o29OcDMXdE8EDk2lyvw
        4LUI8a6d0gNS2BoU++mjWZ63Nfo8/r/QspnaSpDWoi93ZE5EDv5Qc3nHlgkreBngQMTo4N+jvjU
        guzPZdNqGtVuiMQSE/vTNbkPiL8MVuuvnvD3qVFAGXu4rtTjv8AxIENHaRKkHGEj+SlR14aTMzE
        5hoysdMuVwhivJ72Qixbl33LSjF48mR3CyAfqGr7Z0L8t4hOPszw2y6cUt0568XubCPxC0Ovvgb
        UgET1SvS2G2EIknO/GxJiY+ycKTNMkxTPI1V7w5DwtlscaAiYjfesSTPlWQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1697816514;
        bh=+btQ68AmcWJSILa9e4N/O8hbuZlNXpNr1qkY5rcgbRg=; l=2091;
        h=Date:To:From;
        b=GdPRBqAD4rTwL8HVRvf7vUgdHh/zvmW4989ibMBEFu15jPBtuwqP4LSBjED/MeEKF
         hhIBEOP2zZO0oxvppeN18Jxx5fE0a65ya6v5tl1BVI1LMggH3PXk7JwfgRSAeUXZi7
         /jUl4/hRBk2ZtMxSn85ROOF9uKH41mg00YKfmYLzzTkH7G1BDGWrJtYL+jkxBcgPLZ
         fVsLr3MGPf63MMyPR6IipIU0fmo+8jVZbzGPNaY1KwHLzfO/C3xIBHrFurTEWUuOuN
         a/IZSHXMVGGNDqzTZqRuj6bUHhQkXDYmxuqb2LIObcHe1juu1v2upyGKu+XgSGqTU9
         CQW2DqDUvqn7Q==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.23 18:27, Thomas Gleixner wrote:
> On Tue, Oct 17 2023 at 10:54, lakshmi.sowjanya.d@intel.com wrote:
>> +	guard(spinlock_irqsave)(&tio->lock);
>> +	if (enable && !tio->enabled) {
>> +		if (!is_current_clocksource_art_related()) {
>> +			dev_err(tio->dev, "PPS cannot be started as clock is not related to ART");
>> +			return -EPERM;
>> +		}
> 
> Ah. Here is the usecase for this magic patch 3/6 hackery. Again, it's
> the wrong abstraction. You want something like:
> 
>     timekeeping_clocksource_has_base(CSID_X86_ART);
> 
> or something like this, which can be handled completely in the core
> code.
> 
> All of this needs some serious rework. See the below disfunctional
> mockup patch for illustration.
> 
> There is also a patch series, which tried to replace the clocksource
> pointer in system_counterval_t with a clocksource ID:
> 
>   https://lore.kernel.org/all/20230818011256.211078-1-peter.hilber@opensynergy.com
> 
> That went nowhere, but has some valid points. I took some of Peter's (cc'ed)
> ideas into the mockup, but did it slightly different to make all of this
> indirection mess go away.
> 
> There are certainly bugs and thinkos in that mockup. If you find them,
> you can keep and fix them :)
> 

Hi Sowjanya,

I am working on another iteration of the patch series cited by Thomas,
which would implement part of the mockup. But the scope of the original
patch series would remain, so no changes to ART conversion code, no
introduction of the clocksource_base concept... The patch series should
still be compatible with Thomas' proposal, though.

I was wondering if it would make sense to coordinate the posting of my
patch series. I planned to post the series sometime in November along with
other stuff, but I could potentially post it earlier if this could help to
align.

In case of interest in aligning, I uploaded an unverified preview for the
upcoming series to [1].

Best regards,

Peter

[1] https://github.com/OpenSynergy/linux.git clocksource-id-for-get_device_system_crosststamp-v2-preview
