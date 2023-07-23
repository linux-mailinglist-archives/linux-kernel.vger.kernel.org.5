Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286EE75E4DC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 22:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjGWUct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 16:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWUcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:32:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2F91B8;
        Sun, 23 Jul 2023 13:32:45 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NKA64K021899;
        Sun, 23 Jul 2023 20:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=iCY/xGSeNBt0igIaDVzr0uHbG37xemChwK/tEIWOZPs=;
 b=Tg/yRS3sQK0/mAxzefNo1Dt3xJsQfLbRR/kLc0BbDEUo2NH7Rh7IZzA1RYyJfc+Oqorr
 /Z9UDE+4RQnshH/o2rQXHUmHbStB2AqFsWAMtUVcGN+I7hEFleapwF5iOb2G2+3CsMSe
 Im1moeT2RmXdUCk4KY4eCzc5+2z6jBRrdPihgGUbbXCStzIfPfuhglBoTPVXk+EFBsSc
 z/Qn5Jk9Z2tZjYEwa5m3R1u53EoMUG61ul6y5Z4Z7WPnJRcUCSnintiWPac/9DKDQhwJ
 m4pFfaarc0wR/Z6Aeu26g1BqaKf8MV8LWuFoMFEDZqsAXlLvr7zk1Nnt/X309CRLj3fZ YQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c1hyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 20:32:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NIuVQH028825;
        Sun, 23 Jul 2023 20:32:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j2xkxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 20:32:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUggLS/X/x6fY9UzXRDioBuwJn+dPqofhby9+10iHcVeRFiWjEV6j1x6bSDFQRzz3/bqqQNEYHfPV41xx6DHD135B+AZkUCW8CJ8wsi9JctG/bXhumSBea/t4Uk6WJQxVSYfVTGRw/vpGyfk7mtAHBoxDj4V5gLzZP0nUwBV1DbRRbwW1ZazDjLlfNOt9m9vmNGWMs3L/TJbYti4OLKacTj+9dC+pVOZ6CNldZDbKezGmuu6fAsPQ660D96aA0SZSv4q4YhEqwA0jsd+Qi2Le104rND7GEgMx90nJausFSIEQTmJd+wssaF/nzfdxHQLzl7qo8B70YQHFi2njKpvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCY/xGSeNBt0igIaDVzr0uHbG37xemChwK/tEIWOZPs=;
 b=NIj/8db/PKwz/B15IEDPkZmwH6eHJiPIqL2p4AqJU/vsZp+Q2h6TzdcM0fs+P2ysrX7QE98mQOaCT7Cn/pcK66FSABLxQwntK5p6WEJgWtsq7kFcnfra9JlSMmGNvnaonyrdlYc9LyUM5rs/wu4nXGfxBBb+uINgAbd+WyqFWDf0sHVglhqAbD4YHpFCMv7GRT7BZgQZmpN1gzV30R1R6EbKsjECvczpIFoN1W5HQqsXaOqRl98neLKGhQ8LcqCsLj5n0PE1J+FQLqh3XyN9m1legQ5ApkS2cgEaLznE4tFLc1aKKRUWbNaXUImr+s9hVPiIyHAXBgrqc8Urac8X7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCY/xGSeNBt0igIaDVzr0uHbG37xemChwK/tEIWOZPs=;
 b=FQwHXCEc5DhYlssOAe/8y5XJqkojYUmuuGN1q0J2a12Y6B33DiAtpyu+D9vSU3NpPaSUcwOLrqLCevyP18UintuB4DqXHIERT1JuFzlEzbRtD7RonlhGfiR1Qadt0rtFcVF9uuMCY0I26jk/6zoF1DwpSq850W4PYwcKpNWudfc=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by DS0PR10MB6725.namprd10.prod.outlook.com (2603:10b6:8:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 20:32:31 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536%7]) with mapi id 15.20.6609.030; Sun, 23 Jul 2023
 20:32:31 +0000
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     mani@kernel.org, quic_cang@quicinc.com, stanley.chu@mediatek.com,
        bvanassche@acm.org, quic_asutoshd@quicinc.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        konrad.dybcio@linaro.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, jejb@linux.ibm.com,
        linux-arm-msm@vger.kernel.org, quic_ziqichen@quicinc.com
Subject: Re: [PATCH V3] scsi: ufs: ufs-qcom: Change UFS devfreq timer to
 delayed
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1jzuq4bed.fsf@ca-mkp.ca.oracle.com>
References: <20230720093446.30697-1-quic_nitirawa@quicinc.com>
Date:   Sun, 23 Jul 2023 16:32:25 -0400
In-Reply-To: <20230720093446.30697-1-quic_nitirawa@quicinc.com> (Nitin Rawat's
        message of "Thu, 20 Jul 2023 15:04:46 +0530")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0618.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::20) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|DS0PR10MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c4c9d9-ca2e-48e3-d6bf-08db8bbbf065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8OnzsqFuldFqan8oPwymytp2eDYjC/qJqNPeCpboqk/q4gRIsIY3WyHam7DfCjczwc82//Xe4NkXBsGwedPPg0/WlyDit7XPdNmFVfaCkGw8n6Fu9fk+mAy8iK7BgbiW373drE1kcOHOGQRwbOhEZmUqCTs0xeuK590R89ab/28yhAmzsG4CvlawiCh8PrqL8CEfyt6/SftuweYSS5npIAcPpqltvh4MiyQp+bFHPLCZIqiWAbuCinGV6kzjvm9j8C3ulgAKuhLEfXFwwr3bMZyDhGgQE0AWP7GsZEBuAX+jQhfubrujSVZUxubyoMQXbSSplVtAv3x6yOt7YDz07icCo/IuujMhlYVtjgulfT92JejMPNcbbc0Ivl1Ucux8sqYmJ8ErR9l92A06Ky7uRgtpS0hQ4FjrT6T5oec49++dEpkZzdf6rZEzqkQ9/nw3w+oCHf6W1Aw+zMpgiQlXY0MklgD6NophzGe0Byadqmyzh1sbmho0s6bGfhHnm/GutTJVvsPJpP23EC9+4qO08+UP9auEW9IVNnI1vApqt0MbqNlk2QKeW7nrh1nRePV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(36916002)(6666004)(4326008)(66476007)(6916009)(66556008)(6486002)(478600001)(316002)(86362001)(66946007)(6506007)(186003)(38100700002)(83380400001)(5660300002)(7416002)(4744005)(8676002)(2906002)(41300700001)(8936002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yZSOm5ha4puSmkJ3RUA+Blc4Y3yw+T2TWlnOAlGCww2lXUe8QLc9qnLrBIzX?=
 =?us-ascii?Q?ziCWsJIu3L11xxjZousPy1Dhg3jkZJJbYXHsMKD2+FGRAfFyy2CzP/4r3wxO?=
 =?us-ascii?Q?JMs4F20UNlmMKVv1BsQLvsatO2lk4yRn2vK8fmqmNVH5EfZw8nnMJoWr51w7?=
 =?us-ascii?Q?K4O6vQixYcKW8hDxniJbdCa6eG841XsFSXaImm/hJAU69pzR4YMGzGRwB3Gr?=
 =?us-ascii?Q?UATqa5KihwP8AMIVUfXjqdjdHEj1d31J39ZUXBPgWg15HILX/f6n+9sZHrKL?=
 =?us-ascii?Q?S6zjRFJPIbd2OM1zjXuiNpheQf80T470I71n1Xrw09NW8ku5JykFGyP/3UyF?=
 =?us-ascii?Q?GaYc/CM4jy5wLqPcwEpTtMe4FiAGQqXn+xT1N1nKTIYN8pdWTz5a/EbrZ4bQ?=
 =?us-ascii?Q?PfGHHqCaxrbk3nYVchE+mbawvBnjdGKT47+U17+yZ3YtRVus3QVwie9BVWnn?=
 =?us-ascii?Q?u4WdF20l6/fjy8yieRlFk97Pq3VzywiNjNdpWbN2xph9PmNsda0N/LcZhKVi?=
 =?us-ascii?Q?lyse6kmz5NwVpnifbZFObX4KhZ+6WQVbI98UnzMo5nzlgA8QGb9w6s5RVNrd?=
 =?us-ascii?Q?dBStG4AXa/H9doQXMrXUuWjKjJkvbqwEBz+Eyrc7WwN2TgvI1QyYaYcsjOjR?=
 =?us-ascii?Q?YIwQbsoXkQ1jVb6tAho20BtTqfAg50LPj3dTJBKf3xPZYXFUKNB70bvcoSpq?=
 =?us-ascii?Q?5z3Y68oIQV1Dtg0Q6tWHVW8QVpyKapWl1Di4ADxXRoE8PHLli0NddEAAwhnq?=
 =?us-ascii?Q?XYHbWhOap6MCoi1KGnUktFmo/QlMXoCHdWQQB8Q8yLyR+VvZwOfMr8HfEhw7?=
 =?us-ascii?Q?E3J0Tt53Eb8kVc0XXwDa6LXBT/gmd8f9xhNt+UrCrVeviDmop8LJKdzU74tf?=
 =?us-ascii?Q?nUKIbeHUTr8B2LRyI0kJM7wUP8PWXa/8DAcffSOMOJAoGnT7MsF+RtWr+j/Y?=
 =?us-ascii?Q?UJmSVKXwZK9W3M1qYfGOheC22lA28h9zEcUi3dJ+aeP4x3fW1x5EcosP2vUm?=
 =?us-ascii?Q?ESQqy8Y4DXuCIpDvbi5i42Vlm1dkeHLdejgU5tG8kHqQn/R0xbH5Z8sPATkU?=
 =?us-ascii?Q?wdsNtIVXaWc8rv1gauYe0sSljssNpxI1CN7j9SL/JTr6h1/VoDk4k7BN7rZR?=
 =?us-ascii?Q?fgoFy/BDdo7CEnlRbmLmaM1nyHkN/mdfAkB6wTmiJ8Sz/vv/utTgySCVrA2+?=
 =?us-ascii?Q?BBheuLKJOz84w9dOeiuEUQhYLBoyhhALbClmSA8k4Q4DsRVkjk/NDu73hDxZ?=
 =?us-ascii?Q?vLVB87tA1S/QgCahp/Iq1DCMGRM66E6mLEEQECBbqgopaznk9QhiDFjtAO9e?=
 =?us-ascii?Q?YHwJtX2tVTpXZd9ve/4C+qQCa3vVu4sjGLmiBUthtrxYoSZc8quTvZdhhwZs?=
 =?us-ascii?Q?jF9lQ38VlKJwtRKjhh8dIXkB5fW/TzN4iinq3MR+hF7h8DS3bW4vWSq63JFz?=
 =?us-ascii?Q?BCVSKgd1PuPsaSM1Ahwh+jdT9+rV5E1AJdhNSL/NrSr5761ZYfM+5cMJFawc?=
 =?us-ascii?Q?t0bKEO3UxVzom7tYjMSGO9NgQUtu4WlrMMAuvou3xlj6ooMY+5Sh3jW41UQm?=
 =?us-ascii?Q?6wJPDMzA1BnN+OE8qo7IbqLhQDBUrZ/BvCuLqiXfqIvX75YL+nT+y6tvvH/i?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/pZR0ai/rKusMatX69u/2m/Gq75OVuvyBv6kZ3CNshTJFLcGBRVwzuBH2jd4?=
 =?us-ascii?Q?+PZhDKoCXAgEPDad0sK+AUMStgluokC3jlO5jfuTPYe63vPSj6Ufy+QRBn0/?=
 =?us-ascii?Q?6PLsOX6ZA5sVDjPQsxOEn1T6RmjxCD0+hqyg+TgMqZvLENqc98kQEByNjv6b?=
 =?us-ascii?Q?q3RBG/x+ZxolytUDZrvtokLwkP5u2TrsWxd/kZkq3BQ5wO1uc4jhmiNlciXD?=
 =?us-ascii?Q?Y0uwRHjorqoHFUX5NUWxu2KQ8k56ldFrQZbhnw0Y6R+Ftd1J228UPCogVqhj?=
 =?us-ascii?Q?s/qxZlwUWjHLBv5AuXaEKXaka/9yBsHOC04LkfDAo+rmQwHVY58nZ78ixAwP?=
 =?us-ascii?Q?gR/i6pvh6TOSMn/eK9Id6485ojzPh2dhWPqwpAZmVyvNESEJd8AfTPpQJ6TX?=
 =?us-ascii?Q?M5dptUwMnZvlGQV3sbIcbcASggE3MQHD8b2mM9zJY1oiiVmPtxz7ZYhFtVau?=
 =?us-ascii?Q?fVbMEyF/6vz0yFfIejZwoww/x0q8z4GYTn1sK+PuSThHVdRZvxId83mt3M0L?=
 =?us-ascii?Q?jd9d/67W8qghaROMOi5hUlLaVf31yu9s/RdBBxCr+ilTj8rrdclFc6GUublH?=
 =?us-ascii?Q?6JfZQcJ9a/+vhh+r+LpfF/xAlguPu9Ar/dJRJXBSong4ZRc87A+MoJdUMqdC?=
 =?us-ascii?Q?bwCg8dVgfOVYBlEzI1Q46mRTiQgFLBldnAb83QJgHkpV0icQby+m902ufuxh?=
 =?us-ascii?Q?gfIxsHLs57mzJPAmgA43dKpEL+7LERgBdNd+VMehmYVYq1v7xv4CnnpbU3FH?=
 =?us-ascii?Q?xkt6pABhbtw1fbhSJ8UHaK1kdX8aHZvijkPKbJVZi38dbEIkoFGWCzXyGvdn?=
 =?us-ascii?Q?SKZTWg9iQlMrdW8PogzFKaU+AOmjZtP3XIg1dBAzUab2Mn6zjpJo6QRbdyur?=
 =?us-ascii?Q?f/5lchQhVO3EGdolhNQGZJBVUu9OHJydZLGPiJqBXFJycFUc+ZhNw9mDh6TW?=
 =?us-ascii?Q?yJtAGXfsSn6dqM872kpQR3FSUXJODr1UvbwLcnd2N1PBCTpwQLfoTdMDcCz9?=
 =?us-ascii?Q?2mkq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c4c9d9-ca2e-48e3-d6bf-08db8bbbf065
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 20:32:31.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WR2iOgRGn+vdwtJYuS+VwRX/41daQaFa4iHFccPc6KDLx1yGLdhQjbQzJtsr85X7i0SpuIu3c//xpgf++jCSPHm3uHsYIolGBKvYHZnKWo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=857 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307230192
X-Proofpoint-ORIG-GUID: 4suYWNrMA4MZT16SkWVNtjIxTiBdq40W
X-Proofpoint-GUID: 4suYWNrMA4MZT16SkWVNtjIxTiBdq40W
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nitin,

> Devfreq uses the default DEVFREQ_TIMER_DEFERRABLE mode which uses the
> deferred timer for scheduling the devfreq load monitor function. This
> causes the load monitoring to be done only with non-idle CPUs and not
> making use of the idle CPUs.
>
> Hence, use the DEVFREQ_TIMER_DELAYED mode which uses the delayed timer
> thereby making use of idle CPUs as well for load monitoring.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
