Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5887CA0C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjJPHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjJPHgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:36:36 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2105.outbound.protection.outlook.com [40.92.49.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F943AD;
        Mon, 16 Oct 2023 00:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2Uu7LHoZRjgihVAp/FmSMVSRoIHguQfl4167T8RrV1GtYUca+d0KbMskKD39yV0QGIXSXUm/2OLB0yM2zCXHt0J4dKMRp8MxrOevLenxx7DeOA4+EeZYh4F+KvK2hJuCMgnov6qJBnQTApm4vlUZnt1tGEr77iydeFi5b1J1tB+iri6klfn3aZpYOOEKmJOQBxII7QDE7sn24EDtZQWsHM+0fdPzB3pR5qRM/qzwh+JfBt8QT1wHbWK9K+b9pRpWUIpu3w6kuAoaUVb4W4/kntmrNJTcJ47lv4Y+t0NiIAV7TKqMyMobAh2ZInxbbo1Cvcm+8A8IO3BlB8ZKT0YVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml0m30A8vV2+pI5CUMwyXBGbFsVZ2z0i8imtzH1pCDI=;
 b=aynvOoqnh+6e79/HwD39SVm7LK+YuqDGA6pDaRDprw9PSIDTvtjN9imLdO8WtqaSZQL1LgGypQruWCPf/JuacWWZt9zPl1s8vhxYbLYDaTI1uYN6mOZn1JIelHtYuBNNvsMHmg7I5cblscJpYM89MGpK/0nUPC6Vv3xw5lHZG8LwjqyG8MkqxaybKFbE1SDk/DYbo4mQs1/6BmAwQMTwm8CIaIt6ZYMi6l8rX9Q9JWof6U6IHJdZ+7Aj54JF7UNFuOGIAmysnXLOi/qcdhzaNjLdJfDAORJaNXCHxDhDrZLJf3kTLRo/bTTifigfSDNgs9V7PqmIjzyQD2KKI+jFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by DB9PR02MB10017.eurprd02.prod.outlook.com (2603:10a6:10:45c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Mon, 16 Oct
 2023 07:36:32 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 07:36:32 +0000
Date:   Mon, 16 Oct 2023 08:36:29 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 7/7] tty: 8250: Add Brainboxes Oxford
 Semiconductor-based quirks
Message-ID: <DU0PR02MB7899655B888A15FB0C8F68F4C4D7A@DU0PR02MB7899.eurprd02.prod.outlook.com>
References: <BBPatchesV3>
 <20231015171141.3309-1-cang1@live.co.uk>
 <DU0PR02MB78998961117757F4750A3AFFC4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com>
 <46c2e044-446c-41e8-aa64-7ab581d4bb42@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c2e044-446c-41e8-aa64-7ab581d4bb42@kernel.org>
X-TMN:  [6zx5u29qbxsWLoqYDfmUz7W4U4KuPWQL]
X-ClientProxiedBy: LO4P123CA0085.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::18) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZSzn_TBbNAKEqufE@archlinux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|DB9PR02MB10017:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b18493e-dc52-4846-263f-08dbce1a9e4a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JsLinEprTxs50Wizevuquxc1fwgbTmqlp+UBpX8fNxBB9gCQdOTAnmWF1LByIV7JmL32nsuUte3FRThf7PqFJmGQOEK5ul4c6pNFhdsfArusMVCD7EUA1YR7n5C36ZWM9m8LB8sp7GzX2l9yobbIBGMhzjMuE35TAQenqmv31hOSnpe/GRuJ1ATUehYl0dAlrV+Td2Uv6E7SNj3ipzxUgW5gdR49hxIJcpdwWjpqK/15QxCfli0xpFjujLQPSHif31/9YcHPH/8A0pWmR+usHgLMfHv10hQ5ebZJawyy5fZVjDZ8Nd1UELzGBjaQ1eib3aCwIU+nmIpV28deYS+yoc7EsNDSoHN4pyFIp7clYLhUzDwci3Bpd0TkTtoMllMHky8fKtc6ZdqR+wi/Fz9XB8irzoXEZOWZac/HVta5drECrLZFL+qJXO/exDU+0JhaEotknJXTxto3jSsKnyM7P/nWHhSBglq6ZRfuElw8DIa3eWsBtP1jUu2Z2qyrBcF+NinC7wPooQ/ccX+wVeimxwS0jne6tQ/vIZx1DQCMG9q5xGjW2zQBu7iR+oVhx30W
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CnMEIEqJsflvsxr5RyHlO1HfwaVULSltRBv3/PbT2Q5Sq83M4DqqOo7wu9W/?=
 =?us-ascii?Q?PRWinf3azk0hnyhZt1utPYDleqAwakLhZWfE8O1WCVQELpseLvn8g8YNuhwb?=
 =?us-ascii?Q?GOVSBMyhFs4BAnIrnjHneG9BccdvoaMuFBHL9LVABBuHB3dAIFAeytA8Yiqq?=
 =?us-ascii?Q?496BgFNzQ0+OJo9tRBYLoRHmh4MRaqasUHytqP61MYrijA8tQQbV7rZXPBgO?=
 =?us-ascii?Q?y6pR+EtgfVhtnNxivGvypXgN7VNMbBk7OczaTZLGZoVVKqIIW1Ul29T9sOGF?=
 =?us-ascii?Q?MqpQMWWI4eRqt9wg4nuYBbdBt9wUUpZn2TJiH3eYjkhwbW8RfJpB9j8TZN9k?=
 =?us-ascii?Q?cU5+qB31inN1Ej3E0BeQnpaKRcq2sesY8ShGJAb+9XgjRNAgdLcCkWkFJIOr?=
 =?us-ascii?Q?Lh+p16AOzGFj1YljNL6UD6mUKjVQ+Iuq6FvP0qDdus4IJ5vi3OXuWvg5/GO4?=
 =?us-ascii?Q?wMbCMJ7TpX074NRsOFaaMeheyEGrUAy+6aptH3dQIFTETOTFatA+w+E4fsJB?=
 =?us-ascii?Q?K9PU1wXdFzBJGdWWFvhbsjGRXCI9i7DGjP//Vf1TA7WOGTZB86T+Xc0fv86r?=
 =?us-ascii?Q?huCDtz9YVus7on2KS131hKEopQgnnInO1H9Lv4UcPYD4rkaj5I6g0gaA6lqj?=
 =?us-ascii?Q?vZnn3234Ipap2yUl3HOV1Z3uC5WC+scv72umBh3j4/NcsjaXx6LKoDorN65i?=
 =?us-ascii?Q?u+ho9cirDPlHarvKlJe8OkFXW6cdAFBnptWAFiUAci19AJvVPlUUTYRnZZLQ?=
 =?us-ascii?Q?Gmyu6RIvsQvfhkAVp4GoM18E9L+gMlPTAzxpqdWNw73iSiJt/Not2UcpBAqq?=
 =?us-ascii?Q?BhMC+K0ZwMkAa2cD4v5xlta2L9Zrf199woAzAUiq2WLOvQYHCTYbrhuDcm8+?=
 =?us-ascii?Q?hUZYXl0eHrkWRzLOmtOx+TuhiJnxk177x1fwhPyceA4BFvGpxGWoECMXZqny?=
 =?us-ascii?Q?FZltIayqc7P7rU0a5RxrPE3HbNKF2VemE8ujsIaCqnwVXNmiNb257GNcxoEX?=
 =?us-ascii?Q?Kl1ioJlT9V7wtiXUOazGIPvK2ma2WxYcEqcytrMbjpenjhPTGnZO+5T2KCW+?=
 =?us-ascii?Q?KexnR7dTE4hp+pMGx755+fom4avs8eL7Y1B2UuC80tHBMcAQ0ToBjOb4Pr95?=
 =?us-ascii?Q?Td9R+ApsoGGTEyNTUo50A9ULO0YEGx8CRLpn1w1F1sqkdsOV0FwQyPi7kWMG?=
 =?us-ascii?Q?2D72hMgzCKETsloUXpLe/CAMmVr8XZiv6Jd7ag=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b18493e-dc52-4846-263f-08dbce1a9e4a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 07:36:32.6149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB10017
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 07:44:06AM +0200, Jiri Slaby wrote:
> On 15. 10. 23, 19:10, Cameron Williams wrote:
> > Some of the later revisions of the Brainboxes PX cards are based
> > on the Oxford Semiconductor chipset. Due to the chip's unique setup
> > these cards need to be initialised.
> > Previously these were tested against a reference card with the same broken
> > baudrate on another PC, cancelling out the effect. With this patch they
> > work and can transfer/receive find against an FTDI-based device.
> > 
> > Add all of the cards which require this setup to the quirks table.
> > Thanks to Maciej W. Rozycki for clarification on this chip.
> > 
> > Signed-off-by: Cameron Williams <cang1@live.co.uk>
> 
> AFAICT
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Thanks Jiri. I'll take your notes on board and see if anyone else has input
too before v4-ing this series.
> 
> 
Thanks
Cameron.
> -- 
> js
> suse labs
> 
