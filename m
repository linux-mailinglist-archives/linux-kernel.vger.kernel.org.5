Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219207DE413
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjKAPp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344687AbjKAOrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:47:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A96F101
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:46:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1ArjOG011697;
        Wed, 1 Nov 2023 14:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fkeaV9MSjxbIQzctEjVKLrSgUnRd+m+5nMh0NJYBbtw=;
 b=PlBgdmU5OTL3ewzJmH+cKTBVEo5J4d+E506pWB3CaEjdoKsoXh7LZ/aDfE6ANtBkp3i0
 W9NJGYLzb8rmPjJYhtec0xTA2resTy+Ge0Xk17Kkp4Didl3ftMFL7Xyf9c9m/pXPT86a
 SB6BeaF6khXN41KYLGBrKSxeFnXQ3xZarQRxJmlU3XPuWBF0uQY75MY9JTWkXYFJOww8
 hNfFUMSeFvuhxMAeutFtsvaCSKjyHe0RONBTBS+tkinOP8JVBlBQkIDGljXfauOd/N1R
 wSPXc1sZmj2ZueSNY6I1E6HwDGTgRZ7ql/vVf///94/tK/zotGC/RBQozxL5kp7ViKy4 Yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s33yqx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 14:46:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1DrcWO001037;
        Wed, 1 Nov 2023 14:46:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr7fxe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 14:46:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2v6OEPdT6E9jr7gsTrnert506iDG7bICwQZSN/EvtN/JMJLgFpYQQn0dChTKcHXPXJOyM9SG/IVJea2CxyJ55fU5qEnO0sbMYxeJRMn26gG3tpNopsT+DbgOc6YjAAhs/lgqh/JnWZFTb42OwSDAKpp0ESGblDuJB04DrJTMRQi0FNRDKtdQbOIIlGd6RmCJmLKuxyD/nLp4cv257s9jBKYTeUD1tspY8FMV9JrHJ/KcpkTJAATWgOUDtJ3ZWsvKYsavlSUZrPKaE8bYWX0JPaGsBIbdD/plt8i1JuOn3L1UNe1xrD4OmAwlR3zBM76gSqyYLVCQplU2abu4/fAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkeaV9MSjxbIQzctEjVKLrSgUnRd+m+5nMh0NJYBbtw=;
 b=HlsvEJiUrRVMbwHnynzClA76Hdc6ykEel2Tu8ZVSmRiHSoIneUptGTV0slCXJ6Gr+6LTYYQ3hhQkMVHea6OZRJDxy6oUPgShUHtG8qjfUc+TdFt39bAbgRmLPy5YPjnzDxffgavD44jNwmU59msF5m59yySN+yGpNfZI2WcqemW87lqtepEAykrRuPde2J9Nvr5d2QNW1DXfOwKrx4uBXG9eNm0qAEfLnvoNwskXFppMmnE52VJTShM/AqJltRrozcGyuKMYmq1uy02aY/WioifTZdqxrHzVOfZHtUYjuiSfthYSFGqyBp4rbQ9a0vS1Twq5thg4Z1I8X/jo5s03tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkeaV9MSjxbIQzctEjVKLrSgUnRd+m+5nMh0NJYBbtw=;
 b=LyhRtIznF88BO2KvGNUsMLqUHnixKZgyva9h72RWe9idLdTdefydkIqmY1w/Ckr4g1+OqLRhMDzNIJp5HDNqL92infvEkqEUHBUJfL5yf3O/bt7LoTvJL+I8YWu+BFyEkNx/MvIWMURSe4UtchXMC8jBH0C0jMEbcRXyno8gu+k=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CYXPR10MB7976.namprd10.prod.outlook.com (2603:10b6:930:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Wed, 1 Nov
 2023 14:46:39 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435%4]) with mapi id 15.20.6933.022; Wed, 1 Nov 2023
 14:46:39 +0000
Message-ID: <bff9ffa1-dad2-4ec9-8470-c9acefa3e617@oracle.com>
Date:   Wed, 1 Nov 2023 09:46:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] UBSAN: array-index-out-of-bounds in dtSplitRoot
Content-Language: en-US
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+d4b1df2e9d4ded6488ec@syzkaller.appspotmail.com
References: <20231013191028.17382-1-osmtendev@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20231013191028.17382-1-osmtendev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0316.namprd03.prod.outlook.com
 (2603:10b6:610:118::23) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CYXPR10MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 909ba895-c9d1-4efc-a251-08dbdae95ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLi2N2Oser3na3Q8e1DAVm6/vcAnbbhqt54bwQAFzHr/2oV355TXh7/ghHkUGEXwI9y4B5lpKnR6K605iGr7Puav0SbcNetWO12xA4SWiVy8VBnxwez8ZcLxx8XzFn7sFNbUjKJq951tnVsNuoZydK7DddfufCMkhIRFegbNh3xVEciU/mY6kARJmiMgYS1bMcBzGRmE2qdMnCyEhb225dRTJKC+aK7hTkovvszfa+Jl43Ob6LKkMrjGZDezw7fs705lRGUJJKblYxkrNhQvX6PhwnOAq6rrNyPLX2lakmqoLDfqniFcNbTpS3Y+cdpNIPkSClS+75TS2a2aYSWQLWmpoO18ZGjECGngrIqMgIhTvMSMNw/H8yEzuoj4bjZpcm0nuitCK+eaqZHwi4bPA4oiUfJwOJeUBEYiutYrstNBQOlGoJfNEsY/nPH5+kElZd3XGZ0D5ksrla8axCmmjMkFRBb2qolIKU2rh4s/ZYoGy4gX7FhJ8RCcaJBDOxBULqv9DRUk+WB4OQt8KCwGWr8s4R+osgZkghIlENqQxdK62s63ID5QWxOdrQkMDwadiOdubIJEuxhXz76opwzp0odUbdEOderxPRE95QVHQnp+p1rgxXTKNij/7MusfOpqjRimfXcb8UZnjDU40l1FhSgQjNG8om648fwJJM4Klxo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(38100700002)(6506007)(6666004)(6512007)(83380400001)(26005)(66946007)(966005)(6486002)(2616005)(478600001)(316002)(6916009)(66476007)(8936002)(4326008)(5660300002)(41300700001)(2906002)(86362001)(8676002)(36756003)(31686004)(44832011)(66556008)(31696002)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlYxWC8rY0xQNHVGYi9Ud3owaVJTdkpEWURGSVdVNlJDUDJVdU11SG8zVHJi?=
 =?utf-8?B?MmRubWN2d0F5TWNudTlXM0Y1Q3drb0FrSjhKWkFOT01OckJUYTVMd1FSUHJo?=
 =?utf-8?B?RmM4cjJkM3BKVGpMNjI2VWxCdWhWYzVjVmpUeUliVE1zMVpDVjZ4Q2JsZ2NW?=
 =?utf-8?B?RkNiOEJseldNbFF1S0VMOFFjc3NzbVIzR3BxS3RhUkhaR0ZyUHZMWDNNWXU5?=
 =?utf-8?B?blhYOENRZTUvazdydS93cHVjNmR4MnhmRUxJUE8yL0FNamRORUtOY1EwV0Vi?=
 =?utf-8?B?UFBpT1BJVWxMc1N2c3ZQYTh3SDh5YUpXU3MwRVhabEpTUVhsZnA2ZkNiV0kx?=
 =?utf-8?B?dEFkY3BnZExNcWFhVWoxR3l6enZ0dFlmSzRRTnBveTJ6c1JyR1dKSC9LZ2N0?=
 =?utf-8?B?K3UrTDFMWEN3UEpPOXlCZEdoL1ZJcFNtS3hnTHRhc3lhVG02OTlwaVRNRFNy?=
 =?utf-8?B?OXo2eDUwTzNiaTFkSXNHWWs1M2JGOVV6R2NyZlk1b2MrcHlxZFFqZUdCNGVM?=
 =?utf-8?B?M01IMHMwaFpnSVVXSm55alZwbU0wREFvQnpwUHk4MXo0aGRhYjk2VE04anM5?=
 =?utf-8?B?RmNaUWREMnphQTBwcnZiSmtmbVpKOUlNSmdCQVR3SjRsNnJPZ1ZMOGhHVUtU?=
 =?utf-8?B?Tng4S3hLTWV0TTV6ejRrSkdGQ1BObkNBZmNRWmsxdHpWYjVEV2xMbC9iWXpX?=
 =?utf-8?B?bmdEWHR0dkZaWXVUN0NCM1JvQzczMzNjVXFpYk40U3Z3OXoxbURDd0hGZXhO?=
 =?utf-8?B?TVBON2tDSHIxd0dUVFFudkh6U0I5c0dWK3U0aitpeGlKM2VZU2VTdmdGQ0d1?=
 =?utf-8?B?dHZMQVRtRE9SR0FGaVRFdnFRd1N0VTRwOXQzWGpQclQxdGtLbzFSTURPK2xV?=
 =?utf-8?B?dXlzL2JEMS9wNExSQUo3QktkODc1T0xLeXl3ZktkUjJDOERORzNxSFpLTFd5?=
 =?utf-8?B?Ky9TaGxSZ2V5RFNFSE1kcUNsZDNrRFhSK1YzZDJGenl5RkJxTTA2Q0NoejR3?=
 =?utf-8?B?ZDRqRTJUYkwxM3h3VUFvVDc1QWlMNFYxRFpucXlOWE1LazBma0tkK2pZUUJC?=
 =?utf-8?B?b0xSei90NFN4Q1ZCSlhQQ2JBUysvbnBrZG1FdFFjMW5lcGM5YmxaNzYyTEhQ?=
 =?utf-8?B?aFJSbUNCR1p2YlhaOW9ENHZURjFXeFg5YTZUWXVsQU5MbnU3RkRWREZYNkt2?=
 =?utf-8?B?Q3hXaDVYNFZoblpPRCt3d0gyS21kdmxpbnl1aE5tQnNnRUFVenM1T21yYTJ3?=
 =?utf-8?B?c2RxYjlOMHE0SDJYTHkxc0QybTRpUDcrSWRwQUI3dCtvUm9wT3JrVDIxbTVO?=
 =?utf-8?B?L2ttcFl3OTFhSk1YdEEvc1NaS0dPWkQvTFJYbWQ0VmpxWEZvN2JSTmkwS0Vu?=
 =?utf-8?B?T0hHV1JDOXFTWEFkaXNvYXBLQklqN2NydFRzV05PUU9LeU9iT293NXJFNjc4?=
 =?utf-8?B?OTB6TEtkRnhMUnd6dEU1VlpCWjBPaDNMYzQvYzJzSHpmb3VpVEl3TSsxVUp0?=
 =?utf-8?B?ZGFBajJyaUZBUVJGT3FyZlEraElKbVBweXZDTGg1T2JVQStHNGtmQkpERjFG?=
 =?utf-8?B?c2tsTllVYUFzRnBpQ1VTVGpqdUtUZmk1eFRyemNLbER4dmNMdXF4ZWJxR2xj?=
 =?utf-8?B?SWZUdWtQSGRnSkl0R3pJK25CdVlKZTlXRGhkdGN0d3FyZ3BOUXBZZ1BTcVRu?=
 =?utf-8?B?WmlGbWErUm84YWxHN1lHZGpDOTJYU0JhaGQ0TGEvdHVVd0xFWTV6dXM0SnRK?=
 =?utf-8?B?MGdOdzgreHdIWU9razhaOGNGdUVBaXZsK2xreUhzYWJJZXBaY2NYbFN2YXpj?=
 =?utf-8?B?d09CZzAvSnkxR01vTUgyY0VaRTE4NzAyOWdRMEFhVCtGT3Z1a2dxclA5Ky83?=
 =?utf-8?B?em95eU5udkFTU3pzc004cnF0QXp2ejQ3RFZ3STNwM3lyRUoxM20wVmlsM2w3?=
 =?utf-8?B?c1Evd2NkTzMvTThNSmNXLy9nNDdwV2tZNXUxMk1nYkhFdkVKL0Q2NjhKVitl?=
 =?utf-8?B?ZXFCSmZaS0NCRlc3ejFoeDMwZ2lCRUhaVm9GNmhyU0UvL1ZOK09jY1NjS2Jv?=
 =?utf-8?B?K3prTWhMeGwxZGZUR01hYkdXb0w5V0VyQ2U5bjNIajQyUWt1RmVyaDNPcmYz?=
 =?utf-8?B?NTNodzAycjFOeDBKVExqRVp4ckVYdmFyemdIUk1SQUdQVTRQdUU2eENDWCto?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nxIb+7DdLks39fNf2JumRwrCN1452cq9ps2xoIU+vuD5Dx/Qg/FZkJnzRilrIjm4TULb1FkR/IiyTUPPp95B3h4L3c5EytVdCal1j5QeNcrhftl8sP6mrhL4rvzs1QzWMobh6ndy4alohFrBNPLIUpEk7oXnP/FW16HHu8sJR+eaSODXtV3dfsMhH17AyQ+U3k9fqBv1jt9cjCPqbJp90IhpDT80arAVfCitlyRro7y9cuAaIB4bpb6u94Ji0VkrACtNhqiancwVWDkhZzw8uyXOFi4+HnRMc8VwRQeqAxp8Xg9etpIeZt1qH9luKfVMgXtSJzTWoUi8NiR9fscQcDG2PSFbk6O0gs7gJiublsDr/o8IpDY9nYxEUquI2VsNmiWRo9dBUOlNEUtAF5i3ScxWWY5W7JNKDDIYLsFaTg10IH14Efmzj11wq8iZX/I7VLIC3JbabAuQ2HEUE2OWxcLy5jnyMe/IYIMEjdf70buUrdYY9IP8wiBlDDQ1trnFt8nfrh1gr4FcWbj8+9jA50799sdWXj9a3LKt+b+gST7h1ps2OH76yxBQYPHLRg9tgF3Z09XDblIQija0euAo/Ql9Zeh7xa13gmYLnYHRZvVuuhdBuSnat+nqAt2g31kpvud57MhCrhT1AIUrWtSPkR4H28kcrTekqSpW+FSolkwybMzxUYa8A7fWRQ4Vcufv4k1Br/SdOiUoxTmJsnVMLotT46P9odkPmyKpdumPMuNlVhUGZBu/+SU0Q/umlchJkiYShrGURc8wra8gTHiGfJesZI8Dw1hEzelVDjbi6vjfccVi3IDtwmQ7Lve86fJPDO4NqMlbiwcpqdQHmZS7BOJdFswjFzdU4HucMGH6Hug340xvkaUb/W2/bt6eoNiGF+foxEF8a1D3CjZMZ5Vbxrpi9v+OIGyjSMmX1sJIWoI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909ba895-c9d1-4efc-a251-08dbdae95ad0
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 14:46:39.0406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yW8yZbIh8ekGwA6wWs2y0xoWNk5m+R6J1X6kLuh2VW8Wr0f9sXtjKPx+gKwkNxHoxKU9KADsa58PnV4tD4si+8Ko9CN2kOpj70VisDzmcOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_12,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=991 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010124
X-Proofpoint-GUID: lEOTgycmQCZ7MP7xyyxIhDKePqO_N7Gm
X-Proofpoint-ORIG-GUID: lEOTgycmQCZ7MP7xyyxIhDKePqO_N7Gm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 2:10PM, Osama Muhammad wrote:
> Syzkaller reported the following issue:
> 
> oop0: detected capacity change from 0 to 32768
> 
> UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:1971:9
> index -2 is out of range for type 'struct dtslot [128]'
> CPU: 0 PID: 3613 Comm: syz-executor270 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>   ubsan_epilogue lib/ubsan.c:151 [inline]
>   __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
>   dtSplitRoot+0x8d8/0x1900 fs/jfs/jfs_dtree.c:1971
>   dtSplitUp fs/jfs/jfs_dtree.c:985 [inline]
>   dtInsert+0x1189/0x6b80 fs/jfs/jfs_dtree.c:863
>   jfs_mkdir+0x757/0xb00 fs/jfs/namei.c:270
>   vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
>   do_mkdirat+0x279/0x550 fs/namei.c:4038
>   __do_sys_mkdirat fs/namei.c:4053 [inline]
>   __se_sys_mkdirat fs/namei.c:4051 [inline]
>   __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4051
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fcdc0113fd9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeb8bc67d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcdc0113fd9
> RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000000000003
> RBP: 00007fcdc00d37a0 R08: 0000000000000000 R09: 00007fcdc00d37a0
> R10: 00005555559a72c0 R11: 0000000000000246 R12: 00000000f8008000
> R13: 0000000000000000 R14: 00083878000000f8 R15: 0000000000000000
>   </TASK>
> 
> The issue is caused when the value of fsi becomes less than -1.
> The check to break the loop when fsi value becomes -1 is present
> but syzbot was able to produce value less than -1 which cause the error.
> This patch simply add the change for the values less than 0.
> 
> The patch is tested via syzbot.

Looks good.

Thanks,
Shaggy

> 
> Reported-and-tested-by: syzbot+d4b1df2e9d4ded6488ec@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=d4b1df2e9d4ded6488ec
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> ---
>   fs/jfs/jfs_dtree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
> index 92b7c533407c..f3d3e8b3f50c 100644
> --- a/fs/jfs/jfs_dtree.c
> +++ b/fs/jfs/jfs_dtree.c
> @@ -1970,7 +1970,7 @@ static int dtSplitRoot(tid_t tid,
>   		do {
>   			f = &rp->slot[fsi];
>   			fsi = f->next;
> -		} while (fsi != -1);
> +		} while (fsi >= 0);
>   
>   		f->next = n;
>   	}
