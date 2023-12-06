Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9368064C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376570AbjLFBrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjLFBrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:47:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6487CD42;
        Tue,  5 Dec 2023 17:47:00 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B61Xq7f019839;
        Wed, 6 Dec 2023 01:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=5SZ19K+erc8Vm5YW6uzgy/3AmfLOjJ3QyG1fXAjmgOo=;
 b=EAUqC5TtxPe5pwP6EKDMoLGDT9B8keZknkMbvwImnxO/V0p9CQ7dfTAZicFjC1RpfzLF
 cba2tBOk1MuTue/EGIkHotg1FQx3hJWFYzYYX09rGlabz6QayAL5bfSiO6g9EcS+Ean+
 Ijn9E3tTtR61gol3SCvjn0x3tW4ZCl8hwH1Kz44OWzOil1eaT0cz47kbbNW2Z/GM6zRH
 sN/eHqGvSt1e3slkLytgyFxJl0ZjsqD7TxC5i2ZaLYQGVsNi/mKLzFcnf8YG2S6odKUJ
 IIP9/obGGFYHksaQCl+lf09bx7s+Z2MuOjiYZaXum51jG59O3/ehM89y3UrZqpY0nI7M jQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd1g85mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 01:46:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B601mxa039472;
        Wed, 6 Dec 2023 01:46:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan53rr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 01:46:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBDPwfQ7w52IX5ZjZ03dYeY0Bh38c/nCBtWOU3BUlwhcy7NTGhkRPwS8ZDtg4N50AkpdncZ2oOyh8ibI+X1GED4BZiEGSoW71QynD18NvHNZocQ132oNXv7kn4N8JhCDtAyJ+rA09hfQb03ihUI4OnbTtExRLTSfINz/l8gWPRGTvkuGHNTMEiW3yGj8OtCGrR+Ij0O3cjBdSr9JAUn97BuSn/mfKBxSs6Rlac1eGKvA8w2tTrxhLh37jSjdU6L8hSO/HhBzb7PnjkTx7HgZozV+QkHKt9GlaggqXOcJWW0vN4ANFC/vcgoAqi0gsLJSa1z9Y+Bz7ZfgSXfp2e6fcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SZ19K+erc8Vm5YW6uzgy/3AmfLOjJ3QyG1fXAjmgOo=;
 b=P7hDKICqYLaC6h9gETiqX1Pp5OjbcvWlYTGYEji6wHm/SiZRgApT3mEAOdtOeCQKMLiPpA5V03aYzSRValI6qGyvoHOBatAOTfF9OSlnv0K2fRQLOP3ggclHEQiGaUuZuQg3NlRNx0hXNMSUxhWgyNpXNBDBkP7pGleK+3cy+5z9PmIgfmNiclmu0i9kl807MG8y7ijigbLEHHCsxAoQzNGVj4NBbXbATtyU8Vcalc4Asrld/lcjCiD2/mf3qVPj5BYyxWd1yLwv4UpHuicJt8OTC6Rjl9tBFs7UYX22skYXhQU2F6yiYj2mtgU1wfYdTxhjkgXAlYDgGBPQ5XELvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SZ19K+erc8Vm5YW6uzgy/3AmfLOjJ3QyG1fXAjmgOo=;
 b=XnTmYn56OMwtrP/sToA84PZ3/5z31ReN/LZ4U7IxpCGOUh9kXBnwjK0Lypqv4P1XnQD44Te+u1A9yniVVKAlDpVz4b5l+KU8Vvzj975rRQcsORbAB02FT1Ed+Y/0WrSxGzyz1LMJ0FAtRohMibO4aLDZwgySgOcyiD7BtobQhhw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 01:46:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 01:46:30 +0000
To:     Ziqi Chen <quic_ziqichen@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v4] dt-bindings: ufs: Add msi-parent for UFS MCQ
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1il5cp0gj.fsf@ca-mkp.ca.oracle.com>
References: <1701144469-1018-1-git-send-email-quic_ziqichen@quicinc.com>
Date:   Tue, 05 Dec 2023 20:46:28 -0500
In-Reply-To: <1701144469-1018-1-git-send-email-quic_ziqichen@quicinc.com>
        (Ziqi Chen's message of "Tue, 28 Nov 2023 12:07:47 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:332::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 7291f0d2-169a-4687-922e-08dbf5fd2b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5hXFXwghCXBvXLTukBF4avT5NrncoAXtzyYjcczWTiOvNvd7QiQ1V2TPP3AsQaioWCJpateaCWeMc9TzC9uIy41SPat4Ns8yxENzZRA8KJ1c8HOL64GYBIVNWviNgqLXfTtufNvZRm7X5AUk/xOnlx1Z1gxeoZJk0wfPppOhSb3i3htTVxaQ95qf/JPEC0xqtC5j2TK5jpGG64IRdp8bDG+DljHl5P+6ZjiBE9iqGfyzC5lcZimmvYz8V9E91JGKH1X0T5L5PEfEzygHXWUNxNslNEPjA1PkcMuUX3W3bJLE+xfvC3dcIt1JPSvDFUYk39FE/Ld77ZE/8hJuBXXqfoMNaCtx+TfMHA4OoG/tb6QRksGmHObjtQ2bIbpBmUFtvTn4bFfjFwuyBdHl38wrcQCsdWZcp0eM+LaJohzMTMEks96HPp7EG5Zo+p6+M8+sKKuAl50PHmVkX0ZB7VP9M88U/kIqS6m/8xEvBvxMrcZ31ANm5ciyttfXkqmkT7Amof/2chEtt/zb44oSdirQ8MJoG0Jh/rHD2QaXJVTZ9SxHSH1J6EiIg0QQAb1oj9I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(41300700001)(83380400001)(2906002)(6512007)(26005)(4744005)(7416002)(36916002)(6506007)(478600001)(6486002)(5660300002)(86362001)(316002)(66946007)(54906003)(66476007)(6916009)(66556008)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9hR7jyCWYaF34Ctv20yHmLDUdxVJS7Qor4msGPttcSrcOIP7JSKz+vy0vJUQ?=
 =?us-ascii?Q?c6ra2bC8sARwrDLdPog9eVlwR/wNYin7Wt4yIDokpjGAyTuQ8DKLNd98qRoN?=
 =?us-ascii?Q?jpT04ydMLhttq/ue3sP88E06n8MVix75MTe5KAUsLXbheBQRdGYrpSfQ13py?=
 =?us-ascii?Q?1RulfY/b5ywpVaj+To+99CxzURkQ7F3++n12nDFOx7xnZK/JFjUxchQEIejR?=
 =?us-ascii?Q?IjV8/HJA5p01eJgiiSQunU9zYu5ehNyFR/MG9qe7dxijbVj8VX2BVg6EEu3u?=
 =?us-ascii?Q?yadGgzY2bIrJ5B7hqN5HxPf7RBo7qXYacPoH4xFyrM+2DNjC7Wnq/RpG20Nv?=
 =?us-ascii?Q?GxDhBob/0eWP9LSey6DfyAo8YrA6oKNaGmGLiDlVDRy3O21ixxTCYA7AL2Ij?=
 =?us-ascii?Q?HJwgav82C25LqJHn1vZ3zAYrrn9KOTL/05Z3W04SNEVTKvtelfA2x0ysCEr5?=
 =?us-ascii?Q?ZfS0O3GpROIMDCi5sDrbESsZBs/2RDYksrCvEnP8TGe4268XIgNk3uhEWiIu?=
 =?us-ascii?Q?WY9RULep8Mx9RqQRXrACoGvo+dWlmEVnv2QDBu7XydK4+jXBGBegnhvMAkkT?=
 =?us-ascii?Q?GT9EMpSTYghv/30Gzs6zQrYB+ZVvxav61dmOit2dCsd2EZAQ0WpIESwXDx99?=
 =?us-ascii?Q?JStJ7vLI4Fs2sqXAF3fco5/f60U3IamIvKzj6IS5rnZ5dAqk9mJV+f9dVE6V?=
 =?us-ascii?Q?tepVUrHQU3ydckuXiOOO7Dl+Z7rsWSY9hGLfAPTim9p0JXqc6eiGtmwyhHEB?=
 =?us-ascii?Q?gCOpMA4sa/yHF/HsXKoKHj+rdE5J2vGhqCuyRWtJma+R8cfjjXVs7qM7y90e?=
 =?us-ascii?Q?uh3Dc5lEh0Hudh1YhZSsxSQLklufAPKqqZVChqQ7THCQ9sibPFMD77h4kQvA?=
 =?us-ascii?Q?OGw759ee2bZhuvTehhxxbd+IngkiMaCKcVvfZfH5tC2i4HAAGJgHRSM3g5cX?=
 =?us-ascii?Q?VLm4DztOHLD5M4pSTMXKqH5DFz5botw3Cqtirl6L8052oXfHErvbVKqIjo7t?=
 =?us-ascii?Q?USJcljXxjFpUW2Yapd0l6E2yfNsyFpc5rUU2ppsUzUAO0pLwoiw4mT7bXyEB?=
 =?us-ascii?Q?04ygr6i7wmg5rqYAdsYip0/j1961Q/NBp2ePbjEq7+Lo4ZrRh4GUZWqOxzTY?=
 =?us-ascii?Q?BbQu+pfMGVZ5mMEdcpYN8gHXwNwWSsqoptK/pxVq3HaScsl6oTkFwwDKfkIE?=
 =?us-ascii?Q?tnwXLtqwl1StFuwJkazfIPS+zNc93EdfsXNeGM/rqWRQmLl9BJnkTVkFH11o?=
 =?us-ascii?Q?DsVEyuyxCULhJtO0OBYTb1ubyhZK7TWUZKrPt+WAs6HjDYTN9Bv+EBsVrWO+?=
 =?us-ascii?Q?P0oTfFnl8fFnFDIRqDtHeqB/EN9IzSKkItPPD7L/Zkng0YHNlRanFtgXd5X2?=
 =?us-ascii?Q?qDxC10DM5HU2VsAy51FEZLQwAVVr+QDX2SUruPRJ9MbazTQxhEQtSWfR9i2/?=
 =?us-ascii?Q?LhkutoRuUN/pffRCRlKReljt9/l4RecAXH/M8vmfwSanubJAKZYDVa5gYPuj?=
 =?us-ascii?Q?YBsOrXRgfZoe29Xt8ZwLijdi3BhmXohBjFDEwWfAnznt7uJWZhU7B2NyNl/d?=
 =?us-ascii?Q?2JCz8KgP7dn01re63rlN8IW8xXMJWBuHOEjqmskusMbNsSgvWn4BsW5UHXAM?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?r+tiIq6DRW6PWCsVl0qq3YQS6ZqVxOekGhYujfn50uRE7pU1i6g+YrrnQPOt?=
 =?us-ascii?Q?r22vZZBZNhnmvl2JVZdg0HtdTeQz9m/0KJuLBUZvzDWQDFYMVNJ8KC765nuf?=
 =?us-ascii?Q?wSnRzmE6rQyVDwyUzZuaWuiZc6e3JYnH82FlCAhOambiS9uZu92fAmSExRe3?=
 =?us-ascii?Q?O3azuHSX5b2c6ieADj5ChR4GufLEN17PHERB/eXjYIhf3saayK6nJToXbQEF?=
 =?us-ascii?Q?RD3YyMfkb0RLsCWHgjG7DZKBXw8NDEyncUtwWwUavmob7Q8g+ajpDi1usRLo?=
 =?us-ascii?Q?n0v1vkRIe+vQ5hjJFYRiZti+wwJhtW2YXRFz8R92p9iC24Ma/vJOraGMAUUf?=
 =?us-ascii?Q?ANaQfF9IvuepejMOHZlCKoCuedHdXcT/n8halOdVFJZy0ECjNMWtE2Ans0QU?=
 =?us-ascii?Q?fY4yClHjlT+/wT4+n0RJ734qhLtSNnjl6ngFy3ScaAIbyvbNIvCWwqHSBSME?=
 =?us-ascii?Q?tJP3/PzRsM0W8aMscjgQXlr4xLTKz+gsHk7A+YZoYb7xDg1A45kFGXMeotIU?=
 =?us-ascii?Q?lyj7XB49vASS+EsijJUi3RK5lu7KAHECWCTpkPoAIf30m67Eenf9hArSaYiO?=
 =?us-ascii?Q?WAb3QFeaS2I7Xb4IAh1Bqjhc2o1mZvtJuumYDMiv4318MNB69dLo8C4PCaMX?=
 =?us-ascii?Q?GshtFsvauqP9fyz3+QPf8zZPnZXpSSOQgthak64U0Oyauz8Nh1ZJ/KJyr0yH?=
 =?us-ascii?Q?lIFQqTa9Bdunv0mdbascdJPiK++lQ7Eep6T8PhlSvMIEop0cJztrZv2gBR/H?=
 =?us-ascii?Q?uX6ZjRmWrqhDD53j0xAUkNxH4hXe1qkffbDGIfXNdIU5dig/BndW/fIQdhow?=
 =?us-ascii?Q?ikhVRJoD9Rtvauhnu1D/qu9rBlC0b1NQggogXTLo4+kwHivJ1YpdYGRhioIR?=
 =?us-ascii?Q?pRYaRynZ/5F3eMBRaujfjnJ/JI/dSUtJtE9wdT/6vSUkczmNFUhFBPESblXa?=
 =?us-ascii?Q?mXB/WwVjSEn1G0UvhRQxoKht2qC3qUf5DCMnKPNOtWHPz3J/hhF3X7cBMVIJ?=
 =?us-ascii?Q?OHazaodjUn+8xNe2PYKpfMXn9eaS/qR2/QCgH2aOHGJz3ClSdLtDgJWs7CJl?=
 =?us-ascii?Q?yauUPwqU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7291f0d2-169a-4687-922e-08dbf5fd2b37
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 01:46:30.4737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyAmtOMKfIwm/E1mOWLo19Lkwb5/waIVpv96psgPgVLMMjht2XIHzcxSvMf5/UaR+0bDirzDENy03dRu1C6l44MmNQg3VRuse6NmoDOjHsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5841
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=771
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060013
X-Proofpoint-ORIG-GUID: RmF5DVOCdgp3pZuhJnjVkNIoiB49X9Jd
X-Proofpoint-GUID: RmF5DVOCdgp3pZuhJnjVkNIoiB49X9Jd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ziqi,

> The Message Signaled Interrupts (MSI) support has been introduced in
> UFSHCI version 4.0 (JESD223E). The MSI is the recommended interrupt
> approach for MCQ. If choose to use MSI, In UFS DT, we need to provide
> msi-parent property that point to the hardware entity which serves as
> the MSI controller for this UFS controller.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
