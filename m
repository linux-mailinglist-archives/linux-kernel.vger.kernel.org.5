Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB5F7893D8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 06:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjHZEnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 00:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjHZEn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 00:43:29 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2482A2136;
        Fri, 25 Aug 2023 21:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMCSFZV8lZmvwc4EPukOMNQl5eUaZCJhS4Q+U2qyUIu6Ww0klebNsstDUm6EksSMrVl8VB+fwX3SCLA+K0tx77hHoMwrEJ0HSokvZxN2zx9Nm9vva35CdExroG3u3Cu9kUQNuhS2C8MNJtl1dXrMblv4gR0T4Rznf+55xSZ246iytF8dn7UwZ9D7mr/9391MXc2S3EQKdIiZWkrBH7GBhZDffyJ+TB+WyMCwGDo/50IF5RLqGYOQ52HBd75zChzDOW1bbfc8gnaRCgw33cjQVmdK/IYT+C9fbwQkQ9XT7QGuxZjJ6faV34oT9wBIxMRh/GiezA52c1wyh8ZhQpgoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7k2Q3x5G5AoC6CyDyxCbFQAxQop5PPPkDzfOQ0YRoGA=;
 b=Z5F/HbMv679dXASkJMn6yFtftqOIG7d8tWruqPUJcJ1sBYaSgkyr9X3yOnZ8uqoC+ND7kDRWzfxarH7vGk/9sAUnigRfmgsBpe7Cf3iwCfKwAU2wZzHOwt95d03rAR5Xpg6UmNJ1Lm1wW8Nm9niCCc3sJ66V0NqTTaqQaMJ3eLchONp8P+OzLHh1W8L76/VRa9L1hrofkQVNA+WfM2R+6hlUZhsPWTHWhJ657gCFQEQt4dRb8iKt1vngSajiRBnYvaxwKgzYVtunCUXsehBuQDtAJ4OrabZy9wBZwltdO1Dc6RZA9tSakTgU/3zRByhZ4r8/IuF42SpR1TvioiZ4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=embevity.com; dmarc=pass action=none header.from=embevity.com;
 dkim=pass header.d=embevity.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embevity.onmicrosoft.com; s=selector1-embevity-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k2Q3x5G5AoC6CyDyxCbFQAxQop5PPPkDzfOQ0YRoGA=;
 b=KXXdG0U3yLaRJPXQQ4AvtEbmyHfh6pw/pVkeYRb/h0//FSwLXO5iuyl828bKwv0eLQ5T05w1CO/r6k8sMOKwFGbm+HoffjNuhcoRuaF0lciL9Q6DuQ3OdHJ2RTIqJaZLQeWjbFKchW3O8iwa441Geh/DOfSQzmGT3alAtcp6azv3trEBC8rE4kTlm5JqQp7Ftx/P1sFjEw1rU3pvEAIyQLCZb9NDOVGN5flD7bWVsuvUbwBne1gE/OkXNWOGYuoS0XssSZt+NBzqSB+kze1wZAlsS00zX1Qjb0CgrEK8bt2cKgPvz7WKX2nHVuafwXx+3wBlWqnR9M64xZUXLqd7GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=embevity.com;
Received: from AM0PR07MB4243.eurprd07.prod.outlook.com (2603:10a6:208:b1::20)
 by PAVPR07MB9240.eurprd07.prod.outlook.com (2603:10a6:102:315::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Sat, 26 Aug
 2023 04:43:20 +0000
Received: from AM0PR07MB4243.eurprd07.prod.outlook.com
 ([fe80::9b2c:ac40:b73c:6653]) by AM0PR07MB4243.eurprd07.prod.outlook.com
 ([fe80::9b2c:ac40:b73c:6653%7]) with mapi id 15.20.6699.028; Sat, 26 Aug 2023
 04:43:20 +0000
From:   kornel.swierzy@embevity.com
To:     andrew@lunn.ch
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kornel Swierzy <kornel.swierzy@embevity.com>
Subject: [PATCH] Fix encoding of ethernet frame length for big endian platforms in QCA7000/7005 protocol header.
Date:   Sat, 26 Aug 2023 06:43:08 +0200
Message-Id: <20230826044308.41085-1-kornel.swierzy@embevity.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ef21625d-5df7-4421-ab5b-3d49b83c553e@lunn.ch>
References: <ef21625d-5df7-4421-ab5b-3d49b83c553e@lunn.ch>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0333.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::29) To AM0PR07MB4243.eurprd07.prod.outlook.com
 (2603:10a6:208:b1::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR07MB4243:EE_|PAVPR07MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: d0139e99-ad6f-41cf-e4ac-08dba5eef935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /TV597pd0/LTbHkihkORJ8L1Lpls3nY/SJv+25yVvjAEOcXfv3oQ3AC5lGlV2qlekp0HRwtkUQ5DIHQT8cINrrZZAmLyweTQTUWzMWBCBKl4xSuqijeXo6/7S+yMfN691zP5hVHG/2kDO2AjiqkvK5HrgSEU53B3xzRlTYml/s/z39Az+opp+NEjqAju1hfobHceuFjJlFPNuKJvTfHYrTXinr6n6I5C6AtrGISGOrwyYlfh3Nd/+XFtUypNPdDCDk96y3decelimj/9Ktm47V/AtYowcP87Kk0woCiAO6mQFgq2BM1PEvn0nfztn5j9aAKZrrGqOMrilJssjc7ym+hxRAP0ajcLBap4UvMxttsrz03ka0uSuom/pjmpG9cG/SFn2LTLo/r0EGHI812me3AiXT7UbAm7WSY44V+Av5LVFjVTSbVACwBo5fNVI1jKsThlfJXkSwa3oXwsQykDGKyPSiJD8CNqnz7ze5D22fR4r1FpS4WUi8RqmPOr2zA72qa1xCkEiwzlFoelC1rb5DAj1kOdNBGmkMCwi0Czpcqa88wNCRBCD0vv2rHUHYhw+WiLRjwCttbl+x2eXudsk53rdQjcF6e2RawrlyDjhGX77ysb8u5rrCzYkRp8YB7We1KWCSk8ktIBLk5Z2xmkTtkw4HmF+Rjv/Ddzf5NQ55DbFGVuj5xW5ZL42F/OVpup
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4243.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39830400003)(1800799009)(186009)(451199024)(6916009)(2616005)(53546011)(316002)(52116002)(1076003)(6506007)(86362001)(6512007)(41300700001)(107886003)(6666004)(5660300002)(36756003)(66946007)(9686003)(66476007)(66556008)(26005)(66574015)(6486002)(38100700002)(38350700002)(478600001)(12101799020)(8676002)(966005)(4326008)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qgG1nt3S/K9zmYwTNMo9DW3yEgV9DTMkzJMiQNnBp4XnGSH61cZ7NfZYpFjO?=
 =?us-ascii?Q?hhjvz7LuaB/5TvwviuChrxvV8/Kv+CFKtzLBMSHxrRW26TsgtUgr/mQk7Fzg?=
 =?us-ascii?Q?mLjji+1twTtEZNSs8Yjp/2Z0Ltypw31dkKkZ0P1GVw3iVPizBJtwpAxYvlgj?=
 =?us-ascii?Q?JI/sicFjC0U1RJHsxUPQ/ByYMkQefKa7cxGCjiUyOtxNip/oLCYDaPpee6oB?=
 =?us-ascii?Q?0PptqqmNezTpT3Jt1JSzQK4CjWBEVsXX8V6R8A4pfG34gUNPD8qwWeQospiP?=
 =?us-ascii?Q?RJFo6068lA3jgI0/cH1+1iM14Ld8h8yBgRV0b/Zw2HtGmJXtZQTBK1aufspN?=
 =?us-ascii?Q?MQXKtdzeXh6PLgz3SNmmyptIp38XWvX9Gg6nBTVngKDt/6UDWvzT9r+bE4YO?=
 =?us-ascii?Q?TJIe/zzpTUa75j66py8XIpMpbf0YSVQpsKd5KlwOEJBd9904JuM7RLo+BD3H?=
 =?us-ascii?Q?kA9+RsD8+LlauY1TtBb3ascBgBVlYHytE+cQxVYR575HpYI+Gy7UHzQRZlYM?=
 =?us-ascii?Q?JYiiSS4xKZZXxozvzie9s2tTbk7zp5bmrnqzbEZfPQa9IEVHvcxzml6NDiLc?=
 =?us-ascii?Q?fcRL/tMwRba8BIZ6y7K5dy2vdcNVlm4dfJHeQYyfGESxiSfJUZnHTg8/2QGq?=
 =?us-ascii?Q?2zy0XylkHwqplxGA787dy2TiRjMDBCcZnropP3iOg5H5LwwMFnR4wHo5/Ji1?=
 =?us-ascii?Q?1CMMsVGPExsTuIt8PnvYuVWMyyZqh9T+Ji6ZwAgmti1ozlYc3SNrun/MQISc?=
 =?us-ascii?Q?iKtC44Y+HOK9lnMf5mgXmpEwwJeyJLR601p2v2y/ZO9Jcov9WeTwx7zhwjxW?=
 =?us-ascii?Q?iLeSvmGgkcJnIYIfPr7r3ITHGNB5cs5tOsJdAcLDmsgY6OVtSjxqgegDlTMG?=
 =?us-ascii?Q?iCb8lnQbfZdWyqk+qfKL6ZV3S37eIxXWyIhr25nxlVAj5omZkO0ABCjERb3i?=
 =?us-ascii?Q?PczKH4C1crjJJE0iPDk5XPxtoF8+hPswfl5GL+0QYPPFnohuh9SB8h3Hp+Am?=
 =?us-ascii?Q?Sce2q2zAy/j64ZGfduRPx0hvPiiHCFqT0FBjQVRz1ol5lmDNnXUuP29IWl4T?=
 =?us-ascii?Q?PzCuL6bPqYmJaEPw+uF05E/PCJf4J30+H+/yyPbkNTRFXBRNA/4fmyxVudoa?=
 =?us-ascii?Q?xbz7gVzOU+gXmz+P702lYlPRQN40l9XPTTMRziM7ahmfflxCvyCXYd561hOT?=
 =?us-ascii?Q?vY/ALO38mhVThey7UjPYEiF4tdRLarpPWETXDBXYpKB4PsVX6fwaxvpp/SCn?=
 =?us-ascii?Q?vqJxu4MV8yFyzXdfsVx6pkUJIzm1EUzurX9VojpJ4izg1gxQa7Cfi0gIXiUV?=
 =?us-ascii?Q?NtX2550dTydP0GozEwarRM7YZESpPKhU2ms7Qca5+vOB3JHvvU99hlE4ernW?=
 =?us-ascii?Q?OvUQOD8fw66R4icfnLdx8DHZQoMGYVsYpnHGgVoOrAu/H0QvASnyuyevR6sS?=
 =?us-ascii?Q?GLb2K2Q8Np5QBH2Jw7iw9UbkybX+hdrLAFFoppllp8/eufX3xxqoHdoYpo2A?=
 =?us-ascii?Q?gzOBoqNyvCUKYvjtMnkUuR8+KTPCmBIcUGyl/EHgTNIntE5U0u0m47Pca1H+?=
 =?us-ascii?Q?Ysa/3BnJYGGMRfa/xomuaYRMyy39LzmqZoJh6UNpngN/WEx4o9aumn58T482?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: embevity.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0139e99-ad6f-41cf-e4ac-08dba5eef935
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4243.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 04:43:20.7658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 39a59075-037a-412d-8cc4-23a40ffb7ab9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9lGYj1UEcOlNq3tUASU8S30DpWr6Ah3OLyfPS1GPOTs+vdPR9tFqo42/l2IJQGzZUs1JFQlcGgCpbc2gac4Rr2JGHmG+T4dAQTkfFeJc+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9240
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kornel Swierzy <kornel.swierzy@embevity.com>

On 8/22/23 18:08, Andrew Lunn wrote:

> On Tue, Aug 22, 2023 at 08:59:56AM +0200, kornel.swierzy@embevity.com wrote:
>> From: Kornel Swierzy <kornel.swierzy@embevity.com>
>>
>> QCA7000 protocol requires that ethernet frame length is encoded
>> as u16 little endian value. Current implementation does not work
>> on big endian architectures.
>>
>> Signed-off-by: Kornel Swierzy <kornel.swierzy@embevity.com>
> Hi Kornel
>
> Please take a look at
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq
>
> and
>
> https://docs.kernel.org/process/submitting-patches.html
>
> This appears to be a bugfix, so it should have a Fixes: tag. It then
> should be based on the net tree, and this should be indicated in the
> Subject: line.
>
> That change itself looks fine, you just have some process issues to
> correct.
>
> 	Andrew

Hi Andrew,

thanks for the answer and help in submitting my first patch.

I have one question regarding your comment on which I couldn't find any 
answer in the internet: should I post the patch with corrected subject 
and added "fixes" line as an reply to this conversation or it is better 
to submit it as a new patch?


Best regards,

Kornel
