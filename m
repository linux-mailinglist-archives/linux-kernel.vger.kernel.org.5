Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FF676D752
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjHBS5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjHBS5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:57:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D07CC3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:57:42 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372HJ7fh009355;
        Wed, 2 Aug 2023 18:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UEtdnVsxy+ikkjByO/gkZiKE1KvjbFWBawdvnlleMGE=;
 b=NuWpDFZsiUNAumuC75W6LLG8D/eR7ZHHNLu39z3r6dCzzujQ7puwcIYc+S1WPSVR1JFf
 nUCSSEnQsf3KMMFGhTdTaAESPo4Cv98S8U92ByUgl3azHHsdXrBizUSIRPJAFqLUKo+b
 50W1xALFLnvUXM+FKEJma/FCNy+ZKIfuvY1kJracoenoqYC9b9yCMESSgQQKdyBswTgF
 1Ktul6b5T/ct16lv6clYZLTaSb5B2vXwR9xkvYBAa2eO1Ic/eGKkS/66syyI+TgeweZa
 L1tk5dZr6MR/vB/CTJy+lUYohIyE2I1VgY/6OLP6/C+J/XaqIOIx9m4tgIYAVAFOjUgz zQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc839u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 18:56:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372Iixod015769;
        Wed, 2 Aug 2023 18:56:51 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s78jk7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 18:56:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyW5c7YXC0mFK/Gp3UbgaqazBLRRZp1rLXdjq4nvWM5OhXzYx+OtBK5ma/uGHXSAe+OZx3INwr0YqrJHmAfn3rT2t17J5PyOOxBvvEt99xGUrupuueIsbrr2d2R3WdzZwPINlBDa5Jx4v+MINtPAULCQbc7FDiwpklWeijI7VreP+oSNqLUWU6yXkLeFZzJ5iPf3gDtQdxA0xlOUW8duyK/FUpa0C8Ixy13YEESTwcWqvxuVFALPaZgM+NjGK/oqepWc72rG5CSH6mP3F4jVFc2ndWRQwLt0pqElqeuj1MK6xlYbKsK/POThYvMUyAvDg1EFkWLjL79oHa205/V8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEtdnVsxy+ikkjByO/gkZiKE1KvjbFWBawdvnlleMGE=;
 b=md1LgvDEm3V3BnIpz8pc0vZYaL66SJcGPZMt/FbXx0Ra0IvJkzSzhrFOkBhl6G86AchdkK4HkDgGTfvFdRcKW66Os9h/9U0BeT7ESdKRpYL//ThhlHnVoiV3RpgWCjOULBlZHI2rvYwlnycDtD+lPpVYTl7k8phqIjq0a47NY519vUJWX35tPmqnfgb3xNVOv7R+cOyFz9mlofHEpV0eetFVV5T56t+svlgP9BmsQjz4dNvxn4DJ5pE6aN61x8SCBVB+G8B3zgg1wzQKR9QawUyjTCP4SDZLeFl2TWsDCQ2crIksW3OV6qLZDRAkCMq5fRXaXe/o+6Lo4xRpHPhx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEtdnVsxy+ikkjByO/gkZiKE1KvjbFWBawdvnlleMGE=;
 b=NRF0cJB/6FOYMyyLwltiN7LwtoGhzrAb8RfkQEBfJFdLVNm6W593QoZs71gwxQSVWV7d8QGwJ93JwNFhZL1n6Vw0dmKt0cr/IfpNDqY/3/KNYdP94Duco++L6X1R3FPpmgLpRjIyV7RN0+Ujw1Yji3UAfoFC1LfdMehdHK3vGVU=
Received: from CH0PR10MB5020.namprd10.prod.outlook.com (2603:10b6:610:c0::22)
 by CO6PR10MB5585.namprd10.prod.outlook.com (2603:10b6:303:144::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Wed, 2 Aug
 2023 18:56:49 +0000
Received: from CH0PR10MB5020.namprd10.prod.outlook.com
 ([fe80::847f:ef72:f382:87f2]) by CH0PR10MB5020.namprd10.prod.outlook.com
 ([fe80::847f:ef72:f382:87f2%7]) with mapi id 15.20.6652.019; Wed, 2 Aug 2023
 18:56:49 +0000
Message-ID: <ec32cde5-68cb-8492-024f-002211fbf871@oracle.com>
Date:   Wed, 2 Aug 2023 14:56:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: [PATCH v1] xen: remove a confusing comment on auto-translated
 guest I/O
Content-Language: en-US
To:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "moderated list:XEN HYPERVISOR X86" <xen-devel@lists.xenproject.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
References: <20230802163151.1486-1-petrtesarik@huaweicloud.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20230802163151.1486-1-petrtesarik@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:806:d0::18) To CH0PR10MB5020.namprd10.prod.outlook.com
 (2603:10b6:610:c0::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5020:EE_|CO6PR10MB5585:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d65094-5bde-4a50-e46e-08db938a39d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVoc2OEZ2FV+CoL10csXoRVghcz2kKQeXm+n/hDcgWMItq8aKV19Vb5JG2wYDvoOHznCOEKvaYcR3xqq3EGFN9roDlvxGgm74O0UlbUpSTO8PXSS5UF1fnJQwzj9iiMUUuYBCaYVheupbi664dRulTnxjaH0Slbt+jv0DkzOLDZDRwiUJf9EF1Fv1qzUmJFjf3xyaDZ+tToAdkrwVIfMRIse2plOx3C4wVYzolE2jLtwUWP+fWr90bwheLjmntPg1LYQ2C4MlPL8blvNVJNr/PXIRan9UsVytPdAWSVxfv38WCt25CKOrUFbsEgb7gtBghRjMyQD1p9VVN19EVQp9Hilupatu2ZeFYTmaSdmhyPCL/6nxwJYCtSwWVkc45k1YouJlAiAKFF+bPRGgi1o2Gwl9acAG5T0gvGmTts5fQJkIEW0YOLpUkIdGSNFHbnWvkoxbHroMUpg1720Ud9ocILvHu5T+hUS7R1xXu9yC/q+kprUhMOXZKWn5W4BEMcW9aLCX6NrG1V9MQ2n+Wvq/9PQM93051jeAdXFIbB6Lr0XsLfo5Fj9ees3StZZdEknVW3Kt2wDYutXinb9eUy81YeXRX0hPStVRDxyNU/CWoTnXmfmnR4z8LVPj1PaXPfqrSzbN3gHISxAuB+MWi+eShkm+DYViHyOdAI+IW8kM1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5020.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(44832011)(6512007)(6486002)(36756003)(53546011)(2616005)(186003)(6506007)(26005)(66946007)(921005)(38100700002)(7416002)(110136005)(4326008)(316002)(31696002)(86362001)(66476007)(41300700001)(8936002)(8676002)(5660300002)(31686004)(2906002)(66556008)(6666004)(478600001)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWVEYm8ySXNOU0RqckM1cWJYVnVlbWhjODF2M0J4VXdqV3RnU2RKMkxhNFgw?=
 =?utf-8?B?YmxUM2daSVdGV2tXQXNCdzc4dThTVnM3bFROSGJlRmxlMWZtM3lubG8wSjRx?=
 =?utf-8?B?cUdJL3NKaTk4czZBa0UyaE1YY2NEU0NMUklGcWRxZGk3SHZPQVFjS2Jac1V5?=
 =?utf-8?B?NGQxNG9qT0xMbS9vZkxxbUpMakpjWnNUYWJtL293cmxvOUdKa0t1b2gyK0l5?=
 =?utf-8?B?Z2JXNkUxSUtzaUY1bENTKzdMR1p6a0VJbHJLK3p2am85SzY0bzQyUy9MRXJh?=
 =?utf-8?B?WE5obDhLc1QvZjVFd25DdW1RRHZlaHYvMTZzN2I2ZHAyNHJlZDRwQk85RnJ6?=
 =?utf-8?B?d1NVLzhpa293bUlGQ0FvKzllWHA4UC9xWitxTit3VUxKTHU1eVVCMHdNNk1K?=
 =?utf-8?B?Y0RreTg4eEhiaEVpWGNSd2ZFaU1SeFdNOHhrd0FDSmFoaTdaL2tUR1FoMFVs?=
 =?utf-8?B?WkZYdk11SHRFSlkvVGhUb1JIc3BhRlNXNVhxTXhWbnlQclVPN1pmbVZrN1Jp?=
 =?utf-8?B?ci81MWpjbmFMcDVxbzFtNkw0cHJyOFY4T2FuUklSYjdpSlZsYzM1N2NEL3ZI?=
 =?utf-8?B?SVdhZTlCTzFNbEp3RUtiWmtkZCtRUE43ZUxlV1UzN0hNd0F6R1BRZ1ZpRGhs?=
 =?utf-8?B?K0NMNCt3TlUvbWE0OFVHS0V2VTlHeWlZaVVYMllITkxUNW5qRWV1QVhhYUkw?=
 =?utf-8?B?eVVDZFhJOWdVUEF2SFd4SjdJTm9lMzRaN085ejZTL3pRSGJqRlNVVDkrS0Fl?=
 =?utf-8?B?dWllQ0F6dGFkWjI2YmMrSGpFcWtiS1hxUlVSNHRLZjlkUUhPVGhZQnVocXpk?=
 =?utf-8?B?U3MvNlZuQ0hZS1ZKVDlXS2FoVEJ6N0lPNERhRmgzLzRFOTJ6V25zZ0IrVHNV?=
 =?utf-8?B?TDROS3dSSW9JV0ZxQjVoYjlqVHMrVHJxSXU1M3NaVWZYK3FvbDdDS3dDUXls?=
 =?utf-8?B?ZU9ETmpmTjRzajE4SXFGTXhYaXBTamllbisvR1o1QlBha2hLMGhwdW40b3hw?=
 =?utf-8?B?dzhQQStwdHFnVmZ3SGoyZDlMdVllZTN3QmE1M050MGlVVDMxdjhDc1R1TVdm?=
 =?utf-8?B?eTNQNmRvS3hUZnY4NXdFRTZ5Nk1QQVJuOUd3RlFEYy95RVRoTVR6TWRNTWZR?=
 =?utf-8?B?WDV4clJOeUFNQlQ4SjJ5RXFrVFpwVGhlcTNHMng2djZIZ1BXVTE3SkFJeCt1?=
 =?utf-8?B?MVN6UnFtUm9kYk5zbEZ1ZTBEUVhmeEc4cHl6U2V1ZXdLTS8vK09jOENsSTRV?=
 =?utf-8?B?TUp3YjAwTWVnOUlKU1ZaYmdhSGt3Q2xHKzA0THJsUU50M0RUdDNsSXNrOWEr?=
 =?utf-8?B?TEVCZlJzVXRaL2twTkxuNSs0b2l0dThWWUwrSzBBVkcvRzgxSGNtcGE1RTVa?=
 =?utf-8?B?ZlR6b1ZSN3F5OEVyZUhRbEplZDVaK01WcGtOZE80ekFoMVp6dHJ2ZEhuSDUx?=
 =?utf-8?B?azVNeTIrcmo4VHZnWFU3N1FmNGtyV0E0Ty83Vkk4Sy94V0lvVFhPc0pyMlc3?=
 =?utf-8?B?WCtmSUlmZm0rOW80NGVXYmRmdnoyaHZCNWlJcWxuV28wRk5jT1M5YndDczdI?=
 =?utf-8?B?OFl6MGJMY0tRbHhOUzAxQzZ4bTRiNTNnOXRwZHgyTHFyNExwK1ZvRFBjVzJS?=
 =?utf-8?B?bnpxbmY2VEk2aVpZK1ExNmN2dHNDUW5MdkJadmNjekg4NlFVajB3RklYWTFl?=
 =?utf-8?B?Tm52SDRpRVFVaW5aalR2NjRhWmhYRms4RHVqa0ZDZ1FPanluQUN1aFRYVkVO?=
 =?utf-8?B?dmVBWkNXcUNLODhNMkNPNndyNHRQdFpKY2xhbzkrMnlNbTJZTWlnaGhrYTBy?=
 =?utf-8?B?Y01HaXhPVSt6T1d0UGtGYWFVNUE1R05DYU5XMTIzZ3MzV0VXWVBxQmtBbE1Z?=
 =?utf-8?B?TnFSSUFMQzZOZjJpaVZxK3B0V3BCY3Z1cWw3V0p5U0E0ZjBuaUtST1VhMmFn?=
 =?utf-8?B?Q1crU3NhUkFFdEh5aitwZ2NwaDRScDY5Q2NKai90MHRTSFJqV0w2VG9yYVlo?=
 =?utf-8?B?dit1d290MDVIY0svaytiY1lEVTRsQjFqRUNMeldpa1BiMVdDR3RHa1E1RFlE?=
 =?utf-8?B?d2lmdUFac0tZTytaajZiQWFQWnNqQk9vK3pyaG45TUtZa1N5dkVJQXRPdnU4?=
 =?utf-8?B?MDVvZHFCak9aM1ZmdnV2Vms3ckFuYjEzMEh0TzIvS25nemhFR1lLdUlhZWVW?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YUppOHhiL3owaGdIWlpxTzlJc0hYVnVmOTR0Y0xiclUyaVk2akNjSHNlaDVt?=
 =?utf-8?B?Rlk2SVowbkZYdnNFWW5GU2lSOHk1OU9lM3ErK0RYaWU5SHNhLytSeGJzNkxk?=
 =?utf-8?B?VEhCL1J6SXZDckdwVVdsb09pVGNpOTV6YWFQNHBhNHhkdUpobzYrRzFaRHZ6?=
 =?utf-8?B?bzdySEtPS0gweEh2dEZydjFKSjBWWmIzVzdFTXFzTlg2Sys4dWtBTkViNWEy?=
 =?utf-8?B?SGs5aWFMTlY3elpmOTFJTGlvZU53dmdmcmNkcU4wWndyMkZkd1BNSFU5aFBL?=
 =?utf-8?B?R1E4aDZqdHl2NHdTaHFBVGlWdUxsNGkzQW9kdEZWbUdTYWdwU002TWNiajdE?=
 =?utf-8?B?NlZPWGRQYlJCaGdvYTkvdlQwVEY3NG4rTUw3anh2UWpvUHcwcEFTV2NLVzgr?=
 =?utf-8?B?WkFvREFGdHhsamw1ZGdzaUJLVzZVV2xxRUJoWFdGR29JSEt4OWZTZnpHSy9h?=
 =?utf-8?B?WjZqVjAzcC9UOU9OY0d5d2p1bjlGMFd6cC91NFpjVC90UEdTckNCT2RjYk1P?=
 =?utf-8?B?UTdiVGpSSU51blRHa3kwQVVvbk84bjRxcjBzQ2lINmFOUDRXSnVxSUpQSTU2?=
 =?utf-8?B?c2FHbk9GOUh5REVkR3hRR2xZTDl3VkY4TldSOGVDcUY0UjUyamZ0RUIzQWFB?=
 =?utf-8?B?R0xLS1dvQ3l6NTJsTkhmV2E0Qlk3eU1LNW1zU3hQd0dkTWVOc2doQzJhbExs?=
 =?utf-8?B?UThvZG90ZUhKWnFJenV0ckpKdGdLY3NKRkhhOW1ENjI1eGxrL3BxaWhMb0ZI?=
 =?utf-8?B?ckp5REMzL09TZGR4Z2NGSEZRT0hGMUN5OFl4RnNHS1JtMklUcnFXY0RxbklD?=
 =?utf-8?B?SVpneHFXTFB1cE5oSm1lS1lRdmlBNkZzdVZ6T0QrN1VqaGM4S21HeCtzeWxR?=
 =?utf-8?B?aW9YeEJhRm44Zm80OUIyV1VoZlRFY2g3S1JPK3FxeHFZNWlHN25DcWVzUGxp?=
 =?utf-8?B?TjlvUXNBNGpRdk5MRmt6MDIrV2R6Rm1SamV0QTBPdm9EOGlrVWlYMk1GVjFh?=
 =?utf-8?B?RXphY3lTQlA5N3FkWnlzRk1sS0pnKzVoUXhkekZuaTRIdUIxdGgrdEh0WFZx?=
 =?utf-8?B?NUdFOVUzZnJVNGFnbFVyQ0pHWmFTa080bjA3WDVTQXJ5T3RydHJDejJueTBO?=
 =?utf-8?B?MHhQVDA3dVdwZFNLaHpDZDdDS3d6OXIwRHl5QUNJQ25tOTNOa0V3QlBiaTg0?=
 =?utf-8?B?U1NxSVg2R0FIM2xuRGxKVlhydzZxMXdmaTBrMHk4Qi9HTGlNZ3R4VmRTVCtW?=
 =?utf-8?B?Z0N4bk9rbGcyVGpib2RkeTZRTmNxL0JmOUdvNkNrWkdyU2N0TVNKRGpTbWNX?=
 =?utf-8?B?N0YyVVNDUkhpekd0SGRmZU4xczBqK21HMDVrZi9DaVNCZW15NXFBdXBiNUtr?=
 =?utf-8?B?eDZkZkNtOWZVOURKR0lFN2NPRUtxWW5oeStUaXhld0lodmswVzIxSTkxWjRo?=
 =?utf-8?B?a1JGL1lkdEhMcjU2SWJ3bnBFWDhHWVUreTN3emxMWXRYZjRTRzJaYzVET1NR?=
 =?utf-8?Q?vKopuA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d65094-5bde-4a50-e46e-08db938a39d2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5020.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 18:56:48.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07zrAWeLSrUhF94OECeIr04eE9i2SdqcTmxooiPEFXXDI6ZHj5v3WeS3BeF7jVnj81IzuTeKdR+G0Y7PgCQys7MH0AWOqW7x0oBC0YDvVYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_15,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020167
X-Proofpoint-ORIG-GUID: k5QIQZ3bJpy7Tc2F4b9X9y2ETc8NWHLV
X-Proofpoint-GUID: k5QIQZ3bJpy7Tc2F4b9X9y2ETc8NWHLV
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/23 12:31 PM, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> After removing the conditional return from xen_create_contiguous_region(),
> the accompanying comment was left in place, but it now precedes an
> unrelated conditional and confuses readers.
> 
> Fixes: 989513a735f5 ("xen: cleanup pvh leftovers from pv-only sources")
> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
