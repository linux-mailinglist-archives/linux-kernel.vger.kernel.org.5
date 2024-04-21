Return-Path: <linux-kernel+bounces-152593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E08AC0E7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 21:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC13B1C2086B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689643F9E9;
	Sun, 21 Apr 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uUJri1DY"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C249D29B;
	Sun, 21 Apr 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713726740; cv=none; b=YRPxuIYy9pmT/LjCXNvFHWAX+m9J8YQp5I6Uaj25areCStuknblpg7w3Y1N8ywMwG3fsq1gbkQUO0izh4gpMEXHbDPLffB91lVgtR+7kRencs3jOK2EAp93TTt9a2KgiOTn9gjq27kQim98Rl+yA2r4PqAiVxo22BXG7XvrxRNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713726740; c=relaxed/simple;
	bh=9HgGW5saEccWSefyGKMgsnt5U3SeKV0NOEnD1SzN6dM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RIXFgI3CM1PcVQ+nEi3dPpNRR84l7m7NMSMdPwW/uVcv+Ga6/348W6S4YjZo6KxA/N5w5rqn1x4ip52ecVwjljZkfUoyZCiLCj3xQzbV4Wfy0HA+hHIt9mAwRFuq1i8lod3WHd1xj3zIFl27v8NmZTvRf/mVWR5dAbMVuRgEpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=uUJri1DY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713726713; x=1714331513; i=w_armin@gmx.de;
	bh=C3nOF7VZQWjKfoiS3l7MxfB0wSghHRhz1oXuqCqL79Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uUJri1DY7bGDtNfiTB0y/Z4EcdCxUUmuGrDmPUcN8SS61cQsLWCBxR1czt67iO7A
	 9mBNDB0y3MSeioqf7Cmo8v7DdNMtZQmqyVeFtTFVpIv/NlFgOJUF9ki/T402Fghwp
	 dgdImXzsrhNtJIWMjYGvV86SQGQ5WwoUma3wNsqO3CE6Dgli5iKDTSDPPBYAdn7p2
	 D8szXFJCViGXZfpyVyntZvP555/sUI6oO9nPJpOscrDz2GVkitpSL5W94aOAvQPuL
	 GqNo9DPBw9iYaZMIaPnrK17gqddEsI0Vz13Z2gZM6D2Nzz9GWOzrc12JPs92fyt+t
	 qBbLBLu3TxBk68Imxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N4hvb-1sfpHz47zb-011kDs; Sun, 21 Apr 2024 21:11:53 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: teackot@gmail.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: wmi: Add MSI WMI Platform driver
Date: Sun, 21 Apr 2024 21:11:45 +0200
Message-Id: <20240421191145.3189-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:op9LldCKhKQfYf92rcprYrE6yaKM79RzEne4s+I5kzqXLnmuYkT
 cI84PdR34du9bIGLykEavNEbSi4npebGGJZETH2cVaC4DqyZmh0d2yyvn4NcRnYmjeiwtU0
 Hj7bt6tTs3hyFGx3DAqtFbtNPC4dpLAKEepnA4jWRMwEx6mJGWkmqB9jX6fg9f2NOaWOS5b
 RTsZOjAr8+BU0VgA6Wr/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SK7x8n+5W9Q=;A1NcPayJCzufCfizrTsaJ6rr074
 koMA+M0lpJfGgoo8qZkg2CocoYSZicvhLnC4fwlm0zpen22bkF0QZ+/IkNEySxexFS1YqaEAf
 U1dQG0L3BIXW42LpCUks73HClXd/SKivDcZLvdEObSIW8BlOHJRaFZG6spEVNy4i6CSQb+4G+
 mJjt9BZWFJ3W+6aOllSejRD2GAIxNGKkha4XIuQ62WfItcHDMBmPf1OqwnQ5QfGCewWFQeT8z
 guSkC4gscc/Yvih5Xv7Vg6Dw6T9x0iirxQ3mhtRn+/uFlgBDOFSBIHViZwcsBSv5zSWYDwgg6
 ri3pzb+KYY5QGHACfHcuy2orKlAXiKy8FUoZv/Ng0QhJPEedSWMGhARc5Gr8zf+DYTVrkedDH
 WWXYujboa0BhtnaOFdEZT/zaUSWipLe3yxvornnE13AZzrWwCFhC7wFk9yseE6z0265/GZLsG
 WSorv1mfsj0SsnU0bJ3B24yE9dRGIJMzi237ok9ktjqx4ZRGfV7AetmEHnn1R8mzqq8it/qI5
 L9JjMjqI9aa8ivDKTPms6jdWH1MnY4QkM34LqP73GeL+YkEtTuRaswm7n5w8iHnctExQWJFgf
 Subt2mght3HS+7fhXH1wstDW4WNRLqferWfBEFD7bo6yuxYyvtvTsPOOYvkTBkzR2VTrdLDn1
 7BQCFd0T3ZWxZuuX783/u8FynbemZvpss8MXTrFarCZ6ENfVHRrYmT6LlPtkdqRA4g7Zc2Zft
 V8e09eKxnb45pkHXlw4UffwrYAihv2HQ7r0cyi4cFdKZ/JbpSu8teHCTi7JWwmekZZXUAloIC
 VXT3N2NvopVA/W0f9mhM+2gbxcx2tTL9Ov9vKexuhGLLs=

Add a new driver for the MSI WMI Platform interface. The underlying
ACPI WMI interface supports many features, but so far only reading
of fan speed sensors is implemented.

The driver was reverse-engineered based on a user request to the
lm-sensors project, see the github issue for details.

The ACPI WMI interface used by this driver seems to use the same
embedded controller interface as the msi-ec driver, but supports
automatic discovery of supported machines without relying on a
DMI whitelist.

The driver was tested by the user who created the github issue.

Closes: https://github.com/lm-sensors/lm-sensors/issues/475
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../ABI/testing/debugfs-msi-wmi-platform      |  14 +
 .../wmi/devices/msi-wmi-platform.rst          | 194 ++++++++
 MAINTAINERS                                   |   8 +
 drivers/platform/x86/Kconfig                  |  11 +
 drivers/platform/x86/Makefile                 |   1 +
 drivers/platform/x86/msi-wmi-platform.c       | 428 ++++++++++++++++++
 6 files changed, 656 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-msi-wmi-platform
 create mode 100644 Documentation/wmi/devices/msi-wmi-platform.rst
 create mode 100644 drivers/platform/x86/msi-wmi-platform.c

diff --git a/Documentation/ABI/testing/debugfs-msi-wmi-platform b/Document=
ation/ABI/testing/debugfs-msi-wmi-platform
new file mode 100644
index 000000000000..71f9992168d8
=2D-- /dev/null
+++ b/Documentation/ABI/testing/debugfs-msi-wmi-platform
@@ -0,0 +1,14 @@
+What:		/sys/kernel/debug/msi-wmi-platform-<wmi_device_name>/*
+Date:		April 2024
+KernelVersion:	6.10
+Contact:	Armin Wolf <W_Armin@gmx.de>
+Description:
+		This file allows to execute the associated WMI method with the same nam=
e.
+
+		To start the execution, write a  buffer containing the method arguments
+		at file offset 0. Partial writes or writes at a different offset are no=
t
+		supported.
+
+		The buffer returned by the WMI method can then be read from the file.
+
+		See Documentation/wmi/devices/msi-wmi-platform.rst for details.
diff --git a/Documentation/wmi/devices/msi-wmi-platform.rst b/Documentatio=
n/wmi/devices/msi-wmi-platform.rst
new file mode 100644
index 000000000000..29b1b2e6d42c
=2D-- /dev/null
+++ b/Documentation/wmi/devices/msi-wmi-platform.rst
@@ -0,0 +1,194 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+MSI WMI Platform Features driver (msi-wmi-platform)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Many MSI notebooks support various features like reading fan sensors. Thi=
s features are controlled
+by the embedded controller, with the ACPI firmware exposing a standard AC=
PI WMI interface on top
+of the embedded controller interface.
+
+WMI interface description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+The WMI interface description can be decoded from the embedded binary MOF=
 (bmof)
+data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
+
+::
+
+  [WMI, Locale("MS\0x409"),
+   Description("This class contains the definition of the package used in=
 other classes"),
+   guid("{ABBC0F60-8EA1-11d1-00A0-C90629100000}")]
+  class Package {
+    [WmiDataId(1), read, write, Description("16 bytes of data")] uint8 By=
tes[16];
+  };
+
+  [WMI, Locale("MS\0x409"),
+   Description("This class contains the definition of the package used in=
 other classes"),
+   guid("{ABBC0F63-8EA1-11d1-00A0-C90629100000}")]
+  class Package_32 {
+    [WmiDataId(1), read, write, Description("32 bytes of data")] uint8 By=
tes[32];
+  };
+
+  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\0x409"),
+   Description("Class used to operate methods on a package"),
+   guid("{ABBC0F6E-8EA1-11d1-00A0-C90629100000}")]
+  class MSI_ACPI {
+    [key, read] string InstanceName;
+    [read] boolean Active;
+
+    [WmiMethodId(1), Implemented, read, write, Description("Return the co=
ntents of a package")]
+    void GetPackage([out, id(0)] Package Data);
+
+    [WmiMethodId(2), Implemented, read, write, Description("Set the conte=
nts of a package")]
+    void SetPackage([in, id(0)] Package Data);
+
+    [WmiMethodId(3), Implemented, read, write, Description("Return the co=
ntents of a package")]
+    void Get_EC([out, id(0)] Package_32 Data);
+
+    [WmiMethodId(4), Implemented, read, write, Description("Set the conte=
nts of a package")]
+    void Set_EC([in, id(0)] Package_32 Data);
+
+    [WmiMethodId(5), Implemented, read, write, Description("Return the co=
ntents of a package")]
+    void Get_BIOS([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(6), Implemented, read, write, Description("Set the conte=
nts of a package")]
+    void Set_BIOS([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(7), Implemented, read, write, Description("Return the co=
ntents of a package")]
+    void Get_SMBUS([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(8), Implemented, read, write, Description("Set the conte=
nts of a package")]
+    void Set_SMBUS([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(9), Implemented, read, write, Description("Return the co=
ntents of a package")]
+    void Get_MasterBattery([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(10), Implemented, read, write, Description("Set the cont=
ents of a package")]
+    void Set_MasterBattery([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(11), Implemented, read, write, Description("Return the c=
ontents of a package")]
+    void Get_SlaveBattery([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(12), Implemented, read, write, Description("Set the cont=
ents of a package")]
+    void Set_SlaveBattery([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(13), Implemented, read, write, Description("Return the c=
ontents of a package")]
+    void Get_Temperature([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(14), Implemented, read, write, Description("Set the cont=
ents of a package")]
+    void Set_Temperature([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(15), Implemented, read, write, Description("Return the c=
ontents of a package")]
+    void Get_Thermal([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(16), Implemented, read, write, Description("Set the cont=
ents of a package")]
+    void Set_Thermal([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(17), Implemented, read, write, Description("Return the c=
ontents of a package")]
+    void Get_Fan([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(18), Implemented, read, write, Description("Set the cont=
ents of a package")]
+    void Set_Fan([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(19), Implemented, read, write, Description("Return the c=
ontents of a package")]
+    void Get_Device([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(20), Implemented, read, write, Description("Set the cont=
ents of a package")]
+    void Set_Device([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(21), Implemented, read, write, Description("Return the c=
ontents of a package")]
+    void Get_Power([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(22), Implemented, read, write, Description("Set the cont=
ents of a package")]
+    void Set_Power([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(23), Implemented, read, write, Description("Return the c=
ontents of a package")]
+    void Get_Debug([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(24), Implemented, read, write, Description("Set the cont=
ents of a package")]
+    void Set_Debug([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(25), Implemented, read, write, Description("Return the c=
ontents of a package")]
+    void Get_AP([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(26), Implemented, read, write, Description("Set the cont=
ents of a package")]
+    void Set_AP([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(27), Implemented, read, write, Description("Return the c=
ontents of a package")]
+    void Get_Data([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(28), Implemented, read, write, Description("Set the cont=
ents of a package")]
+    void Set_Data([in, out, id(0)] Package_32 Data);
+
+    [WmiMethodId(29), Implemented, read, write, Description("Return the c=
ontents of a package")]
+    void Get_WMI([out, id(0)] Package_32 Data);
+  };
+
+Due to a peculiarity in how Windows handles the ``CreateByteField()`` ACP=
I operator (errors only
+happen when a invalid byte field is ultimately accessed), all methods req=
uire a 32 byte input
+buffer, even if the Binay MOF says otherwise.
+
+The input buffer contains a single byte to select the subfeature to be ac=
cessed and 31 bytes of
+input data, the meaning of which depends on the subfeature being accessed=
.
+
+The output buffer contains a singe byte which signals success or failure =
(``0x00`` on failure)
+and 31 bytes of output data, the meaning if which depends on the subfeatu=
re being accessed.
+
+WMI method Get_EC()
+-------------------
+
+Returns embedded controller information, the selected subfeature does not=
 matter. The output
+data contains a flag byte and a 28 byte controller firmware version strin=
g.
+
+The first 4 bits of the flag byte contain the minor version of the embedd=
ed controller interface,
+with the next 2 bits containing the major version of the embedded control=
ler interface.
+
+The 7th bit signals if the embedded controller page chaged (exact meaning=
 is unknown), and the
+last bit signals if the platform is a Tigerlake platform.
+
+The MSI software seems to only use this interface when the last bit is se=
t.
+
+WMI method Get_Fan()
+--------------------
+
+Fan speed sensors can be accessed by selecting subfeature ``0x00``. The o=
utput data contains
+up to four 16-bit fan speed readings in big-endian format. Most machines =
do not support all
+four fan speed sensors, so the remaining reading are hardcoded to ``0x000=
0``.
+
+The fan RPM readings can be calculated with the following formula:
+
+        RPM =3D 480000 / <fan speed reading>
+
+If the fan speed reading is zero, then the fan RPM is zero too.
+
+WMI method Get_WMI()
+--------------------
+
+Returns the version of the ACPI WMI interface, the selected subfeature do=
es not matter.
+The output data contains two bytes, the first one contains the major vers=
ion and the last one
+contains the minor revision of the ACPI WMI interface.
+
+The MSI software seems to only use this interface when the major version =
is greater than two.
+
+Reverse-Engineering the MSI WMI Platform interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+.. warning:: Randomly poking the embedded controller interface can potent=
ially cause damage
+             to the machine and other unwanted side effects, please be ca=
reful.
+
+The underlying embedded controller interface is used by the ``msi-ec`` dr=
iver, and it seems
+that many methods just copy a part of the embedded controller memory into=
 the output buffer.
+
+This means that the remaining WMI methods can be reverse-engineered by lo=
oking which part of
+the embedded controller memory is accessed by the ACPI AML code. The driv=
er also supports a
+debugfs interface for directly executing WMI methods. Additionally, any s=
afety checks regarding
+unsupported hardware can be disabled by loading the module with ``force=
=3Dtrue``.
+
+More information about the MSI embedded controller interface can be found=
 at the
+`msi-ec project <https://github.com/BeardOverflow/msi-ec>`_.
+
+Special thanks go to github user `glpnk` for showing how to decode the fa=
n speed readings.
diff --git a/MAINTAINERS b/MAINTAINERS
index 3fb0fa67576d..846187625552 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15041,6 +15041,14 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Orphan
 F:	drivers/platform/x86/msi-wmi.c

+MSI WMI PLATFORM FEATURES
+M:	Armin Wolf <W_Armin@gmx.de>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/debugfs-msi-wmi-platform
+F:	Documentation/wmi/devices/msi-wmi-platform.rst
+F:	drivers/platform/x86/msi-wmi-platform.c
+
 MSI001 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 168b57df0a6a..b744f18bbfa7 100644
=2D-- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -698,6 +698,17 @@ config MSI_WMI
 	 To compile this driver as a module, choose M here: the module will
 	 be called msi-wmi.

+config MSI_WMI_PLATFORM
+	tristate "MSI WMI Platform features"
+	depends on ACPI_WMI
+	depends on HWMON
+	help
+	  Say Y here if you want to have support for WMI-based platform features
+	  like fan sensor access on MSI machines.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called msi-wmi-platform.
+
 config XO15_EBOOK
 	tristate "OLPC XO-1.5 ebook switch"
 	depends on OLPC || COMPILE_TEST
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 8076bf3a7e83..26b8af55738b 100644
=2D-- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_ACPI_QUICKSTART)  +=3D quickstart.o
 obj-$(CONFIG_MSI_EC)		+=3D msi-ec.o
 obj-$(CONFIG_MSI_LAPTOP)	+=3D msi-laptop.o
 obj-$(CONFIG_MSI_WMI)		+=3D msi-wmi.o
+obj-$(CONFIG_MSI_WMI_PLATFORM)	+=3D msi-wmi-platform.o

 # OLPC
 obj-$(CONFIG_XO15_EBOOK)	+=3D xo15-ebook.o
diff --git a/drivers/platform/x86/msi-wmi-platform.c b/drivers/platform/x8=
6/msi-wmi-platform.c
new file mode 100644
index 000000000000..436fb91a47db
=2D-- /dev/null
+++ b/drivers/platform/x86/msi-wmi-platform.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Linux driver for WMI platform features on MSI notebooks.
+ *
+ * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
+ */
+
+#define pr_format(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/device/driver.h>
+#include <linux/errno.h>
+#include <linux/hwmon.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/rwsem.h>
+#include <linux/types.h>
+#include <linux/wmi.h>
+
+#include <asm/unaligned.h>
+
+#define DRIVER_NAME	"msi-wmi-platform"
+
+#define MSI_PLATFORM_GUID	"ABBC0F6E-8EA1-11d1-00A0-C90629100000"
+
+#define MSI_WMI_PLATFORM_INTERFACE_VERSION	2
+
+#define MSI_PLATFORM_WMI_MAJOR_OFFSET	1
+#define MSI_PLATFORM_WMI_MINOR_OFFSET	2
+
+#define MSI_PLATFORM_EC_FLAGS_OFFSET	1
+#define MSI_PLATFORM_EC_MINOR_MASK	GENMASK(3, 0)
+#define MSI_PLATFORM_EC_MAJOR_MASK	GENMASK(5, 4)
+#define MSI_PLATFORM_EC_CHANGED_PAGE	BIT(6)
+#define MSI_PLATFORM_EC_IS_TIGERLAKE	BIT(7)
+#define MSI_PLATFORM_EC_VERSION_OFFSET	2
+
+static bool force;
+module_param_unsafe(force, bool, 0);
+MODULE_PARM_DESC(force, "Force loading without checking for supported WMI=
 interface versions");
+
+enum msi_wmi_platform_method {
+	MSI_PLATFORM_GET_PACKAGE	=3D 0x01,
+	MSI_PLATFORM_SET_PACKAGE	=3D 0x02,
+	MSI_PLATFORM_GET_EC		=3D 0x03,
+	MSI_PLATFORM_SET_EC		=3D 0x04,
+	MSI_PLATFORM_GET_BIOS		=3D 0x05,
+	MSI_PLATFORM_SET_BIOS		=3D 0x06,
+	MSI_PLATFORM_GET_SMBUS		=3D 0x07,
+	MSI_PLATFORM_SET_SMBUS		=3D 0x08,
+	MSI_PLATFORM_GET_MASTER_BATTERY =3D 0x09,
+	MSI_PLATFORM_SET_MASTER_BATTERY =3D 0x0a,
+	MSI_PLATFORM_GET_SLAVE_BATTERY	=3D 0x0b,
+	MSI_PLATFORM_SET_SLAVE_BATTERY	=3D 0x0c,
+	MSI_PLATFORM_GET_TEMPERATURE	=3D 0x0d,
+	MSI_PLATFORM_SET_TEMPERATURE	=3D 0x0e,
+	MSI_PLATFORM_GET_THERMAL	=3D 0x0f,
+	MSI_PLATFORM_SET_THERMAL	=3D 0x10,
+	MSI_PLATFORM_GET_FAN		=3D 0x11,
+	MSI_PLATFORM_SET_FAN		=3D 0x12,
+	MSI_PLATFORM_GET_DEVICE		=3D 0x13,
+	MSI_PLATFORM_SET_DEVICE		=3D 0x14,
+	MSI_PLATFORM_GET_POWER		=3D 0x15,
+	MSI_PLATFORM_SET_POWER		=3D 0x16,
+	MSI_PLATFORM_GET_DEBUG		=3D 0x17,
+	MSI_PLATFORM_SET_DEBUG		=3D 0x18,
+	MSI_PLATFORM_GET_AP		=3D 0x19,
+	MSI_PLATFORM_SET_AP		=3D 0x1a,
+	MSI_PLATFORM_GET_DATA		=3D 0x1b,
+	MSI_PLATFORM_SET_DATA		=3D 0x1c,
+	MSI_PLATFORM_GET_WMI		=3D 0x1d,
+};
+
+struct msi_wmi_platform_debugfs_data {
+	struct wmi_device *wdev;
+	enum msi_wmi_platform_method method;
+	struct rw_semaphore buffer_lock;	/* Protects debugfs buffer */
+	size_t length;
+	u8 buffer[32];
+};
+
+static const char * const msi_wmi_platform_debugfs_names[] =3D {
+	"get_package",
+	"set_package",
+	"get_ec",
+	"set_ec",
+	"get_bios",
+	"set_bios",
+	"get_smbus",
+	"set_smbus",
+	"get_master_battery",
+	"set_master_battery",
+	"get_slave_battery",
+	"set_slave_battery",
+	"get_temperature",
+	"set_temperature",
+	"get_thermal",
+	"set_thermal",
+	"get_fan",
+	"set_fan",
+	"get_device",
+	"set_device",
+	"get_power",
+	"set_power",
+	"get_debug",
+	"set_debug",
+	"get_ap",
+	"set_ap",
+	"get_data",
+	"set_data",
+	"get_wmi"
+};
+
+static int msi_wmi_platform_parse_buffer(union acpi_object *obj, u8 *outp=
ut, size_t length)
+{
+	if (obj->type !=3D ACPI_TYPE_BUFFER)
+		return -ENOMSG;
+
+	if (obj->buffer.length !=3D length)
+		return -EPROTO;
+
+	if (!obj->buffer.pointer[0])
+		return -EIO;
+
+	memcpy(output, obj->buffer.pointer, obj->buffer.length);
+
+	return 0;
+}
+
+static int msi_wmi_platform_query(struct wmi_device *wdev, enum msi_wmi_p=
latform_method method,
+				  u8 *input, size_t input_length, u8 *output, size_t output_length)
+{
+	struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer in =3D {
+		.length =3D input_length,
+		.pointer =3D input
+	};
+	union acpi_object *obj;
+	acpi_status status;
+	int ret;
+
+	if (!input_length || !output_length)
+		return -EINVAL;
+
+	status =3D wmidev_evaluate_method(wdev, 0x0, method, &in, &out);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	obj =3D out.pointer;
+	if (!obj)
+		return -ENODATA;
+
+	ret =3D msi_wmi_platform_parse_buffer(obj, output, output_length);
+	kfree(obj);
+
+	return ret;
+}
+
+static umode_t msi_wmi_platform_is_visible(const void *drvdata, enum hwmo=
n_sensor_types type,
+					   u32 attr, int channel)
+{
+	return 0444;
+}
+
+static int msi_wmi_platform_read(struct device *dev, enum hwmon_sensor_ty=
pes type, u32 attr,
+				 int channel, long *val)
+{
+	struct wmi_device *wdev =3D dev_get_drvdata(dev);
+	u8 input[32] =3D { 0 };
+	u8 output[32];
+	u16 data;
+	int ret;
+
+	ret =3D msi_wmi_platform_query(wdev, MSI_PLATFORM_GET_FAN, input, sizeof=
(input), output,
+				     sizeof(output));
+	if (ret < 0)
+		return ret;
+
+	data =3D get_unaligned_be16(&output[channel * 2 + 1]);
+	if (!data)
+		*val =3D 0;
+	else
+		*val =3D 480000 / data;
+
+	return 0;
+}
+
+static const struct hwmon_ops msi_wmi_platform_ops =3D {
+	.is_visible =3D msi_wmi_platform_is_visible,
+	.read =3D msi_wmi_platform_read,
+};
+
+static const struct hwmon_channel_info * const msi_wmi_platform_info[] =
=3D {
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT
+			   ),
+	NULL
+};
+
+static const struct hwmon_chip_info msi_wmi_platform_chip_info =3D {
+	.ops =3D &msi_wmi_platform_ops,
+	.info =3D msi_wmi_platform_info,
+};
+
+static ssize_t msi_wmi_platform_write(struct file *fp, const char __user =
*input, size_t length,
+				      loff_t *offset)
+{
+	struct seq_file *seq =3D fp->private_data;
+	struct msi_wmi_platform_debugfs_data *data =3D seq->private;
+	u8 payload[32] =3D { };
+	ssize_t ret;
+
+	/* Do not allow partial writes */
+	if (*offset !=3D 0)
+		return -EINVAL;
+
+	/* Do not allow incomplete command buffers */
+	if (length !=3D data->length)
+		return -EINVAL;
+
+	ret =3D simple_write_to_buffer(payload, sizeof(payload), offset, input, =
length);
+	if (ret < 0)
+		return ret;
+
+	down_write(&data->buffer_lock);
+	ret =3D msi_wmi_platform_query(data->wdev, data->method, payload, data->=
length, data->buffer,
+				     data->length);
+	up_write(&data->buffer_lock);
+
+	if (ret < 0)
+		return ret;
+
+	return length;
+}
+
+static int msi_wmi_platform_show(struct seq_file *seq, void *p)
+{
+	struct msi_wmi_platform_debugfs_data *data =3D seq->private;
+	int ret;
+
+	down_read(&data->buffer_lock);
+	ret =3D seq_write(seq, data->buffer, data->length);
+	up_read(&data->buffer_lock);
+
+	return ret;
+}
+
+static int msi_wmi_platform_open(struct inode *inode, struct file *fp)
+{
+	struct msi_wmi_platform_debugfs_data *data =3D inode->i_private;
+
+	/* The seq_file uses the last byte of the buffer for detecting buffer ov=
erflows */
+	return single_open_size(fp, msi_wmi_platform_show, data, data->length + =
1);
+}
+
+static const struct file_operations msi_wmi_platform_debugfs_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D msi_wmi_platform_open,
+	.read =3D seq_read,
+	.write =3D msi_wmi_platform_write,
+	.llseek =3D seq_lseek,
+	.release =3D single_release,
+};
+
+static void msi_wmi_platform_debugfs_remove(void *data)
+{
+	struct dentry *dir =3D data;
+
+	debugfs_remove_recursive(dir);
+}
+
+static void msi_wmi_platform_debugfs_add(struct wmi_device *wdev, struct =
dentry *dir,
+					 const char *name, enum msi_wmi_platform_method method)
+{
+	struct msi_wmi_platform_debugfs_data *data;
+	struct dentry *entry;
+
+	data =3D devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	data->wdev =3D wdev;
+	data->method =3D method;
+	init_rwsem(&data->buffer_lock);
+
+	/* The ACPI firmware for now always requires a 32 byte input buffer due =
to
+	 * a peculiarity in how Windows handles the CreateByteField() ACPI opera=
tor.
+	 */
+	data->length =3D 32;
+
+	entry =3D debugfs_create_file(name, 0600, dir, data, &msi_wmi_platform_d=
ebugfs_fops);
+	if (IS_ERR(entry))
+		devm_kfree(&wdev->dev, data);
+}
+
+static void msi_wmi_platform_debugfs_init(struct wmi_device *wdev)
+{
+	struct dentry *dir;
+	char dir_name[64];
+	int ret, method;
+
+	scnprintf(dir_name, ARRAY_SIZE(dir_name), "%s-%s", DRIVER_NAME, dev_name=
(&wdev->dev));
+
+	dir =3D debugfs_create_dir(dir_name, NULL);
+	if (IS_ERR(dir))
+		return;
+
+	ret =3D devm_add_action_or_reset(&wdev->dev, msi_wmi_platform_debugfs_re=
move, dir);
+	if (ret < 0)
+		return;
+
+	for (method =3D MSI_PLATFORM_GET_PACKAGE; method <=3D MSI_PLATFORM_GET_W=
MI; method++)
+		msi_wmi_platform_debugfs_add(wdev, dir, msi_wmi_platform_debugfs_names[=
method - 1],
+					     method);
+}
+
+static int msi_wmi_platform_hwmon_init(struct wmi_device *wdev)
+{
+	struct device *hdev;
+
+	hdev =3D devm_hwmon_device_register_with_info(&wdev->dev, "msi_wmi_platf=
orm", wdev,
+						    &msi_wmi_platform_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(hdev);
+}
+
+static int msi_wmi_platform_ec_init(struct wmi_device *wdev)
+{
+	u8 input[32] =3D { 0 };
+	u8 output[32];
+	u8 flags;
+	int ret;
+
+	ret =3D msi_wmi_platform_query(wdev, MSI_PLATFORM_GET_EC, input, sizeof(=
input), output,
+				     sizeof(output));
+	if (ret < 0)
+		return ret;
+
+	flags =3D output[MSI_PLATFORM_EC_FLAGS_OFFSET];
+
+	dev_dbg(&wdev->dev, "EC RAM version %lu.%lu\n",
+		FIELD_GET(MSI_PLATFORM_EC_MAJOR_MASK, flags),
+		FIELD_GET(MSI_PLATFORM_EC_MINOR_MASK, flags));
+	dev_dbg(&wdev->dev, "EC firmware version %.28s\n",
+		&output[MSI_PLATFORM_EC_VERSION_OFFSET]);
+
+	if (!(flags & MSI_PLATFORM_EC_IS_TIGERLAKE)) {
+		if (!force)
+			return -ENODEV;
+
+		dev_warn(&wdev->dev, "Loading on a non-Tigerlake platform\n");
+	}
+
+	return 0;
+}
+
+static int msi_wmi_platform_init(struct wmi_device *wdev)
+{
+	u8 input[32] =3D { 0 };
+	u8 output[32];
+	int ret;
+
+	ret =3D msi_wmi_platform_query(wdev, MSI_PLATFORM_GET_WMI, input, sizeof=
(input), output,
+				     sizeof(output));
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(&wdev->dev, "WMI interface version %u.%u\n",
+		output[MSI_PLATFORM_WMI_MAJOR_OFFSET],
+		output[MSI_PLATFORM_WMI_MINOR_OFFSET]);
+
+	if (output[MSI_PLATFORM_WMI_MAJOR_OFFSET] !=3D MSI_WMI_PLATFORM_INTERFAC=
E_VERSION) {
+		if (!force)
+			return -ENODEV;
+
+		dev_warn(&wdev->dev, "Loading despite unsupported WMI interface version=
 (%u.%u)\n",
+			 output[MSI_PLATFORM_WMI_MAJOR_OFFSET],
+			 output[MSI_PLATFORM_WMI_MINOR_OFFSET]);
+	}
+
+	return 0;
+}
+
+static int msi_wmi_platform_probe(struct wmi_device *wdev, const void *co=
ntext)
+{
+	int ret;
+
+	ret =3D msi_wmi_platform_init(wdev);
+	if (ret < 0)
+		return ret;
+
+	ret =3D msi_wmi_platform_ec_init(wdev);
+	if (ret < 0)
+		return ret;
+
+	msi_wmi_platform_debugfs_init(wdev);
+
+	return msi_wmi_platform_hwmon_init(wdev);
+}
+
+static const struct wmi_device_id msi_wmi_platform_id_table[] =3D {
+	{ MSI_PLATFORM_GUID, NULL },
+	{ }
+};
+MODULE_DEVICE_TABLE(wmi, msi_wmi_platform_id_table);
+
+static struct wmi_driver msi_wmi_platform_driver =3D {
+	.driver =3D {
+		.name =3D DRIVER_NAME,
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.id_table =3D msi_wmi_platform_id_table,
+	.probe =3D msi_wmi_platform_probe,
+	.no_singleton =3D true,
+};
+module_wmi_driver(msi_wmi_platform_driver);
+
+MODULE_AUTHOR("Armin Wolf <W_Armin@gmx.de>");
+MODULE_DESCRIPTION("MSI WMI platform features");
+MODULE_LICENSE("GPL");
=2D-
2.39.2


