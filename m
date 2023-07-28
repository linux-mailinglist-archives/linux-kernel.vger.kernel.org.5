Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758047666E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbjG1IWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjG1IWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:22:06 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925EE3C38;
        Fri, 28 Jul 2023 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690532459; x=1722068459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cBdvg0VOmnJEtDtAzdfUuqPh8cDdGK098Ve/cyyOmRE=;
  b=JK/2UkFDgZfj4wjT4aGYYY2G6OB5b1RPkzziSDiLYAnit6qPkqsqfNrq
   Py637xsKYQVZCS8Rthj2dPjoxT/mzdXwVTieLiJakNKytpMHuTLPPYEMt
   q+I/n9DZnyDmP/17asdcua9fA2B8bLe/2fOmJznp2zcclyypvUIK2ULks
   FV3XdEHCuC2EkD9VqzqAq0cH5iP/Qqvjejme8/UVdl/24CQHFJoje/DiQ
   0yVIv71GI0UxDxYYjgTi+Ujk3Di61jkthpTDdBA74KR6XAwX5WWKrHhTE
   oaJw4eIDVz9zfjD205b4hDVg8/GMZjN9+kse2qliaB/DDAHLGHE27H+Jb
   g==;
X-IronPort-AV: E=Sophos;i="6.01,236,1684771200"; 
   d="scan'208";a="344470862"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 16:20:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKvel9V3c/Dkgjt10OaD2XBDMksiM8sZdEcdb+BPoieyqgROIkA/W9znmwN0K4Rpy7EH6n0/UJoGEkGUe/KIwaND7hSYH06KFMnO8JdqZcTr1um82NDsW94VFaqCmyCoSuVol/XzmG13PfkiMO/MSua5EqOoiAujatSdCqqth3uudHnqBMJWCcMfKK3A7rwWOn0UNu5CJ0h96Xpgj+nCW93s+hFODi1jZpJNeAig5SQEeyuSLZkC87YC/UZ8dW3hyUq9plkKoeKFlwKSeBJFBfIY0AqkvURrHEfqVokl44CHWTLaG1/U3mqDmC3vGuwIyR48ocwIdY6ebh//OSumWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBdvg0VOmnJEtDtAzdfUuqPh8cDdGK098Ve/cyyOmRE=;
 b=aDYHlEkq519MDK62Zu7F8seH12HC1sP/UkapNkwWAF7OuYow/n/HS2W5h1NIRlgCcDLUAlKo5Iqj/IH4Rx6zMwYb4ihdkxKY2fWxtnTFShC0gwGph/IZuwh4oldUP7M/z3HRYWvRcUeBBly7WTHetIv0YF8rCJ6fKDkmdTfbiAJxgILLrEhcNrg+FZ/1UJB5x1GZEbYkFRjVaGsTt1v4y4IUjB0rJB5wVJMSHfeY192uJCVuV+jPmucpuS3lkPKXZfAJIUAYZl1li1weFuVtF6A9LOQCG53hc6V3+cb2+1ze07/+yKNdUswbIJiaKzXQWz83WmeEiVUZYYV9+J1mWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBdvg0VOmnJEtDtAzdfUuqPh8cDdGK098Ve/cyyOmRE=;
 b=YN3JW4wbjYcCeFaqJ4/CZPxfiVpTmpasJUXJo5YSHRUAjEQfGnHmzvdFHSmlk+2VWeOWR8l/S1Zy4k5+yCnkTHHWPTxoXgYiBfp8RYlVHo8fg16yQ3N8XnhSRol4QRYOhh480ZA2n53os2AMjArirrXQTcWkwT/42UPqQfemRig=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN0PR04MB8173.namprd04.prod.outlook.com (2603:10b6:408:15c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 08:20:56 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:20:55 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v1 00/11] Switch to allowed_host
Thread-Topic: [PATCH blktests v1 00/11] Switch to allowed_host
Thread-Index: AQHZv79H0kZo7ej1zEeDwLGQZvn0C6/O2VsA
Date:   Fri, 28 Jul 2023 08:20:55 +0000
Message-ID: <hqi4yxhc3jc7v7ywf5qvy3u2th676irollqngbsh62rrlitkyy@rhl6axqsve5s>
References: <20230726124644.12619-1-dwagner@suse.de>
In-Reply-To: <20230726124644.12619-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN0PR04MB8173:EE_
x-ms-office365-filtering-correlation-id: 33b2e2b9-71c9-4d59-5d4b-08db8f4390bd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sBhvsvbNMQVnbwWaLU5q1KfkEN8QwdOm6yYWcmxDb2VzAOJohGLn1JwU2LoXM8nhhHO7wfWygXvWp09Q9Nh5Mrexx3YzhFOElLsB4n/TDdCkGC/x5xVhFsB5Hv8Cs/MKDzvxFviq/HI9/f2uwAUwSB6koiNS5xpmVDsZrSFH9IuB+E5lyljhBM2jiGykHjyUBrQHdwHBi/FctxS+5+B18CpRpBS+906W5vt8MzO+NjK7b/zaLQDJmeOvHstBQnI81eUHxoM/pQfNAq9x1RWkO4xWY9z0g3i5/1MH6QM4ZirR2CfYScsdsSG9g+M3PozApansWEew3PxNdwoVYhzGXb6RXpc5pE4Q4n5v5Oapag559OjN7jYoPDBoa4oDzK0bl46Aaz6aych56g3ABLjv3ihDzz7UkS5VUYkJiXd6yv6P4sNl7+TI0SfZ8gDKtUeuc26ZNaMPrVnvvM36VXaH0iEJIzYWUBbFdqgMx284TxNPVwghlQE2kKIqmDgRr+uS+ForQNODE1vd+fFD429IsC/ZAxa2Par7uFa16MNDyim1NI8rPaeFkfiIc1sPyEvosyVlWTUrkhUUQM/gPqifgSuSR1SkEv7g0gC5mdGd3T555ATB4dcBK8accnqWYMC9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(9686003)(478600001)(54906003)(6512007)(6486002)(6506007)(71200400001)(66476007)(6916009)(26005)(2906002)(66556008)(66446008)(33716001)(8936002)(316002)(91956017)(76116006)(8676002)(5660300002)(41300700001)(44832011)(66946007)(82960400001)(64756008)(38100700002)(122000001)(86362001)(38070700005)(83380400001)(4326008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hYMFnLrvW43PgdfSJyI4Um4CQ7eRcrZGJNBpi4Un6GiZ0bpkhDb6BroJtoKO?=
 =?us-ascii?Q?d9k26ymFoIFF6H0lqvqiu2mzgzDJ/EPE56TWLjqEWkj3oPPrYcd12kpvA2dg?=
 =?us-ascii?Q?TlbHjx3sooUydzaPR8g0ivNL92GCqWfTOzvQLCCeOPuSFiXxCcMiivVJ9o7s?=
 =?us-ascii?Q?Fc13M5iXnrFytOhibn7DnYWfkA3zjfaN8U3Z/zSnVXx703Dbx+s6LK6C9YuY?=
 =?us-ascii?Q?azkkLERci8gduzwAZ/CNzVYfFYX8AXHiToPtq/Hlc5VNQ+WACtNoRdUEtVs3?=
 =?us-ascii?Q?exeKwiZCLHgtADakEbfi8YIe7xhOoubPb8sWc6lDZ/qydwNeojyQNFIIy8ss?=
 =?us-ascii?Q?4jeVqPn4aoFbQdjsJKlzSsTmPadkNpnjT1RJ0uXxtP6TQTksYYWiE/NFiYz7?=
 =?us-ascii?Q?cEex7raAdoLlahtXa8g2KUBP3V2JSqIu/5DcMNQ4A9Lhoh0wLtmGVnVNGDpd?=
 =?us-ascii?Q?yFb2QtCeXUPW3Egzsgml8SE4jnPQiqztJgiQEIdC/u5Lg4Mf0Ur14n2L0Npk?=
 =?us-ascii?Q?w8a9iSZhCvhVFoChGqrfqtumw64QJM9JNUzv2Lk1NBnKeazckNkoIVYCSBSz?=
 =?us-ascii?Q?mS6idCX3hGzflmooownpadqiZHqkG2MBmalVljRaNO0hglGR988UXBWNHTcc?=
 =?us-ascii?Q?j0Ozik6KU2UplJ79RNq0Lw9UgTujxqP8fdFEIjOmZR3IULZJrEskyRbW7Y9a?=
 =?us-ascii?Q?peLArLtxdtYgyK/Z2sCl2iB/E8FOpPzApkbAgRdLj6T6vbsjJzIyEab6OKdq?=
 =?us-ascii?Q?Mkrt1hjeln9IL7q7xrO2ZNTFA+5LQA1ypSFaJKYm4CjGOQn44qshn1JHWG0c?=
 =?us-ascii?Q?CKBe5Pte6OC09Ni9wf72Fx2AT9FjUVcs52IKumpsuWmriQmnkkiAEiUUWFer?=
 =?us-ascii?Q?o0VBOFH7OEdOXlPMfHYwVDhwmTxcmxyZnW4BXk/I8ZMneRy8vfX/7MDgFQ0p?=
 =?us-ascii?Q?j3NPDqEk5QW5Ph1H/tF7dk4GR9si2mEBDQetQJk9YAHBDM9Gi2E/XMIQrdU2?=
 =?us-ascii?Q?m1KX/voUnW1vrsQAlPl1ju/MOvBaV0QWTgvXCYLcclR/e4nfJp59DNCbY/dn?=
 =?us-ascii?Q?sEq+1rhxkZ00P+2klhzNNXsH78apIltg7rnsOhP5OVx3OSaHZ6mIykWtJmtB?=
 =?us-ascii?Q?AypTALxO01qwWisniv6xTSszuRVoBkZYv5ch2+OqUdAcK7spj7yfxriBGoOv?=
 =?us-ascii?Q?rWaFzD8XBfBPRI4MmItYsP5go3H59i11Q9uQqgDK8ZkAljBp536xOW4v/5xk?=
 =?us-ascii?Q?WRB9NkxdEWaEwTQDmD90g8C8CRBDfTrswuLZkn2FbpvZWKTCjA+HcGY/1jmZ?=
 =?us-ascii?Q?Ngf6313UuNAkBIia9iv9Fx8TP2tt2CHM8zGs58lOUZm+nP0mfk4nd5wQXva/?=
 =?us-ascii?Q?9W4pOkFo5TsDBAEg9KAnKIl9Nj5VqmhhwCxIGwNPsmF80Bj8NO3qDbga0E4n?=
 =?us-ascii?Q?qbf2dKtMxqjhmQpCt15Oee+jPJ5PeHT/Gew5kUnFJly/Lp1no/Q1U6i+ttka?=
 =?us-ascii?Q?+kTQNA2T/AbvN3W394mLVkD+eVpuc47G2uJKoRekJKTuz9mhKqKNlAelXn4f?=
 =?us-ascii?Q?doWGBiamiLZfikwhgYgT1oF8jfvQrxB6ekxUNxenYlP28mkXNyHKXIzexVLW?=
 =?us-ascii?Q?GPG3tp+yKAmaJWpQlQhMwWE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <208E308F6039734D93A2BE8883CC827B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0D43FeAAmnDltIp/FKryKXoybMPh/tTdrrFgFERGD50SKAVyEAP9YC8t32an?=
 =?us-ascii?Q?8XkeBWGLYGhiMxOBARQ/VwBTjLLHqmUAejxXQPWeSX69c/0KhPV/vig9Ewb1?=
 =?us-ascii?Q?WxfyTyTsOtlmzn2bZd0pekpqZ8CmfbmVXSs/sBA+IAavanQdWBncs59iRbGx?=
 =?us-ascii?Q?NpY7NbI8J8yMvIjtd/0rNF3OEErh+tX4H3JAsH5Rj484TA1ejfpGWptRANU1?=
 =?us-ascii?Q?z1rPxA3NcoKfk0H7tpV5znbgc/vrLlPRDkexEpvO4NKgjgXnmpu5LKAlCHlm?=
 =?us-ascii?Q?XyVRAd39rydCGsjRWlKUvS3DpVNnMZPrhpqFdLq7esWZGjmhuxWnkHS6F2KL?=
 =?us-ascii?Q?YrHDs0Gkneln5lbvM8TBfbcYxPBL6ZEAIPfkHVsq0IyWt0WvxXcSjhBWOdRv?=
 =?us-ascii?Q?N8BPQJZPZY7jwN6P2irhlnqlMzleNsL8EqSeTvSSLzg/Be/aV5FuvQ45Ngv8?=
 =?us-ascii?Q?MPsaRU4Y0ahTftw8q3W4uVjc2u1yfvPpF+UdnDxhNCUD4jSePW0wOxLs1vGv?=
 =?us-ascii?Q?JGfyyyGGBdSwzMWik0+ixZ/wsavJSn0WK6picM258KkPPOROzaF6EpgRnv0F?=
 =?us-ascii?Q?RFcoqHSdaxKM0mhk7qThy9/8JhEH+TOVN7SEpSNWedjiEO4sa6ewJRe3ykyt?=
 =?us-ascii?Q?1mSoClDYQgDjHmAw50C1FkDXj7T55R320TuNIYqJKbI/Gji5Ey0DvSwpwoun?=
 =?us-ascii?Q?awLTQ3mp0lon11owH0krEXhIu8OC8IbrXyvk4ztcbRBhikQoBTn8BCuRroOt?=
 =?us-ascii?Q?40sWbug2i4Ri/ngi8FmIHcu83WW6nfDALzr0CXAuFM7OXhkJbou5tFpkmT73?=
 =?us-ascii?Q?wSm2q/QxXbXUqM+UbBFs4hH1tfe8oWTTuHFAyBdiPUIl5d7nFMziYMBZhWAW?=
 =?us-ascii?Q?ODUPu3uPFP9M/iT0UyWXiCDLr1AMjHc9mc3jH5ilbb01Pq++v+FDaZlk7FlF?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b2e2b9-71c9-4d59-5d4b-08db8f4390bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 08:20:55.6793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vkP8JMEY5uxV1kUBZ8o2nGW5OH7JW4m9C3Mw+PE1FWm4MBnZWxy/5wEDrjy3LmYePxW50wrgeTy2YjJSm5aXB587vrWlnE3Nlcj7fc0+Mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8173
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 26, 2023 / 14:46, Daniel Wagner wrote:
> Max asked me to replace replace the 'nvme/rc: Avoid triggering host nvme-=
cli
> autoconnect' feature with using allowed_host on the target side [1]
>=20
> So while looking into this new feature, I first started to refactor exist=
ing
> code so that it looks a bit more consistent. I think there is even more
> potential to make it smaller, by introducing something similiar to
> _nvmet_passthru_target_setup() and _nvmet_passthru_target_cleanup() for n=
on
> passthru tests. A lot of duplicated setup/cleanup code in many tests.

Thanks for this action :)

>=20
> Except the last two patches are just refactoring patches. So if we decide=
 to use
> common target setup/cleanup helpers, I think we could add them before the=
 last
> two patches, which would make the last patch way smaller.

I ran 'make check' and saw shellecheck complaints below. I added 'export' t=
o the
variables then they disappeared.

tests/nvme/rc:19:1: warning: def_subsysnqn appears unused. Verify use (or e=
xport if used externally). [SC2034]
tests/nvme/rc:20:1: warning: def_file_path appears unused. Verify use (or e=
xport if used externally). [SC2034]
tests/nvme/rc:21:1: warning: def_file_path appears unused. Verify use (or e=
xport if used externally). [SC2034]

I also ran nvme tests with the export fixes and saw no regression. Looks go=
od
from test run point of view.=
