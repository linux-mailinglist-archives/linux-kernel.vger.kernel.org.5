Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BAD7ADDEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjIYRoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjIYRoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:44:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0CB10D;
        Mon, 25 Sep 2023 10:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwsRBKTQSU/FGAOCt+7BhforhzxtOks+y+3B2j40qETNaGAWHW4eb5MPUJWz2oIz7bFVJLx6zLrwPdo9znOgYkHZqSBEwWxmm3PMN+Yb537zBF0j2YB4qdIhpfJWO/slXXWDKNn7lbLYlnMe71L7woeHC5vqMLb+btaC/Ez4AyLPChV2EY82V7YBN3HLj+wcXxSIhXXwD/VnVFZJLUi0CCCGx1C77UcblXvlDFqC4zRhFy7RqaxXYYcjHCzaj+UY4mIeec+q+flDBfIx49LZPEVxD6GEgCvUhRqfy1ysWTvFEEwoxW0D/CnLhYhqPVZjuxRjGYUdt4tvo8F9Tr07fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qebci4ddA9IEgx+nuBYmn6erSfL1iI/kCSQ6K6stPcU=;
 b=jcT1wPSEsMjFnFY3Oaa2TQZpP4h3B2FpLtvKWdiWakNoAuBmX23rDljxbxIlbLNHHzGfXZutFCzgwBWtjvXq8veH65HKAnijctK4LlrJXKUvtCys5Q/0dw+KvKd642tOwATGilnO2gfSu14pczXwOD7qDC/nrYmxf4wY5D0CeMRFEFPGu21UOvYAyZR7/4GU9SzVhhjBY5Xz7L5YX8Dmft8xu60ZdLiX0G9ZYbPSbLf6LPVPGNdjDIF1QpTBh2pvZiFOqRXFIGlhVntj0c+dchLJ79J5tTRMt/Cc0tdJMaw/iBAqBvul5kejGzzXnJQhLMAAL3DCowUCsV0rSVQgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qebci4ddA9IEgx+nuBYmn6erSfL1iI/kCSQ6K6stPcU=;
 b=mMWSMt43UwcbTlgTvGM7ZoGmlQKraB4AeLsJ1MUmyMkaxVBN466srunVK9SldQ18A39XltHqfGAySd5J9O9ZbVSBeY5NtNKrAoim1weIEtEiXG0GB+lDFvB5Bk4sCmAgYq+79nzpeA94YRTOIO1FZwmsJtaLT+7ChwWZAYwAvNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 17:44:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 17:44:06 +0000
Message-ID: <5f753ef4-caec-479a-bff4-43c16fb3317b@amd.com>
Date:   Mon, 25 Sep 2023 12:44:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: s2idle stopped working with 6.6-rc on Thinkpad T14 G1 (AMD)
Content-Language: en-US
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <0d84fb59-4628-4c7f-ab1a-f58889ef2c9b@leemhuis.info>
 <e556ae63-0539-4b34-b33f-5f5beb4183d1@amd.com>
 <e049aa41-b136-4071-850f-d06b47fe67a1@leemhuis.info>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e049aa41-b136-4071-850f-d06b47fe67a1@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0021.namprd18.prod.outlook.com
 (2603:10b6:806:f3::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e9b8fd-b7dc-43d3-4af3-08dbbdef03e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ba2U4qxrMB3EnsGae3XTWtYUikCQltsDAEBkmJj60YkD7xFqSUxgjzmeTR/twSIwd7FDZn7hJ4QOvFaNkELs3vJmMPbcchC3MyhGFxfU3fSxPqCT4HJ8iRXdGtWfdnn9tLU0vGuy/4Qi36JBQT5QUsP64TAirkoZR4UuOtHZG6K2ADOwGwsdGSibSAo4ADPk982ZGCBL5v75AqHmSxI4joAZZkD2zt/QlT2fjyeIWSn19dg59NPxxnDwtJzN/dOZjNRtiPglqKJwMPomw+zYt2x70GCjabzz6Baed0erKBhVGElTlGHnLa+NOiJQRRud4Le4BPmsVQFhOcT+YtijEkZhuVtgoPyy+9HRMTDHCqoKJiwvBnPdfZ33fBxvaK44LP6V7PVta6c/GnEd3rhOTtNYYn/WA7CgPYNrxrA//41ueddSzzu2w1lQGwreHK85LuSETZqc6Z8ZHEgAP1jP2SzqVsA6shNfRAcy57MCkcNnsLJ0rDw4U9Aa9+FOoayL9w3ClfLaTqeX3OhinGRG3DoERLxk4e08NkmUGGY+OUF6KBmls8qpPBse0bYHkZa1H+t3Rv0eZ0lWMA6xmiagSu7zfFaJUlbgSuXTpEIwx35M2mBRU221lD1vhoLqi6gMq6TmAW8v26tTUlEJeFBdYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(966005)(53546011)(6666004)(6506007)(6486002)(6512007)(44832011)(8936002)(83380400001)(478600001)(54906003)(66476007)(31686004)(66946007)(8676002)(6916009)(316002)(66556008)(5660300002)(2616005)(26005)(36756003)(38100700002)(4326008)(86362001)(31696002)(2906002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1o4eXRkSnRMWTc1NzRXTHlvaGJZWHpORlZsT2dvdkV1VERpRHlTL2tSelJP?=
 =?utf-8?B?ZmRpekY5UEtNSUc1dHhZRXVDV01oRFo4eUU2T01GNlFkeVBNRFNzMUtrVWUw?=
 =?utf-8?B?U2YyTW5kUU8wQjFxb1NMMlFRVllOQm9Ya1pqSS9hTjZwMVJjMGovWXJuM2Uv?=
 =?utf-8?B?cUVJSXhLRUY3RzBzbG1yaWFiZDFINnptZHpGN1NPei9WdnpsRkZyMytRUTcr?=
 =?utf-8?B?ZHZldHRuNFRkZDVoNEZXSnYxMGJUYTUyNGF6YVlkeGlyclpjZmRCZWFVeEZ5?=
 =?utf-8?B?WWpTeDM1WnpxRmZOeWNhUytQdXF2WWs1eC9pcFhDZ3VoSGVpYUVyRHdyRXQ1?=
 =?utf-8?B?Uk1qK2Fvem9lQzZyMXpZSXl4MElab3QwRGFkaXY5d2MvYXRhYWtyNkhWeVpE?=
 =?utf-8?B?V3dGU2tEMEovWUJwWnZRQzJmUjNEVGdQaExJYmlncmVnVTR0dUZyMGd6NzRy?=
 =?utf-8?B?T1lIMFNBWDZVUXlQdzZYOXFZdmdlQnV4OVM4bFJValJCUS92RWxIRjJiajho?=
 =?utf-8?B?bHdIVWU4Zld0WW4xdno4SDkwanZJa1dRVTFZSXFmK1RVT04zQUhRZVV5THRT?=
 =?utf-8?B?cnZiVEthbE1nd0JETmVwbVJCeVU3dE12N3pqcWU1L3R1YjNHNkZDdzU2b05m?=
 =?utf-8?B?WGJTT2FNcjhDanhNQXkwRWZJeHd0K1VWQ3FuZEVDSk1hRno1Znl2MGY0QW95?=
 =?utf-8?B?NGhSL3RwQ1NNVDNKUGJ1TjJhTEpNeHBmQzhFQTVyNzl4VW1SMEVSeExIOGZF?=
 =?utf-8?B?N1VCdVFYZ3lnR0xFV0FEOU1nbU5STTh1dHF1amNQWm1aU3lGVUh6NElVT1px?=
 =?utf-8?B?eVUvdEtZeXhlRlNlYTBsd0lVMzQ1amc2eUJPaGhoK1Q3YWZKVSszdkN6WTlF?=
 =?utf-8?B?eVlGbHdKNitITG9IcmgyWnVUMGpwNDA5M3lTd0xLY25CNGVxOVFOSGN0eUlE?=
 =?utf-8?B?ZkNUL1kvUlltQmwwMzZFc2ljWUhVeGVwM3h2RE5MdEo3OXQ3TTE0dHRKb0J6?=
 =?utf-8?B?LytRY0RyVWRYRVhsK2VjN3dKVUxobnFYMDNlM1NzTUJnem1BejNmeVVQSUtB?=
 =?utf-8?B?cEZzSDJMaWozeTJlNWZZR280M2V5SmZoVWVRK29RVldPczdiT0k4VWU5QmJx?=
 =?utf-8?B?ZTh1S3FWOUVqeFFBVW1vMEU4K08vN20wZld3NnhDd2FUYXo4eDVDWDRWRzg1?=
 =?utf-8?B?bVFHVjlsMk81NVFUT210aFhsdmVaSVZ5WTN3Tyt1RU9UeGQyZUFlU2p5ZXJv?=
 =?utf-8?B?ZVhKMEZ1QTJTTTh4YnBMNkRuWEJzTk95OE9hdnVRZVplN3NYZ2x3blRndm0z?=
 =?utf-8?B?b2RMMlpodHpDSVJnelVjVWM3S3I2bWxyUkFVSStNQXNMMnBoZjlPd1owMXhJ?=
 =?utf-8?B?SnFHRjdLUHl4S1JHTks2TXZvV3p0Mi9iMG1lQUoreStEOGE5OWR0UjVJT2Vn?=
 =?utf-8?B?V3BXZEJxSWdpMEwzaklDbGZrMkVtbGhqL1NlS0s3NWlSU3VEMFhzNk9jakRr?=
 =?utf-8?B?STFlWWgrNWYraXNvZjlmNE9oWVRBWTJvZXRqb0grc0I4ZDZtN1JGdm5WUG16?=
 =?utf-8?B?R2J6WVlSNnV3YmpoSkd1RXJuYnNLTDBOWnpHQXFHcDY1cy9SQWpmNkVqMSs4?=
 =?utf-8?B?eVB4ZUFmb0tvaXpldFVvUzhqbmVkSXdWM3EyU3FTU1FEWit5eFJVNXpxd3dT?=
 =?utf-8?B?OHF2VU4yYWE0YkFjM3hmMURIVXJoMjJZaTExTmlDTE03dDZ2TENCYnAyOEJn?=
 =?utf-8?B?N1RFSjUvWEtCMDl3NzJ5L0wzTURwRlFCVjlHN0pkNlo4TGQrd2ZrTURYOUJ5?=
 =?utf-8?B?YWVyK3liRldWdFQ5U1JGWDBTVzg5Mk9NTytaOXBRWWNTdVlQSmVMbjdOVUpj?=
 =?utf-8?B?RFBhMnRPTk5wd1NmMCtSK3U4ZitlZHl6eExCTzNySHN1YzBQU1FIMkZzZWVS?=
 =?utf-8?B?T0VJSkRSZW11d2Q0eU1LOVVlYVljY3R2a1ovQjNoU0p5VVhzWTlCNWVlVkNJ?=
 =?utf-8?B?anMrRTNqZkNCVzIyQWhPaFh3dW9IaWNicWJlMGFRMU5FVHRQUnFJcFprblJm?=
 =?utf-8?B?anZtUUdTMVNtUGxjYkpBaytrTXpkdVpRMWMyTUJmeTFJS1QreXJpZ0lWZHdD?=
 =?utf-8?Q?//Tbq+yVnKqvnGnr8XdqIKDEV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e9b8fd-b7dc-43d3-4af3-08dbbdef03e2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 17:44:06.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ugtj4FuO+CWmMuMVEN6bKdMHQjZ3iTAFXq9q32LqSHQGKQOSsu0LAMlbEMl54+GwvK+Euxcf5g5bNm/Z4q4xpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/2023 08:45, Thorsten Leemhuis wrote:
> On 25.09.23 15:25, Mario Limonciello wrote:
>> On 9/25/2023 05:55, Thorsten Leemhuis wrote:
>>> Hi Mario! Did you by chance hear anything about lock-ups on resume with
>>> mainline affecting AMD systems? I'm asking, as s2idle stopped working
>>> for me with 6.6-rc on my Thinkpad T14 G1 (AMD).
>> You're the first report I've heard of this.
> 
> Thx for taking the time and replying.
> 
>> Yeah not too much useful stuff here unfortunately.  Can you check
>> /var/lib/systemd/pstore to see if you got a traceback for whatever
>> caused the problem?
> 
> Sadly nothing there.
> 
>>> Dmesg for 6.6-rc3 (with a USB-C dock, but problem happens without it,
>>> too):
>>> https://www.leemhuis.info/files/misc/dmesg-6.6_rc3
>>
>> Being G1, can you try "amdgpu.mcbp=0" on kernel command line?
> 
> Just tried it, but didn't help.
> 
> Guess it bisection time then...
> 
> Thx again for your reply. Ciao, Thorsten

FWIW your email prompted me to double check the two other Lenovo systems 
I have on hand at my desk:
* P14s Gen 1
* L14 Gen2a

One of them had a Ubuntu userspace (20.04 IIRC) and the other a Fedora 
38.  I built 6.6-rc3 and couldn't reproduce any issues with s2idle.

So yes; bisect is the next step, thanks.
