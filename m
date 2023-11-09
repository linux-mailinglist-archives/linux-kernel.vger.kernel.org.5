Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108F97E6271
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjKICwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjKICwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:52:00 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1270D2590;
        Wed,  8 Nov 2023 18:51:58 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A91iEIn020370;
        Thu, 9 Nov 2023 02:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=jBUxgMB9KH5XqCt/F3hkCeb/J4D+a/F0SLFc07B5MAE=;
 b=X8xMRkxdqSANR+Xz53A3sLLS01MtPOYl2Wsm4qy/a4U6x3n8VUTNK88aER/oB3rTgZ3k
 kLgj2l8tp1fBV8XNeC8lLX3NUsKTmaivRmOzlLNviOJ3mOEv5bZJpWUpqkbSQO9wA9YG
 TosghoyQCh4mBjEAbwpm+E9EoHvyth19ftUbqNNE5PqnNIxF3ES53kTyTwBn29Cjyvk2
 ZvifP3XG1Rui4rglaY6o5Q0b0vYVtCDU7YI59VpKFBV1fcIhznIR4Ot1RAyGMNMH+j6O
 /ipvNWTfYPgbvP6D8yfk26PBXwsZ9REZk1qp2bBhZqJTpSFg7XgqVVS8D4bUr11DA+lW IA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w203182-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 02:51:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A92PKlB023778;
        Thu, 9 Nov 2023 02:51:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w2610uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 02:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7QdjDtaKVBEP/C/X/D51GoL6qg6SQCM64C8pp19CHAvJDq5XA9cOEnrKCzGrjwNmNVnq8XLYN7o6YM/6BWV9wd7b8YpaJpto8GUiq3El9ywGQJCkQE9sG/2JxUfwnluarwXVv4rhcB0oqFqQAOFedWEQzvYVnk7M4vMXFwXldkN3/++ToMXYYAIjEKlDUmB47ipiWX4bCj/Ac8WpsuSVvJFLdOvELTHvCHkDfgv4Pb+BbPIPFwjv6yEtaPKnSNQ7tak7isVGPchTT5SGwGH5N66AiMB/0nca/9qQMY6v1p793myprFL92cmDaCjBCjdSIxNjn+KBqVgbMy5bQIgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBUxgMB9KH5XqCt/F3hkCeb/J4D+a/F0SLFc07B5MAE=;
 b=XQs5HmBzB5ct3azG400H5B+DsTJ3DPPoS+Mf+ErwnfGuClyOXRxnRXjfi3NnMPHzAbJFIGAckuGoywZvT3NiAxNvRGIdG82YxQ0Jc369Wgek9XwJY4RlvYUvaQ8Td+SyuprT5YRLneKAx8KoeW2l6toGU+GGlStgsWWpLN6TuVfPz+X+KhtBzMnzHt/3ogbkAV8TnwjbOJVUQnYTrKLSWJzgdmJYHnDDMji36f4mn+C+CIN9zWcv9grJSvv3yJg555quy7xPoNGCCrnm77BBJRPaTQLMk88Ettty1jmlQDTuI9FdLr4yydTu/M60LbkSIZ/u4mzcn14m7Aiugg69Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBUxgMB9KH5XqCt/F3hkCeb/J4D+a/F0SLFc07B5MAE=;
 b=Figi9wC9kvzQyZKvsKHG2SrknYVDbRdl2qMXgDUEqzMAcMFfOTboHkbz8IrVdyzRib8C5DQIfSolfGp5vORNXdxCs4NYuGww4m7+LOnwnPuYvyciuwEhOK3DjycedxCaE+7usa3Xxzn1SSK6P8iYIoYXynrQo9nh3yaK1jDpeGs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB6844.namprd10.prod.outlook.com (2603:10b6:208:434::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 02:51:45 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 02:51:45 +0000
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: ufs: qcom-ufs: document the SM8650 UFS
 Controller
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttpv4p1j.fsf@ca-mkp.ca.oracle.com>
References: <20231030-topic-sm8650-upstream-bindings-ufs-v3-1-a96364463fd5@linaro.org>
Date:   Wed, 08 Nov 2023 21:51:43 -0500
In-Reply-To: <20231030-topic-sm8650-upstream-bindings-ufs-v3-1-a96364463fd5@linaro.org>
        (Neil Armstrong's message of "Mon, 30 Oct 2023 10:43:11 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0068.namprd17.prod.outlook.com
 (2603:10b6:a03:167::45) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: f60f46e2-37d1-4fdc-3b87-08dbe0cecfc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z84r5ip/2sdGrYplrj41RQyiCYMa0oclGZ/VBTyabR15NPxU8tJWKJ9l5T6T/psnUXNANo1zOLMshFM26NkCQRj86YG6SPZAUdFoCde2ITiJCMnDfNfTrneFQF5tVcPmkG76u0vpJjOrEqjpb6MZEv6pRdXKK5bS19qt7TMqLdk1Rh79wfzGnHhyRGw3t06LzQ3lbeS7+v063+eugWDfoSsVCi9EUK7CdE8F6EjXhPq63iwVUCMspLFs5p2G4hYcFSVjALmk4sqysEkR4GDD8jkIJ5KpiFv6F/bXJXLysA4lsRQWm8Yzsdr2OJuXjuq0quFEIDscMkhInCjIuR5FuhnYCLNhpN+uXuusyFY6eIKTzCtvkZewD+1Rzwt0W5W1RPcTOIhG+GOATbDe+VjiCbBoEHZaRJxOu35+efw6hUsJpvS0UMZ1DMDhf+Ag7i6Ym+HcoGaBw2oMAbaa7t211YsJo5jXbic0/cOY+Yry990Jf8ZxvxyurFFoLlnQrn+eYHc1GSzW0gC+Ae2z2jvTj0SM1fbnACsSv2J28Pz8nZJClTB6TSUa7KWcMI16hWTP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(86362001)(36916002)(558084003)(8676002)(478600001)(8936002)(6486002)(4326008)(5660300002)(6512007)(38100700002)(54906003)(66946007)(66476007)(6916009)(66556008)(316002)(7416002)(2906002)(26005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gEzXHh+78RaRRcZ5mpfnn7BfMLxSJi/Ksb4ZKEIJq6N1F+Rrv6nGrVOa5nD7?=
 =?us-ascii?Q?yfDoBIGCOIoCPthWAGyCvc7LXOhbXAsCs4HtIs9yCu/quXSO7zQ8mgAAnJcZ?=
 =?us-ascii?Q?vCpTBHdUH0DVr2YJ5mXrFJJolbZKh+nwwuKLZvYg8Oo1kKU6uLcguLxnYaSy?=
 =?us-ascii?Q?IFlw0z6A/OMZzw0RnADIlclZMLPD4dumE7kDgDTpL+FLgDWK/yAl9vtan4hE?=
 =?us-ascii?Q?m93MwfW4c8RUPYot9l+KJLbvgXta4M5ERtVNFy7rmd5a0iJqHnt0KtNvltbB?=
 =?us-ascii?Q?JDa5buRv0/su+0oykWwBzVqx9hzgftqawrnlL9LWME9eYRSna2O4T/cANFt0?=
 =?us-ascii?Q?SBIwd28ImMpHCpILtgRKLW0XjxMPaNTBhZKKHj010EKDxtmfW6na45B7Iqw4?=
 =?us-ascii?Q?EXiatmklx4fMftzIg6wn1mi257t265k9peMvAHJqEMloW0rnQXB45EIAJytV?=
 =?us-ascii?Q?fmu39mKO93sPoXoVje3LNE9dCslzOvZLxVXzvm9TuiFZ51nPJRSF0JJJZZqv?=
 =?us-ascii?Q?zS4X/DkleB+FK9yQzYMYETuhW8A6naJFlUph+MT5ppXmKfLsIcN2vaBU/crP?=
 =?us-ascii?Q?CDYg77Qynq9NtrUL1d+JFTLfFQHhL+jDtOqr3SX0e8qEy5rE+hIAX2E0MiQ/?=
 =?us-ascii?Q?46h/53oWdxgZ4ZgF1X3/0V6BQWs/3rigY04BZX2r/zi34JCzyETfP98SJdNz?=
 =?us-ascii?Q?mB72PcDmcoK3c9q3RC0yfUKhk/sUo1DHopBBYyNw1p0bXgGf6VQPYCxoHO6Z?=
 =?us-ascii?Q?+qsMne9aMuARocpNr/Ad5MvkBtHM5dcetA8ly7azwnXE4kYIf3JTQ0QZoGMD?=
 =?us-ascii?Q?up1cFdPzyhPtHKgGQ02fMNgYyhokmGk/KXQBzgiR64mmSazg1BQitlLT3DuA?=
 =?us-ascii?Q?vubZeRJKiBfXVoXETJopPVudZ72uDbSnf08v4y+QPJbidDvlnPOPbxVHUbNd?=
 =?us-ascii?Q?F8CpRzgUAfN0IYPMuZmFb6uCYXkxYeKCPqkXP3MinbAesMEspK7V29q5IVkx?=
 =?us-ascii?Q?vumEctJKKaWugmkydfX578qAoVV7ycjb5aNwOLuYGOSAKAGTDpJXsdJzeq29?=
 =?us-ascii?Q?nYgu5IOppGiaDMzAP4o23aPFoDSakRfUsyaFqrp8WBRsOVm5kFS5dcDv7XD7?=
 =?us-ascii?Q?aS1hNaEEgWHI/5D7jlkBdOjGtKD3jZV7JTyTDfo05DFTqSyDVKuLjHf+IDQr?=
 =?us-ascii?Q?aBm6upq3Ld8aYPM5q47EmuwTQkJpaWXgNL7jgNUcTJTzfpKOhAP9fdgE+abc?=
 =?us-ascii?Q?msn86Ue/sps03yNCMFlPs7L2FIBA98HJ/0DWwP4mmQ1zE7u0u3GQkaLRXQBd?=
 =?us-ascii?Q?juCQbMfmjC8vCjWoB+DdyPsV8/+kCTfxTnZQMxhtjkQ7risk5U07ucN+pncz?=
 =?us-ascii?Q?bc6V6N/xxNQ2l27UFQd0rvxmVGs9pGUKHAOnyEbvy7ceZClnC0CkSXkJ4v8/?=
 =?us-ascii?Q?oIaGLDCpOM65E7bwxRrgXPA5lDPJ5Zn9Djja0M/nQyfB4CmLPjoKIjSHWz39?=
 =?us-ascii?Q?DBYBEZIELD7kGDWR9P78eLWPNVz0eotAHrCSUEnbm9Wk7f8FiM/BaRQbjsAM?=
 =?us-ascii?Q?l/qWTY1zihRDlptXtv43qPDL5Ut27m8o3vbFHuUqClBhZJ2uCWoC3axqUQa7?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3KbhIFM+mfEa8ctKi/f6Fk3KdBa4rCP12kXRp8lFJ6bImaqaJZs8x12bNLT8NPnI7dt2KSPM/pHfRPdmaHPy2p0djmbp1SthLa/S3Zg48kP5h2u7cm3tVxXknjTuwKvuk/jbnkN8N8O4iB+NEL+y/Jm2Fzfa0XHZ4zsH5+wci5sMBUXj6zB6VuFa65Fg1/98Q6OYijoWqLLl0ChOHb1CFSM/zW8PUaHLuV29571zhNZf7Q+PCX+D4SzF99Atnf1Bb6SKDzvFXUkXOLx7Xq1LqrwvsILNU5HC43LfqyQsAVvj5zbFgh6o9lX757vvm8U+TyJvrrBJDgX7w1JrVdPj4Mxny7qQoUuZxQRSbcXr0oSPORmCztrUZRopnWCQzFXvlqcOHRTun7h3D29ogRAI8GhMztEVGofGAJKcT1RozevpQaim+PcIcv2g7q8TV7MkUy7VjSbtdO3Rn9x9Pkg9jpSu710nACYTa0XrQgRghbArFdLSBSu/rALuVSzVmT0s0MA1O8+SO0RFoEfN31IpzFT6GX9grVoIxpPNA8jADeSLdU6C5fdqB3QK+hUG4Z4gpFvTfGqY9QBYC/PGWI137Sn3+vSHYNTAJKIaoR8PgF2ilUCpwZnO/KuCG+dG2elPa+FoNrm3bqwDcml+1OW9qeO2d6vzdUeTIzQYKKJtq1WS24WHexynhV8uLMT9nbgUGR+imLyhOPcNTnLOWc0RXOCoWBTX3a/RXJWaoBX6a58CWXwXVQ6WA63ydGCxDV9TJXD6RiD4CuZdRSBXt/3n8gVpIdZgG5lHUkUpaJqsb0pI3rMeh9W6oPE8paE5WA1nk1X1ktJz1KRAAIX8+YyfBdXB9y8vCr92vKQmJ0oZ9RyK2XemBCT8bxcgQ1u/ZlihqdexSgkmy88Gp7F9WwdDlA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60f46e2-37d1-4fdc-3b87-08dbe0cecfc9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 02:51:45.8074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pg5c3PGRS4z1ZWaiiG5n6mnQxsLoAJaEUthKTaAgF8cqzAlvRxVHI06lZpyhTAdm/CnQTH/uFZUCYn5G9xYKvM5whFZOgjLtBm69pdNq9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_01,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=737 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090021
X-Proofpoint-ORIG-GUID: sImqYrGx5GazH255O49LQAG0Rsu1X2O0
X-Proofpoint-GUID: sImqYrGx5GazH255O49LQAG0Rsu1X2O0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Neil,

> Document the UFS Controller on the SM8650 Platform.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
