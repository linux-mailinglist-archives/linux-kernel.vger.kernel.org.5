Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304367EA414
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjKMT4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjKMT4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:56:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB67891;
        Mon, 13 Nov 2023 11:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699905361; x=1700510161; i=w_armin@gmx.de;
        bh=R/McC+8zGagwUqETW9j+WDUL2rgHuTQeczIJx7hGop0=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
         In-Reply-To;
        b=AKEDv/xMoi4zaIt6+ECnHD10umNCcR1dLkhnOteGJX7q1JoyNj58Cxj3ETjoWq/U
         HICLHcsE3CruNj6gnrlI7WgAY/MWKOM1KKkXtkgzrAKXPi++6lS1q0ihrS7v+5r8y
         g5Tf/qqkemrue7IGSDVh7Kyh8l+3SCTHKdRsLiPPo1bkQpXqx0287t874NPv5zN2S
         aBAkhSnSluQrq9oB/TyBQ78QUzorqmxvqyv5WHqfTG0eq0SJeQY4cvyTgbyODNaod
         FHORpbbpgEUKIzawkB4Z3/byM3Br7Op4+ON102mhYm206cSPdRUVRIiCnXqIoSsei
         yjVN28jGIqDLbCMFqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYPY-1rZjrd0oie-00fwQS; Mon, 13
 Nov 2023 20:56:01 +0100
Message-ID: <3ec0496d-3b89-46f5-9faf-9fcce78f6b38@gmx.de>
Date:   Mon, 13 Nov 2023 20:55:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] hwmon: (dell-smm) Add support for WMI SMM
 interface
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231106064351.42347-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20231106064351.42347-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hxVtjv83rr/y2l01CxT5Q6pSgn/sqRp6T29u+JIiayf78gYaf0q
 X85RZ3XnU+tH90AW4mLrasevvn59At6dKkX6Jlilc+8L+bNaU82fRhW8TtG0Sw23H+jmzon
 KzA41UjcDIqfjFpeNzoHBCWWJvdJIFu1BPwABvf3ffSlS0KlYn4xHRzjJ9Fu8hPhBsUREoN
 Y0c+gntYwJOOCijAQv7jA==
UI-OutboundReport: notjunk:1;M01:P0:Cz4ETvqxTGY=;nkTYKUrj/aD6knQDwm2Q/3bst9Z
 w03P/zKhpACvAkJUyRGo2yJQVJaR19QShRfjueZUh44UQjaq//s4fGSoEDO3avFg0GdQaBPY0
 lp0hJ1VKIMw8cPaSqTkfR2mfVlxXpFGNVmL4uIQTGsqULrnW2vd3v+BJwxyUQpNqDMWxh1Tqm
 mMEcba5E1zlBn3wzDFfzIHvPBuOBv6xf9lovlmx0OZKrsd9AH319UcO4Djqr8WZRUpZZJNXus
 gjLudJ/pPkt7QHZUWDzIDElCu2Q/v2XC+ngQ7YYTpy7t3DdjYMKs4oYZ7ybW92RZAqXwp33lK
 fqzQMKdsY/Hqt0OLd9zpqTZU1A86xNlzIpY33CPgVF80r5m1FsXNjDnoQuOvJ7pifZh56GZxO
 DseTBpiJBQlYzkewLUCGeRO5sgSJE2f+HkaA1toKiSnZ11zqJy1oejg2FYY1sDck+AoeYNpe1
 Tizp2G1yOpL8Na6R52geE67AyaJGjdqu8C69DH1weVYQH/Xvf226xZTm0zqOnZhsObFt7VaVY
 s9ujzY1z+e0LGuGVRFh3BssWPd48xDJ+BBa54Vs2Hy0HoMv0kVnXhPMatgqkWjBXOYB16zoq+
 XaZF3uyncCpJ33qF16k7gEdS2H2BTBO7B9Wxyfx7WrwTLYPe4lm3vlS3GioHzpYrIdF4nm7Yk
 feI8n81esvcUmt17J/ymqL9jAfRe1qz0vP655YBaQxcofeIBfgmPI+ELDamMyK1PgV50FFlpI
 oyPQt6fSx2BULfm0Zdv1eSVZj3VDmaHeUn5D2E/nSch3lAutgeM4Su9XRuiblJgif3ywDdDFn
 ztrDbMTVM+091O2oPaut0Ck5DG2cOuUE2NsgZA6Bl2PwSng0oy2Ivw0EXmqvQXPxfjuDi/CBH
 /SKjI/4ePLsuDkttrwFw8XtZm0SoEN3dkNcpYtswRQPLoSThZoFsZcczh5u18UuFlo4m9KBs0
 26qR9Z1qQ7f6APbnk6DHQY7XrGw=
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

Am 06.11.23 um 07:43 schrieb Armin Wolf:

> This patch series adds support for an alternative SMM calling
> backend to the dell-smm-hwmon driver. The reason for this is
> that on some modern machines, the legacy SMM calling interface
> does not work anymore and the SMM handler can be called over
> ACPI WMI instead.
>
> The first four patches prepare the driver by allowing to
> specify different SMM calling backends, and by moving most of
> the DMI handling into i8k_init() so that the DMI tables can
> keep their __initconst attributes (the WMI SMM backend driver
> does not probe at module init time). The fifth patch does some
> minor cleanup, while the next three patches implement the new
> WMI SMM calling backend. The last patch adds the machine of
> the user who requested and tested the changes to the fan control
> whitelist.
>
> If the driver does not detect the legacy SMM interface, either
> because the machine is not whitelisted or because the SMM handler
> does not react, it registers an WMI driver which will then bound
> to the WMI SMM interface and do the remaining initialization.
>
> The deprecated procfs interface is not supported when using the
> WMI SMM calling backend for the following reason: the WMI driver
> can potentially be instantiated multiple times while the deprectated
> procfs interface cannot. This should not cause any regressions
> because on machines supporting only the WMI SMM interface, the
> driver would, until now, not load anyway.
>
> All patches where tested on a Dell Inspiron 3505 and a Dell
> OptiPlex 7000.

Any thoughts on this?

Armin Wolf

>
> Changes since v2:
> - Rework WMI response parsing
> - Use #define for method number
>
> Changes since v1:
> - Cc platform driver maintainers
> - Fix formating inside documentation
>
> Armin Wolf (9):
>    hwmon: (dell-smm) Prepare for multiple SMM calling backends
>    hwmon: (dell-smm) Move blacklist handling to module init
>    hwmon: (dell-smm) Move whitelist handling to module init
>    hwmon: (dell-smm) Move DMI config handling to module init
>    hwmon: (dell-smm) Move config entries out of i8k_dmi_table
>    hwmon: (dell-smm) Introduce helper function for data init
>    hwmon: (dell-smm) Add support for WMI SMM interface
>    hwmon: (dell-smm) Document the WMI SMM interface
>    hwmon: (dell-smm) Add Optiplex 7000 to fan control whitelist
>
>   Documentation/hwmon/dell-smm-hwmon.rst |  38 +-
>   drivers/hwmon/Kconfig                  |   1 +
>   drivers/hwmon/dell-smm-hwmon.c         | 603 +++++++++++++++++--------
>   drivers/platform/x86/wmi.c             |   1 +
>   4 files changed, 453 insertions(+), 190 deletions(-)
>
> --
> 2.39.2
>
