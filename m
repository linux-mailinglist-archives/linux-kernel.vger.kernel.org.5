Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F43780103
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355726AbjHQW2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355724AbjHQW1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:27:44 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2058.outbound.protection.outlook.com [40.107.24.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE1030DC;
        Thu, 17 Aug 2023 15:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bdnf4n4r0zzd52r54eF8e6qyqtjZepxgmgjYXyezEOsQuRpftIytMu7NU559/4d+0yW5P5egKP3jZACv5NdIgttN2mbz3UHONVgBeN+MNN3dMKgjMXmnYttkAKK1+nZlhUK6w74tITBZFDmv3yhFGFmqqNgjQPVtz38RWGK2bjSJ6HMGW6dfAw6KwW2IBTxgwMzmtS8p+/Jpw4Qsae7t1qjAV9SV+2Type2b0aJnbRkoKNkR3dE3mdbEKriVSdNvah/KUF5ttJSMVW8ZdbP9Y6ORhzZzzanPEc+6G9gRRPldLDHhZco5Ujafv9OmncyuNQ61bTtxCbprEJMrH9VtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFTUgx/jZQYkjeO9OxukCBNJGpRVquTSP848KGfnOIk=;
 b=F8lxmVE/ZZgnEnOn1K6/vS6M3Z91EdAzwGHKdD7QPGTt8PjJR1OLFPa9et4gi9wHXB5w5g7Bkb0bDYbd/r7dTUX4MbB17CE4LvZrOJaW2dcmgQ2BTwlvXq6igngZmHqE2TzuJ/j9MaU8kCTi/aeJItHptmjpd+w9hRrVQ18htyC3fl68YZJnqK5yRMuCEmn5xNM7/fCApa4t+bXYNKJ/QCGl/MKgqoqc1caz4p+Rpsd7GbZ/LyzF9Lcc4tt9Z6mFlz/lL3LuxsyRjIq7mQpmBtJi6RT/wKrIP0LQymq5MUsjDJlGg5G38GcygVvb3SFKUSBNHQ3xw5Nj1+wj+UYHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=usi.ch; dmarc=pass action=none header.from=usi.ch; dkim=pass
 header.d=usi.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usi365.onmicrosoft.com; s=selector2-usi365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFTUgx/jZQYkjeO9OxukCBNJGpRVquTSP848KGfnOIk=;
 b=mHofeyns0JP6KF/94Mr9EJzPITFBwCeNANu2yji2sh2M4HXvre6imQ/ACGPa4JEPRODFHzbadeOkca2EtwPCJcrL51Z6JlypsF8J/3SAHLP5/pDMb6MSCJEUtBWMrge2nGRzxPCiNJyb0CwtT8vQTB2pM09HLALeXONKbYHu3HU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=usi.ch;
Received: from GV0P278MB0163.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2f::10)
 by ZR0P278MB0871.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Thu, 17 Aug
 2023 22:27:37 +0000
Received: from GV0P278MB0163.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9057:82cc:fc98:1f5]) by GV0P278MB0163.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9057:82cc:fc98:1f5%7]) with mapi id 15.20.6699.020; Thu, 17 Aug 2023
 22:27:37 +0000
Message-ID: <bddea099-4468-4f96-2e06-2b207b608485@usi.ch>
Date:   Fri, 18 Aug 2023 00:27:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michele Dalle Rive <dallerivemichele@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Davide Rovelli <davide.rovelli@usi.ch>,
        rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
 <2023081411-apache-tubeless-7bb3@gregkh>
 <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
 <CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com>
 <e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch>
 <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
 <CANiq72=3z+FcyYGV0upsezGAkh2J4EmzbJ=5s374gf=10AYnUQ@mail.gmail.com>
From:   Davide Rovelli <roveld@usi.ch>
In-Reply-To: <CANiq72=3z+FcyYGV0upsezGAkh2J4EmzbJ=5s374gf=10AYnUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0102.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::31) To GV0P278MB0163.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV0P278MB0163:EE_|ZR0P278MB0871:EE_
X-MS-Office365-Filtering-Correlation-Id: 0349b814-d288-4d67-9a70-08db9f7128f1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/ex0lrKXX6XxrUjBry+qiQZGvfJFlDVJM+w6pPEo8T05MYCuOf+uMWZzaCYcjjWSpQxiW/rs6+qQAvIBlOOpgqVy78YXPwqX2pBLl18GwIL3nUbBPRmv9SUTvR3xP7QQxhV/XEUDyC5i/2s1oV3mkSrZ7zubwra7dIYee9xjvDK2PoYM9dZwiNbvRb7KymRseD5FXvcWScKg1JxGtZ/qAtqT73A8PjS7v9e5aFV9f8y8AAKIz3azly90uwrMWOdis1z3fmjnKb2BGcCfjoqxDEKYMif+kS3Er1vGl7qDHnPnD51TBIAOEkVTxtizU3fDChkGBIoRxHbnqn7qooMrmGL3WiiCEECW23x6u/rzG84gUSj+B2tTmK1bJLSv3t2MbPmxtSrrOu1VH5y65Bolj7GcIHKYbzxG//7O1hdw/kOWG90qotHVB2TR5BeQrOOBbsB5rfFV98+StfhkRrcIcZrzwqYPvi3zvViWKr7XHpzx4l+AJ9UvR8/LlvPEr2fogl4pD1YhJcW0UMOQuszcHb1EGSTeBdxUQgeYWeNt7gyr0o1x8oMCyN8ifXrBMEg27H0xaBhvmE+tL0ix8AACzqvVq4sJGeuk3NkyB/NTnmSS7zDTWfViPmsg5LXSAkSdWh14UK9KO0vZ24xtNNFMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0163.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39840400004)(346002)(136003)(451199024)(1800799009)(186009)(83380400001)(7416002)(2906002)(66946007)(66476007)(66556008)(54906003)(110136005)(6666004)(6486002)(316002)(786003)(966005)(5660300002)(478600001)(2616005)(8676002)(8936002)(53546011)(6512007)(6506007)(41300700001)(4326008)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlnNGhDVllneWJTTEdsd1RXZHQ1MGZrUHc1d0ZwcitkTi9EQTlPaG1XRWhO?=
 =?utf-8?B?VjFBV1JjQktmQWZTdGRSQWhpVDNDcnFwd1QrV2VqbldST1Q1SWx3aVg3eU9u?=
 =?utf-8?B?T2FpV3gxTU9PaG0zYjEvUXBIeFZZSVhRbGVML3JWMDNueGtjUjQwUDJ6Y09z?=
 =?utf-8?B?TjhGVHk5TTFaVzc3MFdlU0pybXBYZVgxZ3VLQjRqMmZ4T2M0Z09DbGY3a1dK?=
 =?utf-8?B?N2oxSTRTZzJKTmhic2Y3d0o3ZG5iNnpqdFN4bitYVFdFZlNZSXk5OTdHdVJi?=
 =?utf-8?B?bjU4bjB0NUNkbHlxVUlyTGxrcFc0a0hlZDBjWHBiem85TXNNb2FFZTBtQ3Rv?=
 =?utf-8?B?NXVMRGNNdm1wRXhoMTlkRmhSeTJvY0NGaWtnaTlyTEhSeGtCVjFxeGJhRWd4?=
 =?utf-8?B?bkN2b3MzdzVoSCsxNVVpcnNzdktXUkxxNzJPTC8yazF3cHVHVU1MdmlZN09F?=
 =?utf-8?B?Q1ZFZmlwckQxNThxQWc1YUcrOW5WWnNaSlB5Y3ArT1VyYmVTTkJlYnIyQkkx?=
 =?utf-8?B?NWpreUlqODliSTE2TVR0a2VzRFlrd0NmWWJRcURYQ0Q3cytxVUphM3pMTGU4?=
 =?utf-8?B?cGluNGZvQ1pibkMxVk5NOHMwL29QRUY3TVNVRWFDbVhuVUFMNUg5RWpPRnNt?=
 =?utf-8?B?K2dpRXczK3R6bU5DUU12b24zdlJOVmpreDhrdXN3eWQ5VEZxWFpQRnF1aWZh?=
 =?utf-8?B?ZkRLVTROQU5rZVJqWG1jQTlqUVRyRm9RdnpEdTNTWHgwY0dSS3VyZEc3Umgv?=
 =?utf-8?B?KytramJDUStqVUNmc3BjY1dsVXBwZmhZR016ZFczZElVWU5CQXdBYncwWlN4?=
 =?utf-8?B?UTRjemhaZVY1eGRPcjVBNXdqR2pMRGdCWTFJRDlEb0NxMC9VUHU0VWJpRCtO?=
 =?utf-8?B?WXFXTVZwUXpqeitIL25VVVRnNVFnMDM4ZzdRWXJETzlKM2I3UUp0cDYySkFC?=
 =?utf-8?B?YnJlUmxBMTlZWU5mcHlvMEVmNVlyby91andlNGFyaFJRKzBaS0VMMUNKNHhX?=
 =?utf-8?B?dVBkalNFMXIwM2g1UkhMRjFBZFNDcVgxNlRlRUNzRXVuWXF3dUl1cU8ybFM3?=
 =?utf-8?B?SVRqNVltKzBYWjhXSEpkWk5PVnlNL2srckdDeW95ZmZFbFVZaE8zUlNobDdJ?=
 =?utf-8?B?NzB2cGdIQ2dFWGQ1UlZxY3VZbHhKencxSlI5dm95MGdjVXBCemlBaHZ1MUUy?=
 =?utf-8?B?NlpBcHVoZVQxVEJSa1Z2THR4NVFWM3Ryd0lEczdFa1liTjViYVYwMjdZZ3Vh?=
 =?utf-8?B?TUVGVFNVL21YcDMrSGlodHMveU54SGNodHdia3g4V24xVnhmNXR0TEM1OW9E?=
 =?utf-8?B?ajcra1pXL0pBOWFodnJPOFhyQnAwdkswWWovMldtS2RDaXNNQkxZeTNvQmVV?=
 =?utf-8?B?V0YvMDdpN3loWUtrOXJHSjJRTXpiOGpvU1FzMldmQW5BWTRmYlFndHArRmdM?=
 =?utf-8?B?R1lqNGEzMnJFMnlKNldob2pmZnNlV3FDTzEwVzlGSVNWSXQ5c3d4Wkh5ZHlX?=
 =?utf-8?B?UU01WWs5ZHpLZ3pNcTR5RlR6T0FxNTRhVjNYbjJIY05ybUp1MDJuTzBtSnlp?=
 =?utf-8?B?THllRXk4SXhxMjZYTDF3ZDh4T2JsVlF6K2Z0dmh2aW5hRU53eGNqYjJRV2c0?=
 =?utf-8?B?YkVRZ2lCa09CNHZnZGszcmxXd1VhSW1jWXMxNVBWWWJoUHFjRjJXM1k1Mkdj?=
 =?utf-8?B?QUsxVmF6cW1iKzh3NFF2TTJ4b0htMkxpTmRibkFTMVRpMCtldnZoR05Fc0Q1?=
 =?utf-8?B?Rmp2SHZPZFJ1NU4yRGZkUDFPZmJ3b1E4WXJ5ekdaZHYzR2VlK0hENnBZYzZw?=
 =?utf-8?B?TDVLYkhTVzJrUzFNTXZtR1FWZCtxcVZGbHpGVGhJNDREaGFVZlZhQjNoV0VQ?=
 =?utf-8?B?MWtpeXdiZDNhOFNpV0cxdUZKT3Y0QnYxek5MNHZHdkg3aVRtWTZ3ZGNJQWxr?=
 =?utf-8?B?NElxRzRhZG9ERWludWQrYVVERmVnejc0Zk9BNVdBMnVGWklaN1ZrZWdFUzdu?=
 =?utf-8?B?SFd2YzUwWjJ1bjBMdkU1RXBQditMZEx4eGltYnBiSXhTQ2x0aDdJU00waE1F?=
 =?utf-8?B?Y0tsc2lrNmtENVRGVUtIbEhuNExudkZ5cmx6SUxxLzZ0ZUdZNXZDY2ZySkd5?=
 =?utf-8?B?YkVkckdKa21zYkt4Q0lOUXJMVitVREMzd1hac1RnQ3doSGFRYVFMMUxaaEpv?=
 =?utf-8?Q?epCUjpRlj7mJcBtQtrBmPBU=3D?=
X-OriginatorOrg: usi.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 0349b814-d288-4d67-9a70-08db9f7128f1
X-MS-Exchange-CrossTenant-AuthSource: GV0P278MB0163.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 22:27:37.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 95bdc5ac-afb5-4881-801b-3874f365cd6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/ptRhyVGP7+q5t+6MRJRLF6bVMxW7hzKcez3td9YNH8B9rxf3pjWyszy/HS/U/c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0871
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 19:14, Miguel Ojeda wrote:
> On Thu, Aug 17, 2023 at 4:53 PM Michele Dalle Rive
> <dallerivemichele@gmail.com> wrote:
>>
>> The idea behind this patch is that, as of now, Rust is not a viable option for
>> any OOT module that requires even the highest-level network support.
>>
>> I am wondering whether the `net` subsystem is interested in reviewing, giving
>> feedback and eventually accepting code that is currently OOT-only.
> 
> It is unlikely kernel maintainers in general accept code intended for
> out-of-tree modules only.
> 
> To be clear, Rust for Linux's focus has never been out-of-tree
> modules. In fact, the whole effort since the beginning was about
> adding support for Rust in-tree, unlike other projects that e.g.
> linked `rustc`-built object files into an out-of-tree kernel module.
> 
> We do support out-of-tree modules, and have a sample of that, but that
> is just only to the degree that the kernel supports out-of-tree
> modules in general.
> 
> The abstractions that have been upstreamed so far are those that have
> (or should soon have) a user in-tree. Sometimes we have had to bend a
> bit the rules in order to split the dependency chain or make things
> easier, but abstractions (in general) cannot be upstreamed that do not
> have at least an expected and public user that is going upstream too.
> Here, by user, we generally mean an actual driver or useful component
> (rather than a sample).
> 
> If I understood correctly from Zulip, you cannot (right now) show your
> use case because it is confidential and therefore you cannot upstream
> it, so we will need another user (and, of course, that is a necessary
> but not sufficient condition for the code to be accepted).

Correct. I work with Michele, let me clarify. We are a research lab 
working on a low-jitter networking prototype implemented as an internal 
LKM (our last paper: 
https://www.usenix.org/system/files/atc21-jahnke.pdf). When trying to 
convert it to Rust, we noticed the lack of socket abstractions which 
Michele implemented. We then simply thought about sharing the 
abstractions with the community since they could fit a variety of 
use-cases - hence the patch.
We now understand the necessity of a concrete in-tree user, apologies 
for not realising this earlier: we are indeed new to patch process as 
you probably understood.
Our prototype might become available in the future but there's no clear 
path on when, this is our starting point.

> Of course, this does not preclude discussing about them or having a
> `rust-net` branch or sub-subsystem or similar. That could be quite
> useful so develop those users and to experiment. In fact, we are
> actively trying to onboard more people (and companies and other
> entities) to the Rust overall kernel effort, so please feel free to
> join us.

We will be more than happy to. In fact, I think the best place for this 
patch would be in a net branch/subsystem of the Rust for Linux repo. As 
mentioned in the Zulip chat, it's hard to provide a "full-fledged" patch 
in Rust at this point as many network building blocks are missing. The 
result is a number of bindings patches such as this one which do not 
match maintainers' interests but could be useful for other developers to 
eventually make a concrete user. It would have helped us significantly 
when starting this project, I think other researchers/developers share 
the same view.
If anyone is interested, we could add these patches to the mailing list 
with a low priority tag for feedback.

> By the way, I am a bit confused -- the patch seems to add an in-tree
> sample, not an out-of-tree one.

It is an in-tree sample, I guess Michele meant an "out-of-tree use-case" 
as in the sample doesn't introduce new core features in the kernel, just 
showcasing.
