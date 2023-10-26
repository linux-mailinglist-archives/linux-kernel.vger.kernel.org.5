Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A569A7D7FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjJZJqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:46:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB448191;
        Thu, 26 Oct 2023 02:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2mc7Lp6koMpZIA57zO5+QBZ+OIBKdGtiblKs+z3sCBUND+M8WzJAYugjdfyOocxxdnU1zJXKSUZcutT27zeBeFO1cOexJ3OKh0zw1gzW6B7+Kj1tefNHt4J8Jl/lFZDUAFZ0q/+xE2hT+RMfyIaNFdomBEk7nvqCIb/SBlWc1r9B5f0O3nFjAPeC1P5jyWz2p10WXZHH1gWqR4W7WEUMtqu7w1HBTtvFTjn1oNj0awheqR1OtOo9jbiKL2nJ29Oc37Jtm8jjKLZjI0Aohk/NJ+a52jy+lOD8+RzXhHusA/dQEyvMd5mZ/i6CMOnLeK8AVVA0BzKNRjdI1hBCfXJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSTq0hLTgBG5Ep/Z4i/pwCQmzUFnC0T9b66dG9xkluE=;
 b=F/CaHNvatXn2dFFKJ08L/PjBTLh0Xws5WYl3wAiZqq0ZsKZbrlaR43RPwf/V2cRguazaHpKSbySnKWiRwhDcKiGE1tQSfJer8SswiWxrpZmiXkZUEPZn3uJc4ukjWaVYbbW2MVr7c7k9RFP5fCM1ULemF7oWh/hWoqnt/YA+IAqrZh7J84noBpXt33LWz4E2lJwiGsTtEUNNLHsAFmx/D3QwRMSDJDQCFTYEc92TEkajziG6SCoJQNlwrshDjQXK1NL9PfnYOJXouLnASUOnqTi8WfHSyT2+gJIOvcrwGsJe8AiWX4drlgdwaQinLaZs0l13zcDG9z7sUGdW0aezvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSTq0hLTgBG5Ep/Z4i/pwCQmzUFnC0T9b66dG9xkluE=;
 b=qbK4BDmbuJ2tyZhHxRWeC8tV0cifZsdA2v5KnUq6C4dp3vJpUhGRQzk9xayFkZi4wAAcnd9ugQEYoSkNm+h+7b5ZCpjdZI9TXfoWHpOPDT8mOJlDwARKNiI1SoFJMbFLsmWpcNTKO7rIL4Lnou6vBXjk7EIMbMR/x0cacwIdNwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 09:46:09 +0000
Received: from PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::bd00:6f1a:9bd5:3b48]) by PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::bd00:6f1a:9bd5:3b48%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 09:46:08 +0000
Message-ID: <44dd915b-4b8d-1532-9ff2-521d02bc22df@amd.com>
Date:   Thu, 26 Oct 2023 15:16:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/4] x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP
 bank types
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-3-muralimk@amd.com>
 <20231026081911.GEZTog/4+zbd2wRK6u@fat_crate.local>
From:   "M K, Muralidhara" <muralimk@amd.com>
In-Reply-To: <20231026081911.GEZTog/4+zbd2wRK6u@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::12) To PH8PR12MB7325.namprd12.prod.outlook.com
 (2603:10b6:510:217::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7325:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc7cb64-88e9-4a70-2cbc-08dbd608615c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bx9tWphTzeQV517ZKti08tBmL1J9T6eqAArIWLgeSrUZ2EnUkNguX1Ttpurb9tMx7ZhgtgzzZOAAie+Zo3Z9TIqo6ljQqQaiZ3SKijLZNiZboR0qKhYCETnCE/Gsimrf1CTR1FORdfRxN7wgFY852wk5pUpTRmqO0dfFE3umuvAzydEy8g22jTn0aQ7JKVUmF1c5rlzpsb2LiNG6K0pnVTnaUdIQu5IPdt0we5vLRzetXFgFxIVWQiBTectno2BMXah/oUNZQSTBR3INH+b2l+FHYHFLzMy/j3rSJ4ECrFADpehtM3pOgHSh7zoSr7eM2Wsuid2EuDiI069LUz5NfRlnrEpXKYKQRHVW5NdOjNCAhr7ZzRPJPbNlNHH/BvRG0PaLz+GXGC1efvj6q7vsWfGueW+UUek9IruffOif8lp3UjQ3fGCQnD0Sc8fNBuyKxeaaITakdS/Y0utur4Gi/3FAx08BDJD0u+2jwc9teLozAgQGMLeTapwhfTRJsapE0k44l3c3Ryw4S+Fg9wxaHfx8dUUSPJ2qhp6kmxrO77wAIw1pOKi9ITVGQzafc2QYz60W6VKrNyR7Iby6prMgg0hjOo5rXR9UVRzXrA9xadovitmpWyfxUn5y5kwmIIdx0xdH2LEXZjdY93RBCXwkow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7325.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(31696002)(15650500001)(4744005)(6486002)(8676002)(966005)(8936002)(31686004)(6666004)(66476007)(66946007)(66556008)(41300700001)(4326008)(478600001)(6916009)(5660300002)(316002)(2906002)(6506007)(53546011)(36756003)(38100700002)(2616005)(26005)(6512007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWtpaUt1NEoyTTJNeCtQaWtaSkx0MEE2MzRxWjhnRFphLzNjek1jUXVsZXdy?=
 =?utf-8?B?NzBXR1Mvejh1Qyt6KzlkZDJnS0tpTWVNLzR3bzVsMlQrOG1kcGhqK0Q3bEZT?=
 =?utf-8?B?Q3BPdmhkTndtMGk5VTJVaHFhajg0MEwvb3Z1VWRla3hNanJDZC9FcTI3c0Ux?=
 =?utf-8?B?SzNoK2x4clNqYnAzdlBvWk1pLzdVU0ZzRW9ubzBtU2xQN1NXbmpmN0tlWmRW?=
 =?utf-8?B?K3BFV0liMG8zV3lIdklZbU1acFl3N1Vod08xSEM5OE5kUW9aekRyQlpYVXo3?=
 =?utf-8?B?VDdIYnUxYlQvSm05SGR5alhEUVZ2T3BPdFhBanhGaFI1TWVpeUJtck5VUGxu?=
 =?utf-8?B?MUdodEFoM2xiSEJtclNuTkJvaDIyUGpIUXNXOVBrdkkvSEtXZ1dsVWdRQWw2?=
 =?utf-8?B?c1h2dDkvcklmSkJySGk4RUJDRWhjUnJob2dRZVcwNkpaWGpUL1pycHhETDFw?=
 =?utf-8?B?R3k5cTJFcDVrWmRYcEd5RjNlWTZkc2RzSFAzWUVrdGRNZFhvUUw1UklVTFoy?=
 =?utf-8?B?TFF1aExRajk5QUw1QkFlTlJ0UGlxcW00Vzk4Q2x2MGxxVlduQWNMWFk5a2Ir?=
 =?utf-8?B?c05wWDJTeVhsTGhUendmbjNETWlVMCtodEN1c0wzZithMFRKTEJIak90QTcr?=
 =?utf-8?B?aGh5V04rNSttaTY4YTkrSEs0NnFrUTV1OER1K1U5bE4xeFR2SnZhZ3BLUDNa?=
 =?utf-8?B?cVNJY2UwQXA4Rzdid2JvQWdwMVpqUUtBc2NMY0sxNnRGUkRyVGZ6U2QyT1RP?=
 =?utf-8?B?NXJUOWYzR0lFVHl6Q2plRW9xN2xNMEM0ekZrWDdLS1RmQVlyQWRtWUtSdDg4?=
 =?utf-8?B?T3dmRGVJM0FuSlNVTk5VRnk0YWl1U1JmemR3RVMrVjlNMngveUQzQlFRM3hI?=
 =?utf-8?B?eEpUbEZ2TW1TamQ2c1lZbEEwMEZRZGptR0M5d2J4TlBnSGhXZTJFQTB0enZL?=
 =?utf-8?B?V09mZ0xxR2wzTDdiKzh1Tk0vZm93ejVRUW9EcldOTVRKeGhjMkhQZE40RzRw?=
 =?utf-8?B?RWpVWnlBVGdDTjBNYklwQ0pmV3dCdkQrNkY4ZWRZemZiZnZuYVlwdUlrcGRr?=
 =?utf-8?B?UjU2V1dTYTNnRkNoOWVqOTZsME1SejdKQ01MTWRCT1NuSEJkRjUwTVZQRUZw?=
 =?utf-8?B?R1EwL2tXY3NSLzNySGlmZVhnYmJQQnNkZ2xzVlZqL2dpZUo4MFpDT05RbUd2?=
 =?utf-8?B?dEVCTkJVdE9aVkJZS3NiazgyVWdrUTBjRjZNQWhDaENIWTc2UmJCNHVjd1c2?=
 =?utf-8?B?S0hOZERRbFFuMDY1eXpuWnN6aDNmZFUyK0QxSFlCakMwTGNMQnlwdzNrQU94?=
 =?utf-8?B?Ui80dTJ6Q2ZYa1BSLzdWbFlWTE9TU1RCaDcvcVZQTHA3WmJTTzN2OUNUaThG?=
 =?utf-8?B?Z09XYkpoRjB1Q3luMncwZ1pULytlZEcycTZUT2ZOMUExdGt4Z0dqUkdZNmJN?=
 =?utf-8?B?TEpJVTFINklUWFJESXl0NC9oYjJrMmFTZnk0bWtMSzRHaG5yaFpmc0k0T3hm?=
 =?utf-8?B?ZHVpVHMvVFl0RTR2R1JMdmttOWgzb29FZitZWkhyaElwUXhGSDBaZ1JyQ2tn?=
 =?utf-8?B?U2xEMDIrUGpWQ1JMRzBZUkZBVkp1UmFSREgwbU9WVUFURmxCcXBLNFFKb2l2?=
 =?utf-8?B?Q0VJRThpT1dRVHRVVzJnNTFYbTVOd0RXaHBnOFdTa0V0SFNNcEREQ3BjVGNz?=
 =?utf-8?B?TER0UXJTVWxuUGdGMVZuSWFaZ3NYeVk4Z2NWQjRkeVI1dm1JaGVMZjdxb1g1?=
 =?utf-8?B?YXlQVEJvSG5YRHBiaGVBd2VTRWg0RkV2aVhZYUhzZXcyZDAvcFZoYXJuT0px?=
 =?utf-8?B?eVhETFNLQmxhZmhJLzd4R2p2VzJPcG93QnFoaWFQMy9RNGJjNUUrYmlDM2xj?=
 =?utf-8?B?eWtrc1gxUHVTRHY3emxHUDcvdWRkU09BNnAvaXY1VUhhR1gwWWFjTmR4S25Q?=
 =?utf-8?B?TC9EYzVibEhtRGkyb3JxOWZ4VzhKMVdMVW5YZmt4dTZDM3VWOUh5RS9wNkFK?=
 =?utf-8?B?QlA1YnlFbnZNKzhzekdGZ0JTTDhCSUQxbkcrZTdmVWE3V1QrdllmdHJyZ3lY?=
 =?utf-8?B?VldGcFRCbmoreDRvMmluMlBaeUdVd0dHNUZQZ0FIY01neWtRQk5MaTlHNmJD?=
 =?utf-8?Q?CjrBHZ2ABMgvwW4OlQNMNTCT/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc7cb64-88e9-4a70-2cbc-08dbd608615c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7325.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:46:08.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PbyArLRnvo99PpV06UZ48IY+bAQoIG+yZ77B5/K3oW3jIPKBZatzsGqNFRQOSzCtWMgOGUmnby8NyKQXDxG/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/26/2023 1:49 PM, Borislav Petkov wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, Oct 25, 2023 at 05:14:53AM +0000, Muralidhara M K wrote:
>> @@ -119,6 +120,8 @@ static struct smca_bank_name smca_names[] = {
>>        [SMCA_SHUB]                     = { "shub",             "System Hub Unit" },
>>        [SMCA_SATA]                     = { "sata",             "SATA Unit" },
>>        [SMCA_USB]                      = { "usb",              "USB Unit" },
>> +     [SMCA_USR_DP]                   = { "usr_dp_pcs",       "Ultra Short Reach Data Plane Controller" },
>> +     [SMCA_USR_CP]                   = { "usr_cp_pcs",       "Ultra Short Reach Control Plane Controller" },
> 
> Why aren't those strings "usr_dp" and "usr_cp" too?
> 

Sure. I will modify them

> --
> Regards/Gruss,
>      Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
