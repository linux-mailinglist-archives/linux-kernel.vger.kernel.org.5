Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F9E78235E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjHUGE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjHUGE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:04:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2059.outbound.protection.outlook.com [40.107.255.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07F583
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSZe0OUX5fqC7a7ZVGnqPHtgdGZF9hziNqDtq+7GeqrBVXZFnwyFTZqm/Hm3UrqVoVld6J6tY+ziOI4rKRpbNIifb1iwLAPUoAYwHgj2A5JT4g15exRN9JWvDeEZDJLpXofaLodYQnRHe5n43GvuptreU5VIL7VQqbtCxlRh6ruma/2Ezj/vbqPqyGt++fP/Z05AyaT1RYG9OUpmY0ps0cUHxobjHjz0yfYMZxCm7cBktXfg0hRNPyt03qW6PjwzS2zR6Ddf55I8fklCGr30jWPdowQLB8WsgXdUTZVZE7qaoYIVO6iFmVleMg+768/9m3pnbh8pqo8EtZ61oU6u6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6FHstID0SFm78V95mDIXuGsnsA5MzxhWhrOO+BbV/I=;
 b=MdkkKB4d4A5CnkAbAVuB4Z1SsnXgwIAXdunrYrEhtz9N3Y7MgnUgXJGqhBNylzppKcAYSeDn1nlprBenZHQMwm04huo2ez7pdJeutDvAifEMAsFeS7NuMw9Ry/8TJKn9InrOXKsen5DhmLiAtvflrR5pDcKPyQ+xAwVthc3b4ZbOp0EuY0b7FW+f80rRO63JHqCNF4jpHoGA2ShUnkt9uaoIF6BSSJZzbCMZIYxTUVuQO13+/OEhJ6dczQ+jPEfY73TA4lnoyf7ER8PKW3CfaWUi8QteDNE3eN/7xgFz6M+fQSVps0IV8V5hn4OEeP87gTJpyBFvV4z8lnq+TjP7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6FHstID0SFm78V95mDIXuGsnsA5MzxhWhrOO+BbV/I=;
 b=kJgQP+u2zrqOPbttIhbHFpOZCx+cBTBUz5po/Zym5lJXFlMvJHhE1j33QDgkA12IXgoVaWYRA6lidaBV6uMTVHbiLGUFvfyzmA9C2ACEdS9bMZI7aWZXjgWifHjIqOFfn1Xm/camOvyZD8IW3iIxvh/Dy09QEeKcLi1iYe25kF8i6kch1yGrQt2ol6l+vKPwNQoWJnO6bW5Hp67CJAQhALnQVETVDW3RVnkKGywgKTaxo5j9mVRsgkPPd0PcKp0GGUFwkctOwEAzbMdD7G1DddgQCIoHVP16IdwtqI3Nm4+fyxFmkuOamNktcYqWKwxSr2qrnpBHImOAQOTZgniDyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
 by KL1PR0601MB5752.apcprd06.prod.outlook.com (2603:1096:820:b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 06:04:17 +0000
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::7e18:3180:75d8:5495]) by TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::7e18:3180:75d8:5495%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 06:04:16 +0000
From:   "Shawn.Shao" <shawn.shao@jaguarmicro.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     lege.wang@jaguarmicro.com,
        "Shawn.Shao" <shawn.shao@jaguarmicro.com>
Subject: [PATCH v2] vdpa_sim_blk: Fix the potential leak of mgmt_dev
Date:   Mon, 21 Aug 2023 14:03:33 +0800
Message-Id: <20230821060333.1155-1-shawn.shao@jaguarmicro.com>
X-Mailer: git-send-email 2.37.2.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To TYZPR06MB3933.apcprd06.prod.outlook.com
 (2603:1096:400:29::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB3933:EE_|KL1PR0601MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e928ae-c728-4232-9b7a-08dba20c7336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyUYQxJGjQ2iYLoJJTWhpHXLL4p34Lm12Wh4eFOhuggxwkUVOXAuN3Zkx0BiBBVfjAaAOCg/J5V5imaHhhBJfehNUCiHrZ/o5z5fwOoRq57m3fh4sz2e2hxhy+qA/1pxcqWAdHfrmFoio+Eiq+5B2PMYu57YZOPv1HhPySB+e1Y2HnZlxHAQGfy6euu5djA6KXp4MAxtRGpRCzg3btUwv3U/zYOdg3fBi4yQPXUJ+zv/ru/1WyqLPx7rVU4PTEPS6CQEWK0TJI6//lB22r8+YJp/QdgtZCzPjLdN3pdfBTfwbS56mSJKmbb7QEnN9x3F/dEx9dFbp7695PcH9WGgFkpr6Mc5zrBj6OupFZuh0YfzoGyD37oscrfkZChT1q9xV5L1t4NNVE7zKbg46fGnhDfTj8gHvyZmNefV7jPdnElVSwyspNyMBP4gbgpf+j9V3NROCgTBHooBCOKJ14HcfBo1L05DOTkEBaAmoGHkWk0IhlGIlm2s2NaEV56ief479T/X4jKGe3KXQMMN+Dq8ui/MzJyaGLGZm71NPU3qWZ+yifBggaEFyzr5gP2mQVR4IHX8TeQY0n8K8/EgoZo4l28huEKO5uMlucBulCj6HncmT+r7sIAABhpkrHKgqXtc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB3933.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(2906002)(4744005)(83380400001)(52116002)(38350700002)(38100700002)(6506007)(6486002)(5660300002)(26005)(86362001)(8676002)(8936002)(2616005)(107886003)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(478600001)(6666004)(41300700001)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hIg1wo1tnjanAe7IJdI+WrHA2hHjcZ397/xj3KYgLnVcEKQFej9+J63vy607?=
 =?us-ascii?Q?JdPeDwVePIuQUVveZtrI46k+1WJQdZW1uLW6C6xZ/0fADa6Zn8qnXqTIeYzN?=
 =?us-ascii?Q?IDahsFS5zzzDqw40F5TLnFtuQxEmJ956l/0MqSrIDC/AF3tiHZwqfaWld6Ow?=
 =?us-ascii?Q?4tKdb8UyNiKgl01jMtMZDzsfPh4EZMS6tL6Jy/hdY1R+sMVDLQb+478YTwWE?=
 =?us-ascii?Q?3Mp9tt2SY081fYAbSAs0bGG7o48ub/YIZoXJCZazitk8T8bXKvhYC3fN74Nt?=
 =?us-ascii?Q?eJ0NZmG/uDPgCB6CGbcRCaW7oMzeCJgiRNAS1jH5RqFh9iNMIMBDH0Hpe3oY?=
 =?us-ascii?Q?OLonXZ8FpiFrCnv6hjMRhDgaw0MPQZ7DAo68KksES9+4y1laSjb4q/JqSByl?=
 =?us-ascii?Q?GPXRlNz91zxNAkqF/k3tQX7b6Ucawze2CoZNiuAQCm7VqppLbGiiU0fipaSC?=
 =?us-ascii?Q?QUvYUD7EC1XqLkNGTSmY6iS7ARmv7ykcH/ns9FNRuuiVPTBguHRrq7vVRHrm?=
 =?us-ascii?Q?ZiAExYGEhZoqMGM/VEda7cF/SEKaXVWX7BtM7mabsCjuWIjkQXo2TFhfJTue?=
 =?us-ascii?Q?1qrcJ3vYxylw3XAQ43SXTUhdqwAHMflkqYlsCUvtX/GfG0d7GjGTeX446VmI?=
 =?us-ascii?Q?wvJDOoPi7kGedF7P94qiixsfjA/vX8KPNRf46p9GMZNToEZxMaiTWTwh/NQp?=
 =?us-ascii?Q?LdzhDniox0IBcFWsTPg96f14qI10XkluBocM/os7urCCcHa8YpDUZ3ZCoa3f?=
 =?us-ascii?Q?CKV9HAcvCfjZfK3QKxx6hkyPoVwtTOT4wjouH47FO/tfUcrQuRy9hBkEiX87?=
 =?us-ascii?Q?ePGYGxQ5x08ZEMwzkgJ6f3zgsXd43jHPkuvAtKYApVeKHOi+OmxrsD/EdeZa?=
 =?us-ascii?Q?V02VfFWgN84iSpORCb5u/7PKeqPJksHKfKZphJNO6/kQ/3+iXkG2aTHxpp8F?=
 =?us-ascii?Q?tzomconqv/GCfl+F78QFPyS/6Cvqrr2G7HmDNTi9SNfXDBr/ywYxckt17ogX?=
 =?us-ascii?Q?CjJx2VaTYVqJeL9Ayl6rYcSSpOsfqRtBlgoe6/h8AQlbUhb6tbLxmivGPHQC?=
 =?us-ascii?Q?HzEbbVJR2zVhOOQ8I5Fq7P1qq2edkj+mQYbJXZkM6nr6jOThc0yediJmNIOc?=
 =?us-ascii?Q?+DGOd61AdiiGLCjFxafzjpa7j4McCo3n/PlmUZYF5ejOETfZcIS7ZevbL8Eu?=
 =?us-ascii?Q?eyrDlmMQh3eOSZ1auEtg2vgYYf/dyPIwH7FenOQmSiN3ghOI3n/QWAEcBwJW?=
 =?us-ascii?Q?UcxCVFCER85P3qTs8qD9ScHIlim/F6d2BFZrAmmNbGQm3hEREf5zGgQfsxbQ?=
 =?us-ascii?Q?ntlSEJNIYj0oZuQgM/hBu6DoWp4RI4ZmVxS8TXPQn+2F4AbeV2Z4i8Z+ulbV?=
 =?us-ascii?Q?yfIYVWZ/k1FzSek2gGH0sTeW4lzYGfXXzkKz8GpMV6OGfkP5STBF9iZRbmGP?=
 =?us-ascii?Q?EOOC/skgGZUM3HZhKnOVmtZL2+thWDAqRHEnNnkDJq/rcTcL4S5nvwExpbe/?=
 =?us-ascii?Q?3kN5MO4l1dXM2mhp0sY/KDjsr0Dlq2d/mwjhaMDysjAqFn5C/4/HlgeacmaN?=
 =?us-ascii?Q?Q3UsUiLf4WbLJSOPHsATp1W/ElWrh17FKJnAxJ3y7VSoi2mdOzQR3bZNTyga?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e928ae-c728-4232-9b7a-08dba20c7336
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB3933.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 06:04:16.2013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8mesIE/eMV1ur0CCDeKWAfxsFXxEHmyhapLxGPlN6lMvuRSpJ/tYykSFT82AYLIs7d5ejVpFy1e2/NvQuWIWK5yuYV0vo/u8bQC4ZeH7uU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5752
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the shared_buffer allocation fails, need to unregister mgmt_dev first.

Fixes: abebb16254b36 ("vdpa_sim_blk: support shared backend")
Signed-off-by: Shawn.Shao <shawn.shao@jaguarmicro.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 00d7d72713be..b3a3cb165795 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -499,12 +499,13 @@ static int __init vdpasim_blk_init(void)
 					 GFP_KERNEL);
 		if (!shared_buffer) {
 			ret = -ENOMEM;
-			goto parent_err;
+			goto mgmt_dev_err;
 		}
 	}
 
 	return 0;
-
+mgmt_dev_err:
+	vdpa_mgmtdev_unregister(&mgmt_dev);
 parent_err:
 	device_unregister(&vdpasim_blk_mgmtdev);
 	return ret;
-- 
2.34.1

