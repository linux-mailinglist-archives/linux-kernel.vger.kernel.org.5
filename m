Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C7081260F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443100AbjLNDpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNDpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:45:00 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7933793;
        Wed, 13 Dec 2023 19:45:06 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0S65V015237;
        Thu, 14 Dec 2023 03:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=8w1//EMNTcW34SWYuLHRcQ7CSF83B21kQIxof+3pfAg=;
 b=kR/Qr/qA/o35NxOWmHGKdmVqVWOiXe2ql7akZ7N24yas/7mTHSgcdtNddFfTs2Xe6fEB
 UheqKAEX/0/vQH0hSXH1IEWNZaFmUhv1Wp8vBY9KxpxqU81p7TaoBVzxTtRHv9xoDuhY
 MK/GdF86rNgPhBU1LHWO0YlqlNIVHb+873OIthpttUlJWYHhC8i5tHO0OiJCAR7wdkti
 Dz0fr4LQ/8VgmVlRXmZ5JlQC80Zp4wVtswfowdWxNjN1LFc4YxQhd8A0BUGEXb+39Hfj
 b3Yu+JtsIAYjwdU4B/1nQYvigg0Ux6JcNTcPb1CssXhQApi19VpbQk7Hp/4NQC5eE3NW XQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3r0j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 03:44:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE3cU1q012823;
        Thu, 14 Dec 2023 03:44:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9f10x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 03:44:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBnWlsMC52YsBSCwckhFMB/wQ3iA9pvYyM973780aMeM45t66WQCoJtc8+mnCnusJXdVn26aGY04TZtG8HFA9SahXKsM38U9Z2Yz+fg+Bm2tHpQnAe0N9chMLci7/j188sHUzPjil3VTuO2bZlQlDXetF22QJkfvjfdGEqf8ybVFrlTsKUFrfQk0RCJ2GpB+bxA0O3fVtpWq7+hlq+IaqitRG2PYVzl9fJP5VRT0o+40kWeUJXuuKG1PtuVxmatzB6vw2l3cHuu3L6SUm2sTpJdeYSTM2lqwxkBCq69CwwteznasjWevhYBxmaBSxzjbHTAG6JO3tQmoYfRzTtCxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8w1//EMNTcW34SWYuLHRcQ7CSF83B21kQIxof+3pfAg=;
 b=llPoPnXMuHsc924MeCS34gOHjBfLB2eEn43Q0TkjZyJ5CEQjxykMOC/CEyf2uQMHv7i5Xeh92Z8RhFs3KvCM+QglmBk5qJNH5gl5OdVxWl2MXkYo3FJW7kXfEevNSxNIdVa1D+Hkx+P/FcduzDRF7vnzg4eX5BgPFWjA5UPkHxALlcnrwkYlu6eaDIWOZOtv1TIFkgfNFAewEFSLZggrEze0M5uc2WfpCTeXELupwOzSlIfrFIslZJK3fm3BrG9M1GEQ/tFq8XPNEjP9DoRwlVSGN9JwCyQ2uX69erfv4dTGt0qNDcZD6KTvHlEXS3kq+sWTAEjs6OyAWCK5jM5XuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8w1//EMNTcW34SWYuLHRcQ7CSF83B21kQIxof+3pfAg=;
 b=eTPayn1tIqzhxvxkJcoOknLGJzAKAkQipMYOOYWLev0W7bnVZEfn5YCNHEaTZujEW6jGxPFnKq17S9zHJYGnm6SoQULznWtTen1xQmI4kvORa4RntXCrWt1sFQfcdmSZbQHZG3pmS2jIq/tnfmoNiMsJTb8EaijjY88d7iiCjl8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6460.namprd10.prod.outlook.com (2603:10b6:510:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 03:44:38 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 03:44:38 +0000
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, mani@kernel.org, adrian.hunter@intel.com,
        vkoul@kernel.org, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC
        support:Keyword:mediatek),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support:Keyword:mediatek),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support:Keyword:mediatek)
Subject: Re: [PATCH v8 00/10] Enable HS-G5 support on SM8550
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fs05h2j0.fsf@ca-mkp.ca.oracle.com>
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
Date:   Wed, 13 Dec 2023 22:44:36 -0500
In-Reply-To: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com> (Can
        Guo's message of "Sat, 2 Dec 2023 04:36:06 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:a03:333::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bec2da1-1077-43fd-aa95-08dbfc56ff54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phTcRoPCitWkMAzUJeKtcyu84iGhF3NEHhTMUtOIm3Jp3D7lu1RmHJznstGzmDc8FlQua5+vXWsKFVTBgI1wspCNPFdm+p8sNs+shUahlim3uczasacPtjl+sDiXGgZOEtLk4KhentUDS24t+9Rdtkh59GX1zqZCvdfYCZ1Cb1MJzIR5C21CaaIRzTpg/G1Z1a8i/74kcj8+qZ/YbFmJ2EwqeB5QQVf2jUSP6was1+utOw6LBOLq64gOKAD9aVESSqrnyF7TJf8dQnIcFHzqYoecpjVktu0idr5rSsqIaSbdgTkCkZx2yYFKW0cditi84jDzjZFrtl1wGZuzKjGWivTEWOPJiWPhmvG0+/V2YbfRH+BMEFUlH7WWW3UpSt+FqI6fcHykh5I2KC96Js+cPU8aspJYDfzo+EHnu38NIe10a7j9IqPhyx0fZOkSspHLKvTZp64bIoRq99dsPQPZGRcDfKMXwvcMA4xA8zfglC5f1JWblMPwFcdKuKNQTCZc9KXDKCVBi2nPI9ptrxnuSBTB1dn45mZbCAMrDW3oaMu9RIl5SFFSjYl4WKXus8AT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(36916002)(6506007)(6512007)(4326008)(5660300002)(7416002)(8936002)(8676002)(41300700001)(2906002)(6486002)(478600001)(316002)(6916009)(66556008)(66946007)(66476007)(54906003)(558084003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t0JsWGLWsIXLinKxP9SZkrD5hdY+M4pYDYUoF4ldWIUTVRr609sLLbqIumY4?=
 =?us-ascii?Q?CU9rqUl6bHARE7aIEO9NTNs8lNoWdPz0/9C0LH0/YPfszyXgml0yfX6vXbzs?=
 =?us-ascii?Q?PWrGr6GfeagmsQfKrvPKf6j+2O0BFqyQ6W/l9ZQImso7PvAt7nr7GVAXWC3V?=
 =?us-ascii?Q?iOIU8X75a8ZQD5u5QhnCippUUrkqfANmre6gG82sJ1OPfdmjwP4zQPpK+msq?=
 =?us-ascii?Q?Q/KsofxXdFvULqm5quFeSzIavylQFJdTO2ZoWwhlpvRVFEXk6VuJ83+pu8iq?=
 =?us-ascii?Q?GhjL+oc3dmzo/83Uur3W91NblHIiofM3LZ2AQvgI7zND9nE3MhhvtDfU7zw+?=
 =?us-ascii?Q?I/8pSletUTk785TXrRPyNuxhYyfzsyrwAmw7Y7l+V1XCa77IM4PMQAUbOBHO?=
 =?us-ascii?Q?AucrhepkM3X4KyiymfJReCAyQ7LUoX6TatqpD6GNMGat80141b+MCifrdxt2?=
 =?us-ascii?Q?bLf0QN09JfAC4DJe/z+RiyWm0qG259CSZ1FpDCTKL+QdZWouvJ+nm6jkOFi9?=
 =?us-ascii?Q?sDYFr/NCfRWtEa+0PbkzY1LgdTY65B4NaU0wBb37XEXaf7nEh2YS7ndfVjBP?=
 =?us-ascii?Q?0OT13gax84baXVOJM0PWxN8ShkbZ8ZlEH6CtI3FK4Bnp0TqSXHbvhmEX7Z2v?=
 =?us-ascii?Q?nPX0eaw6lNIX9Rqi3HF2wctQTT1rK8y61lCyRSSqkQvNs/tsxUYRKHBwcUie?=
 =?us-ascii?Q?uVZoUHwb7U6qvsj3gvAuH7H24G6C8LVB5SkzdQpAMG0dc9JfhodFqK32kWOb?=
 =?us-ascii?Q?ON3elkiSSyHG1F8RW80tjoGw0jH6FzM2U/437FBVJBskVbgCJONEHYWU0YaR?=
 =?us-ascii?Q?jliYh+cLtPnP/WJnkPpWBqcyY7NfU2MVyRsFWKqiKshAvnxAxc+gc57Za362?=
 =?us-ascii?Q?pDMVkwXpKK1h5HOPQeunJ217boahdYrH6R3A/+Hb34DuobwGcX+hHBXKeM0A?=
 =?us-ascii?Q?PiGPNsNleNGl6QUOm/OXW8mRxmHxTkoCBWWOCEx4FPdzKCczrn6dsYRgWENk?=
 =?us-ascii?Q?40bprsloAEsQbR9Jr/IEVKFqHsIQUK/MKB0dS0Rw+04Nc3A+Maa6gGF6+vN5?=
 =?us-ascii?Q?jAp7Bg9LXMkqctG+OUcM0nqGQj/kZ5q3Xzd1eneemBaCXEBEE6XnAOBLqJm2?=
 =?us-ascii?Q?gDu2Jqk+RYg1y0wvlDbGW/A5T42yuVgcUzEy+OyAcIhiaTG/Lp1SuN++jlH3?=
 =?us-ascii?Q?ogKO3ZAFGFHJLhyoPqZfLbdfUfjhBH8O2LAT6Xh4pzw683VVvAw84CwxvK/Y?=
 =?us-ascii?Q?I85X8781A5qf7mLMHUERhs01cBdwlnyveB73wqzjtNskzosmLkcuaZGTOnYi?=
 =?us-ascii?Q?JOyC62slJ1xTAl7O5Z+8wWkDYBscv3X+ftl39s5tiq2fN4rqn5lORPqv7ifF?=
 =?us-ascii?Q?xsAmPLfrrsb8HQsHdTAyMS/JyQII5iBD8a5/ZH/54Gk3Iahmas6lHbMl6AlT?=
 =?us-ascii?Q?OPWeXlNPROW/3dbvmm250Fwv6DL1SfFGpr1E1Z1zSL6TqgrFj6J8eP9B7YCa?=
 =?us-ascii?Q?kFFcGrcG/8YY/y8udysET9prMr7Iy+NQj5/DdKkP5fmMnGoM+q6+YddF3wsv?=
 =?us-ascii?Q?ONYvmJnjBd2vkKtlkzNUnm6i/dq0PN8PUucWai+M888BoxZjBAgeSGcDfHAu?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z2/VWdqJg7cc9AWAEhwHpYviGEIV7p8tZB4ufyarFmxc5pnDsrVRm7081CmtxhNnogJv/avqaviFo5nmELx/7Dek6jbDTICTW7hcjo5zH4Rls4UvaluNG7FIxb33nhhjTDdKQ32osI5rBvPhHlANlBxy/eYSaYnnVpYDLJdyBsHG0RfZIFQPdNhl2TMmaXXr6MJVaJeuKe5HirKqSztJwE4itaxPCGSmd6+J6GuzjYMOMbgoOOVBhbfIaFL23mVHVOHdcGaFZvXMoeDkL7VE9igqa2sj3jYfmULea40hOcipraQla9YzkOWKXiYdkAp/Wh+FX/rhQwtvlVQ/3zO9bC+/QglGqdOosR+BJzjMkuhgS6+bM4GuiYtmBho53DTM54QpKnjuudBWrGhmkpcakbr+e3534ek+Vh6jNYub9QRS8HcVHPqv9sbMgIzcyrOXC5X9FAGyeaUMbigTkR1GGtZp1+ojQSSN3yL10Kp/2iEsMwEl0BYx7kU6z3FUGQDMKUanN3EIhSZMAkKEDweNvQt7g5fWgGH5IuH5AQfPh27DZ+hDytL/CF54YANyyh0gB4WBEX/iIx+YyiD+RJY3Eh2F9LvkNBI9nbkfstF0uD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bec2da1-1077-43fd-aa95-08dbfc56ff54
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 03:44:38.5263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gIQuveDqU/gXwVp71CRpH+/wyk6sx+x7DozcGFmnW+UI4rvFWpI3LuQqK+KoHlFQ2kavk4H+oVKxrQPYti/PldGkUGvrFK/5hFOv8fdqwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_16,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=920 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140020
X-Proofpoint-ORIG-GUID: 0YfaHu17VhVgUutTKyHE1G493YG7xXeK
X-Proofpoint-GUID: 0YfaHu17VhVgUutTKyHE1G493YG7xXeK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Can,

> This series enables HS-G5 support on SM8550.

Applied patches 1-8 to 6.8/scsi-staging, thanks!

The phy patches didn't apply. I assume they'll go through the phy tree.

-- 
Martin K. Petersen	Oracle Linux Engineering
