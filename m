Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124907FA493
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjK0P3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjK0P3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:29:08 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457D019D;
        Mon, 27 Nov 2023 07:29:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXYANBbNHM7VweXHp5cuoMu9Wl+B/VT9akN9jPH/rd4sS4SjUEC1CfL2BOEOaZyB49VsSlNoYCWqCsrdrkjIUM2/6NPP5KCiwDVM553b9oOCg9tKGGh78xYd4n4gIM8qKDC/FrPiq7A5609ym0T6ggImXZupbZq6YWGEfyjLR+NqDqtY7ysh3JsYMZhUajxZT7PT7LGnDXecDDLDetmXvBfvDbM282hJSepJAiuQ6tKC5IGXOORiVppTk++27PcUgj9G0UIY+CPaEjQGJJ0y2cBHobMiQ+Ky2VvG1XaGzFfSCbxqKDC/02R0ANAjXTcJD+KrDNqHX3y0nVavvSelAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUWltBBsIZE4eUYAIWtqNILb3mSl1d9ipSKOn96uw9k=;
 b=hviesataSvTUlpOwVF07DH1ikyLKM4WGEForUwTh4YjC4fTPtpuBSt2Em3DJA11CtTpQFGENOjDNS3NUwmLiXafj4VSFPR0nI63U6qX2AIc9DiAYTzZwAedLwNRgW4Bf0EIYBXZWp/KUJnqCd2zATFpOuXuF7uQ4YklHAwwL2BLmAMSnwpQFz87fuBdWqyXYUD+RU8iPE6GOhefd8yB9b80A3YvJ1aakUTqhn4LlNEmtU4COtMu6kzEKNC/CP8ADN3Y05qSk/sWmWTKb5IXfbYTs2jm2YgEGNdt0na59OrucaQgBM8w0CoNmTnBi43sGLWy0+7wDkmr4FrI+emIenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUWltBBsIZE4eUYAIWtqNILb3mSl1d9ipSKOn96uw9k=;
 b=AahtNgUD7e8gc8PNQqKMHjvbYHZ0KLdBJ9pqcysv4lBqdkSYLMXLTxip0hC0lIWsfIWlW45ZsJI9XUHT5jXPGLRargoWeVL9g+PRYx4glh+FTLD/cnzEpPtLJsYeTnlwMyuznF8ntiy/PIPlLA2IVscCqokOz7A5607O+pvFbpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AS1PR04MB9456.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 15:29:07 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::6410:9a52:b833:5bc1]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::6410:9a52:b833:5bc1%4]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 15:29:07 +0000
Date:   Mon, 27 Nov 2023 10:28:57 -0500
From:   Frank Li <Frank.li@nxp.com>
To:     Peter Chen <peter.chen@kernel.org>, gregkh@linuxfoundation.org
Cc:     imx@lists.linux.dev, Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: cdns3: skip set TRB_IOC when usb_request:
 no_interrupt is true
Message-ID: <ZWS1ucR7dXs153R1@lizhi-Precision-Tower-5810>
References: <20231027183919.664271-1-Frank.Li@nxp.com>
 <20231031084521.GA1948529@nchen-desktop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031084521.GA1948529@nchen-desktop>
X-ClientProxiedBy: SJ0PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::12) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AS1PR04MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad2a7af-da0e-4ed6-5217-08dbef5d984d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fGPnU+TxaVY+JlBCnxTkf6H77Knt+pi6gZgW2TOA476SU0SDhJqxleUk1MxtIAVyzwGWqqVsdCiVrnXMMEBbNDfplDPxMQpO+wS9sWYcZHLNN5xFSmsv28tA658/L4GxTWRgkmAcvksPp/TmGIYY2x4qIdZDV5BHfgi//jn98ly5xFRhSp5vEh7wsVYvhLK3fKCj4aBEjHQw8SHbh8RZwSIhujyTY9YRdPxjh1EIfEws3NQxpsF9kRbAUber9dpCrdLHWOEgCqm09j44ENSwk1hZOzvCG6UB9ureEUIMplk2QuBjxD6DpCPt6xoq/lm/kVIvxMoo9y5i6lI9wqlWuWGGj+uSEHCwVeNSfbO7uAUFmuqoHkaphth5dLOGzCOlYFy/GZGi4g9jaxUugP2IQKspMi6jz+QJzKpUR/BXdzUFFrlVd8brT/07DVabqXWwb3sWakP4sMLUg0SvBamoxLL/d5JABZHn91kSoF3BcYp+MytAjSoyJPmWxWIGN8dVIIOy0N+RVLxnfy/zhx3slxtxN8dI2d4Lt2lOLUzJ+BM6dWWxD9gErIy8l05XBYpL1Mb4s0nZxqIrw9IVoY+xPUMmihtbUZAzcBtbsOTMSL7dyK0HwOCNFRTTvH+VX7m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(376002)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(33716001)(38350700005)(86362001)(54906003)(316002)(66556008)(66476007)(8936002)(8676002)(41300700001)(66946007)(9686003)(6512007)(53546011)(52116002)(6666004)(6506007)(478600001)(6486002)(4326008)(5660300002)(2906002)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gwd4fPMcATdQDWFGRtynUJdrVRVcmS89LBa/JWFi89zamPtrtT3tmnaG65yD?=
 =?us-ascii?Q?wcbK0VTICdbJsEmbeY0up8cfNUUUWkjizOO2AZI0oGcxmcXYfTcWWa0tYO8/?=
 =?us-ascii?Q?ZwZTxPtC7fF13RbxdsIgRsgaboTiUDL8/TwLg7MRdeH3CNF36sxJlfLrHbTa?=
 =?us-ascii?Q?zRzbIxh2+Ls9DqbjtAlphbkbGxqhUoo/TK2v5KiRMRtB2i+J+V19OXJxxEE1?=
 =?us-ascii?Q?GxCmceU7osFiNy38zb5zNQw2EsY6jKN4EYHMEUcdBaug0gbtTsGTKDvjthsZ?=
 =?us-ascii?Q?k8A9JB+DW3AAFuZ1BI/wNA2Kvj9zpN98GM/v69HErHR/hDL+QXQxvJ3mFZ8a?=
 =?us-ascii?Q?/7PDD11IpsC1pymk9UbqofxoJQrsmastwqsSAr45LblUzjpUOji+mph8NsXG?=
 =?us-ascii?Q?FJwlsRQeIqFbYnAm+lPEfoQSaZmmPU4Ontz6Wn1D4q+9GZK1J8yJfMIOqX45?=
 =?us-ascii?Q?4QavtBEivPTCT3TkYp5tEJY4deOAY3S0Onr7aClHLyh0RIQ9ekqgzokOzQ+s?=
 =?us-ascii?Q?MJtF8gX0QZ2Crc9Db9KD/T3YY3wNVvoSvyapLgGz8SBV6Flr6Fd+Mh+oH2T0?=
 =?us-ascii?Q?zra/1qxzQGjMOaAgJLwvFpX83A3fX1ElrQIduHyL93SXzD6Q9Va8PgQBspaf?=
 =?us-ascii?Q?HUYDW6QcMwpltzemCZPKFdqR5xgC7Mi3lY9+xENOsVcrzI1abn3Bf8NB+AC7?=
 =?us-ascii?Q?aVfEm0WxFy0HEex3qH+tzSidxJ1QYRkVyxHGeWvyc/t4HddXxPUoXx5IEe0v?=
 =?us-ascii?Q?Ty+724W6y4wylovQ5xgErA1hYvdyelzowOMnnG3pO8ZkVwQDoR/vB77MFNjn?=
 =?us-ascii?Q?XTrWLXgFINWfz46pkfIY44JgNRxIdhjgWRk7oNWKN2vsVoPdRsL7cVbII4oV?=
 =?us-ascii?Q?i9yotu4ZAsxPbkbw/sU/vgYUz55M7t7y0EodzenCKZXWJNv/D82XP1af9Cfx?=
 =?us-ascii?Q?74UYQlHAUcG+3mIE2jG/Fxfb0s2wvNtuXONsHuR5rRzlol5wMLXVf9gvkysU?=
 =?us-ascii?Q?chjSLlEPiGs405QSIbZgG6f8B4kku4ExS7XF+V5nivpL2wsxuxKii8Ndlt/5?=
 =?us-ascii?Q?osWsGN/OOnnL77Pz9R6U28I6HSdOxbqzP/eJk1eEOWdfQMp/MGM3IpPXI5VE?=
 =?us-ascii?Q?Au1oF8nhZn4ByV3b+DKCOon1BDCL7qwrQe6zDl1C9NDTZDqDbDgK7mfVl1uE?=
 =?us-ascii?Q?tYl2/j+lPWfjyhX73XP3HON1l1nb11zrB4vZj5GsT+rAdAY3PS0Ph+7c3HKI?=
 =?us-ascii?Q?OPcQxXqIMZA89AEKszJn+FiZcZdBnzPqIPoakJjTXN0mnGJuPpRyCPLVDaE5?=
 =?us-ascii?Q?c996NhNzlllcozMJnlvh4jgV0CHpXXU670UWjLmfDFQZtwO1X6p29/BIx0W1?=
 =?us-ascii?Q?i8S1CUEzpIf0WX/wgWoDz0q+09vHaJXwl5KbsCizu2jfdii8q8yAqKecYQio?=
 =?us-ascii?Q?5Q2tlKie951JSoI5KSlI6tkYYjNA3EN0wrHDDPqVcy9sTIHLQcZHriD1jR89?=
 =?us-ascii?Q?rOYnYanbu659ZT1/kQFsMbwuSIXkbt9TWl8dsASNLz2nlqd4GPSrnzxkTZ8r?=
 =?us-ascii?Q?absXwUl+bxIX/RtZ1S8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad2a7af-da0e-4ed6-5217-08dbef5d984d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 15:29:07.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vndQcXH6hQcj/8C9sHW+tzGSTsAZ0xftpOD5JRMEWBh8VdkW0rBRpeR9Srv23QsdsFbAqtzEV9WpmuswC6x3bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9456
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 04:45:21PM +0800, Peter Chen wrote:
> On 23-10-27 14:39:19, Frank Li wrote:
> > No completion irq is needed if no_interrupt is true. Needn't set TRB_IOC
> > at this case.
> > 
> > Check usb_request: no_interrupt and set/skip TRB_IOC in
> > cdns3_ep_run_transfer().
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Acked-by: Peter Chen <peter.chen@kernel.org>

@Greg:
	ping

Frank

> 
> Peter
> > ---
> >  drivers/usb/cdns3/cdns3-gadget.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> > index 69a44bd7e5d02..cd08897f8da8b 100644
> > --- a/drivers/usb/cdns3/cdns3-gadget.c
> > +++ b/drivers/usb/cdns3/cdns3-gadget.c
> > @@ -1124,6 +1124,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
> >  	u16 total_tdl = 0;
> >  	struct scatterlist *s = NULL;
> >  	bool sg_supported = !!(request->num_mapped_sgs);
> > +	u32 ioc = request->no_interrupt ? 0 : TRB_IOC;
> >  
> >  	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
> >  		num_trb = priv_ep->interval;
> > @@ -1233,11 +1234,11 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
> >  			control |= pcs;
> >  
> >  		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC  && !priv_ep->dir) {
> > -			control |= TRB_IOC | TRB_ISP;
> > +			control |= ioc | TRB_ISP;
> >  		} else {
> >  			/* for last element in TD or in SG list */
> >  			if (sg_iter == (num_trb - 1) && sg_iter != 0)
> > -				control |= pcs | TRB_IOC | TRB_ISP;
> > +				control |= pcs | ioc | TRB_ISP;
> >  		}
> >  
> >  		if (sg_iter)
> > @@ -1268,7 +1269,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
> >  	priv_req->num_of_trb = num_trb;
> >  
> >  	if (sg_iter == 1)
> > -		trb->control |= cpu_to_le32(TRB_IOC | TRB_ISP);
> > +		trb->control |= cpu_to_le32(ioc | TRB_ISP);
> >  
> >  	if (priv_dev->dev_ver < DEV_VER_V2 &&
> >  	    (priv_ep->flags & EP_TDLCHK_EN)) {
> > -- 
> > 2.34.1
> > 
> 
> -- 
> 
> Thanks,
> Peter Chen
