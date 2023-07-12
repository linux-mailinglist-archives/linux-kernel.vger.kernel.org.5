Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D28751061
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjGLSPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjGLSPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:15:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7EF10CB;
        Wed, 12 Jul 2023 11:15:35 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CHOLth027993;
        Wed, 12 Jul 2023 18:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=pVpQdqAw4GJnCdB9tMfC3jMkTyzPi8ZaA7hV7vyipHE=;
 b=FWsNy33BLq16PNRPYsZ5An0/gQEITv7EGdT+0t66SEZvcaWiCH/n58KFrx5FPjLYnJ72
 IxiwtTQ56UKPHCw+eoisHofn5WzxlyP1voHzBAzkSeMgzBNhHCZu5ZaM+TwR0jYsftjj
 pHTmTRnMB7uD+qvwj2OowLq1d3Wng0xu7wFf+D7EYnozxnxPvLsF8TVXbpHiLnzmHGk8
 OQtCzg0fVkaRgjx0xyAqVh2qWLxENIbO4kHuqka6N4jQLXruG4SRXY3Vi+mRQqB4aVZ1
 RbzBgBT0+c3AZ6un4ze1dcV4RCpeMjn+w1k12E6Va53RMUqmiAPKRGxIbt6k0FG7fEEf YQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrgn7wq2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 18:14:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36CIBQMO026864;
        Wed, 12 Jul 2023 18:14:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx870u60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 18:14:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cn+2cmNL2UbCnvc/FqYVTaA9eERMsFDbOXIuORgb9ofHe7Mr8ITEO49Ypxrv+Ww4X2QIYODYFZ7OHL2VGSv0cC1iV4Vuq4RyrcHUlUVVK7x/rDibxPwnQPQm/sgcltdT3AIZeFlyk/ZWC4dKX3SJx4pQ4sCKOYqDDabTzDBI78ZYB85fZPCoMwoLFd/YPUSe79GxLqZ10VCPyVwStJmTQLTk+AeHaA909ieYj0aLkU7bJGqXKr3rf0VbXDZtngtkQba6jsqyy3bPXBl2tlT0C6xvaLbKKUALs5Euur7rouM0gFSAm6kgVLt5bk871LqMtOxQQKbpkDzXY4yFCKIxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVpQdqAw4GJnCdB9tMfC3jMkTyzPi8ZaA7hV7vyipHE=;
 b=iQDELoaU31aEusg3b46ksE2O22XIV08tLe67FkAThBPg2iJOWHqOz204I9dU4ifv0+ntkaOPoyJIP7ZRX9uNvklFcxrJoZKHDN9GcE811fW8CEWWioFpBzRx4HP6ZLW31Y7SiXeinCvOGhTbfPTGjJ+g5clFqbl3fwDaKDVEnovyhoxrX9pEAZD2eLYUaFYxZE4XBIHK97D6QP49pc815aJM7+PhPb4DvwMcWVIFsUZAIwZceM74lqZSCbfkWof9XKF/fTlNE9lf8Fft6aCxSbCf4ZIPyzt+3vZATGovoPJaz1TmMBEW1FGQTqmoz8YjXtgAzt8O0GYtfQJ1uCXMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVpQdqAw4GJnCdB9tMfC3jMkTyzPi8ZaA7hV7vyipHE=;
 b=hn0qpBASBPBvJokVKhAANgf28ODgNPvMfyewJvMW6CCbcWNrK9fpmMA9AZBGnDmLOXiK6fSMWfJc+Db7sZ31Q86AmYNfAikodoj6yvieAcnYuoz3KFWTlgjcbW52PbA0WszZmZzyVfwFqzlQp5SbOM7qbX7mrWNyFf65Wkumbqg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5050.namprd10.prod.outlook.com (2603:10b6:610:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 18:14:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 18:14:49 +0000
Date:   Wed, 12 Jul 2023 11:14:45 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] hugetlb: Do not clear hugetlb dtor until allocating
 vmemmap
Message-ID: <20230712181445.GD6354@monkey>
References: <20230711220942.43706-1-mike.kravetz@oracle.com>
 <20230711220942.43706-2-mike.kravetz@oracle.com>
 <4469DCBD-59B4-41F2-A097-E5F01DD9E967@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4469DCBD-59B4-41F2-A097-E5F01DD9E967@linux.dev>
X-ClientProxiedBy: MW4P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a96c7e6-32a6-4041-bf9b-08db8303e153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5ZbT/uZQIJGsgdd+cHh/hBbc0x2jg7JB1l36BdHrhRMad0yJCAICw8fEIXZBRtqKQ51/ZfTpvodFWSQq4BykG0in/g1ZmY6VihIjPZ21E4V518OFrXBSomNZafyr/dJQRPpfsvAJAvVc8O+OyEehocorfiubfgiObbXA9vMgfnkOiK5hmj+gTjinCKqCwFkfSlbOQygBbxg3DUNNLDHqLCYgEnNd+Q+dfJGjS2uK0MiaQAZBYk31xPLKDmypYhHj0CpKeYQpoXSgTzwT2/CgS1xfze6RB+8vN+HdYBgaZv19tII/Z/3EBFi49oSgFaFMDgXdWYnt270XRhmrUoKaHH2bFE/aoOXbgIKBhV0BCbKDuVL0jMHd2FHwIYsI+1wcSSWm4pPs6HLwwOi4Qy5uFZdsn2d59vzlK+bkkTNQxrKBB1GhpMcGVkZe+QV9EEJLz9tGILb4VvB1lFa+CIfrzNqVN5BjxX4MjbbijtloKU0Kozr8lyEZDBcozPMDO5NryhHtcNKy4GirCm7qKmCag5Vy3gqxU5GjlthAAxptqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(66556008)(66946007)(66476007)(54906003)(83380400001)(478600001)(7416002)(8676002)(8936002)(33716001)(2906002)(38100700002)(86362001)(33656002)(316002)(6916009)(4326008)(41300700001)(44832011)(5660300002)(53546011)(6506007)(1076003)(186003)(26005)(966005)(9686003)(6666004)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SF3IW5oKw5BTH+g6Uwn/QlZc3rZvKp63OdTIGLUQpqyWcD5J6/A78z4IPDmz?=
 =?us-ascii?Q?Gnc+W6yvFCaGHiXbOVbx/ZlZ85XGEj+3deZDii/PAMjjpj+vfLFRltdIasDH?=
 =?us-ascii?Q?l+KmwIVCY2E3M1zyHPYXNI0ln65EQOL8gvaC601fVnVzVuL/BfC7+az/I9/K?=
 =?us-ascii?Q?rvANPMS7jMTl/qQzpoK0gTTLmHN9aiZ3jbUU/Vx7p1hdw9TuEQ+eUhOdx5p+?=
 =?us-ascii?Q?3XLQoWjTFT/0G0fMJlZ/JA0iiI47TfAviy93MAXgDAgARq9gnRf1W8UkUCSR?=
 =?us-ascii?Q?3GOh3FHWxqKvqxZqpIKNRtBDQxg4iWNEFkXDY8R3x3xPbPHpO4t1jn19JTPP?=
 =?us-ascii?Q?6Y2URhXRVyms1W3ZXS16Z9M/fdQW4osGcBrgv1dubmWMomKxs0MV2TEDdk79?=
 =?us-ascii?Q?b6jQ2U/MPha6U6JiKyTGGDK2XrItzgDtPpdHcV8yeNUn7KYjJ3NGuiz/WgpD?=
 =?us-ascii?Q?m+9Fc0Ozt2/8sEX6CYXrvvG9WYhO6YkKT/FGPM4TnrTKpWr7OnAJlMfa+y+Y?=
 =?us-ascii?Q?ptyJThWE1XahBkT+9mKq8jn4zXuTvysNhcd3xTtvrJKZROFTlGGlPhMqgFpY?=
 =?us-ascii?Q?LsN/cfPfYXfu2aD86ZcRjQdUkOrLpjYwmICUBBgTZ0lN737EN+IvQuH4qglT?=
 =?us-ascii?Q?+icRdjH7N5ZNKtPpy7m5YYQuJ+Nl9ZOxWvv0nVVYp0q0U41xHrAHrU0PGzuC?=
 =?us-ascii?Q?r/ld96yk9mMRAbAak12OmVdmSxpKk+k1WpvT/Haxah1PwCyU3p4EXSb5YMxG?=
 =?us-ascii?Q?2NhtUFarNyzd56npQ4K7c+izlOnxN3vi6BI6I5jsSYO55N1sPzqpt0NYapcI?=
 =?us-ascii?Q?Ws3nMKseUckRDDrueanobYDB6dEJuDUnXayY/4GTCxfSFZbvSBJqnYvPrWE0?=
 =?us-ascii?Q?/n/M6TL1aICJjP1vsTjq9dphArFW21/I+puktX/k47PALwKP51wRKjKa34ov?=
 =?us-ascii?Q?10Z4gZpaLwYnup7ezcpJ0350FmlD7wvpP9FpB4JXr2b5DkhG4btHPokxNfpJ?=
 =?us-ascii?Q?SOrYa2gecv6xgRiYhXSOdi98SQ1aw7aP+2TcL0SgRetBeVe+w3sf5v5LPY1a?=
 =?us-ascii?Q?ANroV8aZrFqbSEQOuru65fTKNVfz+xZFXIEyejdijtYA/uSgZfND9sroMcD4?=
 =?us-ascii?Q?SexV5Z07fA4Puq71pqzaPuAtfoC1r1bc6/uSQurJRSJPShIgSW+ATi/f9cJ1?=
 =?us-ascii?Q?B3l/dJtmn+3fqbwf656zQdn6gb4+O/CdAHfKPIRBLEiU9PxINZ3m1emgRXtr?=
 =?us-ascii?Q?gIRfFiy1HK/qTEKdSdf/tZw/KzEmgI4PKxoclNVZyZQvcbcrFDJRvwvKTGiH?=
 =?us-ascii?Q?D1IA+XhFabP5jTpG3Mg8pXpwpxKaU42Z/MZ2WBoU7VU2CLucwHeBUN+D3k9V?=
 =?us-ascii?Q?Po30BfE049HLx2po8RkSjTzmAWr4r05xTP2zjsoT1QC8rl7OvDyRVQLUno15?=
 =?us-ascii?Q?rlQkyiY64iu63zLFCn4M/Y9OYSeGjpm5yyjsgGCKzB1Leql9/RMD2sswI53j?=
 =?us-ascii?Q?NzcH90zdhdJ3oIcrR4DDJ0rNn0HrMgQe2b+ahVcHXUzskb6Jg8ZwbyE3Qeg7?=
 =?us-ascii?Q?ohd00XKbpOIFt6PUAnZiPbYbezaH6DZxkMlqpcCAhzbAxX+O7Lgy1/WoATCb?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VyzFfO9sWtv/ApMXh0ZMT8kysxMMitAD5nlGGrVIrROBYCSG5+TAdNYfm+Zk?=
 =?us-ascii?Q?1va3hJZjWNbhfeEr+wYQsMD9YxRL/4ZC3ebeMs4ESmtBac4JX919aFTjBXVd?=
 =?us-ascii?Q?vHt/SWtZ1Daghe0eUNe7VeJaOxd7zOzscaOC0mOgPCd4A0AACvy08fuInX0E?=
 =?us-ascii?Q?I1EKZ3h29C153bGBLFxSgLBZ4p9Wp15Pg+X44/1eZCt/vq2H7/p2dvh66Wrl?=
 =?us-ascii?Q?E5soI2Mu0SwUnLhoAAdXZAH/zQYs16pYPtW7hI+utZ54NoV8Bfz+aG3/RilK?=
 =?us-ascii?Q?uwpVkkvFKlR2hSRygeYdlFhGm4FZuibxUG3r1nDH0aFxwSiw5MyWayYQg+q/?=
 =?us-ascii?Q?vyAahNqXVckOdPio0awGLK0fMIuMyq9PCDeY0ssj5WUty3YLzFiq17AXZ/s5?=
 =?us-ascii?Q?lJEFSxFeavd1icbv3+H+ca58PHMWKhMb83/yaJaJnRsfVaAF2oQ/gjnlHYfd?=
 =?us-ascii?Q?gzF0C0htwjUqQI2dyQG7LTDxvy4XzV8+2FiTpXCVLLLKJVM/MfQPPB3TiAx/?=
 =?us-ascii?Q?EVpUQOrwSunmpv9d2m+v2Z627t7PMvAV7dVDrD6LoluEyAWaa83DAO+PWpqO?=
 =?us-ascii?Q?miqAPHlaMevbGJ3RAzUvztgUWsYYdmMv0p+kh5y8eRmUvMVbQUMOPaWfdpjz?=
 =?us-ascii?Q?r829VRdQxhV7EdnhijaiSClRzCvAlbSQzi/CzDhJlng9jsnKWxtLRfw7TtqB?=
 =?us-ascii?Q?2YjGGTt1E0+q3vkmuFjA61lKxk4ZTNk6youlpNsMumvDhsgbnsKhWPYYqMxh?=
 =?us-ascii?Q?f7dX65Bz9VaTkWENqiJo7uSHu62OOQqoJdi7m+mcTxM3APaP6w02gJdjtjTX?=
 =?us-ascii?Q?bc35FYeyJBVl7OT6+9HY+Kv+oDBTQ499Ck85AiBxRqeABj5KAS9qgdLkE04J?=
 =?us-ascii?Q?kWwf8SNGc0WcMCEnH7lElhIeuJl0JfjWLr3wvJaW8BrA86UeCy43CoEo34Bw?=
 =?us-ascii?Q?Ebu615r2fm5k32EZyNMhtxUSBf4LgEaV9RiLEJdO/Xk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a96c7e6-32a6-4041-bf9b-08db8303e153
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 18:14:49.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgAQXhqCPjCxE8TE85KrfrKg84zeX2vKW51hyvNeeFIJdKG+/HYuLxguuykRnoLKiZ7hUvE9uuTKOC3AMyCSIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_13,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120165
X-Proofpoint-ORIG-GUID: elJvMH6ew4_m5AbGxsquKLZouuvZQS9G
X-Proofpoint-GUID: elJvMH6ew4_m5AbGxsquKLZouuvZQS9G
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/23 16:03, Muchun Song wrote:
> 
> 
> > On Jul 12, 2023, at 06:09, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > 
> > Freeing a hugetlb page and releasing base pages back to the underlying
> > allocator such as buddy or cma is performed in two steps:
> > - remove_hugetlb_folio() is called to remove the folio from hugetlb
> >  lists, get a ref on the page and remove hugetlb destructor.  This
> >  all must be done under the hugetlb lock.  After this call, the page
> >  can be treated as a normal compound page or a collection of base
> >  size pages.
> > - update_and_free_hugetlb_folio() is called to allocate vmemmap if
> >  needed and the free routine of the underlying allocator is called
> >  on the resulting page.  We can not hold the hugetlb lock here.
> > 
> > One issue with this scheme is that a memory error could occur between
> > these two steps.  In this case, the memory error handling code treats
> > the old hugetlb page as a normal compound page or collection of base
> > pages.  It will then try to SetPageHWPoison(page) on the page with an
> > error.  If the page with error is a tail page without vmemmap, a write
> > error will occur when trying to set the flag.
> > 
> > Address this issue by modifying remove_hugetlb_folio() and
> > update_and_free_hugetlb_folio() such that the hugetlb destructor is not
> > cleared until after allocating vmemmap.  Since clearing the destructor
> > requires holding the hugetlb lock, the clearing is done in
> > remove_hugetlb_folio() if the vmemmap is present.  This saves a
> > lock/unlock cycle.  Otherwise, destructor is cleared in
> > update_and_free_hugetlb_folio() after allocating vmemmap.
> > 
> > Note that this will leave hugetlb pages in a state where they are marked
> > free (by hugetlb specific page flag) and have a ref count.  This is not
> > a normal state.  The only code that would notice is the memory error
> > code, and it is set up to retry in such a case.
> > 
> > A subsequent patch will create a routine to do bulk processing of
> > vmemmap allocation.  This will eliminate a lock/unlock cycle for each
> > hugetlb page in the case where we are freeing a large number of pages.
> > 
> > Fixes: ad2fa3717b74 ("mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Hi Mike,
> 
> I have seen an issue proposed by Jiaqi Yan in [1]. I didn't see any
> resolution for it. Am I missing something with this fix?
> 
> [1] https://lore.kernel.org/linux-mm/CACw3F53iPiLrJt4pyaX2aaZ5BVg9tj8x_k6-v7=9Xn1nrh=UCw@mail.gmail.com/
> 

My mistake!  I sent the old version of the patch.

The new version was modified to simply check the destructor via
folio_test_hugetlb() in order to decide if it should be cleared.

I will send V2.  Sorry!
-- 
Mike Kravetz
