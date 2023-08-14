Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B373F77B51D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbjHNJHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjHNJGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:06:54 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7871210B;
        Mon, 14 Aug 2023 02:06:53 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37E7U22U003219;
        Mon, 14 Aug 2023 09:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=kT8M9oVeH86xBACMU6
        u/VKD2mZUdwjSkmY8P4JLKR4s=; b=bxxDpJkOgJksx4HTa3nU9g5eDpV9Qv8hMB
        sKsv+budr1auFTK6TxJDq+TYsFxf/XDprEqylUc2cDVcixBUyCAl3MiXnalNpvpQ
        zFHggXw39cPBgEIf1ZbJUi3+PQdhgOMJXnOFkGPkexKnlm0BasqJDzofexgb4qek
        EpJwRYdfiK6vQuMs5ppI0S4lU0gpwIW9pT2L5Vq+a7HrOweb1002jvrJ5irfE1CE
        BT7v9g0aFzns+WbC88RwGbs9KfQ37CMaQVqx1Z9D+XxZ9tFvODaDsAyte2ljTGgj
        AkOqy+9ci57ajjSK6qbSjsgsS5IMFw3Ih2ss+5VTKJvNr73i/DVg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sdy9w9syk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 09:06:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJyukabHhja8QC+eBlEit+GALT+3PXucxYM+fnGCdVyPl2ZJu/x0AR2jQI0TcydhN+5+O2oG3epFa9vVj1GxJg+aMeS7O9yM+t8Fhn93olbw246HX7KBFxALAhoh+tTOVjXY2Y0/RDNe6f08o3A7rWUWWW2pjvhiwAJ9xgR0SVyxjNrvSjayZxN2AMWZ9fb+0mt3Owjld+KfuNIEdDUwhO/9pHIcd1YZ8h8e1OshZeGaYaGI3QFLJzGd7OUhhOp5CKE3kimc+WC3eitbeVfjr2NfCI7i2Ig9fASRtUYkDmk1bd8AiTMlWKi8PjbOEB4W1R7gNts9oBsuP63tHvw+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kT8M9oVeH86xBACMU6u/VKD2mZUdwjSkmY8P4JLKR4s=;
 b=gw97iW3mgbJWzvyui4D9xh2tRCDUEutEA/YdMy7C8gw8QwvhZtdT+3n83fromdMWMyIlie+yoaflNQ18yN40q/qcEH9zs/U/U0OAgEE6Sbu6gLqe1GEyJ+M44CkB2MxYGfwAlvpgrOwygewe4UMQ/ZqoxrWvs1kyqRidyrv4Rm9+CImJQkWWnhgdF+NLp2ErkR9rA+VjgqpgnCdRis6VPgQ6t3C+d3WiX28frg9ZbryUZrgXruW7BO7y067UUV9Mf+Cdkkh7MGqnYktY0HfRA4Scgb99Gs9OoTmsYQ0SR0movXuOOH4TvNEo44IN6SMt/4795Az8idvIlBJATWIhFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by BN9PR11MB5481.namprd11.prod.outlook.com (2603:10b6:408:102::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 09:06:36 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::3b0:fbc7:334:a64d]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::3b0:fbc7:334:a64d%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 09:06:36 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, meng.li@windriver.com
Subject: [v2][PATCH] watchdog: core: stop watchdog when executing poweroff command
Date:   Mon, 14 Aug 2023 17:06:16 +0800
Message-Id: <20230814090616.1853263-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0150.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::30) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5191:EE_|BN9PR11MB5481:EE_
X-MS-Office365-Filtering-Correlation-Id: 323ac654-63b5-4b36-b23f-08db9ca5c2b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HZ9dnss8TPqtBw/r73IBM+I+adz2sVXgHLHBpyQxLskujt0bA6hjyJQkr8s3djm8lKl9456HbNj3zpUFpxf6tSAYr2IiR4WvW4/rx8wBek1RISNleTc9x4IGyLFJAcx3D3oO5+VD+Kh75H5W5UeahaUYpj3c4eyONQz/jifq+fG+xdMXr1E8TPRsz9TJy0VI7DIY9cwoHZhGv9q254Az/GlI1njq+buPgx/Io4XdagGY/9NmuJfl1TVnlFWYWsT3Jb7Cn8jV8kfK70M3v01FEdQq6Wki+ZUCJ5NMnVS+gWs38dTtg7G3nYpfvDEtqz5oRJRiYDQe/L/zkV4RAFas9DvS+A5sHTPWWyLi08GXP/CrBxl0OPYl+frbYY37WfBOe4+TuAdiwnPzqJ+rTHjDXFcZ7arDoRGByuswh1KrldpEhSXlOkqPrsipu1oA4u8q7hoykTGMpcbDnLneeLaWuEXEBxoDwo8XC44CtUwfTB2treDsRoLjd4IzinerLqx8ieJX7KksaXUceIPTOW/6Gc+i7TisACCMpAn4U2vozTVVpBEL/0b1ZT4uvWDt1Y+ecyyA634yyRmO1M7bJs7zeNIRGNQ7DhQSY6yJ+gZT6tX36IW0t3w2/2hXtrFgxgFYFDiidmIuwyZ8z8f1B1dWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39850400004)(451199021)(1800799006)(186006)(38350700002)(38100700002)(52116002)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(107886003)(1076003)(6506007)(26005)(83380400001)(2616005)(6512007)(207123002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ARmN9xFXVhSF1cZtYjviyV7rGlVNsc3oa+Oa2AEf63ic+bnjq1w0d7AD/uJe?=
 =?us-ascii?Q?K2TjUC0t3OGpsg7yT/XOeHjnFc6192eCwjYqQ4n39DYn3qVum3Dom+0xzL8a?=
 =?us-ascii?Q?vNPath1VW18ykJE+OWp8bUSj79b0jTsBapKXYCUdvkEb6oe/ZQ6/NJCx8Yf3?=
 =?us-ascii?Q?Vtg3nN+DoDpLBjroMSSf+nzzEpCVclEWZ6B+KFasc41tsP0tW51Q8RKbVSNP?=
 =?us-ascii?Q?CMCalWGgR6vwRUNmjQxZY0pUPDbW8F3yCPODm4lhWOc5V5Hh+y4KqY0H9MZp?=
 =?us-ascii?Q?BMrh8v7mmaJVJ0m0r6A7Upd+KWHP7P6DPHrocw36JU18tIgaFw7ZAsXBm1GJ?=
 =?us-ascii?Q?f9j6KaCo/M3WCn4E3gaSMIYmZOYCnPh2OKEKYaU2cEMYIYKPiNMAj0EdtmVO?=
 =?us-ascii?Q?e0eHUp1NyZ6E47GFNIcTnAjvbIYAPyw5cMl9t/fXf2nCGb0R2rc6J1eyapIN?=
 =?us-ascii?Q?fy53DH+RFdNP/9t950Dhi5xAXZmRGVgyFtc8oilnvajogR22CIPdL0zjUfF/?=
 =?us-ascii?Q?HoKoDh15DKpmI+xe4+h3zhWMteJyNIwPqeMhue0OV9ucpb1AEQ2m7qqupTAq?=
 =?us-ascii?Q?/4w16lyR1VxGThqZR8IEwn5uK+4r5MNWieA/dGV7tRJyVX5Co42izIBpJuWd?=
 =?us-ascii?Q?CObftQ3MuY62TI1gGbxScSzuDTPKEzXYNkmgHsKrwGYsW9gcIX/CAbbUVYH9?=
 =?us-ascii?Q?rxoFKtR4qo8qOZfCjlRVYwXjv827ei/jaV+qCKHktPUsGvfVDdUHRV2qP/eY?=
 =?us-ascii?Q?6ogIdtg9e+S18QM4jyE2iHDCWXZtzaGDiflzJGDud8blF3Vr/z4Ded3OSB8x?=
 =?us-ascii?Q?45VAS4iIn19nOxJOx0LViQzh66c3CRnwKdLKQ4R5gBCfvuP3xyAjQ13jc6od?=
 =?us-ascii?Q?kOiVa8rz/Md50dm7uJ1LgDOCnhcDDPAE+9nqQhR/Peg13mEhgpIGML2As6c2?=
 =?us-ascii?Q?yfS/l5QABKURYt3gGA8k2P2PdCQ+M/TE+IqemjtZAKDV7X8Ix8jpSLqMFUc4?=
 =?us-ascii?Q?+w5+218+RZUlo8EXtCBuIJvtLuSNOyxSamXPpZJPa/oiPDnspoCrxdzFZpcj?=
 =?us-ascii?Q?VlQuQULQZp1fWUmcKt2Ie3n+G9tr9ImJZIMG2J6Oe5qQBS/yYmGsKuOIdtab?=
 =?us-ascii?Q?d+SfvFeS76F0Rt8qVHy7fYAYkAKcc4lrPWxtKDlV9FUu5u6aKg0qNSz2FSxK?=
 =?us-ascii?Q?ZmLD6m0xm6ILdie1pWwjXMQe7UD/YhDN8TMFzOEQLTHsz/Z6G+PZ072NEram?=
 =?us-ascii?Q?/M1ZV0BU9BP58RplPCmvH3w/xIoYY493onFIopG9C5Vbltqlmg8A8tN+EQUh?=
 =?us-ascii?Q?ReM8cpxwWhwea/uZGb8RideH18d/bJ+uvcs5YHQiD3UqdDG+Osz0kPznCbC/?=
 =?us-ascii?Q?enrYRy9UNgszPQm9+DxUaWJfngtvsGtpAIgqqdu56rzw27boFSfg7yiARlcR?=
 =?us-ascii?Q?nsVIDIrkiBvQQrRerINPnxCVjh2+RNWUQD1hwL7zLrkV70XKURBKN6wE50CT?=
 =?us-ascii?Q?pRa6whT7lLPIaFAUDYDlXJW0D+wsIyZ6eqDuse82El4ii8yTZYKUSslIW/2x?=
 =?us-ascii?Q?BaZzwt56OUC6vtKA2F8VpsApBRDmu41vPhPTEBab?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323ac654-63b5-4b36-b23f-08db9ca5c2b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 09:06:36.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6s9m1H/KBUtxXc324ZSO0miwYvsYaZiMH6Qpfui+Wjm7U5cFbsy0vcLF194ixWwK4JxgJ3i6fOxudI45P8bvTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5481
X-Proofpoint-GUID: 9eM2oS3Y46OnDzlaXr864IG4YvNanI3p
X-Proofpoint-ORIG-GUID: 9eM2oS3Y46OnDzlaXr864IG4YvNanI3p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_03,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308140084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meng Li <meng.li@windriver.com>

On some platforms, for example, Intel SoC FPGA platform, the watchdog
is started in u-boot, and so kernel will create a timer and work to
keep watchdog alive. But when user executes commands "poweroff" or
"shutdown -h", the system is reset when watchdog triggers timeout even
if WDOG_STOP_ON_REBOOT is set in watchdog driver. The root cause is
that the watchdog is not stopped properly because the SYS_POWER_OFF case
is not supported in notify callback function. So, add this case to stop
watchdog when executing poweroff command.

Signed-off-by: Meng Li <Meng.Li@windriver.com>
---

v2:
 - fix typos in commit log

---
 drivers/watchdog/watchdog_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index d4c5a736fdcb..5b55ccae06d4 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -161,7 +161,7 @@ static int watchdog_reboot_notifier(struct notifier_block *nb,
 	struct watchdog_device *wdd;
 
 	wdd = container_of(nb, struct watchdog_device, reboot_nb);
-	if (code == SYS_DOWN || code == SYS_HALT) {
+	if (code == SYS_DOWN || code == SYS_HALT || code == SYS_POWER_OFF) {
 		if (watchdog_hw_running(wdd)) {
 			int ret;
 
-- 
2.17.1

