Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78B7A75E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjITIan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjITIak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:30:40 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E799E;
        Wed, 20 Sep 2023 01:30:34 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38K4LiQs027614;
        Wed, 20 Sep 2023 08:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=zkrBJP+mr6DHy6EgeS
        YXaYFHaZ4B5eQKZG2J+6skekE=; b=dxj1eQsNsmEig/IfMHhrNrXkUlMVEeXucQ
        Xs3BPUFXlinwT0zHMWVgHmozd9SChL8IYksp1tVZeIoOkDDCwOZqAZ6PA0DzWBs8
        r/oGoa7mvYt6BpnofuqH9lGmXMjlAkRPKIYIV4HjROX8O+SbskMWouaxUJQFL17w
        jaws+1+5xGz1OOBsAqQ6hQQIWbbRpnzQ67lsdaDzREoTrU9WZzNDbZDoPHLoE+uy
        rGmzbmYdw4HNXWfiw5UmOM7PEUFHM2P/nJH/WJT5xglMu/5sXwUDN0DZ1zXZycZJ
        eg//6WFOqeVi5CCFVSd4/FuncKlCFPnHdzM7PL07Dd3qq+M2IDTA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t53b5u9pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 08:29:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4Yoq6mvTpQhjLEnjD8zk2M0suUbTGGNDe8VQjYfVW2SBkdimjRNnZnH7YLgSXlvMO6bS/Eh9wXZloJ5tKx4jtQsMYBonfB+cn8JeIaTEbBGtKwDGzwrKIJpQdD9RFv0xQBGTpVSGpvS2iwetCN1q2LZWH65dkSPQkpmgNBWtmWo6gEs8799zwIHaD4C7z/7zAeZ8fOe40Waqu0E4qgIB1P/zlcN6kRCybtp9ycmtL0gTKYVKXOPnw4IgqIJ4ERSw6oTrVqqiIhPZKLqbeU3xS3cSnhgCWsi1U6o0E5l2T4nAlaAcZ68BjhaDnZj8/PKvrYSPEf752M8szxdR2z/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkrBJP+mr6DHy6EgeSYXaYFHaZ4B5eQKZG2J+6skekE=;
 b=b9iLKtMHOnh3yRlxMwlYdIoCZzahnFURYCD7rHSgAIE41FpLiCT27z2mZfa/HrWONqQlokomu5koQ0sC6JR9RszIPEE1Sh3TWiiVW6obhf3imRD7Eb4yrwuU1TxrxrdY9VVQNqBvakJbT6mBOSXsTekZ4AniaH5cKgd0PDM6xa3WW4xOx49XP83CRR8LPsWzrwJQ5tYzU0sWx1kb/N7MM4wYt4ww4lVp1YO0enidqSF/guL2l7ckRqOOGCT1aouHdTclNmSGO5HwKfRTKx8uRuXIqT92lUqsiLn5yCLwU7mcwlWIeKoF0PGyDQdg7R0cYIB/udApF2cokJSv9EEN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH0PR11MB4774.namprd11.prod.outlook.com (2603:10b6:510:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 08:29:17 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 08:29:16 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     peter.chen@kernel.org, pawell@cadence.com,
        gregkh@linuxfoundation.org, pavel@denx.de, rogerq@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: cdns3: Modify the return value of cdns_set_active () to void when CONFIG_PM_SLEEP is disabled
Date:   Wed, 20 Sep 2023 16:28:56 +0800
Message-Id: <20230920082856.1782284-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH0PR11MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: 302c3211-e27d-4853-fdc9-08dbb9b3ada0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDFJlwS1BYNUpK3xP69JROImYI5GbnnDu+Ln86O3CGf2uQ++uAHZV6D669JraBvBEDn+/jurQpgq2MCAJwzomTQI26qDWx9S5g/XPgRcJnUE6TLAHiYid9Sq/kmLLY9rlTYQqr7jIXSUtEe5WXoh7MjGj7isjTOb+4Rhv5kuM5XoZe8GNrYd2ZRl3/rlsgSy//IKjGn2JKtsclxpBRKCjNeE/+wdY7tZU2IK+pmMTnukzmjqbtqUeCnqePwiRg6cuYq65ydfhpL+9mkvkqkX6PgYb/kijBIrnkjn/CoDBvWDLt/3N3c0+uU/PxEf4sSxZPA5lKaMZjBGzZST3UoW1Wg3n/V1DbBdhDHbhpGPqeOpIfoh+ebzAVHnPtETDcYKE/8zv01N+GfnUUNvHdhbs6ylkrlmdOWvsOQnzkx+XL1ZLv+/7CYuQ+6MAbEHh0VJGYj2P2HwHWFlWQrLhMJHSTOqcxpCR2KvDD/1/WZzQ5epAa1ad5F6+6sjApiUnLPU6Qw4KQ5ECGu40hC97bHiYLOHSe05QAlHUFDdDJbmbqWSf7S9qBDf3V67RSD0+t5XMOHMi0/H+noQ02gHE8losI94SZ5qhg5LKYFoewSAsIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(366004)(396003)(346002)(136003)(186009)(451199024)(1800799009)(316002)(66556008)(66476007)(478600001)(66946007)(38350700002)(38100700002)(966005)(2906002)(8936002)(8676002)(41300700001)(4326008)(86362001)(44832011)(5660300002)(83380400001)(6506007)(2616005)(6512007)(6666004)(52116002)(6486002)(1076003)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vR1PNduhUeYoCrWq/JBR2gGsr9bNlalvELHxta18H6Cl0uwKnTXTpp9SPCMG?=
 =?us-ascii?Q?ecpewncyDNVn3Kx4YuCulgYSm1t5iuDw6xu7qDhWVVTWhEVAYjnM2KGZDkaW?=
 =?us-ascii?Q?NyH1eBIXNgfiLoC0ARqh0vh6kNfis6aRxhrDiy3SfzVUlbT63ZWMoOeitCMU?=
 =?us-ascii?Q?DVFmVsUdCC5BNGSu/IWZpb1zRaK8JsxB9/aCHgNIgbm3vGGWlVR98Zavgxsw?=
 =?us-ascii?Q?LtIJG9ow/QveXFBmAWcbnQDBGuYBIZ4eL5x9lX3jMFZCsfBfaiXDVyt8Xnbd?=
 =?us-ascii?Q?9kJjDWe+Xv2Jb/KNRPAoHN2rwkYL3RiIxl0A0oRUc6Jz08GY4V4YrtKz3/bZ?=
 =?us-ascii?Q?AH1yVY423NT7pVD+ETr46u27+YGnAjvP0QGgNIJwh5uANVYux4+HDOueDlMB?=
 =?us-ascii?Q?hgdBTTloOZg4pajo3KZ/MLIXOvVsHtrUR5JiO0LWt5/wsgQ6RRfETQbeDwri?=
 =?us-ascii?Q?K6w5KoLZtS2DgLrXkEG6YMT+NN0C7k0i4mGQASTm0aNcP5E2iPe93Aw4FVvV?=
 =?us-ascii?Q?+AtsqF1EehVWy2Br6frh7rcZ8WtDWRp+CZTIn85QGVbA+Se1qk2AW3jtTVZo?=
 =?us-ascii?Q?mEZf7IwP0+dgoeaKLG6ePIqPn+f1uXc13C5iHtj96g7ohNcARhI5UH8MK9O7?=
 =?us-ascii?Q?97GaIah/es9XcpiVHOhnvR39VXFEX0YdpEVxz3c+Eur2FNTBl302FjwBJv/2?=
 =?us-ascii?Q?cTjmjCbbUO0WSBkgAihTHaeP0HDU2bg/rGsY6GI2ZJNDyOxkvNrYaXxMF7Xt?=
 =?us-ascii?Q?1z5ZkwWJyBQcHjEeEfW2F4ktMKsGM/oO6uXSyVMQfAlRTKrrWODbQyM+P4Pz?=
 =?us-ascii?Q?8YTj6OoUMtdMY4JfEr7TlHK8dgu8lW7utHSQSMYt+rWQKV7V8bKnZDDnkfkP?=
 =?us-ascii?Q?DmNYyTl6fte8bAHFFnHjkx+2iThuMhNm45hIS8vkhguoWT80tuqGAi/m9bHo?=
 =?us-ascii?Q?d4opkhY6lKV++D5wXG64zmvSRJDYPR/4SaEpcFfbn+lTW+Q63zRSyxKwirrB?=
 =?us-ascii?Q?mK78gISi8ZJKPZIK/aA7yw0apuSKguJzwpRNIieMnTeXMTIA82qEXALUXL/e?=
 =?us-ascii?Q?6J3niEaDOm1aipmlA9Jg1bhfiyE8F5ZBsEXZunueSC+OVqZvAcJ3D7IxPYvq?=
 =?us-ascii?Q?38/lUZhMtNdrF8V0q3N5dJMVPcLPubldBAy0ZFucONoLREF4SVUXdKqnu5hR?=
 =?us-ascii?Q?bPCXGqGPyXbUs257pw9nYb4ZhjWT0gU39HdT7SOVTPuA3IdzPLAOdnPUI3o2?=
 =?us-ascii?Q?SB2pDz9rsdhTO9bc5SAcYfkLc5mmaETRupBfIBFBJvxICGb5bZA9ABhVI/T6?=
 =?us-ascii?Q?M9K5JnNSKZavwj6xnKt+X/002IW3JOwnif493MrAlcZI7kisCcwvLRkWwNDX?=
 =?us-ascii?Q?18k8OJmx000sq/MegrHiji/I9M6GuvMEh2NNeDMV9n8ra4bOkXg4hgG9/YBs?=
 =?us-ascii?Q?R1kCttqwn3aw5MNyStDl/gKRFUVoIPzemAADWnhhchKYDIBvf9g5g4VaMHsx?=
 =?us-ascii?Q?zYKlBiN6yVauoSHSOTdGb4PWFRqDyvFT52iUhKH9MfhGOxUZ4wVUOcjdABRZ?=
 =?us-ascii?Q?y7hNADKkVm1wS6uGnjOSm7qPxs9oajcktqO1NmSW3mNEBay718Wy5ZYLs7Cj?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302c3211-e27d-4853-fdc9-08dbb9b3ada0
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 08:29:16.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th2ZUNr140seGm7sloyNu3/qgojcFSb297oKWM3IOLp2MC1WgVb6gEx/g2QuyPXwX5ZA7umNLLok8FuHtpRJsgppSgwEMdu2/9AadDcYrHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
X-Proofpoint-GUID: aAjPRAdUumIkK3qDpyBkdm4mImw5_oaK
X-Proofpoint-ORIG-GUID: aAjPRAdUumIkK3qDpyBkdm4mImw5_oaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_03,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=654
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309200067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return type of cdns_set_active () is inconsistent
depending on whether CONFIG_PM_SLEEP is enabled, so the
return value is modified to void type.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZP7lIKUzD68XA91j@duo.ucw.cz/
Fixes: 2319b9c87fe2 ("usb: cdns3: Put the cdns set active part outside the spin lock")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Reviewed-by: Roger Quadros <rogerq@kernel.org>

v2:
 * Add Cc: stable@vger.kernel.org

---
 drivers/usb/cdns3/core.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 4a4dbc2c1561..81a9c9d6be08 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -131,8 +131,7 @@ void cdns_set_active(struct cdns *cdns, u8 set_active);
 #else /* CONFIG_PM_SLEEP */
 static inline int cdns_resume(struct cdns *cdns)
 { return 0; }
-static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
-{ return 0; }
+static inline void cdns_set_active(struct cdns *cdns, u8 set_active) { }
 static inline int cdns_suspend(struct cdns *cdns)
 { return 0; }
 #endif /* CONFIG_PM_SLEEP */
-- 
2.25.1

