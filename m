Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AD877506B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjHIBhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjHIBhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:37:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F11173F;
        Tue,  8 Aug 2023 18:37:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378MiCFe018036;
        Wed, 9 Aug 2023 01:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=jxWzLxKffn7izeZkC6bq4IBN+YIsT9RkqukGnwwr+HU=;
 b=pnbp2v0A+eR+2HK3JNU9FV/2MQUGGu/BYg/ch7AzPLzI9jvKFAoNbQZyjhuhiopj1Wim
 zWbhYZuXJTLFceIQYgvrbsuHiafLbNwh11ornkibTxIdvD5gmShhM4m+1uuqp7mCJJLq
 afHz1xnyktR8EG7noHIbSs0lrjnArSV+C2cvO6mHHRXRE5aHKPLpia0PbEHyZ9ZvaYrn
 NtVVUaEzyvgjqNFgkADzIr4O9sQSHPWji5Yy57mqimDIccSun34tslE4dJINHBwhUgEJ
 peVfbcYXb8Q83JXeBz0nlshz3VbQPYoFbtEeSyej8zpVNzEZ3TTli0uSsJLjC6bzYmBu pg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9e1u735h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 01:36:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3790oLPD021450;
        Wed, 9 Aug 2023 01:36:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvdbq1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 01:36:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR4Dfv3szYcMCFF/1w/YQuTyv8MXMYRU3A2SxefQCIpsrtaj251/0ZJ1DqrGuTeg2X0Fmkq4bdyCiX4kmmEYtb/l2zByDiPLIhfCP9LtbEU+eWLeRHQuy15kZy8ISatUdOX7D2jhru+xxAzmhifqzYypc4EE8lnRBye68TOtI8/jfJrO1Bx/H21/i7diB4GkqGrB+dKjWehAAeVZX7SybyH97C7XiMnVDeiFRCKacXFhKoKyDG+tTNO7x9uwuYOlCaIJYIg8K+kgeJCaYAYzf7yE/Wh+70VfDzc7INnAFzlS4gDaeS3WfzzCrZfZOczRFfXY1B8iGwjspdHrRuEjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxWzLxKffn7izeZkC6bq4IBN+YIsT9RkqukGnwwr+HU=;
 b=LVOlEcW84lDuN0+xzNAY0c8ErIFmgljNnK+6nRHLDG050nNHRDA8k6MAGv5sAqCoHtGrDjvrzaLI850/v5IbTiVgP8dzrmkQeiSs2rQf0WrOFNhqAXQpE5ktNZ+m0JNAjoGC3RiN3l4V/OHHozJRJfttPmmMhZKYc2nucOFlB30k1su18YqXHl2I9Wf7RAtkvjDOta+ElFU5ooFQrNlCYMU1wO1g4xahkbLIXLw+H9k6A4Jo89gK8ad6gi84k+PCvigZzKByIfdSMGB5UCK0n2yXLA25RL0LAuWlMmI7MCYdhiTv0j7slw8eaf271K5nE6WmAPL88uVtCAn8TPzzbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxWzLxKffn7izeZkC6bq4IBN+YIsT9RkqukGnwwr+HU=;
 b=Zuo+FqC1Pf1LoMN6l8gwIotTF2t9G3iC+YMBFgUGjWExJcJMdYLhZ18Z1mlezxFRW0OOY2h4fliADdON+rYEFzYVavZMP+jyL1mZo0v48cmtTTeW8/h2zcNWTFPJf5QNm6TLy4Lr9DgI+FeEajPZyyud2Q+Y7B/oCSNGkb1/+0A=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB6244.namprd10.prod.outlook.com (2603:10b6:208:3a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Wed, 9 Aug
 2023 01:36:43 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%6]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 01:36:43 +0000
To:     Jinyoung Choi <j-young.choi@samsung.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 0/4] multi-page bvec configuration for integrity payload
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zg31hubf.fsf@ca-mkp.ca.oracle.com>
References: <CGME20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
        <20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
Date:   Tue, 08 Aug 2023 21:36:41 -0400
In-Reply-To: <20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
        (Jinyoung Choi's message of "Thu, 03 Aug 2023 11:46:56 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0109.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 118264b3-6f65-4481-56f7-08db98791612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +glXoIZVktaZhBPSq7ELY4a8P0UEsp6QtXX4Bm9WCsHqi8whWi/MsdrlSRMgXKs0aAimsq/JADYgph+xxsppwVfK7eWSzURLO5HGoOW9FzlmR27BC0hygFUocQ+Lpa4Q0W7NCK1LpoL2wKnLx4ldkMAoX0lGUnqGGl1H0oOmbbarCNxyLKBkDI+U7ecpGpGT8iPsVh0q0QkMaJ6HE/yX0INNPKhwcOipO1ooIUDcfp/IY8tx8qIOnKCo5u6lBulhGsNwiRB4oXCEY5AoeujKnv6IR+oRJF16nBIMs+dOGCQuNFh0r1nCr1Ex/aFloIQ/zZkPeFL/7QMjMOCeZKb/89Rj0kbkNhKimWFNvdOG5TEJNoVSNKq+KPvJxlLxgPUXk9U6gW2T9WtLEgpCqzxtmRMbblCE40wCI1yGGsEPz+Ckc4ubt+ax4dh7jDVUYaGTLbgJRbF/NbMHRm6K+lBjzkAEta+5TNBM3y08nUVPuPVGucg5acKirLqmDerbReu5rFLLQmw1f8VtpWpKf/aaw+HITv7Cf48sm9PZeQ9hlLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(1800799006)(186006)(38100700002)(478600001)(6512007)(36916002)(86362001)(107886003)(26005)(6486002)(6506007)(5660300002)(66476007)(66946007)(8676002)(8936002)(4326008)(2906002)(316002)(54906003)(41300700001)(4744005)(6916009)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E4Q7kLVFOkhgtLVr414VOme635/E3Vp2HdNRQWRAQHKpIoyaC40arZCrZC+A?=
 =?us-ascii?Q?X6cDaCdcAyZ87IXu3CCxz75sQ1PJdH6t/7u5kSHo3ezvWsPsK5k5hQD9xAIO?=
 =?us-ascii?Q?tzR/ASAPd9wqzmYZ+HAWWDrczYcwDdOW0YeE/zRPnXncZFxobKSmWhvfjMgE?=
 =?us-ascii?Q?IgR7CEYw5SPX+RmxXKB9j3AKhfjaKBDgDbkZsyTmiFXoEmdyOw6ejLSQztRt?=
 =?us-ascii?Q?FpEjgrtWKY59IWQk3CzPhdUqPKRjm3FCD+8gK5baw3BIAiHiE77Ufoy5jk4T?=
 =?us-ascii?Q?rrUTBy79dBWvsp/pZmQEcL39vJY65hLHCKapwO4UG8Ybxtr6EXN5M+T9LSJj?=
 =?us-ascii?Q?Er5XJIlaR7DyPApb87vt5/NDAsEQsMC5zLGTDcqQoc3GqS3LM4UWc73a9I5X?=
 =?us-ascii?Q?MQYrZek8PqTsps3vrTSjyi/ZtT9/436Y08aR6sBulUbod/vFlfGB7hJPcSMz?=
 =?us-ascii?Q?V4TrUflB3Wy6cxjBboDyQUdrmrcTXyo1bC5STlE5MZLQY8EtmICOTBWLDZ1x?=
 =?us-ascii?Q?LndWAWkUg8m7NsV4gYv0Q+ycIxlC6WJW3U9GtpDaEPWyMrSw8KYuUnu35OsZ?=
 =?us-ascii?Q?DfMLBJbIQGhrK2NmnRYqVwlr3t7zvgrNLT364ISJyhEwFwbwLbzzHoA6E/Fo?=
 =?us-ascii?Q?zx7AI2/JrLNmfRtmvuA+KZg8IqwmGOt/lEMd1AV5IGY/Fl8T4YEVRsMMuSbl?=
 =?us-ascii?Q?YaDhisXoqtpyEewY2nZ4QxOiXPLGsfXAdPmQjrPRZO7AYMM9qISo3IXPulu9?=
 =?us-ascii?Q?WLGRX1Qp6O/fLc5yXf+nPrR/yz0WTTNiPVb0CDJlgCM+8SmyRTLCqY6QurC1?=
 =?us-ascii?Q?7tE21DzXt9IEeaJg3BDrOVzYs3PhNOYt0kM9vDimVs5B6sOQVUqAbaJ/hdBj?=
 =?us-ascii?Q?5ZypjaosrZ0JtGkbCa8dpZ7QgKJuUYzdXsm6Oic//tY8b7gbdCGVPmdRMaHI?=
 =?us-ascii?Q?1MMvrCPzaEhmpe3VZ+xpkko4oFpsJTh3kO8UU2VkVAx6z3slsltWFtBaDh9p?=
 =?us-ascii?Q?x7763Y/BaBizuyDA6B6VakVPvfLUxNiet642IeFeags0dHQ0O6GxCahAuIws?=
 =?us-ascii?Q?N5EVtCHw2Sugvf5yp9geXPUTxptRXDnRgayTMUtNxX3ri4k85ubEZgEytSci?=
 =?us-ascii?Q?hoENTVmWt7DG4tEbi31PVhz2jPK8aYfG6cSQP/fCeZ/nc8ebK1gvd9D3klg1?=
 =?us-ascii?Q?WpzHOx7arT+MEZkxS45tcI3Ncaw4nU3PREERriuCX0sxmUwUh6m0KpMhkp/U?=
 =?us-ascii?Q?wI1ibsvmggdx7nwt9YGrhqzk/EB0m3o+meze/y/8TrHY4Jy8o73oFvJcy9KH?=
 =?us-ascii?Q?jvovvNvVmoTe2NExHVpPsJkwvUz17yU3DWTeRhJuJgg+FD9ODYlOGbctskD4?=
 =?us-ascii?Q?LC4WZkY/tiA+djFdRrlQ0Y/UJDSNWjE9JxJiBTGaZSCxfB+hBLnvm5zd8MLB?=
 =?us-ascii?Q?uuBJfGkU9Ry5ybJbVIAajOzpHM4f1NC0ZWDph5YGv0N/q3k6IEKmZI/SaGy7?=
 =?us-ascii?Q?o0wj+yarq5Jtu/YYPhjLeJRJggl6dTd/lEYfqzSPhL/AfXC7EB2eSYgTOek4?=
 =?us-ascii?Q?y2JIYMjojZM6f5Fvm6233HYZGqksYyEBCpTIfe1rdJW5H2SeOxZ+XXEMItAs?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cD/hRz+uIiqj3RHhTQxIoYDNTWL8hsNm32KhTIxlx3ZNjt66SVowx009tPj5?=
 =?us-ascii?Q?vsyYdMurcr22fYVo54b8jQg//Dqtj7I9hYlSZPlyjgc7vwzG5tQsGRQbuNSp?=
 =?us-ascii?Q?bJaJROAxEHW/f33Bhu26V0XABUGkX3PN9LQCjdHk8xiZ4mQ23qeoaGiW6VvZ?=
 =?us-ascii?Q?moLiUR6vTvpiFsThutDJLRtxJfsVgp7QSTPPV0IB/ZVX0nF0X4uWlfxjjj6p?=
 =?us-ascii?Q?fKoUYQihdJgv9frJJVBGbtU3gUa7rZOB9DX0kQf6vnYd0cS6APbGADeJDosg?=
 =?us-ascii?Q?odp+xIMp3zj6NRX+0ohebcV+CiOpMGUm+W5pn0Xk3LNjcBKQMNLXCS99TuRq?=
 =?us-ascii?Q?rcX/eRhKPWbzfQTCVQksqDWp67Ahh+CT0eiEN+aYoalf9XtN6S0jIQa0H3ic?=
 =?us-ascii?Q?SATgb6aBHKeHy9EC6A/VOO6gB36pWxHaVJo+xIfZ8TXU7PC+kuNfFgHhQQRE?=
 =?us-ascii?Q?8TYWWivSbUpWfB0JTA0fzu1PS/IVecyQqd4aMBu+RqHHgLBaYsTG+eVDAHkU?=
 =?us-ascii?Q?rdueCeJzovL+7JnjDqaiIt294v9oOPU1cccUJai5fej1EWU36b4twkniyBrh?=
 =?us-ascii?Q?V0XSDJeOEk/FuclguRJHXTXKs6HbKIoy39aoMH0tuojw+Ci/zGEI+Vb9CXpI?=
 =?us-ascii?Q?QnymNYhRHciQ8FU6p70I/fMOeq7osUyamzQV4JMtztXnxv3QiXMTNUhq6k07?=
 =?us-ascii?Q?cB9i2NSryMl6kuGOn1G/xGg3CvWanyDImz7qY0Rv7gGhTJy+Q78W9Tjkxsl+?=
 =?us-ascii?Q?21z2S76QkGxDIMoaTGhWmqaDcqr7lTYLtNvZBwshiOpc55udlbwcD/82Rb0i?=
 =?us-ascii?Q?jRALQ0RECeZroJMr4JaA3t6jJaWDbiI2Tq9HMUnjbZ1I7tzSmBZ1FVYgd/Ys?=
 =?us-ascii?Q?o7KCxG/QoBB7dUw29zwhlPv0dJxDyluOKJNT+UeJ0t9tflbu19E+ddNM4JOv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118264b3-6f65-4481-56f7-08db98791612
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 01:36:43.3055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlNyVySxfGXOP38UX2UR6ZhEJ+xTxspqXHaDawmxVcGrH3HEWXhfG2hfrT3tBTBLKMaDAkR7E8f827QcFQHiRr3rjYZXkVBvphfH4Ma/jCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_24,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=986 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090012
X-Proofpoint-GUID: N9TuOfQHvLacdXMNYrRQQjGXBBXRmQpc
X-Proofpoint-ORIG-GUID: N9TuOfQHvLacdXMNYrRQQjGXBBXRmQpc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jinyoung,

> In the case of NVMe, it has an integrity payload consisting of one
> segment. So, rather than configuring SG_LIST, it was changed by direct
> DMA mapping.
>
> The page-merge is not performed for the struct bio_vec when creating a
> integrity payload in block. As a result, when creating an integrity
> paylaod beyond one page, each struct bio_vec is generated, and its
> bv_len does not exceed the PAGESIZE.
>
> To solve it, bio_integrity_add_page() should just add to the existing
> bvec, similar to bio_add_page() and friends.

This looks OK to me. I'll test on physical SCSI hardware tomorrow to
make sure there are no regressions.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
