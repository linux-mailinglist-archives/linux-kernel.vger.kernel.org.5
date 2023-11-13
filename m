Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3807E954A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjKMDBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMDBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:01:32 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCA2DD;
        Sun, 12 Nov 2023 19:01:27 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AD31La3002831;
        Mon, 13 Nov 2023 03:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=jhmT4F1FFbGRDUsQKc
        sXj87GaIKhGYLoPREAPz93kEI=; b=D8fxvcyTOCi3Sut0mJt5Hwy7jSTxUpLHEJ
        rDUtzsEHiNxEHPF9bnDQTf1raXvW1C58BAn1f+dmZejeBMNgeDJOthA/op3q7xxb
        UW/l5J0MgJjn1MaDNRHUMyeYrgjEvRh4qAsQDmMWQrPxgzrVgI5uH+NCFU0urI9X
        OIuiY/5ufWWH9qOBiEEvHCKClVWHPreKswcGpRjFHInnUNTRicazsOuGpVaKoCDV
        n+a3Ld9WbcdBUtwwYQ2ac8zNHmlGAWlhtyU05MC+/xCjdWnQGbGbo//j8RYGDuig
        HLBawGkMrV51WeMNTzOL7Av0wzzKsDDhJ55Yv4XodsQsHGpgj3qA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u9xtx9a6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 03:01:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL5krOImf3NN4xBO08tkpyCD1c0cMbl9JtQmMSizfX+I37S4iHL23DB2eu4xA6E9kwguLyFSUxwtKQhEdFLhqe42G3MHO5QaJBAe42f/ocdobLgTR8SPcIKwE4CA81pODoDOd6/qVB5NdimNtfsIHgY8Stmnn1KGq9+ik3omyxeDIV+VVbFDuQmxMCNU2CiUrfeqv5WYpbv6WPMul2z1aqgIO5ELdFFkKmMAG8sPaEbjY2UUyGEtn7vmOI1TdHd4TAg3BJg79jZ9cEFH2Ffr4BU6DiB5gbZRuMSTw4PC5rKfXy+fBgOiBMmPHF6ca/gu7jt2chzhjslpeFFtrmDJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhmT4F1FFbGRDUsQKcsXj87GaIKhGYLoPREAPz93kEI=;
 b=I4XYhjOGO1iAkjuqVl1s5Sauz4S5Xd5X3TT3YZyEzPwuWAWC0pOENlAqqVwXNsaSksdQ7OBMj/8xNyN7f7sy0ty6o6Ylnh1W6SLnylL9FsmHLxSzc/io65J2jwwZVLBwL8dWqA/epDFeMg7nX94EAjZdkHssSmKV4/RirsqGrc2f0Zb9yRH2nV3e6jhmUKXoEORuMLW8gR+2bOKSLeG9ifJe65Mx1VLDUgN5WnKUZn/SQt97AuOZMZOytvD9Ptw3ZWh5R/56ajCnxBdAXqJP0M7BELSoeW29SK+e+KwZHkGtwEczL77CRICDqztWasHgJsHVkRicA5Kc/0MPHwcUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by SA0PR11MB4735.namprd11.prod.outlook.com (2603:10b6:806:92::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 03:01:18 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::41c:9808:690:f88f]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::41c:9808:690:f88f%5]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 03:01:17 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        stern@rowland.harvard.edu, Basavaraj.Natikar@amd.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     meng.li@windriver.com
Subject: [PATCH] usb: hcd-pci: replace usb_hcd_irq() with generic_handle_irq_safe() to avoid calltrace
Date:   Mon, 13 Nov 2023 11:00:41 +0800
Message-Id: <20231113030041.3655742-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5191:EE_|SA0PR11MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: fcda6e4c-0b5c-4bea-aa2e-08dbe3f4cdec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nl2s9+vNSsmyy4XBMGHEndS3ANLD5ifFGNgpxmYPN6vpYHvb6KJZ68Kq83kbAStrPTnOU/Fph13twPBD3NtN0hWnTxim5YFENApZxaYemfoDo780I23q4PZhQCO2oQmikaJQo9KzOZ9jH/7YpzoxxAWI7N0aRhudGaiEzKJpam/5TBI5rDcjveMvjLJ/o1WlKqLMLVhi18UtGCdnjaeTKga708Eb8rsZRzd8Pvomb+YNmYbQvRIv+W82CFCbsZpRcnQ5+sOidOB+5GzyZofY45j60AWH1P2XkuerersgcnWFb+vlYu9ksXl0gNCvvwVt3uzvFUoFJm+O02ySMOfpl+ApPkUfnI/n5kzy3gG84IsukCD1Rp+1TOZ51cZ/ULo8L7gSl9Cjg7FYHVLfH5oBQW0wd/q8xTYooZLdPMz93zatr60Gfg7sVR77qZ8xfmlRUNKr0+0tHjfjpKVCNFVehWTW3pAYnQLKe6Wynlyuc8Nz8ZMz0CrkVP3G6Txo+ZiczCwqHERdhQUkZD/dXEGrf0FGloc/U2+yq6Y+rpIEyoou1vCg6GZR5UftgdQTLRGc9YHGGEaP6oOh2mzW5Dz9BPWkAl/cspGkGyvEw8t9NZPbeMITauEFKorDlEZ/e7fZtnS1iXMsSs7gzwrqKTa1qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39850400004)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(107886003)(2906002)(38350700005)(1076003)(2616005)(5660300002)(86362001)(41300700001)(26005)(66556008)(66946007)(66476007)(6512007)(316002)(83380400001)(38100700002)(6666004)(478600001)(6486002)(36756003)(52116002)(6506007)(8676002)(4326008)(8936002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n3bBLh42kdDpw85YwLgxvFHra37JhiBdM+d+z3LSY0Yf0BzH3piAZVHdhj2Z?=
 =?us-ascii?Q?VUk18KOvYSUbuHNMkyAym4rUxBAfeCJUx8K+1zpQJzAj6YvnumHTOOsZx/+3?=
 =?us-ascii?Q?4BaGwHbWpK8oyANn6wNswyOdUTMTf2Y77HSlx4SSvq90iwvI2SRxit3URBmA?=
 =?us-ascii?Q?hGgoye+9KFM1inUZN7qvNanwRsdX7RqurAUPERzPzCn+CITksH2tf+VzqawY?=
 =?us-ascii?Q?UHXyAVwPdKRCQE/1xYCqM3EAn/aXug8F2WzR+Ujs909NeQxxddMr4xNFkinf?=
 =?us-ascii?Q?Q+3WP8brvzGMkrKtumx4+eHFXkDZ3rrNblNSbpWGvLoZ86Fa1/TW7DEkMIdY?=
 =?us-ascii?Q?HhQ6sM0M2+tzvb3BXDRZwFSx1AWS60pKeVsIbknOxaYSENc4toI6DCaaq+61?=
 =?us-ascii?Q?9/D8tEqnnf15JyDshzq7jbB3LxXNLHS0CM1I90Hb+cir56GsGFUY1U2t6aS9?=
 =?us-ascii?Q?SKgr13+guhpKP5qbb8i7zSlSdRUMJULscbc4FpzrOv+KbVelUHPRB2mBm6vt?=
 =?us-ascii?Q?Ueexl4LWnvylP0Gf8XAY0+9PifxoEnXpRJPdjZYMRPvHr7/r1jX1lgk0ftGF?=
 =?us-ascii?Q?UM2nc1CKyeik/rLM+Mmgu788ieJmL/BM2hugm/48CcqqJDcfFS48l3PxPJKM?=
 =?us-ascii?Q?rCuOlD88Q9fA4tLV6663v7iSiCUbRspWTZZXx3L4XqdHFWkrBQm09oynr99m?=
 =?us-ascii?Q?wPeNFgIxmbDibXLpq+70lxDLA6WpBHDgPyM77nFAOHhxJ7+Fdh0ra0xVYw1/?=
 =?us-ascii?Q?qqknFeg+R5PXyuPn95lt9IDZWPgAMnzQPMAYwFpurpSRxuju9nzVtMPyaHav?=
 =?us-ascii?Q?GRrcEqW5qyGQPHkgHxTIJNu9TDtT7QwjK3EuXBC3iV24KOfUU3eljAEUUuQk?=
 =?us-ascii?Q?yUnagfQjFFVqvZxT+MvD4Ij9/Pgq8Dx78HNIFbxXVHJilosE6Sq3dSe9Pw4T?=
 =?us-ascii?Q?LoqdEG0MdTzpVXiKW0EMn4YKrilND2q2VrHeXMsPz8jte2PcUAmk8iF1rHi8?=
 =?us-ascii?Q?ZiWowW2Er5wDXAZ2LfwZLrh05O/p1xxKFJlYsQWUga93b0fN2ixtVKKEsE6U?=
 =?us-ascii?Q?4HHABRd6L1ax9dR2/Ra3kRT0VoChHHj0TFaHMHybWCX/elg6dpHGncNwfFoZ?=
 =?us-ascii?Q?3Iol0BnHZlunPZ4fkNFL1jTMSHk033juDLOdI/DLBbvZYrnwtoFhRIcpT3La?=
 =?us-ascii?Q?8svnQUL2CLmMiCeNzn7q8Ue34xve7Sank2jnfcKg50GezsPMwsZ8K/aen3UG?=
 =?us-ascii?Q?vcMDo9v97TOQb9EXUZoJbPd5SfNnmbc9/4Rbdd1IvIgTZj2441vPnPzxPXwv?=
 =?us-ascii?Q?5HXRB97LtLrK1wCs2qwTkYPhyqiFFQTEJoO38mFRLCCbaT5UPn+3Z2yCdbQ2?=
 =?us-ascii?Q?GBP7djAL6gAZY2gJwTYHJLNjWjnrOJuTjw4tfqVhPOWeYLbYuBGqc8Tf0c3c?=
 =?us-ascii?Q?08OyJa9zqJxGZBxV772OrSITVQzuiKTrsAlo9xDjOaCTqgvdqjrBpj327YiF?=
 =?us-ascii?Q?M82r4mzBculbq5OKUDGFoAqyUxmmii41YU1dU3icnH5z1X8goZ2ubxCBqY9p?=
 =?us-ascii?Q?Z5auAEpZEAeuokbDCJ5Jo131jAD1eZjlvuQOdIup?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcda6e4c-0b5c-4bea-aa2e-08dbe3f4cdec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 03:01:17.4342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSFHKTsBlJ7Q3a4/JWQnKjHfN6vz9PR5t3pX8AyI2XYwOyDrsFztYLmJLahoD89zS6i656Kde/MmFun8oXIs2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4735
X-Proofpoint-ORIG-GUID: WRZ_MXy9ls0fmJH0oK5Z8bq2XVzT-GPQ
X-Proofpoint-GUID: WRZ_MXy9ls0fmJH0oK5Z8bq2XVzT-GPQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_24,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=369 bulkscore=0 mlxscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311060001
 definitions=main-2311130025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running below to command to remove a PCIe-USB device,
there is below caltrace reported in RT kernel.
Call trace:
 ......
 __might_resched+0x160/0x1c0
 rt_spin_lock+0x38/0xb0
 xhci_irq+0x44/0x16d0
 usb_hcd_irq+0x38/0x5c
 usb_hcd_pci_remove+0x84/0x14c
 xhci_pci_remove+0x78/0xc0
 pci_device_remove+0x44/0xcc
 device_remove+0x54/0x8c
 device_release_driver_internal+0x1ec/0x260
 device_release_driver+0x20/0x30
 pci_stop_bus_device+0x8c/0xcc
 pci_stop_and_remove_bus_device_locked+0x28/0x44
 ......
 el0t_64_sync_handler+0xf4/0x120
 el0t_64_sync+0x18c/0x190
This issue is introduced by commit c548795abe0d("USB: add
check to detect host controller hardware removal"). Because
in RT-kernel, spinlock that may cause sleep is invoked under irq
disabled status. Therefore, replace usb_hcd_irq() function with
generic_handle_irq_safe() to avoid calltrace

Fixes: c548795abe0d ("USB: add check to detect host controller hardware removal")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/usb/core/hcd-pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index ee3156f49533..3b5f7dccbe6a 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -325,9 +325,7 @@ void usb_hcd_pci_remove(struct pci_dev *dev)
 	 * to test whether the controller hardware has been removed (e.g.,
 	 * cardbus physical eject).
 	 */
-	local_irq_disable();
-	usb_hcd_irq(0, hcd);
-	local_irq_enable();
+	generic_handle_irq_safe(dev->irq);
 
 	/* Note: dev_set_drvdata must be called while holding the rwsem */
 	if (dev->class == CL_EHCI) {
-- 
2.34.1

