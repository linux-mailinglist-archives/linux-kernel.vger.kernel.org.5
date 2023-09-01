Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B69A78FEF4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349960AbjIAOXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237954AbjIAOW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:22:58 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2086.outbound.protection.outlook.com [40.107.103.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C204510DF;
        Fri,  1 Sep 2023 07:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ0lFRwjqUj2OS3opjIw95/HtgdxhSqHW7eqErRDa5N/BPOgNQTb46RAfMe3X10PSf+1ROF/Aiv8mTXpKHfXfgrWO3Aurw8oce4+TcuviSoeDM1YwqNxRVS6YpLa1sQh4L2XmQDLekZOWWdgtylPIdqXqnn4fLEoVLPf0bPsu74cF/IdTJZKGlfTK76sx6N3QSoxH+ITTWNuyaNk1jzSNHO4vftMoD6Witu9Hq8dvHw96ZL9eJPmwf0AxUYVqbd5tI+sCHU8SQVuetYXbIkOxGBtiY4d7gvskhnuRz0ikhRAcB9ljzg/gOE0gsI30bgp9g7UJfASvddhHwIZBZZEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFlm9nr4AqGw6FvFOefDu0hsVgw03g9VwI5vy2Qzyrw=;
 b=knlfMbujL1MVrjjbL4X91g4H9Qe+STSMV0DDB/G7O/5IuwIwBCJVZiD5I+b1n8wk3Ht/F+zVK1cjm5vjx4keioishye0XS1Pg56n20gtYhXkLoIX9tybimkQ4E5uf+2npGVENjh/FlukxUKNrR5Fw/2IwzX4i7wxoRXBmzfJgtJ0ZeY3rUUDSJXYPrHXtOibl2bGM4hnoBkLvtwyhx1JQkbiX1ymHmnjgYpGLEMT76rkH/ZZa88j7NKPztkKnay3OuJvhJca6vvsSrly4GowPyn87+6VMa31gDORgoL4KxEGfI6tqRHmcVaLj2IedYW6imqq/nZhJ5cZwaCjNXzulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFlm9nr4AqGw6FvFOefDu0hsVgw03g9VwI5vy2Qzyrw=;
 b=Mw2sUszGw03yIVMrzIXJdVIEBVCzAEdgIkgV3eAy6ubw5bKsPstmHPPYnt6u7pBmq2iRFHhlLfvXrypbJHJrY0klrcLs+lplEmUGA73+Rr/NhNLffpGMT/ErxVZzhDU7iFMeSQrALawc+1JpZETX7qEnPzqmkmOd2qNaJGeqcRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DUZPR04MB9822.eurprd04.prod.outlook.com (2603:10a6:10:4ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 14:22:52 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6745.021; Fri, 1 Sep 2023
 14:22:52 +0000
Message-ID: <ba7e5fbb-126f-8240-4784-e8e25e53b8f0@oss.nxp.com>
Date:   Fri, 1 Sep 2023 17:22:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Content-Language: en-US
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     "atenart@kernel.org" <atenart@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Sebastian Tobuschat <sebastian.tobuschat@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
 <ZOx0L722xg5-J_he@hog> <5d42d6c9-2f0c-8913-49ec-50a25860c49f@oss.nxp.com>
 <ZO8pbtnlOVauabjC@hog>
 <518c11e9000f895fddb5b3dc4d5b2bf445cf320f.camel@nxp.com>
 <ZPG35HfRseiv80Pb@hog> <831bc700-a9a2-7eda-e97b-e1d54dc806f9@oss.nxp.com>
 <ZPHt1vgPzayHfu-z@hog>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZPHt1vgPzayHfu-z@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::13) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DUZPR04MB9822:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc2a43b-2cee-436e-7864-08dbaaf6ed55
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxVYuFzR8qk8T1Xd6f8zEBOq9kXAb+QH8q5Uuyo5fpsKZRVCayixSvyVcuxZpESo0tKEAwj4SIuUx81AArP68Dz55qxDapGmv5yqg2gpnLGZkA8/28KLmkKFtt5ocLCjIeDxjLu+3o76vQ7ybt8UxscKU4e8A0CQ/ZfW5qOweHvIOyxENTXz6FDbN+xcS0BWU3XI/52nbKooZbatbEywtuCUtCLRQ2Kw8zLBwdEO6/3Mh3I11MHQ8iu1WDgLE4dAQwdn6h62EtcbAQ1KPz6mbp3wQDFa18WwPiZ3NbAEvm3HhqX9hJ9z1Z89eA2X7EqqiJNBNfOZ9zeljDI6kXpZ1OSXLatxl/1pRUtDKpWFfHbCRvqmQD9edUd+xbxe5oh4NOpXCK/zT4LAFLA/TD+jATu4EJStdJosUcZwsiys00NCPphvdnFb4CoFy8QEnd4i5DEjqaDrQF352o5FYLuYbZjnv5BThsUqaqrqs263aiKrm3fh9FdudBUUA6mi4MYW5v2QcNtKEfBQpDhkLmjO4zgKdfm5Q5vnQhoGubHvNw7m3Kx1UnYpo2oDQUr+r5s8SaKI3fDmGAQiTcZWRc6SdxItgvWoQZSJDNGrp3ni1AOwbmLBezFlB6ZPn4BjGzzmbVhc6LQdJjr1OAfl1UJR2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199024)(1800799009)(186009)(31686004)(6506007)(6666004)(6512007)(6486002)(31696002)(86362001)(38100700002)(2616005)(26005)(2906002)(966005)(53546011)(83380400001)(478600001)(66946007)(4326008)(8676002)(8936002)(5660300002)(7416002)(6916009)(41300700001)(316002)(66556008)(66476007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHNocS9RUXJPNkVhS1ZaQk83ancyRWl3SW9wL2NxV1ppeTBMYXdkUGFOK0hN?=
 =?utf-8?B?NHhiM2N3d3gxZEpqYlo3MSs5Mm1Ta1lmWjRyV01qeDgzbDNzVzMvdHhxM09w?=
 =?utf-8?B?NGZqM2d6RkFadlpSWkYwOVV3MmxvVXRoNnlGaVRhNTRNOGlRRXNkSmlYNGVV?=
 =?utf-8?B?WGJFRWQ4MUc0YjE0YThwRmpVdUR5Zm9jK2RNb0NIVksvTlN1b3dUL2d0cnF2?=
 =?utf-8?B?My9SRmU0bTVtZzA2dWlRNlFXMjJhdE9qU2d3a2lFdnZCMWZNcjEvSlNOM2Fk?=
 =?utf-8?B?OFI3UXJMcXhjMytHaldJNmVnQ1c4d21vR3g3NFkzS2VKS2M5cVBEcEZ0MlJY?=
 =?utf-8?B?WnNDUjdvUmgyMVlpUjRlQ0xCRGVMUGNaQlBoUUwyUmtieFZLZXg5M0xYcGh3?=
 =?utf-8?B?U2w3Wm5UemlNLzJzd2NtdjB4S2l3WHdhT2g4WnE0dFppaG0ybEVGRUFWc2M2?=
 =?utf-8?B?VjhxdU44VG1QS2pxMFZTVmt6ZFlEbG12bjdZSnE4R1pvUVJmM2NKV3hRdEw4?=
 =?utf-8?B?UTFlazVDWVo4TUZLaUg4dHlvWlV0bzN6Qk1YK3ZWWC9WaDJoQTdEOWlsdkQr?=
 =?utf-8?B?clBJUkg0bnoyS1JBdHNWZkFqQ3d1UlVsVS9zUktHM1hLWkoxd3RLSXJSdlRI?=
 =?utf-8?B?Vmh4MmFoSGFPckMyTG1kRzFHUVliVStoVnJtL2VvcEs4Ym1XV2tld0tvei9M?=
 =?utf-8?B?ZFA0dTVZcFVrSUczOWFvd0ZQczNyUmtXaFZtN2ZTb05rbW95ZExhekhiYWlZ?=
 =?utf-8?B?eHh3VjlCQjVyaW1zdlRyTjNabHBYRDVIMDhFWjgvUUs3dEdJekZLa0NMVmVy?=
 =?utf-8?B?THppenJSdWJHQ2dKTjBMTjlieWNqRmUwdEtHaXBwemZBd2c5ZVRkSGQ4RnpM?=
 =?utf-8?B?SVhJWDYzUE5VeCszNXIydktmQVNiNkFSeGRkczlnMGo5bndSUXRTYytNRUsx?=
 =?utf-8?B?czlxNklvQXhJS3pTeEhwY3BrMmlvNk1ON0Jmdm5jMzlETGNiTnRMbVVXcDhr?=
 =?utf-8?B?T3djSTVCU0FWT0hRMndKTUUvTnhWaWl1cDBDN2JxUSs0N0liMlZhSVpmc0xs?=
 =?utf-8?B?aXVhbDd4TDMrRHVjOS9kN3Z6bHk1UC8wOXdLa1ZaSUhEUjJERjR2dEh1RFo1?=
 =?utf-8?B?RUlZV2hIbUZPckkyN1NlMXlsSnQ4U2dTQUZQZFc3dzBydDR2ZDhKZTlNdXVs?=
 =?utf-8?B?UkxJWHNmdjVKbmIvazU1eENzOFhOb1didzJUUldQVnQ4ckRzaFRRZUI5MVZV?=
 =?utf-8?B?MVJkR3pYeEp5Mk95aTdEck5hNCtSeDdGZTlWdEdBZWZGSzdTM21jUUVKcUhn?=
 =?utf-8?B?Nk1tZ0JBQ3p5SXpIaW5FUlJRUzc2MUZEWjNYS3lXVTFRSHNkcHVjVksxcmNV?=
 =?utf-8?B?bDJNQnZHSkFGZy9KL2Y3cHV2T1gyZ2MwdmVYaVpidm85THI0QTlhSC9KZHBn?=
 =?utf-8?B?SDdtblFYa0htRHdPT0JldUxnSkRhODJIR01zckJnbVFYSkR5TzNIZThrelBI?=
 =?utf-8?B?QXh0WEltMEhPUUh2YkFWZWY1dW4xaTdLSkQvRHJPVVBMb2o3c09ibmY2V3M4?=
 =?utf-8?B?SXc1dFNocnFNQ2VhbGlSSFNWcEtlTkt4OVYvemZKN3VwU3p5cjFUOVk1Mlg3?=
 =?utf-8?B?aGlIbFFsd2pod0hNK3ZXM1dzdlhsdy9ZMGVQOW9udk03YnFoOXcrMldKUGt4?=
 =?utf-8?B?NDRXZG9MZFdMRjNTYWpNL0ZhcnJIM1QybDdGa2dJSkMvYmRVQXN1U2tTUm5S?=
 =?utf-8?B?MW9KRFJIYmxsaVRXMUlDVGhQL3FhWmdrMnlrYUl2a1FUM3FwcDVJRy8rek0y?=
 =?utf-8?B?c3k0U09pejh6YWdWOVlsLzY1NFk4WmRUVkpkUG9lc3FIVjRaSy9TV1lHOEJn?=
 =?utf-8?B?Wmd0N2gzU2FrZVBxbWsralV2M09QYm9uRURseXhLTjI5TjYwUEhKVko4Rmcx?=
 =?utf-8?B?WGxxU0QrbzJXT2FFdEpIOFlIczU5UjREQ2dlYWdXNFN6NFQ4VDVsVm5jKzdn?=
 =?utf-8?B?c2lTSkFyUjVQZnVhZGZ3TDYvMzJ6WFZXcXdzaUpTUFAzWWVoemo5REJYYm9y?=
 =?utf-8?B?a2s2a3dTWm9HQy9PMG00L05lS01XbDUvRFU3K0g2Q3k2d3ZDMXRtTGxHcXN6?=
 =?utf-8?B?cFcyWEk5M21KYWJIaFhTTHk2L0NyRWFJdm1iY3hjQnZTd1FGMFAwWWxUNStI?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc2a43b-2cee-436e-7864-08dbaaf6ed55
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 14:22:52.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTrtkRfhqI5fyJft49zm21mS+x0+zXSf71LMYee3Z8TZe+c953mH/kpifYfAIECRHcKonLmBH4g2NfZXpcqBfUh7g5iQ1U9SmcJdFDEH0zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9822
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01.09.2023 16:57, Sabrina Dubroca wrote:
> 2023-09-01, 14:58:12 +0300, Radu Pirea (OSS) wrote:
>> On 01.09.2023 13:07, Sabrina Dubroca wrote:
>>>> (the interface was up before)
>>>> [root@alarm ~]# ip link add link end0 macsec0 type macsec encrypt on
>>>> offload phy
>>>> [root@alarm ~]# ip link set end0 down
>>>> [root@alarm ~]# ip macsec add macsec0 rx port 1 address
>>>> 00:01:be:be:ef:33
>>>> RTNETLINK answers: Operation not supported
>>>
>>> Where does that EOPNOTSUPP come from? nxp_c45_mdo_add_rxsc from this
>>> version of the code can't return that, and macsec_add_rxsc also
>>> shouldn't at this point.
>>
>> This is the source of -EOPNOTSUPP
>> https://elixir.bootlin.com/linux/latest/source/drivers/net/macsec.c#L1928
> 
> Could you check which part of macsec_get_ops is failing? Since
> macsec_newlink with "offload phy" worked, macsec_check_offload
> shouldn't fail, so why does macsec_get_ops return NULL?
> real_dev->phydev was NULL'ed?

This check logical and returns false:
https://elixir.bootlin.com/linux/latest/source/drivers/net/macsec.c#L343

real_dev->phydev was nulled.
The call stack is next:
fec_enet_close -> phy_disconnect -> phy_detach ->
https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy_device.c#L1815

-- 
Radu P.
