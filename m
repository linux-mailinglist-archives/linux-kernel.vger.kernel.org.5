Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A897E0FD4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjKDOJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 10:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDOJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 10:09:50 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8A9191
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 07:09:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2NaAFcKvgdFLmMBVswKsrG4ClJHtRq/yPU97F0wHlo1DAthfRTVdlNU3P9cvLSv8ZoeryEkiZs04X1DnQ6Eq/Xv4TruZ6BnzKLrUKS2wrB3m0oKSG0WUL3xEzXPPh+QsvchEbQWy5rujJBE8K5A7QHH0Yrt2iJiX77CI0dg62e/qH9a+ZvVQCBnXGZjgIAYP9VTSddgcZgHguocLs4ZWJKcX4aNFWxE6xqIWe2lPq3ofIslz4Qxj8r31xKeaaGbFq/vlP/p/xANzrlfK4B1EkIQV98Eb1qlOJWYZXVtnZLHIs2acoBVCsEMmY95FihJfxCCPYrxIfaG2pYL02Ia0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjkCLfZFWLMWAtAJYHe0POfVnQGKTSfej1AASKkTG2s=;
 b=R8IbamtRwAz9xk4upB6ytGBFZkiSDK5huZmJPKvDUUkKYqjIgYrIP5MgoKrU46dLDUzmvSqrtaWhhV2UIO9fozk8ja/B+t2I0P6u5L5EWtnK2AYW6TvxgGpojh2nOSxwlKFlUoT45q9i1c6Fr33dY3ygrInw052YnQCdDmdOMZPJVzmIWkYmOlyW+IzpYDokYjtJzr3vVcJV5JfRN9Fu3MIO9y1/kGGcgXJGNLdgtJuYdByLFUYoXDLFyE+b4/eGF6pR7N4N46JF0HIciS861z96V/LqLnfnOt/5GhwUz740LEk1VKjTgRA4mzUhtriFPyHVcEA/rIJBzhT5IRYDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjkCLfZFWLMWAtAJYHe0POfVnQGKTSfej1AASKkTG2s=;
 b=isQz/aE3dL1+wyq8cWEBY4a11uusdnk8uuxZlDoXsFTbuJqPaAHExp5D+6FUeLxXIDjnRADigZraYd6i0dopYXCGyvyp07j43HhL+hqYu1aakJi8vwQEmM9pOSVtB7LyF208ydLdX1r0piOhzjPrRMvLBFtZcO3nG7ObDU1y6MSx8MqUzVz2JqkWKT0/WC7Szmw7zZFzqPW3PZBTMF1rI6ILtDfl2Yb+MFWzvJXRNvYksrzCe0qN5NwDW+AecK2qOUIcVq8QnjIJGM4UYYykFjlRTY+uElDZ2DcruCqmNxPproH7o3qTLE4AbhcCx8n+NIResmpC/eIaK++3iVBuyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sat, 4 Nov
 2023 14:09:43 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::7ce2:1ea:7294:50fd]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::7ce2:1ea:7294:50fd%7]) with mapi id 15.20.6954.024; Sat, 4 Nov 2023
 14:09:43 +0000
From:   Rui Zhang <zr.zhang@vivo.com>
To:     broonie@kernel.org
Cc:     dianders@chromium.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        zr.zhang@vivo.com
Subject: Re: [PATCH] regulator: core: Only increment use_count when enable_count changes
Date:   Sat,  4 Nov 2023 22:09:32 +0800
Message-Id: <20231104140932.4946-1-zr.zhang@vivo.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <916eb114-f3d3-4b10-a2c7-ccd411222989@sirena.org.uk>
References: <916eb114-f3d3-4b10-a2c7-ccd411222989@sirena.org.uk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a12d5bd-5a6a-431f-54b8-08dbdd3fb184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCLudeji5fNZB9em+lRDZTW6JsgEbpPHcZ9inlL0O/vedtiKo33ReMgQx9eU+EUbnTlHnU3OvCom7+O7doDETxLdpIdRWvm+xB3nFNMPC0VYOpuC74XWqxi8PbpECQEDQ8VuxA2TiYnZEORBN4Blfxyr301W0f/GWfrRDo3mVcjZynqWKIfevFFJhHZsqqrV8DLIbIwapHoe6Jq753gZWQUCtt1NrfHL8vaEsuxv1Vrf1RYE9WfimjooqybKHbyy5TFyrdGDWbLydWhc/We6alj6EG1pI3FElbLQIn6NFWU5Mn6MR9A5YJrHEPYaNv0zvvGtRg4VMnlTAo/HRZrot1I5Br6jB4mXLzHIaeL3+fRPxqeFBl1yvMpxIv6GTq0+2JrB49WJTtoU5RfozmyHsMoqRwpSRkSOIRFBGJciUM8h/3R+4bNFpqwg+0bwmOltVqtdcGXly4MkYIUAZpsFWjab5k0HHiQ7uelERxrX1AFeVGhjCPE3XBh4iFHa3gJ8jJNTStBvmIo7U9l2gQh0SKYe78Xplfn5qV2e7Jqm8B/vbjJprrnfh0UuwLYkc8GSKhXORq0FkFJh2Pg3c/XICibarch70HD6LCsyncF/eAuXViWpfI9fBSITbqToJeGX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(8936002)(8676002)(2906002)(5660300002)(41300700001)(4326008)(83380400001)(316002)(38350700005)(86362001)(36756003)(66476007)(66556008)(6916009)(66946007)(38100700002)(53546011)(52116002)(1076003)(107886003)(6666004)(6506007)(478600001)(26005)(6512007)(2616005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HhbzlfW+Z5Go8plrLUfemjQQyWV1B2pXUGbxq0ZMhBtCowrPhyaiIVXordME?=
 =?us-ascii?Q?cSvMDKbEo/sSjAZwQCNngo/3DtcfC9VdOB1Ucq+brkKTXbs2RmVhcwBsdJTR?=
 =?us-ascii?Q?gIzAav4VzadBBFYBGO/Ij5Nc0u9CecxXFsMnhvpC5tpAycTLuIrWbzfRBAVf?=
 =?us-ascii?Q?+9ZW8GH2nWt0/WYSfz22/sR+stRkXCqpNW6Gb5WYpd+b8+oPnvbVrto8iDtu?=
 =?us-ascii?Q?Hc3YYBCG1jZL4512Hm7oubcwB4rM+8AxgP/uU08ByxT5Uh7ov2IUzlUipuBT?=
 =?us-ascii?Q?peNu7zS1qHfzBiaJUKOONgLgwzD0uVnCdyfyY63kyQ98X8pYzaxX9R9A+cEN?=
 =?us-ascii?Q?osp9k8VOvskV8KUtHXJmVnsTImcbqs36unqi7EP+jCHc0QnxH1CIq85wG31v?=
 =?us-ascii?Q?yxVGZ2Uh9UiS8vnFC7JKAEqZLUNDsuWNVD/qV+6cKspMWtVnbM8TsE7jwAPa?=
 =?us-ascii?Q?WCbBOIdXV/tkYVBjK+g8TS3LKrWJ0jBS8vAbmkIJbqE3hlwl4ymxdhIh1OU0?=
 =?us-ascii?Q?XYX/uP1mJStkKhZjqcTsBM1qT2u7bFiXhfvW7X5SysSlAxR1SyPjjPuC+kNs?=
 =?us-ascii?Q?Bds7gGOrJvxPQlYBS5DVOf+na10rudUUL0+eaTwVHi0f38ySUizxGOTL70AI?=
 =?us-ascii?Q?cnA84Wvr70i8qXduCc/WDapjMBp5ZTqSR+HHewA0eG1fTqu1pqGiew4cVC5u?=
 =?us-ascii?Q?hUQ4kln/u/rWZkTTXCtJvmEcXI6YjflO8GUMkzvgKtjJfFNWj/aUVrURxMY9?=
 =?us-ascii?Q?F7ud9YAm6bIT/xN3ZD60mnVquX+FDpPfJpn6l6k7xu0rlXt9BE/K1DVcLgrT?=
 =?us-ascii?Q?JBMMrIMcK7LTkT26paTGrPiyZbCWG7/W4CeKM5r70MKUfAElfVWvcnCCicR+?=
 =?us-ascii?Q?2/TPOAPhvzvqj4Wt6uD9veNk5pkEibm4pYsAW0r971WtBya/QDOeup7JceXS?=
 =?us-ascii?Q?N5oaF/WNnyzcIVfKjZvwqm2kugsH9nEt582Ebb53LH+U16Z7a7Wsx8LT6Nt9?=
 =?us-ascii?Q?MGODTrAYblkGBtIxPETcpT5+Yoz3k3AvQapKmXWY5PrV6rVGiQsMhR9tiL2Y?=
 =?us-ascii?Q?+v+PNOVoOaTjEgf17aFoaZhXdwZ7me2IH9NMZhyD9vZdQA/V1ESWilvEHhzp?=
 =?us-ascii?Q?QNDCFcwMia8U+wPZCw7TNS96JCOS4aZDAbk2JyGICbISKlaHAYJ0Yh+ZtmuO?=
 =?us-ascii?Q?HA7yjSrXUPQ8J9nZKO2fqoll8VyRR0XmonaE1B+PXw+QKu2EXkcbYSZwPfdO?=
 =?us-ascii?Q?SHZ0CQX4msAF2OK8pV2ZWTnnopuOh1XcEThGQfro7HAKEvZydzUJbf+a/ojX?=
 =?us-ascii?Q?FFgikE1QCz6uIRy8SjqcSyN6NShvuBFKyXVZwLpaXsYvutJALOJijiAhwX5B?=
 =?us-ascii?Q?qJUTWzwAQQgnaH04hvl6EcX0/wSzZtKh54DMGtjhtUtG4t7aBRUCtfp4QFq/?=
 =?us-ascii?Q?NynTgFo3DiA/QbGfhekkFswyCTk2wgi0jhATN59kzTJ97Mo9nS7NvWm1WJwj?=
 =?us-ascii?Q?oVfPMKpYjsCFPe/8p412etliqV5HYHDryMQwTsb7vxpu/pICad28enJk0dbx?=
 =?us-ascii?Q?arXtV8hDJyCxIYJ3eCBEr8cDgyL56lOWv8toTKQO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a12d5bd-5a6a-431f-54b8-08dbdd3fb184
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:09:43.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YoLT5CWDEu1ZlXLCYeytbjjF/0mAZyOp3ghjYBIno4iUFzwihbEkk+3Nzf0FsdMXtJY27ebUn8rRE8adQKAWwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5899
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was very great to get feedback from you.

On 2023/11/3 20:51, Mark Brown wrote:
> On Fri, Nov 03, 2023 at 03:42:31PM +0800, Rui Zhang wrote:
>
>> The use_count of a regulator should only be incremented when the
>> enable_count changes from 0 to 1. Similarly, the use_count should
>> only be decremented when the enable_count changes from 1 to 0.
> Why?


Sorry. It might be an inappropriate expression.
I think my tone should be softer.

I believe that tracking active consumers would be an useful approach.
In case of enable/disable interfaces, the framework could benefit from
considering whether the resource should be provided particularly when
there are active consumers involved. Enabling the resource when
there is an active consumer might be generally preferable.

That's why recording the number of active consumers throught use_count
could prvide an accurate reflection of the the resource needs at that time.


>
>> In the previous implementation, use_count was sometimes decremented
>> to 0 when some consumer called unbalanced disable,
>> leading to unexpected disable even the regulator is enabled by
>> other consumers. With this change, the use_count accurately reflects
>> the number of users which the regulator is enabled.
> If a consumer does an unbalanced disable the consumer is buggy and the
> reference counting is wrong overall.  The bug is in the consumer driver
> doing the unbalanced disable.

I completely agree with you that the buggy consumer is the root cause of
the problem.

It would be better if the regulator core can prevent the spreading of the
malfunction. We all hope that failures could be limited to a minimum range
and not result in a system-wide disaster.

Addtionally, this change could make it easier to identify the buggy consumer.

For example, there are Foo_A and Foo_B as consumers, both of whom have been
enabled at some point. If Foo_B disables twice reducing the use_count to 0.
(Regulator core will complain about underflow of enable_count.)
Then after a long time, Foo_A disables, the regulator core will complain
about the unbalanced disable. It seems that Foo_A might be the buggy consumer
even it is actually the victim.
However, we would need to ensure that logs from prior to this event from
Foo_B are available to accurately determine the root cause.

