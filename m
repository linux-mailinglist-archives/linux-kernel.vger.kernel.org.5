Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B937609E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjGYF41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjGYF4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:56:24 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2170.outbound.protection.outlook.com [40.92.63.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2BCE77;
        Mon, 24 Jul 2023 22:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HizOu43cAMjSymvMzYYftb5mXMdvttbJaf93fPnQXqOjG+GuGnSSMAtcZuJbv0RUbICyZwvyXCL9Vqhv7plCERwBxp2zFca6nJCYiV/TSNVNsj1gpsiD3CAwHkl8CEWP98TMW3DVIkzDaXf8Mxs9gIlOsAcDaooRXw1nmiFEYNUb0ig68eO93SjQ2UkQSgan3HxEpW4H8sbVukox9r42c1/1Gg7EyhRmswxS8GUK8SQ4fTmbemUXf0dYjkMUfq400C/IS6DhXo9ECNQJvQBpOAukHBrY50Xes/vzgRc+WTTSjtWSXOhgbkzBjnhQvv5IdsqwEKHW4dpmcyDgc322og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXl7OiQwjXRdc4IaEbZ7HI8jVSRAq6hYDKSMWwOqO5E=;
 b=mB3pC0eiP+ihUv5qlOAtYQTfzfAubQCR5JsRhJTn7gIeMPNixjIX+rc4NsjRilpcLbR+UvJtv2ffkwQA/bZ+P8vP+rQIChXPdPHgduPQZPFY0fR+EYMDAkjxSh67Kdlq3VGrv9bFgoiv/OVyGx28Rmh1oWt/68mpsKH1UuHueEjmRtFZlzgHQtB8wIclEMgOVtC4KzpexriQ0aVggYRfzxgAUnkxmkDQVZpXbsW5iRREhcccpAXDSPj5IXJN9el/l6e5WambxaDj8aI8fDR2AuN4AuSp38PVn3YPjStfg4t42L8ej5W1Umqbf9g4whiGqlf39uaLKj/maHYbFzmfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXl7OiQwjXRdc4IaEbZ7HI8jVSRAq6hYDKSMWwOqO5E=;
 b=sUN3oSTirKf/Nea6ozD3O/442dcKPbD91fJCeMO/NmH3Cmp1dWxCJ04dLwWbhK6SoZEWi6eBN0MTH73BFM9lKU8EqVh2bhKzLjmu5QI++n2mfj7vyfeSVD5OY4uVGnke4gs0NayqYnW2ZmlpV4AddAI55/wsT36wqg71eBo/9qu3nKOodQRK6wv9HWGtRqQGAPFLOHG2EAIdoJjc1YFVoTsQQkIcy0Un1+ylahfajrXRnDdpN1rzowsvkkdqFZRin+OP8IwWVY4skW71n4nJPPJEq1Jf9XQTcpkAKwynOvb0qRsq8FQF1Gp1/aMrdJ81BDBKl2rvBHI2HKo+RpX13w==
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::6) by
 SYCP282MB0560.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:88::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Tue, 25 Jul 2023 05:55:47 +0000
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9]) by SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 05:55:47 +0000
From:   qaz6750 lzy <qaz6750@outlook.com>
To:     konrad.dybcio@linaro.org, agross@kernel.org, andersson@kernel.org
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8150: Fix the I2C7 interrupt
Date:   Tue, 25 Jul 2023 13:55:34 +0800
Message-ID: <SY7P282MB3787D64A586E9DC55547BB2DB203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <40e3d1d7-468a-c822-6f2c-6c46f4a02f5d@linaro.org>
References: <40e3d1d7-468a-c822-6f2c-6c46f4a02f5d@linaro.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-TMN:  [lh3uPKgEsvmRTvo9KJB4damMPSHa3TOI]
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1e3::6)
X-Microsoft-Original-Message-ID: <20230725055534.627-1-qaz6750@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB3787:EE_|SYCP282MB0560:EE_
X-MS-Office365-Filtering-Correlation-Id: feeecb97-ed35-46fe-dc5d-08db8cd3cadc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DaLnUpVgLsu9KglEMHvpaYUVM/8yKVzYzbkdxNn6rnIdkoiivG7am3mIymUnqo9/Kp9XiQ/2f9qTg4Gc+vJXGlkZtjFGymzjVUWOIZ0Nv7Qe481ax78PlTP7zS6zhw+okhVrh9lLiTPP8dCqaU9Oki/3KUSjO8fYDqDd2ZQrUW2VIToEAv3b9IUIT1bOF9vpyDu2w3353d0IdoN1qMalAjH3CgNW3aRQxPAKdGI2xBoIffJpsVPI456Rmq1i5RCBOdLTzi/cwCSO5xmQmRS1g/3pIpNqAy+2nbFd9eyPP5Z76OvjO6jDWIyukrd5BNmXxdcUh52AsNJNDL9vZVuDmHOpH07WkzSJa4W7s5D5gFbZwDCB6Q+2Cy59UYLYydpNliLpk2i5YQfuU1OfTDjU/26x+ZB/7WM7fBwnKOpzgPw3OBb8UlbrOM/85WZQrwd2RiprJ2aaf+5JIqMGGm4p0CIFG234eOIZIKJCk6ynZn1P+m/YxpoDu/vlhD2c8yUNj0KGoWgkzBbyaQ/IFko3VS+A0BONuz1aftr8YvETGrUoBlMB/HFCZU5BSwrloyao
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nCroVRTInpWYm4+0dr9fEltR8HqXuplkQzURJ/C5cCOhKMUKUGcNJFaw9odA?=
 =?us-ascii?Q?KjBGBlgZC238fSTI7MJx5yhMVxYDfIRmziC6PWNRz3eowFnG52LkGMMS7oel?=
 =?us-ascii?Q?bnn7MYtobKJMZ93tpV9jvbDDlXVYMuW7aw1wwrYfAnJMyu+7/0V4EFO8gCuR?=
 =?us-ascii?Q?N12/5C2gsIZnv50qiVb5ImnmGUOrhCgqUmYWg1ISR8aKoUJXUoRS8YW6uAxw?=
 =?us-ascii?Q?5zOY4fTIawLkpGo6MNdWsbdee5Jdxn5yIV0SNjznIyOBs0xqhNFVOzFFCyiq?=
 =?us-ascii?Q?BmSZCC4e201lNb4FgfuAJogEov8kegBnB5ZHsNw582T/7rIj8kANa0ledgKw?=
 =?us-ascii?Q?vC4OhvpZEN+iobRz4WkoQ5JR8YIp0HinExK6RMiHjIW4U3dk302HzQyYWB8P?=
 =?us-ascii?Q?N3MckgdnT6KkTjFdXCvhPWcKTeNTRh8CxB+rA3inrQriRqUeFOcoYwLCqM4V?=
 =?us-ascii?Q?Gv8Q/EX4ut2wFwi8F51FWXU1kNdjJCTHmQ3uN4QhvZnrxH6kaenVy6Df+Rjx?=
 =?us-ascii?Q?hGSTFma10SReDD9I3aWqCbNP/OX0XISxEWvHMKx7kod5hBjLTrq43eJ6jD7R?=
 =?us-ascii?Q?inCv2BRF0f9EzjIcV1TYrX4MOTBv1HnD0ChOgd78WiX7+cI6hYBMct1r+3b9?=
 =?us-ascii?Q?JLV7zsrLnw1Wr+uXhnYqOYvDOYm+U632rrs4eXIQOP2Qm1NQBdbXUvll1kSP?=
 =?us-ascii?Q?eDJblpLkuZAIQmAtD+NDSTyAKl2EQk4jGTNCR+fgoMHcNLuxaHFV2nFEohx+?=
 =?us-ascii?Q?muPeKQhzqoYjqyQbe2CWYzwx9AfctdF0nNDoT+hn/mm3AQly7v6xndCLX81b?=
 =?us-ascii?Q?X1y2d3xdkVEhSfYKI/CqFhs0WiqkMUq08Ni/HZkzx8+QwbIJmid/wYHFk+0k?=
 =?us-ascii?Q?O1jpUWmFK9j1J8XUc6gwSbD/ulEN4JxxnmzRq7LWRSGUy6EGV66z6I4xE8IR?=
 =?us-ascii?Q?LJPLOu628jVk+mv/AZsYeyH2DjDy8O9dVxUoZH5Fv09KOTOuPugBFe3P3ROY?=
 =?us-ascii?Q?Lks7KpDEv1kOumP7SB8LUiJobTJfi3eep2N2GcXkxWD6tUZrwjh5NCqH5g8J?=
 =?us-ascii?Q?Sxg14qycDhGt9TpN9U5mreyU4mFBXwMm/hFVvHrDFJiso6zwwiWHmzYl1Nun?=
 =?us-ascii?Q?yRZPA4BZYfLFF8T6m1C5zHt7tbCZ/CVPx6rDGjkDsN5b+bL40m5K1PgPE2Xn?=
 =?us-ascii?Q?OD56KDfaCZ7OVxrBQGGovu2wfRw6gC4xoTA4qA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feeecb97-ed35-46fe-dc5d-08db8cd3cadc
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 05:55:47.6040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYCP282MB0560
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 13:50, qaz6750 lzy wrote:=0D
>On 25/07/2023 04:33, qaz6750 lzy wrote:=0D
>> I2C6 and I2C7 use the same interrupts, which is incorrect.=0D
>> In the downstream kernel, I2C7 has interrupts of 608 instead of 607.=0D
>> =0D
>> Signed-off-by: qaz6750 lzy <qaz6750@outlook.com>=0D
>=0D
>Neither From field nor Signed-off-by have the full name you mentioned=0D
before.=0D
>=0D
>Also: Do not attach (thread) your patchsets to some other threads=0D
>(unrelated or older versions). This buries them deep in the mailbox and=0D
>might interfere with applying entire sets.=0D
=0D
I'm sorry, this is my problem. As this is my first time submitting a patch,=
=0D
I made some mistakes. So, what else do I need to do now? Thank you=0D
=0D
I appreciate all your help,=0D
qaz6750 lzy=
