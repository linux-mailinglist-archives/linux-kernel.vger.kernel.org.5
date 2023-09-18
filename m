Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2347A4C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjIRPZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjIRPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:25:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A741707;
        Mon, 18 Sep 2023 08:21:56 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IA3I9Q018945;
        Mon, 18 Sep 2023 13:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=JtbLEnZTbaKgKJJwyZSMdJEfnsm9wfToZjevPbUrinI=;
 b=27hWZyBzbPcWaUjNgxEFQ1rWRF2CWd7thZKKPBM28ZE1VeBW4Q9jIqseixPuE4nritG6
 4QSMhrxoZyvZF/hBhtnvOitDYaDBKWfgRKnoQAJJrDn6FTtM/GGm7FCT+3JHIsQM341Y
 S4S8f1uHqaJOyCxAnrMSgguGDmlZxDq63bpjfNVWrJyRTM2dF9PNVwTfAOG7oGvIpmkv
 EToE75Abm2lXIig6wWYLdqLKpWjme/4FQh9PFfRaG1zmVmFkV7zwburs2fSVglrD6P1V
 8A639XWqRrsUI/Vq2VZU+TAVGyZJVC+m8lyeVDLrYbsuEjXHyCTb5Q9ekNCOPYIp6a3w RQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54dd2gja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 13:22:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ICrFdY016089;
        Mon, 18 Sep 2023 13:22:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t40dy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 13:22:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LioxTeYH7nukHNe8zYXfzkr3uDyFS1L1lhZz62bHumoP0h4QrpFvOJJRobglQszVk4f6cWt+XRhr4xnb/xDvj8cwNBJmI4qktyuK8/GN/88PLntTKYNFW+UgDp3hEe3trC9JQN3l5I7nZ5OYCpBROg7MDuCAqj8unl+K1Og9a0uc3XbsALX6D1r3x5/cicDGTDkPhFp+cWfP7AUO/JZ1Kkvi7o4S5xwnVwTvfYhHN5IdR6URE7bwnz2N04wpdeleQRCpJT3gXKY/ZpBiqO94gi7/70XNHfNoxmEP+gQwRz48qoNvuJyHNyKIF2RVG+cdFoKJaQN42tUHgch9yuaY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtbLEnZTbaKgKJJwyZSMdJEfnsm9wfToZjevPbUrinI=;
 b=C08GTkH7W6n0uX0hiiCWDL1nz2aobCoxKu0yGvTG4vCK2gWMN5erSxR3zj1vFlw00dss0S64FSzROOPus9CXWylxYId2g4mNWzntg5sEQnlpLKsUZK3afoIiSkk2xlKdWcr1aO8ADPHQThl2eQ3s+m+ni3Y6S9Kx6mgkWzSk00A3Dn9GXSdviQ6kb1+g+5kxULlaF3pJLAMIg5RXCl21lsjaL1ADT4euduQ7jcQKA/Ia4tIrmqB2I0am+UCWgNEp5/aPB7ptdcGW2EBj1+aZxXmQSd7DX7dy/6G1V6o75OGFwlYc5OnXxn7XdRbBkzYcnJU+5TpC+ihd6frXhVarzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtbLEnZTbaKgKJJwyZSMdJEfnsm9wfToZjevPbUrinI=;
 b=bP6Ch0TqnJm+9cv3nDOqSvrHRrn2moCL1S1UTR7vPD0HaNiuRjTRpYc2gvYlZlJ4V8X6OeeqfriSBGab7nPPyWZvN8w86h7ShcFy2uSC69v7HqwVkK/DS7zlakIPDc21Vq3iZ3BCHw3ty/jSfRgGkkG/S6V8p7SvvnE4ZBq1TRU=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 13:22:06 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:22:06 +0000
Date:   Mon, 18 Sep 2023 09:21:59 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        nstange@suse.de, tangqingmei@xfusion.com, stone.xulei@xfusion.com
Subject: Re: Issue: padata: UAF in padata_serial_worker reproduce
Message-ID: <lq67pqfz4ucmrpbwmor7h23x2iafsnyh4yuz3mfrfaxrsqbyxz@wqp5rih7grwp>
References: <ZQft1jGSMSTRlxfi@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQft1jGSMSTRlxfi@fedora>
X-ClientProxiedBy: YQBPR0101CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::20) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SJ0PR10MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: bf01a2f0-45b6-4381-a38e-08dbb84a4120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpS8yA41KnpNv+zlctx1Crer2M601LfYCrn/yMRDdhdfrzouyG3FANJF8mF+HyKvpiBPc82lJPx+lDpeyGlqfRLOngerJRKs6+3HrEehIzusreE3dJilJBUVRsMRU/rGsJtIo/SYFAfcUhunUNl8Vhdg1d+6Hbv4UP9AArFAElT6f2ijXojIp0XPJmc6MUi234jXVz7xV0Xo7MTC9fMUoCAgP5eHRSgmgB5gYLDDpzmF0hERfgS88CXHz95UeJBa2ruMKuD/466O2SxfMc/sCe/hEgLFXC/ZIPDc7+7I6IYxDqGCXgyROZXKjFIfdxfnV277UZgZ3zu8eBNCY4WBjwXDB6P9VHJeCkM1/H3DSqXY4pilSOXi2JHpcoyDpe8XbU+3y4rMaPY2+wHpFOkzYXTSaJso0Ak14vUI8uo91rcshOG702yntKTVYmMv8/EgGD7Ex6wZCEH8mpG+YCG0UIEH+W9MFk28zjbGK6WQTXjZAuKI0c2V4EfbPQodGiErCRairxhxQQoN4cyS7y5QuSlVyTOoWslFx11LgjUHiX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(396003)(346002)(136003)(186009)(1800799009)(451199024)(316002)(6916009)(8936002)(4326008)(8676002)(41300700001)(26005)(83380400001)(9686003)(6512007)(966005)(478600001)(6506007)(6486002)(6666004)(86362001)(38100700002)(66476007)(66556008)(66946007)(33716001)(2906002)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fTw4pG3JrodhoLnJxq0C35JYd0tzBBhinhH0NqdZojSMETQZm1GM+QpOS9Hb?=
 =?us-ascii?Q?QUgN1l7EltdGct41MWrnfaoUxb491n0R+c3sjNTeSa/Dbjpe81QplNuJfUZ5?=
 =?us-ascii?Q?Vv5wTJbwOmtOeHEOaRXgrk7YThHPl4Jy6Sew3bJ7Ve5W/SRRviYQcdogavej?=
 =?us-ascii?Q?MEfvgoHoufhMIrupPUvQCqzURkwN9JBzZMbxEH/Lb3cpK1dnPRYJjkt+vCMa?=
 =?us-ascii?Q?rPKA/lX+/sftRnrO0ZMwIKBk5K+3f2co0uqsoCRi3LPTzbyGxdDQRAq8AABu?=
 =?us-ascii?Q?rakAQJNGx9QpJ31IUucr8Ik0gSYpe3IXYHKokqJPKjBVLy3DqcV/wAkFvlFf?=
 =?us-ascii?Q?EZjPM7B7IMxkEh9yNFtBEUcXi6AzADh0erNbzuko4kP4NoXpZaz54bKyWHLn?=
 =?us-ascii?Q?0OfU6poqD7mJU22Vd+q55VSF3MKX+zbG4Ndw9o2Z4w5OYQxx8gKE/+74GFKA?=
 =?us-ascii?Q?XTWInqFXQ1/i3B++Q/4+j37qVyWydLoQ+V/kGg2hvJ8lne2JNR13+dRpSio1?=
 =?us-ascii?Q?wtiGHe8FWu/9k/kVVPqBHe+aSVv4K84P0kz/7sjG73WrG3TLeKmJYtNXBeoa?=
 =?us-ascii?Q?PTS1kbtlk/YOxiKNvAJwzC4zTR/gyh3PTYhWCOi/zfBuiPlwfAYu9jnVoj76?=
 =?us-ascii?Q?51gZtwZS0W41+idIsD5uPMUB48e1htm1pvhOEFsrrZfbO7JkhPbi93oNNSdv?=
 =?us-ascii?Q?gSb7QHGYDFAjpWsU2iRGsxv8Y97PhZopWNoEv8BgG4DznC0NzjRuvczMX+L9?=
 =?us-ascii?Q?GnA9Hi37upGaBCpQJt/5HgkV8s+EZkMh+C9qDWVdrimBumeqsxZxJqutSQmi?=
 =?us-ascii?Q?VTQxNMD993QFakv5DTtlja5UMsW3k5ztSyzbupCQ/pMlT/AIa+/6ua1SbFYj?=
 =?us-ascii?Q?SnOND3jnH+m2faJwUs0PpVb8crk3SkdFg1hVIvJkG4FFmD2RCgO/evxVVqfF?=
 =?us-ascii?Q?vmAaJxT1ok6l/Ly9JHgxu9QJUXu46pceXaJDfJXun9GE1PZt7lur1EoPXDeM?=
 =?us-ascii?Q?BrWvo6RbXAnWezy/sqYCxQ0ZMuNAgQ46r4A5YMkpvDQtwOOAXtRaBRCAkirz?=
 =?us-ascii?Q?ijwxtDY3DdKJaqKt8IWqBpzViTD29RB9Hkz8Km47YMOSKP4/2tTuxaRAMNiY?=
 =?us-ascii?Q?MXdGGiYAOIN2EXdxinVB1BXipZPMpILiohVjLU7+LTjU5fJtYXIb+5S2YLm3?=
 =?us-ascii?Q?bM4pJcB+ff2yR9y7ZDfi1U+BHcejFCa2anIOLM7G7Gq7C2pL3gmwG+cv27VT?=
 =?us-ascii?Q?nCh2hZgIi8K5U92OByyD4aLPJ7O2dNgbE/Igw/CXWw9TlegXpAfd7WGtiTT+?=
 =?us-ascii?Q?78rkbh4anaHE4DHwdDDtuXRXCsj2R8XinTmi1XMpYfjW1Sb41teFs2SeivYi?=
 =?us-ascii?Q?Ri9bLSvrLDvFipPF4ODpz60RPtg8ngrn4hnG4Gnh+Ut2Th7pnSEhV26VIpzU?=
 =?us-ascii?Q?8s3n9JtSe3b/dK5Nd7giCW5tZyWd/1A/pzQqBeHK/VtavK2YNwxceVTWDAiz?=
 =?us-ascii?Q?KPdH4h+/xVrh6xvucL5dkgTe49wc5FNhgvqTX8GqF0jc8P5/r3tN7H/DKCQr?=
 =?us-ascii?Q?7rPiHP/P4nrctNezlJOkgo3nPLaZcRfN4SW4DpURYMs/rSNXoZKse9IjyzNG?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fjx7oynyRbt+Lg/GBVfGUssFKLaaNqfe69S9a2K7lxiyLdXEhkd6tLCQ2mkXeVIPwMpID7WL2J/oW3wTPXs62esJx+fRjZrqc5i8lGriRI0EeNWkeTXQiYnzOoTGG8UIfi/RlwoQlSFP1yk+ftuDAHOmssXeHn/9jPX32bhF0+fCm/j0Tk8yU9/YS+8BmAXMxxMxr+1E1g7DglkYtbm8CgQjqcavN8NPMlIsD6ZKj0YzXrLRS29fqkyNwdtTIdNcEhaAjUE4MAnPWa/JtIwh2uBTHWlwjyYLBhKSael3amH/i3No51XDSjBbzqFhy5M8rGQBwJgyK4PCecTkvD2zP2/LG4+DGCgkjfxf1WXnMsYsUQNwIXpIkRiK6Q1asULUQNnuUo+VIBMc3SF9OTsFLp31EzPGmiMFMtd6KyjFauqSfbOKcMYh3HZCSjHndYalj+ADCb983o7WQ2zQDDzd6W8UZVgDhbLApSG44dKxgYVz+Xc25pBpkL3e5G9UtlWvjo09Q47ivtTC1uDRiXlrnzzCiiBfk77vAy2W/kS0YxfdD3xMSxR0bvGsHRWn6rNOjnTRcgh0MmEHY5KgLSanNRns89h+9Q4ZMDJF5ZW6aeVSWzYfQtYVg0wzU09qS3uix09HCf6eWMvH5HULIHfqN8x+tnFUm36uXA18v3tJvQLYdyU9e7b6dBGZuX/okUDHUzTf0wBCvqhsgO6ZIGVPqI57+JlR7uk2R+mzWa+DBOrya49o57wOkOO1+HNmeCG0/g5vOR5f9nM7E7iyfuB/YqyUS5qhORK1pdzWuQnPAcoKL2JxhwSh8x5uoOkL8seU7b95qh+Ci4RpcEY31CRfgwInDhzbCVCRxRw3N56/HQw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf01a2f0-45b6-4381-a38e-08dbb84a4120
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 13:22:06.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8a0wADUzAQqPPI43xzxuF6TyMWsBFm89QETPMRn63ix2KmrzuepKMdeibfwmudFL5is0lIgEldRZgthUz90DOROJhcDZJ1IB6HBYVdhynw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_06,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=617
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180117
X-Proofpoint-GUID: 1jFGDkfpWcEydqRgJBJv4lhCS9r6FEeT
X-Proofpoint-ORIG-GUID: 1jFGDkfpWcEydqRgJBJv4lhCS9r6FEeT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 18, 2023 at 02:27:34PM +0800, Wang Jinchao wrote:
> Hello, I have reproduced the issue mentioned by Nicolai Stange on an arm64 server.
> After applying Nicolai Stange's patch, the issue did not reoccur even after running for two days.
> The test tools used were ltp20220121 and stress-ng-0.15.06.tar.gz.
> 
> refurl: https://lore.kernel.org/all/20221028160401.cccypv4euxikusiq@parnassus.localdomain/T/#u

Yeah, this series seems close to being finished, just hasn't made it
over the finish line quite yet.  I wonder if Nicolai has plans to
ressurect or whether someone else should take it over.
