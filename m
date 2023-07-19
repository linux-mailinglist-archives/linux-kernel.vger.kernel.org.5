Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF0A759A01
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjGSPkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjGSPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:40:24 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C98FE47;
        Wed, 19 Jul 2023 08:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekAp33FkTChG4g079SITwyXl67SkNeZ8kKDtk+Md9/n+RLgkxGBXIwETgPOsj91DxaryQmNCPdHoEpPCGVUcGZm/oQcCmo2T7c+eturHKrZNqbXpQiUEt+JZKGXxkOz5JUgbACSGCTnI2B+VOKD8kdEHdLpEcSj44nnK6Sv+Qf6ZEguq4PTPGOIcn7ZjqtFhxi/MnPFO3bi/Oe6pOWs0QMWv0+mOrRjDswzFzPEIE1ypaXf3JnfcQv3ug2nh5VohB92i3GOKjDWPeVeUcqqD8BQWQ8CRo+aH5SfLIdweD5cq/OIJ3MEQ5PV/dh4nofzubutpCQZ+Yn2jUtzTPo30dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOHGBuuqN4LQSRnU4sLSU09fwn6SdAjk1mSopbqLHYk=;
 b=fQwyrTiZpZbzDtCmlMBU6s1ji6xmbmYeXKLAxuXbPMmaS1mnQqJqhvCFoZVXZmN1GEGBiPbvumn7fkNdOHtPWwu1GyTTzouUtz02xVfSOfK8MvVapMjNNeKC6tTHaChhKSusoUtuZAHhcxPcr37Z1zLHw0RgREdcPTABTAqe0Ch82TnQk/hE9r6cgyFseF1ATME0So3IKsEHdoB7aPZ6Zj7TsVhEXqmmJ+mtFkDMvGJWMyvFN7Hppqi+VXyEhuDkfVoS/Frz//ICMOrczwDJoe9oQLf4WR8gLf36D0UQgD7VCX9LS00zVCh8BqAdGj5eIR/aqyAtq7A+aF1C2rJ6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOHGBuuqN4LQSRnU4sLSU09fwn6SdAjk1mSopbqLHYk=;
 b=WRKWRew4EuohqO2HUCDnokTUik4o+aKqyZ6vbm3GE/S/sVJ4ZrAGzllYw101Qr/5jtHCfHQkaOa1iX8mgiEGXSSkLbU0WHPaCb5Vu15phsqeLdoqgSySw/8pbafWnak5uxwzpKU19lwo/3sY7P3JHOyECo4WcEBqUHQVLG+lcDtgBN+9xLwqpW8RkvEYA9UlLy8Doh0gktmBm+o2FLOXBckuqLQSlRullsrENTdjyP136DVBSmi2TWq8pamt76quVG/GstUj5XnJ7VCwCz+Zq/gmmokYF3h1DXLiEnz0OqfmIjHlozB1IbOfdY6j8DaFalBBqqcZdoO+4TleeYwE7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by DU0PR04MB9297.eurprd04.prod.outlook.com (2603:10a6:10:354::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 15:40:20 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 15:40:20 +0000
Date:   Wed, 19 Jul 2023 23:40:07 +0800
From:   joeyli <jlee@suse.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Chun-Yi Lee <joeyli.kernel@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_event: Ignore NULL link key
Message-ID: <20230719154007.GI14791@linux-l9pv.suse>
References: <20230718034337.23502-1-jlee@suse.com>
 <79669635-9a07-7fa2-e73e-bf31f554816d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79669635-9a07-7fa2-e73e-bf31f554816d@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TY2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:404:56::33) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|DU0PR04MB9297:EE_
X-MS-Office365-Filtering-Correlation-Id: ab96f12c-e7dc-452a-adbd-08db886e754b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9+rCgHFkPCW+4QKa6ekECg/4CyOqKgupcctGXaPU3eDRa0+w9vthDFB5wWJSltim3y+pTPj91aKLAaKYTP1m/2rCNxoetnF+9lRzKtMuMNN8plr8Vzfdf0ARbVeTTKz9TuzSmEtX3WLv7qFQi8cvRoxauqwE/8z4J3XDAt8n2Ra+wDsBpTqTfWtfEGoOf5tjN1jqq2cOvYTTHFlYkSNYcyQinK9LoSZPWBFnC6s3WjbspEYuJ6JHjQSMrcUiM2IypbfUHRR3SZL6jBy5bCnlggm6TOsK5G8oaGq3RXYcXqGDXfPSHyLE+ostan9uYocUtKFNOTz3//rpn6hxYN/6mXM54Z/5Ezkj//8XlLsUy4W1VxppsKy7kVQVEbMVQ/3XND5a9zjxlY7U9SyL6E5QfGpXof+6LOViZr+zuldGDKGIMIL+oQJABrt9tlAoaLvhC2/SdkXQNzk21G3bYw00scZgNo3rWaih9vIGbvF5Nx62wNLJIcB1Nb5DyA8H7qbhBhOEHjprNhXds0+yAT2NEK+s5bn38BaV7v3CJ/5xgZNtpkVEyKGfOLyDSmt8b30FjmhVgEjP/poK6X6hXsCs6/wxX/PVlvSApzl2xS+ouM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(966005)(6512007)(9686003)(6506007)(26005)(1076003)(54906003)(36756003)(38100700002)(7416002)(66946007)(5660300002)(2906002)(4744005)(316002)(4326008)(66476007)(66556008)(6916009)(8676002)(33656002)(41300700001)(8936002)(86362001)(6486002)(6666004)(478600001)(83380400001)(186003)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJVSHEzZU5Ob2JmUUl6TVMrWjZvR1pZNGpzTGRKQmZTQkltLzhvZGNYVnRa?=
 =?utf-8?B?Z2ZSd3NQYWVPdk5XNTZFRmh4L3RTcUVJbUxuZHZyV0VDWjQvK2NWODdFZWoy?=
 =?utf-8?B?ZjBUMCtYZm92UFFlejJnN0xKNFdiWXJGSGNYTWRLcDRxeUsrSTBDOHo4aDlO?=
 =?utf-8?B?UHFBclpTMnlUN0lUSEltOGZkdEFVTXJwOWxJcHE0cWoyRjVnOEFnL1hQRjVn?=
 =?utf-8?B?Sm92aDB5WENxUWNscVFGQW1lYVJRejQ0amh4UFJ3anM5aFJudHd3N2FFT1Nh?=
 =?utf-8?B?QkhSOW4zeDh3eUZTZHEyRWp3czhFcXMxdlcwaVRsRG55ZTJIM3E3VTRwZktr?=
 =?utf-8?B?QTkrQm1taGdZS1AwTHpPb3kwVW5uUG96QVhQTlBuY2R6L0NpSFV4bjBFRmhH?=
 =?utf-8?B?aFlyYzZ4azd3NDZRNG5CN0NJSWxIUk1mQkVVZXg2d1lrY0ppUGVWc1lTN0R0?=
 =?utf-8?B?THBsNk0ySTZJejBoeHJHK0FLUHRXeVk0V0xRNlVkcTMzbTMraVJkMzNoQ20v?=
 =?utf-8?B?WXhEK2lwOUVobDhiTmZnYlV6ZEZmWFFGQlZPZlZOL3p5UWNUVU5TRVE4Nmxk?=
 =?utf-8?B?TSt4RWVLVkhrY3JUSkRsL3V1a21hMnhDb0tKL3d2aEFoNUpSR2JQOFNYRVhn?=
 =?utf-8?B?bUxmQ3ZuR1c2RFdhbG9BZjNOaHF0amFFM2MzV0dRTTFjRFdNRTJOWmI0dkUy?=
 =?utf-8?B?THovdnBnTVk5SCs3UmxaQjR3azdqT2o1Wi9mWktaWDJyRDgzekZDV2hrWWtu?=
 =?utf-8?B?dlNzWnB5S3BHUGZCczNlS09jTnk5UnBzTVE1WnhrMGRMWENLM3lzblpCVFMy?=
 =?utf-8?B?dnd1NC9OejFTTmZwblowZ1J6SEE2SDllZG5uL1hLYUlnckZHdTRhRVdmNmVH?=
 =?utf-8?B?b0tvbXkwMDY0dWJZN0RtdzBwRG1nMVZ0NHV5MlptL1oyVWNiOERadWxJSXFi?=
 =?utf-8?B?c0VPU2RaOGVyU0JWNjlsMlFRelFONnlLTFROZnNob0JGWnVQUkkvM2JoRmdt?=
 =?utf-8?B?N2l1aDE5d01HNW14cktRcjF6TTNVQUY1anFtTmJuc1VFNG05d2FDbC9VUmtF?=
 =?utf-8?B?UEsxVk9DWkx2WGQ0aDR0OFR1dDhDTEJ1TnBqMzBBMG5JK3FiRzMxN05MRVBw?=
 =?utf-8?B?WFplZWo3S2JXb09YWUQrc1MyRG5HNFV6MjVrdHJUY3I0U1dlcE04VVBjdWdk?=
 =?utf-8?B?UEd6MzhzQmpTaUZPaEZicWtLQzBncDNnZFdLNDFxMlZBNHgvWGpDWkhxYUVZ?=
 =?utf-8?B?SThoNVlvZ29ZVHlEYWQ5djRkektsOWpkSVNxYkFRM3o0TjVUYVBrTWZkQjNR?=
 =?utf-8?B?QThFV3A1Ulp2R2p1NjEyV1czbEJIR1NYSjRydHYwRVdKNWNONnBOUGNTdG8z?=
 =?utf-8?B?QVpFTzdHZzFsY0sxL2N2b0R3MkdneVpDdGUzUEFlWnExU3FVeVBNaUc2YUpU?=
 =?utf-8?B?Zlc0d3hCUHIxRUFSZ3ViYjZBZzVaZmUxNXN2Q3Y4amVPbFpWdTBxaENJVjE2?=
 =?utf-8?B?ZUpiQVpIZ1dDbXoxSzdjTVZBaVMrWmRtcGZFWEVuZU9KeTRKZ014Z1haU2Jh?=
 =?utf-8?B?MWFoWXd4dFpOdUNhYmRzQU8vaG1lVCtOWFAwdlNHWUNPcEh3aXJnRDFBVnRp?=
 =?utf-8?B?REYwOEl2blR3TWxod1Z2VTVTR29GTzdkNUg0TjhyOFd5aFJaZWhjVlp3L0U5?=
 =?utf-8?B?cFdBSU9SUVNVRlZScEExekN6aDdoUE9IY0QrRStOTnp0b2lSeFVWdCtEUUtG?=
 =?utf-8?B?Q0RVcUlaOURKVkY5QS9EWHRFWWV0RnR6eGdSelVNeTFxUEdFeSs2STZRZkcy?=
 =?utf-8?B?NFQrYVpzMzNCaTFoUmN4d3BCbGNLTDhmWXFycnpTbUVoWDRhbGwrS2ljckFO?=
 =?utf-8?B?cm1wNUxGNXNWYmNWWU1JbFRSS0UzVHhOOTR2L1hCQjJIanlKWjBMN29PRWRL?=
 =?utf-8?B?REQ1TlVYOW51OC8xSy9PaGl1VGtPYXpCWC8ra2VwQXlyQnF1THdPQTRoRUln?=
 =?utf-8?B?dEsyKzlNMGhHbEdES0tjRSt1Vyt4eklMRHVZNmxXVy9TMndMM2ViTEgwajBt?=
 =?utf-8?B?a1RvZnM5SkJJMUlhQUVOR0VrMkM4UzJ6bjlUY25aWlQ2RHQ3TmFsNEVSbVdh?=
 =?utf-8?Q?2z1Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab96f12c-e7dc-452a-adbd-08db886e754b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 15:40:19.9637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Is5tzaRo1lUn6Xb4Ne3tfDT8PP5m3CDL2dwdGLf3Sqz58KaKFlamf7POMng0KGCP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9297
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On Tue, Jul 18, 2023 at 07:50:13AM +0200, Markus Elfring wrote:
> >                         … Base on the paper, attacker can induce the
> > attacked target to generate …
> 
> Would you like to avoid also any wording weaknesses here?
> 
> 
> > We can ignore null link key in the handler of "Link Key Notification
> > event" to relieve the attack. …
> 
> Will corresponding imperative change descriptions become more helpful?
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc2#n94
>

If possible, could you please direct change my original patch description
for your suggestion? Then I will put it in next version.

Thanks a lot!
Joey Lee
