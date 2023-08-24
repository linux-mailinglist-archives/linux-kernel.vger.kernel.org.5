Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1712678701A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbjHXNSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240986AbjHXNRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:17:49 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672BD19A;
        Thu, 24 Aug 2023 06:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYP2wyUGrBwZJXkpMw7YDmty+v9h1A4BlPlSTK5UxZke8kxWrA1PEEPJKFNiMp0BxUsUv+6tvgAApqPU5G12YOC2mSY5lSJcpMcyC7acdezmmUNuG2TUZVHSbkjSbXv+7cC/LA8M7UENSWdpCpccOaFzeOwEdmAWyAd4v9IiqJId/z3M2vyKZ2UUJyCFbop5nk3rnUq0siNDVuyDopTHyFo0eARSKf+4+jtVyOkr7ES3fXSSRobw1JOiWkjNmMbMhxif8OabqmfcYHKpW7kEMVVukH0EODxzuNO7tE72mBRbT3XHw2V+Lakz7tn6AclJK12GIyBOug8mnfIdtz4phQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvaQPLJIqMWJwlC2PCK2sv3E8wJsuNpFNY8cL0FMV5I=;
 b=Mv7ypqVHPxOUH6nhwFR9UDtmNHbHEt8NkVjV0jHoFUYg8j2Bzzkm6Taf+UY6AuEJG/wJeGzbKEXlK70A2coLW9uU6MdHz5mtbVChHo+U3MY/Hnpkf5b1FNgUha+eX/GVuT0iKdDOihJfP4fnBTwN8J7cfLsB25ykBH25oBIWZhr3bFNnTG7fOcewchq2uYOo1rsRQ15ZEkDHImxcQf7DrQfv9I/sC1/esHHCXDccvlMAMTWBJAVe+FNQuWG6Pp8ZyXWKSingt/Iattrv4ecEfxcJuf8/6PYmRyzsP6dhj7c4AUU5o9eVOCCSgR4L5R8JLWoLNNA1htvJ6lhq/UqkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvaQPLJIqMWJwlC2PCK2sv3E8wJsuNpFNY8cL0FMV5I=;
 b=ofe+eh3Yk6ebxNHaMUEIXNuu1GGETCQW7n0t9aiWppPu0TQGNfbhzuDiepzkdZ4nsgi36deWD3XrLWOYjnF4TAQrrWR/TvjLplnJkHJ8aVbXdnNhhYY1kFQPP9XBdQHTu8oMDHCnK6WrQXJQ8QIULNzDR3E7qx1SFMWotcIBfLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM6PR08MB4966.eurprd08.prod.outlook.com (2603:10a6:20b:d4::23)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 13:17:44 +0000
Received: from AM6PR08MB4966.eurprd08.prod.outlook.com
 ([fe80::f7b3:4adb:c638:d8c7]) by AM6PR08MB4966.eurprd08.prod.outlook.com
 ([fe80::f7b3:4adb:c638:d8c7%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 13:17:44 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v4 0/4] Input: support overlay objects on touchscreens
Date:   Thu, 24 Aug 2023 15:17:08 +0200
Message-Id: <20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFRY52QC/43PwQ7CIAwG4FcxnMUAY2A8+R7GmBaLw5jNAKLG7
 N1letTDjn+bfm1fLFEMlNhm8WKRSkhh6GvQywVzHfQn4uFYM1NCNaKVgnuCfIvEczqUEPOA58M
 Vsus4KWNbLQDIalbHERJxjNC7bgKKWWkenZxa10g+PD5bd/uau5DyEJ+fI4qcqjP2FckFb4FaW
 kt0yujtfbj47wernjKb5KLmaqpq3qzBoCcLwv/VmrlaUzXUHq13GgHtjzaO4xv9m1FpfAEAAA=
 =
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692883063; l=3037;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=MlTUi0BIGdjoVP2sJiLlJbCpDMz4P3pd3jj1Xqstggs=;
 b=Qylza32mYYYfLg+PbAxFm/mem0+8OJx7Xf4k7WkZ7DQYqlR4p3ulc3PFxI7grA7Yg7YTZuzxb
 Gr+CXCZKMv8CRyTll4EPC+nVVFr50ni86aS6wl47cKOjcSHuVU8srxu
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0301.eurprd07.prod.outlook.com
 (2603:10a6:800:130::29) To AM6PR08MB4966.eurprd08.prod.outlook.com
 (2603:10a6:20b:d4::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4966:EE_|AM7PR08MB5397:EE_
X-MS-Office365-Filtering-Correlation-Id: 93673079-476b-4183-e4a1-08dba4a480a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0tacam1XBkIeSh1uDMdn7DeO3FBtJgT/AJHOjbR4+rDmsPinxaNDDZLNIhXUd3cWzU9UR4NfC3FHJYbsAt7WYb9BOPhpqyV/Lwl9YmdieMelB9uWSL6L1dWOG21ggWCGBWwZa2RH+ZqMHf4pDwaGwVJDOVA7ToFmgAPZDjgiF/4CwkocgltstE5F0ppKHZuM/zpovNIHVTKEKq42HNxxhlnmnLahNTVdezEIFaz9rcW5ThuBK/jabOBNibfSnU4jdq4g02QGzNlVw7PtDrRI4xtGJUCAAfW4gaVqRAg1nqo69J4yQaPvncOk+F9Uh4IIPRckd9/a+RDcVIiV6hM+DGi2HTLNlumzqERgNcMhbW9LoY63O1UMjFLxf2Dl5Lv9bbbxljLpI6uYDS377ObSxIUizwxA4B939deUE1sx8zgOfiaeVQ3AfFpXzj1T0NZ96ffVQ3zrebL91j9u1DMKuzofINu1u/P1RRBNdS6i4Krswg3c+OYkJLqWTocnAiAdevJNv1gGegbZh+Q/cJsK0lty1KiiZJRYaAD31PPtra+Z7jv9bGBaV6JB35C+ezh1DaeYnliYwZ9LjRDCqNqHwTr2TTVz9MBnBtH6sPCNqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4966.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(366004)(376002)(136003)(396003)(451199024)(1800799009)(186009)(2906002)(38350700002)(52116002)(6506007)(6486002)(5660300002)(83380400001)(44832011)(26005)(86362001)(38100700002)(8676002)(107886003)(8936002)(4326008)(2616005)(966005)(66946007)(6512007)(66556008)(316002)(66476007)(110136005)(6636002)(66899024)(478600001)(6666004)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmpDUGZybXZpazZkeVZ2eEgraGYydWZxcUMyQ2o4SjEwRDdkRHVLTStDam9m?=
 =?utf-8?B?Sy9FZDFmSHYyQy94R1cwYVl6ZU9YYVAzdmRpNHlZNC85bDRTengrY09jSjY5?=
 =?utf-8?B?Nk11dFN5ajNSMWY1R1paZGk3MDAzZENwZUZGR2NSYjMyc3MyS3cvbU5PWS9p?=
 =?utf-8?B?SWhtWitSV0pkbEV3RDV2VHBlWWNWbDZyQUFuNlduOVhmOWtaUHlTdW8vNG5S?=
 =?utf-8?B?YVlEV0ZBS2s2bU9kTFhBQWpmU0lrY1NXZytjTXhQZmJIeEdtNXhlWGdHeGps?=
 =?utf-8?B?Zy9wU2V3bGIvZkYxc1hBM0NLSWdpRDdkUy9MUHEyNEQ5RURiZ2plQlBkVk9i?=
 =?utf-8?B?dkJUTmx1WUFZdW1XNkhYeW05SzZoMkJINVRhYkhXdDFoYk54TUtWelN5d1Rx?=
 =?utf-8?B?MGdnOGNMV3E0TU82aVBUdHh0K1JBdkU2YWV5RDhuandhNzBQdklWdTl5ZHVz?=
 =?utf-8?B?T2J0Y1ZQRzZhU004VzdZdEpxWlB5d3JINUw1SkMxU29hL21Dc2RjNmxSYmE5?=
 =?utf-8?B?RVZTdkZIQTYyMGFZK3pCL1BwNG9BU01XeWZMVXEvVnZ6VnB4TGRqQ201VmV2?=
 =?utf-8?B?dVk5L0tEQUV2TE5Eb3RNVDJGekdyVzlTSmVWdGxQOFF0NWZBeXRXWmJsYWdE?=
 =?utf-8?B?cGt1ano5dVZhTjVoWG5ENmZqTk1sR1Q0UVVVN3JHenpsa1ZsaGZoNmFLOFJ0?=
 =?utf-8?B?b0FUT0tVblc5YzRaUFBjcVRaam44ZUFzdXJUdC9zM1AwZzFveVRBeTJKZXdJ?=
 =?utf-8?B?VjFseEVDcW84MFhBNmVITng3bzg5WUJMaE9mRUVqSHErNjNnZzZtdlU5MHdX?=
 =?utf-8?B?a0wwaUJCcGc0WEZDc0tCVENWQVpBQmNLbXU5QmMyYm1lQWIvOTlsUlJGS0xs?=
 =?utf-8?B?eDE5Mlk1aDVTNnhwNnFXSlZQZVAxVkxtZno1U1Y1eDFSU2NMd25kTkRuNWEv?=
 =?utf-8?B?U0p5MUNqclc2dGx3RjlGdmVCUTRPeTluVTV0NWFQUjlaVC9mTm9sUzh5R1VJ?=
 =?utf-8?B?ZXpyNHdVRTAzRlZOYlNUWm03cFpiMzl6MzBZSVAzN0t3NjRlQ1NCeU5hWjI5?=
 =?utf-8?B?RjNCQzRjb21MbmZycjZTR3Q0WlZUZzB1RTZTYnd6cjBybTl3T1dCZ1lDanlq?=
 =?utf-8?B?Z0RjUzBYM3pkQ2x5UnpCRlEyN3lpVTUzUlNlZldrajNuVVg5b2FPRENsdFZr?=
 =?utf-8?B?dHBTODNwSzBQb2FXWnJsdlpzWTNhN0w4VFpkZXlPMFY3Q1BXd2tBMXRJVU80?=
 =?utf-8?B?WGovZVBnaHZIeFVpYnJnek1XVnFzUnlhN1dTYi9uUStOSUNOQmRQTXYyOG5o?=
 =?utf-8?B?YkZKSkdsbnY4NFN1cWFHS21mTlpZNjdlRU5ubnlZbmFJUlEyR2JoNW5INlgx?=
 =?utf-8?B?RVBUR2ZybXhyS2JFeFFHMFdCcUVEa0ZZa3gvcUgxT3hhRVRaVzVweEJVY3B4?=
 =?utf-8?B?UkI0VGxHbWM0TnJGVDkxMkJhWXhJZ3lJekd3Y3BMNUFMMVZCcCsvTVpQS3Z4?=
 =?utf-8?B?cHp6VUtXVDJEb0lWRGdKMUdtZHdmYytSMFpSV0pNd0lIMEtPOVJjalArdVNC?=
 =?utf-8?B?QnFFNXBWOURvQ3JGNGVVa25Hd1RLckRyTVM5bVJYWk1tNlBwdFBXYkxCTU5J?=
 =?utf-8?B?WkxMeU83aEdDSVREL0pUbmx2N3V0TTdDOW1jaG1BVy90RFJETjlEQWloK0g3?=
 =?utf-8?B?d1NCZFFBckEvcnhkbXZVVDBpS0YzQWdBa2hJZS9aVEw2cjFpNzVoY3FETTVv?=
 =?utf-8?B?TFUyWXRsMkV3c1RxY0ZuOXdKeUFFd2xpQTN5L3lCbTE0dFR6TVpLZGxtYjNP?=
 =?utf-8?B?WFBrMkpGcFc0N2k2N1paYUtvaWFBUTY2akJ3eHdYaG9QaFlYZjBjSktWMVZu?=
 =?utf-8?B?Rk0yU2YyLzNabENsd3NodzBsMzlHcVUvM1FjckhUV1EwNHBRaW5OendjWE5h?=
 =?utf-8?B?bS84c2lMZWZpYUQxTDkyUk9RRGVkSlJmenZYc1R3N1Zlc0pBQmpBTmN6d0xZ?=
 =?utf-8?B?SnlHRFVsd29KcE1na3QrUXNrSVNGTFpWbmxqblRHcWhZTUhORzZteTBweWFv?=
 =?utf-8?B?WGJuMElhbllMWXZuWlVxSXVOUldXZjRxNVZHemJOc1kyUW9tcHE1cDh5V3M4?=
 =?utf-8?B?YlhWVmxqQ1RmQ2lvdFI5VzdQUWc1dm1SQi9DVy9sQU91WjF4RWEzNHNlVmRu?=
 =?utf-8?Q?ODhQf2NUdvu2nObM1W0uCpE=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 93673079-476b-4183-e4a1-08dba4a480a5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4966.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:17:44.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNsh3ALTTxNwZnhT9nS8lbSz+Y9bxu86VKhb01r/o2jNHLxHpGKJPjRjQPVTDFDP1bu6BLoM1EbUPHMD3q5cFQ3xo5nq93RWnaNGQQEs4mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some touchscreens are shipped with a physical layer on top of them where
a number of buttons and a resized touchscreen surface might be available.

In order to generate proper key events by overlay buttons and adjust the
touch events to a clipped surface, these patches offer a documented,
device-tree-based solution by means of helper functions.
An implementation for a specific touchscreen driver is also included.

The functions in ts-overlay provide a simple workflow to acquire
physical objects from the device tree, map them into the device driver
structures as overlay objects and generate events according to
the object descriptions.

This feature has been tested with a JT240MHQS-E3 display, which consists
of an st1624 as the base touchscreen and an overlay with two buttons and
a frame that clips its effective surface mounted on it.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Changes in v4:
- General: rename "touchscreen" to "touch" to include other consumers.
- PATCH 1/4: move touch-overlay feature to input core.
- PATCH 1/4, 3/4: set key caps and report key events without consumer's
  intervention.
- PATCH 2/4: add missing 'required' field with the required properties.
- Link to v3: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net

Changes in v3:
- General: rename "virtobj" and "virtual" to "overlay"
- PATCH 1/4: Make feature bool instead of tristate (selected by
  supported touchscreens)
- Link to v2: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net

Changes in v2:
- PATCH 1/4: remove preprocessor directives (the module is selected by
  the drivers that support the feature). Typo in the commit message.
- PATCH 2/4: more detailed documentation. Images and examples were added.
- PATCH 3/4: select ts-virtobj automatically.
- Link to v1: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net

---
Javier Carrasco (4):
      Input: touch-overlay - Add touchscreen overlay object handling
      dt-bindings: touchscreen: add overlay-touchscreen and overlay-buttons properties
      Input: st1232 - add touch overlays handling
      dt-bindings: input: touchscreen: st1232: add example with touch-overlay

 .../input/touchscreen/sitronix,st1232.yaml         |  40 +++
 .../bindings/input/touchscreen/touchscreen.yaml    | 152 ++++++++
 MAINTAINERS                                        |   7 +
 drivers/input/Makefile                             |   2 +-
 drivers/input/touch-overlay.c                      | 399 +++++++++++++++++++++
 drivers/input/touchscreen/st1232.c                 |  70 +++-
 include/linux/input/touch-overlay.h                |  34 ++
 7 files changed, 689 insertions(+), 15 deletions(-)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230510-feature-ts_virtobj_patch-e267540aae74

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

