Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41FC7F559F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjKWAuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjKWAtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:49:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D1171F;
        Wed, 22 Nov 2023 16:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700700531; x=1701305331; i=w_armin@gmx.de;
        bh=IpekB6HD5lK7F+Kd+JJ/yZUrtd4vGeb83HYctPW2R2A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=NdJ4HKu/4pf25CY2MZm6gSq/iAN3XQT6Z8G+8KOQAdRChXMM9vMexkHsZ16giomR
         u9TQxLoqSYXjUKbZdM/LJUig0e34CQP6G6D9HVbHsZY7tc2fUHxqChbqCwOV6oZK/
         3CVVYsMH3beNP8RlV0CbhTRVhmjoqUysmb1W+z4jQlH+gb2avSDziI9niVPQ8vAhR
         C5zjkfOcCNMRnUYlUayNW3p0a68DWdeYJxIdFuMS70VgTCfwXVBWfqnVCUm6ISbIs
         IBV/px230m+lF/5TPTe1KCjPhb68txNd7TysHG75PJClK8zlH2vocu9IzTM+5DFui
         pHiVE8NgYwEBY9h/CA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MwQXN-1rMfpu0oSr-00sLCa; Thu, 23 Nov 2023 01:48:51 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] hwmon: (dell-smm) Document the WMI SMM interface
Date:   Thu, 23 Nov 2023 01:48:19 +0100
Message-Id: <20231123004820.50635-9-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123004820.50635-1-W_Armin@gmx.de>
References: <20231123004820.50635-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jfeSQcpPOAV12U7567kj2GLK7TAcbn+LqR+47Zhm2vMDhL47PDT
 kH/3wLvLTHRuKXeW9AnRV7+T889shCc9R1mOwcP17d3PEstgxlLEtFv2A4dmAW/fTg8V48n
 a6laLjfk28PRBUdKv2ZmohZyVhUS0yZNTDkZScvM4XbGROwrY64KVhX7niMk2rznXyEy6Kl
 Iv4sFQ3caidVxOZgrE6SQ==
UI-OutboundReport: notjunk:1;M01:P0:8JXhW/qO+Zs=;h+T4cUIgBQMOQdKZEU/teBj3t4n
 i7AQl3qZyclJo4S+GOIwYibtiZdooOORDmwWgbUXX9Mx27iuc50to6wffpCJSZviCvMjE0BPt
 YR4NkCbI6szgJgc5p89HcRVyM+eShAdI9J/cQcm6e8AToRkvdzxqvcJsBErpqbJfaSX8/kbGE
 StFPuQXDIf5yaclpnbrFGK8lNrPX6iTKgpaNRSLLJfIniI+Z/7XLT4lh6UDi7My+xSQFE2hXs
 T+BT4REcOn5vuyhe2tk78hEtGKIdaWsh8pjrXjFfm/dTJSz+8pEwRunbFqTllfl7t8vPXjBkc
 zUOFS0jM7dSVI5C/sg9+RI6udbe3vDt+kv5w6Lk1EKXybghY2TBReHqxtRhWgeVOkh8uQfeCk
 skigdNF26DvAHS5UDj/pxcQJmF/dRXQYeWJjtA0kCarYsmqnl2pm8gLEjjj7wrYQkU0vt0/MU
 nL1wkqXO72ZDtz8v9Pcdr6Su0WSDCGADOWUYULuOZFaNeCfRCiuCl1fk0RozeKCdTd0E3DTCE
 RdA89SnXNAVaN0PVMiXzRIXqaMZUBau/ONxEEQ3cBoHDjqQL/N0ypYcuq140DNh2EXcCvpITB
 kGMDOJkF6PWvE9EqyIMhXRs+DTNmMJF7IcR/a/Xp6czr0XMvpGTTKVs/aVL692C7mS0fu1TeC
 d57+HARJOEvXr4p7fVUtGtQIH8GoXnvHj1aLsyrtWIT82kJxqi2NvPdEuP729QRXn1g+aUxF4
 m4qT8H7mPgmLYsgiwAGurL2LAD/KiUtdba1K9wHZ4p/qu33wiReUBEjz69Jsv+DhLHqEpRifu
 f3AohTK+0RN7lIfjIFNY6jvN8zrLc6dXDtepZqQ5Rf0/sSfiAZSOWL6KvBEW8d3TWpyrDKOJc
 usV0DFgtzutjNz7FZsSwqA5IgnJV+ke370JTrGls6z/UhOV4ZjOvZgsGcCmb9R6uVK1Ye9Nvo
 3im6R+Q1GYDYuQC6dLw9f9jOO7U=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the WMI SMM interface so that future developers
can better understand how it works.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/dell-smm-hwmon.rst | 38 ++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index d8f1d6859b96..977263cb57a8 100644
=2D-- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -186,8 +186,7 @@ SMM Interface
 The driver uses the SMM interface to send commands to the system BIOS.
 This interface is normally used by Dell's 32-bit diagnostic program or
 on newer notebook models by the buildin BIOS diagnostics.
-The SMM is triggered by writing to the special ioports ``0xb2`` and ``0x8=
4``,
-and may cause short hangs when the BIOS code is taking too long to
+The SMM may cause short hangs when the BIOS code is taking too long to
 execute.

 The SMM handler inside the system BIOS looks at the contents of the
@@ -210,7 +209,40 @@ The SMM handler can signal a failure by either:

 - setting the lower sixteen bits of ``eax`` to ``0xffff``
 - not modifying ``eax`` at all
=2D- setting the carry flag
+- setting the carry flag (legacy SMM interface only)
+
+Legacy SMM Interface
+--------------------
+
+When using the legacy SMM interface, a SMM is triggered by writing the le=
ast significant byte
+of the command code to the special ioports ``0xb2`` and ``0x84``. This in=
terface is not
+described inside the ACPI tables and can thus only be detected by issuing=
 a test SMM call.
+
+WMI SMM Interface
+-----------------
+
+On modern Dell machines, the SMM calls are done over ACPI WMI:
+
+::
+
+ #pragma namespace("\\\\.\\root\\dcim\\sysman\\diagnostics")
+ [WMI, Provider("Provider_DiagnosticsServices"), Dynamic, Locale("MS\\0x4=
09"),
+  Description("RunDellDiag"), guid("{F1DDEE52-063C-4784-A11E-8A06684B9B01=
}")]
+ class LegacyDiags {
+  [key, read] string InstanceName;
+  [read] boolean Active;
+
+  [WmiMethodId(1), Implemented, read, write, Description("Legacy Method "=
)]
+  void Execute([in, out] uint32 EaxLen, [in, out, WmiSizeIs("EaxLen") : T=
oInstance] uint8 EaxVal[],
+               [in, out] uint32 EbxLen, [in, out, WmiSizeIs("EbxLen") : T=
oInstance] uint8 EbxVal[],
+               [in, out] uint32 EcxLen, [in, out, WmiSizeIs("EcxLen") : T=
oInstance] uint8 EcxVal[],
+               [in, out] uint32 EdxLen, [in, out, WmiSizeIs("EdxLen") : T=
oInstance] uint8 EdxVal[]);
+ };
+
+Some machines support only the WMI SMM interface, while some machines sup=
port both interfaces.
+The driver automatically detects which interfaces are present and will us=
e the WMI SMM interface
+if the legacy SMM interface is not present. The WMI SMM interface is usua=
lly slower than the
+legacy SMM interface since ACPI methods need to be called in order to tri=
gger a SMM.

 SMM command codes
 -----------------
=2D-
2.39.2

