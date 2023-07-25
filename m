Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708437620D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjGYSBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjGYSBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:01:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FEE1FDA;
        Tue, 25 Jul 2023 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690308091; x=1690912891; i=w_armin@gmx.de;
 bh=MFtLul5oSSszrVcEGTe5MHBdR1ywo9IPpRQm1iAxTkQ=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=YiWu5QIPYvSyzXtriM0HxjVutXRgVWMrt+kI1AIMfhieHyxHyoO6FlOU/uxofV+zon1iKUr
 DZImf7mQxyTV4uZiXw/Cwad1XAK+qtRdmifdVln+UEeW04PIrT2mzYNYxCdC73tLOfldla9wi
 uzApNc+Q/olWynM06M1kb116ArHX2jXbgvK1B2F+wlCUMOfc/QFyIFIx8AhlKtCAKguAfMbQQ
 Q+05yo9BCbD/k9cOyfNdMy9pYRpBNLddYYPjG6tZjyqhuJNTVVaBzvKz22FyIajcDWrtcLJhV
 97QGeD4pERdjf+n/zpCWcjeZypXIrCeBpaK4RNQlTHQvkvguUTog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzyuS-1pdphV0oKs-00x0HG; Tue, 25
 Jul 2023 20:01:31 +0200
Subject: Re: WMI probe failure when reprobing
To:     Hans de Goede <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1252c8fb-8d5f-98ad-b24a-5fabec2e1c8b@gmx.de>
 <d219e8b4-f57e-a546-3794-6f6bc7030e9e@redhat.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <0062ade3-bff2-781f-0e31-ce3bdcf6942e@gmx.de>
Date:   Tue, 25 Jul 2023 20:01:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d219e8b4-f57e-a546-3794-6f6bc7030e9e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:zdgyd6+mj1/oDa66NphThoBJhYf606sGkiEGKlJv1SjB2FcTCW1
 x/i6m/i0T9D90+Si6LO3r5M8cQzbMVnTSk3FGY7m2Fdu6NxeqfCiDtKZ7HXnHIDBRmDmPVK
 YhakcowSs6DiFq6IqyLpHvG9w/8w/ZRx3khegt544sQgyPdjuYjUO7U94tJFXNavx3uGjkk
 0fLNAhs/OQ7xDaklJk+dw==
UI-OutboundReport: notjunk:1;M01:P0:tGGP/1a9zok=;OdjcMc/me4OEtbU96mZNcMp9mCb
 GdVYabUUy/EKLU9HyKdlQMd6Tm2NgbqhhVoEvazBEe/JDXA0gN6iCTYBv1sAOef1ESznGf4tj
 UltLGxou29/TEfghMHCZ93m3rOgD7NNu+2Jx9NIHbvhT/3TV2mVkNyeowpat6c6NXy+raoJW9
 pAr3gUGCYIUVGStgYNnj5SZtDiEixhA/ONYdaNaF3oFYx1r4bPVrhYmtmsjEp2hAeRdenMRi+
 kDwK20EgucUSX2Y/xcQAXLe/KzgelE+nYyEhy3Pw2p/mQWg9ofp4YxJ5vIzCFk0kXwcpA5jQ0
 KpHRkDMQ2Nk8BX+7xuA2P1U/uiE5laRb+5lFgEpiGXjgQ6DAHFQ90CeW6l9UyV0hPzS8Xgs2N
 ggi90jkOqPhnOEMgk+iGrIZDhV19+aZBCHNZDBoyfqkPhkD2hxIqkvYUJiwqkbvJYbyN+Ot0u
 klQ3qDfSUwS6HqV5bCpISNuJcISHpJ+Vj4gJbxAUVFou8hfgoB7kFWfsD2M8VJDf3CyXTnob6
 tNxE8UxkojyBDnvX6wfewI/KJk+KrpqwIVKalckk2nUh1dpjsGC6c14bl6kVTAb4XE7lHjSCH
 EGqML3PiIBIOeMttAmSfCs+QNI0xfiYMxuE5QFkxz40GolvZDLazCVKlLJTxrnbS3WKeOqTjs
 QNGVT+DE/O2UC+lg8mvSTYL+foS2hWDqMMoQbAxJ43Z0BcF9BraM/zrYi2UH3z3osgEOgvBXJ
 MaXMVyYT0c/0zyGuWh7/cUSJwieEEFYD4oDCGCIx83TVnruUx16BFYevhuooxgXSxyIg/Q1rs
 4Hevqsm4I9/LOKbxRiazhCiDD98DES5R/LVl2x03ilvi/dYyhzUhnmowbiiOm8AEyXEtah/td
 uilGPD9Ew2ASEQHalNI3SNPfXv1AfNQSv++5ynKaElDl36m0+oULpIlQ1rb5Bh4Jbgu9AYXxs
 m3+vQSCk/cgyCf20C/N+QIkvASM=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.07.23 um 17:07 schrieb Hans de Goede:

> Hi Armin,
>
> On 7/22/23 02:09, Armin Wolf wrote:
>> Hello,
>>
>> i just noticed that under some circumstances, ACPI WMI devices might fa=
il to reprobe
>> when being manually unbound and later rebound.
>> Example:
>>
>> 1. ACPI WMI device #1 binds and registers WMI device with GUID
>> "05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
>> being named "05901221-D566-11D1-B2F0-00A0C9062910".
>> 2. ACPI WMI device #2 binds and registers WMI device with GUID
>> "05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
>> being named "05901221-D566-11D1-B2F0-00A0C9062910-1".
>> 3. ACPI WMI device #1 is manually unbound and later rebound,
>> now the WMI device with GUID "05901221-D566-11D1-B2F0-00A0C9062910"
>> is being named "05901221-D566-11D1-B2F0-00A0C9062910-1" too, since
>> device naming depends on the number of GUIDs currently known to
>> the WMI subsystem.
>> 4. A WMI device named "05901221-D566-11D1-B2F0-00A0C9062910-1" already
>> exists, causing the registration of the new WMI device to fail.
>>
>> I thought about some possible ways to solve this naming issue:
>>
>> - symlinks to simulate old WMI devices names, new WMI device names simi=
lar to "wmiX" with X being a global unique id
>> - no symlinks, new WMI device names similar to "wmiX" with X being a gl=
obal unique id
>> - use global id instead of GUID number
>>
>> The first approach has full sysfs backward compatibility but i do not k=
now how to create symlinks inside the "devices"
>> directory. The second approach is the easiest and cleanest one, but pro=
vides no sysfs backward compatibility. The last
>> approach provides only limited sysfs backward compatibility and only fo=
r programs which can handle "<GUID>-X" WMI device
>> names.
>>
>> Currently, there is one single stable sysfs ABI entry concerning the WM=
I subsystem (for wmi-bmof), and two testing
>> sysfs ABI entries (dell-wmi-privacy, sbl-fw-update). I do not know of a=
ny userspace programs relying on these ABIs,
>> but i suspect there might be a couple of scripts which might be affecte=
d.
>>
>> Which approach should i take to solve this problem?
>
> The standard approach to get reliable unique ids in the kernel is to use
> something like this:
>
> #include <linux/idr.h>
>
> static DEFINE_MUTEX(ida_lock);
>
> struct guid_data {
> 	guid_t guid;
> 	struct ida ida;
> 	struct list_head list;
> };
>
> int guid_init() {
> 	ida_init(&guid_data->ida);
> }
>
> int wmi_create_device()
> {
> 	int index;
> 	...
> 	mutex_lock(&ida_lock);
> 	index =3D ida_alloc(&guid_data->ida, GFP_KERNEL);
> 	mutex_unlock(&ida_lock);
> 	if (index < 0)
> 		return index;
>
> 	// store index for use on acpi_wmi_remove
> 	wmi_block->index =3D index;
> 	// use index to generate name, don't add -%d for index=3D=3D0
> 	...
> }
>
> static void wmi_dev_release(struct device *dev)
> {
>          struct wmi_block *wblock =3D dev_to_wblock(dev);
>
> 	mutex_lock(&ida_lock);
> 	ida_free(&guid_data->ida, wblock->index);
> 	mutex_unlock(&ida_lock);
>          kfree(wblock);
> }
>
>
> This is going to need a linked-list of struct guid_data
> structs and a new wmi_get_guid_data() function which
> takes a new global mutex to protect the list and then
> first walks that list looking for a guid match
>
> If nothing is found kzalloc a new struct, init
> the ida struct and add it to the list before releasing
> the mutex protecting the list.
>
> At the end of wmi_get_guid_data() return the found
> or created struct guid_data or NULL on kzalloc error.
>
> And in wmi_create_device() and wmi_dev_release()
> use this to get a struct_guid_data matching the wblock
> GUID so that we have 1 ida struct per GUID.
>
> I would not worry about releasing the struct guid_data
> if somehow the last wblock with that GUID disappears
> chances are we are going to need it again soon and
> the ida id-array will be empty then so we will start
> with a clean-slate if we just re-use the old one
> when a new wblock with the same GUID shows up again.
>
> ###
>
> Not the prettiest with the need to have a new linked
> lists of structs to get a per GUID ida, but it nicely
> matches how most subsystems do this so I think it is
> best.
>
> I hope this small sketch of what a solution for this
> could look like is useful.
>
> Regards,
>
> Hans
>
Would it be feasible to use the duplicate GUID allowlist instead?
Since the issue does only exists on GUIDs which can be duplicated, only WM=
I devices handling those
need a unique id after the GUID, the rest keeps the classic WMI device nam=
e.
This would also allow for individual WMI drivers to provide backwards comp=
atibility in case userspace
needs the old WMI device name for the WMI devices they control. If a WMI d=
river knows that userspace
can handle the new WMI device name for his GUIDs, then they can just add t=
hem to the allowlist.

Armin Wolf

