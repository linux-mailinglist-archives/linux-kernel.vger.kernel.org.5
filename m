Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E0678CB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbjH2RjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbjH2Rix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:38:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA6211B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:38:50 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TCCUUB021784;
        Tue, 29 Aug 2023 17:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=P/CthGKSeIR/qzqwW//hBdiKcEWSbYv9kQyJyAH/lsg=;
 b=15MW8CLHGygw9VLGYfK+jXnt2c1Eubfnu8DCzzhJRB6/hc5VphNlAprpyBOXey0zg4j6
 hc7rqBndX4EEb8i7pnnSSm9E4SugjfkZUcAdVnHqP2kTCgohliKuaogLOZXELlSTVPJm
 5A5TexmskTMqVwUya2V3X/fjBa1f0YL70TPSsDoRjrIGHmRoXu6WXdiYIaom3RuKroiB
 QQVF7nRXHd5HnVzH1g5vdaYdNMpgo0hE8szvCy+P1hOGF1p55DhAlC3SUbIyWlAx0uSF
 m4DsumxCAYk5Mwk/DyWLGRJOgMY86ywoeXBo0r/Arzkj5QdfrRH6GfGj1kKH29VJqpVf gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9j4dn79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 17:38:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37THBK0n001154;
        Tue, 29 Aug 2023 17:38:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ssepwt30v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 17:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYvbkFlaSL8GwtC4lByhrhC84SHw+CoDWd2zbBI8hU0BrjRwp3BfitKGN/Iovrz9d12XFB82F5ogo9IAae9Rw4qh6EsBZsfytgMXXUptSRpdpihbn9o/yhVPNCQWxYzQwNXRBM/bUWr/FkP9mVvtuAo6xJ9RImKLR2UEq47gFB7qBcfR/4agyp3xFK/hMFP5kWx5tVeQTwUQ8OftM+m+AttJER3/bzIbq6Jfn5fx3AlR3r5TXkjqRHnW0uLByWUBXPFly97KCbJ74Cjr4kBn29dXMaB38xfe19myE3GdWoHJiRnhAOFnGyxHFVm090/OEl3liUIQha2Fgkw1iEh4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/CthGKSeIR/qzqwW//hBdiKcEWSbYv9kQyJyAH/lsg=;
 b=JnbswcFnn2yExWwNY37sNc6UXF6AISgSgo0G0iFExnMcwojgU1bIcrpCSvIQY3FGYfv3QLaJDU/HOiZfaVC9kjf08eFKtWRfqC+jgbxZpyx5Q0QCUC2jkxiGAlB7LLt7tVRLIZ3awtUQcTn/ZN64EkR87cZNtFADX/M0TGXEQmqgC1HnjYy1FmvqAjCYArXdLq2SpYwOxwWNRvLiDE5Y5uk5g+DiG7BjoMecct9asDB1F1BxLeMIGZuxTBqKQZMmEuVB5RIM1wp2VDYrX/7VEfcXCFpO7Het657d7RHTaPHoxh+cGeFT34f8FmiYIZ/KUpAkk89+ZYmBULwycpxM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/CthGKSeIR/qzqwW//hBdiKcEWSbYv9kQyJyAH/lsg=;
 b=Z7n1KnZJlzuXXkpqPD3VSQsjVd4mexqCKH60jmUBl1pUeTCOdW6lSdiIGt2DTwO/mtGs0sZTzN1UUr9WM2WTM+REGI6Jay/t3fFwFNyBow8ZhGSD7RGFFpV4i9KQcduEu/vZENv9wvZCOZ/e28m7uT0vIcF1iz4I3A8Ydo4vlbE=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CY8PR10MB6588.namprd10.prod.outlook.com (2603:10b6:930:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 17:38:31 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 17:38:31 +0000
Message-ID: <36683767-ad6c-477b-8b46-f10be2ad55d2@oracle.com>
Date:   Tue, 29 Aug 2023 12:38:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] FS:JFS:UBSAN:array-index-out-of-bounds in xtInsert
Content-Language: en-US
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+55a7541cfd25df68109e@syzkaller.appspotmail.com,
        Mushahid Hussain <mushi.shar@gmail.com>
References: <20230821182024.14522-1-osmtendev@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230821182024.14522-1-osmtendev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::8) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CY8PR10MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: a25186c7-43f9-451a-6a36-08dba8b6c2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdZhUaitXRl6Z418wnqcnTCr9J91VINk5H9G9/Vh9HU1Xa9LWWmfncLjMDwKIUHoLglPA+fQNZvO93MfLMF3EbnC0Vmmoa3zAYdZsQ5caLcZypO7k0Ud86FMnlX6AFpaYEfwlwMUbRJ9nbwRUVuOdJGiRwNYfadklpZ2WMqxaPk1HRYuOmPESbuglAp1HfvdzDT5S6S/wrhl1TYD3jCr8vbYGdRyOxWgEw3s3VGXhCq6uijbjPB9Q0N0UVw0nBEHnxJXqwt17pxHD1ZccnOuFnRSmt6873tbE6IMGQNhsolMBlyAWV6EDgFTE2OfDkUvEQTlM9kc6zAclPhr0HaqI6GKPmYhuz9NWGoRDsof8/whzJVEwmtiPE+uBf19kyO6vBB17/xUoes3LPP1vtEh/Ny4RhLw2p0IsQCTJWEmvDZ3BhR0pOjdE8L+DGyDdwYJiYi2It8L63J7dmX+NRBhh38Xs7cipVOA0o4xWSRlmUBkrBjpz9WsF874PJ3/aXbI/emAm1s6NN0CaLjs8YUwnJsycg6xbrXnqumkkXm61e3+Jh/zvg68nnN7RbLeXlJXfh22O1aYftbh8QbXCReNWJjoWwi37Suzrvds2rkXm4pZAtlbmkzO+l0+H6CfVuL81s9Hz32pm/Y5k8QK2P/PkjuWMNR3CoPiyqmTTMWelaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(66946007)(31686004)(478600001)(6506007)(66476007)(66556008)(6486002)(966005)(6916009)(316002)(38100700002)(41300700001)(6512007)(26005)(36756003)(8676002)(44832011)(5660300002)(31696002)(83380400001)(2906002)(86362001)(2616005)(4326008)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjRqVElwQ1JFZ2IrMW5aRldjMHR3R1MvTlg3N2k2SFpjbkFEWllPQ0xLb3l0?=
 =?utf-8?B?eXhWbUo0dWoxLzVrUEtNQlFPbzBZcGdZc3FoR0hPZzZjcnk4dGpDbEwwZHpD?=
 =?utf-8?B?TEJvSHRsTmRvYTNJYU9zaHhBQmQvbEdnNmo3QmxjOUJjMU5CSmg1dXRibkh5?=
 =?utf-8?B?ZklTTnFLZjkwS0s1VFhxcXBoNEMycFpBM3NDejVML3k5MXhtVFc2L0g0cEYv?=
 =?utf-8?B?dUJzbWxRNTUvQTdCKzROUHQraEJxbEwzcXVIam5sL3p2THBHenp3UXUyb1do?=
 =?utf-8?B?anNRcjZ1bW1FKzBianZMRnBrY1c2K3o1S1B1aDlDTjRuZ25yc3RlbTBDUldE?=
 =?utf-8?B?S2wrSGxMMDZvVEs3RUQ0bDAvQ1libnFSQmFuckV3WE1BMHJtMWZzeWsyTnNO?=
 =?utf-8?B?QytEQkxTVUE5cjhaT0tIOHhlRDBwaXMzMW93WURlZCtMb1lTdjJuYVV6SlRy?=
 =?utf-8?B?MW0wUi9IdzBqVHpvbUFWWVZScm1pbFlqdnkvZjM5UXBDUFU0VUpHY2tjRnpk?=
 =?utf-8?B?MEZPUEZrVEpvK3BaQktmV095ajlCZkFBV2g0c3RQSnJXeXRGZmNaMU9ONzRK?=
 =?utf-8?B?alFQRmQ5QWg3c3Q4U1hMNVZTM2c1L2FoM3BxVFpkenAwOU5XelpmbmZ1ZUhO?=
 =?utf-8?B?cGI3ejhONERhekJraWMrejNrcnI4K0l6aUlpWU5EQVNib1d2SERaUXMwalhG?=
 =?utf-8?B?SmVtMDRoU2lFVkVSTGhtdWdVSmN3dkFCS3hNd21zUUJyWmgxUitBNFNSeGxI?=
 =?utf-8?B?Z1ZkQnJmdHhrUENYaXVRYWMrQk9za3VUdWgyMFdtaWZ4SndET3dmNHgvd25G?=
 =?utf-8?B?ZjV2bVhjaFZaM3I5S0s0SitrVngyVkI3QzRFZWlqMURobUpySURLUmt0Wnh4?=
 =?utf-8?B?aVVOYkZGaGpFVlJMR1llSGVsdXFMbEF2Z21sVndPNHdDNDlBZmt0MXEvOGlv?=
 =?utf-8?B?QWFBeGgrU1JhWTBIVGc5dDl3VnFGYjN4RXV2Q3ZMb1MxV1ZOWitBZlRMb2xX?=
 =?utf-8?B?L1d2WFZmR1EydWl1dVBvb2NEbU0wUUlyT2IxQ1hrMXEvcEpFRU81dkh2M0Ri?=
 =?utf-8?B?QWhidkVpVFdPRFpkdkZhOFpCZXphcm1QYnpHK0JPcSt1WkFkM0o0aGdBMjh0?=
 =?utf-8?B?MXlaK2loS0U2UVBVVityTDFVSE15U0pzOEZCUzdnWFAySG11UU0wS3F3ZlY3?=
 =?utf-8?B?RE5vSGpzbkErbW10NWRhWExyL0FhWkdOSHNYTHZPcU1VYW1oaE1Qc1J6NE1M?=
 =?utf-8?B?bUZSdno5OGswSk5FbnQxQ0NoejRjM2lIck9JSHc1emFqTGZOOXp6ZzF2WE04?=
 =?utf-8?B?TGZJRFFHcmM0YzFLaWNIMXQ2U2ZkS0pab1kyL25mUElTempQZ1ZFRk9xWDV5?=
 =?utf-8?B?VFFBSmpyTmRpb3hEUGRZUWdKbUY5akJhSVo4T2ZtZEd4aXdjZFNOeDBVTUlx?=
 =?utf-8?B?VkZxUVdDMUxHeVNEVlM1N0RnN254R0Q0NzRucmFwSUU3M1lScDlTQjZpd1lX?=
 =?utf-8?B?R1lXTFJsbUFoRGplMWtyRDJJVStsMjFLcE1IWXF5NVNrUUJ3NS9uNDBSTDBt?=
 =?utf-8?B?U1ZVZXN5d2hReDZaSXpZV1NpSnBRQVpRbkpEMmNiaWZ4ZDVleFgwK2NUZkw2?=
 =?utf-8?B?WUxPR2JuTTdIeC8zVkFxY28raXFpSEgyUVVmRnlsSGRlaW8vYVdORkxKKzFI?=
 =?utf-8?B?cXB6VkZ6a0JhNUtXNjhHVFp5MXlpYnZtMGMzcXgxR2Yya3p0K1ZRQjlTYmxp?=
 =?utf-8?B?dDFpcDJmQnJBMG1iQjZWdXoxM1MrUGJYeWRyd1BLRnE1R1pKSTJGZ1V6RDc3?=
 =?utf-8?B?Z0lFdWNsWC9vMVJyWk03b1RWMC95RXlpTjJMRGo4UzlGU1VnOTF4d29GSVdw?=
 =?utf-8?B?ZUprQ0pkc0RFWG51V3h6Y0w3RmlXWS9uS2gvQjV6M09GYUUwV0xWUlRIRVlH?=
 =?utf-8?B?QkwvS3MxeGliakFteVQveUp0OVNvaWJETTJDdzhXcG9CbVBSOUpHeGorRVZw?=
 =?utf-8?B?ekoySDF6cld4MHFXRFFUdkwyeitjY2VJSk9YSS9OU2RUeDltUDF3YitWc09M?=
 =?utf-8?B?K3VBcUtwd1RRVlZaakZOdU5hT0JydVhnSDY3OHR6WEIyUk1XVkdCWFFXdkxa?=
 =?utf-8?B?WGl6RlZRWlZPMFR0aDk2eXZETGhld1ZXaXB2Yy9keEVrUzMwZ2FlR2d0YmZn?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g/JZzsUXjgIaZvcSOmTm2UaXRk9BtbDEq6C11gzYvZojk2w2k2meh1OP7YDdWdUC9bfCCoy49g4qdLkTD0Qw46ChHGBaEwMjhwMvYeyEkA3VG+7k326Q8FFgTwtd55WXk+zm58sOMWRYhj5tE2VcUmje2aTzIQvgZXhZ2vJnz1uiv0fUG2xCSDlDm69n4934WFCaKPyL1XY5kDUEIz/bpLIN2wsNnFyoSjmwWsJQKvBle2CyDYBUeqKYCjeaI0CGTYOlxbhLZMOH2w6yS7IIopXj7NhVbqVFyKWb7GwY3UaZr4fTnR6nq2TRGQc6zbhbx0HGBQmU7fsYa4Q0d+0c9arUS03gafIbJxo8Sa5Sp7Q5NJuQENmCVUJA46fDfpyaNMT2im6BtgI2EbYInpFvLuTYcejbRTwKneA4lgaMT7pH1+UNkt4YBazivOAgj6ige69oxN74uhoHZar0UkgOGv/fkd6j1CoM6LbwY/v8waQsEFTJ5qgxbiO0bl48z99qf4fhbBjVBBp2E2Ac4cssBMSUAyzS2JtZfDgs1kO5jb8XNiuf+VNJXFcd0Q0TEAl7Y9dPKz9IOFD14VTr7eGb40zlYhV+bcgVAWVaPs7KRudBILklW2pKWamYk0QO4zlwE2GN3UCSj1dGjcfc9KLWi/q6EUoTRvWnvTpGcihNX6c8MospsPrQvjiGpYzp2vhmXMomyD+4L0qzq9eGv6WhRbjdxdTSzdXCMQtnel7DY2zsKvojADbE2xTpsl6skvaQsmlslz76ZaSoY0zXonr9XTLTVGLuArT7QQXRXvSELXsj0itnTXn0Re84h9ZzGNzRAe916r6Bpjm8b1hJ7idnMAGxtCRlOUZNnxRtzdqioztW4nVQVkqmX/aG0aDSnnh6sTPqnouJxDx7dEZxenpISFXDEL5EFXfuIcAcpvT8HVA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25186c7-43f9-451a-6a36-08dba8b6c2eb
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:38:31.2600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrRNbAB0AHe2x++mpKMmefzn91hV59PwEU1jMugi3VDXVRCPn7KKWmvL0gwV2NdaRRx2mUoOgbI3GAbS0KX2SiS6ZALLcfxy+jGIv+zpd4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=963 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290153
X-Proofpoint-GUID: 8yOtu5loztXS0KgrvDYUVBrCtpvuJMSS
X-Proofpoint-ORIG-GUID: 8yOtu5loztXS0KgrvDYUVBrCtpvuJMSS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 1:20PM, Osama Muhammad wrote:
> Syzkaller reported the following issue:
> 
> UBSAN: array-index-out-of-bounds in fs/jfs/jfs_xtree.c:622:9
> index 19 is out of range for type 'xad_t [18]'
> CPU: 1 PID: 3614 Comm: syz-executor388 Not tainted 6.0.0-rc6-syzkaller-00321-g105a36f3694e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
>   ubsan_epilogue lib/ubsan.c:151 [inline]
>   __ubsan_handle_out_of_bounds+0x107/0x150 lib/ubsan.c:283
>   xtInsert+0xfbe/0x1020 fs/jfs/jfs_xtree.c:622
>   extAlloc+0xaa4/0x1030 fs/jfs/jfs_extent.c:145
>   jfs_get_block+0x410/0xe30 fs/jfs/inode.c:248
>   __block_write_begin_int+0x6f6/0x1d70 fs/buffer.c:2006
>   __block_write_begin fs/buffer.c:2056 [inline]
>   block_write_begin+0x93/0x1e0 fs/buffer.c:2117
>   jfs_write_begin+0x2d/0x60 fs/jfs/inode.c:304
>   generic_perform_write+0x314/0x610 mm/filemap.c:3738
>   __generic_file_write_iter+0x176/0x400 mm/filemap.c:3866
>   generic_file_write_iter+0xab/0x310 mm/filemap.c:3898
>   do_iter_write+0x6f0/0xc50 fs/read_write.c:855
>   vfs_writev fs/read_write.c:928 [inline]
>   do_writev+0x27a/0x470 fs/read_write.c:971
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f0e179f7fb9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffed4fe4448 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f0e179f7fb9
> RDX: 0000000000000001 RSI: 0000000020000000 RDI: 0000000000000003
> RBP: 00007f0e179b7780 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000f8008000
> R13: 0000000000000000 R14: 00080000000000f4 R15: 0000000000000000
>   </TASK>
> 
> The issue is caused when the value of index becomes greater than the
> max size of array. Introducing check before accessing solves the issue.
> 
> The patch is tested via syzbot.
> 
> Reported-by: syzbot+55a7541cfd25df68109e@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=55a7541cfd25df68109e
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> Signed-off-by: Mushahid Hussain <mushi.shar@gmail.com>
> ---
>   fs/jfs/jfs_xtree.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
> index 2d304cee8..034a1613f 100644
> --- a/fs/jfs/jfs_xtree.c
> +++ b/fs/jfs/jfs_xtree.c
> @@ -619,6 +619,10 @@ int xtInsert(tid_t tid,		/* transaction id */
>   			(nextindex - index) * sizeof(xad_t));
>   
>   	/* insert the new entry: mark the entry NEW */
> +	if (index >= XTROOTMAXSLOT) {

This isn't quite right. XTROOTMAXSLOT only pertains to the root of the 
xtree, but we may be working on another xtree page. The problem is the 
definition of the xad array in xtpage_t. I need to fix it so that the 
definition works for both root and leaf tree elements.

> +		rc = -EINVAL;
> +		goto out;
> +	}
>   	xad = &p->xad[index];
>   	XT_PUTENTRY(xad, xflag, xoff, xlen, xaddr);
>   
