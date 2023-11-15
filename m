Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649687EC83C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjKOQNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjKOQND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:13:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636BBC2;
        Wed, 15 Nov 2023 08:13:00 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFG1wmW017446;
        Wed, 15 Nov 2023 16:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=EvMqOw3WBKC6enPj70/lAFSGGI91IAwvZnPmWM1l5NY=;
 b=dmVVUR717LfyRiRMesBz9qzW7migwmFbzQ8Pss1f+xSN2rzjccS3drSe5JixzPFAUXLz
 BePtan3ABA5i/rwVzvIg3RF5Wr/2E7nQbdxuv67mcsiFjdS9uqD6vymAwSKMEN8JEBQ+
 +n21AIIVoexsAOiljmNy0tZivCFB67aK1bDy4N9y5FlqO6lWb8MuFvLvsM9CsNHPn+jx
 jhohn4HTQRJ+TbmmC+W1T/9OBhCqjOEq7XC0i3XjJ3rC6lBUIqcZUhGfFVJo69UZNP6M
 8JXbwqDPoujWykQKUCY0k0/g28X2ZORR7Y/W3HVdQ5joEOs5TTbXDI91YHEEqhZKJpr+ xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2na1081-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 16:12:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFF9qot003972;
        Wed, 15 Nov 2023 16:12:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxj43jck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 16:12:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwa2DqNSz0nfJRisvzUDF2sXaUmOycr+OR6I3spSMmcMP3gA9CZoz3NtV/QZOTEpcdbIdGmII4nJ3su76A3to9RUOQ9zrtmbJmg9VKEc5eCh8uCQU/D2mU8KMvSO9QvZnEo2Q3pyHKOQ1T6PYqhg9X3OghEIUAwWC9SFjbflMlFCI/ULJ5cSGp6JSQvS67j5Fj9Bype63y+HJnOvJ+f5aHpwY6vKnCgsaOJ4VCTLvUJDS4zU1G58kVHTGJpS76BzxRc/p3P9qTjqYIBKMdAV080yzPoUN0zX//1QcwacfgIMdifbSuYTn8hFxlqMGfqBZmeumgriF3fhGr1RDGvAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvMqOw3WBKC6enPj70/lAFSGGI91IAwvZnPmWM1l5NY=;
 b=NNsfJozglWT40+HtOydleavHvuPTkm1vToYXz8KhIGw3/3OKqJftVI/54+eeuO0lvc430JVzTEfZ+sgdwWLbjR31d4tcxOO4RVsC8997LVPZABg5qCMNZS/OFhVlN6b+vltV3Qi1zyw9rUxG6gjiLWvBsBw+QFlpdu8bSKnMAN1kzdmh971pxrxGTOdXNuGv+bHpdi+PUMWEqhsQwVuJTaYcOJ1OYOm7WgszR6qYSJxJKMzjRbvOCl0xkEMlIdKa6xShVAZWZ6qHJ34kjTIJiW4ZEkgpqqo2K1pAUYf7hjr9tuetE+I9SzWG9ZX8beBMFI+pwfjl0+G28Y5SeyhFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvMqOw3WBKC6enPj70/lAFSGGI91IAwvZnPmWM1l5NY=;
 b=IMWoOI/P198rJqtgF3AcHp5ESUd85R29fWW5vVkz8lBbfDi/ediiw0O+zcJINTzzshQ2E7ZsMXgokjYkFRkOiowtEptL1trFTr51ftlJpUrc0WVJy1+PdLDQYlnWzAPwjp6+qlUsYNkf97D9BWgbRgBNFvrQeMDd+gDvkZpg38A=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN7PR10MB7032.namprd10.prod.outlook.com (2603:10b6:806:345::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Wed, 15 Nov
 2023 16:12:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.6977.018; Wed, 15 Nov 2023
 16:12:55 +0000
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc:     martin.petersen@oracle.com, bostroesser@gmail.com,
        michael.christie@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: target: Fixed multiple typos in multiple files
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17cmj10bl.fsf@ca-mkp.ca.oracle.com>
References: <20231023105915.29482-1-m.muzzammilashraf@gmail.com>
Date:   Wed, 15 Nov 2023 11:12:53 -0500
In-Reply-To: <20231023105915.29482-1-m.muzzammilashraf@gmail.com> (Muhammad
        Muzammil's message of "Mon, 23 Oct 2023 15:59:15 +0500")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:208:236::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN7PR10MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: e62e0b2d-d9ef-49f9-63c9-08dbe5f5ba2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRxK+p6Ih4TZG3/eedbnPR2dFVixI4V/8T9Yq5DXoEIrtAJ2wOVJOQVzKvlCFeCZHuzr2KytAk7+jxXLrpISeRvtjVEYMj7K4cOiDzpqhqz644bvEcYUPa5v/luwfaBnSOsRLZu0ONZJa1w0Ep3kX87ry93xLGyCb+y2mE759Cl4KHBYwrhJ+FT/aBbOfUoxcAW4yNFjzTfHv5evAu5awUzAnUHvJ1c+w1AhB2aw5L2E045dvC1hoUiDp/f40annB5ns6jdvUEElvWLo0GNRFq1s0iJKYuvmkIttvJn+/7A+PAfwz/YVvm7/KXw+++z3t/JCRTJUkqrNsr6lzzHcKfWEXbIyjgbJLX1bJoyw5QLbhsHkD//httKzCO+iXtMNpcuFgZB1pzgWJG3fw/NqRnerO0+hPQpp08PPYAHNWp5RqWtN7cnmA+NtpJd+g25lz4mRtvEElTaDkDis2cPWWmpl4n3Jg6EJSFf+js06WtYVWO3GS9ev3N/cZAWrNdIeSay2iYaRSye+xzqXKnHbiUu6QtTr0kDQqEjUsx1jKlesUNDUlc5P9itq/XpWzJGW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8936002)(316002)(66946007)(4326008)(8676002)(6916009)(66476007)(66556008)(2906002)(41300700001)(4744005)(5660300002)(86362001)(83380400001)(26005)(38100700002)(478600001)(6486002)(6512007)(6506007)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fiGVDOlILerFDnIhJPLBNdJUv2lJVBAtZVyKc9FhESrBH64efaHUsdv6OV9V?=
 =?us-ascii?Q?NoX24ZaFXgMXRnHNKJokxitnRZtTjpZ70xx3F+Uw9JVCCsBTIM4LEXVU0L4I?=
 =?us-ascii?Q?NdzJlf5C+jiKAdH78UOOdHVFdswookqDx3jrkQfHG2F8BORmEnLlvuzrtvqj?=
 =?us-ascii?Q?/66He0KnN5vKJBduNhC1KCTJIfV6wqwzT5iXxUs/RfFot0CIL1anIvraKANu?=
 =?us-ascii?Q?PrvPVD7LkbnHoYIbTmTrmmWz6EkKGQ68mSIrhFTTDNoBeqhSxOog0ftYTJar?=
 =?us-ascii?Q?NO7k/8DXHsrydtuhaRguTsQM+WaqqXGaLxAKw188XP2I81xNxlns/Mg/s42E?=
 =?us-ascii?Q?PlQFRIrC9GnCP9zkVG/NZ+nL7BS5kHmEQcu5q+tMMFQAJlTK7yzHYBL5eiqf?=
 =?us-ascii?Q?cBKzPRXmJvP4QBYSmroFOgx/xjdemy499rtf3PwFRVnSjBnILytqZNKmqp99?=
 =?us-ascii?Q?M/5LvWq6ovTkCghM6nr3ERNDy7AKtRv6D2U6wepQjSPM8+gZRrwfR4HMV73T?=
 =?us-ascii?Q?7U5Z2Dq8mWWdzBZKWdlBXSkl1YhXJ3NRx3Yroq3DGN7RjhdvZJnjCvPI0XpS?=
 =?us-ascii?Q?DyYk4dAlycVBlaWs3HhyeZOWb2kzpRF8QhdLUCSklLUStnAa3iV96LdUZ0/p?=
 =?us-ascii?Q?Xy73VW8QC2L74L7AvAYj59AS3+qSDWjCyxZk9a3vAyk5wLZhMhBC6rF+OBlP?=
 =?us-ascii?Q?L5BI2DEuPAr9/qGIO6Atgsfu/l+Kg+G0y1N4L4EwRniVRehZgF4UGEAvYeWM?=
 =?us-ascii?Q?E68ynFqPmzqoGL9WpKMaTHb6nx/9lrd0I9ei3ON4Lc9x6QvkBbTYMoBGcSAG?=
 =?us-ascii?Q?zBch08Msz30eVNJf8EjjFGDo8v3z+FLsLj4LlZpA014Ef6JZcYAjgwMp+4Dp?=
 =?us-ascii?Q?gz7zfBmEommqxJOVbL8lSRi09JelKr91sPNOqkdHcqao/Vo16K7fmJgPiKMJ?=
 =?us-ascii?Q?uhe2P03a7qSNv89BlLg8CvJ9R5ZObgADG1fXgxhzQTUxoOJoyZpUyE85BkKe?=
 =?us-ascii?Q?gOwr/exAndQLRtDk1uFBFXbxl5HxNAUkprWtE66DpSGNAF7iXyT7iZMZCu8V?=
 =?us-ascii?Q?N+AMQoVf6mKHvN2VQNdfL57JEwPw+Q/J0K8U0UyOoFjNHoeV/+CVaYWtFUDX?=
 =?us-ascii?Q?npmIcmPGRKAitxnTGEB0sz2163FIQUcNjieBB/3vs29gcdBTRJBQGnPX9gL6?=
 =?us-ascii?Q?2bwIw2GRfmST98HCChbyytH0Pd5Fp/CZ78HUwzuiEsUrvnILrS8r8oHJ/LfW?=
 =?us-ascii?Q?IrS9Yl0UgDzn+JdPr06USk02CY1SMtInpKjneU7oMlJZV9N2sTsc0iy+Hb5E?=
 =?us-ascii?Q?9ToDl0gCEJTM/d10mR/qSTxss/GeGhM/y+sToFpQOsY7nczDSPKorQZAaeDe?=
 =?us-ascii?Q?2IXEzgDN2NF1cdtizT22RbdHFN0FQQBA2RdEGUsPBXsGyUXxcvY2M+bIZsz6?=
 =?us-ascii?Q?BOhbXQd3/iPU3WGoXB0SJoYBb1nKKx34LaUfl4xthbQ64ywVtyFQ2fNCyLfz?=
 =?us-ascii?Q?qGJo0Y0Hnb3xk2bubZJEX4rIRPqtdHK/s/kP5cP4NGtR+UqcJnfaIA2hEjIQ?=
 =?us-ascii?Q?XAPtg6A/opS8Wb5UN3NjU4EgzP4ZU30L6sz+53k/FmtzkrF42fdEw7kpLqCA?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BK9ZBfZhs6NtrGtK9y+ZSDCI5eUks1MTXFEZpA2B9v+dUAsZXMnMPYE0Wao/MZztsAmy7KvpbeeF6VPeSuNm5sSHgAereNS0m4TdNrUJ5+OcfPpkcspYVhLfbfiDQ+KSphX7MrslZ+ELi6fwZe7O3lDs2XF6mJoA4A2YB9GAtYkZ+Ut2+poXffe0Xv1cTET6SC1mWT4aZzklWQ6q/yrZ/VICwOoOSSRm5mDxOFH/d6W4+MTayipPIGNCvPNI+NN0kmqkcnzzrrN+wCqDzt3+V0M08ylP884i9mVMhqnyqPJOJRY+BNwPW7sVYRKbliW61Dg1/Y2GMnboMnVzOTZLI8FEGAAC8RYEBZUiMDNkULmdfkYt+p1DcNyTWXyMavKHhLPEr3TWwTMD/r6jMgDgkX8zHLGhOAWJFkFOIkybKM2jc/MYydjhfR5jKuEwITYP4pxKCwToL3xS2Lfz44GXeVIIBCQ24jecVavJm7BYJG4sNePWEYdq8bCkh9cY4vBr44wkW5A9av8gQsEUwMlNp4x2Vj9EfIVIbTvZJiIq96UyxnoKC+3J5b5iNnDDgomF8Aa27HZKiuEfgrLrtXnNWneHWGbYjv7En08idlvrGfRILlZheXTGNcVpUug0OPW4kZx6UdSwN9o+iE4lbO4ixxaqNC+bWySvOD7UrxPkKAdoiN4srpZrfZuOj52iBgOBkSpt4pgPefTzuESl9I/6PFzX2EwENqxERaHf1QvESjxzXp6pwB8fVPpGlPpGgE40oHXtDc1jupFq5ZY60Wx+1OswDF852MYXz7FoltA2XMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62e0b2d-d9ef-49f9-63c9-08dbe5f5ba2b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 16:12:55.7335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olpvtDb2DTuebEPRP6kzXJ+zJaWIAjndvrxJFH8sB94XuyF8VPdtOLtbb3l6kH9B3LrUdvcBxAtx539DweFNxHbae7TjNCNUXbJNgfCBPfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7032
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_15,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=971 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150123
X-Proofpoint-GUID: DnyxKST1U-GjnwVSmApql0qoO1Pa5o4c
X-Proofpoint-ORIG-GUID: DnyxKST1U-GjnwVSmApql0qoO1Pa5o4c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Muhammad,

> -	 * CID we do connection reinstatement.  Currently we dont not
> +	 * CID we do connection reinstatement.  Currently we don't not

"Currently we don't not" does not parse. Fixing misspelled words in
isolation is not necessarily an improvement. The criteria should be
whether the entire sentence or comment becomes easier to read.

> -		 * status, with the sense key set to ILLEGAL REQUEST,and the additonal
> +		 * status, with the sense key set to ILLEGAL REQUEST,and the additional

There's a space missing after "ILLEGAL REQUEST,".

> - * Called thru fc_lport_iterate().
> + * Called through fc_lport_iterate().

"thru" is perfectly valid and the author's choice.

-- 
Martin K. Petersen	Oracle Linux Engineering
