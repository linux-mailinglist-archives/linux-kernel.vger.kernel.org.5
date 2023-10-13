Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CB27C7AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 02:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbjJMANp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 20:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjJMANn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 20:13:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B330DB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 17:12:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CLiFSB010623;
        Fri, 13 Oct 2023 00:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=YG+JnkZwxpP7ro2W7lZ48FYlVIjV+iS2uLUfUbBSMVE=;
 b=3I91YxNJZN9Mn8YOz/wbsFjrFQSW84lCP/A/r6+FoNpQsIUo30ZeOnm65KRSdkbr+SQM
 wnDbKA37nIIKy55nYCtSfWhoz1ix1nE3DJdlok8hdLFBhAiqX7991laaR/LL10Bap/tw
 8t9SVI58X0OVJ6WCXGy2P5/tLYcCSOg1uciSTIHKftmFcHkllVX0LahnlqV//kOIftSL
 qQj4e+p2YaxZnHHvCZWdRBQpu5b6XSV/lFyFHLWJEVTIvMz2PDZ/P5F/+8WS03PJbJiU
 qxiQe9WWOGXasj7gdhBu8+bYKYxztljvn6i/7kmmrLyo+AnCshXe1eogK1cDdvwHV1MY kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvuuyqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 00:12:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CMt2in039883;
        Fri, 13 Oct 2023 00:12:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tpt0t2bg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 00:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN5VWvrE1lJSCx7789pRHpKypKcHm3seApX8QEDcVHyLsoP72RWHIVIjGIXdsmpKyjlpcfYTu9OvOcYDV4VHAi4M7JYxN3gR4MLIanbNu5pTkBn4qVU5Dl1j+ipJdSe5VkEbdOUDOsnfpJG+Z1tc5EMCFDwDqrOSyD+y+15Eil/gZeSoMftgbx1JVnen88qyVgKAfr8o1Y01eLJPxXab1ZF6D1WFO5Kzo+uaEdJfFOCLcEiJPp6qDCqkOBDuJuV78b9RoKAt4iacA3eQXze1Py2JGbdT0NbIaYCdH2kqebB71fI47kwSalAPuGJRbzwN9xOmFZ3pkL+f8J1ZysQ6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YG+JnkZwxpP7ro2W7lZ48FYlVIjV+iS2uLUfUbBSMVE=;
 b=fE+Fl+oeOUlzLynYTgYVPCJnwDXu/VG7OR0NL3RMG22YYWV5eEG0dzPD5NSmHh0WhMnZUGWdI/Xp/m4eEfaZP2Nc1WJo6kRevDdXwIqJT0vbbhQaFSk56JGS7KNepwpnp6v/xja/PqEAMGMO2hG/qg0Ne/Idz0+q29BQprxqcKKHsWoD2jxIkr+0CO579QSnnf6B9FvWWLIxca8NQRmQnx2PxX+OFLcqQTo3O9beInqA+6FUKU5R0RL21X99MqrWzvDbXlWmEue025WQuUVoW/fuquBs5vjFvsiGyLNR4kEyt8uXIkimADjQA5FIZE2h0w2/Lj/VwWn+HorN/NNhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG+JnkZwxpP7ro2W7lZ48FYlVIjV+iS2uLUfUbBSMVE=;
 b=DOgfynwYK3vOXnIBSIp1V0UIzX1a9vUuousN4bNOQ03xqYTHKpGtU/mQh3+IzcyKILXXF+ziHcJYNR8+KUCbTtrfVbEvlvoEK+Gg04Yw36UZnLFj7u/97UkNNEcu+frKOHnTiLQ9pOM2tSB1Bl5R23pehYDeuRLddDieNrEVyj0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB7061.namprd10.prod.outlook.com (2603:10b6:510:284::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Fri, 13 Oct
 2023 00:12:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 00:12:06 +0000
Date:   Thu, 12 Oct 2023 17:12:03 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] mm: hugetlb: Only prep and add allocated folios for
 non-gigantic pages
Message-ID: <20231013001203.GA3812@monkey>
References: <20231009145605.2150897-1-usama.arif@bytedance.com>
 <20231010012345.GA108129@monkey>
 <20231012000327.GA1855399@dev-arch.thelio-3990X>
 <20231012145318.GA5127@monkey>
Content-Type: multipart/mixed; boundary="X0sQVLzbSgBbKSJA"
Content-Disposition: inline
In-Reply-To: <20231012145318.GA5127@monkey>
X-ClientProxiedBy: MW4PR04CA0266.namprd04.prod.outlook.com
 (2603:10b6:303:88::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: ed642024-25f2-42d4-502d-08dbcb8108da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGQmK+OfT8x5NRjmiD/fqcDO2OZjYH/8KhUWWRW+hnDgPS+80A3Um5y5inn5MMGr5at5OF74P1IrYW2kncG3ca+gnboAtaopg+6BJ7mBN7KoX4iLGbKUXEYui2VbFr/4QLm+ksakTQdNc5VNA+t3SHagqey8RE8XYCajgOaZV5bJnm4DYEsKLWGxyqWMjZCH4l6fknydkwUsw9PFBrPaubw6Qb9UzRJEyXjpUbN4AQa8009rJ+kxHdKxa5gD3oVQXGHyebVyCc7/EpoY/EobFyW/BuWWWUZcpbHktdjbtDNxg26avJHE2HKJf/4r7S98ndks28ivz4Fhyv8jLVkefIak8HYxtO5/CY2LtOPuyqVG55LzfqtcRERID7Df4JAm58QDRs/JZcDIJMDZ44PCnmXDvX/ZsOvByTZSwiF/aedwLgRt574tLbT87R1Bexs8ZN3paeBLBReFGlB3lSvW3CdxhJRDZwYlLz8csMlhdjE2+QWc1ndo+vifShIGQLVzjfgZH6at4aw4eF7n+0meC5dgHcZo+sbYL+ZN78m8eCFyNw9nQo1jrnP7ShzChklpJTjazsHmgZOFS/c78YfJ67RU2s71EVLZmTkUCLkpQta/V+/XLe6PpHkjx+KBGryp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(9686003)(6512007)(1076003)(53546011)(44144004)(478600001)(6486002)(44832011)(6506007)(83380400001)(2906002)(7416002)(41300700001)(33716001)(235185007)(66476007)(5660300002)(66946007)(54906003)(8676002)(8936002)(6916009)(66556008)(4326008)(26005)(316002)(38100700002)(86362001)(33656002)(6666004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BUKP1HAJRQ6BuP43WQRXmAuIFwf6rPFVFTT6ZVK6jSQcrTl1UDcEJq3mhBdi?=
 =?us-ascii?Q?twnBlZ3gUaxFUa9hDR9Avd5zhxhbjGjqhIh1WOCkngch85N1REj26Z7Vo9tk?=
 =?us-ascii?Q?9cDhRX4v3dWEif9thvojBc06UTokXrTR7GnGh3gpBa4qEBxO3reA0cm6THkQ?=
 =?us-ascii?Q?LgLVxJumYyljDLDxkuHyrmihqWq1FaMgBlm1HxG+xwa35dlrA0MQSUGGhXXR?=
 =?us-ascii?Q?q3YjhStRkmj82NEK7nlHPwUhEA+fglVK+6fBjoTH1AyJih8u9IRwkP/uHAJP?=
 =?us-ascii?Q?EZaRzDrwN9m7mhUs/DvFX4XsB572LLsoh2Q7AObiVWCBC+BBQfW2SeymoL3P?=
 =?us-ascii?Q?JnPnKSQNM3MEg1OO/nXoFpLCaE9u0mCXe8SMMNGy49C2gbjKB3fn8iRrLfSL?=
 =?us-ascii?Q?CBxx3KGc+RkdFkc8aTrCdw9own7GvaDHzO7QHSZRJqINblcrO6/pJmMCWNPy?=
 =?us-ascii?Q?6jKndtXsg5i7NU0hUqBepSExbz6U8EVzkfbTXj2bZ8apHDWcMPLHh1kR1hH1?=
 =?us-ascii?Q?iwImLQgSgWYONsBTdOdrzJe0c0TimMpv3njc2FTsj3uwV6YMBiXsJWa7Unkp?=
 =?us-ascii?Q?kivKNHpA/1czPKSYQOdrk4zjcsyZCyMQ2TjvzQoD9SOiNimUBOC55EMVMxz7?=
 =?us-ascii?Q?C/GkwannnhtB6A61E0fKYmRWxjAcGk5Riu577nWkulUDg40lOPh6EfMcQlW6?=
 =?us-ascii?Q?jcotN7fE0uT5cIms2NyfsacDWkK5tgQd3mxCQD1hEMGd6Pny6zXqvzGefnLL?=
 =?us-ascii?Q?0OJnuYszxnDClP2/r4vWZo5ErwbbDdDrabhuVlGjbqOa9rBAto1KESON96r7?=
 =?us-ascii?Q?TUBORIiUXVJ+uuUIqL7y5FkKwhS/PZH8YyNiCpg6wLY4Ubrimx387Enk7aHf?=
 =?us-ascii?Q?hP5ko2BgXVbdNvX4CncKKpF1Wr2yzENm0QBUy6oXGyoSrFMqtt7/WFkhMQlo?=
 =?us-ascii?Q?5NIdp9C6nwL48L/ITzxIGZIr3Rmnm233rD48QWFLnw5SABlCkjwVv+jIFu8U?=
 =?us-ascii?Q?hR0+irHWnICjTgtKYwImd3atfSJ8fJcOOfq5jFDQWkC6Jcw3Vo+Pja6ihQLZ?=
 =?us-ascii?Q?hIoESr2bPhVuyM6MqMEbfAsKh9fYRO1QP5gsSjY3oND3dMbTYneGCJTmrgUc?=
 =?us-ascii?Q?QxLL2jZkw27P6dBMETni/eJ6h1Asfz/M+ShUliC8tims3UpPNCIZrlRv7jXm?=
 =?us-ascii?Q?ruI2FF0DIoLhpNJNJQcc+iVcMFdtN0RPclKPWUiih30a2Z6dJWFiL59CMdnW?=
 =?us-ascii?Q?rvDyUvX6pHIxQAYeYv0UggShEpLalw5Xs9YUXNjQN71Rq9lHuDNvqrGdIpLq?=
 =?us-ascii?Q?Egho85JXzEoGjuRFduFg4APOmdjIhPkOF8+xY26J6qrjkd+Ow1z7IbH85ODv?=
 =?us-ascii?Q?4+zs/6uwbGScqBti0Ejox/12gMU0/ml0eXHJ19j8U83ovfieEmHOQ/IVaWz/?=
 =?us-ascii?Q?MZnmYulmE5juiVTqh6RH/QWrslNJOZSlfHcgVm67C2/DYX72PuqG9atbOCEy?=
 =?us-ascii?Q?2q+rW71DUZYAFB+gQ7ImldJeWKtyTynbS5IQaBWF6sBuRo/gkO1zsMYkBUX1?=
 =?us-ascii?Q?p1DhuVAPH4/cBsLQQBUJLcvEFNRta1vjrwDeQopd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iId6Yo9+aOxa+lFccE1J/Gg5IYlDMR9hdiqfzk7hl6LKZUTs0v1jGUfrkKzW?=
 =?us-ascii?Q?H9FuqHH0qs0ztW0lQ7VdpcjSPDKpv3CILJzk9nKJVL/0gHNMtYreD9SHNvcx?=
 =?us-ascii?Q?/OuSE1vwiBjf10Lsb/CbpK2Pf+A0KasjfMgRrHQyah2uNrHWulWw6tMONFyQ?=
 =?us-ascii?Q?px89hSUrNgf3aQVZa+fcmPckSRQiKEduRAxuvOKE0EIeKKAYHo5XoDB5Qam2?=
 =?us-ascii?Q?vjmXQeNKuRY0zw1OAWZpTswaacytUcJdqlTF73L17FmK8/WV7XGd5K/JAAlf?=
 =?us-ascii?Q?aZN+Do8c360egB8iJlsdQ1t/XKfzxtQUa8dD/SN+uPCbfLja0iAlBbT06OHR?=
 =?us-ascii?Q?DYfaWfpo27q8w1/kp5YtJRsVbBh4G4k5VIfV00h5rJ0GSTuGLaFCsujTEzlK?=
 =?us-ascii?Q?fIFkkGD2Ze6y4+3zTwvMc41xj6pTNu0hAAeuNYBuoV8u6mh5pGRqylIyNWp+?=
 =?us-ascii?Q?r7SnKgfAY0J8i/HM3AnRgX6GO+YJ8UAnuqe0SSTkj50T9z1s2PglaVkzxvbv?=
 =?us-ascii?Q?ngJ9IX/qFC1avgRJ5iatYEXMJfRXXDXVqphJFeOAuvZ//ztd9thUMWK4CjKb?=
 =?us-ascii?Q?NEeliU4P/nlFXszmC7bYJW7ALJVl6bvNKdwonBxSeM/8bIECVs661p3T64JM?=
 =?us-ascii?Q?JTaPATDWP3fUeCgGhMrrbzQFZ/A+dIKP5OLB7zUYmobu3yxr2l+rdTmx+WQp?=
 =?us-ascii?Q?Dq86SIzrmTyVn4bUiT3KNbBucUAKgFHwBMayL7zpyx2OnzmmyoO+iFZXAJgt?=
 =?us-ascii?Q?hFmnji/89fqSZjFzROozn2vHcrEQj1qB9/ID0Wmu7+Of8jFU0sKqL3JQ2rO9?=
 =?us-ascii?Q?2K1BsFnhtGMUJloDN1djkDP0a7TfTcAzQDh4huAi7AopSo3kUFqmA2iL0Cu9?=
 =?us-ascii?Q?iAjEv0upo+UouOA5NZCCE5fkNf31Td7u0jHuq4BU4d8lH7Oxn+QVZlijlN3A?=
 =?us-ascii?Q?/8SkikYHi2Bx+KM52twMbw0Bz2sFkMzqk7K43A1genwmgAl0B8OUP4lXmXAu?=
 =?us-ascii?Q?iu3c0OzdfbvEgvsooIXtPQwVLaqv6Wqk7wjI7jcQEJo36tA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed642024-25f2-42d4-502d-08dbcb8108da
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 00:12:06.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2h/cHXFieA6PMGLQFV7DfbgUfL+uLKjN/V1ll7NsdVZyZzXoMhmOFqNtRMWE9B5PY1ECMW2ptaAhTn0VY4SqcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120202
X-Proofpoint-ORIG-GUID: cCZcFcXOzNaPEown-tmvFbq3-HuzolWG
X-Proofpoint-GUID: cCZcFcXOzNaPEown-tmvFbq3-HuzolWG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--X0sQVLzbSgBbKSJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 10/12/23 07:53, Mike Kravetz wrote:
> On 10/11/23 17:03, Nathan Chancellor wrote:
> > On Mon, Oct 09, 2023 at 06:23:45PM -0700, Mike Kravetz wrote:
> > > On 10/09/23 15:56, Usama Arif wrote:
> > 
> > I suspect the crash that our continuous integration spotted [1] is the
> > same issue that Konrad is seeing, as I have bisected that failure to
> > bfb41d6b2fe1 in next-20231009. However, neither the first half of your
> > diff (since the second half does not apply at bfb41d6b2fe1) nor the
> > original patch in this thread resolves the issue though, so maybe it is
> > entirely different from Konrad's?
> > 
> > For what it's worth, this issue is only visible for me when building for
> > arm64 using LLVM with CONFIG_INIT_STACK_NONE=y, instead of the default
> > CONFIG_INIT_STACK_ALL_ZERO=y (which appears to hide the problem?),
> > making it seem like it could be something with uninitialized memory... I
> > have not been able to reproduce it with GCC, which could also mean
> > something.
> 
> Thank you Nathan!  That is very helpful.
> 
> I will use this information to try and recreate.  If I can recreate, I
> should be able to get to root cause.

I could easily recreate the issue using the provided instructions.  First
thing I did was add a few printk's to check/verify state.  The beginning
of gather_bootmem_prealloc looked like this:

static void __init gather_bootmem_prealloc(void)
{
	LIST_HEAD(folio_list);
	struct huge_bootmem_page *m;
	struct hstate *h, *prev_h = NULL;

	if (list_empty(&huge_boot_pages))
		printk("gather_bootmem_prealloc: huge_boot_pages list empty\n");

	list_for_each_entry(m, &huge_boot_pages, list) {
		struct page *page = virt_to_page(m);
		struct folio *folio = (void *)page;

		printk("gather_bootmem_prealloc: loop entry m %lx\n",
							(unsigned long)m);

The STRANGE thing is that the printk after testing for list_empty would
print, then we would enter the 'list_for_each_entry()' loop as if the list
was not empty.  This is the cause of the addressing exception.  m pointed
to the list head as opposed to an entry on the list.

I have attached disassembly of gather_bootmem_prealloc with INIT_STACK_NONE
and INIT_STACK_ALL_ZERO.  disassembly listings are for code without
printks.

This is the first time I have looked at arm assembly, so I may be missing
something.  However, in the INIT_STACK_NONE case it looks like we get the
address of huge_boot_pages into a register but do not use it to determine
if we should execute the loop.  Code generated with INIT_STACK_ALL_ZERO seems
to show code checking the list before entering the loop.

Can someone with more arm assembly experience take a quick look?  Since
huge_boot_pages is a global variable rather than on the stack, I can't
see how INIT_STACK_ALL_ZERO/INIT_STACK_NONE could make a difference.
-- 
Mike Kravetz

--X0sQVLzbSgBbKSJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=disass_INIT_STACK_NONE

Dump of assembler code for function gather_bootmem_prealloc:
mm/hugetlb.c:
3292	{
   0xffff800081ae0f08 <+0>:	d503233f	paciasp
   0xffff800081ae0f0c <+4>:	d10203ff	sub	sp, sp, #0x80
   0xffff800081ae0f10 <+8>:	a9027bfd	stp	x29, x30, [sp, #32]
   0xffff800081ae0f14 <+12>:	a9036ffc	stp	x28, x27, [sp, #48]
   0xffff800081ae0f18 <+16>:	a90467fa	stp	x26, x25, [sp, #64]
   0xffff800081ae0f1c <+20>:	a9055ff8	stp	x24, x23, [sp, #80]
   0xffff800081ae0f20 <+24>:	a90657f6	stp	x22, x21, [sp, #96]
   0xffff800081ae0f24 <+28>:	a9074ff4	stp	x20, x19, [sp, #112]
   0xffff800081ae0f28 <+32>:	910083fd	add	x29, sp, #0x20
   0xffff800081ae0f2c <+36>:	d5384108	mrs	x8, sp_el0

3294		struct huge_bootmem_page *m;
3295		struct hstate *h, *prev_h = NULL;
3296	
3297		list_for_each_entry(m, &huge_boot_pages, list) {
   0xffff800081ae0f30 <+40>:	f00007a9	adrp	x9, 0xffff800081bd7000 <new_log_buf_len>
   0xffff800081ae0f34 <+44>:	f9423d08	ldr	x8, [x8, #1144]
   0xffff800081ae0f38 <+48>:	aa1f03e0	mov	x0, xzr
   0xffff800081ae0f3c <+52>:	910023f5	add	x21, sp, #0x8
   0xffff800081ae0f40 <+56>:	d2e00036	mov	x22, #0x1000000000000       	// #281474976710656
   0xffff800081ae0f44 <+60>:	b25657f7	mov	x23, #0xfffffc0000000000    	// #-4398046511104
   0xffff800081ae0f48 <+64>:	52802018	mov	w24, #0x100                 	// #256
   0xffff800081ae0f4c <+68>:	f81f83a8	stur	x8, [x29, #-8]
   0xffff800081ae0f50 <+72>:	5280003a	mov	w26, #0x1                   	// #1
   0xffff800081ae0f54 <+76>:	f946dd39	ldr	x25, [x9, #3512]
   0xffff800081ae0f58 <+80>:	d503201f	nop
   0xffff800081ae0f5c <+84>:	107b72fb	adr	x27, 0xffff800081bd7db8 <huge_boot_pages>

3293		LIST_HEAD(folio_list);
   0xffff800081ae0f60 <+88>:	a900d7f5	stp	x21, x21, [sp, #8]

3298			struct page *page = virt_to_page(m);
3299			struct folio *folio = (void *)page;
3300	
3301			h = m->hstate;
   0xffff800081ae0f64 <+92>:	f9400b33	ldr	x19, [x25, #16]

3302			/*
3303			 * It is possible to have multiple huge page sizes (hstates)
3304			 * in this list.  If so, process each size separately.
3305			 */
3306			if (h != prev_h && prev_h != NULL)
   0xffff800081ae0f68 <+96>:	b40000a0	cbz	x0, 0xffff800081ae0f7c <gather_bootmem_prealloc+116>
   0xffff800081ae0f6c <+100>:	eb00027f	cmp	x19, x0
   0xffff800081ae0f70 <+104>:	54000060	b.eq	0xffff800081ae0f7c <gather_bootmem_prealloc+116>  // b.none

3307				prep_and_add_allocated_folios(prev_h, &folio_list);
   0xffff800081ae0f74 <+108>:	910023e1	add	x1, sp, #0x8
   0xffff800081ae0f78 <+112>:	979ecd63	bl	0xffff800080294504 <prep_and_add_allocated_folios>
   0xffff800081ae0f7c <+116>:	8b160328	add	x8, x25, x22
   0xffff800081ae0f80 <+120>:	d34cfd08	lsr	x8, x8, #12
   0xffff800081ae0f84 <+124>:	8b081af4	add	x20, x23, x8, lsl #6

./include/linux/atomic/atomic-arch-fallback.h:
444		return arch_atomic_read(v);
   0xffff800081ae0f88 <+128>:	b9403688	ldr	w8, [x20, #52]

mm/hugetlb.c:
3311			WARN_ON(folio_ref_count(folio) != 1);
   0xffff800081ae0f8c <+132>:	7100051f	cmp	w8, #0x1
   0xffff800081ae0f90 <+136>:	54000581	b.ne	0xffff800081ae1040 <gather_bootmem_prealloc+312>  // b.any

3312	
3313			hugetlb_folio_init_vmemmap(folio, h,
   0xffff800081ae0f94 <+140>:	aa1403e0	mov	x0, x20
   0xffff800081ae0f98 <+144>:	aa1303e1	mov	x1, x19
   0xffff800081ae0f9c <+148>:	940001a2	bl	0xffff800081ae1624 <hugetlb_folio_init_vmemmap>

./arch/arm64/include/asm/alternative-macros.h:
232		asm_volatile_goto(
   0xffff800081ae0fa0 <+152>:	1400002a	b	0xffff800081ae1048 <gather_bootmem_prealloc+320>

./arch/arm64/include/asm/atomic_lse.h:
132	ATOMIC64_OP(or, stset)
   0xffff800081ae0fa4 <+156>:	91010288	add	x8, x20, #0x40
   0xffff800081ae0fa8 <+160>:	f838311f	stset	x24, [x8]

mm/hugetlb.c:
1969		INIT_LIST_HEAD(&folio->lru);
   0xffff800081ae0fac <+164>:	9100229c	add	x28, x20, #0x8

./include/linux/list.h:
37		WRITE_ONCE(list->next, list);
   0xffff800081ae0fb0 <+168>:	f900069c	str	x28, [x20, #8]

38		WRITE_ONCE(list->prev, list);
   0xffff800081ae0fb4 <+172>:	f9000a9c	str	x28, [x20, #16]

./include/linux/hugetlb.h:
753		folio->_hugetlb_subpool = subpool;
   0xffff800081ae0fb8 <+176>:	f9004a9f	str	xzr, [x20, #144]

./include/asm-generic/bitops/generic-non-atomic.h:
128		return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
   0xffff800081ae0fbc <+180>:	f9400288	ldr	x8, [x20]

./include/linux/mm.h:
1070		if (!folio_test_large(folio))
   0xffff800081ae0fc0 <+184>:	363000a8	tbz	w8, #6, 0xffff800081ae0fd4 <gather_bootmem_prealloc+204>

./include/linux/hugetlb_cgroup.h:
94		if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
   0xffff800081ae0fc4 <+188>:	39410288	ldrb	w8, [x20, #64]
   0xffff800081ae0fc8 <+192>:	721f191f	tst	w8, #0xfe
   0xffff800081ae0fcc <+196>:	54000040	b.eq	0xffff800081ae0fd4 <gather_bootmem_prealloc+204>  // b.none

98		else
99			folio->_hugetlb_cgroup = h_cg;
   0xffff800081ae0fd0 <+200>:	f9004e9f	str	xzr, [x20, #152]

./include/asm-generic/bitops/generic-non-atomic.h:
128		return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
   0xffff800081ae0fd4 <+204>:	f9400288	ldr	x8, [x20]

./include/linux/mm.h:
1070		if (!folio_test_large(folio))
   0xffff800081ae0fd8 <+208>:	363000a8	tbz	w8, #6, 0xffff800081ae0fec <gather_bootmem_prealloc+228>

./include/linux/hugetlb_cgroup.h:
94		if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
   0xffff800081ae0fdc <+212>:	39410288	ldrb	w8, [x20, #64]
   0xffff800081ae0fe0 <+216>:	721f191f	tst	w8, #0xfe
   0xffff800081ae0fe4 <+220>:	54000040	b.eq	0xffff800081ae0fec <gather_bootmem_prealloc+228>  // b.none

95			return;
96		if (rsvd)
97			folio->_hugetlb_cgroup_rsvd = h_cg;
   0xffff800081ae0fe8 <+224>:	f900529f	str	xzr, [x20, #160]

./include/asm-generic/bitops/generic-non-atomic.h:
128		return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
   0xffff800081ae0fec <+228>:	f9401688	ldr	x8, [x20, #40]

mm/hugetlb.c:
3317			if (!HPageVmemmapOptimized(&folio->page))
   0xffff800081ae0ff0 <+232>:	362001c8	tbz	w8, #4, 0xffff800081ae1028 <gather_bootmem_prealloc+288>

./include/linux/list.h:
169		__list_add(new, head, head->next);
   0xffff800081ae0ff4 <+236>:	f94007e8	ldr	x8, [sp, #8]

mm/hugetlb.c:
3328			adjust_managed_page_count(page, pages_per_huge_page(h));
   0xffff800081ae0ff8 <+240>:	aa1403e0	mov	x0, x20

./include/linux/list.h:
153		next->prev = new;
   0xffff800081ae0ffc <+244>:	f900051c	str	x28, [x8, #8]

154		new->next = next;
   0xffff800081ae1000 <+248>:	a900d688	stp	x8, x21, [x20, #8]

155		new->prev = prev;
156		WRITE_ONCE(prev->next, new);
   0xffff800081ae1004 <+252>:	f90007fc	str	x28, [sp, #8]

./include/linux/hugetlb.h:
808		return 1 << h->order;
   0xffff800081ae1008 <+256>:	b9402a68	ldr	w8, [x19, #40]
   0xffff800081ae100c <+260>:	9ac82341	lsl	x1, x26, x8

mm/hugetlb.c:
3328			adjust_managed_page_count(page, pages_per_huge_page(h));
   0xffff800081ae1010 <+264>:	979e566a	bl	0xffff8000802769b8 <adjust_managed_page_count>

3297		list_for_each_entry(m, &huge_boot_pages, list) {
   0xffff800081ae1014 <+268>:	f9400339	ldr	x25, [x25]
   0xffff800081ae1018 <+272>:	aa1303e0	mov	x0, x19
   0xffff800081ae101c <+276>:	eb1b033f	cmp	x25, x27
   0xffff800081ae1020 <+280>:	54fffa21	b.ne	0xffff800081ae0f64 <gather_bootmem_prealloc+92>  // b.any
   0xffff800081ae1024 <+284>:	14000011	b	0xffff800081ae1068 <gather_bootmem_prealloc+352>

./include/linux/hugetlb.h:
808		return 1 << h->order;
   0xffff800081ae1028 <+288>:	b9402a68	ldr	w8, [x19, #40]

mm/hugetlb.c:
3318				hugetlb_folio_init_tail_vmemmap(folio,
   0xffff800081ae102c <+292>:	aa1403e0	mov	x0, x20
   0xffff800081ae1030 <+296>:	52800801	mov	w1, #0x40                  	// #64

./include/linux/hugetlb.h:
808		return 1 << h->order;
   0xffff800081ae1034 <+300>:	9ac82342	lsl	x2, x26, x8

mm/hugetlb.c:
3318				hugetlb_folio_init_tail_vmemmap(folio,
   0xffff800081ae1038 <+304>:	940001ae	bl	0xffff800081ae16f0 <hugetlb_folio_init_tail_vmemmap>
   0xffff800081ae103c <+308>:	17ffffee	b	0xffff800081ae0ff4 <gather_bootmem_prealloc+236>
   0xffff800081ae1040 <+312>:	d4210000	brk	#0x800
   0xffff800081ae1044 <+316>:	17ffffd4	b	0xffff800081ae0f94 <gather_bootmem_prealloc+140>

./arch/arm64/include/asm/atomic_ll_sc.h:
203	ATOMIC64_OPS(or, orr, L)
   0xffff800081ae1048 <+320>:	d503249f	bti	j
   0xffff800081ae104c <+324>:	91010288	add	x8, x20, #0x40
   0xffff800081ae1050 <+328>:	f9800111	prfm	pstl1strm, [x8]
   0xffff800081ae1054 <+332>:	c85f7d09	ldxr	x9, [x8]
   0xffff800081ae1058 <+336>:	b2780129	orr	x9, x9, #0x100
   0xffff800081ae105c <+340>:	c80a7d09	stxr	w10, x9, [x8]
   0xffff800081ae1060 <+344>:	35ffffaa	cbnz	w10, 0xffff800081ae1054 <gather_bootmem_prealloc+332>
   0xffff800081ae1064 <+348>:	17ffffd2	b	0xffff800081ae0fac <gather_bootmem_prealloc+164>

mm/hugetlb.c:
3332		prep_and_add_allocated_folios(h, &folio_list);
   0xffff800081ae1068 <+352>:	910023e1	add	x1, sp, #0x8
   0xffff800081ae106c <+356>:	aa1303e0	mov	x0, x19
   0xffff800081ae1070 <+360>:	979ecd25	bl	0xffff800080294504 <prep_and_add_allocated_folios>
   0xffff800081ae1074 <+364>:	d5384108	mrs	x8, sp_el0
   0xffff800081ae1078 <+368>:	f9423d08	ldr	x8, [x8, #1144]
   0xffff800081ae107c <+372>:	f85f83a9	ldur	x9, [x29, #-8]
   0xffff800081ae1080 <+376>:	eb09011f	cmp	x8, x9
   0xffff800081ae1084 <+380>:	54000141	b.ne	0xffff800081ae10ac <gather_bootmem_prealloc+420>  // b.any

3333	}
   0xffff800081ae1088 <+384>:	a9474ff4	ldp	x20, x19, [sp, #112]
   0xffff800081ae108c <+388>:	a94657f6	ldp	x22, x21, [sp, #96]
   0xffff800081ae1090 <+392>:	a9455ff8	ldp	x24, x23, [sp, #80]
   0xffff800081ae1094 <+396>:	a94467fa	ldp	x26, x25, [sp, #64]
   0xffff800081ae1098 <+400>:	a9436ffc	ldp	x28, x27, [sp, #48]
   0xffff800081ae109c <+404>:	a9427bfd	ldp	x29, x30, [sp, #32]
   0xffff800081ae10a0 <+408>:	910203ff	add	sp, sp, #0x80
   0xffff800081ae10a4 <+412>:	d50323bf	autiasp
   0xffff800081ae10a8 <+416>:	d65f03c0	ret
   0xffff800081ae10ac <+420>:	97d6228a	bl	0xffff800081069ad4 <__stack_chk_fail>
End of assembler dump.

--X0sQVLzbSgBbKSJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=disass_INIT_STACK_ALL_ZERO

Dump of assembler code for function gather_bootmem_prealloc:
mm/hugetlb.c:
3292	{
   0xffff800081b0111c <+0>:	d503233f	paciasp
   0xffff800081b01120 <+4>:	d10203ff	sub	sp, sp, #0x80
   0xffff800081b01124 <+8>:	a9027bfd	stp	x29, x30, [sp, #32]
   0xffff800081b01128 <+12>:	a9036ffc	stp	x28, x27, [sp, #48]
   0xffff800081b0112c <+16>:	a90467fa	stp	x26, x25, [sp, #64]
   0xffff800081b01130 <+20>:	a9055ff8	stp	x24, x23, [sp, #80]
   0xffff800081b01134 <+24>:	a90657f6	stp	x22, x21, [sp, #96]
   0xffff800081b01138 <+28>:	a9074ff4	stp	x20, x19, [sp, #112]
   0xffff800081b0113c <+32>:	910083fd	add	x29, sp, #0x20
   0xffff800081b01140 <+36>:	d5384108	mrs	x8, sp_el0

3294		struct huge_bootmem_page *m;
3295		struct hstate *h, *prev_h = NULL;
3296	
3297		list_for_each_entry(m, &huge_boot_pages, list) {
   0xffff800081b01144 <+40>:	d503201f	nop
   0xffff800081b01148 <+44>:	107b6395	adr	x21, 0xffff800081bf7db8 <huge_boot_pages>
   0xffff800081b0114c <+48>:	f9423d08	ldr	x8, [x8, #1144]
   0xffff800081b01150 <+52>:	910023f6	add	x22, sp, #0x8
   0xffff800081b01154 <+56>:	f81f83a8	stur	x8, [x29, #-8]
   0xffff800081b01158 <+60>:	f94002b7	ldr	x23, [x21]

3293		LIST_HEAD(folio_list);
   0xffff800081b0115c <+64>:	a900dbf6	stp	x22, x22, [sp, #8]

3294		struct huge_bootmem_page *m;
3295		struct hstate *h, *prev_h = NULL;
3296	
3297		list_for_each_entry(m, &huge_boot_pages, list) {
   0xffff800081b01160 <+68>:	eb1502ff	cmp	x23, x21
   0xffff800081b01164 <+72>:	540008e0	b.eq	0xffff800081b01280 <gather_bootmem_prealloc+356>  // b.none
   0xffff800081b01168 <+76>:	aa1f03e0	mov	x0, xzr
   0xffff800081b0116c <+80>:	d2e00038	mov	x24, #0x1000000000000       	// #281474976710656
   0xffff800081b01170 <+84>:	b25657f9	mov	x25, #0xfffffc0000000000    	// #-4398046511104
   0xffff800081b01174 <+88>:	5280201a	mov	w26, #0x100                 	// #256
   0xffff800081b01178 <+92>:	5280003b	mov	w27, #0x1                   	// #1

3298			struct page *page = virt_to_page(m);
3299			struct folio *folio = (void *)page;
3300	
3301			h = m->hstate;
   0xffff800081b0117c <+96>:	f9400af3	ldr	x19, [x23, #16]

3302			/*
3303			 * It is possible to have multiple huge page sizes (hstates)
3304			 * in this list.  If so, process each size separately.
3305			 */
3306			if (h != prev_h && prev_h != NULL)
   0xffff800081b01180 <+100>:	b40000a0	cbz	x0, 0xffff800081b01194 <gather_bootmem_prealloc+120>
   0xffff800081b01184 <+104>:	eb00027f	cmp	x19, x0
   0xffff800081b01188 <+108>:	54000060	b.eq	0xffff800081b01194 <gather_bootmem_prealloc+120>  // b.none

3307				prep_and_add_allocated_folios(prev_h, &folio_list);
   0xffff800081b0118c <+112>:	910023e1	add	x1, sp, #0x8
   0xffff800081b01190 <+116>:	979e5a34	bl	0xffff800080297a60 <prep_and_add_allocated_folios>
   0xffff800081b01194 <+120>:	8b1802e8	add	x8, x23, x24
   0xffff800081b01198 <+124>:	d34cfd08	lsr	x8, x8, #12
   0xffff800081b0119c <+128>:	8b081b34	add	x20, x25, x8, lsl #6

./include/linux/atomic/atomic-arch-fallback.h:
444		return arch_atomic_read(v);
   0xffff800081b011a0 <+132>:	b9403688	ldr	w8, [x20, #52]

mm/hugetlb.c:
3311			WARN_ON(folio_ref_count(folio) != 1);
   0xffff800081b011a4 <+136>:	7100051f	cmp	w8, #0x1
   0xffff800081b011a8 <+140>:	54000581	b.ne	0xffff800081b01258 <gather_bootmem_prealloc+316>  // b.any

3312	
3313			hugetlb_folio_init_vmemmap(folio, h,
   0xffff800081b011ac <+144>:	aa1403e0	mov	x0, x20
   0xffff800081b011b0 <+148>:	aa1303e1	mov	x1, x19
   0xffff800081b011b4 <+152>:	940001a9	bl	0xffff800081b01858 <hugetlb_folio_init_vmemmap>

./arch/arm64/include/asm/alternative-macros.h:
232		asm_volatile_goto(
   0xffff800081b011b8 <+156>:	1400002a	b	0xffff800081b01260 <gather_bootmem_prealloc+324>

./arch/arm64/include/asm/atomic_lse.h:
132	ATOMIC64_OP(or, stset)
   0xffff800081b011bc <+160>:	91010288	add	x8, x20, #0x40
   0xffff800081b011c0 <+164>:	f83a311f	stset	x26, [x8]

mm/hugetlb.c:
1969		INIT_LIST_HEAD(&folio->lru);
   0xffff800081b011c4 <+168>:	9100229c	add	x28, x20, #0x8

./include/linux/list.h:
37		WRITE_ONCE(list->next, list);
   0xffff800081b011c8 <+172>:	f900069c	str	x28, [x20, #8]

38		WRITE_ONCE(list->prev, list);
   0xffff800081b011cc <+176>:	f9000a9c	str	x28, [x20, #16]

./include/linux/hugetlb.h:
753		folio->_hugetlb_subpool = subpool;
   0xffff800081b011d0 <+180>:	f9004a9f	str	xzr, [x20, #144]

./include/asm-generic/bitops/generic-non-atomic.h:
128		return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
   0xffff800081b011d4 <+184>:	f9400288	ldr	x8, [x20]

./include/linux/mm.h:
1070		if (!folio_test_large(folio))
   0xffff800081b011d8 <+188>:	363000a8	tbz	w8, #6, 0xffff800081b011ec <gather_bootmem_prealloc+208>

./include/linux/hugetlb_cgroup.h:
94		if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
   0xffff800081b011dc <+192>:	39410288	ldrb	w8, [x20, #64]
   0xffff800081b011e0 <+196>:	721f191f	tst	w8, #0xfe
   0xffff800081b011e4 <+200>:	54000040	b.eq	0xffff800081b011ec <gather_bootmem_prealloc+208>  // b.none

98		else
99			folio->_hugetlb_cgroup = h_cg;
   0xffff800081b011e8 <+204>:	f9004e9f	str	xzr, [x20, #152]

./include/asm-generic/bitops/generic-non-atomic.h:
128		return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
   0xffff800081b011ec <+208>:	f9400288	ldr	x8, [x20]

./include/linux/mm.h:
1070		if (!folio_test_large(folio))
   0xffff800081b011f0 <+212>:	363000a8	tbz	w8, #6, 0xffff800081b01204 <gather_bootmem_prealloc+232>

./include/linux/hugetlb_cgroup.h:
94		if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
   0xffff800081b011f4 <+216>:	39410288	ldrb	w8, [x20, #64]
   0xffff800081b011f8 <+220>:	721f191f	tst	w8, #0xfe
   0xffff800081b011fc <+224>:	54000040	b.eq	0xffff800081b01204 <gather_bootmem_prealloc+232>  // b.none

95			return;
96		if (rsvd)
97			folio->_hugetlb_cgroup_rsvd = h_cg;
   0xffff800081b01200 <+228>:	f900529f	str	xzr, [x20, #160]

./include/asm-generic/bitops/generic-non-atomic.h:
128		return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
   0xffff800081b01204 <+232>:	f9401688	ldr	x8, [x20, #40]

mm/hugetlb.c:
3317			if (!HPageVmemmapOptimized(&folio->page))
   0xffff800081b01208 <+236>:	362001c8	tbz	w8, #4, 0xffff800081b01240 <gather_bootmem_prealloc+292>

./include/linux/list.h:
169		__list_add(new, head, head->next);
   0xffff800081b0120c <+240>:	f94007e8	ldr	x8, [sp, #8]

mm/hugetlb.c:
3328			adjust_managed_page_count(page, pages_per_huge_page(h));
   0xffff800081b01210 <+244>:	aa1403e0	mov	x0, x20

./include/linux/list.h:
153		next->prev = new;
   0xffff800081b01214 <+248>:	f900051c	str	x28, [x8, #8]

154		new->next = next;
   0xffff800081b01218 <+252>:	a900da88	stp	x8, x22, [x20, #8]

155		new->prev = prev;
156		WRITE_ONCE(prev->next, new);
   0xffff800081b0121c <+256>:	f90007fc	str	x28, [sp, #8]

./include/linux/hugetlb.h:
808		return 1 << h->order;
   0xffff800081b01220 <+260>:	b9402a68	ldr	w8, [x19, #40]
   0xffff800081b01224 <+264>:	9ac82361	lsl	x1, x27, x8

mm/hugetlb.c:
3328			adjust_managed_page_count(page, pages_per_huge_page(h));
   0xffff800081b01228 <+268>:	979de2fd	bl	0xffff800080279e1c <adjust_managed_page_count>

3297		list_for_each_entry(m, &huge_boot_pages, list) {
   0xffff800081b0122c <+272>:	f94002f7	ldr	x23, [x23]
   0xffff800081b01230 <+276>:	aa1303e0	mov	x0, x19
   0xffff800081b01234 <+280>:	eb1502ff	cmp	x23, x21
   0xffff800081b01238 <+284>:	54fffa21	b.ne	0xffff800081b0117c <gather_bootmem_prealloc+96>  // b.any
   0xffff800081b0123c <+288>:	14000012	b	0xffff800081b01284 <gather_bootmem_prealloc+360>

./include/linux/hugetlb.h:
808		return 1 << h->order;
   0xffff800081b01240 <+292>:	b9402a68	ldr	w8, [x19, #40]

mm/hugetlb.c:
3318				hugetlb_folio_init_tail_vmemmap(folio,
   0xffff800081b01244 <+296>:	aa1403e0	mov	x0, x20
   0xffff800081b01248 <+300>:	52800801	mov	w1, #0x40                  	// #64

./include/linux/hugetlb.h:
808		return 1 << h->order;
   0xffff800081b0124c <+304>:	9ac82362	lsl	x2, x27, x8

mm/hugetlb.c:
3318				hugetlb_folio_init_tail_vmemmap(folio,
   0xffff800081b01250 <+308>:	940001b5	bl	0xffff800081b01924 <hugetlb_folio_init_tail_vmemmap>
   0xffff800081b01254 <+312>:	17ffffee	b	0xffff800081b0120c <gather_bootmem_prealloc+240>
   0xffff800081b01258 <+316>:	d4210000	brk	#0x800
   0xffff800081b0125c <+320>:	17ffffd4	b	0xffff800081b011ac <gather_bootmem_prealloc+144>

./arch/arm64/include/asm/atomic_ll_sc.h:
203	ATOMIC64_OPS(or, orr, L)
   0xffff800081b01260 <+324>:	d503249f	bti	j
   0xffff800081b01264 <+328>:	91010288	add	x8, x20, #0x40
   0xffff800081b01268 <+332>:	f9800111	prfm	pstl1strm, [x8]
   0xffff800081b0126c <+336>:	c85f7d09	ldxr	x9, [x8]
   0xffff800081b01270 <+340>:	b2780129	orr	x9, x9, #0x100
   0xffff800081b01274 <+344>:	c80a7d09	stxr	w10, x9, [x8]
   0xffff800081b01278 <+348>:	35ffffaa	cbnz	w10, 0xffff800081b0126c <gather_bootmem_prealloc+336>
   0xffff800081b0127c <+352>:	17ffffd2	b	0xffff800081b011c4 <gather_bootmem_prealloc+168>
   0xffff800081b01280 <+356>:	aa1f03f3	mov	x19, xzr

mm/hugetlb.c:
3332		prep_and_add_allocated_folios(h, &folio_list);
   0xffff800081b01284 <+360>:	910023e1	add	x1, sp, #0x8
   0xffff800081b01288 <+364>:	aa1303e0	mov	x0, x19
   0xffff800081b0128c <+368>:	979e59f5	bl	0xffff800080297a60 <prep_and_add_allocated_folios>
   0xffff800081b01290 <+372>:	d5384108	mrs	x8, sp_el0
   0xffff800081b01294 <+376>:	f9423d08	ldr	x8, [x8, #1144]
   0xffff800081b01298 <+380>:	f85f83a9	ldur	x9, [x29, #-8]
   0xffff800081b0129c <+384>:	eb09011f	cmp	x8, x9
   0xffff800081b012a0 <+388>:	54000141	b.ne	0xffff800081b012c8 <gather_bootmem_prealloc+428>  // b.any

3333	}
   0xffff800081b012a4 <+392>:	a9474ff4	ldp	x20, x19, [sp, #112]
   0xffff800081b012a8 <+396>:	a94657f6	ldp	x22, x21, [sp, #96]
   0xffff800081b012ac <+400>:	a9455ff8	ldp	x24, x23, [sp, #80]
   0xffff800081b012b0 <+404>:	a94467fa	ldp	x26, x25, [sp, #64]
   0xffff800081b012b4 <+408>:	a9436ffc	ldp	x28, x27, [sp, #48]
   0xffff800081b012b8 <+412>:	a9427bfd	ldp	x29, x30, [sp, #32]
   0xffff800081b012bc <+416>:	910203ff	add	sp, sp, #0x80
   0xffff800081b012c0 <+420>:	d50323bf	autiasp
   0xffff800081b012c4 <+424>:	d65f03c0	ret
   0xffff800081b012c8 <+428>:	97d5f73b	bl	0xffff80008107efb4 <__stack_chk_fail>
End of assembler dump.

--X0sQVLzbSgBbKSJA--
