Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37B175E49B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjGWTsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWTsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:48:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355F4ED;
        Sun, 23 Jul 2023 12:48:29 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NIxTLo016422;
        Sun, 23 Jul 2023 19:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WLTrlboy+zGjSwlUWkGAWvIKVwA/nlrrCOoQ9pgFL50=;
 b=yKJgyQSXyZqd422m24gvPUKN2oJGyNLw4XZofXYPTzVBKXkchLnWFdOnHVU8hPuMBniV
 bsZhX1VcoQr++AAHJ9Q7c+lkxv6Ub0fP2hxsM7MFiD+7cuyhGZfimoyYG2yq1wNSzvJQ
 KTGRnJJZoNz98/IFm3PYJgSTfTRPiv9lYhIChrEp8woKj/XXnCrZv9xhxlI56LpL++e4
 7ubDJbICbpNDewBXomK2CIsWM6OLvj9GtFIpswGg7GEDB6Q2bVBNd7zY1uF73PHpuLc1
 4ZHVbd+Z/Hldekg5xupvoKkxJzDS8mPguEtb8a/fg7CLBsuaoZsTIidT4O20ELLM7LL4 BQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c1hds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 19:48:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NEhlpJ035388;
        Sun, 23 Jul 2023 19:48:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j2pba7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 19:48:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNnwVew+hGaiLi/u1VxSp7h4fIHSKffrPQipNWnzcHgza3a2ne3ectUfgQByXnZYxmp1epHXrn0LwlSArH/s1t7tbwPLzFCdJt5a80pHPUp+pevS7Q+7Imh5anvjBuMKZGIHfReif6LywTyyzjBbMpxoS8iEWbQSPq8rvCYKNI+Ze1ViE1Up54+82P6t4pizQukUJj247zsjfbl9ahHuJ86qtrKt51kmoqvHvQqYp4o97Qttnp8TKupI10mRjzBoh4/TexElw+gkzPdBKz1dmQjEuCsCT1/iSa6KNTRnEpFGP+I4p4gQU5K8tRXWHd0fMX7GxrIsNPcsXnMa5b0f2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLTrlboy+zGjSwlUWkGAWvIKVwA/nlrrCOoQ9pgFL50=;
 b=oM6WUnydvPvUYUKZVK2xPZzG6rzNw/tQpw8Rd5lcZQAF7jZv6oa7ovwkzzDXJ8joj7C4J0QeOUWJWcYWIpkd6FbBHOrYyzz6UHZWLPC9TFK26UKD8xQ7EAQkUXUZ/P48iWQ2sY1ifMU8zUM8hJeFWhvckCleN3QC0BEF0+qhcOd/HGSgepzwy5YWCgcCnzZkJ7U/eZ3yaLXtm9Cth/wvbO8KOQcHm/m7n63tra2pWNtoZHH91cjh25zCyOyOa2iwM8Ev2rgDUNUvY6XLDuf7ZIgDlJERiDEkTSzHVuq7NbqqQZoYENfWajv7aJsjENuE5lTDbMAA1APLS64XchRwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLTrlboy+zGjSwlUWkGAWvIKVwA/nlrrCOoQ9pgFL50=;
 b=ebk/ev4WySvVDjFMiLHQBUrkWAcbvnuE81ayij5feEriGqvoaTGNh/VIDOo6Nk2zB+fFDHyIHzWoBmfKIlP3fvciDb69RzuMqPNmP1xAK/K3uFSQNNh4W1nkETZ8AnsRshe5E5uAzZ2GiN5QkEDTl1TQ9WZrb3sEUrZ+k0M+kAw=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by MW4PR10MB6369.namprd10.prod.outlook.com (2603:10b6:303:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sun, 23 Jul
 2023 19:48:11 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536%7]) with mapi id 15.20.6609.030; Sun, 23 Jul 2023
 19:48:11 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ufs: Explicitly include correct DT includes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edky5s0f.fsf@ca-mkp.ca.oracle.com>
References: <20230714175018.4064957-1-robh@kernel.org>
Date:   Sun, 23 Jul 2023 15:48:09 -0400
In-Reply-To: <20230714175018.4064957-1-robh@kernel.org> (Rob Herring's message
        of "Fri, 14 Jul 2023 11:50:18 -0600")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:a03:54::41) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|MW4PR10MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a338e5d-ff86-4c68-796a-08db8bb5bf0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tfeqIJcRFDtohfbaprverBtPssHE2AVMj7jh7uzDsJjnnsD60q21JN6VdX3Ni3aB9MRHawikNKw7tbPDIcXu841bKH4ke5vDABrJRCFHaa7wWYpRBrQri/Ma25ZcHMFcLmHGZPtrW/VkaGc/U/nMiltCWHjlScEtbpoQjPPk/P8GyyWuYADTOiLptYfpgiNKolNOrz3nLqUpIMjT5PuZUTkuQ+IFJ6ocNBmdOHKH/WPpVMG90R98WnoYkI1IOrMtlWL4x8nHG/vYyo2uUk8+G+ialUmOIzR7tymrVcpW47QgVQQ+agc9ZQKro+GgA6h00PQOt2oM1pG69EfnUfz83jC7N0MfMNYo2cYd+lte5m6BJDF0VXCV5IXVN5QYq3czZMpcBIMJvs9y4daa7WMLxTWri/w9cYABoPdFfFxtVhC+FIEfkAT5goJBd9xKlgOlExQzRNt1ogEsQxcj8U2f59MFWq8xTrnIO8j0HcwkCmYB/VywtulfhmbcuyOgxK2/8SvglMlxZbutiN25ZVTYlE6wlCaHsnHIgRmwJTE/6j+XwHzIKtjpcwjXePIsEW4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(8676002)(8936002)(36916002)(54906003)(6512007)(6486002)(478600001)(41300700001)(66476007)(66556008)(66946007)(4326008)(6916009)(5660300002)(7416002)(2906002)(4744005)(316002)(38100700002)(86362001)(186003)(6506007)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7F5yF8qcUYZMcVRxW2w65jhRI3SV+C8dYExl7FFA05oPx1kfA9ac3JQKTFYV?=
 =?us-ascii?Q?P4cYNOZFWO+GixHO25qA8SAwJB7C9C4+A+Y59x1/8bwWPmfBAbHAJN/u2Fjn?=
 =?us-ascii?Q?jxUt/s1h0N2ZgVtFGy5FGKCbmI57yKhYgiPCEKuKcnIaUWINe0aXnMC8vYcC?=
 =?us-ascii?Q?oyOqDJ7zo46gynjZf+79H46uEFMEkqTwI9o9jgZkRlj3vPB9Iwa+NP+/urFg?=
 =?us-ascii?Q?cL4J7YBPQ7cEUWazQ4mktq1XBKuyZKjX40kzVs5Zc46WoykbMEQ6mLe+lflE?=
 =?us-ascii?Q?RRCJx97vM4DCN42yDV7aeccZWiNl6Nq20UzmGlMhLNqXmPBzXXBS0YsfwiT3?=
 =?us-ascii?Q?w8hzML38PfFfCy78WToeBBrMQNc3TaSyBdM6N7RsN2D3D/FXqT0DEMaW3wwH?=
 =?us-ascii?Q?hgGHu9m2pkBO60S52Hr/wW7mKOx3mFU1MGnWJoMadLZv3pGJbW79lNIPlUwk?=
 =?us-ascii?Q?uLUduIGV32hUndvc6zX/ZfO0B1NDhtUDXe93eOPBeLGhTfHj2Zzdx0f4L/sH?=
 =?us-ascii?Q?K/I49F2hBnYIvLAaGLmjcrFetcheMp03MLPSxtEczFj6PA63i+uKxgPzYN3h?=
 =?us-ascii?Q?dc9JRYQ022pQSXcqbZx5pWB6jaY9thX3zplZTe/mFO56N1qfnZmTy2/FnOyg?=
 =?us-ascii?Q?daJPpgxO8Ex1sWo77X5yhHVbt0X7NjeQJtQ00zR3gUFe5cOK8vhPQiqShgGi?=
 =?us-ascii?Q?vPnAS5QSBFMJAfaD5D7Rw6Pg7XU5Y6eLLRp8CkVRxq0XLdYC/lm/up3lHbBL?=
 =?us-ascii?Q?pDrNCvTH8TSmHFEkND4N/aYbX5ibLE4Fsts54L6Z2ly303AApoDxPKl1C6vV?=
 =?us-ascii?Q?Gw6NLFIzfX7IlSo7t16niJpAgXwPohk4mywwHO1Xh/9IQ/q2gM/Vi3CFDz8J?=
 =?us-ascii?Q?873X9KOJIJR4WMMfwzVvLRG6guYAitq3WLddLWXFHnFbKtu+ODrmx9YuLfYc?=
 =?us-ascii?Q?IFVP/vGSxa6fTw2kDPmhCPIt/CK1nGGrvP4Lu1ibydMo/nQSfJJlilVbG9sr?=
 =?us-ascii?Q?xQdAT2+hXz13b3tH1W9v8DYaNypyN0fchNN7BGzBA1lU5V7fRWI+RCba6ME9?=
 =?us-ascii?Q?4HUTf/ZSROhI7aqXweqKwEbWvlqjd/hOfr6ucoKLnF0+iTibEUuw9wI6pksF?=
 =?us-ascii?Q?3QkTEHoxpK3uV8XPkkOD8bLKDKg1LGhd2BeQrYDpDLt3eSGsN1h+3cOp8T9t?=
 =?us-ascii?Q?fS6lrIaCX5vtSbL0w5WB50hCcYLGzNjFpx803OyvQKPmE6PcJCM0xarn6SNU?=
 =?us-ascii?Q?CZugBQFTf/RoEQqVMNdlmKvOmLJ7G5eGL9Z1zln5OVTYcib2da/lZn90TueQ?=
 =?us-ascii?Q?RRf38XZ+RCgZjDjPzv3sWVmFhAivkzCD3qCvXUI5XaGaDx+x7TaFzhZ6dOSj?=
 =?us-ascii?Q?jplyMdU3NszBIjLwe4PdaDCBUct8FNNstLiL679k0gFG3YEapikSI9Y26KyH?=
 =?us-ascii?Q?AO3lhvRRoKHAt6KnbcuHDeRci4Mc0fBUHUe8q29G4clcG7GKBYBXkslWgHlv?=
 =?us-ascii?Q?fef/RTyNbQVV+OZ02X3HeRSOZdgLn3/f+n8ImzNSsiNRrhWCA+5sKLibbStk?=
 =?us-ascii?Q?vg/GR24GsV5qV0tFiLP0JLZz8zPUJL+Fj6ImEDorHi2TR7Z9a8hRYT+mc8Wa?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?uSQhOqjbLfJxHTbfdfxRv7HG04hv7Em83fgXtssMazooAvafTOhtMX4xC30K?=
 =?us-ascii?Q?P6zmP6e+THH/NKw0Uiu+2Ak1uWcrAlq2Gq9hpQxvmTEm1+JYdWdEbqnmuwxs?=
 =?us-ascii?Q?omoTc+lJYfdF4cl0MuQS6ovltkqhpW+86f3McxpAMaWfmewFiRfeUTJsoXZV?=
 =?us-ascii?Q?B76AYqNOy8NGMZ669YDsG6xnhHYpWhVpEWtDnHilNATHKFRmbyQFwmykVkDu?=
 =?us-ascii?Q?oQhwC8C6fN5wMlZ5DLF3DdftR9zA9YKTyunOmYM1vpskmmoIBi+bdgYUis3I?=
 =?us-ascii?Q?KtPLpcaaWn4sLZp8R/L/WsGAvoXL/m2wcqrnwxmMBZZ49PoVYWykNWZM+P0l?=
 =?us-ascii?Q?IXLHiMcewCHQsT7na2O8bhiPv1DxyDrxvV16J0ow45W+cAxgOH1CaiJxKxJt?=
 =?us-ascii?Q?3riyJKmEYkMAfcbIXu5wG6dRQsY1EZDgH/sVH0VUURAIdXxH9tshhE+q+Xhw?=
 =?us-ascii?Q?BsFVXxk9GAJqakP9H7EgbNrt7a/ywqz9CqGojF2Gi6B8tWS2Sc3pwuYjfE8z?=
 =?us-ascii?Q?cLYeZVChS+nRrQZgfCp1M6MMHUch3Rok3QA9JuIqZ/0wVSF1ViIY6JH4ug/A?=
 =?us-ascii?Q?HcXwbRWR8mh3bPwvefM00UkQgnu3yp9sKlqObXmMPl6VgYJFSQfBnDjWCMUC?=
 =?us-ascii?Q?T8MkEaDhpnsI5H+IznsrN8CYkR64KxE6fvUI65Rak8blSnH8MmCWm23Qi7dQ?=
 =?us-ascii?Q?jg5PdgzalYXnSXB0WTuTR4l03Rr1vTRNE3/IgHsEDzzd/VJgs2QjhZABHCyO?=
 =?us-ascii?Q?ckLlVy4c+UJ7tQZoreBio3AlzVCy16IW8eSDf0AzIYZw15AVia15JjKB+Zr8?=
 =?us-ascii?Q?4zBPwCm+icWbT2uhuQyxq4616ddEADyZgT8W2W/gB6xwXzV57AU/SjLXapp/?=
 =?us-ascii?Q?3O3Mgc+AMFspU20/YFG4V0UmLUY09k7dgwX2p/PYmVGLU9sJy+5yi8No/qWF?=
 =?us-ascii?Q?/9JXZDZfsmRt9JoVtCnnLufYtGJiQPeQcjHSJkjecd1I5Ou4V9/UELQdMTg1?=
 =?us-ascii?Q?WvRQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a338e5d-ff86-4c68-796a-08db8bb5bf0e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 19:48:11.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 124UbB4nwTeM2FlE+LffMgWzJxE7X+YSVUp1K3D+j+fiBlPvTJWekEkvayEbuQLjFxk6DaKIv/LL5SUuDH5PEN3Bzx1ylWm1Qee+64yG4us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=677 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307230185
X-Proofpoint-ORIG-GUID: NWs6kyR_QF9h2LzirWYWJhl9oPD0Jbhx
X-Proofpoint-GUID: NWs6kyR_QF9h2LzirWYWJhl9oPD0Jbhx
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob,

> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform
> bus. As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those
> include files used throughout the tree. In order to detangle these
> headers and replace the implicit includes with struct declarations,
> users need to explicitly include the correct includes.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
