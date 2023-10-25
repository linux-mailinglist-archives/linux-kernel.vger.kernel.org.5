Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA08B7D730C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjJYSOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjJYSNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:13:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466369D;
        Wed, 25 Oct 2023 11:13:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEwklL004603;
        Wed, 25 Oct 2023 18:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=NfKSBLgh2aUlS5axBmVQ3KFNLenChfQ/vuL6WLGoBo8=;
 b=GTNfk6bSCznJw55Is/lUuIwYlstgTBrZCEN0WbSB/KBEwuaOm7o2D3SD82H7KftKGsep
 BvesiKXmKmeKGcDyi4OhOtZ6Pz/7d83XAnACd65Vyk2rgWbuNZp9fWfvUqPfo+/sPXyz
 iBv3K16h/1OXNRWjNaYHnXiMzyP+aPFCdxNIAD1EKKnZAy2nrIgsTsYAxRk70a57B6nP
 UrBjHDuLUakA1Q0Mjg5VTD0pEO7LYMcxuwHWgroAJlUwfNDd3uaF1Qbhs2QGgXD75Zku
 zJy2HXZIwKrrvYWMVTNdPdPEB65vI6486KoVqRM3ZCEvyJ0jpnUGKb0FMKN3fCgW6QaV Iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e38ebn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 18:13:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PGWdua031184;
        Wed, 25 Oct 2023 18:13:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53dhb3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 18:13:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7pb0p54Oj3iMZ1fuiJ9FwemjdVFuQL8mi8u5/YVIfhryoXdfdxjyBHLPfgPz/4+WxRq/DxwtKiOx0slvtzotT4gbqK7/qw4iR5BpmeduKqHOdEZvbDjMQMKWgmRzfiWD6JJDn6fp2Tn9UTj1bOc4giQ8LL359Vjy+ujuiCZ71WGaQZoBhn1POJEjWMQH6o4OELylrNaZ93qAoKOf2QafLk5ppi20rOLxFwOLBgImFcR+xjNAqKgfhXA8fQs6DB2AioWCcflv/ETTbjghXsissK2wNhXybvTl0NQyxEav79sDeZ/VPnxCGaDPK/oMsS5Uvy6ZR/Wr3oNJW6syFJhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfKSBLgh2aUlS5axBmVQ3KFNLenChfQ/vuL6WLGoBo8=;
 b=ByipeV+M+MLFP6f1lGLT8Ha5yS/NYvFbyrAUzZZINGiNfS6HwizD326buZuO7LNhXobohnYSx898nd+7i8K8mEPIAwvs3PipxZTQW2qaPQK+ixdG78O8iQaP7VXzYSTYUUXyMaA024edUKGERXrsNNLkdvAEmNoVmFUss87IYUodmrZKy98t/UZArN7xC1oOLIekB+u3fFdxTYOY6c8O2z1ijyprt4V871fobhAvuGiGIViWNwKu4H/zqyT+IIWfNWbk4gCTO14+ccAgVZfXaxjuzqIe4gMSWGguoUYacloMGcQsp2/lfThBLGQ3vnZRcfBsM7ZAyl5+yDLvDW9QEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfKSBLgh2aUlS5axBmVQ3KFNLenChfQ/vuL6WLGoBo8=;
 b=nP+eajNdyvDcBTUrnrb47k0pXvntmvTPYS3yDiL3tQD+PLq44UhHDJ/EKTmARsv3duvOe0SolqzJu0JcnLNrbrKH90PU+I5ItHuuAyDWKvZK20NsGCxEZRf18obLVLBsVlgx/8hwYWatOaoUpvrwyWDkGwfoV3n4z9dHzHeinHE=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by BN0PR10MB4838.namprd10.prod.outlook.com (2603:10b6:408:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 18:13:46 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 18:13:46 +0000
Date:   Wed, 25 Oct 2023 14:13:43 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stone.xulei@xfusion.com
Subject: Re: [RFC/REFACT] Refactoring and significantly reducing code
 complexity
Message-ID: <tmo426hobqdoj7ua33kwpjux243476c7rxech4x7lvmky3mdre@oxq2mfqx2n2b>
References: <ZRU/EjubEH/5QLlG@fedora>
 <ZRZk6tC6j1FtW3uY@gauss3.secunet.de>
 <ZSCxxxMKoby6XWsg@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSCxxxMKoby6XWsg@fedora>
X-ClientProxiedBy: BL1PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:208:256::30) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|BN0PR10MB4838:EE_
X-MS-Office365-Filtering-Correlation-Id: 495de6d1-65ba-4add-e454-08dbd5862144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aj/zNGpiYDkBHwCh1BVnx58R8DrB3zb2Xwl8eADI2ALynbQXwYAAuUhdraqpwpDTyav6QZkzEjvrmB/G3+uGqZedP6WXt4UW8v2yuxo6K3NN0SrVnx2jyyPTLvRcNVhimwUZ7JrjtdexZ5ZXfi/S/MNl72jJuxiDrdVYwygsxcuvAhXAfYOZlk4B7WBh4JnMhcFOvVpzSbQJ6QSDRt+LCoj4hzTIfz71qrMOTEV7EAnW9CuVHYN30IsX3EqivEBLO+MQTNlPZbfj0ZYQEvYMBDxtuBe7gJuRFFQ6ZwwRiw8CYqipnAOjE4Bl4huMjQhNxrhTF3Jww+Kc+pyXDgvAmQR+Gf5hbpVPMnYxYvgSs+HIReG2v8YdmjSB9YzlyVKr7hNyMahNrJcDLnxjEROBjD4sr0ZXw5zj04VPFHWkQj5BIZspxQaEYJMz1twOR8v4PAU4w1RS+Fv/mLnzE6xAQHgMKUrFofPtrFyZ/p7yPq9GFgn70g78b7RV2ZwXDJdi23b9jVC+8vVa4/mY6yqtp8rT3jJRNR29AKvwvSKJskgyJgXm9+5uQBfSzG74KoVx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(33716001)(6666004)(5660300002)(8676002)(6506007)(2906002)(6512007)(38100700002)(9686003)(4326008)(26005)(86362001)(8936002)(41300700001)(558084003)(66556008)(6916009)(316002)(66946007)(66476007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p5UawZDAivHxC+ViC12m34XHvUIgx1nAM3F+0hTMAq9gN2Q/6XVu5e3vU1vc?=
 =?us-ascii?Q?jvu7eg7KAf0SqKC9Bk7lHZ7rONW3lE3rwxwNVf2hrww+spLclpeZzIZt/VCZ?=
 =?us-ascii?Q?MgvYJJuzg76GKIyi9ca+bVbJnOXLtUrKOSa2tvg+yq1+3eVcfCHFVjZl+b9L?=
 =?us-ascii?Q?IfXsMOhxYRU+MqkNhRQUjzI9OmxQWkyyjNRiSxkDF+VKGcGb0Pwa0QTf78Us?=
 =?us-ascii?Q?Cf0ZNg+tRTxLTtrOo8lbQXa4vZQkUnJLcRBYaAQnum+/mGSFTToi7luZBLFd?=
 =?us-ascii?Q?iB9WdLN0Ptb194uI6Qimonji0p5ChGJv5EvAlJG1CDx8ST1hPvJEYPGUCbQO?=
 =?us-ascii?Q?k+LZM/hPlHbl5ylDlz8WiGIAy04X1DJs2Q4OG7XXHXbl7gIU2mJlBd+sCwnX?=
 =?us-ascii?Q?GeHOTeiFEUYACLYPJY0I2GiRK2SBz7vxtp4ZsWAo2QA52SoFe0ovM+PHsA7K?=
 =?us-ascii?Q?3MMbM2F0VCz5V+iWr6cvNFFOynXWMIZXtZNr83A4sNWBASpIacSHLD33hwtf?=
 =?us-ascii?Q?14XkKcF5/sCFG0mkkhDQELh5q36PV2qPatjk1Dn8ttyFNDK5Af4MHd8l2adv?=
 =?us-ascii?Q?w1Xcg6OSilj2/PiMHbAzVlMkOe160DXZPCOOLo3SVDOWAM0+SpS6J7+6aumR?=
 =?us-ascii?Q?+ml+iXZIvOyIcjI0T2STdnHB0/ylOe4Tc2YBnvEVZKtdHqw2YHCkP8rbXhyT?=
 =?us-ascii?Q?ad/ld21DXop1BPLKM4wE4sPgpV18Gh0Gih23BrX4ARk80ju5ZYHAeICVWoph?=
 =?us-ascii?Q?wC5rB9FBxM8ZnnAskiH8GmZ8Yp7OTkEdDfc57Hfg11Foh15W28ePN+hhjtQ2?=
 =?us-ascii?Q?Q/OpLGlClRW45ewfElEEibVmAXL9Q7gsRyyI/QxBlrSX7N+dun74rpW4NDZH?=
 =?us-ascii?Q?GOUo1GlcU6GlYXnI4B9n5lhu1kTkFMTrN52JnMBo6Kua+Wa+1/JAq6wqwhXv?=
 =?us-ascii?Q?wVo1baT0EA4l0Cj9awoHY2oIQvLlGxNB4NaQl1ySKsPVGpzfbW4mtd7OMBH2?=
 =?us-ascii?Q?2Gz28ucUxYIDrfyM/RzmgTy0tnRZeT06VS2LVLoRpxURBeakg3gbAmUXfNOz?=
 =?us-ascii?Q?RG8I0Tg0ZAjNDdNmgDHjA0ob423vTwpaeT2Ttxr/uyx8ZRKedJ26293BHtRr?=
 =?us-ascii?Q?/4K60DmYDf5kWXtv3WNh5d6kqzoqgqj+K76YNQL2JGUN9FPFNOG7zUq9np7H?=
 =?us-ascii?Q?JS3RUSLjmsyOxEUWJnciinLPsy3YrJS9c2FTfjuLkz8iDDbSbMkVsK1+XZgp?=
 =?us-ascii?Q?PX6yR+taeyu4/52wSuvXroxxaOVpC7kXlLeELgLV3L6+WvFUwa8pJdi0c7VE?=
 =?us-ascii?Q?XGgOHoKRzpeynRYLdg2WGcNgeNxyJE9miuPtG45GlkVRIXzXNu8joKVfU0GM?=
 =?us-ascii?Q?ZLycrOhugZ2lLtO3A0sY9tCNrEuP8Tzc4RMainOV+smOF0oV6AMB13v4ely9?=
 =?us-ascii?Q?DTTLL5dNrjg8cjMdLEGSJ1UgFHm5d9XmwDI2zGO2uaV7SrSq071FtZpgNWDt?=
 =?us-ascii?Q?+Age5QK0oz44V9aWG3HR/OQXqKUyjhI9Goa7rQxKkeEqYlSJSb4xKyUOcgO9?=
 =?us-ascii?Q?jIazVJY8gNBJRNtFcKIDVtUBaGQN5jM8ZUP74E0zkDH3bkfd5y/I0xtS/Zgt?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OyayxedllnOXQXmvDSE5sHdtm9pmspSNNUMzab3JYdbCijcCZkC3mv7/EGEDZYTrBAfvWO7+nyriJbp5bYqh8lZknaU+/oBHpEzHihm8QAZ26QsYreYb+jtbMMmsaUaCbn4y2KuEKeliuaYPZl/dr93CcDTSr80Zk9HvrSQ2/PaBsMQT6xYjMMNUDYhz1U3lVucNPRnppkomwci+99DVFyPJL5hXonHk2nmNcGA4kqaipBKQ6O8RBD4g9Q3vldL1N9OuSokKqQ8l6j+SSthe1dYed8phpoXNSta2aAhdKSxX7RN8MWMVHuhbnwv4AEUb4I+TMGcI+d/Qoxfg3mvccFVIRytnSZLI4OFfsCi6VV59Wi6goiKtaKwXJ4ZzUv1BDwNQkpcxwpfBKmWiHlfYzxV54PpCbvpnnTak1LhEINYBGaAMZBj+hBsHZCfqmFxyKZPI2EzqSRTt7pQr24ijOF7f9Q+Q3it5yeEyqxWUMGzXh+BrJ8WBneXlzTDd5nXfb+zvww334H9NpF+PuFnTairHzpHXdll22NgfXv4aURr36UDNplwWR4ji/1+MtNSqsFXyr0N5Ru7368GOnEalC92l5G8h+8c/ZiEHToX++yci6Sg3K8xtoGkHs86POZUlfk5JTyRrmNnSzn6LDDCrmu4P+mSvj9ucCzrmfNdWOqxSsAYzGgJYAeEd/y15swevxSTP0me+9o/veH+gaPUaS1oBKkhaFlCyQzVF8dUgTf6x6FoBbfOyEoWjB3SwZPA9ZUBghwUgsFXkJW+zy9Oh5wDwJltXmeJPk2ux7HMqk56Jj5eU8fsTvke2BFDaEuBITtkeQsZE4/5goC8Yo2QIUg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495de6d1-65ba-4add-e454-08dbd5862144
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:13:46.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ys44OloCTKAypUAVI8p1DUJR0UWL5DLsHAidNPGDJSzDnKEdoZwxll2g0Mowp6idgIFVPtf3IfLhzoUr7wv1c0xYH94UUfHSPJgEY1xA+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_07,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=472 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250158
X-Proofpoint-GUID: klWUa7HU6XhtvolcBESzwjSnRpM1uEkU
X-Proofpoint-ORIG-GUID: klWUa7HU6XhtvolcBESzwjSnRpM1uEkU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 09:17:59AM +0800, Wang Jinchao wrote:
> This is just a design idea, because I am not familiar with IPsec, I haven't 
> tested it in a real network environment yet. 

Out of curiosity, what's your use case for padata?
