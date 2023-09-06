Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E419B7944C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244553AbjIFUyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244540AbjIFUyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:54:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA83180
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 13:54:12 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386KoIuh024753;
        Wed, 6 Sep 2023 20:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=5JaDahz6BcgeKCZmtD223ui1b4z7LkEkiLPCMhtb6Ro=;
 b=D92YtRAqKLI+N4N75MTzJPyBTD0BFyKwo4rahKEtNvZNmiVflLrfpa9QULJF+Myeddl4
 hRqlmuAcGANNofkvgFNuZOrVfyfIcnnYCjv3DSyXW983Ju/yL45SWp9uKP57p7yCx5mM
 nIHx/I4RP/wZBVJbYIz0YdYrnJ7S1oz4khl6q5oEg6gYD+uXB4QgN2U4zZHGZeNJXTqA
 Wqo/Z5WQCmKYXztKFQMuYcVwhM/vcM0Wxdh1Y8CYgLXhoky0XiKReurXyTjiV6YrhC34
 /pY+xmfWP8+9DpSb5xI6K+yxsBBCgAedxOlenBnkkItDvGTlnkDj2iTEtzOWW8/3+Oh7 KQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sy0sur0ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 20:53:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386KSpnE028166;
        Wed, 6 Sep 2023 20:53:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug6tack-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 20:53:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XliCSpNCr+lsXSvPObctWvQZ74cVB+M+dIY41iaPAzM8JJGrAb/85A2NvEITcxiiLW+leHBD7FQ/xpssQQ7fGXfgiE6ud5ch1CEAECvbCEJVf1/dBhWium4dAIdbe7YjCJD4dKNW4IOKpQgIQSI+CotPT2W2fSmatmELgMzMTKzLlHNzRkeXAzDmBywZwVVXhvJA9+GydIDTMRayY3PK0jYE6gTkZmCht6ghKsNW9xBn5awm4Rz2IIgxMbH/eiFkfu2H/2xewoun8RL3of30jf9+nJUtYaZgqY3ppRLMvFAQeQkIx23xif6C7rkrBdB2wC2p3TSX3AZJIvNQOa8lUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JaDahz6BcgeKCZmtD223ui1b4z7LkEkiLPCMhtb6Ro=;
 b=Z7N4EV8PN8WUahVyUePmvAshoFGKGC+I7rv0hz6YVNiEKvRYjefbRXmaX+yU059kCxAhcHDzRqc6vn6tOJQt1rTx1ZGfpcFHCYyVrJpU0Iqe70x9pWxHR9W2LBevWy3weRs3kg0QYn3sV4aNifWF2yVMINiXb7+rhz7ZtKC5le4CsBANCAcMGaocb1OIQpf5h/yI+OcWfBicKKuQW4h60Aqvxtw2RnJwuhlR5yuxzf7Aa+esO0MpKPFQfmaE2RXkbazyFA4x0JP4yRMZ0B/+/2AGcIqMpBt/z24Jmt9e36cjA8lUSfMKWmqdIA+mFDrGt3PoUuDhrVNiedtcH8ueyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JaDahz6BcgeKCZmtD223ui1b4z7LkEkiLPCMhtb6Ro=;
 b=nU8J9gT6E2Pn3elfosOWchV3GsRUnmZcFnE/EZazQNXMp2HAmPGFSwsBv5YyNb9x0K+UHffJnguMQsbsniI2lqwCfQbtKbEyG583SJ4lEsAzY+0CNwBUuJu4SD+vjLSeSsZtDgqMeL1y6ZlYyxwwbo1LTDPM+GaaCZHgM7BbxFM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB6571.namprd10.prod.outlook.com (2603:10b6:806:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 20:53:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 20:53:23 +0000
Date:   Wed, 6 Sep 2023 13:53:19 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 07/11] hugetlb: perform vmemmap restoration on a list
 of pages
Message-ID: <20230906205319.GB3612@monkey>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-8-mike.kravetz@oracle.com>
 <5e091211-9a32-8480-55fb-faff6a0fadef@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e091211-9a32-8480-55fb-faff6a0fadef@linux.dev>
X-ClientProxiedBy: MW4PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:303:8d::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 198f7f8c-8858-4e9e-c2c3-08dbaf1b4f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2oJGMAxmBQMIye+bDEMRbzW9wHSfL7Gd8bXKtETNtgJobExm/7VXyPIrSG9RQ+7aazWbrKbOlvnR29gw3JuJLYpk9dW1xGSOGFckyeIL55OMx+dXbq37SD+TJySeENA3mIAWP7btxLMwY3I/+YqpueY3ztVGcACgCpG0jVFUiDV+MjOkp/vhmnj33nOSJIHXSFQUilcgwfJr6yrQYC2AauiyLUQenEEX1fd1Ibyb57XCg+S7uXLI7N2IDX8Qh468ETHfBPXNiusd1KyBJ3TRvr8ERFMH+X8PEbzm7skyHwUCwKVZ2dkjuDqy+do9gZ81rjVEVx1lkQcjc3FUbcyxNW7umBpsMmgtx0mC02zoyF+SSMHJE0W1KlzkbV/B8bNKfj3A0nbR1X31qtbYbtZ46r06CH/RIl2rS81z+L+Ry8SeKok89mOdwBFv0hH+vFjXe71xFP8vYd+VUdKtOkzGhAZtKhPcNzDNfHWqRNx9dx3ohMt+qyPiD3X4uIDEPF2SjsOHcQL2UJdDCyYkKqfuC5l/lH/2NHbZ2brEs9LZe21EkTpDGjMzUIoQoTu62fa0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199024)(1800799009)(186009)(7416002)(83380400001)(38100700002)(2906002)(66946007)(9686003)(6512007)(6916009)(41300700001)(316002)(54906003)(66556008)(66476007)(86362001)(33716001)(6506007)(4326008)(6486002)(33656002)(478600001)(53546011)(6666004)(8676002)(5660300002)(8936002)(1076003)(44832011)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A+Dk+j5JrHdl43NQYQKS4TiXfZnJcMr77nboNaJx4gjMK+i02S8d8zO0qhqe?=
 =?us-ascii?Q?lyNVMl0zCbj4vTiKTz7WnScGAaidv0+qwr9MTjkGABcqijcpw0F21zqVa+uP?=
 =?us-ascii?Q?a9SR+Y+cFeyiWXBFX2M88pRsofETMzwXDwjz/ulpDJ/8WlPvl+4uNL+mV35U?=
 =?us-ascii?Q?iCsAp3/3LJbD751R/wxgOj78DI66pIwxfgXjgt2lYrEwP5Fa2sXhxrdNKLuV?=
 =?us-ascii?Q?+t3smotbKNUG8s8/HhKgbE2pBx79A/9Z+yshEWJ73mUTnNENATJsXuEb8BZJ?=
 =?us-ascii?Q?KHua9jOhX5DfxivWiy2KNtJmACoVI0AUBm95qrNAI7AA2zPv9j2HzQEE+HDH?=
 =?us-ascii?Q?D4WNkIU4d3X+Ff3aWXqXGcw9QVwzXzcRj/rgw4UEnK7KeUZ5b+A+i1vxic7Z?=
 =?us-ascii?Q?65h4Lk6po/ZGNtfod0+5jIl4Tg1HyQl1cKP//MQRw6UKZF7eSCyYg/NTgz89?=
 =?us-ascii?Q?7t8JHft9FL9THokX9xwM1KR/pVaI/ek1cqCo8FofZNp7oG6RNUG9WJRYT5KQ?=
 =?us-ascii?Q?C9LfM/UG2pvIGWl5gGnMD63/COjb3lQ1cagx9joqtIRNOp1DRqouRKaIjXC+?=
 =?us-ascii?Q?mnisgGLTHXvfEHiWceu1q1632+oSnbiT84EXhNQTUdGz81JaRudZQsmWApQF?=
 =?us-ascii?Q?pZ6ecXfdj550UPj9WVmznWa3SGLQ+GAJU6xwyc9HdiD6ocCWkpKCy8qZq+2d?=
 =?us-ascii?Q?EHJO6K7rupri7GZTr4MgSBiaRMTxKacCwZrCBzkRj0+UmACISBAyVpChaEfR?=
 =?us-ascii?Q?BHLmGpNGDAI55/oFtYWjwmYJAVKe/xgQJT8Jp4lXRzI7HR2adlV4Ite4Q+6U?=
 =?us-ascii?Q?E5kuKUbUvzDPNzsiCYcHl74Tj4P7d3xoPT9g3cWyJg44QTE70O/jugN02cf3?=
 =?us-ascii?Q?6KLOHYBXg7UDF5tqkM3IO8haiHhrAZAeAjlihhFTV7vQBaoiAFzRG9W8wiBD?=
 =?us-ascii?Q?ZrRa45LVKjSyKPFwR7BtCcFhe3XcjNvPM9EePZ6m0lbQNdjfSJSb2lgQbxUr?=
 =?us-ascii?Q?Hco2P9lBey+TFtt53eRDB9sr9i1Y0M2s72JFmkiLmNi5/RZfRQzFwieH6F9D?=
 =?us-ascii?Q?po1gh3qYpCPEvZuVVDBx9/WR/sgcNDIKuw2NzWs56Na/5+9iJXid02vgMyaY?=
 =?us-ascii?Q?ACcXDemJ8sC1fXSnY1M43g1aYx9L0RcRhqHFzYHhCvvtRse+A5ZhN9gpqEkX?=
 =?us-ascii?Q?m3ooTsH3j/Ze2+yeypogc5WOGFDWMoyIaYAHw36JkbeL6pyFB8Jiog/XPSO3?=
 =?us-ascii?Q?hwVRdglA0s9E6a6jNYEtogN/qd00msTXXjIHNO4eWaaAdBiK3ISe0C0Q0e2g?=
 =?us-ascii?Q?w+dY8dQ5RtgL3DMoErCL4FBoiUocOK76PmnotBSXgs+9OSMcoexT4J80KlDs?=
 =?us-ascii?Q?NCq+qF//UV0ieeDP2bmWL77uykfGtZAY0Osb2+QGpa9TL9NIiBNdD3nViaHn?=
 =?us-ascii?Q?wYH7TmQ9AYrHjM6PJELbsTG/iUCrRJJsdPNQwQkj33/X1JpRC7EkizWR6LR1?=
 =?us-ascii?Q?Yu87Y/Fg4oSh9Ng5CUyXer8XUTHHD/NabaV+MUxv5sgFFEi+AxdO8u4Z70Ux?=
 =?us-ascii?Q?wAF7gMxNAyW3DAuHCHzkZx6Lnys7IzQMO1YaanL5n1OBYeIZmXVJAYy4qw8s?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rkiTilETP0jwfNY/eAh/RBsiuA8Iv1RW6iYrsEdOqH3E/8Yly4HCjQMRxmQk?=
 =?us-ascii?Q?IjTZIQKO1xHu8Pw3g84OJSGC8MiQpH/uqkCDthP0snQEUbly9WpTpvTFe+hl?=
 =?us-ascii?Q?esPT5Z+RwMPBW+atifU3Wa8vlUw5tNdzn0sTDo3Zm1PfvMPN206b4UFm3WJp?=
 =?us-ascii?Q?Ycx8ulA6c/RrXrRaDtUztlmCP3z1Q91eFDs9cAYhtp7s6aoHnSsp6yy7Up+c?=
 =?us-ascii?Q?97CBr+wPUuC+PoQz65hqj7z8gPRGLMyMks8oD6xCtVtfTH/oVwZl9I/4mS+v?=
 =?us-ascii?Q?Ja7K5vlwONszrfkKLcEXGwxmqx73GOVONsRgN8WM1U2nDb2VO/0Ul1WIS0lY?=
 =?us-ascii?Q?/rcm127b89muPOjJlwbDeorxutAQSXZRELzCuJb++XSOg8nzTckWKpsIVAp3?=
 =?us-ascii?Q?Z4Kc45WjtohYT0zc5evR41asICRt9jHEaIuF0+umNS8VuhP3pNnrhrToK6Io?=
 =?us-ascii?Q?p3psEtIeebYSc6oiJbWJ889NYr97S7emNZTZqZG0/fNFr8sZLpB+oxIgS+LC?=
 =?us-ascii?Q?Gf8w1Q7XW8lyja09bD2GzYngvsgYJz6jzvyOWDE4pNaOwpyAC29UUz2WNyQj?=
 =?us-ascii?Q?QtFEF1HOBzSHSiJHSkMLPoaLYptVvU5PhFH1ztCbggiVGWFNQX9lgnpmYzrA?=
 =?us-ascii?Q?5Vu+SbXZx4F26ouMkcHQ5h83Z7QrFfLyFFFBal+t9jkd1RoFH1t+7h2PZNjJ?=
 =?us-ascii?Q?Y5U00FxmIYFSE+HW8ZbfsmeOXp9Ru05yV1QXhc+UPpbSa67dbizpzKzKawR9?=
 =?us-ascii?Q?zPWoQeFHAt4YlezV8Wc9DaOGNBttnkLIATDTne7L3j7goAm2MbHbG+ZvrZuw?=
 =?us-ascii?Q?xd5nNYBH61Y/4vdLkspFHA/PE6HlVmtP6Z1mWelys7N0NzGcFF6wqy8ECHaX?=
 =?us-ascii?Q?//oyA4sNKjCf+1dx7Qg1Vn+H3xZjDwmfqT9uPpQtB3Fod8huxCor8PwU4rIR?=
 =?us-ascii?Q?fFBpbGbMSMzAxL5WQAqTDbJuLhczsVijAFKKMxPHq+nvpf4zXHCUUgoRpp83?=
 =?us-ascii?Q?SSWXmpqopvQxV4BNwm4EcEQ90S0o+5dgVW+FrXi60nVV6+b1Q0lodlqOBbA5?=
 =?us-ascii?Q?T4/Lox/AJFjaM/9elCCRFpoZ9Vx/HqkcnAfEEPwPjmycjozSBmWxsFkSysab?=
 =?us-ascii?Q?xASPEuMc5Ajz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198f7f8c-8858-4e9e-c2c3-08dbaf1b4f0e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 20:53:23.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezTI44+pvzN9+USaOvJVVbvYCyq2zCi3HAk0aPWXFFj/j+5YOImYcLv7FhZ6qx0rFcZWDqFMCoTkA4DtEJqLbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060181
X-Proofpoint-ORIG-GUID: TJywl7h1RjSMcLh6xbg7b3elXGk3TxlA
X-Proofpoint-GUID: TJywl7h1RjSMcLh6xbg7b3elXGk3TxlA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 15:33, Muchun Song wrote:
> 
> 
> On 2023/9/6 05:44, Mike Kravetz wrote:
> > When removing hugetlb pages from the pool, we first create a list
> > of removed pages and then free those pages back to low level allocators.
> > Part of the 'freeing process' is to restore vmemmap for all base pages
> > if necessary.  Pass this list of pages to a new routine
> > hugetlb_vmemmap_restore_folios() so that vmemmap restoration can be
> > performed in bulk.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   mm/hugetlb.c         |  3 +++
> >   mm/hugetlb_vmemmap.c | 13 +++++++++++++
> >   mm/hugetlb_vmemmap.h |  5 +++++
> >   3 files changed, 21 insertions(+)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 554be94b07bd..dd2dbc256172 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1838,6 +1838,9 @@ static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> >   {
> >   	struct folio *folio, *t_folio;
> > +	/* First restore vmemmap for all pages on list. */
> > +	hugetlb_vmemmap_restore_folios(h, list);
> > +
> >   	list_for_each_entry_safe(folio, t_folio, list, lru) {
> >   		update_and_free_hugetlb_folio(h, folio, false);
> >   		cond_resched();
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index ac5577d372fe..79de984919ef 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -481,6 +481,19 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> >   	return ret;
> >   }
> > +/*
> > + * This function will attempt to resore vmemmap for a list of folios.  There
> > + * is no guarantee that restoration will be successful for all or any folios.
> > + * This is used in bulk operations, and no feedback is given to the caller.
> > + */
> > +void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
> > +{
> > +	struct folio *folio;
> > +
> > +	list_for_each_entry(folio, folio_list, lru)
> > +		(void)hugetlb_vmemmap_restore(h, &folio->page);
> 
> I am curious about the purpose of "void" here, seems it it not necessnary,
> ritgh? We cound see so many palces where we do not add the void if the
> caller
> does not care about the return value of the callee.

Yes, we can drop the (void).  Sorry about adding that.

-- 
Mike Kravetz
