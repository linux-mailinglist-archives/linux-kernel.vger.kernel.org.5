Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5347F5586
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjKWAtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKWAtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:49:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC41D1B3;
        Wed, 22 Nov 2023 16:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700700515; x=1701305315; i=w_armin@gmx.de;
        bh=yDHyDHS5S4Auj4mc9ZSQ4WBkDIhFW3w9J4NlOR396bA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=V2/nGg+l89FJhovOYpe620NwhhbJeixnNf5TJhKUg/1tNy8FgIBy15nG/3LwbE0s
         VFFo+VoBAzE0QRJN2xL+6ZC+2PYvnbTCcWl6TtAB7RwF93cj0/2yKsBdyTZnxcmi2
         jrs7bRzeD6jbWev8rgWCHfaSdRE8xXgH+i3/1n16IPtCtgFZ0MDsIyuD4zhaHY/Gq
         tvgX4MnKqp7owsc1z1qr12sHy+mQM+riTxcbFT0TBj5p8HAEVCC7UCJv8DPtkUl4o
         MZN59DrxGprpNewGzoYvkaEpJDltLpR4/+G0lPqfNkLkvIhBTSwZCTROwf07azSef
         peeWJeNcVkSG1Go9Zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1ML9yS-1qnt2n1YNm-00I9EK; Thu, 23 Nov 2023 01:48:35 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] hwmon: (dell-smm) Add support for WMI SMM interface
Date:   Thu, 23 Nov 2023 01:48:11 +0100
Message-Id: <20231123004820.50635-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/8/j+v/jLv65EcbwtRVIULNAn+AXMfHuCCmvpDJblvjb9KBaCNQ
 z8yXIudV5LTlgMloxMGj7afibyf8EQXUY6U6mZ5CpUERbAX5NZxALXOPMleJagbDyZ973Bc
 Qq27PNbFtWBLtAmJ8Mg9JPoYG/LbNCyq5wXbTnqrDrm4vkzCa65eV9S1yXa4rMt06LunQVk
 C7dCEkO0SKzo96M2Y5zzQ==
UI-OutboundReport: notjunk:1;M01:P0:QEu2HiJ3IXc=;uhPAUJLf6aJNhsq/a4AmdUvLkMv
 fskxnYN3fHyK/C4fBiQGBo6E+F0GI1mHP+M7nA635SHjT7MiSi69tje66wx5f2mbQvglkv4u9
 BoXP8/Zo5svlJwOqzvjXdKMaoLjM8P2sfYkMEdJLbZdtQsexVXeSgBE1gUfRkNbIeukV7CBNs
 c2H+HKf9zZmFGj5ddmZbvFW+L6uHTn8IP657sz7KLpNJtq3eSocYIbNVYRNMerO6sZUS4GoPC
 UtLOORNEKONOUS0aSn0Y7iZ9KRPFF4mQJHPQCSn3oQ+O/p3x9A9o7RdoYQVdkxfH20u6SI6Gl
 eMmL2sMXfKGGjM/IdTpLqQ+aN1Thsv8/KKL+dBNJXMJznUJTXGfEpEvYgM3tfxCtZI7fQpNFb
 d7UgXSHouXiFEytu4RCmTgnbB0KeloKHlDCqDPvUiGLfC2RHQhLNj3qn5iKiNqrtKupSvfyus
 jUbWdPAHeWdUOuIhpqZgo9IcTXoa2ZadzNG/agVHXfeuK+WDBoJ9wAZOnhberRNoCeyk/6phQ
 nMy2iFuDRR/uPmHxsuuxXUlLUHb/FEHdUSgAJ1jCdaX6EkSoEB2EVKBCaavW0Fgpg8JJnVIib
 W8F1wVGumbvHTO/6McFj66eDYCPrAjr/JcO5Xy+RGIIPSZdpVFv4pNYoSAIkLydSKZLNdXAdm
 e5LlrpeLGyGVhEBZVe7kNEMDxSUNDGKF3XaXvhQhc4lnWlM6RJLOWxq6NmuMulCPt456/Fa30
 07S8Dx+bivUKuO4mRRUjPwKj1Ugpj59oTYAG1mZwcjVFoRQB8WZtw1y6TRijFYGDikeg9n08o
 gOMKsvrgMBhtz+m/2795hxcz3msGQzYfkAvXxUDzr01OeYKNH4Ohx0A9LjjJMQmoJDg5rVQrU
 L2e6YOU12AaNCZ5HIjWH1LEE6tFIH4KpIaJqyXxiyWzbd4rGPqQbsVub8mGBa5lYNrauGtdwj
 df4AJg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for an alternative SMM calling
backend to the dell-smm-hwmon driver. The reason for this is
that on some modern machines, the legacy SMM calling interface
does not work anymore and the SMM handler can be called over
ACPI WMI instead.

The first four patches prepare the driver by allowing to
specify different SMM calling backends, and by moving most of
the DMI handling into i8k_init() so that the DMI tables can
keep their __initconst attributes (the WMI SMM backend driver
does not probe at module init time). The fifth patch does some
minor cleanup, while the next three patches implement the new
WMI SMM calling backend. The last patch adds the machine of
the user who requested and tested the changes to the fan control
whitelist.

If the driver does not detect the legacy SMM interface, either
because the machine is not whitelisted or because the SMM handler
does not react, it registers an WMI driver which will then bound
to the WMI SMM interface and do the remaining initialization.

The deprecated procfs interface is not supported when using the
WMI SMM calling backend for the following reason: the WMI driver
can potentially be instantiated multiple times while the deprectated
procfs interface cannot. This should not cause any regressions
because on machines supporting only the WMI SMM interface, the
driver would, until now, not load anyway.

All patches where tested on a Dell Inspiron 3505 and a Dell
OptiPlex 7000.

Changes since v3:
- Using unsigned integers for registers
- use TAB instead of space after comma

Changes since v2:
- Rework WMI response parsing
- Use #define for method number

Changes since v1:
- Cc platform driver maintainers
- Fix formating inside documentation

Armin Wolf (9):
  hwmon: (dell-smm) Prepare for multiple SMM calling backends
  hwmon: (dell-smm) Move blacklist handling to module init
  hwmon: (dell-smm) Move whitelist handling to module init
  hwmon: (dell-smm) Move DMI config handling to module init
  hwmon: (dell-smm) Move config entries out of i8k_dmi_table
  hwmon: (dell-smm) Introduce helper function for data init
  hwmon: (dell-smm) Add support for WMI SMM interface
  hwmon: (dell-smm) Document the WMI SMM interface
  hwmon: (dell-smm) Add Optiplex 7000 to fan control whitelist

 Documentation/hwmon/dell-smm-hwmon.rst |  38 +-
 drivers/hwmon/Kconfig                  |   1 +
 drivers/hwmon/dell-smm-hwmon.c         | 604 +++++++++++++++++--------
 drivers/platform/x86/wmi.c             |   1 +
 4 files changed, 454 insertions(+), 190 deletions(-)

=2D-
2.39.2

