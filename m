Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6874E7E28DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjKFPik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjKFPii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:38:38 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E24FA;
        Mon,  6 Nov 2023 07:38:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpDFRaP1AhKoh2qT3Q01aETblVgS+LY1HsMaL0qc/zWguJax8vvjSTW/Ci1x4j+XNH3DKft8LALD1rBB8TOYccJjPU3aKZ376F7gZKV1rlB/h+SQJRk1gud/T6S82tiUKRu5hZdkkrosJOPO8toUFd2HZjx2DwLJYXGIPfOXa3DvojLtZLqdVUoG9Kj29CIRDhwf2tY95MDCMFENGHBkoQM671OVeX2Dquv27UB3oNtt5RFWAKIiZyVYIi08BMkckkC5spPiTGi2Y1OC83RUBmibLqNUV+fdmtRVFf6xzJOzmbMXNGTcvRhEv9tFcbNgETF22uwOCSSXPTc35a33GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Bj29JVZ2zmud50YwC3rk8EnqusnfP1hWSP2iFx5EmM=;
 b=XJMjKSVtMCH3Erw5Ba8wu12hpUwggQpl63pyFzC2uw45vsr0arYPCVL5Rn7rchxwu91N9O/F6S9145FMUgdyxO2UsuiGtnsm0CuIh6uw1nCk9v6V96RAeRhvilQ0sSnzFcak4z2h5CGmz54h2eyjLm8sOPbgDsxHURnwHgfPY1Hr8rd5gBHIQzi3YkyX+jpJrPD/P5WyPhZgy74NwsosNMHkD8aqPrtJ4Lev/AZFIQKQPzAHWhJm5rcJqIiGyP7SPtRDvAD2bhSQIrxptdIDB6prkp7YgwTSwo1Nd/qyBbdAtB7Qmxiwmos+mHCn6+kIXS9yH5RSgp3QyhyrpuQOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bj29JVZ2zmud50YwC3rk8EnqusnfP1hWSP2iFx5EmM=;
 b=WTROihwvvGt6jRQ0l5f1nfbHWtMquDhFzFwv4UvM1sFQmcXXlFYatWLSWGbAi5PZ93MukSdAsEfbB2qJAltnKTAaSSXQTx3HgLovonSOw0ht8XBuvXp80l8VgXf105Y7oVib+CZsIMrvvP586nCqGmbEDMQHjvzQu5+G1bbiDCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Mon, 6 Nov
 2023 15:38:32 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::2635:52a:c866:2576]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::2635:52a:c866:2576%6]) with mapi id 15.20.6977.013; Mon, 6 Nov 2023
 15:38:32 +0000
Date:   Mon, 6 Nov 2023 10:38:24 -0500
From:   Frank Li <Frank.li@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: cdns3 uvc first ISO parkage lost problem
Message-ID: <ZUkIcCAdDQS0n8A5@lizhi-Precision-Tower-5810>
References: <ZTvhEl+JcnhJXcrl@lizhi-Precision-Tower-5810>
 <BYAPR07MB5381F7224612F0C0793B6B29DDA1A@BYAPR07MB5381.namprd07.prod.outlook.com>
 <ZT/XkhOvbucxA90V@lizhi-Precision-Tower-5810>
 <BYAPR07MB538112FE4150BC19696D7613DDAAA@BYAPR07MB5381.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB538112FE4150BC19696D7613DDAAA@BYAPR07MB5381.namprd07.prod.outlook.com>
X-ClientProxiedBy: BYAPR08CA0065.namprd08.prod.outlook.com
 (2603:10b6:a03:117::42) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c844697-9477-4bdd-2d7e-08dbdede6e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqAw2zwB/7lfTmMHE/mUlc8NnqU7qB6i6+xeAKm8Fz1DvfG/9RvN18wn+jVVcHRlkF4T58rFSw9rzlgP9+dUycwRTUUrcPru3lvWQf4IVqmB2EsjxCTz2UIZVfqqQD5xw/PGsKxmqj+Uv0Yrxx+or+DrqH0+VPoYws6a4oFgpuMKzzWlMD/KSMwKoOGun/yXwqQKwR06n9EWW2+WgtM7LoiLvSZmzWmIlxAV2bKXHwL0hHknxD/4xDsGG3pO2vEoyw6HHBVYrT0rDl9PqtSZMZixXZB38RlGzEAVAbiE2/hx36G9NVxw1X13JbGc3RQ+Rj+rXRNxWP/57lFJ/6BfkAQPRmH+Fzg/Ckkmi9lNZu/EkNvDe4+Dsbiy3oWTdIu7ND9Km8t2KoNCdY0jxTlMKaWMatkfZX+LWzSz0xmYZyeahpCGwQzrx2rVvuxHqlSJ4o00cs4ZskgdYY8ub0I+dngw1HT3LCHTVYB0GX/BhP0lSGCeC0JPoegYF6gGDEV76C15msuPrB9jyyzDlF/I5hQnNhjNT+MIk8RSrJXmKlvPW5s2JN6Wm1QONfXezjqtI4O5jOhmadjNZf/iQT3wp3y7i4yfvZx0bV5u4WcpCsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(366004)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(86362001)(38100700002)(5660300002)(41300700001)(2906002)(38350700005)(33716001)(478600001)(83380400001)(52116002)(9686003)(6512007)(66946007)(26005)(66556008)(316002)(6916009)(54906003)(66476007)(966005)(6486002)(6666004)(6506007)(45080400002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Entdm5YBa7naOmzIdolxvpFPrFZEyM8TJPR1E7ME+DbqlwVU+zEmLM/qClMc?=
 =?us-ascii?Q?Wc6Qtb4sJ3lPOhfSiepqb9D84iDnUik/u7LJd+chQf8ZVJGkXwxXLl7zkeiT?=
 =?us-ascii?Q?UK8ilT7DQ9+/T9COLfNLrMZHtFAs7COi02TNnzJtLpag4Zs8+8CMrEh91pOd?=
 =?us-ascii?Q?25DhC3E3zMWTS7esOhOWYPQbstQ4LSY6bJ4Rlf3eSzU50oMk3ejxq+E6ixen?=
 =?us-ascii?Q?UJxOuDGleQbx/z5mh2skS3uk6wBVfmHRbrHW58X3AVN6XaENlBAVyFLc7pNU?=
 =?us-ascii?Q?hW9+n/rV9zFvWCEORfdHXIEIsRCuLztZ/RUhlMcz8gIRUvtrXSmUnt0bCMen?=
 =?us-ascii?Q?qhptyNEzJ3U///NyS4wPaglgMp+zSB01AOog8MQ4J/2v2N61BzkjY7f885WF?=
 =?us-ascii?Q?wO3bU/hQWABBLIofeDz4paICfmUl3qtYjjxbQNp8WIGYs5E//32BbVRRACBy?=
 =?us-ascii?Q?4C1bVgnv7Zke6FyCPusw7b7iTQ3j0uQeiE7zSOEeN0uQKyC1IN5P5qhcdtDD?=
 =?us-ascii?Q?HHcnyDAap2POTkOG6KaE6o5+JWpv9OqA3TgCb+sIzUVtmUed1xb2gXaPklU0?=
 =?us-ascii?Q?InAxHd6Kenf1aY2Z31aZodLXY2GjUpBlm+pxmYGRNdjyE67Jdw5mTNRpplW2?=
 =?us-ascii?Q?ot7aJSXJuF3v8ngrkyrVX5zbSWANusN0a5jOUZyNYAL9b2vCT+yfEopSfUm/?=
 =?us-ascii?Q?A5dywIhJPKJkD9j/3fnI9aBWowS8HhLTFWvREgLad6BpyP7RYn4aIuT4aPlq?=
 =?us-ascii?Q?R64T7w+dZoVYJuRuzXdZJF3DHOVkkXEncb85OtTWu23HwqsdJpVPjJNykGsc?=
 =?us-ascii?Q?sS6llpix6ym6gzQ9eCaZu1IC5dvAI5gvgMOCbB9kR049/PaJWKxrFXqZLqGv?=
 =?us-ascii?Q?nnnN5J8RocAtRJ5p9AKqXfTS5G+8Jz0BiV1TJPyUtuherqrYYLSw63q3F1rD?=
 =?us-ascii?Q?pfGS6fiXLtKa5xyjW3F3sIU2a7d/yetlRXsUqxapukVckrWVjp/EeyP63Hin?=
 =?us-ascii?Q?fwj8GK4kJIOh6H9FaBbMPj9XOUFIcLa4YOdjl+Kvx+9tU5gw0ZAzmGS9YTXa?=
 =?us-ascii?Q?ozg5Z3t6GR34UscdNVrEUeDs4XM9im813rUruXLpwXLkeZLuvOoZGw4tztpq?=
 =?us-ascii?Q?wl3PWmlQqBo+TbTgZx3nvSspLpmC6yTcLoJCmdEhmGYl7sOqYYqmDpoDT7Pa?=
 =?us-ascii?Q?y2hpbWhDoYuSZu0r6c3kqEay8mPxqXFvSvyE5UkIYNZFcgTPfYV105w7DPcB?=
 =?us-ascii?Q?kljamf8hb8FdTPSPxgyHVRWtmjodk60woClpsGTh91iHVoaoOZWnuT76b3OT?=
 =?us-ascii?Q?XUl0DOtWSXS3JYiGmiL2u70cDOT0j9nJaMry6IbHeCUwkeuKE6nsTb8SlOw8?=
 =?us-ascii?Q?OqsACJYxCgga7+jIAbSO9B9SDLHE084Ewx/N/jW9dmtmwdWeOHpOgoTBcxL/?=
 =?us-ascii?Q?3pKqJHxJBORF++PmqKVRTns+oDDsKayNs9RZmyA4TCot0S+Am1nlkI4xFBaU?=
 =?us-ascii?Q?fOpWzTQqKVCe5JxezhSeyTAoRMO/ZlOGc/pfIVhIb84hly9it6hnkp0/5JDQ?=
 =?us-ascii?Q?0rc8uqFjRkAeo5MWtbw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c844697-9477-4bdd-2d7e-08dbdede6e83
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 15:38:32.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQPS3BNqQq+La8jXiu3vpXLLdYA5RZuSp6fkXi9BLHjBmn3vV3JW345wsnWTki686nykzPyDFLzYhbGYnHWtcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 11:12:10AM +0000, Pawel Laszczak wrote:
> >
> >On Mon, Oct 30, 2023 at 06:34:48AM +0000, Pawel Laszczak wrote:
> >>
> >> >
> >> >hi Pawel Laszczak
> >> >
> >> >Recently, I met the problem when use uvc. UVC report jpg header error.
> >> >
> >> >Basic reproduce steps.
> >> >Gadget side:
> >> >1 -
> >> >	https://urldefense.com/v3/__https://gist.github.com/kbingham/c39c
> >>
> >>4cc7c20882a104c08df5206e2f9f?permalink_comment_id=3270713__;!!EHsc
> >m
> >>
> >>S1ygiU1lA!H1h8GlLnbS6vqklXm_2qGyinP638O62Kk2eLB9zeMkjAGXUAPYyPXD
> >L
> >> >FasSqYt16xq0RGT0Ff-cP4A$
> >> >	uvc-gadget.sh start
> >> >2 -
> >> >	https://urldefense.com/v3/__https://git.ideasonboard.org/uvc-
> >>
> >>gadget.git__;!!EHscmS1ygiU1lA!H1h8GlLnbS6vqklXm_2qGyinP638O62Kk2eLB
> >9z
> >> >eMkjAGXUAPYyPXDLFasSqYt16xq0RGT1ogOdRQA$
> >> >	uvc-gadget -i test.jpg
> >> >
> >> >
> >> >Host side:
> >> >	https://urldefense.com/v3/__https://github.com/thekvs/uvccapture2
> >>
> >>__;!!EHscmS1ygiU1lA!H1h8GlLnbS6vqklXm_2qGyinP638O62Kk2eLB9zeMkjAG
> >X
> >> >UAPYyPXDLFasSqYt16xq0RGT1MNlKiXA$
> >> >	uvccapture2 --device /dev/video0  --resolution 640x360 --count 1 --
> >> >result 8qxp.jpeg
> >> >
> >> >	It will report jpeg header error.
> >> >
> >> >
> >> >After debugs, I found two problem.
> >> >
> >> >Problem 1, sg is enabled. so uvc driver will use sg. each package
> >> >include two trb,  trb0 is 8bytes header, trb1 is 1016bytes. total 1024.
> >> >
> >> >num_trb here is wrong.
> >> >it should be
> >> >	num_trb = priv_ep->interval * request->num_mapped_sgs.
> >> >
> >> >because priv_ep->interval is 1, I just simple set to
> >> >request->num_mapped_sg as below patch. USB analyer show one whole
> >> >1024 ISO package sent out as expectation although document said only
> >> >support one TD when use ISO (Maybe my doc is too old).
> >>
> >> Support for sg  in uvc has been added after upstreaming this driver,
> >> so the driver needs some improvement.
> >>
> >> Calculating of num_trb probably will more complicated change.
> >>
> >> You can see how it is implemented in
> >>
> >https://urldefense.com/v3/__https://elixir.bootlin.com/linux/latest/source/d
> >rivers/usb/gadget/udc/cdns2/cdns2-
> >gadget.c*L412__;Iw!!EHscmS1ygiU1lA!EZS2StTKnSzdCT7N5B1-
> >l8nGXQgS63KwgcGINcpBC8rnRJu2u8ryV1UjwQb6YfwYLPq9T_115KC5qQ$ .
> >>
> >> CDNS2 is different controller and support only HS but has borrowed the
> >DMA part from CDNS3.
> >> It was upsteamed after adding sg to UVC.
> >>
> >> Regarding TD, it is true that controller can support only one TD per
> >> SOF but this TD can contain many TRBs
> >
> >Okay, great. I can work a patch if I can resolve problem 2.
> 
> At this moment I don't know how to resolve the problem 2.
> I'm going to recreate this case on my side and try to find some solution.
> 
> Pawel 

I post a sg ISO fix patch, in case you need it.
https://lore.kernel.org/imx/BYAPR07MB538112FE4150BC19696D7613DDAAA@BYAPR07MB5381.namprd07.prod.outlook.com/#R

It fixed my case. but android looks like still issue. Recently quite busy.

Frank Li

> 
> >
> >>
> >> >
> >> >diff --git a/drivers/usb/cdns3/cdns3-gadget.c
> >> >b/drivers/usb/cdns3/cdns3- gadget.c index
> >> >69a44bd7e5d02..8cc99a885883f 100644
> >> >--- a/drivers/usb/cdns3/cdns3-gadget.c
> >> >+++ b/drivers/usb/cdns3/cdns3-gadget.c
> >> >@@ -1125,10 +1125,7 @@ static int cdns3_ep_run_transfer(struct
> >> >cdns3_endpoint *priv_ep,
> >> >        struct scatterlist *s = NULL;
> >> >        bool sg_supported = !!(request->num_mapped_sgs);
> >> >
> >> >-       if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
> >> >-               num_trb = priv_ep->interval;
> >> >-       else
> >> >-               num_trb = sg_supported ? request->num_mapped_sgs : 1;
> >> >+       num_trb = sg_supported ? request->num_mapped_sgs : 1;
> >> >
> >> >        if (num_trb > priv_ep->free_trbs) {
> >> >                priv_ep->flags |= EP_RING_FULL;
> >> >
> >> >
> >> >*** Problem 2 ***
> >> >
> >> >According to doc and my observation, looks like hardware fetch data
> >> >into FIFO when get SOF, then transfer data when get IN token. Each
> >> >SOF will increase TRB regardless it is ready or not.
> >>
> >> Yes, but this fetched data will be sent in next  ITP.
> >>
> >> >
> >> >When gadget complete equeue ISO data, so SOF will increase TRB
> >> >regardless if there are IN token.
> >> >
> >> >   SOF       SOF       SOF     SOF  IN    SOF ....
> >> >      TRB0      TRB1      TRB2      TRB3  ...
> >> >
> >> >
> >> >Host may start get data at some time after gadget queue data.
> >> >
> >> >So TRB0..2 data will be lost.
> >> >
> >> >If it is audio data, it should be okay. But for uvc, it is jpeg
> >> >header, so host side report error.
> >> >
> >> >I checked dwc gadget driver, which start equeue ISO data only get NYET.
> >> >
> >> >I check cdns spec, there are ISOERR. But it is never happen.
> >> >According to document, ISOERR should issue when IN token and FIFO no
> >data.
> >> >
> >>
> >> Current CDNS3 driver has disabled ISOERR. Did you enable it?
> >
> >Yes, I enabled all IRQ.
> >
> >+       if (priv_ep->type == USB_ENDPOINT_XFER_ISOC && priv_ep->dir) {
> >+               priv_ep->flags |= EP_QUIRK_ISO_IN_NOST;
> >+               reg |= 0xFFFF;
> >+       }
> >
> >Supposed ISOERR should happen even DMA is disabled.
> >But I also tried enable DMA, and using lenght 0 TRB and link to loop.
> >
> >Still no ISOERR happen. I can see TRBADDR changed, but still no ISOERR
> >
> >
> > irq/447-5b13000-200     [000] d..1.    78.662729: cdns3_epx_irq: IRQ for ep2in:
> >00000804 IOC , ep_traddr: c0086018 ep_last_sid: 00000000 use_streams: 0
> >
> >	 ^^^^^^^
> > irq/447-5b13000-200     [000] d..1.    78.662851: cdns3_epx_irq: IRQ for ep2in:
> >00000804 IOC , ep_traddr: c008600c ep_last_sid: 00000000 use_streams: 0
> > irq/447-5b13000-200     [000] d..1.    78.662975: cdns3_epx_irq: IRQ for ep2in:
> >00000804 IOC , ep_traddr: c0086018 ep_last_sid: 00000000 use_streams: 0
> >
> >STS is 0x804, only IOC set.
> >
> >Frank
> >
> >>
> >> >I tried below method
> >> >	1.  Delay queue TRB, but no ISOERR.
> >> >	2.  queue a lenght 0 TRB,but no ISOERR
> >> >
> >> >My question is how to delay queue TRB to ISO IN token really happen
> >> >to avoid lost JPEG header.
> >> >
> >> >Frank
> >> >
> >> >
> >> >
> >> >
> >> >
> >>
