Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99AF756847
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjGQPtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjGQPtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:49:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86101A4;
        Mon, 17 Jul 2023 08:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnpELjZQO8lBBe6EfkG9vvXoFl1UgNB6y/iHVU4JOLu4xldMMsBCpyxbW2ZS9zljQy0u3ivHSBASW4QfiO42hOBGI7NBZhY+bE/Ckb1ech1AJR+72iFXWPFLLkmQVrWgIleVnIkhUZrCPXuGj1IkCmbyZLD0mhRtm/PH+Qw11/dL45Mu6TObBfWaTPUKThq5I/hPpvugknj1wNbWQgGJvgOKY07MEvWdIZKlY13JbIilyFkfubqmFJPFxskncYkJOzy7wOj/8nVbKpAogTNX0pvyZvN/JpVSieq0HxHyxln+Q48qggbpVhM3o8JZ9CIkqmqN4toJ1Ki4lhB7k+Y6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZJ4Oycpm97BfUgezlZvC+UVp7wtWq8aIGjb5COBpJo=;
 b=lXAbhKzanCM7ssFVCYwlTqgp20kMdpJ5Ji4UFEzbLRIS6PYQ5KsTcYfGDsNmFcTwLqRqPW7xUfiE0riRl+opDRt+V6ND67YOXCpuB2TGfBDEhPfim/Z35gykonkEZtpSF0L5DyW86/cymkLHchhTF8WCv6xlhbILM25SmABRSFtJYz2o9X5FuhuhW/YqWYZ5mXOOzVs3Z26k7pJ8zsuqW0hUKtvmOAQQke63uuy3BjUDR27t8cbzyM6NK8Re4roCRH2cMiV3anpcwV95vxwWlaS7wgk8T4SSk+wL2+fr1s4FzBynCgj6ouIy4g6hSjFQqka+5Va+8VJRxl0R69bM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZJ4Oycpm97BfUgezlZvC+UVp7wtWq8aIGjb5COBpJo=;
 b=2YNvgY9e05tyhoMxiGEP19DJs0lcv6GRuLcC8mFQ2nWRfD8BU7qkYUL+uquFjPYu+GR9zFPWrkhUo5mtrsumoYOIbMlxlBP/OIfrM4NJHrdtOVm9s+nxbokXpCSvO8zdYRNrYYqj1M/ZSk/wl8BcxjQo877ui5HQkTZzRyXujtu/SkuILeSP4KgYxJ3v+SAZDtPiR0FZihaStLVK5X1RQhAN9B7PxYgwomxpxs8SfuUlw+KRPfd/i5iUJ/CKITmpRqZqGOEnTpx/GwKzgDx/1biUYAquumiw5X2NxlBU/cFxhO1iEH3368HDJdEWUFrU6JAS1vWQ8iRTiugxOKKFEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:48:56 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:48:55 +0000
Date:   Mon, 17 Jul 2023 23:48:49 +0800
From:   joeyli <jlee@suse.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Chun-Yi Lee <joeyli.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: hci_event: Ignore NULL link key in
 hci_link_key_notify_evt()
Message-ID: <20230717154849.GB14791@linux-l9pv.suse>
References: <20230714161210.20969-1-jlee@suse.com>
 <8eeb958e-d947-2f6d-5942-d30746cf1268@web.de>
 <20230717055150.GO5866@linux-l9pv.suse>
 <7cae670e-b7c5-470b-536b-ab03513cd0a3@web.de>
 <20230717102310.GS5866@linux-l9pv.suse>
 <7cc32a46-b4f6-4d92-bf72-24fdbb8f3eca@kadam.mountain>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cc32a46-b4f6-4d92-bf72-24fdbb8f3eca@kadam.mountain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|DB9PR04MB9628:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d36c95b-9249-4c3a-36ef-08db86dd53ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otHgYPxfHD3HJLfbzTIzKvLsM6ZvNhmxNQvWFl8E2HX2YGS1RXnAK4FByIvys/MCs0rrLBXpr7MfZIHLuJ4ClxehrzKKgYC8O12mqgvpXZSU9MF2sbhX/UI09MpIekoATf2tP9ITv4LhXC/4wtnXZGAckPmjS48H1hjKOCpR/omVQuVJzdx1Oou7Riw5GIaM4HzeLztwqSviM+FZgP/9diaXnPKqMrp5z/rqE6MXJmgkoWd6MzL0E49BGAtHL/m2yEEHdz5qTIZWS+vv6MOWGr8v0Z5Nz2lLZEVF2yKxMuOM0e/kLijgvH5RrsiKtmg8OYD7VSD+7ByI/Dchzg+mC3+bAfyL5BVqZn81X91cVTE1dVlMNhjMTplXOihy0ex+TeAdTcxPDpIygmYRVuzaV0kJ5r+Grk4De/fHnh8wcIrrvN2MrkDK1cMUFE5ht8j+OU//C386TkuDlyexLdtIHFesFytKZxanSx7bCoYvlh+IXE3FfvpHYTESqS7DqcpgdR7o9McX5h+muo/uc8PdyxoaBnFG4HkWhvMDIxep277NfLkoppQ5UNjxarF4Pm18D3Ykh/LXrTWMLaj9//87woRAB5gQtNs29kd8hOeukgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199021)(83380400001)(86362001)(6486002)(6666004)(36756003)(38100700002)(2906002)(186003)(5660300002)(1076003)(6506007)(33656002)(41300700001)(26005)(8936002)(8676002)(478600001)(6512007)(9686003)(66556008)(66476007)(66946007)(4326008)(6916009)(316002)(54906003)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NElIdTNtQm8xMWVrcWJGZVQxRGZaR1RleVBtV1U2T0FjRXhvdFd4K0ZaYmpj?=
 =?utf-8?B?NFE0cDVYa1JlZFAvbFY2blk0V055dWljdUFpMitqc2oxZ09tOHF5eEdlUHhG?=
 =?utf-8?B?UXZwaWFYS01ERXpYUVQwbjhRQXdBZTJHa3R0QjJVN1NHTm1kbE5VczNuMFZS?=
 =?utf-8?B?akYwdUFrN1dpeXNybzgySE9MMnZ1dnN3RzBoYjRKVnM4ZEdKT2hZeHdGSndU?=
 =?utf-8?B?aTlsYWtZYW1OVW5vdEtXMi9hQldOQkNLZHlVZU9FMjZCcnZaREwxTUFnYzhn?=
 =?utf-8?B?ZmJ3cFNObm4rL0F2a0Y4Yjg4Wk1YWlViUXFGYkhVY2JFY09iVllOb0tlQjBl?=
 =?utf-8?B?MnZzN3hRMmlFV0VWS0x6bXJxdEUwRjhDOWQ0ZFBSVW4rMzRSdjlpWHQzU3h0?=
 =?utf-8?B?SHNrcHNnWnV6bmU5R0NFNG9EQjZpUER0UG42Rk80TTd0MVZLVlpEQlU4MFEz?=
 =?utf-8?B?azI2aGtYNWo4MldDY29FRFJMdG5hSTlOQmY5eEJkVmVMU2Q5ODI1QUFralJJ?=
 =?utf-8?B?RTAxNW0wNTR2Mk53WVc5KzJuN08yNFJHRmpHK0haV0Juc1JWT1dlR25JbWRU?=
 =?utf-8?B?SkZERUhBZHZnZ1ZlN3VkcThvYUpBQldSNHovcHRCWHIyc3k1TW5pQmo3UnZJ?=
 =?utf-8?B?d2lFNllBODN6NHVZT3lKT25qbFRWalU0b2JEYUVIVTh1T0dzWTBZcC9MdWVr?=
 =?utf-8?B?OHF1dCsyU0dVNDNTUHd4Um92aDMzR002V01vcGgzZzVkQmI0RVBtMnEycWlE?=
 =?utf-8?B?SGZ6M0RSQVRxWnlaVlplbEF0YmxhZkE5Tm1Ka0tCaWxCWEVjNXZLeHlKOU01?=
 =?utf-8?B?dlFYbXRkWHBncTNCMGxrWkp2ZE5TaWVRTVlSRWQ4UzZuVzJQUFNkNStpZEQ4?=
 =?utf-8?B?elk0NHhDT3RYUTRDRGdtL0RZNVhoSUlxdnRub1F4a21DTUVUVXpMQy9Gc0Ew?=
 =?utf-8?B?RHRsbjVUQ3hobFVVb3lGQkhIUjd6cFRFdllTZ1YxZ2lVTFc1VDJzMFE4TW9h?=
 =?utf-8?B?LzIrMTQ4cmJWZGx6cklLTXdpeEUyNW1xTGE1Y1g2QkZMRmhob1lRQ0lMT2FE?=
 =?utf-8?B?NnRPL25KbTJudm1ReWU2eitrNDc2VGJzNzh4V2tyTWhlalFQMmFtbk5vNytl?=
 =?utf-8?B?R3hCRXNidlN0VmdNSzBxSTUrSnc3QnhYeUtqWXArY3JhandOMHdVN21zL21F?=
 =?utf-8?B?OFByRHQ4Y1ptNG5leE0vVy9zTkpITHJCc0drQXBFMk00L0tQTlpGQjA0OTRV?=
 =?utf-8?B?SXZYemtKV2tmT1dTU2QrODB1Q0xSQjJXZVk1YWFRWHNIZjgyblJ2TXpLSE5t?=
 =?utf-8?B?ek9RWUZJY1Z0aFBuOFRoVVZYUUNLaFQvVlVGUVhPam9NWUFYTThCNWQwVUM5?=
 =?utf-8?B?TjR0MG1RSXpBYjFGTGxrS0xUQVhVY0JITlR5ZHE1am5SZ05pNFMzMlVlL1Q2?=
 =?utf-8?B?QnorWTBNRFo1TEwwV0NxeWZiZUNyNW10elFaYk54b0R1K2JOcjdSWnA2aU8x?=
 =?utf-8?B?dU9kV0FHVy9zVytSc3ZpSzJlcnhIdVBGaVFRc1JjbTd2TWFweG13SmNVaVEx?=
 =?utf-8?B?ZXc1UnFnOEtoYXZ0bFRZRGFNbzZER25Jb3ZGWWJVWmRpUlNmMmpnbnpLVktn?=
 =?utf-8?B?MnBsY0V0UjVZTGN6OElybmpheDhYWXdPaFAzK0hlR3dRYzdXZkNyeGEyTHNS?=
 =?utf-8?B?d3dHM242cGNkemlMV1h4S1lGM2Rsd0ZNa3QrU05nZzdTRi9seEkyRFIvd2xO?=
 =?utf-8?B?dll3cFlqOGNRek95R2Y0bmJHQlFPa0E4MkxjNU54QktCUTJWRGhlL2FYMWJJ?=
 =?utf-8?B?YUhMcm9tRDRyb1BpMlJ6Z2QvZE5VbU9OTWtEclo4U3RsbmV6K0ZNamNOWndC?=
 =?utf-8?B?eUw0MzJ4TFZKaURhN3ZyVHFnUGhPdWxHeHVDK0hDZGllcFZBekJHUk4xblVq?=
 =?utf-8?B?eWJNYzlzQXR2K2hXT2xaWE9RSUEyVG13MWc1Ykg2bFJ3OHhiMGVBR3FsV2Vm?=
 =?utf-8?B?dVVUdzhoZ2F6RHdLd0RrVVZOM3I5N09sTmFYWTBaSU9WZWNKRldoNjd6alZN?=
 =?utf-8?B?ZGVWM0ZlSXlqWXRpYndhc3dEN25MVWQ0VkZvRFBGUGdjaHpVWjZWRlVpWXdD?=
 =?utf-8?Q?Dg4Zk5MrU2ac/A1uUw1QO4x7F?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d36c95b-9249-4c3a-36ef-08db86dd53ed
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:48:55.8061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a60omoB9B1UwhYZlmkoW3ONhokN+5vy77cJOzMmrQp4S6dU4e6ouQ08UpS1BhY/D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9628
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Mon, Jul 17, 2023 at 02:25:06PM +0300, Dan Carpenter wrote:
> On Mon, Jul 17, 2023 at 06:23:10PM +0800, joeyli wrote:
> > Hi Markus,
> > 
> > On Mon, Jul 17, 2023 at 08:15:56AM +0200, Markus Elfring wrote:
> > > >> …
> > > >>> We can ignore null link key in the handler of "Link Key Notification
> > > >>> event" to relieve the attack. …
> > > …
> > > > Sorry for I didn't capture your point.
> > > 
> > > Did you provide sufficient justification for a possible addition of the tag “Fixes”?
> > >
> > 
> > This patch is against a CVE. The issue is not introduced by any old kernel
> > patch. So I think it doesn't need Fixes: tag.
> 
> You should probably put a Fixes tag against when the feature was
> introduced.  (Kernel's prior to that were not affected by the CVE).
> 

OK! I see.

I have digged that the link key stored function be introduced by 55ed8ca10f35
since v2.6.39-rc1:

commit 55ed8ca10f3530de8edbbf138acb50992bf5005b
Author: Johan Hedberg <johan.hedberg@nokia.com>
Date:   Mon Jan 17 14:41:05 2011 +0200

    Bluetooth: Implement link key handling for the management interface

I will add Fixes: 55ed8ca10f35 ("Bluetooth: Implement link key handling for the management interface")
in next version.

Thanks for your and Markus's reminder.

Joey Lee
