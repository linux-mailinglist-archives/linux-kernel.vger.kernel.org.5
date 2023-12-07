Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2904080954C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444118AbjLGW1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjLGW04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:26:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE591711;
        Thu,  7 Dec 2023 14:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701988010; x=1702592810; i=w_armin@gmx.de;
        bh=16WGdSv1+wfNklniu4sIQ3a5/s+FjR905kU76pYmoek=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=II+4uhQ47c/heN/9/Kv9a3ubuYSXD6Bq3S2q8MW6tDrxQlf3RGaDxUzlik4/HLeg
         tnLaU20ueLBKeQluHIxlS+rEKEAOLdniLucywJR5TYR5zJtigo7CLMsroIHUtfTaU
         itp4JUnwjsBqDTwV6jTNeu9HEjkcPkMzP87YoQM+3atzXGj0IkebGwkNw0dxq7ks6
         uKRmNTtyQI0c9hKJJ6OZCl7DkLbE1A1yqUKcb3Wu34yeC1ZeFKj2bQ93KHBpDtQb/
         oTRvmIek9VL32T/mxZg9TAyov9pv0jeSTO7KMHgEvkinqo2Kx8xpcpjr6PLGiYEN7
         aO2CEXlhDzs+iXSVLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M9Wuk-1r852z3pQK-005aLd; Thu, 07 Dec 2023 23:26:49 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, corbet@lwn.net
Cc:     Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] platform/x86: wmi: Add driver development guide
Date:   Thu,  7 Dec 2023 23:26:23 +0100
Message-Id: <20231207222623.232074-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207222623.232074-1-W_Armin@gmx.de>
References: <20231207222623.232074-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2qa6zIdjybo5q629oAtjbiXMkCrTpt+gIGIfAX5ZpzSG5Dy44i5
 Ip69bUk3E+GN/Xq4ChdcANtHh0/d0jtCb89eKTap7xeSlJIc74+Ei+050cM3LBj1MDljV+Z
 FItLSj84qZuaaM7DhpAK26XJdpiS2yybmflZ7+2UycBM2RL7VdH3anbhcXzMd+sE2TxMBPu
 e8KkQKe/twR+19lTu6JQw==
UI-OutboundReport: notjunk:1;M01:P0:YQBEAL5gS1I=;qafX62ughQgYefvaW5PcGYW4NfN
 og+e4JKSRBWlhZ+OfbVcii/qfl4wcX8eIdFMi2w2wMrzCZor84RvRBHnemYFKbfnkmSVFgoml
 C7XIWRfFsQI1mEgakfDV3k1D96l+++AX8XX+rBxUlQvvNemDgwbGdgFS5M06OpGcxJKEHLXiV
 rPs7Jpa4AWkedthXHLWelgt5aXncx+FAtGPpHqqOUyTT6j2BxRowgU4PSvQVvRN8+SUGyXS/e
 XBdIpSqsPTjpE2PjNZVZ1JT3w1EHOedSmbb/MXsehBcn48qFMLKpa5D00DZFK8e9pj62b435h
 fK7KcJiS1PYLYz3XqJtArvtNJL9QeTKttyEoINGVMDip9hD1ngWcMQBwEYm7ytr34iiF/xohJ
 gbHkLRoDRsHiN3LVV1Spt2lo+KRLLWN1cLtwcYq5vqNMUMuX1koeC/C6+c6OgnsusXjvk+Hdt
 Jm1AZoJMSnYPGIM/zm2HefApjtKsTaqQ52BzbnxkNfmHVUhKFk60cqnluOO2MUr5Ry5P4oA4R
 /i9MkVeW/gmiJHCy4ds/EbNEigcK6A96a+DCEfg6lImwsuVMJuyGw1Q35ztZPDR5prulsCG1J
 arwVf8LMJzl40Ahz3bfJTUgzyxiHlmI1T3pohUoYW0mVpxsKxSCiI3gotHKTTidTaEg8r2UFs
 KCY51v3PUF0Zeoj6VTDDuuWdwYc+Y5WkEQe/bc0+/TZ+tfs7Tmf4enWudvqC1nua97TUiXAU0
 F+MsDvOFhKDbt2QEnRrS5o16l5hKVYyZOnP6y/sE96On9rSWTTuwC26DVad4sATQgjJveoKMM
 AdH5vfeES8EFxlQWrR/rJjiBIBZwKLIifBNGj8LLGdcE1vUZF8g2kR8pETdSnW0xHkaKmhDJI
 tSYIARd1aMbxoA2WnkB8H38UdaI2bs+NgPuT+chcz0azkqIbs35JWSGmnlj21PEo8nMNh7Dx/
 0/hBR8+q2msPyIDnSHB0tOGwonQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2010, an LWN article covering WMI drivers exists:

	https://lwn.net/Articles/391230/

Since the introduction of the modern bus-based interface
and other userspace tooling (fwts wmi, bmfdec, ...), this
article is outdated and causes people to still submit new
WMI drivers using the deprecated GUID-based interface.
Fix this by adding a short guid on how to develop WMI drivers
using the modern bus-based interface.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../wmi/driver-development-guide.rst          | 126 ++++++++++++++++++
 Documentation/wmi/index.rst                   |   1 +
 2 files changed, 127 insertions(+)
 create mode 100644 Documentation/wmi/driver-development-guide.rst

diff --git a/Documentation/wmi/driver-development-guide.rst b/Documentatio=
n/wmi/driver-development-guide.rst
new file mode 100644
index 000000000000..a831e2728d25
=2D-- /dev/null
+++ b/Documentation/wmi/driver-development-guide.rst
@@ -0,0 +1,126 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+WMI driver development guide
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+The WMI subsystem provides a rich driver api for implementing WMI drivers=
,
+documented at Documentation/driver-api/wmi.rst. This document will serve
+as an introductory guide for WMI driver writers using this API. It is sup=
posed
+t be an successor to the original `LWN article <https://lwn.net/Articles/=
391230/>`_
+which deals with WMI drivers using the deprecated GUID-based WMI interfac=
e.
+
+Optaining WMI device information
+--------------------------------
+
+Before developing an WMI driver, information about the WMI device in ques=
tion
+must be optained. The `lswmi <https://pypi.org/project/lswmi>`_ utility c=
an be
+used to display detailed WMI device information using the following comma=
nd:
+
+::
+
+  lswmi -V
+
+The resulting output will contain information about all WMI devices insid=
e a given
+machine, plus some extra information.
+
+In order to find out more about the interface used to communicate with a =
WMI device,
+the `bmfdec <https://github.com/pali/bmfdec>`_ utilities can be used to d=
ecode
+the Binary MOF information used to describe WMI devices. The ``wmi-bmof``=
 driver
+exposes this information to userspace, see Documentation/ABI/stable/sysfs=
-platform-wmi-bmof.
+In order to retrieve the decoded Binary MOF information, use the followin=
g command (requires root):
+
+::
+
+  ./bmf2mof /sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]=
/bmof
+
+Sometimes, looking at the disassembled ACPI tables used to describe the W=
MI device
+helps in understanding how the WMI device is supposed to work. To find ou=
t which
+ACPI method handles which WMI device, the `fwts <https://github.com/fwts/=
fwts>`_
+program can be used with the following command (requires root):
+
+::
+
+  fwts wmi -
+
+Basic WMI driver structure
+--------------------------
+
+The basic WMI driver is build around the struct wmi_driver, which is then=
 bound
+to matching WMI devices using an struct wmi_device_id table. Please note =
that each
+WMI driver should be able to be instantiated multiple times.
+
+::
+
+  static const struct wmi_device_id foo_id_table[] =3D {
+         { "936DA01F-9ABD-4D9D-80C7-02AF85C822A8", NULL },
+         { }
+  };
+  MODULE_DEVICE_TABLE(wmi, foo_id_table);
+
+  static struct wmi_driver foo_driver =3D {
+        .driver =3D {
+                .name =3D "foo",
+                .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,        /* opti=
onal */
+                .pm =3D pm_sleep_ptr(&foo_dev_pm_ops),            /* opti=
onal */
+        },
+        .id_table =3D foo_id_table,
+        .probe =3D foo_probe,
+        .remove =3D foo_remove,         /* optional, devres is preferred =
*/
+        .notify =3D foo_notify,         /* optional, for event handling *=
/
+  };
+  module_wmi_driver(foo_driver);
+
+If your WMI driver is not using any deprecated GUID-based WMI functions a=
nd is
+able to be instantiated multiple times, please add its GUID to ``allow_du=
plicates``
+inside drivers/platform/x86/wmi.c, so that the WMI subsystem does not blo=
ck duplicate
+GUIDs for it.
+
+WMI method drivers
+------------------
+
+WMI drivers can call WMI device methods using wmidev_evaluate_method(), t=
he
+structure of the ACPI buffer passed to this function is device-specific a=
nd usually
+needs some tinkering to get right. Looking at the ACPI tables containing =
the WMI
+device usually helps here. The method id and instance number passed to th=
is function
+are also device-specific, looking at the decoded Binary MOF is usually en=
ough to
+find the right values.
+The maximum instance number can be retrieved during runtime using wmidev_=
instance_count().
+
+Take a look at drivers/platform/x86/inspur_platform_profile.c for an exam=
ple WMI method driver.
+
+WMI data block drivers
+----------------------
+
+WMI drivers can query WMI device data blocks using wmidev_block_query(), =
the
+structure of the returned ACPI object is again device-specific. Some WMI =
devices
+also allow for setting data blocks using wmidev_block_set().
+The maximum instance number can also be retrieved using wmidev_instance_c=
ount().
+
+Take a look at drivers/platform/x86/intel/wmi/sbl-fw-update.c for an exam=
ple
+WMI data block driver.
+
+WMI event drivers
+-----------------
+
+WMI drivers can receive WMI event notifications by providing the notify()=
 callback
+inside the struct wmi_driver. The WMI subsystem will then take care of se=
tting
+up the WMI event accordingly. Plase note that the ACPI object passed to t=
his callback
+is optional and its structure device-specific. It also does not need to b=
e freed,
+the WMI subsystem takes care of that.
+
+Take a look at drivers/platform/x86/xiaomi-wmi.c for an example WMI event=
 driver.
+
+Things to avoid
+---------------
+
+When developing WMI drivers, there are a couple of things which should be=
 avoid
+if feasible:
+
+- usage of the deprecated GUID-based WMI interface
+- bypassing of the WMI subsystem when talking to WMI devices
+- WMI drivers which cannot be instantiated multiple times.
+
+Many older WMI drivers violate one or more points from this list. The rea=
son for
+this is that the WMI subsystem evolved significantly over the last two de=
cades,
+so there is a lot of legacy cruft inside older WMI drivers.
diff --git a/Documentation/wmi/index.rst b/Documentation/wmi/index.rst
index 537cff188e14..fec4b6ae97b3 100644
=2D-- a/Documentation/wmi/index.rst
+++ b/Documentation/wmi/index.rst
@@ -8,6 +8,7 @@ WMI Subsystem
    :maxdepth: 1

    acpi-interface
+   driver-development-guide
    devices/index

 .. only::  subproject and html
=2D-
2.39.2

