Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8352278348F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjHUUlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjHUUk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:40:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7673418B;
        Mon, 21 Aug 2023 13:40:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxOlx027365;
        Mon, 21 Aug 2023 20:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=W6w4jRDpgD0S8WlLNqgGhUDEUUDPk6cEYYkig1mv9Zg=;
 b=f80CYDfh9fg9vUBUrvCnFCfU2KG3r21Xu10R96m63UqqTqTzLreyiD7qw2LbgdZynQgr
 B0i4KxR5xW2EjR+VQrgi1Rng9+NdAg5f+DN55cyMMjOD6WA3SJVSWk+SP5XdDU90Bep7
 oOSSZJbhq7zMt0KyH9u57qxveqCOa1V+hDm4XzYJ4oNrE1RtksxmrgHqs4KhiXdbDh/Z
 Ek2e28JZOdAPrlSusIZ/o8981d1U6nY3nQQmTSIIm/XG2Gz8UI+wYC32ip8Tqf8eJC/q
 QZM4HPXG+4MeBbIIrNZRnT6p/q9XuY7P+k77MMM2Kh9SPT7E1oORlarIIN289yo4Gpws ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmh3bvqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:39:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LKDkGn018693;
        Mon, 21 Aug 2023 20:39:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm64evwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:39:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNhmQNapCRYIKMLcM/iUPvIVYOWV/TjU6BUlF8KExBUURkJ7PZuxjr4FFjV1FfL3LJs2oEsu+L2etOhUrD4oZQ+OKeIXLcQIae3QX14C+XflGKJ7gdjMQMRWBQu2MeVGSloo1kK6urWTCsc4U1KhimP/qtDdeS33vlTk6DJct7G4uxcuLlKofjRvGOKDFfdniy5ogXfOUwY+1gdDvGRwKXQyzvd/2kiX21xZLIDaDgTEMXlsgVPJQsac6o3OTpDU1SmTUDT5wsVxAVfx09ovWZGkUd7WXocRjOWaSrVfiPrdOBuG629+OiPtPBdYF5Vul7HAIkxUyPiQsmsFsecBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6w4jRDpgD0S8WlLNqgGhUDEUUDPk6cEYYkig1mv9Zg=;
 b=W4FVIaNM28IhbVEFf/3w+C77f5F/5f7RDt50SUbJkRHtYVUSnIgCBLUWrGjAZQ5BPvw36BNMau+MND2q9KHosBhM3ZBqDzjILw9tbkdoNAPv32uMKIlnRlSrtCrTYA+A1eEi9hvpgB5HXOoHYfZc/uVjR+TKJUlw7JzKxOwFgti/zE79W2192n2vjkiucCTSWfPA+EH1stTQCHbiPwZiknwfCbRyUPxK5DEVN8mpt7PvfApXlM2oeT2D7jzvibm+fUGUh2somMDhPkMTJYJ2688Dmok5o20jqIkv5ewMU1Tj+supu1MRutaF9mJUc0Yu/e9c3XAUcZdCe9wYFMcYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6w4jRDpgD0S8WlLNqgGhUDEUUDPk6cEYYkig1mv9Zg=;
 b=i58ushE8bBy6/8Fkv1uRmo1QUtNntQSeT6ravDRPRFNe2Ki1RB3tKGQabg3EG8868ZLq5jwpltAR0BbOSK8anU8RGgKc9dN3csg2wYsBO+nZHGI5QAYyb62UZCe/VxIkcsKqylp1ASLx/gs3pQxmud/o3fxFh8UnOH3J8opIStY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5817.namprd10.prod.outlook.com (2603:10b6:510:12a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 20:39:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:39:48 +0000
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] scsi: isci: init Return result of sas_register_ha()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lee48709.fsf@ca-mkp.ca.oracle.com>
References: <20230813202336.240874-1-artem.chernyshev@red-soft.ru>
Date:   Mon, 21 Aug 2023 16:39:45 -0400
In-Reply-To: <20230813202336.240874-1-artem.chernyshev@red-soft.ru> (Artem
        Chernyshev's message of "Sun, 13 Aug 2023 23:23:36 +0300")
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:a03:505::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 6594f5ab-351b-4a11-7145-08dba286c2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUE9C2fF5hnlUr50gtgK8T7J6O0sMsOLyRjlX1TszHEVA1gIQ3KcdqNMUR4n5XeJ3Nj1jSXefnzA8qZwG877NiuU3+y9gWqTDym8rPjpKD5pisNRIjhhKD9L4qUtTSJhOcVUJehuZFynce5gjj+8I2XdTL4c8t9lkD7DSeW4ARnw44XnnCrHLhSAR1ndZ2prrkbV/eKWfl+RdXTWqkAS0t/nHtcGKpiD4IwwuP/sczRmZy6XrtrvaaNjSx/2CYLuCTOqHnMS8o5Sw6tSYWVPl/5svGxffp3oBVZ9OL2OFASCgZaoYt0uTE75rGlN/buAFkJRGvshBzmqZV0gs1LGoqBgqriW/ipcbrzetopQZblhOzrIXDMRnZAHMI8kEDBsQRzQR8KhtfFDzDq9+gLSum22H2bal08iLNb/1KtYruudXRP6PrGYElSiGB2Jj/GRS+NuNxB3716zZTbRk2Oy80Isu6f/GQagJuMQ/mgXrTpFnSlrNj9KGLFcMnkXca/6/FBEiR3V5phB/0pDkQNKsppjYKGjFUNdSfE7MMOZsfvEOAmPy7ym0haxBmOKWnIn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(186009)(1800799009)(451199024)(54906003)(66556008)(6916009)(66476007)(66946007)(6512007)(316002)(8676002)(8936002)(4326008)(41300700001)(478600001)(6666004)(38100700002)(36916002)(6486002)(6506007)(83380400001)(558084003)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kahBOt8nivhbQhrcoQuFDyECmHXEHCSad8d3zypq8oZ7wTaVXdmScZGNu1Fo?=
 =?us-ascii?Q?+0peJArwB+KBUuEt+mA1b6aCkKr2Bn2+RXJIWpDCh6vUjdml+5c7vm2TOuj2?=
 =?us-ascii?Q?xNUGRM0GynFa/6OVAyMVeO9bUS7lASxw2dhX8pbX8hRcpWwxekJxkeXJvetK?=
 =?us-ascii?Q?ZKkb5F71lbb8BXZe/DJ9BdMp7kW8vVWjCe3UsW+i7PXNMw0jhxpQr0LIiAYh?=
 =?us-ascii?Q?2kSQiuzEIgb2busfC5cNU1VKigRgmQ32XNVZQ9cH7W1LHRR36CfAzLin5aUH?=
 =?us-ascii?Q?xZBQYs6PO+AX3GeZnc9IkfublYMNpB58yuK3UcPCd/OqmoquET7q2CFt7Gos?=
 =?us-ascii?Q?GAsaXPtv+E9X6CGY2fsG1bnj51E6FEGNoeC9NxLJd6JJlNvJskan0LxUSB/H?=
 =?us-ascii?Q?Xk2fer6PnSIZNet/3y7l4YLw1ZY6F9M3OdTmzA+k/VlnC7Re0VIMgIgMv02o?=
 =?us-ascii?Q?ROUSMs5XSZNZ8NyhxZytdjXujmvtlSgIrn4DDi+SIvBxXCFlu2EAW6oOsEWG?=
 =?us-ascii?Q?mmGO6QhPYo/2Em1kvQMuiiDFqz4hU2dKc57u7Ojpa3Jkz2kWuLVGofocg2hP?=
 =?us-ascii?Q?823lzgy7yFrV+1RQlXwIIv5r5I7kwJSSuh2Izj4DwKyhypubNNafryn/PIb1?=
 =?us-ascii?Q?Auy3gIqsZYPbIgM/khvorurTClKp9gVPyCtI43YiMGo3HVIPHsJtf9kkUaiH?=
 =?us-ascii?Q?iVl5w2Zo9EBivPvUsg+RqhjEU+xP7LWLajUoagoMfh4AjtuXu6rdUFgOqBeu?=
 =?us-ascii?Q?5AFLHilB2LmDjv2t+QHhnY2HdgVzocwdOMV5ewlz/M1c1gRt++73foG9mHto?=
 =?us-ascii?Q?DNFizHoFl1Py62fAoYvyBSLJgmsJAX/rlj0F8s4OQwgsU/kK+gTJEwoQzpOo?=
 =?us-ascii?Q?FLv2TBkXbrK2yXcB1jKAEZODoWZOHeg/Xgk9Lg2OWB+7GbLJTyEPe8EoWsLg?=
 =?us-ascii?Q?ye6RHDKAIQzmXFNCVVjjErBUooMjhHUJv/shQlkwfrKolcvf6A2Gjxv+tuTw?=
 =?us-ascii?Q?zja2EoNTAu1DOEbaXkZIRKHS5zl3ccu7mcB622GiBgEU7MNxpN6ckSS1H6EI?=
 =?us-ascii?Q?gumn03qVYpcW4BeK1VdaEnUZf4InviJlVoY3OZPkERJ580XxCqdo//J2EYg0?=
 =?us-ascii?Q?sMm/ktDFYGQFkzv5YRPHHHskfLJUsdVTjExicNOyRQxUi6Ke6GAmqx5pnokt?=
 =?us-ascii?Q?uSGemmI8j7hWM8+ajeF5CBY10+RxnbkrilADkcQ8kN8GCetO15byrgm8HUDH?=
 =?us-ascii?Q?q34lIKhSiWdRWJOD1Oq27W6qUf/s7v3ta4SmQ7bzsmSoU2rQz+rCwvuH7NEJ?=
 =?us-ascii?Q?J2J/jaFpafyRG5WNJ6SHkFaYLgcBhtpG0lYeZfU2QgVrulkGksx05DnRnDLu?=
 =?us-ascii?Q?ZBxUekFRXkLYiCDkFJ9ebIzKRDWCwk0qdY7v1e4rIHe9KIDTVY7QCNltJvqL?=
 =?us-ascii?Q?y51vpSkWVeIXHuRsbqePcX67D1S/xAgvwwfFxvDHh9zEaaAxB2JTsLxb8aKD?=
 =?us-ascii?Q?4B5+kuq68ts/TwX/C8BANeZ4fC9WHcJ0NpoOD4ZrkNbxwgVKfrhuhy6H1ftz?=
 =?us-ascii?Q?FJXZxF6FAKVYYO5Xeis5ydM2ZdIlMivljYFPSLxeo82sZXTfguG4WS7d2Ygr?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AoNy2SGRQLbdSmNGj9SWcWImywRmch4kFfRdT1ILfIndCorpaUjKGpNM9qb6s6hgMqP7ZingnRm0JX6GjWCBXTv+L4qgB2S+r6vz6iFI7wQaGPtuzk/hxE6LySeqcIvjehT5bDJThtT47zpTIt6XleTfn9iTxZPzsR+m0ZTWfGwr1LB8WJut+3hgumb4EkK1SJjpFg3CKpQIypuRkaTtmEBYcBvX897kOd7T0yy7xwI+jdXJ4/CV0f3sz+KCETyfg47UaGL1iMLDscai3AcgaB72U1SRkBlqXjO3P5doLvtLxourGtc5MDQLFZI5oDWNx5+U7GGhXcy3Xo/oJJcM8xGaMeb9RmBIl7yeMXLB8JqOqchAXsXUBAjyPhxVnvrTbLT11U6hBRWbuFLhldX9Rh/+BVi/BYsusUpocfzBpTAIT9VMtrSyI+mOMARJ3cGsanG7/U8WVfpHFddZ8/YUpiNCjC8dLoH5ftbjloY1wEWSnGEQZKcGTIwMTIBl1HMR778NsNrc0R1QLtmohNlcl1n7w4RTTZa9zzJrpiWaCxrYkWc1VhO3ufQo+Fc4TnSBikKZoxZG/HEV3qqWOqcIicDdnqNuzjaeBv9Fl7X1LnaYLo0c5PYU4wXyZ0EajdUU2M59JCBp/E9TQMxZWKOspRJ0DYZy2N8s8naA9SVSpqWSld0jON3NDjNMKTUPqVuVC6iX9u6HIpE0WQO/Ng2L5kHIpWFjznmwhfABxqiRgUxb6PQgEBSu6wxC2YEE6f9JQQijYAHrkoCOaf1ra4AWpsEFMr4vcm+7/vSyAJfusDaaptKo3V0lKg11KAIz/On0MYFnQnr7P3sIX+ZjDIlh7J3HPv/9Fxz0WWsBFvpZC79VISFsG87GrwXPcBVxwznfioGrwAJSp2aPcxFPIm4EEw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6594f5ab-351b-4a11-7145-08dba286c2af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:39:48.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvzGqVDvVUB/JgJToXtaOwPwfILRfyjCvj/hJSk5+Tzcmfvie/k1y6Yibbug+u1V172TcfFIi6h8v88z1MgRdb1aFUf1olnieMTNPr562XE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=805 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210192
X-Proofpoint-ORIG-GUID: WA8KzCv_HxxQe0w8NqW7inJdABE1tIm_
X-Proofpoint-GUID: WA8KzCv_HxxQe0w8NqW7inJdABE1tIm_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Artem,

> To properly manage possible failure of sas_register_ha() in
> isci_register_sas_ha() return it's result instead of zero

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
