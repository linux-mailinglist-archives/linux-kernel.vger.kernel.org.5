Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5AF7604E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjGYBrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGYBrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:47:02 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2147.outbound.protection.outlook.com [40.92.62.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F97610D9;
        Mon, 24 Jul 2023 18:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WklyFjVTEGc7Nb8pWTLwNaH6dzqNI1E7uue7BTLXitpkqRPfwQKIOGo3U5Q/LGka0Zja6xD3fx0P/WepxZATT++fk4Nh/7KX2mD1XMayOP9vKAw5CKNenSOkUXCZ0sasS4Y7nhWh3J/jDPUsX9TN3KHOk8sFdq6ODS/cnAgwqut+jKzlAS2T4LT3Ybk3Dz+K05IkWCb8DIzCm8y19rg+aSlbDJSdADmeUC79zfxlnYB/m1BYCxsLlgVIaCznqXVpRzoLqaWSudASrQRS2hRJncJMfR1EpMP/iKqiOiIKMzBxfuMlMgVCz7WDRM927wnS1QN4OVkccVv6Os6T8c0yzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHi2oNTvgR87Cmq8hOo0dOpGwYj2sO/yIGFVJmhqCMk=;
 b=Mqt5SY1EIZAAsf8zFEQSulrB/6aFCIb3jolfH4MzCg4ibYIl2M3w/Eetx8e8IYEXO396Qgj47l9+SNo1oyizdL4BUnrsa2uAOkpEW4qqGLHblkVuYlpKryLKSUuLtQW2cXizs75hPIBweQFh6WES7hBfaXejU8tzeHQ3a/kspFq5OS8bN7XwYbr29QVpe9owTzza35wRD+AXyvaP33x3UygG8XgzFVdbpT/fHNAvfdT21D51ba6YWqIHyFc7rwCSVuLAdJ1+uwuttUUnhEucYex3zNkKTbNJteoMNJV+KO6B4W51QPTImHgEOvdryFXdCceYB/aWWVl0ZKPx+72a6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHi2oNTvgR87Cmq8hOo0dOpGwYj2sO/yIGFVJmhqCMk=;
 b=SkYF79h9xrsRPfiU5Oa0/q2U+oT46m8O+xkZLpROXaltJVTczjIcV/5qZTvtXQpeheyF7KcEqZqkWkXt+qKZ6+n6aMlXGkapnJuSq5bPT4TmEhMXC8mqfF8IwIBusjDuO5g1p5Hhu6EQtK2GympttS7fgwTZ5d7paYd2IOH3OF9Rc69LHAgEAw/sgpjSriei9re025RoRFtqpLD5DsmM1o/ucCILlxn9j00HnHBqMSxPFsCoJaQSZcPNHoHSJx+ZXaxESu8q4vVd6/CvHgfzIlIfkEiD7Gy6xQ6dYNPJc0Br1E3XEfNOxdFJ3w6CAONAzkaJ55WGnuFDQq/6ektwYA==
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::6) by
 SY4P282MB2250.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:f3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.29; Tue, 25 Jul 2023 01:46:54 +0000
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9]) by SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 01:46:53 +0000
From:   qaz6750 <qaz6750@outlook.com>
To:     konrad.dybcio@linaro.org, agross@kernel.org, andersson@kernel.org
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: Fix the I2C7 interrupt
Date:   Tue, 25 Jul 2023 09:46:39 +0800
Message-ID: <SY7P282MB37872A5CB962A92934C83125B203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aa3c95f5-69a8-678a-307a-25bd0ae51a94@linaro.org>
References: <aa3c95f5-69a8-678a-307a-25bd0ae51a94@linaro.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-TMN:  [Y6Egq3QFmGcXSJVRR++WZWDouoB1d4jP]
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1e3::6)
X-Microsoft-Original-Message-ID: <20230725014639.786-1-qaz6750@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB3787:EE_|SY4P282MB2250:EE_
X-MS-Office365-Filtering-Correlation-Id: 2746566a-774b-4572-60bb-08db8cb10582
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bkr89dPhGnC9WrEiXLCj9+CCns49l9LsviEPVg+yiNKnSq6jy51kUmbtJdQIyk6a6HU3LeXIEl563jnhuyhA2D2z3qm3Sl7rUrLwMPibomIrCMZw0OBtBKny/5XO+A+Z0FLbpBgZq/ExZMHCIpzhxEj77jihJOU1ZsklYIOVfjeMt48WUjExc5N8/cKZCWjp7LFqiXT3qVtB62ODi8QxK37ZCPLOtA4SkwIXyvEKhbU7wEVmkifZaZi10aDGlFmj9wXpltMv+gEP9lzPo2PiyEmGID4flwvqODIM8PgHteRrARvHi8JpJGq3SNQCUTHc54Vv7QTVspdSmUDPXl14jR9Fyjlie8SJz1jTP2lEnQSMP5q77hRmZkOtHVDGd+cgn0W75YGLhhMpvCD/qtizx+JQhJzjpR76LFgRpoDYcYeJkgYHclYBnRM3BKKYIjpNE9bIFWrLGyL125UIVzBROV+e9oUXf+u5GbqtIBIRV+ilIbP2B5TASsSOEiJvVSNSe3qTFzywyY9vwuoI/fn6JLXSH1Zx+IBASbXCjGT1Vqw13iKZt0phMXaFaFz4St5O
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bCFpspBqpjTPdM5CNGmoNAIWHnCwVliESgWn5wZZbBz0Ql4OVq6TsfQETouv?=
 =?us-ascii?Q?EJXLiTP2F0trqS2+ozSNsLGINNrwOdRdybHEmQDZib1UKMS4vRVHNidJHkTc?=
 =?us-ascii?Q?Rl79zAaIlme7m+TydRoA4nJddYSMwuhcBdFy3/q8yNf6eWwtlGdHxGtbt3IR?=
 =?us-ascii?Q?45OXhUjWejVWHn1K5Z28pTWfvUtE1LGMY5NnMOspYcdv0Yz1mEy2i5+1snGP?=
 =?us-ascii?Q?WUhCKLHojINVoyUVZGGN+Nz7xud+ywKxu6cPGgCIGtEL3OW2WwuOj3VceyH5?=
 =?us-ascii?Q?HwU+7pAv4gXPuZQXu6n7tr9+jCjixWjt+cn6MI06odLndvxC4X3uVDsbJJU6?=
 =?us-ascii?Q?LIAYZ+2bWpF6yxfXxhvcefv5JHzVOGFl/kpEz22j7/bVA47ZJKpAMR9CLeUl?=
 =?us-ascii?Q?zZiWhOfaNqxHYZWvS37iAncz5L0ninnToL4fwpFw3png0VsmWflQMm8Kxh8c?=
 =?us-ascii?Q?YcGNfL29R9431/gEM/D0O1WfKNuv3bsCGZjGOBxm479WgpHZ65HUmvLrmDC3?=
 =?us-ascii?Q?UYmFzcD78Xjjw1daZtkjvFoWXIHwNEsc+FlsKhgQrECcaNQEqe8FwbcSZ1W0?=
 =?us-ascii?Q?e04zYmKXlKHYl53dfsZ5yHLVK4O2I+ltT0LfngWebPZb7GzYgX0X5Q2lQXYv?=
 =?us-ascii?Q?S/JvK7OaBFFI5iUe0bXBbJQgxenG3eHxFtWWoNCTWlq/5rwg6lAnI7+DzS0W?=
 =?us-ascii?Q?AQ3e5X8Y4kht1Y089rG6ebfV+mXhH+hljxossLIWlkGd7HjCJ6CacThEocma?=
 =?us-ascii?Q?aPVc08jq0/u9iaxrpIh5De+aZAc9sak/pnV6QBl7Aqlla30PDZ5JWN/lyyxw?=
 =?us-ascii?Q?EJsVmuAldvhqjuxf6CF9nqhCn9p9ITTs8Zh7UzX964AbxLMMoaxe1xVMtGuB?=
 =?us-ascii?Q?AJHYoqhSilchPHJQR7mNV+D5BjDJCi/Whmv7/B9wTCeAsZrzwLtFZEHMJili?=
 =?us-ascii?Q?THirXTWxz3h+OU8rK1JbI6rkdHpLZwyYKLaKtt7QymTrIzLKtl/uzYp4pg07?=
 =?us-ascii?Q?2yrO9lmyU01WpCmUNQUJ5B9SXbX1qhrr+1EB9ajSAaWpr6inDaTXBGNGxqgL?=
 =?us-ascii?Q?1KN1xI+0NPLAuIczJz/Tl2+nD/WftaeGccgaQbmy9csZ6NNDqpxQs/3/gF3q?=
 =?us-ascii?Q?CWGdyZqMPGZjaBo0F5unGWrl8PDlQZid3dwW2VpsVi3tX/jtue7nW4D8lgCW?=
 =?us-ascii?Q?OEzlMRZS3purqmcW0uvPry0+m9/nv1kE1QwKxQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2746566a-774b-4572-60bb-08db8cb10582
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 01:46:53.9203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB2250
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.2023 9:44, qaz6750 wrote:=0D
>On 24.07.2023 18:52, Krzysztof Kozlowski wrote:=0D
>> On 24/07/2023 18:29, Konrad Dybcio wrote:=0D
>>> On 24.07.2023 18:21, qaz6750 wrote:=0D
>>>> I2C6 and I2C7 use the same interrupts, which is incorrect.=0D
>>>> In the downstream kernel, I2C7 has interrupts of 608 instead of 607.=0D
>>>>=0D
>>>> Signed-off-by: qaz6750 <qaz6750@outlook.com>=0D
>>>> ---=0D
>>> Fixes: 81bee6953b58 ("arm64: dts: qcom: sm8150: add i2c nodes")=0D
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>=0D
>> =0D
>> But we also need full name or known identity, not anonymous contribution=
.=0D
>Ack, I overlooked that.=0D
=0D
Is it to modify my "Signed-off-by"? I'm sorry I didn't use full name accord=
ing to the regulations.=0D
I think my full name is zeyan li=0D
=0D
=0D
Thanks,=0D
qaz6750=
