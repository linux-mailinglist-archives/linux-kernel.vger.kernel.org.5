Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC2B7F54FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbjKVXsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjKVXsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:48:30 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FCD1AE;
        Wed, 22 Nov 2023 15:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1700696898; x=1700956098;
        bh=f6AP4LmFw/trA60I/yMovmpTiDKYHrAJis74uiTJfuc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=LgfVUwMabzoZ0GZdCiNplAUdW5ZUgRm//I+1rvh9ZzeSj3s4hHcp1aG3mj56loQWk
         FZsWjHpquhpwQyU6HmRntasLt2wQjlJfyve86+Pdl/ubm05MNv1prlSkfns6Njti2L
         ADOUdtu4kgp58s5y5mdDLEToqMyP/JrQs/ZLdUogD7MEHehG4XV1d4vC8XDhfSLH6q
         NaOI+uzNeN4YLJ8F1J8LCN+o3RzwZiEMypg2LDqaBCXMF5BjWZEJjSuGITj0JlISUN
         0DwvqWZcyMuhL5L3UC8k8WrLX+9NLeD4mIw/JqJagq7cDGW2DnQQ/r4M28J3lHfqlr
         QppN++RYjWo7g==
Date:   Wed, 22 Nov 2023 23:48:08 +0000
To:     Henry Shi <henryshi2018@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     hbshi69@hotmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, hdegoede@redhat.com, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, hb_shi2003@yahoo.com,
        henrys@silicom-usa.com, wenw@silicom-usa.com
Subject: Re: [PATCH v14] platform/x86: Add Silicom Platform Driver
Message-ID: <1usxJUtpXn7sDZJDkSY3j4F45qYVw7b4-8t5SYM5-3bfyXdgG3yXswa2oDJvi3b_Lt_e5ZZUiUIBpAJoQZriz-E9BHh1QzGGErE8QV5zbDw=@protonmail.com>
In-Reply-To: <20231122212007.19428-1-henryshi2018@gmail.com>
References: <20231122212007.19428-1-henryshi2018@gmail.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

2023. november 22., szerda 22:20 keltez=C3=A9ssel, Henry Shi =C3=ADrta:

> [...]
> +What:=09=09/sys/devices/platform/silicom-platform/hwmon/hwmon1/temp1_inp=
ut
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This file is read only. It returns the temperature
> +=09=09of device in the scale of 1000 * Degree Celsius.
> +
> +What:=09=09/sys/devices/platform/silicom-platform/hwmon/hwmon1/temp1_lab=
el
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This file is read only. It returns "Silicom_platform:
> +=09=09Thermostat Sensor".
> +
> +What:=09=09/sys/devices/platform/silicom-platform/hwmon/hwmon1/fan1_inpu=
t
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This file is read only. It returns current fan
> +=09=09speed (RPM).
> +
> +What:=09=09/sys/devices/platform/silicom-platform/hwmon/hwmon1/fan1_labe=
l
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This file is read only. It returns "Silicom_platform:
> +=09=09Fan Speed".
> +

These are standard hwmon attributes already documented in
Documentation/ABI/testing/sysfs-class-hwmon, is it really needed to documen=
t
them here as well?



> +What:=09=09/sys/class/leds/multicolor:sys/brightness
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read/write file. It is used to read/set current
> +=09=09status of system LED brightness:
> +
> +=09=090 - to turn off the LED
> +=09=091 - to turn on the LED
> +
> +What:=09=09/sys/class/leds/multicolor:sys/multi_index
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read only  file. It returns:
> +
> +=09=09white amber red
> +
> +What:=09=09/sys/class/leds/multicolor:sys/multi_intensity
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read/write file. It is used to read/set current
> +=09=09multi-color intensity of system LED: First value for
> +=09=09color white, second value for color amber and third value
> +=09=09for color red:
> +
> +=09=090 - The color is turned off.
> +=09=091 - the color is turned on.
> +
> +What:=09=09/sys/class/leds/multicolor:wan/brightness
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read/write file. It is used to read/set current
> +=09=09status of WAN LED brightness:
> +
> +=09=090 - to turn off the LED
> +=09=091 - to turn on the LED
> +
> +What:=09=09/sys/class/leds/multicolor:wan/multi_index
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read only file. It returns:
> +
> +=09=09white yellow red
> +
> +What:=09=09/sys/class/leds/multicolor:wan/multi_intensity
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read/write file. It is used to read/set current
> +=09=09multi-color intensity of WAN LED: First value for
> +=09=09color white, second value for color yellow and third value
> +=09=09for color red:
> +
> +=09=090 - The color is turned off.
> +=09=091 - the color is turned on.
> +
> +What:=09=09/sys/class/leds/multicolor:stat%d/brightness
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read/write file. It is used to read/set current
> +=09=09status of device status LED (number %d) brightness:
> +
> +=09=090 - to turn off the LED
> +=09=091 - to turn on the LED
> +
> +What:=09=09/sys/class/leds/multicolor:stat%d/multi_index
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read only file. It returns:
> +
> +=09=09red green blue yellow
> +
> +What:=09=09/sys/class/leds/multicolor:stat%d/multi_intensity
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read/write file. It is used to read/set current
> +=09=09multi-color intensity of device status LED (number %d):
> +=09=09First value for color red, second value for color green,
> +=09=09third value for color blue and fourth value for color
> +=09=09yellow.
> +
> +=09=090 - The color is turned off.
> +=09=091 - the color is turned on.
> +
> +What:=09=09/sys/class/leds/multicolor:fp_left/brightness
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read/write file. It is used to read/set current
> +=09=09status of left LED brightness:
> +
> +=09=090 - to turn off the LED
> +=09=091 - to turn on the LED
> +
> +What:=09=09/sys/class/leds/multicolor:fp_left/multi_index
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read only file. It returns:
> +
> +=09=09red green blue amber
> +
> +What:=09=09/sys/class/leds/multicolor:fp_left/multi_intensity
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read/write file. It is used to read/set current
> +=09=09multi-color intensity of left LED: First value for
> +=09=09color red; Second value for color green; Third value for
> +=09=09color blue and fourth value for color amber.
> +=09=09for color red:
> +
> +=09=090 - The color is turned off.
> +=09=091 - the color is turned on.
> +
> +What:=09=09/sys/class/leds/multicolor:fp_center/brightness
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read/write file. It is used to read/set current
> +=09=09status of left LED brightness:
> +
> +=09=090 - to turn off the LED
> +=09=091 - to turn on the LED
> +
> +What:=09=09/sys/class/leds/multicolor:fp_center/multi_index
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read only  file. It returns:
> +
> +=09=09red green blue amber
> +
> +What:=09=09/sys/class/leds/multicolor:fp_center/multi_intensity
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read/write file. It is used to read/set current
> +=09=09multi-color intensity of left LED: First value for
> +=09=09color red; Second value for color green; Third value for
> +=09=09color blue and fourth value for color amber.
> +=09=09for color red:
> +
> +=09=090 - The color is turned off.
> +=09=091 - the color is turned on.
> +
> +What:=09=09/sys/class/leds/multicolor:fp_right/brightness
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read/write file. It is used to read/set current
> +=09=09status of left LED brightness:
> +
> +=09=090 - to turn off the LED
> +=09=091 - to turn on the LED
> +
> +What:=09=09/sys/class/leds/multicolor:fp_right/multi_index
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read only  file. It returns:
> +
> +=09=09red green blue amber
> +
> +What:=09=09/sys/class/leds/multicolor:fp_right/multi_intensity
> +Date:=09=09November 2023
> +KernelVersion:=096.7
> +Contact:=09Henry Shi <henrys@silicom-usa.com>
> +Description:
> +=09=09This is a read/write file. It is used to read/set current
> +=09=09multi-color intensity of left LED: First value for
> +=09=09color red; Second value for color green; Third value for
> +=09=09color blue and fourth value for color amber.
> +=09=09for color red:
> +
> +=09=090 - The color is turned off.
> +=09=091 - the color is turned on.
> +

These are standard LED attributes already documented in
Documentation/ABI/testing/sysfs-class-{led,led-multicolor},
is it really needed to document them here as well?


> [...]
> +static struct led_classdev_mc plat_0222_mc_led_info[] __initdata =3D {
> +=09{
> +=09=09.led_cdev =3D {
> +=09=09=09.name =3D "multicolor:wan",
> +=09=09=09.brightness =3D 0,
> +=09=09=09.max_brightness =3D 1,
> +=09=09=09.brightness_set =3D silicom_mec_led_mc_brightness_set,
> +=09=09=09.brightness_get =3D silicom_mec_led_mc_brightness_get,
> +=09=09},
> +=09=09.num_colors =3D ARRAY_SIZE(plat_0222_wan_mc_subled_info),
> +=09=09.subled_info =3D plat_0222_wan_mc_subled_info,
> +=09},
> +=09{
> +=09=09.led_cdev =3D {
> +=09=09=09.name =3D "multicolor:sys",
> +=09=09=09.brightness =3D 0,
> +=09=09=09.max_brightness =3D 1,
> +=09=09=09.brightness_set =3D silicom_mec_led_mc_brightness_set,
> +=09=09=09.brightness_get =3D silicom_mec_led_mc_brightness_get,
> +=09=09},
> +=09=09.num_colors =3D ARRAY_SIZE(plat_0222_sys_mc_subled_info),
> +=09=09.subled_info =3D plat_0222_sys_mc_subled_info,
> +=09},
> +=09{
> +=09=09.led_cdev =3D {
> +=09=09=09.name =3D "multicolor:stat1",
> +=09=09=09.brightness =3D 0,
> +=09=09=09.max_brightness =3D 1,
> +=09=09=09.brightness_set =3D silicom_mec_led_mc_brightness_set,
> +=09=09=09.brightness_get =3D silicom_mec_led_mc_brightness_get,
> +=09=09},
> +=09=09.num_colors =3D ARRAY_SIZE(plat_0222_stat1_mc_subled_info),
> +=09=09.subled_info =3D plat_0222_stat1_mc_subled_info,
> +=09},
> +=09{
> +=09=09.led_cdev =3D {
> +=09=09=09.name =3D "multicolor:stat2",
> +=09=09=09.brightness =3D 0,
> +=09=09=09.max_brightness =3D 1,
> +=09=09=09.brightness_set =3D silicom_mec_led_mc_brightness_set,
> +=09=09=09.brightness_get =3D silicom_mec_led_mc_brightness_get,
> +=09=09},
> +=09=09.num_colors =3D ARRAY_SIZE(plat_0222_stat2_mc_subled_info),
> +=09=09.subled_info =3D plat_0222_stat2_mc_subled_info,
> +=09},
> +=09{
> +=09=09.led_cdev =3D {
> +=09=09=09.name =3D "multicolor:stat3",
> +=09=09=09.brightness =3D 0,
> +=09=09=09.max_brightness =3D 1,
> +=09=09=09.brightness_set =3D silicom_mec_led_mc_brightness_set,
> +=09=09=09.brightness_get =3D silicom_mec_led_mc_brightness_get,
> +=09=09},
> +=09=09.num_colors =3D ARRAY_SIZE(plat_0222_stat3_mc_subled_info),
> +=09=09.subled_info =3D plat_0222_stat3_mc_subled_info,
> +=09},
> +=09{ },
> +};
> [...]
> +static struct led_classdev_mc cordoba_mc_led_info[] __initdata =3D {
> +=09{
> +=09=09.led_cdev =3D {
> +=09=09=09.name =3D "multicolor:fp_left",
> +=09=09=09.brightness =3D 0,
> +=09=09=09.max_brightness =3D 1,
> +=09=09=09.brightness_set =3D silicom_mec_led_mc_brightness_set,
> +=09=09=09.brightness_get =3D silicom_mec_led_mc_brightness_get,
> +=09=09},
> +=09=09.num_colors =3D ARRAY_SIZE(cordoba_fp_left_mc_subled_info),
> +=09=09.subled_info =3D cordoba_fp_left_mc_subled_info,
> +=09},
> +=09{
> +=09=09.led_cdev =3D {
> +=09=09=09.name =3D "multicolor:fp_center",
> +=09=09=09.brightness =3D 0,
> +=09=09=09.max_brightness =3D 1,
> +=09=09=09.brightness_set =3D silicom_mec_led_mc_brightness_set,
> +=09=09=09.brightness_get =3D silicom_mec_led_mc_brightness_get,
> +=09=09},
> +=09=09.num_colors =3D ARRAY_SIZE(cordoba_fp_center_mc_subled_info),
> +=09=09.subled_info =3D cordoba_fp_center_mc_subled_info,
> +=09},
> +=09{
> +=09=09.led_cdev =3D {
> +=09=09=09.name =3D "multicolor:fp_right",
> +=09=09=09.brightness =3D 0,
> +=09=09=09.max_brightness =3D 1,
> +=09=09=09.brightness_set =3D silicom_mec_led_mc_brightness_set,
> +=09=09=09.brightness_get =3D silicom_mec_led_mc_brightness_get,
> +=09=09},
> +=09=09.num_colors =3D ARRAY_SIZE(cordoba_fp_right_mc_subled_info),
> +=09=09.subled_info =3D cordoba_fp_right_mc_subled_info,
> +=09},
> +=09{ },
> +};
> [...]

These LED names do not have the syntax described in Documentation/leds/leds=
-class.rst,
which is "devicename:color:function".


Regards,
Barnab=C3=A1s P=C5=91cze
