Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF787D600C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjJYCpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJYCpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:45:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01703D7D;
        Tue, 24 Oct 2023 19:45:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OLUfDb032449;
        Wed, 25 Oct 2023 02:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=wS2yQZevTuc1miun1dJlkdZ0qd/X1HV5JycgNxRC2HM=;
 b=AWAhPzHWL6yFMZFTnRDBiymKBJrdMFvAL8AnF5PLWJnOtA9OiQNUY6HcURlTQij1+4di
 qxGuFtVZjdvgAr+neU7eVQkLItURgc5v9gewCTqQphPupSR5VDOrUi1X8u2p0OQLKyOk
 GGADKqhyvUDwODK7g164frp5oLfjsrAOa/ff5QI1Ft32uxIwMsle79asFEI8ohccEfTX
 XSq8PI9w1XXEuTne6glCvmgLCw9c5qtTT++IGCIYsPzFJ/9IuFUGBic3TKl7lEsYJQvL
 fJKmxdRsQZS30nzdOlogrzcK8Z5T7ZvqxQwcIm4rey1w0obQlnXSVQqgMso0R+NcY7lf 1A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6pcxs6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:44:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39P178ql015271;
        Wed, 25 Oct 2023 02:44:53 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5362juu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:44:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH2k2qeaQG8eUIssdQsmj5/AbyziMaHusoCweS++MLohfhoEZptuxMmX53Es4NBSl0mY7BbIshVqo0E9h2JvXx/op80GREWyJxkEcKZC0mV/FVhI0IDliwfjdMXEPdE27VbeoPKUjnVfjk5sScOdb+nCotwBAs8Crt7IXXWWRj2p3XtFObW5I1syirqIwHbz3l/mXb7hGEqf2/4v1xi5hz0ZZ/2UFXW9LX8znDvbWIj8zBkO4ABaUbHkyYf2FUp6FMHyMA7OPAvpgrYVbZDrOxp4jfW7bFngDqeddA8TwTCQ7ZDhjhzMCLJ8fdSSCUgUECeu/Q5tVP3CyJQh6HpoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS2yQZevTuc1miun1dJlkdZ0qd/X1HV5JycgNxRC2HM=;
 b=nS6EWYPhLlNtkNa7+2CCYviYarphqugxYP7bvDum4o+ZpEfZQKLtmQ+utTXEOfjWyBSy1NONzBlrAw64eITONWwVnypbjSv5L23KmRDiHGZQpYuthKwcUzIRU18GXgFRLifcrlJdncr6tNGysJUO3yFlRWy2R1pZCy7+tuASchddAZFyKN7ygC+nHgEwk0BmFHIaAj2NIbOSQAi8d0xKKFvIwG/y+0rR66z4PeottlnGZUgCmqkqqSmFqLD5/qdVDmOiIG+utkOoKNOlAzJwgRAfh9EYAuD1XtY1UefFgPYFrLNFY6tfd1NNjgiEgIjw8TpR+cyhH5k1ZPqDW4eWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS2yQZevTuc1miun1dJlkdZ0qd/X1HV5JycgNxRC2HM=;
 b=GI+CU0FDWwiYUlKlIAS1hBfll5CX6uWkwpCfO8P8eg0P2M7UKJSho037bSa7LirvKLhT0JodSMTnZOggkvLBjuFds/bhCwfTt/Jqh+B280Pw6UTRtzqlid6zF5t4y9KTZJdyVQP+3A9+FBTPEOEI/DEuH8lXrf+IqF3sFxRxkvs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CYXPR10MB7924.namprd10.prod.outlook.com (2603:10b6:930:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 02:44:51 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20%3]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 02:44:51 +0000
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, mani@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, peter.wang@mediatek.com,
        beanhuo@micron.com, quic_nguyenb@quicinc.com,
        Arthur.Simchaev@wdc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ufs/core: ufshcd: Conversion to bool not necessary
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sf5zctew.fsf@ca-mkp.ca.oracle.com>
References: <20231024183401.48888-1-bragathemanick0908@gmail.com>
Date:   Tue, 24 Oct 2023 22:44:47 -0400
In-Reply-To: <20231024183401.48888-1-bragathemanick0908@gmail.com>
        (Bragatheswaran Manickavel's message of "Wed, 25 Oct 2023 00:04:01
        +0530")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0083.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CYXPR10MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e508c3-e6cd-4612-75eb-08dbd5045c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OG3V1zOio+w7UG0uR9MinTeiyYyJxiDDVI/WIsMFDkghKgD7UZz72ZhqEvjrxdXjZO26JHVLEUVncPhmYxjsZj6QJ+vB3f12VhxWo85KNxOzHjIo4EPEPRfjQZHZ9lUhcOe/8v53CYV6ca+lFKOvn3oednk2YL1tBRjAYkJDDIXG1Gh6LfjdQDKsd4IuCXU7em8Ukzs3iEyhBo4mvAdWbo4faSXoBPhXfkk23D9gMM9e52jeF+ygIZzch6ALDm5XuV7CIBAk6jOn+GmWXCT07lKEgSoOwN0LWin389TsxMF3pEUO5tmqdzxIgG23EWOijdw/XZT2xA6dWiX9hiMxZB3V2ZPo4NNtPTEilIDYI8T7t7OxTJG8w8vU4376kdusrFFo6mjmkei/ab6FoVr+EDD7aew7G4D0XbqMHQ0e+E2PYMUCKr473StalYGeObyyksprHDyrqULcI0iTeOQnpddtshm3qqHMtOouVTp0tJvMwbLIlixl1HmghVv3wjcDRJbE0dPTPobp+PBaRBI0A4736zY3MYEt2UTy1k9F4HAYudjYTFFyJmf4WafAJxlx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(8676002)(4326008)(2906002)(7416002)(41300700001)(8936002)(36916002)(6486002)(38100700002)(86362001)(26005)(478600001)(6916009)(558084003)(316002)(6666004)(5660300002)(6506007)(66476007)(66946007)(66556008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bQH7styru118wkOT4FScgFt65cRU2Fkt/anyJZ3NCnXOWHGsIvpUySfh8VX9?=
 =?us-ascii?Q?5XwvwJChC0Snwrcgaipq089gH9jxzVn4tDVOxI2ShlLFSvPyjAGsj+SQNJsG?=
 =?us-ascii?Q?4cvn09PXyjZ4ouzRg6xuPSpyTj0rZsgQBBXb6UcBkw4bbyoR5TsTJz1kJNWE?=
 =?us-ascii?Q?lF0fHx9Ce0GNwLTx22+kfj3IYcGmt7iR8n71r99zzikBweTYfrJq9FT2wvc4?=
 =?us-ascii?Q?ZEhPUEAmaIKMNsRB1t0NYiIeXkRY8mlxOVg925tZobPqOQcM5RaulqYWYv8s?=
 =?us-ascii?Q?bBoFSRCpdNggYqtbYc32pj5qnIaTDdw/aIwlC4PDk66atD+9KxB+npd/juWS?=
 =?us-ascii?Q?9LAPFHZzUu80bVjPc6lrTjoZ4p7n2sHlXdStCKkxH9/W2QwNed6WZf0Af1iG?=
 =?us-ascii?Q?h2bVA7ndX8QRLO+ji02eUC0Hi5aiFLgqi0wuYIIDMYcdTg5Bn1OBwzRPelxY?=
 =?us-ascii?Q?H02TlCmE0cwSmsG5cRIYwx08BUucEmAeMpo9f7ulUKglhzqSQ0EZflov+09Y?=
 =?us-ascii?Q?XRKlzFgS/y+wMDLRV5oNHtqpMLALaTQO3DQa1/xgVC59fFshRkZd+uZSDP4V?=
 =?us-ascii?Q?/evIDa2nR68Ix93j400eJeTAUxZTKEQ2MFTURH7SNraGYqERVik25ka/+gFd?=
 =?us-ascii?Q?yAnn8iZkvuFI2jc5ssfZEsWX8tjjhaGxPSwPshXWKuDDu5rBaTm4Q7yyBM+3?=
 =?us-ascii?Q?NnbhaKOfrWkKLBhLxoIdomwzAKD7sqXi6RTN6wzZxLqx4veqsfnUWbVGbiDO?=
 =?us-ascii?Q?WJnoYjd2kpwrO7Wp50/hZIb75LEPYi224EG9uhTu+9IkH/x3JNtWaN9TWP5c?=
 =?us-ascii?Q?oNh8SQ3Rn8pH4PPMgrDTFTiNl/K+VWV6r66xqz2BaGdXvdwKn2LNQrf9LUz+?=
 =?us-ascii?Q?6BRRSQrQkKpfxz361j30STMlH4lOkeVkkZIUHnse7JCyVOTW+OhSYgvpszeA?=
 =?us-ascii?Q?S7T/c3TTGgkWUtPgDF/L+wIhnzef1pEmo7uKXj3q+VeMKi/g6fTekx6QsfoL?=
 =?us-ascii?Q?dTQIpXrmcsuRZY5mmOVZeHA1cgs5Khs+ED4Alv5iFD0JZq9E3ft3yUtmsS1s?=
 =?us-ascii?Q?a2X0UdLM8+D9Ir8RM986j6GuKMaHAK2+1MarUlQW/QuxDRpOivuJO8vnWTAc?=
 =?us-ascii?Q?wOoeI28CEi6M6/9ppbgN1WsCKbi8yVJMOesCBZkBDdkp8dDaHNyGtrWnCH4M?=
 =?us-ascii?Q?lgjsCsy6zot73XkUfhiKFJHfa/+2ee1LhmQqpsI/eym4A4j9dTd2R+OKWVwb?=
 =?us-ascii?Q?rV90WRmh8x3WgrCdcV/u4A9dhYpDfy8PY3b5nokXfBwnO9b1sAo0DYnljs2o?=
 =?us-ascii?Q?3YsCglLmLIVINCEpva0tO4MXNL5uAwgm4wB69s1awYsLX0VHlLXQiiqXMOL7?=
 =?us-ascii?Q?7QpffOD56cT8mTY1ih/e6zCPQVgcv9c65Ik46bM19NRlNsyLzI5jsIMXqzZa?=
 =?us-ascii?Q?udLrj9z+TlW5Y/j8+WGmMO0Zds7HARaYbSO42g+mC8U5X4Eq56arV4dG+T8b?=
 =?us-ascii?Q?+gK8EaUbgKnF3je/2kSgDExr3OATY6uGVqyXy9R5sHO5M/TyOIU9OB/eAl7T?=
 =?us-ascii?Q?h6dHLUnK3WX09kj+6qfqhIgO6Yj6sQ69arws9+nLFXhqQgya5cqLRyvoxMTt?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Inb6Z5ND1ByaVG2lEhxPu4cHV5wjJXhrYG4gvlWXFVk1y7K7XWkKsKsappNS?=
 =?us-ascii?Q?x8yQoLN+EPI8fruBKMw/HCdCLZ8LXqCBNDBaDfcNzmX1KTkQVvD/PGK1kOBk?=
 =?us-ascii?Q?g5grD6racNQc7urVdS3or4hp4Z1Y/BQ1A4Sc9KeYkKpw8HQR7YSsLij5NJ33?=
 =?us-ascii?Q?9+IyN/kqivQydZqkyG2WOMLMm+kkqZClV701Z9RZVV/LjUWu9kN2y6dIfvaT?=
 =?us-ascii?Q?W/Mxvt55aA+ej9AnIfsuF5Vp4iK60bhT7snTRVqyrZrEg09QNfY0ewtn788w?=
 =?us-ascii?Q?LZuiinEFUgNdNBlz16jtvghsqpeRNtpqNI/uOOjel3RyT+SIb8hhq3PFlYx6?=
 =?us-ascii?Q?pFGT64AsOsiuZyFhLMi7qAZxIpG5iw2aFBkZQRkHEw/o8Cl7Cqt0jpVFMKqR?=
 =?us-ascii?Q?D+em803vkNqRlZKscS7Igd/GuRI/Tw4ePhn/yfqtQJtMN9SRGX6ea9pbJs6N?=
 =?us-ascii?Q?8kn8hDRG6OdTfqg1QKXhbchrbRbmhMgP2N/k4KM1+bqKcR7rWxGNNR9vnWB1?=
 =?us-ascii?Q?/rZme1DifHXehEwNvjkAiu805+iFwuUFXbAVo6NIGS7vavkfW1jzH0SqwwX2?=
 =?us-ascii?Q?TeWCT2N7NfYnzuFYURCm35R+m/scH+p7HN1BsbAApNeV9RIGRzLtlkGsVNbE?=
 =?us-ascii?Q?oPH77FyrXc4kYH2zvi57aWySaTAxXR6YcWq2CduN6lox8ycBey39FkjhT8K0?=
 =?us-ascii?Q?ophW/XM/YYm+MQ6qr+09uh4VWBuTmsFkMWeVG31fuZC+uqx9SNmHYZLSQwUJ?=
 =?us-ascii?Q?ZqiqXqLYr6FzIeGeh6KG6sp4Tyvu7V/7OrTPxNUUJyqT0yhgq//wtNuJqowV?=
 =?us-ascii?Q?1+nMIdj+NRHPadk2HYtavokhaYukO+lRHozcrkiC6VhGXNS7u1Xm1CYmgE4e?=
 =?us-ascii?Q?lcv/JHwwbF1vz60NiOncjy4C8TEMwkmM5sX9gTY06th5ZJF7SejZwB/fs6+h?=
 =?us-ascii?Q?tNQRH2hlUhYz9UnqQD5PdxxPx7lkYSsRMLNi5C8zjJ72iEAiheefRgPznlag?=
 =?us-ascii?Q?E0DxxgslvwN5qPbamgzim7yvaw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e508c3-e6cd-4612-75eb-08dbd5045c6f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:44:51.2051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDIw4LCyweji0xB44Dn3quVIEIY1jjOQyzswyknJXMoqgTD7gAOCVYJq3xAUHm/6zvV7iH1u2vIntU6BPeowdfrQ7/sIrqq5iWVv4shnCHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=466
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250022
X-Proofpoint-GUID: ag3W-moFXPzztfux5J8FlT0CC2orFeh6
X-Proofpoint-ORIG-GUID: ag3W-moFXPzztfux5J8FlT0CC2orFeh6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bragatheswaran,

> A logical evaluation already results in bool. There is no need for
> using a ternary operator based evaluation and bool conversion of the
> outcome.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
