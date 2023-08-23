Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6637785C81
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjHWPuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjHWPuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:50:18 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A89CD1;
        Wed, 23 Aug 2023 08:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM2yuxtiPDWbxhwc+lmUvTjPn0yACk2042DilnS7Snb7ZAvvexZmLUeNTCNT7FbReiRgZeaeBXDf16ZUMSNmjhT7vDiunfRLq/e/nrsWC4PBh5zcSv9lP2aKfdPiA1E8RSJITuPXfdOV0/BdhaQUi+4OOhTLSZALe2hw/aXOn7/Vuv2hiYFrmWQYoyvfYske7HMaiEcSH2mA8jMYbZSmUjPhGTQlKDgLsANDhfRropAM3I/8fWMRzdKgIFSE/0W6K3sjI3r8aclgJj3b5BzRpY3PkXwmUdUKcqvgP59Uh4THvP5jt7ddkt8tUeFsOZVFwKlrlpshT1XkNgUaS5EFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ5cDwfC/tfk5iA4VsGaudDqbOQVewz7i8u3RHw9Yso=;
 b=P+rHWwnRzi2zvc97O5BhJy6/78EE2P4vDB4wGfiaEat5nTBiu9gdlap2017RP8M68U6kwun4crkX53KCdHMk8iREHrUEdZ9+isyWe52qpp9czDZGjUYJD9CTmYTabkkp7L/KOjc9AZL/J98QM6nwaAugS5W4YqIdeNVJycXkVGOoR4gPKMkRey10+PqH1izy3RbyNklM9Q2dXzKQe7lb3lopKPw0YFeZEVDVzl7zajGBcTHHmDZA3HqrjO0rzZ0C4DYrDzQTmAoMni189En334dtVyeOyf3EK/UZd6SCoKl8oRRFXqd4yZkVr+9Y+/7MNoP8h+bWwm8N6MsjBgqFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technexion.com; dmarc=pass action=none
 header.from=technexion.com; dkim=pass header.d=technexion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technexion.onmicrosoft.com; s=selector2-technexion-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ5cDwfC/tfk5iA4VsGaudDqbOQVewz7i8u3RHw9Yso=;
 b=WTxu6FI3UWvy2cXq9j1VBJtxXLMXXppqZ+1t70VSbFk6pOCIiaWu7uOm3EMYv+uADMerYj3R/aT+bILs9YqLtaxwbJPbb4WIN7pHe95yQkSWFgShZ5AKSg0K4vUuY+tK5cVhLSPWd6hpDsIbvsjmllUVfgyyZCrzJoCSZ0Ubm2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=technexion.com;
Received: from PUZPR03MB7015.apcprd03.prod.outlook.com (2603:1096:301:f2::6)
 by KL1PR03MB7502.apcprd03.prod.outlook.com (2603:1096:820:e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Wed, 23 Aug
 2023 15:50:10 +0000
Received: from PUZPR03MB7015.apcprd03.prod.outlook.com
 ([fe80::9cc9:1ce6:df90:532a]) by PUZPR03MB7015.apcprd03.prod.outlook.com
 ([fe80::9cc9:1ce6:df90:532a%4]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 15:50:10 +0000
From:   Jerry Liu <jerry.liu@technexion.com>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Liu <jerry.liu@technexion.com>
Subject: [RFC PATCH] media: uvcvideo: Modified uvc_ctrl_fill_xu_info 'kmalloc' to 'kzalloc'
Date:   Wed, 23 Aug 2023 08:47:23 -0700
Message-Id: <20230823154723.75483-1-jerry.liu@technexion.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::26) To PUZPR03MB7015.apcprd03.prod.outlook.com
 (2603:1096:301:f2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7015:EE_|KL1PR03MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 04450fac-126d-49b7-6d6e-08dba3f0a15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogXQA/eR9BmwOr2Kkr7dGP6Ror7UgUSXtBRe020aNfvx9xLSSfiCxeeCRT8lAi17VVaFi8SOCYbRkOIfKpEbhBLJqnXnW8Mj+bDNqomf+w2uBWMhdgKKgva9qvxKSlJhp88maq2/I4w3Eb1az0wXUQODcjDs7fRtWVi03moR2fZFe/6zLVFU3QRCyB2xDn+/2JzgQZ6rJfnOcvFkMgdsulfaCShaCn0ykNbgKCTY0nxeXfAC6LRaLCrA7uaLu8B6JJ/xLkWwsCobO+tgXh5a+9Btccg81MyJjQybqWAR06DoVHxxVzBhiZBEHWKqyR+shUy3OulseD3eYh/XS2+NZSPhlgFIk9PN9RTeBx1jZ1XPx7AuPKCzGGK6VjrxRY4/rzPAcZ+FhFk1ZuRlUsUeLh+MrxsWDxPkKHYoRakGFhh87Uj1Wynd8xTg4RbH3KCJBjwRno3ORWHI62AyYRYBqHQMitCh6mCa0lqf99fTcqfIrkq4kgIXZLtgteJ5wbolJ4oVYhaX/IsxgLClqxR5I2pgPgRn1MDcgxPkrQCrAprqIHHZeby/XGgaxmsHgm3aOBhhWG+cFu6yJ0lBbqlwerxvnWaOv2bv6Wn1r5X+v/I3uXUavi8MfUnbAYjL73zfsuG0hxJJVvVJX9bC1ZH36JywcB43C2dj4dAojhxzuJftCWjvSeJ4J9B2GrwnYEs8p+j2PPay/9x0+hURGyhvOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7015.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(366004)(346002)(376002)(136003)(451199024)(1800799009)(186009)(6486002)(6666004)(6506007)(6512007)(52116002)(478600001)(83380400001)(107886003)(26005)(1076003)(2906002)(4744005)(316002)(2616005)(66476007)(66556008)(66946007)(41300700001)(5660300002)(44832011)(8936002)(8676002)(36756003)(38350700002)(38100700002)(86362001)(4326008)(12101799020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aUCoOpxyOgi2X+I5grv2J24Ep4wPYXvjPhTdNwEayT6+jMLa4NfeM0EDObNm?=
 =?us-ascii?Q?j15RUQpdVJpdyCigP9YOdcGFDqRd6OPJWSinGkpNMjA+qm6kViEcbjdYbYTM?=
 =?us-ascii?Q?v3Sn2pm4xT+yNRVQkFkxumdcFOOFrBuUIa0sovaDkC00KKE80ab2qOSH5kWz?=
 =?us-ascii?Q?+Ac1rQzKSBdP8YOfnuu49qpvOND2xSDxMwYqm/JNVPX27gi4GWTOuIztv3Tp?=
 =?us-ascii?Q?T00MdsSOWAkoBDAaF6BOosXTKuv9mMjva8aNT4tHL+Qppb2SVCufcuYx0gUL?=
 =?us-ascii?Q?u4vyUSeebbP6A0aRIWlqYmSTgZ/Op2YiQaUl7gctxq3CQ4fJZ6spALo0XV9s?=
 =?us-ascii?Q?rosx9cRomuN5z3GyVvtWL+68EwdTXtiQWj9kIHia4n2N7EVN7JX7I9OdWQTY?=
 =?us-ascii?Q?L59v2Kdzqv/AZtRFqfoV4CD3XaokSJd+nF+PH5Z1kxFYpTGOvNjFlX3rZVP2?=
 =?us-ascii?Q?kpkt0Z8ChksXL+XuoYTEtkF+vOCsCuz7aPV5DU+ZDTznR6z6qsoPq8BWcB1F?=
 =?us-ascii?Q?k/gIzhTqj+hNdo7GadHiY64WCoDuxdD7ANC1Axi9GWWyWwdB6rBDPg+6edBY?=
 =?us-ascii?Q?LsfExClJ4+WUwM2cjfMRzhF+R7S+Q/IOqrwA1SoY2A7rxe5g9FSQrcIHQsUr?=
 =?us-ascii?Q?Vg6IBj4b/E2V0HkupQiySJXuEbeZ66lIznkULC2+rgVRvwyks8CXTtVjin5X?=
 =?us-ascii?Q?XJNpJ0/fwDDxlL1TIYcdineyvOVEYlUAlBxltYYP1v8RykCJ6kK6rvU1PNP+?=
 =?us-ascii?Q?HVHn6EbMASyoMr1Lv22s14x4T2M7ZQjhXwyz0SjLSxg1XxAzR6dMxnxN67WQ?=
 =?us-ascii?Q?Jq5529ZZXTdI5JHiniCcoS5q4M4eLgpgaa9oS2tNru3Z9uD1pPKCwTOc4wu+?=
 =?us-ascii?Q?0vNT+VHPXROD3gHzFyfZdJz/ky8r2Auozz597hjHFRP/fEw4xnEOmXSS5E0j?=
 =?us-ascii?Q?eXc1DsI2hlqbsNydarFMAqVsBgoN72vDh/EQLsQOV02X60UjKiKVHuNeE0zI?=
 =?us-ascii?Q?H5w8KIIOr6HFYJEM2/ZL2XVTrglhJEWZ/kTFSIvDhbdiSkFleOZ+PkMy7IPt?=
 =?us-ascii?Q?zqUSsGMyRbPOZj42SRODDVkUZw+QweyXHe6aCRUFYh4AKj0mpVOsl6ELZUqh?=
 =?us-ascii?Q?qOUMogLvEQ7bksuI9SXkWj84lYP/g2Zs/SfBjePivIFPMC3tADIULOTaN6us?=
 =?us-ascii?Q?UcHC5FfxX3Qj3cPZ2a/RIwz8KK6MHHfZWLNk9GCbGDdDZMjxG/1UDrcwrcwM?=
 =?us-ascii?Q?hBTQqAtMKCBLTFW5YbLwLmJip2J4yfxbhO+ZGEB+7zIl1GfnjfRplWQg9XrJ?=
 =?us-ascii?Q?aUXBnVHWNGqtyuUs7ISNJsLtD740lJD2GCCaItS4VddxjynRP5PzVtFkSTBV?=
 =?us-ascii?Q?A8qRZNWqDM4//NKrFxc+K/RSa3UztfR4w5rNv9RFrv849ks0fma1goIS12BJ?=
 =?us-ascii?Q?SAMBoMeemxw1C9ajq5MjSvaJlR8iyh3FQBb6Ow0HiguIdFO3F4D3nMJyPzRl?=
 =?us-ascii?Q?tPJiBf0+dHmaSGevR33dTngtkcrqeFw1zMfcrU+9Y5pupCjCsrSWg/EU8nkF?=
 =?us-ascii?Q?inZD5nVfQ837vcuFUCGWVXVQ/2DPWUSS4KbrG2sS+mOaQUvUn9/7UUEmStka?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: technexion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04450fac-126d-49b7-6d6e-08dba3f0a15a
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7015.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:50:09.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5ee19679-b9a6-4497-8ed2-1eda849e753b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYOBLUcGVBtYGm2pdrQa/YvEttaEHkFn2VWvLvgh8jUa8n0ogruaDTktYk+V+0/wc1WDDLZ43VNH3m+ZBJrpePcn2g22EVw0UX0vXL7Y9Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7502
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the length of UVC XU Control is 1 (even though this is illegal), due
to the non-zero value of data, UVC_GET_LEN could potentially result in a
length that is not 1. In order to ensure that 2-byte data array is set
to 0, 'kmalloc' is modified to 'kzalloc'.

Signed-off-by: Jerry Liu <jerry.liu@technexion.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 5e9d3da862dd..054bc14f7a58 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2088,7 +2088,7 @@ static int uvc_ctrl_fill_xu_info(struct uvc_device *dev,
 	u8 *data;
 	int ret;
 
-	data = kmalloc(2, GFP_KERNEL);
+	data = kzalloc(2, GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
 
-- 
2.25.1

