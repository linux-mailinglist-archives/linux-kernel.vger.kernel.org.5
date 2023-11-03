Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23047E07F1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjKCSNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjKCSNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:13:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABB2A2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 11:13:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3G87m2030685;
        Fri, 3 Nov 2023 18:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=7TEPWf1ytHq0viOzo3EVzU5DvfGH+kzZlxdPryKfmro=;
 b=a9Frbg/0/dKCyBsUrDbpc79ao6wekpMfZvKg57kCno3aAWMO26s9eggZvLnOuBJ9n++6
 bS9VUhn1WyjHZx1vLDnHHStCrzZOYAPQonAqW/9F+gqbEs8VwEcaS+ZpvImCSUDDrLG7
 UDWA+2qS3dEUfNAnzQEQw7KOBCyb/tmaH9k39GR9JDfMFWrmatNOxeMgV76p/D6D7Xte
 iZdF25y0G1DGvPwIdMlxNO4aAW48v3KGePOU9w5HB4pXCJW8CUSe/aR1EFYAOdebKN7j
 L1sQbUiCcaXgtjGh6E2TjenVeO7CKdKEw1/Q8Lf0u2UCbavLuxPwDnyqWtCHI+htGgbv Kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtvn24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 18:13:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3Guu9a020244;
        Fri, 3 Nov 2023 18:13:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrgpruv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 18:13:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfkkBOtT7e3LKAHd35BtxKQ03qU+pi1eVG9qYliLTimgZqO9Gx0EqZ0lpp3UWo0YfkQPRJM+IZWpkIOyWXLT97tjr0Lj8tw94W3z77CYMXqXa700P1Qsdinr5A4VtQM/gApAhFtxjYSNjj7iMvjV3D21WF9da5VLYzeyKt03ROwaHJb/kq3+YdMw8a5487eVdFE7QLThn26jfjNXY8jCeq7GJD6i/hJzdV5ALVlnfz1tVMuc7IEXZ6EwvP6OaMaB/xMP3fw4wBaxFqkz4baoGNNQZjhIwPC2Ow5+9lDQP8kUfl+DgTcXZSjflNxBy4aENRO2C/OJwuL1JkBq70DEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TEPWf1ytHq0viOzo3EVzU5DvfGH+kzZlxdPryKfmro=;
 b=Rkmjye8DzmHI60IuoAx8m+mghOUdx29dKL+JhBJ4ykFS3+unoPFk2bmgtzAIyYOy4GjebfXyCWa8POUHvyAPl1Oj7UoQmFzweN5GXh3cy7MiaH8WQditKR/AiaM6HVLgcoMQxc+90I+E8JpMsYA5t865mL1362WCmJjakFsvEnT/aRnnNcTkrCKkIFf2FM14dVjClZFkw+oy/+hJalEHtn6eDzKGSxXCaVu3V1F/R9IMLgQiIkJpc8CPsGmXsZiN8S1BP7iey3KARwIUgufE5nfCKKSvMfTZN1npNXbFjCJ9PZRpeDdtAO3gJG9cNrHvFV+KpGAkrsexwpe4qiMGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TEPWf1ytHq0viOzo3EVzU5DvfGH+kzZlxdPryKfmro=;
 b=r8nYnNSrzvrSK5ioNPe17GSx7FkttR0Nh/WMou9xi54Rs0w1ey2uOb6C7iM6xejyzFSRvf57ZL3a94IfbKqQi2WlHFJClmRcdEJUD79sDDDP7YtIE98FCg2wF3uTn7V/vBF9K8necmqYe6meW3o0gW2F5rBf/E9598bBXCmCuH8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 18:12:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%6]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 18:12:46 +0000
Date:   Fri, 3 Nov 2023 11:12:43 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     syzbot <syzbot+ec9435c038e451be48ff@syzkaller.appspotmail.com>
Cc:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] general protection fault in __hugetlb_zap_begin
Message-ID: <20231103181243.GA19832@monkey>
References: <tencent_E5C64B4991EEF2AEC68C80A7DF86E092CF06@qq.com>
 <00000000000004515d06093e225d@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000004515d06093e225d@google.com>
X-ClientProxiedBy: MW4P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be7c640-82b8-4057-ed85-08dbdc987b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9gqY7QXVD+inOjn1w3y4V+l6cIgkKXAQKLCC99GL9WtkBSGFKRL/Z+mUiW7wLpYYda96f9ghWSwDny5Yea+IiTgKM207IFFeEpaMSIbCFw/nvq/lQ70uHTZXX88aMw9MIuyOD9xF+Y3+Xn302fEKtJBoBmFJENwMyvbwCFpcBkfyMFllYjz/aQLq2jVRqINq52c59lZzxoEM5Levg209mB5NyXcQqx1Udn51G3UxGmbhCkhrIZObD1sORCa2RBpX20dkgbepPeYhjU2e31Dpt00UMq6NFoLn94/RXIG++G1lVtevQT+YvbyLppYbC4n5u15HuLoXdC/Rw4kDbCopUAvTtmtvttDjLJ4OKIL8uu7Il8IhRKzldjDXsZ6Tkw7iaoXxbgZyiRZyMl/1eUU+UcW6yDFZluloeNA4MlE15re5ZOd/5NPHyYLhTPNbG+24aF6DZ759iVgCl/cuaHXV6ipWGI9WSMLdvqWWyWXcIuqg84WP2n9em0byqMIZP2feSP60rzXDbILhPn+ik1Bi8X5hMEE5NCqXfMyulPpLjSDxFg5dXyeEfZBhilaNNBdJ90MMeiO02wdBcszeSPdd6lsrphc41cMLTCbAe0lEoToh+1KESs/USxKjACm9r7Yz5JrmCaSfOzgP2clcbXJqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6512007)(9686003)(1076003)(26005)(33716001)(966005)(6486002)(316002)(8676002)(8936002)(4326008)(2906002)(86362001)(41300700001)(33656002)(66556008)(66476007)(44832011)(5660300002)(66946007)(6666004)(53546011)(6506007)(478600001)(38100700002)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ft8IrrTbwQYxot22cypQC/VSee4zcW0Z6YMitPVU8N0mySLp8mMFOiW9EW1f?=
 =?us-ascii?Q?CylL7Ult0FQDpIkQsS1ruhuErt3EWsmDF5iG7LeAch2D3hyQbyL0hOSbc55o?=
 =?us-ascii?Q?fBE3m1NCm2V1AzUnvxhYXfI4iQ6mDHx94tD79NDViBrbIIG1p5GgZqECcSaQ?=
 =?us-ascii?Q?jYlsAo3/sebNf9dAhUgkpC0O32cHX1sBkeEfuZ2lizZBsIYJcJxHdYQCd0k7?=
 =?us-ascii?Q?XWWcIwX8yUEPWtlutk8G002VhUXlx01LvIoTKPF/uWKLhJdRqopS46uN52Au?=
 =?us-ascii?Q?Zw9mppQYMdfuF9Ok23Eky+WHwh4h95Rws0V8euv+5avhTBi1EWdrmSxvmhz4?=
 =?us-ascii?Q?RkBo00TOa7Vc8B91QFk601mb0l323G0AR5ZeiaToZhLNso9FFmZnCS2willo?=
 =?us-ascii?Q?eaUz9AMV4KzZDxFihQDT+WX1zs7upTsbXmaCoUYqSh1OuRfOE0bMBnbQj6ZP?=
 =?us-ascii?Q?8KYgTXtSP6CCNcODOVWGtLR7OwYThddIbKR1GEZ8ijgG1uEBHoi6h5UG6n3u?=
 =?us-ascii?Q?IRkTc8j1/pg2eNjVRaVHebZv6CykrcwhHpyQTeKRY4N8ago5xub9AqIMXhhE?=
 =?us-ascii?Q?ZOGvKL+/Rv7KVTksQIepXPJuZGDk4taBg8aX7bVOuNXFshhEXY8ahwXUdFof?=
 =?us-ascii?Q?gQstXH2wXQUsTVj0I2X1u7A+lbgxsOZ2dycltEL3objb/syL0Vtc5Fx5DElu?=
 =?us-ascii?Q?x7iFMxkw0VHJ4rZAin1kE1D9F71eilLoTFAtpVwjeYHjcwYbmQPPyWhiyn4/?=
 =?us-ascii?Q?LsmYuvXsXmTQrdYIOnrSHdbhwYNXeisRtmOK2iLiMi9H5A+lYubYLYb6JhKP?=
 =?us-ascii?Q?aVNMRlHLw0kiSFzIl7yxn9Jzue7Ex2g6ArwNwBw0SbEOOc63RrDEONMTw96Y?=
 =?us-ascii?Q?C/M+AG3w0e0LVMU+/DctXzhaMKbhr1O4FfCL4PqQ6GEueqM+DB8fRqDI3xk+?=
 =?us-ascii?Q?SMxi31/0+BreGyJL8AuY4F8boSiayN0kL6FM2huTG2Yli3toAo9k2ITo+sCR?=
 =?us-ascii?Q?RBWQH5yhXS25KuxoWEXx606r52n0uOFVahPWU+XQ2LZwLepIEJ8vFsKpwbcf?=
 =?us-ascii?Q?vUxKODCdhb9+C6jyx7KIasFsS6yHSUj0g2/FBnyXFdTfia8g1CamljAlgNNO?=
 =?us-ascii?Q?HPK8SXBVEYE31J++k3lv1wg8nPFsgYTlmPHKyaxE+NQnjevOUQOO9EE5+PHE?=
 =?us-ascii?Q?quB5ppw/y8Yv0YsekSGSxtICTLqS/ZX7X2Q8xr+axJzkB6abMd9uC34j+3Ak?=
 =?us-ascii?Q?4COAmnQzO+zMz2CzkdUb6zxcosy3W3ZV1sQTX9YCsblo4rqa/Yp95zbI/2YT?=
 =?us-ascii?Q?7Izn3hvaOY2lqUl25XQgWHt/ac22lHPK/PGo+GqkHJ72o/Wi9vvSnvzaBS+o?=
 =?us-ascii?Q?MNkCtB5DPus28sPlHjlWgjQCw1LI79qTDwCYdbdvWABRu7+aTJP0V/5Sc4vO?=
 =?us-ascii?Q?76/ObNViMjjSQnfCTq0MwxCC+arSJc8hPuzv+nbwM3b53O9Jvi12MH+ZQsLd?=
 =?us-ascii?Q?rQ9zWGfyxCMeLdesY18qvdSjMlZI7KvIzCXq4h5gNpHN4iEYD0MnNSg1Kitd?=
 =?us-ascii?Q?Fs2QZwdOFmJ53o7eBGOZSff/9VuE7CtSHAY/w7Mc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0Q4BjVSZ1jPWjCWFuLIUZyrDi+X/QASGuVIpX4u89Fu9+JEQC+kDK47+6/Z+jcMbthydxhfcgohaYcRJhSRlw7dMJZ9QTE41jd00jcWzzhAZ84MIrRaG0C0pFwnEibgzSKaKoNUVG/ujP2ewaOdiO0siDE4tkYnjNBLAeTph11iqpEbRg4kkX171HDDIiZVDIxzzt44JgqsEzKDG0SitQ392+a1aryjusGd8tYPkw0elbVda2l6nTwqTnTo1fxmvsy79iyQhoTMBql1PNqWFEnSTsrMtXIy3rR5TluFP9oCFRrdaHD+GHHVyJDKWN6UpYQENyW7QtFHqXVsxqPoTa8cW7eiTHktmhKArmdTuOKs9Gi3WdN38LK0WJhE7cFTToTESzrZ7DuAMjclu/Vey3reRikB+Z2y0FdgFSZItL9ZiLZGcqaI1nwBXBNnJj3Pl4jfhWVZv+fgP5Tqp+ROWhyKNfw0v5Xj/EcvG7xW7SxFYYUDedtKUAyPPHxQj7y732A2Tve93MLTbZgcS9Xmt2xNltkDKODyEOp5bZOs/M7aQ95cixPg08nj45jVDIZk7Gf984fe9XQFURlt6+RYHbgQLsanZ/N/QeF8vsy6urfbVbUNsipe8CWmI1JwY+iwLftyhPF8pV7+DDp6We/MN2IYMdyeyWZ+FEZ/tNQo8KqhSQ8CTG/c4zqXnLC8w0096JsoFaeYCuFJ2NwnsGhyYDUmEQcl4Miylog2giHW03VTf4dF+co/ZJ525Js1ICygP0oC5JjQ8qoSfE3n5ndloEFb1gFczRDdMaXZMeT2GQK4YgEekrrgnixyTjlpy4d0qETxmN9k2YUaFW1YrpEsMSGyoMJRip8BrGGMz0cu6z+F+9w452P2f6ArdeUnByTqedYwvl6vWIW1GbR29rj8SaQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be7c640-82b8-4057-ed85-08dbdc987b63
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 18:12:46.9098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBDzs4+JaKpnZ8zsMDbsLD6rVvFAdH2JaSAGJHWfdDBvqNCsvkJ5p8jLjP1dfMYRGWoJcZvt9z1CYOVuJJotQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_17,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=964 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030153
X-Proofpoint-ORIG-GUID: nx4yETUY1QamsbwDvkK5EUq4qjI6Yyt_
X-Proofpoint-GUID: nx4yETUY1QamsbwDvkK5EUq4qjI6Yyt_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/23 04:52, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> general protection fault in __hugetlb_zap_begin
> 
> general protection fault, probably for non-canonical address 0xdffffc000000001d: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]

<snip>

> Tested on:
> 
> commit:         2dac7569 Add linux-next specific files for 20231018
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=14bc60d7680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=29e8e23689e6210c
> dashboard link: https://syzkaller.appspot.com/bug?extid=ec9435c038e451be48ff
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1088a55f680000

Unless I am missing something, I do not believe the tested patch was
proposed for the general protection fault in __hugetlb_zap_begin issue.
-- 
Mike Kravetz
