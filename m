Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA527E6243
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjKICgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKICgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:36:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B02582;
        Wed,  8 Nov 2023 18:36:21 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A91iREn019025;
        Thu, 9 Nov 2023 02:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=TovO9wxWmsNi8DzyoRpB/NtZHOeAPGSyXjBNxCjS7lY=;
 b=vlDr1H1O3IMKgy4Pny65tTiJdPRVooO106GyQ0AkWDPN6m2FOsS1XXI97MrGgECo2Ejk
 eau/PT7uO3VTGwz0fTdLu5D4roq6YwT6WJkt+rVur91WufL7EeyY4Kc3l7gnf+KHOCFg
 NVUmwjjQ8ci/ktpSGz5ySZZPTVKFs0lgBpHTZNG/YCoh7W5cKBuF5+auKAhTxBqsHd/s
 KnuwBF5GF9a929Wi7+fSgLSd5Bk13Fl1T9QT4nV1pXnjV0wza6ZtoN579g3SAI2Vnx9C
 xSWHwnc+fiSRSgAbmNzr/6WWm4rZN4C+we3BwMPPlTI04vA4cNLZCDkm4TjQ9JQqhEj/ kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23301n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 02:35:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A92TApb011123;
        Thu, 9 Nov 2023 02:35:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vr9df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 02:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrnrfWIznLiXC+zmv+hAQOgx0CtG1aLlMYKVJjzslK7rY3MuEDQvo0MHOc2KGAMhzcxDqzsqWdMoqaK3lWJiMIYKqjZXs4DHsIj4GW2li6LjoA0eDpytuyPlmuLHFr1w6mfFviymDA5nIit4DbeUeVdrJIppccyY9FeNDly+l4g6kRRTQhGi0WqcLwRm8X9ObgDjXbZlDAcXzfIgK7xpn7ZdrixFlJJPVn2M85PN3au2vzQyQZW/+00CNDq1RWERH4UGHenNiPxXxvp7vl2Xq8/paDex0Sg7qbAy7vDoJuFyoVqFwWzolW4En+2DZTzubv45lMdDkyK66sExQFJOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TovO9wxWmsNi8DzyoRpB/NtZHOeAPGSyXjBNxCjS7lY=;
 b=lDnrGGH6Doo6WPpPs2V9tkbZd8DqILVIEZxR34ZR/DDwRzMbiJ6IYcl6ZVXp76A5iK1SmPHucp/zIX5u8ItgvkGgd5iPYdODm4BOYT10P65O4KsCCS7uf/eWNnp5KU/Kyj8yVeCNMvvrNtsnUDmqSyO+t0HHK9G/fDhZkdkWoeXX1od023eomr6LZe41KeDZoNLPZeuui9Z897+7g0O+/IGt3qFqguxxtG2WSTfhNWj6ERisX6Y0GiBryt8sew3eWw0fEA8Hg6WTg82yK2+qDeFVSsj8x/1rItgLWYFcOARIdtj0aRZsnYMO1IA3LKtpKDn8j1gd/w56ZEpjIyyP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TovO9wxWmsNi8DzyoRpB/NtZHOeAPGSyXjBNxCjS7lY=;
 b=ANGQHnihpCsLCEjBUr/wYoGksNIjLMlou+H4O2KKzczHI0ol8+f6R1HGXJJXAyn7QTudfBW2qpOZu9UmjhRgfsjhU6iqgW5dITA1OxThJHjali/nOEhgTfp6F5wMY2V9XOZmWHAlrG/afO687dYtpnCIacjb1pDkz/NHpSG+Fhk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN7PR10MB6667.namprd10.prod.outlook.com (2603:10b6:806:299::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 02:35:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 02:35:55 +0000
To:     <naomi.chu@mediatek.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>, <wsd_upstream@mediatek.com>,
        <peter.wang@mediatek.com>, <casper.li@mediatek.com>,
        <powen.kao@mediatek.com>, <alice.chao@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <eddie.huang@mediatek.com>
Subject: Re: [PATCH v3 1/1] ufs: core: Expand MCQ queue slot to
 DeviceQueueDepth + 1
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6lv64cz.fsf@ca-mkp.ca.oracle.com>
References: <20231102052426.12006-1-naomi.chu@mediatek.com>
        <20231102052426.12006-2-naomi.chu@mediatek.com>
Date:   Wed, 08 Nov 2023 21:35:53 -0500
In-Reply-To: <20231102052426.12006-2-naomi.chu@mediatek.com> (naomi chu's
        message of "Thu, 2 Nov 2023 13:24:24 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0263.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN7PR10MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a52286-0126-4aed-a2f1-08dbe0cc9963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+iloQIUmHlXXG++t0ED1igZWp12BkuSe9ec6XWWVKUm1FqeC1GSlF+2VjP5eiv+uGozr67w3xDM+PGnp3QQ+3erZASO9CucSSwK7vXH8H7Y1lbaQBGSugzmJuF/Jnao0cLA4UBbRKYYkeNPVUTeXrVrZEV9Y3IOohKhtNXKpR45s0XDAHRDkRHXpsrzmmOpKEPgESEYaSs/jh3d7ZzwrbTNPjbkh25oUvgkjN3vgP5QgRfdhRfSOudPtHHZlXelH84Ui6/6zwOMg6uW5YPvaNxlPx/tTdHPjDr5Ozli02NjeIss4zN6LcOe5vdcAyO1wkUbKjf+PS8Ssz2tNGWQNgyfwTXAlBMujh0aJAI5iu7wSZG2coP+yWEzc9yrfhH+ICFOx9DYKd9dUvKK+h7+IAI5vQce3faOlDEN8XLk4pseTS1ZQJesRhP+z6T8kSaLeWMLfIkL1j01wPN35IDK5qFswmbwnprHycJTp8nNbSZdc9cGSQrwOCd5fry5icLLpAWBzDjowGgro09uPVMzmQGHCoKW3k48W11Y+CWeCvDUY7LbWlkeWkdVNOb8sFzv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(4744005)(38100700002)(316002)(26005)(478600001)(36916002)(6506007)(6486002)(66476007)(66556008)(6512007)(6916009)(66946007)(5660300002)(7416002)(54906003)(2906002)(86362001)(8676002)(41300700001)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YrnUFAASC5IBRmAKrhgkXfHjaGTLNlKDz3KO4nPzEiOOYWljMhxzPeDMg3Tz?=
 =?us-ascii?Q?5QJhc7MgXfPUo7v0J+bjXdyP45JapD3wQw9Drk3ETNybCjQxBxvfaTQQIFbM?=
 =?us-ascii?Q?gPvsYjNs2hUdRQjJVYVgzReMTzJJ8Z0IG5IkDSninwUo604FH9PoUvHv1ZD+?=
 =?us-ascii?Q?YUH43IVivMPXnqLnv0yBZrXGj+1GfqZMx2GWchKVJ6Gn1tzp8KHvztbUdumT?=
 =?us-ascii?Q?GTklnXZlLsZfOkc8BHVklHeL0tT/Wt5lxDMwNoFQ3u+qb7bcXyC/jHBc2Ibv?=
 =?us-ascii?Q?hRl6CoRCUUyWYtt4/4oX8QKOitedDL7J4KOaUg12HvQbJOJKbX3g9nOT04S+?=
 =?us-ascii?Q?+0hT2pCu64TUNd0XszH9pM66mNm/gU5Hj8g4NeY1Hc3v12gVLp3dNmXMUhkY?=
 =?us-ascii?Q?zmmxcNr/GdXZL8IMx+S/3WpvPCPNdlIIvCloDxow0NE53l7ACHNWZjfju4pD?=
 =?us-ascii?Q?IHoqWizkTGQ7E1/EBVxqbtREeRB4/nzDpIWDBVl9U4YlgYs3qGMYs8l+aQAs?=
 =?us-ascii?Q?rY/UQ2CbGfFV1zELNHy4M7GcU08JEe72/OgJ/4H0ReyFettxJG8K8AMEwe7K?=
 =?us-ascii?Q?iWv2Ycup5CEqGdZJF1u1vxA+QFTUKjbS708qIsi2zQvnjE1fkYltcvC4KPfF?=
 =?us-ascii?Q?jGfGfPXjx0c4hFXO+6+gtUAWJIWC0bGE3JKM2TDuw96dVDHOzYGMsHsLMuSO?=
 =?us-ascii?Q?eK0b7GRLAIbvAHpksOjUz6GFQNbkOoQpJWhKHtoAzTV6aalZ4yxlJOzQTLrS?=
 =?us-ascii?Q?OYgUo95mZai9IEPSY6GuWDRBNbbxdXGjc60EcssnQjr3zuqJyFQwdeCxWnEZ?=
 =?us-ascii?Q?a8FqulrcVbjmC2Kt6yOfhCmuDkz2rTITVYvyWalZE0CsIqepABDQaegc4/hw?=
 =?us-ascii?Q?BNgvPzNYWpHydLTjF9ggkL20knNQLYU+x5fDOpJbrpv4rVQ5EEfF+edHSGC8?=
 =?us-ascii?Q?ilpy6iL6AUrPcwddTjw8iUY1k7nToGLB4mwLfalG6Nw1idkCEfbFCT3xdece?=
 =?us-ascii?Q?dz/pkHKsoQi3TBG7h+d1PqthAfKSiehq/ZeHORN+0CAkeA+pmaSUNsHEJxZt?=
 =?us-ascii?Q?hPUY4TB3KpDBICfZEmP19D6WTJRwjCcYCIRfO7Y2FYqUShr/GutdN3bxgpzS?=
 =?us-ascii?Q?afIDereawjCI4hdsuyEYUz05bLYxHezJ3OMYyyz3z+daQzWXVXQxiO3q3myi?=
 =?us-ascii?Q?Id6W7onApJeSSf+bNGNzN1Q7fi5CELt86uNAyVQWpcvvB2OfV2v/FQxwv245?=
 =?us-ascii?Q?bwCuU4A1y0AFsvyvKycOeojKU12K+GHDh99Jb5QtTKjp3yZX0fzHEYV01Oi1?=
 =?us-ascii?Q?5yZP3FpMjkxMY1ToXpahZRLFOaLjRQ3ji6r7Dx3NrvmnXr1RH8gu0/zJdRVN?=
 =?us-ascii?Q?lfwar89sKGSdE/VyuhS5UYVQdNopQ2X4Pv7jRIqlpfkp7qLq8/rvBmjfXuVf?=
 =?us-ascii?Q?PYJORYxmFdUF+LWfpp/rTjpiOAL1yCjBOzcWc2GWPCW/D2mhE/jfT22r3QGG?=
 =?us-ascii?Q?RAjrBAJkZ0tNxcuxE9ohoxrG+Gbg+1blq4TQ+P3sQUzMJvun5k+a5cH04VZB?=
 =?us-ascii?Q?QoKhw1UPOInaDdlEPqIeNnCP6tEKrvlG0cCppi6oUh6rWaflr4IlAS8BvXJm?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?f5XgA9sSS9Qb3D+KpgNkLY2RN5HT7KtYbJ+5uZpK30bEZRSGyR+VCEkR5iak?=
 =?us-ascii?Q?RKDJ1/3x4zRwBvg+04FCySHOZseAV0pSDEvFnIEPNUbVTkl9/hNyh69Dk82u?=
 =?us-ascii?Q?bS0gYIlAAZpUsSIwGDPs79VKgZJZCSx/LufYmAUXR4jIzeA0GyqsCSy95BY8?=
 =?us-ascii?Q?JTfip99Paw5tSKT275z3+YxmssBH+69prViMzHCouBvGuaeDD3u+4ljQ5TtB?=
 =?us-ascii?Q?Y47UNfWty5dEYVs69eiC0SJZ/G+wQKRkPTKUc1LXbN2G2cfTx7EAL83ukKKB?=
 =?us-ascii?Q?YysPHopPXcvWV9XN+zRQuIjYy5jSxcP7SefIm1Bw9c6Qd0+U931sqZqj5qIy?=
 =?us-ascii?Q?X9dBILCAhJVOvxBaIVztAFfDCwipkaszDpN9zWG5e6NH/Uaa4EPhfUKy2Pd9?=
 =?us-ascii?Q?l/dCpAFRtcWdC8oj4XV1XbOJvHZDGhD3sN9j89XEiquyVUacq9Z0oHvgUMnp?=
 =?us-ascii?Q?qZLS2WM21N5ycims6zchMkNFcN1F2reCsRqdYR7Hj9eAQ0ACWxLIUuZacPG0?=
 =?us-ascii?Q?MjMeHqESMSJFNuc313spNuoLTvKAl47JMG/mj7jNc4/fJJX5uM/7EygIkwVj?=
 =?us-ascii?Q?gXaIjxHgnW83mtoOhQqb4rMCe9iFijvkvsVGvvwyNydyUUqzNRFWxMMqQSsR?=
 =?us-ascii?Q?32Q7CveYxxuvoNo1dG9ruj/eYnQ8d6nYTBvC0WGKXkL+xxMOcaI/KUrw4QQn?=
 =?us-ascii?Q?9+H/IPTNLjEK1E1JTBNvFXiwet3/gNGp4hzspj5r7jRuWEakUJHGfxknt0DY?=
 =?us-ascii?Q?6suz/XJXf1PQ2mJMmYkOOBkp/2X8K6K8XUe1HpIx807LleJiBUc4EXDWQbF9?=
 =?us-ascii?Q?tTDHZnCDtnXc2U9t4yWQLlYH12lR8WL2vaWX4zklANPJ6VMrOmqvZXCWv9kG?=
 =?us-ascii?Q?+RDRnPEmX0D5MnM3+rOdDL77QFWd0DSBF6dKyVQkkf+ulvObahXqHM5iLNsx?=
 =?us-ascii?Q?UEMeJcOcvqbW3+AvaLOrS8C+tkcsOg8rpUgpinGGj6i0PrTrXVM4VzEj3rrM?=
 =?us-ascii?Q?k+Ap7qmThUMTEEJ78dCvxt/ySCdDuDZ3Fp6pW9h4h7nfHyb7j+aX5sDUCEWi?=
 =?us-ascii?Q?IxCQ4KncY2gN8GDZM0LyU7S7HWdHKw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a52286-0126-4aed-a2f1-08dbe0cc9963
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 02:35:55.5524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4PTW7EXWf7mALrhVDSQFgC5P4Sxm5HknvQ98JPxVrGmEtb/7NG9i9PlOtlsUogDbF4DdtnnE/KStbKnq7vaIwk4DN4viELfMZeIRocl1lM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_01,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=836 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311090019
X-Proofpoint-GUID: fUox6ZhKXykL4kLLPrlPc2A4kSnTYw6K
X-Proofpoint-ORIG-GUID: fUox6ZhKXykL4kLLPrlPc2A4kSnTYw6K
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The UFSHCI 4.0 specification mandates that there should always be at
> least one empty slot in each queue for distinguishing between full and
> empty states. Enlarge the `hwq->max_entries` to `DeviceQueueDepth +1`
> to allow UFSHCI 4.0 controllers to fully utilize MCQ queue slots.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
