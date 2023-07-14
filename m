Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11438753751
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjGNKB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjGNKBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:01:17 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B237235A5;
        Fri, 14 Jul 2023 03:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689328866; x=1720864866;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=mXI9UeUYqNskBhhz2mKZZ9iJX1pVRRLVaQXYJrMaIdmt8omo8NKEnsfP
   AQ81v4J2C89PNlO766DJAiVRmxElflLw6z0f+wt9bg78WERCHp+iBUSQp
   JoHwSfbL1ezJdvcoZ+5BN0tXB2DhChqBqKTPb+04lW50NI35dUn7gxT1V
   7Mb1Vczt3FTSZv+ZDUGgPA+SrOFK0oozyTNHDJJTiMGBjwqdT7/Ktowdc
   kcSZ18r/atmjA0ZO/dPGy14wYGyvsVU9K6VwDjmD8hTBYER4ODPkfQWnD
   9TwiZBgDB1xhGa/Q9FLCitryE0+OrJKzSNNrDQdXMOOfXd6frwtqHMhd4
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,204,1684771200"; 
   d="scan'208";a="349958354"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2023 18:00:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuXTJBxo9baIjhrL6KJzLr3SOiwj/xK8rp/ntHJtabyP64V7HJG0C1H+ix7cD+gP3CFYRr/YMaFuRfDuOO8RcuJ7QsMvDZskH6jYQ0Vzwrts4j2L1NnB9jtgoHfOlwEcI0mlb+QgEkqY1+7KK3a0aqFsMiaVUUU6pIw95JvMbk7o6AsmLRHMSel8uUJbk+nAu3eFIyhDm4UWuSsjEw6dUEry/keAzj+gUvl+zQXiwg8KYJypEk6rjmdNPCOIJRfK5r5OeHx3UU6gge6UHugxB6WJG8VGt0hZNg4q48ZVLdWHfVEt2uFYe+RgVG5c3U3OTHLI5HpNsxpF8LVo4UzhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=fjztMnGS/NInU5CtufFcPWVaY2fG0NEU78atlUcO8rC0PJg35fv4DWf94CjGl7z/YI44dl9+KTDLho+0bJdJfLhHwFKzmqMxDWpfsz15xTas66pic4ow1SiD6ZvHPBxiTvzG39Qlwa/BxhCl+pD/F1ew1+zcpV2JEC/Hr/DmJifVyLHfTjUv+4QGi44tG/J47DqCx8PEKmX1VzLCGcvH5FSyI9cLIFTr8z4G9NQ7TwLKWnwf10PmFvHjkOWc8apF/8LU5etvBRLgzZX3P4tTC9O+m1fAvhHzZuGiJiWj+6q7gqIxbFUG9lPemMya3N/OzDFUV9m3/RBl9dyZsrZyXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=XuBqBpkxIDRai5iaBeAU4kbB1ppVUfZRn5AFrRS+b5twGbRaXyv+6vlkK8QfC0qqMIH3iqWhCaY8Yr13VG5pukH3OkeQ4t6LnyUAH+tGoUZfvmeFT3X59che9zTY5FXnClH8BpqYBOzmgWvj1QIIYkFpaLr5IQg9tTpkh3UL9Jk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6431.namprd04.prod.outlook.com (2603:10b6:208:1ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 10:00:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d10e:18ac:726d:ffe0]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d10e:18ac:726d:ffe0%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 10:00:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Andreas Hindborg <nmi@metaspace.dk>, Ming Lei <ming.lei@redhat.com>
CC:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v9 1/2] ublk: add helper to check if device supports user
 copy
Thread-Topic: [PATCH v9 1/2] ublk: add helper to check if device supports user
 copy
Thread-Index: AQHZtiRn8ykWGlFi00yWssXHYCKmPQ==
Date:   Fri, 14 Jul 2023 10:00:50 +0000
Message-ID: <PH0PR04MB74162DD9A22DC6CC609436AE9B34A@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20230714072510.47770-1-nmi@metaspace.dk>
 <20230714072510.47770-2-nmi@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6431:EE_
x-ms-office365-filtering-correlation-id: 0da0dfc7-ea10-4ffa-7774-08db8451342d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yIxwFvkd7xKiKyCF0RB+kB6cW65DlTLRmvf/yNDXCyCb/4+enGMFKl0MoOyHT8F+VISDSImnjIqu7YgTGBShe0iZroT9iLv0N1hbvS2R/R6LrSTB84C8fD6c39OIxQucYiOcPTygZacUGIDV8OeOo+yNIBgkKqxOOx5n8M5OtDjPvFS5z/cb6/y8o3uDEwmPyDaJvGJxcjot2zzB3WLbnSRDCSWM95aI1+PpyWazSkV99OCpuOrxDwWku/+V//nhG7U0Hv3tB6k6zD8VVqup8BXhQq7bnVmg18F7PnjSDf6+nOLXyr2Y+7iuggVjajNNtmcImSQs7SRO8I0BOGKuyOao7xtqlrVIeZAU8gVEres=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(55016003)(86362001)(33656002)(122000001)(38070700005)(82960400001)(38100700002)(478600001)(2906002)(71200400001)(7696005)(110136005)(6506007)(9686003)(26005)(8676002)(8936002)(316002)(41300700001)(7416002)(66946007)(66556008)(76116006)(54906003)(91956017)(52536014)(4326008)(66476007)(66446008)(64756008)(73894004)(621065003)(186003)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wVi/Lm4YQ4gb4PLS+P4nSoXqSHvHQ/WoXorVvJZa25wlrJT+Nkbayn/kTE?=
 =?iso-8859-1?Q?aph9gHZYYNM+Ug0orPHppwAbUBjQFpKDvdN64dQp3FK5tFtcylOezjn1eh?=
 =?iso-8859-1?Q?G2MCTbmBn+r40A9RMjXrTStlL/vCFLqXj80hqs/Wbw7+SMO6TeKg7/ir9f?=
 =?iso-8859-1?Q?ilKg8edv5bhYOxW2UYKzc0zCaSB0VhY8vKTQ6aCBczfv2a7nIv6/Do1uba?=
 =?iso-8859-1?Q?bRdxpzM41NrAkRLvjKC0XWJ76ZDOQ1dZIhppBiaWSLHsL8+YzLgeImvrzJ?=
 =?iso-8859-1?Q?H4BXAwcEWSnj1vv3vbWusD5SH29EJaMXIIOKkKZCFjFQfXYtFnuqp1N1zY?=
 =?iso-8859-1?Q?65WV958ZLNxqFp7NU7onQ2/XIu5nWLlQTq19g4prFYucmPoomW+wpXR+qc?=
 =?iso-8859-1?Q?ZH3QTnK2Z6723MNQkbjP0LQOznR2LrjyGhQUCAPz+GRG9bzGwSgWX18C8/?=
 =?iso-8859-1?Q?t/Vn0VfdNP+G8hRM8Jc0SygzPvOrruedPCUQkNV2paSGLWa4t66Z2C9KIt?=
 =?iso-8859-1?Q?GmkJX9lGxEq9+u323PHaANhNDMxw0u9BGZ2KPictc1LTDvlfG3ltyqauFD?=
 =?iso-8859-1?Q?IlnNiw+LC/hfmxRNyVr0bpyIxgV3vo40W4VYFmc6bnryq28YmIMCpGnapy?=
 =?iso-8859-1?Q?EMTUBGJoMhfdlFZvD72+otdxfEYqedDWiVK2tCCgqdkfAUKJtFHwT006fo?=
 =?iso-8859-1?Q?up+AvUBpnrsY5y1kHXiq7CxiJisWSldQxAMYsxsGXDumlBw3PJciQeaH/1?=
 =?iso-8859-1?Q?D9MWxrxkmr7TYVv2QB3zbyUI9A9CeHl9crBAstL8NLWU1i8/d7z/CT8Tt6?=
 =?iso-8859-1?Q?DWl9eV0xUW2oQESW6LpsafwlsoT2qLJmjRUcqDveUg5e37i5zTk6Aa2TYe?=
 =?iso-8859-1?Q?RFT9so177Ki9phr8v51BPSJOxztOT68PvpZSCVkJbERuak05kHOdbWDFOT?=
 =?iso-8859-1?Q?PUbOvYclksR9R8thyvhtasTBZczozJEtv7MoXzeksZznZCxbVIRqBePCjg?=
 =?iso-8859-1?Q?tiogKvzsGkclOVsaunoQXKRywgWAwPYeY9hu1mnswPqsQhRwAOhUgVguF4?=
 =?iso-8859-1?Q?dIWNCwcPbNWdYfi0qnq/yxbXOYBPZMeYRAVcu0jqnV2qtzk4iagKnykSJa?=
 =?iso-8859-1?Q?Ef2gLbB7rnPd4D6HJCxC93XUlJNrGNv4hr1tnpK3Xin/XngdKx+KFfikB6?=
 =?iso-8859-1?Q?uLVJ+pQEpM8uCJk/h92TXXejvvxoy8m3mfD9lGphDNmPwVh8fkc2cFWFnZ?=
 =?iso-8859-1?Q?ThdZ+II4uhbsj3JSWhLMa3AKQEEVIEVkye6EWpBuWddThgQ5TbTjuOFk+X?=
 =?iso-8859-1?Q?QZyQJFevPMBaMpfyu1acc0MEqX9kwqX+P4xvzdIpGHQSz6Ih2jlEslK5tz?=
 =?iso-8859-1?Q?KVNOuKRR5KEsD5MNoDUnciStM3PM9996HRE2zFWls6369zCm6Z5AdrWUpL?=
 =?iso-8859-1?Q?IXZHYh1sN2l0sSmK64XIuw87gMFNw5uDfIbvR1BmGa9Pw55utP3tlKiTwY?=
 =?iso-8859-1?Q?HwhQWpcpq4pzzHLu3DaczpYDaito2a5L4T+uEAulJxWEXA7vsg8oKgS14l?=
 =?iso-8859-1?Q?Gj+C3EqxUofqU0C4bpM0gZxcB/eUJFxr8gXvZ2VGYVEy/CFODP4tvzD8rr?=
 =?iso-8859-1?Q?3bWsU099I/OtGePTXqCIz/jE5AuaD52EvEzaXrI+IPYqBxS32YptgNzw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?e3rh334ZWb6IwY8D4Fh/dghcEMGSjyvJEE8f6vnupof13x5we8TQSa9aV5?=
 =?iso-8859-1?Q?kpxRkJELnSlQXM2N8W24aUBvzK3t2ZRO43bNxfcpi+t3shlt1LHtgdGG4c?=
 =?iso-8859-1?Q?Y6ziHEWy4+DoW5wQtUjVv5KzhhopRFzVzBGRXAxuMGDh36OVo52tqHh3tR?=
 =?iso-8859-1?Q?DW7TRMGI1krgLREYcpQXAvBxDlnhwnYG+fH47OotfHt8sWAainvGhe4jhK?=
 =?iso-8859-1?Q?MfAzEeDaxVng0GzQJeHClo7YuqUOC4yiASmU2UZnG5wVgEnkUwe4hBUBGv?=
 =?iso-8859-1?Q?A/jsNERzh2JL+bO/zu5FrenS/iMORwt0PJ+Qm1oiiasJL3VKJzcFIbOvfe?=
 =?iso-8859-1?Q?GKHJwlkSw9TpoeCeraZI/ILjYLteKgIefIgRxgxHhk11Z2N07ENKKBasfP?=
 =?iso-8859-1?Q?9pbbAk5W2z8PX7gHOimS99aCoX3iPYqsLDvUfsmJoKOIS6zth0/mB/id6a?=
 =?iso-8859-1?Q?LSgG9cj4HU7NxdtWTh8QmkY0pJauFOnjdnaP6vQSQb5CZ/94jbzq6BGX2w?=
 =?iso-8859-1?Q?m5om9emzyGS0K1+rf/46ODRFWzJuFNR8gzVNxS0F+Lip1NOWhPVDNBBZ1Z?=
 =?iso-8859-1?Q?1pqpou/rmDtPMvxFStIgxbohCKpirqNOP9/0lEEJRqKN814zO+u6PN9SXv?=
 =?iso-8859-1?Q?T/a3qwXTAeopTdegiHvbcPa594FJfUWaajfbBPvm3PWpREFzsv4NLW1GFa?=
 =?iso-8859-1?Q?Nb2Is8e7OR5zarXR5Ee3s4kSWubkbDxBEGYf0vabKaotBM0b3iSqExRTcq?=
 =?iso-8859-1?Q?6bQCT3jSOYhvSpjL2hG4ja2FUivgZUMBtuAaMBkYWK2Aka7/G+M/ydjuDW?=
 =?iso-8859-1?Q?TMMKj99rfXmquPVT9XojMc4GIYPT6eB2XpbnWa7xdukXeutwF6rtlDe43d?=
 =?iso-8859-1?Q?sa38Wy5c/7yw9FbkPvkFmpO4FyBRf1w2MVAnYsqy84wUrX005QhooYHoR8?=
 =?iso-8859-1?Q?chapnRAc7XfhsV/eFaxmD3FegIlhlKi7lPQngxxWZJVjYFmC+p+gVysafd?=
 =?iso-8859-1?Q?W12OY6S9A8rQlZsRmBm709FcrBVxdjFBMyPalf?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da0dfc7-ea10-4ffa-7774-08db8451342d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 10:00:50.5332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySmkmn9TIuBQtR70VKKS88AnzQL9lSsIZhuYSj4MlOCcu3Ba0v7Ie0lNG/yhLilwpgUTvGFX14sX6hjAdBgN8pnE+XwfovNkylkBFwDBvxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6431
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,EMPTY_MESSAGE,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


