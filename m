Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0A7B82C7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242979AbjJDOyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjJDOyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:54:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E58AB;
        Wed,  4 Oct 2023 07:54:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948itvi030810;
        Wed, 4 Oct 2023 14:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=2XH1V+ovdfGfXRmXD05JAh3k3JXg1lh5a3RfZhjeX+8=;
 b=SNnPOrgpl/qOhGMmbo6C6x74gHon1F9kXDpexFyiKdfDNuO3hMwPJX2E9O8M1T3vGSJL
 P0WQPypnteFVEkdO/uoUuQQLZOAYK/bDtQD6AQMPHzw3+a2uJ1XOI6K73qxuZEWfeVGD
 S3TGtZkGZp8C2ThnTdIfLqimouvaBGZEabj0bM2WqYOM8li5CqKkbEbnV4v3V1yfqnUJ
 W5WZPzPc4Dq3NsfLMXD8IHjlTMa5s0Gb7zQoSaoDKZg5cP6jJcB1+yGRuy7hIffd67uW
 m532Cxr7ZYTI9a5ubNkT8n5Cm4FkV0fNGPkpVG9+cc80Ls8SHLn+OuBrrRiWiEYU66Ql iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9ufb0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 14:54:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394Erdnb033621;
        Wed, 4 Oct 2023 14:54:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47vm96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 14:54:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN5bi9ktHRfQxNRwOoARNqUk8IKNK/QO4gId0W8ZNQwkwSPsh0f70IGzvCQP+lSjG69505zdWg1O+lmMYSETK7/ov3s9Nkobyd+8H5MjkYPtq2HZrowfHYKqyXbGlYvzNzZlRw0KQq0uYi8v06okeG/iWKvjGoViq+eW3iu5bkvRuNX7m3avAfGsNtQONXUKegkXp0+ZYRIMEdDPwZFBPtX9aSQRrF1ZOaSZco32ABy1+D5FvXeDj6WhTHVtW9+D7G/Go2RITJnY+MhO7zlP/TGk+9VoG1MUSn0bFBAwnWqU74XCaqenEC0KlaJPMlH1lh1evyhamE/PVNHtKYp+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XH1V+ovdfGfXRmXD05JAh3k3JXg1lh5a3RfZhjeX+8=;
 b=ExANCkrrRzGipm3JmHZ7o8YytVkWmuLRZ/8OaZMqpICL9yd7qeFD+aTpcpxC/qP4h5JCnYzICKRgVsd+2XnK8qUw8OjsYXe/+wpOpZYGFjHtF3Jg8tX6HhhFD1uVxY9CzIRWwf8vZndtHLrATeEopKK0NFntmUo5DcxgK4s8K2tj5wFpn3hKO8Q/NNaz1c8N/jtY0Se8J4AVGPnGkikcifoRh3tLhxbXeF7BgUmVgrzjDkmcrgOm7nEHLYAFSFGP0ZmDWonk/hGPtWF1ZrxEQfxZdWgoFf4bYrmC05G+MwZ1awOxHHbnnGRx3J7sb5nSje4xgtzfzX6iYwqWpYlwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XH1V+ovdfGfXRmXD05JAh3k3JXg1lh5a3RfZhjeX+8=;
 b=ihzHdfriFkwW1scIcrS7bpc1vygYH5xnxxYwJRt1x8AfzVsz/SSLazVb0ykq/VjzcaOLAjE66THUj5xyj7s6jem6XG1uDiG0NtDx0vctF3UfFt0l1xeNXUbEui5zoDKGom/hQ2w4UTYi/gXDmhR7n0V6ocyrVNfDhvTMh+78w7M=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by CO1PR10MB4546.namprd10.prod.outlook.com (2603:10b6:303:6e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Wed, 4 Oct
 2023 14:54:34 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48%4]) with mapi id 15.20.6792.026; Wed, 4 Oct 2023
 14:54:34 +0000
Date:   Wed, 4 Oct 2023 10:54:29 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] padata: Fix the UAF issue related to parallel_data
Message-ID: <rjayevj3rwpj6wt2uq2jc7c3oqbewnobdqhs5bkrjte7fxzkct@k5rpt4g6tnqh>
References: <ZRTLHY5A+VqIKhA2@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRTLHY5A+VqIKhA2@fedora>
X-ClientProxiedBy: YQZPR01CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::27) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|CO1PR10MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e61893-308d-4dfe-db70-08dbc4e9d2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsLWkwifNXiR/mZ6lUIgSOh+1NcnmGq4SSX3OBzXlKj7TyHIAyBuHSEtCCB0/sgRBp2nm7Uz8UTumBDwC3qtXoFgQJh8S9eK66BsHGpiyDZkwWJlj9DdOWtmC4hep8Mr1knVb+8Y2/bGlCYeYxSaSHX5MstNfUslLMX7fz8rXTM9Ka/hxn2zSHuX5qKqo2ZrlWyHHW/eBPLEZr+3mqygPb3u49D4uo/OzBJiCIRGqnJLTbegCIz3lqYJjs3feYTA5bEewnnTYtSPUdjzAjB3rQkG/+wF1qaVoFU+FpHwdbopoQ9T1CWG+LoCCOxMmpt/5/clcXO/dJHI/fKLJe7nhCB0SKiFw5AEl0GWeolVFGaqN+kqa/XgOZoa3Hb3fjwbiB0PirXakXDU/1ZP10/OLZymjtwzBgMYlFFavZhKWyp6gU0VOTB3D24yb0Kt712P/iXm8QpNCqRzsz8ti566MiFm+L9DpBXH2GuDwiobNhYtYWLbpbaGbt+p73rANzLPbtZWrZejkeiQ8liGU7ddaW5ozWmF3P0XWFIt5p7A3/gChXVMZHs5QS3sGdgAjVx2thxz+781vKLe88p7l8awzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(26005)(9686003)(86362001)(33716001)(38100700002)(83380400001)(8936002)(66476007)(66556008)(478600001)(6506007)(66946007)(316002)(6916009)(5660300002)(6486002)(966005)(4326008)(8676002)(41300700001)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QemNEKb0HjhevulqiWBIFpAg3X9O+W/ouJ5YO4pvrE1Dc1ctZfGpEKuSu31L?=
 =?us-ascii?Q?y6qgLo8xhpMdQclNUoW/R0g0JaafiI99zH5EGlRmwMA1TOmx1zjHCWV+JrTG?=
 =?us-ascii?Q?SVAJVhxM/lQWrnvFlTWa30nlUFRKR4zxxjSmyKasT7vx/OhWHznfSxzUPgF8?=
 =?us-ascii?Q?OqVHvIWdgAmQRh+ZpG3+Z8twCGbeZXltzzmkmKnBKsYD17ksnADweOIYip9K?=
 =?us-ascii?Q?NzL/t7tqLBiyY2pKYcHm1lnpqzteJBO4VC4juN7XOhrJkzG8P2GnIaBI8HY9?=
 =?us-ascii?Q?rpjipo5+iBSYDkTxg90ytAtYxVfG/lOax28stS9i+3giujo7DyYS17Dpr3F2?=
 =?us-ascii?Q?9ws+hMgZhl7aSgLhFxX/iYXaUtfiEEVsROxXEFtRqPWf7juX9wEFYRaJRizK?=
 =?us-ascii?Q?tVG16KRxgXttwCyxTnUrUENmhLylp5411wGbTnkrgwEYJLv5EcKWgdja8MkZ?=
 =?us-ascii?Q?LdpDvS74RSnAlHasTgphGcxjrMseXiFsQ2KatkOkdl/YVP1wI9SgHcOYxoJX?=
 =?us-ascii?Q?C8t9V32ZLpQl6lTnSmPG+N1mchysxv/GqBc516dJkh8Bdm4+FDjW+G+qL9t6?=
 =?us-ascii?Q?fIZ1fSwEeobLaXPvJyEYEsy7Eo6JVIVLO6yu33WbW4DoJqjEAFWV6G/2AOEp?=
 =?us-ascii?Q?JoxvfOKpjESdYvCdrUJXbS7xJOUChL9i43ruUWuzB+gsdslcq73ns1y1lzEL?=
 =?us-ascii?Q?lciBkhTTTWlqp1nDdUiqQLsqaZGhnRLfSINeXfIOrCq4qumjxEDseyWNYTx/?=
 =?us-ascii?Q?xiFtk5Tzm19fg9nLpXZ2lchvXLKVn7qSC8A1parCWVWwZUrCNurvbKmppGib?=
 =?us-ascii?Q?m2niL9BHLtCS8/IHFbbJFEp5436SQaC13JIblmY3kj2Cq6nyWxlhGaXkP3Th?=
 =?us-ascii?Q?JmP8UdhdiZA/Eo4Kedg/fk2/+e+a51SvT7KB5ZkS3uJyKj7Cvl3JiW5r/0NJ?=
 =?us-ascii?Q?Ao1GmbugRxlhoRxY1zxlJhu8sQobjW+LxDSFxgZXDDhb9BzJ3aIx+IjQPfgQ?=
 =?us-ascii?Q?mc9g/s5AHR4m5zge/9au7fjwJMy2zkpOBb4+jMNgjt5GuMJ0j2+DshAB3WBq?=
 =?us-ascii?Q?HshSYONNH3osJEUsq4b2OQ7UZG/HC3d8wRWSKTqJiI+RM6/Fi8GXtbPeMhxI?=
 =?us-ascii?Q?QTi9RUGc0r2ECdGvy+d717VCQtM/qPskdsiUZshaMys3joycTa55RG6AlpZs?=
 =?us-ascii?Q?6uzFz7lyvJlbU+n65D0Gf1Rj821sn6oPS7biUoWfW04VouegyuOyBbNyTGRM?=
 =?us-ascii?Q?23nRpQaYkcHXhbJpTzLNlLiRxsSuakmrsQupk1z7GCXHy75rzwrL0gfCoG+C?=
 =?us-ascii?Q?s5QuIqqyNPKeFZgBvfDn80kbSna0qN0jBatIxZXQyk7KLPAvbj6qmfiVt+3F?=
 =?us-ascii?Q?Uqlh4uOU13nOniDf6fO+4td7FZtBRbZ1Q+iQ2AVHPE8m5hNndExJN/VBYt+w?=
 =?us-ascii?Q?YuqyQelwIZa0DGm7EMEHeFuGp2etErhRuXVFSOKfbQ4ZuvpKW6uiondotYOn?=
 =?us-ascii?Q?HjU7HHhIMqdNdFASAUBPTD6ayPX3c8YmtMP578+a9f0bcpTTF/nfgeJW771e?=
 =?us-ascii?Q?CaVgmF0iHjWI1V6BNeD4G1kHpJB+s+9zlekCZEdsU8Iw7wz7qOjbvaiqzuBr?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2dXJfYXV5hJ9S+lDsHWv/J09H+WOAsDcVScSMK6E3VEwECbx7sX9YideXagfi7ZmyWeSKp19Vi97DwrdsT0Hk+RnmKltJPMlJ+7C/HneNClkmJs8Ud2H5T+QsHU3mkIHQOfuZ/DeJi5OdD9cye4Y1GpE8X86/LhaKZ3qA+HCVAF39WXQHyccaXPJLEPbQIVfBB5JyWbcpjz1HSCbX292/DP6ZmMEmZNg+kXKanX80Qc5Po+6Ik5WtmJWxd6PUpHRdtie8Dvlz53cH8CU6RBi171Cs/NbrijY4UdzkjUXBzStwShhaPccp6jHx2LaLWJgQBxyW4C4/QygA58qb1+sSg4Iy1cOC3ayCVBbWxFt48vmoEdwhodWlvjOVpURtlH5VIUbZ/PCcilYtQa9Su1jDdkGWObYIliNlBgTEmLRdYjDoa/JryOl8ZWMdGDSeq4/105Z/T4r7X/TB/rZYIkPur/DrRDq9G4T45tI3pJh6w5PFaz9PSphtrk0Q12pXo5tH4H0x+tCCaduBgdDcXBiGY/iKeJNOfaaQ4PI2CNSkjUHGAaRJ73r7FlGcZZ3fiik/HWijcqbyYlWjpxObDfyuc/e7KcwpMXc0UHDLcVmzEMOG5x+QShy9UFVBXyAMyk0IGZaX53fTTTM0e/Suo7f27HxwPT4Wtaex07p68/pXfX9ZGzoUlN+XXBssNdmqlaB/a+R7v3EfD0GYjDJ47bb51ncbFSHwGd87m/nJHO6bzGVyLig+senRrHAVferq8M+3/ychmBYF0FkHTRg3/0ry+jwhWDPVRzQUMnZJ0vS9xULynlRzaDNBTeX7zSIE17atcBYfajC2b7/GFcnAG+lzw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e61893-308d-4dfe-db70-08dbc4e9d2a8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:54:34.5650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELOsMHABtovLf7sm9pIi+zLnTKB4TPtt+19Jg5Ml/urprwL78B68CLK6FaAWHGyBYY/87gA0Y5nzy8wyIJtJkoryBfUbTGvCBqH1w+40mlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040108
X-Proofpoint-ORIG-GUID: 414ve4Zl8iejylNfU-f54FxIFxdiP_bB
X-Proofpoint-GUID: 414ve4Zl8iejylNfU-f54FxIFxdiP_bB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 08:38:53AM +0800, Wang Jinchao wrote:
> In a high-load arm64 environment, the pcrypt_aead01 test in LTP can lead to
> system UAF (Use-After-Free) issues. Due to the lengthy analysis of the
> pcrypt_aead01 function call, I'll describe the problem scenario using a
> simplified model:
> 
> Suppose there's a user of padata named `user_function` that adheres to
> the padata requirement of calling `padata_free_shell` after `serial()`
> has been invoked, as demonstrated in the following code:
> 
> ```c
> struct request {
>     struct padata_priv padata;
>     struct completion *done;
> };
> 
> void parallel(struct padata_priv *padata) {
>     do_something();
> }
> 
> void serial(struct padata_priv *padata) {
>     struct request *request = container_of(padata, struct request, padata);
>     complete(request->done);
> }
> 
> void user_function() {
>     DECLARE_COMPLETION(done)
>     padata->parallel = parallel;
>     padata->serial = serial;
>     padata_do_parallel();
>     wait_for_completion(&done);
>     padata_free_shell();
> }
> ```
> 
> In the corresponding padata.c file, there's the following code:
> 
> ```c
> static void padata_serial_worker(struct work_struct *serial_work) {
>     ...
>     cnt = 0;
> 
>     while (!list_empty(&local_list)) {
>         ...
>         padata->serial(padata);
>         cnt++;
>     }
> 
>     local_bh_enable();
> 
>     if (refcount_sub_and_test(cnt, &pd->refcnt))
>         padata_free_pd(pd);
> }
> ```
> 
> Because of the high system load and the accumulation of unexecuted
> softirq at this moment, `local_bh_enable()` in padata takes longer
> to execute than usual. Subsequently, when accessing `pd->refcnt`,
> `pd` has already been released by `padata_free_shell()`, resulting
> in a UAF issue with `pd->refcnt`.
> 
> The fix is straightforward: add `refcount_dec_and_test` before calling
> `padata_free_pd` in `padata_free_shell`.

This could use a Fixes tag.  From Nicolai's patch[0] we agreed on

Fixes: 07928d9bfc81 ("padata: Remove broken queue flushing")

With that,

Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Thanks!

[0] https://lore.kernel.org/all/87educb7rm.fsf@suse.de/

> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
> V2:
>     To satisfy Sparse, use rcu_dereference_protected.
>     Reported-by: kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202309270829.xHgTOMKw-lkp@intel.com/
> 
> V1: https://lore.kernel.org/all/ZRE4XvOOhz4HSOgR@fedora/
> 
>  kernel/padata.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/padata.c b/kernel/padata.c
> index 222d60195de6..acef1e703a8b 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -1107,7 +1107,9 @@ void padata_free_shell(struct padata_shell *ps)
>  
>  	mutex_lock(&ps->pinst->lock);
>  	list_del(&ps->list);
> -	padata_free_pd(rcu_dereference_protected(ps->pd, 1));
> +	struct parallel_data *pd = rcu_dereference_protected(ps->pd, 1);
> +	if (refcount_dec_and_test(&pd->refcnt))
> +		padata_free_pd(pd);
>  	mutex_unlock(&ps->pinst->lock);
>  
>  	kfree(ps);
> -- 
> 2.40.0
> 
