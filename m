Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CB67D4D87
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbjJXKSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjJXKS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:18:29 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2027.outbound.protection.outlook.com [40.92.74.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6A0BA;
        Tue, 24 Oct 2023 03:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d59uDYhqDk+cR9DJjcEURL7i4ojd27AzA5VEGNZo4qVBBihnyUT51tOEmwwH6SoQVkKagCn2yG5xGtwtMqJy9XS3dy6xzs4g1zEZa/QbRcN5zkfOrWR88oC+3NYWre1JWsmCn8UDlo5sjQ59AOTfcOu1ZPDl+12uWvkSz14meHj2VulgqJ1ksblh/G5cCtX6p7B797yFSmvhsDyF/sRPxF79lVyAuhP+KBb0X1yc3PE+CkZANx0rGtd0iiUpWerCHFITGu9iJZFhqaY6QBdeWAj5sz+F0BFBAiVgThIDig9Jj8NDglYKl0gEOFSVq6vNLmtdtMGCHBrESNQLnk83Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0Bh33dda43pddy6wY/BZySSmOhNHRFbKSmJJ6H7dWw=;
 b=WU6nqUM/bENrvJrX/9veX9aIhgixyxnRkIparR8Ld7YtRt7CAH5K5e5hQJkehWu7BjippDjXibbljFOHU3XCxB6JQ+wyV3XFn3II8E2ToDpWokYENB3x/Z69+AkjW7tL3n1lm0cDuWHLll9zdKpKHKJKVAQ1Og7x8Qs8FssX3iilhB4PTy9piVLSmhqJy0OLRY0cJaOwRi/tIpylqrc3M0CzTqKafbG775907hkrf4GTlOJeDKyJMXjlGPq6EmoGTTOa/r5hoNzeQfm/lkPewLnZHzYTo/y2vJf3w8baltRB4qFsfG7aIEbnDFrvctiPG/8Qe//j+YoliQlRJOtoLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by PAXPR02MB7887.eurprd02.prod.outlook.com (2603:10a6:102:283::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 24 Oct
 2023 10:18:25 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 10:18:25 +0000
Date:   Tue, 24 Oct 2023 11:18:21 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ilpo J??rvinen <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 06/11] tty: 8250: Fix port count of PX-257
Message-ID: <DU0PR02MB7899B6CC10D2429CF9DB4C4FC4DFA@DU0PR02MB7899.eurprd02.prod.outlook.com>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
 <DU0PR02MB7899C804D9F04E727B5A0E8FC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
 <f21a942c-5f1e-3c1a-945c-358632edb188@linux.intel.com>
 <2023102453-startup-corrosive-4b7d@gregkh>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023102453-startup-corrosive-4b7d@gregkh>
X-TMN:  [AHb3ujkmovsZnyDPjcdxYuypVu6Qeq87]
X-ClientProxiedBy: LO2P123CA0034.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::22)
 To DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZTeZ7TOFdNx_4w0V@archlinux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|PAXPR02MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d6a258-4756-4f27-1338-08dbd47a8ea4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4i6IMmg7o+TruhmJaJxLfheQRKb+gvS2wFxJtg8Q80RLQ7W/ndWuDMLhEJWovzQNuXZLQCensyiUVr9GA97Li1Y10Y8TXVc/zVnjFPOg6D0JRhZZ5S5HvPpo5O4GAuPfhqGZiUtALhSCs6LTvgnW043wVT5Fn6Ls61G1wF2Wb7PjpuYYSEh6fOmLN2br/wRZFm+Sn55cMNtYUyoOLo6AnB10ctRpq/+a96KZHs5KcWeBru4j/B2PVC5rQVCFoNjvEdZHeHUQ8nGVbQnn/RWbIqPdnqdLFYzjZgFlel6nXYTkOX5DFayFVTXRS+BPNHlCwFzqXKkkPAZnsfm11wpCnn0LgCQxa9VZItmoJA1HWeBxkCuQTwHk2nKmMxGBMRsp2DRNZb7+mv9pKhEUIoxSvpPyxscJvCGSVt+q8jirym+pb5qQdMFnxkIxnsCyAuQOvbNC4yYNhdMAhozy0TWGDUb/vV3uU4b6cCYjkFMrYv+qNOmU97qhb0MaQyRWwZWhf0sR7BYWQMT1c/MVxqwLgL60BL2I6jHiGtYk55ptP+fv2aSihW6UhS2C8kB1B8+n
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2qwFzZ6JD6DggThnFTP99CBKyNVygG5wW/nR0Uo716KFv++8muMpS2mMiu?=
 =?iso-8859-1?Q?KFr7+j+jsOVpVg2YWje4vrPCxPg+/RBimhmEersGgb3AMdR9PNWTGwk2LB?=
 =?iso-8859-1?Q?423OU8ovokYgYnoyxkmOvVnQbBlVI8CbY93C8hPpnYaSmUMiqpYIG+Nhgs?=
 =?iso-8859-1?Q?StAAqD+Ta8bDU+I11XK5wC9adkwxn+NmV+6XD989hKYBXyVlwJqZ8QDLH/?=
 =?iso-8859-1?Q?6bGoFrZXbfzz9sYT2CoEl7On363soSvpSAknYi2bxcwegTfqKxY4jo+MyL?=
 =?iso-8859-1?Q?MrDxhyzhzYjuYmzhSC88pICVe+FsVNsIYgwbHXS73a0MEvKly8ELA3aILV?=
 =?iso-8859-1?Q?IRjFNX7RCMiva0Y9vxc+zGT+kgob9TBsUen02c7Vp3dlFAEbflrHTxWfcU?=
 =?iso-8859-1?Q?cLoG2J14rtBq0lewp2yJCJfA/bGeLdZPS3x9YnPdSKsa8iXdUfmln9wkf8?=
 =?iso-8859-1?Q?pm3xBn8Nqj4hPjOSQ6hYoHih3UbCTUIEitkfjCbh5Dt7wI5vPrnGAbwCd5?=
 =?iso-8859-1?Q?fix98Fp0cAsst4BorMdyTPhH3jgW3V7yIn6Ui/6l9bW0ZLxFQf4h3hoIx9?=
 =?iso-8859-1?Q?XaHae5flGlJxc2VEV9KOLlMWXOGZyGl+mkIGKF98Qtw1aPLniDmvm5nn5C?=
 =?iso-8859-1?Q?cVouic8YueonL2QsExQYdqCMkkuqx1VFJqxReWJCPT4vdwA2s673Aq3Q0z?=
 =?iso-8859-1?Q?spSSYgy2WNHfDkQi5jd29E5VCHIU8M2DaspFeJK6nNbDDpZMdLe9B7RISz?=
 =?iso-8859-1?Q?Ro1v5a9uMIL3Tk0cb1+x6pEX25A813tYGnRg96z43ACJEn8nL5g88hXrVz?=
 =?iso-8859-1?Q?OrORVyiUaKKykXDbpPJD+uliZFWAVFBzxSgW1RcFcx7iyns8bJm2EuQorJ?=
 =?iso-8859-1?Q?L5IDvPsxMdyEgS9SZaZtfuLrfJMmDAr2/zlHAZ/TapU3dMu64FXtzzEDDF?=
 =?iso-8859-1?Q?9rgDt1vXP0BbdCgGJFzT+B7hO1ITIdV4G2UsDz9Gk3OdHX9MoLVxNnTE17?=
 =?iso-8859-1?Q?HehEbwAwoYA02XUEmqr05W8wZsiSw+8sPH7Tew4ohADIAKovul3Sz223Zb?=
 =?iso-8859-1?Q?7a665s1f4DuSWEaVU8xAfMcWK1d+30R6Z6wLwTjP2rFl+UFMQ0uSMhA4Hv?=
 =?iso-8859-1?Q?Cg78ek5viVMTDjHMgQSwxXhtfQJnXkkjti+fXMOkXSXfVjP12iwSO54F7J?=
 =?iso-8859-1?Q?DcAJSyfLVvVy0cGT99MbdjtZOtAnP0xqefYcvthS8Ek4tlqrM1l3wv/Xu1?=
 =?iso-8859-1?Q?4AnYRIyAzgsTJz0A0dsA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d6a258-4756-4f27-1338-08dbd47a8ea4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 10:18:25.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7887
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:50:05AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 24, 2023 at 12:42:28PM +0300, Ilpo Järvinen wrote:
> > On Fri, 20 Oct 2023, Cameron Williams wrote:
> > 
> > > The port count of the PX-257 Rev3 is actually 2, not 4.
> > > 
> > > Fixes: ef5a03a26c87 ("tty: 8250: Add support for Brainboxes PX cards.")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Cameron Williams <cang1@live.co.uk>
> > 
> > Please arrange your series such that the patches with Fixes are first, 
> > not in the middle of your series.
> 
My apologies, when I was working on this patch series I was going by device
product line then fixes and additions. I will keep that in mind for next time.
> Almost all of these are going to stable, so this was ok.
> 
Thank you Greg, I was sure that device IDs/quirks were OK to go into the stable
kernel as per the documentation online.
> thanks,
> 
> greg k-h
