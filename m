Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F6E7581EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjGRQRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjGRQR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:17:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E5AB5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:17:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ID7fnX005692;
        Tue, 18 Jul 2023 16:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Pt2JPE/aTYSdUl9I7JDyx/UcclGwWpHD96lXYLqgnYY=;
 b=31SjN/WrT782swLABUb0r66TR91YLjvjXizoznwF92SwiTLSKVatfdd0wv+3RTax4cXK
 vV5lGV2zM+TV8z1tjj2GymQcRovnFOjCasGnCEUGD6UhqUJ3IJo+r7UxSh//5iZnCDRl
 +AsqMAZvLwSScseP7rl45eT/8XOzL0eSN1YOJqDWHTBn4bu/J9F5w66kRFEQ0j7HOVWd
 5c6QC6yrbFXub7HVq2AgLCrN1dx86jSdzehgWr6xFTslyofDgpozs/E3RFouXOCEwssd
 6JGxQmqVw1F3ZZpIoSWkDJzB+DUUllNJWw5LR+Y7MDPHAwPTwugUJH7DIaUxCwWX/PgS vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run76whbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 16:17:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36IFbW03038179;
        Tue, 18 Jul 2023 16:17:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw5bbf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 16:17:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUc1xVqgQA6O3tHXKqEsKWqWMz6TA0Cd05kYSsOdEPD/3N5xYV1ytzyqpzJAUlr0rcnoQGTZqLd0Qgbk3iefVOly/kLSGxavuJNYNQ6cbrGlQDiDDUZy5+FRifLXKff6+abUMLcOXviXgu/puJyBtWwFjwt3kP8PuDlaoitt+YHvRrl6PYc/0gj32TuYo1gAUFWm/M7OovAYgg7Codeflasddwu7/Rhe6vMfTcuubvgv9QSmS6Matc1VCnfXObmKztOQTqOU9QkpYSCpNokLUwPJerDtHFa2kXhgmuGaNIM5tcDfV6AdwnLlZyrKue18msmxqwOjA5vxDKqIZxgJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt2JPE/aTYSdUl9I7JDyx/UcclGwWpHD96lXYLqgnYY=;
 b=QWHZ/w9ewdVpgoEYwMY1VPMESckNi9ZnC/OSgsu6iYXIll4JwMUTJgfwc/x0hvdvbrwybcQ9OnOdXzxmxlUdDr3bYCtDY2X7uaSBvYHs0F1vvAe0vVl3cYaXsKv3FNAV2f73976EyccE951+Zi48LE3RnSG9p29wKXyXyYLH4zylikFMbz7azr/+2WtOrxMHjvv1m3lR0wuRe+H1zonUF6DgSi9Y2+p3wx06P9LANFDZn05dWdQKxn45JWS0zN7BtMuzIv2kyNTrLGBlHHUTf6vYHLPINDFtvyrVpH1rGenO55vz171IFAcedv3xM+AUzXg38kyIU1ZmTUKH8iMgpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt2JPE/aTYSdUl9I7JDyx/UcclGwWpHD96lXYLqgnYY=;
 b=uTMc7L1dfBTSOH90Evp9xamDnwJI/v0KM7ZjXPnUJqIL6SXMlNfjcJGA5bj8eyD1VIeTrXYb61JRiHZ3T+ic98POY1uxv4eQoeyFCQGpQoYjFKXfMqGdLMHVHxhqqR91hNhkOJiBCJHNJfu7MPrbcT7zhMNzURoDWfs/ANL0WqU=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 16:17:04 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1ad9:6eeb:6c8d:27d3]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1ad9:6eeb:6c8d:27d3%6]) with mapi id 15.20.6565.028; Tue, 18 Jul 2023
 16:17:04 +0000
Message-ID: <5c4c63ff-2191-c57b-50b9-20a7b9a60d86@oracle.com>
Date:   Tue, 18 Jul 2023 11:17:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fs/jfs: prevent double-free in dbUnmount() after
 failed jfs_remount()
Content-Language: en-US
To:     Andrew Kanner <andrew.kanner@gmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
References: <20221201124628.603505-1-liushixin2@huawei.com>
 <20230701140542.2252-1-andrew.kanner@gmail.com>
 <20230701140542.2252-2-andrew.kanner@gmail.com>
 <64b6b235.190a0220.28c3a.1ee8@mx.google.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <64b6b235.190a0220.28c3a.1ee8@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:610:4e::34) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SJ0PR10MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e63a93f-a104-451f-f834-08db87aa6c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1SrKNbCs1dqiM/SvRZrAeeVxAzbsno7ZY/zPaGbWL6vIR1o71eBplyiFfKwEQWizgA8eC3gUTUYGPg5aWc0VLkdiKrEkS4i7PsVRqR5TPWh/HOALJ9FZ4lZhfwET+jdzHCbM/wL/r3uELBgp3K9YmqukxoqmT0+RV7w98qOyHfwJDet8D+YvNIUAJ8wJPxRGVm6su+GYxcoqtAbsqZHOBp8KKwu1GtbBaf4SiFxfoZTikMuPkC84WNH1UAy/GtNHLQs906E0UeFHvOBTmHDGZRbFS48yTPxLZY6ga6vlLJEuVs237f1b4Vxn0FnOg+1b4YEMvG1X8ymVxuz+EY7EacnZuMGcPp1FgkbFH4M9SUJEvdQ0tirjYxa3SbS5NK8oUVGlRrde4YCQxwAx5sh+hDgKyd493OcfYHCQK4qWr1T8uBkVkYKe9GQBP4keWrGkNjf0x/JiuZ+bHa1lMl7TkGEeUjQb7FXF01ELHTlkDuCbl57drzFUtJ/XN3O2zJ6B3/dHaqefan5f/PcGnHym0tt/ASzRFj5VqXjZaVB6sgFC0i5vAeBQe+U0UBfyt2gnJz/KQUmOjN/p8TN3M8dGQnahzpahkZAXc3R0oT43ij+mfiVOQA7RTzLo9MI0NcxBltNzQ1WbNCZ0jHANUatxK22MgZgNt8WhRx4Fq+Ig5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(478600001)(26005)(6506007)(6512007)(966005)(6486002)(6666004)(4326008)(83380400001)(8676002)(8936002)(44832011)(5660300002)(2616005)(316002)(41300700001)(86362001)(31696002)(2906002)(31686004)(186003)(38100700002)(36756003)(66946007)(66476007)(66556008)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1FYMk5CdkFhTHc3b0xoOUwrRWFTeHY3ZlNmSGJQS3BPYThBV2RtYTU5KzAx?=
 =?utf-8?B?d3ZVNTk4SnVGQkgrem5Bbmg2dzJDdjVhUHhnQWp4UDJYbDltK3pGT3FuS1BS?=
 =?utf-8?B?bVZqYlNQYmZ4NlRiMmJKZDhMOU1pMGFwRE9IKzcwREZyU1pEZS90SGJuWkJP?=
 =?utf-8?B?K1hqRC9INHh3ODZCVzlPN3VCdVRkRVg0UXJRdFFIRjVSdTcxekkrTzBjVTI2?=
 =?utf-8?B?WmxEbzNxa0dHcG5ialVlNUV5VVN5RCs5MFR3TkZpcE5SbExQS3BaUTdpTWdJ?=
 =?utf-8?B?Ry9tYUloZEtvVWlHQ2krNmdyUnU5czZLOWluc1hNMjcyUjdWQ3B5Ykx5a1lx?=
 =?utf-8?B?QlVveHN3ZVZuMEs4WnNXYS9GMU83SEVneXRNNzk5aVRacmsxWU5IUVB6MFV3?=
 =?utf-8?B?eEpLa2dwaW0rcERZMDFsbzk5eVVXLzlSeEJOYVF1RVcvTmdQalVsSlJzK3ND?=
 =?utf-8?B?dHpzWDU5cmdKQlNEQldGQWhNSVlrL2QyYXJaYnowMXR3QVFtUjVEMXNTWStT?=
 =?utf-8?B?eVh4Zk12dkRsMWR3NzA1eUZ2R2xjWS83MTdDd2ZBNmRUWFIrZks4TzY5Qm5a?=
 =?utf-8?B?MnQxODRFVGZJQzBOa0RQdHBZczJZNzU5RFoyTEJIbnpsYU9JWjVaOCthd1I1?=
 =?utf-8?B?WkNNUFQyaVVzdmFMVnRTUHdWMENNYkwzTjZxZElxalZxT25lcFZpVHh4MlBF?=
 =?utf-8?B?WjdGOEs1OWkwQU9rMXFKbjAySm5qb0UxSmZIck1LM0Rsb2tCRWMxMlY3MzNI?=
 =?utf-8?B?Zng4ajJYU1ZBL2RtdXBjczlwcVIvZDJ6SFVHTUp5RXFmQlNkODcwN0syNUpy?=
 =?utf-8?B?VjZIN0lyLzY5QTJtRmh1YmJscUJ6VUZ2V1dMZGV2TEROaDdSVlBrN1ZqY0Rn?=
 =?utf-8?B?QzVyR3Rta2ppOUpEajVFMXNCbGR1S0liNE9sUjJPNWowdTBteEYvb1Y4MDJu?=
 =?utf-8?B?VW9KT2M0Q3I1dUJaSXdWZlhRV3NoN2EwY3IxVE9tRXlSaE9UTlRIZUkxdVVF?=
 =?utf-8?B?dVVUN3cvYkFTRnJCcnJ6NXpTcUJGUEk3ckV6T1l1UU90TGNibVl5c3krVTBB?=
 =?utf-8?B?M2REaXV2VmFXdndMcjljNXdQTUtBdndWaFBzZ216NTE0T25idFBjVUhNSUVT?=
 =?utf-8?B?bUQrVEFScXdKRGVqM0s4bElEcUNmNlQwT2syaTNHQUwwRHAzY3lQeFQ1Q1B2?=
 =?utf-8?B?ZXBwdTNKWWdrdGUzNzRTdGg1WkVscHc1STFYYVdSeExwUGdiZ2hhR3RJYUlW?=
 =?utf-8?B?RVdMaXE2NWZ0SWpwWmd1NnlPVDZaa1Q1cTBDSEpzcmxqSThiU08wU0s0OVJn?=
 =?utf-8?B?c3dWRWE3VEtxTXdNbndWeGVkd01Ub25qUnJ1UE9oODROWTVCU3dZdGtwTk9k?=
 =?utf-8?B?NWZKaEltcGx1ZWNEa1A4RlNQdjNCWUx2MHgzaFp6ZjFycFFVNXFmRG5LQXVD?=
 =?utf-8?B?eHZ3eG1Ta2duWVdhVjB4WXhsTlpKZkNSQ1NlekFzZVhhNzRpZUxxV0MzUXpD?=
 =?utf-8?B?WENaRjUvKzZNMkttT1c1eWVFOTJ0WmlUT1VSZUpQR2wxb2J5QitZaUJHT3c0?=
 =?utf-8?B?SE1OZCtqc3QySGI1V1lGdnB6M0ovdjRtTVNYbG14L1prbjlXRzlWTzZ2TTRR?=
 =?utf-8?B?RW9PMWE4SDUvK04yWEhHSmxlQVFINUp5Wk5wTUwvYVA2R3FOd2Rrc05kR1BD?=
 =?utf-8?B?Nk1iSk1ERFRPakd1UXA4V1Q4ck1WSzFKczl2N0JWdHdoTTZmQ3lrQk1ZT24w?=
 =?utf-8?B?K2UyRGxVMWZ1UGd6T1MvQW1kN0RFVm1mN2JWZFZGejBCMTFBZ2tXMk5ZQUxB?=
 =?utf-8?B?Q3RzaEhGU1VFbTRQZ0tOVEViaXZEa09KUk1xQXRPM1JweFQ4dTQweFQxWjZS?=
 =?utf-8?B?TU1IUXRMMTRzSnBKMDM0dDRKMm85ZDJqZmVBK3NCVE5TbzhXM0pOWnQwTU52?=
 =?utf-8?B?T3YzSlVyejBLVGFWd1dhQ255c0dHQXFGQWU0VWtRdC90Z2VxNmx1NHhYK3NH?=
 =?utf-8?B?MVJsajBqSUtzV05lSGZ1Z2tnSVNSajZ1M0xvejNQb2E2YTFOK1JkWXgzK2tx?=
 =?utf-8?B?WGljVVliTVNzRnFsR0cwbVJ5clJRSTUrbklzbUlKaGs5TkZ6aWhVRmVleG9R?=
 =?utf-8?B?bjA3WUp1Z1hzUHFXYlhKRUE1cUtZZnNlOUpZbm0zR2lQYm52ZjkrQko2aVRX?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uWhAjtF+Z6kjuqxdf97dIToYhZKuUHsGUi0ba7S4W+eZbk9FeZFcfcbEKuY4T1dmwFEQLiCaRbNQyh1W24rpHOjRjq4VZ7LGzNs/Z2dUHw9CEs0cRoWwakbAPLGbXkwg6lZpSOg7pCj/hEboLGLpbC9WnWsT+FImNFiW8x85sEtwWWJ7H4cJSWVf2Z1bASCtdHmQc1Aj6u5OFUk1JtbMVNuN7kttXLmJBr064e9hWkcRRKDgMbuGU7mjS710ok6b8Mz5CP6HGBFBkxuDjfIWFZxX0BCVkgOtTszjI6tofjovzoROhuVczfAeeuVlNJoC7VtNeN+ARhHIxcA5Hd9PbbPEK9h9CDsi2STDGOQmRWeJyWNgqc/e5s/mBSVcR7e/XDF5echd4PeFj0rgadAgf6ocqXAwbqxOnjr3rZU9djtTiTvjQeSGAcaX5ID8WPa2dirP03jbHlflU1eITlQ23D1kDQbxfC20KNhmeUOcXn5W8pZ602/TzLmWjyjkrldN0TzUJCl9XCR48bYeQrj5qi3sirKbqldF1F9p+o1wxruuWNCyjcf3+CEN3yky0N/ZMVdOlBgcAnQ5TdlyG4a3M4WS3afAvyyFm/ek1wiasu1gVk8v0irTMNy6uVepGwkgayOYmQQjxzWMneq9Trzb9DbLmgy/Nt5d3GDt6CQqkp3jWH+i7sN8uTQkrGbX2Wv+830LpApTGV6iG7t12GgKMLv/S+KZ0EodHhaOZYH1raiZWZNmysBmyPE8HC2jXqdFR9sBoDMTGhl0BRfRwK84qQO1UoIbKabh6kgYOcbaUw6gSR4vk5UjJrftzPCI2VejO+Gp2wtr8Du8yoeVP60WmuodMjUaSgBUc1NiGw2QNyWPBSlZyGgGhdCcUtjxg6QLdGjZt3oK5FKhv63EUHwNqt/Aga+MVAaM05Hghhyd1so=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e63a93f-a104-451f-f834-08db87aa6c73
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 16:17:04.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuRvA0NUiZBpu9eXz9kw4hTVYIqZFtCUATq3Gte6fm8GOV6SYAzloxBMilxXlKbJdd+Ljk2EGv9i0jhi2fFmpz3FpvaZfkI6HuSdLUbQl18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_12,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180149
X-Proofpoint-GUID: dLV94ydPZ5yXUiLXNDF7QY7LiXvUsaGc
X-Proofpoint-ORIG-GUID: dLV94ydPZ5yXUiLXNDF7QY7LiXvUsaGc
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



On 7/18/23 10:39AM, Andrew Kanner wrote:
> On Sat, Jul 01, 2023 at 05:05:42PM +0300, Andrew Kanner wrote:
>> Syzkaller reported the following issue:
>> ==================================================================
>> BUG: KASAN: double-free in slab_free mm/slub.c:3787 [inline]
>> BUG: KASAN: double-free in __kmem_cache_free+0x71/0x110 mm/slub.c:3800
>> Free of addr ffff888086408000 by task syz-executor.4/12750
>> [...]
>> Call Trace:
>>   <TASK>
>> [...]
>>   kasan_report_invalid_free+0xac/0xd0 mm/kasan/report.c:482
>>   ____kasan_slab_free+0xfb/0x120
>>   kasan_slab_free include/linux/kasan.h:177 [inline]
>>   slab_free_hook mm/slub.c:1781 [inline]
>>   slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1807
>>   slab_free mm/slub.c:3787 [inline]
>>   __kmem_cache_free+0x71/0x110 mm/slub.c:3800
>>   dbUnmount+0xf4/0x110 fs/jfs/jfs_dmap.c:264
>>   jfs_umount+0x248/0x3b0 fs/jfs/jfs_umount.c:87
>>   jfs_put_super+0x86/0x190 fs/jfs/super.c:194
>>   generic_shutdown_super+0x130/0x310 fs/super.c:492
>>   kill_block_super+0x79/0xd0 fs/super.c:1386
>>   deactivate_locked_super+0xa7/0xf0 fs/super.c:332
>>   cleanup_mnt+0x494/0x520 fs/namespace.c:1291
>>   task_work_run+0x243/0x300 kernel/task_work.c:179
>>   resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>>   exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
>>   exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
>>   __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>>   syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
>>   do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [...]
>>   </TASK>
>>
>> Allocated by task 13352:
>>   kasan_save_stack mm/kasan/common.c:45 [inline]
>>   kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
>>   ____kasan_kmalloc mm/kasan/common.c:371 [inline]
>>   __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
>>   kmalloc include/linux/slab.h:580 [inline]
>>   dbMount+0x54/0x980 fs/jfs/jfs_dmap.c:164
>>   jfs_mount+0x1dd/0x830 fs/jfs/jfs_mount.c:121
>>   jfs_fill_super+0x590/0xc50 fs/jfs/super.c:556
>>   mount_bdev+0x26c/0x3a0 fs/super.c:1359
>>   legacy_get_tree+0xea/0x180 fs/fs_context.c:610
>>   vfs_get_tree+0x88/0x270 fs/super.c:1489
>>   do_new_mount+0x289/0xad0 fs/namespace.c:3145
>>   do_mount fs/namespace.c:3488 [inline]
>>   __do_sys_mount fs/namespace.c:3697 [inline]
>>   __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Freed by task 13352:
>>   kasan_save_stack mm/kasan/common.c:45 [inline]
>>   kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
>>   kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:518
>>   ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
>>   kasan_slab_free include/linux/kasan.h:177 [inline]
>>   slab_free_hook mm/slub.c:1781 [inline]
>>   slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1807
>>   slab_free mm/slub.c:3787 [inline]
>>   __kmem_cache_free+0x71/0x110 mm/slub.c:3800
>>   dbUnmount+0xf4/0x110 fs/jfs/jfs_dmap.c:264
>>   jfs_mount_rw+0x545/0x740 fs/jfs/jfs_mount.c:247
>>   jfs_remount+0x3db/0x710 fs/jfs/super.c:454
>>   reconfigure_super+0x3bc/0x7b0 fs/super.c:935
>>   vfs_fsconfig_locked fs/fsopen.c:254 [inline]
>>   __do_sys_fsconfig fs/fsopen.c:439 [inline]
>>   __se_sys_fsconfig+0xad5/0x1060 fs/fsopen.c:314
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [...]
>>
>> JFS_SBI(ipbmap->i_sb)->bmap wasn't set to NULL after kfree() in
>> dbUnmount().
>>
>> Syzkaller uses faultinject to reproduce this KASAN double-free
>> warning. The issue is triggered if either diMount() or dbMount() fail
>> in jfs_remount(), since diUnmount() or dbUnmount() already happened in
>> such a case - they will do double-free on next execution: jfs_umount
>> or jfs_remount.
>>
>> Tested on both upstream and jfs-next by syzkaller.
>>
>> Reported-and-tested-by: syzbot+6a93efb725385bc4b2e9@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/000000000000471f2d05f1ce8bad@google.com/T/
>> Link: https://syzkaller.appspot.com/bug?extid=6a93efb725385bc4b2e9
>> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
>> ---
>>   fs/jfs/jfs_dmap.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
>> index a14a0f18a4c4..88afd108c2dd 100644
>> --- a/fs/jfs/jfs_dmap.c
>> +++ b/fs/jfs/jfs_dmap.c
>> @@ -269,6 +269,7 @@ int dbUnmount(struct inode *ipbmap, int mounterror)
>>   
>>   	/* free the memory for the in-memory bmap. */
>>   	kfree(bmp);
>> +	JFS_SBI(ipbmap->i_sb)->bmap = NULL;
>>   
>>   	return (0);
>>   }
>> -- 
>> 2.39.3
>>
> 
> Hi, Dave.
> Are there any objections?
> Or maybe suggestions on how to test both my patch and the patch from
> Liu Shixin (some corner cases)?

Sorry. I got behind. I'll try to catch up on these today (or very soon 
if something more urgent pops up).

Shaggy
