Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28C07E088E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjKCS5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKCS5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:57:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237ECBD;
        Fri,  3 Nov 2023 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699037844; x=1699642644; i=w_armin@gmx.de;
        bh=WxIQKDxEScDT6pMF2VA0SucOhl2rbl0wp5PNNerC15A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Fd/1CCLbG/eO1i8/k/hH5v2iYHO5SjLgmZ/5794m0fbdAeZJMqn3lQoHUHRNnIlr
         rk0aLF6pidUO9juzgrUoKHFLMQuQfCqJ3kMKOu1RpmCAlCsxQ5QEqMoGaGWMPUZcN
         CbwZY7djwBVarHfb0a4pXkquCT4tEzDdSo592zjf88zoMvlaSbkLYmPS/WdWz8gnb
         lEz9LgXUe/BBPvXAhGLvVnGg1S/e7v6sCCsQf0OfkJ3l/owVeH7V7ARiSUkr+tzV3
         XXn/PNzmYHldau026lVx2Rr6+wuka4D7P08el7mY/tvtl8DG0fln3VW2DNOq+e9Sx
         EkH9m4wUjTm7hOTlVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MoO6C-1rnmaC20W8-00okDZ; Fri, 03 Nov 2023 19:57:24 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] hwmon: (dell-smm) Add support for WMI SMM interface
Date:   Fri,  3 Nov 2023 19:57:07 +0100
Message-Id: <20231103185716.11007-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Sd20CM+fHbaAIxl8mLOwXNM4dkkepHezY+nWmvVUtxJUMDeSql
 w08TD+0HYyGPIt/vznU4ir4snnHl+BlCXoG8iFbJjoqoZrbE1IQQyArpdW9wzuZh8UvcLB1
 BxYhoiADDxr+p6UyLuCwkUnHwC+q2jOsSlSfZiNWaj7+oLDJ/CjyNe8ZOJeMbuXbePFsvEY
 n1Tkkdxg+8cPekrC0OQsQ==
UI-OutboundReport: notjunk:1;M01:P0:iJuU7nWPeKE=;+0Kj5Mvni25uYWOeQdxs7Puo4bJ
 KX4w3f4sxHE5CtflQ/n5ho/QpCkdi3XfVHhjklDGvu9f1PLTsoiMeY8Cbe8MFjdHaXb2w+XEs
 vXWQvrwGMFp0RyUh+cHZq2bT6Jp3/q/K5GLiXl+cZCDAUIq4QsgaMq0UhArR0kr0jB/6iWslW
 bZdeXA2c2MxR6xirzlyW6MPlXv2VMc/JEHCppuJrwsG8IFI87UM1jOKsZWUcFj5Lzf/kFQduf
 QqCP81R/VKlKJo4hX1D9deKDPjZZ5zOoHjFSTw7+n9tVgMW1N2dsgjDixOyb6idVN/kjBf6os
 nu3yCujfyOOB9W6vaFliFgLaIT7Dkn4mZrJnoj0UUzmfpVN5kND4jo4F9drIDP3lwJZewhSOW
 Hm1oPsqm1/SG0o4tTq746en3tTidzoWy2ecAkiM+YsT8R9lXUUDbketIQNBmzQ0abtwlEN4zT
 x8bpwvIRN71eaZst5u4jCKn501LN7hAQ8k1a7QsOt5QNGedC20ctW0VFSA89wjdbNjGvZ6P8D
 VuDAJVZAbtcRhBTVgEWuLeJ+ZvzfPv+V2IzxeWgOtQJPlUqx5ZAwePhFNVXlB/M3Gorn5K2c1
 0hZzI7ZUK8znrHQNvsBbKTCh7JTSUiuCmIYx6u7KPCgOF0Qud1OgtZgtxuQ/Jyux9DXOrsBjo
 wxVqp00O8zBxHaeQHECBnNPlrdXtlsWBQG4pUFWvljzZ6Sz/XIKveBqUSjg3jkMAt5lU3i3nv
 8t3g3KVPUWtegvYl2CPAB73fmszym/VzGZIETQ5z6Mo2fkTMoPYWlQOEGMAWdxc5PB5fDkw+t
 Lr50naZXEVT29qxducrQlLbuimV7MAF1WoKeuKiVAl616VMtPx7NnIJ8vTeNkUGKXKxjhtco+
 Lzoy1Ig0zQEQA1dqKmFZoHMi8ktYz1AAQres3DXHchAI//m8+FmZ+pLalJLCbpYfxhz1B2CDC
 cxROoqRAqn6BVBdDzht4PMfiGD0=
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

 Documentation/hwmon/dell-smm-hwmon.rst |  33 +-
 drivers/hwmon/Kconfig                  |   1 +
 drivers/hwmon/dell-smm-hwmon.c         | 569 +++++++++++++++++--------
 drivers/platform/x86/wmi.c             |   1 +
 4 files changed, 414 insertions(+), 190 deletions(-)

=2D-
2.39.2

