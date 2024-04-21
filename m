Return-Path: <linux-kernel+bounces-152616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC58AC136
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FD71F210B2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A821E31758;
	Sun, 21 Apr 2024 20:34:43 +0000 (UTC)
Received: from dd19934.kasserver.com (dd19934.kasserver.com [85.13.149.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB691BF20
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.149.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713731678; cv=none; b=JvFP8qYT3TSLHZ+rn/0G8Xm1Rt2g3GXWLhF0+ABoKy0MyNbs6hg/Off8IbOgwJkSquSufNODcUmvrCJZJ+Tzo6OK7QQau8dTiQ7jBP7toWzWyhYFUNz9pSNRJuIQcgUrYZMBoasZ+rBQrLlKBWbZmHD9633BjQ2NPO4wCrUd1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713731678; c=relaxed/simple;
	bh=oyj7nCMqEV5aRAiKrim/Dvx4NgfAQsam+F5aqsPfoMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V0zzPBiFZWUo5ePkjzBU9hR8YBoeVsA1aoY7fAfZJq8C3v9TnQA9g3QhzCeIQuYrzMhcHZmx9Dz/OKDm3NvdMy/glGOdMa/mz0wfNnmGA6n1cR/LxMD5PTr1v9pA8VC63Vl3aWIx1x3hLiADYBxn91pd6MJJqw3s3lpxbG0LFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wolf-entwicklungen.de; spf=pass smtp.mailfrom=wolf-entwicklungen.de; arc=none smtp.client-ip=85.13.149.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wolf-entwicklungen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolf-entwicklungen.de
Received: from [192.168.0.22] (unknown [185.94.38.253])
	by dd19934.kasserver.com (Postfix) with ESMTPSA id 2C70B2CA0749;
	Sun, 21 Apr 2024 22:29:18 +0200 (CEST)
Message-ID: <b081ee4d-b758-0b69-fa73-304c8105674f@wolf-entwicklungen.de>
Date: Sun, 21 Apr 2024 22:29:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] staging: pi433: Remove unused driver
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Marcus Wolf <linux@wolf-entwicklungen.de>,
 Valentin Vidic <Valentin.Vidic@CARNet.hr>,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>
References: <20240421195717.GA10943@matrix-ESPRIMO-P710>
From: Marcus Wolf <marcus.wolf@wolf-entwicklungen.de>
In-Reply-To: <20240421195717.GA10943@matrix-ESPRIMO-P710>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +

Hi Philipp,

First of all: I am ok, if the driver gets removed.

There are frequent requests of people, interested to work with pi433 and 
the driver. I am sending three, four, five engineering samples out to 
the world per year. Looks like none of those persons got results, they 
felt worth to contribute.

I am not working on pi433 or the driver any more.

Before final deletion, I would like to mention, that the interface of 
the rfm69cw, that is used on pi433, was similar to several other modules 
of Hope-RF (producer of the rfm69cw) - including some LoraWAN modules. I 
don't know, whether the current modules of Hope-RF are still with same 
interface. Never the less, I have never seen a linux driver, working 
with those modules (but I also haven't put attention to that for long 
time, too).
So maybe the pi433 driver still is the only implementation, abstracting 
the interface, Hope-RF used for several of their modules and thus the 
core of the pi433 driver maybe interesting to be used as a more or less 
generic driver for such Hope-RF modules.

Anyway - if you or the community wants to remove the driver, I am fine 
with that decision and say thank you, that I got the chance to place and 
present my driver in staging for several years :-)

Cheers,
Marcus

Am 21.04.2024 um 21:57 schrieb Philipp Hortmann:
> Marcus started a project in 2016 to bring the pi433 alive. One project
> was funded successfully but the second not. So only a few pi433 got sold
> to early adaptors during this time that ended late 2017. There is a
> simple user space program available for a demo with the pi433 but that
> does not use this driver.
> 
> The driver is unused since 2018. No description or user space application
> to use it can be found. To bring it alive the device tree needs to be
> adjusted manually.
> 
> The last patch reviewed by Marcus was in June 2018, last patch tested
> was in July 2017.
> 
> No response since 27. March 2024 regarding the removal of the driver.
> Remove unused driver because of the above named reasons.
> 
> Link: https://lore.kernel.org/linux-staging/c4c5ab38-8c67-4c21-86bc-f4f3c06be358@gmail.com/
> Link: https://www.kickstarter.com/projects/1292669042/pi433-a-radio-module-funkmodul-for-raspberry-pi
> Link: https://www.kickstarter.com/projects/1292669042/smarthome-pi/comments
> Link: https://www.pi433.de/en.html
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> Checked for artifacts of pi433 in MAINTAINERS.
> Removed artifacts in Makefile and Kconfig.
> ---
>   drivers/staging/Kconfig                       |    2 -
>   drivers/staging/Makefile                      |    1 -
>   .../devicetree/pi433-overlay.dtso             |   48 -
>   .../pi433/Documentation/devicetree/pi433.txt  |   62 -
>   drivers/staging/pi433/Documentation/pi433.txt |  274 ----
>   drivers/staging/pi433/Kconfig                 |   17 -
>   drivers/staging/pi433/Makefile                |    4 -
>   drivers/staging/pi433/TODO                    |    8 -
>   drivers/staging/pi433/pi433_if.c              | 1437 -----------------
>   drivers/staging/pi433/pi433_if.h              |  148 --
>   drivers/staging/pi433/rf69.c                  |  832 ----------
>   drivers/staging/pi433/rf69.h                  |   66 -
>   drivers/staging/pi433/rf69_enum.h             |  126 --
>   drivers/staging/pi433/rf69_registers.h        |  478 ------
>   14 files changed, 3503 deletions(-)
>   delete mode 100644 drivers/staging/pi433/Documentation/devicetree/pi433-overlay.dtso
>   delete mode 100644 drivers/staging/pi433/Documentation/devicetree/pi433.txt
>   delete mode 100644 drivers/staging/pi433/Documentation/pi433.txt
>   delete mode 100644 drivers/staging/pi433/Kconfig
>   delete mode 100644 drivers/staging/pi433/Makefile
>   delete mode 100644 drivers/staging/pi433/TODO
>   delete mode 100644 drivers/staging/pi433/pi433_if.c
>   delete mode 100644 drivers/staging/pi433/pi433_if.h
>   delete mode 100644 drivers/staging/pi433/rf69.c
>   delete mode 100644 drivers/staging/pi433/rf69.h
>   delete mode 100644 drivers/staging/pi433/rf69_enum.h
>   delete mode 100644 drivers/staging/pi433/rf69_registers.h
> 
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index 8e0e9ab37302..db4a392841b1 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -60,8 +60,6 @@ source "drivers/staging/greybus/Kconfig"
>   
>   source "drivers/staging/vc04_services/Kconfig"
>   
> -source "drivers/staging/pi433/Kconfig"
> -
>   source "drivers/staging/axis-fifo/Kconfig"
>   
>   source "drivers/staging/fieldbus/Kconfig"
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index 471b483e9042..5390879b5d1b 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -20,6 +20,5 @@ obj-$(CONFIG_MOST)		+= most/
>   obj-$(CONFIG_KS7010)		+= ks7010/
>   obj-$(CONFIG_GREYBUS)		+= greybus/
>   obj-$(CONFIG_BCM2835_VCHIQ)	+= vc04_services/
> -obj-$(CONFIG_PI433)		+= pi433/
>   obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
>   obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
> diff --git a/drivers/staging/pi433/Documentation/devicetree/pi433-overlay.dtso b/drivers/staging/pi433/Documentation/devicetree/pi433-overlay.dtso
> deleted file mode 100644
> index 096137fcd5cc..000000000000
> --- a/drivers/staging/pi433/Documentation/devicetree/pi433-overlay.dtso
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -// Definitions for Pi433
> -/dts-v1/;
> -/plugin/;
> -
> -/ {
> -	compatible = "brcm,bcm2835", "brcm,bcm2708", "brcm,bcm2709";
> -};
> -
> -&spi0 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	status = "okay";
> -
> -	spidev@0{
> -		reg = <0>;
> -		status = "disabled";
> -	};
> -
> -	spidev@1{
> -		reg = <1>;
> -		status = "disabled";
> -	};
> -};
> -
> -&gpio {
> -	pi433_pins: pi433_pins {
> -		brcm,pins = <7 25 24>;
> -		brcm,function = <0 0 0>; // in in in
> -	};
> -};
> -
> -&spi0 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	status = "okay";
> -
> -	pi433: pi433@0 {
> -		compatible = "Smarthome-Wolf,pi433";
> -		reg = <0>;
> -		spi-max-frequency = <10000000>;
> -		status = "okay";
> -
> -		pinctrl-0 = <&pi433_pins>;
> -		DIO0-gpio = <&gpio 24 0>;
> -		DIO1-gpio = <&gpio 25 0>;
> -		DIO2-gpio = <&gpio  7 0>;
> -	};
> -};
> diff --git a/drivers/staging/pi433/Documentation/devicetree/pi433.txt b/drivers/staging/pi433/Documentation/devicetree/pi433.txt
> deleted file mode 100644
> index d317c0ec3419..000000000000
> --- a/drivers/staging/pi433/Documentation/devicetree/pi433.txt
> +++ /dev/null
> @@ -1,62 +0,0 @@
> -* Smarthome-Wolf Pi433 - a 433MHz radio module/shield for Raspberry Pi (see www.pi433.de)
> -
> -Required properties:
> -- compatible: must be "Smarthome-Wolf,pi433"
> -- reg: chip select of SPI Interface
> -- DIOx-gpio must be dedicated to the GPIO, connected with DIOx of the RFM69 module
> -
> -
> -Example:
> -
> -With the following lines in gpio-section, the gpio pins, connected with pi433 are
> -reserved/declared.
> -
> -&gpio{
> -	[...]
> -
> -	pi433_pins: pi433_pins {
> -		brcm,pins = <7 25 24>;
> -		brcm,function = <0 0 0>; // in in in
> -	};
> -
> -	[...]
> -}
> -
> -With the following lines in spi section, the device pi433 is declared.
> -It consists of the three gpio pins and an spi interface (here chip select 0)
> -
> -&spi0{
> -	[...]
> -
> -	pi433: pi433@0 {
> -		compatible = "Smarthome-Wolf,pi433";
> -		reg = <0>; /* CE 0 */
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		spi-max-frequency = <10000000>;
> -
> -		pinctrl-0 = <&pi433_pins>;
> -		DIO0-gpio = <&gpio 24 0>;
> -		DIO1-gpio = <&gpio 25 0>;
> -		DIO2-gpio = <&gpio  7 0>;
> -	};
> -}
> -
> -
> -
> -For Raspbian users only
> -=======================
> -Since Raspbian supports device tree overlays, you may use an overlay instead
> -of editing your boards device tree.
> -To use the overlay, you need to compile the file pi433-overlay.dtso which can
> -be found alongside this documentation.
> -The file needs to be compiled - either manually or by integration in your kernel
> -source tree. For a manual compile, you may use a command line like the following:
> -'linux/scripts/dtc/dtc -@ -I dts -O dtb -o pi433.dtbo pi433-overlay.dtso'
> -
> -For compiling inside of the kernel tree, you need to copy pi433-overlay.dtso to
> -arch/arm/boot/dts/overlays and you need to add the file to the list of files
> -in the Makefile over there. Execute 'make dtbs' in kernel tree root to make the
> -kernel make files compile the device tree overlay for you.
> -
> -
> diff --git a/drivers/staging/pi433/Documentation/pi433.txt b/drivers/staging/pi433/Documentation/pi433.txt
> deleted file mode 100644
> index 4a0d34b4ad37..000000000000
> --- a/drivers/staging/pi433/Documentation/pi433.txt
> +++ /dev/null
> @@ -1,274 +0,0 @@
> -=====
> -Pi433
> -=====
> -
> -
> -Introduction
> -============
> -This driver is for controlling pi433, a radio module for the Raspberry Pi
> -(www.pi433.de). It supports transmission and reception. It can be opened
> -by multiple applications for transmission and reception. While transmit
> -jobs are queued and processed automatically in the background, the first
> -application asking for reception will block out all other applications
> -until something gets received terminates the read request.
> -The driver supports on the fly reloading of the hardware fifo of the rf
> -chip, thus enabling for much longer telegrams than the hardware fifo size.
> -
> -Description of driver operation
> -===============================
> -
> -a) transmission
> -
> -Each transmission can take place with a different configuration of the rf
> -module. Therefore each application can set its own set of parameters. The driver
> -takes care, that each transmission takes place with the parameterset of the
> -application, that requests the transmission. To allow the transmission to take
> -place in the background, a tx thread is introduced.
> -The transfer of data from the main thread to the tx thread is realised by a
> -kfifo. With each write request of an application, the passed in data and the
> -corresponding parameter set gets written to the kfifo.
> -On the other "side" of the kfifo, the tx thread continuously checks, whether the
> -kfifo is empty. If not, it gets one set of config and data from the kfifo. If
> -there is no receive request or the receiver is still waiting for something in
> -the air, the rf module is set to standby, the parameters for transmission gets
> -set, the hardware fifo of the rf chip gets preloaded and the transmission gets
> -started. Upon hardware fifo threshold interrupt it gets reloaded, thus enabling
> -much longer telegrams than the hardware fifo size. If the telegram is sent and there
> -is more data available in the kfifo, the procedure is repeated. If not the
> -transmission cycle ends.
> -
> -b) reception
> -
> -Since there is only one application allowed to receive data at a time, for
> -reception there is only one configuration set.
> -As soon as an application sets a request for receiving a telegram, the reception
> -configuration set is written to the rf module and it gets set into receiving mode.
> -Now the driver is waiting, that a predefined RSSI level (signal strength at the
> -receiver) is reached. Until this hasn't happened, the reception can be
> -interrupted by the transmission thread at any time to insert a transmission cycle.
> -As soon as the predefined RSSI level is met, a receiving cycle starts. Similar
> -as described for the transmission cycle the read out of the hardware fifo is done
> -dynamically. Upon each hardware fifo threshold interrupt, a portion of data gets
> -read. So also for reception it is possible to receive more data than the hardware
> -fifo can hold.
> -
> -
> -Driver API
> -==========
> -
> -The driver is currently implemented as a character device. Therefore it supports
> -the calls open, ioctl, read, write and close.
> -
> -
> -params for ioctl
> -----------------
> -
> -There are four options:
> -PI433_IOC_RD_TX_CFG - get the transmission parameters from the driver
> -PI433_IOC_WR_TX_CFG - set the transmission parameters
> -PI433_IOC_RD_RX_CFG - get the receiving parameters from the driver
> -PI433_IOC_WR_RX_CFG - set the receiving parameters
> -
> -The tx configuration is transferred via struct pi433_tx_cfg, the parameterset for transmission.
> -It is divided into two sections: rf parameters and packet format.
> -
> -rf params:
> -	frequency
> -		frequency used for transmission.
> -		Allowed values: 433050000...434790000
> -	bit_rate
> -		bit rate used for transmission.
> -		Allowed values: #####
> -	dev_frequency
> -		frequency deviation in case of FSK.
> -		Allowed values: 600...500000
> -	modulation
> -		FSK - frequency shift key
> -		OOK - On-Off-key
> -	modShaping
> -		shapingOff	- no shaping
> -		shaping1_0	- gauss filter with BT 1 (FSK only)
> -		shaping0_5	- gauss filter with BT 0.5 (FSK only)
> -		shaping0_3	- gauss filter with BT 0.3 (FSK only)
> -		shapingBR	- filter cut off at BR (OOK only)
> -		shaping2BR	- filter cut off at 2*BR (OOK only)
> -	pa_ramp (FSK only)
> -		ramp3400	- amp ramps up in 3.4ms
> -		ramp2000	- amp ramps up in 2.0ms
> -		ramp1000	- amp ramps up in 1ms
> -		ramp500		- amp ramps up in 500us
> -		ramp250		- amp ramps up in 250us
> -		ramp125		- amp ramps up in 125us
> -		ramp100		- amp ramps up in 100us
> -		ramp62		- amp ramps up in 62us
> -		ramp50		- amp ramps up in 50us
> -		ramp40		- amp ramps up in 40us
> -		ramp31		- amp ramps up in 31us
> -		ramp25		- amp ramps up in 25us
> -		ramp20		- amp ramps up in 20us
> -		ramp15		- amp ramps up in 15us
> -		ramp12		- amp ramps up in 12us
> -		ramp10		- amp ramps up in 10us
> -	tx_start_condition
> -		fifo_level	- transmission starts, if fifo is filled to
> -				  threshold level
> -		fifo_not_empty	- transmission starts, as soon as there is one
> -				  byte in internal fifo
> -	repetitions
> -		This gives the option, to send a telegram multiple times. Default: 1
> -
> -packet format:
> -	enable_preamble
> -		optionOn	- a preamble will be automatically generated
> -		optionOff	- no preamble will be generated
> -	enable_sync
> -		optionOn	- a sync word will be automatically added to
> -				  the telegram after the preamble
> -		optionOff	- no sync word will be added
> -		Attention: While possible to generate sync without preamble, the
> -		receiver won't be able to detect the sync without preamble.
> -	enable_length_byte
> -		optionOn	- the length of the telegram will be automatically
> -				  added to the telegram. It's part of the payload
> -		optionOff	- no length information will be automatically added
> -				  to the telegram.
> -		Attention: For telegram length over 255 bytes, this option can't be used
> -		Attention: should be used in combination with sync, only
> -	enable_address_byte
> -		optionOn	- the address byte will be automatically added to the
> -				  telegram. It's part of the payload
> -		optionOff	- the address byte will not be added to the telegram.
> -		The address byte can be used for address filtering, so the receiver
> -		will only receive telegrams with a given address byte.
> -		Attention: should be used in combination with sync, only
> -	enable_crc
> -		optionOn	- an crc will be automatically calculated over the
> -				  payload of the telegram and added to the telegram
> -				  after payload.
> -		optionOff	- no crc will be calculated
> -	preamble_length
> -		length of the preamble. Allowed values: 0...65536
> -	sync_length
> -		length of the sync word. Allowed values: 0...8
> -	fixed_message_length
> -		length of the payload of the telegram. Will override the length
> -		given by the buffer, passed in with the write command. Will be
> -		ignored if set to zero.
> -	sync_pattern[8]
> -		contains up to eight values, that are used as the sync pattern
> -		on sync option
> -	address_byte
> -		one byte, used as address byte on address byte option.
> -
> -
> -The rx configuration is transferred via struct pi433_rx_cfg, the parameterset for receiving. It is divided into two sections: rf parameters and packet format.
> -
> -rf params:
> -	frequency
> -		frequency used for transmission.
> -		Allowed values: 433050000...434790000
> -	bit_rate
> -		bit rate used for transmission.
> -		Allowed values: #####
> -	dev_frequency
> -		frequency deviation in case of FSK.
> -		Allowed values: 600...500000
> -	modulation
> -		FSK - frequency shift key
> -		OOK - on off key
> -	rssi_threshold
> -		threshold value for the signal strength on the receiver input.
> -		If this value is exceeded, a reception cycle starts
> -		Allowed values: 0...255
> -	threshold_decrement
> -		in order to adapt to different levels of singnal strength, over
> -		time the receiver gets more and more sensitive. This value
> -		determs, how fast the sensitivity increases.
> -		step_0_5db	- increase in 0,5dB steps
> -		step_1_0db	- increase in 1 db steps
> -		step_1_5db	- increase in 1,5dB steps
> -		step_2_0db	- increase in 2 db steps
> -		step_3_0db	- increase in 3 db steps
> -		step_4_0db	- increase in 4 db steps
> -		step_5_0db	- increase in 5 db steps
> -		step_6_0db	- increase in 6 db steps
> -	antenna_impedance
> -		sets the electrical adoption of the antenna
> -		fifty_ohm	- for antennas with an impedance of 50Ohm
> -		two_hundred_ohm	- for antennas with an impedance of 200Ohm
> -	lna_gain
> -		sets the gain of the low noise amp
> -		automatic	- lna gain is determined by an agc
> -		max		- lna gain is set to maximum
> -		max_minus_6	- lna gain is set to  6db below max
> -		max_minus_12	- lna gain is set to 12db below max
> -		max_minus_24	- lna gain is set to 24db below max
> -		max_minus_36	- lna gain is set to 36db below max
> -		max_minus_48	- lna gain is set to 48db below max
> -	bw_mantisse
> -		sets the bandwidth of the channel filter - part one: mantisse.
> -		mantisse16	- mantisse is set to 16
> -		mantisse20	- mantisse is set to 20
> -		mantisse24	- mantisse is set to 24
> -	bw_exponent
> -		sets the bandwidth of the channel filter - part two: exponent.
> -		Allowd values: 0...7
> -	dagc;
> -		operation mode of the digital automatic gain control
> -		normal_mode
> -		improve
> -		improve_for_low_modulation_index
> -
> - packet format:
> -	enable_sync
> -		optionOn  - sync detection is enabled. If configured sync pattern
> -			    isn't found, telegram will be internally discarded
> -		optionOff - sync detection is disabled.
> -	enable_length_byte
> -		optionOn   - First byte of payload will be used as a length byte,
> -			     regardless of the amount of bytes that were requested
> -			     by the read request.
> -		optionOff  - Number of bytes to be read will be set according to
> -			     amount of bytes that were requested by the read request.
> -		Attention: should be used in combination with sync, only
> -	enable_address_filtering;
> -		filtering_off		  - no address filtering will take place
> -		node_address		  - all telegrams, not matching the node
> -					    address will be internally discarded
> -		node_or_broadcast_address - all telegrams, neither matching the
> -					    node, nor the broadcast address will
> -					    be internally discarded
> -		Attention: Sync option must be enabled in order to use this feature
> -	enable_crc
> -		optionOn	- a crc will be calculated over the payload of
> -				  the telegram, that was received. If the
> -				  calculated crc doesn't match to two bytes,
> -				  that follow the payload, the telegram will be
> -				  internally discarded.
> -		Attention: This option is only operational if sync on and fixed length
> -		or length byte is used
> -	sync_length
> -		Gives the length of the payload.
> -		Attention: This setting must meet the setting of the transmitter,
> -		if sync option is used.
> -	fixed_message_length
> -		Overrides the telegram length either given by the first byte of
> -		payload or by the read request.
> -	bytes_to_drop
> -		gives the number of bytes, that will be dropped before transferring
> -		data to the read buffer
> -		This option is only useful if all packet helper are switched
> -		off and the rf chip is used in raw receiving mode. This may be
> -		needed, if a telegram of a third party device should be received,
> -		using a protocol not compatible with the packet engine of the rf69 chip.
> -	sync_pattern[8]
> -		contains up to eight values, that are used as the sync pattern
> -		on sync option.
> -		This setting must meet the configuration of the transmitting device,
> -		if sync option is enabled.
> -	node_address
> -		one byte, used as node address byte on address byte option.
> -	broadcast_address
> -		one byte, used as broadcast address byte on address byte option.
> -
> -
> diff --git a/drivers/staging/pi433/Kconfig b/drivers/staging/pi433/Kconfig
> deleted file mode 100644
> index dd9e4709d1a8..000000000000
> --- a/drivers/staging/pi433/Kconfig
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -config PI433
> -	tristate "Pi433 - a 433MHz radio module for Raspberry Pi"
> -	depends on SPI
> -	help
> -	  This option allows you to enable support for the radio module Pi433.
> -
> -	  Pi433 is a shield that fits onto the GPIO header of a Raspberry Pi
> -	  or compatible. It extends the Raspberry Pi with the option, to
> -	  send and receive data in the 433MHz ISM band - for example to
> -	  communicate between two systems without using ethernet or bluetooth
> -	  or for control or read sockets, actors, sensors, widely available
> -	  for low price.
> -
> -	  For details or the option to buy, please visit https://pi433.de/en.html
> -
> -	  If in doubt, say N here, but saying yes most probably won't hurt
> diff --git a/drivers/staging/pi433/Makefile b/drivers/staging/pi433/Makefile
> deleted file mode 100644
> index 051132fe4dae..000000000000
> --- a/drivers/staging/pi433/Makefile
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_PI433) += pi433.o
> -
> -pi433-objs := pi433_if.o rf69.o
> diff --git a/drivers/staging/pi433/TODO b/drivers/staging/pi433/TODO
> deleted file mode 100644
> index 23c808fc99de..000000000000
> --- a/drivers/staging/pi433/TODO
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -* currently the code introduces new IOCTLs. I'm afraid this is a bad idea.
> -  -> Replace this with another interface, hints are welcome!
> -* Some missing data (marked with ###) needs to be added in the documentation
> -* Change (struct pi433_tx_cfg)->bit_rate to be a u32 so that we can support
> -    bit rates up to 300kbps per the spec.
> -  -> This configuration needs to be moved to sysfs instead of being done through
> -     IOCTL. Going forward, we need to port userspace tools to use sysfs instead
> -     of IOCTL and then we would delete IOCTL.
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> deleted file mode 100644
> index befddf6bcea9..000000000000
> --- a/drivers/staging/pi433/pi433_if.c
> +++ /dev/null
> @@ -1,1437 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * userspace interface for pi433 radio module
> - *
> - * Pi433 is a 433MHz radio module for the Raspberry Pi.
> - * It is based on the HopeRf Module RFM69CW. Therefore inside of this
> - * driver, you'll find an abstraction of the rf69 chip.
> - *
> - * If needed, this driver could be extended, to also support other
> - * devices, basing on HopeRfs rf69.
> - *
> - * The driver can also be extended, to support other modules of
> - * HopeRf with a similar interface - e. g. RFM69HCW, RFM12, RFM95, ...
> - *
> - * Copyright (C) 2016 Wolf-Entwicklungen
> - *	Marcus Wolf <linux@wolf-entwicklungen.de>
> - */
> -
> -#undef DEBUG
> -
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/idr.h>
> -#include <linux/ioctl.h>
> -#include <linux/uaccess.h>
> -#include <linux/fs.h>
> -#include <linux/device.h>
> -#include <linux/cdev.h>
> -#include <linux/err.h>
> -#include <linux/kfifo.h>
> -#include <linux/errno.h>
> -#include <linux/mutex.h>
> -#include <linux/of.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/kthread.h>
> -#include <linux/wait.h>
> -#include <linux/spi/spi.h>
> -#ifdef CONFIG_COMPAT
> -#include <linux/compat.h>
> -#endif
> -#include <linux/debugfs.h>
> -#include <linux/seq_file.h>
> -
> -#include "pi433_if.h"
> -#include "rf69.h"
> -
> -#define N_PI433_MINORS		BIT(MINORBITS) /*32*/	/* ... up to 256 */
> -#define MAX_MSG_SIZE		900	/* min: FIFO_SIZE! */
> -#define MSG_FIFO_SIZE		65536   /* 65536 = 2^16  */
> -#define FIFO_THRESHOLD	15		/* bytes */
> -#define NUM_DIO			2
> -
> -static dev_t pi433_devt;
> -static DEFINE_IDR(pi433_idr);
> -static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */
> -static struct dentry *root_dir;	/* debugfs root directory for the driver */
> -
> -/* mainly for udev to create /dev/pi433 */
> -static const struct class pi433_class = {
> -	.name = "pi433",
> -};
> -
> -/*
> - * tx config is instance specific
> - * so with each open a new tx config struct is needed
> - */
> -/*
> - * rx config is device specific
> - * so we have just one rx config, embedded in device struct
> - */
> -struct pi433_device {
> -	/* device handling related values */
> -	dev_t			devt;
> -	int			minor;
> -	struct device		*dev;
> -	struct cdev		*cdev;
> -	struct spi_device	*spi;
> -
> -	/* irq related values */
> -	struct gpio_desc	*gpiod[NUM_DIO];
> -	int			irq_num[NUM_DIO];
> -	u8			irq_state[NUM_DIO];
> -
> -	/* tx related values */
> -	STRUCT_KFIFO_REC_1(MSG_FIFO_SIZE) tx_fifo;
> -	struct mutex		tx_fifo_lock; /* serialize userspace writers */
> -	struct task_struct	*tx_task_struct;
> -	wait_queue_head_t	tx_wait_queue;
> -	u8			free_in_fifo;
> -	char			tx_buffer[MAX_MSG_SIZE];
> -
> -	/* rx related values */
> -	struct pi433_rx_cfg	rx_cfg;
> -	u8			*rx_buffer;
> -	unsigned int		rx_buffer_size;
> -	u32			rx_bytes_to_drop;
> -	u32			rx_bytes_dropped;
> -	unsigned int		rx_position;
> -	struct mutex		rx_lock; /* protects rx_* variable accesses */
> -	wait_queue_head_t	rx_wait_queue;
> -
> -	/* fifo wait queue */
> -	struct task_struct	*fifo_task_struct;
> -	wait_queue_head_t	fifo_wait_queue;
> -
> -	/* flags */
> -	bool			rx_active;
> -	bool			tx_active;
> -	bool			interrupt_rx_allowed;
> -};
> -
> -struct pi433_instance {
> -	struct pi433_device	*pi433;
> -	struct pi433_tx_cfg	tx_cfg;
> -
> -	/* control flags */
> -	bool			tx_cfg_initialized;
> -};
> -
> -/*-------------------------------------------------------------------------*/
> -
> -/* GPIO interrupt handlers */
> -static irqreturn_t DIO0_irq_handler(int irq, void *dev_id)
> -{
> -	struct pi433_device *pi433 = dev_id;
> -
> -	if (pi433->irq_state[DIO0] == DIO_PACKET_SENT) {
> -		pi433->free_in_fifo = FIFO_SIZE;
> -		dev_dbg(pi433->dev, "DIO0 irq: Packet sent\n");
> -		wake_up_interruptible(&pi433->fifo_wait_queue);
> -	} else if (pi433->irq_state[DIO0] == DIO_RSSI_DIO0) {
> -		dev_dbg(pi433->dev, "DIO0 irq: RSSI level over threshold\n");
> -		wake_up_interruptible(&pi433->rx_wait_queue);
> -	} else if (pi433->irq_state[DIO0] == DIO_PAYLOAD_READY) {
> -		dev_dbg(pi433->dev, "DIO0 irq: Payload ready\n");
> -		pi433->free_in_fifo = 0;
> -		wake_up_interruptible(&pi433->fifo_wait_queue);
> -	}
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t DIO1_irq_handler(int irq, void *dev_id)
> -{
> -	struct pi433_device *pi433 = dev_id;
> -
> -	if (pi433->irq_state[DIO1] == DIO_FIFO_NOT_EMPTY_DIO1) {
> -		pi433->free_in_fifo = FIFO_SIZE;
> -	} else if (pi433->irq_state[DIO1] == DIO_FIFO_LEVEL) {
> -		if (pi433->rx_active)
> -			pi433->free_in_fifo = FIFO_THRESHOLD - 1;
> -		else
> -			pi433->free_in_fifo = FIFO_SIZE - FIFO_THRESHOLD - 1;
> -	}
> -	dev_dbg(pi433->dev,
> -		"DIO1 irq: %d bytes free in fifo\n", pi433->free_in_fifo);
> -	wake_up_interruptible(&pi433->fifo_wait_queue);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -/*-------------------------------------------------------------------------*/
> -
> -static int
> -rf69_set_rx_cfg(struct pi433_device *pi433, struct pi433_rx_cfg *rx_cfg)
> -{
> -	int ret;
> -	int payload_length;
> -
> -	/* receiver config */
> -	ret = rf69_set_frequency(pi433->spi, rx_cfg->frequency);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_modulation(pi433->spi, rx_cfg->modulation);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_bit_rate(pi433->spi, rx_cfg->bit_rate);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_antenna_impedance(pi433->spi, rx_cfg->antenna_impedance);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_rssi_threshold(pi433->spi, rx_cfg->rssi_threshold);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_ook_threshold_dec(pi433->spi, rx_cfg->threshold_decrement);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_bandwidth(pi433->spi, rx_cfg->bw_mantisse,
> -				 rx_cfg->bw_exponent);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_bandwidth_during_afc(pi433->spi, rx_cfg->bw_mantisse,
> -					    rx_cfg->bw_exponent);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_dagc(pi433->spi, rx_cfg->dagc);
> -	if (ret < 0)
> -		return ret;
> -
> -	pi433->rx_bytes_to_drop = rx_cfg->bytes_to_drop;
> -
> -	/* packet config */
> -	/* enable */
> -	if (rx_cfg->enable_sync == OPTION_ON) {
> -		ret = rf69_enable_sync(pi433->spi);
> -		if (ret < 0)
> -			return ret;
> -
> -		ret = rf69_set_fifo_fill_condition(pi433->spi,
> -						   after_sync_interrupt);
> -		if (ret < 0)
> -			return ret;
> -	} else {
> -		ret = rf69_disable_sync(pi433->spi);
> -		if (ret < 0)
> -			return ret;
> -
> -		ret = rf69_set_fifo_fill_condition(pi433->spi, always);
> -		if (ret < 0)
> -			return ret;
> -	}
> -	if (rx_cfg->enable_length_byte == OPTION_ON) {
> -		ret = rf69_set_packet_format(pi433->spi, packet_length_var);
> -		if (ret < 0)
> -			return ret;
> -	} else {
> -		ret = rf69_set_packet_format(pi433->spi, packet_length_fix);
> -		if (ret < 0)
> -			return ret;
> -	}
> -	ret = rf69_set_address_filtering(pi433->spi,
> -					 rx_cfg->enable_address_filtering);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (rx_cfg->enable_crc == OPTION_ON) {
> -		ret = rf69_enable_crc(pi433->spi);
> -		if (ret < 0)
> -			return ret;
> -	} else {
> -		ret = rf69_disable_crc(pi433->spi);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	/* lengths */
> -	ret = rf69_set_sync_size(pi433->spi, rx_cfg->sync_length);
> -	if (ret < 0)
> -		return ret;
> -	if (rx_cfg->enable_length_byte == OPTION_ON) {
> -		ret = rf69_set_payload_length(pi433->spi, 0xff);
> -		if (ret < 0)
> -			return ret;
> -	} else if (rx_cfg->fixed_message_length != 0) {
> -		payload_length = rx_cfg->fixed_message_length;
> -		if (rx_cfg->enable_length_byte  == OPTION_ON)
> -			payload_length++;
> -		if (rx_cfg->enable_address_filtering != filtering_off)
> -			payload_length++;
> -		ret = rf69_set_payload_length(pi433->spi, payload_length);
> -		if (ret < 0)
> -			return ret;
> -	} else {
> -		ret = rf69_set_payload_length(pi433->spi, 0);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	/* values */
> -	if (rx_cfg->enable_sync == OPTION_ON) {
> -		ret = rf69_set_sync_values(pi433->spi, rx_cfg->sync_pattern);
> -		if (ret < 0)
> -			return ret;
> -	}
> -	if (rx_cfg->enable_address_filtering != filtering_off) {
> -		ret = rf69_set_node_address(pi433->spi, rx_cfg->node_address);
> -		if (ret < 0)
> -			return ret;
> -		ret = rf69_set_broadcast_address(pi433->spi,
> -						 rx_cfg->broadcast_address);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int
> -rf69_set_tx_cfg(struct pi433_device *pi433, struct pi433_tx_cfg *tx_cfg)
> -{
> -	int ret;
> -
> -	ret = rf69_set_frequency(pi433->spi, tx_cfg->frequency);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_modulation(pi433->spi, tx_cfg->modulation);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_bit_rate(pi433->spi, tx_cfg->bit_rate);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_deviation(pi433->spi, tx_cfg->dev_frequency);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_pa_ramp(pi433->spi, tx_cfg->pa_ramp);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_modulation_shaping(pi433->spi, tx_cfg->mod_shaping);
> -	if (ret < 0)
> -		return ret;
> -	ret = rf69_set_tx_start_condition(pi433->spi, tx_cfg->tx_start_condition);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* packet format enable */
> -	if (tx_cfg->enable_preamble == OPTION_ON) {
> -		ret = rf69_set_preamble_length(pi433->spi,
> -					       tx_cfg->preamble_length);
> -		if (ret < 0)
> -			return ret;
> -	} else {
> -		ret = rf69_set_preamble_length(pi433->spi, 0);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	if (tx_cfg->enable_sync == OPTION_ON) {
> -		ret = rf69_set_sync_size(pi433->spi, tx_cfg->sync_length);
> -		if (ret < 0)
> -			return ret;
> -		ret = rf69_set_sync_values(pi433->spi, tx_cfg->sync_pattern);
> -		if (ret < 0)
> -			return ret;
> -		ret = rf69_enable_sync(pi433->spi);
> -		if (ret < 0)
> -			return ret;
> -	} else {
> -		ret = rf69_disable_sync(pi433->spi);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	if (tx_cfg->enable_length_byte == OPTION_ON) {
> -		ret = rf69_set_packet_format(pi433->spi, packet_length_var);
> -		if (ret < 0)
> -			return ret;
> -	} else {
> -		ret = rf69_set_packet_format(pi433->spi, packet_length_fix);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	if (tx_cfg->enable_crc == OPTION_ON) {
> -		ret = rf69_enable_crc(pi433->spi);
> -		if (ret < 0)
> -			return ret;
> -	} else {
> -		ret = rf69_disable_crc(pi433->spi);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -/*-------------------------------------------------------------------------*/
> -
> -static int pi433_start_rx(struct pi433_device *pi433)
> -{
> -	int retval;
> -
> -	/* return without action, if no pending read request */
> -	if (!pi433->rx_active)
> -		return 0;
> -
> -	/* setup for receiving */
> -	retval = rf69_set_rx_cfg(pi433, &pi433->rx_cfg);
> -	if (retval)
> -		return retval;
> -
> -	/* setup rssi irq */
> -	retval = rf69_set_dio_mapping(pi433->spi, DIO0, DIO_RSSI_DIO0);
> -	if (retval < 0)
> -		return retval;
> -	pi433->irq_state[DIO0] = DIO_RSSI_DIO0;
> -	irq_set_irq_type(pi433->irq_num[DIO0], IRQ_TYPE_EDGE_RISING);
> -
> -	/* setup fifo level interrupt */
> -	retval = rf69_set_fifo_threshold(pi433->spi, FIFO_SIZE - FIFO_THRESHOLD);
> -	if (retval < 0)
> -		return retval;
> -	retval = rf69_set_dio_mapping(pi433->spi, DIO1, DIO_FIFO_LEVEL);
> -	if (retval < 0)
> -		return retval;
> -	pi433->irq_state[DIO1] = DIO_FIFO_LEVEL;
> -	irq_set_irq_type(pi433->irq_num[DIO1], IRQ_TYPE_EDGE_RISING);
> -
> -	/* set module to receiving mode */
> -	retval = rf69_set_mode(pi433->spi, receive);
> -	if (retval < 0)
> -		return retval;
> -
> -	return 0;
> -}
> -
> -/*-------------------------------------------------------------------------*/
> -
> -static int pi433_receive(struct pi433_device *pi433)
> -{
> -	struct spi_device *spi = pi433->spi;
> -	int bytes_to_read, bytes_total;
> -	int retval;
> -
> -	pi433->interrupt_rx_allowed = false;
> -
> -	/* wait for any tx to finish */
> -	dev_dbg(pi433->dev, "rx: going to wait for any tx to finish\n");
> -	retval = wait_event_interruptible(pi433->rx_wait_queue, !pi433->tx_active);
> -	if (retval) {
> -		/* wait was interrupted */
> -		pi433->interrupt_rx_allowed = true;
> -		wake_up_interruptible(&pi433->tx_wait_queue);
> -		return retval;
> -	}
> -
> -	/* prepare status vars */
> -	pi433->free_in_fifo = FIFO_SIZE;
> -	pi433->rx_position = 0;
> -	pi433->rx_bytes_dropped = 0;
> -
> -	/* setup radio module to listen for something "in the air" */
> -	retval = pi433_start_rx(pi433);
> -	if (retval)
> -		return retval;
> -
> -	/* now check RSSI, if low wait for getting high (RSSI interrupt) */
> -	while (!(rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_RSSI)) {
> -		/* allow tx to interrupt us while waiting for high RSSI */
> -		pi433->interrupt_rx_allowed = true;
> -		wake_up_interruptible(&pi433->tx_wait_queue);
> -
> -		/* wait for RSSI level to become high */
> -		dev_dbg(pi433->dev, "rx: going to wait for high RSSI level\n");
> -		retval = wait_event_interruptible(pi433->rx_wait_queue,
> -						  rf69_read_reg(spi, REG_IRQFLAGS1) &
> -						  MASK_IRQFLAGS1_RSSI);
> -		if (retval) /* wait was interrupted */
> -			goto abort;
> -		pi433->interrupt_rx_allowed = false;
> -
> -		/* cross check for ongoing tx */
> -		if (!pi433->tx_active)
> -			break;
> -	}
> -
> -	/* configure payload ready irq */
> -	retval = rf69_set_dio_mapping(spi, DIO0, DIO_PAYLOAD_READY);
> -	if (retval < 0)
> -		goto abort;
> -	pi433->irq_state[DIO0] = DIO_PAYLOAD_READY;
> -	irq_set_irq_type(pi433->irq_num[DIO0], IRQ_TYPE_EDGE_RISING);
> -
> -	/* fixed or unlimited length? */
> -	if (pi433->rx_cfg.fixed_message_length != 0) {
> -		if (pi433->rx_cfg.fixed_message_length > pi433->rx_buffer_size) {
> -			retval = -1;
> -			goto abort;
> -		}
> -		bytes_total = pi433->rx_cfg.fixed_message_length;
> -		dev_dbg(pi433->dev, "rx: msg len set to %d by fixed length\n",
> -			bytes_total);
> -	} else {
> -		bytes_total = pi433->rx_buffer_size;
> -		dev_dbg(pi433->dev, "rx: msg len set to %d as requested by read\n",
> -			bytes_total);
> -	}
> -
> -	/* length byte enabled? */
> -	if (pi433->rx_cfg.enable_length_byte == OPTION_ON) {
> -		retval = wait_event_interruptible(pi433->fifo_wait_queue,
> -						  pi433->free_in_fifo < FIFO_SIZE);
> -		if (retval) /* wait was interrupted */
> -			goto abort;
> -
> -		rf69_read_fifo(spi, (u8 *)&bytes_total, 1);
> -		if (bytes_total > pi433->rx_buffer_size) {
> -			retval = -1;
> -			goto abort;
> -		}
> -		pi433->free_in_fifo++;
> -		dev_dbg(pi433->dev, "rx: msg len reset to %d due to length byte\n",
> -			bytes_total);
> -	}
> -
> -	/* address byte enabled? */
> -	if (pi433->rx_cfg.enable_address_filtering != filtering_off) {
> -		u8 dummy;
> -
> -		bytes_total--;
> -
> -		retval = wait_event_interruptible(pi433->fifo_wait_queue,
> -						  pi433->free_in_fifo < FIFO_SIZE);
> -		if (retval) /* wait was interrupted */
> -			goto abort;
> -
> -		rf69_read_fifo(spi, &dummy, 1);
> -		pi433->free_in_fifo++;
> -		dev_dbg(pi433->dev, "rx: address byte stripped off\n");
> -	}
> -
> -	/* get payload */
> -	while (pi433->rx_position < bytes_total) {
> -		if (!(rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_PAYLOAD_READY)) {
> -			retval = wait_event_interruptible(pi433->fifo_wait_queue,
> -							  pi433->free_in_fifo < FIFO_SIZE);
> -			if (retval) /* wait was interrupted */
> -				goto abort;
> -		}
> -
> -		/* need to drop bytes or acquire? */
> -		if (pi433->rx_bytes_to_drop > pi433->rx_bytes_dropped)
> -			bytes_to_read = pi433->rx_bytes_to_drop -
> -					pi433->rx_bytes_dropped;
> -		else
> -			bytes_to_read = bytes_total - pi433->rx_position;
> -
> -		/* access the fifo */
> -		if (bytes_to_read > FIFO_SIZE - pi433->free_in_fifo)
> -			bytes_to_read = FIFO_SIZE - pi433->free_in_fifo;
> -		retval = rf69_read_fifo(spi,
> -					&pi433->rx_buffer[pi433->rx_position],
> -					bytes_to_read);
> -		if (retval) /* read failed */
> -			goto abort;
> -
> -		pi433->free_in_fifo += bytes_to_read;
> -
> -		/* adjust status vars */
> -		if (pi433->rx_bytes_to_drop > pi433->rx_bytes_dropped)
> -			pi433->rx_bytes_dropped += bytes_to_read;
> -		else
> -			pi433->rx_position += bytes_to_read;
> -	}
> -
> -	/* rx done, wait was interrupted or error occurred */
> -abort:
> -	pi433->interrupt_rx_allowed = true;
> -	if (rf69_set_mode(pi433->spi, standby))
> -		pr_err("rf69_set_mode(): radio module failed to go standby\n");
> -	wake_up_interruptible(&pi433->tx_wait_queue);
> -
> -	if (retval)
> -		return retval;
> -	else
> -		return bytes_total;
> -}
> -
> -static int pi433_tx_thread(void *data)
> -{
> -	struct pi433_device *pi433 = data;
> -	struct spi_device *spi = pi433->spi;
> -	struct pi433_tx_cfg tx_cfg;
> -	size_t size;
> -	bool   rx_interrupted = false;
> -	int    position, repetitions;
> -	int    retval;
> -
> -	while (1) {
> -		/* wait for fifo to be populated or for request to terminate*/
> -		dev_dbg(pi433->dev, "thread: going to wait for new messages\n");
> -		wait_event_interruptible(pi433->tx_wait_queue,
> -					 (!kfifo_is_empty(&pi433->tx_fifo) ||
> -					  kthread_should_stop()));
> -		if (kthread_should_stop())
> -			return 0;
> -
> -		/*
> -		 * get data from fifo in the following order:
> -		 * - tx_cfg
> -		 * - size of message
> -		 * - message
> -		 */
> -		retval = kfifo_out(&pi433->tx_fifo, &tx_cfg, sizeof(tx_cfg));
> -		if (retval != sizeof(tx_cfg)) {
> -			dev_dbg(pi433->dev,
> -				"reading tx_cfg from fifo failed: got %d byte(s), expected %d\n",
> -				retval, (unsigned int)sizeof(tx_cfg));
> -			continue;
> -		}
> -
> -		retval = kfifo_out(&pi433->tx_fifo, &size, sizeof(size_t));
> -		if (retval != sizeof(size_t)) {
> -			dev_dbg(pi433->dev,
> -				"reading msg size from fifo failed: got %d, expected %d\n",
> -				retval, (unsigned int)sizeof(size_t));
> -			continue;
> -		}
> -
> -		/* use fixed message length, if requested */
> -		if (tx_cfg.fixed_message_length != 0)
> -			size = tx_cfg.fixed_message_length;
> -
> -		/* increase size, if len byte is requested */
> -		if (tx_cfg.enable_length_byte == OPTION_ON)
> -			size++;
> -
> -		/* increase size, if adr byte is requested */
> -		if (tx_cfg.enable_address_byte == OPTION_ON)
> -			size++;
> -
> -		/* prime tx_buffer */
> -		memset(pi433->tx_buffer, 0, size);
> -		position = 0;
> -
> -		/* add length byte, if requested */
> -		if (tx_cfg.enable_length_byte  == OPTION_ON)
> -			/*
> -			 * according to spec, length byte itself must be
> -			 * excluded from the length calculation
> -			 */
> -			pi433->tx_buffer[position++] = size - 1;
> -
> -		/* add adr byte, if requested */
> -		if (tx_cfg.enable_address_byte == OPTION_ON)
> -			pi433->tx_buffer[position++] = tx_cfg.address_byte;
> -
> -		/* finally get message data from fifo */
> -		retval = kfifo_out(&pi433->tx_fifo, &pi433->tx_buffer[position],
> -				   sizeof(pi433->tx_buffer) - position);
> -		dev_dbg(pi433->dev,
> -			"read %d message byte(s) from fifo queue.\n", retval);
> -
> -		/*
> -		 * if rx is active, we need to interrupt the waiting for
> -		 * incoming telegrams, to be able to send something.
> -		 * We are only allowed, if currently no reception takes
> -		 * place otherwise we need to  wait for the incoming telegram
> -		 * to finish
> -		 */
> -		wait_event_interruptible(pi433->tx_wait_queue,
> -					 !pi433->rx_active ||
> -					  pi433->interrupt_rx_allowed);
> -
> -		/*
> -		 * prevent race conditions
> -		 * irq will be re-enabled after tx config is set
> -		 */
> -		disable_irq(pi433->irq_num[DIO0]);
> -		pi433->tx_active = true;
> -
> -		/* clear fifo, set fifo threshold, set payload length */
> -		retval = rf69_set_mode(spi, standby); /* this clears the fifo */
> -		if (retval < 0)
> -			goto abort;
> -
> -		if (pi433->rx_active && !rx_interrupted) {
> -			/*
> -			 * rx is currently waiting for a telegram;
> -			 * we need to set the radio module to standby
> -			 */
> -			rx_interrupted = true;
> -		}
> -
> -		retval = rf69_set_fifo_threshold(spi, FIFO_THRESHOLD);
> -		if (retval < 0)
> -			goto abort;
> -		if (tx_cfg.enable_length_byte == OPTION_ON) {
> -			retval = rf69_set_payload_length(spi, size * tx_cfg.repetitions);
> -			if (retval < 0)
> -				goto abort;
> -		} else {
> -			retval = rf69_set_payload_length(spi, 0);
> -			if (retval < 0)
> -				goto abort;
> -		}
> -
> -		/* configure the rf chip */
> -		retval = rf69_set_tx_cfg(pi433, &tx_cfg);
> -		if (retval < 0)
> -			goto abort;
> -
> -		/* enable fifo level interrupt */
> -		retval = rf69_set_dio_mapping(spi, DIO1, DIO_FIFO_LEVEL);
> -		if (retval < 0)
> -			goto abort;
> -		pi433->irq_state[DIO1] = DIO_FIFO_LEVEL;
> -		irq_set_irq_type(pi433->irq_num[DIO1], IRQ_TYPE_EDGE_FALLING);
> -
> -		/* enable packet sent interrupt */
> -		retval = rf69_set_dio_mapping(spi, DIO0, DIO_PACKET_SENT);
> -		if (retval < 0)
> -			goto abort;
> -		pi433->irq_state[DIO0] = DIO_PACKET_SENT;
> -		irq_set_irq_type(pi433->irq_num[DIO0], IRQ_TYPE_EDGE_RISING);
> -		enable_irq(pi433->irq_num[DIO0]); /* was disabled by rx active check */
> -
> -		/* enable transmission */
> -		retval = rf69_set_mode(spi, transmit);
> -		if (retval < 0)
> -			goto abort;
> -
> -		/* transfer this msg (and repetitions) to chip fifo */
> -		pi433->free_in_fifo = FIFO_SIZE;
> -		position = 0;
> -		repetitions = tx_cfg.repetitions;
> -		while ((repetitions > 0) && (size > position)) {
> -			if ((size - position) > pi433->free_in_fifo) {
> -				/* msg to big for fifo - take a part */
> -				int write_size = pi433->free_in_fifo;
> -
> -				pi433->free_in_fifo = 0;
> -				rf69_write_fifo(spi,
> -						&pi433->tx_buffer[position],
> -						write_size);
> -				position += write_size;
> -			} else {
> -				/* msg fits into fifo - take all */
> -				pi433->free_in_fifo -= size;
> -				repetitions--;
> -				rf69_write_fifo(spi,
> -						&pi433->tx_buffer[position],
> -						(size - position));
> -				position = 0; /* reset for next repetition */
> -			}
> -
> -			retval = wait_event_interruptible(pi433->fifo_wait_queue,
> -							  pi433->free_in_fifo > 0);
> -			if (retval) {
> -				dev_dbg(pi433->dev, "ABORT\n");
> -				goto abort;
> -			}
> -		}
> -
> -		/* we are done. Wait for packet to get sent */
> -		dev_dbg(pi433->dev,
> -			"thread: wait for packet to get sent/fifo to be empty\n");
> -		wait_event_interruptible(pi433->fifo_wait_queue,
> -					 pi433->free_in_fifo == FIFO_SIZE ||
> -					 kthread_should_stop());
> -		if (kthread_should_stop())
> -			return 0;
> -
> -		/* STOP_TRANSMISSION */
> -		dev_dbg(pi433->dev, "thread: Packet sent. Set mode to stby.\n");
> -		retval = rf69_set_mode(spi, standby);
> -		if (retval < 0)
> -			goto abort;
> -
> -		/* everything sent? */
> -		if (kfifo_is_empty(&pi433->tx_fifo)) {
> -abort:
> -			if (rx_interrupted) {
> -				rx_interrupted = false;
> -				pi433_start_rx(pi433);
> -			}
> -			pi433->tx_active = false;
> -			wake_up_interruptible(&pi433->rx_wait_queue);
> -		}
> -	}
> -}
> -
> -/*-------------------------------------------------------------------------*/
> -
> -static ssize_t
> -pi433_read(struct file *filp, char __user *buf, size_t size, loff_t *f_pos)
> -{
> -	struct pi433_instance	*instance;
> -	struct pi433_device	*pi433;
> -	int			bytes_received;
> -	ssize_t			retval;
> -
> -	/* check, whether internal buffer is big enough for requested size */
> -	if (size > MAX_MSG_SIZE)
> -		return -EMSGSIZE;
> -
> -	instance = filp->private_data;
> -	pi433 = instance->pi433;
> -
> -	/* just one read request at a time */
> -	mutex_lock(&pi433->rx_lock);
> -	if (pi433->rx_active) {
> -		mutex_unlock(&pi433->rx_lock);
> -		return -EAGAIN;
> -	}
> -
> -	pi433->rx_active = true;
> -	mutex_unlock(&pi433->rx_lock);
> -
> -	/* start receiving */
> -	/* will block until something was received*/
> -	pi433->rx_buffer_size = size;
> -	bytes_received = pi433_receive(pi433);
> -
> -	/* release rx */
> -	mutex_lock(&pi433->rx_lock);
> -	pi433->rx_active = false;
> -	mutex_unlock(&pi433->rx_lock);
> -
> -	/* if read was successful copy to user space*/
> -	if (bytes_received > 0) {
> -		retval = copy_to_user(buf, pi433->rx_buffer, bytes_received);
> -		if (retval)
> -			return -EFAULT;
> -	}
> -
> -	return bytes_received;
> -}
> -
> -static ssize_t
> -pi433_write(struct file *filp, const char __user *buf,
> -	    size_t count, loff_t *f_pos)
> -{
> -	struct pi433_instance	*instance;
> -	struct pi433_device	*pi433;
> -	int                     retval;
> -	unsigned int		required, available, copied;
> -
> -	instance = filp->private_data;
> -	pi433 = instance->pi433;
> -
> -	/*
> -	 * check, whether internal buffer (tx thread) is big enough
> -	 * for requested size
> -	 */
> -	if (count > MAX_MSG_SIZE)
> -		return -EMSGSIZE;
> -
> -	/*
> -	 * check if tx_cfg has been initialized otherwise we won't be able to
> -	 * config the RF trasmitter correctly due to invalid settings
> -	 */
> -	if (!instance->tx_cfg_initialized) {
> -		dev_notice_once(pi433->dev,
> -				"write: failed due to unconfigured tx_cfg (see PI433_IOC_WR_TX_CFG)\n");
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * write the following sequence into fifo:
> -	 * - tx_cfg
> -	 * - size of message
> -	 * - message
> -	 */
> -	mutex_lock(&pi433->tx_fifo_lock);
> -
> -	required = sizeof(instance->tx_cfg) + sizeof(size_t) + count;
> -	available = kfifo_avail(&pi433->tx_fifo);
> -	if (required > available) {
> -		dev_dbg(pi433->dev, "write to fifo failed: %d bytes required but %d available\n",
> -			required, available);
> -		mutex_unlock(&pi433->tx_fifo_lock);
> -		return -EAGAIN;
> -	}
> -
> -	retval = kfifo_in(&pi433->tx_fifo, &instance->tx_cfg,
> -			  sizeof(instance->tx_cfg));
> -	if (retval != sizeof(instance->tx_cfg))
> -		goto abort;
> -
> -	retval = kfifo_in(&pi433->tx_fifo, &count, sizeof(size_t));
> -	if (retval != sizeof(size_t))
> -		goto abort;
> -
> -	retval = kfifo_from_user(&pi433->tx_fifo, buf, count, &copied);
> -	if (retval || copied != count)
> -		goto abort;
> -
> -	mutex_unlock(&pi433->tx_fifo_lock);
> -
> -	/* start transfer */
> -	wake_up_interruptible(&pi433->tx_wait_queue);
> -	dev_dbg(pi433->dev, "write: generated new msg with %d bytes.\n", copied);
> -
> -	return copied;
> -
> -abort:
> -	dev_warn(pi433->dev,
> -		 "write to fifo failed, non recoverable: 0x%x\n", retval);
> -	mutex_unlock(&pi433->tx_fifo_lock);
> -	return -EAGAIN;
> -}
> -
> -static long pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> -{
> -	struct pi433_instance	*instance;
> -	struct pi433_device	*pi433;
> -	struct pi433_tx_cfg	tx_cfg;
> -	void __user *argp = (void __user *)arg;
> -
> -	/* Check type and command number */
> -	if (_IOC_TYPE(cmd) != PI433_IOC_MAGIC)
> -		return -ENOTTY;
> -
> -	instance = filp->private_data;
> -	pi433 = instance->pi433;
> -
> -	if (!pi433)
> -		return -ESHUTDOWN;
> -
> -	switch (cmd) {
> -	case PI433_IOC_RD_TX_CFG:
> -		if (copy_to_user(argp, &instance->tx_cfg,
> -				 sizeof(struct pi433_tx_cfg)))
> -			return -EFAULT;
> -		break;
> -	case PI433_IOC_WR_TX_CFG:
> -		if (copy_from_user(&tx_cfg, argp, sizeof(struct pi433_tx_cfg)))
> -			return -EFAULT;
> -		mutex_lock(&pi433->tx_fifo_lock);
> -		memcpy(&instance->tx_cfg, &tx_cfg, sizeof(struct pi433_tx_cfg));
> -		instance->tx_cfg_initialized = true;
> -		mutex_unlock(&pi433->tx_fifo_lock);
> -		break;
> -	case PI433_IOC_RD_RX_CFG:
> -		if (copy_to_user(argp, &pi433->rx_cfg,
> -				 sizeof(struct pi433_rx_cfg)))
> -			return -EFAULT;
> -		break;
> -	case PI433_IOC_WR_RX_CFG:
> -		mutex_lock(&pi433->rx_lock);
> -
> -		/* during pending read request, change of config not allowed */
> -		if (pi433->rx_active) {
> -			mutex_unlock(&pi433->rx_lock);
> -			return -EAGAIN;
> -		}
> -
> -		if (copy_from_user(&pi433->rx_cfg, argp,
> -				   sizeof(struct pi433_rx_cfg))) {
> -			mutex_unlock(&pi433->rx_lock);
> -			return -EFAULT;
> -		}
> -
> -		mutex_unlock(&pi433->rx_lock);
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -/*-------------------------------------------------------------------------*/
> -
> -static int pi433_open(struct inode *inode, struct file *filp)
> -{
> -	struct pi433_device	*pi433;
> -	struct pi433_instance	*instance;
> -
> -	mutex_lock(&minor_lock);
> -	pi433 = idr_find(&pi433_idr, iminor(inode));
> -	mutex_unlock(&minor_lock);
> -	if (!pi433) {
> -		pr_debug("device: minor %d unknown.\n", iminor(inode));
> -		return -ENODEV;
> -	}
> -
> -	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
> -	if (!instance)
> -		return -ENOMEM;
> -
> -	/* setup instance data*/
> -	instance->pi433 = pi433;
> -
> -	/* instance data as context */
> -	filp->private_data = instance;
> -	stream_open(inode, filp);
> -
> -	return 0;
> -}
> -
> -static int pi433_release(struct inode *inode, struct file *filp)
> -{
> -	struct pi433_instance	*instance;
> -
> -	instance = filp->private_data;
> -	kfree(instance);
> -	filp->private_data = NULL;
> -
> -	return 0;
> -}
> -
> -/*-------------------------------------------------------------------------*/
> -
> -static int setup_gpio(struct pi433_device *pi433)
> -{
> -	char	name[5];
> -	int	retval;
> -	int	i;
> -	const irq_handler_t DIO_irq_handler[NUM_DIO] = {
> -		DIO0_irq_handler,
> -		DIO1_irq_handler
> -	};
> -
> -	for (i = 0; i < NUM_DIO; i++) {
> -		/* "construct" name and get the gpio descriptor */
> -		snprintf(name, sizeof(name), "DIO%d", i);
> -		pi433->gpiod[i] = gpiod_get(&pi433->spi->dev, name,
> -					    0 /*GPIOD_IN*/);
> -
> -		if (pi433->gpiod[i] == ERR_PTR(-ENOENT)) {
> -			dev_dbg(&pi433->spi->dev,
> -				"Could not find entry for %s. Ignoring.\n", name);
> -			continue;
> -		}
> -
> -		if (pi433->gpiod[i] == ERR_PTR(-EBUSY))
> -			dev_dbg(&pi433->spi->dev, "%s is busy.\n", name);
> -
> -		if (IS_ERR(pi433->gpiod[i])) {
> -			retval = PTR_ERR(pi433->gpiod[i]);
> -			/* release already allocated gpios */
> -			for (i--; i >= 0; i--) {
> -				free_irq(pi433->irq_num[i], pi433);
> -				gpiod_put(pi433->gpiod[i]);
> -			}
> -			return retval;
> -		}
> -
> -		/* configure the pin */
> -		retval = gpiod_direction_input(pi433->gpiod[i]);
> -		if (retval)
> -			return retval;
> -
> -		/* configure irq */
> -		pi433->irq_num[i] = gpiod_to_irq(pi433->gpiod[i]);
> -		if (pi433->irq_num[i] < 0) {
> -			pi433->gpiod[i] = ERR_PTR(-EINVAL);
> -			return pi433->irq_num[i];
> -		}
> -		retval = request_irq(pi433->irq_num[i],
> -				     DIO_irq_handler[i],
> -				     0, /* flags */
> -				     name,
> -				     pi433);
> -
> -		if (retval)
> -			return retval;
> -
> -		dev_dbg(&pi433->spi->dev, "%s successfully configured\n", name);
> -	}
> -
> -	return 0;
> -}
> -
> -static void free_gpio(struct pi433_device *pi433)
> -{
> -	int i;
> -
> -	for (i = 0; i < NUM_DIO; i++) {
> -		/* check if gpiod is valid */
> -		if (IS_ERR(pi433->gpiod[i]))
> -			continue;
> -
> -		free_irq(pi433->irq_num[i], pi433);
> -		gpiod_put(pi433->gpiod[i]);
> -	}
> -}
> -
> -static int pi433_get_minor(struct pi433_device *pi433)
> -{
> -	int retval = -ENOMEM;
> -
> -	mutex_lock(&minor_lock);
> -	retval = idr_alloc(&pi433_idr, pi433, 0, N_PI433_MINORS, GFP_KERNEL);
> -	if (retval >= 0) {
> -		pi433->minor = retval;
> -		retval = 0;
> -	} else if (retval == -ENOSPC) {
> -		dev_err(&pi433->spi->dev, "too many pi433 devices\n");
> -		retval = -EINVAL;
> -	}
> -	mutex_unlock(&minor_lock);
> -	return retval;
> -}
> -
> -static void pi433_free_minor(struct pi433_device *pi433)
> -{
> -	mutex_lock(&minor_lock);
> -	idr_remove(&pi433_idr, pi433->minor);
> -	mutex_unlock(&minor_lock);
> -}
> -
> -/*-------------------------------------------------------------------------*/
> -
> -static const struct file_operations pi433_fops = {
> -	.owner =	THIS_MODULE,
> -	/*
> -	 * REVISIT switch to aio primitives, so that userspace
> -	 * gets more complete API coverage.  It'll simplify things
> -	 * too, except for the locking.
> -	 */
> -	.write =	pi433_write,
> -	.read =		pi433_read,
> -	.unlocked_ioctl = pi433_ioctl,
> -	.compat_ioctl = compat_ptr_ioctl,
> -	.open =		pi433_open,
> -	.release =	pi433_release,
> -	.llseek =	no_llseek,
> -};
> -
> -static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
> -{
> -	struct pi433_device *pi433;
> -	u8 reg_data[114];
> -	int i;
> -	char *fmt = "0x%02x, 0x%02x\n";
> -	int ret;
> -
> -	pi433 = m->private;
> -
> -	mutex_lock(&pi433->tx_fifo_lock);
> -	mutex_lock(&pi433->rx_lock);
> -
> -	// wait for on-going operations to finish
> -	ret = wait_event_interruptible(pi433->rx_wait_queue, !pi433->tx_active);
> -	if (ret)
> -		goto out_unlock;
> -
> -	ret = wait_event_interruptible(pi433->tx_wait_queue, !pi433->rx_active);
> -	if (ret)
> -		goto out_unlock;
> -
> -	// skip FIFO register (0x0) otherwise this can affect some of uC ops
> -	for (i = 1; i < 0x50; i++)
> -		reg_data[i] = rf69_read_reg(pi433->spi, i);
> -
> -	reg_data[REG_TESTLNA] = rf69_read_reg(pi433->spi, REG_TESTLNA);
> -	reg_data[REG_TESTPA1] = rf69_read_reg(pi433->spi, REG_TESTPA1);
> -	reg_data[REG_TESTPA2] = rf69_read_reg(pi433->spi, REG_TESTPA2);
> -	reg_data[REG_TESTDAGC] = rf69_read_reg(pi433->spi, REG_TESTDAGC);
> -	reg_data[REG_TESTAFC] = rf69_read_reg(pi433->spi, REG_TESTAFC);
> -
> -	seq_puts(m, "# reg, val\n");
> -
> -	for (i = 1; i < 0x50; i++)
> -		seq_printf(m, fmt, i, reg_data[i]);
> -
> -	seq_printf(m, fmt, REG_TESTLNA, reg_data[REG_TESTLNA]);
> -	seq_printf(m, fmt, REG_TESTPA1, reg_data[REG_TESTPA1]);
> -	seq_printf(m, fmt, REG_TESTPA2, reg_data[REG_TESTPA2]);
> -	seq_printf(m, fmt, REG_TESTDAGC, reg_data[REG_TESTDAGC]);
> -	seq_printf(m, fmt, REG_TESTAFC, reg_data[REG_TESTAFC]);
> -
> -out_unlock:
> -	mutex_unlock(&pi433->rx_lock);
> -	mutex_unlock(&pi433->tx_fifo_lock);
> -
> -	return ret;
> -}
> -DEFINE_SHOW_ATTRIBUTE(pi433_debugfs_regs);
> -
> -/*-------------------------------------------------------------------------*/
> -
> -static int pi433_probe(struct spi_device *spi)
> -{
> -	struct pi433_device	*pi433;
> -	int			retval;
> -	struct dentry		*entry;
> -
> -	/* setup spi parameters */
> -	spi->mode = 0x00;
> -	spi->bits_per_word = 8;
> -	/*
> -	 * spi->max_speed_hz = 10000000;
> -	 * 1MHz already set by device tree overlay
> -	 */
> -
> -	retval = spi_setup(spi);
> -	if (retval) {
> -		dev_dbg(&spi->dev, "configuration of SPI interface failed!\n");
> -		return retval;
> -	}
> -
> -	dev_dbg(&spi->dev,
> -		"spi interface setup: mode 0x%2x, %d bits per word, %dhz max speed\n",
> -		spi->mode, spi->bits_per_word, spi->max_speed_hz);
> -
> -	/* read chip version */
> -	retval = rf69_get_version(spi);
> -	if (retval < 0)
> -		return retval;
> -
> -	switch (retval) {
> -	case 0x24:
> -		dev_dbg(&spi->dev, "found pi433 (ver. 0x%x)\n", retval);
> -		break;
> -	default:
> -		dev_dbg(&spi->dev, "unknown chip version: 0x%x\n", retval);
> -		return -ENODEV;
> -	}
> -
> -	/* Allocate driver data */
> -	pi433 = kzalloc(sizeof(*pi433), GFP_KERNEL);
> -	if (!pi433)
> -		return -ENOMEM;
> -
> -	/* Initialize the driver data */
> -	pi433->spi = spi;
> -	pi433->rx_active = false;
> -	pi433->tx_active = false;
> -	pi433->interrupt_rx_allowed = false;
> -
> -	/* init rx buffer */
> -	pi433->rx_buffer = kmalloc(MAX_MSG_SIZE, GFP_KERNEL);
> -	if (!pi433->rx_buffer) {
> -		retval = -ENOMEM;
> -		goto RX_failed;
> -	}
> -
> -	/* init wait queues */
> -	init_waitqueue_head(&pi433->tx_wait_queue);
> -	init_waitqueue_head(&pi433->rx_wait_queue);
> -	init_waitqueue_head(&pi433->fifo_wait_queue);
> -
> -	/* init fifo */
> -	INIT_KFIFO(pi433->tx_fifo);
> -
> -	/* init mutexes and locks */
> -	mutex_init(&pi433->tx_fifo_lock);
> -	mutex_init(&pi433->rx_lock);
> -
> -	/* setup GPIO (including irq_handler) for the different DIOs */
> -	retval = setup_gpio(pi433);
> -	if (retval) {
> -		dev_dbg(&spi->dev, "setup of GPIOs failed\n");
> -		goto GPIO_failed;
> -	}
> -
> -	/* setup the radio module */
> -	retval = rf69_set_mode(spi, standby);
> -	if (retval < 0)
> -		goto minor_failed;
> -	retval = rf69_set_data_mode(spi, DATAMODUL_MODE_PACKET);
> -	if (retval < 0)
> -		goto minor_failed;
> -	retval = rf69_enable_amplifier(spi, MASK_PALEVEL_PA0);
> -	if (retval < 0)
> -		goto minor_failed;
> -	retval = rf69_disable_amplifier(spi, MASK_PALEVEL_PA1);
> -	if (retval < 0)
> -		goto minor_failed;
> -	retval = rf69_disable_amplifier(spi, MASK_PALEVEL_PA2);
> -	if (retval < 0)
> -		goto minor_failed;
> -	retval = rf69_set_output_power_level(spi, 13);
> -	if (retval < 0)
> -		goto minor_failed;
> -	retval = rf69_set_antenna_impedance(spi, fifty_ohm);
> -	if (retval < 0)
> -		goto minor_failed;
> -
> -	/* determ minor number */
> -	retval = pi433_get_minor(pi433);
> -	if (retval) {
> -		dev_dbg(&spi->dev, "get of minor number failed\n");
> -		goto minor_failed;
> -	}
> -
> -	/* create device */
> -	pi433->devt = MKDEV(MAJOR(pi433_devt), pi433->minor);
> -	pi433->dev = device_create(&pi433_class,
> -				   &spi->dev,
> -				   pi433->devt,
> -				   pi433,
> -				   "pi433.%d",
> -				   pi433->minor);
> -	if (IS_ERR(pi433->dev)) {
> -		pr_err("pi433: device register failed\n");
> -		retval = PTR_ERR(pi433->dev);
> -		goto device_create_failed;
> -	} else {
> -		dev_dbg(pi433->dev,
> -			"created device for major %d, minor %d\n",
> -			MAJOR(pi433_devt),
> -			pi433->minor);
> -	}
> -
> -	/* start tx thread */
> -	pi433->tx_task_struct = kthread_run(pi433_tx_thread,
> -					    pi433,
> -					    "pi433.%d_tx_task",
> -					    pi433->minor);
> -	if (IS_ERR(pi433->tx_task_struct)) {
> -		dev_dbg(pi433->dev, "start of send thread failed\n");
> -		retval = PTR_ERR(pi433->tx_task_struct);
> -		goto send_thread_failed;
> -	}
> -
> -	/* create cdev */
> -	pi433->cdev = cdev_alloc();
> -	if (!pi433->cdev) {
> -		dev_dbg(pi433->dev, "allocation of cdev failed\n");
> -		retval = -ENOMEM;
> -		goto cdev_failed;
> -	}
> -	pi433->cdev->owner = THIS_MODULE;
> -	cdev_init(pi433->cdev, &pi433_fops);
> -	retval = cdev_add(pi433->cdev, pi433->devt, 1);
> -	if (retval) {
> -		dev_dbg(pi433->dev, "register of cdev failed\n");
> -		goto del_cdev;
> -	}
> -
> -	/* spi setup */
> -	spi_set_drvdata(spi, pi433);
> -
> -	entry = debugfs_create_dir(dev_name(pi433->dev), root_dir);
> -	debugfs_create_file("regs", 0400, entry, pi433, &pi433_debugfs_regs_fops);
> -
> -	return 0;
> -
> -del_cdev:
> -	cdev_del(pi433->cdev);
> -cdev_failed:
> -	kthread_stop(pi433->tx_task_struct);
> -send_thread_failed:
> -	device_destroy(&pi433_class, pi433->devt);
> -device_create_failed:
> -	pi433_free_minor(pi433);
> -minor_failed:
> -	free_gpio(pi433);
> -GPIO_failed:
> -	kfree(pi433->rx_buffer);
> -RX_failed:
> -	kfree(pi433);
> -
> -	return retval;
> -}
> -
> -static void pi433_remove(struct spi_device *spi)
> -{
> -	struct pi433_device	*pi433 = spi_get_drvdata(spi);
> -
> -	debugfs_lookup_and_remove(dev_name(pi433->dev), root_dir);
> -
> -	/* free GPIOs */
> -	free_gpio(pi433);
> -
> -	/* make sure ops on existing fds can abort cleanly */
> -	pi433->spi = NULL;
> -
> -	kthread_stop(pi433->tx_task_struct);
> -
> -	device_destroy(&pi433_class, pi433->devt);
> -
> -	cdev_del(pi433->cdev);
> -
> -	pi433_free_minor(pi433);
> -
> -	kfree(pi433->rx_buffer);
> -	kfree(pi433);
> -}
> -
> -static const struct of_device_id pi433_dt_ids[] = {
> -	{ .compatible = "Smarthome-Wolf,pi433" },
> -	{},
> -};
> -
> -MODULE_DEVICE_TABLE(of, pi433_dt_ids);
> -
> -static struct spi_driver pi433_spi_driver = {
> -	.driver = {
> -		.name =		"pi433",
> -		.of_match_table = of_match_ptr(pi433_dt_ids),
> -	},
> -	.probe =	pi433_probe,
> -	.remove =	pi433_remove,
> -
> -	/*
> -	 * NOTE:  suspend/resume methods are not necessary here.
> -	 * We don't do anything except pass the requests to/from
> -	 * the underlying controller.  The refrigerator handles
> -	 * most issues; the controller driver handles the rest.
> -	 */
> -};
> -
> -/*-------------------------------------------------------------------------*/
> -
> -static int __init pi433_init(void)
> -{
> -	int status;
> -
> -	/*
> -	 * If MAX_MSG_SIZE is smaller then FIFO_SIZE, the driver won't
> -	 * work stable - risk of buffer overflow
> -	 */
> -	if (MAX_MSG_SIZE < FIFO_SIZE)
> -		return -EINVAL;
> -
> -	/*
> -	 * Claim device numbers.  Then register a class
> -	 * that will key udev/mdev to add/remove /dev nodes.
> -	 * Last, register the driver which manages those device numbers.
> -	 */
> -	status = alloc_chrdev_region(&pi433_devt, 0, N_PI433_MINORS, "pi433");
> -	if (status < 0)
> -		return status;
> -
> -	status = class_register(&pi433_class);
> -	if (status)
> -		goto unreg_chrdev;
> -
> -	root_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> -
> -	status = spi_register_driver(&pi433_spi_driver);
> -	if (status < 0)
> -		goto unreg_class_and_remove_dbfs;
> -
> -	return 0;
> -
> -unreg_class_and_remove_dbfs:
> -	debugfs_remove(root_dir);
> -	class_unregister(&pi433_class);
> -unreg_chrdev:
> -	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
> -	return status;
> -}
> -
> -module_init(pi433_init);
> -
> -static void __exit pi433_exit(void)
> -{
> -	spi_unregister_driver(&pi433_spi_driver);
> -	debugfs_remove(root_dir);
> -	class_unregister(&pi433_class);
> -	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
> -}
> -module_exit(pi433_exit);
> -
> -MODULE_AUTHOR("Marcus Wolf, <linux@wolf-entwicklungen.de>");
> -MODULE_DESCRIPTION("Driver for Pi433");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS("spi:pi433");
> diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
> deleted file mode 100644
> index 25ee0b77a32c..000000000000
> --- a/drivers/staging/pi433/pi433_if.h
> +++ /dev/null
> @@ -1,148 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * userspace interface for pi433 radio module
> - *
> - * Pi433 is a 433MHz radio module for the Raspberry Pi.
> - * It is based on the HopeRf Module RFM69CW. Therefore, inside of this
> - * driver you'll find an abstraction of the rf69 chip.
> - *
> - * If needed this driver could also be extended to support other
> - * devices based on HopeRf rf69 as well as HopeRf modules with a similar
> - * interface such as RFM69HCW, RFM12, RFM95 and so on.
> - *
> - * Copyright (C) 2016 Wolf-Entwicklungen
> - *	Marcus Wolf <linux@wolf-entwicklungen.de>
> - */
> -
> -#ifndef PI433_H
> -#define PI433_H
> -
> -#include <linux/types.h>
> -#include "rf69_enum.h"
> -
> -/*---------------------------------------------------------------------------*/
> -
> -enum option_on_off {
> -	OPTION_OFF,
> -	OPTION_ON
> -};
> -
> -/* IOCTL structs and commands */
> -
> -/**
> - * struct pi433_tx_cfg
> - * describes the configuration of the radio module for sending data
> - * @frequency:
> - * @bit_rate:
> - * @modulation:
> - * @data_mode:
> - * @preamble_length:
> - * @sync_pattern:
> - * @tx_start_condition:
> - * @payload_length:
> - * @repetitions:
> - *
> - * ATTENTION:
> - * If the contents of 'pi433_tx_cfg' ever change
> - * incompatibly, then the ioctl number (see define below) must change.
> - *
> - * NOTE: struct layout is the same in 64bit and 32bit userspace.
> - */
> -#define PI433_TX_CFG_IOCTL_NR	0
> -struct pi433_tx_cfg {
> -	__u32			frequency;
> -	__u16			bit_rate;
> -	__u32			dev_frequency;
> -	enum modulation		modulation;
> -	enum mod_shaping	mod_shaping;
> -
> -	enum pa_ramp		pa_ramp;
> -
> -	enum tx_start_condition	tx_start_condition;
> -
> -	__u16			repetitions;
> -
> -	/* packet format */
> -	enum option_on_off	enable_preamble;
> -	enum option_on_off	enable_sync;
> -	enum option_on_off	enable_length_byte;
> -	enum option_on_off	enable_address_byte;
> -	enum option_on_off	enable_crc;
> -
> -	__u16			preamble_length;
> -	__u8			sync_length;
> -	__u8			fixed_message_length;
> -
> -	__u8			sync_pattern[8];
> -	__u8			address_byte;
> -};
> -
> -/**
> - * struct pi433_rx_cfg
> - * describes the configuration of the radio module for receiving data
> - * @frequency:
> - * @bit_rate:
> - * @modulation:
> - * @data_mode:
> - * @preamble_length:
> - * @sync_pattern:
> - * @tx_start_condition:
> - * @payload_length:
> - * @repetitions:
> - *
> - * ATTENTION:
> - * If the contents of 'pi433_rx_cfg' ever change
> - * incompatibly, then the ioctl number (see define below) must change
> - *
> - * NOTE: struct layout is the same in 64bit and 32bit userspace.
> - */
> -#define PI433_RX_CFG_IOCTL_NR	1
> -struct pi433_rx_cfg {
> -	__u32			frequency;
> -	__u16			bit_rate;
> -	__u32			dev_frequency;
> -
> -	enum modulation		modulation;
> -
> -	__u8			rssi_threshold;
> -	enum threshold_decrement threshold_decrement;
> -	enum antenna_impedance	antenna_impedance;
> -	enum lna_gain		lna_gain;
> -	enum mantisse		bw_mantisse;	/* normal: 0x50 */
> -	__u8			bw_exponent;	/* during AFC: 0x8b */
> -	enum dagc		dagc;
> -
> -	/* packet format */
> -	enum option_on_off	enable_sync;
> -
> -	/* should be used in combination with sync, only */
> -	enum option_on_off	enable_length_byte;
> -
> -	/* operational with sync, only */
> -	enum address_filtering	enable_address_filtering;
> -
> -	/* only operational, if sync on and fixed length or length byte is used */
> -	enum option_on_off	enable_crc;
> -
> -	__u8			sync_length;
> -	__u8			fixed_message_length;
> -	__u32			bytes_to_drop;
> -
> -	__u8			sync_pattern[8];
> -	__u8			node_address;
> -	__u8			broadcast_address;
> -};
> -
> -#define PI433_IOC_MAGIC	'r'
> -
> -#define PI433_IOC_RD_TX_CFG                                             \
> -	_IOR(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_tx_cfg)])
> -#define PI433_IOC_WR_TX_CFG                                             \
> -	_IOW(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_tx_cfg)])
> -
> -#define PI433_IOC_RD_RX_CFG                                             \
> -	_IOR(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR, char[sizeof(struct pi433_rx_cfg)])
> -#define PI433_IOC_WR_RX_CFG                                             \
> -	_IOW(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR, char[sizeof(struct pi433_rx_cfg)])
> -
> -#endif /* PI433_H */
> diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
> deleted file mode 100644
> index 5a1c362badb6..000000000000
> --- a/drivers/staging/pi433/rf69.c
> +++ /dev/null
> @@ -1,832 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * abstraction of the spi interface of HopeRf rf69 radio module
> - *
> - * Copyright (C) 2016 Wolf-Entwicklungen
> - *	Marcus Wolf <linux@wolf-entwicklungen.de>
> - */
> -
> -#include <linux/types.h>
> -#include <linux/spi/spi.h>
> -#include <linux/units.h>
> -
> -#include "rf69.h"
> -#include "rf69_registers.h"
> -
> -#define F_OSC (32 * HZ_PER_MHZ)
> -
> -/*-------------------------------------------------------------------------*/
> -
> -u8 rf69_read_reg(struct spi_device *spi, u8 addr)
> -{
> -	return spi_w8r8(spi, addr);
> -}
> -
> -static int rf69_write_reg(struct spi_device *spi, u8 addr, u8 value)
> -{
> -	char buffer[2];
> -
> -	buffer[0] = addr | WRITE_BIT;
> -	buffer[1] = value;
> -
> -	return spi_write(spi, &buffer, ARRAY_SIZE(buffer));
> -}
> -
> -/*-------------------------------------------------------------------------*/
> -
> -static int rf69_set_bit(struct spi_device *spi, u8 reg, u8 mask)
> -{
> -	u8 tmp;
> -
> -	tmp = rf69_read_reg(spi, reg);
> -	tmp = tmp | mask;
> -	return rf69_write_reg(spi, reg, tmp);
> -}
> -
> -static int rf69_clear_bit(struct spi_device *spi, u8 reg, u8 mask)
> -{
> -	u8 tmp;
> -
> -	tmp = rf69_read_reg(spi, reg);
> -	tmp = tmp & ~mask;
> -	return rf69_write_reg(spi, reg, tmp);
> -}
> -
> -static inline int rf69_read_mod_write(struct spi_device *spi, u8 reg,
> -				      u8 mask, u8 value)
> -{
> -	u8 tmp;
> -
> -	tmp = rf69_read_reg(spi, reg);
> -	tmp = (tmp & ~mask) | value;
> -	return rf69_write_reg(spi, reg, tmp);
> -}
> -
> -/*-------------------------------------------------------------------------*/
> -
> -int rf69_get_version(struct spi_device *spi)
> -{
> -	return rf69_read_reg(spi, REG_VERSION);
> -}
> -
> -int rf69_set_mode(struct spi_device *spi, enum mode mode)
> -{
> -	static const u8 mode_map[] = {
> -		[transmit] = OPMODE_MODE_TRANSMIT,
> -		[receive] = OPMODE_MODE_RECEIVE,
> -		[synthesizer] = OPMODE_MODE_SYNTHESIZER,
> -		[standby] = OPMODE_MODE_STANDBY,
> -		[mode_sleep] = OPMODE_MODE_SLEEP,
> -	};
> -
> -	if (unlikely(mode >= ARRAY_SIZE(mode_map))) {
> -		dev_dbg(&spi->dev, "set: illegal mode %u\n", mode);
> -		return -EINVAL;
> -	}
> -
> -	return rf69_read_mod_write(spi, REG_OPMODE, MASK_OPMODE_MODE,
> -				   mode_map[mode]);
> -
> -	/*
> -	 * we are using packet mode, so this check is not really needed
> -	 * but waiting for mode ready is necessary when going from sleep
> -	 * because the FIFO may not be immediately available from previous mode
> -	 * while (_mode == RF69_MODE_SLEEP && (READ_REG(REG_IRQFLAGS1) &
> -		  RF_IRQFLAGS1_MODEREADY) == 0x00); // Wait for ModeReady
> -	 */
> -}
> -
> -int rf69_set_data_mode(struct spi_device *spi, u8 data_mode)
> -{
> -	return rf69_read_mod_write(spi, REG_DATAMODUL, MASK_DATAMODUL_MODE,
> -				   data_mode);
> -}
> -
> -int rf69_set_modulation(struct spi_device *spi, enum modulation modulation)
> -{
> -	static const u8 modulation_map[] = {
> -		[OOK] = DATAMODUL_MODULATION_TYPE_OOK,
> -		[FSK] = DATAMODUL_MODULATION_TYPE_FSK,
> -	};
> -
> -	if (unlikely(modulation >= ARRAY_SIZE(modulation_map))) {
> -		dev_dbg(&spi->dev, "set: illegal modulation %u\n", modulation);
> -		return -EINVAL;
> -	}
> -
> -	return rf69_read_mod_write(spi, REG_DATAMODUL,
> -				   MASK_DATAMODUL_MODULATION_TYPE,
> -				   modulation_map[modulation]);
> -}
> -
> -static enum modulation rf69_get_modulation(struct spi_device *spi)
> -{
> -	u8 modulation_reg;
> -
> -	modulation_reg = rf69_read_reg(spi, REG_DATAMODUL);
> -
> -	switch (modulation_reg & MASK_DATAMODUL_MODULATION_TYPE) {
> -	case DATAMODUL_MODULATION_TYPE_OOK:
> -		return OOK;
> -	case DATAMODUL_MODULATION_TYPE_FSK:
> -		return FSK;
> -	default:
> -		return UNDEF;
> -	}
> -}
> -
> -int rf69_set_modulation_shaping(struct spi_device *spi,
> -				enum mod_shaping mod_shaping)
> -{
> -	switch (rf69_get_modulation(spi)) {
> -	case FSK:
> -		switch (mod_shaping) {
> -		case SHAPING_OFF:
> -			return rf69_read_mod_write(spi, REG_DATAMODUL,
> -						   MASK_DATAMODUL_MODULATION_SHAPE,
> -						   DATAMODUL_MODULATION_SHAPE_NONE);
> -		case SHAPING_1_0:
> -			return rf69_read_mod_write(spi, REG_DATAMODUL,
> -						   MASK_DATAMODUL_MODULATION_SHAPE,
> -						   DATAMODUL_MODULATION_SHAPE_1_0);
> -		case SHAPING_0_5:
> -			return rf69_read_mod_write(spi, REG_DATAMODUL,
> -						   MASK_DATAMODUL_MODULATION_SHAPE,
> -						   DATAMODUL_MODULATION_SHAPE_0_5);
> -		case SHAPING_0_3:
> -			return rf69_read_mod_write(spi, REG_DATAMODUL,
> -						   MASK_DATAMODUL_MODULATION_SHAPE,
> -						   DATAMODUL_MODULATION_SHAPE_0_3);
> -		default:
> -			dev_dbg(&spi->dev, "set: illegal mod shaping for FSK %u\n", mod_shaping);
> -			return -EINVAL;
> -		}
> -	case OOK:
> -		switch (mod_shaping) {
> -		case SHAPING_OFF:
> -			return rf69_read_mod_write(spi, REG_DATAMODUL,
> -						   MASK_DATAMODUL_MODULATION_SHAPE,
> -						   DATAMODUL_MODULATION_SHAPE_NONE);
> -		case SHAPING_BR:
> -			return rf69_read_mod_write(spi, REG_DATAMODUL,
> -						   MASK_DATAMODUL_MODULATION_SHAPE,
> -						   DATAMODUL_MODULATION_SHAPE_BR);
> -		case SHAPING_2BR:
> -			return rf69_read_mod_write(spi, REG_DATAMODUL,
> -						   MASK_DATAMODUL_MODULATION_SHAPE,
> -						   DATAMODUL_MODULATION_SHAPE_2BR);
> -		default:
> -			dev_dbg(&spi->dev, "set: illegal mod shaping for OOK %u\n", mod_shaping);
> -			return -EINVAL;
> -		}
> -	default:
> -		dev_dbg(&spi->dev, "set: modulation undefined\n");
> -		return -EINVAL;
> -	}
> -}
> -
> -int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
> -{
> -	int retval;
> -	u32 bit_rate_reg;
> -	u8 msb;
> -	u8 lsb;
> -	enum modulation mod;
> -
> -	// check if modulation is configured
> -	mod = rf69_get_modulation(spi);
> -	if (mod == UNDEF) {
> -		dev_dbg(&spi->dev, "setBitRate: modulation is undefined\n");
> -		return -EINVAL;
> -	}
> -
> -	// check input value
> -	if (bit_rate < 1200 || (mod == OOK && bit_rate > 32768)) {
> -		dev_dbg(&spi->dev, "setBitRate: illegal input param\n");
> -		return -EINVAL;
> -	}
> -
> -	// calculate reg settings
> -	bit_rate_reg = (F_OSC / bit_rate);
> -
> -	msb = (bit_rate_reg & 0xff00) >> 8;
> -	lsb = (bit_rate_reg & 0xff);
> -
> -	// transmit to RF 69
> -	retval = rf69_write_reg(spi, REG_BITRATE_MSB, msb);
> -	if (retval)
> -		return retval;
> -	retval = rf69_write_reg(spi, REG_BITRATE_LSB, lsb);
> -	if (retval)
> -		return retval;
> -
> -	return 0;
> -}
> -
> -int rf69_set_deviation(struct spi_device *spi, u32 deviation)
> -{
> -	int retval;
> -	u64 f_reg;
> -	u64 f_step;
> -	u32 bit_rate_reg;
> -	u32 bit_rate;
> -	u8 msb;
> -	u8 lsb;
> -	u64 factor = 1000000; // to improve precision of calculation
> -
> -	// calculate bit rate
> -	bit_rate_reg = rf69_read_reg(spi, REG_BITRATE_MSB) << 8;
> -	bit_rate_reg |= rf69_read_reg(spi, REG_BITRATE_LSB);
> -	bit_rate = F_OSC / bit_rate_reg;
> -
> -	/*
> -	 * frequency deviation must exceed 600 Hz but not exceed
> -	 * 500kHz when taking bitrate dependency into consideration
> -	 * to ensure proper modulation
> -	 */
> -	if (deviation < 600 || (deviation + (bit_rate / 2)) > 500000) {
> -		dev_dbg(&spi->dev,
> -			"set_deviation: illegal input param: %u\n", deviation);
> -		return -EINVAL;
> -	}
> -
> -	// calculat f step
> -	f_step = F_OSC * factor;
> -	do_div(f_step, 524288); //  524288 = 2^19
> -
> -	// calculate register settings
> -	f_reg = deviation * factor;
> -	do_div(f_reg, f_step);
> -
> -	msb = (f_reg & 0xff00) >> 8;
> -	lsb = (f_reg & 0xff);
> -
> -	// check msb
> -	if (msb & ~FDEVMASB_MASK) {
> -		dev_dbg(&spi->dev, "set_deviation: err in calc of msb\n");
> -		return -EINVAL;
> -	}
> -
> -	// write to chip
> -	retval = rf69_write_reg(spi, REG_FDEV_MSB, msb);
> -	if (retval)
> -		return retval;
> -	retval = rf69_write_reg(spi, REG_FDEV_LSB, lsb);
> -	if (retval)
> -		return retval;
> -
> -	return 0;
> -}
> -
> -int rf69_set_frequency(struct spi_device *spi, u32 frequency)
> -{
> -	int retval;
> -	u32 f_max;
> -	u64 f_reg;
> -	u64 f_step;
> -	u8 msb;
> -	u8 mid;
> -	u8 lsb;
> -	u64 factor = 1000000; // to improve precision of calculation
> -
> -	// calculat f step
> -	f_step = F_OSC * factor;
> -	do_div(f_step, 524288); //  524288 = 2^19
> -
> -	// check input value
> -	f_max = div_u64(f_step * 8388608, factor);
> -	if (frequency > f_max) {
> -		dev_dbg(&spi->dev, "setFrequency: illegal input param\n");
> -		return -EINVAL;
> -	}
> -
> -	// calculate reg settings
> -	f_reg = frequency * factor;
> -	do_div(f_reg, f_step);
> -
> -	msb = (f_reg & 0xff0000) >> 16;
> -	mid = (f_reg & 0xff00)   >>  8;
> -	lsb = (f_reg & 0xff);
> -
> -	// write to chip
> -	retval = rf69_write_reg(spi, REG_FRF_MSB, msb);
> -	if (retval)
> -		return retval;
> -	retval = rf69_write_reg(spi, REG_FRF_MID, mid);
> -	if (retval)
> -		return retval;
> -	retval = rf69_write_reg(spi, REG_FRF_LSB, lsb);
> -	if (retval)
> -		return retval;
> -
> -	return 0;
> -}
> -
> -int rf69_enable_amplifier(struct spi_device *spi, u8 amplifier_mask)
> -{
> -	return rf69_set_bit(spi, REG_PALEVEL, amplifier_mask);
> -}
> -
> -int rf69_disable_amplifier(struct spi_device *spi, u8 amplifier_mask)
> -{
> -	return rf69_clear_bit(spi, REG_PALEVEL, amplifier_mask);
> -}
> -
> -int rf69_set_output_power_level(struct spi_device *spi, u8 power_level)
> -{
> -	u8 pa_level, ocp, test_pa1, test_pa2;
> -	bool pa0, pa1, pa2, high_power;
> -	u8 min_power_level;
> -
> -	// check register pa_level
> -	pa_level = rf69_read_reg(spi, REG_PALEVEL);
> -	pa0 = pa_level & MASK_PALEVEL_PA0;
> -	pa1 = pa_level & MASK_PALEVEL_PA1;
> -	pa2 = pa_level & MASK_PALEVEL_PA2;
> -
> -	// check high power mode
> -	ocp = rf69_read_reg(spi, REG_OCP);
> -	test_pa1 = rf69_read_reg(spi, REG_TESTPA1);
> -	test_pa2 = rf69_read_reg(spi, REG_TESTPA2);
> -	high_power = (ocp == 0x0f) && (test_pa1 == 0x5d) && (test_pa2 == 0x7c);
> -
> -	if (pa0 && !pa1 && !pa2) {
> -		power_level += 18;
> -		min_power_level = 0;
> -	} else if (!pa0 && pa1 && !pa2) {
> -		power_level += 18;
> -		min_power_level = 16;
> -	} else if (!pa0 && pa1 && pa2) {
> -		if (high_power)
> -			power_level += 11;
> -		else
> -			power_level += 14;
> -		min_power_level = 16;
> -	} else {
> -		goto failed;
> -	}
> -
> -	// check input value
> -	if (power_level > 0x1f)
> -		goto failed;
> -
> -	if (power_level < min_power_level)
> -		goto failed;
> -
> -	// write value
> -	return rf69_read_mod_write(spi, REG_PALEVEL, MASK_PALEVEL_OUTPUT_POWER,
> -				   power_level);
> -failed:
> -	dev_dbg(&spi->dev, "set: illegal power level %u\n", power_level);
> -	return -EINVAL;
> -}
> -
> -int rf69_set_pa_ramp(struct spi_device *spi, enum pa_ramp pa_ramp)
> -{
> -	static const u8 pa_ramp_map[] = {
> -		[ramp3400] = PARAMP_3400,
> -		[ramp2000] = PARAMP_2000,
> -		[ramp1000] = PARAMP_1000,
> -		[ramp500] = PARAMP_500,
> -		[ramp250] = PARAMP_250,
> -		[ramp125] = PARAMP_125,
> -		[ramp100] = PARAMP_100,
> -		[ramp62] = PARAMP_62,
> -		[ramp50] = PARAMP_50,
> -		[ramp40] = PARAMP_40,
> -		[ramp31] = PARAMP_31,
> -		[ramp25] = PARAMP_25,
> -		[ramp20] = PARAMP_20,
> -		[ramp15] = PARAMP_15,
> -		[ramp10] = PARAMP_10,
> -	};
> -
> -	if (unlikely(pa_ramp >= ARRAY_SIZE(pa_ramp_map))) {
> -		dev_dbg(&spi->dev, "set: illegal pa_ramp %u\n", pa_ramp);
> -		return -EINVAL;
> -	}
> -
> -	return rf69_write_reg(spi, REG_PARAMP, pa_ramp_map[pa_ramp]);
> -}
> -
> -int rf69_set_antenna_impedance(struct spi_device *spi,
> -			       enum antenna_impedance antenna_impedance)
> -{
> -	switch (antenna_impedance) {
> -	case fifty_ohm:
> -		return rf69_clear_bit(spi, REG_LNA, MASK_LNA_ZIN);
> -	case two_hundred_ohm:
> -		return rf69_set_bit(spi, REG_LNA, MASK_LNA_ZIN);
> -	default:
> -		dev_dbg(&spi->dev, "set: illegal antenna impedance %u\n", antenna_impedance);
> -		return -EINVAL;
> -	}
> -}
> -
> -int rf69_set_lna_gain(struct spi_device *spi, enum lna_gain lna_gain)
> -{
> -	static const u8 lna_gain_map[] = {
> -		[automatic] = LNA_GAIN_AUTO,
> -		[max] = LNA_GAIN_MAX,
> -		[max_minus_6] = LNA_GAIN_MAX_MINUS_6,
> -		[max_minus_12] = LNA_GAIN_MAX_MINUS_12,
> -		[max_minus_24] = LNA_GAIN_MAX_MINUS_24,
> -		[max_minus_36] = LNA_GAIN_MAX_MINUS_36,
> -		[max_minus_48] = LNA_GAIN_MAX_MINUS_48,
> -	};
> -
> -	if (unlikely(lna_gain >= ARRAY_SIZE(lna_gain_map))) {
> -		dev_dbg(&spi->dev, "set: illegal lna gain %u\n", lna_gain);
> -		return -EINVAL;
> -	}
> -
> -	return rf69_read_mod_write(spi, REG_LNA, MASK_LNA_GAIN,
> -				   lna_gain_map[lna_gain]);
> -}
> -
> -static int rf69_set_bandwidth_intern(struct spi_device *spi, u8 reg,
> -				     enum mantisse mantisse, u8 exponent)
> -{
> -	u8 bandwidth;
> -
> -	// check value for mantisse and exponent
> -	if (exponent > 7) {
> -		dev_dbg(&spi->dev, "set: illegal bandwidth exponent %u\n", exponent);
> -		return -EINVAL;
> -	}
> -
> -	if (mantisse != mantisse16 &&
> -	    mantisse != mantisse20 &&
> -	    mantisse != mantisse24) {
> -		dev_dbg(&spi->dev, "set: illegal bandwidth mantisse %u\n", mantisse);
> -		return -EINVAL;
> -	}
> -
> -	// read old value
> -	bandwidth = rf69_read_reg(spi, reg);
> -
> -	// "delete" mantisse and exponent = just keep the DCC setting
> -	bandwidth = bandwidth & MASK_BW_DCC_FREQ;
> -
> -	// add new mantisse
> -	switch (mantisse) {
> -	case mantisse16:
> -		bandwidth = bandwidth | BW_MANT_16;
> -		break;
> -	case mantisse20:
> -		bandwidth = bandwidth | BW_MANT_20;
> -		break;
> -	case mantisse24:
> -		bandwidth = bandwidth | BW_MANT_24;
> -		break;
> -	}
> -
> -	// add new exponent
> -	bandwidth = bandwidth | exponent;
> -
> -	// write back
> -	return rf69_write_reg(spi, reg, bandwidth);
> -}
> -
> -int rf69_set_bandwidth(struct spi_device *spi, enum mantisse mantisse,
> -		       u8 exponent)
> -{
> -	return rf69_set_bandwidth_intern(spi, REG_RXBW, mantisse, exponent);
> -}
> -
> -int rf69_set_bandwidth_during_afc(struct spi_device *spi,
> -				  enum mantisse mantisse,
> -				  u8 exponent)
> -{
> -	return rf69_set_bandwidth_intern(spi, REG_AFCBW, mantisse, exponent);
> -}
> -
> -int rf69_set_ook_threshold_dec(struct spi_device *spi,
> -			       enum threshold_decrement threshold_decrement)
> -{
> -	static const u8 td_map[] = {
> -		[dec_every8th] = OOKPEAK_THRESHDEC_EVERY_8TH,
> -		[dec_every4th] = OOKPEAK_THRESHDEC_EVERY_4TH,
> -		[dec_every2nd] = OOKPEAK_THRESHDEC_EVERY_2ND,
> -		[dec_once] = OOKPEAK_THRESHDEC_ONCE,
> -		[dec_twice] = OOKPEAK_THRESHDEC_TWICE,
> -		[dec_4times] = OOKPEAK_THRESHDEC_4_TIMES,
> -		[dec_8times] = OOKPEAK_THRESHDEC_8_TIMES,
> -		[dec_16times] = OOKPEAK_THRESHDEC_16_TIMES,
> -	};
> -
> -	if (unlikely(threshold_decrement >= ARRAY_SIZE(td_map))) {
> -		dev_dbg(&spi->dev, "set: illegal OOK threshold decrement %u\n",
> -			threshold_decrement);
> -		return -EINVAL;
> -	}
> -
> -	return rf69_read_mod_write(spi, REG_OOKPEAK, MASK_OOKPEAK_THRESDEC,
> -				   td_map[threshold_decrement]);
> -}
> -
> -int rf69_set_dio_mapping(struct spi_device *spi, u8 dio_number, u8 value)
> -{
> -	u8 mask;
> -	u8 shift;
> -	u8 dio_addr;
> -	u8 dio_value;
> -
> -	switch (dio_number) {
> -	case 0:
> -		mask = MASK_DIO0;
> -		shift = SHIFT_DIO0;
> -		dio_addr = REG_DIOMAPPING1;
> -		break;
> -	case 1:
> -		mask = MASK_DIO1;
> -		shift = SHIFT_DIO1;
> -		dio_addr = REG_DIOMAPPING1;
> -		break;
> -	case 2:
> -		mask = MASK_DIO2;
> -		shift = SHIFT_DIO2;
> -		dio_addr = REG_DIOMAPPING1;
> -		break;
> -	case 3:
> -		mask = MASK_DIO3;
> -		shift = SHIFT_DIO3;
> -		dio_addr = REG_DIOMAPPING1;
> -		break;
> -	case 4:
> -		mask = MASK_DIO4;
> -		shift = SHIFT_DIO4;
> -		dio_addr = REG_DIOMAPPING2;
> -		break;
> -	case 5:
> -		mask = MASK_DIO5;
> -		shift = SHIFT_DIO5;
> -		dio_addr = REG_DIOMAPPING2;
> -		break;
> -	default:
> -		dev_dbg(&spi->dev, "set: illegal dio number %u\n", dio_number);
> -		return -EINVAL;
> -	}
> -
> -	// read reg
> -	dio_value = rf69_read_reg(spi, dio_addr);
> -	// delete old value
> -	dio_value = dio_value & ~mask;
> -	// add new value
> -	dio_value = dio_value | value << shift;
> -	// write back
> -	return rf69_write_reg(spi, dio_addr, dio_value);
> -}
> -
> -int rf69_set_rssi_threshold(struct spi_device *spi, u8 threshold)
> -{
> -	/* no value check needed - u8 exactly matches register size */
> -
> -	return rf69_write_reg(spi, REG_RSSITHRESH, threshold);
> -}
> -
> -int rf69_set_preamble_length(struct spi_device *spi, u16 preamble_length)
> -{
> -	int retval;
> -	u8 msb, lsb;
> -
> -	/* no value check needed - u16 exactly matches register size */
> -
> -	/* calculate reg settings */
> -	msb = (preamble_length & 0xff00) >> 8;
> -	lsb = (preamble_length & 0xff);
> -
> -	/* transmit to chip */
> -	retval = rf69_write_reg(spi, REG_PREAMBLE_MSB, msb);
> -	if (retval)
> -		return retval;
> -	return rf69_write_reg(spi, REG_PREAMBLE_LSB, lsb);
> -}
> -
> -int rf69_enable_sync(struct spi_device *spi)
> -{
> -	return rf69_set_bit(spi, REG_SYNC_CONFIG, MASK_SYNC_CONFIG_SYNC_ON);
> -}
> -
> -int rf69_disable_sync(struct spi_device *spi)
> -{
> -	return rf69_clear_bit(spi, REG_SYNC_CONFIG, MASK_SYNC_CONFIG_SYNC_ON);
> -}
> -
> -int rf69_set_fifo_fill_condition(struct spi_device *spi,
> -				 enum fifo_fill_condition fifo_fill_condition)
> -{
> -	switch (fifo_fill_condition) {
> -	case always:
> -		return rf69_set_bit(spi, REG_SYNC_CONFIG,
> -				    MASK_SYNC_CONFIG_FIFO_FILL_CONDITION);
> -	case after_sync_interrupt:
> -		return rf69_clear_bit(spi, REG_SYNC_CONFIG,
> -				      MASK_SYNC_CONFIG_FIFO_FILL_CONDITION);
> -	default:
> -		dev_dbg(&spi->dev, "set: illegal fifo fill condition %u\n", fifo_fill_condition);
> -		return -EINVAL;
> -	}
> -}
> -
> -int rf69_set_sync_size(struct spi_device *spi, u8 sync_size)
> -{
> -	// check input value
> -	if (sync_size > 0x07) {
> -		dev_dbg(&spi->dev, "set: illegal sync size %u\n", sync_size);
> -		return -EINVAL;
> -	}
> -
> -	// write value
> -	return rf69_read_mod_write(spi, REG_SYNC_CONFIG,
> -				   MASK_SYNC_CONFIG_SYNC_SIZE,
> -				   (sync_size << 3));
> -}
> -
> -int rf69_set_sync_values(struct spi_device *spi, u8 sync_values[8])
> -{
> -	int retval = 0;
> -
> -	retval += rf69_write_reg(spi, REG_SYNCVALUE1, sync_values[0]);
> -	retval += rf69_write_reg(spi, REG_SYNCVALUE2, sync_values[1]);
> -	retval += rf69_write_reg(spi, REG_SYNCVALUE3, sync_values[2]);
> -	retval += rf69_write_reg(spi, REG_SYNCVALUE4, sync_values[3]);
> -	retval += rf69_write_reg(spi, REG_SYNCVALUE5, sync_values[4]);
> -	retval += rf69_write_reg(spi, REG_SYNCVALUE6, sync_values[5]);
> -	retval += rf69_write_reg(spi, REG_SYNCVALUE7, sync_values[6]);
> -	retval += rf69_write_reg(spi, REG_SYNCVALUE8, sync_values[7]);
> -
> -	return retval;
> -}
> -
> -int rf69_set_packet_format(struct spi_device *spi,
> -			   enum packet_format packet_format)
> -{
> -	switch (packet_format) {
> -	case packet_length_var:
> -		return rf69_set_bit(spi, REG_PACKETCONFIG1,
> -				    MASK_PACKETCONFIG1_PACKET_FORMAT_VARIABLE);
> -	case packet_length_fix:
> -		return rf69_clear_bit(spi, REG_PACKETCONFIG1,
> -				      MASK_PACKETCONFIG1_PACKET_FORMAT_VARIABLE);
> -	default:
> -		dev_dbg(&spi->dev, "set: illegal packet format %u\n", packet_format);
> -		return -EINVAL;
> -	}
> -}
> -
> -int rf69_enable_crc(struct spi_device *spi)
> -{
> -	return rf69_set_bit(spi, REG_PACKETCONFIG1, MASK_PACKETCONFIG1_CRC_ON);
> -}
> -
> -int rf69_disable_crc(struct spi_device *spi)
> -{
> -	return rf69_clear_bit(spi, REG_PACKETCONFIG1, MASK_PACKETCONFIG1_CRC_ON);
> -}
> -
> -int rf69_set_address_filtering(struct spi_device *spi,
> -			       enum address_filtering address_filtering)
> -{
> -	static const u8 af_map[] = {
> -		[filtering_off] = PACKETCONFIG1_ADDRESSFILTERING_OFF,
> -		[node_address] = PACKETCONFIG1_ADDRESSFILTERING_NODE,
> -		[node_or_broadcast_address] =
> -			PACKETCONFIG1_ADDRESSFILTERING_NODEBROADCAST,
> -	};
> -
> -	if (unlikely(address_filtering >= ARRAY_SIZE(af_map))) {
> -		dev_dbg(&spi->dev, "set: illegal address filtering %u\n", address_filtering);
> -		return -EINVAL;
> -	}
> -
> -	return rf69_read_mod_write(spi, REG_PACKETCONFIG1,
> -				   MASK_PACKETCONFIG1_ADDRESSFILTERING,
> -				   af_map[address_filtering]);
> -}
> -
> -int rf69_set_payload_length(struct spi_device *spi, u8 payload_length)
> -{
> -	return rf69_write_reg(spi, REG_PAYLOAD_LENGTH, payload_length);
> -}
> -
> -int rf69_set_node_address(struct spi_device *spi, u8 node_address)
> -{
> -	return rf69_write_reg(spi, REG_NODEADRS, node_address);
> -}
> -
> -int rf69_set_broadcast_address(struct spi_device *spi, u8 broadcast_address)
> -{
> -	return rf69_write_reg(spi, REG_BROADCASTADRS, broadcast_address);
> -}
> -
> -int rf69_set_tx_start_condition(struct spi_device *spi,
> -				enum tx_start_condition tx_start_condition)
> -{
> -	switch (tx_start_condition) {
> -	case fifo_level:
> -		return rf69_clear_bit(spi, REG_FIFO_THRESH,
> -				      MASK_FIFO_THRESH_TXSTART);
> -	case fifo_not_empty:
> -		return rf69_set_bit(spi, REG_FIFO_THRESH,
> -				    MASK_FIFO_THRESH_TXSTART);
> -	default:
> -		dev_dbg(&spi->dev, "set: illegal tx start condition %u\n", tx_start_condition);
> -		return -EINVAL;
> -	}
> -}
> -
> -int rf69_set_fifo_threshold(struct spi_device *spi, u8 threshold)
> -{
> -	int retval;
> -
> -	/* check input value */
> -	if (threshold & ~MASK_FIFO_THRESH_VALUE) {
> -		dev_dbg(&spi->dev, "set: illegal fifo threshold %u\n", threshold);
> -		return -EINVAL;
> -	}
> -
> -	/* write value */
> -	retval = rf69_read_mod_write(spi, REG_FIFO_THRESH,
> -				     MASK_FIFO_THRESH_VALUE,
> -				     threshold);
> -	if (retval)
> -		return retval;
> -
> -	/*
> -	 * access the fifo to activate new threshold
> -	 * retval (mis-) used as buffer here
> -	 */
> -	return rf69_read_fifo(spi, (u8 *)&retval, 1);
> -}
> -
> -int rf69_set_dagc(struct spi_device *spi, enum dagc dagc)
> -{
> -	static const u8 dagc_map[] = {
> -		[normal_mode] = DAGC_NORMAL,
> -		[improve] = DAGC_IMPROVED_LOWBETA0,
> -		[improve_for_low_modulation_index] = DAGC_IMPROVED_LOWBETA1,
> -	};
> -
> -	if (unlikely(dagc >= ARRAY_SIZE(dagc_map))) {
> -		dev_dbg(&spi->dev, "set: illegal dagc %u\n", dagc);
> -		return -EINVAL;
> -	}
> -
> -	return rf69_write_reg(spi, REG_TESTDAGC, dagc_map[dagc]);
> -}
> -
> -/*-------------------------------------------------------------------------*/
> -
> -int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
> -{
> -	int i;
> -	struct spi_transfer transfer;
> -	u8 local_buffer[FIFO_SIZE + 1] = {};
> -	int retval;
> -
> -	if (size > FIFO_SIZE) {
> -		dev_dbg(&spi->dev,
> -			"read fifo: passed in buffer bigger then internal buffer\n");
> -		return -EMSGSIZE;
> -	}
> -
> -	/* prepare a bidirectional transfer */
> -	local_buffer[0] = REG_FIFO;
> -	memset(&transfer, 0, sizeof(transfer));
> -	transfer.tx_buf = local_buffer;
> -	transfer.rx_buf = local_buffer;
> -	transfer.len	= size + 1;
> -
> -	retval = spi_sync_transfer(spi, &transfer, 1);
> -
> -	/* print content read from fifo for debugging purposes */
> -	for (i = 0; i < size; i++)
> -		dev_dbg(&spi->dev, "%d - 0x%x\n", i, local_buffer[i + 1]);
> -
> -	memcpy(buffer, &local_buffer[1], size);
> -
> -	return retval;
> -}
> -
> -int rf69_write_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
> -{
> -	int i;
> -	u8 local_buffer[FIFO_SIZE + 1];
> -
> -	if (size > FIFO_SIZE) {
> -		dev_dbg(&spi->dev,
> -			"write fifo: passed in buffer bigger then internal buffer\n");
> -		return -EMSGSIZE;
> -	}
> -
> -	local_buffer[0] = REG_FIFO | WRITE_BIT;
> -	memcpy(&local_buffer[1], buffer, size);
> -
> -	/* print content written from fifo for debugging purposes */
> -	for (i = 0; i < size; i++)
> -		dev_dbg(&spi->dev, "%d - 0x%x\n", i, buffer[i]);
> -
> -	return spi_write(spi, local_buffer, size + 1);
> -}
> -
> diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
> deleted file mode 100644
> index 76f0f9896a52..000000000000
> --- a/drivers/staging/pi433/rf69.h
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * hardware abstraction/register access for HopeRf rf69 radio module
> - *
> - * Copyright (C) 2016 Wolf-Entwicklungen
> - *	Marcus Wolf <linux@wolf-entwicklungen.de>
> - */
> -#ifndef RF69_H
> -#define RF69_H
> -
> -#include "rf69_enum.h"
> -#include "rf69_registers.h"
> -
> -#define FIFO_SIZE	66		/* bytes */
> -
> -u8 rf69_read_reg(struct spi_device *spi, u8 addr);
> -int rf69_get_version(struct spi_device *spi);
> -int rf69_set_mode(struct spi_device *spi, enum mode mode);
> -int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
> -int rf69_set_modulation(struct spi_device *spi, enum modulation modulation);
> -int rf69_set_modulation_shaping(struct spi_device *spi,
> -				enum mod_shaping mod_shaping);
> -int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate);
> -int rf69_set_deviation(struct spi_device *spi, u32 deviation);
> -int rf69_set_frequency(struct spi_device *spi, u32 frequency);
> -int rf69_enable_amplifier(struct spi_device *spi, u8 amplifier_mask);
> -int rf69_disable_amplifier(struct spi_device *spi, u8 amplifier_mask);
> -int rf69_set_output_power_level(struct spi_device *spi, u8 power_level);
> -int rf69_set_pa_ramp(struct spi_device *spi, enum pa_ramp pa_ramp);
> -int rf69_set_antenna_impedance(struct spi_device *spi,
> -			       enum antenna_impedance antenna_impedance);
> -int rf69_set_lna_gain(struct spi_device *spi, enum lna_gain lna_gain);
> -int rf69_set_bandwidth(struct spi_device *spi, enum mantisse mantisse,
> -		       u8 exponent);
> -int rf69_set_bandwidth_during_afc(struct spi_device *spi,
> -				  enum mantisse mantisse,
> -				  u8 exponent);
> -int rf69_set_ook_threshold_dec(struct spi_device *spi,
> -			       enum threshold_decrement threshold_decrement);
> -int rf69_set_dio_mapping(struct spi_device *spi, u8 dio_number, u8 value);
> -int rf69_set_rssi_threshold(struct spi_device *spi, u8 threshold);
> -int rf69_set_preamble_length(struct spi_device *spi, u16 preamble_length);
> -int rf69_enable_sync(struct spi_device *spi);
> -int rf69_disable_sync(struct spi_device *spi);
> -int rf69_set_fifo_fill_condition(struct spi_device *spi,
> -				 enum fifo_fill_condition fifo_fill_condition);
> -int rf69_set_sync_size(struct spi_device *spi, u8 sync_size);
> -int rf69_set_sync_values(struct spi_device *spi, u8 sync_values[8]);
> -int rf69_set_packet_format(struct spi_device *spi,
> -			   enum packet_format packet_format);
> -int rf69_enable_crc(struct spi_device *spi);
> -int rf69_disable_crc(struct spi_device *spi);
> -int rf69_set_address_filtering(struct spi_device *spi,
> -			       enum address_filtering address_filtering);
> -int rf69_set_payload_length(struct spi_device *spi, u8 payload_length);
> -int rf69_set_node_address(struct spi_device *spi, u8 node_address);
> -int rf69_set_broadcast_address(struct spi_device *spi, u8 broadcast_address);
> -int rf69_set_tx_start_condition(struct spi_device *spi,
> -				enum tx_start_condition tx_start_condition);
> -int rf69_set_fifo_threshold(struct spi_device *spi, u8 threshold);
> -int rf69_set_dagc(struct spi_device *spi, enum dagc dagc);
> -
> -int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size);
> -int rf69_write_fifo(struct spi_device *spi, u8 *buffer, unsigned int size);
> -
> -#endif
> diff --git a/drivers/staging/pi433/rf69_enum.h b/drivers/staging/pi433/rf69_enum.h
> deleted file mode 100644
> index 9dc906124e98..000000000000
> --- a/drivers/staging/pi433/rf69_enum.h
> +++ /dev/null
> @@ -1,126 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * enumerations for HopeRf rf69 radio module
> - *
> - * Copyright (C) 2016 Wolf-Entwicklungen
> - *	Marcus Wolf <linux@wolf-entwicklungen.de>
> - */
> -
> -#ifndef RF69_ENUM_H
> -#define RF69_ENUM_H
> -
> -enum mode {
> -	mode_sleep,
> -	standby,
> -	synthesizer,
> -	transmit,
> -	receive
> -};
> -
> -enum modulation {
> -	OOK,
> -	FSK,
> -	UNDEF
> -};
> -
> -enum mod_shaping {
> -	SHAPING_OFF,
> -	SHAPING_1_0,
> -	SHAPING_0_5,
> -	SHAPING_0_3,
> -	SHAPING_BR,
> -	SHAPING_2BR
> -};
> -
> -enum pa_ramp {
> -	ramp3400,
> -	ramp2000,
> -	ramp1000,
> -	ramp500,
> -	ramp250,
> -	ramp125,
> -	ramp100,
> -	ramp62,
> -	ramp50,
> -	ramp40,
> -	ramp31,
> -	ramp25,
> -	ramp20,
> -	ramp15,
> -	ramp12,
> -	ramp10
> -};
> -
> -enum antenna_impedance {
> -	fifty_ohm,
> -	two_hundred_ohm
> -};
> -
> -enum lna_gain {
> -	automatic,
> -	max,
> -	max_minus_6,
> -	max_minus_12,
> -	max_minus_24,
> -	max_minus_36,
> -	max_minus_48,
> -	undefined
> -};
> -
> -enum mantisse {
> -	mantisse16,
> -	mantisse20,
> -	mantisse24
> -};
> -
> -enum threshold_decrement {
> -	dec_every8th,
> -	dec_every4th,
> -	dec_every2nd,
> -	dec_once,
> -	dec_twice,
> -	dec_4times,
> -	dec_8times,
> -	dec_16times
> -};
> -
> -enum fifo_fill_condition {
> -	after_sync_interrupt,
> -	always
> -};
> -
> -enum packet_format {
> -	/*
> -	 * Used when the size of payload is fixed in advance. This mode of
> -	 * operation may be of interest to minimize RF overhead by 1 byte as
> -	 * no length byte field is required
> -	 */
> -	packet_length_fix,
> -	/*
> -	 * Used when the size of payload isn't known in advance. It requires the
> -	 * transmitter to send the length byte in each packet so the receiver
> -	 * would know how to operate properly
> -	 */
> -	packet_length_var
> -};
> -
> -enum tx_start_condition {
> -	/* the number of bytes in the FIFO exceeds FIFO_THRESHOLD */
> -	fifo_level,
> -	/* at least one byte in the FIFO */
> -	fifo_not_empty
> -};
> -
> -enum address_filtering {
> -	filtering_off,
> -	node_address,
> -	node_or_broadcast_address
> -};
> -
> -enum dagc {
> -	normal_mode,
> -	improve,
> -	improve_for_low_modulation_index
> -};
> -
> -#endif
> diff --git a/drivers/staging/pi433/rf69_registers.h b/drivers/staging/pi433/rf69_registers.h
> deleted file mode 100644
> index 0d6737738841..000000000000
> --- a/drivers/staging/pi433/rf69_registers.h
> +++ /dev/null
> @@ -1,478 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * register description for HopeRf rf69 radio module
> - *
> - * Copyright (C) 2016 Wolf-Entwicklungen
> - *	Marcus Wolf <linux@wolf-entwicklungen.de>
> - */
> -
> -/*******************************************/
> -/* RF69 register addresses		   */
> -/*******************************************/
> -#define  REG_FIFO			0x00
> -#define  REG_OPMODE			0x01
> -#define  REG_DATAMODUL			0x02
> -#define  REG_BITRATE_MSB		0x03
> -#define  REG_BITRATE_LSB		0x04
> -#define  REG_FDEV_MSB			0x05
> -#define  REG_FDEV_LSB			0x06
> -#define  REG_FRF_MSB			0x07
> -#define  REG_FRF_MID			0x08
> -#define  REG_FRF_LSB			0x09
> -#define  REG_OSC1			0x0A
> -#define  REG_AFCCTRL			0x0B
> -#define  REG_LOWBAT			0x0C
> -#define  REG_LISTEN1			0x0D
> -#define  REG_LISTEN2			0x0E
> -#define  REG_LISTEN3			0x0F
> -#define  REG_VERSION			0x10
> -#define  REG_PALEVEL			0x11
> -#define  REG_PARAMP			0x12
> -#define  REG_OCP			0x13
> -#define  REG_AGCREF			0x14 /* not available on RF69 */
> -#define  REG_AGCTHRESH1			0x15 /* not available on RF69 */
> -#define  REG_AGCTHRESH2			0x16 /* not available on RF69 */
> -#define  REG_AGCTHRESH3			0x17 /* not available on RF69 */
> -#define  REG_LNA			0x18
> -#define  REG_RXBW			0x19
> -#define  REG_AFCBW			0x1A
> -#define  REG_OOKPEAK			0x1B
> -#define  REG_OOKAVG			0x1C
> -#define  REG_OOKFIX			0x1D
> -#define  REG_AFCFEI			0x1E
> -#define  REG_AFCMSB			0x1F
> -#define  REG_AFCLSB			0x20
> -#define  REG_FEIMSB			0x21
> -#define  REG_FEILSB			0x22
> -#define  REG_RSSICONFIG			0x23
> -#define  REG_RSSIVALUE			0x24
> -#define  REG_DIOMAPPING1		0x25
> -#define  REG_DIOMAPPING2		0x26
> -#define  REG_IRQFLAGS1			0x27
> -#define  REG_IRQFLAGS2			0x28
> -#define  REG_RSSITHRESH			0x29
> -#define  REG_RXTIMEOUT1			0x2A
> -#define  REG_RXTIMEOUT2			0x2B
> -#define  REG_PREAMBLE_MSB		0x2C
> -#define  REG_PREAMBLE_LSB		0x2D
> -#define  REG_SYNC_CONFIG		0x2E
> -#define  REG_SYNCVALUE1			0x2F
> -#define  REG_SYNCVALUE2			0x30
> -#define  REG_SYNCVALUE3			0x31
> -#define  REG_SYNCVALUE4			0x32
> -#define  REG_SYNCVALUE5			0x33
> -#define  REG_SYNCVALUE6			0x34
> -#define  REG_SYNCVALUE7			0x35
> -#define  REG_SYNCVALUE8			0x36
> -#define  REG_PACKETCONFIG1		0x37
> -#define  REG_PAYLOAD_LENGTH		0x38
> -#define  REG_NODEADRS			0x39
> -#define  REG_BROADCASTADRS		0x3A
> -#define  REG_AUTOMODES			0x3B
> -#define  REG_FIFO_THRESH		0x3C
> -#define  REG_PACKETCONFIG2		0x3D
> -#define  REG_AESKEY1			0x3E
> -#define  REG_AESKEY2			0x3F
> -#define  REG_AESKEY3			0x40
> -#define  REG_AESKEY4			0x41
> -#define  REG_AESKEY5			0x42
> -#define  REG_AESKEY6			0x43
> -#define  REG_AESKEY7			0x44
> -#define  REG_AESKEY8			0x45
> -#define  REG_AESKEY9			0x46
> -#define  REG_AESKEY10			0x47
> -#define  REG_AESKEY11			0x48
> -#define  REG_AESKEY12			0x49
> -#define  REG_AESKEY13			0x4A
> -#define  REG_AESKEY14			0x4B
> -#define  REG_AESKEY15			0x4C
> -#define  REG_AESKEY16			0x4D
> -#define  REG_TEMP1			0x4E
> -#define  REG_TEMP2			0x4F
> -#define  REG_TESTLNA			0x58
> -#define  REG_TESTPA1			0x5A /* only present on RFM69HW */
> -#define  REG_TESTPA2			0x5C /* only present on RFM69HW */
> -#define  REG_TESTDAGC			0x6F
> -#define  REG_TESTAFC			0x71
> -
> -/******************************************************/
> -/* RF69/SX1231 bit definition				*/
> -/******************************************************/
> -/* write bit */
> -#define WRITE_BIT				0x80
> -
> -/* RegOpMode */
> -#define  MASK_OPMODE_SEQUENCER_OFF		0x80
> -#define  MASK_OPMODE_LISTEN_ON			0x40
> -#define  MASK_OPMODE_LISTEN_ABORT		0x20
> -#define  MASK_OPMODE_MODE			0x1C
> -
> -#define  OPMODE_MODE_SLEEP			0x00
> -#define  OPMODE_MODE_STANDBY			0x04 /* default */
> -#define  OPMODE_MODE_SYNTHESIZER		0x08
> -#define  OPMODE_MODE_TRANSMIT			0x0C
> -#define  OPMODE_MODE_RECEIVE			0x10
> -
> -/* RegDataModul */
> -#define  MASK_DATAMODUL_MODE			0x06
> -#define  MASK_DATAMODUL_MODULATION_TYPE		0x18
> -#define  MASK_DATAMODUL_MODULATION_SHAPE	0x03
> -
> -#define  DATAMODUL_MODE_PACKET			0x00 /* default */
> -#define  DATAMODUL_MODE_CONTINUOUS		0x40
> -#define  DATAMODUL_MODE_CONTINUOUS_NOSYNC	0x60
> -
> -#define  DATAMODUL_MODULATION_TYPE_FSK		0x00 /* default */
> -#define  DATAMODUL_MODULATION_TYPE_OOK		0x08
> -
> -#define  DATAMODUL_MODULATION_SHAPE_NONE	0x00 /* default */
> -#define  DATAMODUL_MODULATION_SHAPE_1_0		0x01
> -#define  DATAMODUL_MODULATION_SHAPE_0_5		0x02
> -#define  DATAMODUL_MODULATION_SHAPE_0_3		0x03
> -#define  DATAMODUL_MODULATION_SHAPE_BR		0x01
> -#define  DATAMODUL_MODULATION_SHAPE_2BR		0x02
> -
> -/* RegFDevMsb (0x05)*/
> -#define FDEVMASB_MASK				0x3f
> -
> -/*
> - * // RegOsc1
> - * #define  OSC1_RCCAL_START			0x80
> - * #define  OSC1_RCCAL_DONE			0x40
> - *
> - * // RegLowBat
> - * #define  LOWBAT_MONITOR				0x10
> - * #define  LOWBAT_ON				0x08
> - * #define  LOWBAT_OFF				0x00  // Default
> - *
> - * #define  LOWBAT_TRIM_1695			0x00
> - * #define  LOWBAT_TRIM_1764			0x01
> - * #define  LOWBAT_TRIM_1835			0x02  // Default
> - * #define  LOWBAT_TRIM_1905			0x03
> - * #define  LOWBAT_TRIM_1976			0x04
> - * #define  LOWBAT_TRIM_2045			0x05
> - * #define  LOWBAT_TRIM_2116			0x06
> - * #define  LOWBAT_TRIM_2185			0x07
> - *
> - *
> - * // RegListen1
> - * #define  LISTEN1_RESOL_64			0x50
> - * #define  LISTEN1_RESOL_4100			0xA0  // Default
> - * #define  LISTEN1_RESOL_262000			0xF0
> - *
> - * #define  LISTEN1_CRITERIA_RSSI			0x00  // Default
> - * #define  LISTEN1_CRITERIA_RSSIANDSYNC		0x08
> - *
> - * #define  LISTEN1_END_00				0x00
> - * #define  LISTEN1_END_01				0x02  // Default
> - * #define  LISTEN1_END_10				0x04
> - *
> - *
> - * // RegListen2
> - * #define  LISTEN2_COEFIDLE_VALUE			0xF5 // Default
> - *
> - * // RegListen3
> - * #define  LISTEN3_COEFRX_VALUE			0x20 // Default
> - */
> -
> -// RegPaLevel
> -#define  MASK_PALEVEL_PA0			0x80
> -#define  MASK_PALEVEL_PA1			0x40
> -#define  MASK_PALEVEL_PA2			0x20
> -#define  MASK_PALEVEL_OUTPUT_POWER		0x1F
> -
> -// RegPaRamp
> -#define  PARAMP_3400				0x00
> -#define  PARAMP_2000				0x01
> -#define  PARAMP_1000				0x02
> -#define  PARAMP_500				0x03
> -#define  PARAMP_250				0x04
> -#define  PARAMP_125				0x05
> -#define  PARAMP_100				0x06
> -#define  PARAMP_62				0x07
> -#define  PARAMP_50				0x08
> -#define  PARAMP_40				0x09 /* default */
> -#define  PARAMP_31				0x0A
> -#define  PARAMP_25				0x0B
> -#define  PARAMP_20				0x0C
> -#define  PARAMP_15				0x0D
> -#define  PARAMP_12				0x0E
> -#define  PARAMP_10				0x0F
> -
> -#define  MASK_PARAMP				0x0F
> -
> -/*
> - * // RegOcp
> - * #define  OCP_OFF				0x0F
> - * #define  OCP_ON					0x1A  // Default
> - *
> - * #define  OCP_TRIM_45				0x00
> - * #define  OCP_TRIM_50				0x01
> - * #define  OCP_TRIM_55				0x02
> - * #define  OCP_TRIM_60				0x03
> - * #define  OCP_TRIM_65				0x04
> - * #define  OCP_TRIM_70				0x05
> - * #define  OCP_TRIM_75				0x06
> - * #define  OCP_TRIM_80				0x07
> - * #define  OCP_TRIM_85				0x08
> - * #define  OCP_TRIM_90				0x09
> - * #define  OCP_TRIM_95				0x0A
> - * #define  OCP_TRIM_100				0x0B  // Default
> - * #define  OCP_TRIM_105				0x0C
> - * #define  OCP_TRIM_110				0x0D
> - * #define  OCP_TRIM_115				0x0E
> - * #define  OCP_TRIM_120				0x0F
> - */
> -
> -/* RegLna (0x18) */
> -#define  MASK_LNA_ZIN				0x80
> -#define  MASK_LNA_CURRENT_GAIN			0x38
> -#define  MASK_LNA_GAIN				0x07
> -
> -#define  LNA_GAIN_AUTO				0x00 /* default */
> -#define  LNA_GAIN_MAX				0x01
> -#define  LNA_GAIN_MAX_MINUS_6			0x02
> -#define  LNA_GAIN_MAX_MINUS_12			0x03
> -#define  LNA_GAIN_MAX_MINUS_24			0x04
> -#define  LNA_GAIN_MAX_MINUS_36			0x05
> -#define  LNA_GAIN_MAX_MINUS_48			0x06
> -
> -/* RegRxBw (0x19) and RegAfcBw (0x1A) */
> -#define  MASK_BW_DCC_FREQ			0xE0
> -#define  MASK_BW_MANTISSE			0x18
> -#define  MASK_BW_EXPONENT			0x07
> -
> -#define  BW_DCC_16_PERCENT			0x00
> -#define  BW_DCC_8_PERCENT			0x20
> -#define  BW_DCC_4_PERCENT			0x40 /* default */
> -#define  BW_DCC_2_PERCENT			0x60
> -#define  BW_DCC_1_PERCENT			0x80
> -#define  BW_DCC_0_5_PERCENT			0xA0
> -#define  BW_DCC_0_25_PERCENT			0xC0
> -#define  BW_DCC_0_125_PERCENT			0xE0
> -
> -#define  BW_MANT_16				0x00
> -#define  BW_MANT_20				0x08
> -#define  BW_MANT_24				0x10 /* default */
> -
> -/* RegOokPeak (0x1B) */
> -#define  MASK_OOKPEAK_THRESTYPE			0xc0
> -#define  MASK_OOKPEAK_THRESSTEP			0x38
> -#define  MASK_OOKPEAK_THRESDEC			0x07
> -
> -#define  OOKPEAK_THRESHTYPE_FIXED		0x00
> -#define  OOKPEAK_THRESHTYPE_PEAK		0x40 /* default */
> -#define  OOKPEAK_THRESHTYPE_AVERAGE		0x80
> -
> -#define  OOKPEAK_THRESHSTEP_0_5_DB		0x00 /* default */
> -#define  OOKPEAK_THRESHSTEP_1_0_DB		0x08
> -#define  OOKPEAK_THRESHSTEP_1_5_DB		0x10
> -#define  OOKPEAK_THRESHSTEP_2_0_DB		0x18
> -#define  OOKPEAK_THRESHSTEP_3_0_DB		0x20
> -#define  OOKPEAK_THRESHSTEP_4_0_DB		0x28
> -#define  OOKPEAK_THRESHSTEP_5_0_DB		0x30
> -#define  OOKPEAK_THRESHSTEP_6_0_DB		0x38
> -
> -#define  OOKPEAK_THRESHDEC_ONCE			0x00 /* default */
> -#define  OOKPEAK_THRESHDEC_EVERY_2ND		0x01
> -#define  OOKPEAK_THRESHDEC_EVERY_4TH		0x02
> -#define  OOKPEAK_THRESHDEC_EVERY_8TH		0x03
> -#define  OOKPEAK_THRESHDEC_TWICE		0x04
> -#define  OOKPEAK_THRESHDEC_4_TIMES		0x05
> -#define  OOKPEAK_THRESHDEC_8_TIMES		0x06
> -#define  OOKPEAK_THRESHDEC_16_TIMES		0x07
> -
> -/*
> - * // RegOokAvg
> - * #define  OOKAVG_AVERAGETHRESHFILT_00		0x00
> - * #define  OOKAVG_AVERAGETHRESHFILT_01		0x40
> - * #define  OOKAVG_AVERAGETHRESHFILT_10		0x80  // Default
> - * #define  OOKAVG_AVERAGETHRESHFILT_11		0xC0
> - *
> - *
> - * // RegAfcFei
> - * #define  AFCFEI_FEI_DONE			0x40
> - * #define  AFCFEI_FEI_START			0x20
> - * #define  AFCFEI_AFC_DONE			0x10
> - * #define  AFCFEI_AFCAUTOCLEAR_ON			0x08
> - * #define  AFCFEI_AFCAUTOCLEAR_OFF		0x00  // Default
> - *
> - * #define  AFCFEI_AFCAUTO_ON			0x04
> - * #define  AFCFEI_AFCAUTO_OFF			0x00  // Default
> - *
> - * #define  AFCFEI_AFC_CLEAR			0x02
> - * #define  AFCFEI_AFC_START			0x01
> - *
> - * // RegRssiConfig
> - * #define  RSSI_FASTRX_ON				0x08
> - * #define  RSSI_FASTRX_OFF			0x00  // Default
> - * #define  RSSI_DONE				0x02
> - * #define  RSSI_START				0x01
> - */
> -
> -/* RegDioMapping1 */
> -#define  MASK_DIO0				0xC0
> -#define  MASK_DIO1				0x30
> -#define  MASK_DIO2				0x0C
> -#define  MASK_DIO3				0x03
> -#define  SHIFT_DIO0				6
> -#define  SHIFT_DIO1				4
> -#define  SHIFT_DIO2				2
> -#define  SHIFT_DIO3				0
> -
> -/* RegDioMapping2 */
> -#define  MASK_DIO4				0xC0
> -#define  MASK_DIO5				0x30
> -#define  SHIFT_DIO4				6
> -#define  SHIFT_DIO5				4
> -
> -/* DIO numbers */
> -#define  DIO0					0
> -#define  DIO1					1
> -#define  DIO2					2
> -#define  DIO3					3
> -#define  DIO4					4
> -#define  DIO5					5
> -
> -/* DIO Mapping values (packet mode) */
> -#define  DIO_MODE_READY_DIO4			0x00
> -#define  DIO_MODE_READY_DIO5			0x03
> -#define  DIO_CLK_OUT				0x00
> -#define  DIO_DATA				0x01
> -#define  DIO_TIMEOUT_DIO1			0x03
> -#define  DIO_TIMEOUT_DIO4			0x00
> -#define  DIO_RSSI_DIO0				0x03
> -#define  DIO_RSSI_DIO3_4			0x01
> -#define  DIO_RX_READY				0x02
> -#define  DIO_PLL_LOCK				0x03
> -#define  DIO_TX_READY				0x01
> -#define  DIO_FIFO_FULL_DIO1			0x01
> -#define  DIO_FIFO_FULL_DIO3			0x00
> -#define  DIO_SYNC_ADDRESS			0x02
> -#define  DIO_FIFO_NOT_EMPTY_DIO1		0x02
> -#define  DIO_FIFO_NOT_EMPTY_FIO2		0x00
> -#define  DIO_AUTOMODE				0x04
> -#define  DIO_FIFO_LEVEL				0x00
> -#define  DIO_CRC_OK				0x00
> -#define  DIO_PAYLOAD_READY			0x01
> -#define  DIO_PACKET_SENT			0x00
> -#define  DIO_DCLK				0x00
> -
> -/* RegDioMapping2 CLK_OUT part */
> -#define  MASK_DIOMAPPING2_CLK_OUT		0x07
> -
> -#define  DIOMAPPING2_CLK_OUT_NO_DIV		0x00
> -#define  DIOMAPPING2_CLK_OUT_DIV_2		0x01
> -#define  DIOMAPPING2_CLK_OUT_DIV_4		0x02
> -#define  DIOMAPPING2_CLK_OUT_DIV_8		0x03
> -#define  DIOMAPPING2_CLK_OUT_DIV_16		0x04
> -#define  DIOMAPPING2_CLK_OUT_DIV_32		0x05
> -#define  DIOMAPPING2_CLK_OUT_RC			0x06
> -#define  DIOMAPPING2_CLK_OUT_OFF		0x07 /* default */
> -
> -/* RegIrqFlags1 */
> -#define  MASK_IRQFLAGS1_MODE_READY		0x80
> -#define  MASK_IRQFLAGS1_RX_READY		0x40
> -#define  MASK_IRQFLAGS1_TX_READY		0x20
> -#define  MASK_IRQFLAGS1_PLL_LOCK		0x10
> -#define  MASK_IRQFLAGS1_RSSI			0x08
> -#define  MASK_IRQFLAGS1_TIMEOUT			0x04
> -#define  MASK_IRQFLAGS1_AUTOMODE		0x02
> -#define  MASK_IRQFLAGS1_SYNC_ADDRESS_MATCH	0x01
> -
> -/* RegIrqFlags2 */
> -#define  MASK_IRQFLAGS2_FIFO_FULL		0x80
> -#define  MASK_IRQFLAGS2_FIFO_NOT_EMPTY		0x40
> -#define  MASK_IRQFLAGS2_FIFO_LEVEL		0x20
> -#define  MASK_IRQFLAGS2_FIFO_OVERRUN		0x10
> -#define  MASK_IRQFLAGS2_PACKET_SENT		0x08
> -#define  MASK_IRQFLAGS2_PAYLOAD_READY		0x04
> -#define  MASK_IRQFLAGS2_CRC_OK			0x02
> -#define  MASK_IRQFLAGS2_LOW_BAT			0x01
> -
> -/* RegSyncConfig */
> -#define  MASK_SYNC_CONFIG_SYNC_ON		0x80 /* default */
> -#define  MASK_SYNC_CONFIG_FIFO_FILL_CONDITION	0x40
> -#define  MASK_SYNC_CONFIG_SYNC_SIZE		0x38
> -#define  MASK_SYNC_CONFIG_SYNC_TOLERANCE	0x07
> -
> -/* RegPacketConfig1 */
> -#define  MASK_PACKETCONFIG1_PACKET_FORMAT_VARIABLE	0x80
> -#define  MASK_PACKETCONFIG1_DCFREE			0x60
> -#define  MASK_PACKETCONFIG1_CRC_ON			0x10 /* default */
> -#define  MASK_PACKETCONFIG1_CRCAUTOCLEAR_OFF		0x08
> -#define  MASK_PACKETCONFIG1_ADDRESSFILTERING		0x06
> -
> -#define  PACKETCONFIG1_DCFREE_OFF			0x00 /* default */
> -#define  PACKETCONFIG1_DCFREE_MANCHESTER		0x20
> -#define  PACKETCONFIG1_DCFREE_WHITENING			0x40
> -#define  PACKETCONFIG1_ADDRESSFILTERING_OFF		0x00 /* default */
> -#define  PACKETCONFIG1_ADDRESSFILTERING_NODE		0x02
> -#define  PACKETCONFIG1_ADDRESSFILTERING_NODEBROADCAST	0x04
> -
> -/*
> - * // RegAutoModes
> - * #define  AUTOMODES_ENTER_OFF			0x00  // Default
> - * #define  AUTOMODES_ENTER_FIFONOTEMPTY		0x20
> - * #define  AUTOMODES_ENTER_FIFOLEVEL		0x40
> - * #define  AUTOMODES_ENTER_CRCOK			0x60
> - * #define  AUTOMODES_ENTER_PAYLOADREADY		0x80
> - * #define  AUTOMODES_ENTER_SYNCADRSMATCH		0xA0
> - * #define  AUTOMODES_ENTER_PACKETSENT		0xC0
> - * #define  AUTOMODES_ENTER_FIFOEMPTY		0xE0
> - *
> - * #define  AUTOMODES_EXIT_OFF			0x00  // Default
> - * #define  AUTOMODES_EXIT_FIFOEMPTY		0x04
> - * #define  AUTOMODES_EXIT_FIFOLEVEL		0x08
> - * #define  AUTOMODES_EXIT_CRCOK			0x0C
> - * #define  AUTOMODES_EXIT_PAYLOADREADY		0x10
> - * #define  AUTOMODES_EXIT_SYNCADRSMATCH		0x14
> - * #define  AUTOMODES_EXIT_PACKETSENT		0x18
> - * #define  AUTOMODES_EXIT_RXTIMEOUT		0x1C
> - *
> - * #define  AUTOMODES_INTERMEDIATE_SLEEP		0x00  // Default
> - * #define  AUTOMODES_INTERMEDIATE_STANDBY		0x01
> - * #define  AUTOMODES_INTERMEDIATE_RECEIVER	0x02
> - * #define  AUTOMODES_INTERMEDIATE_TRANSMITTER	0x03
> - *
> - */
> -/* RegFifoThresh (0x3c) */
> -#define  MASK_FIFO_THRESH_TXSTART		0x80
> -#define  MASK_FIFO_THRESH_VALUE			0x7F
> -
> -/*
> - *
> - * // RegPacketConfig2
> - * #define  PACKET2_RXRESTARTDELAY_1BIT		0x00  // Default
> - * #define  PACKET2_RXRESTARTDELAY_2BITS		0x10
> - * #define  PACKET2_RXRESTARTDELAY_4BITS		0x20
> - * #define  PACKET2_RXRESTARTDELAY_8BITS		0x30
> - * #define  PACKET2_RXRESTARTDELAY_16BITS		0x40
> - * #define  PACKET2_RXRESTARTDELAY_32BITS		0x50
> - * #define  PACKET2_RXRESTARTDELAY_64BITS		0x60
> - * #define  PACKET2_RXRESTARTDELAY_128BITS		0x70
> - * #define  PACKET2_RXRESTARTDELAY_256BITS		0x80
> - * #define  PACKET2_RXRESTARTDELAY_512BITS		0x90
> - * #define  PACKET2_RXRESTARTDELAY_1024BITS	0xA0
> - * #define  PACKET2_RXRESTARTDELAY_2048BITS	0xB0
> - * #define  PACKET2_RXRESTARTDELAY_NONE		0xC0
> - * #define  PACKET2_RXRESTART			0x04
> - *
> - * #define  PACKET2_AUTORXRESTART_ON		0x02  // Default
> - * #define  PACKET2_AUTORXRESTART_OFF		0x00
> - *
> - * #define  PACKET2_AES_ON				0x01
> - * #define  PACKET2_AES_OFF			0x00  // Default
> - *
> - *
> - * // RegTemp1
> - * #define  TEMP1_MEAS_START			0x08
> - * #define  TEMP1_MEAS_RUNNING			0x04
> - * #define  TEMP1_ADCLOWPOWER_ON			0x01  // Default
> - * #define  TEMP1_ADCLOWPOWER_OFF			0x00
> - */
> -
> -// RegTestDagc (0x6F)
> -#define  DAGC_NORMAL				0x00 /* Reset value */
> -#define  DAGC_IMPROVED_LOWBETA1			0x20
> -#define  DAGC_IMPROVED_LOWBETA0			0x30 /* Recommended val */

-- 
Marcus Wolf

Wolf-Entwicklungen
Helene-Lange-Weg 23
80637 München

