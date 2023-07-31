Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258CF769931
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjGaOPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjGaOPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:15:51 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD30AF;
        Mon, 31 Jul 2023 07:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aldz4V3Pf4PztOikIKlvsMVv64fHDWVnTALqCASB140vb6KL51L8Je1UnKleP0Uh35c4gMABCGuZGtbMDi5TfyfSelDkG5oelCCgY/k6pIEhTwEQwUcy9KKAKZIrYlkHDyZmth4k1yc10UCUKcsw1XzTAEC4CtOkgN5tMkxnTxzDyHB9xG8vlyjUodU/bVjsp3aoW3OljkFJJU2rYKJoanBTVfVoKg0oKBVTdox/JujQbNWZENeNg7OWoSSsrKketdoLwOP9GAfYk8cRMzUyGiltH5T8L4Ocw8BY9OuTOkPF9MP5ifQhMAd7XojBZgN0ZWq1qNpb7a/fGIf3CeyftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVR9sE2uTVS+RojtnOnFij+ped3SJvsDEE9JfFS9AC0=;
 b=bw2UsFJcQ6Al9LybgwPlZ7nBtZeSxPGVYcG8riCVSsVXr0unKuUQ/IbCR5rd0kEntmJGDI4FzboJdcavhHmTvyQ9gcA6upRanFGmitqdaCStPuPTRN/qaL8wkX3LvEP/PtlHasdQucHKye5JICg+oedjME0Eez+W793i7TUV+w7an7NZOgkcZzZFGJyu0+XuHSnzhvly5b7CXt41muCiq9veOE0EC1koE7D9X630fYxMji/Z9s9vazK22W6O11NaXqtzRxQ9Vd9MHMhjNoX/mLbEenVXohOTDs4/Vdcq/sw6vuucyZ5gLoikvE5gkkRkuuNkUdIX/4ZHgGjZgIja0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVR9sE2uTVS+RojtnOnFij+ped3SJvsDEE9JfFS9AC0=;
 b=QNqZZ2p3O/GokTKGUiBj6NExMzcq6een6965B+QBCBWi2J7nOkp23Gg1y09QyhwinihW0OFXZchCOgI9O9L/nkzTEGSC1CQZM5AsP2SYU2O4NzCl850nqCLBUjm6Exo6H4Dt3X7PwGfge9jWxDM3pBxXywsuX+fw20dV742HFPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 14:15:47 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 14:15:47 +0000
Message-ID: <51b43b27-42f6-9b23-4175-6f9b17870524@amd.com>
Date:   Mon, 31 Jul 2023 09:15:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 0/2] docs: Integrate rustdoc into Rust documentation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org
Cc:     jani.nikula@linux.intel.com, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org, rust-for-linux@vger.kernel.org
References: <20230718151534.4067460-1-carlos.bilbao@amd.com>
 <87mszqfbfg.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87mszqfbfg.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0094.namprd06.prod.outlook.com
 (2603:10b6:5:336::27) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 359a6950-741c-4768-3bc0-08db91d0a287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjMwc+HeEyy8Y/OZdhBjJLLR935JcgQNqlW2Ym6h+wGNYxDo5g3drYXmTNHI1286bKZ/9h7Qno47E8eD7eoSRfaHczHI1g+PwjkiSowtFI4UIqE5Xm6FP10iIG7kCjCBAyxEc4p0AMS7jmXLcUKZR6retvzmo5LCh0wt47jABYswZ1dlBQsj7ewH6/nbRhnc4B9IvAcdZ5OA5RAJ0Ofev4ulVz+FAdQVDDdfR/tpzbbHcGIBc3Gv4E7Pq5oEiulP/MXoAfBkJdzhxA54FWOetBMSeBjKZ+O9rdN9uAYGvGzqIyMcuEnAspXCWAGP2LoCFDtV4g9gNlbRvoWR6TOoS3Di6j7QMpQZtZCJnQTfX1Bbgg/aB6wx/ilBO8vwaRiayEdjy36KhfHPzJ3cTcbJNzlbUDjLTkG1HI219IZJw4vNdE6S+wGQtAD0UpQQCzENFzke2/BMERMU7Z0P8c74eEmOzLuba4KYXnXXXbWZGsRLdLBEPxnHqm6dcfE0hjYcJO5bZ1rroDLLdw0RCVylVearYhAQnAarojo2I4sbabyO1FqypLYFls1g14QC4AZnLWkc2bvtp+v1VMgq2Q98zMvw+mUmzYuYqSNv97m4hU2745jd2Yvs2wGCseHqcvHhEwPUJp8bsE5TkNPvZ/ax3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(86362001)(66476007)(31696002)(41300700001)(8936002)(31686004)(8676002)(316002)(5660300002)(4326008)(66946007)(66556008)(478600001)(2906002)(38100700002)(6666004)(36756003)(44832011)(6512007)(6486002)(186003)(26005)(6506007)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU13dHBxeGRNVXMvNkpjQWdaVVN5b1lHbzJVZzFWNFQxWkZKT1R2OGdOckVM?=
 =?utf-8?B?VWdRMm1SZVFEdTRJT3lMekxWTk5menM3cEJISkNndlFqaUxKVFpjeTdNR2ZP?=
 =?utf-8?B?ZFJXUThqcHhQSkJ2NTFuY3VCRzEvczljZ3hhRGVrdWlqakJ2M2M3aW5RTHhr?=
 =?utf-8?B?YWoxbDgySUp1SFc5WUtic2E4UjZOamwxdDJHU1JaYno4bkxscnVFUWMwWEJL?=
 =?utf-8?B?SWFEQmI5dkx1dzRGSU9JR3VyUzJ0eFlCWTdRVmU4WEg5RnVYc2trVnhpK2Nh?=
 =?utf-8?B?SFVqdFQxYm9MZjlSckxMQ0FsRHFNUlZUOXBvVDNhSWJyS2wxZHFQZytjNjho?=
 =?utf-8?B?RHBWV25WbGpETVVzR2tLcGtkVjZqOWU1ZldRUTBIb21oTXhucDU4eXlIYldV?=
 =?utf-8?B?TjVyZEdpNDJnZjROV0ZqR2RTMmVXblZKaU1CSWdteWpiTktwWGtzcy8wUnl5?=
 =?utf-8?B?L2JlQ1k4NEpRajFld3hsT3lCK3Vxb0d2SmdPVGhMSVk3R213V3dLUURrVkRE?=
 =?utf-8?B?My8xZmNCeW0xS0ZIS1d0WVVnbndDMWo2RHJ4NHloK01ORmlwaVdBYmFzTVVh?=
 =?utf-8?B?NHNxQ096Q1lTYXVkaWdsaGNVV0RnNDJidTNFOWQ3cXJndE1qQ1FKTzMyT3dx?=
 =?utf-8?B?djdQSDQ4QjNFa2J4ZTMxc3JDSmJVSy9rUUcvcUtWK3dTZFUvMzBqeTRWbkc2?=
 =?utf-8?B?NmFrbEZnbWZrMXBMbDBYWVB4cWlpUlQ4SlprclZEbmg3M2pMY2JXOHJmQjkz?=
 =?utf-8?B?NEs1MXY4aXNqbUtaTGJqRm1BRXc0M2FZR0pXd3ErQXBrWnpQUzdUSjU3MXVM?=
 =?utf-8?B?aWxKVDVhSEZpL09jby9vemM2cVhGMkVxczVyUzZ0aE5RM3k3eUJtQkZwSVNU?=
 =?utf-8?B?NnRSd1JqejNFUm9EOE1XdjRVYXdJOW9XaEEvaWptUXpIbVA5QmFuMDhZUlhF?=
 =?utf-8?B?TDBrSjFaUDdhSk8vS3YwYW9DWkxvU1BUSURzWGpZSnh1dVI3cTRrTG4yNzNp?=
 =?utf-8?B?Sm5Ba1BZRk8wbnB0MjFqSk8yVXlyblc3Ujg2cXpYTm9sR01SQnN5cTRkMWMw?=
 =?utf-8?B?ekpLbHRpVDVwUjJhK0kyb2RRc2hEc3pURW00RCsrdnlHdkhlSmVpNmhLenFY?=
 =?utf-8?B?emdDSVhLU0xtTmpyWXlkRkV2VEhyanlPWis2ZlUreEc2d1ArbG1md3NrMW9S?=
 =?utf-8?B?MVVIdk0zd0pUK3dydTVtOVdVNHZCbW9tcTI3RGJqYUZqSGtqUStsZWpRallv?=
 =?utf-8?B?UTQyYi8vR1VYYmdPalNUZGdMM3RHOFVPYTRRblh0SUQ3NThIeExzZVNDK3hh?=
 =?utf-8?B?T1Nva1BIcDRmRFlLZkNkQ29pYzhkcVNGMUtoTnRqSnlFTWNKZXVNWk8vWm5I?=
 =?utf-8?B?KzBkUlNGZFpSb1YxSDV5aVBVQmJJWW84TllMTVplVGhnV0dzQWgrbTJtRDZ4?=
 =?utf-8?B?bUszd0EzdVJRM2VFL0VuTUx0cVc5NTNJWTRTbCtoUytxTjJJM2JweWdrVGl2?=
 =?utf-8?B?MnBUcC90S3laQllPWWlHdktPcDcvalZYcmhaaGdURFVHSnV6L0NMcmVyS0dp?=
 =?utf-8?B?SG9YN0xPWG5MekxLUTdHdHRoZkt1Y2FtUVJ1OThtN0taQUNsc2I1VzF2ZVJH?=
 =?utf-8?B?bDhTWnZxcFhQdFp6Y0lISmJrK0QrNCtNaEtoc0VrR2RidEpCNHpsREZmZEEw?=
 =?utf-8?B?NnlZRkRadGViT2cvVkhlK2Z5eXlwa0k4VFFxajB4SG82c0tHMmdKVC9CRFZq?=
 =?utf-8?B?bUV4WjhaL1JPNk10bmF6SHVWZmpJOWFtN3dIc0dhSW0xekJrM2IvRXF0V2ZD?=
 =?utf-8?B?WHkwRTdaWjRyN1dtYkdsQ0pBN0d3TWRqYzZIdmlnZUJaZWQ5TCtwdExJR0Nm?=
 =?utf-8?B?MUt4bjJjVXR5QVNUMGpJVXBEOUVseGZjdE5pTGU2cTRyZ1FuWVczQjhWbXBU?=
 =?utf-8?B?c2xkZVF3THR4Z3VkdzZiRzhHUVRBclhUYXhOeGFDZUJkZmlGM0E2aDVzb1pB?=
 =?utf-8?B?UkhkM0poZStPcFMycFFlaW0rZThBc0Y3WWtCNlRqM2hhd3JmbU1yVTJrUFV1?=
 =?utf-8?B?K2xpejBmRkV4Slk2NXRwTGc2RkdXY05tWHFaTmpKbkg3Y0R2MWJJcjlyWFM3?=
 =?utf-8?Q?PSozvrvy2RYE7n16jay4FgqI+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359a6950-741c-4768-3bc0-08db91d0a287
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 14:15:47.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zap+6G/utATprA9FfH/9cu6yCZeCB3+PYd7u+mjVfKNLkLFdPsb7/JUSeMbz0ttdZXquBM9gM43rd6vQfWEF+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 17:46, Jonathan Corbet wrote:
> Carlos Bilbao <carlos.bilbao@amd.com> writes:
> 
>> Include HTML output generated with rustdoc into the Linux kernel
>> documentation on Rust.
>>
>> Carlos Bilbao:
>>   docs: Move rustdoc output, cross-reference it
>>   docs: Integrate rustdoc generation into htmldocs
> 
> So I've been messing with this a bit, trying the various combinations.
> 
> - With no .config file, it behaves as it always did - thanks.
> 
> - With CONFIG_RUST=y I get the rustdocs, as expected.  There is a time
>    penalty of about 5%, which is unfortunate, but that's the cost of
>    progress, I guess.
> 
> - Setting CONFIG_RUST=n led to a crash with make complaining:
>    "No rule to make target 'rustdoc'".  That isn't something I have been
>    able to reproduce, though, so I have no idea what happened there; have
>    you ever seen this?

I have not been able to reproduce this error either. If anyone comes across
this error in the future, please reach out to the list.

> 
> Other than that one bit of strangeness, I think this is about ready to
> be applied.
> 
> Thanks,
> 
> jon

Thanks,
Carlos
