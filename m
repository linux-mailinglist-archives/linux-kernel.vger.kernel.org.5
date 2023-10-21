Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E54E7D1C4D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjJUJxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjJUJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:53:41 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD7A1A3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:53:36 -0700 (PDT)
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
        by cmsmtp with ESMTPS
        id tlCjqPC1nhqFdu8fnqWHWF; Sat, 21 Oct 2023 09:53:35 +0000
Received: from shared083.arvixe.com ([143.95.229.40])
        by cmsmtp with ESMTPS
        id u8fmqGPgbRqxCu8fnqcfSe; Sat, 21 Oct 2023 09:53:35 +0000
X-Authority-Analysis: v=2.4 cv=IY2U5Ema c=1 sm=1 tr=0 ts=65339f9f
 a=GmS1SBToaRoMP0YkDtvSoA==:117 a=GmS1SBToaRoMP0YkDtvSoA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=--C6PtRGR58A:10 a=6rG29qTtAAAA:8
 a=W3oY0It-uVSGyoCTqBsA:9 a=QEXdDO2ut3YA:10 a=SUYTu1jUCiDWs7I31qRB:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=donjajo.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=69ezUPYJn99d3j3dKdmt5HU1Ta24VPvwrPsVIjI3toI=; b=Z93zyyakkC6J7gfwU5FzOlTJKJ
        XILRAZyHjNvdf8cM+WHaBA/BqYW6pfGsjCkNVVOP8N8QXpj3JeXhJ/GHSw3Ur3JfeTB1IxoTra1VZ
        6IoOPwfpd24MhZLPbKLGompGMixwpSx61Uvfr8JO3gVW+niRmdBmSwp0DfBgmpRsSySx01PCnvyQQ
        CVjpbnBeaCGuekrbrNh3DdnGolaWSL/pE9skiDIxMKTLoJDnGtzsqq8vem7QqU5ux+/cUfGzVOBnJ
        4ToRBnvk33smEKVkmb8n1dHUbKYOx+BlXOOBraFr5NUYdjpBRW80w7itdwaJd205Gz8W6ZSuOFdAp
        RSn9P/+w==;
Received: from [41.66.218.188] (port=53078 helo=[192.168.1.244])
        by shared083.arvixe.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <me@donjajo.com>)
        id 1qu8fm-000agM-0B;
        Sat, 21 Oct 2023 04:53:34 -0500
Message-ID: <258f0947-afea-4676-a0cf-51bd4dc41d1c@donjajo.com>
Date:   Sat, 21 Oct 2023 09:53:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS
 Lock and PrntScrn on Zenbook S 13 UX5304VA
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com>
 <132feb67-c147-7ee6-b337-385e11786ec6@redhat.com>
 <146cb960-406b-4456-94ce-ad6ed3f330ad@donjajo.com>
 <d70f7d35-6458-437d-f68f-47291ce74a1e@redhat.com>
 <90a7309e-4a76-4dff-8259-9975dd3ed8b1@donjajo.com>
 <938c83c4-973d-ac23-bfb6-53c63c153d81@redhat.com>
 <6c97dc9e9cfea6e18c59d717e5973255@donjajo.com>
 <d8c5c530-9eea-5acb-f7f7-7f7af56e700d@redhat.com>
 <92d930f8-5e3f-4137-8fad-8639de5e2f9c@donjajo.com>
 <d452fc76-26a1-eb08-d855-5b9d5fabb039@redhat.com>
Content-Language: en-US
From:   James John <me@donjajo.com>
In-Reply-To: <d452fc76-26a1-eb08-d855-5b9d5fabb039@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - shared083.arvixe.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - donjajo.com
X-BWhitelist: no
X-Source-IP: 41.66.218.188
X-Source-L: No
X-Exim-ID: 1qu8fm-000agM-0B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.244]) [41.66.218.188]:53078
X-Source-Auth: me@donjajo.com
X-Email-Count: 1
X-Org:  HG=asoshared_arvixe;ORG=aso;
X-Source-Cap: b3h5aG9scmU7b3h5aG9scmU7c2hhcmVkMDgzLmFydml4ZS5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP3wMYMJGN6/G3IsL8UuZKqWIrRtQn6aOqob9AQzTTFE0bPsgVpqQa4UBYcKLddZZ5W0JoiSKk7JFPSVVHIF7ngl+dnk+LeonBw0EmUaNFIsGakh1Ev6
 FyGGxYJYgbzh3MAfoRONiG0zqzZr5xqUob4Z3JN/Uovmk/LGLVh2PDv2Ayga4vcgddiuFIs6WkVJ+qy79pdSXuYriiFmIleTEzs=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That is noted. I have learnt some things while solving this.

Thank you

On 21/10/2023 09:46, Hans de Goede wrote:
> Hi James,
>
> On 10/20/23 01:22, James John wrote:
>> Hello Hans,
>>
>> Thank you for your support so far. I really appreciate this.
>>
>> I have always wanted to contribute to the kernel, so, this is fun for me! :)
> That is great and thank you for all your help with solving this.
>
>> The 2 evtest logs show that each brightness up/down keypress
>> gets reported twice, once by the "ACPI video bus" device and
>> once bythe "Asus WMI hotkeys" device.
>>
>> I do not think these are multiple events. There are different. One has the value of 0, the other has value of 1.
>> I am not sure what they mean. I initially thought it could be keydown and keyup events, but it is not, because
>> on pressing the keydown, they are still both reported. I also think the desktops handle this, maybe by filtering out
>> 0 values. I use KDE Plasma, and I still have 5% step despite evtest reporting these 2 events.
> The 1 / 0 events are indeed press / release events that is
> not the problem, the problem is that a single keypress reports
> these events on 2 different /dev/input/event# nodes.
>
> Interesting that this is not a problem for KDE, I know it is
> a problem for GNOME. I guess KDE may do some filtering of
> the duplicate events itself.
>
>> I have applied the last 2 patches.
>>
>> 1. Show no output for capslock / printscreen
>>
>> Correct. These keys are no longer captured by Asus WMI hotkeys
>>
>> 2. Show KEY_SELECTIVE_SCREENSHOT events for the
>>     "Screen Capture" hotkey.
>>
>> I am not sure I am getting KEY_SELECTIVE_SCREENSHOT event for the "Screen Capture" hotkey. This is what I get:
>> Event: time 1697757579.588239, type 4 (EV_MSC), code 4 (MSC_SCAN), value 2a
>> Event: time 1697757579.588239, type 1 (EV_KEY), code 634 (?), value 1
>> Event: time 1697757579.588239, -------------- SYN_REPORT ------------
>> Event: time 1697757579.588244, type 1 (EV_KEY), code 634 (?), value 0
>> Event: time 1697757579.588244, -------------- SYN_REPORT ------------
> This is actually the correct output, 634 is 0x27a hexadecimal and:
>
> /usr/include/linux/input-event-codes.h :
>
> /* Select an area of screen to be copied */
> #define KEY_SELECTIVE_SCREENSHOT        0x27a
>
> This is a somewhat (but not really) recent addition to the list
> of KEY_foo defines, so I guess you are just using a somewhat old
> evtest which does not know this code yet.
>
>> And this is what I get for "Screen Capture" hotkey, from the debug you placed
>> [ 1096.691389] asus_wmi: raw event code 0x2a
>> [ 1096.691446] asus_wmi: raw event code 0xffffffffffffffff
>> [ 1097.982976] asus_wmi: raw event code 0x2a
>> [ 1097.983032] asus_wmi: raw event code 0xffffffffffffffff
>>
>>
>> 3. Show no output for brightness up/down,
>>     yet brightness up/down should still work since
>>     these are also reported by the "ACPI video bus"
>>
>> Yes, correct. No output from Asus WMI hotkeys, but there an output from Video bus
> Great, that means that everything works as it should now, thank you.
>
> Regards,
>
> Hans
>
>
>
>
>
>
>> On 18/10/2023 19:35, Hans de Goede wrote:
>>> Hi James,
>>>
>>> On 10/18/23 02:17, me@donjajo.com wrote:
>>>> Hi Hans,
>>>>
>>>> I hope you are feeling better now.
>>>> Thank you so much for your support in resolving this.
>>>>
>>>>> I assume that the first "BACKLIGHT BUTTON" is the backlight DOWN button ?
>>>> Yes. Correct.
>>>>
>>>>
>>>>> 2. Can you please run:
>>>>>
>>>>> sudo evtest and then select the "ACPI video bus" (or something
>>>>> similar) device and see if that reports brightness up/down
>>>>> keypresses?  And then do the same thing for the
>>>>> "Asus WMI hotkeys" device ? I expect the Asus WMI hotkeys
>>>>> device to only report brightness up keypresses (after my
>>>>> hwdb "fix") while I expect brightness-up events to get
>>>>> reported twice, by both the "ACPI video bus" device and
>>>>> the "Asus WMI hotkeys" device.
>>>> Done and attached.
>>>>
>>>>> Can you confirm this? This also means that brightness
>>>>> up will take bigger steps (2 steps per keypress) then
>>>>> brightness down, right ?
>>>> I am not sure I understand what you mean here. But I have attached the output here
>>> The 2 evtest logs show that each brightness up/down keypress
>>> gets reported twice, once by the "ACPI video bus" device and
>>> once bythe "Asus WMI hotkeys" device.
>>>
>>> This means that in e.g. GNOME the brightness will move
>>> up / down by 2 steps for each step, reducing the amount
>>> of steps from 20 to 10, or iow making each step twice
>>> as big. Especially at the low end of the brightness
>>> scale this may be an issue since steeping by 5% there
>>> can already make a big difference and this double
>>> key press reporting now changes this into stepping
>>> by 10% at a time.
>>>
>>>> After applying your patch, it seems to have fixed the issue!
>>> Thank you for all the testing and other then the double
>>> keypress issue + the unknown code messages everything
>>> now looks good!
>>>
>>> I have applied 2 more patches the first one fixes the
>>> unknown code messages and adds a mapping for the
>>> "Screen Capture" hotkey. The second test filters out
>>> the duplicate (duplicate with the "ACPI video bus")
>>> brightness up/down events.
>>>
>>> It would be great if you can add these on top of
>>> the previous 2 patches and then run one last
>>> test for me:
>>>
>>> Run evtest on the "Asus WMI hotkeys" device this should now:
>>>
>>> 1. Show no output for capslock / printscreen
>>>
>>> 2. Show KEY_SELECTIVE_SCREENSHOT events for the
>>>      "Screen Capture" hotkey.
>>>
>>> 3. Show no output for brightness up/down,
>>>      yet brightness up/down should still work since
>>>      these are also reported by the "ACPI video bus"
>>>
>>> It would be great if you can confirm for each of these
>>> that this behaves as expected with the 2 extra patches
>>> applied on top of the previous patches.
>>>
>>> Regards,
>>>
>>> Hans
