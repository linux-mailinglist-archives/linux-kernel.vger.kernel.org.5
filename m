Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D226E7E1A72
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjKFGo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjKFGoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:44:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB6B1BF;
        Sun,  5 Nov 2023 22:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699253047; x=1699857847; i=w_armin@gmx.de;
        bh=q6cARFSLIG3o2btPPaMZi74WireLHu6yHBRBI8lSF8g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=dxI7NoCFawl6BBUcc8paNrRPIiUc2K9XIU2x+Xqu9KSaxl733/AxSH3ZUehWDalU
         xLQVmKmh6/7pd8pIasPBG7sa0eH/6AcPdGk4od9eMfdRNSP7ogBW8wUKDMrwOQKSs
         dSFwTYs0tb+kXEh7NEEp/x/OyHBEfGhXQTpdimUrU+6QmyJjfkVHW7ke9Q4NjanJ+
         btgKW48gXs4ckqu7gy6lGPgQSSg+gdQYe9LIctHgb4zMOw4dJBMT/iWn4438D4Gyd
         BbobMIrHAKhNC5+AGKa8G+uEZg/1Ixio1jiKJJTzk7vLGZ1CtrTimnzyK4BPXjdo9
         C5qU4a1ph6KkKFkTyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MwQXH-1rInha35S1-00sN0J; Mon, 06 Nov 2023 07:44:07 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] hwmon: (dell-smm) Document the WMI SMM interface
Date:   Mon,  6 Nov 2023 07:43:50 +0100
Message-Id: <20231106064351.42347-9-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106064351.42347-1-W_Armin@gmx.de>
References: <20231106064351.42347-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ls4/MndJBxFs7c9Xj5UdPtUh5VGww/q2spEJ2gy3uxqM9bCf7jv
 9GxK47y2i1X0oTThPwCNZiLnHZy0rBc+PHhcCFaXqEyvgibfDI2gijcgOnYoE9PCRcceApS
 ksky5wSx+dQssN7WMPIzIl/9bzymmYO2eVcu1xMoDtrmp5FgMl5LkGVSHbrcqznX7nIUhj2
 0ioCby7lhMmDY9hFhMNuA==
UI-OutboundReport: notjunk:1;M01:P0:PKhh50ms3JA=;keIA95Rh5w0bk3SNTk1pk0d3hbo
 c4uq6UNQ6k1T0R/Guy/9/9IxHtavtwrp06xp4yDNjhOrBnVCPPv4oz8S9MAq+8kjOlf8W1gGR
 jOnxqfJ1805IabhhlqQKooWpkxhqKx76jxp/VaX83zhoojn9ps5WhiO/uBRGVaXpapVRTEpEn
 zPelnEDrqNRb0dhi+EiOZN5HWEVT1JFL6oXzNCuZ+HUTp6ptcJwk6VotuBCPrHaWWOX6HWI4a
 nGh1kbtJOqZSBMmxsOwvjEwn+JkhQdOviWYRAB8QMwCuzBEEEU17AjW4URTeAmz9V8QLclgWl
 wA0I+dOf62dPE56W9sMoNbFUcHbB7xGmZI8lV72pDFwyleZcKPq/8J1oCVPJPmQXmcD7s733m
 BPBPFM2T2fYLR3tiPN8p5WgcAovm/K3DOK/SZuDK80mdK+9f5OLfqLaJWiFnRbp4RpS5Vif7T
 URVClsTamXQ/zymb0Zpopm2ICU+D9kgJzcA12d+dTxg1P1vZuw3kmpnDeNxWGzrLIVVUH+XFc
 jJ65dCCBLMvxrgvNgHTJ4zy3nGziInqNb4JcyXV1nYEPcaldcxz6PjgJYe52x2VIHA6FXXe7b
 3Ggo/DydndUuQQuG4NzhMYLGJd51zuwEhCS7VraW4lqyVUA0l/Jodnjt4dmuR/gly3fxK0v7t
 C2FQqEGn2BtnHYfkdKNpbcOys1i40DjFh2cqhkyEVbM5XUGbSD7PQtd+0Z5tKx9CM9/OeCFeh
 yhvgFOOPR8nUU2rK0aToKgydsRRNHtNsQrhZY2NMfrJvka0VVKt8pMc4QDGWhDGFo+UiZP4Eh
 3/vADrKVpSe1o5wAUOlVV1uNdSKGdWM15HNF/k9tKGixRdH10NSe0SvGVFsAertMSBXOMSIZX
 TSCDx8/MrJPVOkRtrXCHIGbFugzHhnnLFDn4/Jr5xUYoEz+nTk4ZwFeZMNs7AQ3hnYUqOXBgZ
 jXvkv+JYNu91HlZ8tNKxac3BNCE=
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

