Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D729C79DF88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 07:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbjIMFtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 01:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjIMFtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 01:49:24 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F91172A;
        Tue, 12 Sep 2023 22:49:20 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKevIr015233;
        Tue, 12 Sep 2023 22:49:08 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3t2y84shp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 22:49:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVdFog0yzIAnqeh1qFCJCU1B2hHa2QRryfyUVghfuntd4j1PNDj188e/wgVbEzvldbULMBpoV2B1go7XipKpQxVxYVI7CXvSxmhdPNRVxccEY2ubBMhP5erm8CBf1XH+7IAO5gDv7zRNC5WdM7QpSnZcXPVffsEyCHq7d/d8zs02UMYLzzzZfeA3f0/PNJ17UJG3b9c6Imx0b1X9uYpjPNUa6raNNrXYbEoJcZYgg/gVHtCSkYOhzdARmKFmgvbHuOMJGfLmpjkT+E66gyuwfYnsu8Lj3M0UPBQvnd9SCmR8TJCtld9nJhAjTavKBALRPsFZj0r13Edlz+lDKCB+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FV/Mmad6sDNTqqAXOY7biJaTR7cgzc1oCzWwehrwHXw=;
 b=fXWQkty9liwYNQ/FC+netU7/oKogPjwqi3eXCLGfs3Np2gbRi4X4QuJ1Ng82otf4Yb2/HIw0LrN2o91kQOOsk7wnNwbXRxsOpEKa7uGEsifmRSFzdhNAdqRe8CHqPRB9wyEprsM3bUKa89Cot+oTo1GflH6orTnityRcdEaelVhdEP75U8PwLCo/XVInQb/0RDqGT/hQuYX+tCxqBwyp2TaTF8Ap5SIdDFpCl0/qswNtqK0Zx6Y2HICxqhPNi9I4BSehNQR4G5zFOm0JFB5qhv3aic8BIZ0dTmFXP6y3m7Jv5P8aHzL/PZRjANCiiF6UkG2HNQG4L/ef2j6d48AytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV/Mmad6sDNTqqAXOY7biJaTR7cgzc1oCzWwehrwHXw=;
 b=IDyZ0pgigu7LZz3Hr8uTYz88JfCD6uRMpvUsruVHo++hWLkv7xFWj3rKTwGETTtjcBU3UJQHCVl52pxCVnd/+vVFatIjF/aavwInWebiJYsFme1WZEeP07VH7zGVhDDjOt1Hv6IllIZuK/rm6aV2Yi5znCZm2L9ym63EaQbx5l0=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by LV8PR18MB5583.namprd18.prod.outlook.com (2603:10b6:408:18c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Wed, 13 Sep
 2023 05:49:06 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7652:bbbf:784a:bd40]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::7652:bbbf:784a:bd40%6]) with mapi id 15.20.6768.039; Wed, 13 Sep 2023
 05:49:06 +0000
From:   Shinas Rasheed <srasheed@marvell.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>
CC:     Abhijit Ayarekar <aayarekar@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        Haseeb Gani <hgani@marvell.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Satananda Burla <sburla@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>
Subject: Re: [EXT] Re: [net PATCH] octeon_ep: fix tx dma unmap len values in
 SG
Thread-Topic: [EXT] Re: [net PATCH] octeon_ep: fix tx dma unmap len values in
 SG
Thread-Index: AQHZ5UdRCoDe4Am3GUGagew8bCX4RbAW4F6AgAFfmVU=
Date:   Wed, 13 Sep 2023 05:49:05 +0000
Message-ID: <PH0PR18MB47346CADA6D087CB1BF2234CC7F0A@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20230911180113.GA113013@kernel.org>
         <20230912070400.2136431-1-srasheed@marvell.com>
 <2c532d4594ca0cacdc0cfc5d1f5d55d5d758dc1b.camel@redhat.com>
In-Reply-To: <2c532d4594ca0cacdc0cfc5d1f5d55d5d758dc1b.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|LV8PR18MB5583:EE_
x-ms-office365-filtering-correlation-id: 6dd9f494-f814-4446-aae0-08dbb41d2460
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3b3VIkQC2Otsu66F7lkx6ne++IFReGJINcnrV53viPV0ZTKZXKOSS52BUeJSQN8AAXTAEjOsWNuCOZ0Clt4YMg4yXs10YjiVOiwtbaIuQSMMbDfEAGftp3dw/kf9lVHszNUr8YjJpoNfrlN4/Bf4A+QZ3fEbC7q0di4GwM4mv6JxR2dFCXJ1zXQ9ATfkD3UP+5KFif4jWTZ163e3Hi7LMhvjqsM71dZP52OOENY1Cqndp+66jx3D7sfwmxnCHWvu5ncuzhmO/mg22sus+urJM8hypp2+0Ur4JBlem0VnZ9Pjirv/TlqTKtJtO+tjZ/i55ohBFGe/yvioHGUxdi4qnMDbWYEqdQDQ/QF1bMW1r4QGUFJvnCxN2ybda3kAh2qMbBjR0Me29sP+cy+51P151a7ylU9xlPR5cl7xE25zlR4a7BIxO05aDtRBbDgUooAoh/hPcGMfWNgB0dzOfc4VejwjGZpOAnNg1yS8ztxgPqr0L+Sua860E2o8+y7bgVUJ9mUWdtN1mFibr97hNbADsh2xtt717F/2DjK3RXMxyuewedjMlYK21nynZJWHUt+FzLNEM0WZBXwsL0qELkzfrgPLYyx1a/TWG8ALO5ZK7I8n86N9nbkQAP1ISvGG183
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(186009)(1800799009)(451199024)(6506007)(7696005)(41300700001)(54906003)(53546011)(110136005)(91956017)(76116006)(478600001)(2906002)(38070700005)(122000001)(66476007)(33656002)(38100700002)(316002)(64756008)(66446008)(9686003)(86362001)(55016003)(8936002)(26005)(8676002)(52536014)(66946007)(66556008)(4326008)(107886003)(83380400001)(71200400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7jyOmFDSr6dS7fWcibV5wfB6CZTYZpFysCTnWis5OKfvd2WWkQuuTwpsnu?=
 =?iso-8859-1?Q?NCCJrBtncCF4eYk/YVrTosMEAixqbxtKGcGn0uEGSe9/zf6xeptV63drs3?=
 =?iso-8859-1?Q?N0x93iVTeHNuydMutCzoOk6bH7JgTuUzTmVDceIfisf6Hfwj9c4IIDDqXA?=
 =?iso-8859-1?Q?2v2B9QgZkt3ta5OMp+MP6mCsDtVn2i9wkkJ3Ow5kzLXR/QemqdAXsYlK+9?=
 =?iso-8859-1?Q?euIrcw1ZfBE6GYG5C+Y74lNhoKPlwHSJr+dCoXBgydIPmBpAHcAwh+DKyO?=
 =?iso-8859-1?Q?5WIeZgUv2Xp5gIoCoB2n7SMpWoYIxMGJo5s/F1pgwfw+X9Za0QB7f+cTyy?=
 =?iso-8859-1?Q?NREPRMBZP3EcIGKXJdhL9V/Ihnhbml7kIZZHb08ucP+Q4vuDhBJhhpE03I?=
 =?iso-8859-1?Q?YdNK+VqAWESIyDa7jDfORwgHAIXj9aR7O6+0m47F4RChW6RwpIYDB3QnEM?=
 =?iso-8859-1?Q?i36oq7ozXCWIHjo2GRPEL1BCIa8xIqXGi37uzZPRplq1VmOZ03CMyVBJ1Q?=
 =?iso-8859-1?Q?NK6ymX1L98QMXEu/ZAAu8Cu7CMqYvBF05OsNQNxz57+mH9cdgzmCEaVFZX?=
 =?iso-8859-1?Q?MaIFC4FUmd10yVBJYf0v0XDzh3wu6H6kqJwixTOgEWeX1oub4WaOoANf5l?=
 =?iso-8859-1?Q?9l0Z7qdxfdr3fwpJIde4168QQIGfLILPknTvthS/yxI2LE0k0xBwD04X53?=
 =?iso-8859-1?Q?YGU+oGEOEbA/G9oz2IWZ4q+392aHO4I5yN5LyCzBAQFyRgtcJeDL4VSS/3?=
 =?iso-8859-1?Q?EjDCDqRGhv+Ke6f+FhP3Nt0aoylgJwfVy+t6qcYgRcOt+aFyRmOG4tTICP?=
 =?iso-8859-1?Q?abnjMPQIdKl5nrvb9m5AbosTXbzn4eq6byjpdhKz9NhMmg1vn1b/Ovw8Qw?=
 =?iso-8859-1?Q?IpS45fcl3z+DK8e/62eVz7Iwr/UQcs84xMYl7vC0Ntqf3g/5XmC7gwsfA1?=
 =?iso-8859-1?Q?RmhQdZTV3l4MiGo/Z2jVUeEcl71ZpWc5QBLOIoiPFFyuAzQJ/Dz4YCpn+H?=
 =?iso-8859-1?Q?Q+1UZmLVlFHPfRHEgVItqs41YnyNh4EhiPKGbILS+aeXDjzTjNRpWTF4A3?=
 =?iso-8859-1?Q?6ON9Z7DRlM7HknsSYDbX/P5AeLzgqe42iq+lfNq1VrEmhLvmNIslyCAFWV?=
 =?iso-8859-1?Q?rmctdwy85B3lcmk7kLP+7MsmjVHpZ59MVgUiXcSqTZTL5sszug6zhjDapu?=
 =?iso-8859-1?Q?vcaL5z5ByXBMz4o3ug4rXHYarbfiyFcYjnFoDJGsw0xG4bi5wj4UlnTEvp?=
 =?iso-8859-1?Q?u3xMH/TRYqQiINT8suim9sEfBCnej9D6nkwaxTD1a8qv9p5lDTCqLyzJfm?=
 =?iso-8859-1?Q?VpJ5DNVrvxP8q4yIMuph3cFokSvT/ZF1QK5STRlps2qww3na0g3mBwM9w4?=
 =?iso-8859-1?Q?u7XM4LdGDAKWhObrU/DYh5vzHPMFIXWhUj8ZbRsEZdYkZZk07x4dq5zQe5?=
 =?iso-8859-1?Q?EAiHTOo3koYifwvp8pU8zo3U5go5iejecK+LUi8keNsheKlaE4Af6DFZ8I?=
 =?iso-8859-1?Q?5sXFrXk7JuIf0CwYQNTmEk9ysjDFBQ7NENTG2DhZ+HFSq4GFA9sSwgrH5S?=
 =?iso-8859-1?Q?OOQfAZvb391Ea6O93aJXuosDe4bUIHVR9fZV2s9g/rCWFOgEU5jSEh8JW2?=
 =?iso-8859-1?Q?o2SugDuD80XW0nw5ub+Bn3vHTme3D7Y00O?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd9f494-f814-4446-aae0-08dbb41d2460
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 05:49:06.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5193rRvR+EQuGcWWFhIcuS0N+tBVwpa5JG987FWXYesWxf/AUFDA7lzar2+dWF0nMhiBzT6NagD+h6Y+p/R9Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5583
X-Proofpoint-GUID: vPlsLG1RC5j614QlxabSXNJcxcEbsubu
X-Proofpoint-ORIG-GUID: vPlsLG1RC5j614QlxabSXNJcxcEbsubu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo, Hi Simon,=0A=
=0A=
=0A=
From: Paolo Abeni <pabeni@redhat.com>=0A=
Sent: Tuesday, September 12, 2023 2:15 PM=0A=
To: Shinas Rasheed <srasheed@marvell.com>; horms@kernel.org <horms@kernel.o=
rg>=0A=
Cc: Abhijit Ayarekar <aayarekar@marvell.com>; davem@davemloft.net <davem@da=
vemloft.net>; edumazet@google.com <edumazet@google.com>; egallen@redhat.com=
 <egallen@redhat.com>; Haseeb Gani <hgani@marvell.com>; kuba@kernel.org <ku=
ba@kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=
; mschmidt@redhat.com <mschmidt@redhat.com>; netdev@vger.kernel.org <netdev=
@vger.kernel.org>; Satananda Burla <sburla@marvell.com>; Sathesh B Edara <s=
edara@marvell.com>; Veerasenareddy Burru <vburru@marvell.com>; Vimlesh Kuma=
r <vimleshk@marvell.com>=0A=
Subject: [EXT] Re: [net PATCH] octeon_ep: fix tx dma unmap len values in SG=
 =0A=
=A0=0A=
External Email=0A=
=0A=
----------------------------------------------------------------------=0A=
=0A=
=0A=
>I guess Simon intended asking about octep_iq_free_pending(), and AFAICT=0A=
your reply confirm that the change is required there, too.=0A=
=0A=
You are correct in that the change is also required in octep_iq_free_pendin=
g as well. Thanks for pointing that out!=0A=
I will submit another version of this patchset including that.=0A=
=0A=
>Additionally the changelog really need to be expanded. I don't=0A=
understand how this change relates to endianess: if the ring format is=0A=
big endian I expect some be16_to_cpu(len) instead of complement-to-4 of=0A=
indexes.=0A=
=0A=
=0A=
The bytes are in itself not big endian, but rather the each of the 16 bytes=
 are kept in memory in=0A=
a kind of big-endian order. Apologizing for the confusion.=0A=
=0A=
63              48 47             32  31           16 15       0=0A=
|      Len0       |     Len1         |   Len2         |   Len3  |=0A=
=0A=
I shall provide an ascii figure like above in the code to explain and also =
update the changelog accordingly. Thanks for your time!=
