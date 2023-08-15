Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577EE77CC15
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbjHOLwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbjHOLwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:52:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD301986;
        Tue, 15 Aug 2023 04:52:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FB9WkY015043;
        Tue, 15 Aug 2023 11:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=xbT93WWdjQkJI0eqdnHzjbzboxrJye3HeyrBrtTAxNM=;
 b=Xu1S3H81+T//0im41xg2V5TbfSD1mTgIR9lG8ourrhyVnD9W4su6fqeVqiIqwFGJMX5S
 ylaKpd+v2NECw1TJW0FyWJnlL7a/5n7hc82u/RL5tErlSDsYbY5F7i8oaCRHqfzAsgAc
 XXFjXIoYelkhR70bEQI8zZQLc+vL6ELwz0+UHTJ6CnoFGlN5IGv+qy2V7F35wQurY5eJ
 TY/HP7fU8N2G+JjFOm0LY6n6ZL0lo4CgLjAZQ7eHjlJ0DKnbFNBSAbD8XmUSzXwgTwf+
 VZWSGn9rgHHiDPeD+lowYNv+0WrEZMVdc2vk8f8SIDwfcpjuOSElnPKdb26o01LEqGux 2Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwmgk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FB3YhJ027683;
        Tue, 15 Aug 2023 11:52:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rytun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYv+B209Oz6RzkFJvLljXjt6Pjw28W5OEfc9oYQjExFK6jUJmF8s9WTIhEWTYGlk5gFv7a/p+UqKWvM8IqLB3LrD5PZhiyeSOXzrLOhmhmcMy4Qxq/PnoUxln/jDLZlekrF8m88yLiXb4kv92nLdipaLeXs39KJS9zoS89nELkIbV/eZtbiOEk2JVK5FB8fi5M2MQlWSWJvj64u2ZgrDaXJrAg4oiTnWT/Ww+ZIuI5NfTdV0xfnOKiAk0X9d6af4C4f3/FsTC+gCRTjU27rwEWx9IGeOe7Mb9J5Xf7gRFUpMRl42pH24S9O7lec86eItTVLv7evKXCyManPNMdbyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbT93WWdjQkJI0eqdnHzjbzboxrJye3HeyrBrtTAxNM=;
 b=QsRZVRtcVi38NwU+ffuLeW16GE6KGKO2O95NGoNSTCRJ/w80suhQQHoxr8VbpBUMeTvo19KY//QGZTr6XSwPOEVifbQZGEmHQDE2/cRig4RSUj89IbjgOIcjVDNXd9pV73vfY/XVjfkFJrSqd15UaQnqpaHbApT8/n5rhQRDmgYCRJ3cpPItcteN0ni9tiaoAC/mzTUE88xvFyvoW+s6u3KrQqCjV1oCLna8+uB6jx4b9lxmQgHOTssBq+SwPR0V6gp6pXdkJXq9q2Gk67JTnIc40ElX3IZv9nMVX4ylGmCO1cP6+3p0t0NpWlorWVOncSaI1dmc/AYldepLdoK6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbT93WWdjQkJI0eqdnHzjbzboxrJye3HeyrBrtTAxNM=;
 b=bOLDdIfpCrnZclAiPtasA3GviTZuq2xEi4AA0XweKPwQjX3oFV42AsJ72Ch1Yp9pvLRy5JDYxtYI91YK9bQfr87cW+743DQ7iu/iJOvVzunP6RYIuR5T06DFMw5ag1Uoxolx4cMuDHUtA4IKNtEDBwzWg7/NqHyDJGB1XvNiUYc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4488.namprd10.prod.outlook.com (2603:10b6:510:35::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 11:52:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 11:52:20 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com, dlemoal@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 01/10] scsi: libsas: Delete sas_ha_struct.lldd_module
Date:   Tue, 15 Aug 2023 11:51:47 +0000
Message-Id: <20230815115156.343535-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230815115156.343535-1-john.g.garry@oracle.com>
References: <20230815115156.343535-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0110.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0fdd4a-e37a-4bfd-c14d-08db9d8614be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ql2jbp3K/r7Pm2QHBgpZ5PMchSu+GAv8mn4avEfmeScUa8snxOmdMkw7e/vZqGEoansS5HRIUlWueOub8iu0y957azlYuFWx171OtO4f3n8lXmYOzGme83XpjAMmwm3lViW4C2PPEkN84lLzAasMZpzHuR7q+VPGr6rJxrvVGMLtTiHC/F/YRtM0ujH2mqxepTYNjBJ4w8b78aOmPrK0/l280ziZg5X7sgSvqv9Z5nHgF5upE088TCThcvHFcHdc7qnwnOcGH1efWzS03iCCAmdlwIYWO9/N8TZMiQ8hqUghgPPW4AJSzJbqXdE3c8sVljKAdMDqh1Ns0awgC0DH6SadSOFF/Xb5yu+OpVuCe56FL3BayPwFaF/t4TDbp++4E3fhRStVDrTQx7BdyukqOVT+vAgLxepz4yC6Hkw4cKAQj7zmsdz+xY/hL2l50D5yhWzQsGIFnkcmY30fa9St8hfxpaKM4gQYGvYyzF236nVtBbCS25AmZpstBj6xG8lT+pijorpYoW1+OPDGSwgshIyV2Fl9OfqD97k3ipm/4yX+QTefX/TpofGWtubYQ4kO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230030)(39860400002)(136003)(366004)(346002)(376002)(396003)(1800799009)(186009)(451199023)(6506007)(107886003)(26005)(1076003)(2616005)(6512007)(86362001)(8676002)(478600001)(4326008)(41300700001)(38100700002)(66946007)(316002)(83380400001)(66476007)(5660300002)(103116003)(6486002)(36756003)(8936002)(66556008)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N6PVTVieKiDH3vDY7AmmE8GN9xJo1MRKyeIWcWYPCx3MUw3hM/fhPy5cAfWa?=
 =?us-ascii?Q?01thmislMqtWO1uIQ8WM9Yda7b8xdEqY35iE/xaOqeL5+CTv1Af0IW2Ks6bW?=
 =?us-ascii?Q?14qQJlvzIqKoXL0nXUriiIEkQsQX5fn73OfvgIpw9pBz/pSTFfqHPQVOHiTf?=
 =?us-ascii?Q?Huqp6rYAKgE7VpY1ZN7Fe/7wJUz7dqGUMDNkh4I6LLAHV95VkDuucDqQM/Wa?=
 =?us-ascii?Q?Bkb29yr6C4aZP35LovBsAktDNjDueoX5bzS8OUOnqlxwJESwk1GGQoX1Swta?=
 =?us-ascii?Q?AEuNas0TUuFq01GvPuvNSnlxC4Nyy5mHebvFhGASIw2gnboTqdYfpDKyWQaU?=
 =?us-ascii?Q?5rs8i6ATz8Y3/kYOVUVRAGhUNwwmaxCHyx2+t0myKxjxkJbviIgjRXPTrzQ/?=
 =?us-ascii?Q?6ZUUvwBRlvoNlSv+IACxfPYdbzwD3VnqhAjCa8KDyCSCp0D4sJkEIrrF0Ced?=
 =?us-ascii?Q?WxJHkN21J9MRST60KnLqycDPZG2b4K0rqLbDUVRK+0+uA0d+ez8sDU+tPgze?=
 =?us-ascii?Q?MTVdGvBXcchlUu0yELtwXLfDNfBJ5iZPCcr5N4EUk4+MHJpcatWtU7jqtsGm?=
 =?us-ascii?Q?tLhgLIlbyRUHbvIlWYDVIKlHYclPiD64ftS2Inkr05CZCeog7GYn2k5PyhqG?=
 =?us-ascii?Q?ZZfEO1TEdZQXfq/BKHMgApKti9G5i1pEP1+0GLY0kmykkes+jdSoCmhYXhcD?=
 =?us-ascii?Q?Ow4s/BPAR9huEFPhgwJQWD6dVEilXHVKGlDNHw47qJiVLNU/N7am9BKSCm0H?=
 =?us-ascii?Q?YxjVjlWjsPoWtFFQUSEsiu7HdTe2LUWwuu7D0ViioEX2deKvpRtPVBHOauV8?=
 =?us-ascii?Q?HxyH/MkEzIOMC5pPND5FHbfkd4QrGJj/mowQWtWpmw6MdG0aDIkSr609Ur/H?=
 =?us-ascii?Q?HuheESf+nC5OcrVaETqpFTwTC8vJublVZNakUcYYwBXg9ntDqy81dlMzrlqO?=
 =?us-ascii?Q?s0HlvJyTpkjLOH+ofN5PGkeTQ3wJZ7bxNemIjmxILROT1WK3+EH3Lwy1JDEN?=
 =?us-ascii?Q?b0y7MXuTvH8IwwF+KxuRcg3HiiH3tS8XrU04ZbaNT++Y0v08qDowDSBfpkeD?=
 =?us-ascii?Q?fAcOq8C0DqwXzOH4h8w2cQ3Yt9mmQTZTxjIOinxu6Yse/+5y2eomOaY3hXW0?=
 =?us-ascii?Q?J92bbwZeF7kKIIpRxWYsqMQ9hmxbX+dqpn7dQ90jj+SOmjCcqlJLeuTq/vIe?=
 =?us-ascii?Q?upsRgf2KxOUs1k8xI57IE/pqk5IMYbukpOCHY39/ifX6YgJ9Qu40rt8X2Njz?=
 =?us-ascii?Q?gJxoJyVxyfzn43oPccE/jWi4zeZjWiTwNKHNzbuRFZ1Z+/X4TR01GuqP4HdA?=
 =?us-ascii?Q?98Mi8lpxmtj8fsefSWeH7ztlTpFU02FZ7q9+HFEmehMQKCDEEncR9xDMlHVO?=
 =?us-ascii?Q?T2r/U8xieYsFJBGnqxNyXnTx+xI77GKBHFaTMNZj+vC/luEnAji2/Cfzg9Nn?=
 =?us-ascii?Q?GDPRBMPgLP3eNl7xreJfrr6lyT3RJnX3Bi4VIUUkBSW4xy8GA7M6t7fQNwKB?=
 =?us-ascii?Q?I5g7H7xdpCw1h7mO8XMfJWrLv9z2A1VYK9ws+ZWcQlQcfmKt7FUqXMOdpvpS?=
 =?us-ascii?Q?J4D62gg9C1G68X59j2IKtEJpM1YZLiVAhEIZGPu3z68utkev5VAgp8X4toKI?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DlCEjEl2GG71QIi3hjLN+adDUPIT2xpxl9JUlG4d2oa21o6fTjIU1Tte10bC?=
 =?us-ascii?Q?ghFr2va5qLLRK7B+o1CGitvlSnO6RJPph4a0ZhqOK5tv4xDXGAnTLgt23MMv?=
 =?us-ascii?Q?++BdGwGyVQEFOgohNmCN3tFfHrrt+g1jm6rymfLo0vXBke2dvzw0+qKZ89ro?=
 =?us-ascii?Q?1rDiks4B+TjZ+2Ajz4o5emCm9laBhLx7f1ngCm1qbCDVPq/dHaSvu1h+ZPL7?=
 =?us-ascii?Q?ZszvwO3Z6M0AEhnwFmL6wMnBHvzZjhGlcHQ38hA4ENviIr8WeeE/7I3qkqwO?=
 =?us-ascii?Q?NyYi+WwX6GVehkHWNcy6L21AlEWESXcjNkD4fEDnOpLqwP6Y5h+eo7DzciiP?=
 =?us-ascii?Q?2PCokYP0yyjhA2/f77gP9cG+SG1szYFJggyWXVYdSuBx4BQML8Ky0rOVYZtx?=
 =?us-ascii?Q?TOYjHr/4/tckf163nZN5NYov5c+oc+rZoO5pYet5d3qPN3xo9Hp7wwEQOhYW?=
 =?us-ascii?Q?UYKZLbhbUF9k/UGTQaWvbjrVa1tH6DcPbglEz+ufXWow7LPUjH23zkxgq+2s?=
 =?us-ascii?Q?Xt4262sNddkrBL7TAmfOBKDN51ly9gkFOEkXyc/CtrrFK3m/cUFWDCDW2Ne7?=
 =?us-ascii?Q?BUFVWage9kaiENLmSwkXnPUpcsfMAI4K1gRdtrPmoOgIRdhLwNi419c2dKec?=
 =?us-ascii?Q?xihht1a/8FUUBzzjl59oXhFISTBHIaC2PeEoM9SqbDzNYNo8IMAS3mLGfXNj?=
 =?us-ascii?Q?2tG6GPhDwy8xkum8HptpTSh/7uGd+uUreZ/UgNCJWhlvSOaIITxcH5Pdr/Ay?=
 =?us-ascii?Q?VOdOwJ4SRR6aveU6rtDL7NG3s18nkgtht9+VFB1stCs7GnG3Va8l7g5ebDCX?=
 =?us-ascii?Q?nipppH4DceIjNC/TBmP8TNa3UXryktUSdPQqEEzYkZlF5pZyqW80beE/23MS?=
 =?us-ascii?Q?zURc+cxr/dr+umIkR51GKqiyGAVTrEw36XAL3A9zYH+dl8RZyKyjFB6wkYgo?=
 =?us-ascii?Q?8HlGdd2Io5m1ifQzBaAUgw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0fdd4a-e37a-4bfd-c14d-08db9d8614be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:52:20.3451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17ZMh32nyWz+LP2a5wyqTzhEnCKBDSeMwTA34SPjGQAvUstzXSX9Sep5KeQt3JveRfzl1KrLShoKru6L9zcUEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4488
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150106
X-Proofpoint-ORIG-GUID: rxrMNTkQ0j5OK2PIgUFZIlIb3HQeYSG5
X-Proofpoint-GUID: rxrMNTkQ0j5OK2PIgUFZIlIb3HQeYSG5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
driver"), sas_ha_struct.lldd_module has only ever been set, so remove it.

Struct scsi_host_template already has a reference to the LLD driver
module as to stop the driver being removed unexpectedly.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx_init.c    | 1 -
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 1 -
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 1 -
 drivers/scsi/isci/init.c               | 1 -
 drivers/scsi/mvsas/mv_init.c           | 1 -
 drivers/scsi/pm8001/pm8001_init.c      | 1 -
 include/scsi/libsas.h                  | 1 -
 7 files changed, 7 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index f7f81f6c3fbf..6603e91cee8a 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -667,7 +667,6 @@ static int asd_register_sas_ha(struct asd_ha_struct *asd_ha)
 	}
 
 	asd_ha->sas_ha.sas_ha_name = (char *) asd_ha->name;
-	asd_ha->sas_ha.lldd_module = THIS_MODULE;
 	asd_ha->sas_ha.sas_addr = &asd_ha->hw_prof.sas_addr[0];
 
 	for (i = 0; i < ASD_MAX_PHYS; i++) {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 7a62590f8730..9585f1ed8ae5 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2514,7 +2514,6 @@ int hisi_sas_probe(struct platform_device *pdev,
 
 	sha->sas_ha_name = DRV_NAME;
 	sha->dev = hisi_hba->dev;
-	sha->lldd_module = THIS_MODULE;
 	sha->sas_addr = &hisi_hba->sas_addr[0];
 	sha->num_phys = hisi_hba->n_phy;
 	sha->core.shost = hisi_hba->shost;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index a676558b096b..7b40f0eed703 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -4973,7 +4973,6 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	sha->sas_ha_name = DRV_NAME;
 	sha->dev = dev;
-	sha->lldd_module = THIS_MODULE;
 	sha->sas_addr = &hisi_hba->sas_addr[0];
 	sha->num_phys = hisi_hba->n_phy;
 
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index ac1e04b86d8f..c3704208511b 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -250,7 +250,6 @@ static int isci_register_sas_ha(struct isci_host *isci_host)
 		return -ENOMEM;
 
 	sas_ha->sas_ha_name = DRV_NAME;
-	sas_ha->lldd_module = THIS_MODULE;
 	sas_ha->sas_addr    = &isci_host->phys[0].sas_addr[0];
 
 	for (i = 0; i < SCI_MAX_PHYS; i++) {
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 49e2a5e7ce54..aea70ec308f9 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -458,7 +458,6 @@ static void  mvs_post_sas_ha_init(struct Scsi_Host *shost,
 
 	sha->sas_ha_name = DRV_NAME;
 	sha->dev = mvi->dev;
-	sha->lldd_module = THIS_MODULE;
 	sha->sas_addr = &mvi->sas_addr[0];
 
 	sha->num_phys = nr_core * chip_info->n_phy;
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 2e886c1d867d..1e0154d08393 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -654,7 +654,6 @@ static void  pm8001_post_sas_ha_init(struct Scsi_Host *shost,
 	sha->sas_ha_name = DRV_NAME;
 	sha->dev = pm8001_ha->dev;
 	sha->strict_wide_ports = 1;
-	sha->lldd_module = THIS_MODULE;
 	sha->sas_addr = &pm8001_ha->sas_addr[0];
 	sha->num_phys = chip_info->n_phy;
 	sha->core.shost = shost;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 159823e0afbf..ccaf8f6b1055 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -376,7 +376,6 @@ struct sas_ha_struct {
 /* public: */
 	char *sas_ha_name;
 	struct device *dev;	  /* should be set */
-	struct module *lldd_module; /* should be set */
 
 	struct workqueue_struct *event_q;
 	struct workqueue_struct *disco_q;
-- 
2.31.1

