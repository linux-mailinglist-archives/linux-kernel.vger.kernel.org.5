Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5344776DF17
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjHCDjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHCDjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:39:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9612719;
        Wed,  2 Aug 2023 20:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691033983; x=1722569983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N7bDdfAd9kscOME6a8bL1AeAOwDy25qj29gDRpSQt/g=;
  b=Bggp0Ahgkd9DJ3iWzIwYguQTucPSa+ktyUwWlJxmQR60n3tu7izHGBm2
   SDiQOrC1L3Sxe4ffzUIES16A1lv5HhXHpNqPuVXB0lzvPUQOAMbpUMBgZ
   gW1nzeMA7ZVnBU10M204Aoho2f0bRzPOvJb9tRjg2PSgX6vUYJnY3BFgw
   PVFSqAoDrdduoCcXf6pn6g3GoK5ANy5ARsCxzJOs+9o4BvhzbgGby2v2F
   MdnVJkbdPx1egiOT9+qABlwsa1GVfIN8wAoNipkoe92v1CrJD8KNkpDcI
   HY9BywGLBfikzWaC17U4mRBqmRW66k+KAlR+R4+vve1CwDfl/GckyeH35
   g==;
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="227719827"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 20:39:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 20:39:37 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 2 Aug 2023 20:39:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7deCk+USxDomjtr2wTLDjpsdh7ISxtpBhiStqmwajzA6VNd1+kxfBu6N0NR4P5prOog182UK1iFPXAPsJf37lqLvR7ajE1z/RSGJJgbWrOt3fc1NCZVYDn/gSymT3rADPCNb3fuFT6XDe5mlyWfssdO91I8G6q5eRpSguWGOVe/HIfjdIfcJ28iJfcagX1Cbiz+I3lBK/POzAK28tTBJJ6iDJbrHw0/NqZUvf1PU6v4gQHSK7DHLGPG0UjS1EH0rXCTNmSelrI1hTXLvlhL5JwLLYcCYd1o5LXyZOUIMNJXl+2P6wqsOP9Zq48EFNMGCFtyo1ygAfm4UHO9bj3oDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7bDdfAd9kscOME6a8bL1AeAOwDy25qj29gDRpSQt/g=;
 b=IUk8B9V9oYMU/Udt4EdZZvuM0lpIpIQZekaALymHxt+/ajms7RpG9ieAvo3qROVojVaPhSTAx37CBFgAamYwo+WkUdN2+E8Zpk8o0q/NWFQ0ZvVhju0YyokhdgWMQVz5gYHzJd4obvdYDu8x7B+4BRLdUS9zRwkYZCysLidO9jIhmsYMlL/6KZ0Khz8wEB/TyLIRm4MSLfjhDoSfAdHg2eSJ7UjF5ierB9Ma4OMBhfyRADLgXZtA70dt59wVSE1+lPpenxczaaQ0wBLFzY/nzCZiX3XvcH8nEXrJJ/pXTnuzy2jZ8KjYQnNtz1OPV9Vl9Oz8tGZ0vv2P8rI4TyXUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7bDdfAd9kscOME6a8bL1AeAOwDy25qj29gDRpSQt/g=;
 b=sxmIoSuHtxacFl4EZxhKPd9jTxh2o/h8Pl1B/rSI+kL5zqRxiGc6zBzHQeHHwTk4N7Tf2p2iQ7ct2icudWqIcT9MGjT7m8lYIS6iIYkCCCjeHb28bHvFbezMTnb5d1ILaThs2WFGJMPwqNv9abAPm1rNjFvu8YN2m7FTQ3auL6k=
Received: from SN6PR11MB3341.namprd11.prod.outlook.com (2603:10b6:805:bc::27)
 by BL3PR11MB6506.namprd11.prod.outlook.com (2603:10b6:208:38d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 03:39:34 +0000
Received: from SN6PR11MB3341.namprd11.prod.outlook.com
 ([fe80::f71d:7e80:690d:ee1c]) by SN6PR11MB3341.namprd11.prod.outlook.com
 ([fe80::f71d:7e80:690d:ee1c%7]) with mapi id 15.20.6631.026; Thu, 3 Aug 2023
 03:39:34 +0000
From:   <VishvambarPanth.S@microchip.com>
To:     <richardcochran@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: RE: [PATCH net-next] net: lan743x: skip timestamping for non-PTP
 packets
Thread-Topic: [PATCH net-next] net: lan743x: skip timestamping for non-PTP
 packets
Thread-Index: AQHZw2rbMPoDf41Sy0CTnd7RT703zq/T5UkAgAK7ffA=
Date:   Thu, 3 Aug 2023 03:39:34 +0000
Message-ID: <SN6PR11MB3341B905C5D5705205A4D839EC08A@SN6PR11MB3341.namprd11.prod.outlook.com>
References: <20230731125418.75140-1-vishvambarpanth.s@microchip.com>
 <ZMe8To+Rw0/pcjLv@hoboy.vegasvil.org>
In-Reply-To: <ZMe8To+Rw0/pcjLv@hoboy.vegasvil.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3341:EE_|BL3PR11MB6506:EE_
x-ms-office365-filtering-correlation-id: 8504b372-d21a-40ff-c94a-08db93d34118
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BS57fVTfA+8Go/7YoZLxHk7Wn5oe8VObNFllmU0iPOrkgD7LFYvwHKATaKRLSUibvxY44ElGk+CngpZuWdHASQqCWRXzd7V7bVnNOCri6dByx2BE08e/GXCBqeCr++HqmNs8zyYzol0fUvide3TWeORzRNj1PJ6UNKDnfpTZ0YU1LHeaDKoPPgEw5TgXWZlCTU6VqpgaBSx/2Aa965mIefd/OJvjqg9dh0OEvK0eKWGVTbgKUjYj8uHHNJf3fwbF857imvprk4iBAyVS3/02KJUestyEDk+K3t+5AHGEBiU6U+KQCjxNN5dli5JbHgi74HgYUjeWpCLSTPLMK4gTUMdKVS6JKOPCXHW4fWAZ8JE3Qn59KaZ7w86KS6gMaYqtrqUjwlKGYVQyIITP8VTTW/alSFfcko3TcbE3m/FDLB+69BBdCB9C0Dv4tnrmGxBt5KmnB3B3liVW6+tU8BOjnIDPMwC4h7vHeFytwLZvMtJuMsPVwJpRXPTZ3n6xSQqrrBiLMWEqPHalT4750fM+12HNjspCsPYccIZTTA+SkHNHu+S0fEZX3eciGWF8+0uxJ0tIEsx5tY7d7qFYOABc+D3OJi/4NGMIygxPuc52MLwvaW0xD155uzNFOroLcaj0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(41300700001)(316002)(4326008)(2906002)(6916009)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(52536014)(8676002)(8936002)(5660300002)(54906003)(122000001)(38100700002)(33656002)(26005)(6506007)(53546011)(186003)(38070700005)(86362001)(83380400001)(9686003)(478600001)(7696005)(71200400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MU5z/WoMW6BBCi1Jd6PLJ4fEiTmW8ChgsnXOx29u5LoqwW85CuNs09RMniZ+?=
 =?us-ascii?Q?v8Vcqbc9hIN2qtiS6yulp5HFqAkbbWCTMh8r+uUdxyML8lstGxX5swOWRslU?=
 =?us-ascii?Q?ps5FFRPGT6aQmBL8J9czOlh5mwPdSRCjO3NeKdOvvc/aNlZJd0B6CXZhPrTX?=
 =?us-ascii?Q?TH9YUsYmExTkePXmpwBdnnUMub1TiD5JAd0s7AftgqmfmGXIPK3kZpBSjN7N?=
 =?us-ascii?Q?IF99QtK6BzWMjGI0FJQogYYDTEeb3CW8WR6T4mFWGvaubDyQbpyOZelJzdti?=
 =?us-ascii?Q?hcFdnMnwW1igQZ380qRLhYMvRn6o/RuhxSlB5O1q+M0dv/XNH6T+pVYsdyr8?=
 =?us-ascii?Q?em2e/WgcWUUDw+bwtS4f9/g6uk4LHOa0HDiMUdoweDIqCrw1Gym4kzIcorMm?=
 =?us-ascii?Q?jtqN/Gw1qy2loE4JwX+HMhaYCQEz9Eov05HSsiPbb67ucmGEtd/PXUQ3KHJG?=
 =?us-ascii?Q?GQySiyWFo+Yv92PfrUVv9f3fppY3cgyJKa7zkzTtvu/0Pzg2bvObvWVo4RhF?=
 =?us-ascii?Q?wu66sC6C3mdef9u4DObqbukS+PfYuOSWCouBs4Ey2gkOWOkhBTPpbEPlsACG?=
 =?us-ascii?Q?mkBMbI3i2xohd0gVZinERpA2E9mqc9rnspyBg0DcgIe4Il7bYx51E6eFYCwy?=
 =?us-ascii?Q?yqDXKUrCA11bEyZ3P8e1yvbcwRiMK3KoPFmdXEH/p8M6KqrB5iycPUGsiCSG?=
 =?us-ascii?Q?ZKvHsI2krLI/BRqK49aU89bBPUGq33FKF1eIbH2r3iIYGitSBnoQZyNiJy38?=
 =?us-ascii?Q?9XzaBH8ITfP/emC4lWvZ5b8O+HpoecOuhM2qnzKB7raOVJeceDok5RVopFeJ?=
 =?us-ascii?Q?ZQkvmcVqRGPajPffQMwIU+RSYsX+VG/UPFXSUxYMwB8eIoTVCJrPeKc4W9jz?=
 =?us-ascii?Q?FT+T2H2AeA3ms5pMgea+l2NYv515UCJ7dVf9Vm8wv6R/nvMPUqxSO0RWu2Il?=
 =?us-ascii?Q?LMqRHZxNI8R2gyry2sJccBfvEMOjGI7jrOKBmYXxyY87JuB2aLtjMz5At8Gq?=
 =?us-ascii?Q?3W35m0A0mPgzP+Tm/7SHXo92op+ICxupqMKZoPMXIwaM+MegqWwl0qtSxP2b?=
 =?us-ascii?Q?wZkBAs2oPkaPUmId4q5eUvpRF5QWiqLHB66oxxJGiwrXkETgO4W0gSpNPDIm?=
 =?us-ascii?Q?82TM7x7FzXKP/H41gT+2mXVBVAesVw0tza1dYQ54YO99+uh/DEIZ4V5gz8f9?=
 =?us-ascii?Q?8KdVCej2daiLG0TriA73dczhzFCOKVxbzEk4wpT10Z7cQ/VcLPbh3F9mgM38?=
 =?us-ascii?Q?Fveebq7kuB1h/URlZnENazewiMsSw7eAiKy2X/DWU/K/4i64IE1q6+oDMnVW?=
 =?us-ascii?Q?KloV04hSes5rNF0eZwcpx11PmmcyvijWNTTOj1i4G6pGI43JCUGVsazxil6g?=
 =?us-ascii?Q?it1+gOIPMEYYZeZ/HGu0mL+K5jXNi7drppKp89LaBsAnwMWozbgJg/japm+w?=
 =?us-ascii?Q?96+SBhNd8q1i7mEceQT76LgS3T6i4AwqUdQPMu4VbtSvHT/vGzLZR9lDuURw?=
 =?us-ascii?Q?E2RpbzQ1WiYQZHLszyKxjW9Zgbr8kEjoIivRRmEtXvEZfOOGwGCuO7dMbvvR?=
 =?us-ascii?Q?7livvQSmx4Yc1u1MbNBlvm8Es+/c9z4MxYNEqh5jsRtXm0zyEhbD0K9x2G2I?=
 =?us-ascii?Q?3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3341.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8504b372-d21a-40ff-c94a-08db93d34118
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 03:39:34.2244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fz9UVyke226dHaGvtjafTo31Rw5M8i16qNPJEeP7Hay7pXjmeN57124zsygGD7ZXLllBMWuHywKONpSqR/SNZee2VvGKg1GOAHhDdIl2Wq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6506
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

Thanks for your review comments.=20
We will work on configuring timestamp based on hwtstamp_config. We will upd=
ate in the next patch submission.=20

Thanks,
Vishvambar Panth S

-----Original Message-----
From: Richard Cochran <richardcochran@gmail.com>=20
Sent: Monday, July 31, 2023 7:21 PM
To: VishvambarPanth S - I69108 <VishvambarPanth.S@microchip.com>
Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Bryan Whitehead -=
 C21958 <Bryan.Whitehead@microchip.com>; UNGLinuxDriver <UNGLinuxDriver@mic=
rochip.com>; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pab=
eni@redhat.com
Subject: Re: [PATCH net-next] net: lan743x: skip timestamping for non-PTP p=
ackets

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

On Mon, Jul 31, 2023 at 06:24:18PM +0530, Vishvambar Panth S wrote:
> Currently all the RX packets are timestamped and the timestamp is=20
> appended to the RX packet for processing, this reduces RX throughput.=20
> This can be optimized by timestamping packets only when the PTP messages =
are received.

No, you should not do this unconditionally.

Instead, you need to dial the correct setting based on the hwtstamp_config =
in lan743x_ptp_ioctl().

Thanks,
Richard
