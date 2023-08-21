Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436F2783431
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjHUVAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjHUVAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:00:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619E4CC;
        Mon, 21 Aug 2023 13:59:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxqbh024095;
        Mon, 21 Aug 2023 20:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=kAumljadycvLD0oZHUogbG0TAdJF1i/XCFn3B8orV6c=;
 b=TVCpE1yKGdty/FBvS0/TXCXjqLo6ZVxXV1WnLXNPFeQpzn2TwJN5z/i9JVwp5nlDxQE/
 g2UPgpXfRe2wtmxgyh2+6TmTG4oarzd37A8tVecQJhs4X7R+ldXMUhWex+oPCEeQqRa9
 9i+3TwmYRyOOmCHOvd7/M+OX2+TKwuGrQY+paDACnPW5Si+PJKqiFIHY4agiLJ+qvlEE
 fSaGquW4z5HCDWpWuwSA6h3WP+mP7niqJqdifeEXDhHxPtQprM/G0bbD7n4vmBngITeX
 qEJZCUIg4wU/eoN9YHS6LeLKiPwQXaGSpPUreWMuuO6MyeYJwVoKyn0mhGGWCyVJM8Nh 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnma3tpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:59:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LJm2RD018677;
        Mon, 21 Aug 2023 20:59:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm64fk5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoBGmsqvKNXs3N94hliLK9G9no9Z+eW0C99S5xY49dzkMdDJMrPkjpv4trlSiTkgbqTipxlXO71bWhDbZ9WJwlKuXz+x7vBSAclgikT4Joy9wrqsz1SxlikkC043hNjl/+B7t/rZ5sNo6DOZRtKYDw02z1BbCVngABRqM56j2NfRoYFFSh2JzMVgxuflT7BixRARl76ZIgsHsFRoDco8Jsl43wvQCexqLPIp+erF5xLqVu9NVn5MTUHkPiRg4pIi8PyjLFozXrsjU34dCeAxmrEXGuESQ0dYHQqU+TK5wvmqsEPmfiO1RQTr1jqe8UK4X8mG3QPT8C8nu4wtLRb5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAumljadycvLD0oZHUogbG0TAdJF1i/XCFn3B8orV6c=;
 b=GI4wSYbHCGkdz3J46Tc7WJfRhyJtf/L1t2nHSGVlYGQtSZnW/Xs3qJWAWUqWPQmojxSK1pfsWwuaTa1wDkWaTUfLQEUlLXXnzr7xfuG6Y40Irmm2yFjANoF0BzzHl/AuNj8MXfT9bqrJ80U781a8vmpIraJe6y7/zvgtJpWSqIv9LaxR5j+TgKPbdC9+6LmBdSF+KvganIa1Da4AvoZhGgJgbMyK/9nPudLqlqFDECKdqKngDUC/qBIBp/90sXG+Hj5lKvXv32LSx1ddWo2nypzd6eNhUrxcmZ+lUalq++8gMa9NXki/YbQAEk0h/JUjZoBMrk9AUKcYYvd5tLKYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAumljadycvLD0oZHUogbG0TAdJF1i/XCFn3B8orV6c=;
 b=aDqELpuJIc1wtPF+pC8ssLew66HIsE2n0iUGkyMZBgZWZX7Jw3sVuMawk1IZQdkIfgj9CEB3irovSSqUs80IkvVjf/RJeQHz56H7NStdLn5t+vzVtTaHI2uWoUl1S5jM3/q/VVI383cXycGVx0UdiH2bftgxzlHwn3IwSM9KNS0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB5773.namprd10.prod.outlook.com (2603:10b6:303:18d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 20:59:44 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:59:44 +0000
To:     coolrrsh@gmail.com
Cc:     james.smart@broadcom.com, ram.vegesna@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        rdunlap@infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] scsi: sli4: Remove code duplication
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1msyk6rja.fsf@ca-mkp.ca.oracle.com>
References: <20230817114301.17601-1-coolrrsh@gmail.com>
Date:   Mon, 21 Aug 2023 16:59:42 -0400
In-Reply-To: <20230817114301.17601-1-coolrrsh@gmail.com> (coolrrsh@gmail.com's
        message of "Thu, 17 Aug 2023 17:13:01 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::6) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 2deade46-a2f4-4a6b-f8ef-08dba2898bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zYvvWkBsuvpvjHZk9DZihwQSoVYclvZJsNe16/B7IFq1MerinGwN2IR527c02kSCxlf4OACfhBjolrbBBD2JubrMUPTIJ37mZfOIe7fmU53qXdKQWsMF++dzDO8ExnM9cuo2BZmnQZKom+nJTG8Y+4fafiiLNesHLcDdkOhudo0Kmwyo718IJJVkBxDr2BRDJalWNRqupNTkX3bp65HmSUFJam/ambSXX4Olw+S8lYcN297fWhyoknaPc69jvrH3qkEPyROljv4Q4UBajdqW5EHoyFD8MzPcAwoxIQxIOdzd76hbgpErtGDGlDo9ngVpy7IVFds1GkB7TOzVD/wpyqgsMX3k+yjHj9hI8NtazuAMM8Q9TKW7QJuf7KS8HreQ6BFbE+Wob76Xb22Zz1yZsaiQNpbkRSz30ayaYuxadi6VkoxK1coDNowlB5bkiIiiIfjlizgVtWQSIX2ewsBcDLt03gmxFYUnRbeUjE1/hZlTkL0iXA2N8xF1EwPpg019c/cRDHJRIYQnJX0kYRlw9ddXndak/OL17ZwCr2ue2qAEsbl0P6NNq5n6WMowNbb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(4326008)(41300700001)(478600001)(38100700002)(36916002)(6506007)(6486002)(558084003)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bREXw/CuhyeUguVUNml9M9sv4NjEfIvuyYbfg0G0Ct3ax9Acg1aALrIIIZlc?=
 =?us-ascii?Q?J4vsLS19KY/etMx46lfE9+9qGjQcLAqhajeJOqKg8HB1nA4X/YbkjZui/FKQ?=
 =?us-ascii?Q?W6F92ZduF16SHKv0jC7m52w9ZZ7VXQBzhpPzElUj4FOU3VsrHlmSBLBrDaRB?=
 =?us-ascii?Q?C2racQD+b3NnNX/zejWgoRTj3Fx6gg2l0uNtxlfKIWzGESw5CQTNLEPmKJCc?=
 =?us-ascii?Q?7GCMMjaVsjLLYUw9wlpcn+IyZs2gfUpp5cUXD43yfmdAG1DvjbYCKeNBM37I?=
 =?us-ascii?Q?MSq5EZAvyz6zBCt2mtK0ONfjmsxd4rZxFdL9FV4zH/rMWmAxrGg9Xhp2MwqK?=
 =?us-ascii?Q?u8P4onNjOyy+w8mnyn6y1ZMkITbGzmG8WQFViIlSWAoOB7RwFNQunZlOsSs3?=
 =?us-ascii?Q?pe7G9AaE24I/DjKKwllZ+G3jz/GFl9klfZgQNyxuRrXi+a85s7e2IE54D2mX?=
 =?us-ascii?Q?oR+5c3n1hroZLzZYb7wmbgWToePhwIo2+LAY74qr1Q/MYOgpNlbm+BuFpTqf?=
 =?us-ascii?Q?90hAXCKBYxw4bn7+vP2ST5nHJ9QK8FxG/V5iMbkgk4YrtVgZzO5i/eaku5xV?=
 =?us-ascii?Q?lxC+h5VG9G5iu1bEtH/5285NdxY5G23+jQgY1CNBsTDIseFLh7r9Dls/zw+Z?=
 =?us-ascii?Q?Gzh64gnIHJlhYvpVm0q/YvCIGhwnkLO6bO0TejxQ8R7zjJG53slFzXEDyEqt?=
 =?us-ascii?Q?1TMWeoAW6PnXn0zC1DMxopvkiao81OATTrwbjdLQa203yy0/HMt3odMs+4km?=
 =?us-ascii?Q?orSoN7re00JpJL4byJ4sUMz8avU9/m1Wq+P7mQMv5XcBSgF3kkSZm3ggis3L?=
 =?us-ascii?Q?6bo7jQ9qlZ+/qu1COFyEUrv06dYL8u4HLlPtaOoy3xWZS0vsco1794xJQ2dR?=
 =?us-ascii?Q?dP2aWsZ8e3R0R/Ta3CHSNcbw6MQw9Nyh3jtS8F7C1OeCnEg4aUBtJak4r3rJ?=
 =?us-ascii?Q?0pf+m4A8zr6jcla3gqG0w4uAE8xVqCh35/XRrOzFmwRBVRjHLcE0PPHng4h/?=
 =?us-ascii?Q?O2GLf+lx2pSBVDVApZXN6qoBIO9dM3teNCuB+xIymmHKTLqfgUkONbJBBF0w?=
 =?us-ascii?Q?EijfmvTpG5Q19U6/mJNUHBlnyRGbHmyxeoFnEzuUFyRQO5zxcUWnSo3axGDV?=
 =?us-ascii?Q?+d4uiAcNGxF6iRwbJ9jK+qaX0bcnvEaMq7YsxzWcxJP+jtWW/TC7sk1Q5YnI?=
 =?us-ascii?Q?THcgO78sn3ktM/TeL1s/Fdn8q7tDc3H/MIyEj7QkRvXgjzCVHRKGf6JfVuyM?=
 =?us-ascii?Q?HNb3I6lsa6C1wtwH/BZIk/3FOE+/65oAamOMhPuWacajv6IITERtgohDDWdH?=
 =?us-ascii?Q?nSzXkLR9boWQB2Fzx3DoQ+ayzBP99Rr2uWpZKDBpOYjJuN5y9bNLqQxQhhJO?=
 =?us-ascii?Q?aQzS5jQdXW7v+CZDQ/LRcvud1Lglk/cazTKJU+DB2oyfRV7lE/9p2htENzuk?=
 =?us-ascii?Q?sufvaOQrVgObxG4XAiQL8SC6cNw0ipSEZot0HuXN8x6yCZqOJrHrcN+Lc8i0?=
 =?us-ascii?Q?kgQStVWF+Is14eH2oVi6TElWMVcDx50sSkgUHNbW/mrg0YtyLmlW5iTcrz4m?=
 =?us-ascii?Q?KRLjpnmB2POcuDBTU9EZt2S0OMT4Fr//O6GdHiqEzNzFLI6nKnlA2IVmwnJL?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?o0NyfkV6tbIDn7h4dxtnTmkakyusE9hkDdHU3ovVQBYn14Sq4WMmDcAquxrp?=
 =?us-ascii?Q?n3XyLHFel2YgMS5ehqp5bneOTcUUvF1IXC/of7iIAOcjLbNYWYTVAphvbV+E?=
 =?us-ascii?Q?jbTkriotw+xAvwS6AW1QxUZEIgT5DNHLV0KeuCTkziuPlC3X6Y87wvVtON9T?=
 =?us-ascii?Q?L1QBX8D+n7pdL3xOXvUy4gdIn595G/Kx4B25/+qXThn6mEivJh2IbC7r26fe?=
 =?us-ascii?Q?0/YUKCs65w5saxqhzsC/PQ5J+54IWx2k97v2apT0H6dB9xWDuMc+PJ/+PVRy?=
 =?us-ascii?Q?o2r0EuxjeeqkxLLgh2GrdFP6Bc77rRvIEGWpOiMGG+KnIaqf/qYivzxZFfaN?=
 =?us-ascii?Q?heO+BjiDLy2yGseL8TQqPQ4/heXvnF0teOToS5tcMWLnqmfVHtGX2R/grsA7?=
 =?us-ascii?Q?YZDHJuH7h+J4XQU4bM/AAyqbRfq/ZuAivPURO4UGHI9dTBrU7U2TuJvtHOnT?=
 =?us-ascii?Q?gNgSywijpXV2Yq2mUKxmyzGLXvQa9PzIw8lImkWVqIdUc/59LBezS+NNc764?=
 =?us-ascii?Q?sI/FFkKzz4ob1seRtrG214EESZ6tWZMlbmSCu2qpbhPKv+n1xuMk0irdWDoq?=
 =?us-ascii?Q?Z9GZHysHp1OFSeO83jt6RsJG7xRZR22nGNmkwLwleEEObIAzJuSfjeje2/hy?=
 =?us-ascii?Q?VofVDw2jiw3G6kPwAGPc6n+D+8wyRj0gSLuZ5AEDkeFga92TgdnqjKKsOXzh?=
 =?us-ascii?Q?qo1d+Y2Wvd3zGH8R9m7w5rJK0UiKF24uOXJB/yJdrIYvV7n9tRPmLFoMx5f8?=
 =?us-ascii?Q?myvhOmmy9nx+jxjgg3TG0A95dJCR1PVCxvFK87n30CeQQkfkIcduy79AclPU?=
 =?us-ascii?Q?4inHFSYhflIx5JJ+TuFIXil69GnqqZLWDoUnsRoe/f7z4080qLm545XbPE93?=
 =?us-ascii?Q?X5cWB4RgIU10KEaSPBn1WCbI5wBKQ36Ro16zLn8XtSY4g9CbZTDdw5bJ28vW?=
 =?us-ascii?Q?BkK6Y8GMUu1ye4oPstrZdA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deade46-a2f4-4a6b-f8ef-08dba2898bcc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:59:44.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6mVMVqUKGpRPrtb5Bt14tsz/fP6486nRJtteX8+fl6IOIvWxA1sTxulBhaYB9R2zyh6Ai+ygBFkY8gj1DzZ//TZhEqNz6k9VIs5hodJRMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=672 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210195
X-Proofpoint-ORIG-GUID: QtRzoR6li9bdjxW3lzH1YTzscrysw-Az
X-Proofpoint-GUID: QtRzoR6li9bdjxW3lzH1YTzscrysw-Az
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> In the function sli_xmit_bls_rsp64_wqe, the 'if' and 'else' conditions
> evaluates the same expression and gives same output. Also,
> params->s_id shall not be equal to U32_MAX. Therefore removing the
> unused code.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
