Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D30753770
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjGNKEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbjGNKEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:04:50 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477AF2702;
        Fri, 14 Jul 2023 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689329081; x=1720865081;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=GL505xVTQDX3WqPFOIM5i0LkE/2lhQ75pXgxgoMD3ESvcBxld9XWsLaf
   JKp4Nk3Qa5Lw//oCyrDGVrko4mZ+HUaXaPumJMvGoOsrOmCxVBZ1EAnNM
   SySzaz6tziUeMdOAoQTT3hCTxYW5lHFXYXMZK5UKr0wTDyD2EG1L6JuGm
   7UN4vW3xYWx6wTergL3lpizFLL4g0s/MKwIP8BZQr4ytJXx0d9DZLFJ7N
   OZBdqKmf2U/56pgsO7Y7wFam/uJhF2R9w67AXMvLUyX92rBDvgWSxxIPQ
   6dYqbg5tNsmu5kOFS+BhnHDXtIcew5cSegIvb7w55TX6NVMSS5j9U0Zbx
   g==;
X-IronPort-AV: E=Sophos;i="6.01,204,1684771200"; 
   d="scan'208";a="343122003"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2023 18:04:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPaJ/CG7ZHdESF+jxn9E5k7xewMV2kADC1MOFBZzjqLvZnHqG9p0TtGmvDLvBUIjir7lCEqNbXD4usHJICt1EiuhMDNY5rn/G8hWLarW2RgHLJPbjlSomuy+fO5Cw+jX0kEGRzJa7B4HwuD6PF5DU4fjHFOZm66mr4JnPiSBsowsMABaCBhkmSGAFEl5Y5jgmvVTExzbEwF1fttFpR/qcsSYJtmhHkzm0PL43uWYBk+HPtfP4Cdhl5HA9pyrEyJJZz/ZzJ4cGh1LUR+LtE9wDlKQDZl8SK3Vm22Exrpq4Diwar5PNPE0J+aGK4L1YPuU3ekPm0faShU7Im8tgRVciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=H/il+2HpTgBX+oJfi55rAgAqCtyFS3D9QRviCwIO3+kPiq0AOEi1ztfwBIHKoFoZYBRiNs09kyHlcR2nOpVvmFXqfovy+EB3EcQni4OInlnIyD5xYnNlYyGrssw9bC1+fuY8lJYfiPcJRxcrsdqGXWa9/Dn0hwCnNq5epgDUQ07sPfPWo9055bKErg6vdnSykyDllB3T4PBVMZrpOWALyUEHXvzuZy7tzbao68SHqZpypuj76sl0BhgkpFx6N3+cNxZpGjIzASEQBa6EiddRw0jVcbMV0IkqfuLn7YEk+odXjhWnGI8u2hnM99DraBATqNXOfURCqryQaAwLDxIZiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=ezkSpW1IeSUEMU22vMcY9J+rWyfwZFzF1XHtVzxraUOvOtMJHwwhRVao3PzSVp0LdTFWP7bXTukRhOUwB3ZL1XuysWqiLhndy1/JMVAVPitiorj6wZ48wPGF/2UcAjYmpl+meYGhpYzFsJi5f3Zwt6Uf30kwuNg9WTZVI3jdkD8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6431.namprd04.prod.outlook.com (2603:10b6:208:1ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 10:04:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d10e:18ac:726d:ffe0]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d10e:18ac:726d:ffe0%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 10:04:35 +0000
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
Subject: Re: [PATCH v9 2/2] ublk: enable zoned storage support
Thread-Topic: [PATCH v9 2/2] ublk: enable zoned storage support
Thread-Index: AQHZtiRmdnzuxLXksEWraWawgpENGg==
Date:   Fri, 14 Jul 2023 10:04:35 +0000
Message-ID: <PH0PR04MB74162D5799D1724F0FB8D3A29B34A@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20230714072510.47770-1-nmi@metaspace.dk>
 <20230714072510.47770-3-nmi@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6431:EE_
x-ms-office365-filtering-correlation-id: 653df2c7-22ed-4794-491e-08db8451ba6f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sXeazeOVMK09A7On+RmWV9tLK7xGX8yKxm9HpdFNx9Ua9Zlrb7mVMLhs4D/Y63lJzVTogrOxp45OUwXqeARF9rHsrUHlLHqBM4rHspv3LpuBgq4l7gvFzqnQW0mDkSj43t5OHwp648CHBB0A31a0wNNTAGTVUQTMqc2PNN6yFAhs1l5CCLJ3C7CSl672xi17n3InrXMt0o2bTwny7u2cZub5jdY8LToA6sObTiCT0prjjuPlcjq/fjUJSvCiSBc7ALKae2/pBNyqp04Pvv68VEp+w8OeEKlpE8rT+6LTsbEJda66qYyXkwOrmDRoyQJvlb27CTSA2SLiV+5pAf7z1Fjw/Fi8NyF6y94SnfmZkBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(55016003)(86362001)(33656002)(122000001)(38070700005)(82960400001)(38100700002)(478600001)(2906002)(71200400001)(7696005)(110136005)(6506007)(9686003)(26005)(8676002)(8936002)(316002)(41300700001)(7416002)(66946007)(66556008)(76116006)(54906003)(91956017)(52536014)(4326008)(66476007)(66446008)(64756008)(73894004)(621065003)(186003)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Tqrs+12thDUCq/uzK8lwD1k3+7AFgd9ax5CvmldEXk2XHCv9yOBsI9o8I1?=
 =?iso-8859-1?Q?IytH3ZLSUQo6MlmwkH7F3rsL369c8qR7i8Pp1e6OmDS+GayA29nNqJ1x4I?=
 =?iso-8859-1?Q?ajb+mLP118oiCylvK/fHTB0sEc5+K8H1kCSDI60+YBmnsKHwcdptzih/a6?=
 =?iso-8859-1?Q?MbgSdIwKh/S4aOrLZfoBSGj1OmDhSjsvqACHLATaUealKNQSDcXoM83BT/?=
 =?iso-8859-1?Q?hqY1uQqEqc8tYYYz0op/AdjAMq8VM0XVPHLA3Y3tDB2+2QgmPm9yAgDvAN?=
 =?iso-8859-1?Q?FOWfdm3Vxc3IBueS7m+GmJJMEBSjsPDoS/+zutrRa9PgEM4NmZFlyi00Mo?=
 =?iso-8859-1?Q?MRaeuCgbPzxOAWFpusWioExSx79oaAD33wm6ZIE0OIRvnE8FWL83mz+YUI?=
 =?iso-8859-1?Q?c0v6ENCyB3Iw0NpuwGOti+XuuTRMicaowoMzcNIMZiQbwjg5CrdPVJ9Lji?=
 =?iso-8859-1?Q?QE4nyP2NXmuk7wJZZCVaj9Ng5w2LpW0he/hdbQYxG/qSf2VlhJV0WiqRBM?=
 =?iso-8859-1?Q?Wc3ti9W/g9FU81vt4pwEFRPFgEvSVDjySSmyzBHnkZ8nvRYegS1hdMhJsg?=
 =?iso-8859-1?Q?ha+z5rDJb58m7C2ZkF/CysC70PDYq6OPj8/ziXd7UEocXeHpYAs7T/jsqC?=
 =?iso-8859-1?Q?QVHCk788n9XYFKAWrxaxigs4EAmsMXwrftwUOwJkXs50y9/PxsMR21mHWe?=
 =?iso-8859-1?Q?pGSiPjX79ilwtZJQ7OG+QjglvBRbguQds80gBGnH0M+iM4TiOs/7BLJ+k2?=
 =?iso-8859-1?Q?IIcQnl7+pDEt1yB+kBEpZtLsQMf2hp601rUqK1NWZpp1iF/LH257ooWfVQ?=
 =?iso-8859-1?Q?lJIWTnLBEJrcvBKHMZ9S1ZWj+9lE3PnrI3dU2z/QCrcTpamh15I1ZD8J8q?=
 =?iso-8859-1?Q?X09mjg4r8wRuFTcyBH9tdNCWKI78tgwCRsx1Dbd3h2RlTCIaxuwJM/U5o+?=
 =?iso-8859-1?Q?m7hfTIb0qDgr0Po0Wc3sUiPHNFXepkIq+VKihmXPhMEXQs4fXrOrY/U5eW?=
 =?iso-8859-1?Q?tV+HipT85nH2DV9iGQX6kQT5PeT3UdDNepS2t/kULctQSxDxF5rTh+ipyK?=
 =?iso-8859-1?Q?xj1DZDXrnnEFWAX3S5cqauHPMXeaXuTTvpbFXNafGvwbtsOnnjZ8601riP?=
 =?iso-8859-1?Q?7b0NJw3W9tkxv+9IKGnxojZJT9v21MyM4UTnJF6Lt+vMdreaxkvfr7Q5YY?=
 =?iso-8859-1?Q?coD47Xbb3TV7LCkAk2TkGi11K9I0Yky9xX7y9cpq0aDPc2moq3I+YDXyDL?=
 =?iso-8859-1?Q?NUsMAy3rjUnBquFqduWdbx6EmEv+GvVDnwtFtcSlSqaPwKY5WC4FSbAJJ1?=
 =?iso-8859-1?Q?F1d9zRSMwWPwuMR+EsUhAN/x8nLwmy1VdmFzKWdVFAlGx/IXy+BZD4hW7i?=
 =?iso-8859-1?Q?8ztd+GBr/r+zXqruOCaofCykES6wYsnWzXBOpeenPXmRDdHF/QNSGXjplP?=
 =?iso-8859-1?Q?l62wAfzU5Nf647jZlF7YKLH2oa96owvZmuphZ0IPhHQ/pWh+fHus4D9Ath?=
 =?iso-8859-1?Q?UdxuTR6Uh+X9O5HDkT8CHf/b1h/M7Dbf3ypwaUlJ6Onagr03FPTT/7WaMz?=
 =?iso-8859-1?Q?00qERZ45jkW8lzd+45Voy6jOC7qEfUSUV7lMqoKPNnNq5c+nY2tF3g/95R?=
 =?iso-8859-1?Q?oSLMquaLokXiRqHob464Yka4ng9xrqu332AgrHHLEz1+ajb7zLoOr7RA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?mKytwxDZq01MQVKP7CJjYx7ItSbXpw364jYPfNdIUkNkLa1sSpqJvNoX30?=
 =?iso-8859-1?Q?1Irlj/+K6mtBFqkQiId1LXfKXHHHrw90ulzozW4XNIcxA9PiyqW+KRHOd5?=
 =?iso-8859-1?Q?i2sBn/ElPVS8Ekn0XaLYeVowmxLCVI2JZIBVfDWMjCKBQIcxsYcQn708EZ?=
 =?iso-8859-1?Q?iqXKjF2mXjOJerkKj4/QsyxRPr/JtI27DvEIOxcY1kh9mPyueO6GCzft+r?=
 =?iso-8859-1?Q?kPlDT4O1IIGJFZFlitI9Prdip4oljcVsbUsPFlkmyiuO6k0rYIlVIdXojm?=
 =?iso-8859-1?Q?v326rWJg+Pd+O1cVztcD4qInLEkyIhFyUBMGNCXIb8MNEmy5/Ck7DqbxqW?=
 =?iso-8859-1?Q?rtEixvLKFHmMLzXl6nTa849RALvWjkJxVqsLUcEDvCa2LiB0/OkXuqXGfV?=
 =?iso-8859-1?Q?6mKmYLCZcYlYp0rmWG70kL6QvkWVrW5CoyXZkwcOsiLk1zRLQMJi21GmrU?=
 =?iso-8859-1?Q?j6QEV3gy3LhdrDwKmMHkabRgTFI0odBQSRrooC2oiMLoC79cKCBeeG9dwG?=
 =?iso-8859-1?Q?vsd6q8k8FHRE5TfN23CmEq5v6Pp6/OyAmF18pq2cKbq4UGBiRFL+VG2CSb?=
 =?iso-8859-1?Q?h4nLRPnJ+wUYAKEJxXte54SicJ4vgGPVcnJj0BvPRKW/wTUac4f7cPwtX4?=
 =?iso-8859-1?Q?OtmTNmcJ9s3ORdv6j13d6zADfj6y3hd00DgLMWllEO+yrssblqqYmb/waP?=
 =?iso-8859-1?Q?Zhq6Y6hn8I2kZbqv0GE7sUKZpsD+AmK7+Ok3mQ1nAGMxAaGn2lIGzkkjKr?=
 =?iso-8859-1?Q?K0WKuf83a6X7kdtfyrZ/1MEtEXUmmjWf+lqsrleezbSyRvXwcxFCb9ESkQ?=
 =?iso-8859-1?Q?cKEz9l4U6eB1ZAOkOcPZzD7zEq2l4uQMagsinxZi87ErQzFrhk82fHG+qA?=
 =?iso-8859-1?Q?bO9Gw9hoTSHEfBVNFW0Hho5Ee4wC6RGtjDY1X/5FkC+TKSDBr4rtSLt2av?=
 =?iso-8859-1?Q?Cx2Ave7kQ9CryUBKdmezmsHH3slfbG4GdEpSBzQPKu5KW3zrGbiGF4GBKH?=
 =?iso-8859-1?Q?Dg0Zwei5YuWNLu8puNkVGszvrkUBKYPrw40CmU?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653df2c7-22ed-4794-491e-08db8451ba6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 10:04:35.7929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iCnZcJ2elg6IYFCT/2RV+FJkPfnDbVCIbXRpy80gaGILXs+ScUfzNooBH/7Gt3u9HEHqJ+BbYXgrYmAKlbO0d1ibIWGnAW7dRELLa1q7xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6431
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,EMPTY_MESSAGE,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


