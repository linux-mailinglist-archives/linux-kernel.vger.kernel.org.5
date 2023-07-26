Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3698C762EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjGZHyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGZHxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:53:39 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2182.outbound.protection.outlook.com [40.92.62.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77EF5243;
        Wed, 26 Jul 2023 00:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCDA9UBc3RGmUCbEagMEj9uJsyT684P9V1Xy7KmkFNISe7+3fljkvoVsOdGwbRaO5bxdWrG3x24B0qFAhqGutPR1RsGY9ZbAZP8kr8oCBPW2HoZOugwM07dVItvSvO9934LesygC+ITiMAte4OqYYll75Xnu6j1VSf3cb9BT6RuB5HSm8cwTiEMLYPJsOrwm6OB2sbCPfYYFLaRhE2oW/KA3dEQ/+7A4RDhbGyBHtoEsFMO+jgD+H48kHpXVlJbiAUF2IpTcxwFfZZfgBJ3CSHt25d3b4VvD9YXgyY5RVbFS0VieuTPssbWyX4KDAg0J/gLdNp252/D/9+V7tAW6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CxyziiI7Bunus/bYH11TDmdJTvdO4rxseT8bUB/ALI=;
 b=S2hzSy1ROqAzZIw68RYZmzSp11DPUlrv+iGxwm7evp66bG21xvF4dwI25ztpINrcl6xHs0WKXVKOFWierIZOP1fivcWF4NCPFx0fdWWk728F+21KsVg0bg2b0JtFsZQT8KQyGBTdQ3r9AhBStf/oZzSPPVSWUfs7xWSiNqrfsDMTfRPnm7YTe8dfsXJQ82FTN/bNStysn52/oy9H9WlgAMdgIszDXscjcPJaM/jKZQwMhuRK6flmQh0P2Kx7BWiujU6nvch+RJxpjNOuqnUJUijPt5dueoRojR3R+vhC3e4SSgKsHUN9l5TDS3P8jTuRPOVDd68+mO8MKejqpQryJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CxyziiI7Bunus/bYH11TDmdJTvdO4rxseT8bUB/ALI=;
 b=r2nVUH1hiqT5mcye0pF/Dz3FUvZIHrETPkn3fSrSQ1vc4xCGEZNraLstSjBWf863BONN+ljJYmaLVMwNyQnlot+bT6QNKCUW8tRIYHjYCUsUtmPmK9ax0SZRG16TDJEzuTCXwBWHwlsi50QoLK4BS2KYmB00d/nzTtdocwU2FoKn758qDx5YFgf//QZHrE97N5aMdy3dx0wZW6d84dFcDUUTP5KXLHrh0WskZ1BaT2dNqq2exdnRnoUaUiLNQWshN+3jkCY4LNHtKk8r816HSaWj3ZeDEvmPCG50ZwL2FBx1VmSLYlvVAQAlak/rs9Yya4WIi0r2ECdeHrbFNrD5Lg==
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::6) by
 SY4P282MB2121.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Wed, 26 Jul 2023 07:47:13 +0000
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9]) by SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::67bc:436f:32c5:3cd9%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 07:47:13 +0000
From:   qaz6750 lzy <qaz6750@outlook.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: add uart13 node
Date:   Wed, 26 Jul 2023 15:46:57 +0800
Message-ID: <SY7P282MB378754EB8809F4E0C150BBAEB200A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <vg4muvoornyxxs6oiepdr5lkkoobujxydixwu6n2mv3lezc3xn@vz675x4jc6t5>
References: <vg4muvoornyxxs6oiepdr5lkkoobujxydixwu6n2mv3lezc3xn@vz675x4jc6t5>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-TMN:  [hFkGGo6L7JxxzFRCEFdNIFXbi0AoaBKz]
X-ClientProxiedBy: TYCP286CA0155.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::13) To SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1e3::6)
X-Microsoft-Original-Message-ID: <20230726074657.855-1-qaz6750@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB3787:EE_|SY4P282MB2121:EE_
X-MS-Office365-Filtering-Correlation-Id: 7030f432-2049-45b8-91dd-08db8dac861b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DgttdGxmvu8z46/z/A19A2Plm79LePt1yIH1U09UKIUsjAbOcEnNGJSRrSCN0084yPW70GGhEBiL5k55AtKshZT6tL7uVOkhL6jAUkdP0P9NCcYVZgpFr4iid/3GiRZsciNiiHlpkqk/hrLDSaDOI1HmcphlqVdkiwQjPTccHIckpWimGuB897BfVz903pZGxEehN3oucOqg175RI/8/Ql/6E4SDQEdo40ONpmuipFtZzwwX2kNXMzogPxqebmVm8PgKe/U8NmCtGnArK6wlkSWOVw18FSlbOqRKYZjyl7hVDmyLugwndNtqAoAnsn0tNkAcc3eStHPyWUpFtaAf3U0uKrquVq2OyL0ZqVlCXutKA1McbNI1rJyjFDab47R3dJD2G87Da0BvZrAZjEnWtOwu9Ntvz7DGYA2Jva40mAaU89TZdzy9J3pOQIfaW86CmMaMNcmXUHMbmReqGdtE3WBtqrVF5WK1xzCo3loZ8TtQ/5fPJp0cUIIK7U2lsVijDMRFc9/ht9tN6zb+MrhHbLBiseNzfqmoflPGFYxFpkDwGf+dGt0ugvIqa4vHNfh
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1L0Yri3IKaZIr+pUQ11JsWc37wg9CGABOrJVGAfeIuH4J2l95M1mpca5WlM4?=
 =?us-ascii?Q?PGiJh3HAislj7DwtmjzIVxc3dcErJ7UsX+OZ86P/aGfxUJYMrHmF+b4yWDCk?=
 =?us-ascii?Q?blOv2RJGyTT9BsRTQWlOvzcJrE6eMf1RghTJPExwWzCaxrNpo6VsSRnKceNw?=
 =?us-ascii?Q?4SNf/qqWSB6ei103t2UhsBP3BSUzLPsFCJRZ3Z/9cmewBovfA2A4AzjU5kLu?=
 =?us-ascii?Q?Lz0UL0nbacu7SrRwPdtHvQA4DWhJgfUqH8HabRF1PmOX08JQv9cOW02pqemo?=
 =?us-ascii?Q?akeapQvCCClqKV8J6oCJInCyrtCm6atTHrcw/zQwi1dZ/O9IHiSNl6zyX7Vz?=
 =?us-ascii?Q?N9YUaPjhG2wPsNz9VPdZAnpJgq1g2MydjxkRfBeBPdk+sqTk7NtohYgv1Ao4?=
 =?us-ascii?Q?trdEuaarfu+1B4PoS1KPOLNJ6Ko+J0evbaIVRkcNuy657PIyCmZtUwDMJA3z?=
 =?us-ascii?Q?s2peKvDkyKa5J/VE9RszTEb0CMdG2qyLOTG2cz20I9d8igdtbrXYIp7XYDvg?=
 =?us-ascii?Q?J3wNB3N1nUTMjFCG6Q9XNny9xsePP8DNrXtFv0MsKBmEI0BYxWuhbtyVdFBK?=
 =?us-ascii?Q?B0crFgzYIa2gcOw7c4gzmCn4NEaFoO6i4/bfBwdeFfJtQLj1/Ixt8AGuUw2k?=
 =?us-ascii?Q?Pmnw4i6Ehp+I8jhnxGVe4h2OeTwQqhQu7lKo/x5xUfxxAkchC0Us4pScKhFA?=
 =?us-ascii?Q?uzGltUEo+39dGZgtySdQgxABoKd0pkTTU5/GPFGNQv9AAxqmvOn+z5dEP4aR?=
 =?us-ascii?Q?rk64K+27KL/x1K85yyMQIQW8sti3nC37fm4L+2kDejmMxUMASAYZkfoGSvlH?=
 =?us-ascii?Q?L5irF6u6apm1yeZnhOzzRPN84883xV/hALZe035DC+LR9ctsEtbGpVgIplRr?=
 =?us-ascii?Q?jLtkznSRLdK81KjxsJDC/NEnfAafYr8wgdCPRxqomGSXjjTGnEH3QYqKgrvm?=
 =?us-ascii?Q?UVAr9ZIkkwjOrJQmN/AxPquQfN9Yow/QmuJLny1mGS7rlotmw5gpsSQH/XNi?=
 =?us-ascii?Q?eS3v9JNQUi21KLqOkFIyYSvtRnhMv4Lhp/2gjNU++QYLyCSlzYfOSjWy/4oE?=
 =?us-ascii?Q?bvJZ3ThlH+FEfWFOipP560ZZpxWGkMX+2bh8RRrariYMe5kJs1yMiGIXo56L?=
 =?us-ascii?Q?KimZ2zaiECM36y0piZiSskW78+NzgssXqdicXblsfGCIxy71BfSptzEaVwB1?=
 =?us-ascii?Q?aK3SbwhtvqWOp/58NGADM9wrgBcgBtZge4cQAQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7030f432-2049-45b8-91dd-08db8dac861b
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 07:47:13.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB2121
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

>>On Tue, Jul 25, 2023 at 03:22:38PM +0800, qaz6750 lzy wrote:=0D
>> Bluetooth on SM8150 requires uart13=0D
>> =0D
>> Signed-off-by: qaz6750 lzy <qaz6750@outlook.com>=0D
>=0D
>Forgive me, but is that your actual name?=0D
>=0D
=0D
Yes sir, I'm sorry=0D
=0D
Thanks, =0D
qaz6750 lzy=20=
