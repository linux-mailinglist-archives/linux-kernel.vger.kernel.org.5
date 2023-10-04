Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A201C7B7632
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbjJDBTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjJDBTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:19:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D666B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 18:18:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I56Pj006407;
        Wed, 4 Oct 2023 01:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=nR1kDZN1k2WqZLE04D2NJTBVOZWtc0ZEhRKRUS3Ks74=;
 b=t+aVoYQiUEs+vIE2sjlr9Ty4UgS15LTY6VJhEPoTA2/heWT+yE9YGgUgVwUSd2jkigwN
 oncMo2w7cdhAzFRwVVg2QTE9pH+RCHPm0yQo8DhtG9wyCwtIqSrcibLfWiWuTapfnYG3
 ZXo99laQ3UEHPS5LFZ0OPUod3EgAWBADGckQLhD4rZ6fISXMO9Mo6ZS60lGlhPbvwmSv
 s3F14/UN6CQcuUXBIZu22mObzINTuh35JNl+S6etZTXAAPzeyKC3ivglm/xJFrq4YEiH
 a5Jv7He/51OUziVS0pf3o3bSCn8teA31Llx/e1EbHUcPN0Gh6mLFMtrs1G8t7Zdf7cA/ 8w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vdxgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 01:17:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39416lYP008693;
        Wed, 4 Oct 2023 01:17:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47c0u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 01:17:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdTVaE6ATEIR9wr0zCGndGVljcXTG7WresonvFO6MO7HJshE+4q7B6Ggh5b1A6CkBOapn8yGeXVxotS4zp84TJ2WveWlMbnNxbnnfa5q70j4iaO/uCpQYHjPwVvqJGaiGa2/lJ94D8+fxKLAev2fcAMErtMSlQY2eB5f7o0K4lkpDM1IaTqvkHwlZQIF5l5Ogocm2eMqQ6Z3LITGQY2DV54PBfXRog1ljfZBJKw72j1PCrBONL65M8PFq77GLRgirPyeZ9E/78detmOJEMfCbm3IICJJWc1sd9058MUTF78jMrxd3edQlIs6y7jKwM43M51So4WfEs5JATU0OmtDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR1kDZN1k2WqZLE04D2NJTBVOZWtc0ZEhRKRUS3Ks74=;
 b=Fa05FsT/g+fGbDJnHwSpUjtmYfWAJU9o1FZlDRa7o8ImGW0SZ0pwYWp2EjUDAOWo3HjGa/tVNvyADopSWx2esZf+8/4Y49ORcH+B/sXvSarK1NN8xMJnbo86AGNFD2q3ydiXs12EACAdYnzVSBZLPTpMdAzOz2EytNqz1mIUD4Gq3HbLkIdIhizJzHbwRqe0ePduhjOlT3A8zc2CZ3DHkG9TmNElpRzHVYqIUeXtA9cxRrqevjpS0q//8FtE3fwcMXaRxrjXbLpP06kJNhS1hi1dsZQetw0G/nPt295t5Qb9DUILc2eHtnm5kd7Pr/jg784DXo5RDDo8IKlWszM0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR1kDZN1k2WqZLE04D2NJTBVOZWtc0ZEhRKRUS3Ks74=;
 b=eVTZwOcML/tOn+wbo2EZKpev2UplS3kyK2EaI5NYSIU7HoY/WhitkAZ/jdH/PaEhXXAnT1zprh/jviDpVECE8mJOGepo0iHb9YBrVkxuiU3qvmyNMcm5yQGX6B3havehGwR0efLylf/Rz2JURvNclfiwOqrX37EduezULoyqVkk=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by CH0PR10MB4828.namprd10.prod.outlook.com (2603:10b6:610:c8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 01:17:40 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48%4]) with mapi id 15.20.6792.026; Wed, 4 Oct 2023
 01:17:40 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     peterz@infradead.org
Cc:     bristot@redhat.com, bsegall@google.com, chris.hyser@oracle.com,
        corbet@lwn.net, dietmar.eggemann@arm.com, efault@gmx.de,
        joel@joelfernandes.org, joshdon@google.com, juri.lelli@redhat.com,
        kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@kernel.org, patrick.bellasi@matbug.net,
        pavel@ucw.cz, pjt@google.com, qperret@google.com,
        qyousef@layalina.io, rostedt@goodmis.org, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, timj@gnu.org,
        vincent.guittot@linaro.org, youssefesmat@chromium.org,
        yu.c.chen@intel.com, daniel.m.jordan@oracle.com
Subject: [PATCH] sched/fair: Preserve PLACE_DEADLINE_INITIAL deadline
Date:   Tue,  3 Oct 2023 21:17:37 -0400
Message-ID: <20231004011737.188682-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230531124604.068911180@infradead.org>
References: <20230531124604.068911180@infradead.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:208:32d::34) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|CH0PR10MB4828:EE_
X-MS-Office365-Filtering-Correlation-Id: b1782110-9c90-43eb-75b9-08dbc477b3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqkbODpoKDO3dD4ZBcKU7q1bseqx7flLXrcHWlf4iZ+PxRowAnI36gUrXBFxXYE9pvKfOyZ5Z5pYbGB57/2WCl9vuMjdnFFyOcNfQcHwTXKkOuXd7eEyeSuMbcSqDhG9TJcMPp1G1fozITVR+r2GOoFKmHevn7wJmv3vXUUigcWKbjO2UzZp5wTB7tbN6Lu3nAlvB/EQO5go8xTml0DqDqiNTsGg6Ck/rxou7gCsIPrepbJrCgETPi0LoMbk1M0A6jkohXl+rU7Tgd+n1TChHd0mHC9S4tKAkc2tWf7FQ7Wm7L3/x+c6oALT5SHDK3IekSW2NXvYlrsmAQKemFIiHzzYYWOGXUFJ4ztrPUjHBSjtKACxc7Y0lufucjdEOb2MVU9NNH/GFPKvlGQYlMs1dQJIwa7l93Ncrk+kfunjXbGBCnv0DMXCLP59vXFJ20HKmWDENjvyW+RtUT2DCMaNi9ZgEXIqoaphGjIBji7HAZjXmODv+lhpKE3JfvrCG1qHg0rkNAWLQrYz9heft65L2htHY78z9p6AnGAqVvll0zKoNpRhtW/ciMGWK6UlMMlu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(41300700001)(107886003)(6486002)(2616005)(316002)(6506007)(6512007)(66556008)(66476007)(6916009)(66946007)(4326008)(26005)(5660300002)(478600001)(8936002)(8676002)(6666004)(7416002)(83380400001)(2906002)(38100700002)(36756003)(86362001)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AhzwlzWR4vMh27NTQ/unWqZ+XtiSGeZ/vmZzOFEvuV5JZgG0kwqE2NaKGR9Y?=
 =?us-ascii?Q?qVyxNLZTKMkSeIdPk4dC3+Go3eGlES11pHUqAU2FEIMhzMO5654mCmJ0f7+7?=
 =?us-ascii?Q?GnW/aiTtZnBZrlcmWZWetLy/NIgO4lmqI8lz3VNbKhOCiry9RYgdF2jzSw7k?=
 =?us-ascii?Q?Gf+OWB7Ipxue8CjlfJ9MAJP7qyAUyRRmEwetsyZySKEMZ3BkRLEGrjqXtBAt?=
 =?us-ascii?Q?fKZc2/0VRSdQRCusVG++x6M0+pjk07NNpK3bHUcbtO2cj+qIMSdo7C2IGihN?=
 =?us-ascii?Q?v/hAoL+0tcB9sj4HfCHdXC1PWbneW7lP4hOqQCoVVRotoFAhRtZeEjHf7H0v?=
 =?us-ascii?Q?7xqByyMUpvRCcwHg1r8v1afuEFEr3Imc/+My73PbHmLVKoa4dY1sdN48wDAT?=
 =?us-ascii?Q?cC1Cvv3NhcITFvdj5CZ2JEN7nMneJCoc201qmvSTX8ni/l2nTcuY6y4jCAsb?=
 =?us-ascii?Q?yLBv1t4ASj9FvSwRXuN9x8wAAZ5MaZ+jFzLh5vTCluULU+UPqWxa/QX6EFGA?=
 =?us-ascii?Q?QRdGrmi3qEwr1F0yIHzvjgR8XBv7QEpQAA14TESrDCmtPaY/IYV3bfAn4OPf?=
 =?us-ascii?Q?5uAlzMTqkbcIOO9NM3P80rduGunXGDHQawByV7E8SGBIYr9CIq+14qfBFLVd?=
 =?us-ascii?Q?yWdOr4rAbE4MEPyS70/f85+ZEXpJaz+WfV7Qi0dYwlb9Hmm82UdH06umRNa0?=
 =?us-ascii?Q?3npcYFKDkm6VwZ7iBBo9RGiuu9dniZ4Vfs42qQHgiPQD9ceQTnp6N8NaZmHg?=
 =?us-ascii?Q?LyfksFmEqOfBka4B4gRmpLz6hMopQUEOVqrMYmd0aVjMY1aEj7lzEpgScwZb?=
 =?us-ascii?Q?LDGbVcl4xnL8JBLUCevFAVePkMFChOltOd+Eh7s/dVkFyJg+IfixhtetnAl6?=
 =?us-ascii?Q?HPPKhVbCotAzqGhMXym8lphU6ohz9+gjSZzJKwAS/hRm+ih9NlZCHeuY7ygY?=
 =?us-ascii?Q?e6B/Y3BrCxHPkt7lMdmTLrYSZj74DWvHvBZMFGabnpSHYn6lDc/xkGvTjcBR?=
 =?us-ascii?Q?/0j8Xvc+fonVQ39EwAik+mJDZRvJjcEKM+r9b+3KTFijN2zCVmVM6w4/N1Ec?=
 =?us-ascii?Q?WIxJqj+4zt/ajOD3KVzPiVCHAP0IUx9LQqFMgJL1JUhgXpcKMuQs9GBMxh0l?=
 =?us-ascii?Q?bgjmkNzzJwZbbQeLy8j3Jzbqq9z4JVggON1zrF1j8Cy6LrPbNJY8fEg6Ej1k?=
 =?us-ascii?Q?R4bf8m4YIBBtr2FomT3kBnq9oBCHsVv+r9q/JZkF19AdYb4ZnJ0QKJ2Du8Y4?=
 =?us-ascii?Q?0P0NHhYOL5wUxSxGBEpXzUrv7/isbdzcuH2dZkh/60tBsPc+iPJeRG/StNNi?=
 =?us-ascii?Q?a7Vvpfj9G8GwHoEYOJiMmMz+JgzIR6o1U/DbcRmAtDZsfN9yso6VZvgkKpha?=
 =?us-ascii?Q?Zzhr421GzyIb9QyO3FbEJeGkTGwRG01q11ZTxUxJ7kPfsOenArywCLs1/PVX?=
 =?us-ascii?Q?0zR9oGcoUgtiZGNZfVcMNZ+ebN+WdLHL+CjJkUVO/UdBmWK+hKncM4e/+RqX?=
 =?us-ascii?Q?1CEV24FR36Q7Tzv8a0vTYX0n3tZtgL33WQOdFJWa7K7xyioI2feKcvOALCnr?=
 =?us-ascii?Q?6szNNdQDkSsDjrLIozlOiCXUaZGdpU+2vZvwhib4NJklGtMEg9NBd584JTlI?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vIOQfs/+l5OTrnL532nZ7q30kKKT3PrKUNJakvr+Ela/UlzjWjdHUvMespcz?=
 =?us-ascii?Q?ZFmYVpcNxBzrxKjBlvIuaDnrcbFHvj8BvfgM26V62vZEW3024AvKsAe6V90E?=
 =?us-ascii?Q?sERb/EeXG7+LGyEGJO8IEOLRko3mm4Zrr+A/v1UJfnpTIi6+o2HZ2r5kKOOj?=
 =?us-ascii?Q?q+Nly23BEkheK/PYrMNJklaznp6TsqO+WbYORGuIl63ORK0XMG9r63xJFBKV?=
 =?us-ascii?Q?8rGG+IWLebN+uDTQv8r6L6Xu4s6/yBZLrUGER1oXHhB+oiP3qb33IS/MzIsr?=
 =?us-ascii?Q?TykglhWO2eThFv8wNj1WFBEf9pw09U+H13dqvWmm9oezNEkkupf5DaEQc5JS?=
 =?us-ascii?Q?mhme9RF+HIeV+QkUh7RhCW1heppAEV93kcNZBnmlta9HjN4hM1OLpoyWsZvp?=
 =?us-ascii?Q?eL124yJ9pcY6EBxCp9uKsVu6RCyIuVHWbbU8xH4p8e9s49+oAqGwyQcg07OG?=
 =?us-ascii?Q?Da0z8vDtkotd76vG4C3/2Qnzx56mFgW0vd+lrDYbtr+hYUU4NJ7GWC1tjKtT?=
 =?us-ascii?Q?Iep6PEbl6Gf6TV4UziB9ekPdYUqkPG/cYUNGhVnypu7mhyEaWLew7prMnMzS?=
 =?us-ascii?Q?BycgWZoDmiLa8/saZA5+4cIdTSYEztEz2nV/zWWhFA/mEeTKjKcMrXPaPHZc?=
 =?us-ascii?Q?mn84d84XWZRpfZFr5F0p9MJgQt0wLi6f0X21arK/k3Wkc5DlpC/ClHMXefQ/?=
 =?us-ascii?Q?ajCnt8xba758SEent9EVAaN9BrtzZ/gayfO/rYpDwhgCkoRANjipIaOHb9ob?=
 =?us-ascii?Q?cdiqYI/GPdxWmbFxp0vCpR3QbfXDwaJNN1kWgZHBZztqPW9ko2C26fWM7paf?=
 =?us-ascii?Q?8U7/VdTvYiIj8Ih6MsfTucTRynjNJ631peVtopT/P3lYUSNYMIHh/1KknYOH?=
 =?us-ascii?Q?49OCpQ5F1rbLW+s+WQyLxWUk2cp9ixoiLNxzwB10vIVY7ch0OGUgy7O5zvVv?=
 =?us-ascii?Q?zBo8KjjDT9oPD7pP5RXPLjtU5saqhk+okqGV3OSTm/CQbfs8gx+Sb0WZ2ck3?=
 =?us-ascii?Q?lhYx0h/7ObBuube6f/XWJMg+seOIj9YFsPptOvVqI2EEqHQfGmSsyg4DjnS0?=
 =?us-ascii?Q?GodQUo4isa3NAoWK2mmN9LjSGLItZSkl/I4kDcJs+rE+VmIdAc7Ic4+plUih?=
 =?us-ascii?Q?tw7R4mJrZJsLL93Edqed9QBUADc10F/dPsNsAn5ExnuhRm7GQMHw8zOrVhBY?=
 =?us-ascii?Q?CU0YO8QVL/55rqHxZCAi8CsJSOS/rDPa5A1VzQSvbWg3cHf63C/vcfIGRsQE?=
 =?us-ascii?Q?B8GXU49E/DOsrqcJPiklH/aezK1QhgLzGSdslcLVs5z14vVZEcMwRhQkvUB1?=
 =?us-ascii?Q?8SEZc/pMfhZ0l+o29CtDptD2P6s7hpMpj7Sw8pHydxkVmw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1782110-9c90-43eb-75b9-08dbc477b3f5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 01:17:40.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qz4nsFrMSfHl/zWyCJDzhvMV/vY4Sp5xDrwidmV2XT+IU5BI+ILJ6/bDb80kO1SJf0wERFgGklCBh2GUmBC1BgH5knRNIjgi4tqdajAIb8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_20,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040006
X-Proofpoint-ORIG-GUID: beeKUWdsc7izn8Fb1HwvACZsWLl7iaCL
X-Proofpoint-GUID: beeKUWdsc7izn8Fb1HwvACZsWLl7iaCL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An entity is supposed to get an earlier deadline with
PLACE_DEADLINE_INITIAL when it's forked, but the deadline gets
overwritten soon after in enqueue_entity() the first time a forked
entity is woken so that PLACE_DEADLINE_INITIAL is effectively a no-op.

Placing in task_fork_fair() seems unnecessary since none of the values
that get set (slice, vruntime, deadline) are used before they're set
again at enqueue time, so get rid of that and just pass ENQUEUE_INITIAL
to enqueue_entity() via wake_up_new_task().

Fixes: e8f331bcc270 ("sched/smp: Use lag to simplify cross-runqueue placement")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---

Tested on top of peterz/sched/eevdf from 2023-10-03.

 kernel/sched/core.c | 2 +-
 kernel/sched/fair.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 779cdc7969c81..500e2dbfd41dd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4854,7 +4854,7 @@ void wake_up_new_task(struct task_struct *p)
 	update_rq_clock(rq);
 	post_init_entity_util_avg(p);
 
-	activate_task(rq, p, ENQUEUE_NOCLOCK);
+	activate_task(rq, p, ENQUEUE_INITIAL | ENQUEUE_NOCLOCK);
 	trace_sched_wakeup_new(p);
 	wakeup_preempt(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a0b4dac2662c9..5872b8a3f5891 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12446,7 +12446,6 @@ static void task_fork_fair(struct task_struct *p)
 	curr = cfs_rq->curr;
 	if (curr)
 		update_curr(cfs_rq);
-	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
 	rq_unlock(rq, &rf);
 }
 
-- 
2.41.0

