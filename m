Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD4577C09E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjHNTTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjHNTTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:19:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF089C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:19:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EGU31n011367;
        Mon, 14 Aug 2023 19:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=Es7dJdww+rRVUyl4IAcITaa3aaGJZSSTyw5MP/Ud+x0=;
 b=XRJp6L+LAGE7z3n9m9CSYfMcDQWB5o+avorpleuEEjR3bD3NJzKMtXn6tf3sIB1ErMmU
 k9egf9qAMfg4F5DYLf0NmdbhZFAReKsE4R5hrkffws+bn/ZxCKTyD8sP650VICWB5aDO
 sdD/AdNwYe6FAaSjvDTWDPEdzTl9HSwGJYb9G91zsFmOnNHcdlB+0cUDGv1R08/lWOWn
 vucS9QNgMrc19jyo/MaaFkHWVFowUzNzv+swuDm598zxXFpz08N4KGLQtJv1luroS/mi
 2+A2MFjDMVWXpNLksNzxW7Mth5aMGdTDZwexjByx9xjzV7i36ljZ+HjyYCMIZQAEoQLT Eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwkcje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 19:18:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EISYvW019981;
        Mon, 14 Aug 2023 19:18:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3uhv7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 19:18:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1+X/kxTI+1mnjSEiXErMP6EUZJfEvHQbAYsKqu6RMi2RoEMGu25rl8huV5m9e0+1yiJTXQOVfbxNuyRQrFMtQyPWreHBxpLTAyNp+RScziMo3asxR+GwXRfoRt1G6kkwav15g6UlW4HJmSLHUZdPlNPTS4laRdneVoH9V/2w8/adEgoGmo3k0L7ueoedHe3vPc7EC+j3g0blz7hq/VmkEPZB2yXpDYVSJ57p9YnNll8KsaISTr6P+V3JUTneIfadjq0mAs9akId3awa1nClCLZ4Wv+/Krcxoq2Kbs9qukgy0lo7LIkSvxapWlDbDLdkJrMo5K2iGKTl67CJBheN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es7dJdww+rRVUyl4IAcITaa3aaGJZSSTyw5MP/Ud+x0=;
 b=fLbNiAy8eBYP9ymVdKJHLLwkg9+bthXMVX5UAzKqcQc61MTQTf9BuRENYAJ+dF5s+6sr6S48hbdq4TN0NjYBh24X8UctMTv/v8vajM+9pxH8ggmG1I/E7KP3U8brbfg4fX8TlLcJp7mME8Do0vLtPtiGEmBqR+Z3v28jIstqOkZkYFjhX43C0IbfUZ1XrIMlm5Ggk2bMjeDXHSRs4UgqKDfoSxC+15qkvoRCO+G6wJ/QRor/7w4jUtjd2UQA1XI8qqKvRA/ZOPVkLNiYGCa6qt4IVRp4PWoqMyl6P7aT////6s27R9KbMXScfT6RluK5KRCjBVMxPA1FCgRbTk+22w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es7dJdww+rRVUyl4IAcITaa3aaGJZSSTyw5MP/Ud+x0=;
 b=AKjsptfkXipytJsBWwFo6R8zAwI5e0rXcb1S7kyiGM+oTjP140wohJ1/JVjGLp0SoMAEePciqWDTyvV9kOKRsBBkoDUep0eF1fmWUyfsI0r4JGouFoEsDxxEs5iRyGNqWLFv/ljvcQgXsFjGxuv+d9C8OEYU+TZRe0DhmA5w4fg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB7078.namprd10.prod.outlook.com (2603:10b6:510:288::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 19:18:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 19:18:38 +0000
Date:   Mon, 14 Aug 2023 15:18:35 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/15] mm/mmap: Change vma iteration order in
 do_vmi_align_munmap()
Message-ID: <20230814191835.jzj7ryvhi6dqwruy@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
 <20230724183157.3939892-16-Liam.Howlett@oracle.com>
 <CAG48ez09ELhVYZftGtcxrvUaW6pF+k9RzwFtjRs-pcRx1aUweQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAG48ez09ELhVYZftGtcxrvUaW6pF+k9RzwFtjRs-pcRx1aUweQ@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0288.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c321693-28c9-4250-f4c4-08db9cfb430c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oxoi/QQiuQL+rxx6F92JELcCXJ5JNhz3irdtdl6Ap9aRo/e1et0v++FOqTqWE/0O35KpID/kVJ0G9PLKMR3F5A3fCSSeWTIr/ym17bvyL7w3v7MQrk1AWMawIuMZZuXc4EMM2R1X83+Nr37xc/4nab3ZkVI/kdzuE56VVSx8VJz7W37/WUOdwtmWRJISWBU4fh5eAj4GPlju5JU0s6RDJkC1hDvSiFEUePUcnVM2ZRIw3sh3rvHjJWT1J0pTMAPqus3/Fl3RqfKh7fhBdSbOoyMBmLLZjp2TeCpApaQwHE1I5lO2tn7xGMI6ph+uV3TBQl0H1rIBxqaEmjnf9dsB1rmnfZqYUf1ZXQc5aCGYaGa//339hRR/kanTQqgMi3b+Wnw6uLnKBxuf4EvIGyXrYCtauNzSNOqTdnOSMoK0dDfNwit4l0xzLm3D6+LWuC15Nw7SF2y1uPOWNp4+vm5le3GUF2JcV54z2ZepFJIniPblMe/mcUw4J/vSS2mBGIanMuMDqQ97nuZKjPh4mqjNV8Ap0Iw0AhNlYpsc8E69rFKvFANg5Jtd97CBC7xiFjEu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(346002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(83380400001)(33716001)(41300700001)(38100700002)(66946007)(478600001)(6512007)(54906003)(66476007)(66556008)(316002)(6916009)(8676002)(8936002)(9686003)(5660300002)(4326008)(1076003)(86362001)(26005)(6506007)(6486002)(6666004)(2906002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkZKN0dRUnR0SS91UnZzSWtQRlErU0gvd0djaFluR1JSY0lYOCtOUDFLNzFY?=
 =?utf-8?B?aUpFam1PZFd4UzFZVFZIekJJN3VUYzJSeDBncHZUUS9hM1p4RHBoYld4TXB0?=
 =?utf-8?B?d0hkTEVWNDQyVXRTZUZaYmg4Y2NZVCtHbWFZeHlnSUJ3Y1hzWjFtRDdURzc3?=
 =?utf-8?B?dk5CbWZtR0puUlpDYWExS05JWUJBemNybHkzWHplT1dZLzVvY1dwVHFzTTRo?=
 =?utf-8?B?TXJ5ak1WQkE2d05YWG5ZWkNpR0VXSUJWM3JWNVRDNW9TdGhFRlVZWkl5Y1pW?=
 =?utf-8?B?cUlva1VQVmJYa25vcm5jN1FLYjRCS3JQb202aEIyR1hzNGE0RHZiMjUxUUE1?=
 =?utf-8?B?WnpoSWozbkU4a21lbS9WeWtBSU9ISitYVXlXM3VqNUxNL1RES3Zwd2hJdzJx?=
 =?utf-8?B?V3V6VGJxenJBL20vSWNRM3lJd2hSN3lvS3lUTXVjZ21zK01tdm9aeXk1YUxa?=
 =?utf-8?B?ZFAza1hYZTZQMTdtTzM0RmVxWEJ5LzFrSXpTZ3JOQXgvSWZMTGJXZDFqU3Jx?=
 =?utf-8?B?R28rbW5xb3ppbW5GeDl2OFFPNHVVNkZNWURObktPY3RLNWY2dlBzdmtsNFNN?=
 =?utf-8?B?WVhmQnRLdStQZURwaUxTbmVVNE93RFdzN2t1czVaQ1YxcWNNMHFLTFk2L2xE?=
 =?utf-8?B?eVJhUm9ndUJPQk1xdWhvZ3ZwaUxiNisxYnpsN1MvU2Z1T1JySTcyQ1VINCtl?=
 =?utf-8?B?L1VpeWVpUDZ5c2pvSTQ4eFVIU0hLNnVuZFE5SGZCUXNaYStyQXFDRmo1UGF0?=
 =?utf-8?B?WVBEWlRTSVN2K095SEZici9hNFRNc005MHhEdU1YOHN5Q0RvRllOV2NkRFRj?=
 =?utf-8?B?OGs0L0hIRVZ5U1RQUW9odkN0MzhaK3JIbENaQlBLSXZ2K2lpOHozVitvcXFT?=
 =?utf-8?B?UVRUN1phWi9mUFVSbzRNNlhCTlc0MzhiREdjWktUZ0Jpd3c5RmtaVjBNeEJt?=
 =?utf-8?B?MnhmMFNWeFZycTQ1aGxCWlVPY25tWVZnNGtFeVc4dllIeTIyR2xkblBmYnpy?=
 =?utf-8?B?bWR4dGJsT29mMVQ0a043d2RSdTJmN2JlNTNLaWRCZ3hLTDZvNEl4MmxUQ3Ju?=
 =?utf-8?B?dXB4d0M4eStyTWNVK0tkWXZ2cWNjTGMvYWE4clpKNmVEcFpjYysvRWw4SDRP?=
 =?utf-8?B?cXZ2azNsc1dCa3ZuVHB0aUU0MU5MNjhncmcvTnNiMzlJY0J4cCthMU4vUDBq?=
 =?utf-8?B?WEp4K2Q1V2ROcGh0dzhFZmIwZGZ6MlJPV0RCdHpLQ1A5TUtpay82SFZ0ZW9j?=
 =?utf-8?B?Ym1QZy9JMGVmY1NTU2d2NGk3SzlFSUZmdHcxektkZ1dma1VncWZjc2c4VlFa?=
 =?utf-8?B?UHg0cHdsWGhyTllxdTFORVdia1psL05pZ3ZIWGtlSHhvN3pKSjFsRnMzMmJ4?=
 =?utf-8?B?WWt5UVZ5SW1LeFpjak9wS2d0ejhkMysxc0NXS1Z5WFNqN3d5MERodGNmRnB3?=
 =?utf-8?B?RkxpTk5WZGppV3NiTy9VK29RWkw0c2prbks5UE5pRWpnTms1NndWSWdxU21l?=
 =?utf-8?B?aFlwY2lKS2Z4eW1vb2RXRnhIQ1NGVDc2WkpvTElkWXFEbVFoUUJYT2gxdjFs?=
 =?utf-8?B?bXNMTTYwVUw5b25wNnB6YTd6ODUrQXB4cmNHaGxTS0k5dkIvTlVoQ2ptSmpp?=
 =?utf-8?B?OC80ejdYZjE0NzFXVEQxN2c1cDZEWDNtSXQrQnNhSm9hVWRaTXFDU1M0SDdI?=
 =?utf-8?B?Z2JFcWR2VE10cFQ5QUhXRWFNZDV4UjkyVkhQZFNnL2FZN1pzMktJTmY0ajdU?=
 =?utf-8?B?K21iZUhlKzBBR3ZDUVJuZnljak5vK3hPS1c1dmFZMURPeEs2V2gvZHh6S2RP?=
 =?utf-8?B?WXlXa2VwUTB4WUxSVEhTZkRIRjBFR3R2NnJyMk5JWlk4MGF4LzNkSnh2eFdH?=
 =?utf-8?B?K205RWM3Y0N0ekZEOEFHQmJxOE55U1RxMDhBK0E4SE82OGNFUFpVVldwWDhM?=
 =?utf-8?B?cGczdlBaZXFJMmw0bncrVnZSN2dEdGs0Wk92UksxSm9yL0tGTkJwM25LNVBm?=
 =?utf-8?B?TzBRWGZDVm1ic3NRTWxCdHI1WExxYnZSSGJnd3R5MDZWU3pBb0FQT0t6UEhG?=
 =?utf-8?B?YUNEY0cvVmhTZTRkRXRRc08xY2w4dE9wZ1ZIck5KQ0JoMUVkdVZTSldQL0l2?=
 =?utf-8?B?SEdhMkFzYXVPbHI0YVJlS1ZQSjhkcHdxbks1VmNRZGk5OFQzRWhmL3ROd2FY?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Nym9lf6zPTZEnnPPntp7CDlhn+n2gKMkIo9+3HJ344zAhZoHV27vTyYBZxqcC+A1Erh9YoixT9a9DRyEzaH50FcJwMLXfR4H7fhulJidnEH6+IOM21iDaSjuKOsIAY4D5BOVTHRHMH05AsBn/FPB+Ej3yWHyKDBvcA3r2ClTpypVOLhDgRtXKhA+uBLnrYq/Hh9ACM0JJW08ouWHn/TFxCEhgvCnY258pyv71j00bCrEzU0dmZ6Y1kKBQcsdABfGibs8wCoYci9UiRvlVCYhpAwP3r1KRnYh0wybo6iCUHJPF8AW4dxFqSCNGcyXBxDKwt5iYPW9wVIVMCQopx+KJCDumo5TP1uj6d0W5WB5XQLtVH+G5/lxtsyjehWxX+bU/0H7hKTMBysCsuxZRsS8BzqXx5FFu3YR86qRPFoUYROCkS7Q3Z7OP3WE+iaqofPTHzjij556zc1Kt3BSzvQp+76FQAfTYLtAG0EuUeQV7Jy0aPs8R1eSf4lfwf7fST94kMSVyGwXwEK7dSlmCu++vKQVDNXuJe5vUd2Jmq6EMFRwLPKnFgtv0gl+EoE3jLsO/t6NssGY9ztIq2uOsdyb1m5Bz/irJfmukfq1Vg+9XhtJM2wIBGjhnAV+QfC9/3gd5U9q2OiXyHCkcoVO62YNjLz0FmD8ezF6my/622Hs+75HFpCUXwltCAdizTpaoxeMvjiJ4nvO9z6PcWi6PIEn4cgmDowbSDx3nTRWVzUzNJIXTh8AfrsRC/KdOC7PXGG+pjF5tAjR8+2dFCbr/ECkD8cwPrd7VgyIdrusoGROAsO2WFAO8n0USEXYECG83cTjBpiSnKyCILuOjXxRMacFj+u87it6rWgWBCyTdA99qqAPIQF/YFiNKgJcQHHaMWQB
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c321693-28c9-4250-f4c4-08db9cfb430c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 19:18:38.0553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdGaLYHff+aX7bElBdiscaek9UazU5A8peS0SfubvJ8rpjIiH00A0w6rubSacYOLEEAvqPSyKB1ymCVPRjzQ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=694
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140179
X-Proofpoint-ORIG-GUID: FNuSxx4ypfdtAngtoEWQ4EuyV69HSAdS
X-Proofpoint-GUID: FNuSxx4ypfdtAngtoEWQ4EuyV69HSAdS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jann Horn <jannh@google.com> [230814 11:44]:
> @akpm
>=20
> On Mon, Jul 24, 2023 at 8:31=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> > Since prev will be set later in the function, it is better to reverse
> > the splitting direction of the start VMA (modify the new_below argument
> > to __split_vma).
>=20
> It might be a good idea to reorder "mm: always lock new vma before
> inserting into vma tree" before this patch.
>=20
> If you apply this patch without "mm: always lock new vma before
> inserting into vma tree", I think move_vma(), when called with a start
> address in the middle of a VMA, will behave like this:
>=20
>  - vma_start_write() [lock the VMA to be moved]
>  - move_page_tables() [moves page table entries]
>  - do_vmi_munmap()
>    - do_vmi_align_munmap()
>      - __split_vma()
>        - creates a new VMA **covering the moved range** that is **not loc=
ked**
>        - stores the new VMA in the VMA tree **without locking it** [1]
>      - new VMA is locked and removed again [2]
> [...]
>=20
> So after the page tables in the region have already been moved, I
> believe there will be a brief window (between [1] and [2]) where page
> faults in the region can happen again, which could probably cause new
> page tables and PTEs to be created in the region again in that window.
> (This can't happen in Linus' current tree because the new VMA created
> by __split_vma() only covers the range that is not being moved.)

Ah, so my reversing of which VMA to keep to the first split call opens a
window where the VMA being removed is not locked.  Good catch.

>=20
> Though I guess that's not going to lead to anything bad, since
> do_vmi_munmap() anyway cleans up PTEs and page tables in the region?
> So maybe it's not that important.

do_vmi_munmap() will clean up PTEs from the end of the previous VMA to
the start of the next (even over areas without VMA coverages - because
there are platforms what need this, apparently).

I don't have any objections in the ordering or see an issue resulting
from having it this way... Except for maybe lockdep, so maybe we should
change the ordering of the patch sets just to be safe?

In fact, should we add another check somewhere to ensure we do generate
the warning?  Perhaps to remove_mt() to avoid the exit path hitting it?

Thanks,
Liam
