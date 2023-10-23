Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117187D3993
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjJWOka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjJWOkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:40:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2739C;
        Mon, 23 Oct 2023 07:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8Dalky/7xDW7LW05qxrX5zjgaNxgU3SRNomsqMjlpGlKr4+MCf7XB2yQ2q+pdNeLwmAxW3DViJgsQy8a7TXT7/JnJNHDwK9U5hB1md6mHYxvqWZl12GGtFzLFanslc7obQAR88E5gwYqq/a3aXwXRHdbZqKSJ7CPMuyAbeRWAapPeDTM89TbZmDOPWq3/XM5rlTn1uATSFERWC6cWHYEUon6zCVl2qYUNG15muSdvjcZYhKhX32rzO2F/PrMVfrRN/ivw/xtFnSnL5QDubSlrK8guQW+0l4xd0CXv+VXkx9CYd/zh2Fa0JhUZi62HNMS/kUihX44bOi9CUWhkkm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2G1K3opmyd0NJ14/5hDntjcV3mcbf0pu2KK388u6RI=;
 b=k+XlTzfKZ7gSg0cltijPcC8mFUGHzNtOQDvsSucqq2pCfhl41wezcpFIfmFw6FR2KXm30cCll/CTqD8IEtS35BkT1MgQi462/OvE0wj5AzTBT+r1Ubut1MXA3ZDZmlQK/xRD/eF2AFs++9d00mCy+AiV7505iwlNvZpvTNc+hoNBQyXL7lOFqlj5QmwkOD+23mi5tMSfa+RWMWuEoc8NhffQBw1xWyg+vDjU+a/Vc8WF7gYO3F2+0RgNpK4/B/4/3fXJQ3EaSiPmwrcpcT8CievnAUW51qpMNR4IwiIWRUqEFTt4UFZ9fmGbHZrNd04g3p8yguvvcSabUkMItxt3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2G1K3opmyd0NJ14/5hDntjcV3mcbf0pu2KK388u6RI=;
 b=Ha1nRRw/JWJwdP0LbAApCbTg9EIWw1KP4pM4u4gyFw3YAzc5lHr57JrIW8XL7rG1MO0mDB6gerIrwc/J+kuDrIla68b8aCNYva7PvYqcFNlmSBobwfueohj30pI4WtY8yKx8/rVX0XsdN3ro+g7BkTv3JG15DSMY/TJ5u8CzGYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Mon, 23 Oct 2023 14:40:18 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::7e38:5c00:e469:bde]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::7e38:5c00:e469:bde%6]) with mapi id 15.20.6907.030; Mon, 23 Oct 2023
 14:40:17 +0000
Message-ID: <6018953a-b6fb-00ec-626e-17d86632d133@amd.com>
Date:   Mon, 23 Oct 2023 09:40:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] docs: rust: add "The Rust experiment" section
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20231018160922.1018962-1-ojeda@kernel.org>
 <d47553f1-1832-4c69-8a8c-71c58048ff30@lunn.ch>
 <CANiq72=E7TPLcq-yiQF9E8a33ghbogPcbv-yMqFKBxMQ0oOxNQ@mail.gmail.com>
 <5c3f3ef8-e93c-49f1-881f-11c02afdaf7d@lunn.ch>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <5c3f3ef8-e93c-49f1-881f-11c02afdaf7d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0197.namprd04.prod.outlook.com
 (2603:10b6:806:126::22) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: b219dac9-22be-42ae-7d16-08dbd3d5f9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46Xl2HTmLMz+LQmGlQSSFk7dAittZipFw1me5LA2pBkWSrWMxiSKfoJQLrGSi60EFBOODdJyy9MegItumm806lSc9x2x//eimwPYMOmhosMboxDTchmYIG9B7YYBm4GWscLBFIsiD4NhW+iGofmFdQyneI2s0YOPdh+wBrbmNd684vdvlmEbumfAjXe/RiVzXPFQAGU5y7Tw2c2gPMYhZy+vQeBFOx9UurhCqzpb4a+aoDdOM5He+msQpXqSZ9hRdIB4lRU1TcmpcoLtIKWYeaxREkL4Wgw0l/38wCLr3iSF6la3n26c3O2a4iH4d6TEHf99ukYuxbfIIQuVsfZ3v0AC4Mctk6XsYt37zOhQERQ/JYM71FmWd+SXftkuON1Ef3LEqZu2urCvhDhEOBJQSy/7cbhNYDujeGCldKbnjbiWXSHGb7KG1nG8KZEN8xLwm5pSk5khui3EjMRX4IKouLwohaZIQmJdas5oiRuGYWCtWKWTZlVdBkF4Y5Gh5qqO2YqxbMfnhpY+xfb/55mdhCmV0Jq2F9qorc+8rakpnBZS7Y1TRiDaED/ONYjNTiNi9jNxdwO1Hs8L0132/GhTSkI/DX7JcaAQQlIDT3fXD/jRUyRRozotEad225MXjoHIF2f7IgqU7h4XwK2hht5NFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(31686004)(66899024)(38100700002)(2906002)(41300700001)(44832011)(31696002)(5660300002)(86362001)(36756003)(7416002)(8676002)(8936002)(4326008)(6666004)(478600001)(6506007)(110136005)(316002)(66476007)(66946007)(2616005)(54906003)(66556008)(83380400001)(6486002)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzE3enZWN1VvMHhYdGF4aGFETSs0Zytza0xEUkZ3a3lKUS96S0RqUllwZ3RM?=
 =?utf-8?B?UmhsY2F3dXhzOFhrYzhRaDE0ZGdTUVhLS2xNc3lpSlVqWW8vV2l3S1F1MzBK?=
 =?utf-8?B?UE5QVC9tWGFlM3F1UVFnb1IzaFA0TnFPWWQwNU1rY2NnaldlOVdGUlJmVkhW?=
 =?utf-8?B?V0NyWjVHYUY2Ylh3SVVDTUliSXB1cUpnc0JIUDhLZmNRcURzdjNXZ1dJYTNI?=
 =?utf-8?B?ZWtuL2tKR3hpWnNlUVh3QU96cG1sRkoveGpIb2pRaGduRE9lSGxiWjRsc1V3?=
 =?utf-8?B?RHdycFdDdXcrcEJLZkFGbzNGMVlmQ2F1ZlJpMi8yMHlhamJwdWlRZ2lzNmZt?=
 =?utf-8?B?RnNKQjlSZlNPdkxuTmNFQzhGOUhQT2hxVm5aSXlDVFpiaWpXdzBtaU5rdGpG?=
 =?utf-8?B?K2ZQVWJXOTNpekFJR09wTUdCY0dTMDdhaTBpejZKUGVTUVRMSGIyTHhua2xZ?=
 =?utf-8?B?TU5nUWlxeWpndkdDaVpsTTJLZ0dyS293Yk5vcUhTZ2c3elRvOE5mcFZYOWEy?=
 =?utf-8?B?QlhjWDFJbVN5V1VCOThBRHNlQUR4KzQrNjFsSmlGZExYUmp4Q0RrNlV4d1FI?=
 =?utf-8?B?UVo4T29SSGgvRU5Iekxlamw1b0pJSzVCMkVVZWcxM2NDa1MvaEFkUlFMNGhl?=
 =?utf-8?B?a2grc0g0dFlnd2gyYjZidVZyS0Q5VS9vRFJyN3RjRFJhTUJGWC95czMyYmd2?=
 =?utf-8?B?QnVMNmtHbG1MQ0N3akluWnpJc09LTEVFY1M0UC84VGRhTWF4U0Qza0RzUnp1?=
 =?utf-8?B?cE9JcGRTdmxXSHRSaEtyNVJpZFBkMElJWUVURVlWUTNBOGVNYXZLOU54ZktT?=
 =?utf-8?B?K2QwaWNHeGlJckxMc01LZGRSMWZBNFYvTzBaNVZQaE9LUGJLQXJpWWhJTk1J?=
 =?utf-8?B?QS80Tjd3NkJHRUhpYmtpZjc5L0ZyQW13aU1CdzFobGFyVVhMM0F1MUFRdXVy?=
 =?utf-8?B?VXhMSU5qYjc3R0ZwaG1kWkJ5SC9EeDJrYjY5bUVBQ05uc3Q2Nkk5Z2g2RDlB?=
 =?utf-8?B?V1JWRGhiYkVDNDl2UnNhYzlIdytBUGp5NG9LcFNiMno0bVpjQkdnV1VOOWtj?=
 =?utf-8?B?RkZZN2hsb3FzM1ViQ3N0YkYydkMvalVvQ0lTcnU4WFBrYUgyLzY2dmp0blVJ?=
 =?utf-8?B?NHh2UFcxQzdSSE4yOEQvVGVSRytPOU9iZTcwZG1YcU8xMGRweUR4OGE5T2hi?=
 =?utf-8?B?MkZYOHlmMExiejBhR1VxbTMvaFNsMUpQcWUzY1Jjcm9JMG1ncVdMaVB3R01Y?=
 =?utf-8?B?NmI2S1dpazZVSDloVG9vYXJqZFBwRGdCazVJaVU4NUp2SWJjcWpYZ29ibkVj?=
 =?utf-8?B?ZDlKZ0ZJa3lBZzVYdmlCb2xneVFYTWx6R1JqSi9Vd1BxRmlEdHo1WjFiWnRq?=
 =?utf-8?B?Qnl1bmFZcmRQclhXMkxkd0dlT0FwQjRmcFlDQld0dTl1M3FYUnY3UXRoNW9m?=
 =?utf-8?B?d09SUlZQQjhvNVkxS3RFcEVMVFdFeDhmeDNMTnZmOHJTMXRJczQ1TGcvS2lH?=
 =?utf-8?B?dUdkaWk1d3hrSkcxNWFRTDQ4YlZzSHR4ejFka2duV3RYSmQwb0RiZkVsWWpB?=
 =?utf-8?B?ZkU1SGxrOUVwMGZUcmt3dHdhUXZtV0RGWDhXb0dpcFdEVHZLVlRRWVVnbVQ1?=
 =?utf-8?B?RFQ3WUdQaVlRbGdFckZmNmpZMkdVT2poY05QUzI1Um5XMnhreFhkWDkwSVVZ?=
 =?utf-8?B?Si9QeitoMWJrS1FlbUpxTmxqbyszbmUvbG53U2lBNFc1WDAwS0l3ZnpJK0c1?=
 =?utf-8?B?SVlzRnlYbFZsSWwyMmhBM0FDNmFoWjNiNmxFVUFJa2NZNnJucHZXQXRJUGdr?=
 =?utf-8?B?dHE0ZTFLdTI5MGlBSm41RHBVbnJQNVlqUk9DZ1M5cW9INWgwemNpd3ZCeFVr?=
 =?utf-8?B?bHJhN2NBYVdnYXVicW1jakFsaVhzanYxM2E4eFg2TWVCMlFWb3cxanVwTllk?=
 =?utf-8?B?Z0dhYldTSks2dXFybWZiMTVUMXhGQkFCRXpTOXRKamhzVWRqeXoxcm44c2Jo?=
 =?utf-8?B?dHJQZ20ySDZ5WE8wL3RrVFNuU1IvVmZrVTMxbll6YkJ0bjk1ZWUvSm9UbHAw?=
 =?utf-8?B?ZVRhdEJnUWJuZDdlREJPb1NLTEVqZnpxMkxzVVZWa2piNXpXa1RYTDl6VVIz?=
 =?utf-8?Q?ffJqUUxfRRFvcL870qAxo9UPz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b219dac9-22be-42ae-7d16-08dbd3d5f9a5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 14:40:17.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ov/NHAwHFuCAAH9kjJyIIWOhNteaczctaN8mjeHArChQCv96EnbqiLEqQEaGfEKm5slcCmQVyJ+Zx9ojoTgkbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/23 10:00, Andrew Lunn wrote:
> On Wed, Oct 18, 2023 at 06:41:10PM +0200, Miguel Ojeda wrote:
>> On Wed, Oct 18, 2023 at 6:27 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>>
>>> It very unlikely end users read this document.
>>
>> We can add a note to the Kconfig symbol too -- would that be OK with you?
>>
>>> And that statement is
>>> not limited to end users, it is true for everybody.
>>
>> Agreed, but that bit is meant to emphasize that end users do not have
>> a reason to use it at all (unlike kernel developers etc. from the
>> previous paragraph)
>>
>>> What we should be saying is that Rust for the Linux kernel in general
>>> is not ready for production use. Developing drivers in Rust is
>>> currently for experimentation only. Given the experimental nature of
>>> the work, there is some risk Rust will never be ready for production
>>> use.
>>
>> The risk is that Rust gets dropped from the kernel because it is not
>> used enough, not so much that there is a fundamental problem to solve
>> in order to reach production.
> 
> I've talked to a small number of netdev developers, not many, but
> some. The general impression i get is that it is unclear what
> experimental actually means, and they have no idea what makes it not
> production ready. The two are also not necessarily mutually exclusive.
> 
> To me, it appears Rust is not production ready because:
> 
> You need to disable module versioning.
> You need to disable structure layout randomisation
> 
> On X86, you need to disable X86_KERNEL_IBT and RETHUNK, both of which
> are part of the mitigation for speculative execution vulnerabilities
> 
> So no vendor is going to release a kernel with these disabled.
> 
> Networking also tends to be architecture independent, so production
> features need to run on X86, ARM, ARM64, and to a lesser extent MIPS,
> RISC-V, etc. I know this is documented, but it does not appear to be
> that well known within the networking community.
> 
> Networking people also tend to be interested in endianness, does the
> code work on big endian as well as little endian? Big endian is dying
> out, but its not gone yet. However, with only x86 supported in
> mainline today, it does not seem possible to test big endian. I assume
> the rust type system will actually deal with this to a large extent?
> But are developers writing abstractions which are sound with respect
> to endianness?
> 
> I think it would be good to describe the experiment a bit. With a
> multi year experiment, you often have short term goals and long term
> goals.  What are these goals? What is the Rust for linux community
> trying to prove in the next few kernel cycles? What do you consider to
> be 4 or more cycles away? What do you consider not so important now
> because its not needed for your short term goals? That might also help
> developers understand when it will transition to production ready, but
> still be experimental.
> 
> And you obviously need a disclaimer, Rust for Linux is a community,
> developers are free to scratch their own itch, so things might happen
> in a different order. And information like this might help get people
> involved, helping solve some of the limitations, spur research into
> different goals etc.
> 

Points such as:

- Clarifying the definition of 'experimental' and why Rust is not yet
   considered production-ready.

- Providing insights into the short-term and long-term goals of the
   project.

- Addressing concerns related to endianness.

are indeed important aspects to consider, and documenting them would help.
But that's not what this commit is about, and the index page is the last
place to comment on such evolving topics.

> 	Andrew
> 

Thanks,
Carlos
