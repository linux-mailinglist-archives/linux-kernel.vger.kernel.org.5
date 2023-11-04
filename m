Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CB57E1027
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 16:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjKDP4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 11:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKDP4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 11:56:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F90D19D;
        Sat,  4 Nov 2023 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699113364; x=1699718164; i=w_armin@gmx.de;
        bh=W7K72Gws5VcOYX9dxJOCuIlMoX8ancV6sQsAZoNeQgI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=g1iy8eCsYmfyxa48ePqTvcxK4zLq37Nz7xyU+RzXvHTwBy80LL+D8t+qJSDHb0Z4
         QTCK9dcbdYHix59rYQJ8EnD+9PMUmJl1b1GZ3eFKIC3ZYA0LRkA/At5COrJC0o4bw
         m68wxvHHsS70U8umILPhK+awU/Mu3WXaSNT/BYZQepuC8F2HJKcHxpHB1akEG42jq
         euAVmZ+n6+xD0JJfbAq/UEmQSdsB/NW0im/SoVku9ag1xDRw96UIlqN8qjxD4FnHA
         OOnOHrClPK6xa/NhOGqfPIiNGBGzQg/xKtb3mMc50dLPSPiFdZeB0TLRA405Lldsu
         XeGotR6zRERQGra6dQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MF3DW-1rEg9L3Iro-00FTK4; Sat, 04 Nov 2023 16:56:03 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] hwmon: (dell-smm) Add support for WMI SMM interface
Date:   Sat,  4 Nov 2023 16:55:50 +0100
Message-Id: <20231104155559.11842-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:le8Ec2oo0n0/vHFqYI6WavwtGaLWDZPviYaaHjAkv3QFzijsAfc
 2vl41Jvm/lYcsvXSFIblDfakzj3Y+FFguyvE+yw9FqxWTtzzqyFEbSCizIamLuy2NqQAIOQ
 OtdO3PU32BXqrc5UV83ecUS3LVJ5yFS1LDPLn/i9tUTRmF0T/ByucLOGkKw+rIhVH3aOLPg
 sOVeplc+PFuhNxb59dOPw==
UI-OutboundReport: notjunk:1;M01:P0:MnMC3M5/0io=;FyjBixMPg3mNEraLyhp31i19Oc/
 1vc+UWOjveUIYBrzoqwO89Nq0y33a/CWkKQ0OO+DXQbiWqvwlue13ujlbu872EyIexae9Vgic
 KMpNZ0gZtQcdpOpJuq6rM1nwUKgvZgVAA0Y5pfS7OXNR168+2phL1Z0FmM3vFWDl4E7L7EcDP
 8C3YUlYr0VXCWjpxA8GgkJ8jtdxIpIuClrewyLY89ce0IMx5XrbTRnFkS8xQ5E2BxL41rPSXy
 diO328YqkbQN0GOqLb7h85Y3HCBTIcJWSuEbqypD50ZmJwAxKIeTupRLy+aQdoXztU6FwK1uA
 rHJF0W+MhKN283SbVwsGHq+qrpJcGnWnJbtizhxZPDqQVpi6YbyJnYwBzVo2UJkoTCS0xbeeF
 yv6qYYc0//Y7iTNG2PHa9Hd0f1tXJFzb4/zM/Wbx9wP4VlUqLb0mDvgKEK+ZHTtmP/eF3O367
 GGJ3Q10HYGLpY7CY3TMWUhgMp3QUijpA3WXeAjugEIEXo2R8C38ymXY5ZSetDoInNGzMP9v1j
 +r1jjI0i+xQyF2c7wWeifLzw9Zt4rg/GuNtnjsAOJ5kuNh8f2qe5IHDzf6BqhCi1oP5vX//rf
 vdFsQ+SjEfvcsDVVzYI19odfyHyn8UWQN3NFf0tc5WPmgA8qsLu9EVq7LcoQQwLMsr6EYR5vc
 SwqWYD4DFz0+kvAsq2NMdPkfKslZZbADrDulR/CTnEmIpRILz/U0nPhf40EliKdT/V7OYI56h
 RZ9lT6owY+atcAodESvtKpZHch7gIRDu3WI41hCB5Lf284W+VBv5uLLHjCyW5uCiJ5mRIHdSr
 IOXPcCPXyClBpngSelQT/WuiOZE+9sq5R5Y5IOEV6gLErOUhvpojfnbjAmXWf5I1ieojdSfOb
 oD+oUlayVz+0zjc7HMI/1TQBXnOtgc8L1kk3Wmb7OpM36iSc6WkugZmMoLCB7hA9WpcTR75a6
 VlVL/mnZdmGKfdzmkS1QtlqlBxo=
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
 drivers/hwmon/dell-smm-hwmon.c         | 569 +++++++++++++++++--------
 drivers/platform/x86/wmi.c             |   1 +
 4 files changed, 419 insertions(+), 190 deletions(-)

=2D-
2.39.2

