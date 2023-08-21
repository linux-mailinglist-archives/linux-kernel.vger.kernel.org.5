Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A095782759
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjHUKqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjHUKqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:46:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B9EE4;
        Mon, 21 Aug 2023 03:46:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KNJb7L028774;
        Mon, 21 Aug 2023 10:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KyyM7yswYc81R6xTDSLn76NgBjNgwlYaSGbY23u3xCw=;
 b=E/6soF2EvpLzJZK9s1UnX/ONSD0S+t2dlr6rUdbBZgU4fqfM2HWxvkfc7xlMTouaUczP
 tjaYk5jzcBpSfN8MAeYQulBwtVXnnVow/GRaG1O7hhsRZNy+bW9eNgC58F012pAiwwCm
 PSSALRqlG0I97X8TiZUhtUXXWbIo6m6YTp+6qjlZKe08TpqNNw8u/tHyscz6bE9I8Kwx
 2jUB5f2LnrA1p7SZtyBE1EW9GIXCSwd7yJ/AwWn4uM8uM4D6LP+1900LtPUEgsajrSTS
 Nblndi1NJnX/EmkVCG2bSmIguyUK8PmQpZsSc9C5XiXFCWNKyBANU8DmOm2wZGL4mTYp 3Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnbttj21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 10:46:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37L8vH4f029893;
        Mon, 21 Aug 2023 10:46:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm69sgwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 10:46:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcBQ7tB8X/4RCdcrH8ilmdX/9ekhmAsiPrEMfC4AbIqAjyWQpTjoepnmw56ZQpQuc6i2Au5/2uEH6Zv59kkTVglKWfqZ4ATrg6MsEbM11a0JJL3NnQkgYWDprLp70tKFNp1MATlU+jOA1/b0Kyxaf5EbCngAWEYCiciyOdnUEnW4cTjaHP7FIn1w5rSwGbyHq1SpaBNvEk7RrrLGh5SrwIgW6hBe6R0oK6MVUrNMu2Vm84AXLDTRMxp7WDiTXuexmKM9bHYgQEQNupDwrboUGsAU7pHiY+H4upWVTQG4zQSWEC3afAdl4sko7J/AgcP3iRUV1xOkV1fLGQ8zw0GO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyyM7yswYc81R6xTDSLn76NgBjNgwlYaSGbY23u3xCw=;
 b=Se9ENt22GCRAU1itMG1FjZkp2rc7hTILcf+NIuIcBaWohPLcsHL/WCHKcvhqKw0jJ4UGnBaQbqNanhJ9RoN0wPdbR3Nhky4i7TzVLEEXZTZNzytY4b9VJAbXCG6iOS1YT7MSFMrvGAPMZvdWm6gRKzsuX0zg01I6tWu168ryjQA2dEg0c2KHe81sYI3Wj809updNZaFmGuY/PVO0xHePsKtp2za2nOlFAik6axz9CuKu0ghmqU48BsEQewjwNggdS8MLnYK0I+8c2+FjYVm6sBmDuFGCrV5YR6ewdeFp3arPh7A6RlTfdcOKXSZKAY66DJq+2yPJV4moplceDR3+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyyM7yswYc81R6xTDSLn76NgBjNgwlYaSGbY23u3xCw=;
 b=hL0AAnfSRcGb7FBQtbxBVGZ827IB9Uz9EZFX5amucnSSa0b1vuJpnzvITKxLaZRD1bG2JppwhuZJdjzxz2MVWNmdW6Pc9uEm4oMH1D688fIcNCDiehGxrBuyWYxkc+HxF9lAJ970KCzrrSBJwkWVKo3emtwu2l0uivosnU59TLk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6582.namprd10.prod.outlook.com (2603:10b6:303:229::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 10:46:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 10:46:25 +0000
Message-ID: <dd4bc3fe-5b8e-6e64-bcec-29263df43086@oracle.com>
Date:   Mon, 21 Aug 2023 11:46:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] perf jevents: Raise exception for no definition of a arch
 std event
To:     Ian Rogers <irogers@google.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230807111631.3033102-1-john.g.garry@oracle.com>
 <373e8253-656c-84dc-c05-b578e3725d@os.amperecomputing.com>
 <CAP-5=fVsePTVU2qeeUzVFkWA7Oxj6bgSq+yWzO=t3y283vOgOw@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fVsePTVU2qeeUzVFkWA7Oxj6bgSq+yWzO=t3y283vOgOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 7428330e-cc9e-4b51-d22c-08dba233ddeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UavG2kGhfCkcEn8fEt1XstnYkezX8ZvG7B9wDgu4Z1/Xi8bA/GktMmE9WFcRcOSIDNma2cVfVJCZVzBG1ndeo2V2i5e/+dTRfBN9VWEqHDLyPFDynBUhS3RI5EIvLxw1Ev56Lz2dK6ZjTuficYMNBFQ559HPXRCnjE1AcAe725BhJ04GB+MCGw7GZkN7Lp7mi15/AjgbnBUCJeSqd9v55FFg/esea/EQ7hSyJ1jhZ0Q/Nwr+ctCYAEIQrhNpTg5ercCm92E2eXsdxPNUD+Q4Z5gyQQr1uCUbIVF0pN8RLYeZNHx9BvZ8uZokS+7lMrdNCm0OzHrveGmv3S6n7JwWFZRpBVIAT2M6sFnZFkGKPVnBk8Sf18jfGKZpm+ELGjdf6sasT2yArA+WmryafeyV5lB5ak+8UGkXx8l5hfCPMnd6Jrtmakhjlz4pU9jZGuVjO0Y7bsgp3Wvxbz3/ErLTNNCAWYh2FrPpSQ6S+yFo/j4dz/a+129SVvP7b/qf8NlonPSQBThKIdNL20ddYi/MD5WDR8AUVA1Ll23Tsaki7qm3mTFysIcvi4MtmaQZC86PiTSOKdq+nzMYOZ57JaoappnoicaV0TNEjexdEjkxHSSutzdtEyZbZCuZCFU6F3V5KTdlao8Q4GkoT4SLCF1Hmy9oI+UHTMmRWAk+rQPoVTBgpj0xp0AjAbv2m5UOK9f4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(83380400001)(53546011)(38100700002)(36916002)(6506007)(6486002)(5660300002)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(66556008)(66476007)(110136005)(966005)(478600001)(6666004)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHBCaW9NMjFESHErTFl3aXhwR3FyR1FBQkNwamVFWE9FaTBYSHdGZ3FxbkEx?=
 =?utf-8?B?ODJrUTFXMFpMZi9yVnA1SWF3cld3emRoUUkyOW00SHFWM0xkMVM4amZZTTNt?=
 =?utf-8?B?Z3RidkJlbExqOE1yVjZkd1BDRE9XNXJJc3dsZlFIcUtuUkd5TWFpMVY3Q2xQ?=
 =?utf-8?B?SDg3eVVRSElGc1I2eElEY0Jyb2pFcHJNcDdKbXFuTkVxUGxHcnlxWFl4alRu?=
 =?utf-8?B?YjZDVFBuT1g0ckl0ZG4zc1VZb1EwSGRFZi90WGxzNDhUZ3FTb1B3YkhNMG9k?=
 =?utf-8?B?WFo0MGJSRWVqZW54Rm5lNzZ2K0krQXFNeW1PKzREWHVDcnZVSWlTMGljcFht?=
 =?utf-8?B?VEdwWGVZUzhmK3RTWWorSFNreDZJUE0yVEVBM1VUY09jekFFcFluWU1TOEFK?=
 =?utf-8?B?eGxnUGxZemlmVlFpRDlXRDQxMUd0TGFoRVNZN3NLUWZKRzRQcEpnSUo0aG9x?=
 =?utf-8?B?K3NBUFlSNEVXd1Ivc1ZrdGxHeUhNaVVmTzdjYzBPd3lIWGN4enNlK0lIVDBu?=
 =?utf-8?B?N09kT1BEVHoraUdET3A2UEFlV1k4Zk1DWFpoeUpuN2U1ZnZ2MHVDQjAwcDVO?=
 =?utf-8?B?eFhUQWZvOUQvMFJtTUlHanFpNTdlT0NvbDA0ZGtyVDBISWhLa2V5czF1WHFK?=
 =?utf-8?B?WUtINzIraGcrUVlYN1JoYXVYRU14SEU3bVNac3lDRnJ1UEVCelNneml1QzA5?=
 =?utf-8?B?aUtlazd4UFUxMDRYR0ljTnVsNkRKN2ZKWnlsMW1EVGxDeDdPdGp1bzU5U0xN?=
 =?utf-8?B?SEdvVWVDZjR2WTZ6aXo5THh0UUZlTHMvUUVob01DTGdROGxXRUxmRW1xVWhz?=
 =?utf-8?B?N0dQc1Nub2RkVXR3WXdKMU5DSmsxT0xIWGloSGZMLzYzZHF2MnpMV1hJalJn?=
 =?utf-8?B?Z2kvb1FYUUdhYlpqMU9hQ0IvdmhtQ3FlS1pVSEtVS2tDM2xQTW80WmlOQ3gw?=
 =?utf-8?B?cW4raDhEREV5VmQ5OW1ybkpYb0tYQnBQYW5FZTBUMGxUTDZjYTI5MjlEYkl6?=
 =?utf-8?B?TGo1SDNEMTN2L1BXMHFYaTlJNk15L28zYUlVQWFGb1RLTTJuNTZFcDlTb3Ey?=
 =?utf-8?B?VXU3OEo1WnZUei9ISFBhTG5PYUY2SXpzYVdNUG9IYzRuNVFqN3U3SGdJUldT?=
 =?utf-8?B?U3Jud3FWTno3cFU0V0ZCUEdpbjlNRFBlK1RlZDlYbHN1YzFlRjFJNVY4cTIr?=
 =?utf-8?B?N3l0MWpjMUZoenliNTRrclpiTmE1U3pMck5DaVYzaFYya2c2Q1IyTW5kRFA3?=
 =?utf-8?B?UzNqc09SMWorTDdidnBrZHlEWnVCRjcyNmJERFQ1S1lQandDR0plcXJXMVR5?=
 =?utf-8?B?V0c5NmpVU3hHY0psLzBZbWY4bjBZeXRXM3hnTUdNRmpuWklUNXVWS1ZCb0JV?=
 =?utf-8?B?QVZDMG9mNjdXWEI2ZDRoampVUjRER3M3SE5yVlJoSWVnZHZ1SDVueXpnUXRm?=
 =?utf-8?B?a0loUytkZjAvUXNtQm9mekxSM1kvL3FZbW9ldkl1MW1IZzhLQk91KzluYmU5?=
 =?utf-8?B?TVF6SlM1dkw5eDdHRGMrbDZLb3ROdWNCU3RUelJmSDZJVmVyZlh4cll6MHAz?=
 =?utf-8?B?UWl3K1FSMXgyMWRRZFlCNnplRzRqN1lRcGNRNEJUZk1pMDJoTDVsQkd1MWcv?=
 =?utf-8?B?MDl1Wk9ETlovb3lOZ1dhcStqZUpEZG1oTTdvVmkyODRqczFsWHRMK2orSVVV?=
 =?utf-8?B?aXhuZkpjQ29wVE5LSkFKNDZkYXpNZU41cGo5clJDRGJVTlAzOUY2Qnl4RWpH?=
 =?utf-8?B?SXJCRDExRzhsTDh0Skhnbjg5R01kdFlXbHhDeHEzckxYeW1zOTZ2dG5Qb1h1?=
 =?utf-8?B?SGo4b2dIV0V6OC96VXJpRUljMTA2cnp0YTdZN3B4RkFsWWptM1pTWEhWdTly?=
 =?utf-8?B?Y0szYTg0c3IwWVhIQ3V0MVQ2YnBLQmVDN2gwRXRwMm03S0pQbjFaNi81d0Qx?=
 =?utf-8?B?cUVMc3gyY09QT3dzc2FTZjZoa3VOc3M1eHhvZXdocmplZ242UVdCSmxxUmVo?=
 =?utf-8?B?Q1paOTd2SGt6a0VEVkhZbHFEbFV1SjBMeFBZbThycUh3TDV3M3U3cHM4d3VX?=
 =?utf-8?B?ZWJhSWMxWXFIR0ROZ3kyVEV3OXU2OVhPbXp1Qms5Wjl6d3VySlRzaDRZT2I4?=
 =?utf-8?Q?9Ipf8SvKbQR381Ey7GD5kjCUM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IXUq4skkdIbLqyJJtJUM6Rss0mrjSbOhYzHjYbpTJb+o+ofMINMTFGUJWZ/6BhtkRG0gwyoHVy/NzVQi6eopA6mNFfpIwtnnCIdhvSudd2EvNvNGuAV6PxVPXX67cPSqFB0flsKFwQEZzqTfVryChFKswdyKIb7tnU7zPcAaoyHvB/zeWFZ4ZginYx7pg07s2RJC7SnFkw1dNPjgGB/KsdO1/VTWJreqOcynh+9+Xui5fXYBiqsw/Aa2x5R5N8eea/OL78Rr+VGVpBL0jo8dq/1BB7IyvHfjj/H0a19mqA8CbywAbfdkn58jBKKANgkUCQKZITF5JQ0T6HCz9iksm1YU90RA4ZijU55pi25xIFdNBbzvHKan1eRejyvSsrAA7RS5PMwb/ExDkK3NNQkfNgV44EQWeeABAgDV2rYWrXSnjkh9jvPuuyPh1W4YnB+HhJ0BS+2swTpUQSStpMorx/CJwa6QOPeu1lyaTyu2FqN1VQIvFIPKiVA0/+OgrjWdCpgALJkLP/lCfo66SBQ5zHQ03vnVVyz5z+E3/qGmyYe76M64FwRPBum0ycTHTzlYcWzTZ2NhLqvkPMkj9ZS2F3+msFSmWKJBSSpUDOJiPIL+L/+OMhcsObIlAyCtM6n5wPqWOfOB2JheMYTYJMwk6Jy8cGx0OOL1Ade+OzQWLftJdi4XKVRcJ0uP+9hJ4ukK4wUir/SxrpbFJcqUOxOzqHoyOdEG55rQMknIFhrMfikeCYRnP70EmiVGG5xmwQFZLwMLid3+EPrL+yt9MQiHtqI9dK36BW5z/eFUNGPc5Env8P3/UOceVvrobrE3nxOelciDluY5ud6Uz2+U1nzSpFb2N1+HrNFbQbQ528OMW5hpHw4DTsurhMmPXY4V5yi1
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7428330e-cc9e-4b51-d22c-08dba233ddeb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:46:25.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CkzsAKRVR+enHQl+cHlzqtH7oYX1JLhV7JbPq+GGK13BOWDdlEqJeP1up7V9vdaKJEPY3t8EO4xa6u1CuEAeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210099
X-Proofpoint-GUID: c8qJjOU8XmSD5iVD6fIAU2Pa17gK-i9O
X-Proofpoint-ORIG-GUID: c8qJjOU8XmSD5iVD6fIAU2Pa17gK-i9O
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 20:27, Ian Rogers wrote:
> On Wed, Aug 9, 2023 at 10:11 PM Ilkka Koskinen
> <ilkka@os.amperecomputing.com> wrote:
>>
>>
>> Hi John,
>>
>> On Mon, 7 Aug 2023, John Garry wrote:
>>> Recently Ilkka reported that the JSONs for the AmpereOne arm64-based
>>> platform included a dud event which referenced a non-existent arch std
>>> event [0].
>>
>> I wish I had found the bug in my patch a long time ago but, in fact, it
>> was Dave Kleikamp who initially pointed it out to me and figured out the
>> difference between jevents.c and jevents.py when porting the patch to 5.15
>> kernel.
>>
>> https://urldefense.com/v3/__http://lists.infradead.org/pipermail/linux-arm-kernel/2023-June/844874.html__;!!ACWV5N9M2RV99hQ!It9EhKK4s2uBUJyQvLg-ruUfENAA6Sw7TWVo_hF8XmFoQ6q565iYafTnN-yoBNh3EQ1IFa2tHknUjNHs5dI$
>>
>>>
>>> Previously in the times of jevents.c, we would raise an exception for this.
>>>
>>> This is still invalid, even though the current code just ignores such an
>>> event.
>>>
>>> Re-introduce code to raise an exception for when no definition exists to
>>> help catch as many invalid JSONs as possible.
>>>
>>> [0] https://urldefense.com/v3/__https://lore.kernel.org/linux-perf-users/9e851e2a-26c7-ba78-cb20-be4337b2916a@oracle.com/__;!!ACWV5N9M2RV99hQ!It9EhKK4s2uBUJyQvLg-ruUfENAA6Sw7TWVo_hF8XmFoQ6q565iYafTnN-yoBNh3EQ1IFa2tHknU_t28TiE$
>>>
>>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>>
>> Thanks for the patch! I quickly tested it and it worked as expected. Just
>> in case this is needed:
>>
>> Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Hi Arnaldo,

Can you consider applying this patch along with 
https://lore.kernel.org/linux-perf-users/CAP-5=fX2uE=B_Vb90nn5EV0mw+AJBpjDecP9w29OUn=j7HKPPg@mail.gmail.com/

I think that we should expect another version of that series with 
changes elsewhere.

Thanks,
John

> 
> Thanks,
> Ian
> 
>> Cheers, Ilkka
>>
>>> ---
>>> Please do not apply before [0], above.
>>>
>>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>>> index 8cd561aa606a..98cccc3fcbbd 100755
>>> --- a/tools/perf/pmu-events/jevents.py
>>> +++ b/tools/perf/pmu-events/jevents.py
>>> @@ -347,12 +347,15 @@ class JsonEvent:
>>>        if self.desc and not self.desc.endswith('. '):
>>>          self.desc += '. '
>>>        self.desc = (self.desc if self.desc else '') + ('Unit: ' + self.pmu + ' ')
>>> -    if arch_std and arch_std.lower() in _arch_std_events:
>>> -      event = _arch_std_events[arch_std.lower()].event
>>> -      # Copy from the architecture standard event to self for undefined fields.
>>> -      for attr, value in _arch_std_events[arch_std.lower()].__dict__.items():
>>> -        if hasattr(self, attr) and not getattr(self, attr):
>>> -          setattr(self, attr, value)
>>> +    if arch_std:
>>> +      if arch_std.lower() in _arch_std_events:
>>> +        event = _arch_std_events[arch_std.lower()].event
>>> +        # Copy from the architecture standard event to self for undefined fields.
>>> +        for attr, value in _arch_std_events[arch_std.lower()].__dict__.items():
>>> +          if hasattr(self, attr) and not getattr(self, attr):
>>> +            setattr(self, attr, value)
>>> +      else:
>>> +        raise argparse.ArgumentTypeError('Cannot find arch std event:', arch_std)
>>>
>>>      self.event = real_event(self.name, event)
>>>
>>> --
>>> 2.35.3
>>>
>>>

