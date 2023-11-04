Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9AD7E1030
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 17:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjKDP47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 11:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjKDP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 11:56:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A5D45;
        Sat,  4 Nov 2023 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699113380; x=1699718180; i=w_armin@gmx.de;
        bh=q6cARFSLIG3o2btPPaMZi74WireLHu6yHBRBI8lSF8g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=T4AMUjbpECECbLgusPKR+/3VijUyy/WvxJaLNjQgipPH2+8zj4BRMia1FBb4dLAA
         XizBqVaOZpMr2eM+X/IxdETJAFHX52jKY/klMT7dH7aE/vlxBWKYUglUPU//o27b4
         9ONXITnL68B5te146m+UbSxHHZkwLJpDeu5AgASU7gE1EXRDZgJkItGtwL7P7Dx+p
         FuKffuwaNXHpG8rS+MOOsE0dbeafoG8mrLdFOT40vw7liUwysjeOt2CJcYcQ8vTPc
         5CgPWm26fN62b2K86t7gDekl8NCU1ujyGk2m4JC5BebT+LcuFhaQkZVJTp4x/sphO
         fJLkjBV1hXZdX2PPJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N3bSj-1rPSpL0mbj-010cIP; Sat, 04 Nov 2023 16:56:20 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] hwmon: (dell-smm) Document the WMI SMM interface
Date:   Sat,  4 Nov 2023 16:55:58 +0100
Message-Id: <20231104155559.11842-9-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231104155559.11842-1-W_Armin@gmx.de>
References: <20231104155559.11842-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kOBTuwVlIrQcUiY2l/atFBfUWYfK96gs1cBaS8Txv8qiXZh9Qcs
 vATNekt57z+yXPAp+xLIc+uJ9L5nnMstUtUycNJ3xZwHGSWImwfJ229v6yHMladI/H7U3Vi
 +ueHaAzA0Fcgd18WWwfsM1Gw4iDucb40fBdyLe/coiCx0aYcMC8FJFhyVDhMZf14n5j2Pxf
 AL0a//ViivMx/VWYADiFQ==
UI-OutboundReport: notjunk:1;M01:P0:Zfn4TXe2Lkg=;EqBE00tFK915qpptKI8QT50k7WE
 9oV4ViRnTUGwu+yz0gvbN6yrXvF57jFNu+ch7xq7bbCjFG6W+z+jRRjx0hg8RmbKFtBcJ0KYr
 w+DLwvEYq02A0YcKMNXPb1npKADXz//4xnKyErJcCkDMa+Us5NKh5SPG0KGlyQ1cdmV+JVfGl
 V6ubQT6/yYuAkeP6v3yBm1QxkgoLfMtbI3vqd+bZ5OZ1muwNfLXyguFnkL2Z22DpMnRpOwRqL
 FuZvTcPGJT0jwuHTqEbsYJJy8bG20yYBvCHmmXLpnEm3KOWKPs3gwqlBgVwoSDH4HYkTu5IMF
 3v/gBQxXKeUshOvwM5EFH/SGSJZ2dDQEhUcpOaOs1ff/GqKUQDfukAO0MfhG4Ug6D9WKHiqfr
 Cg+xkSGrq4WLssUIw24w07VgIs9vE/Cc6ARb8bf9Kwz31m5j4ySTynCV9k0KOUsNRZgqm9RHQ
 tuf+yk2WmTJ/Zku/JKMdizYbrsqwln2UK/xwdv7FzmJOGRw2HjUEUthTzO6RlXoc2afOuyXHm
 MX9FfE7i9VzLhJ08nSY6P5MaDlSGEt4Q1gabJ0owxSJ24IJA8FbDv9rNa9xGjTf5M/AQIKemE
 UQUb/+f0PZTe/ktHCR1ueDnj64hIdsvd71K5vrY2V7ETUPBk3ccJC05ha7fIN/en524AapxHt
 Y3/krSlc9NFNvEEsXnP3ZRiWyWnCZGAqlRbZVCs2t/KC8dDO6YbVYhjErOhs2HeW7fr6xH7v3
 lJwogwaByOrM50auhIeVpuP+gjkxDPIdbt8Udiij7BCVCfJHiGefKgXYgEG3/1sWvqg06IaLI
 yYkRc/v8SY+UWCUPgIDVpdF5+BISKAFCBOYAFt9GZhiJHxk4Yy6Td79nlJAH2bhE9JxZPHsCf
 W+DjUnmkvpwGD9xEB0Vv3bF8wPuEGwkQIiqetFhAfpJh9uXjWxcx0SXpDLLLZtkNOrSEXZfFU
 Vm7JLcaj1egCx2RYFfmXk0lnJno=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the WMI SMM interface so that future developers
can better understand how it works.

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

