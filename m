Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F3A7D1EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 20:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjJUSU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 14:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUSU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 14:20:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FF4DF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 11:20:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39LHjiE3003260;
        Sat, 21 Oct 2023 18:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=scc5Su87cXDYjGDdQB3uOwmORsGwqc04OyE2nXrzmw8=;
 b=HDTCk2uC43SlCHG0lOvk2cjR44MyHleSRSCk1f06fohUiXCxCv2de1Kf8lohoiUYhYnL
 nNYYvDpdzwcs8zGqXmDtH9dxaTgV2+0psIlkeDrxiR0LIimnZ1smknwQd7eIP3Jw8vQ5
 duKoGkL+VuLpqiqlglD+xDoqVVdBQrFb8gTUdoq+EO63jZZ5iP4aLrActbVZK9Kv0MFY
 MxGXyGz7OEwcBFFvR7sGBlyY2FhEDsIIMq9pmwODMidTyS+D0RBN1PYJMC41jC1DnESk
 eGih0cg/FctU2DpXAooobpU4eZ6QybVVgC+J4GHWFWHHUMeP7jUVXmVFf7R2xF23waD2 WA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e30t1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Oct 2023 18:20:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39LD4pEr014025;
        Sat, 21 Oct 2023 18:20:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tvbffs6rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Oct 2023 18:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kav2n7E/dMLVaNTmc3oBQ7Tt7N1Oh6kc5QlZ51hhV5gb7YN7vJb/fD40aflTp2W+5Ycl69ZSR/kjHkjvP9XndEyet7ztGM3hKR+Q3rTaUit9I5ioXYrWXkW+hAKzN9inajX1EZILL5eKJjJ5G9JsyZAQ5yPZ5/mhfBSWmBPneVi40yA9+GQF0MrYGJKzPv87VTBuBG/+vIzLwk3ksGOc4Ry0bl9OIidmJinQhfLuZZN1Kbx1zG1rvp4NtueFYBruI4kUEVgeE3Zo7CKFW71WpmoVk2o+gV3Nab9na4Z0/wlxcXprXydVzMnDFOzf5nGVKkSdZAH5nW5JEFWtPX2TLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scc5Su87cXDYjGDdQB3uOwmORsGwqc04OyE2nXrzmw8=;
 b=cHP8jrPt5bVtsLE48LuScKFvCcA6kzSFmd3cfFglNxRluIjIDTsgmE/lyYFPQ9BIc/4peP1Z2dUJQCF4INYRfFOPZ8xTJl+hobXLDpB1FvuwLm9qSvfV8erWwWNLFBzrEmE77ZYoHZJa9Mswi6qj394AdswjrnXMxqNSrdkrJvLHmAdUV8o5ydT+YDFLNqkBy7DzNbWq65XlsINb72Cl+wOLZ1HIlOptKaEQeKtYfOGwR8lQIsdZpvzc9IL4O4kyEMMWhQcYSCRCeM70+VxyMO7YrEGL+hKA4fomaw0IB2UZ0nHlEDgR+D9Yi/dkpve/V9VurbKpmHR7qYLK4g6bFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scc5Su87cXDYjGDdQB3uOwmORsGwqc04OyE2nXrzmw8=;
 b=i/poub89ag1uiTfoz099fJUA/a1+iYdkprOO+2Zzxbzb/iJGWeP1iP8aa44onQdIdKyqYiFF1xjrntfEjmQDzvxUI9K3UANf+d0zkoXKi88PDcC//DuaXXW4AoXXrWb+6sT4WkvZ2UDU090ZCUOWVb22MRBYOAM8v1zQlHPvw3g=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH7PR10MB6336.namprd10.prod.outlook.com (2603:10b6:510:1b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sat, 21 Oct
 2023 18:20:18 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1b36:2f2c:93c7:f651]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1b36:2f2c:93c7:f651%3]) with mapi id 15.20.6907.025; Sat, 21 Oct 2023
 18:20:17 +0000
Message-ID: <cbebac71-0be6-ae66-02b3-243d0f8c39e8@oracle.com>
Date:   Sat, 21 Oct 2023 11:20:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v8 7/8] hugetlb: batch TLB flushes when freeing vmemmap
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231019023113.345257-1-mike.kravetz@oracle.com>
 <20231019023113.345257-8-mike.kravetz@oracle.com>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <20231019023113.345257-8-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0040.namprd17.prod.outlook.com
 (2603:10b6:a03:167::17) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|PH7PR10MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: c92ca7e3-9bda-466c-4f28-08dbd2626035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1AS2RH1W9jHjv+09dozqeZniGUTjkGJylCj6YGR8RACfhFpeHxIhw43/nUv3Jnq/dADl+Z2GOskYO6RQFV9Uzvjm7xFwt6ItdHhxNBkhZsQ28sKoWMQArt7MDA/hat3pTlsZ3je2SGZWTnD7qcS38DXsjhBkumceWvjjwEM+/Y+Y7Zce1IoYVK3u4EurOw1eYmru0ItNn/ejgy/HFWvh7yVJ2eY6R+35ZS5km/L+0RMwZI7yIYb8qSh0k0HypI1UbIt1DZo6h7fq/Nx0HVLTw+O13DXl8Z1Vi7b6bIg6ZzFbjNtPK9yfHkvhXMN8JDXC2scwE9hmJQjQMZEEFPkZV/rFlDcAhZhXgf3+NCtsYhecGGDhxiImKqG4ok1RG4Lt9nefAqLee1+/WFasD/anIYKG/L4YWAB4Bype4kEXSHyhq4jAOspHpFHya7SYTMmilLIObmye/NGXzQUmuf9jR0JWmjT103odIEPeKIy0a9j83yMBcxlAqLO6BZbJNV2sKms1Xs5arw5xvrc8ix4dJdIH2qTHqLkWnhF4HnTBN6P30VF1tAda6mFORlfvBcNv15CANgbiWrWvGBCP6ygT1g13sHk5sJC9MkPwOPe81IRL6787kktgJwJ5AxydLbUYYCcVQaDyunFjg26y+b4vbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(53546011)(2616005)(26005)(6512007)(6666004)(6506007)(31696002)(31686004)(38100700002)(86362001)(36756003)(6486002)(41300700001)(5660300002)(8936002)(8676002)(478600001)(44832011)(2906002)(66946007)(66556008)(66476007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUVZaUdvYm83aVgvRnBlV0ZCTzVPcWl6Q1RBZXFUcDVXNC8zay9GSTdySkY4?=
 =?utf-8?B?WWxYMFM1WWQ0bWs4MXJ6OXk5VkUrdzJKL0ZDTEZXWkNBOXZUVDRodmoxazRt?=
 =?utf-8?B?b2RzRmx6Wmd0S2FlUHNiQXNlcVBaNzljVnVkWWVNU3BuSEhHR240enZUZ3F6?=
 =?utf-8?B?Z2xVdEw1dzRwR2Y4TnM4K0pkOTdzSkxkQWVQaG53WExsbW9DMHdSNzNDUWtQ?=
 =?utf-8?B?dGJaK0RPV1pkcEphakJib0FlMWVBdDZsZjc5WEFoUlprNUs2SGwzMDdmVVR1?=
 =?utf-8?B?MGYxRFRGYnl5YkFFaENRTk41NUs1YmNmbEtzckFDa2R1WHN5VHV1MUJRNWU1?=
 =?utf-8?B?VkxKWkdSRVdNd0IxaXZUbUxTd1JUSXFjdHVxUnBCaHBXNTlzcWxJWnJEdGVx?=
 =?utf-8?B?TkY2YTlKSkVqMDBzSFFDL3hjOVlxZzZpTnh0VlBlNlRFZnZTMyt3OVBZVmhp?=
 =?utf-8?B?ZisrZjlNMzZ5Rm9hd0pzRXhpOFBXT3g4dWlwVVllcnBzN3dkL1VCSDVmWE9l?=
 =?utf-8?B?N0l0YlBib0ZFVmE1bVpiVVExV2NVeDA0U1V4cnBDYXo0L3RKRFBUL1lUNllZ?=
 =?utf-8?B?Rys0NmRsL0xIVWNDWHYzSnhFUi9ucjlpWTBtb0RKWjcvZXFxZlhQTzRsS0U3?=
 =?utf-8?B?SE04bUlpbWhRTlZyNVArMEhYb2EwUTR0eUZUeXJNMGx5cDBzYXY1REc5b1pu?=
 =?utf-8?B?dzFDNm1nVlMvaTRuNUNOczZaSDhZNzhXOVIvU2cxRzc0VmRtMUlXTncxdGtY?=
 =?utf-8?B?MHNJT1VzUDIzWWVrUlBtN2VVQldvMDBIZjJ1VUt0YktmUmF2ZFloNnM3aFhK?=
 =?utf-8?B?SEowcmtKb0ovV3JYQzQ1WnFPU001TVAxWkxaUkpoN1FTNjJuSmR4d2hwODcw?=
 =?utf-8?B?eEFjYTZYRFUrWTRucU9NZ0xyVjN5TXlpT2hiamlqZXJDVzBUNlBuUzVkVVNV?=
 =?utf-8?B?VjBDbi9zT2ZzanBaVHEwaXRqOHFBQmF0SXp4Y0lsUDJXb25YWHNSV1FXTFpQ?=
 =?utf-8?B?ejg3VTZqOWdHeVYrL1RWSjBobytyTnN2clJjTG9DVWJnRHlxdHdwYWJZNklG?=
 =?utf-8?B?ZHBkOHBOZ21tZEFtamNHVVJTZ3hGZnJUS2k2NXVOcUhpMzNJUHdyZWg4clJT?=
 =?utf-8?B?NjNkVFd0VHp5Tys3bkxST2M2cEROL0tybHE4NXV0SW8vZW9lRTUxZkdTelM1?=
 =?utf-8?B?bG1qWXhxZTQwa1FuZlZsbWFtUUZPbjhHTHpITkloSzZzaDRtUHdYYTZ5TEE5?=
 =?utf-8?B?VHdqaHBvL3AySTJDY25XQy9qbkRrK3dRS0JOSnc1N2NTSy9xaHRua25vYnAy?=
 =?utf-8?B?b2hjWmxWTXhyK1hLT3lZeXA0NE54L21PNTRXaUpnaHJUT2Zjb3JwSnh6S2Ro?=
 =?utf-8?B?MzcvNVY4VStwUTVBaGJONTgrd2pocDdVL0k2VzVHdTRwcUd3K2dJTjBnWHJV?=
 =?utf-8?B?dU5WTHJNMkhpelpsOW9la3dTMTlQRHpkNU5ld21tT0gvcWQrdlBla3pHYlFs?=
 =?utf-8?B?bVJrNE5EMFJRWUdvWGtERkZYMlpoeU5sTUwrSU93WFdKL2thb0F6RmMwTis1?=
 =?utf-8?B?OTEvSG5lR1dUZzhSQmhFN1NNRldTZmVEVEVhcFJPd3Z0VythR3pUcm9JQWhi?=
 =?utf-8?B?eEFCQllETmJtUS9LeFA3dWg5bm9YNGdqVDRDN2UzenFTM0NBaTJTVmQybGtC?=
 =?utf-8?B?SlQzV2lnd0tPYXcybVZESXptd052WDJOZjJiMWthNER6bE10YTd0ZnlNcjBV?=
 =?utf-8?B?WXdwZEpoQ0hDR1NRcnZBRGRPTUF5Q1paUGFYcGU3bUtXVFU2eEI0S0xta0xi?=
 =?utf-8?B?ZDdjd1JUK1FIc1R1K2R2ZDBVNWxlSDFWRVU2b0NDSnZ2cHIyMmFxbVJ0bkhw?=
 =?utf-8?B?Q1l6TU80bzNDeGh1MkxoakFwYk9naWhkaWV6dmRtc08zcUlYMzlkVlA2R2Rt?=
 =?utf-8?B?SnN3cHByeUxRbk5oVS83My9vZFhVU0NwTHc5cE9NWEVmZUJ6T2plOFFYTXRB?=
 =?utf-8?B?WWJTbkgySHh6YXY3S0tuTlFhRDdJTFhUSSsvbjNNN2ExdDd2bUNVZkV1SlRH?=
 =?utf-8?B?YkdmZlI1N1hUbHVCOUFvOUlmNTdrYjJsRHJMcUt6dHkxTUw2Wmg4bzR3Y0RR?=
 =?utf-8?Q?6ozqMttB3Y4XfM+FD8txPJqSu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FFdT+7tKVmIYhqTTKt79FR4G0klmmEB5IQ4fi4f/gZqyflSPTfkGTQH/CGGl8AC6qGrMvBXFD8zsT0M3AWycaQcsnGlRYWxQ1SaRWNjdf3pxglbrs1+QrZ14TsbwXeDu/hyREjV7HQulBrh/bOFaxrqkqqAh8uKXUwExlSNEK8dioY4kZtvsYUi6qCW7+IROd7fUGSF8f4mY33CU6FmDZYhacGCmCUAa9CELH15CuMPBfNxEKEh6YtdlpbimTxtuPKaIOMTzkzIPyAbDl8Gau8hRNDHr6N3TOfJdFtd3La3VQjK9IxtElB9/3tyHmFKdQdYIjHI5LHEM0GCwEmrX6yDoxGUR6OH8bABMbX9vnprBg80luCQh8gEWF+M4nOpLpTmFQ5WnNKQx1MSPHp28CAjebmEot/6AOsR3vRTskGgyd3ViC90Ti5fOs428ueGU+pl70BVQYT545eoD/S4yKXP1C7PxLwEEzjVTARz/Fawb0K9vkcFxlh3qG1bNK6BZAgBdYrMHf8t3V0ltkb2mInvBpZJG2uxmkdzIe89elZALM6DHgN/1rBGkcmqVxdtU0NVhYC9Qjf8qV1uVD0JfhVch9hLvRZOI1mDgaOaL5Aa7UbF/kkSVHfsq9EPbAMYdsMsx8D4rWl69J8qI5bMjOIr9OsF3GUFDBXhW91F8gZ1BSrmZyN0sU4xmSP5matUi/oQ8V550r19UwsJMwAp57c7jqHGxEyayHnpRar9FYLmm/cfRUItTJN2BsZR78bl1RgB1JKlrTLPdshu5GsJYIeKioxW23zY+x2f7z9kye8I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92ca7e3-9bda-466c-4f28-08dbd2626035
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 18:20:16.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouzhfzPAduHYNtU4nIqWaUA3DXt+Hv1OLamo7jXFOfA6U/vwk0kiKGb//7G6+cPTMjGsFE5hoyd0yRuDlG3imQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_11,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310210169
X-Proofpoint-GUID: 2RODblrgPABLdZkFt_xgTsXZwVmpcjrV
X-Proofpoint-ORIG-GUID: 2RODblrgPABLdZkFt_xgTsXZwVmpcjrV
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike,

On 10/18/2023 7:31 PM, Mike Kravetz wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> Now that a list of pages is deduplicated at once, the TLB
> flush can be batched for all vmemmap pages that got remapped.
> 
[..]

>   
> @@ -719,19 +737,28 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
>   
>   	list_for_each_entry(folio, folio_list, lru) {
>   		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
> -								&vmemmap_pages);
> +						&vmemmap_pages,
> +						VMEMMAP_REMAP_NO_TLB_FLUSH);
>   
>   		/*
>   		 * Pages to be freed may have been accumulated.  If we
>   		 * encounter an ENOMEM,  free what we have and try again.
> +		 * This can occur in the case that both spliting fails
> +		 * halfway and head page allocation also failed. In this
> +		 * case __hugetlb_vmemmap_optimize() would free memory
> +		 * allowing more vmemmap remaps to occur.
>   		 */
>   		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
> +			flush_tlb_all();
>   			free_vmemmap_page_list(&vmemmap_pages);
>   			INIT_LIST_HEAD(&vmemmap_pages);
> -			__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
> +			__hugetlb_vmemmap_optimize(h, &folio->page,
> +						&vmemmap_pages,
> +						VMEMMAP_REMAP_NO_TLB_FLUSH);
>   		}
>   	}
>   
> +	flush_tlb_all();

It seems that if folio_list is empty, we could spend a tlb flush here.
perhaps it's worth to check against empty list up front and return ?

thanks,
-jane

>   	free_vmemmap_page_list(&vmemmap_pages);
>   }
>   
