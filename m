Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B05977E154
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245053AbjHPMSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245067AbjHPMSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:18:41 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C397109;
        Wed, 16 Aug 2023 05:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692188320; x=1723724320;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zs9A27x/i2/ISHf0hX+fbZg/36nSzu0MCNUBhvHCGOA=;
  b=OHzt3o7VCXD+1n7MCZehxzQe+U/GuEgC83XbOQfl7BP5J8re0CmFM0Q/
   pQr6qPQV1WwX61r7pYM9Bm1ZFpRRetZ5Q4yMccghBhTC4MXX9Tly/Wm8d
   NeMWZGx3orrkpkisllR2zSV0w5S+CV+OwBVUtNOOK/OUsfFpDB+BheDc6
   8FfDhRm8RovJBVQor/xJ00EVrgcbmdkzGaWgUyweR3uIJ/kEqG5gIe/dQ
   F7Lv9OSnqAFRpRqbufhhQX+Q0lLGL4HoBRfXnnD+SvPfPKJsNr3flKs8S
   EfGvDemHdKkMSgd7f05dq+l9IA/n9ssgokXP1ayaD5sB6dKEoWumOa3B5
   w==;
X-IronPort-AV: E=Sophos;i="6.01,176,1684771200"; 
   d="scan'208";a="346443941"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2023 20:18:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOeCYMiHpvY81VmAgqQxRnTTv5IZRu1DN4XekLPjTpB+T5fN98EBmwiW+1b4tcoqNc2P7pWOjfnDBTG2fkr8kTheLbPJM5MHAnwbszdq4Xzlj3NDEAbZdAUp7vZbTFP0NwXVFz8iJXKG57C10uwSY34Y9lG1bvXXFx4iK+S5RY/rYfZnbiw9WGzOvsN9evkw2cZAvCgHjdEgkN9xn0wSVEYJ8NPC5h/JgD4HAgwIZSkyYw6GQAw5ogqngUgyLpoh+3PuuRjugYv5bo21IrDrYzF16bnwdrkpsCITXgxEctNB65vbJJOi9TfdbLZhoIL3p57eW6ptgeAwlF3x0JwR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs9A27x/i2/ISHf0hX+fbZg/36nSzu0MCNUBhvHCGOA=;
 b=ZQPI7Hx3MeZ8956TdisfKBckMO3sr56lRZlBlJGLjF0+/8iOjUMRjklGiOB6DC/m4yDDaI6mNvBpveQwuuBNDF9cEUf3tw6JjipyJ8GOpM052ZgP5lWUU7Fh01N/aPuOfcMogGlE2Vp82GgOv8Y8MutQ2Au5rjCxnFYQ2M0DGmYpTtDDR0xlHEpdyACjqWt8eAj7gmSz9WMP+2qrTeAX1zTuA0irrYRsLzq+3djOGrbCaRTdhHBVs9izX3F6S2bGenYcctYygnb5Nmv5k15Vjs5vquspjpdvC1TEw+PITRHxKo+jKlWI6yhzuxS0xMx0jLPghBDuoTpVQi01quhBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs9A27x/i2/ISHf0hX+fbZg/36nSzu0MCNUBhvHCGOA=;
 b=kKrOTCNlpbfY2MLR8MCIlr9zvfHD2c0/W1BKVbvs5dy7x9Fr1JlY/MUwAdWLh7XkZBGnRtH63Uft5vvSJ4JCmxZ/i3iuJgqh3l9bs79o1MibszPZg+cNc8ukWAkspxvHauwDjWl55FRo1u/h+KpDmq6yZ8+4ej/qpAoTVqak+d8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN0PR04MB7968.namprd04.prod.outlook.com (2603:10b6:408:157::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 12:18:33 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 12:18:33 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v3 00/13] Switch to allowed_host
Thread-Topic: [PATCH blktests v3 00/13] Switch to allowed_host
Thread-Index: AQHZzDdMs3TsBo7WeUCvxoTAoQFlvq/oVTKAgARbUgCAAC6ZgA==
Date:   Wed, 16 Aug 2023 12:18:33 +0000
Message-ID: <ky6hb7se4hd5hgvwd7uwxm6pxgznxo5jp4fjr474qf3pepoipo@g2g2wtb2hvn3>
References: <20230811093614.28005-1-dwagner@suse.de>
 <1098c6a6-50cb-8704-9041-03c431155dfb@grimberg.me>
 <6e3i34utxot67jod2opzksdufcnfypycule5kkrcfaezxxvyg4@ixifxnti4wqy>
In-Reply-To: <6e3i34utxot67jod2opzksdufcnfypycule5kkrcfaezxxvyg4@ixifxnti4wqy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN0PR04MB7968:EE_
x-ms-office365-filtering-correlation-id: 20389a3c-e761-4e16-5152-08db9e52e8f0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MuoovYa7OZKMM480jyIQD/H/2VymZOpdXeTGlH9AyqNLves5o0WTfo0JMY2CNPVkyQI0HylsDRYzoOaDDJ67ecoqnWXjPHndIFL2DGz2xD4rtLYO16C3TSheYq9Mv8NXxMj6sisar6cHdAwIs6aSFVIlmRv2okZAd2fQ9A4bGQQt72f5lOFUCCJx5xY5FQpyNEXda+mqtabKBVeKUf8GiGKJqt3TZgr6ojYS/FXlBpSVVZXaqNwpqMdUyN/7cE7AIz4k352hNNNHkWDN1C9POp8ezP+uXJntYyf+/lL3Rvcn4njSQRJR2cSeRPJ0Kgil3GgxMxCJb3EU1RDEkyJGSjzD+v8boYfKVis3Xim5e7Ozd3ahe+Nyt6RwfXZW/358Hdg/Weqfdb3qhLjRpLiPM/zK6jJCDXywoLTXcj07DzZAzvzHjkLXVj6OSE7XAE05fDYK/zkbdIOVqtE7jSAIMD5D5SX2yFreWyO1pjoPpuWRMfd4A7er4pef32lRTkElTEXMkx2kzzuN0TeFuKGRLI+Unm0NL3MZqVsfJ5vPieROH8skX0zqkOdoeMFldN7cH3aosTaMe+qFb+J21ozL9EraMqyR3se9WO0MSv3ll8oC4aaegZLKOn4b+5gZXsic
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(54906003)(76116006)(6916009)(66946007)(91956017)(64756008)(66446008)(66476007)(66556008)(122000001)(41300700001)(5660300002)(44832011)(38070700005)(38100700002)(8676002)(4326008)(8936002)(33716001)(82960400001)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(9686003)(6512007)(6506007)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kgrNHjsyFQYkbcfN9FHlS/X1omXgCsdRb9rzbSg97rZ1+DjlcM0f8DZsHPaU?=
 =?us-ascii?Q?h6ChmM4Vn6UsoDGZRYP0EuN1WVU2xIoW2sKc8rJHr9yTVjVxrtr5+q8I1VCp?=
 =?us-ascii?Q?WvOkuH72RZAnq9ZLu9EO98Ca1Rmegv6T9gm3WReK94N6c5BMIwGz9jy3RfXR?=
 =?us-ascii?Q?2NT7veeUPQqkmxaownJloxWA2g7jKM8sC+BgTlQpdSm3FvTdmX+YRXTdzWF/?=
 =?us-ascii?Q?/+WuuXXza1XSeDi9VhW3BPD+i6M/KLhn0OnTQQvWctZrW3pLFjTXKyDB/17W?=
 =?us-ascii?Q?Yp4blu2WjX90VwjeZ/33hhu8aG9YoJHRtSoRDP8IbwJ2wELBXpJ6mSdAcbgT?=
 =?us-ascii?Q?0ATZjr6OOjkjXAGEJpl95FW+tZGUosqsYNv9bCfpcMprW7SvnNpcCZVAuej1?=
 =?us-ascii?Q?3qzJdGrnG6P1cOJmVZ5uHlPElW8mjAB8JQy+yc//DWZDo4D0JgidmXnNdTQ9?=
 =?us-ascii?Q?eIOa/1C3wEAwGR/5LPt7lFIcZ6yNkt6cLAOOeP/OzCHYppVoL62bAcXNsOBA?=
 =?us-ascii?Q?7CrCJk58MUbnaq9LSByDGth7laDy+N4k2aD2q62M1X9g1trfOyHYk6ung3QK?=
 =?us-ascii?Q?5OZAN8KczQFuALiN4lLJmQe45G7alMuCYDLpDecbOIbw8j7veuko5lk4TG2y?=
 =?us-ascii?Q?kvqE1D1WYnkE5tcJzRrINjTdNxxJdpU0lqhH9gx7ZHZCw7rlkswsLzcow9cu?=
 =?us-ascii?Q?JN6m/6J97/0MEGWUnA/zeKmiqDWuRxMwTajI6xVo4cGVuIfeVuFMjljrXeEQ?=
 =?us-ascii?Q?4KTgVMbW1yz/8Ad4YcNIduYyF/bo1OoCz3WEszxyCbtGmMGIzLxzywGwGaC0?=
 =?us-ascii?Q?4NMsCESurouJ6Zm2P8wif7zV6n6GjZ1bHVE3kBCxDDAwXEmKFaGXYDQh8FsE?=
 =?us-ascii?Q?5KNvj9ZiPk1PlJ8RHWXiywzFPWIOnA1MeMf+bVMCkw9lVwyfXtah9tH1+qbG?=
 =?us-ascii?Q?To7ZU8ocDSTjrYqJmRsVy011zRsdBUdSFaltyZ7b/7y0KInPMZ0EvoMQ8Xpd?=
 =?us-ascii?Q?yeF9YXZ81UlFOHMEp05+99wRLl+UnELjSAqnn6ZSar6yJdBloNHlfnS2rjBW?=
 =?us-ascii?Q?eqUJGpF7pihXM67AjqIBHJyKP2RRZdww/OC58+shj2y+o6SUfeTmUloUMo5v?=
 =?us-ascii?Q?JjMMZxQouz2j5KdiSvcJjhUpwhiR0rRzkR+zWIpRGrg8OWI0NcQOCzODQR6J?=
 =?us-ascii?Q?7mdP2TlRBfQHmFVQlLkbi2PQQJ2/iiuLDFAG3QiCgIFiy05ZwjtgU40/us/k?=
 =?us-ascii?Q?rq4Hcv+pL19SclsOw8RaE7Qa0n+GKuamDT8BfcE7chMs9MO+AfeIztgpgQRc?=
 =?us-ascii?Q?j0JpNFUW79AgS1N9qD3By6c86e5hiL6DCu1ClnEYm9RHV3MzduXzlVadwtTu?=
 =?us-ascii?Q?v2ctdahu7ovdOqYZaAmFtEzdiEqsFYaxD4G5ODNXn0/uuQXAo83xd12amsWP?=
 =?us-ascii?Q?S1ZBxdItBbKK6CaAxbS4X5Qjv1XDyrvus50FdX9fUFmvRhm2MCBLDE76Pl0A?=
 =?us-ascii?Q?Kj2v1Y8LsEII3Jwc18N6lFM6NlRUM8cRqbbxIJEu8oMNvXYnlWqJOOM95ZUA?=
 =?us-ascii?Q?Fsohwq71St8LECveE9GC2gpkZlyZcCM2fXuqZKo7JhURqAfYYaAzFUnwAMrV?=
 =?us-ascii?Q?uqr3x0tNFulz2o3WwstZZyU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04D1883731220542AC12AC126A7A06CA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Q8X1ntBMIArPu+LAkocIkSNkehTbLxGHxFVLpzIrMnVxQT6+kRry0491Alcj?=
 =?us-ascii?Q?hkIlhrvT3MPGprfpzYzLlH4QYgnkaDR61+pxrALxdz1AQZSMA2Fdb9/xLYWX?=
 =?us-ascii?Q?LFfKbtpiqQsxRd/vKkJEF8qdzh7JfcYLyGNORnkp7Z7J1UM6ZkBlLc5MlQEi?=
 =?us-ascii?Q?qvMvhYSHjj1HHLxGEFpGETBidY2NbMobfuSXz/o6JwQxJvGIhSWKBor3d3q1?=
 =?us-ascii?Q?q4X+ygl3ONRsgTpUeYNYy9QHOHcgyzYNp5s0gIDbEbIKbjI4C62fh5cIsrX9?=
 =?us-ascii?Q?OKTOBvwrP/WF7KM2/NEzAnUWC1VV3NtlFkEY42/WM2t+Adun/hCevNv/lkrS?=
 =?us-ascii?Q?mJlVkfodDcv4PdI8vIa4uAEmVa1okUWVuanVPllvr0HJwlkvFvgjixsiyovU?=
 =?us-ascii?Q?kITO9oYnTVofQGHOYiUSil3wXJiZLIPpw5iJfQnK5gExOI8CVYNsapk8u3Zg?=
 =?us-ascii?Q?7Ppcd7gglrVpjrgmCGk8H9Ep37hqGq77IWqH6TEExw6AnT3+I7duqKK71eZg?=
 =?us-ascii?Q?DzHGs77CkjfKnD7dFk1jebMktT5cBElsthh76HsUeEuVF7+2jNHmDkvvykkS?=
 =?us-ascii?Q?u5w/5XrebcFFw35P8agUoCT12cYqMwpLTR3kjHBRrHr75NumlHekhM5a8qQi?=
 =?us-ascii?Q?KuL5ViiXUWcg1rZQ+D0w1EUnJp/2pmr61YZcyicFHfbins6lt3BeeggXgstt?=
 =?us-ascii?Q?hpmuugQFLsMGwCUC1cQVRSb0aAGF0S16wqkwnseMsImHRLXBDWw/SkFcYZZr?=
 =?us-ascii?Q?NnBfqurH3s46RRpTe3maNydZis4gbMbn4BDEpNQgFfvG82V3kSuDpTBtdB/P?=
 =?us-ascii?Q?sbWMtsLOh1eQCYh/RRyPokrCH4O/tBUHAGgaAnmdpqj2pFUo7PiOyyyG/v8w?=
 =?us-ascii?Q?DAR8KeahV0yANyj78wY2OEMp3WiYhZ4jlwHRpLSJ/IsfIEIeVy/ucX9vc1mH?=
 =?us-ascii?Q?5HpoGN+cU7Tc9Flc0LOCfg=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20389a3c-e761-4e16-5152-08db9e52e8f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 12:18:33.5265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXm4ktrqp4ViZqqKbOyR0BqIhZFQP1PdtZlqQNOnE6VaUazqoPpTMnU5VunU0pZnpS73XKu1WcfektreB0S2RqnKlBpTjiAfrHbj+wq9usk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7968
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 16, 2023 / 11:31, Daniel Wagner wrote:
> On Sun, Aug 13, 2023 at 05:59:53PM +0300, Sagi Grimberg wrote:
> >=20
> > > Addressed the comments from v2. I also added cleanup code to _nvmet_c=
leanup() to
> > > make sure we do not leak resources when something goes wrong. I run i=
nto this
> > > while testing and all tests after the first failure failed then.
> >=20
> > The name of the patch series suggest that it switches to allowed_hosts
> > where it does that in 2 patches 11+12 out of 13 patches. The rest are
> > just bug fixes and unifications. It's true that any series will include
> > fixes, cleanups and prep patches, but this is too far :)
>=20
> I see your point. The whole series started smaller, but just grew over
> time. I suppose if we agree with the general direction we could just get
> the first part done (bug fixes and refactoring).
>=20
> > I'll let Shinichiro accept as he wish though.
>=20
> I am fine either way, just let me know what you prefer.

I think the 13th patch worth spending some more time, and other 12 patches
from 1 to 12 have consensus. If there is no other voice, I will apply the
patches from 1 to 12 tomorrow.=
