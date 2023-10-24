Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76567D5A43
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbjJXSPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjJXSPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:15:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ADB111;
        Tue, 24 Oct 2023 11:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1hmKYSjcRs8dsNAsUfhp2sZPlqxt8qP+3YudfyF4H5h73eMEEpFu+YNK9KOSja51WrCeP90CBl/kUbDjM07RO5irdLEAfBbzSUcWgLDZCgkkLWGa8i7YGPCLh1PzTFeVlXf/RY24QhZ6kn5BkQOX+cJcEh3fr9vszpyYsS1O8AwV9B15kOZutdKLQG6fa0/LZxYQhwA1nOf84Zl+lXqsDF7tJO7RQxCHJsFI+6Dt1dyTC6ETXbun8IylkIIb26QgUwuggN7NJlkAOV7IOJ2kivYLhFVLz1hW4ScpvwkrleX1m2usY5S9dAlZRO3UqMa73fJgoXoxZMeu/cNx3B55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xywl0cRE7kq4q1dgu8cSh76YoAEBIbjHDpmqMj5n7H8=;
 b=Jop++RZTlOBiTbBttt5A7S+kolGoMKFDvdnzCG0JyEas0BrVX6+RFJxiTEQQsfkSsBLxfaF16kTuOTBjTojQfqrRUY6G77GSrGt2ok96iFuHthAHxNpHSD1awBrPjmhBtyDu3v+g4Be/JikQYGwITX91r93UOgIVPS2Q+bHrz7hiZo1M3L9tBILz0507o5UIXk7yZW1bf1ZQjF3Y/THvK4AzhKSQdC6kSvhhy50XVs2iZAJXwwOAjm+WzgTwotJHTOR2RHI77Oq5nH7Titjc47DmU8rP0PT7GBna/BUcbOKeWgtAmWMHT4HZbPy8368UMI6Lu/5uAuAx4UvflRMqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xywl0cRE7kq4q1dgu8cSh76YoAEBIbjHDpmqMj5n7H8=;
 b=4EO/ByEBhnw5OJQ9B6eCgdI1UU+qBKjR3RZwTkLEBvJ4fo2SxWd5OAS4EAXa/4F912zMkIVHBvistgxlnrnxTq7LGsmMeuypSGPgLljOWcr+vnx5vHnQBcbGqw+WQJE1JSk0nVpWIzjrBpsGVQF/7q+Zpg+1dOmlGPT2ED2eQrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 18:15:26 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::7e38:5c00:e469:bde]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::7e38:5c00:e469:bde%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 18:15:26 +0000
Message-ID: <4f53ddf7-f92b-84ed-046a-da2ac7a2cedd@amd.com>
Date:   Tue, 24 Oct 2023 13:15:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] docs: rust: add "The Rust experiment" section
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20231018160922.1018962-1-ojeda@kernel.org>
 <dcb9d0bb-67a3-2f50-9d17-251baa24b066@amd.com>
 <CANiq72kjbrU7gDOx6m+KY89B0YhAk0FQ8L9BvSXEF2UeYqP88w@mail.gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <CANiq72kjbrU7gDOx6m+KY89B0YhAk0FQ8L9BvSXEF2UeYqP88w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:5:54::37) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: bc90a391-98ba-4162-bb40-08dbd4bd3279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1jQUPVzntJ2yo9b+qTICLQVT7MJRe25+jI2EVCkaThaH6BroQQYbuh5cVjIf6/wMTAQ+SGE3jKvMOPEhS5Whe7QMRzJws5RwI/1H3eyEoaNv71+G4k0Hw+rLHYcUNmHcSE/SH6FFHAJMjRohvSfMdkSYati9roRfRH4mcghxmOCo8ibcStT07FL4NrK+vMLtECumOdJhV5EGRwgP1TGBIuMfu1I5fYYULMdtimaSKTst8+OAL2WWH1SWRRvkscR6R+eYnuuGxyFckn+nrxHInKYCttxTvyKwbDi6psoAG034ReShINw+KO0EoICs1tCwMksIU+monFXKD3ItOZ0ELZF/dvDEY9PbX41f52tK6Xzdeuw+DFEWAXHBcwXyCbM6IKMeGBXhLqKEpU9K/cgP0H7gDc1IVfBT3mk0CoAbr3gPRNga4QBOpd7Rw9KDx2ndsTZDEVbqf4gZisdGLl6qFh4T443VA7rGjehnSjc/9Q9p9j2xdmHnKtLCAMO925uxsblrnIXcAZXhhyJc+mFjLJWhPNxlnjS1Et/ncHlqipANL4+BNdBZrXz1gai7q3TJqiiNiHNhKs944iKC6JNeVQFFn7P3NunMhCLfFpa/h1HT4XPAPkRXJOIyZrt488BkAJq0Vcz+U+B65xDfCL/ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(6512007)(53546011)(6486002)(26005)(478600001)(54906003)(66946007)(316002)(66476007)(6916009)(66556008)(31686004)(86362001)(38100700002)(2616005)(36756003)(31696002)(4326008)(8936002)(41300700001)(8676002)(44832011)(7416002)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0tLeEJpUUxMcmN2RmZ4TWxQaGs4UVJZK2lnQTNOQThhdUhMRzlEaDhLSU9U?=
 =?utf-8?B?MGRja0JwelJFWlJhZ2xQY2EreDdIQnpLSlNxS2laWktySU5MR2hmL2R4ODUv?=
 =?utf-8?B?UzNFSFVDWE01QUJPTWt6VndXYlBwakZrSkVXb2QzdllsQk8xeHp0Zkl4R096?=
 =?utf-8?B?eEZpWXdLVTFpTDUxVGlscTc5ZlRHalhwZ0NJNWdNdE1oTmF4RGhyQWc0aFNq?=
 =?utf-8?B?K1N4SjlmY3BJQ0ptTUd6QWZRcE4vK2F2NUIwc3QvRHk1YXZENUVxakNnc3Bm?=
 =?utf-8?B?WCt1MVFsbW5MTFFnbHdvTHBGS3F0WE9QRFZkSzdxVjhVSVRHTlJ6SzNrSldW?=
 =?utf-8?B?WjExZWFRdnRaZXFzQjIraU5HcnAyUmg2SmVuRTI3M2JLNUw4a3lJdGczS2Ja?=
 =?utf-8?B?SERCUm52b2tWMytzYnI0SS8wVG82S1BpSzRrd3dZRURJR3F2MStCc1Q3WXpG?=
 =?utf-8?B?YWVSaGhaRzZxOThveXlMd3NDZ0RPcEtSWE1PK3F1UURCTDdzVVpnMnNWVHd3?=
 =?utf-8?B?SlNEZjJzZEg1Z2hZQUVWUUtheHRpTjBkZXhrU3FGT1Z0M2oyQ2I4WUFkNm1N?=
 =?utf-8?B?YWhFMERoR1dEYnY0YnRGcnptL01GY29JZnc4elRSWXpYVGFMREhEVWQ3djFl?=
 =?utf-8?B?cWEwYmZKZjh6T3RqVklhNitMbXVkSkw0RU5Wb01pSEsrQ1lRZE5Nb3FKWXE4?=
 =?utf-8?B?c3YzZEJUM3pOYlZkUklvcWVLVkNac2JxMU9HMnpWbG5YNHhINjdQayswbEE3?=
 =?utf-8?B?dzdFdkpTU0N0RjNLUWx1WEppQVVxNHJWeFJCczRMbldNUFNPU0FObXg3bXIr?=
 =?utf-8?B?eGdPVUpMeTl1MTVRM1FUVlFSTmlqRWlybmlwTlBZSVFGTElOV3JvRmxXelBB?=
 =?utf-8?B?b2QrVFM2VEErV3p3VHo1MFFvaVpBUkE2OGs0UWJEdVJhYjhEL2pqTExRSlA1?=
 =?utf-8?B?WmZhYjZTWHh5OU5YYnpyT1UraVZBdUpMRm9ZMWR1TVk3eUcrYk92VjJGZ2Rx?=
 =?utf-8?B?NHRlV25zd3BJM3IzUTUvRGJOaGdFMElzQUVuYXcyUHBBaXJwcE1PY2l2L1RN?=
 =?utf-8?B?ZUpaVWpxSHhveFcvbkp0RkZsN1BjSlRPM0JsQXpxN2ZaWXVTNXhndS9XbTZa?=
 =?utf-8?B?WVNRaDFZTllGcnZVejJvc3c4cDNHOUJUSmlpMnhwd3BNbWtWM3pGaEc0RVRQ?=
 =?utf-8?B?ckEwbWlWVGZ0UFV4c09yeEJWOTQ2T1E5dXkwM3paZmRDUDRpVXNqaW5LdTkx?=
 =?utf-8?B?SHozdE82SGdTenBqdlBLN1hFamZxSXpXK0tlcnU5UzdWRXQwOWJQWExDMDNm?=
 =?utf-8?B?M1JDcUJwdW1vOUlLMVQ3VTljS0JKWDdHZU1wSTdoa0FHTzkzM0c5S2xwK3V1?=
 =?utf-8?B?US9JZnZMelhGU2F6cURsSFNkU1Y5dEtPcHNDYUZlemFRajFpYWVLYytsd3Rh?=
 =?utf-8?B?czdMWS9SMHVlekRqQkFZNnk1a1hwd3ZpakZLSkZzeTRPNDJPcjNPM2E2L05D?=
 =?utf-8?B?YjBIbDFiN2RNcndWZzg4akdrVG1SV2dMNVFNTDVXd1hTSmxyOURHZU9EZjJl?=
 =?utf-8?B?emxoKzN4SHZGaU00ZVFYUXNSMlVLbjlhclhVdnE5bEpCYXdzc3pMVEhvaGtu?=
 =?utf-8?B?eEMzaDJLRC9wNnBhUTBXV2Y5dFF4b1RacWlycnN6MXVZTjJjUGlSd3ZUZ0FK?=
 =?utf-8?B?KzlvbW5ySHl0REVkZnZxSkdJK1I5dEdYa3o4YkFIdnV4NFFNYUJuZTI3Mzho?=
 =?utf-8?B?TlVVbHordzVsSDdjbGZqSW0wYis4RTNTdWdNL0Vtb0Q4R005UHdBRGJXQk9G?=
 =?utf-8?B?TG9Nejhybjc4amR1WVJyNVhpdXpPaktYUTFMS1FrelRKYlNqc2x6Vkx1MGQ1?=
 =?utf-8?B?QWpERVNFL05QbFN5QXpja3d6eG1tMXVxcTF3ckhBRThoaEgxTHh3Yk80Q0pa?=
 =?utf-8?B?OWVScWF5a2FGS1NZU3Iyd2pLdVFQV2VRV0ZXYkRXZDU3S3JpZVh2c2FwRmVu?=
 =?utf-8?B?Q2FZRDNWM290ajBNbnNlZEpJTnltbjlRTjhNdjlIcHlvR3EySGJCUmxZeWl3?=
 =?utf-8?B?c2dyUm5aUWlHckRTV3pDMUpraXRtdW1Rc25JZEJORUJHQjAxcTZraW54WTFj?=
 =?utf-8?Q?0xVJ4RACGq6Q/wdw2HXbKQDKv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc90a391-98ba-4162-bb40-08dbd4bd3279
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 18:15:26.5609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdFrywpbAOboHtCv7RJgZwQxYTcqHIrEgm4JEqWLMhe3/+UJcSABpUAkz9Kwj82aIMpCn1lQbAY4bTdnwGlYuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 04:16, Miguel Ojeda wrote:
> On Mon, Oct 23, 2023 at 4:34 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>>
>> Personally, I would rephrase this to:
>>
>> "Please note that, as an end user, there are currently no in-tree drivers
>> or modules suitable or intended for production use."
> 
> Yeah, I think the "yet" -> "currently" change helps, so I took it. I
> haven't changed the "if" to "as" because some readers are not really
> end users but kernel developers/maintainers, so I think it could be a
> bit confusing.
> 
>> I think this will be helpful.
>>
>> Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
> 
> Thanks! I have changed the paragraph to this, can I still use your
> `Reviewed-by`?

Yes, that's perfect.

> 
>    If you are an end user, please note that there are currently no in-tree
>    drivers/modules suitable or intended for production use, and that the Rust
>    support is still in development/experimental, especially for certain kernel
>    configurations.
> 
> Cheers,
> Miguel

Thanks,
Carlos
