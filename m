Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F776326E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjGZJhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjGZJg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:36:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6003170D;
        Wed, 26 Jul 2023 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690364117; x=1690968917; i=w_armin@gmx.de;
 bh=zz2scL0uM0DdBGj92DefjAzlR1bQbFZpbyd6mZ3XWw4=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=g8dCQCAaNas7fOq+KmS85/msWXjg9DXFUgDbvMX8CSjeCCgzl4lDZU28PYkuSyjyQocJ9x/
 9kKDtMHxnS2rea2mXVl/r/Goyq/lqRKA6PCmgOn64ITr0DYxFjigQJ+Vqsq/5Acqtf9f4WDzM
 ViKGHx2wpRTkPCAdGYdgFscu0AgkMcVr0+M1Q4rQhSodb+1nCeitjUJUM4kYUSVms/Z+IvcKX
 auoq567iUwiU0HwgIXW0XbHa8x5ZBk95Jt0QY73hYngIHlT5/YEbqDn365K+hW9m+AxaUPVmq
 ++i9wqSOnykV9GGfX2zBluzaFbx/ndCZRE/0CYKdXoevQAXnuQgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiHf-1qFT1m1BLb-00Q9gy; Wed, 26
 Jul 2023 11:35:17 +0200
Subject: Re: WMI probe failure when reprobing
To:     Hans de Goede <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1252c8fb-8d5f-98ad-b24a-5fabec2e1c8b@gmx.de>
 <d219e8b4-f57e-a546-3794-6f6bc7030e9e@redhat.com>
 <0062ade3-bff2-781f-0e31-ce3bdcf6942e@gmx.de>
 <60c9f64f-d53b-72f2-5440-0eae18c9357d@redhat.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <70ee1a69-e78a-108a-d2e7-3b6637d79fef@gmx.de>
Date:   Wed, 26 Jul 2023 11:35:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <60c9f64f-d53b-72f2-5440-0eae18c9357d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:JGo75GMjy1gKZ5mAaZAcNNk1SIbwldvnNO7+MesqICFvKN4uEz2
 9cyXykaU9+sd7PHXNA+T+lry6uyi/tch0xGRzkXij+eMD8viOu6i6lv/dZWYLSCcBWdYShg
 vjsAXddbI/ZelkYCyYqecmrG4Nt26/mucbarOzQ/B30f3FWdbclSUllFK5SJhnPdYvH6DzD
 Q4MeD7CVVPquIOUQCgqOA==
UI-OutboundReport: notjunk:1;M01:P0:1OfCzaN6aNQ=;dQ0kaJ7Rdd6oYH6t7eCirVOcLcv
 2AFqq3jUtLrA5SibC2SfEwnS+fkZDipFmjoSeeGwMzxwzFMHZswGarGJQjk37uk1izK9owWSg
 su49NPCRbqFjCSCpm6GtGvJEBVAQcCVZOj7aw2i/GKTQ6uO8Zi4Ri/OFDjo4LZEzrIdxmpgMd
 R3rGmYMSxS0hw3VawbmaH5dmEJGoci4HfT2k+RWPfk6tsozJ7RxqgBSKLZrmEJYsqBfzvZxak
 Md7r132qWufNq2a0x7bCadSjswZP+LlKx+KgfHc72ZvFGs3k6A3+ZWVnlIlQHgjutWtvCRDDX
 59HKtaISyQKkXDWjKuOs1XnRNi/cwcnXf01GW4Tqx4hNHrm5IOadqInaOi+BeqDxaemlq02LT
 4WXT4rTroel7M/p/zOUHf0veb9i6TjHO8/LgUonr/QWf0c0Pq/HZt/d1E/qvnJ0G8OqG/PujP
 gQJnCpp9pJClPUSq8LjyIWKQ1iISrSrVBQnJAa82BDFL8pxgyo5D0Cbb/czzSwu5ELl+mg2nH
 Xr5gEmeA9FJAVzQa7Q9RvsiICiMQAFXddyyHodJld8y6Z10Enqvd8w4GFEax2mvP6vzo9jCcf
 t3nuSksF4kvKTqJVR6KBTOn/je7WV4mSqiE0XQKmoq3LAQp9+VKqy4kmv3pVkpk/99bmqHEg1
 Ml1Ls4ekKF5X0PnNe95hsOQaozMbSjhTRZfSduVrhsP998RtZqYnMp7cB+ZU6Q2NhFg6/XsN2
 c6AqVLEHMPy05NLGl3vrfRPVNHCD4jldabeR2G3GbzSTw6dafoee2W7HjzRkxYeY+RWb72FMy
 uvAUMb30pS8hUYBnVIsF3MYDAKUo8h+p89DrmTWnoU/Qf4zzYw3r1EtsWuORYYqWXrAUMXOa4
 +XSJeV9A3pEXAa9MtPrLl5VLMYoArfzhgp9PHwssX6hpqnfFz4q2H6L1bfLQoxiIBG+YWpyq+
 AV7TNDpfZa8XKEbWngeVMVFVnKs=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.07.23 um 10:01 schrieb Hans de Goede:

> Hi,
>
> On 7/25/23 20:01, Armin Wolf wrote:
>> Am 25.07.23 um 17:07 schrieb Hans de Goede:
>>
>>> Hi Armin,
>>>
>>> On 7/22/23 02:09, Armin Wolf wrote:
>>>> Hello,
>>>>
>>>> i just noticed that under some circumstances, ACPI WMI devices might =
fail to reprobe
>>>> when being manually unbound and later rebound.
>>>> Example:
>>>>
>>>> 1. ACPI WMI device #1 binds and registers WMI device with GUID
>>>> "05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
>>>> being named "05901221-D566-11D1-B2F0-00A0C9062910".
>>>> 2. ACPI WMI device #2 binds and registers WMI device with GUID
>>>> "05901221-D566-11D1-B2F0-00A0C9062910", resulting in the device
>>>> being named "05901221-D566-11D1-B2F0-00A0C9062910-1".
>>>> 3. ACPI WMI device #1 is manually unbound and later rebound,
>>>> now the WMI device with GUID "05901221-D566-11D1-B2F0-00A0C9062910"
>>>> is being named "05901221-D566-11D1-B2F0-00A0C9062910-1" too, since
>>>> device naming depends on the number of GUIDs currently known to
>>>> the WMI subsystem.
>>>> 4. A WMI device named "05901221-D566-11D1-B2F0-00A0C9062910-1" alread=
y
>>>> exists, causing the registration of the new WMI device to fail.
>>>>
>>>> I thought about some possible ways to solve this naming issue:
>>>>
>>>> - symlinks to simulate old WMI devices names, new WMI device names si=
milar to "wmiX" with X being a global unique id
>>>> - no symlinks, new WMI device names similar to "wmiX" with X being a =
global unique id
>>>> - use global id instead of GUID number
>>>>
>>>> The first approach has full sysfs backward compatibility but i do not=
 know how to create symlinks inside the "devices"
>>>> directory. The second approach is the easiest and cleanest one, but p=
rovides no sysfs backward compatibility. The last
>>>> approach provides only limited sysfs backward compatibility and only =
for programs which can handle "<GUID>-X" WMI device
>>>> names.
>>>>
>>>> Currently, there is one single stable sysfs ABI entry concerning the =
WMI subsystem (for wmi-bmof), and two testing
>>>> sysfs ABI entries (dell-wmi-privacy, sbl-fw-update). I do not know of=
 any userspace programs relying on these ABIs,
>>>> but i suspect there might be a couple of scripts which might be affec=
ted.
>>>>
>>>> Which approach should i take to solve this problem?
>>> The standard approach to get reliable unique ids in the kernel is to u=
se
>>> something like this:
>>>
>>> #include <linux/idr.h>
>>>
>>> static DEFINE_MUTEX(ida_lock);
>>>
>>> struct guid_data {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0guid_t guid;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0struct ida ida;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0struct list_head list;
>>> };
>>>
>>> int guid_init() {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0ida_init(&guid_data->ida);
>>> }
>>>
>>> int wmi_create_device()
>>> {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0int index;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0...
>>>  =C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&ida_lock);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0index =3D ida_alloc(&guid_data->ida, GFP_KERN=
EL);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&ida_lock);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0if (index < 0)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return index;
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0// store index for use on acpi_wmi_remove
>>>  =C2=A0=C2=A0=C2=A0=C2=A0wmi_block->index =3D index;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0// use index to generate name, don't add -%d =
for index=3D=3D0
>>>  =C2=A0=C2=A0=C2=A0=C2=A0...
>>> }
>>>
>>> static void wmi_dev_release(struct device *dev)
>>> {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct wmi_block *wb=
lock =3D dev_to_wblock(dev);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&ida_lock);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0ida_free(&guid_data->ida, wblock->index);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&ida_lock);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(wblock);
>>> }
>>>
>>>
>>> This is going to need a linked-list of struct guid_data
>>> structs and a new wmi_get_guid_data() function which
>>> takes a new global mutex to protect the list and then
>>> first walks that list looking for a guid match
>>>
>>> If nothing is found kzalloc a new struct, init
>>> the ida struct and add it to the list before releasing
>>> the mutex protecting the list.
>>>
>>> At the end of wmi_get_guid_data() return the found
>>> or created struct guid_data or NULL on kzalloc error.
>>>
>>> And in wmi_create_device() and wmi_dev_release()
>>> use this to get a struct_guid_data matching the wblock
>>> GUID so that we have 1 ida struct per GUID.
>>>
>>> I would not worry about releasing the struct guid_data
>>> if somehow the last wblock with that GUID disappears
>>> chances are we are going to need it again soon and
>>> the ida id-array will be empty then so we will start
>>> with a clean-slate if we just re-use the old one
>>> when a new wblock with the same GUID shows up again.
>>>
>>> ###
>>>
>>> Not the prettiest with the need to have a new linked
>>> lists of structs to get a per GUID ida, but it nicely
>>> matches how most subsystems do this so I think it is
>>> best.
>>>
>>> I hope this small sketch of what a solution for this
>>> could look like is useful.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>> Would it be feasible to use the duplicate GUID allowlist instead?
> Yes that is a good idea, if you make it non const you can just
> store the ida struct there. You'll likely need to add some macro
> to init the entries then which also inits the ida struct.
>
>> Since the issue does only exists on GUIDs which can be duplicated, only=
 WMI devices handling those
>> need a unique id after the GUID, the rest keeps the classic WMI device =
name.
> ack.
>
>> This would also allow for individual WMI drivers to provide backwards c=
ompatibility in case userspace
>> needs the old WMI device name for the WMI devices they control. If a WM=
I driver knows that userspace
>> can handle the new WMI device name for his GUIDs, then they can just ad=
d them to the allowlist.
> For backward compat I would still omit the "-%d" suffix for the wblock d=
evice which gets index 0, that should still be the same one as before.
>
> Regards,
>
> Hans
>
>
There might be a misunderstanding here, i meant to propose to avoid this o=
ne-ida-for-each-guid thing and instead
change the WMI device naming depending on whether the GUID is inside the a=
llowlist:

- WMI driver cannot handle duplicate GUIDs and userspace requires old WMI =
device naming -> GUID not in allowlist, old WMI device name
- WMI driver cannot handle duplicate GUIDs and userspace does not require =
old WMI device naming -> GUID not in allowlist, old WMI device name
- WMI driver can handle duplicate GUIDs and userspace does require old WMI=
 device naming -> GUID not in allowlist, old WMI device name
- WMI driver can handle duplicate GUIDs and userspace does not require old=
 WMI device naming -> GUID in allowlist, new WMI device name

The old WMI device name would be a simple GUID, while the new WMI device n=
ame would consist of the GUID and an unique id, which is always present.
This would allow us to avoid another list of GUIDs while making sure that =
backwards compatibility for userspace is preserved.

This approach is simpler and faster than the list-based approach, and it w=
ould allow us to turn the allowlist into and denylist in the future.
What do you think of this approach?

Armin Wolf

