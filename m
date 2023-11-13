Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076327EA531
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 22:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjKMVCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 16:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKMVC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 16:02:28 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E61D5A;
        Mon, 13 Nov 2023 13:02:21 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7789aed0e46so325932885a.0;
        Mon, 13 Nov 2023 13:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699909340; x=1700514140; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vXkZm76dpTZ/k++NpqlJUMl3w0PsdZsmKLB/kYkg7D8=;
        b=axmh3H6cFB9Hd+pYXNBa8fJ5Kd2YdTmthXCUKAy9E/aHxRX79CcUoWAk/qt2nc2xkR
         m7lLQ1YiWrkOGVeg/BJaY53nB8Yim9Mvwmc3HL8pAROCoRJ72J37MDYuYozZsm6m4roT
         J2sy13LXEfcDW/kbXYTddPBkjl8O0OQ9K+CEZ+1UaTAyCGbi/kAW+MraydTH+LxTd8eS
         F+rfqY8YJgp/hHW7mCEStZaODGWAQkw7eSn3/TrOXfc6mQEjEtKolnjUwXutQGbgnA5O
         vaAqWnjdM2z+4146Pc0ZWpcXb9Gllw8NTTiMgWexrh6eUAo0U7oLaz7w2Xmdq/sG7il1
         oZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699909340; x=1700514140;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXkZm76dpTZ/k++NpqlJUMl3w0PsdZsmKLB/kYkg7D8=;
        b=s4Zz2iTDnAcQCPCJ2X2ZwCPNE6ocXofs5e/WoYV5ieErsTCOyOeNYH/COE0HmrYJia
         00bcjKZBHPkL5M4+axT8gbNZbtVPGVgZFuy4gB+VTeU/vJeK2FjKY2bDauf7kLHFhQ2P
         ys8MnVF8GxWfrBUTBmJwgBBbYlV0jcY0AnfW9NLATRlz/z5lsmTG4+uUsOraDRCZ6/ok
         dc3j8ccnvldRokOmYhIixHjE/dA4oGZtn9B2OlKAl95MTJm72O4NnTCfNilFDoIiKY9k
         RrjYpesftZZdjVtVmU9ojHfi+jKjcRDzIWFbXcleN0PCWzpuLioEPJ9FkrCPBEgZ1tm/
         0kzw==
X-Gm-Message-State: AOJu0YxhwFuVvmF6ACAxW3K13SD7wpdsNP+WKx3rXSn8S3OC8k7yt3/g
        zkx2chZufwRn3yQROmGpHH8=
X-Google-Smtp-Source: AGHT+IHbxOqw5+zJOiPQ+DbnIPp+Y6QJ35Ec+xuJ0ZshtECJ428WyjMB6FsaHz8e2dG32Fb/uXVOsQ==
X-Received: by 2002:ae9:e50f:0:b0:77b:c8ab:af94 with SMTP id w15-20020ae9e50f000000b0077bc8abaf94mr351390qkf.67.1699909340084;
        Mon, 13 Nov 2023 13:02:20 -0800 (PST)
Received: from build.adi.eng (173-14-114-226-richmond.hfc.comcastbusiness.net. [173.14.114.226])
        by smtp.googlemail.com with ESMTPSA id dh15-20020ad458cf000000b00655e428604esm2350916qvb.137.2023.11.13.13.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 13:02:19 -0800 (PST)
From:   Henry Shi <henryshi2018@gmail.com>
To:     hbshi69@hotmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, hdegoede@redhat.com, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     hb_shi2003@yahoo.com, henrys@silicom-usa.com, wenw@silicom-usa.com
Subject: [PATCH v12] platform/x86: Add Silicom Platform Driver
Date:   Mon, 13 Nov 2023 16:02:16 -0500
Message-Id: <20231113210216.30237-1-henryshi2018@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Organization: Silicom LTD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform/x86: Add Silicom Platform Driver

Add Silicom platform (silicom-platform) Linux driver for Swisscom
Business Box (Swisscom BB) as well as Cordoba family products.

This platform driver provides support for various functions via
the Linux LED framework, GPIO framework, Hardware Monitoring (HWMON)
and device attributes.

Signed-off-by: Henry Shi <henryshi2018@gmail.com>
---

Changes from v1 to v2:
===========================

Suggested by Hans de Goede <hdegoede@redhat.com>
.Use git send-email to submit patch.
.patch contents should be in message body.
.Kconfig bit for the driver should be in drivers/platform/x86/Kconfig.

changes from patch v2 to v3
===========================

changes suggested by Guenter Roeck <groeck7@gmail.com>
.Removed unnecessary include file linux/thermal.h.
.Removed EXPORT_SYMBOL for mutex lock/unlock function.

Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
.Remove extra new line in code on multiple position.
.Use table instead of space in code.
.Uss Linux defined bit operation MACRO define.
.Removed local variable in rpm_get().
.Corrected typo in comments.
.Corrected incorrect indentation.
.Removed unnecessary comments in silicom_mc_leds_register().
.Rewrite efuse_status_show() to used defined variable and removed 
uncessary local variables.
.Rewrite uc_version_show() to used defined variable and removed 
uncessary local variables.
.Removed unused MACRO define: #define CHANNEL_TO_BIT(chan) ((chan) & 0x07).
.Rewrite powercycle_uc() to used defined variable and removed uncessary 
local variables.
.use GENMASK() and use FIELD_GET() instead of bit shift.
.Added define for constant 0x28 used in  efuse_status_show().
.Added define for constant 0x0 used in  uc_version_show().
.Added define for constant 0x0 used in  powercycle_uc().
.Rearrange functions to avoid uncessary pre-define.
.Rewrite rpm_get() to used defined variable and removed uncessary 
local variables.
.Rewrite temp_get() to used defined variable and removed uncessary 
local variables.
.Use FIELD_GET instead of bit shift in temp_get().
.Used #define for constant variable 0/1.

Changes suggested by Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
.use "if (!led->subled_info)" instead of
"if (IS_ERR_OR_NULL(led->subled_info))
"in silicom_mc_leds_register

changes from patch v3 to v4
===========================

changes suggested by Guenter Roeck <groeck7@gmail.com>

Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
.Rewrite silicom_mec_led/gpip_set/get() functions to use two newly created
silicom_mec_port_get()/silicom_mec_port_set() which have common code.
.Remove duplicate code in silicom_mec_port_get()
.Rewrite uc_version_show() to use Linux bit operation MACRO, and add
logic to check un-supported register value.
.Added "#define MEC_EFUSE_LSB_ADDR 0x28" and "#define
MEC_POWER_CYCLE_ADDR 0x24"
.Added "#define MEC_VERSION_MAJOR GENMASK(15, 14)" and "#define
MEC_VERSION_MINOR GENMASK(13, 8)".

Changes suggested by Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
.Used a local variable to store "sizeof(struct mc_subled)" in function
silicom_mc_leds_register().

change from patch v4 to v5
===========================================

changes suggested by Guenter Roeck <groeck7@gmail.com>:
.Corrected return value in temp_get() to return 1/10000th degree.
.Removed local variable struct silicom_fan_control_data *ctl in
silicom_fan_control_read_fan(),
removed storing rpm value to ctl variable.
.Removed local variable struct silicom_fan_control_data *ctl in 
silicom_fan_control_read_temp(),
.removed storing rpm value to ctl variable.
.Changed return string in silicom_fan_control_read_labels() to 
specific string for Silicom platform driver.
.Removed silicom_fan_control_data structure.
.Removed static variable mec_io_base and mec_io_len, and added
"#define MEC_IO_BASE 0x0800 and #define MEC_IO_LEN 0x8".
.Removed ".write = NULL" in silicom_fan_control_hwmon_ops
structure defination.
.Removed unnecessary function silicom_fan_control_write().
.Removed unnecessary check for silicom_led_info in function
silicom_platform_probe.
.Removed unnecessary local variable "silicom_fan_control_data *ctl"
in silicom_platform_probe().
.Clean out driver initialization error handling in
silicom_platform_init();
.Add patch version and changelog for patch submission.

Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
.Rename "#define MEC_DATA(offset) to "#define MEC_DATA_OFFSET(offset).
.Use constant defined in include/linux/units.h instead of a literal.
.return directly instead of go to err condition when
platform_device_register_simple() failed.
.Remove unnecessary check for silicom_led_info and silicom_gpiochip.
.Use a local variable to how multiple use of array size.
.Align the arguments to the same column in
silicom_mec_led_mc_brightness_set.
.Add patch version and changelog that shows version to version changes
for patch submission.

Changes suggested by Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
.Use "sizeof(*led)" instead of "sizeof(struct led_classdev_mc)"
.Use "if (!led)" instead of "if (IS_ERR_OR_NULL(led))" 
.Removed unnecessary error message:
"dev_err(dev, "Failed to alloc led_classdev_mc[%d]:
%ld\n", i, PTR_ERR(led)).

change from patch vv5 to v6
===========================================

changes suggested by Guenter Roeck <groeck7@gmail.com>:
.Removed checkpath warnings. 
.Resoved dependencies between CONFIG_HWMON and CONFIG_SILICOM_PLATFORM.

change from patch v6 to v7
===========================================

changes suggested by Hans de Goede <hdegoede@redhat.com>:
.Usa a proper subsystem prefix for this patch subject:
Subject: platform/x86: Add Silicom Platform Driver.

change from patch v7 to v8
===========================================

changes suggested by Hans de Goede <hdegoede@redhat.com>:
.Chnage commit message of this driver.
.Adjust location of change log and signed-off-by.
.Change "config SILICOM_PLATFORM" and help contents location,
and put it to source "drivers/platform/x86/siemens/Kconfig".
.Set editor tab to 8 and align the start of extra function
parameters to directly after (. This should be applied for
all function.
.Do not manually create a sysfs dir and register sysfs attribute,
instead define a platform_driver structure.
.Move MODULE_DEVICE_TABLE(dmi, silicom_dmi_ids) directly after
table declaration.
.Using pr_info() instead of dev_info() in function
silicom_platform_info_init().
.Made dmi_check_system() check the first thing to do in
silicom_platform_init().
.Instead of separate platform_device creation + driver registration,
switched to using platform_create_bundle().
.Removed mutex_destroy(&mec_io_mutex).


Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
.Too many GENMASK() within to code itself, need put them to
#define. Removed all GENMASK() in c functions.

change from patch v8 to v9
===========================================

Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
.Just do the same (like MEC_VERSION_MAJOR) with all places in the where
you previously had GENMASK() in the code (currently MEC_GET_BITS()
is there, obviously, but it should go away and be replaced with
FIELD_GET(GOODPREFIX_GOODNAME, ...))).
.This is sysfs so it's odd to print pr_err() like that here. If the driver
does not support those versions at all, the probe should fail. If driver is
fine but just doesn't know how to interpret such a version, you should
return -Esomething here. Driver returns -EINVAL here.
.Replace CENTI with 100
.Align FIELD_GET()s to the same column for line 661.
.Change variables efuse_status, mec_uc_version, power_cycle to unsigned
int from int.

changes suggested by Hans de Goede <hdegoede@redhat.com>:
.Please add a Documentation/ABI/testing/sysfs-platform-silicom
file to document driver specific the sysfs attributes of this driver.
.Like with the Kconfig part, group this together with the other industrial
PC drivers we have at the end of the Makefile after Siemens
Simatic Industrial PCs.

change from patch v9 to v10
===========================================

Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
.Added missing newline in kernel document file.
.Changed the order #define to make sure they are in increasing order.
.Removed printing in init function silicom_platform_info_init();
.Changed #define name MEC_PREFIX_HIGH_BYTES to MEC_TEMPERATURE.
.Removed dev_err(dev, "Failed to register[%d]: %d\n", i, err)
in function silicom_mc_leds_register() before ruturn err.
.Changed %du to %u in function power_cycle_store(...).
.Chnaged sprintf() to sysfs_emit().
.Changed start point for multi-line comments.
.Added empty line to seperate #define.
.Remove parenthesis around MEC_IO_BASE.
.Changed #define EC_ADDR_MSB (MEC_IO_BASE + 0x3), use
a constant value instead of MEC_DATA_OFFSET_MASK.
.Changed define name MEC_PREFIX_NAME to MEC_PORT_LOC.
.Changed define MEC_PREFIX_HIGH_BYTES to MEC_TEMP_LOC.
.Removed "PREFIX" from define name, changed
MEC_PREFIX_SEC_BYTE to MEC_VERSION_LOC.

change from patch v10 to v11
===========================================

Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
.Don't print anything when userspace gives an invalid value,
just return -EINVAL in function power_cycle_store().
.The includes should be in alphabethical order.
.Just make the calculation once and store into a local variable
in function silicom_mec_port_set().
.Use GENMASK for MEC_PORT_OFFSET_MASK, MEC_PORT_CHANNEL_MASK,
MEC_DATA_OFFSET_MASK.
.Rename MEC_PORT_LOC to MEC_PORT_DWORD_OFFSET.
.Add local variable to function silicom_mec_port_set() and
silicom_mec_port_get() to make the code less heavy to read.
.Allgned defines start from same column mostly.
.Kernel test robot WARNING sys/devices/platform/silicom-platform/hwmon/hwmon1/
is defined 4 times.

change from patch v11 to v12
===========================================

Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
Several editorial things:
.Put the subdir headers separately.
.Add more new line in define section.
.Use () around all macro arguments to be on the safe side.
.Add new line and remove comment in function silicom_mec_port_get().
.Add new line and remove comment in function silicom_mec_port_set().
.Remove unnecessary comment in function temp_get(), rpm_get().

 .../ABI/testing/sysfs-platform-silicom        |  262 +++++
 drivers/platform/x86/Kconfig                  |   14 +
 drivers/platform/x86/Makefile                 |    3 +
 drivers/platform/x86/silicom-platform.c       | 1010 +++++++++++++++++
 4 files changed, 1289 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-silicom
 create mode 100644 drivers/platform/x86/silicom-platform.c

diff --git a/Documentation/ABI/testing/sysfs-platform-silicom b/Documentation/ABI/testing/sysfs-platform-silicom
new file mode 100644
index 000000000000..90d69f0f14c1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-silicom
@@ -0,0 +1,262 @@
+What:		/sys/devices/platform/silicom-platform/uc_version
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This file allows to read microcontroller firmware
+		version of current platform.
+
+What:		/sys/devices/platform/silicom-platform/power_cycle
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+		This file allow user to power cycle the platform.
+		default value is 0; when set to 1, it powers down
+		the platform, wait 5 seconds, then power on the
+		device.
+
+What:		/sys/devices/platform/silicom-platform/efuse_status
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This file is read only. It returns the current
+		OTP status:
+
+		0 - not programmed.
+		1 - programmed.
+
+What:		/sys/devices/platform/silicom-platform/hwmon/hwmon1/temp1_input
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This file is read only. It returns the temperature
+		of device.
+
+What:		/sys/devices/platform/silicom-platform/hwmon/hwmon1/temp1_label
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This file is read only. It returns "Silicom_platform:
+		Thermostat Sensor".
+
+What:		/sys/devices/platform/silicom-platform/hwmon/hwmon1/fan1_input
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This file is read only. It returns current fan
+		speed (RPM).
+
+What:		/sys/devices/platform/silicom-platform/hwmon/hwmon1/fan1_label
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This file is read only. It returns "Silicom_platform:
+		Fan Speed".
+
+What:		/sys/class/leds/multicolor:sys/brightness
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read/write file. It is used to read/set current
+		status of system LED brightness:
+
+		0 - to turn off the LED
+		1 - to turn on the LED
+
+What:		/sys/class/leds/multicolor:sys/multi_index
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read only  file. It returns:
+
+		white amber red
+
+What:		/sys/class/leds/multicolor:sys/multi_intensity
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read/write file. It is used to read/set current
+		multi-color intensity of system LED: First value for
+		color white; Second value for color amber and third value
+		for color red:
+
+		0 - The color is turned off.
+		1 - the color is turned on.
+
+What:		/sys/class/leds/multicolor:wan/brightness
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read/write file. It is used to read/set current
+		status of WAN LED brightness:
+
+		0 - to turn off the LED
+		1 - to turn on the LED
+
+What:		/sys/class/leds/multicolor:wan/multi_index
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read only file. It returns:
+
+		white yellow red
+
+What:		/sys/class/leds/multicolor:wan/multi_intensity
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read/write file. It is used to read/set current
+		multi-color intensity of WAN LED: First value for
+		color white; Second value for color yellow and third value
+		for color red:
+
+		0 - The color is turned off.
+		1 - the color is turned on.
+
+What:		/sys/class/leds/multicolor:stat%d/brightness
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read/write file. It is used to read/set current
+		status of device status LED (number %d) brightness:
+
+		0 - to turn off the LED
+		1 - to turn on the LED
+
+What:		/sys/class/leds/multicolor:stat%d/multi_index
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read only file. It returns:
+
+		red green blue yellow
+
+What:		/sys/class/leds/multicolor:stat%d/multi_intensity
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read/write file. It is used to read/set current
+		multi-color intensity of device status LED (number %d):
+		First value for color red; Second value for color green;
+		Third value for color blue and fourth value for color
+		yellow.
+
+		0 - The color is turned off.
+		1 - the color is turned on.
+
+What:		/sys/class/leds/multicolor:fp_left/brightness
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read/write file. It is used to read/set current
+		status of left LED brightness:
+
+		0 - to turn off the LED
+		1 - to turn on the LED
+
+What:		/sys/class/leds/multicolor:fp_left/multi_index
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read only  file. It returns:
+
+		red green blue amber
+
+What:		/sys/class/leds/multicolor:fp_left/multi_intensity
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read/write file. It is used to read/set current
+		multi-color intensity of left LED: First value for
+		color red; Second value for color green; Third value for
+		color blue and fourth value for color amber.
+		for color red:
+
+		0 - The color is turned off.
+		1 - the color is turned on.
+
+What:		/sys/class/leds/multicolor:fp_center/brightness
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read/write file. It is used to read/set current
+		status of left LED brightness:
+
+		0 - to turn off the LED
+		1 - to turn on the LED
+
+What:		/sys/class/leds/multicolor:fp_center/multi_index
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read only  file. It returns:
+
+		red green blue amber
+
+What:		/sys/class/leds/multicolor:fp_center/multi_intensity
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read/write file. It is used to read/set current
+		multi-color intensity of left LED: First value for
+		color red; Second value for color green; Third value for
+		color blue and fourth value for color amber.
+		for color red:
+
+		0 - The color is turned off.
+		1 - the color is turned on.
+
+What:		/sys/class/leds/multicolor:fp_right/brightness
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read/write file. It is used to read/set current
+		status of left LED brightness:
+
+		0 - to turn off the LED
+		1 - to turn on the LED
+
+What:		/sys/class/leds/multicolor:fp_right/multi_index
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read only  file. It returns:
+
+		red green blue amber
+
+What:		/sys/class/leds/multicolor:fp_right/multi_intensity
+Date:		October 2023
+KernelVersion:	6.6
+Contact:	Henry Shi <henrys@silicom-usa.com>
+Description:
+		This is a read/write file. It is used to read/set current
+		multi-color intensity of left LED: First value for
+		color red; Second value for color green; Third value for
+		color blue and fourth value for color amber.
+		for color red:
+
+		0 - The color is turned off.
+		1 - the color is turned on.
+
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2a1070543391..f38fbd97f33d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1076,6 +1076,20 @@ config INTEL_SCU_IPC_UTIL
 
 source "drivers/platform/x86/siemens/Kconfig"
 
+config SILICOM_PLATFORM
+	tristate "Silicom Edge Networking device support"
+	depends on HWMON
+	select LEDS_CLASS_MULTICOLOR
+	help
+	  This option enables support for the LEDs/GPIO/etc downstream of the
+	  embedded controller on Silicom "Cordoba" hardware and derivatives.
+
+	  This platform driver provides support for various functions via
+	  the Linux LED framework, GPIO framework, Hardware Monitoring (HWMON)
+	  and device attributes.
+
+	  If you have a Silicom network appliance, say Y or M here.
+
 config WINMATE_FM07_KEYS
 	tristate "Winmate FM07/FM07P front-panel keys driver"
 	depends on INPUT
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index b457de5abf7d..8fdb0c7d8ca1 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -133,6 +133,9 @@ obj-$(CONFIG_X86_INTEL_LPSS)		+= pmc_atom.o
 # Siemens Simatic Industrial PCs
 obj-$(CONFIG_SIEMENS_SIMATIC_IPC)	+= siemens/
 
+# Silicom
+obj-$(CONFIG_SILICOM_PLATFORM)		+= silicom-platform.o
+
 # Winmate
 obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
 
diff --git a/drivers/platform/x86/silicom-platform.c b/drivers/platform/x86/silicom-platform.c
new file mode 100644
index 000000000000..659fce6584f0
--- /dev/null
+++ b/drivers/platform/x86/silicom-platform.c
@@ -0,0 +1,1010 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// silicom-platform.c - Silicom MEC170x platform driver
+//
+// Copyright (C) 2023 Henry Shi <henrys@silicom-usa.com>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/dmi.h>
+#include <linux/hwmon.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/units.h>
+
+#include <linux/gpio/driver.h>
+
+#define MEC_POWER_CYCLE_ADDR 0x24
+#define MEC_EFUSE_LSB_ADDR   0x28
+#define MEC_GPIO_IN_POS      0x08
+#define MEC_IO_BASE          0x0800
+#define MEC_IO_LEN           0x8
+#define IO_REG_BANK          0x0
+#define DEFAULT_CHAN_LO      0
+#define DEFAULT_CHAN_HI      0
+#define DEFAULT_CHAN_LO_T    0xc
+#define MEC_ADDR             ((MEC_IO_BASE) + 0x02)
+#define EC_ADDR_LSB          MEC_ADDR
+#define SILICOM_MEC_MAGIC    0x5a
+
+#define MEC_PORT_CHANNEL_MASK GENMASK(2, 0)
+#define MEC_PORT_DWORD_OFFSET GENMASK(31, 3)
+#define MEC_DATA_OFFSET_MASK  GENMASK(1, 0)
+#define MEC_PORT_OFFSET_MASK  GENMASK(7, 2)
+
+#define MEC_TEMP_LOC          GENMASK(31, 16)
+#define MEC_VERSION_LOC       GENMASK(15, 8)
+#define MEC_VERSION_MAJOR     GENMASK(15, 14)
+#define MEC_VERSION_MINOR     GENMASK(13, 8)
+
+#define EC_ADDR_MSB           ((MEC_IO_BASE) + 0x3)
+#define MEC_DATA_OFFSET(offset) ((MEC_IO_BASE) + 0x04 + offset)
+
+#define OFFSET_BIT_TO_CHANNEL(off, bit) ((((off) + 0x014) << 3) | (bit))
+#define CHANNEL_TO_OFFSET(chan) (((chan) >> 3) - 0x14)
+
+static DEFINE_MUTEX(mec_io_mutex);
+static unsigned int efuse_status;
+static unsigned int mec_uc_version;
+static unsigned int power_cycle;
+
+static const struct hwmon_channel_info *silicom_fan_control_info[] = {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_LABEL),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
+	NULL
+};
+
+struct silicom_platform_info {
+	int io_base;
+	int io_len;
+	struct led_classdev_mc *led_info;
+	struct gpio_chip *gpiochip;
+	u8 *gpio_channels;
+	u16 ngpio;
+};
+
+static const char * const plat_0222_gpio_names[] = {
+	"AUTOM0_SFP_TX_FAULT",
+	"SLOT2_LED_OUT",
+	"SIM_M2_SLOT2_B_DET",
+	"SIM_M2_SLOT2_A_DET",
+	"SLOT1_LED_OUT",
+	"SIM_M2_SLOT1_B_DET",
+	"SIM_M2_SLOT1_A_DET",
+	"SLOT0_LED_OUT",
+	"WAN_SFP0_RX_LOS",
+	"WAN_SFP0_PRSNT_N",
+	"WAN_SFP0_TX_FAULT",
+	"AUTOM1_SFP_RX_LOS",
+	"AUTOM1_SFP_PRSNT_N",
+	"AUTOM1_SFP_TX_FAULT",
+	"AUTOM0_SFP_RX_LOS",
+	"AUTOM0_SFP_PRSNT_N",
+	"WAN_SFP1_RX_LOS",
+	"WAN_SFP1_PRSNT_N",
+	"WAN_SFP1_TX_FAULT",
+	"SIM_M2_SLOT1_MUX_SEL",
+	"W_DISABLE_M2_SLOT1_N",
+	"W_DISABLE_MPCIE_SLOT0_N",
+	"W_DISABLE_M2_SLOT0_N",
+	"BT_COMMAND_MODE",
+	"WAN_SFP1_TX_DISABLE",
+	"WAN_SFP0_TX_DISABLE",
+	"AUTOM1_SFP_TX_DISABLE",
+	"AUTOM0_SFP_TX_DISABLE",
+	"SIM_M2_SLOT2_MUX_SEL",
+	"W_DISABLE_M2_SLOT2_N",
+	"RST_CTL_M2_SLOT_1_N",
+	"RST_CTL_M2_SLOT_2_N",
+	"PM_USB_PWR_EN_BOT",
+	"PM_USB_PWR_EN_TOP",
+};
+
+static u8 plat_0222_gpio_channels[] = {
+	OFFSET_BIT_TO_CHANNEL(0x00, 0),
+	OFFSET_BIT_TO_CHANNEL(0x00, 1),
+	OFFSET_BIT_TO_CHANNEL(0x00, 2),
+	OFFSET_BIT_TO_CHANNEL(0x00, 3),
+	OFFSET_BIT_TO_CHANNEL(0x00, 4),
+	OFFSET_BIT_TO_CHANNEL(0x00, 5),
+	OFFSET_BIT_TO_CHANNEL(0x00, 6),
+	OFFSET_BIT_TO_CHANNEL(0x00, 7),
+	OFFSET_BIT_TO_CHANNEL(0x01, 0),
+	OFFSET_BIT_TO_CHANNEL(0x01, 1),
+	OFFSET_BIT_TO_CHANNEL(0x01, 2),
+	OFFSET_BIT_TO_CHANNEL(0x01, 3),
+	OFFSET_BIT_TO_CHANNEL(0x01, 4),
+	OFFSET_BIT_TO_CHANNEL(0x01, 5),
+	OFFSET_BIT_TO_CHANNEL(0x01, 6),
+	OFFSET_BIT_TO_CHANNEL(0x01, 7),
+	OFFSET_BIT_TO_CHANNEL(0x02, 0),
+	OFFSET_BIT_TO_CHANNEL(0x02, 1),
+	OFFSET_BIT_TO_CHANNEL(0x02, 2),
+	OFFSET_BIT_TO_CHANNEL(0x09, 0),
+	OFFSET_BIT_TO_CHANNEL(0x09, 1),
+	OFFSET_BIT_TO_CHANNEL(0x09, 2),
+	OFFSET_BIT_TO_CHANNEL(0x09, 3),
+	OFFSET_BIT_TO_CHANNEL(0x0a, 0),
+	OFFSET_BIT_TO_CHANNEL(0x0a, 1),
+	OFFSET_BIT_TO_CHANNEL(0x0a, 2),
+	OFFSET_BIT_TO_CHANNEL(0x0a, 3),
+	OFFSET_BIT_TO_CHANNEL(0x0a, 4),
+	OFFSET_BIT_TO_CHANNEL(0x0a, 5),
+	OFFSET_BIT_TO_CHANNEL(0x0a, 6),
+	OFFSET_BIT_TO_CHANNEL(0x0b, 0),
+	OFFSET_BIT_TO_CHANNEL(0x0b, 1),
+	OFFSET_BIT_TO_CHANNEL(0x0b, 2),
+	OFFSET_BIT_TO_CHANNEL(0x0b, 3),
+};
+
+static struct platform_device *silicom_platform_dev;
+static struct led_classdev_mc *silicom_led_info __initdata;
+static struct gpio_chip *silicom_gpiochip __initdata;
+static u8 *silicom_gpio_channels __initdata;
+
+static int silicom_mec_port_get(unsigned int offset)
+{
+	u8 reg;
+	unsigned short mec_data_addr;
+	unsigned short mec_port_addr;
+
+	mec_data_addr = FIELD_GET(MEC_PORT_DWORD_OFFSET, offset) & MEC_DATA_OFFSET_MASK;
+	mec_port_addr = FIELD_GET(MEC_PORT_DWORD_OFFSET, offset) & MEC_PORT_OFFSET_MASK;
+
+	mutex_lock(&mec_io_mutex);
+	outb(mec_port_addr, MEC_ADDR);
+	reg = inb(MEC_DATA_OFFSET(mec_data_addr));
+	mutex_unlock(&mec_io_mutex);
+
+	return (reg >> (offset & MEC_PORT_CHANNEL_MASK)) & 0x01;
+}
+
+static enum led_brightness silicom_mec_led_get(int channel)
+{
+	/* Outputs are active low */
+	return silicom_mec_port_get(channel) ? LED_OFF : LED_ON;
+}
+
+static void silicom_mec_port_set(int channel, int on)
+{
+	u8 reg;
+	unsigned short mec_data_addr;
+	unsigned short mec_port_addr;
+
+	mec_data_addr = FIELD_GET(MEC_PORT_DWORD_OFFSET, channel) & MEC_DATA_OFFSET_MASK;
+	mec_port_addr = FIELD_GET(MEC_PORT_DWORD_OFFSET, channel) & MEC_PORT_OFFSET_MASK;
+
+	mutex_lock(&mec_io_mutex);
+	outb(mec_port_addr, MEC_ADDR);
+	reg = inb(MEC_DATA_OFFSET(mec_data_addr));
+	/* Outputs are active low, so clear the bit for on, or set it for off */
+	if (on)
+		reg &= ~(1 << (channel & MEC_PORT_CHANNEL_MASK));
+	else
+		reg |= 1 << (channel & MEC_PORT_CHANNEL_MASK);
+	outb(reg, MEC_DATA_OFFSET(mec_data_addr));
+	mutex_unlock(&mec_io_mutex);
+}
+
+static enum led_brightness silicom_mec_led_mc_brightness_get(struct led_classdev *led_cdev)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
+	enum led_brightness brightness = LED_OFF;
+	int i;
+
+	for (i = 0; i < mc_cdev->num_colors; i++) {
+		mc_cdev->subled_info[i].brightness =
+			silicom_mec_led_get(mc_cdev->subled_info[i].channel);
+		/* Mark the overall brightness as LED_ON if any of the subleds are on */
+		if (mc_cdev->subled_info[i].brightness != LED_OFF)
+			brightness = LED_ON;
+	}
+
+	return brightness;
+}
+
+static void silicom_mec_led_mc_brightness_set(struct led_classdev *led_cdev,
+					      enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
+	int i;
+
+	led_mc_calc_color_components(mc_cdev, brightness);
+	for (i = 0; i < mc_cdev->num_colors; i++) {
+		silicom_mec_port_set(mc_cdev->subled_info[i].channel,
+		mc_cdev->subled_info[i].brightness);
+	}
+}
+
+static int silicom_gpio_get_direction(struct gpio_chip *gc,
+				      unsigned int offset)
+{
+	u8 *channels = gpiochip_get_data(gc);
+
+	/* Input registers have offsets between [0x00, 0x07] */
+	if (CHANNEL_TO_OFFSET(channels[offset]) < MEC_GPIO_IN_POS)
+		return GPIO_LINE_DIRECTION_IN;
+
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int silicom_gpio_direction_input(struct gpio_chip *gc,
+					unsigned int offset)
+{
+	int direction = silicom_gpio_get_direction(gc, offset);
+
+	return direction == GPIO_LINE_DIRECTION_IN ? 0 : -EINVAL;
+}
+
+static void silicom_gpio_set(struct gpio_chip *gc,
+			     unsigned int offset,
+			     int value)
+{
+	u8 *channels = gpiochip_get_data(gc);
+	int direction = silicom_gpio_get_direction(gc, offset);
+	int channel = channels[offset];
+
+	if (direction == GPIO_LINE_DIRECTION_IN)
+		return;
+
+	if (value)
+		silicom_mec_port_set(channel, 0);
+	else if (value == 0)
+		silicom_mec_port_set(channel, 1);
+	else
+		pr_err("Wrong argument value: %d\n", value);
+}
+
+static int silicom_gpio_direction_output(struct gpio_chip *gc,
+					 unsigned int offset,
+					 int value)
+{
+	int direction = silicom_gpio_get_direction(gc, offset);
+
+	if (direction == GPIO_LINE_DIRECTION_IN)
+		return -EINVAL;
+
+	silicom_gpio_set(gc, offset, value);
+
+	return 0;
+}
+
+static int silicom_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	u8 *channels = gpiochip_get_data(gc);
+	int channel = channels[offset];
+
+	return silicom_mec_port_get(channel);
+}
+
+static struct mc_subled plat_0222_wan_mc_subled_info[] __initdata = {
+	{
+		.color_index = LED_COLOR_ID_WHITE,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 7),
+	},
+	{
+		.color_index = LED_COLOR_ID_YELLOW,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 6),
+	},
+	{
+		.color_index = LED_COLOR_ID_RED,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 5),
+	},
+};
+
+static struct mc_subled plat_0222_sys_mc_subled_info[] __initdata = {
+	{
+		.color_index = LED_COLOR_ID_WHITE,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 4),
+	},
+	{
+		.color_index = LED_COLOR_ID_AMBER,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 3),
+	},
+	{
+		.color_index = LED_COLOR_ID_RED,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 2),
+	},
+};
+
+static struct mc_subled plat_0222_stat1_mc_subled_info[] __initdata = {
+	{
+		.color_index = LED_COLOR_ID_RED,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 1),
+	},
+	{
+		.color_index = LED_COLOR_ID_GREEN,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 0),
+	},
+	{
+		.color_index = LED_COLOR_ID_BLUE,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 7),
+	},
+	{
+		.color_index = LED_COLOR_ID_YELLOW,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 6),
+	},
+};
+
+static struct mc_subled plat_0222_stat2_mc_subled_info[] __initdata = {
+	{
+		.color_index = LED_COLOR_ID_RED,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 5),
+	},
+	{
+		.color_index = LED_COLOR_ID_GREEN,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 4),
+	},
+	{
+		.color_index = LED_COLOR_ID_BLUE,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 3),
+	},
+	{
+		.color_index = LED_COLOR_ID_YELLOW,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 2),
+	},
+};
+
+static struct mc_subled plat_0222_stat3_mc_subled_info[] __initdata = {
+	{
+		.color_index = LED_COLOR_ID_RED,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 1),
+	},
+	{
+		.color_index = LED_COLOR_ID_GREEN,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 0),
+	},
+	{
+		.color_index = LED_COLOR_ID_BLUE,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0e, 1),
+	},
+	{
+		.color_index = LED_COLOR_ID_YELLOW,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x0e, 0),
+	},
+};
+
+static struct led_classdev_mc plat_0222_mc_led_info[] __initdata = {
+	{
+		.led_cdev = {
+			.name = "multicolor:wan",
+			.brightness = 0,
+			.max_brightness = 1,
+			.brightness_set = silicom_mec_led_mc_brightness_set,
+			.brightness_get = silicom_mec_led_mc_brightness_get,
+		},
+		.num_colors = ARRAY_SIZE(plat_0222_wan_mc_subled_info),
+		.subled_info = plat_0222_wan_mc_subled_info,
+	},
+	{
+		.led_cdev = {
+			.name = "multicolor:sys",
+			.brightness = 0,
+			.max_brightness = 1,
+			.brightness_set = silicom_mec_led_mc_brightness_set,
+			.brightness_get = silicom_mec_led_mc_brightness_get,
+		},
+		.num_colors = ARRAY_SIZE(plat_0222_sys_mc_subled_info),
+		.subled_info = plat_0222_sys_mc_subled_info,
+	},
+	{
+		.led_cdev = {
+			.name = "multicolor:stat1",
+			.brightness = 0,
+			.max_brightness = 1,
+			.brightness_set = silicom_mec_led_mc_brightness_set,
+			.brightness_get = silicom_mec_led_mc_brightness_get,
+		},
+		.num_colors = ARRAY_SIZE(plat_0222_stat1_mc_subled_info),
+		.subled_info = plat_0222_stat1_mc_subled_info,
+	},
+	{
+		.led_cdev = {
+			.name = "multicolor:stat2",
+			.brightness = 0,
+			.max_brightness = 1,
+			.brightness_set = silicom_mec_led_mc_brightness_set,
+			.brightness_get = silicom_mec_led_mc_brightness_get,
+		},
+		.num_colors = ARRAY_SIZE(plat_0222_stat2_mc_subled_info),
+		.subled_info = plat_0222_stat2_mc_subled_info,
+	},
+	{
+		.led_cdev = {
+			.name = "multicolor:stat3",
+			.brightness = 0,
+			.max_brightness = 1,
+			.brightness_set = silicom_mec_led_mc_brightness_set,
+			.brightness_get = silicom_mec_led_mc_brightness_get,
+		},
+		.num_colors = ARRAY_SIZE(plat_0222_stat3_mc_subled_info),
+		.subled_info = plat_0222_stat3_mc_subled_info,
+	},
+	{ },
+};
+
+static struct gpio_chip silicom_gpio_chip = {
+	.label = "silicom-gpio",
+	.get_direction = silicom_gpio_get_direction,
+	.direction_input = silicom_gpio_direction_input,
+	.direction_output = silicom_gpio_direction_output,
+	.get = silicom_gpio_get,
+	.set = silicom_gpio_set,
+	.base = -1,
+	.ngpio = ARRAY_SIZE(plat_0222_gpio_channels),
+	.names = plat_0222_gpio_names,
+	/*
+	 * We're using a mutex to protect the indirect access, so we can sleep
+	 * if the lock blocks
+	 */
+	.can_sleep = true,
+};
+
+static struct silicom_platform_info silicom_plat_0222_cordoba_info __initdata = {
+	.io_base = MEC_IO_BASE,
+	.io_len = MEC_IO_LEN,
+	.led_info = plat_0222_mc_led_info,
+	.gpiochip = &silicom_gpio_chip,
+	.gpio_channels = plat_0222_gpio_channels,
+	/*
+	 * The original generic cordoba does not have the last 4 outputs of the
+	 * plat_0222 variant, the rest are the same, so use the same longer list,
+	 * but ignore the last entries here
+	 */
+	.ngpio = ARRAY_SIZE(plat_0222_gpio_channels),
+
+};
+
+static struct mc_subled cordoba_fp_left_mc_subled_info[] __initdata = {
+	{
+		.color_index = LED_COLOR_ID_RED,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 6),
+	},
+	{
+		.color_index = LED_COLOR_ID_GREEN,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 5),
+	},
+	{
+		.color_index = LED_COLOR_ID_BLUE,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x09, 7),
+	},
+	{
+		.color_index = LED_COLOR_ID_AMBER,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x09, 4),
+	},
+};
+
+static struct mc_subled cordoba_fp_center_mc_subled_info[] __initdata = {
+	{
+		.color_index = LED_COLOR_ID_RED,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 7),
+	},
+	{
+		.color_index = LED_COLOR_ID_GREEN,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 4),
+	},
+	{
+		.color_index = LED_COLOR_ID_BLUE,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 3),
+	},
+	{
+		.color_index = LED_COLOR_ID_AMBER,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x09, 6),
+	},
+};
+
+static struct mc_subled cordoba_fp_right_mc_subled_info[] __initdata = {
+	{
+		.color_index = LED_COLOR_ID_RED,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 2),
+	},
+	{
+		.color_index = LED_COLOR_ID_GREEN,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 1),
+	},
+	{
+		.color_index = LED_COLOR_ID_BLUE,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 0),
+	},
+	{
+		.color_index = LED_COLOR_ID_AMBER,
+		.brightness = 1,
+		.intensity = 0,
+		.channel = OFFSET_BIT_TO_CHANNEL(0x09, 5),
+	},
+};
+
+static struct led_classdev_mc cordoba_mc_led_info[] __initdata = {
+	{
+		.led_cdev = {
+			.name = "multicolor:fp_left",
+			.brightness = 0,
+			.max_brightness = 1,
+			.brightness_set = silicom_mec_led_mc_brightness_set,
+			.brightness_get = silicom_mec_led_mc_brightness_get,
+		},
+		.num_colors = ARRAY_SIZE(cordoba_fp_left_mc_subled_info),
+		.subled_info = cordoba_fp_left_mc_subled_info,
+	},
+	{
+		.led_cdev = {
+			.name = "multicolor:fp_center",
+			.brightness = 0,
+			.max_brightness = 1,
+			.brightness_set = silicom_mec_led_mc_brightness_set,
+			.brightness_get = silicom_mec_led_mc_brightness_get,
+		},
+		.num_colors = ARRAY_SIZE(cordoba_fp_center_mc_subled_info),
+		.subled_info = cordoba_fp_center_mc_subled_info,
+	},
+	{
+		.led_cdev = {
+			.name = "multicolor:fp_right",
+			.brightness = 0,
+			.max_brightness = 1,
+			.brightness_set = silicom_mec_led_mc_brightness_set,
+			.brightness_get = silicom_mec_led_mc_brightness_get,
+		},
+		.num_colors = ARRAY_SIZE(cordoba_fp_right_mc_subled_info),
+		.subled_info = cordoba_fp_right_mc_subled_info,
+	},
+	{ },
+};
+
+static struct silicom_platform_info silicom_generic_cordoba_info __initdata = {
+	.io_base = MEC_IO_BASE,
+	.io_len = MEC_IO_LEN,
+	.led_info = cordoba_mc_led_info,
+	.gpiochip = &silicom_gpio_chip,
+	.gpio_channels = plat_0222_gpio_channels,
+	.ngpio = ARRAY_SIZE(plat_0222_gpio_channels),
+};
+
+/*
+ * sysfs interface
+ */
+static ssize_t efuse_status_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	u32 reg;
+
+	mutex_lock(&mec_io_mutex);
+	/* Select memory region */
+	outb(IO_REG_BANK, EC_ADDR_MSB);
+	outb(MEC_EFUSE_LSB_ADDR, EC_ADDR_LSB);
+
+	/* Get current data from the address */
+	reg = inl(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
+	mutex_unlock(&mec_io_mutex);
+
+	efuse_status = reg & 0x1;
+
+	return sysfs_emit(buf, "%u\n", efuse_status);
+}
+static DEVICE_ATTR_RO(efuse_status);
+
+static ssize_t uc_version_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	u32 reg;
+	int uc_version;
+
+	mutex_lock(&mec_io_mutex);
+	outb(IO_REG_BANK, EC_ADDR_MSB);
+	outb(DEFAULT_CHAN_LO, EC_ADDR_LSB);
+
+	reg = inl(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
+	mutex_unlock(&mec_io_mutex);
+	uc_version = FIELD_GET(MEC_VERSION_LOC, reg);
+	if (uc_version >= 192)
+		return -EINVAL;
+
+	uc_version = FIELD_GET(MEC_VERSION_MAJOR, reg) * 100 +
+		     FIELD_GET(MEC_VERSION_MINOR, reg);
+
+	mec_uc_version = uc_version;
+
+	return sysfs_emit(buf, "%u\n", mec_uc_version);
+}
+static DEVICE_ATTR_RO(uc_version);
+
+static ssize_t power_cycle_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	return sysfs_emit(buf, "%u\n", power_cycle);
+}
+
+static void powercycle_uc(void)
+{
+	mutex_lock(&mec_io_mutex);
+	/* Select memory region */
+	outb(IO_REG_BANK, EC_ADDR_MSB);
+	outb(MEC_POWER_CYCLE_ADDR, EC_ADDR_LSB);
+
+	/* Set to 1 for current data from the address */
+	outb(1, MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
+	mutex_unlock(&mec_io_mutex);
+}
+
+static ssize_t power_cycle_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	int rc;
+
+	rc = kstrtou32(buf, 0, &power_cycle);
+	if (rc)
+		return -EINVAL;
+
+	if (power_cycle > 0)
+		powercycle_uc();
+
+	return count;
+}
+static DEVICE_ATTR_RW(power_cycle);
+
+static struct attribute *silicom_attrs[] = {
+	&dev_attr_efuse_status.attr,
+	&dev_attr_uc_version.attr,
+	&dev_attr_power_cycle.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(silicom);
+
+static struct platform_driver silicom_platform_driver = {
+	.driver = {
+		.name = "silicom-platform",
+		.dev_groups = silicom_groups,
+	},
+};
+
+static int __init silicom_mc_leds_register(struct device *dev,
+					   const struct led_classdev_mc *mc_leds)
+{
+	struct led_classdev_mc *led;
+	int i, err;
+	int size = sizeof(struct mc_subled);
+
+	for (i = 0; mc_leds[i].led_cdev.name; i++) {
+
+		led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
+		if (!led)
+			return -ENOMEM;
+		memcpy(led, &mc_leds[i], sizeof(*led));
+
+		led->subled_info = devm_kzalloc(dev, led->num_colors * size, GFP_KERNEL);
+		if (!led->subled_info)
+			return -ENOMEM;
+		memcpy(led->subled_info, mc_leds[i].subled_info, led->num_colors * size);
+
+		err = devm_led_classdev_multicolor_register(dev, led);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static u32 rpm_get(void)
+{
+	u32 reg;
+
+	mutex_lock(&mec_io_mutex);
+	/* Select memory region */
+	outb(IO_REG_BANK, EC_ADDR_MSB);
+	outb(DEFAULT_CHAN_LO_T, EC_ADDR_LSB);
+	reg = inw(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
+	mutex_unlock(&mec_io_mutex);
+
+	return reg;
+}
+
+static u32 temp_get(void)
+{
+	u32 reg;
+
+	mutex_lock(&mec_io_mutex);
+	/* Select memory region */
+	outb(IO_REG_BANK, EC_ADDR_MSB);
+	outb(DEFAULT_CHAN_LO_T, EC_ADDR_LSB);
+	reg = inl(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
+	mutex_unlock(&mec_io_mutex);
+
+	return FIELD_GET(MEC_TEMP_LOC, reg) * 100;
+}
+
+static umode_t silicom_fan_control_fan_is_visible(const u32 attr)
+{
+	switch (attr) {
+	case hwmon_fan_input:
+	case hwmon_fan_label:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static umode_t silicom_fan_control_temp_is_visible(const u32 attr)
+{
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_label:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static int silicom_fan_control_read_fan(struct device *dev, u32 attr, long *val)
+{
+	switch (attr) {
+	case hwmon_fan_input:
+		*val = rpm_get();
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int silicom_fan_control_read_temp(struct device *dev, u32 attr, long *val)
+{
+	switch (attr) {
+	case hwmon_temp_input:
+		*val = temp_get();
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t silicom_fan_control_is_visible(const void *data,
+					      enum hwmon_sensor_types type,
+					      u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_fan:
+		return silicom_fan_control_fan_is_visible(attr);
+	case hwmon_temp:
+		return silicom_fan_control_temp_is_visible(attr);
+	default:
+		return 0;
+	}
+}
+
+static int silicom_fan_control_read(struct device *dev,
+				    enum hwmon_sensor_types type,
+				    u32 attr, int channel,
+				    long *val)
+{
+	switch (type) {
+	case hwmon_fan:
+		return silicom_fan_control_read_fan(dev, attr, val);
+	case hwmon_temp:
+		return silicom_fan_control_read_temp(dev, attr, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int silicom_fan_control_read_labels(struct device *dev,
+					   enum hwmon_sensor_types type,
+					   u32 attr, int channel,
+					   const char **str)
+{
+	switch (type) {
+	case hwmon_fan:
+		*str = "Silicom_platfomr: Fan Speed";
+		return 0;
+	case hwmon_temp:
+		*str = "Silicom_platform: Thermostat Sensor";
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_ops silicom_fan_control_hwmon_ops = {
+	.is_visible = silicom_fan_control_is_visible,
+	.read = silicom_fan_control_read,
+	.read_string = silicom_fan_control_read_labels,
+};
+
+static const struct hwmon_chip_info silicom_chip_info = {
+	.ops = &silicom_fan_control_hwmon_ops,
+	.info = silicom_fan_control_info,
+};
+
+static int __init silicom_platform_probe(struct platform_device *device)
+{
+	int err;
+	u8 magic, ver;
+	struct device *hwmon_dev;
+	const char *name = "Silocom_Fan_Monitor";
+
+	if (!devm_request_region(&device->dev, MEC_IO_BASE, MEC_IO_LEN, "mec")) {
+		dev_err(&device->dev, "couldn't reserve MEC io ports\n");
+		return -EBUSY;
+	}
+
+	/* Sanity check magic number read for EC */
+	outb(IO_REG_BANK, MEC_ADDR);
+	magic = inb(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
+	ver = inb(MEC_DATA_OFFSET(DEFAULT_CHAN_HI));
+	dev_dbg(&device->dev, "EC magic 0x%02x, version 0x%02x\n", magic, ver);
+
+	if (magic != SILICOM_MEC_MAGIC) {
+		dev_err(&device->dev, "Bad EC magic 0x%02x!\n", magic);
+		return -ENODEV;
+	}
+
+	err = silicom_mc_leds_register(&device->dev, silicom_led_info);
+	if (err) {
+		dev_err(&device->dev, "Failed to register LEDs\n");
+		return err;
+	}
+
+	err = devm_gpiochip_add_data(&device->dev, silicom_gpiochip,
+				     silicom_gpio_channels);
+	if (err) {
+		dev_err(&device->dev, "Failed to register gpiochip: %d\n", err);
+		return err;
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&device->dev, name, NULL,
+							 &silicom_chip_info, NULL);
+	err = PTR_ERR_OR_ZERO(hwmon_dev);
+	if (err) {
+		dev_err(&device->dev, "Failed to register hwmon_dev: %d\n", err);
+		return err;
+	}
+
+	return err;
+}
+
+static int __init silicom_platform_info_init(const struct dmi_system_id *id)
+{
+	struct silicom_platform_info *info = id->driver_data;
+
+	silicom_led_info = info->led_info;
+	silicom_gpio_channels = info->gpio_channels;
+	silicom_gpiochip = info->gpiochip;
+	silicom_gpiochip->ngpio = info->ngpio;
+
+	return 1;
+}
+
+static const struct dmi_system_id silicom_dmi_ids[] __initconst = {
+	{
+		.callback = silicom_platform_info_init,
+		.ident = "Silicom Cordoba (Generic)",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Silicom"),
+			DMI_MATCH(DMI_BOARD_NAME, "80300-0214-G"),
+		},
+		.driver_data = &silicom_generic_cordoba_info,
+	},
+	{
+		.callback = silicom_platform_info_init,
+		.ident = "Silicom Cordoba (Generic)",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Silicom"),
+			DMI_MATCH(DMI_BOARD_NAME, "80500-0214-G"),
+		},
+		.driver_data = &silicom_generic_cordoba_info,
+	},
+	{
+		 .callback = silicom_platform_info_init,
+		 .ident = "Silicom Cordoba (plat_0222)",
+		 .matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Silicom"),
+			DMI_MATCH(DMI_BOARD_NAME, "80300-0222-G"),
+		 },
+		.driver_data = &silicom_plat_0222_cordoba_info,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(dmi, silicom_dmi_ids);
+
+static int __init silicom_platform_init(void)
+{
+	if (!dmi_check_system(silicom_dmi_ids)) {
+		pr_err("No DMI match for this platform\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Create and register a platform device.
+	 * Directly probe the platform driver in init since this isn't a
+	 * hotpluggable device.  That means we don't need to register a driver
+	 * that needs to wait around in memory on the chance a matching device
+	 * would get added.  Instead run once in __init so that we can free all
+	 * those resources when the __init region is wiped
+	 */
+	silicom_platform_dev = platform_create_bundle(&silicom_platform_driver,
+						      silicom_platform_probe,
+						      NULL, 0, NULL, 0);
+
+	return PTR_ERR_OR_ZERO(silicom_platform_dev);
+}
+
+static void __exit silicom_platform_exit(void)
+{
+	platform_device_unregister(silicom_platform_dev);
+	platform_driver_unregister(&silicom_platform_driver);
+}
+
+module_init(silicom_platform_init);
+module_exit(silicom_platform_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Henry Shi <henrys@silicom-usa.com>");
+MODULE_DESCRIPTION("Platform driver for Silicom network appliances");
-- 
2.21.3

