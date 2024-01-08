Return-Path: <linux-kernel+bounces-19715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7D08271A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DAF1F23429
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF34245979;
	Mon,  8 Jan 2024 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="fgSCEqwy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AhYq/1qB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D850446458;
	Mon,  8 Jan 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id BA2445C10FA;
	Mon,  8 Jan 2024 09:41:18 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Mon, 08 Jan 2024 09:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1704724878; x=1704811278; bh=jxpUndgcSr
	PAjNB5IbGDCYp/28ALE4Bz3ix1d/S78XI=; b=fgSCEqwyjuUb5vcguklMJ9K0IN
	HlcTy7fzapjDVGuskI2dOsHepARExofVZrezegK5uxmXN/B9/L/zQhYHrfvbxiNZ
	t3/uG/gIg1yJEcOjBswU37++1jhdqh+0z4VV461G4V1fFHjX1IFEh7lHfZpEirC6
	Hq3sFOoRaUHJko/e+Q+nEP0/bnowSVJMtUkzrBNhpC3K+7QZYob+91ddW5Jpmfmu
	2zB0pUlmgB8UJe8PgZgjojwVDE3dFR8f/XP3LH46LZaj1cIBwTx7IByKNQ8f4zgF
	l9zgH/UGODbq6sGAVy6A5SBhrKK+JXVBT2bz7LSCvGsWanVZTOg+OUwXOU4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704724878; x=1704811278; bh=jxpUndgcSrPAjNB5IbGDCYp/28AL
	E4Bz3ix1d/S78XI=; b=AhYq/1qBMTrccPzhRdPHR2spV2e3QCrWzujC0USQUZm4
	ChbUzoQJq60Ygzm3cl0E7DcQJWjudSpYr8ymiG+b9VMTfrLawESCevTPdsfVxzS3
	EjXQUzWbdiQOt0tzhpQDCf0HYj3UVkAvWPq92XISSD74oKBEyoQOiRfHK8XAbb5z
	teeHTsAOB9ZVVdZVMlTZ2rQTvox+jBCx/5cm4WfSaA8nUk1W9REdun4qoAVBgbwV
	vM8xQHlljujATTDsBsDZeyaaqE4nWDc38tjvzrvmXdTr44iOIgP4BlabaYWw3z5+
	46BNhassF974enW5IFPHk2BEz3VSWMDrB9tVJbB1Qg==
X-ME-Sender: <xms:jgmcZZdIfPTbO06AXXa3NMH1gZX3lvg7f5kcbHo-07axmFSI2W0HLA>
    <xme:jgmcZXOuTOfu8TYLX3gP4MwYwx0f9nB4RE6jC3pbk-WQ1lts2A7wVLvMyxtFgr6UB
    9aihhWyKIw-nXsfkbY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtsehttdertderredtnecuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmph
    gvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhn
    pefgtdelledufeeikedvheefleevtdfgkedtgedtleffgfeugeeltdeileefueeuhfenuc
    ffohhmrghinheplhgruhhntghhphgrugdrnhgvthdpshhouhhrtggvfhhorhhgvgdrnhgv
    thdpthhhihhnkhifihhkihdrohhrghdpohhrrdgtiidpshhfrdhnvghtnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhl
    vghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:jgmcZSjxxeMBGYKn8yNVToJkkyT_fKzdylmnmvno248bNdhXSsiq6w>
    <xmx:jgmcZS8KtRdDeuGkfM24yrS8kAOBF0NhPz5nq6XfG1nDkUDKu94OtA>
    <xmx:jgmcZVtU0yDDgXFhu2fXT4XM6BWa8I1GQzqXAPHj9ell0TYccb7xjw>
    <xmx:jgmcZW-7WnJdPdj3qC5oLwOzRCliQ-XapaeRuIG2br07ttDakkBkOA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3964BC63EC8; Mon,  8 Jan 2024 09:41:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ebab9f05-c887-43b4-a040-fa178fdc7b0a@app.fastmail.com>
In-Reply-To: <063131aa-1945-45bd-ba35-e47ff6ea7820@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20240104003726.21277-1-mpearson-lenovo@squebb.ca>
 <063131aa-1945-45bd-ba35-e47ff6ea7820@redhat.com>
Date: Mon, 08 Jan 2024 09:40:57 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Hans de Goede" <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 corbet@lwn.net, "markgross@kernel.org" <markgross@kernel.org>,
 ike.pan@canonical.com, "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 linux-doc@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] platform/x86: Lenovo sub directory
Content-Type: text/plain

Thanks for the review Hans,

On Mon, Jan 8, 2024, at 9:17 AM, Hans de Goede wrote:
> Hi Mark,
>
> On 1/4/24 01:37, Mark Pearson wrote:
>> Looking for feedback if this is a good idea or not, and if I've missed
>> anything important.
>> 
>> Over the holidays it was raining and I was bored so I was toying with the
>> idea of moving some of the thinkpad_acpi functionality out of the file
>> into their own modules - the file is a bit of a beast. I'd like to try and
>> get any commonality between thinkpad, ideapad, etc where possible.
>> My plan was to first look at pulling out the platform_profile pieces and
>> then extend to other pieces (fans, temp, sensors, etc).
>> 
>> Doing this will, potentially, create a number of lenovo_xxx files and so it
>> seemed nice to put lenovo stuff in it's own subdirectory (in a similar way
>> to other vendors) before starting the exercise.
>> 
>> This was my attempt to see if it was easy - and it was.
>> 
>> Please let me know:
>> 
>> 1) Is this OK to do, or does it cause any problems?
>
> Moving the lenovo drivers and especially removing the duplicate
> functionality sounds good to me.
>
>> 2) Have I missed anything important?
>
> I have a few small remarks below, other then that this looks good
> to me.
>
>> 3) I don't want to tread on any toes - so if there is protocol to follow
>> with moving files please let me know :) (Or a preferred way to do such an
>> exercise)
>
> No special protocol for moving files.
>
>> 4) I don't have any ideapads to test with. I think this is low risk, but
>> if anybody is able to confirm nothing breaks please let me know.
>
> The moving should definitely be safe. For the refactoring planned on top
> would be good if you can test on some actual hw.
>
>> I will see if I can scrounge some HW from somewhere in the meantime.
>> 
>> I will need to rebase before proposing this officially, so please ignore
>> the fact that this is based off 6.7-rc1 and therefore a bit out of date.
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>>  .../admin-guide/laptops/thinkpad-acpi.rst     |   3 +-
>>  MAINTAINERS                                   |   6 +-
>>  drivers/platform/x86/Kconfig                  | 196 +---------------
>>  drivers/platform/x86/Makefile                 |  10 +-
>>  drivers/platform/x86/lenovo/Kconfig           | 211 ++++++++++++++++++
>>  drivers/platform/x86/lenovo/Makefile          |  13 ++
>>  .../x86/{ => lenovo}/ideapad-laptop.c         |   0
>>  .../x86/{ => lenovo}/ideapad-laptop.h         |   0
>>  .../platform/x86/{ => lenovo}/lenovo-ymc.c    |   0
>>  .../x86/{ => lenovo}/lenovo-yogabook.c        |   0
>>  drivers/platform/x86/{ => lenovo}/think-lmi.c |   2 +-
>>  drivers/platform/x86/{ => lenovo}/think-lmi.h |   0
>>  .../platform/x86/{ => lenovo}/thinkpad_acpi.c |   2 +-
>>  13 files changed, 238 insertions(+), 205 deletions(-)
>>  create mode 100644 drivers/platform/x86/lenovo/Kconfig
>>  create mode 100644 drivers/platform/x86/lenovo/Makefile
>>  rename drivers/platform/x86/{ => lenovo}/ideapad-laptop.c (100%)
>>  rename drivers/platform/x86/{ => lenovo}/ideapad-laptop.h (100%)
>>  rename drivers/platform/x86/{ => lenovo}/lenovo-ymc.c (100%)
>>  rename drivers/platform/x86/{ => lenovo}/lenovo-yogabook.c (100%)
>>  rename drivers/platform/x86/{ => lenovo}/think-lmi.c (99%)
>>  rename drivers/platform/x86/{ => lenovo}/think-lmi.h (100%)
>>  rename drivers/platform/x86/{ => lenovo}/thinkpad_acpi.c (99%)
>> 
>> diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
>> index 98d304010170..55b79ee2bb26 100644
>> --- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
>> +++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
>> @@ -20,7 +20,8 @@ This driver used to be named ibm-acpi until kernel 2.6.21 and release
>>  0.13-20070314.  It used to be in the drivers/acpi tree, but it was
>>  moved to the drivers/misc tree and renamed to thinkpad-acpi for kernel
>>  2.6.22, and release 0.14.  It was moved to drivers/platform/x86 for
>> -kernel 2.6.29 and release 0.22.
>> +kernel 2.6.29 and release 0.22. It was moved to drivers/platform/x86/lenovo
>> +for kernel 6.8.
>
> The 6.8 merge window just opened so this is only going to land in the
> next cycle which will be 6.9 .
No problems.

>
>>  
>>  The driver is named "thinkpad-acpi".  In some places, like module
>>  names and log messages, "thinkpad_acpi" is used because of userspace
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 97f51d5ec1cf..c83ed9a51a44 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10243,7 +10243,7 @@ M:	Ike Panhc <ike.pan@canonical.com>
>>  L:	platform-driver-x86@vger.kernel.org
>>  S:	Maintained
>>  W:	http://launchpad.net/ideapad-laptop
>> -F:	drivers/platform/x86/ideapad-laptop.c
>> +F:	drivers/platform/x86/lenovo/ideapad-laptop.c
>>  
>>  IDEAPAD LAPTOP SLIDEBAR DRIVER
>>  M:	Andrey Moiseev <o2g.org.ru@gmail.com>
>> @@ -21637,14 +21637,14 @@ S:	Maintained
>>  W:	http://ibm-acpi.sourceforge.net
>>  W:	http://thinkwiki.org/wiki/Ibm-acpi
>>  T:	git git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
>> -F:	drivers/platform/x86/thinkpad_acpi.c
>> +F:	drivers/platform/x86/lenovo/thinkpad_acpi.c
>>  
>>  THINKPAD LMI DRIVER
>>  M:	Mark Pearson <markpearson@lenovo.com>
>>  L:	platform-driver-x86@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/ABI/testing/sysfs-class-firmware-attributes
>> -F:	drivers/platform/x86/think-lmi.?
>> +F:	drivers/platform/x86/lenovo/think-lmi.?
>>  
>>  THUNDERBOLT DMA TRAFFIC TEST DRIVER
>>  M:	Isaac Hazan <isaac.hazan@intel.com>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 7e69fdaccdd5..842ced89bd82 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -121,20 +121,6 @@ config GIGABYTE_WMI
>>  	  To compile this driver as a module, choose M here: the module will
>>  	  be called gigabyte-wmi.
>>  
>> -config YOGABOOK
>> -	tristate "Lenovo Yoga Book tablet key driver"
>> -	depends on ACPI_WMI
>> -	depends on INPUT
>> -	depends on I2C
>> -	select LEDS_CLASS
>> -	select NEW_LEDS
>> -	help
>> -	  Say Y here if you want to support the 'Pen' key and keyboard backlight
>> -	  control on the Lenovo Yoga Book tablets.
>> -
>> -	  To compile this driver as a module, choose M here: the module will
>> -	  be called lenovo-yogabook.
>> -
>>  config ACERHDF
>>  	tristate "Acer Aspire One temperature and fan driver"
>>  	depends on ACPI && THERMAL
>> @@ -430,6 +416,7 @@ config WIRELESS_HOTKEY
>>  	 To compile this driver as a module, choose M here: the module will
>>  	 be called wireless-hotkey.
>>  
>> +
>>  config IBM_RTL
>>  	tristate "Device driver to enable PRTL support"
>>  	depends on PCI
>
> stray blank line insertion, please drop this.
Ack

>
>
>> @@ -446,31 +433,6 @@ config IBM_RTL
>>  	 state = 0 (BIOS SMIs on)
>>  	 state = 1 (BIOS SMIs off)
>>  
>> -config IDEAPAD_LAPTOP
>> -	tristate "Lenovo IdeaPad Laptop Extras"
>> -	depends on ACPI
>> -	depends on RFKILL && INPUT
>> -	depends on SERIO_I8042
>> -	depends on BACKLIGHT_CLASS_DEVICE
>> -	depends on ACPI_VIDEO || ACPI_VIDEO = n
>> -	depends on ACPI_WMI || ACPI_WMI = n
>> -	select ACPI_PLATFORM_PROFILE
>> -	select INPUT_SPARSEKMAP
>> -	select NEW_LEDS
>> -	select LEDS_CLASS
>> -	help
>> -	  This is a driver for Lenovo IdeaPad netbooks contains drivers for
>> -	  rfkill switch, hotkey, fan control and backlight control.
>> -
>> -config LENOVO_YMC
>> -	tristate "Lenovo Yoga Tablet Mode Control"
>> -	depends on ACPI_WMI
>> -	depends on INPUT
>> -	select INPUT_SPARSEKMAP
>> -	help
>> -	  This driver maps the Tablet Mode Control switch to SW_TABLET_MODE input
>> -	  events for Lenovo Yoga notebooks.
>> -
>>  config SENSORS_HDAPS
>>  	tristate "Thinkpad Hard Drive Active Protection System (hdaps)"
>>  	depends on INPUT
>> @@ -489,162 +451,10 @@ config SENSORS_HDAPS
>>  	  Say Y here if you have an applicable laptop and want to experience
>>  	  the awesome power of hdaps.
>>  
>> -config THINKPAD_ACPI
>> -	tristate "ThinkPad ACPI Laptop Extras"
>> -	depends on ACPI
>> -	depends on ACPI_BATTERY
>> -	depends on INPUT
>> -	depends on RFKILL || RFKILL = n
>> -	depends on ACPI_VIDEO || ACPI_VIDEO = n
>> -	depends on BACKLIGHT_CLASS_DEVICE
>> -	depends on I2C
>> -	depends on DRM
>> -	select ACPI_PLATFORM_PROFILE
>> -	select DRM_PRIVACY_SCREEN
>> -	select HWMON
>> -	select NVRAM
>> -	select NEW_LEDS
>> -	select LEDS_CLASS
>> -	select LEDS_TRIGGERS
>> -	select LEDS_TRIGGER_AUDIO
>> -	help
>> -	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
>> -	  support for Fn-Fx key combinations, Bluetooth control, video
>> -	  output switching, ThinkLight control, UltraBay eject and more.
>> -	  For more information about this driver see
>> -	  <file:Documentation/admin-guide/laptops/thinkpad-acpi.rst> and
>> -	  <http://ibm-acpi.sf.net/> .
>> -
>> -	  This driver was formerly known as ibm-acpi.
>> -
>> -	  Extra functionality will be available if the rfkill (CONFIG_RFKILL)
>> -	  and/or ALSA (CONFIG_SND) subsystems are available in the kernel.
>> -	  Note that if you want ThinkPad-ACPI to be built-in instead of
>> -	  modular, ALSA and rfkill will also have to be built-in.
>> -
>> -	  If you have an IBM or Lenovo ThinkPad laptop, say Y or M here.
>> -
>> -config THINKPAD_ACPI_ALSA_SUPPORT
>> -	bool "Console audio control ALSA interface"
>> -	depends on THINKPAD_ACPI
>> -	depends on SND
>> -	depends on SND = y || THINKPAD_ACPI = SND
>> -	default y
>> -	help
>> -	  Enables monitoring of the built-in console audio output control
>> -	  (headphone and speakers), which is operated by the mute and (in
>> -	  some ThinkPad models) volume hotkeys.
>> -
>> -	  If this option is enabled, ThinkPad-ACPI will export an ALSA card
>> -	  with a single read-only mixer control, which should be used for
>> -	  on-screen-display feedback purposes by the Desktop Environment.
>> -
>> -	  Optionally, the driver will also allow software control (the
>> -	  ALSA mixer will be made read-write).  Please refer to the driver
>> -	  documentation for details.
>> -
>> -	  All IBM models have both volume and mute control.  Newer Lenovo
>> -	  models only have mute control (the volume hotkeys are just normal
>> -	  keys and volume control is done through the main HDA mixer).
>> -
>> -config THINKPAD_ACPI_DEBUGFACILITIES
>> -	bool "Maintainer debug facilities"
>> -	depends on THINKPAD_ACPI
>> -	help
>> -	  Enables extra stuff in the thinkpad-acpi which is completely useless
>> -	  for normal use.  Read the driver source to find out what it does.
>> -
>> -	  Say N here, unless you were told by a kernel maintainer to do
>> -	  otherwise.
>> -
>> -config THINKPAD_ACPI_DEBUG
>> -	bool "Verbose debug mode"
>> -	depends on THINKPAD_ACPI
>> -	help
>> -	  Enables extra debugging information, at the expense of a slightly
>> -	  increase in driver size.
>> -
>> -	  If you are not sure, say N here.
>> -
>> -config THINKPAD_ACPI_UNSAFE_LEDS
>> -	bool "Allow control of important LEDs (unsafe)"
>> -	depends on THINKPAD_ACPI
>> -	help
>> -	  Overriding LED state on ThinkPads can mask important
>> -	  firmware alerts (like critical battery condition), or misled
>> -	  the user into damaging the hardware (undocking or ejecting
>> -	  the bay while buses are still active), etc.
>> -
>> -	  LED control on the ThinkPad is write-only (with very few
>> -	  exceptions on very ancient models), which makes it
>> -	  impossible to know beforehand if important information will
>> -	  be lost when one changes LED state.
>> -
>> -	  Users that know what they are doing can enable this option
>> -	  and the driver will allow control of every LED, including
>> -	  the ones on the dock stations.
>> -
>> -	  Never enable this option on a distribution kernel.
>> -
>> -	  Say N here, unless you are building a kernel for your own
>> -	  use, and need to control the important firmware LEDs.
>> -
>> -config THINKPAD_ACPI_VIDEO
>> -	bool "Video output control support"
>> -	depends on THINKPAD_ACPI
>> -	default y
>> -	help
>> -	  Allows the thinkpad_acpi driver to provide an interface to control
>> -	  the various video output ports.
>> -
>> -	  This feature often won't work well, depending on ThinkPad model,
>> -	  display state, video output devices in use, whether there is a X
>> -	  server running, phase of the moon, and the current mood of
>> -	  Schroedinger's cat.  If you can use X.org's RandR to control
>> -	  your ThinkPad's video output ports instead of this feature,
>> -	  don't think twice: do it and say N here to save memory and avoid
>> -	  bad interactions with X.org.
>> -
>> -	  NOTE: access to this feature is limited to processes with the
>> -	  CAP_SYS_ADMIN capability, to avoid local DoS issues in platforms
>> -	  where it interacts badly with X.org.
>> -
>> -	  If you are not sure, say Y here but do try to check if you could
>> -	  be using X.org RandR instead.
>> -
>> -config THINKPAD_ACPI_HOTKEY_POLL
>> -	bool "Support NVRAM polling for hot keys"
>> -	depends on THINKPAD_ACPI
>> -	default y
>> -	help
>> -	  Some thinkpad models benefit from NVRAM polling to detect a few of
>> -	  the hot key press events.  If you know your ThinkPad model does not
>> -	  need to do NVRAM polling to support any of the hot keys you use,
>> -	  unselecting this option will save about 1kB of memory.
>> -
>> -	  ThinkPads T40 and newer, R52 and newer, and X31 and newer are
>> -	  unlikely to need NVRAM polling in their latest BIOS versions.
>> -
>> -	  NVRAM polling can detect at most the following keys: ThinkPad/Access
>> -	  IBM, Zoom, Switch Display (fn+F7), ThinkLight, Volume up/down/mute,
>> -	  Brightness up/down, Display Expand (fn+F8), Hibernate (fn+F12).
>> -
>> -	  If you are not sure, say Y here.  The driver enables polling only if
>> -	  it is strictly necessary to do so.
>> -
>> -config THINKPAD_LMI
>> -	tristate "Lenovo WMI-based systems management driver"
>> -	depends on ACPI_WMI
>> -	select FW_ATTR_CLASS
>> -	help
>> -	  This driver allows changing BIOS settings on Lenovo machines whose
>> -	  BIOS support the WMI interface.
>> -
>> -	  To compile this driver as a module, choose M here: the module will
>> -	  be called think-lmi.
>> -
>>  source "drivers/platform/x86/intel/Kconfig"
>>  
>> +source "drivers/platform/x86/lenovo/Kconfig"
>> +
>>  config MSI_EC
>>  	tristate "MSI EC Extras"
>>  	depends on ACPI
>
> Random remark: it would certainly be good if we can reduce the number
> of THINKPAD_ACPI related Kconfig symbols ...
Agreed :)

>
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>> index c7a18e95ad8c..ccf3610cb34b 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -58,18 +58,16 @@ obj-$(CONFIG_X86_PLATFORM_DRIVERS_HP)	+= hp/
>>  # Hewlett Packard Enterprise
>>  obj-$(CONFIG_UV_SYSFS)       += uv_sysfs.o
>>  
>> -# IBM Thinkpad and Lenovo
>> +# IBM Thinkpad
>>  obj-$(CONFIG_IBM_RTL)		+= ibm_rtl.o
>> -obj-$(CONFIG_IDEAPAD_LAPTOP)	+= ideapad-laptop.o
>> -obj-$(CONFIG_LENOVO_YMC)	+= lenovo-ymc.o
>>  obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
>> -obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
>> -obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>> -obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
>>  
>>  # Intel
>>  obj-y				+= intel/
>>  
>> +# Lenovo
>> +obj-$(CONFIG_X86_PLATFORM_DRIVERS_LENOVO) += lenovo/
>> +
>>  # MSI
>>  obj-$(CONFIG_MSI_EC)		+= msi-ec.o
>>  obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
>> diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86/lenovo/Kconfig
>> new file mode 100644
>> index 000000000000..a4de6f5b841d
>> --- /dev/null
>> +++ b/drivers/platform/x86/lenovo/Kconfig
>> @@ -0,0 +1,211 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Lenovo X86 Platform Specific Drivers
>> +#
>> +
>> +menuconfig X86_PLATFORM_DRIVERS_LENOVO
>> +	bool "Lenovo X86 Platform Specific Device Drivers"
>> +	default y
>> +	help
>> +	  Say Y here to get to see options for device drivers for various
>> +	  Lenovo x86 platforms, including vendor-specific laptop extension drivers.
>> +	  This option alone does not add any kernel code.
>> +
>> +	  If you say N, all options in this submenu will be skipped and disabled.
>> +
>> +if X86_PLATFORM_DRIVERS_LENOVO
>> +
>> +config YOGABOOK
>> +	tristate "Lenovo Yoga Book tablet key driver"
>> +	depends on ACPI_WMI
>> +	depends on INPUT
>> +	depends on I2C
>> +	select LEDS_CLASS
>> +	select NEW_LEDS
>> +	help
>> +	  Say Y here if you want to support the 'Pen' key and keyboard backlight
>> +	  control on the Lenovo Yoga Book tablets.
>> +
>> +	  To compile this driver as a module, choose M here: the module will
>> +	  be called lenovo-yogabook.
>> +
>> +config IDEAPAD_LAPTOP
>> +	tristate "Lenovo IdeaPad Laptop Extras"
>> +	depends on ACPI
>> +	depends on RFKILL && INPUT
>> +	depends on SERIO_I8042
>> +	depends on BACKLIGHT_CLASS_DEVICE
>> +	depends on ACPI_VIDEO || ACPI_VIDEO = n
>> +	depends on ACPI_WMI || ACPI_WMI = n
>> +	select ACPI_PLATFORM_PROFILE
>> +	select INPUT_SPARSEKMAP
>> +	select NEW_LEDS
>> +	select LEDS_CLASS
>> +	help
>> +	  This is a driver for Lenovo IdeaPad netbooks contains drivers for
>> +	  rfkill switch, hotkey, fan control and backlight control.
>> +
>> +config LENOVO_YMC
>> +	tristate "Lenovo Yoga Tablet Mode Control"
>> +	depends on ACPI_WMI
>> +	depends on INPUT
>> +	select INPUT_SPARSEKMAP
>> +	help
>> +	  This driver maps the Tablet Mode Control switch to SW_TABLET_MODE input
>> +	  events for Lenovo Yoga notebooks.
>> +
>> +config THINKPAD_ACPI
>> +	tristate "ThinkPad ACPI Laptop Extras"
>> +	depends on ACPI
>> +	depends on ACPI_BATTERY
>> +	depends on INPUT
>> +	depends on RFKILL || RFKILL = n
>> +	depends on ACPI_VIDEO || ACPI_VIDEO = n
>> +	depends on BACKLIGHT_CLASS_DEVICE
>> +	depends on I2C
>> +	depends on DRM
>> +	select ACPI_PLATFORM_PROFILE
>> +	select DRM_PRIVACY_SCREEN
>> +	select HWMON
>> +	select NVRAM
>> +	select NEW_LEDS
>> +	select LEDS_CLASS
>> +	select LEDS_TRIGGERS
>> +	select LEDS_TRIGGER_AUDIO
>> +	help
>> +	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
>> +	  support for Fn-Fx key combinations, Bluetooth control, video
>> +	  output switching, ThinkLight control, UltraBay eject and more.
>> +	  For more information about this driver see
>> +	  <file:Documentation/admin-guide/laptops/thinkpad-acpi.rst> and
>> +	  <http://ibm-acpi.sf.net/> .
>> +
>> +	  This driver was formerly known as ibm-acpi.
>> +
>> +	  Extra functionality will be available if the rfkill (CONFIG_RFKILL)
>> +	  and/or ALSA (CONFIG_SND) subsystems are available in the kernel.
>> +	  Note that if you want ThinkPad-ACPI to be built-in instead of
>> +	  modular, ALSA and rfkill will also have to be built-in.
>> +
>> +	  If you have an IBM or Lenovo ThinkPad laptop, say Y or M here.
>> +
>> +config THINKPAD_ACPI_ALSA_SUPPORT
>> +	bool "Console audio control ALSA interface"
>> +	depends on THINKPAD_ACPI
>> +	depends on SND
>> +	depends on SND = y || THINKPAD_ACPI = SND
>> +	default y
>> +	help
>> +	  Enables monitoring of the built-in console audio output control
>> +	  (headphone and speakers), which is operated by the mute and (in
>> +	  some ThinkPad models) volume hotkeys.
>> +
>> +	  If this option is enabled, ThinkPad-ACPI will export an ALSA card
>> +	  with a single read-only mixer control, which should be used for
>> +	  on-screen-display feedback purposes by the Desktop Environment.
>> +
>> +	  Optionally, the driver will also allow software control (the
>> +	  ALSA mixer will be made read-write).  Please refer to the driver
>> +	  documentation for details.
>> +
>> +	  All IBM models have both volume and mute control.  Newer Lenovo
>> +	  models only have mute control (the volume hotkeys are just normal
>> +	  keys and volume control is done through the main HDA mixer).
>> +
>> +config THINKPAD_ACPI_DEBUGFACILITIES
>> +	bool "Maintainer debug facilities"
>> +	depends on THINKPAD_ACPI
>> +	help
>> +	  Enables extra stuff in the thinkpad-acpi which is completely useless
>> +	  for normal use.  Read the driver source to find out what it does.
>> +
>> +	  Say N here, unless you were told by a kernel maintainer to do
>> +	  otherwise.
>> +
>> +config THINKPAD_ACPI_DEBUG
>> +	bool "Verbose debug mode"
>> +	depends on THINKPAD_ACPI
>> +	help
>> +	  Enables extra debugging information, at the expense of a slightly
>> +	  increase in driver size.
>> +
>> +	  If you are not sure, say N here.
>> +
>> +config THINKPAD_ACPI_UNSAFE_LEDS
>> +	bool "Allow control of important LEDs (unsafe)"
>> +	depends on THINKPAD_ACPI
>> +	help
>> +	  Overriding LED state on ThinkPads can mask important
>> +	  firmware alerts (like critical battery condition), or misled
>> +	  the user into damaging the hardware (undocking or ejecting
>> +	  the bay while buses are still active), etc.
>> +
>> +	  LED control on the ThinkPad is write-only (with very few
>> +	  exceptions on very ancient models), which makes it
>> +	  impossible to know beforehand if important information will
>> +	  be lost when one changes LED state.
>> +
>> +	  Users that know what they are doing can enable this option
>> +	  and the driver will allow control of every LED, including
>> +	  the ones on the dock stations.
>> +
>> +	  Never enable this option on a distribution kernel.
>> +
>> +	  Say N here, unless you are building a kernel for your own
>> +	  use, and need to control the important firmware LEDs.
>> +
>> +config THINKPAD_ACPI_VIDEO
>> +	bool "Video output control support"
>> +	depends on THINKPAD_ACPI
>> +	default y
>> +	help
>> +	  Allows the thinkpad_acpi driver to provide an interface to control
>> +	  the various video output ports.
>> +
>> +	  This feature often won't work well, depending on ThinkPad model,
>> +	  display state, video output devices in use, whether there is a X
>> +	  server running, phase of the moon, and the current mood of
>> +	  Schroedinger's cat.  If you can use X.org's RandR to control
>> +	  your ThinkPad's video output ports instead of this feature,
>> +	  don't think twice: do it and say N here to save memory and avoid
>> +	  bad interactions with X.org.
>> +
>> +	  NOTE: access to this feature is limited to processes with the
>> +	  CAP_SYS_ADMIN capability, to avoid local DoS issues in platforms
>> +	  where it interacts badly with X.org.
>> +
>> +	  If you are not sure, say Y here but do try to check if you could
>> +	  be using X.org RandR instead.
>> +
>> +config THINKPAD_ACPI_HOTKEY_POLL
>> +	bool "Support NVRAM polling for hot keys"
>> +	depends on THINKPAD_ACPI
>> +	default y
>> +	help
>> +	  Some thinkpad models benefit from NVRAM polling to detect a few of
>> +	  the hot key press events.  If you know your ThinkPad model does not
>> +	  need to do NVRAM polling to support any of the hot keys you use,
>> +	  unselecting this option will save about 1kB of memory.
>> +
>> +	  ThinkPads T40 and newer, R52 and newer, and X31 and newer are
>> +	  unlikely to need NVRAM polling in their latest BIOS versions.
>> +
>> +	  NVRAM polling can detect at most the following keys: ThinkPad/Access
>> +	  IBM, Zoom, Switch Display (fn+F7), ThinkLight, Volume up/down/mute,
>> +	  Brightness up/down, Display Expand (fn+F8), Hibernate (fn+F12).
>> +
>> +	  If you are not sure, say Y here.  The driver enables polling only if
>> +	  it is strictly necessary to do so.
>> +
>> +config THINKPAD_LMI
>> +	tristate "Lenovo WMI-based systems management driver"
>> +	depends on ACPI_WMI
>> +	select FW_ATTR_CLASS
>> +	help
>> +	  This driver allows changing BIOS settings on Lenovo machines whose
>> +	  BIOS support the WMI interface.
>> +
>> +	  To compile this driver as a module, choose M here: the module will
>> +	  be called think-lmi.
>> +
>> +endif # X86_PLATFORM_DRIVERS_LENOVO
>
> Maybe sort the entries alphabetically, putting the 2 yoga drivers at the end ?
>
> I assume all these entries are just moved and no changes wrt
> depends / selects have been made ?
Yes - I was deliberately trying to minimise the changes.
Only thing is I did make X86_PLATFORM_DRIVERS_LENOVO have default 'y' because I was worried when this got picked up if distro's didn't have this set then Lenovo platforms would stop working and I would get yelled at....a lot. 
Everything else is the same as before.

>
>> diff --git a/drivers/platform/x86/lenovo/Makefile b/drivers/platform/x86/lenovo/Makefile
>> new file mode 100644
>> index 000000000000..4f8d6ed369b8
>> --- /dev/null
>> +++ b/drivers/platform/x86/lenovo/Makefile
>> @@ -0,0 +1,13 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Makefile for linux/drivers/platform/x86/lenovo
>> +# Lenovo x86 Platform-Specific Drivers
>> +#
>> +
>> +obj-$(CONFIG_IBM_RTL)		+= ibm_rtl.o
>
> This looks wrong, since you are keeping this in the main
> drivers/platform/x86/Makefile and Kconfig
Ooops - yes, my mistake.
Originally I moved hdaps and ibm_rtl into the Lenovo directory but on further consideration I decided that was a bad idea as these are originally IBM files (pre the business getting sold to Lenovo) and I should leave them where they were.
I missed this when reverting my change. I'll clean this up. Apologies.

>
>> +obj-$(CONFIG_IDEAPAD_LAPTOP)	+= ideapad-laptop.o
>> +obj-$(CONFIG_LENOVO_YMC)	+= lenovo-ymc.o
>> +obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
>
> same remark for the hdaps driver.
ditto above.

>
>> +obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
>> +obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>> +obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
>> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
>> similarity index 100%
>> rename from drivers/platform/x86/ideapad-laptop.c
>> rename to drivers/platform/x86/lenovo/ideapad-laptop.c
>> diff --git a/drivers/platform/x86/ideapad-laptop.h b/drivers/platform/x86/lenovo/ideapad-laptop.h
>> similarity index 100%
>> rename from drivers/platform/x86/ideapad-laptop.h
>> rename to drivers/platform/x86/lenovo/ideapad-laptop.h
>> diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo/lenovo-ymc.c
>> similarity index 100%
>> rename from drivers/platform/x86/lenovo-ymc.c
>> rename to drivers/platform/x86/lenovo/lenovo-ymc.c
>> diff --git a/drivers/platform/x86/lenovo-yogabook.c b/drivers/platform/x86/lenovo/lenovo-yogabook.c
>> similarity index 100%
>> rename from drivers/platform/x86/lenovo-yogabook.c
>> rename to drivers/platform/x86/lenovo/lenovo-yogabook.c
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
>> similarity index 99%
>> rename from drivers/platform/x86/think-lmi.c
>> rename to drivers/platform/x86/lenovo/think-lmi.c
>> index 3a396b763c49..bf688df50856 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/lenovo/think-lmi.c
>> @@ -19,7 +19,7 @@
>>  #include <linux/types.h>
>>  #include <linux/dmi.h>
>>  #include <linux/wmi.h>
>> -#include "firmware_attributes_class.h"
>> +#include "../firmware_attributes_class.h"
>>  #include "think-lmi.h"
>>  
>>  static bool debug_support;
>> diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/lenovo/think-lmi.h
>> similarity index 100%
>> rename from drivers/platform/x86/think-lmi.h
>> rename to drivers/platform/x86/lenovo/think-lmi.h
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/lenovo/thinkpad_acpi.c
>> similarity index 99%
>> rename from drivers/platform/x86/thinkpad_acpi.c
>> rename to drivers/platform/x86/lenovo/thinkpad_acpi.c
>> index d0b5fd4137bc..7d085d4e02ee 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
>> @@ -80,7 +80,7 @@
>>  #include <sound/core.h>
>>  #include <sound/initval.h>
>>  
>> -#include "dual_accel_detect.h"
>> +#include "../dual_accel_detect.h"
>>  
>>  /* ThinkPad CMOS commands */
>>  #define TP_CMOS_VOLUME_DOWN	0
>
> Regards,
>
> Hans

I have another thinkpad_acpi patch I'm working on that is more important (or at least functionally useful) so I think I'll get that proposed and reviewed first; and then redo this series on the latest with the fixes.
Thanks for the review!

Mark

