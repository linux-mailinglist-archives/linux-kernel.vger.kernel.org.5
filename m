Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB87D7DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344490AbjJZH6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZH6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:58:12 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC47C1;
        Thu, 26 Oct 2023 00:58:10 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q71eRQ017512;
        Thu, 26 Oct 2023 00:57:58 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3txcsr192x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 00:57:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jazt09B7AUWzasEm2+qtiLC7QXUb8CY20S+b1KI2sAq5OCTUti549wVZkYsejPgI6abUHk6Th8iiifrbUNYWvCIivMfisdL2uhIpQev+y/QnEFTicvvNDBVr9HGy7bGYeY4NGhDXGunnnl95qtaOTpW8tjCw9FRJ6JPeOkpkYQiZa5BDFBnNKwgKXnFgoa1UB2xYkzYn5eb80kYm+Stnf9EEBzApVfQHIoIxy3SC1OIoOXas2jMYiHOnQImNn0cz48Urslwt1e+N4e3ygSB0YD/0U+xAp37gyHIW/0mW4yBFLkmGZYPwCA0VJyAUExQr+cVa+88HxSPl7IqTTkiGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4MP/pU+qtdPQKEyTe0gtIvlrjDhYVfuIx5MZS6qIRg=;
 b=WqeGihBUDpKxHi0IzQNz1QkS2bOPQRjoXHOvrMi8Y77GeZJpQvKW7MyfuW4k7IsOlWBDSaogYGRYrmwIuyS2QvE+BrkNiNkfpuSEF629hoCK8aUZzjcdY/Zqo7DsAfs6gLvlVmidlwMFEBvyysQH8g7dwHqnpF1tOnH/p6KCmrFaKKv9QyrcqCANaVHi9SJu1U7WiXaOkyb2MxbuVVIvNQPy6RGJao3soG9ixnaOTXc2nOtJQ9UlDWe9aT6EgdUF2J/i545UEA3TJ4XAGZoZHHa1eXdAaQmM8U72W9vSzFgDUBPlr4RiDsAT5zZa0p5hLMBbY8XPsMoXXWlmHmy3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4MP/pU+qtdPQKEyTe0gtIvlrjDhYVfuIx5MZS6qIRg=;
 b=qWGcZ+oPZ0TyYVaGj7dy0ogNLqJfmnvbod84vvHvoWGwDpmwG8Jz9MH0Nxe61TN01T3b2hZWyiDiitX/cTvJDw9g06cOLXmTCT4cntdlR5ve5ewerzsF5/CvensG4lR7ZllkJEdbr6edMjDi36AFOb8G1H5Zr2CHc4CdU354GXg=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by MN2PR18MB3448.namprd18.prod.outlook.com (2603:10b6:208:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 07:57:54 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7c0a:5ded:25e9:7fa2]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7c0a:5ded:25e9:7fa2%6]) with mapi id 15.20.6907.028; Thu, 26 Oct 2023
 07:57:54 +0000
From:   Shinas Rasheed <srasheed@marvell.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [EXT] Re: [PATCH net-next v2 3/4] octeon_ep: implement xmit_more
 in transmit
Thread-Topic: [EXT] Re: [PATCH net-next v2 3/4] octeon_ep: implement xmit_more
 in transmit
Thread-Index: AQHaBomdyCzd/AB+BUOLdgCH/VlJFbBZpWyAgAIItnI=
Date:   Thu, 26 Oct 2023 07:57:54 +0000
Message-ID: <PH0PR18MB473482180622D7C163B487ADC7DDA@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231024145119.2366588-1-srasheed@marvell.com>
        <20231024145119.2366588-4-srasheed@marvell.com>
 <20231024172151.5fd1b29a@kernel.org>
In-Reply-To: <20231024172151.5fd1b29a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|MN2PR18MB3448:EE_
x-ms-office365-filtering-correlation-id: a70e74f8-d5fe-4a86-0d56-08dbd5f94280
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RWlfzYW+BdOSzUtyCZkgPfDm0G9cf820x83893RkGGlWmJ5rwSW82Pi2X9Rqk58Lqq0bpBf75KA1EdvqJ9+CndrwY56A+0ZTEkeI395SOEX9JkOjjOUwsbHH8HluhFfhA2Vy7ZFKh9Xr/uJQcWfZNqcEzvVnFZpu392cOuitJkVgLdSSxaV1Ih2NhTjqzwbKbH3NDjMMz3bTdeKkuJxgmo5+oR3vACZfPn0tr7sut1GhMGnZ8GJGBfFpWZX5L8N1Hz0YJfSrh5AuT5C9QnZm5llNuGBATeO595HxPad7bTRE6f+qFv2fM2pYOLV6P7i7I7YOdaX+t6LR2MxtcDuDVQT4wetiXUXmL6boMZsjUowqfMv7r8B7E921mT7eXwrEtDPp6tagRjVIdZBA5g8qNJraGpI8babvB159TvPdix4AscTxVQ9b9hdp/BzmsoBvAKmvYn0FhIgNCIElrbEKeDxDhu/g6YFyci2KCh3QaSb9xU/oWJkN9enPHOycEje6pd08uLO6UIOed17CTJD4O5QHA7icHSAkeZ82WGbTh9vjEj9Duw/K6/OSeRSWL6t8V0XQIdcAB9dNyKx+wT7OV5etQEyh4R1xoEb3FE1DN3o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(33656002)(38100700002)(2906002)(86362001)(83380400001)(7416002)(5660300002)(55016003)(9686003)(41300700001)(122000001)(91956017)(316002)(66556008)(66476007)(66446008)(64756008)(54906003)(6916009)(66946007)(76116006)(52536014)(71200400001)(7696005)(6506007)(38070700009)(966005)(8676002)(26005)(478600001)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v9rGrA/o/UxVlp6sp1iVJf0P8vm68gkzp99/Xi4lM95uTvQX+BYqB4SpwD?=
 =?iso-8859-1?Q?75texC5hcmdjvLoPb5XSLZF63qiMTUbVkfDUi6E1HieOdyTQFIhtJ6l+dE?=
 =?iso-8859-1?Q?eK32TJCgI/B0wdn63gOoJQ3db/vrB4qBAnu6QVVtJmMOLd2gUkaiN9MGOM?=
 =?iso-8859-1?Q?3N+d8ktdZV6S0cn+kjyi8RxNkhY6QLM5rrMcWg6ztWdn4mZBkdz1l7BEih?=
 =?iso-8859-1?Q?JTzEk216LzH1aMpZgOxke7ZF+qBdXlayOfp47l4WVhCWgqrzBeuSLRWBtJ?=
 =?iso-8859-1?Q?vL+6LfLK0Lybwuo92eFesvYkQa5Y8eh2ZlV98Nb+z6p7gj8xQRRevv0AqY?=
 =?iso-8859-1?Q?gGAtfvCyRvvSDau8ezY+wq2mPGhKQE01SOv3lrAVnsIMR0YZmayvcnWZ3V?=
 =?iso-8859-1?Q?QdoRhyizWA7AAF7NQmfDAgwfqyXO7sSlE999dvTJcAl4K0Jin86X9M3CoZ?=
 =?iso-8859-1?Q?FU6ihrxuHYs3Gnaa7gSbEaoU8ruWP30RoWAmy0wnRqDmvCYQb9X53N5uZR?=
 =?iso-8859-1?Q?zFRmF2O2fkqNGoQpRN2/teBrSEggfKGYV5K9QyludabG6yu7r+czeBdWUD?=
 =?iso-8859-1?Q?OTMdfRhFQNiZCfftXVZpEpMSiP36BXhw5OXZz5xyhnFQUyu6LoA6zOdOsY?=
 =?iso-8859-1?Q?Wd7JK2J10oeIlqaZ/8vze/X3BCSz55gM6+pF0cRfQpM/CR5Zo/PD2H7A+o?=
 =?iso-8859-1?Q?L+n3IAqj8uoGkSKYODEyEIenS61rOztB2gidc+MrlZeKtQjWZD4i3NBr1S?=
 =?iso-8859-1?Q?Ic3OQoIeC+lE+eSia5FUZHdBXYKKwXo3vYpFrLxdJL5+bZueKt02PjQnEw?=
 =?iso-8859-1?Q?R5BCBLwSkxQfMKtxRw5Zw2shAFEmpw/E6n8835ZAdcVKd1h3VsJ+O75b+K?=
 =?iso-8859-1?Q?iRTGUPFEQ5QNRcO9EFWhItkczeJ7eKrjNAt0E9VUkchanLHI4QMeq50MDx?=
 =?iso-8859-1?Q?6OhxB5ONxUsWylXinhdTAFUE5yrUFllXV9fIXfo3jni16ILkUY/XZJYn5d?=
 =?iso-8859-1?Q?MHLp8jMaDd5wC2oJClkHVvjFmk1PxsMMAnmNHolVdIo9kx6DWoEO1zy5OT?=
 =?iso-8859-1?Q?bucB8TIHVc+kD4NTsb1e23SBL+rvSLmsAzxlWqGQZ+sFXN7s0+VCZpC55g?=
 =?iso-8859-1?Q?dBU3MPftOw2J1S8+prB/D+tZqdWH+sIgiPvUqRgtAUXViA98RICmSTTbIu?=
 =?iso-8859-1?Q?ygy/OAxQiKg71oCLMNoj39rRh24c75pihcZteVabWqpB4WuLiTIsJVT+s5?=
 =?iso-8859-1?Q?ITo9vW2JVAnGo2WFUBB19ThCkTh83TytJ/SfzdxgOOArYQXAsI34XbTlw+?=
 =?iso-8859-1?Q?xcpWj+tOMwfRZ44cYEBUY2zGXX9CVHZQ3jxGYvyASWb/WwYfHkJAwQKh0x?=
 =?iso-8859-1?Q?sjrt17Qzu8VC1l1yVNQQZAzM5ql/c7MayWviOQX+FdHlGIADuD/0wUcsTB?=
 =?iso-8859-1?Q?ftkUBXIqEG1oO1I7r2uOPTmb0bZrn1u8rkbEcBRAeCx8P5p87Cj9+SpK4N?=
 =?iso-8859-1?Q?QMqL35Lux/p5qA6dgrZZjCHcXaF6UEx9L+GcIT92d4bREbs2OIvAHKuNTk?=
 =?iso-8859-1?Q?YfmZ8dczUz1UAOk3Wuc42wQ2ByPvHHJVjzVFf00poSedlV+A7jLnySnb/S?=
 =?iso-8859-1?Q?ElfWHExxzKY4qvx/1jHFZPIzUposG+IaQj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70e74f8-d5fe-4a86-0d56-08dbd5f94280
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 07:57:54.2179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bm+eW6YkER5BOdqI0Zpj1Amis8K1wfibKBdKpBRA6K5PK+1WoNxmWr+jw1r5YFTa7speKtUjvS9usq7DFOvlmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3448
X-Proofpoint-ORIG-GUID: lyTk-Yp96H07jbSPMIGo1EMpd9CD1hsT
X-Proofpoint-GUID: lyTk-Yp96H07jbSPMIGo1EMpd9CD1hsT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_05,2023-10-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub, =0A=
=0A=
Again, thanks for your review.=0A=
=0A=
> Does this guarantee that a full-sized skb can be accommodated?=0A=
>> I assume by full-sized skb you mean a non-linear skb with MAX_SG_FRAGS e=
lements in frags array.  Yes, this can be accommodated and the hardware use=
s separate SG list memory to siphon these skb frags instead of obtaining th=
em from the same tx hardware queue. What I'm trying to say is, this means t=
hat a single tx descriptor will be enough for a full-sized skb as well, as =
hardware can pick up SG frags from separate memory and doesn't require sepa=
rate descriptors.=0A=
=0A=
>If so - consider stopping stopping the queue when the condition is not tru=
e.=0A=
>> We do stop the queue if tx queue is full, as in octep_iq_full_check earl=
ier on.=0A=
=0A=
>The recommended way of implementing 'driver flow control'=0A=
is to stop the queue once next packet may not fit, and then use=0A=
netif_xmit_stopped() when deciding whether we need to flush or we can=0A=
trust xmit_more. see =0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.kernel.org_doc_h=
tml_next_networking_driver.html-23transmit-2Dpath-2Dguidelines&d=3DDwICAg&c=
=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D1OxLD4y-oxrlgQ1rjXgWtmLz1pnaDjD96sDq-cKUwK4&m=
=3DFyJHTb5Z2u9DTFSYPU38S5kPcP5KvwGWzY-DPcqOl1gdnm7ToZhTFpyvhLMqh1hd&s=3DdBM=
mwfWKAi0UH3nrz7j9kYnAodDjuN3LZ5tC2aL_Prs&e=3D =0A=
=0A=
>> In the skeleton code above, as I understand each tx desc holds a skb fra=
g and hence there can be possibility of receiving a full-sized skb, stoppin=
g the queue but on receiving another normal skb we should observe our queue=
 to be stopped. This doesn't arise in our case as even if the skb is full-s=
ized, it will only use a single tx descriptor so we can be sure if queue ha=
s been stopped, the write index will only be updated once posted (and read)=
 tx descriptors are processed in napi context and queues awoken.=0A=
=0A=
Please correct me if I'm wrong anywhere (sorry if so) to further my underst=
anding, and again thanks for your time!=
