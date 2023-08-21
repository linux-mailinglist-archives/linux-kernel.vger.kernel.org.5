Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFD78344D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjHUUiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjHUUiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:38:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2B5C7;
        Mon, 21 Aug 2023 13:38:22 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxUXf003622;
        Mon, 21 Aug 2023 20:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=rYPQnklKphjdQfwhqh+t1iY9AbqDVnnCDgaDsyCXTiw=;
 b=TleN9AsIKpbWFWtyW2Rz1tMoo01QrdHd3jfr+DEpHdA+TCUFYuYMVliiTE2idikqZUoM
 BcqB0+pwwm9pN9/6vJKcKuF3PQLd629yAQJaoO04RF/tVQKRPsO+dqf8om+EXoBZ0aTP
 mEgpj3Isti6xG12afj8XV+iv40YI3TzKSTVR0/v1wUQiD8xV0HO7pvW70N804Greu3FP
 yiRiBJiCk327gdcIiqK96kCpxIPnRLs787qKgjYNBGOzFkcHhVGnG+LNxj87xsFSzMYc
 WMyC+HS//LDDOm29bakuNks3q2s4FWK3wICQJFY7Z0y/z6lPkPYpuY82eB8Whfnzie74 UA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmnc3uav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:38:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LInUEl026639;
        Mon, 21 Aug 2023 20:38:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm646q4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:38:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8DQ9ijX3hMYbD3xfA2srmY44ARdqUCWHp/JekKXcgsAZ4dtl0plL55MFgq0qhbZvH/mRHWVBSBipd2cy+4Zzut+W/E1scG375mIInULIigeGO3vkyUCb58eDPmGZKpN6ckdMQPEy81HAXaRzXSdt/bONqS+YlduLl56db1SiBUhL7KSDhg6x5D+V4GTfA56G4mXldKxIA6ZSCzgqTO9bHH9b6aRZ2xLnyEnD5dUC9cYJ/JTQi2VXG+9fx7uFxtKOfhwpZ9cvYIFOrD0ni3GDXMtP+RGT48LlwMr2anRKXtnKUsfgVU3AanodH/GTQxQBCcd/zgQ5bLXmDyuVxpCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYPQnklKphjdQfwhqh+t1iY9AbqDVnnCDgaDsyCXTiw=;
 b=CkseFzoTvbrFeAgiMSmEPc/g4KgzBnp+7fuB2HsXKBvftVMkHONiEDoifxN9V5WbcFBJ2x/1lOqcRZFlxtnYEGVnO6BV9CAo63rZEsRybTsx6GySQ9wTT1eXh2CCY75fpqGj32cpv3BHeVrOyhYOHlrbUORel6fRW448UDi8kwfgRRQYMngXZv74UTLqyHOXXd96jDUcjUjyDYSBaHNt5NKI4UZ5Pg6zfwU//9Br/fya+LuSDt+NyujU4X6zRk/T8T99J4QFR8JaWcRPxbslA1dvAqQ+SiAgoQ6FcyDdGpj7uPmURs3UAXLfaQJr4sFOm/wHJkDgn/F7hNqoKnK9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYPQnklKphjdQfwhqh+t1iY9AbqDVnnCDgaDsyCXTiw=;
 b=HaiA5XJSFZos6rBATzDOvWIr/ujudl4zIgdvIzLPQk9WcrNL9wtkR2crbEeMlkdFwgPtXZhQEIlmj0AWLaQozOe6ztTvaGAf8g446IE8CZa+LL21fBjaVUafyXuMF9t8nrGCbopUStjspsI6wIcGjNC1HsZ6/9BWhrbQQkNM+Ho=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5817.namprd10.prod.outlook.com (2603:10b6:510:12a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 20:38:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:38:04 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpu.wang@ionos.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 07/17] scsi: qlogicpti: mark qlogicpti_info() static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wmxo8739.fsf@ca-mkp.ca.oracle.com>
References: <20230810141947.1236730-1-arnd@kernel.org>
        <20230810141947.1236730-8-arnd@kernel.org>
Date:   Mon, 21 Aug 2023 16:38:01 -0400
In-Reply-To: <20230810141947.1236730-8-arnd@kernel.org> (Arnd Bergmann's
        message of "Thu, 10 Aug 2023 16:19:25 +0200")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:5:334::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd399cd-294c-4512-986d-08dba28684cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXY5rpE6rnp47DQEYciXFsSuBEB4/FqIIhHt2YaugouVyb9nqsQOe5i9rJ6nVoUU4w0Q6JmNBzbNUy3lJMiRJpfIA+KQefPCQ8ft7i1vdwEEsXUny1AtJ1ebnVIw0IjBd6aRJK0egpXM3zxl/pbc7wgWZG8fMZ8QPM3EV4jhZszXz5wL9sz5y5N7Daram/NK9vND7gfiZfolp8gmPwv7rNu2hGuLiqvg5gbFrM2QPhJvsuNeposXl++Q3QDrvD9ayZOgKtzt28hZhDmzY+WXTisgEeSRK4iZ/WtdC6NlzFM6hrkTyY7RDavCo3PMXz6uw3Iq9NGTIzSemW+Qq7i5+bw9j+k4Y1065JMj2e1yz/3T6grPRkY1UicQAIQ9NOygl4YOxivzJfuVmn92TWe9P/VPf3+2F3xY5qtrnotMurZTTXP2vOYUXCTFD07Kokho8b4OOCSZYva/cAXTYu8GdzndQVEgoQe8mfdvvt3XgbWg/TgOUPuua7KCCuosSJloNbvPbTIPvTgG+GQMnaBSBA++HKn+o5obgfI8vfVfjt99NeIAB532oYivdiNutjJQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(186009)(1800799009)(451199024)(54906003)(66556008)(6916009)(66476007)(66946007)(6512007)(316002)(8676002)(8936002)(4326008)(41300700001)(478600001)(6666004)(38100700002)(36916002)(6486002)(6506007)(83380400001)(4744005)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7XFtvuzbYHoOS41Hov73PTwEv0O1zN41LH6y/tpJanEKqS61cjOHaP+KBMYk?=
 =?us-ascii?Q?TqqZNIqTUf1FGlTC4CzOoECKByt/mhT5EOdzeiZsSextGKwh65ew+YgRpo8b?=
 =?us-ascii?Q?sQMGr+1eAlPCkZx+0zjz5A4+GaTnmwSdkp5Ltcd4ZlfLqjuQbVAT0CikdEjo?=
 =?us-ascii?Q?eDmMskQq90cEfqmPWAYsEQkAnzSPSM5mYyXit+r6hREEvlIIbSSDVm9kppWa?=
 =?us-ascii?Q?BTvbbDpFC03HcVJ82DjglDf4EfV3AUUIb5snkKwPst/ZfPaOC3hD1V6w5GrT?=
 =?us-ascii?Q?xLeaa7XY4vGg/tbKAwJIyic4ME/06PlNj7ntDQ7ZwYjX0Jj4j5f48DJWuVdy?=
 =?us-ascii?Q?iwQsJVo5mDX/VbyrGRgbGTAGTM4N81v3GHJ7W0pXDCN9sS53SjvTkeWRlu/F?=
 =?us-ascii?Q?m0AMrZXcWBgqQIaJqBWe7Z3j2y1ru92Lfu4fYhDmH871RGFnMjeXwsQq5IfH?=
 =?us-ascii?Q?LwoWSCM30SQt4AHyADhE9FHrc0ljzMMX/mPQR6ZXhansYxpssgzOpPis2SAr?=
 =?us-ascii?Q?Z3g2c1yyxjr+FxQNEqPM7GeOMvL30ZXwR6SEn1YGkvhmRjsJI/CN/eo9sbIe?=
 =?us-ascii?Q?bvUOgvkkvjsM4zk+Ie5xeueOc9Gn/H1QUju4MUAR8ViPcD6Ck6JV5zdNut9O?=
 =?us-ascii?Q?DQmdFti/9rJmEfaTIhRJNhkoKHpUw8pKcaB0M2rbLELJzXsdqyH/wPpILvt6?=
 =?us-ascii?Q?oIEPAcIbb7i2i/QTQdP7UKSksjIBQsi9dcplG+078nOWhCNOp70I9O00bkIr?=
 =?us-ascii?Q?0TF1YM4hHTWyMnYdzhqryjN6Gq8cFAVl2t8jY8QRLnvmXf/H+jYUej2a0FHd?=
 =?us-ascii?Q?P3+gJsNLuIjbwtwwMGAATx6kDLZKO0JNmRjCRMXrWsEIYypsiEMOizVIOTNs?=
 =?us-ascii?Q?P5jYJIe9XQCzEvWpYrF/ZXNqotiS9WJYa0Uu3wPa/xImV9iBOMhEqV0zZjYp?=
 =?us-ascii?Q?EqMJr4bUiBWXvWhQ9hFkE10cpvDbqhX2HB5VCvM3tNoZaZ0M8IZCokWuFvOG?=
 =?us-ascii?Q?D/SlCiQFtNvy07130gjpSEwuKJJj/9EyESjQT+438R6/pzyGc5Ez+uOxMZtD?=
 =?us-ascii?Q?g44ap0xBSyA8m7RkxVsubpQU4J4ylxDLHPBdKon0RQG4KMUhF1j8Th0a6wNo?=
 =?us-ascii?Q?qWx4QTA8VcDZXE4+AyP0VD9NH0uvfF53h0GSJQjfZ7nhU7drUqRG2o3um2o1?=
 =?us-ascii?Q?ugWZqAN/tG1iMMX/JQtoGr8i+5LnQQiHukFjv5rzCGlSFKFdQrqlbIAg42yZ?=
 =?us-ascii?Q?8IqcokAbZnosRAd7Ne8dB3JGpo/kf3sZXB1dquYKgO5DK0l+/qqEGDCZ3NcY?=
 =?us-ascii?Q?Fz46QPt7l8yW7OeuNPi1WqvSC455v/TT8dgRC5onowL90CKO0xr+CQaEAKzs?=
 =?us-ascii?Q?YWe8MsY+7/T0peYXaPHh622vIu/S5X9bJEj0jd2a5D6BCyppttBlVJjBCcvs?=
 =?us-ascii?Q?73ceLjzDMWfQC+6tjHMtOuHgqLO3hmroL8dYE6HhHg80K58to/5LwOa5jGx6?=
 =?us-ascii?Q?B/a/PYHa0kQfc5tK+FGx2ZnnVUuZSErn1O0sdi7UMnDE9qxDeL+3DbJhMeGQ?=
 =?us-ascii?Q?gDM5YO6t++jDqQulTtpxnC55GsJoJ5K+HlM0UgMem8YHo239Afq1ii4fJo87?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JeAK0S5Y80l6UNEcrbcH1V7KjVGXrPK+UZbHZ9IzioNCoiP0Tr15mz7NBnVo?=
 =?us-ascii?Q?on/oLsr/0UR87BLi50nwv88IkJLwPxh3weyX6CmXRxLolSOygDm9+GHDgbmZ?=
 =?us-ascii?Q?GhFpQuggfhl0bsoTySPmyufM40EKTssl117ACbZbwPbDyAdv1hK2/5m/7Fly?=
 =?us-ascii?Q?/XXCK9UOB5pvliSCCkL71YDHU392I3IUsz70HNOurtwSpHyaGRx9ETYpBF3h?=
 =?us-ascii?Q?wbgK40Pw4w3Cd/eHpUcfv5kgSUqqiF6O5G6R8j1dSJCik5twpO2eBBrgcnQO?=
 =?us-ascii?Q?6WInkV2xTwhPaW65OwE+fcrmBrp86sgvnKLhRFbk/zt44MnASgCGkbSoYP3Z?=
 =?us-ascii?Q?qQ8DsI9Uvt/Yd4Rr4dHazOopTt1vq8MqDL3/dGmR/KihB5S/D6cVYXQ0yLOL?=
 =?us-ascii?Q?8OJExjuulFiHpClcUX4N8aqVHQtqJSUUJlHCzPHfntEQyYwG4zRPCWBUq1tD?=
 =?us-ascii?Q?jAJEbuqQgFRrcYB0vFohsVFCODl/4HXN2BcEK6zBnjLqrm4EQhTDbS15nuAl?=
 =?us-ascii?Q?3eyyR4QisxsB7DwllmIFyG7uDiud277hx5i/qy6oMeHm2Oc+ptFrXDDoXoHt?=
 =?us-ascii?Q?KpMMa2cayAwy1sRdKzf5vQmicnhypTjMefANuC+9b5rKWf7DtLOhZek3IxEB?=
 =?us-ascii?Q?FX9L9k7Zza43I2fu/ACMfi6pG4KrlSgzZC/CXhcvO8aj3Tv+MPgaMX4Me/xG?=
 =?us-ascii?Q?m8KPLRUTnMw9/S80sbaIQF6CLP0M268PJtycXx0QeoQYWW2/GhDd+rPxZmEK?=
 =?us-ascii?Q?BdGpoxAOmXezSuOjbR19hyw38Vp0LK3VdhRf8rYyeOlyNT5tc0bej303dU/w?=
 =?us-ascii?Q?+XaV7U6kgIXTvYdyDrZER+7hDflGHuSxqj0mY6cF5GwDFuuE60P+9BjK3Awv?=
 =?us-ascii?Q?ee2rEBgI+esdRp/Xxf2mOhceUh+kSL8uBYZJIhcIm4Xx8mLtYyjDutbX5Ctf?=
 =?us-ascii?Q?B1rJZP4UziSOeGGLHfRlwQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd399cd-294c-4512-986d-08dba28684cf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:38:04.1792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EG0Mw2s1dn3y5NGlxolJi9NuDuwQjHP5CZC1yyeSg8wApFAWr6Eew1PB6dmuurjH0kCDEeTiO7JYaoETmRGDfPDWzCkSbM4zXMvN/xzzVzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=656 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210191
X-Proofpoint-GUID: v85GR8FwmoSDiaLTtuIdQ7_KjB4HuQYd
X-Proofpoint-ORIG-GUID: v85GR8FwmoSDiaLTtuIdQ7_KjB4HuQYd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> The qlogicpti_info() function is only used in this file and should be
> static to avoid a warning:
>
> drivers/scsi/qlogicpti.c:846:13: error: no previous prototype for
> 'qlogicpti_info' [-Werror=missing-prototypes]

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
