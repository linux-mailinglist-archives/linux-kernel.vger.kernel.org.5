Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB19F7728A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjHGPGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjHGPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:06:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBDA1701;
        Mon,  7 Aug 2023 08:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy6NHgGMLQRyzVl125bxezpjl5OSwWVFl2G5C/8HICLvHaIQCDIPqtbPitUC19nSy9kxM3HbtfKYMSX1qG/LpjGSytwy+MgiaaiKoPA0FEvgeVp8yWzngTtloDloNfJ45HpqAKunfr+GGQSHkYlBnKPBJPw7eFRffZOIAefuW6po7GxeXMSuju+nawaocLMkIn11Q6RtPs2iPcOXnj+uD7OEElSAa7sG7BHKeqE/fAk2ipOMORUmJm9mJuDqL4GsJa6UASnddiw3Ym73N7fxYTfyNApbOOpphPUnpBsYJNe6l5/dtPENqxm/qvDvIbqtE99wH9m/1I5AUYnkKXuwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPRftwa/5INHUuf/U0IO6DYv07+MkuBCaxGoh+MZ00E=;
 b=I2ySPq75AtXbW2qYUG4G7sozx70ZIEvq2wtfCCqe55RkuHNvl6V+m3zx9B7bpsvsUieE9qi+zftXWDcDsAyqEGyGt8offvjighRiIQx/lBzZc03+7C4GKdXQUepkfb2cDkEPzLl25hWSGivQlNYgh8ECwSKUzMqARhzSLLouK53XViG4G/7FSwvc74gvYIrIbhbVXte1fSod+yTpChm1X+lbRTThdu+jpnhmuSy4jmWKiJhU/YAviQSZMLEiWQLs7NDZTDmukTO6PAR/ZZpB0XzH552yofZge6nXQ1rce7Ol2PZlt7ZG46IFX3xWPGtVsvf6bArQR3tzAOz8HsPoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPRftwa/5INHUuf/U0IO6DYv07+MkuBCaxGoh+MZ00E=;
 b=alK9AcXWM4JWfOVcWoGfsxba6SA6KaHSgO0ESeAyzk9IA8G4zPNvkeIH5DsMfqZiLvEY8LeqB+SxTBvFXss0uLG9Wxgqdn553kequ490iap6+8sq/bnbC6ojoOJgSBqYLoox9aNg058+4xL4WxXoOiFfk6pcsQNdm7YQ5e564zU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 15:06:11 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:06:11 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 9/9] wifi: wfx: fix possible lock-up between scan and Rx filters
Date:   Mon,  7 Aug 2023 17:05:42 +0200
Message-Id: <20230807150542.247801-10-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807150542.247801-1-jerome.pouiller@silabs.com>
References: <20230807150542.247801-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR0P264CA0252.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::24)
 To IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SN7PR11MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c679e4-8df1-4146-9af0-08db9757d62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYE8zqrqxp3sscWQ2ZMasbkAXC4XLpfDl01/lCigHW7nElyq3H1x2PmTiGnoHNAzIwSZ7wGmXOj7Ld3mS2DloGLg9s3Im/ykWNWIVGyKrhV3LIkrwGLMvNgtRC92Rg8iq4k8NB4cEc/XzsFzkvybz/4yapzOdI0DgnyX9koiAAtBPq8YbkGAa7L0YmM21PAFmawfBvOx+Wm/KQEsE8QV9F/COcIlruoeVDXMnok3OCE7Uj5YYeElokOxYnuc5JoYrsWB6q9M+ZVfkV8p1r/MuCGBgRw5zA3k1WM9sjd+KqTdz0LZH1JB2tRYFA5cPTg9hWazwbakP+Z6mw6iooXGmIul4JhzjkkzZFJS1CZwCBykfrqswb0DNr72Utv+uSmHVmzpCaM/UjXEYYFTiaS/yA+FrT409UaJiPU75mhnDNVGGoFWOMkQjgzYIxlrG9K+f6hB5/OEZl4lwjHV07RXACVV78JNGdpdfcL1BCxs+rtPAaPUToFJOpGp8zirreH5VcRSKE/pXxx7cXdxENQMpP+0AXMVEcm38zrSUHfIz1KA6ECQvI+pZ3303mMreKrnUnE7IuEoMisIXQrBvXOAL8dDZw+WhmGWg19bnfPeKjr1dhMXfPW+IjrbyJU3GYi7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(376002)(346002)(396003)(366004)(451199021)(1800799003)(186006)(2906002)(4326008)(6916009)(66556008)(66476007)(66946007)(6486002)(52116002)(6666004)(66574015)(83380400001)(5660300002)(41300700001)(8936002)(316002)(8676002)(38350700002)(38100700002)(2616005)(478600001)(36756003)(107886003)(26005)(6506007)(1076003)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDR6Rm9hSDRzR2dsV0orcEtsRE81Y2RFRUhpeGc5VEUxTVYrcWpOM1A4UFBl?=
 =?utf-8?B?Z21DdWNCa09WQTZ4ZC9LcDJBSTJjekkyQ1Nodm9DRVVqWnZyYWpnWVF3dTlF?=
 =?utf-8?B?ZDgxU0hpQVh2OGZHTEpkNlloWjdYWEEra1ljOTIzUU14TEx2MXVnelNvNGdk?=
 =?utf-8?B?cGppZVRZVnFqaTdybm1yY2lyQXZoOFhEbEcvSFhGQkxOM1JKME5FQVpqb3dR?=
 =?utf-8?B?eDFkUTJYeVdQbzlnbEhtVklsMFhYK0J4NEZTR3MxZ3JPSVB1UWRkUEdNbENm?=
 =?utf-8?B?QW5Gd0tMSlJkeENqY1FFVGdWcmNEY0pBTXBtM05FZFVIVDEwWkRMK3ArRkZW?=
 =?utf-8?B?ekZUcHk4eGJuczJrTWlYNnhtTmsybGUxOTBjMnl6WXl5cytoTVhoL1FlSm9i?=
 =?utf-8?B?Mk56eHpFSm9xWXVUWVRLWkdORXpPR3hJWXUwdkpvTTNURVV0bHdzZzVmb3pC?=
 =?utf-8?B?Tnkyb1RFYmxyRUVTNCs1Z2MvVStsV1BwNXhEcFlVSytIblpOaDRsazVmTlBu?=
 =?utf-8?B?TUNhenRtMm9mdis0bUw3YWZEMTZ3eWpwZnV4b21mVXdIaUNmU3h3MjZOdEUr?=
 =?utf-8?B?Y3F6THg0b0k1cndCTTR3M1dBb1pmUUEzWmhaeHpieVdLZXM5ZG1YM1VHRnl5?=
 =?utf-8?B?U1JTK2pDalJUR2x1aXpnWmFlQ1lCSHNLRnlwMEtSSVBHdWJpZFpYY1dod2h6?=
 =?utf-8?B?dnh1Ulh1OTVMRDZFNEh2UHViTW9KSzFqL2tOVDVVRWVsbHVLTURnelJVTUlt?=
 =?utf-8?B?ek1sMG13ZjNmY3pTMjRzYU1ScmthVUQ0NEJ0a2t2S1lRaEJYdEFMUnh2a2ow?=
 =?utf-8?B?MlYwTFVoNndJanBzN2tUWVV1WFNHOFdITjluQy83UXhjS1ZkOTJabW1SdU1x?=
 =?utf-8?B?ZzZ3dVg3QkxpSXVlZFR6KzE2dUFESG1FT2FYY2FPK3p2Rm50QzNTUEl1NzVt?=
 =?utf-8?B?ZmJ4SHJHYnZZbTN3eVB2V2JhVmRGT1NKUWhCdlZYaWhjd2ptekl2N1AvSGhk?=
 =?utf-8?B?d1g3aEJKaXp5Z1hSRVJzSjQ1WjlsQ1p4c2thV0JrYmZ2ZUxWSTFQRVRhYVRv?=
 =?utf-8?B?NE1Ba2ZJWFhoT0N4MFJlVXpKVDNDVm9ORHdxWW5XSzJPVDB5Qk9ySTVYeXdj?=
 =?utf-8?B?azdLVmR4RUt2UkdVZmRDL0sxRTdIUU5kZmNMSDNLQjNMNko0dVJ1OUtmODhl?=
 =?utf-8?B?UGMzK3hYRTlJRnNBck9INExoUklDVW5mQnc0dUNjZDFrUWF5ekhuOUtTUnhh?=
 =?utf-8?B?MWdUdVV0bkF2SEJCRTlQL2JwVHFrR1FwWGlZV2xjZnVoZlVXdld4ajVuQ2ZH?=
 =?utf-8?B?VnF4ekRZMzdPR3dTdk5pN0s2UVd6ZjkzR00wYW9IRlNtSjhvZEJZYnVZSWVt?=
 =?utf-8?B?Sld3bEhBcjZrOEVkeG93MjBkS3VVQStLeVgxK2lSRFNiRFVWbjkybFNPT0pv?=
 =?utf-8?B?WFFKdHJ1eUtqVk1iMWF2UnMwb1dWKzQ2Ykw3aS9tUkJoVlE4WXh3NkFwUHZh?=
 =?utf-8?B?K21IU3pnY2FrK0ZNNkRrL24xcGkrV1JuWnVtNGJqdEV0TkRhcHl1OFR1d1Vl?=
 =?utf-8?B?TEFVdWVjb0NsUEEwOWZyOHVvKzFBN0RQUVRXUU5FOTd6NGZYbnI4QktaMWRm?=
 =?utf-8?B?MzhqQnFNQ1UwRnp5YnhxWUZsQnJjTVEyb0RhbEdkejVxTmNkQ25JOEIyMmRZ?=
 =?utf-8?B?V1BWU0NEQTIvZnZlcUZxd2VhMS84T0FLUHdkUlFrdElCY09NNklTNWFldVZk?=
 =?utf-8?B?bGZJNEN4WXNtdjZ2ZllMTVpLenhNeDN5Q3pseVFadFRtWFlpVVdZMGpjcGRt?=
 =?utf-8?B?OEhUR2Ird3FsRFdkSGFsSTUwcktPMzdIQnl2SHV4OGd5eXJHMERyd1FlalFT?=
 =?utf-8?B?a1ZMRVpWNDVBN1Q3MndGUVQ5TWFHSWt4dXpTY1pqWHNrODNwd3ZDRXpwWnJp?=
 =?utf-8?B?WkxMUnpkck9aQkFkV1hZTTkzMzZJLys4VG1sSnovbFArYXVHSVJQa1k5Wm84?=
 =?utf-8?B?QUJud1cxeGdYSkMvUG5pOTlWazJjV1IvOVFxeDFrRVdWYVZoNm1IMWhvTkZS?=
 =?utf-8?B?d20rSFpieFZ3Z25vZWNvUmo3bit6K0JMUHNRRStCRkpaYnVvWlk5ZUpqdDZF?=
 =?utf-8?Q?CV/BKUpzm9mwxk4baUU5BjC5j?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c679e4-8df1-4146-9af0-08db9757d62b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:06:11.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8q+QPp6zj6S25Ii+K42rh19ALr1HObFvvzYY7Hs1TqGhom/omlrp7ncLBGpqYnfNHXqAcsTW/pz4jpAR1Tf+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7590
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGRldmljZSBpZ25vcmUgdGhlIHJ4IGZpbHRlcnMgZHVyaW5nIHRoZSBzY2FuIG9wZXJhdGlv
bi4Kd2Z4X2NvbmZpZ3VyZV9maWx0ZXIoKSBhY3F1aXJlcyBzY2FuX2xvY2sgdG8gcmVmbGVjdCB0
aGlzIHJlc3RyaWN0aW9uLgpIb3dldmVyLCBpdCBpcyBub3QgcmVhbGx5IG5lY2Vzc2FyeSBzaW5j
ZSBtYWM4MDIxMSBkb24ndCB0cnkgdG8KY29uZmlndXJlIFJ4IGZpbHRlcnMgZHVyaW5nIHNjYW4u
CgpIb3dldmVyLCB0aGUgdGhpbmdzIGFyZSBjaGFuZ2luZy4gVGhlIHNjYW4gb3BlcmF0aW9uIGlz
IGFsc28gdXNlZCB0bwppbXBsZW1lbnQgcmVtYWluLW9uLWNoYW5uZWwuIEluIHRoaXMgY2FzZSwg
d2Z4X2NvbmZpZ3VyZV9maWx0ZXIoKSBjYW4gYmUKY2FsbGVkIGR1cmluZyB0aGUgc2Nhbi4gQ3Vy
cmVudGx5LCB0aGlzIHNjZW5hcmlvIGdlbmVyYXRlIGEgZGVsYXkgdGhhdAplbmQgd2l0aCBhIHRp
bWVvdXQgaW4gdGhlIHVwcGVyIGxheWVycy4gRm9yIHRoZSBmaW5hbCB1c2VyLCBzb21lCnNjZW5h
cmlvIG9mIHRoZSBFYXN5Q29ubmVjdCBzcGVjaWZpY2F0aW9uIGVuZCB3aXRoIGEgZmFpbHVyZS4K
ClNvLCBhdm9pZCBhY3F1aXJpbmcgdGhlIHNjYW5fbG9jayBhbmQganVzdCByZXR1cm4uCgpTaWdu
ZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+
Ci0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYyB8IDYgKysrKy0tCiAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jCmluZGV4IDQ5NmI5M2RlM2VlNTguLjFiNmMxNTg0NTdi
NDIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYwpAQCAtOTYsOCArOTYsMTEg
QEAgdm9pZCB3ZnhfY29uZmlndXJlX2ZpbHRlcihzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgdW5z
aWduZWQgaW50IGNoYW5nZWRfZmxhZ3MsCiAJKnRvdGFsX2ZsYWdzICY9IEZJRl9CQ05fUFJCUkVT
UF9QUk9NSVNDIHwgRklGX0FMTE1VTFRJIHwgRklGX09USEVSX0JTUyB8CiAJCQlGSUZfUFJPQkVf
UkVRIHwgRklGX1BTUE9MTDsKIAorCS8qIEZpbHRlcnMgYXJlIGlnbm9yZWQgZHVyaW5nIHRoZSBz
Y2FuLiBObyBmcmFtZXMgYXJlIGZpbHRlcmVkLiAqLworCWlmIChtdXRleF9pc19sb2NrZWQoJndk
ZXYtPnNjYW5fbG9jaykpCisJCXJldHVybjsKKwogCW11dGV4X2xvY2soJndkZXYtPmNvbmZfbXV0
ZXgpOwotCW11dGV4X2xvY2soJndkZXYtPnNjYW5fbG9jayk7CiAJd2hpbGUgKCh3dmlmID0gd3Zp
Zl9pdGVyYXRlKHdkZXYsIHd2aWYpKSAhPSBOVUxMKSB7CiAJCS8qIE5vdGU6IEZJRl9CQ05fUFJC
UkVTUF9QUk9NSVNDIGNvdmVycyBwcm9iZSByZXNwb25zZSBhbmQKIAkJICogYmVhY29ucyBmcm9t
IG90aGVyIEJTUwpAQCAtMTI2LDcgKzEyOSw2IEBAIHZvaWQgd2Z4X2NvbmZpZ3VyZV9maWx0ZXIo
c3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHVuc2lnbmVkIGludCBjaGFuZ2VkX2ZsYWdzLAogCQkJ
ZmlsdGVyX3ByYnJlcSA9IHRydWU7CiAJCXdmeF9oaWZfc2V0X3J4X2ZpbHRlcih3dmlmLCBmaWx0
ZXJfYnNzaWQsIGZpbHRlcl9wcmJyZXEpOwogCX0KLQltdXRleF91bmxvY2soJndkZXYtPnNjYW5f
bG9jayk7CiAJbXV0ZXhfdW5sb2NrKCZ3ZGV2LT5jb25mX211dGV4KTsKIH0KIAotLSAKMi4zOS4y
Cgo=
