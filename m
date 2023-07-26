Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA50763020
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjGZInX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjGZIm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:42:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF9049FE;
        Wed, 26 Jul 2023 01:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMAnmObwzoOqHLQcmgkmfY/kar0W4Ant+u62uZfvqyefoprzKZphXJxbOyZIFOmHYJr2WaFYEZtPw2FuAhs7z4vii5tMXZ0iD40f25/FdMXTGTnT2vtj8qzwlGXjpbm7DOIr2xCT+zNFKnbMbHMSw5zqvSDXhIlY3evH3nH6CWsd03SX1H5tdpFaEUfCry62cGk+ub8sunkik205IDXJgEg+8bKkqa+Pwg3mBQ/z+u/Yj6RF+bP26t8WjuEk4h+NxyzemMr9LmwRJ994F15bnZz10/nU0+Yf3sbQA2m4joot4HIXmQcjnFjWYX05LVqS/DMN87OA28i2dR0/lDgH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrImMrW8b6/GKuU1mm4LC3BqM1DhRj2B0x2I765np28=;
 b=YHl0BznvjB36VRs1hgsI4ywDtbVzRYdxo0DaA2gIXTOydP+/WtdXn2EjvAneamXSytbny+3j/oR1lDngUyOwX7TQRZ4aY+JutaOpaqBMPTML5BmZ2eXgH+w/zNUhQfC2CAOMcP37EauOyNu5FgWb5+h4FPaW57w5X/TFGh2f4cbn1SRSaLWNHqrYoIJHFcYTvfG/mkh3+Bwn2PgDTSWygrB5EROwSDrmnZUIxtAJ2McSEZZE8GfFTXHU+d/qa+7yrpgXnMy0eo5ra23949KnDQRz+hOdgIreVHvkQ6b2yBkQT24KUqe+yURPVFnIYqpLbNhjxEY4wysjHgbDyK7NbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrImMrW8b6/GKuU1mm4LC3BqM1DhRj2B0x2I765np28=;
 b=kp16c0ju1pnjhzzdgpggVuFJiMnmRtHDhAR/LXtahMeoScAjc723rgGopMCJQAS1g6DiPxRGcSPgJAE5jV/SXivdauWGli+LLQDmmSuJJfwl4Vk4zlL8HFNsexMTs002RILmOdbHt4lgBSNuK5ocmiBfamAOfrxMFQSZ55aLvxvLswcm0lDGjjinqle9XCR+wwWynFiHlI7ibVx/r8YmMJHrOP3cSP87NSIPlOG0n/vR7xfrfBoJHlTuuVmNcDSuzFNNH2n77Q4n2ILpfjFnAt7TLxMZzmpLX9ln5c+DWaL67OiwFmWiT7uplYLYCq02vQok3wBiJS1Ing7kJ+9wYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by VE1PR04MB7391.eurprd04.prod.outlook.com (2603:10a6:800:1b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 08:33:24 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 08:33:24 +0000
Message-ID: <37ae1c44-fe7e-3f0f-0eea-0c684fe04d50@suse.com>
Date:   Wed, 26 Jul 2023 10:33:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus rates
Content-Language: en-US
To:     Dingyan Li <18500469033@163.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>, stern@rowland.harvard.edu,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
 <2023072546-denture-half-5ceb@gregkh>
 <4edabcb3.7e65.1898d54679e.Coremail.18500469033@163.com>
 <ca4ad735-5605-3fd4-c903-fe5b039cf6a8@suse.com>
 <3018cd33.7ee4.1898d7e4798.Coremail.18500469033@163.com>
 <2023072526-reissue-uplifting-5674@gregkh>
 <6be59e4e.8166.1898dd22d84.Coremail.18500469033@163.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <6be59e4e.8166.1898dd22d84.Coremail.18500469033@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::10) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|VE1PR04MB7391:EE_
X-MS-Office365-Filtering-Correlation-Id: 802bfcc6-7b41-4448-aac8-08db8db2fa46
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Nh8vWW/T+HK5sVtOcvKAUITKmpF841smYcuWz04xa/TzYBlaNXLwhUhZpdXQSjD13kN2Qd0nHfgoD6dGAYQdf9tSJY3047vGmXQGa2BAl3HDa9zIX5/CgV5og79l9dR+1NQxeqQXf396u8wVKcJI+4gZKQaIN1CDrvpkRNM85ZN5zfBdvYRJ6NhnD01Xy8lLP9SXusFca+DC8UJDCUvE9c5M0d19T9Ov5zdCpO3OlQOhE/WQHCteoN27Sd4Jo8zY25ffyoWBaKIQU+iY2YrR3lT1kWD0opFbVxlCE4Ubr/cSNRsDEgMbqyuf8v7Z1db+Kkt68F/gyio/KpK0UpwKeRW41HzA+BgN9zM8QeFGa3Y/vbJ3YU2UtN/f8oPQ0y102jEs0C8jO5vOovK5YRkZnE7yeuWyy/XN4XQfv15OkkJtGMhwT2F+RYyPpJpNBtL367kjOpvtf2zH/29MqyIEfkSMQZXcFTcKpXe/mUIrx4JXNehA1v83PNjwZ0RNt2u2u+79A9WZZMOCWVrwaf7cj4Bo73ZwHwx897H+WI4WlpIMV55vOkqK/32VfAEHEexiRzcF+WYWq6ec8ERmgr0zJkLOSTKl24E3/mnSDZiFDR2JNB64R052yfuHVxBSXnDT3mlwDaR5ujq1vXRaCN/Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(4744005)(2906002)(41300700001)(316002)(5660300002)(8936002)(36756003)(31696002)(86362001)(8676002)(53546011)(6506007)(6512007)(478600001)(6486002)(83380400001)(2616005)(186003)(31686004)(38100700002)(110136005)(66946007)(66476007)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFZ0RVJLOTRJK1VXSk9JL1V6L3lDMm80L29vdkJ5dmdRMGIwV3hMWUUxSTdB?=
 =?utf-8?B?ZGpuVVRpTnFGNW5ZT1g1WW1yVU5MdXdURzZnRFczcmRZOTVnRVNNc015RDNz?=
 =?utf-8?B?bFFVclQ4U2V1WnJoOGNLMHJiK2tPakdXZWlOaGhjY255ZzMyMlV6WGIyR3E1?=
 =?utf-8?B?dE5PT2hsZU5jWEhEdUpoRW5LbDc0Qlk5NVNCMjdSSm1sZUdqaXNpVjY5MEtv?=
 =?utf-8?B?cS81OC9PYmpNdVl2Z200NmhrYXZCeEZLZkdjVWQ1T1JvRjBiNTJBYlFDQjQz?=
 =?utf-8?B?UGdYblBZZVdTWXpkamh2L09OSEJqZjJscVRyK3pLQSsrZkY5UytKdzJkTE5N?=
 =?utf-8?B?WHlMNXdjZ3BEOHN5NjdxSHU5RVJxVWRhMlgzUk9xblgveVN1TUpLTnB3N3Br?=
 =?utf-8?B?SllqcmR1ZmNWa296ZFFMVGd6WlNoNjh5L2Jxc1d6cE9ONzJtaGJrUVRoVDVs?=
 =?utf-8?B?RWwyOTNoZHhZemQraFRLUk5Lbm1wRVUxYVo1WVI0eDNlODQ2aFB6Y0x0d1Yz?=
 =?utf-8?B?S3cyY00yVlh4U0xVUEYrSTZYQmFWUTU5WWRXNXh0dk1VMWFONm0rYmxTUW5X?=
 =?utf-8?B?aEw5S2c4OWMxbmlOMkdtVVg4d0JPV1NTYldSR0JnaHFabE1GdzlGRWl6S1ZI?=
 =?utf-8?B?OHJhMkk4ZVlJeE00TGZwcWJOa293QXpsQ2dZSXowOEFUWXp4T09nT1c2ck1F?=
 =?utf-8?B?RU9JcW0rUUZ2N29zbUJPMU1zeFNTNFdYUmFub2Q3d29WRlR4Z0VvQ3lVNHZr?=
 =?utf-8?B?MVp4c20wc0VtYzA1TTBqdTdxbWlDNTFFNVpIQ0doZlNEUmVrMjlDM0p1WEpK?=
 =?utf-8?B?U3Z1Q29aRnJIQldUTVNyL0lXYXF0TVdlOFl1Z3loSWFUdU0wbVd0OHFrM1I1?=
 =?utf-8?B?Ym5EOURmWGJEcUo0THVNb1A1eWs3RHFSNkpkbUpudk84V0N3bXVLTmxzVVZC?=
 =?utf-8?B?Q09zdmJzMDEwSGJyWWtaV1gvSmkxenF4di9xd1RBVW5lVlUxbFppOTAxV29C?=
 =?utf-8?B?aGlGaWtETlpYWDIzMU91bTdlSnA4SzNXdEtYRkZNZFJvS3BMZy9zRjNGQTFG?=
 =?utf-8?B?SHFaWjYrSGg2dGhVTndobFAvWWEvQzhQSzJheEIyS3NYSnpVaVJWZlcxM3cv?=
 =?utf-8?B?NVNKbnJwTXV2dXkxZ2htVnBpNFovQXVEMjdNeGNZNjZsbVgxS1RURkhsWmhq?=
 =?utf-8?B?MFhLT3pDU1ZueUNjdTVwclRDWTNkZkp6U0p2Q28vU3lJZUw1dEhzcEdiRkIy?=
 =?utf-8?B?MjU3VUtaRnRoNTY4d1VSSFNZNmZEd0Q0TXZjeDFMcEtWM0lNUmZGVTVpU09p?=
 =?utf-8?B?K2Y4Zm0rR01kYlZXOEFrZVV4M2lOV0RFaXRKKzBMWFZ6dFgxLy9JeldrdHpN?=
 =?utf-8?B?TFZ6MVVyR3RPaTN3V213L1pPbEtLTUFPb3dGMms1LzBZeGJLNDcrUThmYUg5?=
 =?utf-8?B?N1BGUExrR1BLc3RtU2NLSlllRVhtZjNUcTU3a2YzcGVEa2pOVVhvRWJPZmF2?=
 =?utf-8?B?WG1uS3NkT2xrZzdPZDFtTUJIVVQ3UDNvUmJxRXBFL0R5UU9PeVZQZGk2NHo0?=
 =?utf-8?B?ZTU4Qk9ycjZHcTF1bGhCSjkwTno5aXQxK2FmV2t2ek83ZUdENWpPeDR4eFhS?=
 =?utf-8?B?MFErYWJUUHowT0QrakRacTZEengwb0U4RXdFNlMwS3VoVkdIaHE2UTg0S215?=
 =?utf-8?B?cXpCb1V6Q1h1Q0hTL2drRlZ4cVZWdGRVNmxLUHBvcHFOaUlpUzEzbVhIUkpP?=
 =?utf-8?B?Tk5FSis1UUs3eVdDZjRkTW9wVlI4SDBibEVUOWQvSk9IWE1BcVlXNXdNcDQ0?=
 =?utf-8?B?cktBK25WY3Y4eHBUcjVVZy9UVGZ4S0FIamw2aEZtN0Rudis2Y1MrUFFoVHJX?=
 =?utf-8?B?eC9kbGJmcFZBTExjY2JBbTV3dWNTVEFFbEYwdXNhNnNNLzFCUWhwSjZEdjVS?=
 =?utf-8?B?WXZHUnNQeWxyMHkvUmtaZmdIQUZmdDVKZnBaNUZxVS9VZ2VBbzlQR1V6dU8v?=
 =?utf-8?B?RkdrVy9UUW1qeXdVcWNVV3VCUTNJTjJGZ0lMbVdVckhYVlZBd1FLUGw0dlFu?=
 =?utf-8?B?YW1KNWVOUlZHdURyWEtwcnVHYnlTNUh3aDFSUm02TFlncnV3emx1MTRDMnRz?=
 =?utf-8?B?U29pdDVubEwyTG5OVzZScE9WV0tLN3VBUTNPMWgvUkNRRzZTTHhxcTUwK0FQ?=
 =?utf-8?Q?45bPPNfrzKPpBLiOOt2R7zDscjfp3urFo5iKjfiV+UHO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802bfcc6-7b41-4448-aac8-08db8db2fa46
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 08:33:24.7164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwYr7q2JuYti1UeGvI9YAUE8i6wW6Vb1pdPZRTvYMn/kUUvpVtnGqjSPRozvrpQhjxUTNVgxAVB6e/Du1j5Q+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7391
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.23 18:11, Dingyan Li wrote:
  
> In proc_conninfo_ex(), the number of returned bytes is determined by
> the smaller number between sizeof(struct usbdevfs_conninfo_ex) and a
> user specified size. So if we only append new members to the end of
> struct usbdevfs_conninfo_ex, it won't impact the bytes in the beginning.

You have just caused memory corruption in user space by overwriting what
was right behind the buffer of the agreed upon size. Or, not much better,
caused a segmentation fault.

	Regards
		Oliver

