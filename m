Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B20175E484
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGWTZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGWTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:25:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FE1E5E;
        Sun, 23 Jul 2023 12:25:40 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NIlZ7S029796;
        Sun, 23 Jul 2023 19:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=84v6CXRAL9h/9HbgfYFgokxqozORMORGoiSOhP20eC8=;
 b=bpvcIKhIvatL3F/hPW7qW6/DvYG/xSSUL3Il+WC63Pg5rcGKA/JGkOGuV4CoLRFl3KMD
 pZlgNi/yoGlBeoASF/MfmDJdbOrmALOaw8h5UjYCbv7vzNnOqAjBcJ/l97XqHfJVZcJ1
 9R5Pdx8dg9V4BZi/68D1RsoaLwnEM2EJgizQiiWGEL7SA19KTYZfvMlQXJ276VexBgef
 BzBYA+ickfNJo+qq1A56zrUftTGciNJUh8sMllbTjSR+skfZEmQvmAL0lfLu/YgaPGmV
 SMaxyUfFi4qZtA7qH5NrWFPDjo3tVZWth7uSvV1aew6dfsLz+vhF+Ri7Vvc94fLV9GC/ NA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c1h0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 19:25:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NFEbhK040860;
        Sun, 23 Jul 2023 19:25:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3671p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 19:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzbe72fAMMGz9OE5quPtXpt9kNQVB2r77XAEbIOd6Cc322hddqrXKoHq322vWY/3ZD56UbOJqXFJHpvuNMeJpGc9Gge7hGtBZsyj9opXBKvlPo5OKzjTT2Ra3kk3CtgvF3kk+Hz3jR9gpryGh7JSx0cDf9kURMWrllKDtthqXfDQKnMtz7z6X9vgY2bW3fjGXBYCJHGLpUD1wb2R9aRZPU3uNxqqB8pgnzXk4WucgJqDjoVSwrO8BJGqFA0YpKc8pjuB1Uw2dZMYj2EhjTjGdBHRiXOpxN/WsF+KLvee1rKlUf7U82Rji/64wpG/kF0Higoby/YSmmUpwQbaa81/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84v6CXRAL9h/9HbgfYFgokxqozORMORGoiSOhP20eC8=;
 b=nGJYn02e0HYaXQWp106cBYcYRbmHcW95RKUgoNr85eDiRm9XhCjHTqnSCSgsAdb7acObVG8T/zpoas/O0D6DQtl/lbF61AeldPOw9iVq1QHjpq8H1kIkCwTciccL+Q7zCweJixhwnxzZd+zh5Ohoa+qmjF50TQUKAtb65SHuSkUVmK6/OcDmJPA7jVHyVGjQH1u+jWe3GEe6Bg2KtwJBUKm1Cr9dTPZaJKjdCgQDKd56HnfQ6+VL9ncU0seeP41M1vbANa1ml8yYz/CqhIEtWZVnfPsy9F+RSTX3HebS797p9nPoxYSykbhMbJvzpgZmrorEOa/Dh+BDKRX4fgFaxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84v6CXRAL9h/9HbgfYFgokxqozORMORGoiSOhP20eC8=;
 b=jGqJWfDxnLeWf5UaaSx6T+OdwM1hwFeNiWLeUv/vcMo/g4aVelQ94mPxsfNNJgQaO2987C/pTchGsK76HvHMtteZL0WxASqgs4R+atww916UAh6npt3/VGULYpMRAQwGRmGEua65DbxYyUSweN18mGsjOEcKdwAzNUJJdbl8rzs=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by DS0PR10MB7050.namprd10.prod.outlook.com (2603:10b6:8:14a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Sun, 23 Jul
 2023 19:25:07 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536%7]) with mapi id 15.20.6609.030; Sun, 23 Jul 2023
 19:25:07 +0000
To:     Ziqi Chen <quic_ziqichen@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        quic_nitirawa@quicinc.com, linux-scsi@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v1] scsi: ufs: qcom: Hold the mutex lock when config ESI
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8ea5t2s.fsf@ca-mkp.ca.oracle.com>
References: <1689065327-45039-1-git-send-email-quic_ziqichen@quicinc.com>
Date:   Sun, 23 Jul 2023 15:25:05 -0400
In-Reply-To: <1689065327-45039-1-git-send-email-quic_ziqichen@quicinc.com>
        (Ziqi Chen's message of "Tue, 11 Jul 2023 16:48:46 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:806:126::29) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|DS0PR10MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e82f076-d8fb-4708-199a-08db8bb28638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7F2IP/SmIW6JTajB+GRjzgWWJA+shhfiGGZxpd7Awc6TFrhvGheXNJd2Dt1SCUiBAHzj5yB5GwBHMrbZ8mMcXi/QCFEnGjwXTi3Fqz/xe8yZ+yGsL2Rgzxs0Xi+fiuGhMfWkA2aVuhj2w54B/ICFwc4+IhcMirPPtDb6D5dcFpsGIoxUUEOCt/arHWTbMPJ0GTowyFXb8ZTCtLtTXu7uGXVatDL4RkUHUsA6CoYWKMhrosnPoFWKvZQpmQ8TbWVXsW2sdxMgetLZGefmH9ZtPy2bpHShiV3hUoetANn5Zjy+uFxm7TjLeAV1BVMieUT+MW7tAXlZHYKh72cxEq07FqNxzgbqCZ8NQu96gRLvt2zh8IDryXUuYNE7wNMsRqVlX+itJNHxtDfomQC30y+EMn64VZbnPq/Q24b9xdxjOQ2Vgnert90EL6bFAUUrmIobm8izERF/630FRUV4twbyqBmk2UI9ufrvlRd1QEFMtzG4HgWwBsQP13au8p+3yOAuc6LCJ/iM1TedU04HT6gKftrUNaSL56sgT+vXOyJ8XjZbHadb6B3B2+1SlpSy/JEm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(36916002)(54906003)(478600001)(6512007)(6486002)(86362001)(83380400001)(66946007)(66476007)(4326008)(2906002)(66556008)(316002)(26005)(186003)(6506007)(558084003)(38100700002)(8936002)(6916009)(5660300002)(7416002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rTkrotQD6IabrQHdX55hZH7G33FuccS2QpN3xRmtB5goduh4TjG0UvMqVHih?=
 =?us-ascii?Q?17+BloLP1u8B963vukvHPvupacIcMLXmZQUcUw96GjBCnWeYPvW/y2H5YGDc?=
 =?us-ascii?Q?/HwQYeYSD8nR4hKmIWi6EGx8ZwGy6o/5cTgXKDst0MxUWClHlfvAfUcRGyi+?=
 =?us-ascii?Q?UzODGBExWTOoGEnBCGiWwOstLsIdyFSmlo83MvRyR26TSYM952X4an+VBjbp?=
 =?us-ascii?Q?RSqynA/vO3cUXboi9ZUlRDmHUpMG6a1ms56SJ1D6husUr94uUKOO0IhpbzlT?=
 =?us-ascii?Q?u3BP8+S1rze8N1o2FYI0+uqsg967MT/AIZyJehVgXtyZ4xxO1HoacQii8VZx?=
 =?us-ascii?Q?0Ty+v4nvfe9YYqDW136TittNPmjGzmWfeBCzrqcH8HpPo1v21EWbhRMDqypF?=
 =?us-ascii?Q?I+WU0vOku9ass1W6eqJ9OJDeHWyrl1ROA2S00X0znBJeuaaEr2XbWp1WIrKH?=
 =?us-ascii?Q?R/GUUulWpIvXoro7XVEh3aGhnSKBD3T08pT3xo2VfFuSvmFWvmFb01UHWUXA?=
 =?us-ascii?Q?PvbfagCHuIsoJwEMNrMxbNTnS7jTmeOw34XMVZu92ma5bW5M3g7GagHAA3HO?=
 =?us-ascii?Q?vrvSoqz02yNI+4IJwBuGL3gy2ZTO6smWZsdsXWuT5jjjMClrHKaeXcc2X90D?=
 =?us-ascii?Q?WyaCU4gQ6A3mv1RECprzxyD8Mbu/cu3Q4yYiuwBtZBBB8PlxhwcoQjrF4lWw?=
 =?us-ascii?Q?TtxF5jIBr19bf3QiXJgk7ZH9Mq/Mtef6e6w6tTk00FH0RufmQE75UBStMSDw?=
 =?us-ascii?Q?QsiurImYnLT7WHGoTLgMOsM5Bm14nWeCK/y/9zBoiwmvX3EPiHqv+6CO9tlY?=
 =?us-ascii?Q?7vbbV1/+QvSf/IKeW7ksOfA94iC6xcPrS0nD0sUq+TUwul6FuOfaRggOCsGE?=
 =?us-ascii?Q?HsCDlvLm2D+BG5AxAPMeJXHPIk/vBQuMqiqNK4P0/RZlAhrsQ4VmByTJKnGE?=
 =?us-ascii?Q?TEzOcbLk/EicmbGnSjgc3GpwfKqKHV0qrjEmBSTq6UZfcy6Xp/1m9SlhdAP0?=
 =?us-ascii?Q?CQVl7to/7+RZnl7QFVBSs5MLNkF7pft6CfrmTRg9BQVY00DLfgTReQ+WckHM?=
 =?us-ascii?Q?C01VxZRIhOJID063vH+p+IE9yjGGmMQDVLTQYIv4wbRWwcg5W0uCei6UPuq3?=
 =?us-ascii?Q?N1mYKIh7Tkm7C87QOAIhNkj5quUGlB/gKyKFEVe+N29tpA9PIz3ExVlrIbUR?=
 =?us-ascii?Q?Ey9HWDAOtuwuvo3+iZWDk21fdsq8Yy7ix3RaQm78882G1yUW9oFwZCjLgLFj?=
 =?us-ascii?Q?A0tq7NaspbPHFWoai4T+F/jEhzdzkJnyUG9dbnf5ICYHZxDvaXoZ6/NpEhm6?=
 =?us-ascii?Q?Gmcu2HvmGWFSDO8WO7PDYGtLuHoKhg8kv67OGOz0tiYuM8Q6+6Pq4cHPfpsS?=
 =?us-ascii?Q?aGbF4RzTDrR4Ro7VOqPWpt4Irmm4dr4aid/CdF51ZNdmZYPRUTQqbunhj88I?=
 =?us-ascii?Q?rU9SIutSIRCT3P95fg8Nf0azssnPQaHHr+DnqzeqtEPFn8dymuuS3sFgubW3?=
 =?us-ascii?Q?qFpxhWBTlq306AuQIWXDkd6GuFmDIq/4Zt3bWTLsND3jq7hp6TsLXuIA6xL/?=
 =?us-ascii?Q?6K8yAuHiXXbb5F1rukLgd4jQbaVLsR7GI1xLqhwUElyw92X3ER6igpd7A8f4?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qnkBJeSdZxWmJEHxR23+F9QifvkATsMKVyK/Di2LJMTT0tZLsiCh56Dgaa1a?=
 =?us-ascii?Q?k2PNab6E19z2YhLXr6D5d3L0CSwXTtCtvlxLNabwrU61gHxaf53jQLWWlWY3?=
 =?us-ascii?Q?dfLKJHQu3wJb46hjwjLC2UNhk7OCIwY1YM7bn4dAL2wUoF3orhBfNuIxXPzP?=
 =?us-ascii?Q?nmNvneqTyiBEj68qn1BHmjqpODbVIaIFSCbL/PTlbltmO5qX2ewXFywDwVl7?=
 =?us-ascii?Q?a2EhnvxGRYXRO6CyUvKbnCgH+d4YfrOS4FQ954f57JZoFh+F7WH/dYD2xkMd?=
 =?us-ascii?Q?nGVN9EG0JmSFu2OiNwP7GoMyOCMWxNGQ39JwvpbzeD+N18Ol3WJU7r3A+ZMP?=
 =?us-ascii?Q?yvuEAwgiq1YQRtgSiYUdfijjxmtj4RT0p/xrgwo+VzsQvAnEtyaYszdHnw4w?=
 =?us-ascii?Q?Kvdlrx2b4rHXx4NlD+8X2Rv8YTYqtd8iDvK+jkHSANluQbSzTQWJinDZM84b?=
 =?us-ascii?Q?Qv+oO+eeiQWQa8LD5DRvs5gZBztF3g8NFdj20uJUc/wQdIP2dpwe5H6FJq6C?=
 =?us-ascii?Q?WVsd1ZS9DUs2+vu0A5hqzb/TymMHdQtNT5MMSqxGK5xpu7M/BQ9+GFpFLAgw?=
 =?us-ascii?Q?/pzEilyWkfNL11/yGVJiHC6SMzWOkgXNI29ewd9/w8u0qCWMq4XfVoD85Oom?=
 =?us-ascii?Q?UVmndxsk7g49V7HmvIUrnAUOGrw1WraF2RfnF/zkeVDFMsiIF61iG+PQp/g+?=
 =?us-ascii?Q?pH0lGy5HgZd6+qIUihASBtCP7qxgC53XrH2nk61lKfbr7vA4rBHQ4qGmoGhT?=
 =?us-ascii?Q?CVWYePd6S7/pbFRkGUjt9WzGEaGHW7cesABDTYxa03HuHZ3UMuRz+Z2klE23?=
 =?us-ascii?Q?JzlQ4j7JdUcrPT7CxvFgchGAZ917wEOLC72dvX/fa04QmRV23l7ZywXzbDLg?=
 =?us-ascii?Q?Act+Iq22A2M+5DXYDKh3nSommk7IT0lC2zyai/EA6g4unB0iR+sDXjgNsxhh?=
 =?us-ascii?Q?uKUgxcN6CF1wZL5UEXUBtDv0PqXi6ztkRXcvF84BACMffWvZ0z2yQwX7+z9a?=
 =?us-ascii?Q?V9gjCoVNPEoLNFet2WdYPnIuNquq7tmg0zls7/SgvwqGtbY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e82f076-d8fb-4708-199a-08db8bb28638
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 19:25:07.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMy//Ij1trw4M/nwcoSF3hixbxMy5F6suNkT/cAhpKS9pCemNPiBI3HaabJVeH5OybkzfYO01aR9XqJREkHAqOu0cT1J+U4ofAmvUyQTkfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307230182
X-Proofpoint-ORIG-GUID: 25MCSlg4Wx1q9Z6RSUoOeVNUx78MPMWT
X-Proofpoint-GUID: 25MCSlg4Wx1q9Z6RSUoOeVNUx78MPMWT
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ziqi,

> Lock the MSI descriptor storage of a device when config ESI. Otherwise
> we would meet plenty of warnings during boot up.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
