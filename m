Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3EC762EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjGZH6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjGZH5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:57:53 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2172.outbound.protection.outlook.com [40.92.62.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBBC76A6;
        Wed, 26 Jul 2023 00:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBn8YA29M9XzFdN71ZSInQBLpLloPy43GT+TQ9yx7b8Srq2+jA/B4qt7BPbQx5DIqXFUDDKCq1vX43B0zInoAy2RRZzLcRz72Vng+Na1q1+45268yCYU67GHE13guRsiwRD/P+m5+Uv+yd5RBTtLtj8OvR1SJ8n20iFzysnLm86KRUuoFsRGHbLWQBScPLxgEt3xFKI055QgvcYDAypzjtnf2oNO3cmK1+AvuHTdlLGwx8bI9e9Z5j69B1eK9quKzi6FZVBrlysbdqI5p06PhL2z5q+A9D2pgBkWZ/XVpstJIzqiqCLQw5jDoHk4IMStEK4l7i3peOm6zmwRpu+4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kVEK7j2gDSK0CSydLgj9ZQoPUQwXz1tmpa7rhUXOZU=;
 b=XZ7I4h9vXVWjRIkrhpSP/KLHQaroe60Kk+vISZMnKIAVHUAoLpnJ5zQEvhIvWCsC/EVqnRBGDBSK2wxr0FPGU2oddiIhiPkWmPVwBTIznj7k5k3I+Obq1Vf7V/Q5Lfr5xa8I3ssF/oLiG4RupAs2NhgVQVHhY6b5aDeWAkw7CaL6Y3r621y0mOsu075x5FTAsk4w/dkEBlyNFtQNlMj/3nDDkztMJXZBoCpf9hAybAUpP7ydF6k24sWP6gRnCVnP73alSF1TOO4In9ZsY7r+ehaXl7fDVCtdS1M5773qMsv3xBcxKCgx4nIJzaV4IUvwmLfOpdh/iqHsvX5R+h0bPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kVEK7j2gDSK0CSydLgj9ZQoPUQwXz1tmpa7rhUXOZU=;
 b=qtsyp8E5OXG/LvE/fvA9K/9B0QVyL+VckGAcBHDqpknSz+I3A6Jv5GUwBTP/ysMzuUQhKW1WRL/nkDeAqP1rxH/6Q+1RTDt3gjdxRerzVI7P5h7D+iv8pjvposE7Kh0w+PD1DUMlhpsB7UEqK2iYFHf85aKW8t+i5mtCfPZdv0VRp5g/8Upu+GVr7DYT5xVnxIK+UgtPlr8Ktnm5eh5kPpZ7YtlMvg9h9MrC4kHWJA1VsYnj2dhsrpleUnhGQuW+qnvrrP2RP/lwNmpGaaWKgmDulzwIKZg2l3pEH5gs99ElAkc42/ktK/YWxpFe4e2oytVXpezpSRHm7Zm6lxfB8w==
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::6) by
 ME3P282MB2985.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:13a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 07:49:38 +0000
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9]) by SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 07:49:38 +0000
From:   qaz6750 lzy <qaz6750@outlook.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     agross@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: add uart13 node
Date:   Wed, 26 Jul 2023 15:49:23 +0800
Message-ID: <SY7P282MB37876FCD449EBFAE187FCE1BB200A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <312a2e60-efc0-855b-e33b-a1ec8411d595@linaro.org>
References: <312a2e60-efc0-855b-e33b-a1ec8411d595@linaro.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-TMN:  [lA+NHCEUcM0b6NUoLnxhh+TfZI4Jwy/d]
X-ClientProxiedBy: TYCP286CA0276.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::13) To SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1e3::6)
X-Microsoft-Original-Message-ID: <20230726074923.934-1-qaz6750@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB3787:EE_|ME3P282MB2985:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b06f2d5-7d0c-4220-38db-08db8dacdc93
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a++zFg+WyhdC1aEAswlecNExhy35XBPDRwxoUsmB+d4m1tvCD45WkShgkz5REId5A3XfNo5Y9V+uDazaqeZDhiShpcqTywbWSzMd1h13yuvqqFjQloCcIOAmejnKO2qUkUe9Wk50BNi7/jxWx6zrobl62xWu+2wIkB4DrNGeMx7NTSU3McZy5Qwlo4t5wcJonm1xGPE5cJiTL9mEHdfeSFb0fy3l0qAUtxe9wO90C8IyfZvmO3vYCdOeMQh8hy+/qdEGP9lRkWewt44EBfvWQ1Wk5LsBsn8sADrOv/jjetsrbnLjSJZL4DRK0yZ0lmFheykMu5KBM5zJ3R8k64r4rV6i6oytMVQBUZbLmQZf68x8vwSDjcnOTL6S9PQb8VNGhwTPzPG8K3kcZrMARS6e30/GZME+YOErMcadiYxEJsBuNvxvZgr/EyBR7Xzk0r3tHhP+1ceJ7PxcqCFG5icPPohrRh7+SLgcY3oz2ZvvvfIIQMpmiss5aJ0DrmfVmzHIwgSqtZFaOZnKbiRKogF+in1Uti/QxcjMUp+KahhBEhvUzelolcQFgnF6iW4HJyHq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+HOyhQArxuq+FTpLX5GmApkHYKan9KaYbEvzeB7eemRGxF+wbmOJGv0KMv+H?=
 =?us-ascii?Q?KMgdrf1IUhXTHY2TE4meNbM+pSCmb1mqJonAxFFr5+f7Mc5tp3eACc3/ZSn5?=
 =?us-ascii?Q?CPX+dtkT5CgyqswaieVCo9CnncBT87vT5JNKHYVzeMP2zTZ3vRhX3sOs9LuP?=
 =?us-ascii?Q?/Q54HpLlmFC0JZmihfwFlUyp4u8DIXkfleD2MAnwYYv+cwitZn+lmqihhqOA?=
 =?us-ascii?Q?/odbB5Fmh5yulkrAlBAjoHPhHSCiMQUpUQEzTVOGDJrwRv80PU/5DhqMXlyv?=
 =?us-ascii?Q?1mDRKSzz1LEgPgOWaC3KP6nnUwW5gz0rPcf7Gfw3nyuW6nEDJpIDm26BEH0a?=
 =?us-ascii?Q?7D7HBHL83qu7CHDFnmpW1K5sgMvO6U3kBRCDB1ZZ2uk1wm+kXd+YDjgKD7Pb?=
 =?us-ascii?Q?T9qkbyizomtWtKV5LVsm5xi4dfjDjKq79C7a4tpqf5bcscts1ftP+nupuVrZ?=
 =?us-ascii?Q?wTWwnh36gxTJEAUqQyjIxtozwAwWpomLHD/bxKrlYHgBkO5kEiQI2POojoN5?=
 =?us-ascii?Q?hgXbv2HpiZ79CTKCeFUgCOrJJB3Om12T0cqV72LAdOVzehqjsSBYozgxfpSu?=
 =?us-ascii?Q?Jjx7IXwiDcFANyy+nfvAglb9WCWgF7MWJ1Ypfg4kXo+k6onQzxpRCTPjPsUB?=
 =?us-ascii?Q?hersju/Zw9SLZ9z6q2wxot7jg0s/MlSL0fvwhU1Ee1wRB+ItWudkNKL1QWH1?=
 =?us-ascii?Q?7wzc87ZG8ziqIvBFC9NB/wMMHl4nu7giYh3pWSaaiCtZZ2gPKdXEzclsqhGJ?=
 =?us-ascii?Q?j+xC95KUGof7mKbjkFw5B4ApK6q8GcKJ11AkOYa4mLgBef7EIkduS14XLflq?=
 =?us-ascii?Q?HP6KAZ25UxMJjVLYEb7NbcCPzctC1MljI+80RtWmXcmrJf9aCERhRyH8Hvcy?=
 =?us-ascii?Q?5vIQgD91Zj4j/cOg7eG7x3XLHa/0RNL5uQF9BpdlSkxW1dDuUOjQo3A62THs?=
 =?us-ascii?Q?xa+4/9YCQqE/tmhLkBuVyNII+0ExFa3+GgEw6n71vnf+HASid4Cs+nokbRJF?=
 =?us-ascii?Q?eyP+MaQA5Et6Xn1sAN1NZYaqE7nRc/oaCdyjq553LbpnjS7YoZ5xkZWlhU+o?=
 =?us-ascii?Q?A85OKBETcmL5IyXBkp3sQszlKCfW6gxBotZc3h9qo6rwdGeUA2KmSawGCt03?=
 =?us-ascii?Q?WeCbIOFSKJ7p45D3Am14I5GURtwQYX3BHcwDLZ6Iel94+XMc3cNjXAUiOJWX?=
 =?us-ascii?Q?kZnI6uzlq1EUn0C4v4Pq+ib/MGDVZaNI4LaUmw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b06f2d5-7d0c-4220-38db-08db8dacdc93
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 07:49:38.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB2985
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 25/07/2023 09:22, qaz6750 lzy wrote:=0D
>> Bluetooth on SM8150 requires uart13=0D
>> =0D
>> Signed-off-by: qaz6750 lzy <qaz6750@outlook.com>=0D
>=0D
>Not much improved here. We talked about this, sorry.=0D
=0D
Okay, I'm sorry to bother you=0D
=0D
Thanks, =0D
qaz6750 lzy=20=
