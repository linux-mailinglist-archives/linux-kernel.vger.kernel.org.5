Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575027771E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjHJHsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjHJHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:47:53 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22F9211E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:47:51 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37A5f853004421;
        Thu, 10 Aug 2023 07:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=FG+08jmNx+7kR0mhNA
        Hrfo4GQCX4fVn0beSpS3ZdT3g=; b=nRXcMmXRc5QIlIrAY+14/08tbvWv1bgn+y
        3rH+HrHAI2vxYAxegpEnGmF6p1Cra83h2/+skVTZci8rGYcEa125w3ELLZ3hEo5b
        cDD/fsxs3xPGLHI8rENDOcFJqUfRZVh5ajNlYcqWECbtvfI2zT/brAEszOu9cE2Z
        oibLBu/NWZHXTg/CRn95RGKe0OWW6DwaSTvNa+9CxggmOAO8jDe6J5Tg1GPU7cpm
        BT4J/Bq5D+mUn/aRU1iXdkn/kRS7laeyQd77ambYqu1F1+wA04BDvsONazWrA+jB
        zWeD8LS3j/EmNqLCuE3RXuuysrIqL4OpQaY6MmjZRZIa55f/esnw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9dd64msm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 07:47:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7BDVYM7XNxs+iaL33CkXlO37Jx3OrkrYAZx8d0WoOAtuse2nN5DYu+meQnpEFh4vLIUNoSSV2YDGmJOdXjrxK3aFRjOUERXyZt9envnQyOyWG4ixBx0kGgXoUmu+LPQ55FfYtDQ1sbaJBMjl07dIaTijCDthZvNcZvnuiid5Z5MImnplaHWC6D+n3C2exY4QrxqY8a7do4zl+X9qoQ8XpaefXOilnILCTXGjXODg65We3lYNNw0WxXaJCi97+118AKswphHgBk7qI3BAmi9yP3KZswDUIhtHkV4y8TrgQnK8JchHob9IIxCWySl5z8QRh1pBed4Oc9Rl4pNjCZCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FG+08jmNx+7kR0mhNAHrfo4GQCX4fVn0beSpS3ZdT3g=;
 b=WN6E5mS1crh99Gat4sSnpASzee8K4EpWExAYwXnX1YE00g9Dyaz1L+b38kK6LAc/FCuKcX4Wyump2Ondqdwg6siAnTpI/2eGN5mroSAw5inDYpIgir9Jbw9BRzIX9MAncXn7GXzGi6AXOc11rKzoiyIR/2bEAOWNX+PduLWuolELBClTPNnfpfZTc9AJfHBQ5OpwLjzCarSWWQBsp0/ECuClPAWsONxtdvp7dvWsOHA2LnFWG/nb9fF7D2xIjlKsHgZIT1rAJ1MkbNkIELNl+xW/+wMsZzUGWfK5nMRRWKJIQoz0HI3m+w56c3EKAAWiS2C6VuabNL2jaO/TqkhH2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8)
 by PH7PR11MB7497.namprd11.prod.outlook.com (2603:10b6:510:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 07:47:23 +0000
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::1b5d:f77d:a3c1:ce4c]) by SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::1b5d:f77d:a3c1:ce4c%4]) with mapi id 15.20.6652.026; Thu, 10 Aug 2023
 07:47:22 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        glider@google.com, andreyknvl@gmail.com, vbabka@suse.cz,
        zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Bail out in __stack_depot_save() if the stack_table is not allocated and delete the kmemleak_initialized judgment in set_track_prepare()
Date:   Thu, 10 Aug 2023 15:47:02 +0800
Message-Id: <20230810074704.2042664-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To SJ0PR11MB5769.namprd11.prod.outlook.com
 (2603:10b6:a03:420::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5769:EE_|PH7PR11MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 63048909-807f-4de8-d88a-08db99760828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+WR93My0nuiO+Ug6j3QbvqQbdchHy691M8o64+4tD7H4BSh7fY+f3xNT00pAHYUzTFF0tHg8UAO62i5p2qxx2OQZMdbMnDl92jS2VOb+uT+TadxRVsLWFRC77qoSxsrg/7npk/VuiVj2mImGsJyPG2/FpeAgHPv+iviIwKJADg8wdlJcOU9mXahX4w133rvoobqpJP8AhxI0b2v4K1IDcAuWuFjGrWSsmpE6P6eT8mt8u+6+rVXQ8OJ9pO9KqsEHZ8IMjf/BPnflObChs4SROWUE0bMGU7HqhNDGev6W/0AjZfs8QyANyxeqlVAsR9CXPTDZAJMhUSj+qLplAB1lAAGOTcBTBgrm9duqiD/h0URFKwq3sFqq0t0+BP2EN0I1AVLIO8KToGw/OjPfklxXDCjK3UDAxJiWTRUio4gh+2gFrh6N8EtZj5ufc6eLOQF5qIKxLiVGQUB6a57xa6RjGf9G+0rYVmDAvlztBkxkMb5JU6suuhn7xhajG0xo2M5qWN1sBML5U13PCyT8qyBPUZx/R1d67nGMWlva+Rvrzs9Ug5tj6FuRfXgshAq6iztp3+zKLPSbCHMaIw2+jVFL0xfeAQAMA5HdjQ4cYe1lcDS54CMSgC7Sf2MdTIrRxUu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39850400004)(186006)(1800799006)(451199021)(2616005)(316002)(86362001)(478600001)(6666004)(6506007)(26005)(1076003)(36756003)(5660300002)(8936002)(8676002)(44832011)(6486002)(41300700001)(6512007)(52116002)(4326008)(2906002)(38350700002)(38100700002)(83380400001)(66476007)(66556008)(66946007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CuqGlPm8ARtEEKq8x8IbzKVTjPz41NsoM1vW/HqE7s6CH3XS4bTzzwzXdQ9T?=
 =?us-ascii?Q?sOYdi8gl03jElFyHNBhLL8TRuBTxixgYQvC3kRv2gVI6OaezdDhLl5j2ANC0?=
 =?us-ascii?Q?wAfR5hAF98sr+iDM7i45AW1qSV7t3fTpTeJfFPa8x0tS16QKkch62LiwL3Qg?=
 =?us-ascii?Q?HSzeSqkAhhAGCFYfWorJ/fiBnmx/4erX+cegL8Rp+dF4WXsg2XriXS1EHmAL?=
 =?us-ascii?Q?cj/1SsnetH0fI3yFzVCd0Sba3b9tFb0lI0ara2dJwy+2TJkADhZVYhR5sibp?=
 =?us-ascii?Q?wRjfgMzNKP/iafBF3uRZ6eLLoScSRUcM4Ff/6Fdh5J2VZAaiOuMJpCzqEbQ6?=
 =?us-ascii?Q?w3DI1JH0NFbIgyjhv6k7e7in6knsuxUMaW6TtCAgDW4AFuAYRjeOgkNAps5k?=
 =?us-ascii?Q?6TDq+olT5tBIVU/Ls8O5F+BGFuzp7YThf9p98nQLCznui3RyEXL3ts7SczhU?=
 =?us-ascii?Q?9YIoVSd4Sxas2ppkp8CbJQcOp20uILkIVe8QAMHd7bU2mV+DlrzeEjlmddDI?=
 =?us-ascii?Q?QBxm64lWPFer2s8X2jCJHtdZHCoNnRDCfvpMwMKg+gkVv4GL49X1sf7CPkyE?=
 =?us-ascii?Q?uE5LnY4kBt0tEI3L6Z5AmH22vLxFtXygBhW27tyOis0Obhj3oTbFKbhFZnOd?=
 =?us-ascii?Q?xUnOepM5weU22UJ7sLOuLOpvR+hbj26PXYm3Yzf6GE2pgECHHlWBJFffJtPx?=
 =?us-ascii?Q?oBO8SHz62w17VwSeX6JAp9mmCdRWs0oYFeNHx865+6yJoiNP2Ap2jW2LeD8l?=
 =?us-ascii?Q?pOzOSRGITrFGbZEVvWZFRfFCACwyu7XeMWcEmH/GQb63FQKlz1wTGuH4XPVu?=
 =?us-ascii?Q?CPNx420uaW4smEczrLf/f4OlxNBNK8knFCdwWbbVZAvx7CRtPm3UIAylUSPD?=
 =?us-ascii?Q?ppQPGmsenme89i3jZK+UCWUS89ZXi/V5Ux2TYgsN5PutQZN9U+Bfefan2MhX?=
 =?us-ascii?Q?wUz4DI99lithMUntUMzaQcc0K0vK4oveOpDXTgMxr/74+jZGJz6Z6SfCfs60?=
 =?us-ascii?Q?dFp8gwgH+Fnt0Ce32l1E9FWHpJSOgc7OYZS80EoXXFM7k57uChCOIqdt2cBz?=
 =?us-ascii?Q?T2Ote8dxGbaaCL2kzXvh9AC/E8GZEzz9nZtkRf+TVTU6a+Uim7L5ya8BPzPb?=
 =?us-ascii?Q?jQe/U98MnketlM7m48S8FImgTSjHgiamEqxCUXUI82BBJUnu5UqmuC1xmiRE?=
 =?us-ascii?Q?Ibfu9sHMR92rmpvCTDYkikMevavFdb4/gU25yWwMU2ucRvNg3nYVYjKtERX2?=
 =?us-ascii?Q?YFcyhaBnkCZQnZZJ0lyW/cbcRN1cfUJ+jUsFH5L8hs4uttFEWKUCOVI0O81i?=
 =?us-ascii?Q?zoqS4lWlQ6ivlxyndzqntXUJr5oC1SsJPFiFtmHiYi9tJoexCaY5TBEPO6gu?=
 =?us-ascii?Q?idplSrZkgsxauFw+jOePOGeCydf+aNMYIejFtGm/BeQtFKLbya5tGtGPIav3?=
 =?us-ascii?Q?Ghg+qDGk1CAVXaRhKPfh26WC/sMn4+WjBUzJUIE6A7dbVLu5b7No+qJb+IaV?=
 =?us-ascii?Q?nYkUGBrKXW5DqIJrfxnloXjsivs/MRHwVK3vCMea2OuX1pPmDfVOKNj5jF7P?=
 =?us-ascii?Q?1GQ2NzhdgF++oQpHMBEGfnUysItDXiQ39oYYBw4IpMXr0orJlHi2Mqnna6RX?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63048909-807f-4de8-d88a-08db99760828
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 07:47:22.8564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0k8uRyPHgP2J31GV13Dqm5SgcT37nt6grPT6VT3dWCjhfj1AhM/3QH2UIkN3z9Ni8CujKy+n4flWmXX/4z+8oAoJuur6BokMqVSrtItEFCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7497
X-Proofpoint-GUID: wvgxzzWmf-7lDOQ78gV0FJ_buBeD0_35
X-Proofpoint-ORIG-GUID: wvgxzzWmf-7lDOQ78gV0FJ_buBeD0_35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_07,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=772 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308100065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch1 solves the null pointer situation when __stack_depot_save()
is called when the stack_table is not initialized.

patch2 solved there is no call trace for the memory leak which object
is created before the kmemleak_late_init()

Xiaolei Wang (2):
  lib/stackdepot: Bail out in __stack_depot_save() if the stack_table is
    not allocated
  mm/kmemleak: No need to check kmemleak_initialized in
    set_track_prepare()

 lib/stackdepot.c | 2 +-
 mm/kmemleak.c    | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.25.1

