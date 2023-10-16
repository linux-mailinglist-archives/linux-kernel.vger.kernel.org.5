Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BD07CA0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjJPHes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:34:46 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2105.outbound.protection.outlook.com [40.92.49.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA59DE1;
        Mon, 16 Oct 2023 00:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Em/6nFLasVCMWpVPNkqHTh9dkg0yNP5hWxgEs99XoGGcQiEOCw/2mv7dAgT7F4QYlIIgc6cdbiTK3tRUFMo6WHn/ibU+/bFzZ5KvHrREZobymuBXSkQ6Ui5m+wJj5+OpPmg08FPr8PK1e0tPRNbTWYnM+T/i1oG35pCBoNezHng5Z2BNTcDwEr0tmPxcblF+yx65ilBUxExINaJUIkH+05BfYb0dMEjfEEQsVxPA2bfP16ZXUQpG3KhBhSXB1FyRAZzUnhREjVnJMsqs/Kv95b/qTOlVXDW/DxhyGU3STSmTvIxRgQXcdpvtWUiNInPbKoYGomMbN2Db9PMCOFwnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MgkxcJFUznFEF4gAEI8nFTa/O9PcNV3MvLuDMCiGYY=;
 b=RFmhzru0tk9zyMuSbbsOtbsUDOWiaxQBn79ucFQnlEI+ddOQGQJdVe4sBYA+J+Ji1P+RDcWsjcqOWOidLBpfD5CCR3W3Xl7LQKan0/x3OX/3ZwCmFH4Gj+3pcWnT4JZc+tG3fCgmLDfce2+wptMs0zmBctVSTfF2po5sdDTEqZDnSguDDip3cS+NO3pylQBQNe6ICLDbHJwwSREx7TaKE8RtofjPqSELGxwFYO/pW7W6yrLdR1ttoBQLpfv5JCUtVmGnjH3l5Nebvl6VzSXYALFWhc+85EPe9wyXe+vkCn0pPdcnPZJPvveo7IhgKOONuiAWCw+1XEKgEjLEeAl6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by DB9PR02MB10017.eurprd02.prod.outlook.com (2603:10a6:10:45c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Mon, 16 Oct
 2023 07:34:39 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 07:34:39 +0000
Date:   Mon, 16 Oct 2023 08:34:36 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 2/7] tty: 8250: Add support for additional Brainboxes
 UC cards
Message-ID: <DU0PR02MB7899461DC8DD0CBD02EAABDAC4D7A@DU0PR02MB7899.eurprd02.prod.outlook.com>
References: <BBPatchesV3>
 <20231015171141.3309-1-cang1@live.co.uk>
 <DU0PR02MB7899EF5899BB15DAF3DB580DC4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com>
 <5054cda2-f618-4d84-ba7a-84c442235353@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5054cda2-f618-4d84-ba7a-84c442235353@kernel.org>
X-TMN:  [HFdrxRDyOq1pBK/7IH55ZDOWvNupp0i7]
X-ClientProxiedBy: LO2P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::36) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZSznjCbs51wN0PHJ@archlinux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|DB9PR02MB10017:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f1330a-2e12-431c-ba3a-08dbce1a5acb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGq9/L4Py1qlSyw/Tjkr9kWUdwuRbK7MvEKZ0M8cMkZoXZQ1+pjfeFamYuodmQUMYfANQhLw3UqB2UE3CV22ZY7s+aFMTM5xmYOonJmlxQkU5zvY7x7l3cyRJTk4bGdGkJN2Qd6afiAWa6wAWw4HQ7nNL33VTAUqyvud63YsCsaOb5whIl+5dqU0B8OMrYDvBAefmudg3uN9xe80g0rCgQsZQPmYN1+0WqCOUrZsKnuyqAJo8wUeOUc4u96ZyxYY4+WVDIZX75j8Qt9PzaPmjLPh1iVOQcX9UIj7hCpCC+yfhPYB6gJn7QMXJGXBLKRw7TOP6baVM4BwXAP7+mxbtW68AHreEK1PVdcJhpX5VTSr3tWoKywlAqSRp4TOxGMckeyQwUCk7yHfmL2aluWhRrlr8PTuzjNMzCwwTH9iZQjb02ceUk91nFfszBtbIMzxUW1wxq7Sy69xA92zR5osmaTSgR/CjHtvU+JQ4DBfd6iiFrxK2RWRiaB6ZTqRV/1B1B5h68YqC1yNy+2ZBkkvVkcpY0cL4p2VTPCxAC3wsOMcN1HnswwHw2xnsyb1QA3l
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ebcgxHfHxk1B7mzSeP/Gu4SO1tt1kLLJUqpCetk9WdKJvx5nsWuJLS/hGsu0?=
 =?us-ascii?Q?WEwsl1CSIo0bAUrSiKB9692i/okVJfTSItjT4uCGiT9KrxKQbKr8WeKEPhtI?=
 =?us-ascii?Q?KDoR/zDAQrQ3ES6OBPZnbmKLuCQgU/wcS8/9ZcBGc5J45eg+Tfuf0tG6q/EI?=
 =?us-ascii?Q?2SXZ7vk7X0bufK7Gq1Y0LAWTt83UpdZPzeN7Yzl4Du15kaNKNDXWbBbAT8QN?=
 =?us-ascii?Q?OfnYiLgnUFrEdo7OMmFZwg/XtSNG3mZmLqfbwKmHEVjzhtxc2e8SW/XyVj8q?=
 =?us-ascii?Q?WP8Cw7Q0vBil13xdZSnPffnscqYX9XDenOL/BkS7fKRG+yrW6Vz3JU86yjOt?=
 =?us-ascii?Q?6aiZ2EwxKeoCP92jS10ovh2k4pm5/5DafYAzYAget8Oxup5ILY+i35MhT1UR?=
 =?us-ascii?Q?OiZNekaOV3lKubWS/VgLmNcMaGJRTjp1YtGS1j+vnfT8DOyc6BAcI4Nl7H/k?=
 =?us-ascii?Q?V2H4BmqQ2z5wWjIsXRkBivR4y6Aewu5SKCBB4YwkwemCYIKf1C5Klpsv8KpI?=
 =?us-ascii?Q?MnkYp/IpFjZyQWenOd9lR98WVDXJBMh7STHyCk1ssxNuWWr9tP/qTLBhCHWA?=
 =?us-ascii?Q?ujj7ybZ6gUXBs9ZsaMz4wKCXyDeaqNf9H68JE8ka/3mmTbu/TV9fpCLUvUV+?=
 =?us-ascii?Q?JE9oKy/fz5kES410prE3FBa/erdU4qIsa5ReCwQrYprG+1GJELnh2lKAmv7p?=
 =?us-ascii?Q?rTIKwwpypV2h4zPy+CRNja8NvjEjBEa2w8uBuPH+poGWYCEORlzgNEeUuKLP?=
 =?us-ascii?Q?aOAlsDjCOLpbiUAmfO5APAM6+bql1/IHXaWqhW3BIFeoZXn3GnNsfNMBUsQV?=
 =?us-ascii?Q?kKFmCUcNHNfEB7VdcGeLLlmM3osNV+0Em+idKFiPysuSeuNCVQPcrv7US/wt?=
 =?us-ascii?Q?KYZT6jxsHLrfp4hijWUff/wajt3oFvWeS0zXZPA0h8R+6rShapx4oUdOuqWF?=
 =?us-ascii?Q?h8ZsvWX29D+Hm4AqKGNYU9w8iW69DN2jDOp1NLWt5O4ao5ZSTKGQZeOlRi19?=
 =?us-ascii?Q?KnD6Up5UcPU6VbQzSd9sZsI7kwSd9yQoabPb8P7Q9p3ilSpsVmS/U+Tyq4yR?=
 =?us-ascii?Q?3BNUElqZ7POTN01AfNs2HI5uBUr9ma9BYRlVlbvuQ7AZsonU/yu0qVjIanOd?=
 =?us-ascii?Q?anBgy7pKRN/DcUSiv3F41yVOBOKPOBWQfHEm6fOCyc2paROa6F9/vQ+m9zHE?=
 =?us-ascii?Q?idkl4nEGTZBPklFijjy1R/uTjwzQxutXZ+WQWA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f1330a-2e12-431c-ba3a-08dbce1a5acb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 07:34:39.4850
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

On Mon, Oct 16, 2023 at 07:40:03AM +0200, Jiri Slaby wrote:
> On 15. 10. 23, 19:10, Cameron Williams wrote:
> > Add support for additional revisions/IDs of the Brainboxes UC
> > range of serial cards.
> > 
> > Add: Additional UC-235/UC-246, UC-302, UC-313, UC-346, UC-357 card IDs
> > Add: UC-253/UC-734 , UC-607, UC-836 cards
> > Fix: UC-431 variant note removed as it is a 3-port card, and there is
> > no generic 3-port configuration available.
> 
> So can it be fixed instead of removed?
>
By fixed, do you mean implement a generic 3-port configuration?
I could look into it, it would be nice to have all of the cards in the
range supported, but I wanted to avoid adding a specific configuration
only used by one niche card.
If you mean fixed as in change the wording a little bit and add a Fixes:
tag, then I can do that too.
> > Fix: UC-257 moved to parport_serial as it is a serial/LPT card.
> 
> So this patch deserves a Fixes tag and should go to stable as well?
> 
> Anyway, could you split this into fixes and additions (ie. 2 patches)?
> 
Noted.
> thanks,
> -- 
> js
> suse labs
> 
