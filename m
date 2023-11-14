Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0FC7EB6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjKNTAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:00:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30888F4;
        Tue, 14 Nov 2023 11:00:07 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEIxYNV009640;
        Tue, 14 Nov 2023 18:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=AcizvDlICP1DLXT5By7JB41hlvyHLoFpFMkP0Zvup9M=;
 b=IZMrglzZZk19efEtOCLSXOYtsB8KASqYBWCso9EcnDxr4NKLU9kOdA8WrDWHcJjs+BRA
 IbS56/bYUCGzEL8k9Ykav4WALTKdYiDtwYgnRmzvrLpT4sgfLGfo24bxAJT4pewAvl3V
 Ca/SaI6EwUa0lrAvC9VPYmIya4nwjpgnhF4DIMSg3IaCKByQ1I0tz26tEG7p3KnwMu/6
 A9kFCiPjucTGEuL5DhrFp1IGq8AApXQKhPI/oIVxLJBAbDnXkW7o8hdh3zZeVhStozpg
 6h5XGGbazDqow4uvEapnBxs6NZ2tZms9ZYuhCCamR2CScw1o0YsdS15/gMoiw+b4zn3m rQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2r06dpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 18:59:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEImeT6013085;
        Tue, 14 Nov 2023 18:59:56 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxpyrkke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 18:59:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWtH8bWeMs0Oarc7hvLe+En3dRAnYVphN/e1/7Hboer5yDvzJr+q5KeDSAjTPs3x0UjYjA45rJHuw6Y021qEJ25LswBM3Xy1+vmtYe5cf9Tyz3OsKPuT55NnCOY617VBtNdonMVBOjkDBZlJJBj+yzWedbZYwaiDjt8W/2KXXERK+HzUVv5BogDl6qgvLapE7/6OIExgy07eyvlGdorXmSHC7FVD7/M5H/Tsm5zGCwddsSxW3InxsXMAPQG9Z/38/g4MelCcQz9bmPxB+Y3EMfPYj83dzC+sKKZ6g5D1uRYonCNi8T89mSC6TFdV8UHQ6MzadyLcs1c1OTGgJYS1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcizvDlICP1DLXT5By7JB41hlvyHLoFpFMkP0Zvup9M=;
 b=Xc5AluOKpwNFcwa7yS0sUU8Vxm6z+RbgqxoqCqq+FJU86+JLccNrpwVj1RDsAd/YBquVaSAvGtdpxcQXU0NFBTh9iWgwEwtQpUpSGxO7AHzO82dXYzsY2087lmKgNmmudu5/sdBGx54LnaCF+LAs7CFOxuOpo0ooaL6QFvBF8Lagc2LICn1OyqlDk21/fgkt23R34JIgsJBRexV+I1Ccrreu/stBXHDYpw+xbsEnNHKtIe3PzfNH54rwXQRqW7YaPnNEkL80rJyJ/9Z3K+jGXS58BYXCpTIs+31/ohlwyWDB0lHSCjSiMNOXm7fhHJ1CXJdXk+BinX0aRm0z5Oa6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcizvDlICP1DLXT5By7JB41hlvyHLoFpFMkP0Zvup9M=;
 b=HZtUeQRJPLo10INQn3xoOgh2SGBg8SWAHXLxICb6z3gLhl7dNRzzKPWLY85YJxm7AcOYLzuyWR3Tv8+g0694fHnvmw8PSTP/ecA44STET3HoMZKOvxNXeuucxIUcmPmDrS/rT3NFezGx+ZvYbiu+LIej5w3IdXkpKokDH4iMt0c=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by CH2PR10MB4167.namprd10.prod.outlook.com (2603:10b6:610:ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 18:59:53 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::baa:8a05:4673:738]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::baa:8a05:4673:738%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 18:59:53 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-raid@vger.kernel.org, tj@kernel.org,
        gregkh@linuxfoundation.org, junxiao.bi@oracle.com
Subject: [PATCH] kernfs: support kernfs notify in memory recliam context
Date:   Tue, 14 Nov 2023 10:59:47 -0800
Message-Id: <20231114185947.42829-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0170.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::9) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|CH2PR10MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec9bf53-086c-4c7e-5888-08dbe543e279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1pv8CDiblT+NJHrMZuN6UDbuH6HxQ7vXV/bvkmiMlfo23BFziT7UiDH4paalT2UCKQHKCFSwPX94euspgaca6J2Avhf70BqeMao+xX9BfSOBkXop7C1oqHcsqh3xf2o6GeANCGbDf2nGVkR8MXRosfFavRXn117/freHXNh8kfOBTddFmA51pEYt5YvG1gpoSZbo8pmJ20Bo94vO0oIqapKcL6E9KZ/PCw/IWwGoEXgoI3IntfE6Sem1Gj3/8I5yZY7sB0lVtAY9VnqguJ4SARC6bix5yJD0BvF4q7zXgbNTxU9Q/F/36SR7os8VFnff+L5Gfqkwa30lGgT/ndeAW9k7/prWnp0gYhBySIWb75g9ei40slX5qnlf//p0OdObPJajGBAgtTHmM5p9y785nyCgm5Z5O57+FmCkIoKofIfluotvABwzOz0B9Vzmwxc4MYFtHVolNgl0V8I+ZHLS+S4feRBr89OV/EbZesElM34xSF9BLzR00pZdXpioRXw3K+kaNqRKB32XlSkQLrl4DjyuZ6dzd26njsZOduoc1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6666004)(6506007)(83380400001)(38100700002)(26005)(107886003)(1076003)(6512007)(41300700001)(2906002)(5660300002)(8936002)(4326008)(86362001)(8676002)(44832011)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(2616005)(966005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2gDItVMroAztsIQAD6b+QxEOrXqfP7oaAr/doYWdzGF62683gNaklND1FPDu?=
 =?us-ascii?Q?Pzv/rcoyQvrsbxL477h/Yuf0mToRjAFib+imYKqR406TaUpMHQyTJEFdX/9h?=
 =?us-ascii?Q?BRCWPtUOHAgGdkB2J5O80X6HNT5kOTklBUPKBc5SQT9OsUZgloPw0xyOM0gH?=
 =?us-ascii?Q?MEM7b7nlyBxk8EjmCdwpkGCB+IH1fH2a6yDt1CGJc+QIn+14Xf2EzmjmFNcR?=
 =?us-ascii?Q?yyVL4UWkgR0LQ+MKaBVJ2IDc6a4RC3Y04HiuyAjZrnCNIknAFFlNnQcbZHfY?=
 =?us-ascii?Q?3vmzVtLomiMO9k37HFd0d7hwYDljRQGvSjwJugLyUoa7dirFMTrOsEkdGAFm?=
 =?us-ascii?Q?StLDzfpmFxy0/5o2zC+ONetG5qtd3VH6YXpdQIQYgfzlDlzM3wU2c7VNbWq5?=
 =?us-ascii?Q?jXdnPDdsJgjdlNfjr23BmRaYQqNb85Xi1tBtcCj2UUlmfqT+xkXDKb4A3ELc?=
 =?us-ascii?Q?H/H8KgWS0k4gk0JTsgfnny/ShYoxHgtRp/srVo344HZaTeBRw9uG9npQN4Ed?=
 =?us-ascii?Q?8WZBNqBwvTmx1L2RLfg7aA7gHJa5K6JPkRCgyoc2s/L+JG6Nd31TotXtTChz?=
 =?us-ascii?Q?CT1MxnxRSlBW3O45446bw+0WCxhyGb3KllhNpmGZkmpc+/pTVurDFeun45NJ?=
 =?us-ascii?Q?3WXuchd2zBkUFtFjQlYEQu5FFRa9B5dkr438BYeVDvxKxSSFTrmD4ovIlnbz?=
 =?us-ascii?Q?fkIiZ3rbv55V7l2VHbp4mQZkIzBjQFZ3M20UBl00hhe6ADzetqipH+d0L0dW?=
 =?us-ascii?Q?KW/OxLNIMYjWMeoZCBmLeTrXVl8QzaafYiZErjF86XpntcYGuUFM3eGZrnWc?=
 =?us-ascii?Q?vJShQTTdmxsOWb5LA+cVuVwebqHAPcGv/vyl/WKi9B4xLbMlJmDIT5zotUmk?=
 =?us-ascii?Q?p9HBnK0W2uQjMgeRgslPAGvhXIMdhIQsSpZZ6IcELskywnG+3al4o1v9ggRs?=
 =?us-ascii?Q?MK8U1f9XgO12w/YLr1dHXc1cHxmIbwp66IzG14QHGQSMqaGW7KsnyzswRhrS?=
 =?us-ascii?Q?oTmCe2HbRYjR/U/2CSFM48dWjEC2hj1Qi8y+NtyuQCalnRlwO2OOjiVkkwks?=
 =?us-ascii?Q?p5gOAnwU7SKNCiA7kUrESlnyiUZckkw/5Dxn+Dm76kco2KqMceGAb31UnQQC?=
 =?us-ascii?Q?fQHQsGL9NQVmS65zTUCliNe9sr9DqjPPva32tmL5KvsKRkYheVyVdaBBzaTm?=
 =?us-ascii?Q?+ZPv2j+5jmd6aVzZ7EwjhlDL4TusKKbfNQeytm6cURTmYTuaKa8i0uVhWFyH?=
 =?us-ascii?Q?4J03DynqYogQZX+XFhxVLvTxugcblIuSTuRCqe3O4lYBpB404ijsKr0AJ4BA?=
 =?us-ascii?Q?aTkAIlI6/iD/xTQsy2Zwhpv2zrMhaVcgAv/3Di+KJuwxSiFfDJtTpumaThYk?=
 =?us-ascii?Q?ZctyufqD4LeUussE0eL0Oe8MWP1uka5FNxMlCxNec5wwAp+LDFycuj5biNPN?=
 =?us-ascii?Q?nObauIy/W+26VeUSRoSf7Y9OuqTCmdCKlDfpnjAyFzV5aMtsee1o1jyIHM8m?=
 =?us-ascii?Q?UKy/zdxl/x3M07c6fIhu4zBOONXNdDyG4+zGJABjwoTBOnLbIc4Rz/iq2Jkc?=
 =?us-ascii?Q?ATM+slJYHkD7NFjc3/ffZDWuAkeVT7cGvpzg8cdj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LD4+ejr6Y1rBAOV1dxRK0lCU/SGN3IsvVOd9lFCZ+kLZ6ge9DxLudxe7b6YLIvct0A8BTuTe2rOHrb6oHCWObDZsSvq/xHtdhaeSWW0YTYJF26SSzEo8rwI4DzJE7K671olyzKxip7zVfKmeJee0Zv+03IT18h2NLLLoSWk+pMSWte6A+0rWNT0NGchOWWiYUkenIdyt9EwxgwENUPZz14MtsU/BxIT+wv0InaHgz7U8mX+yRoy5JRd5Ry958A6ddPx/yFQxIleZ7W68xxAia5ge2Girs02HWiFK9EoCGzlIGxL76Q3ZqLqydX2xVWZTIrkg26RjXAqKGim5bGepSp2eK0zx2oL7XRYjhxzySp+x+1i7oBvZH4riV21Fcku8FJhx08p6sj48QryGJ/HxjYoFXGjAtGWXA1+pYFL2Qv3w9xpf2MFaexcY3znMqerAdrK2rgKXm7cBqxlve7TkT+Yq6j4D4eFJukepp6vZrBZ0r3AtPx/2Z0wbFk2sLDt3p2VdrEC4CsI3L0Q6QwYl6aIZnI/eDxgrdCaq2fe/95FPBXhvb3Uxq8FqWbSD+lfMTiSTU4oijJ5sYlNKUaN6mpHhSGR8usYGuThrRqBSORgS3K7BXw8cVmBpC/torjoncmf2SKMD6Mgu6AIrZ0uB0sFiSKCSWxAa6qPFd7nW1pf0U6gcpEBIYK95d4dg/6HHZretqggLTdeVMivfhFNGAlVMHzZbq/N/6lyYqTwDwDoHsFaPY4vEzdrjadryUciN73QtQQUMAOugU9ORfWjv2YTjHHcFPyzves2jVaM6z6nKcRw0rG37kEBFZJvURNch7LBHyBexolOy3j1IHnmcsRR4yLRjT865C/W5lGBm5CY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec9bf53-086c-4c7e-5888-08dbe543e279
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 18:59:53.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujByPkODo2DFdn+xdx1LQ4aXedneyuwAqHhtjkSOmZqAq0zSCiyktF/hUArNxxQ41Yluwhp8sZu5g0+Nc1T4Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_19,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311140144
X-Proofpoint-ORIG-GUID: hs7nn7WLL7TRUF5QXiiV-zc0tKbhM-_P
X-Proofpoint-GUID: hs7nn7WLL7TRUF5QXiiV-zc0tKbhM-_P
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernfs notify is used in write path of md (md_write_start) to wake up
userspace daemon, like "mdmon" for updating md superblock of imsm raid,
md write will wait for that update done before issuing the write, if this
write is used for memory reclaim, the system may hung due to kernel notify
can't be executed, that's because kernel notify is executed by "system_wq"
which doesn't have a rescuer thread and kworker thread may not be created
due to memory pressure, then userspace daemon can't be woke up and md write
will hung.

According Tejun, this can't be fixed by add RECLAIM to "system_wq" because
that workqueue is shared and someone else might occupy that rescuer thread,
to fix this from md side, have to replace kernfs notify with other way to
communite with userspace daemon, that will break userspace interface,
so use a separated workqueue for kernefs notify to allow it be used in
memory reclaim context.

Link: https://lore.kernel.org/all/a131af22-0a5b-4be1-b77e-8716c63e8883@oracle.com/T/
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 fs/kernfs/file.c            | 2 +-
 fs/kernfs/kernfs-internal.h | 1 +
 fs/kernfs/mount.c           | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index f0cb729e9a97..726bfd40a912 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -974,7 +974,7 @@ void kernfs_notify(struct kernfs_node *kn)
 		kernfs_get(kn);
 		kn->attr.notify_next = kernfs_notify_list;
 		kernfs_notify_list = kn;
-		schedule_work(&kernfs_notify_work);
+		queue_work(kernfs_wq, &kernfs_notify_work);
 	}
 	spin_unlock_irqrestore(&kernfs_notify_lock, flags);
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 237f2764b941..beae5d328342 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -123,6 +123,7 @@ static inline bool kernfs_dir_changed(struct kernfs_node *parent,
 
 extern const struct super_operations kernfs_sops;
 extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
+extern struct workqueue_struct *kernfs_wq;
 
 /*
  * inode.c
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 4628edde2e7e..7346ec49a621 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -24,6 +24,7 @@
 struct kmem_cache *kernfs_node_cache __ro_after_init;
 struct kmem_cache *kernfs_iattrs_cache __ro_after_init;
 struct kernfs_global_locks *kernfs_locks __ro_after_init;
+struct workqueue_struct *kernfs_wq __ro_after_init;
 
 static int kernfs_sop_show_options(struct seq_file *sf, struct dentry *dentry)
 {
@@ -432,4 +433,6 @@ void __init kernfs_init(void)
 					      0, SLAB_PANIC, NULL);
 
 	kernfs_lock_init();
+
+	kernfs_wq = alloc_workqueue("kernfs", WQ_MEM_RECLAIM, 0);
 }
-- 
2.39.3 (Apple Git-145)

