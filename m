Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7985476404B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGZUKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjGZUKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:10:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED53592;
        Wed, 26 Jul 2023 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690402193; x=1691006993; i=w_armin@gmx.de;
 bh=/WvSeF+g5diZ1vOgLeMKBcnvq86j+14erVrZefkM8HA=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=pWaRrBUth0giWXdYohKFxsHu/gHN8Z2uoq4hdoD4UlZQrpgjMEjg94t5pM1gM0EboMJCYIr
 IALE7RbTYnWkh1OuMtsRUpjIrXTB44jn/4ks7g8J2NSsPJAzI+lwGRRL4LLCmrwXmWbLHfvFg
 5PX+QHvIIOvOVwo+dGXwqywtKmVGx+NPuQ0Wm9mIkFDIITN8HzTZHfrbhk2dr0AnlR4ND54w4
 UA2V92kHaOOJVR+VDVM9YsaHDHq1PfrxKbJwUIQ2qlHhr1lRgtGPJmDhRk/HStN/7gZIbA/6A
 puLJvYNReEejEEhK59DsacqeuxWpOQJnP8EJOmmRdV3a2YfWIywg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1pebG50QIK-00xd2k; Wed, 26
 Jul 2023 22:09:53 +0200
Subject: Re: WMI probe failure when reprobing
To:     Hans de Goede <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1252c8fb-8d5f-98ad-b24a-5fabec2e1c8b@gmx.de>
 <d219e8b4-f57e-a546-3794-6f6bc7030e9e@redhat.com>
 <0062ade3-bff2-781f-0e31-ce3bdcf6942e@gmx.de>
 <60c9f64f-d53b-72f2-5440-0eae18c9357d@redhat.com>
 <70ee1a69-e78a-108a-d2e7-3b6637d79fef@gmx.de>
 <85a51904-7598-b3cb-2fe1-b6da3626500c@redhat.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <64a5a645-0039-9df2-9b23-d2905fe9d1a7@gmx.de>
Date:   Wed, 26 Jul 2023 22:09:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <85a51904-7598-b3cb-2fe1-b6da3626500c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:1/zSIKqRx3XQC5YoHZHGRbcYXMFb9KaokYF0EDFGBZtF8ayONh3
 uJDi8Jh3+359MhewpVq8XZNcJ2CwBy8jl2Tb6tGEcbr/QmIA6RtUQknIOccK//yX6zirqOh
 AxlbwSUelzNdk8DmLq6kMx41M1mP9Nxb3qX+luuB+dt3cTI664+OBpmm8N3Zn3KdwLXksdk
 xVfUffcUH+qH8Wyuu9sTQ==
UI-OutboundReport: notjunk:1;M01:P0:J0nNy1H4vjU=;DtWMgSxW+28whB7lE+n20B+B3Z8
 vceP8fQyOuMuJyaXCbL/svK/i0yvRxZRp2cjS+M/j3GXLcZhRxKNipyt8kgachE2KPxeNuowP
 PXXzgv6/ShTBa5yRwr9Gyv2hv0gy0lkgld0zOa6NGKsJTx8jUQUe1D5bSWzjx2h7ArKVtQXkb
 UmaGMKqEB57p3MusBt2sfRmI4zZ6PUvBptuGNMv/zL4BuWdIe6Q2JF71nD7jQ5rXFRUVLkef+
 rUSobLqNC846YN729bkTGVC55i53dB/iThNewQ4elFgqlS1fn0yrh8oee90gvOAXUcybEFL7+
 SqlWUvVHWRRpthhkzi3J7RkioEqLbjsI8YxfSwkTn22lRAZ9vMX8GyjNsj/ScqMWb5cO5pXb7
 vAdQlnOa3Gtl9xVQmreuLvSbe3JAkE/+/xVN4PfX8uix3+O2Fv4bfJljJEAud3NeUHUkdMihm
 8k6/lZ+b/KUqLPdRi/d56lpbXql3p5VQtQnA/GcYffPkTQmiUJeoFnorHCLAPAYX2eJFgYCkM
 azaiGVqra2qPYfw1JZmYseQjfHg1CtPxBAKTkWekXxyDWah4/qkCL9wQ/Gkq+ZpllvAuglyxe
 y5/z45E0Rybz5BTD8olA0ConZPIkz2ks2y8I0ZUfmI6TMwIbxqdY71qmX2mvrC7LRrycnZbG5
 v3uYhnBvUERM/1JxtuU8nw308i+SQEIIXXKvfk2sJeehGO7AzHS7BjBHA0O0C8L8+WI6BBoHp
 kxUUpQwq3sWtQZbZ0Q4WlNJ0GMvCJYc6k+V5TNap6rBhB6dWcC/PU0AFH+nQ6nAhuzfSNJzNz
 vh/6Mb+nVKhekHPITGPZdYnU27ejHDHqvBPP9sa6rebU+/LwaHzSk8mktCUiAwK3xuvK3qBSp
 9nqIH/FVdKbSAJj/L0pHRnnw3HDy7Dxgl7B0QRonYSVBAvHaaqAX6XX0TR+8N3LtTVL4JEHB9
 dzjMr6UigfgoYQTic07VPMgUoWI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.07.23 um 11:59 schrieb Hans de Goede:

> Hi,
>
> On 7/26/23 11:35, Armin Wolf wrote:
>> Am 26.07.23 um 10:01 schrieb Hans de Goede:
>>
>>> Hi,
>>>
>>> On 7/25/23 20:01, Armin Wolf wrote:
>>>> Am 25.07.23 um 17:07 schrieb Hans de Goede:
>>>>
>>>>> Hi Armin,
>>>>>
>>>>> On 7/22/23 02:09, Armin Wolf wrote:
>>>>>> Hello,
>>>>>>
>>>>>> i just noticed that under some circumstances, ACPI WMI devices migh=
t fail to reprobe
>>>>>> when being manually unbound and later rebound.
>>>>>> Example:
>>>>>>
>>>>>> 1. ACPI WMI device #1 binds and registers WMI device with GUID
>>>>>> "05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
>>>>>> being named "05901221-D566-11D1-B2F0-00A0C9062910".
>>>>>> 2. ACPI WMI device #2 binds and registers WMI device with GUID
>>>>>> "05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
>>>>>> being named "05901221-D566-11D1-B2F0-00A0C9062910-1".
>>>>>> 3. ACPI WMI device #1 is manually unbound and later rebound,
>>>>>> now the WMI device with GUID "05901221-D566-11D1-B2F0-00A0C9062910"
>>>>>> is being named "05901221-D566-11D1-B2F0-00A0C9062910-1" too, since
>>>>>> device naming depends on the number of GUIDs currently known to
>>>>>> the WMI subsystem.
>>>>>> 4. A WMI device named "05901221-D566-11D1-B2F0-00A0C9062910-1" alre=
ady
>>>>>> exists, causing the registration of the new WMI device to fail.
>>>>>>
>>>>>> I thought about some possible ways to solve this naming issue:
>>>>>>
>>>>>> - symlinks to simulate old WMI devices names, new WMI device names =
similar to "wmiX" with X being a global unique id
>>>>>> - no symlinks, new WMI device names similar to "wmiX" with X being =
a global unique id
>>>>>> - use global id instead of GUID number
>>>>>>
>>>>>> The first approach has full sysfs backward compatibility but i do n=
ot know how to create symlinks inside the "devices"
>>>>>> directory. The second approach is the easiest and cleanest one, but=
 provides no sysfs backward compatibility. The last
>>>>>> approach provides only limited sysfs backward compatibility and onl=
y for programs which can handle "<GUID>-X" WMI device
>>>>>> names.
>>>>>>
>>>>>> Currently, there is one single stable sysfs ABI entry concerning th=
e WMI subsystem (for wmi-bmof), and two testing
>>>>>> sysfs ABI entries (dell-wmi-privacy, sbl-fw-update). I do not know =
of any userspace programs relying on these ABIs,
>>>>>> but i suspect there might be a couple of scripts which might be aff=
ected.
>>>>>>
>>>>>> Which approach should i take to solve this problem?
>>>>> The standard approach to get reliable unique ids in the kernel is to=
 use
>>>>> something like this:
>>>>>
>>>>> #include <linux/idr.h>
>>>>>
>>>>> static DEFINE_MUTEX(ida_lock);
>>>>>
>>>>> struct guid_data {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0guid_t guid;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ida ida;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct list_head list;
>>>>> };
>>>>>
>>>>> int guid_init() {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ida_init(&guid_data->ida);
>>>>> }
>>>>>
>>>>> int wmi_create_device()
>>>>> {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int index;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&ida_lock);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0index =3D ida_alloc(&guid_data->ida, =
GFP_KERNEL);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&ida_lock);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (index < 0)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return index;
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// store index for use on acpi_wmi_re=
move
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wmi_block->index =3D index;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// use index to generate name, don't =
add -%d for index=3D=3D0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
>>>>> }
>>>>>
>>>>> static void wmi_dev_release(struct device *dev)
>>>>> {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct wmi_b=
lock *wblock =3D dev_to_wblock(dev);
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&ida_lock);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ida_free(&guid_data->ida, wblock->ind=
ex);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&ida_lock);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(wblock=
);
>>>>> }
>>>>>
>>>>>
>>>>> This is going to need a linked-list of struct guid_data
>>>>> structs and a new wmi_get_guid_data() function which
>>>>> takes a new global mutex to protect the list and then
>>>>> first walks that list looking for a guid match
>>>>>
>>>>> If nothing is found kzalloc a new struct, init
>>>>> the ida struct and add it to the list before releasing
>>>>> the mutex protecting the list.
>>>>>
>>>>> At the end of wmi_get_guid_data() return the found
>>>>> or created struct guid_data or NULL on kzalloc error.
>>>>>
>>>>> And in wmi_create_device() and wmi_dev_release()
>>>>> use this to get a struct_guid_data matching the wblock
>>>>> GUID so that we have 1 ida struct per GUID.
>>>>>
>>>>> I would not worry about releasing the struct guid_data
>>>>> if somehow the last wblock with that GUID disappears
>>>>> chances are we are going to need it again soon and
>>>>> the ida id-array will be empty then so we will start
>>>>> with a clean-slate if we just re-use the old one
>>>>> when a new wblock with the same GUID shows up again.
>>>>>
>>>>> ###
>>>>>
>>>>> Not the prettiest with the need to have a new linked
>>>>> lists of structs to get a per GUID ida, but it nicely
>>>>> matches how most subsystems do this so I think it is
>>>>> best.
>>>>>
>>>>> I hope this small sketch of what a solution for this
>>>>> could look like is useful.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Hans
>>>>>
>>>> Would it be feasible to use the duplicate GUID allowlist instead?
>>> Yes that is a good idea, if you make it non const you can just
>>> store the ida struct there. You'll likely need to add some macro
>>> to init the entries then which also inits the ida struct.
>>>
>>>> Since the issue does only exists on GUIDs which can be duplicated, on=
ly WMI devices handling those
>>>> need a unique id after the GUID, the rest keeps the classic WMI devic=
e name.
>>> ack.
>>>
>>>> This would also allow for individual WMI drivers to provide backwards=
 compatibility in case userspace
>>>> needs the old WMI device name for the WMI devices they control. If a =
WMI driver knows that userspace
>>>> can handle the new WMI device name for his GUIDs, then they can just =
add them to the allowlist.
>>> For backward compat I would still omit the "-%d" suffix for the wblock=
 device which gets index 0, that should still be the same one as before.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>> There might be a misunderstanding here, i meant to propose to avoid thi=
s one-ida-for-each-guid thing and instead
>> change the WMI device naming depending on whether the GUID is inside th=
e allowlist:
>>
>> - WMI driver cannot handle duplicate GUIDs and userspace requires old W=
MI device naming -> GUID not in allowlist, old WMI device name
>> - WMI driver cannot handle duplicate GUIDs and userspace does not requi=
re old WMI device naming -> GUID not in allowlist, old WMI device name
>> - WMI driver can handle duplicate GUIDs and userspace does require old =
WMI device naming -> GUID not in allowlist, old WMI device name
>> - WMI driver can handle duplicate GUIDs and userspace does not require =
old WMI device naming -> GUID in allowlist, new WMI device name
>>
>> The old WMI device name would be a simple GUID, while the new WMI devic=
e name would consist of the GUID and an unique id, which is always present=
.
>> This would allow us to avoid another list of GUIDs while making sure th=
at backwards compatibility for userspace is preserved.
>>
>> This approach is simpler and faster than the list-based approach, and i=
t would allow us to turn the allowlist into and denylist in the future.
>> What do you think of this approach?
> This means that as soon as a new GUID gets added to the allow-list, beca=
use it turns out 1 laptop model has 2 wblocks with the same GUID, that we =
then change the sysfs path for the wmi device also for all the other lapto=
p models which only have the GUID once. Which may very well cause issues f=
or userspace. So I'm not really a fan of this approach.
>
> But I do like the idea of using the allow-list to see if we need an ida =
at all (since we don't need the index for GUIDs not on the allow list). So=
 we can then change the allow-list from an array of strings with allowed G=
UIDs to an array of structs with a guid_t + an ida struct in there.
>
> Then we can also use GUID_INIT() to directly fill a guid_t in the allow-=
list saving us the guid_parse() call which is currently done to check entr=
ies on the allow-list.
>
> GUID_INIT should then probably be wrapped in a new macro e.g.
>
> #define ALLOW_GUID(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)	{ \
> 	.guid =3D GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7), \
> 	.ida =3D IDR_INIT(ERROR), \
> 	}
>
> ok so that won't work, the ERROR above needs to be the .ida member, but =
I'm pretty
> sure that writing:
>
> 	.ida =3D IDR_INIT(.ida),
>
> is not allowed (worth a shot though I guess).
>
> So I think we would need something slightly more involved like this:
>
> struct wmi_allow_guid {
> 	struct guid_t guid;
> 	struct ida ida;
> };
>
> #define ALLOW_GUID(index, a, b, c, d0, d1, d2, d3, d4, d5, d6, d7) \
> 	[index] =3D { \
> 		.guid =3D GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7), \
> 		.ida =3D IDR_INIT(allow_duplicates[index].ida), \
> 	}
>
> struct wmi_allow_guid allow_duplicates[] =3D {
> 	ALLOW_GUID(0, a, b, c, d0, d1, d2, d3, d4, d5, d6, d7),
> 	ALLOW_GUID(1, a, b, c, d0, d1, d2, d3, d4, d5, d6, d7),
> };
>
> Regards,
>
> Hans
>
>
Ok, i understand now why my approach does not work. But i would still not =
use the allowlist for storing the ida structs, because this would make
it much more difficult to turn the allowlist into an denylist later.
Instead, i would use the associative array library inside the kernel. We c=
ould use this to map a GUID to a ida struct, and we could also use this
data structure to efficiently check if a given GUID already exists inside =
the system. This would replace the wmi_block_list currently used by the
WMI subsystem while being faster and more scalable.
I will try to implement your approach using the associative array library,=
 if you have no objections of course.

Armin Wolf

