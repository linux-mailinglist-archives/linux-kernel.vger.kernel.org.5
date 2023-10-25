Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8311B7D5FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjJYCWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjJYCWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:22:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6E210D9;
        Tue, 24 Oct 2023 19:22:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OLUTLq019752;
        Wed, 25 Oct 2023 02:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ox4ESgLqEze7+c6ekrFZKKtlyg4srPKDKfzyqhVw81M=;
 b=2zNP5S7PHR2SnxpgzVHIzMmy3oopWdffyrP1mWZhr91AXmwJlWDANgIb8vzauiOLye3h
 yTTmsy4fdoYnPZLgGmSvb8yCin5JnJaBBk4U2K46ZmFqSDeQxDrBdHX2DPh81ttE6gYy
 CDbtf2fDeFgAxPfHs9TbgtQIbINt6FGsMw6OZR8Cp2vs3N72ACFNp6fD9wVkuLo9MUXC
 csjvRUb+/2kltzbWLfUOjydF+aL32KoREQNzcn3Abic9Uyis6ClZoBmmXDqzdQxZWgOk
 RHnOZbc4k0/6p0Phk8/YJm8ikdivi6zgzM83krK4/BKsVDouf3hoBwuy97seLVQ2hDgn Bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68tepwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:22:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39P07cYn014154;
        Wed, 25 Oct 2023 02:22:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tvbfkahpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:22:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCL9ptIXh4ItYJhzHavMcEF1iT/Qxo1xrHX+vNdIK99SxmpSY9odXBXkqIJ2Fzb5p5fFKAmojiC9d2vauOBWYkIMV061/Qj2i049FvQMuErQX4GALOcJMJH0jzrLoIZiRFemZn7kYSChgFaxRJ7sJSikl8Tpc0kyqSccUY9E3VcJjucfW36eIUVhp1a655Ovpkoyg4qC8rAEf/fhYrNnweLRxZ/Ex6j4wD21j5Nfg2/VyeJHr6Lb4gedzghDurnUwD3+9LVMJ7y1LsOAcDgTvs8h8jSCdygSmSxuR6dHnYVzBNO+Xu5xgFMQ1ALqVcvEouYQonXw/Pr9L6IPA4jn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox4ESgLqEze7+c6ekrFZKKtlyg4srPKDKfzyqhVw81M=;
 b=FhH0s/OXTseu1g37/FNQE9qkyZuKBulxrGEL2Q0bVLH3aBvbuMSy/BaFSu+2pVokUJNLF9FkfJcc3ZPsl8sw7RWmRgxB63/EQVpXd06a6zz2rbExdNsdEg4ghIGASoFH3yYVA+momVus5Kr33oa6NtkY2SYluPdt1fBcnJRy+RLRqk9do+eYkLeFo+F5YeeLSn4yuIKfI9Kq0srxdxTj9noePCSBv/HYl/90qJ4LlWGYCwDPe6ntZT03dvlEobQDE0lyMmgI/czzXkFt54vKQW24eaJTw3MkG2zVRA/Raxlt2x17PpotCYCRDROndt991QtFgj6VxG3pxZT1kcxMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox4ESgLqEze7+c6ekrFZKKtlyg4srPKDKfzyqhVw81M=;
 b=QPaBK2U82i+yW8RRKPZg4K6TG1Aj04dPDBs7tCoJA+opO/LwasUzJf2D9DleLvgzCDsm+QReln5cULql6B9fTT3SHh/d2sV3IG+uJBhclPQ4yVDWVuSmBd7YXTSFRU/SoF00n1w91LBoS04ux/Eugy2z9r6JI63vzlbsc5VQtVg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 02:22:10 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20%3]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 02:22:10 +0000
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] scsi: pmcraid: Fix some kernel-doc comments
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cyx3fnlj.fsf@ca-mkp.ca.oracle.com>
References: <20231017025853.67562-1-yang.lee@linux.alibaba.com>
Date:   Tue, 24 Oct 2023 22:22:07 -0400
In-Reply-To: <20231017025853.67562-1-yang.lee@linux.alibaba.com> (Yang Li's
        message of "Tue, 17 Oct 2023 10:58:53 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::43) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BL3PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af83747-8542-449b-6c2c-08dbd5013149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYCqekyNqHUPEjxroJyAIZqQJiZxqVCyg9tSmgjtOxFwmWopEDd4aaKySJCwqfjPToFF2aRevNBHZNvPFHmSutM5NADwc+XeKOI0Szid5V/7rK+BJwvccbn6kT7sisKND39gL+KV4GYQJPxZ8HAL5nfEs3SCcQM4Y9QD3b7JFyz10gHPycmDZCNA5c22rsXAk/HDVphdLEkKEICWHna77EnE+jef49teopd7YsP2EGuxh65eS3A4eqFYyrlH69elnYlABKXLZROi0tO3DT0HactN4RRM0MT36z9vqGSS5BVQ5Bx+wMPhQHuBA/8yNnvs+7BK8mlrF+JazmI36vPBVI+NhLm7bp74D6KFAkOdUGeEodBHPJ5FsP12YymPvxIFxXdR6cXEw89jjyKR6GfU9DsxqrPpCATY1lUJonTS/x/1Hvn6R4tAa04StNQurVel9+5sUhc6ZFUkbFQg9Lv/iLyA3DVV+bgD0AcGlE3NeM4kuv5rZ8uwxl+UnzIXzr4t3iEwoFXBi2qR9f3X9Hqf+gBaXYn0OXL2QByRr8iuqsnKcc2J7TouK2Fv1UHZ3/QI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(83380400001)(5660300002)(6666004)(66556008)(41300700001)(86362001)(66946007)(66476007)(478600001)(316002)(6916009)(6506007)(6512007)(6486002)(36916002)(4326008)(2906002)(38100700002)(8936002)(8676002)(4744005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBuNpTitQHT4PfLNpU/Qa2zPaKUVZ9t53T4kT4IcqETwr2C4Hb189UyRRxE8?=
 =?us-ascii?Q?N5KlKBDmLxnkOs1+lZ0sYIjV8ABE8YapHhoLcVVqEOo4nGelqIBpce3+i6Rn?=
 =?us-ascii?Q?OCtpO9W7xPr2lUx/p+/iM9nrVJdVOoDYsw2GWQ/QhZXcZpw6IY6wzZnJxt5z?=
 =?us-ascii?Q?80mxqgha9lGqopEEHlS6o49pz9S4WcleK2rekX43M9B+fxlap1HqxD38Q4eq?=
 =?us-ascii?Q?o9O0Hh5UtMT/ytVIm6D/1lEfycZ9Aofkxthydl3gE6F8rSYKWjuimqHT8XKB?=
 =?us-ascii?Q?pmO61B8dRumteqdZbDUkj9BTqi+0iZrjNrsUWuQqWZPb8ENiItI2nkY5z2JB?=
 =?us-ascii?Q?Utwm3t3AMAEJBZ34sSenxapyEW195/aEUSDm93gYQ8vXdVs9OovuVx8Bmdq5?=
 =?us-ascii?Q?uVTc+Yk9LfiNK1TkJZG898xIqP7CRqsJXLLy93GME/DvrajpRM9W9arUbngj?=
 =?us-ascii?Q?OBeKo/HOmtmAgmAZ5OUDr4nWzAdSPNvkspugY8jprsT+bCUBvKF4e18YW+TP?=
 =?us-ascii?Q?vzOB6jeEsYoegLV+FbiLbbUc6WenkwEpyh88jrINnuh7J+kgYDUifQhCH2by?=
 =?us-ascii?Q?q06rxJlFu7+5knTVW569+tY1JE/18EBzebgrDN2+vr2gO3DrWVy9azIn3Jii?=
 =?us-ascii?Q?axOqW11952tbkQTEPn9hSoLu+laIdvnCY5UVj6amgFE6jAUk2EfkGLv2/nhY?=
 =?us-ascii?Q?WOU0GqPzYzQiZ9haCzzR6U66nL4StcmMx78Zyw2v3ZUCaqun0mGCk8Ai5ZoB?=
 =?us-ascii?Q?qZDK4EKiiYsGUUjCPp7DNeOOi3IP5sjYQOg1jFLkOgQahJgpeUTdMVFISQ8I?=
 =?us-ascii?Q?7zzvmSooBbPe30b4Y/xGslXJopBxZc27HBmoJ3jViQ/gIbjk5jQNH9YiLVDg?=
 =?us-ascii?Q?OWoUe6Qzlx+ySizevqMVSzOPlig5gSu+5lwxB3CyR2UPXO9uRWSoJcrEMpIL?=
 =?us-ascii?Q?Yc5vbFBIMI4XqaKWdcX6WYmPGN8za2EwX/RgKzwoC2UJG7VNLmQ9Nv4wFWZP?=
 =?us-ascii?Q?tM/JEOm88/3genf8qTyLulPiwNeuZ1urZf2RabNM6oWNsvcChcIjSlHnUxFK?=
 =?us-ascii?Q?ZXr0k7/YhwkbgYdHiJBzq87fIiH5AmZCsEiMlAHDuG9BImWCCtwohzjLRHfG?=
 =?us-ascii?Q?zL6KChRC30GPqOU0qJqAQyMIUOGU8tP5MjSSKBDr+n6Pv0LJ82HZ/mTGJnJa?=
 =?us-ascii?Q?eD/nULvN34pUhXy+Ft+W3jrgsWP1Sg1aFv4X24BCwhbX/L5vSX9mV+gYYKSt?=
 =?us-ascii?Q?yCf0E6iSxiLJrGsuVPPsjaIUvJBmj8r7DpBFbBNLVZ13eS0J1GY8B0rsp04b?=
 =?us-ascii?Q?NSZyGuslrRpzDsLY7vO0VES1NEyjKnrzO4uwCE6uVPvywSbhRB/w8lIzvLyH?=
 =?us-ascii?Q?MYK5+xYmRaOahwZ8mw+m2RVFPtWC5dKqh8AMVxjq9mnDs/wkGuDQToyzOyJu?=
 =?us-ascii?Q?zrVqsOvTRBDDlOppJKzWwp7/Xav6GYqcjofSrrkcaDJzSaO8phkLZKTpEP5c?=
 =?us-ascii?Q?AR/LwlsElZCbuEy/0D2NilW/xvr72v8S3dCWTTs53jlVxW0YjJPJnpth7EH+?=
 =?us-ascii?Q?29WWXoS6wUcji+404tIozEHZSr8PHh1kof1OnEw2yL5wrlxDVG6dUA6inQuT?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S+ouVkWe4yBRnuOgnyk3U6vQGCBDTtqjtXuUhTipggKEaGtv0ZiOx+KEOCcpcMUVhi8fheytUxrNcMrqwdWLxD7L3AfkVlQBgSS7PKGE96g3eJ322lFJjcjecf1+U9hMmxy18G8GuMnPC0YLyMlkaJwnImJazxjXqVVh9oRNfuF2FU4gMSbrItzQ0wHxMHtfQQN4wNLLWlRhMH2at5lbhGgeq+HQD1yA7mzavOBxbaWvTRMP3RsikuRCKeStiJlUaHVivbkv92AvS7T6QHDC4D5xLhHq9K0abgiEkajjjjWlSpVknUuMtZ5mo2mIqWNkHyCUNm7tvXPSBiqQsAqnMuWD1gbrFYc5HGVeCy/IBIhP/0nCwLPaN2AuEwsx9moO4mqnI3TTKTBgmlXm+WdCUBgIfbA4jZ6Gfuy0WiHd0+2filpr4cNwxJm9ce4LYgIy+FaYcdKsj797+e8I+H6P5U464anr3aN7EV8eaXAraBpdFT2X2NXU7nDuORoB7nAn3JmkMSCY+KXfGbEGpubphmyf+OGCi31geGVbfTQa/pRJEbk2gIw8UdZaNKSNSB53N0WCQfBQL9VEOZcy8Ki+9Z2yxnBnQvLyMvHxKN8xWooK/pazkUim2dxdNAlfZ0qjUehzXA5g5QmJtzGEZUNEr9lFvYJqYqBZMj/qQ6NEaMAJHoaDELL6wPc+yEuFEZSP9HAtqVPbtCyogpeSWaWK9chGE3Hrqpgtf8wJpSIKyCZPblWnE4ZJwu/83XEtHqNnrIxFJ9Pq65VftUq/02jskvEUdUUNy0lN57SnNoiXmPbT8lrJtJz5k3GG9S/PpPZfj/gnQoYGx1GPHypNFbCiQ8wO604GkPrf/mzK4I+kr8I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af83747-8542-449b-6c2c-08dbd5013149
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:22:10.2774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7i46JlWG6HS3Pg9cWj64507xJeSogqZtJfIYWF7lkbGYSdt/2yqkIl7GCY9s1PFS6m5QEiOThF/IuhER29FndFm+ROdpFThb2yHMSy+tPgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250018
X-Proofpoint-ORIG-GUID: QOBUiyKGUjtxkooZxpa9HldPBpLWxY-s
X-Proofpoint-GUID: QOBUiyKGUjtxkooZxpa9HldPBpLWxY-s
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang,

> Fix some kernel-doc comments to silence the warnings:
> drivers/scsi/pmcraid.c:2697: warning: Excess function parameter 'scsi_cmd' description in 'pmcraid_reset_device'
> drivers/scsi/pmcraid.c:2697: warning: Function parameter or member
> 'scsi_dev' not described in 'pmcraid_reset_device'

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
