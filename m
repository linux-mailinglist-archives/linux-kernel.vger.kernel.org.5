Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747A480ABAC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjLHSLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLHSLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:11:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7705B173B;
        Fri,  8 Dec 2023 10:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1702059047; x=1702663847; i=w_armin@gmx.de;
        bh=P9edKpKexTHVvkOcXN5hlM+yTHAv/d7T1y5gwBKtBDY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=ogzh/wErEJl3m6V15nDnjN9SZ+uAT4up6rCslwEYVM/0zoR5NPySf3g+VaFHA+O9
         p+Lhvpc1UUhc7MYJBiUEy6jUkVqrR78+GslmRzI2rSroiI7pE/Ntu6AH5DVUcumVa
         xTHdRXM66tja8T8c7zyotsN7XkYVBHl775X7jirqZAii8m/fucZTLNKZOCqkYPMxY
         oWXy3X9qX41w3nljlHbEgDQHBcvxVJudEQfFE5pan+FqKmwdbFMvqZmx6euD6lxvx
         hupCs/yOZJXx5LJI621NURFyqg5Vq9wramxSMcr2hEHYCAzyOxLx8zZKVURk/KxW3
         wMH2mDPwCgjMu7VxPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQg6-1rOuuN2pCi-00vMWS; Fri, 08
 Dec 2023 19:10:47 +0100
Message-ID: <e7da54e0-177c-46cc-8407-17bdb07010a0@gmx.de>
Date:   Fri, 8 Dec 2023 19:10:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] platform/x86: wmi: Add driver development guide
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, corbet@lwn.net,
        Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20231207222623.232074-1-W_Armin@gmx.de>
 <20231207222623.232074-6-W_Armin@gmx.de>
 <aefc53a4-2472-4613-ef9d-5d3ad972bef3@linux.intel.com>
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <aefc53a4-2472-4613-ef9d-5d3ad972bef3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T7gz8CBFZZ/+cLVrnlzQUdkpmoZ1c6nscBTQslx3HIoM5Mtky8l
 jGLsxbNrWCcGGOZRi1i52etNBUTAT0c8BMs+e49dj6uy7f1868EhogLvy0uHXRheHHBrbnL
 WK499EcnjCp9b5n9uJqeyx9UKLdgZpu/dT7WDCQy/NUzrX3aQUnUxKAcgJvQC16sF3G//Ue
 YYQAxuwJMebWnFEffBoYQ==
UI-OutboundReport: notjunk:1;M01:P0:yyAgzB0BofA=;VWrJ0W4bZblvabSS9HUzMsXIw5a
 AiqsgXQGHu5tWDoVmsBaiiLhkAbilRv/fk0uSH2SkpDiv1+8rZv6zbKP6aQxu1VgjBgOYK96k
 QvkEHA/jhnkKXueAviXbtPGk7vJ4nVQ07pgyrFTTVrzoi5nBnF1kor3RrhFhFs9yBn4QU359h
 f/ck86TV/HHczksasfrDRmGSVCseYWI76LC/Cd9BFkYu0oQFgsmauz7O+sGoI7e15xD6N0uZt
 ZMKS1/ergSdoJ7lY89fIDLKAOMWHJUviFMQ7m5RGupiRTRFF/IW8LRKCIJXJ+IdfUZegCNiRZ
 QYFZ5IOLVbdPNA2FtCUAN5FM9Zp9ediGyCBrtylkbKo+dVKW8zFNcro/moCpsIRhOPvkzKzFq
 +uX+0v+ga701N6Zj4AtRrz+d4nJHHaiHghyLsOQuVHksMw2F9Qn5aixcQK69iKXbG0EIksyYO
 FUqtSo7lRvgVAvWnQG/WFVSZXAmxgn5aoCKDryEQlxTQzgCGjBqkXuMiud1bQ6QrDzfogarFw
 VErppY+dagcZQS72gVTfePTYDG7WYPAl8htd/FDb5j2ynLyzclYY3kfLjzRHUIZTof0Y7rkJV
 i+zP2e+Jq4qIzN+XplTkfXE1gzJySwjMEGMNrxhbtTm1/n/4N9Lm+65QnOF5OsbX2KZpS9wsC
 thnFaqMUVcJEixXG0sLsO2/y0Z+/61+ztt4WT9Y2JQwkAFdA4PolZwjrdLSqR8WZsu5/HInYd
 /YsPhhcOmvKNDLeSwjN63sg1041fUkDen0x8wtu9UOVua9iPIQ0bW7tdIyssgwCevQXXc7nZM
 Hh1VxeMbKtWAmOF+7hZNAfi2lLSHlvJp/kH8VTlUn1cL+grSyDlAcH5AMRJOUGuok5e0vvRSi
 TdTptJT75owqFET+n54gNN7K46hMxzJ5UfGila9pdwKLEqMKJS3xbIaHSVxG6rDZcdEvT+Mg4
 20+tjcvdFnqkSnAUwRYDMQrdhEk=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.12.23 um 13:25 schrieb Ilpo J=C3=A4rvinen:

> On Thu, 7 Dec 2023, Armin Wolf wrote:
>
>> Since 2010, an LWN article covering WMI drivers exists:
>>
>> 	https://lwn.net/Articles/391230/
>>
>> Since the introduction of the modern bus-based interface
>> and other userspace tooling (fwts wmi, bmfdec, ...), this
>> article is outdated and causes people to still submit new
>> WMI drivers using the deprecated GUID-based interface.
>> Fix this by adding a short guid on how to develop WMI drivers
> Too used to typing guid(?), here you want "guide" instead. :-D (I know
> that feeling when my fingers type something else than I think).
>
>> using the modern bus-based interface.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   .../wmi/driver-development-guide.rst          | 126 +++++++++++++++++=
+
>>   Documentation/wmi/index.rst                   |   1 +
>>   2 files changed, 127 insertions(+)
>>   create mode 100644 Documentation/wmi/driver-development-guide.rst
>>
>> diff --git a/Documentation/wmi/driver-development-guide.rst b/Documenta=
tion/wmi/driver-development-guide.rst
>> new file mode 100644
>> index 000000000000..a831e2728d25
>> --- /dev/null
>> +++ b/Documentation/wmi/driver-development-guide.rst
>> @@ -0,0 +1,126 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> +WMI driver development guide
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> +
>> +The WMI subsystem provides a rich driver api for implementing WMI driv=
ers,
> API
>
>> +documented at Documentation/driver-api/wmi.rst. This document will ser=
ve
>> +as an introductory guide for WMI driver writers using this API. It is =
supposed
>> +t be an successor to the original `LWN article <https://lwn.net/Articl=
es/391230/>`_
> t -> to
>
>> +which deals with WMI drivers using the deprecated GUID-based WMI inter=
face.
>> +
>> +Optaining WMI device information
> Obtaining
>
>> +--------------------------------
>> +
>> +Before developing an WMI driver, information about the WMI device in q=
uestion
>> +must be optained. The `lswmi <https://pypi.org/project/lswmi>`_ utilit=
y can be
> obtained
>
>> +used to display detailed WMI device information using the following co=
mmand:
>> +
>> +::
>> +
>> +  lswmi -V
>> +
>> +The resulting output will contain information about all WMI devices in=
side a given
>> +machine, plus some extra information.
>> +
>> +In order to find out more about the interface used to communicate with=
 a WMI device,
>> +the `bmfdec <https://github.com/pali/bmfdec>`_ utilities can be used t=
o decode
>> +the Binary MOF information used to describe WMI devices. The ``wmi-bmo=
f`` driver
> (Managed Object Format)
>
>> +exposes this information to userspace, see Documentation/ABI/stable/sy=
sfs-platform-wmi-bmof.
> This should use a true link to the file.
>
>> +In order to retrieve the decoded Binary MOF information, use the follo=
wing command (requires root):
>> +
>> +::
>> +
>> +  ./bmf2mof /sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[=
-X]/bmof
>> +
>> +Sometimes, looking at the disassembled ACPI tables used to describe th=
e WMI device
>> +helps in understanding how the WMI device is supposed to work. To find=
 out which
>> +ACPI method handles which WMI device, the `fwts <https://github.com/fw=
ts/fwts>`_
>> +program can be used with the following command (requires root):
>> +
>> +::
>> +
>> +  fwts wmi -
>> +
>> +Basic WMI driver structure
>> +--------------------------
>> +
>> +The basic WMI driver is build around the struct wmi_driver, which is t=
hen bound
>> +to matching WMI devices using an struct wmi_device_id table. Please no=
te that each
> an struct -> a struct
>
>> +WMI driver should be able to be instantiated multiple times.
>> +
>> +::
>> +
>> +  static const struct wmi_device_id foo_id_table[] =3D {
>> +         { "936DA01F-9ABD-4D9D-80C7-02AF85C822A8", NULL },
>> +         { }
>> +  };
>> +  MODULE_DEVICE_TABLE(wmi, foo_id_table);
>> +
>> +  static struct wmi_driver foo_driver =3D {
>> +        .driver =3D {
>> +                .name =3D "foo",
>> +                .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,        /* o=
ptional */
>> +                .pm =3D pm_sleep_ptr(&foo_dev_pm_ops),            /* o=
ptional */
>> +        },
>> +        .id_table =3D foo_id_table,
>> +        .probe =3D foo_probe,
>> +        .remove =3D foo_remove,         /* optional, devres is preferr=
ed */
>> +        .notify =3D foo_notify,         /* optional, for event handlin=
g */
>> +  };
>> +  module_wmi_driver(foo_driver);
>> +
>> +If your WMI driver is not using any deprecated GUID-based WMI function=
s and is
>> +able to be instantiated multiple times, please add its GUID to ``allow=
_duplicates``
>> +inside drivers/platform/x86/wmi.c, so that the WMI subsystem does not =
block duplicate
>> +GUIDs for it.
> Just voicing wouldn't it be more useful to not burden new stuff with thi=
s
> at all and construct the opposite list instead with the GUIDs that have
> a driver that don't support duplicates? It's the existing set of GUIDs w=
e
> have in-tree minus those currently on the list, correct?

You are right about this, i am already thinking about a different approach=
 which
does not rely on such a whitelist.

Basically, the legacy GUID-based functions only act on WMI devices which h=
ave an
ID of zero (which means they where found first), so that legacy drivers do=
 not see
WMI devices with a duplicate GUID.
At the same time, WMI drivers would have to set a flag inside their struct=
 wmi_driver
to indicate that they can be safely instantiated multiple times, otherwise=
 they would
only be allowed to bind to WMI devices with an ID of zero (which are uniqu=
e).

This would replace the whitelist with a flag inside wmi_driver, which can =
be enabled
by the driver developer without having to touch the WMI driver core at all=
.

I think i will split out this patch from the next revision of the series, =
since getting
rid of the whitelist should be a separate series.

Thanks,
Armin Wolf

>> +WMI method drivers
>> +------------------
>> +
>> +WMI drivers can call WMI device methods using wmidev_evaluate_method()=
, the
>> +structure of the ACPI buffer passed to this function is device-specifi=
c and usually
>> +needs some tinkering to get right. Looking at the ACPI tables containi=
ng the WMI
>> +device usually helps here. The method id and instance number passed to=
 this function
>> +are also device-specific, looking at the decoded Binary MOF is usually=
 enough to
>> +find the right values.
>> +The maximum instance number can be retrieved during runtime using wmid=
ev_instance_count().
>> +
>> +Take a look at drivers/platform/x86/inspur_platform_profile.c for an e=
xample WMI method driver.
>> +
>> +WMI data block drivers
>> +----------------------
>> +
>> +WMI drivers can query WMI device data blocks using wmidev_block_query(=
), the
>> +structure of the returned ACPI object is again device-specific. Some W=
MI devices
>> +also allow for setting data blocks using wmidev_block_set().
>> +The maximum instance number can also be retrieved using wmidev_instanc=
e_count().
>> +
>> +Take a look at drivers/platform/x86/intel/wmi/sbl-fw-update.c for an e=
xample
>> +WMI data block driver.
>> +
>> +WMI event drivers
>> +-----------------
>> +
>> +WMI drivers can receive WMI event notifications by providing the notif=
y() callback
>> +inside the struct wmi_driver. The WMI subsystem will then take care of=
 setting
>> +up the WMI event accordingly. Plase note that the ACPI object passed t=
o this callback
> Plase -> Please
>
>> +is optional and its structure device-specific. It also does not need t=
o be freed,
> structure is device-specific.
>
>> +the WMI subsystem takes care of that.
> I'd state the freeing part more strongly:
>
> Releasing the ACPI object is handled by the WMI subsystem, not the drive=
r.
>
>> +
>> +Take a look at drivers/platform/x86/xiaomi-wmi.c for an example WMI ev=
ent driver.
>> +
>> +Things to avoid
>> +---------------
>> +
>> +When developing WMI drivers, there are a couple of things which should=
 be avoid
>> +if feasible:
>> +
>> +- usage of the deprecated GUID-based WMI interface
> It would be nice to be more specific because it's far from obvious at th=
is
> point how to differentiate. So perhaps adding something like this would
> help:
>
> (avoid functions with wmi_ prefix that input GUID converting it into
> a wmi_device using wmi_find_device_by_guid()).
>
>> +- bypassing of the WMI subsystem when talking to WMI devices
>> +- WMI drivers which cannot be instantiated multiple times.
>> +
>> +Many older WMI drivers violate one or more points from this list. The =
reason for
>> +this is that the WMI subsystem evolved significantly over the last two=
 decades,
>> +so there is a lot of legacy cruft inside older WMI drivers.
>
