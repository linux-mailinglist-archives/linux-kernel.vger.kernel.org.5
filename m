Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C0E7F6EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjKXIuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjKXItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:49:51 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1096410F7;
        Fri, 24 Nov 2023 00:49:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQNWCpq3u+ghccmwBFGcfh5iXJlMZXe9wakeS4Qa9mM3S60S2VLQOXMVBb7sGgXImc/GFs7xS0fwls/dZUcflFSe0Ws3nzTPAlNOr5QCx+5ST8d88hjGuvgcs8dDRLxfHTw3xwrFvtXrvNGW7J49VQCjBXS/Zkiyfef/RRi1uniW9T6IWjuJOenQJb9afCix50Pk3aLvln4mT5fz2RY0YcqUeFwdXnaPyRrbgtswYn0dlgX4eGVXw1LMa9GOX8XQsH/wIVx1W0CAewuxAk/xN42wFs6/whPWx0XCfuE58IILEKZ2J6Fw5Sqk0ghyk5aiw/S3D0Lh5e7tRo8+hWbVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ2kSvNUND8O3iANmUc8FZtLZmkTNo5nv9dd8E8hYKc=;
 b=DIedhUNHlVPAE9aFP9tW1/zIXLpoxJOCLnpR4N/+WIY3nA43JfpHV6AveQAsGupcIHuar2b6YOU8D5fNIt8I595FBCew3Eg5ddtuSkDwKfAiemmvpu9eL20DiybQdrhFXz1I5zSEnKwbgK0vFxrJvnk7yVS3djNzH3LFLIeF5PhLzZre3oDhq84ijT/cO7IY74Ao0Hu4KRQhW2ygth7NdD5A/mN/PkmucFH3OcjXfTZxUJwmhEkWmCGwG9XRYc6H04QuLrIb3NZaigW8vhTG4atl4OuRt+L7D6ke9CTXLathZksTq5xvwWxnIDo29/r7360tO61qq9Oz9fDc7kPnyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ2kSvNUND8O3iANmUc8FZtLZmkTNo5nv9dd8E8hYKc=;
 b=hgE4evxoY0o/9Kqf3mfPtwbbtt8EC5ODXBfHojhpO0pD7FjmjkjhgBij0GkeKN3pgX3bUhBFfd2bIrS5yHYtSZWMIwIG3hiRmvaMsA++Dh9QW8inAnil4slYzihqdGPW7njEurbE2b3xlfB7CcdH/5S+giO19YTyx3fad2tmUgV0Pa9b1nfcVwT4PvIEmDq4sFT6U5MGd1qwRDCX27attCX2TwpPdgJI2n2e1LiUtOC5BGCbR1g2Z9s2dyXEVn0IDu2yrg/YozO2faMtSxpTNxZOE8GYJ+ZrVMsJSfhM3WqZ3UeAz40pNkeLJe+r2cyuJeeZLrLtUxlzc638GLpZYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB3168.eurprd04.prod.outlook.com (2603:10a6:802:6::10)
 by DB8PR04MB7083.eurprd04.prod.outlook.com (2603:10a6:10:121::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Fri, 24 Nov
 2023 08:49:30 +0000
Received: from VI1PR04MB3168.eurprd04.prod.outlook.com
 ([fe80::86f0:1f91:8cf1:8049]) by VI1PR04MB3168.eurprd04.prod.outlook.com
 ([fe80::86f0:1f91:8cf1:8049%3]) with mapi id 15.20.7025.019; Fri, 24 Nov 2023
 08:49:30 +0000
Message-ID: <66f077cf-ff85-44dc-a76a-05d8995ea261@suse.com>
Date:   Fri, 24 Nov 2023 09:49:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] microcode files missing in initramfs imgages from
 dracut (was Re: [PATCH] x86: Clean up remaining references to
 CONFIG_MICROCODE_AMD)
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        lukas.bulwahn@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
References: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
 <c67bd324-cec0-4fe4-b3b1-fc1d1e4f2967@leemhuis.info>
 <20231112181036.GBZVEVHIIj/Oos1cx4@fat_crate.local>
 <0e9cbe6f-ac6c-47f2-b663-a22568799eca@leemhuis.info>
 <20231122115826.GAZV3s4krKXI002KQ0@fat_crate.local>
 <e1ca042c-de1d-4fe3-ad69-51d147b1fe0b@leemhuis.info>
 <20231122155758.GEZV4lBgtZyzsP5Z4V@fat_crate.local>
 <CAHk-=wiV+NM+jLKbSj_Ej9RaXpu4akWV03G_wXyTSHZhArq1tg@mail.gmail.com>
 <20231122205135.GGZV5p157mBi6RYUNs@fat_crate.local>
 <CAHk-=wh03jMZRAxHFTkv0h9dZ6TmiqukzcHd4RTx7ijia_prsg@mail.gmail.com>
 <20231123112013.GAZV81bezsrS6sdJQR@fat_crate.local>
From:   Antonio Feijoo <antonio.feijoo@suse.com>
Autocrypt: addr=antonio.feijoo@suse.com; keydata=
 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
 pXW1EqveeQ==
In-Reply-To: <20231123112013.GAZV81bezsrS6sdJQR@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0145.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::10) To VI1PR04MB3168.eurprd04.prod.outlook.com
 (2603:10a6:802:6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB3168:EE_|DB8PR04MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: 8942737a-5961-4d07-cb98-08dbecca4599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2j95d/B+/9zcbL+QmGWQWIRo0gdSzEdQS5eKOVKijr45cWgU2C6SkVKYpygGdLwY3ZjG2O/cUsKdjaSyu9c5xZ1nHi22jyrEvd6Y/ersHPu6602wFaEHHhfLeKP3ykWTboYooqYVrIGHRei3+8uGahkwFyBms13cJEBsrsE78lSus+lt2kniqhMlpmTephfJcCb/D/nmIystSRLtV4/OKszPYFks0/rMjwYD0em8N0Lbqi/8RwTQssUvCXtY4q3c3Xpa7T+s7xL3skOp9I9Bf1UYqa0oUHdTsUFf/W48QX1VNh9kbtEBD7lBXwhVocYOhIveQl9ppO5qTs34YVZrKPw4zE+t4g3+hlDxuWL0knmKx0tszdtTp5B8/qYUBWMcn9HjWuixyhrL87Ms48E37Wd9ORTwwKPdZ3f5SLWOKaCx6/yChbXzvmgZreIv2bvqtLlnUfQjhiGB8zCC9KWjUYJVvuQuxG4Qecmc4eUGzok6lJGbABxk5kTu/6x9qQTzqUfH85sNp5utLouH5oMZBHvzM7E9qIaFuOu9kkTY/UHWiYXqQKLwk1aWfDvMCzf4WKX+cnxyRgp+CtV5Pl2Kh2kv1guR+SDcf3td1IyaSCUc4D9UXtmagXP23r+WvT++eRaq5kUugV2p0q+//n+og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3168.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(7416002)(5660300002)(44832011)(36756003)(31696002)(86362001)(41300700001)(38100700002)(66946007)(26005)(66476007)(66556008)(6512007)(2616005)(110136005)(316002)(6666004)(478600001)(6486002)(31686004)(966005)(6506007)(4326008)(66574015)(8676002)(8936002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU5sUy9aenZYWGVJSjdpeGJWY2xOL1pCZURSbTVVbHNmWE5pV3FTaE10RWdm?=
 =?utf-8?B?eTFBSXM0UTlwaU1BWVVZTERqMi9VVld6VTRPWUs0SU83M0RzTkZrRE5YTlpS?=
 =?utf-8?B?cGIvMFhnZno2RnF5Wi9rWVJsY3pHZGFrVjNPYTQwcWtuYVVxODJibHpOR3Bp?=
 =?utf-8?B?Z1k3NGhURkh2Ni9yTGNVRDcrUzlXZ3cxTERFU1pZZXhVVUFScmQ0TCtqZ0px?=
 =?utf-8?B?TzkrNmJkaU1yMVh5cUliSWVlWEJQNElXNW9rQ3YyTG92SWg3dlBNTkxWemx0?=
 =?utf-8?B?MmdyTkZPUnRpMEozRlRIUG5FdkVwWXRMcGFydFJUanVjQ21RRkRsbktUM1M2?=
 =?utf-8?B?MTdCOTRsalRLd3VuUVcvN1FCOW15MDl4OUNuTGcxWDU0QnRncFVFSEN1UzZU?=
 =?utf-8?B?eXd0eGkra1d2VkYwOUNCM3d3Z1owTXE0RWVCWGczY0ZBRzB3Mmc3aXFTM295?=
 =?utf-8?B?QnpRM1MweDZiRzkzeUFYMVNabjVZUVZtTWJpMlUxLzRCZnRzMlhSeEhKVTFy?=
 =?utf-8?B?WnFQT0lTQzh2YlJ2SDlIanhVNmJBNGRpR0ZTclNlNks4clJMRGN4VE9ia1Va?=
 =?utf-8?B?TTF1YThUb2lRZ2o2OFZIM3l5cUxIbFRFbjF4VEtGV0RIVnI2VkZmSThGcWYy?=
 =?utf-8?B?M0prSjYzanVNOGxncHJZNTBkWlhaTVhDU1FpU3JMclhVYXBRMnR0TDR4LzFQ?=
 =?utf-8?B?M01PVWlPR2swTy9nN1pCTDlRbVUrbjcrRStNY2x0ZUxFcEtlUVlPL3NBVVhj?=
 =?utf-8?B?QmpYb3VYOVJyZm1GMHRYOWd6WVBocWZQdlRlaVlOU3BPOFVWbFpkaUFybGdW?=
 =?utf-8?B?alUrdXlCZGQ4WDBtcGZZNUExUEZacCtGeDl4VjNVcEp4SXcxUDYxZWY0Q2tY?=
 =?utf-8?B?MisvV0M3WmRYZ0JKRitRZld6aW13aERJM2JVOVoweTdtdVhFa0d4NnF5b25l?=
 =?utf-8?B?OGQreEc1aXozcTNCUzcwOS9MelUwaU1CYU9oTUE2WEpjQ2Z5RCtWZ3Z2aDB6?=
 =?utf-8?B?bkkyYTlVb2MvRnI4MUhrL1kvSGhqM2g0Y3JFUVRQYzBEVytaN1dxNkQyWVlW?=
 =?utf-8?B?a2FBQ3ltQ0tsN3FEUjBQVEw1ODFKTU43TkZEcEhkV2lTVytEUXo5ZlNhdmFk?=
 =?utf-8?B?K3owaEdmZlQ4K0FXMzlRSkpDQjRQMkdodG11ODBvQ1VMamt0akNuSzhsRzZs?=
 =?utf-8?B?R0hrRXBZVUNIMFh2Ry9UM3VXYjc0b3Y0SDd4S2dFY09ubGJ3L0pkbVQydzhx?=
 =?utf-8?B?RTNkSjRpM0l2bThhVVRydWJ4MGxWWG5RWUdrRzZZclRqeDcwN2pDdjFZd3pZ?=
 =?utf-8?B?OUtNR1dybjdlME1LeXUzbURWR3NmNWlNQmovbUJHVDNHOTZqS0wwS2IwNlhp?=
 =?utf-8?B?dllORHRCdXJXWmJzZHovcXNLQktuMEdTMVdTK1NvMnRCMmtTaTZxN09MSDVC?=
 =?utf-8?B?U2xDNFRlcCt2YXI1SXd6OEFhb3QyaVVuVWxIWGV4QXc0TGFHSDlmRlZud3U0?=
 =?utf-8?B?OWU1MC84bVIzankvZWxDWWI5UFpBdmxuUUF3ajJSUXVnNFZqU2xtUTZIdWVI?=
 =?utf-8?B?bkdmSmxHNnRsR1hQVmQ4OVMrcFRDNlNHQmFVZmVldndEeTB2OEM1NUcwOFpR?=
 =?utf-8?B?cEVFQlFhWnNmZkRSSVl6aU11N0U0ZGNPdHhEUTRUc0tYc05mR1RxSGtyNnJi?=
 =?utf-8?B?TzFUUThWaDhFTnFpS0ZFOS9DSkFnYU5aSlFlZnFBd203clNacVZnOFY0RC9a?=
 =?utf-8?B?UUNQYktLc2xlSFp1Mk5kZ2JpWmorMzFjQms2UlBGYW96NEJ4V1Rmenp5WVRx?=
 =?utf-8?B?c1NTQXRQUzRmOVRCN0xUODNxRzlXTnVHaW0yd0FZTFU3VXNCd0JDV2JMRVpK?=
 =?utf-8?B?SmNheC9JODF5dVY4NWJWWHRwRjYvMEVHSmpMMXhJSVRTbFpaeXdJcDJKcHhi?=
 =?utf-8?B?eHRpL1AraWpHMXVta2FOTjFDV3RidHJmVXRIZTZZcXJ0Y09aaE0xYzF3U3Ju?=
 =?utf-8?B?bmZWYTdZRTJRSE1hTWdtbmtFK1FQK0JQQ0w1NndRd3AyYWszR1BiMmtXZ2Nh?=
 =?utf-8?B?b1lCNkloS3pzRGg4cGZ2d2wrREJMeEkzZnVvcEVWamIzRkx2Yzl4YjNYUThP?=
 =?utf-8?B?S0NFSGFrb3VuK3pTVlhHV2JmNkU5dXRScmN2UDRjbHgzWnVJVzBaWE96SUd1?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8942737a-5961-4d07-cb98-08dbecca4599
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3168.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 08:49:30.2480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGQYJThi8mkX4ECm/X0tHSVCjO1Ts9s4TO1D2kgHAuDaD5IO/pspZEAP41/uo69QTwOatItDvDAoxg1wsIjy2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a side note, complaints about this issue reached the kernel because most
distros out there didn't do their homework, as this patch has been merged
upstream since 6.6-rc1 was released. Fortunately, this problem does not break
the system boot.

As Linus said, the `check_kernel_config` stuff was implemented in 2014 and this
is not the only kernel config option that it's being checked by dracut
(CONFIG_ACPI_TABLE_UPGRADE, CONFIG_ACPI_INITRD_TABLE_OVERRIDE, CONFIG_RD_ZSTD),
although I agree that it's fragile if something changes. But adding in CC the
initramfs list (like you did), would be enough to prepare a simple fix in time.

On 23/11/2023 12.20, Borislav Petkov wrote:
> Adding Antonio who did that last fix to dracut:
> 
> 6c80408c8644 ("fix(dracut.sh): remove microcode check based on CONFIG_MICROCODE_[AMD|INTEL]")
> 
> On Wed, Nov 22, 2023 at 01:08:41PM -0800, Linus Torvalds wrote:
>> There are dracut command lines, like "--early-microcode" and
>> "--no-early-microcode", so people who really want to save space could
>> just force it that way. Doing the CONFIG_xyz check seems broken.
>>
>> But that's for the dracut people to worry about.
> 
> Yeah, I guess something like this below.
> 
> Antonio, how about something like the totally untested thing below?
> 
> dracut would simply always build in microcode - this is the majority of
> the setups anyway - and people who want to save space, do:
> 
> --no-early-microcode
> 
> ?

The only problem I see in your patch is that we should also remove the
`--early-microcode` option, and dracut will fail if someone pass an option
available since 2013 (5f2c30d9bcd614d546d5c55c6897e33f88b9ab90) that would not
be recognized now (and by failing, I mean it will not build an initramfs if an
unrecognized option is passed).

Please, submit it to https://github.com/dracutdevs/dracut, so more people can
see it and discuss it. Thank you.

> ---
> diff --git a/dracut.sh b/dracut.sh
> index 3b292910f324..c0a88b083f8e 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -1561,20 +1561,16 @@ fi
>  
>  if [[ $early_microcode == yes ]]; then
>      if [[ $hostonly ]]; then
> -        if [[ $(get_cpu_vendor) == "AMD" || $(get_cpu_vendor) == "Intel" ]]; then
> -            check_kernel_config CONFIG_MICROCODE || unset early_microcode
> -        else
> +        if [[ $(get_cpu_vendor) != "AMD" && $(get_cpu_vendor) != "Intel" ]]; then
>              unset early_microcode
>          fi
> -    else
> -        ! check_kernel_config CONFIG_MICROCODE \
> -            && unset early_microcode
>      fi
> +
>      # Do not complain on non-x86 architectures as it makes no sense
>      case "${DRACUT_ARCH:-$(uname -m)}" in
>          x86_64 | i?86)
>              [[ $early_microcode != yes ]] \
> -                && dwarn "Disabling early microcode, because kernel does not support it. CONFIG_MICROCODE!=y"
> +                && dwarn "Disabling early microcode, unsupported configuration"
>              ;;
>          *) ;;
>      esac
> 
> Thx.
> 

Best regards,

-- 
Antonio Álvarez Feijoo
System Boot and Init
SUSE
