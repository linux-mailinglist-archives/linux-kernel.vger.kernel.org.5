Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DAF752764
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjGMPhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjGMPhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:37:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB481FFC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:37:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DEJh1r029203;
        Thu, 13 Jul 2023 15:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=xjsiZzbtpc+bE9VY/GjWftCHyRN3nOCHCe0XKM+TQGw=;
 b=19qKzWoXIRlGBHQ5fNeBIzm78sbtaesRSwaXRPdMcKenVW1TYRt6HRyE4E8mkA2u/PaL
 gT89W5QrT+2N8MhtfRfKzinbREK6haQKU3BJhPp6SxEuXwu6POzcYosu6Zk2j7nTicLu
 cs+tp4PQKpXDP8iF002EAQHYDWTf0mcKvSQFD5caxJHJFn+ZlubUqV0Qt/BNDVRQbmkS
 MsV5DiP3XUDbkC1Z3gRGY6UlTsUoP2ydlTkChTOnY33PCxDVj4gJTk74wusCWshFNNCj
 IKGiBPCwNK4EVQncb7kirc0g3D2TsIWhs3VF1VzYo01kkLGOkFWP3GAwgsFUw5BGMFId 9A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrjmhfben-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 15:37:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36DEklLb026872;
        Thu, 13 Jul 2023 15:37:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx88hv9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 15:37:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5bq7nim1sE72ge6IyVCuXZEV2GIxDqQIV8g3kEwbmBEEkIhw1ZSg/WWv2cC2fOEVh/Ni7LqI0m9TjenYb/cYNv+OlOENhYFOcTzzNKqaQPVg+5KyQDwfDpvAY7NYBftnfiu9y4T+1Jftd7DNgeNgZZ0+9uEhfsacCBrSyKwQ49oZSGHkdx4WuE66z+qbQTf1M6TO3dRhLsnvGanCemon9Ht2OzLw/F2VcUhmTaYlRB2rPojkWIjB3ydVh1Er34nn4bRP2t/bE90I9ehMk2whC5hKyn6ooq0w7CgOjmN9JqCZfyqSo8Oqe3rXXjp1JXVytncrjeE6UMwPdKupHiGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjsiZzbtpc+bE9VY/GjWftCHyRN3nOCHCe0XKM+TQGw=;
 b=DHWZJ5/ztDL6cuq/cQA4kfAsdj40WCvjjNYLKRwauqmZPxhaEEoW8m6uHYbE1gvtDOWVThlQI5M3iTLN6bB9gAUhq/G6H5uu6/mCgoOtdhpD5+RvB7WVCjegxP1iOdNiwgGmpKgNCtxXGmUBh6iTNxlzFePuZk1UwpgQlk2/irtanyjf2llfsgI1wPq97snhEXR9fEenw0vmRdU7+IFqMO8QOpJZnGZLV559wPB/rYakLw/w6QIO4ZR9qu40S4FKaPXL8AGTPxlBOLGpuTTEg3j8ySCTHGzs5ZL77quJ0LZSo8WIfTULAfHW5TtASlGdtNTsy0mP+Gzn0shxDt8TxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjsiZzbtpc+bE9VY/GjWftCHyRN3nOCHCe0XKM+TQGw=;
 b=qbgYyd346xI/4ywM0T7yi7noij7u/xJqY+W3rxAIJT88j2tXIEfI34SMW+Le+fhyzKyDL6sOb119FPYxTIAwdfusXT2dluQR5T1+h/aIfHbrvdWWYOah0UV9TFxxATP4aQvU/J65Zh83Zd2heMFa90MMJXmaQVWJtUFGGCtD2S4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB6700.namprd10.prod.outlook.com (2603:10b6:208:440::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 15:37:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 15:37:00 +0000
Date:   Thu, 13 Jul 2023 11:36:57 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: Maple Tree Work
Message-ID: <20230713153657.b2xzf6z3yxi6nojn@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230707163815.ns4kdz7iut5octjv@revolver>
 <463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com>
 <20230712152738.ld7rn5zmmhtc6wkg@revolver>
 <e2fd59b5-8791-0a46-5157-51f93835ef35@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e2fd59b5-8791-0a46-5157-51f93835ef35@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0482.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ad1fe0-aed7-4912-7f43-08db83b70020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNB0O5htHZWtBc3nsSMZ46+e4mOh6UvggRS99sIDcELPsMUyK/q0/+h6Pc9vK/byudNPMC0xuAiaMVFDGJF8JKokC6YlkrSTjEoqzBScXKwDrAIL7cgAX36jU2ZYCWcXhFchuBUO2xjQWfiH7RyJEhhBFtWE3RTzK1X4DpxrJ3ziE+9PrVXvh9eJlynB21pMXU9f6itOqs06mjzcGmQV+b599hHYGhuEMW7xKi+zaB04WUfHnfBgldxb9xN++Mz2v0mjS6CBva9+irDafF+UjmfrzwY9PN3i/QuqcTfnJj0QwQMQHmxT0FweP0lFTvIppLKTaeOKKqVJTIQnygrQetUoY3Phc9P6txxZ5rKGqZUpJ5jeDmP26H6IQBNQtOODRQO02p2Pj4hKwgY5shnEU/Gxj1S2BtLCWQDh1l/zQsnSsQ9spvw9URzXWkWOg7wOeggyCFo1Q+KLsX4J8mOO5kJUmJ9U64nhrvkyZsnUbInqyuK4MyaVQjzDhDXnm8a8VzIq+JakNCJAPfNJIB7n5mRfWI94HgKeUx8EFn2VrK3F/ktzI/X+xw26mIDNsEwC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199021)(6512007)(4326008)(6916009)(66556008)(66946007)(66476007)(38100700002)(86362001)(186003)(26005)(6506007)(1076003)(83380400001)(9686003)(33716001)(478600001)(3480700007)(41300700001)(8936002)(8676002)(6486002)(316002)(6666004)(7116003)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czBpN3ZEd2NYS2MxOU5SV1B2YndYZktxZjZ5b2JPbWdWNXltVXg4NzVFQkRR?=
 =?utf-8?B?MnN5UjAwa2hEbFlmNWNoYWdZa3BkM1cxeUNpZGVZOU9oUFJZZ3daQktXeWtJ?=
 =?utf-8?B?NjN6MU9BTjZnR0E2UDg2bWt0UUs5ZlNrUEtuQ0hQQ3VyNXpoc3VINUVHdWtz?=
 =?utf-8?B?UEZTRWVJc3pqVVh3SjlDNGgyZ09CVmVURmt5WU5JVERTdTBERUFYU0Zycmoz?=
 =?utf-8?B?emVDN2FPWFR3TktLdkEyemtOSVAxQzg5MHVPMTRkcmFmYnJjb00rMEpoaHZj?=
 =?utf-8?B?amdOYkZ2b09hbWV3RmQvUmp5aFNnU1M3OHMyY3luUWR3dFY4N3ZQNVZjRlJx?=
 =?utf-8?B?L3JsYUg4a1FOSGpCSXphdkJHUFNvK3RoODltWXduQWJicTVDWG1CVDYwQlZ4?=
 =?utf-8?B?aW9iYUtFdmltZFg4V05jMWEvRVduNUpvVUNtZzVLdVNESDRIeDRWMFFjR0NJ?=
 =?utf-8?B?dkdPekpiZlFBTkFKM3Q2K2xudWlzT2YvVzFUelhZYmVDdkNRQTRVVWNkNXdY?=
 =?utf-8?B?NzNkYVhLQUdMRXRwWmJxZ05welFDV0lkc3V4NGhDUm5jOHkyR2VyR1B2b3F1?=
 =?utf-8?B?TkhBb3YvU0dsOVlrWE8zVFBGRGRIRnVXV1JtVjlmU0pObWt2RzNCeXcyaEVX?=
 =?utf-8?B?NS9ZNGZKMGxLcEIxcHUrYlZaM0l5WTJ3c0xFRUxGWDJKSklheWlaYlZkaHJR?=
 =?utf-8?B?VWlSOS9UT3cxVWt0S3FjMkoyYUIzRFVUQ0QzSWMwa21TckduQ294NWdlblo5?=
 =?utf-8?B?RHJrZ0VVTHNDZXR2anZsTmVGNzROWVNPVnlrL2M1YlJXVkg2bktSM0RvWDBB?=
 =?utf-8?B?T2ZFNUdNUnY5QkYyZEFyaWhKdS8zbE00RkNtTm84ZmtRZjJ3YzRlNDZtZk1j?=
 =?utf-8?B?RFl0bithTWVtYTRMUkFNRk1ITTg3WVRoYXo5dWk1ait5cHJsdlp1S2xhQUFZ?=
 =?utf-8?B?VER4TzFnRXBYcXBsczBjQURNbm5sbklBT2cxQmxma2hWTFdIK2NteVp2d0xD?=
 =?utf-8?B?c1VuN1M3STRlalBOM0RRSmJHL2ZjOUlWVjZKWDVNTElDSm5LK3B3ZEJlb2Rh?=
 =?utf-8?B?aVdnMW9PNkxiYjh6UWJvQUtCQ1RuQlJkd1R6ck9MNjZ1Mm9zMmRCa2dla2wz?=
 =?utf-8?B?SzExdHRLazEvM2wxc3Zmd1dQZnhIYmNUdmJLT2VQVWhjRm9nOExFV0thbXVw?=
 =?utf-8?B?RFhkSTd3MDYvQkt2cHhLL3ZWc2ZhNFlpNjNRRklnVnZMNTF5TmNSOEhPbWFl?=
 =?utf-8?B?QlZLZnIrM3lnZ3ltMVNFWWVZQjNjaU9NREIvV2t0dzJ6R2NOaDhXZ2xYWUlR?=
 =?utf-8?B?aWRXL2FxOUJTUDhyNFQ0UzJyNGlnODIvOGZlOXN4eFJHYWxmUzNiV1lDWlFy?=
 =?utf-8?B?VjBWMG9LU0RMKzVMSlZMK3owY1Yvb0ZkdGRLdkxUcUZINm53eExzbmJPMnFk?=
 =?utf-8?B?SEtpNFRrM2xmcVdMVzJodk9BbWFLcGtZOXR4ZmlvZ2l2cWZ5ZWFMUXZXUkRH?=
 =?utf-8?B?cmcvSUVKTXFwZ0dWUTJMb0psanMrVUlLMTJaUkpMN3dYL3B0R0RqK2kzUFd0?=
 =?utf-8?B?elM3VW1TZ28vRU1RWFpROHQvVnZMemRVWFdSeWhXYm9BbHphYUdGc0d5Z25p?=
 =?utf-8?B?SzdJTzlVRmhZVDFWOEQyYzRFRmw2b05neGVLQWNEeEN3QWZubzFPN0ZCTUJD?=
 =?utf-8?B?aGJzeWZZUmIzYTFNdlJNM2xTZkdkV1pRYmVuNFZJdjMxZjRYK05xU2swR3Zi?=
 =?utf-8?B?Qklrc1ZSREFRdFJaSHQraDhNcTJ6RHUwSVlJS3hwTWFYQkp1N3l0U1FrN2Vo?=
 =?utf-8?B?L0x6NTVzbDNpSVlWS0pTMHFSQkRhc1czeEFTbHZOYzg5NFJ5MVlhWTZSblM3?=
 =?utf-8?B?Mzh1K0lQTDFBUS9QTXZ1bGhBb3NJTFhZRmVGQUQ3Slk0eUFRWGZINkowRjhl?=
 =?utf-8?B?RXRYWjgyOXR1YUY5VEREeUZXNkw2ejQ2RDlnYmltd1o0ZWczU05Yc2ViTkhU?=
 =?utf-8?B?WWphWDNJeFFvUjdRZTNHeGpDQS8zcElheDdPTWk2dVEzZlZ5RnNQcm1Pc2RJ?=
 =?utf-8?B?WUNrVUtSK3cxQ1JZakFNVld6OEZvNnpXVTVZeXlBRVFFRUhHUks0d2dRUmVK?=
 =?utf-8?B?VnE0akpzbW1ZRUNWQjRhbHR3VGJjMU12Ny9NVmxHRmtFTVVzRGgxOWRrTk0y?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cALb3ZScdEZ9GpETZ9ade0FFyRYC87fr3AM+kgrZlPaCvUJWvgeVANWtMt5aDM2d4QFX/41UVLeXRoSpMd/C6QDYFw6EkZHuoNS5g4WTJvbeJYYPhn3kMy5Uweg4lWoHxkBH3duKOO2LyDObIGwZ3Y5hFDhPpr8yX+DA+fZl47lKQMYtaan8CQpzWmlt9GyT944NCOrsPHEqOrARQmN718bVfaNJWCWXErD1929sBdrwmo/Szyq/ZuBoYrCmurXz6nnGSs4ew/+6AOQ50NWI28v+gtWskrJSFCfKgc306WkM90Ae7iQawhTiwbRSqcVkEAG54QBRgaRCZgtUE8hUUxFHhg48t8Kq6FBzNTANuhCszQhE049qG+IQBFqyG4OtGF60znjN4EeOXpOR/tgXuZ2IVfGEjHVwqUKQwoj8wfhCn9gUQNs78duUddFqu7/uqamBGWDoRa9EQJTjwhoMOKthPgrpSDGAc5HK8o/U1dliLVQ5emKwZywLLSlLbNA6YXJQcbdyqwcIS3LT1r5yEJRP2Vcr2tk5NB8STi8LavU1xoELJ9XaPz94iCaNnZqdIpODZD2RysKKXSlJzLLZzFso/We+/tBYIjvrj/ahQBHh+IS9PIVAdegNCQW8Y189RtW1MenI/OkbbdawxSoZGezaibycLPT0fjCJf/NUGtizAVqlJZVAu+nWTjFUjPRZnFCMDoqqM2fP3XOrlDinDVY1JttrX2l7Y7ZEFG3Xigkj2Nv/TXHt2RuB051GY1EvF03N6zQXBj2euBRW/WXOjpLzh/AnbigJo8GUvUVLXZ6+ZnLEqCT3Yd5Q0CeIMb+Bki3IwIiVoPHUzEyOlUgkQq2Iuyhf+22p+gO6nI00xrQfcKRXfAkXZkH/Omh68g+A
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ad1fe0-aed7-4912-7f43-08db83b70020
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 15:37:00.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79ds7BgN/Bzffm5gxx9mBhudl0onz8og+JFlfWtc0hBKsoh67iu30qCeQwclCzyWuzQBz8ScTuj5xpE7E42yyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130137
X-Proofpoint-ORIG-GUID: d1cLaiFIpyIs6WvreXt386uB2tphm38j
X-Proofpoint-GUID: d1cLaiFIpyIs6WvreXt386uB2tphm38j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230713 04:05]:
>=20
>=20
> =E5=9C=A8 2023/7/12 23:27, Liam R. Howlett =E5=86=99=E9=81=93:
> > Dropping Danilo from the Cc..
> >=20
> > I was asked to add linux-mm to the list, so I did that as well.
> >=20
> > If anyone else is interested in seeing the full list, it's on lkml [1] =
and
> > the maple-tree list [2].
> >=20
> > Thank you Peng for looking at the list and taking time to think about
> > the items.
> >=20
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230712 07:49]:
> > >=20
> > >=20
> > > =E5=9C=A8 2023/7/8 00:38, Liam R. Howlett =E5=86=99=E9=81=93:
> > > >    - Fork & Dup tree + Delete DONT_COPY
> > > >    	This is to optimize dup_mmap() in kernel/fork.c, but other
> > > > 	users may want faster duplications of a tree.
> > > > 	This should be faster than building a tree in bulk mode.  The
> > > > 	idea is to just copy each node and replace the pointers in,
> > > > 	probably, a BFS order.  Once the leaves are reached, the VMAs
> > > > 	will be replaced by the copies made in fork, unless DONT_COPY is
> > > > 	set, in which case the VMA will be deleted from the copied tree.
> > > > 	DONT_COPY is not common and since the tree isn't visible, all
> > > > 	nodes should be available for reuse (no RCU worries).
> > > If DONT_COPY is set, this method will be complicated, because the gap=
s
> > > adjacent to it need to be merged, and the gaps of all ancestor nodes =
need to
> > > be updated.
> >=20
> > My understanding is that this is a rare event; there aren't many VMAs
> > marked this way.  The store operation already does all the necessary
> > work for deleting an entry. The gap tracking is also updated, and that
> > would only happen if the new gap is larger.  Are you concerned about th=
e
> > performance/runtime of handling the DONT_COPY in this way?
> Yes, if no DONT_COPY is set, copying all nodes and replacing the
> pointers must be the fastest way. I was just thinking if there is
> a faster way if DONT_COPY exists. Using the store operation to
> delete unnecessary entries will cause additional overhead sometimes.
> To give an example:
>=20
> Suppose a leaf node layout of the maple tree is as follows:
> [VMA1][VMA2][NULL][VMA3]
>=20
> If VMA2 has DONT_COPY set, we need to change the node layout as
> follows to delete it:
> [VMA1'][NULL][VMA3']
>=20
> At least we need to copy this node to replace it to make this
> delete operation, even need to rebalance. However, this is a
> rare case. In most cases, there is no gap between VMAs, so it
> will not cause changes in the node layout.

Remember that at this point, there is no readers so we could edit the
node without a copy.  It would require new code, but it's just moving
data left..  The bigger worry is a rebalance, as you said, and that can
get complicated. We know we have (more than) enough room to store the
data, but editing in place isn't done in this version of the code.  We
do allow for node re-use by pushing back onto the mas->alloc, so the
data requirements won't be too high.  Without any readers, the parent
pivots could be changed directly between two leaves.

> >=20
> > >=20
> > > I have another idea to build a tree, if inserted in order, we only
> > > insert at the leaf node. All leaf nodes are connected using a linked
> > > list. In the end we get a linked list with only leaf nodes. Then we
> > > construct non-leaf nodes layer by layer from bottom to top. I think
> > > this is also faster than bulk mode. Another advantage of this method
> > > is that we are applicable to more scenarios, do not need the original
> > > tree, only need to know the ranges inserted in order. I don't know
> > > how fast this method is, so we can discuss it.
> >=20
> > What is the advantage of a linked list over just building the tree as
> > you go?  Considering the non-leaf nodes are just a list of nodes
> > already, and you will have to do the same work of setting pivots,
> > allocating nodes, and filling them after you have the linked list.
> >=20
> > What work do you avoid that would make a linked list faster than bulk
> > insert or a tree copy/replace VMAs?  I was thinking that we could avoid
> > a lot of the work involved with splitting/pushing and the parent
> > construction by using memcpy of each node, replace each slot (and
> > parent) with a new memcpy of the mirrored tree, then have a minimum
> > amount of modifications to delete the DONT_COPY during the VMA
> > replacement.  BFS copy would ensure we wouldn't modify the source tree
> > during VMA replacement and deletion (DONT_COPY).  So the rebalancing (i=
n
> > bulk insert), pivot calculations, metadata, and gaps are (mostly) saved
> > by using memcpy.
> Your analysis is correct.
> >=20
> >  From what I understand from your linked list idea, we would need to
> > construct the child node by examining each entry and know that a certai=
n
> > entry is a DONT_COPY (ie: VMA logic would be needed in the maple tree
> > code or a callback?). We really can't have VMA logic in the maple tree
> > code, so we could do some sort of loop through the VMAs to add the entr=
y
> > to the list if desired.
> >=20
> > Once we have a linked list, we still need to figure out each pivot for
> > the parent (I guess we won't use the last slot so there is a pivot to
> > check?), and each max gap in each child to construct the upper layers
> > of the tree.  Is this correct?
> >=20
> > I guess we would still need to adjust the last node to ensure sufficien=
t
> > entries as well, so as we add items we may need to rebalance the last
> > leaf with the second-last leaf.
> Yes, the last two leaves need to check to make sure they have enough
> items.
> >=20
> > The bulk store currently adjusts the split to favour splitting
> > left, could you get the same result by strictly filling the nodes?  Thi=
s
> > would have to have special handling to rebalance the last one - which w=
e
> > have a pretty good idea of when it's going to happen as we have a count
> > (and the DONT_COPY is rare).
> >=20
> > Are you thinking you could compact the tree at the same time to gain
> > efficiency?
> >=20
> > What would you consider a sufficient packed tree?  It's best to keep
> > some space around for expansion/contraction.  This works out since, I
> > think, we would need to keep that last slot free so we have a pivot to
> > check in your linked list plan. Initial development with strict
> > split/join rules resulted in a 'jittering' of nodes as the number of
> > entries in a node shifted just above/below the threshold so we relaxed
> > the merging of nodes to avoid such a scenario.
> We can control the number of entries of nodes, for example, let this
> number be (min + max)/2, so as to avoid making a node too 'dense' or
> too 'loose'.

By the way, in the VMA case, we also know the number of VMAs in the
tree.  Unfortunately, we don't know how many are DONT_COPY VMAs.  I
wonder if it would be worth while to balance each VMA with its neighbour
during this operation, at least within one tree level?  It would reduce
the possibility of a larger rebalance on a DONT_COPY.  It's probably not
worth it because it would slow down our fast path.

> >=20
> > Let me know if you would like me to put your name beside the Fork & Dup
> > Tree item in the list of work.
> You can put my name on this one and I'll do it.

Sounds good, thanks!

> I use the method of copying all nodes, so I will implement an interface
> to get a mirrored tree.
>=20
> But I can't think of a good way to replace old VMAs, it can't be done
> during the copy tree process, because maybe some VMAs have DONT_COPY
> flag.

I think it could be done during the copy, instead of a 'replace' it
would be a 'delete'.  I think this is why we need to use a BFS-like
duplication. So once we reach the leaves, then we can modify the tree
knowing that the above state has already been copied and so it's going
to be altering a copy of the data and so we are at a point where it can
be mutated.  You could detect that the lock-step next/insert is out of
sync and delete the range between the old_mas and the new_mas.

> It seems that we can only scan all VMAs in the source tree again
> to update the new tree. We have already traversed the source tree once
> in the process of copying the tree. Is there any way to avoid traversing
> it again?

Well, we haven't visited the VMAs in the copy, but we have visited the
leaf nodes with all the pointers to the VMAs.  I get what you are
saying thought, we will have to duplicate the leaves then re-visit the
leaves to replace the VMAs.  I am not sure we can avoid this since a
rebalance may occur, and it would be very tricky to rebalance with old
and new data in the tree - it's probably best to just revisit, at least
to begin with.

Depending on how you implement it, you could make the copying of the
tree end on the first leaf node by using the height of the tree to
figure out which way to sweep (left to right or right to left) on the
first level.  Not strictly BFS, but you could end the maple state in the
correct location to start replacing the VMAs.  Would that work?

We also have a reverse iterator, so we could just run through the tree
from the right-most node to the start.

I was thinking that we would make the first 'duplication store' detect
an empty tree and duplicate the tree, ending on the left-most leaf and
then replace the first entry (and possibly delete up to the first
store).  Each subsequent store would do the same.  We would need a
'duplication complete' that would remove any entries beyond the last
store and rebalance, if necessary.

Feel free to use some or none of the ideas.  I hope some of this helps
with what you are trying to work out.  Let me know if you have any more
questions.

Thanks,
Liam
