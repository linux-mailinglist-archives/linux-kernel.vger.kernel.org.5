Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87458805D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjLESOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLESOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:14:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F20AF;
        Tue,  5 Dec 2023 10:14:09 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5HNvuT008405;
        Tue, 5 Dec 2023 18:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=wg0yutLLrTI+E0QbRT9wFWqakZgboNiRyaCtqb4ooBo=;
 b=Q8AVHQ+c86U41z/Ltq0TchTen68Uzj4FK3u7+A3fdg/BZH3d6fPTgb6Dr8yzGok4UOiE
 HmW3MlEj6MQ8IR7O+pEb84tt0jyccNIFC210HMgzNwOu7BlVnO91VO6ycvF52G2GR6Rj
 nTgN30iULVgpp2Y6JwYzN2222iLL4UTXbPI3hDXcshN87jXzhD6jn35NY1s4Ob54M+3M
 ofQaHK31NpMWoWG8j+MR2WBG0e2qIawILaZYFJZn+2ZPC4TLaB7v9mesucR/ULRPCDIz
 vtxsQQM1Pd45NVgFXxuJS1KoX/vR68f1DgzkmapvnIOo7MajT3nUK432jTtS9ePlTEac +g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ut0qh1bt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 18:13:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5HGwQU018503;
        Tue, 5 Dec 2023 18:13:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu17v46k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 18:13:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6nNznNYO5QzREIqDRBRV5h62u6ZqW8vgN8haOvbhg6n5ohUtVBt5y/lWDPZ9L4EV2PtwsP4MphmLUvt/5WtslvkS/YYlE96x0OPBEPpMzst3TbnjW6t+Ia4KBJ6c+O+z1ohgIPxP1SHxF+0cCtV03t6r/WuYQFiJqt8hUB3qyLbI/GO3xKklFA40WMWGR/Lh/2H6gCRHSl7I2jLlO5p0WErCsEaNxp/BK9gn/0JxdKY1X5T1b+QNsC8Nx8y0yEvlmHFYDdjXDVfCvUfLuNsjD4lPIDDgMs9bxWp7xwDHH/D0rhXk/E/Nl0zRHUlfqIxvfBVaQzR4ZgBEqbanhQCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg0yutLLrTI+E0QbRT9wFWqakZgboNiRyaCtqb4ooBo=;
 b=Uj/aPF0maTRblF5YbW001jwqyf6tDnYVjRdaGmyD34qw4DsSV2ZMm2aGUXmaZPIDljx0xGXdZ6k7wqkGjVZuROOnBLej35sa13GQ+xGa8lQNugsndjf5g1tDUp5z5HE6hjXB1ZM8zLJX5CpH6LpynOwOBuoR0QqL6aBP5H7SzHACtdJ6CKSlcyZ6QlmXh+aNI9tlYm2AtPtL6tjrpIP28B9p7kNq6JJoFm7xJgPJIrhYf4ClYIsU+sl4yCAziq3cQMb1ddJx0GqAuJH3yax0SUhsv5mD4mD9qlb03PPdMFy7iLwe7vcjR6lOKDYYBHN4l3SX5ftznWG3YWFVI8uxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg0yutLLrTI+E0QbRT9wFWqakZgboNiRyaCtqb4ooBo=;
 b=neGPeJWVkfv0jtNjmPxT60WgyvouIX56pUXikkCHjK2ugj4poTaGN0sTRQdbDRw97gMlU+lFrShZfFFagx7vaIYxtd2n2Q5AsF4VEFRDOXma36Zby/2trnbzTMQBBqbITlkRB6iTsKR/1mquMMipYuwGOXemqpDMoJJBuFG/3Pk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7359.namprd10.prod.outlook.com (2603:10b6:208:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 18:13:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 18:13:39 +0000
Message-ID: <d2fc59e0-4aa0-46fa-aaef-1d5f707d988e@oracle.com>
Date:   Tue, 5 Dec 2023 18:13:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] scsi: libsas: Fix the failure of adding phy with
 zero-address to port
To:     yangxingui <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        chenxiang66@hisilicon.com, kangfenglong@huawei.com
References: <20231204122932.55741-1-yangxingui@huawei.com>
 <20231204122932.55741-4-yangxingui@huawei.com>
 <336b3084-dfae-4e91-ba31-7e08ba4e5591@oracle.com>
 <8742e128-3ac8-aa56-0596-037c38e05089@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8742e128-3ac8-aa56-0596-037c38e05089@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0021.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 151145d4-59b1-4eff-afee-08dbf5bde81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LenboCpI7VpSy4un7R73Tz/52lza2WSc0dTHJJfW6avfyOSbYUlhJoNMt82LoptdRN2AFwfYiNQ8wFxKiMcUMP4wAOdGaItWZU85cpD+hiGvgAmJevMnmUqkeiXPYyEw9E7OHhLliUOlexuLIfpgbIr48DSKEuElH3oHKrc6jcafQPWLKe4aFkAlD9zypCgupxuLQrJN9ImnuPoXGGkqWZEGmszMLwMM8tPhDR9oJRD4M1hccjltO5mdJ+5BLTEMbyRU5rTL1SkgAPOain1G1Kf1SPI6U/x8IE6bNHwq3rWupfUtevFYsuSKxsQHZ9uJTQ3EyADNXlUW/WwqFQTv9iD4cs8MCb3SK+fIFCYjnLXjwkhVEE2IegQrDUDuBeXmeMFZFRH8Xqqiv4ocHLzk5MfXOEYcI8//DhMLraOzsBAGMGHEw5qJRlKIOxt0Ebktwv1MBcGhEslP+x8YHe6dJaBJjmHEy2NecJurjawkLA8vi1DWzhr+Fhepsgq0UyZcwpwZOXlSkeITFbx6jdKAFtamK9I8zI3iKIciSc4LPfrUFdm9+pXurnZ42aN23mlQo3koKHJNEV5XysuNEr1nkANi1J30vGM8oTuKpZpYVSX9XdRHN0/uPFfFQhOwmTXIaWveSr01PlB9vBNtJda/ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31696002)(5660300002)(2906002)(7416002)(36756003)(86362001)(41300700001)(6506007)(478600001)(6486002)(6512007)(53546011)(38100700002)(36916002)(6666004)(83380400001)(26005)(2616005)(31686004)(8676002)(4326008)(8936002)(66946007)(66556008)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGpSeU9NcjhISnpNYjExK2k0M3VVckxLaHRCd3ljQ2lkWXlzU3Zkb2lYOFNi?=
 =?utf-8?B?T1dZY1FkemI3TDR1dHErVEVwc2FaWGJwbkxodXFjWUh2RUZTOGdxWTk5RVA2?=
 =?utf-8?B?anFDcWJZREE3M281S3lNS255b0dFbUVkQmZ6UVRVUDREbnI5MmswSVNjd3Vz?=
 =?utf-8?B?ZGJ5RGdDMEF2NEQ3UCs0dlNFTGNId1ZCQTBQWVZDd3NRTUhUbUhacmZRZXR5?=
 =?utf-8?B?dEhmL2pXaVVDSUNaRzh4aEJQUFJ3dDFDeUFMN216dUoyWW9Da3Y0MzI5OWky?=
 =?utf-8?B?TWVrUWpSWmVrYXZBd0VpdGRwYzBNMkpiL1g3eFduSFptVzJ3ODE4S0cxMlMw?=
 =?utf-8?B?YWMvTmNoV2pEUk44Rm9uS3lxSFdIdnIrUlowdnNVdENCU215M3lkNVUrelZy?=
 =?utf-8?B?Z09pOGx3Nlp3Y2I3cHhtWkx5dGFPT21KY1Z2WWs4U1FoN1Z4U3NKSGdsYXh3?=
 =?utf-8?B?NzVDNGtIb1hMRlJIbnBJcThFSFhwdU43NG4vZHNOTFl4Q1c1TkxXU0JzS1o3?=
 =?utf-8?B?c3JJTEtnZGxJUDhpOWx5eHI1aWNjMWxzRXd6bklDbWw0T1FzMTB1L09rMFBw?=
 =?utf-8?B?OG9NRXBIaHpUNGRrUVNmaVp4Sno3aTUxdmRtdFo4Y3BDMVBxZFRnVXlpS25a?=
 =?utf-8?B?T2hrSHFERlJFbVNjRXdxUGh1NklQTE9Oc0xjNFV5QmhkY2Y3Y3owUlVaMjlt?=
 =?utf-8?B?anpPRS9hRUpSNGduQnI3Y1I1UFlLNnhRR2swMnB4TGRqcXI0OUtuckpHWE1a?=
 =?utf-8?B?NHNhalVlSndDVDU0UDJibkRFc1lrUmwvYU80dExJUm8xVUhjYm50WVN0YjlS?=
 =?utf-8?B?eGpOWDdKblZzQS9KVnRqUk1hVmZjcStOdmxjeW5VZ0ZJYW5IQmtpQVlZSlla?=
 =?utf-8?B?bCtqZTJseDFKVGQvVlhTdjZMdmtFaGg4a2M4Z0ZhTmNZUWNpcDViMXhuN2JR?=
 =?utf-8?B?MGhZV3d0M0Z2SkVENGhRZCtmWk1wTG9ZZE9LRVAzZUlOSy9VaGpBQ0NrMFpY?=
 =?utf-8?B?aFJYUjRxaEk2UEJKZStJYXhZY2lKWFpJRTd3S3crTnlDOXVMbmNwSEk3YzY5?=
 =?utf-8?B?NVpTS1RNbjNPVDBnTlJsckZaUHJ0YjBYQlBDTlFTMjdreDRqb1UrOENxSno0?=
 =?utf-8?B?VjAyNjB0NFJZNXUyVDZubGJVMWZSOEZqTzFkVVkyZGJhT2lZWkY3SVIzQmdX?=
 =?utf-8?B?amJseVFXbGFsOHFmQ3Q5eC9pSk1DUG5LeU43MFFzZ3VZT2xtTzMwUk8yRm5F?=
 =?utf-8?B?azE5SnpCaHNiaFk4K0phL2ZIWjlTdWhESXlnaW5oaU1mSlhCR1FtVkV0ZEZS?=
 =?utf-8?B?cTRnQjJQT0M1d2NpTnREcm5EWnVnL2p0NEtjU3c1NnlSOW1OcytoRDA2bHI1?=
 =?utf-8?B?YnNEWUxuWlJHWmE1bjBHaVJkK2xKYk9XMmQrU214bmpjRitKR3hDa3VSYmcv?=
 =?utf-8?B?QmwwVG5pMEhGYXNsajBVNDJqZWRjUDA3eVVSOTBJUjhxVVBCNXpmOWU3ZHFi?=
 =?utf-8?B?WHY0SCsyZi9xaENuZGpQVDhuT2lCbExQcU1FUStyblQ2T2ZYbndIanFzUGZX?=
 =?utf-8?B?M1pZSnVMdVd2OU01Y0RWSnpJdFRtanZjWnRUdUk5OXFsTWxEQnZFaXBBek9P?=
 =?utf-8?B?SmYxUEJSQ1Q0TElXTG54RkM3WUdQWWloS09ZMEd4L2NISmEyUU9wYk5aOGQv?=
 =?utf-8?B?NkplYzFxWnBGY3psZE5lbUdFSEg5ZFB5RExBQld6a0NGS0VZU3pOWW9saExI?=
 =?utf-8?B?TW8xOUZ1TjFUTGp1UmV3WWRacmh4TE9rQy9ZWk42MUI2N051a20yQXkydlRO?=
 =?utf-8?B?MXBCRXlSQmRYc0FJV3JubmsvSWFvaHpEV3VkU0RBUm82Tk1oeVQ3ZXFET3Vy?=
 =?utf-8?B?ZXVyNVVDTmdMWmwwazROVDYwemZQc0ZVMGhxZFhEMWtGeXU2bXQyN3BiVTBy?=
 =?utf-8?B?eGh6MzU5cVFlNXhsbzdRVUhsSVdwSERNcjBnbDdDd3lDRzMzSzNNdHNPMjlm?=
 =?utf-8?B?WlVkQ2hvcnRnY0NBOVE0K0xOQXJyMjZsMWRCUlh5Tmx2eFNiS1RTblRDR0tY?=
 =?utf-8?B?TC9hbE5BQlBvZE5IRjkvWUNQTyt0Nk0zN1NEdUdMU2N5N2FnM1plUGZHbEo0?=
 =?utf-8?Q?8vKV4P4mBCnoZixR5p2v2aZ8J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 30UVuS1LyLcNnK2YLwbF1t18vhHlm8m6bnxZvyzCoRfIbnZiz/iX4edqtqBGQIAsM6oi0m+9TxqC8xciDRvodky0iwIhN8X0ShvvzeHQOMFFqg7Q75iYphN6bTy8df386LC8Az8q9/W18+s6DecR4xUdVBzpA23ggqk6rL0SMGZtYwOaePyDYHDXl8WsFYbAuvrNiCVW6YyX8oey/qmfgvfpvRqtB23sYi13qCqhrY54CReTmM4Vk2EoHHYsKnwGSbazFCueVrmwAHaxsZpIMmDtNmJ7uI2TI+q0sKFmaBnkRnO/zFj/mVxFEn5oamxBULg07C7wivFI67ZkL3MRF4KmzBBODqm9kTyqNp5cXTIiWoV6NtNgUUKFSZDSicxJAhrVraeY1nLf8AAvotnM2L1OBzogeTi3W9b3Hb2FgOU7eYlsMDukPzkA6OHTzm3zYWyfRRU7i4IoHP+oVGDGtjYQHrBkgXOmPub4YoWzLfzI3xWtXWAVFKbcwSfn23jSzO0ra+fdhNhwtyC80lXSWHRcD7pgmnl6shImLT0eMUHm0acde+4WyuZNzB+0MoLo0yKt9Cy4N1BNQiF8Arq9B/fyUSMPInHUQbzZnyzrtIs7ma50Qc274gGs/vtHeQ4rFVtwnnGPDi/FlRGc62liuM8sLZ4qaceZAr66LXvw7tNEaY8tGg37mkH6RY+XWYU2krfvc719JiNdgWUdsjSY7HxtzOHOARe6wa47L+tWVNmCTI67rEopQ8R6jMr09iLA9grZNfeIoc3ZO95f50XYb369yJy4Oaojov0jjbocP4U54P+IhoxaqUpsJcdK9F82KKPiGdeETUPhTmjQ60XqkHF77l/miSwrOSMCfzbENxS4VCvWqpdlI0GPq63g5pCyYsb6ZMFt/fuCMg96lNcFWIss1uXhkr9Xl0F4w1qpEd8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151145d4-59b1-4eff-afee-08dbf5bde81c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:13:39.7580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /S3UZOFB7auUoilY8SYOJhfG7NM4kp9KpsxUh7Z9n7NMmZtewF13TzxSmGEf22sRZPcGnBgftFHNc8VEVn6cDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_13,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050145
X-Proofpoint-ORIG-GUID: BGzLwTtJDyFVPd9j-aGT6xXcm-Ungjat
X-Proofpoint-GUID: BGzLwTtJDyFVPd9j-aGT6xXcm-Ungjat
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 13:22, yangxingui wrote:
> 
> On 2023/12/5 2:05, John Garry wrote:
>> On 04/12/2023 12:29, Xingui Yang wrote:
>>> When the expander device which attached many SATA disks is connected to
>>> the host, first disable and then enable the local phy. The following 
>>> BUG()
>>> will be triggered with a small probability:
>>>
>>> [562240.051046] sas: phy19 part of wide port with phy16
>>
>> Please use code from latest kernel. This again seems to be the old 
>> comment format.
> Ok.
>>
>>> [562240.051197] sas: ex 500e004aaaaaaa1f phy19:U:0 attached: 
>>> 0000000000000000 (no device)
>>
>> The log at 562240.051046 tells that phy19 formed a wideport with 
>> phy16, but then here we see that phy19 has attached SAS address 0. How 
>> did we form a wideport with a phy with sas address 0? Sorry if I asked 
>> this before, but I looked through the thread and it is not clear.
> Ok, the early address of phy19 is not 0, and forms a wide port with 
> phy16. But now phy19 has been unregistered and the sas address of phy19 
> is set to 0.

ok, so the old logs are simply misleading: "sas: phy19 part of wide port 
with phy16" implies that we have joined phy19 to a wideport with phy16.

Indeed, my change to that vague print is more than 4.5 years old now - 
see commit a5b38d3159.

Sorry to say, but that does not fill me full of confidence that the 
changes in this series are suitable for a mainline kernel. Please don't 
do that. Test against the very recent mainline kernel.

> 
>>
>>> [562240.051203] sas: done REVALIDATING DOMAIN on port 0, pid:435909, 
>>> res 0x0
>>> <...>
>>> [562240.062536] sas: ex 500e004aaaaaaa1f phy0 new device attached
>>> [562240.062616] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 
>>> 0000000000000000 (stp)
>>> [562240.062680]  port-7:7:0: trying to add phy phy-7:7:19 fails: it's 
>>> already part of another port
>>> [562240.085064] ------------[ cut here ]------------
>>> [562240.096612] kernel BUG at drivers/scsi/scsi_transport_sas.c:1083!
>>> [562240.109611] Internal error: Oops - BUG: 0 [#1] SMP
>>> [562240.343518] Process kworker/u256:3 (pid: 435909, stack limit = 
>>> 0x0000000003bcbebf)
>>> [562240.421714] Workqueue: 0000:b4:02.0_disco_q sas_revalidate_domain 
>>> [libsas]
>>> [562240.437173] pstate: 40c00009 (nZcv daif +PAN +UAO)
>>> [562240.450478] pc : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
>>> [562240.465283] lr : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
>>> [562240.479751] sp : ffff0000300cfa70
>>> [562240.674822] Call trace:
>>> [562240.682709]  sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
>>> [562240.694013]  sas_ex_get_linkrate.isra.5+0xcc/0x128 [libsas]
>>> [562240.704957]  sas_ex_discover_end_dev+0xfc/0x538 [libsas]
>>> [562240.715508]  sas_ex_discover_dev+0x3cc/0x4b8 [libsas]
>>> [562240.725634]  sas_ex_discover_devices+0x9c/0x1a8 [libsas]
>>> [562240.735855]  sas_ex_revalidate_domain+0x2f0/0x450 [libsas]
>>> [562240.746123]  sas_revalidate_domain+0x158/0x160 [libsas]
>>> [562240.756014]  process_one_work+0x1b4/0x448
>>> [562240.764548]  worker_thread+0x54/0x468
>>> [562240.772562]  kthread+0x134/0x138
>>> [562240.779989]  ret_from_fork+0x10/0x18
>>>
>>> What causes this problem:
>>> 1. For phy19, when the phy is attached and added to the parent wide 
>>> port,
>>> the path is:
>>> sas_rediscover()
>>>      ->sas_discover_new()
>>>          ->sas_ex_discover_devices()
>>>              ->sas_ex_discover_dev()
>>>                  -> sas_add_parent_port()
>>>
>>> ex_phy->port was not set and when it is removed from parent wide port 
>>> the
>>> path is:
>>> sas_rediscover()
>>>      ->sas_unregister_devs_sas_addr()
>>
>>
>> Sorry, but that is not a callpath. Maybe you condensed it. Please 
>> expand it.
> Ok.
>>
>>>
>>> Then the sas address of phy19 becomes 0, and since ex_phy->port is NULL,
>>> phy19 was not removed from the parent wide port's phy_list.
>>>
>>> 2. For phy0, it is connected to a new sata device and the path is:
>>> sas_rediscover()
>>>      ->sas_discover_new()->sas_ex_phy_discover()
>>>                              ->sas_ex_phy_discover_helper()
>>>                                  ->sas_set_ex_phy()
>>>                          ->sas_ex_discover_devices()
>>>                              ->sas_ex_discover_dev()
>>>                                  ->sas_ex_discover_end_dev()
>>>                                      ->sas_port_alloc() // Create 
>>> port-7:7:0
>>>                                      ->sas_ex_get_linkrate()
>>>                                          ->sas_port_add_phy()
>>>
>>> The type of the newly connected device is stp, but the linkrate is 5 
>>> which
>>> less than 1.5G, then the sas address is set to 0 in sas_set_ex_phy().
>>
>> I don't understand why we do anything when in this state. linkrate == 
>> 5 means phy reset in progress. Can we just bail out until the SATA phy 
>> is in a decent shape? I assume that when the SATA phy is in "up" state 
>> that we get a broadcast event and can re-evaluate.
> You are saying that we use a method similar to SAS_SATA_SPINUP_HOLD?

Maybe. Can we simply re-use SAS_SATA_SPINUP_HOLD handling? Is it suitable?

>>
>>> Subsequently, a new port port-7:7:0 was created and tried to add 
>>> phy19 with
>>> the same zero-address to this new port. However, phy19 still belongs to
>>> another port, then a BUG() was triggered in sas_ex_get_linkrate().
>>>
>>> Fix the problem as follows:
>>> 1. Use sas_port_add_ex_phy() instead of sas_port_add_phy() when 
>>> ex_phy is
>>> added to the parent port.
>>
>> this seems ok
>>
>>>
>>> 2. Set ex_dev->parent_port to NULL when the number of phy on the port
>>> becomes 0.
>>>
>>> 3. When phy->attached_dev_type != NO_DEVICE, do not set the zero address
>>> for phy->attached_sas_addr.
>>>
>>> Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
>>> Fixes: 7d1d86518118 ("[SCSI] libsas: fix false positive 'device 
>>> attached' conditions")
>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>> ---
>>>   drivers/scsi/libsas/sas_expander.c | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/scsi/libsas/sas_expander.c 
>>> b/drivers/scsi/libsas/sas_expander.c
>>> index 7aa968b85e1e..9152152d5e10 100644
>>> --- a/drivers/scsi/libsas/sas_expander.c
>>> +++ b/drivers/scsi/libsas/sas_expander.c
>>> @@ -45,7 +45,7 @@ static void sas_add_parent_port(struct 
>>> domain_device *dev, int phy_id)
>>>           BUG_ON(sas_port_add(ex->parent_port));
>>>           sas_port_mark_backlink(ex->parent_port);
>>>       }
>>> -    sas_port_add_phy(ex->parent_port, ex_phy->phy);
>>> +    sas_port_add_ex_phy(ex->parent_port, ex_phy);
>>>   }
>>>   /* ---------- SMP task management ---------- */
>>> @@ -261,8 +261,7 @@ static void sas_set_ex_phy(struct domain_device 
>>> *dev, int phy_id,
>>>       /* help some expanders that fail to zero sas_address in the 'no
>>>        * device' case
>>>        */
>>
>> Please pay attention to this comment. It seems that some expanders 
>> require us to explicitly zero the SAS address.
> Yes, we have reviewed this point, and its modification is for some 
> expanders to report that the sas address isn't zero in the "no device" 
> case. The current modification does not affect its original problem fix, 
> we just removed its linkrate judgment.

ok

>>
>>> -    if (phy->attached_dev_type == SAS_PHY_UNUSED ||
>>> -        phy->linkrate < SAS_LINK_RATE_1_5_GBPS)
>>> +    if (phy->attached_dev_type == SAS_PHY_UNUSED)
>>>           memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
>>>       else
>>>           memcpy(phy->attached_sas_addr, dr->attached_sas_addr, 
>>> SAS_ADDR_SIZE);
>>> @@ -1864,9 +1863,12 @@ static void 
>>> sas_unregister_devs_sas_addr(struct domain_device *parent,
>>>       if (phy->port) {
>>>           sas_port_delete_phy(phy->port, phy->phy);
>>>           sas_device_set_phy(found, phy->port);
>>> -        if (phy->port->num_phys == 0)
>>> +        if (phy->port->num_phys == 0) {
>>>               list_add_tail(&phy->port->del_list,
>>>                   &parent->port->sas_port_del_list);
>>> +            if (ex_dev->parent_port == phy->port)
>>> +                ex_dev->parent_port = NULL;
>>
>> This does not feel like the right place to do this. So the port which 
>> we queue to free is the ex_dev->parent_port, right?
> Yes, we found that if ex_dev->parent_port is not set to NULL, after the 
> port is released, if there is a new ex_phy connection, use-after-free 

Do you mean really a memory use-after-free, like which KASAN would report?


> problems will occur. And the current branch is to determine whether the 
> number of phys on the port is 0. I think it is more appropriate to set 
> parent_port. Do you have any better suggestions?

Let me check again...

>>
>> BTW, do you know why it's called ex_dev->parent_port and not 
>> ex_dev->port? I find the name parent_port confusing...
> It is the port connected to the upper-level device, so named  parent_port.

But isn't this just the sas_port for the expander device attachment to 
the host and more closely associated to the expander itself?

Thanks,
John

