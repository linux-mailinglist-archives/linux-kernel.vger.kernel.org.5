Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9543277264C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjHGNoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjHGNnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:43:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5FB19B1;
        Mon,  7 Aug 2023 06:43:15 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 376Nf2rV021502;
        Mon, 7 Aug 2023 11:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=F4dc77V5rVBQRDKBgGZgkz7chpSuJu2Tof7nKTWTth8=;
 b=yd5/zm6U2OUf+ssrZhtzCA6G1oXWY2Zn6coROCJZaEFdnCiX7NiC5C5gqwZZeR70c8t3
 nqN5kOngR4EMoc6olwDvyqpEltbPb9vL2BpYGgWRSnpwEIcDOZAsc47EYteTQyFt8PYy
 PQgJvSR6TckYxrc+x411C6su0ORz2w2ykgRGgSHjDkhdAkUwgxkWgloFwIy2Q36uLtNp
 jDaxVuLhWgMhoM8Vy25Ns1p+bkfNQgapRXfmrYGW9JxdXrD2HD2r2+P84JWzyw1mckgw
 jBP1WCykU0eOb69Ho3NljB83CCtRbHnBkcgqTv9Y4UXaMWaFbJf2QtvAb0nBCYODERnR Gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9efd2hpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 11:16:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3779Y07K032731;
        Mon, 7 Aug 2023 11:16:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvadjry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 11:16:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecOTjozkKcbXd22/IX8x5zQEU5ggdqK9meD4Fx1JSytBIgG8u9hpsY6n1yz3YzpEYTo9CQg6S1zFjZHAJv3wE1Nh8pGT8ih6DVgyVyDHEsDUvgUAzBN06naIBfnUiLsPHxWNLqvVvs73HmfyhGv+u2EEjQlLUdSVMhnc3MgcD9IKJ2jDUpIT0kXadcvCuaPFrq2cvvKI9lgiuPc6HrTiTWH9Jg9nDIzHotNFr1nh0bRZk1dfFxd6laXjT8HNpCXf52LOhseZ4HRLNatQNW8QU4URMgqVZ6xXsfO9tLcME1V0dUFpvkGb2Xzb0j2KUOKl6gfGhRgVgdsJ6/rwWWSjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4dc77V5rVBQRDKBgGZgkz7chpSuJu2Tof7nKTWTth8=;
 b=lypcW0iQBtF8Ag3DCmvDmB4i2QDUeB6h1P1r6EvrOtr2gB/2G1aTE8AZWWC5ujHtJtZON57J3j3AxGec6/CxJzsf7x2EvDE+IBdcmUea4m8bjwyWMKz9dfzHbJDrA4mghAsLfFkx2eerswcDQtXEq/P/7nu/8bnw44qGnWPOYVHpgCu8lvqfTD40iA5vyL4edvKp8Jw7y+Xf/nuo/lYYPwFCKBdyVXkjWBJWlGaInDIApSskMGFieAW6oB/ccMVfCzr0W8lnZ6vFs0Icu2r9dNfSpVaVg7bXBP7utoaSXhg84FU6vhAS8k9rHon+fIRdm0LFz4mzZESGIPiRTxrYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4dc77V5rVBQRDKBgGZgkz7chpSuJu2Tof7nKTWTth8=;
 b=Lo/N3FZoUf4u9Eqnl0eGy5WpA3LwbuAgaUOmVhotPwoDNnagrbDVyTajPlJEuY/R64LT8Yu2Zu1Bk7rM1GiN/T/qpJZJoVXt8M2fWlNsI2RIkh2zrVJpWWI39Kiz8ELAWlEV3j3SKen55q5iAfgtMVLG1Jx1VHbP6//p6auLa0A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CYYPR10MB7625.namprd10.prod.outlook.com (2603:10b6:930:c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Mon, 7 Aug
 2023 11:16:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 11:16:43 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     irogers@google.com, acme@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilkka@os.amperecomputing.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] perf jevents: Raise exception for no definition of a arch std event
Date:   Mon,  7 Aug 2023 11:16:31 +0000
Message-Id: <20230807111631.3033102-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CYYPR10MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1c9e97-2d05-4df6-d163-08db9737c78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/k0RNCQwLxCOqyUo/XIivHGY4ivNvy0xrXIYHOmt4zd6g7alwSsX4evH0a2b26ny75Ho+vosEFXYdgGaHMyLQ8UJQkVKpYTAjBekdFyFqT1dShQ76DNd261nc1M0/zj8x+UM9KOPdnQEjUZInsglCf/lGq9FFuvX0cA34MnaMZzlimreTlIjvCb53DGD0NWeclfUM9BtIM/aMFfVG1AcKBnAqc03/53Gg2rmwWt1nGTptSjmJnEfD2Cwbha/RXMpZMAN3fGTt4oFx42swouokk94cKaZQ2I+jw0ygVu53LdqfXfVDK9tr/0cYFau5VI1+DoojeonrQK36PUTFhakiDQE33MgftvITr3MOi8vDtDNaFcN/DWyBTTUI/9FzQQbdsfrts7fOZwsNNKsiqg38xHovxAYbL2I2xhOubFvyoHWkQfNUsdZ2kSWbd8cN99I/mIEkjW/ZsE3vEdhLZgJa5dDxrmCCf3HqD11PWuvdM5jtD0dm1UUvI/O8M421oVh+x+aqEJzt2XsImIPcu43euRl0/HZhDzAC9AUqrikOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(186006)(1800799003)(36756003)(103116003)(86362001)(8936002)(478600001)(38100700002)(6512007)(1076003)(83380400001)(2616005)(6506007)(26005)(107886003)(6666004)(6486002)(966005)(41300700001)(66476007)(4326008)(2906002)(316002)(66946007)(8676002)(66556008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M/kPooStCUjxaYDWGaaxHf9Okkt5xlqZn4l7feAGT0iwacr5CaAURX4xKTX8?=
 =?us-ascii?Q?Bguk66EWmsWqlgMfaPk5jW3H/UbDitEr2CK5gm2iOWpJ0D7IVo7npUDKCspN?=
 =?us-ascii?Q?NO/Ol86ocoh0oyXE1AYBlWRTgQquOiY0A+YuJKyoyk7AgwIvrsmk1z9I6es4?=
 =?us-ascii?Q?q/HmVBQLri04x2d9LAXuM+kgzFTvEfL7LtBOCgAJ7CmcpJDQRpcQ7PVs/VCk?=
 =?us-ascii?Q?nQdS6F/XAwlGHAkoFJ0+331UpUo2Lr5WnViQjtp4AjxdMOQVR0lJduR9o1er?=
 =?us-ascii?Q?h8rPxVZJUYJGCEPtd4wlVA1sHBG77fZ9WYmkBAz55oE4iJNiOF1IAgq4E/tu?=
 =?us-ascii?Q?4EzMF/kQT83/gwRsFue7qmEXDWTxuBcYiHT7vhmqnc3QCZshIlThKazYy+gK?=
 =?us-ascii?Q?DlLE6w5hEQbmsqMTYqRC9I87Rs8Pc/D1lU68zD4zNX7yRNEF3LQozQR5ju/Q?=
 =?us-ascii?Q?OXGLYPPnssfJb47X3+tdmQ7Mu2MKXZ0dK02ELvrZazpOgYec5uVzcde0Ryy2?=
 =?us-ascii?Q?7Ck8U+iHHuyr0WyA4KqWwul4XoTeBguY8/3/xq3rq3bnyVRuroaLbzVWF5GO?=
 =?us-ascii?Q?019z7oG3qa8V9GW8txFse3n2Mh+ifYcrOmBE5LivNMwtmo2JxoQFgYagNiND?=
 =?us-ascii?Q?OhJxA+yGcUKSWrW55+F04NVVivEcaBsWdWVEzarYBcghhDi5e1vt/Knn/sX9?=
 =?us-ascii?Q?774ViWrbpME3lfUTcCyPZA5qmO7+4Nv5pEkI/ztKQNmwlBd5gJJn7aWnhL/w?=
 =?us-ascii?Q?4fqeb7gkfZwXVoAxun5Jdo9ii7KYcXVuA9GCrUxTyP43V5TeDwMEd1nU/TYM?=
 =?us-ascii?Q?OdhPKczA/BIqiIWwg0jE2DpuAJmGzHp8lP+aOJpp0mznElqP4i2Z0YJhy6RQ?=
 =?us-ascii?Q?tJyZqHHuYJ/yvPN7bSf6nyRyxzxgMenX4Nbt1b7hiW3ON/zLHdym96b70mH/?=
 =?us-ascii?Q?OnkMFo/oDIlLjSIi8Sz7Gkj3R8y2cyopuBH1zp3BW9y4FLIYH8BENvJQ/8lY?=
 =?us-ascii?Q?+u5RKiFlhePNUGfWk4z17Sq6NkQLEEwKpjtz4VuL6HSfKHhW7zc407XJf9KO?=
 =?us-ascii?Q?axW6NB25x4KylGvgh+2//6aFQqxMBOBrKHnCmSvroSYQXoeaSUIMI9fPSXiW?=
 =?us-ascii?Q?6be6DSbRfFol/xRT0FUGFm+PFMvITAFl7kQwhR7sztUbbHXfvyc5D2PYKKWg?=
 =?us-ascii?Q?xX0c9tYWRI625zeD6JT7u1Q2M5fXVYpuNckS7sgIrxReKiLSNH936U9+C+rW?=
 =?us-ascii?Q?wRkUqOoFr2DC+xYUvaGXbGfuW7NMLQRQUTXzMegJFHeL5mry/KO6GlVt6a6R?=
 =?us-ascii?Q?23Ve/XOebQu4aGp2f5I2/NS5yb6BXBnMY+0l4hDrGP9JmilgwS9Rnu8PfUeb?=
 =?us-ascii?Q?bD3ONwPuYJv6slyRb9jxjlerBwanyumYMrxT4bZ4iuc108XvoQ29TOTujmzo?=
 =?us-ascii?Q?N5lNHiGbMjWoSo1PWuY0r7OQzZQ14Juhl0Vl8Hib+pN+iWAW2YoFPd9tCp3e?=
 =?us-ascii?Q?qXx8q3OKEYinROjYZUgZacMEAw9Im9ynFCdf2L95zRbhw+xTJJZ9LePKvV6V?=
 =?us-ascii?Q?iCWmAlFoVhigqkE31jHQZ6gJxU3BK4VJgKT2/lKU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ELcp2NCjKUFjYS/qrQmt87V3wvdcz/dd8m4jaiZRvEPo91gvuZh6EIdiV+g9NuwbRKUo5DE+CkjQtt3lEHG1eRwt/cWsLMu9PwLdh6WOd8aO36zgMO0ZrtPBhW6joBDwvBp/4UjINYk7bARFPN7C/lR7QW7DPkcVTK1e+8sm3vD/Y+5SlvNP53Q9PQ/LFc1R9/9+yvi1S2LZlm9aGjMo34o+P6wCABy26CxbX9hMy45MoapGBmvsZBO6P9wcWSLJRVjLyfT79KGNkny1JoryTwRAFvclvGLl9uAO82/n8P7zF2bGEMf+OLTQM9IJ0zfqn3rNIF8rZSZioFolUaUUONSblH981irqYlk5QIV5eyGrIanALgHpOWF7Vpu2TGghB2QcVyajnxvhT1UuC6nRu616QuOdij8v3AiC0rWjC7AT8O4xWALSEEvcsITxU5ejOhr+I/wlS/Nt1LgBlczCxjdJh1Tg9hTrX0r1WSN0X60gM2+SJ5PRaYQuLB7V+8Kuc0RlXdiMyaxW9UfFMsrYWxlIoaeVnc2E4Z9Vstpz619v35ruKGl3wj2I/FuSx/PMWrwSqNniDmL+ZAtNrXVlmxleJLCE9FuEh6yr7PCrXx9iUvCAm484WXvwnPZoeEa2oRu65UeGk1+7EAezax+3TB9+WIZtJo+nCMuRmoy83MQKcN43GXGp2RGLhGJ+KxWMg38hY9xK4s84jZlgAPSQcz9okDYCuqq2tVtq1xb+3+TsP8qrT5n6yM2Z1nxTHcJQNmwf0PqAkfPVVNQbR8fo0aIQudH6yRuIggmQY8jtFpHRfjXxrEW0dk7ntJGtZEadYKdPeVKvPk3XJLrSRr0jIBy1TPrw7wCZruLqHfXBRtUMHjsLLuOH0IeOM6hEgDK9
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1c9e97-2d05-4df6-d163-08db9737c78a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 11:16:43.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYEMv4R9p7Kj6wPO1H0k2ngGctU7f2/VAxq5A5QXPa33zd3WscC0OHrYDD3K32pMLBDhdTWAqU0WtfwPIL1EwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_10,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070104
X-Proofpoint-GUID: h4s934UlNuoDNjBWQYfcfBj3b1MRaHa3
X-Proofpoint-ORIG-GUID: h4s934UlNuoDNjBWQYfcfBj3b1MRaHa3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently Ilkka reported that the JSONs for the AmpereOne arm64-based
platform included a dud event which referenced a non-existent arch std
event [0].

Previously in the times of jevents.c, we would raise an exception for this.

This is still invalid, even though the current code just ignores such an
event.

Re-introduce code to raise an exception for when no definition exists to
help catch as many invalid JSONs as possible.

[0] https://lore.kernel.org/linux-perf-users/9e851e2a-26c7-ba78-cb20-be4337b2916a@oracle.com/

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Please do not apply before [0], above.

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 8cd561aa606a..98cccc3fcbbd 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -347,12 +347,15 @@ class JsonEvent:
       if self.desc and not self.desc.endswith('. '):
         self.desc += '. '
       self.desc = (self.desc if self.desc else '') + ('Unit: ' + self.pmu + ' ')
-    if arch_std and arch_std.lower() in _arch_std_events:
-      event = _arch_std_events[arch_std.lower()].event
-      # Copy from the architecture standard event to self for undefined fields.
-      for attr, value in _arch_std_events[arch_std.lower()].__dict__.items():
-        if hasattr(self, attr) and not getattr(self, attr):
-          setattr(self, attr, value)
+    if arch_std:
+      if arch_std.lower() in _arch_std_events:
+        event = _arch_std_events[arch_std.lower()].event
+        # Copy from the architecture standard event to self for undefined fields.
+        for attr, value in _arch_std_events[arch_std.lower()].__dict__.items():
+          if hasattr(self, attr) and not getattr(self, attr):
+            setattr(self, attr, value)
+      else:
+        raise argparse.ArgumentTypeError('Cannot find arch std event:', arch_std)
 
     self.event = real_event(self.name, event)
 
-- 
2.35.3

