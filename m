Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18AF7E089E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjKCS60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345884AbjKCS6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:58:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC2AD6C;
        Fri,  3 Nov 2023 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699037858; x=1699642658; i=w_armin@gmx.de;
        bh=TJgFoJSEZ7oco6vbH2uSKw0a8ZVpn5/M8nMVqzHvOZo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=BYSCoL+pIdDXwXl/6kR4OTi+DESwfNZOxbep/QZIKAFJKcUApLJltQGJZ2d4nYQe
         YEeVFpxauq/8XMMKZuKWWOAgC0TA+b5kgqFXZnYiPNawzau8js40HcnoexWWxY+De
         MO9OeKwO5k+K2G+FvEtzfZ9iBbEkMSiiaTEiXCRSX0N6Q0qt3iNddNkEsG0k7uFsM
         kLEX5z8M6DpVnDmUl26dLLOCqGnUZvAX/rhWzagTGIzzlVymQ9c6y8C9CyOntm0xU
         pxH2vCamA9Mz10IAqX2jGz+Q8Q6ExY7ZkRe5wMlG9qKUfCX6zZ/3+NUFquXvbvctL
         Ckq19/JQeUbMC7oALw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MeCpR-1rXVAL0yIx-00bLtj; Fri, 03 Nov 2023 19:57:38 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] hwmon: (dell-smm) Document the WMI SMM interface
Date:   Fri,  3 Nov 2023 19:57:15 +0100
Message-Id: <20231103185716.11007-9-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103185716.11007-1-W_Armin@gmx.de>
References: <20231103185716.11007-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TrSHmD4i5OZnstY4A3RxAkbMGUr3UEZcJLJCOCdsFx5ENHUxOT2
 jaYRNr0AaCuMvMeF5CTDfjR6P9wLtgtm8cPW8f769MmiY7vGZ838/POYuf0sa1tXFTTe28c
 lbgTHWPRvpUMpMYLNOuha8lxRGJACvFeEhFjpqf1f2GvquK41MLU6PKsaaRfDdmaO5dMaqr
 34eY9Z+Lin9EH6pNPhBHA==
UI-OutboundReport: notjunk:1;M01:P0:Rlimnw2H6FE=;af55sEDBauzCOwcmmik/s0KEY+n
 dpm/c5tj+HsULnAQAR89zPZ5YCPO8i8+iHVHtf/P7fLFa/IznTitSGa31xr7uhSPbkkquJTF9
 AvPQk0GBP/bSKj5gkUv5XYanRYz+shOYwBk1CNz29Rfzy2uEKKuC2TUJTBa86BYiBPnU1Me3h
 teX5C00T7VpxkFEYjKJuRf7SUedNSbjSvTvPQsoRSE+MZR/+9RMq6lMANVSRgEdViV9qHIMB0
 KopR1oDEqiI/XY6r9SXzYxIMHzgCU4Z8txvTZ3ugX1MqfrYL+NAbcKyrrbEJLgAIU5VXCubKn
 Cm0Gd2hEplcQrMrBhfkQCjk/8NhVVhp7BDM6P/HfZ6B4frbHdfjGPhHHfrB6efDlQwRNgEoUI
 w+cz4mYwq9Y3y2ggKLZL0aLarr62ePUvQBOw3dA8mFNqwkPmACGluFigVW1xcY8ejE8Ln/B5s
 crujHHAl3k/uH8BWyMZwgv/HLZSlir3gRkI+I4m3uCwb+gFP4xfmtuYGWMxJfHHOBkixnljJY
 DdfoeYNNtuwb4WeuUODCaWgKSF5EjedEAna7uM+QmiUF7S7hpPkqwrjebcLJIa1CzmY0nVK2L
 YYGU4z9/jXXY9PPHIdJgWCgthRIJ1IB8gjbOgz6Kt0+enPcViSSjlmVBNi5ztqcCdfo2c9n4N
 KzQMWXg10KkcJSXZ1RE807LlYOzvVtO//VFnEK2Am1apimECgioAigk4AsZtqImW8TaDoodbv
 xeAWHVqYNxVb/kGxtSkjVwhS9DqKKKVNljq96ehuH0UUFtyJhAJYXM/tgxRD1/TmsW1+5O8hi
 IsnYX4jNS1fK++m4PGAhgGjsVneV+4mdV2k/S+1wbBadDQZQYffS7TJS+5Kc8ZZWNZ1M0I1q+
 nRApftoAAUoyr/xxhDQ+GsyBP0Doim4Nj7vMifLVX6uNfCyLGrlEFPOoXHqBm7FsGSoudXFwD
 37Fmb/eqPPWOAPxlE/8q/L7yUc4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the WMI SMM interface so that future developers
can better understand how it works.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/dell-smm-hwmon.rst | 33 +++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index d8f1d6859b96..fea8cf76088e 100644
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
@@ -210,7 +209,35 @@ The SMM handler can signal a failure by either:

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
09"), Description("RunDellDiag"), guid("{F1DDEE52-063C-4784-A11E-8A06684B9=
B01}")]
+ class LegacyDiags {
+  [key, read] string InstanceName;
+  [read] boolean Active;
+
+  [WmiMethodId(1), Implemented, read, write, Description("Legacy Method "=
)] void Execute([in, out] uint32 EaxLen, [in, out, WmiSizeIs("EaxLen") : T=
oInstance] uint8 EaxVal[], [in, out] uint32 EbxLen, [in, out, WmiSizeIs("E=
bxLen") : ToInstance] uint8 EbxVal[], [in, out] uint32 EcxLen, [in, out, W=
miSizeIs("EcxLen") : ToInstance] uint8 EcxVal[], [in, out] uint32 EdxLen, =
[in, out, WmiSizeIs("EdxLen") : ToInstance] uint8 EdxVal[]);
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

