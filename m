Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF27CD133
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 02:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbjJRATO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 20:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJRATM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 20:19:12 -0400
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 17:19:06 PDT
Received: from omta039.useast.a.cloudfilter.net (omta039.useast.a.cloudfilter.net [44.202.169.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1418BA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 17:19:06 -0700 (PDT)
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
        by cmsmtp with ESMTPS
        id sWfEqChvwCPDcsuFiq6vN3; Wed, 18 Oct 2023 00:17:34 +0000
Received: from shared083.arvixe.com ([143.95.229.40])
        by cmsmtp with ESMTPS
        id suFhqJOTcYl3UsuFhqsvC6; Wed, 18 Oct 2023 00:17:34 +0000
X-Authority-Analysis: v=2.4 cv=HdoH8wI8 c=1 sm=1 tr=0 ts=652f241e
 a=GmS1SBToaRoMP0YkDtvSoA==:117 a=GmS1SBToaRoMP0YkDtvSoA==:17
 a=bhdUkHdE2iEA:10 a=--C6PtRGR58A:10 a=Br9LfDWDAAAA:8 a=Qd5ZInFqQxoc_DCkrDoA:9
 a=7xhl_xkYUFzfw9z2:21 a=Zk8DA_qPyZ6MZGUn:21 a=QEXdDO2ut3YA:10
 a=TRW-o2S9CEoA:10 a=OsUonXv-ptgA:10 a=jRPC9tqfqjmi2Q9XY2UA:9
 a=CDSaX9IuIzn3pvfP:21 a=KRYhrpjcpIRdb_oiJp4A:9 a=gR_RJRYUad_6_ruzA8cR:22
Received: from [143.95.229.40] (port=30246 helo=shared083.arvixe.com)
        by shared083.arvixe.com with esmtpa (Exim 4.96.1)
        (envelope-from <me@donjajo.com>)
        id 1qsuFh-003rHN-0d;
        Tue, 17 Oct 2023 19:17:33 -0500
Received: from [41.66.218.188]
 by shared083.arvixe.com
 with HTTP (HTTP/1.1 POST); Tue, 17 Oct 2023 19:17:32 -0500
MIME-Version: 1.0
Date:   Tue, 17 Oct 2023 19:17:32 -0500
From:   me@donjajo.com
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvin?= =?UTF-8?Q?en?= 
        <ilpo.jarvinen@linux.intel.com>, Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS
 Lock and PrntScrn on Zenbook S 13 UX5304VA
In-Reply-To: <938c83c4-973d-ac23-bfb6-53c63c153d81@redhat.com>
References: <a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com>
 <132feb67-c147-7ee6-b337-385e11786ec6@redhat.com>
 <146cb960-406b-4456-94ce-ad6ed3f330ad@donjajo.com>
 <d70f7d35-6458-437d-f68f-47291ce74a1e@redhat.com>
 <90a7309e-4a76-4dff-8259-9975dd3ed8b1@donjajo.com>
 <938c83c4-973d-ac23-bfb6-53c63c153d81@redhat.com>
User-Agent: Roundcube Webmail/1.6.0
Message-ID: <6c97dc9e9cfea6e18c59d717e5973255@donjajo.com>
X-Sender: me@donjajo.com
Content-Type: multipart/mixed;
 boundary="=_520c7d88f4c6099c929b99f4c94291d9"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - shared083.arvixe.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - donjajo.com
X-BWhitelist: no
X-Source-IP: 143.95.229.40
X-Source-L: No
X-Exim-ID: 1qsuFh-003rHN-0d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (shared083.arvixe.com) [143.95.229.40]:30246
X-Source-Auth: me@donjajo.com
X-Email-Count: 4
X-Org:  HG=asoshared_arvixe;ORG=aso;
X-Source-Cap: b3h5aG9scmU7b3h5aG9scmU7c2hhcmVkMDgzLmFydml4ZS5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGHK2949RE8ImCGLygvbJ25TsEbOsEByphlRmqelU9gNsDmlYWHA6HZpLMrUUE4rc4NxLHL7l491Jk7Cg6/o5fUPzNZN31lNZUQzLWM2F8vDHRPR4K9D
 hGHYdPnPZV8GK3qS9ki1liv8bAMbKiZlHr6VLQW9xKnBmwuJ24uxD/2lkfnODgdy49Ys9o2VCRZosZPO2V5FEpPL2UdpsXK4Mws=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_520c7d88f4c6099c929b99f4c94291d9
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

Hi Hans,

I hope you are feeling better now.
Thank you so much for your support in resolving this.

> I assume that the first "BACKLIGHT BUTTON" is the backlight DOWN button 
> ?
Yes. Correct.


> 2. Can you please run:
> 
> sudo evtest and then select the "ACPI video bus" (or something
> similar) device and see if that reports brightness up/down
> keypresses?  And then do the same thing for the
> "Asus WMI hotkeys" device ? I expect the Asus WMI hotkeys
> device to only report brightness up keypresses (after my
> hwdb "fix") while I expect brightness-up events to get
> reported twice, by both the "ACPI video bus" device and
> the "Asus WMI hotkeys" device.
Done and attached.

> Can you confirm this? This also means that brightness
> up will take bigger steps (2 steps per keypress) then
> brightness down, right ?
I am not sure I understand what you mean here. But I have attached the 
output here

> 3. Please run:
> 
> sudo acpidump -o acpidump.txt
> 
> and send me a private email with acpidump.txt attached.
Sent


> 4. Please with the kernel with the debug patch press brightness-up / 
> -down repeatedly,
> I assume this does actually change the brightness ?
Yes

> Then look in dmesg and check that it consistently reports 0x2e
> for brightness-down presses and 0x2f for brightness-up presses
> independent of the brightness level being high or low when
> pressing the key.  Please confirm this behaves as expected.
Yes.brightness-down reports 0x2e while brightness-up reports 0x2f


> 5.1 capslock and printscreen now lead to: "Unknown key code 0x.."
> messages in dmesg.
Yes, printscreen and caps lock now responds with:

CAPS LOCK
[  122.965660] asus_wmi: raw event code 0x2c
[  122.965705] asus_wmi: Unknown key code 0x2c
[  122.965730] asus_wmi: raw event code 0xffffffffffffffff

PRTSCRN
[  126.066419] asus_wmi: raw event code 0x2b
[  126.066439] asus_wmi: Unknown key code 0x2b
[  126.066451] asus_wmi: raw event code 0xffffffffffffffff


> 5.2 running evtest on "Asus WMI hotkeys" shows brightness
> up and down presses when pressing the brightness keys.
Yes

Event: time 1697586223.014528, type 4 (EV_MSC), code 4 (MSC_SCAN), value 
2e
Event: time 1697586223.014528, type 1 (EV_KEY), code 224 
(KEY_BRIGHTNESSDOWN), value 1
Event: time 1697586223.014528, -------------- SYN_REPORT ------------
Event: time 1697586223.014547, type 1 (EV_KEY), code 224 
(KEY_BRIGHTNESSDOWN), value 0
Event: time 1697586223.014547, -------------- SYN_REPORT ------------
Event: time 1697586223.714462, type 4 (EV_MSC), code 4 (MSC_SCAN), value 
2f
Event: time 1697586223.714462, type 1 (EV_KEY), code 225 
(KEY_BRIGHTNESSUP), value 1
Event: time 1697586223.714462, -------------- SYN_REPORT ------------
Event: time 1697586223.714471, type 1 (EV_KEY), code 225 
(KEY_BRIGHTNESSUP), value 0
Event: time 1697586223.714471, -------------- SYN_REPORT ------------


After applying your patch, it seems to have fixed the issue!

On 2023-10-17 03:50, Hans de Goede wrote:
> Hi James,
> 
> On 10/1/23 16:16, James John wrote:
>> Hello Hans,
>> 
>> Thank you. I applied the patch and I have the inputs attached here.
>> 
>> After setting the hwdb filter, all the hot keys are still working 
>> except that the LED notification light on Mute Hotkey (F9) is no 
>> longer turning up on mute.
>> 
>> The Screen Capture, Disable Camera, and MyASUS buttons are not mapped 
>> yet. I believe the Screen Capture button should map to PrntScrn 
>> button, and MyASUS with Disable Camera unmapped, obviously. I also 
>> have the codes in the attached log.
>> 
>> Screen Capture button is KEY_UNKNOWN to evtest.
> 
> So I missed the Screen Capture button so far.
> I believe that the 0x2a code should be mapped to
> KEY_SELECTIVE_SCREENSHOT (to differentiate it from
> the printscreen key, this is also used on other laptops
> for similar buttons).
> 
> I'm going to send out a RFC series of 3 patches,
> the 2 patches which I send earlier + a patch to
> add a mapping for this. I'll Cc you on this.
> 
> Please give this series a try (after removing the hwdb
> change).
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
>> On 01/10/2023 13:45, Hans de Goede wrote:
>>> Hi James,
>>> 
>>> On 10/1/23 10:46, James John wrote:
>>>> Hello Han,
>>>> 
>>>> Thank you very much for this detailed steps. I was able to reproduce 
>>>> this with "evtest" and everything went okay.
>>>> 
>>>> After editing /lib/udev/hwdb.d/60-keyboarrd.hwdb as you specified, 
>>>> the problem has been fixed, which I believe should revert on reboot?
>>> No this will fix it until /lib/udev/hwdb.d/60-keyboarrd.hwdb gets 
>>> overwritten by your
>>> package-manager the next time the systemd packages get updated.
>>> 
>>>> This is the content of /sys/class/dmi/id/modalias
>>>> 
>>>> dmi:bvnAmericanMegatrendsInternational,LLC.:bvrUX5304VA.304:bd05/16/2023:br5.27:svnASUSTeKCOMPUTERINC.:pnZenbookS13UX5304VA_UX5304VA:pvr1.0:rvnASUSTeKCOMPUTERINC.:rnUX5304VA:rvr1.0:cvnASUSTeKCOMPUTERINC.:ct10:cvr1.0:sku:
>>> Thanks.
>>> 
>>> Looking at:
>>> https://bbs.archlinux.org/viewtopic.php?pid=2123716
>>> 
>>> I see that at least one other model Asus laptop is affected too. So 
>>> rather then
>>> adding a more specific hwdb rule for your model I would like to try 
>>> and find
>>> the root cause of these 0x20 event code events when pressing capslock
>>> on your laptop.
>>> 
>>>> Yes, I built my kernel. I wish I could parse this and write a proper 
>>>> quirk.
>>> Good, I've written a small kernel patch to get to the bottom of this 
>>> (attached)
>>> can you please build a kernel with this. Then boot into this kernel 
>>> and
>>> then run dmesg -w
>>> 
>>> When you now press capslock you should see log lines show up which 
>>> contain
>>> "raw event code 0x..."
>>> 
>>> Please let me know what these lines show when pressing capslock.
>>> 
>>> Please also let me know what these lines show when pressing other
>>> hotkeys which are handled by asus-nb-wmi (you can re-run "sudo 
>>> evtest"
>>> to check which keys that are).
>>> 
>>> I think the issue might be that the asus-wmi code is filtering out
>>> the higher bits of the value, which causes some new events to
>>> get mapped as just 0x20 instead of some-higher-bits + 0x20.
>>> 
>>> Also I'm wondering if everything else works as it should,
>>> e.g. does changing the brightness with the brightness hotkeys
>>> still work after setting up the hwdb filtering ?
>>> 
>>> And does the lid-switch (suspend the machine when the lid is closed)
>>> work ?
>>> 
>>> 
>>>> Also, I don't know if this is related; the hotkeys should be enabled 
>>>> by default. Fn key should be for Function keys. But in the current 
>>>> state, it is reversed.
>>> This is laptop models specific and not really controlled by Linux,
>>> sometimes you can change the default in the BIOS. Or sometimes you
>>> can change the default by pressing Fn + Esc.
>>> 
>>> Regards,
>>> 
>>> Hans
>>> 
>>> 
>>> 
>>> 
>>>> On 01/10/2023 09:28, Hans de Goede wrote:
>>>>> Hi James,
>>>>> 
>>>>> On 10/1/23 10:11, James John wrote:
>>>>>> Hello,
>>>>>> 
>>>>>> First of all, thank you very much for the work you do with 
>>>>>> maintaining these drivers and supporting systems. It is not an 
>>>>>> easy one.
>>>>>> 
>>>>>> I have debugged this bug down to the asus_nb_wmi module. When I 
>>>>>> disable this module, the problem goes away, but then other hotkeys 
>>>>>> are not recognized. Attached is a debug event from libinput, where 
>>>>>> I pressed the capslock twice
>>>>>> 
>>>>>> I have tried to dabble around with asus-nb-wmi.c codes to see if I 
>>>>>> could fix it by luck, by adding UX5304VA to `static const struct 
>>>>>> dmi_system_id asus_quirks[]` but to no avail. And I have a very 
>>>>>> little knowledge of what "quirks" are.
>>>>>> 
>>>>>> I have attached some information regarding my hardware and kernel. 
>>>>>> I will be available to provide any more information that might be 
>>>>>> needed to resolve this.
>>>>>> 
>>>>>> A related open thread: 
>>>>>> https://bbs.archlinux.org/viewtopic.php?pid=2123716
>>>>> First of all lets confirm that the KEY_BRIGHTNESSDOWN events are 
>>>>> really coming from asus_nb_wmi.
>>>>> 
>>>>> Please install evtest and then run "sudo evtest" and then select 
>>>>> the "Asus WMI hotkeys" device
>>>>> by typing its number followed by enter.
>>>>> 
>>>>> After this reproduce the bug and see if the log shows 
>>>>> KEY_BRIGHTNESSDOWN.
>>>>> 
>>>>> Since you said you tried playing around with the quirks, I assume 
>>>>> you can build
>>>>> your own kernel, please let me know if that is wrong.
>>>>> 
>>>>> If this confirms the KEY_BRIGHTNESSDOWN events are coming from the 
>>>>> "Asus WMI hotkeys" device,
>>>>> then please edit /lib/udev/hwdb.d/60-keyboard.hwdb
>>>>> 
>>>>> And search for "Asus WMI hotkeys", this should find this section:
>>>>> 
>>>>> evdev:name:Asus WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>> evdev:name:Eee PC WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>> evdev:name:Asus Laptop extra 
>>>>> buttons:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>>    KEYBOARD_KEY_6b=f21                                    # 
>>>>> Touchpad Toggle
>>>>>    KEYBOARD_KEY_7c=f20                                    # Remap 
>>>>> micmute to f20
>>>>> 
>>>>> Change this to:
>>>>> 
>>>>> evdev:name:Asus WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>> evdev:name:Eee PC WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>> evdev:name:Asus Laptop extra 
>>>>> buttons:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>>    KEYBOARD_KEY_6b=f21                                    # 
>>>>> Touchpad Toggle
>>>>>    KEYBOARD_KEY_7c=f20                                    # Remap 
>>>>> micmute to f20
>>>>>    KEYBOARD_KEY_20=unknown
>>>>> 
>>>>> And then run "sudo udevadm hwdb --update" followed by "sudo udevadm 
>>>>> trigger",
>>>>> that should filter out the spurious keypresses.
>>>>> 
>>>>> If that helps, please run:
>>>>> 
>>>>> cat /sys/class/dmi/id/modalias
>>>>> 
>>>>> So that a proper DMI based quirk to only to the filtering on your 
>>>>> model
>>>>> can be written.
>>>>> 
>>>>> Regards,
>>>>> 
>>>>> Hans
>>>>> 

--=_520c7d88f4c6099c929b99f4c94291d9
Content-Transfer-Encoding: base64
Content-Type: text/plain;
 name=evtest-asus-wmi.txt
Content-Disposition: attachment;
 filename=evtest-asus-wmi.txt;
 size=3047

SW5wdXQgZHJpdmVyIHZlcnNpb24gaXMgMS4wLjEKSW5wdXQgZGV2aWNlIElEOiBidXMgMHgxOSB2
ZW5kb3IgMHgwIHByb2R1Y3QgMHgwIHZlcnNpb24gMHgwCklucHV0IGRldmljZSBuYW1lOiAiQXN1
cyBXTUkgaG90a2V5cyIKU3VwcG9ydGVkIGV2ZW50czoKICBFdmVudCB0eXBlIDAgKEVWX1NZTikK
ICBFdmVudCB0eXBlIDEgKEVWX0tFWSkKICAgIEV2ZW50IGNvZGUgMTEzIChLRVlfTVVURSkKICAg
IEV2ZW50IGNvZGUgMTE0IChLRVlfVk9MVU1FRE9XTikKICAgIEV2ZW50IGNvZGUgMTE1IChLRVlf
Vk9MVU1FVVApCiAgICBFdmVudCBjb2RlIDE0MCAoS0VZX0NBTEMpCiAgICBFdmVudCBjb2RlIDE0
OCAoS0VZX1BST0cxKQogICAgRXZlbnQgY29kZSAxNDkgKEtFWV9QUk9HMikKICAgIEV2ZW50IGNv
ZGUgMTUwIChLRVlfV1dXKQogICAgRXZlbnQgY29kZSAxNTIgKEtFWV9TQ1JFRU5MT0NLKQogICAg
RXZlbnQgY29kZSAxNjMgKEtFWV9ORVhUU09ORykKICAgIEV2ZW50IGNvZGUgMTY0IChLRVlfUExB
WVBBVVNFKQogICAgRXZlbnQgY29kZSAxNjUgKEtFWV9QUkVWSU9VU1NPTkcpCiAgICBFdmVudCBj
b2RlIDE2NiAoS0VZX1NUT1BDRCkKICAgIEV2ZW50IGNvZGUgMTY5IChLRVlfUEhPTkUpCiAgICBF
dmVudCBjb2RlIDE4MyAoS0VZX0YxMykKICAgIEV2ZW50IGNvZGUgMTg1IChLRVlfRjE1KQogICAg
RXZlbnQgY29kZSAxOTAgKEtFWV9GMjApCiAgICBFdmVudCBjb2RlIDE5MSAoS0VZX0YyMSkKICAg
IEV2ZW50IGNvZGUgMjAyIChLRVlfUFJPRzMpCiAgICBFdmVudCBjb2RlIDIwMyAoS0VZX1BST0c0
KQogICAgRXZlbnQgY29kZSAyMTIgKEtFWV9DQU1FUkEpCiAgICBFdmVudCBjb2RlIDIxNSAoS0VZ
X0VNQUlMKQogICAgRXZlbnQgY29kZSAyMjUgKEtFWV9CUklHSFRORVNTVVApCiAgICBFdmVudCBj
b2RlIDIyNiAoS0VZX01FRElBKQogICAgRXZlbnQgY29kZSAyMjcgKEtFWV9TV0lUQ0hWSURFT01P
REUpCiAgICBFdmVudCBjb2RlIDIyOSAoS0VZX0tCRElMTFVNRE9XTikKICAgIEV2ZW50IGNvZGUg
MjMwIChLRVlfS0JESUxMVU1VUCkKICAgIEV2ZW50IGNvZGUgMjM3IChLRVlfQkxVRVRPT1RIKQog
ICAgRXZlbnQgY29kZSAyMzggKEtFWV9XTEFOKQogICAgRXZlbnQgY29kZSAyNDAgKEtFWV9VTktO
T1dOKQogICAgRXZlbnQgY29kZSAyNDcgKEtFWV9SRktJTEwpCiAgICBFdmVudCBjb2RlIDQ3MCAo
S0VZX0ZOX0Y1KQogICAgRXZlbnQgY29kZSA1MzEgKEtFWV9UT1VDSFBBRF9PTikKICAgIEV2ZW50
IGNvZGUgNTYwIChLRVlfQUxTX1RPR0dMRSkKICBFdmVudCB0eXBlIDQgKEVWX01TQykKICAgIEV2
ZW50IGNvZGUgNCAoTVNDX1NDQU4pCktleSByZXBlYXQgaGFuZGxpbmc6CiAgUmVwZWF0IHR5cGUg
MjAgKEVWX1JFUCkKICAgIFJlcGVhdCBjb2RlIDAgKFJFUF9ERUxBWSkKICAgICAgVmFsdWUgICAg
MjUwCiAgICBSZXBlYXQgY29kZSAxIChSRVBfUEVSSU9EKQogICAgICBWYWx1ZSAgICAgMzMKUHJv
cGVydGllczoKVGVzdGluZyAuLi4gKGludGVycnVwdCB0byBleGl0KQpFdmVudDogdGltZSAxNjk3
NTgzMjM2Ljk3NTY2MSwgdHlwZSA0IChFVl9NU0MpLCBjb2RlIDQgKE1TQ19TQ0FOKSwgdmFsdWUg
MjAKRXZlbnQ6IHRpbWUgMTY5NzU4MzIzNi45NzU2NjEsIHR5cGUgMSAoRVZfS0VZKSwgY29kZSAy
NDAgKEtFWV9VTktOT1dOKSwgdmFsdWUgMQpFdmVudDogdGltZSAxNjk3NTgzMjM2Ljk3NTY2MSwg
LS0tLS0tLS0tLS0tLS0gU1lOX1JFUE9SVCAtLS0tLS0tLS0tLS0KRXZlbnQ6IHRpbWUgMTY5NzU4
MzIzNi45NzU2NzQsIHR5cGUgMSAoRVZfS0VZKSwgY29kZSAyNDAgKEtFWV9VTktOT1dOKSwgdmFs
dWUgMApFdmVudDogdGltZSAxNjk3NTgzMjM2Ljk3NTY3NCwgLS0tLS0tLS0tLS0tLS0gU1lOX1JF
UE9SVCAtLS0tLS0tLS0tLS0KRXZlbnQ6IHRpbWUgMTY5NzU4MzIzOC40MTMwMTgsIHR5cGUgNCAo
RVZfTVNDKSwgY29kZSA0IChNU0NfU0NBTiksIHZhbHVlIDJmCkV2ZW50OiB0aW1lIDE2OTc1ODMy
MzguNDEzMDE4LCB0eXBlIDEgKEVWX0tFWSksIGNvZGUgMjI1IChLRVlfQlJJR0hUTkVTU1VQKSwg
dmFsdWUgMQpFdmVudDogdGltZSAxNjk3NTgzMjM4LjQxMzAxOCwgLS0tLS0tLS0tLS0tLS0gU1lO
X1JFUE9SVCAtLS0tLS0tLS0tLS0KRXZlbnQ6IHRpbWUgMTY5NzU4MzIzOC40MTMwMzYsIHR5cGUg
MSAoRVZfS0VZKSwgY29kZSAyMjUgKEtFWV9CUklHSFRORVNTVVApLCB2YWx1ZSAwCkV2ZW50OiB0
aW1lIDE2OTc1ODMyMzguNDEzMDM2LCAtLS0tLS0tLS0tLS0tLSBTWU5fUkVQT1JUIC0tLS0tLS0t
LS0tLQpFdmVudDogdGltZSAxNjk3NTgzMjM5LjQ3MjIyNiwgdHlwZSA0IChFVl9NU0MpLCBjb2Rl
IDQgKE1TQ19TQ0FOKSwgdmFsdWUgMjAKRXZlbnQ6IHRpbWUgMTY5NzU4MzIzOS40NzIyMjYsIHR5
cGUgMSAoRVZfS0VZKSwgY29kZSAyNDAgKEtFWV9VTktOT1dOKSwgdmFsdWUgMQpFdmVudDogdGlt
ZSAxNjk3NTgzMjM5LjQ3MjIyNiwgLS0tLS0tLS0tLS0tLS0gU1lOX1JFUE9SVCAtLS0tLS0tLS0t
LS0KRXZlbnQ6IHRpbWUgMTY5NzU4MzIzOS40NzIyMzcsIHR5cGUgMSAoRVZfS0VZKSwgY29kZSAy
NDAgKEtFWV9VTktOT1dOKSwgdmFsdWUgMApFdmVudDogdGltZSAxNjk3NTgzMjM5LjQ3MjIzNywg
LS0tLS0tLS0tLS0tLS0gU1lOX1JFUE9SVCAtLS0tLS0tLS0tLS0KRXZlbnQ6IHRpbWUgMTY5NzU4
MzI0MS41OTk1MDAsIHR5cGUgNCAoRVZfTVNDKSwgY29kZSA0IChNU0NfU0NBTiksIHZhbHVlIDJm
CkV2ZW50OiB0aW1lIDE2OTc1ODMyNDEuNTk5NTAwLCB0eXBlIDEgKEVWX0tFWSksIGNvZGUgMjI1
IChLRVlfQlJJR0hUTkVTU1VQKSwgdmFsdWUgMQpFdmVudDogdGltZSAxNjk3NTgzMjQxLjU5OTUw
MCwgLS0tLS0tLS0tLS0tLS0gU1lOX1JFUE9SVCAtLS0tLS0tLS0tLS0KRXZlbnQ6IHRpbWUgMTY5
NzU4MzI0MS41OTk1MTEsIHR5cGUgMSAoRVZfS0VZKSwgY29kZSAyMjUgKEtFWV9CUklHSFRORVNT
VVApLCB2YWx1ZSAwCkV2ZW50OiB0aW1lIDE2OTc1ODMyNDEuNTk5NTExLCAtLS0tLS0tLS0tLS0t
LSBTWU5fUkVQT1JUIC0tLS0tLS0tLS0tLQo=
--=_520c7d88f4c6099c929b99f4c94291d9
Content-Transfer-Encoding: base64
Content-Type: text/plain;
 name=evtest-video-bus.txt
Content-Disposition: attachment;
 filename=evtest-video-bus.txt;
 size=1791

SW5wdXQgZHJpdmVyIHZlcnNpb24gaXMgMS4wLjEKSW5wdXQgZGV2aWNlIElEOiBidXMgMHgxOSB2
ZW5kb3IgMHgwIHByb2R1Y3QgMHg2IHZlcnNpb24gMHgwCklucHV0IGRldmljZSBuYW1lOiAiVmlk
ZW8gQnVzIgpTdXBwb3J0ZWQgZXZlbnRzOgogIEV2ZW50IHR5cGUgMCAoRVZfU1lOKQogIEV2ZW50
IHR5cGUgMSAoRVZfS0VZKQogICAgRXZlbnQgY29kZSAyMjQgKEtFWV9CUklHSFRORVNTRE9XTikK
ICAgIEV2ZW50IGNvZGUgMjI1IChLRVlfQlJJR0hUTkVTU1VQKQogICAgRXZlbnQgY29kZSAyMjcg
KEtFWV9TV0lUQ0hWSURFT01PREUpCiAgICBFdmVudCBjb2RlIDI0MSAoS0VZX1ZJREVPX05FWFQp
CiAgICBFdmVudCBjb2RlIDI0MiAoS0VZX1ZJREVPX1BSRVYpCiAgICBFdmVudCBjb2RlIDI0MyAo
S0VZX0JSSUdIVE5FU1NfQ1lDTEUpCiAgICBFdmVudCBjb2RlIDI0NCAoS0VZX0JSSUdIVE5FU1Nf
WkVSTykKICAgIEV2ZW50IGNvZGUgMjQ1IChLRVlfRElTUExBWV9PRkYpClByb3BlcnRpZXM6ClRl
c3RpbmcgLi4uIChpbnRlcnJ1cHQgdG8gZXhpdCkKRXZlbnQ6IHRpbWUgMTY5NzU4MzA2MS42OTUy
ODUsIHR5cGUgMSAoRVZfS0VZKSwgY29kZSAyMjQgKEtFWV9CUklHSFRORVNTRE9XTiksIHZhbHVl
IDEKRXZlbnQ6IHRpbWUgMTY5NzU4MzA2MS42OTUyODUsIC0tLS0tLS0tLS0tLS0tIFNZTl9SRVBP
UlQgLS0tLS0tLS0tLS0tCkV2ZW50OiB0aW1lIDE2OTc1ODMwNjEuNjk1MzAzLCB0eXBlIDEgKEVW
X0tFWSksIGNvZGUgMjI0IChLRVlfQlJJR0hUTkVTU0RPV04pLCB2YWx1ZSAwCkV2ZW50OiB0aW1l
IDE2OTc1ODMwNjEuNjk1MzAzLCAtLS0tLS0tLS0tLS0tLSBTWU5fUkVQT1JUIC0tLS0tLS0tLS0t
LQpFdmVudDogdGltZSAxNjk3NTgzMDYyLjkzNTIzMywgdHlwZSAxIChFVl9LRVkpLCBjb2RlIDIy
NSAoS0VZX0JSSUdIVE5FU1NVUCksIHZhbHVlIDEKRXZlbnQ6IHRpbWUgMTY5NzU4MzA2Mi45MzUy
MzMsIC0tLS0tLS0tLS0tLS0tIFNZTl9SRVBPUlQgLS0tLS0tLS0tLS0tCkV2ZW50OiB0aW1lIDE2
OTc1ODMwNjIuOTM1MjQ4LCB0eXBlIDEgKEVWX0tFWSksIGNvZGUgMjI1IChLRVlfQlJJR0hUTkVT
U1VQKSwgdmFsdWUgMApFdmVudDogdGltZSAxNjk3NTgzMDYyLjkzNTI0OCwgLS0tLS0tLS0tLS0t
LS0gU1lOX1JFUE9SVCAtLS0tLS0tLS0tLS0KRXZlbnQ6IHRpbWUgMTY5NzU4MzA2NS4xNjkzNDQs
IHR5cGUgMSAoRVZfS0VZKSwgY29kZSAyMjQgKEtFWV9CUklHSFRORVNTRE9XTiksIHZhbHVlIDEK
RXZlbnQ6IHRpbWUgMTY5NzU4MzA2NS4xNjkzNDQsIC0tLS0tLS0tLS0tLS0tIFNZTl9SRVBPUlQg
LS0tLS0tLS0tLS0tCkV2ZW50OiB0aW1lIDE2OTc1ODMwNjUuMTY5MzY0LCB0eXBlIDEgKEVWX0tF
WSksIGNvZGUgMjI0IChLRVlfQlJJR0hUTkVTU0RPV04pLCB2YWx1ZSAwCkV2ZW50OiB0aW1lIDE2
OTc1ODMwNjUuMTY5MzY0LCAtLS0tLS0tLS0tLS0tLSBTWU5fUkVQT1JUIC0tLS0tLS0tLS0tLQpF
dmVudDogdGltZSAxNjk3NTgzMDY1Ljc0ODgzMywgdHlwZSAxIChFVl9LRVkpLCBjb2RlIDIyNSAo
S0VZX0JSSUdIVE5FU1NVUCksIHZhbHVlIDEKRXZlbnQ6IHRpbWUgMTY5NzU4MzA2NS43NDg4MzMs
IC0tLS0tLS0tLS0tLS0tIFNZTl9SRVBPUlQgLS0tLS0tLS0tLS0tCkV2ZW50OiB0aW1lIDE2OTc1
ODMwNjUuNzQ4ODYzLCB0eXBlIDEgKEVWX0tFWSksIGNvZGUgMjI1IChLRVlfQlJJR0hUTkVTU1VQ
KSwgdmFsdWUgMApFdmVudDogdGltZSAxNjk3NTgzMDY1Ljc0ODg2MywgLS0tLS0tLS0tLS0tLS0g
U1lOX1JFUE9SVCAtLS0tLS0tLS0tLS0K
--=_520c7d88f4c6099c929b99f4c94291d9--
