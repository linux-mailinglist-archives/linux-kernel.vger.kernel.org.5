Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D47F74A7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbjKXNPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXNPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:15:04 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2073.outbound.protection.outlook.com [40.107.241.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E4B10C6;
        Fri, 24 Nov 2023 05:15:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2Z0yhHCq4YfbCMRHGKHRMyx/QwpLr/wn//eJZuAV320uWciJcwX1juY93+YuLauPs+OtSbfxZIybFt8H+S3FQjUQlacDFxZvAnPWM8hxYnwQNRKg9JvADJNSEwpLrWotpNLDpruAPY1FWtTkbYp7VgJdYGq9wLclXMsx0VFjtusS2ib5ntWpCWBpRjEJhGEa9PhdXf/dBZfiqgOM5zVudUp8bUIZ8NuFzeD8D8GcLlu4VmO/R96Zf3rr21OZKJ2RxG2xi2Pisu7kpPX2EvGavV+061eEJ6fMdpGJqdK4zq+xlzC5WVUSldjEfnOKv/O3qPbDxXY6+e8PUYX0V1CgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AmIIvNlwAPHJFWYNNmum8zBGqeZtZdeDho8aI5+GkE=;
 b=fOE/6Ph9aPB2lOeQ7I+UrrTGnq56HY8arSv7A/cdi6KkoQSjem2qS5KTBrWTEy1ThM+mVtlRgrEKK6Xrw7Ipnhf+Mr5f+OxzFGybUHugy5tLkjjrfBnBcxY7Cp0Mxjmw3hoTcBZEsqTIWOVIJXxCThswF5G3oI/IxCjtX/rvyu2HmVpmncpHq0mcyvbU+Fp/7ozQgIdSYhzW65tocvFWMs5d5zNhB9EyEknQZjwkak5IIeYRjKhCvK4bUOlZiLid/aeUZUlpf01tZAEaVmw7O/t9coD22uG46rqKCsgvDNIokPnIb1fXakOS346SGuXgdHDMIPDCFu7y0UtSFkJKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AmIIvNlwAPHJFWYNNmum8zBGqeZtZdeDho8aI5+GkE=;
 b=OAIEWlicNHEDAVCqYhtUZWubQkHizzvfBobNySkprPjPmMnxX/w8Kq5K4xhwHWgqlpD0TO0WJ1yHSQyoF7r99Vy6cLYomKWFFZuCOs9JluoZOR+OLVYFZxpu/ec5V8iGYyUq1D3yLMvmYnT5guu08qNsaufW3TTGrGfu+AW6uKESg5rbSwfEMxJ/UirAX8IUSXDIfnoUS46XyZ8urc+9dQxf3rQmrpF9BbPUZDbVJQ4yCy255teF/ohIy6mfFga1e/Qsc61stPzfk8TGyjN9ifneFIST34Doy9a+5nsJ3/Y8GhFyvZe8julw6qD2oZJ+EzmzEx/UtWal1jvTfcNarg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB3168.eurprd04.prod.outlook.com (2603:10a6:802:6::10)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Fri, 24 Nov
 2023 13:15:05 +0000
Received: from VI1PR04MB3168.eurprd04.prod.outlook.com
 ([fe80::86f0:1f91:8cf1:8049]) by VI1PR04MB3168.eurprd04.prod.outlook.com
 ([fe80::86f0:1f91:8cf1:8049%3]) with mapi id 15.20.7025.019; Fri, 24 Nov 2023
 13:15:05 +0000
Message-ID: <081ddbc7-8e3a-41c2-b361-3a03dfb3af12@suse.com>
Date:   Fri, 24 Nov 2023 14:15:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] microcode files missing in initramfs imgages from
 dracut (was Re: [PATCH] x86: Clean up remaining references to
 CONFIG_MICROCODE_AMD)
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        lukas.bulwahn@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
References: <20231112181036.GBZVEVHIIj/Oos1cx4@fat_crate.local>
 <0e9cbe6f-ac6c-47f2-b663-a22568799eca@leemhuis.info>
 <20231122115826.GAZV3s4krKXI002KQ0@fat_crate.local>
 <e1ca042c-de1d-4fe3-ad69-51d147b1fe0b@leemhuis.info>
 <20231122155758.GEZV4lBgtZyzsP5Z4V@fat_crate.local>
 <CAHk-=wiV+NM+jLKbSj_Ej9RaXpu4akWV03G_wXyTSHZhArq1tg@mail.gmail.com>
 <20231122205135.GGZV5p157mBi6RYUNs@fat_crate.local>
 <CAHk-=wh03jMZRAxHFTkv0h9dZ6TmiqukzcHd4RTx7ijia_prsg@mail.gmail.com>
 <20231123112013.GAZV81bezsrS6sdJQR@fat_crate.local>
 <66f077cf-ff85-44dc-a76a-05d8995ea261@suse.com>
 <20231124121500.GAZWCTxML94BSYaQf3@fat_crate.local>
From:   Antonio Feijoo <antonio.feijoo@suse.com>
Autocrypt: addr=antonio.feijoo@suse.com; keydata=
 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
 pXW1EqveeQ==
In-Reply-To: <20231124121500.GAZWCTxML94BSYaQf3@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0461.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398::28) To VI1PR04MB3168.eurprd04.prod.outlook.com
 (2603:10a6:802:6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB3168:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b181304-8bee-4b67-19e6-08dbecef5f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQ3DhNiX/ZqVqdMyJIKBf4CKajcTcHVctWCuvv8Qq3512RsMAQ9w+GABPKbfLRIKwCt9BWACU1dOoHpRCS//aoqHhjsxlBS6yzu5fdxXJZrXu8nlIz3XbAeRlpBV87PP1nbruZQfpmHcqCUXrg3+dA0LpycbSY54jnnx5dcxTfpemgAKQyRhvPLyvEs3tmJWnYIWQVDz5oYcmrkkz4Z6I7UIpa+7xdWhEd2gi/grDqbug1cesPsNyeOu2h/bd0E0F16meLynAMdIHq5tIY8W7q5eTzI+utdyvQU4HMW7Hkg9stHZMlkBA1YhfCdCcLqBb94UhdxFX5A0lF09ftaX5hfutFtFKbZ46FBa87AXvMeDNTHu8RtliwAd8XdIfst283RFw9oo2q03XchUOdhUzuq/VvUfpZ/5D2SlMyjHTHlfpc0ftLtkxTV8OBOqLlQ9R5x9llMS/GWnVE5HOhkVUNZ1EaKJ91JME8Jrr8bP4leLZru+JNpHoue2XrtTBzpVIV6iH8FQyk8832cFwFTbLlN6FecI5Dp54lxdTmjkGSaxJ/AvgvXfjoGnTc0beKAJ+unWF0//kTp0RA5vC27sNYmOd2bYYxqNLd/RnQ2CRs+lIPg9XVvBYYXVy70jyxhbUWf2NrxeN4Xh5tEjVc4Jd+/ri8juqJ/u6MySyd7BlAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3168.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(66556008)(66946007)(66476007)(54906003)(38100700002)(36756003)(31696002)(86362001)(5660300002)(2616005)(66574015)(83380400001)(6666004)(6486002)(6506007)(6512007)(7416002)(2906002)(4326008)(8936002)(26005)(6916009)(316002)(478600001)(8676002)(44832011)(41300700001)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rzh2UW16YzI5dXZld3dIZlN5VWNkckVvMGpLb3pFWmUzRjlTTWpjUGxicllp?=
 =?utf-8?B?QmRsa0I3VHhuTHpxNVl5Skt4RE1NZDU2djVHbW5tRTY0TGx1elJLREFqY21k?=
 =?utf-8?B?WC9QRG5vaXdQZ2xCMks1a2VsZzFBeUhuYUVnMW5uQ2F5eFArWlhUSTQvNWlK?=
 =?utf-8?B?c0FuR21wUkZDUldsVWIzVmpJVjdId2JuWTVGYkxWdDVJRVpYZytMQTZUS2di?=
 =?utf-8?B?eDM2T1AyaFNXaEpCd2U4NmFNWHRkSXMrdDAvblp2VVFJSnB3OTdMZnB5YnFC?=
 =?utf-8?B?N1dLL21BZy9GanByT1hRNi9IOTBKSE01Zy9HT0dCdmFEcjhKQWZVc0M2cUVs?=
 =?utf-8?B?MThEa2R0QW1sR0FmRUVsVXVyUnJYUms1YzhkZXF3NlNWR1g0ZnQwT0c3bzJM?=
 =?utf-8?B?Nk10MFg3UENaZjdPYllOZ08rRlhSRXEyajlVQWlQR0lWajdnTGRwMzJEdXd4?=
 =?utf-8?B?Y0Q2N0tBakVxWGh1eEVPdzN0a2FtQmlhenpGWXBoU2x6REYxM2VHcWovN2xq?=
 =?utf-8?B?K1ZYaDZpMkF1YzhTV3p5ZWpBYXBmRVlQaERwRDVhdmFuMmREQ21jVG55bExq?=
 =?utf-8?B?Q2Y5MzZtOVdGSzNoZWQxQ3ByNGo0Z1NpN1dWZ2NBYnlFUWJ0aEdORTRYd0FW?=
 =?utf-8?B?KytXZTV1YUJ2Q2dvMEJMMFFSdkdjVUFiWTVwNkpyRzZHZ2owV3BvMnpNbDBF?=
 =?utf-8?B?b1JoMU5kNE5NemMyT014RHJ5RkVvQXE2QkR5RVh1UXEyQ2VQUjFsSWpodUFB?=
 =?utf-8?B?T0ZwNURpYSt1ZVBocm1GMXpaOFNCeXUxR3NnODRTemdkNkpVVWk4dmNWelR0?=
 =?utf-8?B?TmQvMXJUeDd3Y0ZXdkxZN1kzeGlOOGhROGVEQmhkZHA3SHF4TklYMysydmpv?=
 =?utf-8?B?YUtPUVRlSXBYbytxWWFaUU83VlNxOEtWRG9ueGZoaDR4MFd2OHVFWlZsQzRI?=
 =?utf-8?B?R1k4bXppeSs1THovYmcydmpUTXMrYkJ4d3gxTitFbWhrNDJaUXdOK2N1cmxk?=
 =?utf-8?B?Z2NLdWZOelJ5TWRIWEFTb1V6Z25BY25FUVFiOGNQMlhmbWpkMEd5cjNIZjVR?=
 =?utf-8?B?RFNUUE5VMkM5eUszbnlNd3BGRUh4K0dNMXhJMWpndWlpUXFVbDRSTUEyM2Vz?=
 =?utf-8?B?ZXpJSUR4SWxVWDdKZTlzVmwyV0ZhV2FDUUZ5R0k4bTdiQlV1QlRVREdmQzRu?=
 =?utf-8?B?aEFQYStOUFZSVWJrZ0xDK1RFbkQ4Mk5lMDhjZ29rWVloSHFYUkZXQ2F3cmha?=
 =?utf-8?B?T3owNkRkOTI3dTlhOERmTU1HOXVJbmF0a1RpWU9mM1RPc1ZZWGdpS0RCZUc5?=
 =?utf-8?B?VEdueWNSNVA1R0Fnd1VMMUQ0QTNBOERydU4va2dpak1lZTJHL3JST1dXWlVu?=
 =?utf-8?B?dHpjeVZiU1ZVcm1tTzdtR1JYWTNCb2VRN1BlYWpmd1ArZFdZZkptYnZ4dTdk?=
 =?utf-8?B?cHl0RTAvSzlYalFobEZZcUludnlVS0RwSHFJZzhYeXdxUExwUnR2ejBIbWQ1?=
 =?utf-8?B?bE82TTY1WWxJUFFVbHlYRkMvSzY1MCtuRmZWQTBVMzR1UzFTT2lwUVFUaFIv?=
 =?utf-8?B?UEdUZjE2TTZuemE2azFSN0k4N25LRzJRallhUmh5bjJQSkRYdHAwRUVtK1dy?=
 =?utf-8?B?RGduQ2w3NkJOMUw1cHFhT3Racm9wOHlhOXMvMnd1Y3MzLytwWXU5d2U1TDdQ?=
 =?utf-8?B?SktqeExrR3hiZVE1bk1ZNERMU28zeE1xNDQ1bVV2SExqZXNTTEZ0RDlqclNF?=
 =?utf-8?B?NU1SSTFiSEx6VkNBZDg3dEhWQzcvMU5GVkVnZTFUVzVUN3lyWEJOVGZiaWp6?=
 =?utf-8?B?NjViZmczRXlJUzdNRjIyMGkwUzE3VjNRMVBaaXhwNkVPNjNMcm5NWVBOVkd3?=
 =?utf-8?B?Yjg5TGVxZTZGTCtNVFZrWnFpNER3WnMwb3hsaTF6Y285Z3c4bmx4YTVBZi9I?=
 =?utf-8?B?QituWDdJZGx6UDNQQmpzUFFOUHRZVDFhTG1hQ0x0cS9NcGMwWDY5dUVWbEcw?=
 =?utf-8?B?RnNWdjhybE5ZbklZazVNSk11R0tUVjh1NnM0OW9uNXRwcTh2Zm8zUVFqeldi?=
 =?utf-8?B?NzhBeUxHei9RWE9iSUlydkw0ZXNaN0o2bTUzNHVyMUdKOGo5N2JRRzd5NWhJ?=
 =?utf-8?B?azRNZlB4d1NLSmtUQThxR29KdXlWZXJENWZJd25zU3JWTU9lc3VxckdHdEFy?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b181304-8bee-4b67-19e6-08dbecef5f87
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3168.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 13:15:04.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbxRPaFz1NHO3gjm/1DO+FnTouohp8B7Sr+VjX21iBLrD9kWxx1RAj5sYpbQ2nA9WV064ZSY3V7vjTYD3c/jtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9906
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/11/2023 13.15, Borislav Petkov wrote:
> On Fri, Nov 24, 2023 at 09:49:27AM +0100, Antonio Feijoo wrote:
>> As Linus said, the `check_kernel_config` stuff was implemented in 2014 and this
>> is not the only kernel config option that it's being checked by dracut
>> (CONFIG_ACPI_TABLE_UPGRADE, CONFIG_ACPI_INITRD_TABLE_OVERRIDE, CONFIG_RD_ZSTD),
>> although I agree that it's fragile if something changes. But adding in CC the
>> initramfs list (like you did), would be enough to prepare a simple fix in time.
> 
> Right, how about we give you a more reliable way to check functionality
> built into the kernel instead of grepping the .config file?
> 
> Like the ELF note thing, for example:
> 
> https://lore.kernel.org/r/20231122132419.GBZV4BA399sG2JRFAJ@fat_crate.local
> 
> The current thing is not ABI and will break everytime we change
> something and even if you fix it on time, older dracuts will still be
> broken.

The problem I see is having to add a new patch with a new note every time a
user space application requires new information to query. And also new dracuts
will be broken with older kernels that do not contain this info.
But (from a user space application point of view) if you (the kernel devs) are
ok with this approach, I don't see why we can at least get some info from there.

> 
>> The only problem I see in your patch is that we should also remove the
>> `--early-microcode` option, and dracut will fail if someone pass an option
>> available since 2013 (5f2c30d9bcd614d546d5c55c6897e33f88b9ab90) that would not
>> be recognized now (and by failing, I mean it will not build an initramfs if an
>> unrecognized option is passed).
> 
> Ah ok, --early-microcode becomes a no-op with my change. Sure.
> 
>> Please, submit it to https://github.com/dracutdevs/dracut, so more people can
>> see it and discuss it. Thank you.
> 
> I presume I should read this first:
> 
> https://github.com/dracutdevs/dracut/blob/master/docs/HACKING.md
> 
> and send a github pull request?

Yes, that would be enough.

> Anything else I need to pay attention to when sending dracut patches?

Just follow the Conventional Commit style for the commit messages, but that's
also specified in the HACKING.md doc.

> Or is there also an old school mailing list where I can send the patch
> to?
> 
> :-)

Unfortunately no. All the development process was moved to github.

> 
> Thx.
> 

Thank you,

Best regards.

-- 
Antonio Álvarez Feijoo
System Boot and Init
SUSE
