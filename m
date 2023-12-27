Return-Path: <linux-kernel+bounces-12038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A16481EF37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258FFB21700
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463C044C9C;
	Wed, 27 Dec 2023 13:36:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2082.outbound.protection.outlook.com [40.107.222.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48035446B3;
	Wed, 27 Dec 2023 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGUNGRmPOcTw5Vq4MXA/8J0GLYlBf+70DWljl8pg2pQnukHVoeoZz6mjEr+Kbt/qKI4/H/KYSUIrf/VWwmIB7jUoBemQHcy3q6B+g7klSvB2BNL20lZU0nCrqBhEa3LVjpDCjh1u5zS3iLL/qGwnOXD5l/Li6clEfSM/3f857BiICmHKYOAqDegG2w1R2JPRbdZWomk6U30mCH4VsCx7S2SBBs64jLW5rIxp6VzXISU10xEpyUPbEJaqxnERrO/Y0vLGspEytyigNVydn62SvRw87P2a8nCpDi3K0nnE71hY0TY2EaU/5a4C76fII6G2p8+Bvpk/U0p60fMlNGrLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3cgDzAw48TGeTPr5ou9ig6S3k5bZk1qzBNtZOrIB4c=;
 b=IfvcWgx7C16yJeB6xNb/ndFWIS4wJQ9aAgo4rZIRdvocg+Czzo+fSxPctH32u1WSHn5QavTknN9i7bIflG6sps3CdCBvSLYM1oMNFL/778mIWUbRROqfl8NRnJ4Qj6cZLWBRWEPxYy8PcA3h47fU7aQlbp/MnVHmPY/S6CcdohtzZtCiCv0czyeCqN3PosTe1C4FHP+Z4l4yTdqDo2o1epypqwpQHaE5JY/YeUrYel0UtJHD0C009Ntk/cWBaK1fzvzLFbHdut1qQGXG4RQ60/y9q0FRzqdTfYg7swrTK/hl5GEYHhBMgpvnv5iDt1E+n6OMB6Ma5HH7naMShcq6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by PN3PR01MB9565.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 13:35:54 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 13:35:54 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: lars@metafoo.de,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bhavin.sharma@siliconsignals.io
Subject: [PATCH] media: adv7180: Fix cppcheck warnings and errors
Date: Wed, 27 Dec 2023 19:05:16 +0530
Message-Id: <20231227133516.1356553-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::11) To MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:42::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB6957:EE_|PN3PR01MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1605d0-4143-4a71-353c-08dc06e0bf96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wVDkY2eF1E2dHpoxKlNyzdKYkdO7dUWnfwYYL69q213SVOqrch6yNxgBndPrwA29bTriVz2+KmEq1Dn4j3bEf4WgLJg2BaWI07zRdOiWpILlm252sVt8rE6246SRLT32OKukXoX+tltNdgWUsCrwRK6xzppCl6f9Ou1bhnfrvB1JVN2A4mWPSFTwwwu79fB1kIAndyy3gmjptWBk0VIpmHxzLLq9aQJ0MpB1OJ61embHQGg5eDsdFuJ2tc0uIh1GYPiI1EwwfvgdAb2f68UUhy8550G4QdAbGjtIsAOwQYTYVG4wj16ZA6yUQGOKl7njsidxzgBB5MQ4rwdmdresNr7jMBqKH8WxSo0jx//O0MH+yM1HuQuq5MylRjKNRNnzkbzZu/FpbL2mc5Rgg4S9urE/6gHeXAGZuXhb0ZwfCokWUm8vajtsEIncc4l8jMNKMNlNwTsSEYlxelxprdBjGLZCOYnCDwbnPJ7vFAMC1+9QKgndodmOcMhcLBifmdiS22EXhSpuYFeKiv5XAQxYJReapU4V+wrbVVhcGRk4GlIaf+iVh53SHRGRG387xt2To8fqccvOc9siULE6+9+l8m/xKARsal2gH7VnZc15PDfnX8sZgN/PpQeLjHeDJ2OJDcjL8Kyvy+O3UE0+RiGrku1Yl4dz1yYLtII9NQj5Pr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39830400003)(230173577357003)(230922051799003)(230273577357003)(186009)(451199024)(64100799003)(1800799012)(38350700005)(83380400001)(66556008)(316002)(66476007)(66946007)(6666004)(44832011)(8676002)(8936002)(4326008)(6506007)(6512007)(52116002)(107886003)(1076003)(478600001)(2616005)(38100700002)(26005)(6486002)(41300700001)(5660300002)(2906002)(4744005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3/lrf5MmLXqeDpIDiOFE/+bmJ7XT3NBTG94StFjH4oUb25JFRvHIPvP9GafG?=
 =?us-ascii?Q?88rHCmcjT7tmjxXhRMywPBGxoQxQTxWTxcv7PtS5Qm3qB+4Bw2tKchu8UODj?=
 =?us-ascii?Q?INSZx3dJFYGL44AQtyNRTJofRzf9K0YaV2sU0QPZc5UxdyqfTBl4DLq0TRq8?=
 =?us-ascii?Q?Ays+UPy8hOGmSrYy5YznEBNG8sKwVa4n61GTEb/wE2rxsCkMNy9cHizFeYMT?=
 =?us-ascii?Q?R1s1gpIHhh8qoGzUSnfSTgwbHMYhYeeUBrK0LWa6OzbpZ8N54zeWeNNJ9sn3?=
 =?us-ascii?Q?96tDvGvkgCixNYaN57mjgmLyLUBY/YXko7J9zIv+AqisDV+D+jboz+JPpjjd?=
 =?us-ascii?Q?kjKMIpPufH5nKLrop4BfahauhbIxJuZ9PtWlR3xlZftLGMmJU+p2yhmX37T2?=
 =?us-ascii?Q?/ARCa149m2ovd8XFh2Fu6ao5BXwpm6LNH8vZ2sHqq7KLkgse7srawaYv+TPR?=
 =?us-ascii?Q?RrB2heq4hp4ePCU7oMT0wxwhW9AXpkFAaK9pgFGxZr1VWhL8f54geQUV5v8I?=
 =?us-ascii?Q?F3gwgS9QYe6XkMmjGd00PAN1N5wVbAdZIbbQrE1tSxyiPZGsslCXf+g+SdXD?=
 =?us-ascii?Q?gG7/Yt21yNISPweiv9CeLPgxq/ymP9eH9LtrVNW0YvlK9CpjUZd3LEMl8BpR?=
 =?us-ascii?Q?YsRyvLPAdpWvkpfZL7m1Lm3E621g3NGWETvnwm9Y+2jBWCAwAu2xqwNbFlmw?=
 =?us-ascii?Q?xgmPSsnS+3WF8tQoP4VYExZFm0T2MigNz/jOuMywFqfFCjw0vAHt7+NFmrPw?=
 =?us-ascii?Q?WmPYHs3Xfpjqs+v3q60VOheuPzVpVugkTR4H8n9iom0eT2Le9DwIiHHvCXzm?=
 =?us-ascii?Q?tBfBbDMKiL6oTPa6gZnsSEaHed9Vzm3oz3jbDMlbeeuuqaOHF7/OwSJOkzQk?=
 =?us-ascii?Q?QfELnfdRaFQJXDIOjtAzS7e+WgxwD7VUF6zuQgh0RawFrURAZgCQ9Vq70gg0?=
 =?us-ascii?Q?uT/n8tSs+196GsqODH/NyOAMeC+viWSltWKI0rJfN8DVMSF8JlvxQzkuOoSV?=
 =?us-ascii?Q?DVrv8OhYWMy/3fgHurLpV2i5MFHvgCQDrBgDP3Hwq4p99gcS/34GGm0cvCQS?=
 =?us-ascii?Q?1J8rq8MWu6ndIO6+LEEu8WMpOCDzVu5ss7D/YyhTQWQrW4ZgYZG3YVMvOXDE?=
 =?us-ascii?Q?kfIF8ESnS9ZLGy28aJtpA+dTBKzcXNSDAZTCREkoDmXZ7/0YBSmPQbFpbLrR?=
 =?us-ascii?Q?7gmvU1PtMYfkUHnKUCyMSQlTGerjGL7gzMIY0YWc6JaWpCgpnJbCo1bvlzGi?=
 =?us-ascii?Q?wOUVn3H27EEqSLQ4rH9dbtQ06JpaQ4qkoyRzDu+uXPZ4hAR9dvW3rlNADNhu?=
 =?us-ascii?Q?mqhjZI7VPFLIvfOqU5SPAApJPAGU2a5KeSyAu1XLRDtjxjopV4YDFONzRvgd?=
 =?us-ascii?Q?xoiJyd+1yNn2QVzsAudXXBSaVCCLji+rnEjna+1a4PHgOV2K2fFJKWQIEDoJ?=
 =?us-ascii?Q?gohQdd+tNPsnRHnQKH1W+H8fzchIC7lnLJBUCZJvgyL8QEvocmgMnM40jwvz?=
 =?us-ascii?Q?Xq54/9nSGXGfo7WHR5RQcdJ3/ndTJC5LGYWFLuyk/B7HoxYBR72JkcjY1DPT?=
 =?us-ascii?Q?/O8vBuLn+uEJgFLmns/9NCy3mYgfr/e+hUXPBm0BS2/5y0+UJeyWoLyT89Mt?=
 =?us-ascii?Q?TBac/cJo7i5Qv5s2iRPsw1s=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1605d0-4143-4a71-353c-08dc06e0bf96
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 13:35:54.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cS3DR0b91/zQiHqDj7WG4xx4TdxOK5BxzheKkKo6A55nG8SrFXyDkWRdV5TDpl63NRdRmLfK4Og/42fT8DQ3HDDBzj2Z8dHGNbYyfKVgHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9565

WARNING: Missing a blank line after declarations
ERROR: else should follow close brace '}'

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index 54134473186b..91756116eff7 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -357,6 +357,7 @@ static int adv7180_querystd(struct v4l2_subdev *sd, v4l2_std_id *std)
 {
 	struct adv7180_state *state = to_state(sd);
 	int err = mutex_lock_interruptible(&state->mutex);
+
 	if (err)
 		return err;
 
@@ -411,6 +412,7 @@ static int adv7180_g_input_status(struct v4l2_subdev *sd, u32 *status)
 {
 	struct adv7180_state *state = to_state(sd);
 	int ret = mutex_lock_interruptible(&state->mutex);
+
 	if (ret)
 		return ret;
 
@@ -1046,8 +1048,7 @@ static int adv7182_init(struct adv7180_state *state)
 					      ADV7180_REG_EXTENDED_OUTPUT_CONTROL,
 					      0x17);
 			}
-		}
-		else
+		} else
 			adv7180_write(state,
 				      ADV7180_REG_EXTENDED_OUTPUT_CONTROL,
 				      0x07);
-- 
2.25.1


