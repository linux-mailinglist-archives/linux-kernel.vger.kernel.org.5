Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82AA7A2362
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjIOQQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjIOQPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:15:47 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A32A1;
        Fri, 15 Sep 2023 09:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYwBkGa48aeaTkRngGvKH/jgJSusCZqL0x094NU+EupLEsXvRLD0mMk+bdw+sJzYP6NXwkfJAnIdjkF2A4lUAV8aRtJB0fUsMC96OMQtVG22wsPDQvLm1xWA/w40l5Hz2XHOH5GaecuBIR7b/jKmxzVKlOnI089S52gxwEVJZ2sjCXQ+sNUryRfuLmi9EyyhDdtKbYF3SmU957KpzFf9DMSN6hi3wyqFZA3inwyl+5mioUZkC+1VxCtGFBLtqmF0ixdgUHbD2d2z4jvGlTf3ktq6f1MsAP/IPkYyoF6gEtUZ96dvT37si1dwbJ/px/MTpdM1vzyxxQCQuFcfeeDSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+P6xMlkfzC4dCpN728uZhxXhgyhaYzHn7LpQY+EpK0g=;
 b=iq6GkyFYNN3O9kJHNGyc33w27HPBndN5FdqYU3mnjTeG1VViV95ZKKo4hCJrqDSxx7TTRdZpRe+ebMagbPtWa1p3gHcf/hwywWZwqGQrgAp4n4EA1DVmonuiZQ5GPWkBENhhILnK6iT7/MArT/B8CziZkhI2V2aa8omcxyR8710HUE5AZYxebX3EF0B/dAhmBfZ0NZ0DIM3I/Gi06lkT3Y7vZZUJWjJ3msTbGsUGu0tdyN4dXXEXJEnZSnKzbn4yFMd5PKTMOtAQ4tBgAYTEDPmoYKuDg4ZUnQ71lBUaPrE3moqzcfhGiliI+EBrgEi+TKSS8wMIfThyQdm7SFwJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technexion.com; dmarc=pass action=none
 header.from=technexion.com; dkim=pass header.d=technexion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technexion.onmicrosoft.com; s=selector2-technexion-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P6xMlkfzC4dCpN728uZhxXhgyhaYzHn7LpQY+EpK0g=;
 b=EOntBiJKsZz3RlpEdnWHqNpd8VDYhidw7SX0WxlYSsqsuuInSelqSp1BvNzeTfc/V2j7CVflcg3qTPodylHAg3uOnG2RohaL/MYjo6LUe/j+ehZsnbkw6NwAPDVCSPiu8no8H+Ar0WASah7VrAeSpawhr0OwkOdlpxNO7ZDODj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=technexion.com;
Received: from PUZPR03MB7015.apcprd03.prod.outlook.com (2603:1096:301:f2::6)
 by PSAPR03MB5783.apcprd03.prod.outlook.com (2603:1096:301:8b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Fri, 15 Sep
 2023 16:15:29 +0000
Received: from PUZPR03MB7015.apcprd03.prod.outlook.com
 ([fe80::f4df:54b4:c6a5:ef1d]) by PUZPR03MB7015.apcprd03.prod.outlook.com
 ([fe80::f4df:54b4:c6a5:ef1d%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 16:15:29 +0000
From:   Jerry Liu <jerry.liu@technexion.com>
To:     laurent.pinchart@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerry Liu <jerry.liu@technexion.com>
Subject: [PATCH] media: uvcvideo: Modified uvc_ctrl_fill_xu_info 'kmalloc' to 'kzalloc'
Date:   Fri, 15 Sep 2023 09:12:14 -0700
Message-Id: <20230915161213.42503-1-jerry.liu@technexion.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To PUZPR03MB7015.apcprd03.prod.outlook.com
 (2603:1096:301:f2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7015:EE_|PSAPR03MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: e85466dc-e442-4196-c0ab-08dbb606fa4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Kohvsao/FmMhskcr+XANTWwkie4pfZs15E0H5r46uFTZG1k0AG0PL+yrStTXnV3O6sE/WfH7y0xsih/l8iIIsXCzMlQYb0Ch4ILmeT3gXzob/abtvTpqzqjBBdAwiAQSEnfzGfwcoN8KCFdAa4D0gv3zWQWWkariyjd/1zlXuOtaae59REzWKpLIIJyyKTW71RzqWARW25YuFcE+kfOxu/Dp7FgAmk/alDUjBrSMztgyLBu21wqCI+DWNGJ0OpJtJYyfK5ng4xn/sfvUakTsM459/LDHWekFJM4MjIWDg6+eI9qW1CySHgttj3sbKKgFgfveshJpMYFoEcGqfL8JKlHj3UVJzEkWqOjbGNaG50z+Srva9vbBVsdCeTKobQIGQI8C2eyAe4l18niOXNoIEFJD0xm6clYhka8vbhS7vmLZvPbY7M84+g7TBqll/yegYLiyNHgOC4mAZz2vi3e/i1vQNI9RAjwG6mPRn9WawmJh+SxrZYuOaY8A0jwfXJNOBPGk+b2Ylj1hCszAMtEQeQHaGyd0aBvkuZrv80vkHFOFCGFljkbD9I+kyKyRUdpdgZgx00pOI51s4lXz8p4kxJ8WdhGb5EJtTjdrUhP1XKBtRoZE+zxkqm8ZXnAEi5AwAsn4xhLOyQlWAXUcyjneRtmxv21NmY42ZIXJ5pHYjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7015.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39830400003)(376002)(346002)(136003)(186009)(1800799009)(451199024)(2906002)(86362001)(52116002)(6512007)(107886003)(2616005)(26005)(1076003)(478600001)(36756003)(6666004)(6506007)(6486002)(38100700002)(38350700002)(83380400001)(8676002)(4326008)(8936002)(41300700001)(66476007)(66556008)(66946007)(4744005)(5660300002)(44832011)(6916009)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PhYJOIxzVFuZ8IQ2KRLA6mZHOt8Xx/VwfAZyEwumt6hivDVnF41779Y/jGpP?=
 =?us-ascii?Q?cIeUVNE1B6QU6uD4MiNR7aKyc/GE/Klz/EITmbkUIYfPBMwDQKtc4dTcE30h?=
 =?us-ascii?Q?m7jU+L14cEdJ0PgNFpRJs/CprZHRWvZIj9t7izJXgbVkpAU+gtWslmjlgvFB?=
 =?us-ascii?Q?o5FCsEZoJEg2FAPwBHDsSdkfVRggLbzc3dDvmRG9LXheaGU3aghjj+pt/QGc?=
 =?us-ascii?Q?xIAsF3yp9sQVjOEGYlifwZbc/rHK47+nqAatY03pHKyYXgGSdDi0Ga+DNNof?=
 =?us-ascii?Q?0NgAeewLvMEuaHFcWXanxerJvA9ydH8/1F5u6IhMiR54HjcXa4scInteLoao?=
 =?us-ascii?Q?Oq3dPGNXo225+WGF5VLE8yXZgL1ZmuarhTk5mRp/xctllKGLuApf4WqA1909?=
 =?us-ascii?Q?ZgL/mU1GMH37DiLTloBnWYJ+7RR/0VczW0yIbPQi12B8xA2M20LQyRzpoyYE?=
 =?us-ascii?Q?ZAMntxlipPBD/zp44iNNEC+MW5sGfXsOFirZvgdNXAsdnJFaTLs4k/gVfWD6?=
 =?us-ascii?Q?hjBxvWR12UmDaKZwMdU/r82ZEOQd3p/2RRbDVOLjX4S4V9aeMDTOUqUOH+7W?=
 =?us-ascii?Q?NnoZcuHk/pm9PPkP/iF/6KmbbZafFCeZCu9z+ozGywBCad7z4B2XX/T7rktU?=
 =?us-ascii?Q?T1FRGoa5wGGz8xOwVf5TrDq1jFxyNP95kq/M9bw6f580Pi+Tgc7wSaVNXMca?=
 =?us-ascii?Q?8td1/rT20MV8KbYG0CfXhnlRMny9kyDeB+1n5hctAxvroQYtw6TRrAfM84lD?=
 =?us-ascii?Q?sxJn2FqNrB32B+7QOebRA6/1gsur3pfwUV97XRX6RBq38j3krHp5T1eYXZE1?=
 =?us-ascii?Q?zirXU4R7KORnfdrwb4/pgBmy6dZ9mljsjwFPFwDD3xrja6SBh2W50gOQ+qfg?=
 =?us-ascii?Q?xX5wywtZ79WMa37HalWUWgmDGOr+4wloJpl21gxZFvCpce+NZmnzmaXE7cTz?=
 =?us-ascii?Q?N/urSnlAJ77dlsHYwUo4bYmrgFMsQHfcV5pJGYIRzt61gFg7adOgf35gvTHK?=
 =?us-ascii?Q?/yzUcTsXu+ocfvTvx6zofFn8Hdkuy7vVpzK+N+gOygvam0+AsOOGilz9se/6?=
 =?us-ascii?Q?mrDBaVz0iS5UxCipN2CdGF5CcQTMWMlgrY8KMq4/ea7QfhC88IOVGmCoSDjz?=
 =?us-ascii?Q?VUR6YPcX/qE9yX5oZ/wlj3Cd/Vpk7YxQnSB/RWJa/uJkkFi9cdmk+CEDfMzB?=
 =?us-ascii?Q?6xXV+6vh4WkLNMV2OCkKAOaT/9M5Pqmx+6uj4BHpLvwDSx9OY/tRuaFs/FnW?=
 =?us-ascii?Q?SPvpglX29Nm02MkxhGrhOsfYlFNh1nCICz7GUzjf37yuqWYw9sDTIMDZcNUC?=
 =?us-ascii?Q?3vLgAqJk91CJP4OusHnzrU8Vm2U7qmDt5aFJPwNLEIqHD1BZwygUUU+Uy1l1?=
 =?us-ascii?Q?O53TwnYGtQV5vy8TCpaglhk+AZr5cHCFff5zPyaFcvTZXSsr7no2FiL6dbUw?=
 =?us-ascii?Q?gQ36CoDQItmJ3n5rVuXLxLegQkKSrDFjR63mBed60XM5CxWbkQUcfryoNh3D?=
 =?us-ascii?Q?yRCaPLg4wXxSmW1xIDBE73J3xUv/xl6h8aMuXuyQuqPScxpSpgygpzU4jHxr?=
 =?us-ascii?Q?Vg937l+gTm2y6wSbxsV36B3iwB0PJ/SjXAln0kojtJBf0q8oYHPTS2S104+s?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: technexion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85466dc-e442-4196-c0ab-08dbb606fa4e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7015.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 16:15:29.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5ee19679-b9a6-4497-8ed2-1eda849e753b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZjguxTt61/Y0qjiNCQXRiXXcKYzKInE0OSCD6458NgCNDNBh8ZuCUeE8TWhQGGZAN3/e6orV0YLkeWR3dK2oteIAkfvwBmgRYW1gEx4L2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5783
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the request length of UVC XU is 1 (even though this is illegal), due
to 'data' may be the non-zero value, UVC_GET_LEN could potentially result
in a length that is not 1 because of the high byte is not zero. In order
to ensure that 2-byte data array is set to 0, 'kmalloc' is modified to 'kzalloc'.

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

