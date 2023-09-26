Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB27AE72A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjIZHyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:54:16 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E0092;
        Tue, 26 Sep 2023 00:54:09 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38Q5jFEB028972;
        Tue, 26 Sep 2023 00:53:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=eMSVxr19vNrvjtHox8
        yCqM0M6X6BxX2Op2dFIb9Sy8s=; b=NNaYyW6JqsLru3oh6hbjxPHClCgumqSZNe
        I1aT6+LVQiAf4RpUyNzAWuQYumQSdgxoxAs2CrsrK//Qm6Ir33kmxSPn1G2YA+qy
        p3qn83G+xyzUbXBPt2o2uoxS4ZxAymS5SVShG26inSp1L3VLr31kFxcb3sTcVO/f
        ADy2sQ2wGpj+17YBq6/vyvf+nZ/7PFKRIMlRb+L/QuOESMprv0bDNn9bM4BSfdG+
        TtTd4qJ4whH6T8wHeOKNriHGx+STiKSmBLp4pTb8ejk19g+fFhFEZgUeFqvj8RxM
        1F2U8mrsS2fwraiqKiuwWUe2VBr+h+0no5QCdOHNG+Us5Via09Qg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t9yhgj7gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 00:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9YTWB+FeJYWwzIJYGIBR32jyJ7m9+7LPrBD8dOzfYGsYmUf8hjhgWDs/WOmtUE5ZuN2yi+LxbwsJEsvpeMxr1qmK8pvGv2GZPsHa/s8Q4HRKrB7NVA7G10X9OVj35a/bNgJjjyudiyCSzLwvzoGP+rS0iP4WUm+CM7M3O8o2iOp9qkgml6X4U/a7maLOj9m5dVm4yvCwz4bumWNDXbx0vY1GW/XfqRiewSvRHKI6ByI2D/c1S7lVfOqMaKlzrCXam2aHP4q0bdEerFiZQKu/PSjkZ466GGSB49iyHQznarZbIVdaOejGeP2B1XlWV9PTdMynRH0xViODMgU45GE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMSVxr19vNrvjtHox8yCqM0M6X6BxX2Op2dFIb9Sy8s=;
 b=RHXoQFbfLQq69JIbNcA4va5+eq1pT7kgFUE/KlECSB3YIWlmVI38NO7X5QZd4ilZhzDxtpS28qdFP81TpwrtW+FtYTcGOKPJbP0Ti3AVnFgk6brrezKT+ceC4pkooSANmB3UrxlSO13n9VPgQ+2F91l8YoyzaTttlMdKNLh4oPKy+Q2VG07+4cNk3R3FTGdAYuCUpJVBB5e5jmC+3TCHaU/QN9fY7FXfgGh1U/9lRVGK+QHwhEdDD3B+SDLL9JOADWgitYAYvydTRkJUHz6W7ZDQbtQ6gp1VFbkUGrPnih1SEsLi67No/HtXIRw6iBKJdxTchALv/psj/Lm5jT0YpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH8PR11MB8286.namprd11.prod.outlook.com (2603:10b6:510:1c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 07:53:49 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::100d:4fe7:fa5a:c5e4]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::100d:4fe7:fa5a:c5e4%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 07:53:48 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     peter.chen@kernel.org, pawell@cadence.com, pavel@denx.de,
        rogerq@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] usb: cdns3: Modify the return value of cdns_set_active () to void when CONFIG_PM_SLEEP is disabled
Date:   Tue, 26 Sep 2023 15:53:33 +0800
Message-Id: <20230926075333.1791011-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::22) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH8PR11MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: b8039564-6e17-4d71-f777-08dbbe65b772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayiAD32vBGLThROQW+TKtSd3OBGuITGs2isMGjuNsDr4pEQgcyZK6fbD7JFYwcV9Sn8nrLvqFFi+hwNlnyk5CG0c4nZGdz2P3RIRIxLwsZjVCVdFcFz+bMbkogGQXglnOKW7HsumV4Pa1Ie8J1q4bF7Fkc26dTHjTRiwPewKkwXVWb4lunPbvMuxeeU1YUuvflhm5xgQ6V1C0AJ1MXL4DksJdFKWGwQp3jkaOvRRCmDKwjx87IvU7LTZ1iml6XvRPeqxTot5rAxOSVJR1H3OgfTWNyi/Hd7kyA+1s8MZQzEKYn0Y7Ud4WZHVRYAtGisI2XVDVz/UtKNrnHeymRYu1+BQi6meTueYVU8g2hED9x0us1mv/KDtenhw7PXb+gBWEaF8/32ZScbLyh8sp0F5hKns8l74lo0gBSO+NBra3eW1uLNQfQ2ULpggPcFgMthMgH/mzgx+xphemvhiKbxfy4B419L71s8MqJZ6VHD8On+oZJ+a/FA7fqqPnmJ5XeZhw3/2Bt23WyEhkrQy9MZoV4IDkUlPEUKs8+f/kQBOu4a46EWeMj/2hVXkZ8lZmf8bDV8b6c8V0tiucJ6xSu0L7WBHZBJBqA3u/bLFR1P8Nng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39850400004)(376002)(136003)(346002)(230922051799003)(1800799009)(186009)(451199024)(52116002)(316002)(66556008)(83380400001)(6486002)(6666004)(6506007)(66476007)(36756003)(26005)(1076003)(6512007)(2616005)(66946007)(478600001)(966005)(44832011)(8936002)(5660300002)(38350700002)(2906002)(4326008)(86362001)(8676002)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bgox4UIODSgV5g3ovqs7a5AYkiDGvQEN3kOuGlpHphX97vyf74E7YhWlA7ot?=
 =?us-ascii?Q?Sl5W1SGkC2yQd93QpgvoPcpF5HnCxX5gw27vAzROLw/AhV7TTi7JVnE4wDx8?=
 =?us-ascii?Q?7vlbOzpQdAU9F/NbzXX8pJkV34cefDV4k075HTM1tYG4QlNLdizr2dQr31iH?=
 =?us-ascii?Q?Q7XdrHPP2EETpWRCUL0gpgT5ftqmxgFn9NaKrGzjC9LdUs254g9SybX38t6P?=
 =?us-ascii?Q?RTGoGRTKSS6dn2Lun6nXWYgcxvCBXMR5bHTIjUmnXpG7rpyTrrdFT5iESlph?=
 =?us-ascii?Q?L9zAXKgeODIVfeH/hJRQAi6cWWoIOvvHmNMXvlPFRhSgPmcET7FKFmRFsSDd?=
 =?us-ascii?Q?+3pngKF9WphHXlyGjv0jztwhMbSCxSTTSwGdfvrsiqSmJRZNR0WLErRcGQ3D?=
 =?us-ascii?Q?XEkO/H9cz6YNXqT/2inLhakQxIS/efbTH5RlWccRJgPpx6KBcCUgUGyMazms?=
 =?us-ascii?Q?M08cGTwjU/5BWHyTSHLZJsWyib4zUQmr/deLF1ps5e88k4xFxLqALMedy3mv?=
 =?us-ascii?Q?US1PeUvTIgwiGbBUncXnciCv8ryM3Uu5jFB2cWXjIhZLQfUuon77ilJrE+uc?=
 =?us-ascii?Q?MxqZyl2LxQsD5Za4DzZXh6FPyZA8ZQcpS5NVq1vdP791KylL8LYYKmX5d8YI?=
 =?us-ascii?Q?UpkF7kKftsKQvbyDTGvPQQNkBiiT/K7xiIf0kz/HK5/E8LIHqcRb/XfMWjMt?=
 =?us-ascii?Q?vwC3fK+czYgGEphdHU4u0UjUyN782lZJRapIcz9cw1lBeZNy3RG+sFiz2gQf?=
 =?us-ascii?Q?YOGEV6i2Uce48DYB6uwKeNlPas1yzhQ4jhB2Bx/4N4lBmjCns6Ue7e2adoZb?=
 =?us-ascii?Q?ucod6SK+AttzmfJzY+DOEo2HBpJpC1k2/pvpcXMsZYA2McfPv7U7nm5lBt5z?=
 =?us-ascii?Q?K2VbN5laAVKEnjfCN7p1MWFmV7tL2gZJnioehS7uABhL71jRY/69M7Fquo/I?=
 =?us-ascii?Q?8uNtKeL3RQnMUOWgla/NvC+PCkniMhN5BhDEoLde1BmPbYMJxyAlsSB9sJKk?=
 =?us-ascii?Q?gueTluMvYaOFh3UvIChbJq2HzNbw+OHwkhj1Fu8jfq/ePalBsuw+rd4bQ5NL?=
 =?us-ascii?Q?ZgtSlEaXjCTGNIF6uezRyyeGWAHkrLU8E/4tjOZjCgnK+QqhWAPyvQVQ3rdX?=
 =?us-ascii?Q?ud8IQ+gWSGUTbW1GUIBs89XV0HXaW8jYWViYuLnteqS1s59Fng5esHK9mK+K?=
 =?us-ascii?Q?TAUJDrbFvqgMuTlNO/YOrZXzHxoZbi6e4kRNrlRoNWsOANGBBkUUfWGRnU+s?=
 =?us-ascii?Q?x8dVlVwM60VfDSWgG3CqnlcsvHnfrKjOUklvkdfb0NzqTKvo+RnOkY038Seg?=
 =?us-ascii?Q?2rKQcQ67jy0wCix89DDLygxkcpsRvOb4hcOBaPvn13zmF96+UjFXaI92dpsv?=
 =?us-ascii?Q?9I95MaDzrFnh3bCj/DxVQlDVitCdnjdSiUH6md5gzkOt20BTZGo1J0yY/Xt5?=
 =?us-ascii?Q?miV6c9sYnKokfiI9Q/gA62TX7UPv0hUa6mEELD3wHWtbasS9pyTz3RnSSaRa?=
 =?us-ascii?Q?l8zcxiq1ichXIqjpZWAmDClKkkuO3jb3X3oqI2yZNdhqoivNClSM5xZjRA8u?=
 =?us-ascii?Q?Lb2YOJT/odIw5ROYJASTi8OY1lGP3K1OJCOgVetxidhZUUO4aZ/icf2cgMMq?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8039564-6e17-4d71-f777-08dbbe65b772
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 07:53:48.9170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgFkhY8qAAV9v2PEUjFrLq9GV06Q6XFomZAmKGK8AaadhRKYlpzzjCvaGcH/Pn4KHCCR3CVGG3LyUDL5EigPuGD+lHnKT7WgoVGIfd3otAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8286
X-Proofpoint-GUID: rtYh9lfe522U2Ym_8VeqcPzz_KO8J-Nc
X-Proofpoint-ORIG-GUID: rtYh9lfe522U2Ym_8VeqcPzz_KO8J-Nc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_06,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=745 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2309180000
 definitions=main-2309260068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Acked-by: Peter Chen <peter.chen@kernel.org>
---
Changes in v4:
- Delete "---" 

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

