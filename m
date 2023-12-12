Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A877180F73E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377299AbjLLTxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjLLTxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:53:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FD0B7;
        Tue, 12 Dec 2023 11:53:24 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCDiwok021412;
        Tue, 12 Dec 2023 19:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=s9ZHq4yOVd2m969bRXUZGiWNOPfyPIQzd+QL1aKkjGw=;
 b=RPQoT1ysIf3WELAOKMKTM3DuW05GBiz6FzzLqYWSVeU7coj06IKhtWIfWJ3DsCCwlstH
 z+amcbXHv4fJtG/fzrC4+ww71VgWX72D1Ys7X0YX1GTCjKz/cbCkoIuTIVBlwMuu2z85
 4z7AFAJ8MqKbcOkA/FWB3sUUEsV2mE/OomXf6j3m7FDgtbL8irJA5aPg5dl7hmI184YT
 mMjXEojdyMhYiTy8I/poqnt0BkK7bAd+krZo3z71k+AS+A+6dejU6enphhSrftZhJDzi
 XjpjcqefuJFrWkGs/EeUYfjCjL5hmtuDNf3gnz9TSPqB6YJdzUuKO3ZDXm9V/3uYkgv0 hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu6hqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 19:53:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCIKkwG003177;
        Tue, 12 Dec 2023 19:53:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep74je3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 19:53:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWsqIN+rUwt6Etp1MXFDLZDvC2VjjePnH7Mt5Oju6Efq7ZKMJOlvwmYfke51grF/Qbw19QM3kJBAsSlXe9hB32MPnHFWTFZrdraIt3IaTokPmhyRBbr9+GDDKETDgZr7//ZcPYLjaJlOYD4kpbn8HFTm0QNiC7nZB4CP11NPM0WIA40Kil7uSAGIPRn745ItzoUnDwrGS3bBgIGMnkSEyhFzdZdZqA3h3fGdGiEFauvOiDAcj+0IBcfd+0L9QcPYCS1TM8JnUIXFnZnOHvxo3/y7hSFizw0QSMpICaumS0LjS/8J+YVssjWh3GXBeZrm9AQ40dJ+jHm+TjlUvALi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9ZHq4yOVd2m969bRXUZGiWNOPfyPIQzd+QL1aKkjGw=;
 b=D/5UPFTjgDcUAY2MSElz+rWleECYrk6G/8uBut1PDvKGKqr8DhGLSGbx/n4KSk5wVOgdSrmEKZWvs/EHS70ibvLLguo4VIRS4pal2b09TEwHtISaa0RIbIJQE43dM8MRTDvG1nOjck9qJR2d424fefgesxQ8QFIQj6GeADTxUguVruDoCg2EiiTLQ99DAyj2c56ZOx/nlroem7vR6H4N6omis47jBv4NVDUz0Q820iOgrZ7fywecDR5cc3gVxSXU5uZi6vOuBTSit6HXcEkHHyLUggIcOyCEgcpl5ySVgU2Cr4KpopmqniLKgKyDQYw0W2v4+Gxda8oddzUUtdS9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9ZHq4yOVd2m969bRXUZGiWNOPfyPIQzd+QL1aKkjGw=;
 b=Lk6UpqXxNCsIYIAiiYnWWX19P5Ad5cFiZS1dfpQAt/XL+awpUM+Q2Dtj4MXTm7YTzAK7+GKkUeGHfAwKMaR5tZEkqXPEmRhFIJ/YChNhuWNoCYWdddapxA13IVTjoOS6XtaXujnMYGKA9UbnM786pscF2qMQS+EtaJocWg4BKaI=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SN4PR10MB5573.namprd10.prod.outlook.com (2603:10b6:806:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 19:52:59 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 19:52:59 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH 6.6.y] maple_tree: do not preallocate nodes for slot stores
Date:   Tue, 12 Dec 2023 11:52:55 -0800
Message-ID: <20231212195255.219624-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:a03:167::16) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SN4PR10MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: eda2e2d2-d153-4c37-548d-08dbfb4bf12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dNzgR9+NsNwHSOwRJYo8pbN0AZQUGkDaQdkG97sj670/MDo2Dxtj2fFeF/qzMb9cbrd5pN+A8apqQMIkIGYkAfvHcpm1mxX4FjOGsW0bMyJKwFaesH7AXKMuejIca9M4aHqGgm76JjEhmnP7VT1izRVJ3utdl/VpyoPcERzKbXngWXMN14ovcgE2zwES/VdE6PCTaqm5jzuvXRANfPlfoG6axyzztabDTCJRFW5RJkLLGQUKCqK2IllmCMoI5OgWmrLrgSA4tN9OLCgd8rOAP8xp2glRLHZzIYOY/mVzkM7RjXRzwFbbhlSOs3NLx9ufEBkJYAGXy0dz7dgy4AczYZ4lo5m0HGNHYRPlGGLnOX4hDH6QUnOu1AwVRLVXf8F+0PtGuImQZtDJcHbgY5zmmmdoZvB5n1x6BHYeaqDxTC6xKuTcy9Bz5EnMMJQ+DW9ue3sOQHRUmQMnh2uUXQaT9xjvtFnA8iqvB/2dtR+9FrEtV7dtoGpEAwjW7B56sDuCAYGXQwa1f87o/iillrcMa7if/Cp0Q98K4hAyI26P6i7nKXPItqZJltx6YyyX+kB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(38100700002)(8676002)(316002)(8936002)(86362001)(36756003)(66556008)(66476007)(66946007)(478600001)(6486002)(2906002)(6512007)(1076003)(6506007)(5660300002)(44832011)(2616005)(83380400001)(6666004)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?00UsTzZIQQ3EngItl15zFOwUR4Q/0Yqzn35FBnfo3w2uLxfd2DpS0GgJ0AA5?=
 =?us-ascii?Q?sfVDylIU41N9KZo6owpMJa/7VfCc3LfhjwSd7FYtYAITFTucNzWvCyW0RJVh?=
 =?us-ascii?Q?9Rbbs7ykpqYW1YaYrrRFXjq6BGKMQ5F/T/b50kFf43M6exGw8UqZFIBZlRHq?=
 =?us-ascii?Q?Z1i9O7ByizlYc23NtmlRZWkgv+/oV+naAD5xTwhlYvhJjYuzK7oM7lr5PXGB?=
 =?us-ascii?Q?MCgKfFZLHRqeIA7rJv2N0ji+WLwVQOrckx+mX97wXIa82r/NEJhvnsvAllRE?=
 =?us-ascii?Q?IihLr0v5RD8fKLlNtveo3CP9DMkaIrps32jljSiRbiEfOXfEA2dY12J3vgol?=
 =?us-ascii?Q?jG5799/wbXseZPliywjsvB4a2VYtBz0aesb+ihgBcMc3lsVQTDtWFTzmyOyc?=
 =?us-ascii?Q?qYqw/HjWrxiGcGmOS+VkswXMHjDH3F4U7C+9yY/0pvy+evOR7VOfoyW81iJh?=
 =?us-ascii?Q?v3JyT/aFlstGVWDUnqC4ra2+umyzf2Cb6sNnIlXEuadeoo8IyhYZeHnSrJKR?=
 =?us-ascii?Q?KcIc5hYRoQmwOnF6LqcN9Cf1mlyh/7hY7pN9ERUP9CmwNURnXupqlYhvprGo?=
 =?us-ascii?Q?jtpUsCcETd2eUR/FVLe35kVZ6yZdYYfEHRCcu7JQ7xQcPBoSBChuah7rJsb1?=
 =?us-ascii?Q?RrFeIWNRiS3Oux+6qzxbEROZGSOc2J4zNQ+KSeg1UVK4rjEtA9kpen7/1jEE?=
 =?us-ascii?Q?IHRlvQUoJ7IIby12/TgAWtzGxJK9njwINp1aApLKAk2ViwzWUSPiN+tXqOc/?=
 =?us-ascii?Q?gGCrJslCbhhZi0oDyU6bPA/gZ5HjvVhT17Ms5QQGzlG2vj/7aO2YyQ7dSnGh?=
 =?us-ascii?Q?GaqvIIlxjkGWD9aj5EYHo+F+FCxHvvBQaHzHNfFiOq3xZ8dmPlObrHBq/h2l?=
 =?us-ascii?Q?mU33AV6c0EjwNXjGm9Gq7aQtBELqCYV3DPX4TbwYa6ohkDzF1n7kwzYZGVpJ?=
 =?us-ascii?Q?Zros2SulFV4xnMX8MWwePhTK8Ns5/IKc2WJWx1eZXDllAsnMNABTyQOQW0fl?=
 =?us-ascii?Q?canXaR1SRohWC5mMs8KIrp3NUapFANqk3VGp7IBUuf1n8IPZlIsk2649Hp/6?=
 =?us-ascii?Q?6c1crcMYTFGYXF8BwE9KpaMiC4AHVbHiRnV8oaKHfJNKS+YoCeNKaBofYE1q?=
 =?us-ascii?Q?Y+cs2F3aJWzCz12BIyX6Bo2chsUmSHQ/bNzDwabO4ro1StAZWfjMxXnEnLH9?=
 =?us-ascii?Q?NTFxPI/loCSzp+RLmjjRvbYjhZmct+ea3rG+LcxM0Cjh4lWTwgey7u7f14Tb?=
 =?us-ascii?Q?61bKuL3erVJ5t6qCEh2mSiztEC2LppgIX8pZtiqAy36s7o0VUNmFc8a7vtbN?=
 =?us-ascii?Q?GGTAp9muHgYF24heLflno3GHH4siEUS+B5KaH6HAfcHbTGkQ5FPway2EDtq7?=
 =?us-ascii?Q?p1M5TmNbusGq1j8AyOb4SaVYFOdnE6kkIk3eT4dwRErcEvFszWKs5ywXgQhH?=
 =?us-ascii?Q?NjjietIcHModCHK+R2wcGlpvUHVuU95CAhfcs6gBeZnuPCbwp4CeNcAZjs1+?=
 =?us-ascii?Q?ijbkiz3kcibnaZGtMYY/rzDLp14qoYbMgQXefj86JxiWtoF7PmiRVdrZF0SR?=
 =?us-ascii?Q?xmNXlXAZBADFCmPbNj7nU+NKt8yDoM5RPhbIp9PPDIHO9fcr/nhMZ43suw6F?=
 =?us-ascii?Q?Jf8vq/HmV8eLB8ei23MM7SY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Mn1+LxWMRes82cDFu21wbi5G/og6EuwXhcqsQ+VsS/KRixj4izwWXIKFwUe0?=
 =?us-ascii?Q?AmAvP4ZEH98x6XST2ol3WHuvARooHkvqRVkWCHtru9bB3eZybomqoGdDQAMt?=
 =?us-ascii?Q?j4YXvw9X415ZOyIGCbJieMgYOZDUDQb0C5JWD9AI82tUTVXgMDl+vKmf6ZIK?=
 =?us-ascii?Q?iKCbxyCEs+zPf3LwwY5lL56KoDO3qi23ZRmRrwS+okb3F7CxixSB8GxZtjfc?=
 =?us-ascii?Q?0+i2T1sWPBImT2MDlPURc0TEWTJp27oQbt06AnOBdVr6rWilJ4NMLwjKU+jY?=
 =?us-ascii?Q?bKQcHdG1aQBD/DoJQgS4G052FpitHTJVOTkRSMjtWKnxF8kGlh+QNspJPlIg?=
 =?us-ascii?Q?PrubjOnttW+SnX+6hp1BR77WGdAjiSLiAwAxXyP8KHPHQfC9VimOew9CrSJ1?=
 =?us-ascii?Q?P4IR52WCdSAmJfVEs4ybSOQfwEoanzdkQ7BrZIMpEDrzvWFIi3BBiDkj0yOT?=
 =?us-ascii?Q?4Kudk0nkp7du2Iws30vRMExCGJ0uBdRO0DFTXS3bqwXDNW4cbnyeG/rbu/qu?=
 =?us-ascii?Q?CfgwHwTcju9BjvugWaZxL1cP+6fNKjDCeuB3fFAHYwDgW3n/1RRWvXs9ztNR?=
 =?us-ascii?Q?4TA5mR+j7x7BHF+G0yFIFTx0/8zb9LS+jS0Su0U6sEbjGEw9aMWGq1FvV3CQ?=
 =?us-ascii?Q?ppxcFlZchWzvDXLYgzvNNAYgmvIfe932J2R4RmkyYXRKmuXUcVy3dnu27zDZ?=
 =?us-ascii?Q?AQcb6byX13aGXgt8E1BqJq3nbY7fgtffJ9a1TnkKXhf4DqIJCBXa82NYy2np?=
 =?us-ascii?Q?lW7Ms4wtRbOi6d1lX+hoYsoUSxjl6Y7gXO0QSalsZ/MfoO4wnnutEF2DENPM?=
 =?us-ascii?Q?wcW11lTN+6hrG8bnhMeOSLoAzWjP0Lr4MliUC49vJZ9AA3nOX6cyM+fkgv7E?=
 =?us-ascii?Q?ALrV0n3ezL5DeWc7VKxyh4+jF+ByQ3x3NZRUPj7E4Zub0BuEPp2ipX/Tmfcl?=
 =?us-ascii?Q?7omCgPeMrxkGYJDjbjwoULLj+QwfuWw41tiuU3WDxkg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda2e2d2-d153-4c37-548d-08dbfb4bf12b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:52:59.1876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnQCDvRgQONUScxij8tpVfiz4nQ9Npo633OMNsyf54dH4HoKq0XZS5uV6oKTS3MZFalD5W+ASAcF1xJtf7TDJqoP3vl0Hz5SFi2Kv3uvsF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120152
X-Proofpoint-GUID: B-n4FTqgwzdrXyqb9EuZmVvtPGRwvSwC
X-Proofpoint-ORIG-GUID: B-n4FTqgwzdrXyqb9EuZmVvtPGRwvSwC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_preallocate() defaults to requesting 1 node for preallocation and then
,depending on the type of store, will update the request variable. There
isn't a check for a slot store type, so slot stores are preallocating the
default 1 node. Slot stores do not require any additional nodes, so add a
check for the slot store case that will bypass node_count_gfp(). Update
the tests to reflect that slot stores do not require allocations.

User visible effects of this bug include increased memory usage from the
unneeded node that was allocated.

Fixes: 0b8bb544b1a7 ("maple_tree: update mas_preallocate() testing")
Cc: <stable@vger.kernel.org> # 6.6+
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
This is a modified backport as the patch to fix this in upstream does not
apply to 6.6 because the node_end field was moved from the ma_wr_state to
the ma_state after 6.6.

 lib/maple_tree.c                 | 6 ++++++
 tools/testing/radix-tree/maple.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bb24d84a4922f..5950d0c0e0f69 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5501,6 +5501,12 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 
 	mas_wr_end_piv(&wr_mas);
 	node_size = mas_wr_new_end(&wr_mas);
+
+	/* Slot store, does not require additional nodes */
+	if ((node_size == wr_mas.node_end) && ((!mt_in_rcu(mas->tree))
+		|| (wr_mas.offset_end - mas->offset == 1)))
+		return 0;
+
 	if (node_size >= mt_slots[wr_mas.type]) {
 		/* Split, worst case for now. */
 		request = 1 + mas_mt_height(mas) * 2;
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index e5da1cad70baf..76a8990bb14e8 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35538,7 +35538,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
-	MT_BUG_ON(mt, allocated != 1);
+	MT_BUG_ON(mt, allocated != 0);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
-- 
2.42.0

