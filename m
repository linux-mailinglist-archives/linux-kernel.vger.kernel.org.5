Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4943475AA40
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjGTI71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGTIjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:39:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C55D26B2;
        Thu, 20 Jul 2023 01:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHG1d0tvM3M12epgai9F3h+d4qeUV9fzq39mQ1U9L/a7jCoRW+svpF8a7z57DZxQa3m014iJnEvRvAGb51RGhFhWamMDLpNPM9YsMTaAfgQNre539S99ht+wCgt0ElCOj5lH2y0FLJ+NkEyKq2RkiI9Dq3K8QLlQTySUZ42gXbvKden5iAWSbSQAztApkzi6DPtYbc9KKjibyZxpFJ35dqkT5Ph6aPN3K1t5pUiI2yIrF3sr5oVjE72VowjEaahh1ta3CiPRVdWAqZMk6gZ4Zu5vUy5StF2fKuxt2BjqTDcaguyiK6mMT1kzchkYC3/2umLj4dRoiXD1pKGLuXZjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LKbGVV3DPMavnaubobCv8Uliz4/wXdU/SC+PxFehGw=;
 b=VJBPIh/mxrUyy8h24ezZnNBvkd7SFJMy0VLuuqWHz6F1hF6+bexQynXv4n2J0b7+cY9cnTN7H9JWJpt2IWGzZk3qh60lwN26tzOGSzjS2qnA1ZnZElcYCZDRmlpxM2SMGM6YQmmG3GMQzk5gg+xFpSS/BIxFiFi6H5a9+1tgSLHOq7ttqFX1rYr2VDSU6HGtcENkNzVcmPV+Wg+55t1ZrG+sY0XkdWs4YElEx9kdEVqGSJAC0BoJljvfo9IhqWpWUVpjZpydsJKq1AjSKiNDjWuI0umOr5FCUOMak/t1vf3sQGF6+u58adgAnSvCRs6PsIRHBmZHCzCBbRuW/9xHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LKbGVV3DPMavnaubobCv8Uliz4/wXdU/SC+PxFehGw=;
 b=UjzWF5+Itttnc4xy36fGZ/H60vxRDXRmpI1aynxLjbQ1YTgtelKH9/dcQlrbaMUtIY3UqLUJHi2IFulX29mP9+1CjV2v8VpyD+oTRAQ4gZzKz0i/nYTz2AULOKnnrpNq41uYmLPyl3dbya9UeI0rfegoWpFMQJtkIL8+Nnu8LzVp5gsIzfAjWB7J+chR/doEA2xX1A8EJOLLHAiVWaCOTLyh7oSSwiLUMpT/Rf6V5OHLMQwlwk0pPaVEDWRoNcqstDKDrnp/ybNYLg4YLzZrgDJwcMwx2KrzgKuL+Mn6vyXilxwLriXxj0vM/LHqCiP/v/ID/i4cM57Ng/DNNS3ybA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AS8PR04MB8691.eurprd04.prod.outlook.com (2603:10a6:20b:42a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 08:39:43 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 08:39:42 +0000
Message-ID: <0a706af0-8b19-25c5-1a76-0add28f5d214@suse.com>
Date:   Thu, 20 Jul 2023 10:39:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] r8152: Suspend USB device before shutdown when WoL is
 enabled
To:     Alexandru Gagniuc <alexandru.gagniuc@hp.com>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, hayeswang@realtek.com, jflf_kernel@gmx.com,
        bjorn@mork.no, svenva@chromium.org, linux-kernel@vger.kernel.org,
        eniac-xw.zhang@hp.com, stable@vger.kernel.org
References: <2c12d7a0-3edb-48b3-abf7-135e1a8838ca@rowland.harvard.edu>
 <20230719173756.380829-1-alexandru.gagniuc@hp.com>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230719173756.380829-1-alexandru.gagniuc@hp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::17) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AS8PR04MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: fd687252-275a-4b50-75e5-08db88fcdd22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kw4zRLpepjHsKqYKoB4Gyr68bWS638GXa1KHeX+tg2CvgIDM8cz6nwJKiDSB3WXEju8nyAheODvzgeoWa3Qb4A0wL4WUTdbN7MRBcXEjPTIXMp/y7REUXyWvlVIUcT8tBqy723RWjP9MJ5EyLo3N9nTeZlOe8PYcfvvqnq4vgwSDe0Llos6bQ27D3CCQAa0ZoXkuQXeo8zZ9R00mwOqpX/t+QpY69nY20MAdrQNvmFFzHbcr+17p8ZYf5f3RwiXAHr98aHdElamPcLrDIB7e88dKFFTvoqTIHpzrkG+i4FxtW57q2lEllJQ04w/sI00Q6PYPM1uUdfyYQ6+kg9h01PIfjYV8cLXfndmVdzyq8rKjRbEsjOM30CK6gljzNK04rGIIsua0IlN70LHhTmDHfw2eyhNtptD0n6IPuLO4vz9dU4PRUadvrKpJPNuUyEhDL7E83bqcxzVnzJN15bvVoMUoF7Ky6koXSsQiLsYUzrf+t4aFvUIs2bFfI8m95B+s7O7XA0asHU9tiPhtXEdw07e8uP0URTjxGCGdRYqKtYg4VafC/ZW+b0DYi8V70oUV7lBxNmoF2fYk/iQQwn2RgmBpYlKX+okmky79MNjOVjvLHHpETr3Isr882BEE7L20EausDVFG9wDK12KbxEOj3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(66556008)(7416002)(66946007)(4326008)(66476007)(478600001)(41300700001)(316002)(6512007)(31686004)(6486002)(86362001)(186003)(6666004)(8936002)(38100700002)(8676002)(5660300002)(6506007)(83380400001)(2906002)(2616005)(36756003)(31696002)(53546011)(4744005)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVlBNVYyek12cllpWjJlT0trNTRKV3IrQ0VzeWppVU5SNlkwUGJ5SWhpb1Nv?=
 =?utf-8?B?L0FtYWcvTS8wRVhCUFF0eHdhdUEzR2szYUNoc0lkMHl4RVZvM1laSWU3T2p2?=
 =?utf-8?B?N3ZZc1NjaDlzTW9tNTR4YUQ0OXI3akhFUnJtc3FWbWs4VDI0SEg1eUVVV1pX?=
 =?utf-8?B?VHo3N0hwdnY2enVsZjY1dFR5R2VJcXZqOTZKYy9lRWlqVjZtTWtuMlJKM0V6?=
 =?utf-8?B?Rm9CZWlVdktsNTdpQllGb29wdUU3bkcyOEVZRHM2MEhhNWtRdmRGRWFYb0FD?=
 =?utf-8?B?d2o1TGtrRkpraWRJUXFMdlNYTkZCVnN6SUdyejlsSVlES290L3RQRzdxSk5x?=
 =?utf-8?B?OHhxbXFqZjI4S1V6K0ZwcDNBaUdCaXh5aWxpaHErVTlEZEVXeVluU3Zuampv?=
 =?utf-8?B?QS9vNFo2N0dRYzkxOVRtWEI1MC9NWTFvS2V5eEhMYkJ0TURFSHNpSDZqYm5D?=
 =?utf-8?B?MTFUWU5FWDJWY0dBbkJjeFdpbWNMcnhzcjhYeVFpVGtzUmlXRkNxMWlSbzQy?=
 =?utf-8?B?ZFV5bkMyYXZlQTdsOFpKVTYrVzRuR1psb0xCSGg5ZW10U05PYUdUTDNwZUZz?=
 =?utf-8?B?QkhGdFg1SnpqV0w2OHNMUmpQcTJIdGlNd0ZOTlBOeDBmQ1RJeURhSzk5N0Fy?=
 =?utf-8?B?NFhJTHY4RGdLRE1GcnIwNm5CZmhnei8yczNDc04wRUNDWVJMb0dxS1diRmZy?=
 =?utf-8?B?QTVtUTdUdDg4RzJnY3pkcmVoekRtc3lEdU1MNUU2cUc3TXQzaUpoT1lMcnhV?=
 =?utf-8?B?YkhnV2ZmODFiblpGMGZBTkNVTzJTOGJBTi9zQTVlaU94d2djN3FlSkhUeWg1?=
 =?utf-8?B?YlF2ZjZSMGZtUU1iZzBKV3NKVmh2WXJWbW9ZVmlFVHZiblEvbE9wUmxNVjFS?=
 =?utf-8?B?am90VU5NMVJKbmZ1UGNLZWk0TE10Mi9peTVKbGhzRmZIeG5lMkJzWDhBaWUv?=
 =?utf-8?B?QnE0YU5xU3J2ZXdjcFRMQ0lzOTg4SDdUN3dMcFpyM1JPU3ZIQ2kwRWxhdjFO?=
 =?utf-8?B?b1lXeC9zeXpnZGtUNVNZWkZWbzhxb09xa2ZRQXBidStoenRRTE5QNjJ5bTFu?=
 =?utf-8?B?WnN6Wkp3ZmFYaXFydXl4QkdYejd2YlJTdDNnU3duUEJhRTkxcUVXVzZqTzJQ?=
 =?utf-8?B?V04yVWJmT3dqVGhYV3BsMkFSQzFXMzQxL2dqcWk5TFJ1QlFzNktlTWhMaXJ5?=
 =?utf-8?B?T1A5cmUvNm1GL3FycjJIeTBzaVo0dHIyOWNXNGlueE1VWHlOaVgzd2k0Tmda?=
 =?utf-8?B?RXhsOEdSNVBUTitRbGlWNUdveXBnbTFEQlNsSURoRTByYzl5RVg0RTFhMWZt?=
 =?utf-8?B?Ync0ak9NSnFGdmVScXRBbmlocXJlMjYrdWNnc1ZROUpOcS9ubG9wSW5OL3FU?=
 =?utf-8?B?eFNtV01zcll3aldWcHltRVU1Q2laQ0pvMlN4THhRU2dvU2VsRWlPdWhNU05s?=
 =?utf-8?B?cmpJOC8vbWVsOUlDWEVwRk9ydEFvNmVaNk0rL1hMTzV6NnAxMFlUS3FPd0Zj?=
 =?utf-8?B?NEhPTG51QnVGU2xzc1A5d0I4dXdUeVB6TDZxK05mSWhaQktTT2VUUEUvd1Fi?=
 =?utf-8?B?aU9PcVpzTlU1RDJEdTdjQytHd25DUW9hWTJuRGw5YTFTbHRIdytjWmpSMGdO?=
 =?utf-8?B?TmczTDQxNFFMZk9naDBjN0xTYzNZVzRLMkw1emtINzFiK2JiaTJtbFVCL0VC?=
 =?utf-8?B?NEViOEZmMVlNWjR0NkxRa1pWSlFTQjdmTCtkSHROYWlsR2xaMUo4eEZCMGtH?=
 =?utf-8?B?M2taTUd3K1BUdmhBVkJ3RFVzcnNzQmFvMEVwNEs0TUc1UlV2UDQrZzEvenBo?=
 =?utf-8?B?Rlc5ZzFLaExCb056c3hRZitQUXU3dW1EZUNRZ0U2TURudTMwZjJ1cDRpcC9o?=
 =?utf-8?B?ZnlEdzNPNnFhc283aDBlYml0cE1ac09yYmYxeWgvTVZDKzZVZGZ3cXZ2aXdZ?=
 =?utf-8?B?VFNNWFBUbXF1WGNIYXZSWmdnUVhCQ1h2YzE5dWJvSHMyQzZDQUsyWFpCbTZZ?=
 =?utf-8?B?ZHp4b08xcUN2OWFKdlJwM25NNHY2QjhWVEpNbldmZmhGK05QeEtEdHh1c2pS?=
 =?utf-8?B?dkIzakt0dTlQZmcyNFo4dDYweXlkT2FIaGQ3SGlNczBGeDdmdXd4YytkTE1I?=
 =?utf-8?B?M0xrVnU4UmJCQUluUTY4bXphNG83aENjbk9SVmZNQzFYdTJZZHZQMlVHVUY3?=
 =?utf-8?Q?ZS5q1MUfRclVuiS6DIHP4jo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd687252-275a-4b50-75e5-08db88fcdd22
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 08:39:42.8260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1tiG1fZoCkWFARd/KpLVAiMukp4Osu/tRiVylHW3Fm/e6XJ/owD7TdPDysdhRzLCYIDLlgUlCK7t9tbJ/G1ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8691
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.07.23 19:37, Alexandru Gagniuc wrote:
> For Wake-on-LAN to work from S5 (shutdown), the USB link must be put
> in U3 state. If it is not, and the host "disappears", the chip will
> no longer respond to WoL triggers.

First, a question, does this also apply to S4?

> To resolve this, add a notifier block and register it as a reboot
> notifier. When WoL is enabled, work through the usb_device struct to
> get to the suspend function. Calling this function puts the link in
> the correct state for WoL to function.

Second, do we really want this to be done for every driver with this issue
or do we want a flag for core USB code to suspend devices when the system
goes down? UAS at least does something similar.

Third, what happens if the device is already suspended when the notifier runs?

	Regards
		Oliver

