Return-Path: <linux-kernel+bounces-77869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E15860B50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6496C1F25AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7C214A93;
	Fri, 23 Feb 2024 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Jqwbgle"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3A516436;
	Fri, 23 Feb 2024 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708673205; cv=none; b=UzvitmoCOWegQY1q1NhD7VzFkXTCBe757fkBD6PB9a2WgqtstyoAdomXWHjFTkBeK9dmxKa4JtvQvGdBtEp6Hu0yWxrkOTUotdX4nn45nMOe5NMVQxrTxbYvQPcW6Ty9sBtolThToEgnlJK16xogoD2vqbO7jFh0+GejKsdCOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708673205; c=relaxed/simple;
	bh=oNtBagdjI6/H4pFEBpGqbUza7rtbHUdNBaoHg0Kl3lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLlRM2kbft+lkJXf6M/regYuDZKHb84bBBYThmq5/z/IYM4wBFr2sMn7J31sJIvKvfgKh7Z+/I881B/v1gVb9J8++MTob09bnVkdDJCvQqg7ElciwYQwA45N9M5wBKG8lUUCRHkwb0szXgEoV4xRe1UOdX/pgEFmJIMPYTXvm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Jqwbgle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E934C43394;
	Fri, 23 Feb 2024 07:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708673204;
	bh=oNtBagdjI6/H4pFEBpGqbUza7rtbHUdNBaoHg0Kl3lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Jqwbgle827yadjap+A7PUCmr2jz+YPiSMxdH6pEl90B1PRJnBbAgGHxpCwNspRNU
	 KUogNN+GztdN0FqhyvvZtrcmYLt4nltgcdBfd4vkN2WbLAUwbY5S/fdHqF0yU2z3rw
	 QJHs9v5nwMUFxzmOhq+lvpjMlLp+BeYpAGErJvko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.307
Date: Fri, 23 Feb 2024 08:26:32 +0100
Message-ID: <2024022332-widow-scant-ac42@gregkh>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <2024022331-zoology-tried-3716@gregkh>
References: <2024022331-zoology-tried-3716@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/ABI/testing/sysfs-class-net-queues b/Documentation/ABI/testing/sysfs-class-net-queues
index 978b76358661..40d5aab8452d 100644
--- a/Documentation/ABI/testing/sysfs-class-net-queues
+++ b/Documentation/ABI/testing/sysfs-class-net-queues
@@ -1,4 +1,4 @@
-What:		/sys/class/<iface>/queues/rx-<queue>/rps_cpus
+What:		/sys/class/net/<iface>/queues/rx-<queue>/rps_cpus
 Date:		March 2010
 KernelVersion:	2.6.35
 Contact:	netdev@vger.kernel.org
@@ -8,7 +8,7 @@ Description:
 		network device queue. Possible values depend on the number
 		of available CPU(s) in the system.
 
-What:		/sys/class/<iface>/queues/rx-<queue>/rps_flow_cnt
+What:		/sys/class/net/<iface>/queues/rx-<queue>/rps_flow_cnt
 Date:		April 2010
 KernelVersion:	2.6.35
 Contact:	netdev@vger.kernel.org
@@ -16,7 +16,7 @@ Description:
 		Number of Receive Packet Steering flows being currently
 		processed by this particular network device receive queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/tx_timeout
+What:		/sys/class/net/<iface>/queues/tx-<queue>/tx_timeout
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -24,7 +24,7 @@ Description:
 		Indicates the number of transmit timeout events seen by this
 		network interface transmit queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/tx_maxrate
+What:		/sys/class/net/<iface>/queues/tx-<queue>/tx_maxrate
 Date:		March 2015
 KernelVersion:	4.1
 Contact:	netdev@vger.kernel.org
@@ -32,7 +32,7 @@ Description:
 		A Mbps max-rate set for the queue, a value of zero means disabled,
 		default is disabled.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/xps_cpus
+What:		/sys/class/net/<iface>/queues/tx-<queue>/xps_cpus
 Date:		November 2010
 KernelVersion:	2.6.38
 Contact:	netdev@vger.kernel.org
@@ -42,7 +42,7 @@ Description:
 		network device transmit queue. Possible vaules depend on the
 		number of available CPU(s) in the system.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/xps_rxqs
+What:		/sys/class/net/<iface>/queues/tx-<queue>/xps_rxqs
 Date:		June 2018
 KernelVersion:	4.18.0
 Contact:	netdev@vger.kernel.org
@@ -53,7 +53,7 @@ Description:
 		number of available receive queue(s) in the network device.
 		Default is disabled.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/hold_time
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/hold_time
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -62,7 +62,7 @@ Description:
 		of this particular network device transmit queue.
 		Default value is 1000.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/inflight
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/inflight
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -70,7 +70,7 @@ Description:
 		Indicates the number of bytes (objects) in flight on this
 		network device transmit queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -79,7 +79,7 @@ Description:
 		on this network device transmit queue. This value is clamped
 		to be within the bounds defined by limit_max and limit_min.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit_max
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit_max
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -88,7 +88,7 @@ Description:
 		queued on this network device transmit queue. See
 		include/linux/dynamic_queue_limits.h for the default value.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit_min
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit_min
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
diff --git a/Documentation/ABI/testing/sysfs-class-net-statistics b/Documentation/ABI/testing/sysfs-class-net-statistics
index 397118de7b5e..53e508c6936a 100644
--- a/Documentation/ABI/testing/sysfs-class-net-statistics
+++ b/Documentation/ABI/testing/sysfs-class-net-statistics
@@ -1,4 +1,4 @@
-What:		/sys/class/<iface>/statistics/collisions
+What:		/sys/class/net/<iface>/statistics/collisions
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -6,7 +6,7 @@ Description:
 		Indicates the number of collisions seen by this network device.
 		This value might not be relevant with all MAC layers.
 
-What:		/sys/class/<iface>/statistics/multicast
+What:		/sys/class/net/<iface>/statistics/multicast
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -14,7 +14,7 @@ Description:
 		Indicates the number of multicast packets received by this
 		network device.
 
-What:		/sys/class/<iface>/statistics/rx_bytes
+What:		/sys/class/net/<iface>/statistics/rx_bytes
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -23,7 +23,7 @@ Description:
 		See the network driver for the exact meaning of when this
 		value is incremented.
 
-What:		/sys/class/<iface>/statistics/rx_compressed
+What:		/sys/class/net/<iface>/statistics/rx_compressed
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -32,7 +32,7 @@ Description:
 		network device. This value might only be relevant for interfaces
 		that support packet compression (e.g: PPP).
 
-What:		/sys/class/<iface>/statistics/rx_crc_errors
+What:		/sys/class/net/<iface>/statistics/rx_crc_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -41,7 +41,7 @@ Description:
 		by this network device. Note that the specific meaning might
 		depend on the MAC layer used by the interface.
 
-What:		/sys/class/<iface>/statistics/rx_dropped
+What:		/sys/class/net/<iface>/statistics/rx_dropped
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -51,7 +51,15 @@ Description:
 		packet processing. See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_fifo_errors
+What:		/sys/class/net/<iface>/statistics/rx_errors
+Date:		April 2005
+KernelVersion:	2.6.12
+Contact:	netdev@vger.kernel.org
+Description:
+		Indicates the number of receive errors on this network device.
+		See the network driver for the exact meaning of this value.
+
+What:		/sys/class/net/<iface>/statistics/rx_fifo_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -60,7 +68,7 @@ Description:
 		network device. See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_frame_errors
+What:		/sys/class/net/<iface>/statistics/rx_frame_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -70,7 +78,7 @@ Description:
 		on the MAC layer protocol used. See the network driver for
 		the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_length_errors
+What:		/sys/class/net/<iface>/statistics/rx_length_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -79,7 +87,7 @@ Description:
 		error, oversized or undersized. See the network driver for the
 		exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_missed_errors
+What:		/sys/class/net/<iface>/statistics/rx_missed_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -88,7 +96,15 @@ Description:
 		due to lack of capacity in the receive side. See the network
 		driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_over_errors
+What:		/sys/class/net/<iface>/statistics/rx_nohandler
+Date:		February 2016
+KernelVersion:	4.6
+Contact:	netdev@vger.kernel.org
+Description:
+		Indicates the number of received packets that were dropped on
+		an inactive device by the network core.
+
+What:		/sys/class/net/<iface>/statistics/rx_over_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -98,7 +114,7 @@ Description:
 		(e.g: larger than MTU). See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_packets
+What:		/sys/class/net/<iface>/statistics/rx_packets
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -106,7 +122,7 @@ Description:
 		Indicates the total number of good packets received by this
 		network device.
 
-What:		/sys/class/<iface>/statistics/tx_aborted_errors
+What:		/sys/class/net/<iface>/statistics/tx_aborted_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -116,7 +132,7 @@ Description:
 		a medium collision). See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/tx_bytes
+What:		/sys/class/net/<iface>/statistics/tx_bytes
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -127,7 +143,7 @@ Description:
 		transmitted packets or all packets that have been queued for
 		transmission.
 
-What:		/sys/class/<iface>/statistics/tx_carrier_errors
+What:		/sys/class/net/<iface>/statistics/tx_carrier_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -136,7 +152,7 @@ Description:
 		because of carrier errors (e.g: physical link down). See the
 		network driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/tx_compressed
+What:		/sys/class/net/<iface>/statistics/tx_compressed
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -145,7 +161,7 @@ Description:
 		this might only be relevant for devices that support
 		compression (e.g: PPP).
 
-What:		/sys/class/<iface>/statistics/tx_dropped
+What:		/sys/class/net/<iface>/statistics/tx_dropped
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -154,7 +170,7 @@ Description:
 		See the driver for the exact reasons as to why the packets were
 		dropped.
 
-What:		/sys/class/<iface>/statistics/tx_errors
+What:		/sys/class/net/<iface>/statistics/tx_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -163,7 +179,7 @@ Description:
 		a network device. See the driver for the exact reasons as to
 		why the packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_fifo_errors
+What:		/sys/class/net/<iface>/statistics/tx_fifo_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -172,7 +188,7 @@ Description:
 		FIFO error. See the driver for the exact reasons as to why the
 		packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_heartbeat_errors
+What:		/sys/class/net/<iface>/statistics/tx_heartbeat_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -181,7 +197,7 @@ Description:
 		reported as heartbeat errors. See the driver for the exact
 		reasons as to why the packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_packets
+What:		/sys/class/net/<iface>/statistics/tx_packets
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -190,7 +206,7 @@ Description:
 		device. See the driver for whether this reports the number of all
 		attempted or successful transmissions.
 
-What:		/sys/class/<iface>/statistics/tx_window_errors
+What:		/sys/class/net/<iface>/statistics/tx_window_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 8e44107933ab..c3154ce6e1b2 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -234,7 +234,7 @@ corresponding soft power control. In this case it is necessary to create
 a virtual widget - a widget with no control bits e.g.
 ::
 
-  SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_DAPM_NOPM, 0, 0, NULL, 0),
+  SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 This can be used to merge to signal paths together in software.
 
diff --git a/Makefile b/Makefile
index 6c5cb44190dd..4c1ea41b5621 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 306
+SUBLEVEL = 307
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/boot/dts/imx1-ads.dts b/arch/arm/boot/dts/imx1-ads.dts
index 119b19ba53b6..26af4e05abec 100644
--- a/arch/arm/boot/dts/imx1-ads.dts
+++ b/arch/arm/boot/dts/imx1-ads.dts
@@ -71,7 +71,7 @@
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <4>;
diff --git a/arch/arm/boot/dts/imx1-apf9328.dts b/arch/arm/boot/dts/imx1-apf9328.dts
index ee4b1b106b1a..f5015f5e808a 100644
--- a/arch/arm/boot/dts/imx1-apf9328.dts
+++ b/arch/arm/boot/dts/imx1-apf9328.dts
@@ -51,7 +51,7 @@
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index 2b6e77029de4..8c4c7464b133 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -268,9 +268,12 @@
 			status = "disabled";
 		};
 
-		esram: esram@300000 {
+		esram: sram@300000 {
 			compatible = "mmio-sram";
 			reg = <0x00300000 0x20000>;
+			ranges = <0 0x00300000 0x20000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx23-sansa.dts b/arch/arm/boot/dts/imx23-sansa.dts
index fa22fd9b2412..a0bbc39e644a 100644
--- a/arch/arm/boot/dts/imx23-sansa.dts
+++ b/arch/arm/boot/dts/imx23-sansa.dts
@@ -175,10 +175,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio1 24 0		/* SDA */
-			&gpio1 22 0		/* SCL */
-		>;
+		sda-gpios = <&gpio1 24 0>;
+		scl-gpios = <&gpio1 22 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 	};
 
@@ -186,10 +184,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio0 31 0		/* SDA */
-			&gpio0 30 0		/* SCL */
-		>;
+		sda-gpios = <&gpio0 31 0>;
+		scl-gpios = <&gpio0 30 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 
 		touch: touch@20 {
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index aaaa987d8eff..223c5171edab 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -406,7 +406,7 @@
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx23-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <7 5 9 26
diff --git a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
index e4d7da267532..5858ec8a409a 100644
--- a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
+++ b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
@@ -35,7 +35,7 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 5f84b598e0d0..167f21434fbf 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -53,7 +53,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		user {
+		led-user {
 			label = "Heartbeat";
 			gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
index c85f9d01768a..bb1d0576732d 100644
--- a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
@@ -39,7 +39,7 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
@@ -96,7 +96,7 @@
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 0935e1400e5d..e4ed62397d62 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -328,7 +328,7 @@
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 39e75b997bdc..ecfb07c8e185 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -588,6 +588,9 @@
 		iram: iram@ffff4c00 {
 			compatible = "mmio-sram";
 			reg = <0xffff4c00 0xb400>;
+			ranges = <0 0xffff4c00 0xb400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 5107fdc482ea..84f7c86373b5 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -984,7 +984,7 @@
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx28-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <78 79 66 0
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 36c00fe29f4f..c62cf9fea481 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -701,7 +701,7 @@
 			};
 
 			lcdif: lcdif@30730000 {
-				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
+				compatible = "fsl,imx7d-lcdif", "fsl,imx6sx-lcdif";
 				reg = <0x30730000 0x10000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
@@ -1094,7 +1094,7 @@
 		gpmi: gpmi-nand@33002000{
 			compatible = "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
 			reg-names = "gpmi-nand", "bch";
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index db612271371b..c5144f06c3e7 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -336,12 +336,20 @@
 		pinctrl-0 = <&hdmi_ctl>;
 		status = "disabled";
 
-		hdmi_in: port {
+		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			hdmi_in_vop: endpoint@0 {
+
+			hdmi_in: port@0 {
 				reg = <0>;
-				remote-endpoint = <&vop_out_hdmi>;
+
+				hdmi_in_vop: endpoint {
+					remote-endpoint = <&vop_out_hdmi>;
+				};
+			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
 			};
 		};
 	};
diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index e8161e4dfde7..4680bac894f6 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -276,7 +276,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	"	.set	pop"
 	: "=&r" (sum), "=&r" (tmp)
 	: "r" (saddr), "r" (daddr),
-	  "0" (htonl(len)), "r" (htonl(proto)), "r" (sum));
+	  "0" (htonl(len)), "r" (htonl(proto)), "r" (sum)
+	: "memory");
 
 	return csum_fold(sum);
 }
diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index 731325a61a78..d7d0a4872389 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -15,6 +15,7 @@
 
 #include <asm/cpu-features.h>
 #include <asm/cpu-info.h>
+#include <asm/fpu.h>
 
 /* Whether to accept legacy-NaN and 2008-NaN user binaries.  */
 bool mips_use_nan_legacy;
@@ -311,6 +312,11 @@ void mips_set_personality_nan(struct arch_elf_state *state)
 	struct cpuinfo_mips *c = &boot_cpu_data;
 	struct task_struct *t = current;
 
+	/* Do this early so t->thread.fpu.fcr31 won't be clobbered in case
+	 * we are preempted before the lose_fpu(0) in start_thread.
+	 */
+	lose_fpu(0);
+
 	t->thread.fpu.fcr31 = c->fpu_csr31;
 	switch (state->nan_2008) {
 	case 0:
diff --git a/arch/parisc/kernel/firmware.c b/arch/parisc/kernel/firmware.c
index 906b7c882587..82f264621845 100644
--- a/arch/parisc/kernel/firmware.c
+++ b/arch/parisc/kernel/firmware.c
@@ -127,10 +127,10 @@ static unsigned long f_extend(unsigned long address)
 #ifdef CONFIG_64BIT
 	if(unlikely(parisc_narrow_firmware)) {
 		if((address & 0xff000000) == 0xf0000000)
-			return 0xf0f0f0f000000000UL | (u32)address;
+			return (0xfffffff0UL << 32) | (u32)address;
 
 		if((address & 0xf0000000) == 0xf0000000)
-			return 0xffffffff00000000UL | (u32)address;
+			return (0xffffffffUL << 32) | (u32)address;
 	}
 #endif
 	return address;
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 2b396de45e9e..20cdf744522b 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -330,5 +330,9 @@ static inline void mmu_early_init_devtree(void) { }
 #include <asm/nohash/mmu.h>
 #endif
 
+#if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
+#define __HAVE_ARCH_RESERVED_KERNEL_PAGES
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MMU_H_ */
diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index 91c69ff53a8a..50c2198c2c76 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -42,9 +42,6 @@ u64 memory_hotplug_max(void);
 #else
 #define memory_hotplug_max() memblock_end_of_DRAM()
 #endif /* CONFIG_NEED_MULTIPLE_NODES */
-#ifdef CONFIG_FA_DUMP
-#define __HAVE_ARCH_RESERVED_KERNEL_PAGES
-#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_MMZONE_H_ */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 63c751ce130a..67a00131ec42 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1341,10 +1341,12 @@ static int emulate_instruction(struct pt_regs *regs)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long addr)
 {
 	return is_kernel_addr(addr);
 }
+#endif
 
 #ifdef CONFIG_MATH_EMULATION
 static int emulate_math(struct pt_regs *regs)
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 6f1e57182876..f0aa6fc8c6b2 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -21,8 +21,8 @@ obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o strlen_32.o
 # 64-bit linker creates .sfpr on demand for final link (vmlinux),
 # so it is only needed for modules, and only for older linkers which
 # do not support --save-restore-funcs
-ifeq ($(call ld-ifversion, -lt, 225000000, y),y)
-always-$(CONFIG_PPC64)	+= crtsavres.o
+ifeq ($(call ld-ifversion, -lt, 225000000, y)$(CONFIG_PPC64),yy)
+always	+= crtsavres.o
 endif
 
 obj-$(CONFIG_PPC_BOOK3S_64) += copyuser_power7.o copypage_power7.o \
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 30c434abe861..3da6290e3ccc 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -473,6 +473,8 @@ static int do_fp_load(struct instruction_op *op, unsigned long ea,
 	} u;
 
 	nb = GETSIZE(op->type);
+	if (nb > sizeof(u))
+		return -EINVAL;
 	if (!address_ok(regs, ea, nb))
 		return -EFAULT;
 	rn = op->reg;
@@ -523,6 +525,8 @@ static int do_fp_store(struct instruction_op *op, unsigned long ea,
 	} u;
 
 	nb = GETSIZE(op->type);
+	if (nb > sizeof(u))
+		return -EINVAL;
 	if (!address_ok(regs, ea, nb))
 		return -EFAULT;
 	rn = op->reg;
@@ -567,6 +571,9 @@ static nokprobe_inline int do_vec_load(int rn, unsigned long ea,
 		u8 b[sizeof(__vector128)];
 	} u = {};
 
+	if (size > sizeof(u))
+		return -EINVAL;
+
 	if (!address_ok(regs, ea & ~0xfUL, 16))
 		return -EFAULT;
 	/* align to multiple of size */
@@ -594,6 +601,9 @@ static nokprobe_inline int do_vec_store(int rn, unsigned long ea,
 		u8 b[sizeof(__vector128)];
 	} u;
 
+	if (size > sizeof(u))
+		return -EINVAL;
+
 	if (!address_ok(regs, ea & ~0xfUL, 16))
 		return -EFAULT;
 	/* align to multiple of size */
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 2b656e67f2ea..927703af49be 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -65,7 +65,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 	 * as to leave enough 0 bits in the address to contain it. */
 	unsigned long minalign = max(MAX_PGTABLE_INDEX_SIZE + 1,
 				     HUGEPD_SHIFT_MASK + 1);
-	struct kmem_cache *new;
+	struct kmem_cache *new = NULL;
 
 	/* It would be nice if this was a BUILD_BUG_ON(), but at the
 	 * moment, gcc doesn't seem to recognize is_power_of_2 as a
@@ -78,7 +78,8 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
-	new = kmem_cache_create(name, table_size, align, 0, ctor);
+	if (name)
+		new = kmem_cache_create(name, table_size, align, 0, ctor);
 	if (!new)
 		panic("Could not allocate pgtable cache for order %d", shift);
 
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index c36289a3ad50..0495a1906a38 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -414,6 +414,7 @@ static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
 		/*
 		 * floating point control reg. is in the thread structure
 		 */
+		save_fpu_regs();
 		if ((unsigned int) data != 0 ||
 		    test_fp_ctl(data >> (BITS_PER_LONG - 32)))
 			return -EINVAL;
@@ -774,6 +775,7 @@ static int __poke_user_compat(struct task_struct *child,
 		/*
 		 * floating point control reg. is in the thread structure
 		 */
+		save_fpu_regs();
 		if (test_fp_ctl(tmp))
 			return -EINVAL;
 		child->thread.fpu.fpc = data;
@@ -1002,9 +1004,7 @@ static int s390_fpregs_set(struct task_struct *target,
 	int rc = 0;
 	freg_t fprs[__NUM_FPRS];
 
-	if (target == current)
-		save_fpu_regs();
-
+	save_fpu_regs();
 	if (MACHINE_HAS_VX)
 		convert_vx_to_fp(fprs, target->thread.fpu.vxrs);
 	else
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 92041d442d2e..bc700cb9fc53 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2995,10 +2995,6 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 
 	vcpu_load(vcpu);
 
-	if (test_fp_ctl(fpu->fpc)) {
-		ret = -EINVAL;
-		goto out;
-	}
 	vcpu->run->s.regs.fpc = fpu->fpc;
 	if (MACHINE_HAS_VX)
 		convert_fp_to_vx((__vector128 *) vcpu->run->s.regs.vrs,
@@ -3006,7 +3002,6 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	else
 		memcpy(vcpu->run->s.regs.fprs, &fpu->fprs, sizeof(fpu->fprs));
 
-out:
 	vcpu_put(vcpu);
 	return ret;
 }
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 3ef1b48e064a..0216e3254c90 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -206,7 +206,7 @@ static int uml_net_close(struct net_device *dev)
 	return 0;
 }
 
-static int uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct uml_net_private *lp = netdev_priv(dev);
 	unsigned long flags;
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 35ab97e4bb9b..f2da8347d5f5 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -49,7 +49,7 @@ extern void do_uml_exitcalls(void);
  * Are we disallowed to sleep? Used to choose between GFP_KERNEL and
  * GFP_ATOMIC.
  */
-extern int __cant_sleep(void);
+extern int __uml_cant_sleep(void);
 extern int get_current_pid(void);
 extern int copy_from_user_proc(void *to, void *from, int size);
 extern int cpu(void);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 691b83b10649..c9d09d04d19d 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -210,7 +210,7 @@ void arch_cpu_idle(void)
 	local_irq_enable();
 }
 
-int __cant_sleep(void) {
+int __uml_cant_sleep(void) {
 	return in_atomic() || irqs_disabled() || in_interrupt();
 	/* Is in_interrupt() really needed? */
 }
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 3f02d4232812..53d450e4a53a 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -45,7 +45,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	unsigned long stack, sp;
 	int pid, fds[2], ret, n;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
@@ -69,7 +69,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	data.pre_data = pre_data;
 	data.argv = argv;
 	data.fd = fds[1];
-	data.buf = __cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
+	data.buf = __uml_cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
 					uml_kmalloc(PATH_MAX, UM_GFP_KERNEL);
 	pid = clone(helper_child, (void *) sp, CLONE_VM, &data);
 	if (pid < 0) {
@@ -116,7 +116,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	unsigned long stack, sp;
 	int pid, status, err;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 8cc8b2617a67..0436cc9537e0 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -166,23 +166,38 @@ __uml_setup("quiet", quiet_cmd_param,
 "quiet\n"
 "    Turns off information messages during boot.\n\n");
 
+/*
+ * The os_info/os_warn functions will be called by helper threads. These
+ * have a very limited stack size and using the libc formatting functions
+ * may overflow the stack.
+ * So pull in the kernel vscnprintf and use that instead with a fixed
+ * on-stack buffer.
+ */
+int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
+
 void os_info(const char *fmt, ...)
 {
+	char buf[256];
 	va_list list;
+	int len;
 
 	if (quiet_info)
 		return;
 
 	va_start(list, fmt);
-	vfprintf(stderr, fmt, list);
+	len = vscnprintf(buf, sizeof(buf), fmt, list);
+	fwrite(buf, len, 1, stderr);
 	va_end(list);
 }
 
 void os_warn(const char *fmt, ...)
 {
+	char buf[256];
 	va_list list;
+	int len;
 
 	va_start(list, fmt);
-	vfprintf(stderr, fmt, list);
+	len = vscnprintf(buf, sizeof(buf), fmt, list);
+	fwrite(buf, len, 1, stderr);
 	va_end(list);
 }
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 638411f22267..fd0a2d4d60d5 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -372,7 +372,7 @@ config X86_CMOV
 config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
-	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCRUSOE || MCORE2 || MK7 || MK8)
+	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7 || MK8)
 	default "5" if X86_32 && X86_CMPXCHG64
 	default "4"
 
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 90eb70df0b18..523f21593cd9 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -12,12 +12,29 @@
 		,,regs->di,,regs->si,,regs->dx				\
 		,,regs->r10,,regs->r8,,regs->r9)			\
 
+
+/* SYSCALL_PT_ARGS is Adapted from s390x */
+#define SYSCALL_PT_ARG6(m, t1, t2, t3, t4, t5, t6)			\
+	SYSCALL_PT_ARG5(m, t1, t2, t3, t4, t5), m(t6, (regs->bp))
+#define SYSCALL_PT_ARG5(m, t1, t2, t3, t4, t5)				\
+	SYSCALL_PT_ARG4(m, t1, t2, t3, t4),  m(t5, (regs->di))
+#define SYSCALL_PT_ARG4(m, t1, t2, t3, t4)				\
+	SYSCALL_PT_ARG3(m, t1, t2, t3),  m(t4, (regs->si))
+#define SYSCALL_PT_ARG3(m, t1, t2, t3)					\
+	SYSCALL_PT_ARG2(m, t1, t2), m(t3, (regs->dx))
+#define SYSCALL_PT_ARG2(m, t1, t2)					\
+	SYSCALL_PT_ARG1(m, t1), m(t2, (regs->cx))
+#define SYSCALL_PT_ARG1(m, t1) m(t1, (regs->bx))
+#define SYSCALL_PT_ARGS(x, ...) SYSCALL_PT_ARG##x(__VA_ARGS__)
+
+#define __SC_COMPAT_CAST(t, a)						\
+	(__typeof(__builtin_choose_expr(__TYPE_IS_L(t), 0, 0U)))	\
+	(unsigned int)a
+
 /* Mapping of registers to parameters for syscalls on i386 */
 #define SC_IA32_REGS_TO_ARGS(x, ...)					\
-	__MAP(x,__SC_ARGS						\
-	      ,,(unsigned int)regs->bx,,(unsigned int)regs->cx		\
-	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
-	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
+	SYSCALL_PT_ARGS(x, __SC_COMPAT_CAST,				\
+			__MAP(x, __SC_TYPE, __VA_ARGS__))		\
 
 #ifdef CONFIG_IA32_EMULATION
 /*
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 84667781c41d..5b75a4ff6802 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -271,15 +271,6 @@ static void init_amd_k6(struct cpuinfo_x86 *c)
 		return;
 	}
 #endif
-	/*
-	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
-	 * certain circumstances on Zen1/2 uarch, and not all parts have had
-	 * updated microcode at the time of writing (March 2023).
-	 *
-	 * Affected parts all have no supervisor XSAVE states, meaning that
-	 * the XSAVEC instruction (which works fine) is equivalent.
-	 */
-	clear_cpu_cap(c, X86_FEATURE_XSAVES);
 }
 
 static void init_amd_k7(struct cpuinfo_x86 *c)
@@ -979,6 +970,17 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 		if (c->x86 == 0x19 && !cpu_has(c, X86_FEATURE_BTC_NO))
 			set_cpu_cap(c, X86_FEATURE_BTC_NO);
 	}
+
+	/*
+	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
+	 * certain circumstances on Zen1/2 uarch, and not all parts have had
+	 * updated microcode at the time of writing (March 2023).
+	 *
+	 * Affected parts all have no supervisor XSAVE states, meaning that
+	 * the XSAVEC instruction (which works fine) is equivalent.
+	 */
+	if (c->x86 == 0x17)
+		clear_cpu_cap(c, X86_FEATURE_XSAVES);
 }
 
 static bool cpu_has_zenbleed_microcode(void)
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 968d7005f4a7..f50cc210a981 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,18 +26,31 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
+		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		if (info->direct_gbpages) {
-			pud_t pudval;
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_large(*pud))
+			continue;
+
+		/* Is using a gbpage allowed? */
+		use_gbpage = info->direct_gbpages;
 
-			if (pud_present(*pud))
-				continue;
+		/* Don't use gbpage if it maps more than the requested region. */
+		/* at the begining: */
+		use_gbpage &= ((addr & ~PUD_MASK) == 0);
+		/* ... or at the end: */
+		use_gbpage &= ((next & ~PUD_MASK) == 0);
+
+		/* Never overwrite existing mappings */
+		use_gbpage &= !pud_present(*pud);
+
+		if (use_gbpage) {
+			pud_t pudval;
 
-			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
diff --git a/block/bio.c b/block/bio.c
index 7858b2d23916..476a88e11715 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1592,8 +1592,7 @@ void bio_set_pages_dirty(struct bio *bio)
 	int i;
 
 	bio_for_each_segment_all(bvec, bio, i) {
-		if (!PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
+		set_page_dirty_lock(bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
@@ -1652,7 +1651,7 @@ void bio_check_pages_dirty(struct bio *bio)
 	int i;
 
 	bio_for_each_segment_all(bvec, bio, i) {
-		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
+		if (!PageDirty(bvec->bv_page))
 			goto defer;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae70b4809bec..0cb559d63998 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1064,6 +1064,22 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
 	__add_wait_queue(wq, wait);
 
+	/*
+	 * Add one explicit barrier since blk_mq_get_driver_tag() may
+	 * not imply barrier in case of failure.
+	 *
+	 * Order adding us to wait queue and allocating driver tag.
+	 *
+	 * The pair is the one implied in sbitmap_queue_wake_up() which
+	 * orders clearing sbitmap tag bits and waitqueue_active() in
+	 * __sbitmap_queue_wake_up(), since waitqueue_active() is lockless
+	 *
+	 * Otherwise, re-order of adding wait queue and getting driver tag
+	 * may cause __sbitmap_queue_wake_up() to wake up nothing because
+	 * the waitqueue_active() may not observe us in wait queue.
+	 */
+	smp_mb();
+
 	/*
 	 * It's possible that a tag was freed in the window between the
 	 * allocation failure and adding the hardware queue to the wait
diff --git a/crypto/algapi.c b/crypto/algapi.c
index 346557a3fc0b..a1ceca922841 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -231,6 +231,7 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
 		}
 
 		if (!strcmp(q->cra_driver_name, alg->cra_name) ||
+		    !strcmp(q->cra_driver_name, alg->cra_driver_name) ||
 		    !strcmp(q->cra_name, alg->cra_driver_name))
 			goto err;
 	}
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index e05309bc41cc..e148b0a28ec9 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -317,9 +317,10 @@ static void __exit extlog_exit(void)
 {
 	edac_set_report_status(old_edac_report_status);
 	mce_unregister_decode_chain(&extlog_mce_dec);
-	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
-	if (extlog_l1_addr)
+	if (extlog_l1_addr) {
+		((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
 		acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
+	}
 	if (elog_addr)
 		acpi_os_unmap_iomem(elog_addr, elog_size);
 	release_mem_region(elog_base, elog_size);
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index c22297cce288..a3f8368fe231 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -581,6 +581,15 @@ static const struct dmi_system_id video_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3350"),
 		},
 	},
+	{
+	 .callback = video_set_report_key_events,
+	 .driver_data = (void *)((uintptr_t)REPORT_BRIGHTNESS_KEY_EVENTS),
+	 .ident = "COLORFUL X15 AT 23",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "COLORFUL"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "X15 AT 23"),
+		},
+	},
 	/*
 	 * Some machines change the brightness themselves when a brightness
 	 * hotkey gets pressed, despite us telling them not to. In this case
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 4f06fd570d2c..2232576cbe2b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -846,6 +846,16 @@ binder_enqueue_thread_work_ilocked(struct binder_thread *thread,
 {
 	WARN_ON(!list_empty(&thread->waiting_thread_node));
 	binder_enqueue_work_ilocked(work, &thread->todo);
+
+	/* (e)poll-based threads require an explicit wakeup signal when
+	 * queuing their own work; they rely on these events to consume
+	 * messages without I/O block. Without it, threads risk waiting
+	 * indefinitely without handling the work.
+	 */
+	if (thread->looper & BINDER_LOOPER_STATE_POLL &&
+	    thread->pid == current->pid && !thread->process_todo)
+		wake_up_interruptible_sync(&thread->wait);
+
 	thread->process_todo = true;
 }
 
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 3380322df98e..36629633ae52 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -2936,6 +2936,8 @@ open_card_ubr0(struct idt77252_dev *card)
 	vc->scq = alloc_scq(card, vc->class);
 	if (!vc->scq) {
 		printk("%s: can't get SCQ.\n", card->name);
+		kfree(card->vcs[0]);
+		card->vcs[0] = NULL;
 		return -ENOMEM;
 	}
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6e380ad9d08a..5fd2b887cc04 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3334,6 +3334,50 @@ define_dev_printk_level(_dev_info, KERN_INFO);
 
 #endif
 
+/**
+ * dev_err_probe - probe error check and log helper
+ * @dev: the pointer to the struct device
+ * @err: error value to test
+ * @fmt: printf-style format string
+ * @...: arguments as specified in the format string
+ *
+ * This helper implements common pattern present in probe functions for error
+ * checking: print debug or error message depending if the error value is
+ * -EPROBE_DEFER and propagate error upwards.
+ * It replaces code sequence::
+ * 	if (err != -EPROBE_DEFER)
+ * 		dev_err(dev, ...);
+ * 	else
+ * 		dev_dbg(dev, ...);
+ * 	return err;
+ *
+ * with::
+ *
+ * 	return dev_err_probe(dev, err, ...);
+ *
+ * Returns @err.
+ *
+ */
+int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	if (err != -EPROBE_DEFER)
+		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+	else
+		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+
+	va_end(args);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(dev_err_probe);
+
 static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
 {
 	return fwnode && !IS_ERR(fwnode->secondary);
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b32d3cf4f670..8d71a6844787 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -847,7 +847,7 @@ static int __init genpd_power_off_unused(void)
 
 	return 0;
 }
-late_initcall(genpd_power_off_unused);
+late_initcall_sync(genpd_power_off_unused);
 
 #if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_GENERIC_DOMAINS_OF)
 
diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index c9757fa2d308..d932dd95b04e 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -24,10 +24,13 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 
 #define RNG_MODULE_NAME		"hw_random"
 
+#define RNG_BUFFER_SIZE (SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES)
+
 static struct hwrng *current_rng;
 /* the current rng has been explicitly chosen by user via sysfs */
 static int cur_rng_set_by_user;
@@ -59,7 +62,7 @@ static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 
 static size_t rng_buffer_size(void)
 {
-	return SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES;
+	return RNG_BUFFER_SIZE;
 }
 
 static void add_early_randomness(struct hwrng *rng)
@@ -202,6 +205,7 @@ static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 			    size_t size, loff_t *offp)
 {
+	u8 buffer[RNG_BUFFER_SIZE];
 	ssize_t ret = 0;
 	int err = 0;
 	int bytes_read, len;
@@ -229,34 +233,37 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 			if (bytes_read < 0) {
 				err = bytes_read;
 				goto out_unlock_reading;
+			} else if (bytes_read == 0 &&
+				   (filp->f_flags & O_NONBLOCK)) {
+				err = -EAGAIN;
+				goto out_unlock_reading;
 			}
+
 			data_avail = bytes_read;
 		}
 
-		if (!data_avail) {
-			if (filp->f_flags & O_NONBLOCK) {
-				err = -EAGAIN;
-				goto out_unlock_reading;
-			}
-		} else {
-			len = data_avail;
+		len = data_avail;
+		if (len) {
 			if (len > size)
 				len = size;
 
 			data_avail -= len;
 
-			if (copy_to_user(buf + ret, rng_buffer + data_avail,
-								len)) {
+			memcpy(buffer, rng_buffer + data_avail, len);
+		}
+		mutex_unlock(&reading_mutex);
+		put_rng(rng);
+
+		if (len) {
+			if (copy_to_user(buf + ret, buffer, len)) {
 				err = -EFAULT;
-				goto out_unlock_reading;
+				goto out;
 			}
 
 			size -= len;
 			ret += len;
 		}
 
-		mutex_unlock(&reading_mutex);
-		put_rng(rng);
 
 		if (need_resched())
 			schedule_timeout_interruptible(1);
@@ -267,6 +274,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 		}
 	}
 out:
+	memzero_explicit(buffer, sizeof(buffer));
 	return ret ? : err;
 
 out_unlock_reading:
diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 77072c7778b9..93b4d8933797 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -481,8 +481,10 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 		return;
 
 	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
+	if (!clk_data->clks) {
+		kfree(clk_data);
 		return;
+	}
 
 	for (i = 0; i < num; i++) {
 		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
diff --git a/drivers/clk/mmp/clk-of-pxa168.c b/drivers/clk/mmp/clk-of-pxa168.c
index f110c02e83cb..9674c6c06dca 100644
--- a/drivers/clk/mmp/clk-of-pxa168.c
+++ b/drivers/clk/mmp/clk-of-pxa168.c
@@ -258,18 +258,21 @@ static void __init pxa168_clk_init(struct device_node *np)
 	pxa_unit->mpmu_base = of_iomap(np, 0);
 	if (!pxa_unit->mpmu_base) {
 		pr_err("failed to map mpmu registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
 	pxa_unit->apmu_base = of_iomap(np, 1);
 	if (!pxa_unit->apmu_base) {
 		pr_err("failed to map apmu registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
 	pxa_unit->apbc_base = of_iomap(np, 2);
 	if (!pxa_unit->apbc_base) {
 		pr_err("failed to map apbc registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
diff --git a/drivers/crypto/stm32/stm32_crc32.c b/drivers/crypto/stm32/stm32_crc32.c
index de645bf84980..04adc84d677c 100644
--- a/drivers/crypto/stm32/stm32_crc32.c
+++ b/drivers/crypto/stm32/stm32_crc32.c
@@ -98,7 +98,7 @@ static struct stm32_crc *stm32_crc_get_next_crc(void)
 	struct stm32_crc *crc;
 
 	spin_lock_bh(&crc_list.lock);
-	crc = list_first_entry(&crc_list.dev_list, struct stm32_crc, list);
+	crc = list_first_entry_or_null(&crc_list.dev_list, struct stm32_crc, list);
 	if (crc)
 		list_move_tail(&crc->list, &crc_list.dev_list);
 	spin_unlock_bh(&crc_list.lock);
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index a293b39fd4ce..25c5de074525 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -113,10 +113,9 @@ static int textual_leaf_to_string(const u32 *block, char *buf, size_t size)
  * @buf:	where to put the string
  * @size:	size of @buf, in bytes
  *
- * The string is taken from a minimal ASCII text descriptor leaf after
- * the immediate entry with @key.  The string is zero-terminated.
- * An overlong string is silently truncated such that it and the
- * zero byte fit into @size.
+ * The string is taken from a minimal ASCII text descriptor leaf just after the entry with the
+ * @key. The string is zero-terminated. An overlong string is silently truncated such that it
+ * and the zero byte fit into @size.
  *
  * Returns strlen(buf) or a negative error code.
  */
diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 4f1af323ec03..cfa36c0de5b6 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -318,20 +318,27 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 		switch (flow_type) {
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IC, 1);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IC, 1);
 			break;
 		case IRQ_TYPE_EDGE_RISING:
 		case IRQ_TYPE_EDGE_FALLING:
 		case IRQ_TYPE_EDGE_BOTH:
 			state = sprd_eic_get(chip, offset);
-			if (state)
+			if (state) {
 				sprd_eic_update(chip, offset,
 						SPRD_EIC_DBNC_IEV, 0);
-			else
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_DBNC_IC, 1);
+			} else {
 				sprd_eic_update(chip, offset,
 						SPRD_EIC_DBNC_IEV, 1);
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_DBNC_IC, 1);
+			}
 			break;
 		default:
 			return -ENOTSUPP;
@@ -343,20 +350,27 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 		switch (flow_type) {
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTCLR, 1);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTCLR, 1);
 			break;
 		case IRQ_TYPE_EDGE_RISING:
 		case IRQ_TYPE_EDGE_FALLING:
 		case IRQ_TYPE_EDGE_BOTH:
 			state = sprd_eic_get(chip, offset);
-			if (state)
+			if (state) {
 				sprd_eic_update(chip, offset,
 						SPRD_EIC_LATCH_INTPOL, 0);
-			else
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_LATCH_INTCLR, 1);
+			} else {
 				sprd_eic_update(chip, offset,
 						SPRD_EIC_LATCH_INTPOL, 1);
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_LATCH_INTCLR, 1);
+			}
 			break;
 		default:
 			return -ENOTSUPP;
@@ -370,29 +384,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_FALLING:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_BOTH:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		default:
@@ -405,29 +424,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_FALLING:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_BOTH:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		default:
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 6afe833031e3..33b28430e618 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1427,6 +1427,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] = {
 			.ignore_wake = "INT33FF:01@0",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from TP_ATTN# pin
+		 * Found in BIOS 0.35
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3073
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1619-04"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "PNP0C50:00@8",
+		},
+	},
 	{} /* Terminating entry */
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 574c1181ae9a..75e4f1abb4c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -88,7 +88,7 @@ struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
 		return NULL;
 
 	fence = container_of(f, struct amdgpu_amdkfd_fence, base);
-	if (fence && f->ops == &amdkfd_fence_ops)
+	if (f->ops == &amdkfd_fence_ops)
 		return fence;
 
 	return NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c84f475d4f13..ae28f72c73ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -823,6 +823,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 				return true;
 
 			fw_ver = *((uint32_t *)adev->pm.fw->data + 69);
+			release_firmware(adev->pm.fw);
 			if (fw_ver < 0x00160e00)
 				return true;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 2d6f5ec77a68..5eb8f93c7022 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -219,7 +219,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev,
 		 */
 		fence_owner = amdgpu_sync_get_owner(f);
 		if (fence_owner == AMDGPU_FENCE_OWNER_KFD &&
-		    owner != AMDGPU_FENCE_OWNER_UNDEFINED)
+		    owner != AMDGPU_FENCE_OWNER_UNDEFINED &&
+	    owner != AMDGPU_FENCE_OWNER_KFD)
 			continue;
 
 		if (amdgpu_sync_same_dev(adev, f)) {
diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index a3e817abace1..5eb7e4992f39 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -64,13 +64,13 @@ static int ptn3460_read_bytes(struct ptn3460_bridge *ptn_bridge, char addr,
 	int ret;
 
 	ret = i2c_master_send(ptn_bridge->client, &addr, 1);
-	if (ret <= 0) {
+	if (ret < 0) {
 		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
 		return ret;
 	}
 
 	ret = i2c_master_recv(ptn_bridge->client, buf, len);
-	if (ret <= 0) {
+	if (ret < 0) {
 		DRM_ERROR("Failed to recv i2c data, ret=%d\n", ret);
 		return ret;
 	}
@@ -88,7 +88,7 @@ static int ptn3460_write_byte(struct ptn3460_bridge *ptn_bridge, char addr,
 	buf[1] = val;
 
 	ret = i2c_master_send(ptn_bridge->client, buf, ARRAY_SIZE(buf));
-	if (ret <= 0) {
+	if (ret < 0) {
 		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
 		return ret;
 	}
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 334addaca9c5..06cdae6f598c 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -299,7 +299,7 @@ int drm_open(struct inode *inode, struct file *filp)
 {
 	struct drm_device *dev;
 	struct drm_minor *minor;
-	int retcode;
+	int retcode = 0;
 	int need_setup = 0;
 
 	minor = drm_minor_acquire(iminor(inode));
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index b64a6ffc0aed..9fc4af4b10a6 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -538,7 +538,7 @@ int drm_mode_dirtyfb_ioctl(struct drm_device *dev,
 	struct drm_framebuffer *fb;
 	unsigned flags;
 	int num_clips;
-	int ret;
+	int ret = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 81923442b42d..2bd4e768b129 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -305,7 +305,8 @@ static int mipi_dsi_remove_device_fn(struct device *dev, void *priv)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
 
-	mipi_dsi_detach(dsi);
+	if (dsi->attached)
+		mipi_dsi_detach(dsi);
 	mipi_dsi_device_unregister(dsi);
 
 	return 0;
@@ -328,11 +329,18 @@ EXPORT_SYMBOL(mipi_dsi_host_unregister);
 int mipi_dsi_attach(struct mipi_dsi_device *dsi)
 {
 	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
+	int ret;
 
 	if (!ops || !ops->attach)
 		return -ENOSYS;
 
-	return ops->attach(dsi->host, dsi);
+	ret = ops->attach(dsi->host, dsi);
+	if (ret)
+		return ret;
+
+	dsi->attached = true;
+
+	return 0;
 }
 EXPORT_SYMBOL(mipi_dsi_attach);
 
@@ -344,9 +352,14 @@ int mipi_dsi_detach(struct mipi_dsi_device *dsi)
 {
 	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
 
+	if (WARN_ON(!dsi->attached))
+		return -EINVAL;
+
 	if (!ops || !ops->detach)
 		return -ENOSYS;
 
+	dsi->attached = false;
+
 	return ops->detach(dsi->host, dsi);
 }
 EXPORT_SYMBOL(mipi_dsi_detach);
diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 425e76e39b3b..35df2fac5c29 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1183,6 +1183,7 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
 out:
 	if (fb)
 		drm_framebuffer_put(fb);
+	fb = NULL;
 	if (plane->old_fb)
 		drm_framebuffer_put(plane->old_fb);
 	plane->old_fb = NULL;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index b599f74692e5..db09e2055c86 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -410,6 +410,7 @@ static int exynos_drm_bind(struct device *dev)
 	drm_release_iommu_mapping(drm);
 err_free_private:
 	kfree(private);
+	dev_set_drvdata(dev, NULL);
 err_free_drm:
 	drm_dev_put(drm);
 
@@ -424,6 +425,7 @@ static void exynos_drm_unbind(struct device *dev)
 
 	exynos_drm_fbdev_fini(drm);
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 
 	component_unbind_all(drm->dev, drm);
 	drm_mode_config_cleanup(drm);
@@ -461,9 +463,18 @@ static int exynos_drm_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void exynos_drm_platform_shutdown(struct platform_device *pdev)
+{
+	struct drm_device *drm = platform_get_drvdata(pdev);
+
+	if (drm)
+		drm_atomic_helper_shutdown(drm);
+}
+
 static struct platform_driver exynos_drm_platform_driver = {
 	.probe	= exynos_drm_platform_probe,
 	.remove	= exynos_drm_platform_remove,
+	.shutdown = exynos_drm_platform_shutdown,
 	.driver	= {
 		.name	= "exynos-drm",
 		.pm	= &exynos_drm_pm_ops,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index d71188b982cb..4a93d87c2096 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1322,7 +1322,7 @@ static int __maybe_unused gsc_runtime_resume(struct device *dev)
 	for (i = 0; i < ctx->num_clocks; i++) {
 		ret = clk_prepare_enable(ctx->clocks[i]);
 		if (ret) {
-			while (--i > 0)
+			while (--i >= 0)
 				clk_disable_unprepare(ctx->clocks[i]);
 			return ret;
 		}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 19e2753ffe07..a411cfe76998 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -53,6 +53,9 @@
 		(p) ? ((p)->hw_pp ? (p)->hw_pp->idx - PINGPONG_0 : -1) : -1, \
 		##__VA_ARGS__)
 
+#define DPU_ERROR_ENC_RATELIMITED(e, fmt, ...) DPU_ERROR_RATELIMITED("enc%d " fmt,\
+		(e) ? (e)->base.base.id : -1, ##__VA_ARGS__)
+
 /*
  * Two to anticipate panels that can do cmd/vid dynamic switching
  * plan is to create all possible physical encoder types, and switch between
@@ -2326,7 +2329,7 @@ static void dpu_encoder_frame_done_timeout(struct timer_list *t)
 		return;
 	}
 
-	DPU_ERROR_ENC(dpu_enc, "frame done timeout\n");
+	DPU_ERROR_ENC_RATELIMITED(dpu_enc, "frame done timeout\n");
 
 	event = DPU_ENCODER_FRAME_EVENT_ERROR;
 	trace_dpu_enc_frame_done_timeout(DRMID(drm_enc), event);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index 66d466628e2b..56ae888e18fc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -61,6 +61,7 @@
 	} while (0)
 
 #define DPU_ERROR(fmt, ...) pr_err("[dpu error]" fmt, ##__VA_ARGS__)
+#define DPU_ERROR_RATELIMITED(fmt, ...) pr_err_ratelimited("[dpu error]" fmt, ##__VA_ARGS__)
 
 /**
  * ktime_compare_safe - compare two ktime structures
diff --git a/drivers/gpu/drm/nouveau/nouveau_vmm.c b/drivers/gpu/drm/nouveau/nouveau_vmm.c
index 2032c3e4f6e5..fe8b88c6e2f9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_vmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_vmm.c
@@ -107,6 +107,9 @@ nouveau_vma_new(struct nouveau_bo *nvbo, struct nouveau_vmm *vmm,
 	} else {
 		ret = nvif_vmm_get(&vmm->vmm, PTES, false, mem->mem.page, 0,
 				   mem->mem.size, &tmp);
+		if (ret)
+			goto done;
+
 		vma->addr = tmp.addr;
 	}
 
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 80ecbf14d3c8..8ba8f76c92c0 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -54,6 +54,12 @@ MODULE_PARM_DESC(swap_opt_cmd, "Swap the Option (\"Alt\") and Command (\"Flag\")
 		"(For people who want to keep Windows PC keyboard muscle memory. "
 		"[0] = as-is, Mac layout. 1 = swapped, Windows layout.)");
 
+static unsigned int swap_fn_leftctrl;
+module_param(swap_fn_leftctrl, uint, 0644);
+MODULE_PARM_DESC(swap_fn_leftctrl, "Swap the Fn and left Control keys. "
+		"(For people who want to keep PC keyboard muscle memory. "
+		"[0] = as-is, Mac layout, 1 = swapped, PC layout)");
+
 struct apple_sc {
 	unsigned long quirks;
 	unsigned int fn_on;
@@ -67,6 +73,28 @@ struct apple_key_translation {
 	u8 flags;
 };
 
+static const struct apple_key_translation apple2021_fn_keys[] = {
+	{ KEY_BACKSPACE, KEY_DELETE },
+	{ KEY_ENTER,	KEY_INSERT },
+	{ KEY_F1,	KEY_BRIGHTNESSDOWN, APPLE_FLAG_FKEY },
+	{ KEY_F2,	KEY_BRIGHTNESSUP,   APPLE_FLAG_FKEY },
+	{ KEY_F3,	KEY_SCALE,          APPLE_FLAG_FKEY },
+	{ KEY_F4,	KEY_SEARCH,         APPLE_FLAG_FKEY },
+	{ KEY_F5,	KEY_MICMUTE,        APPLE_FLAG_FKEY },
+	{ KEY_F6,	KEY_SLEEP,          APPLE_FLAG_FKEY },
+	{ KEY_F7,	KEY_PREVIOUSSONG,   APPLE_FLAG_FKEY },
+	{ KEY_F8,	KEY_PLAYPAUSE,      APPLE_FLAG_FKEY },
+	{ KEY_F9,	KEY_NEXTSONG,       APPLE_FLAG_FKEY },
+	{ KEY_F10,	KEY_MUTE,           APPLE_FLAG_FKEY },
+	{ KEY_F11,	KEY_VOLUMEDOWN,     APPLE_FLAG_FKEY },
+	{ KEY_F12,	KEY_VOLUMEUP,       APPLE_FLAG_FKEY },
+	{ KEY_UP,	KEY_PAGEUP },
+	{ KEY_DOWN,	KEY_PAGEDOWN },
+	{ KEY_LEFT,	KEY_HOME },
+	{ KEY_RIGHT,	KEY_END },
+	{ }
+};
+
 static const struct apple_key_translation macbookair_fn_keys[] = {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_ENTER,	KEY_INSERT },
@@ -166,6 +194,11 @@ static const struct apple_key_translation swapped_option_cmd_keys[] = {
 	{ }
 };
 
+static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
+	{ KEY_FN, KEY_LEFTCTRL },
+	{ }
+};
+
 static const struct apple_key_translation *apple_find_translation(
 		const struct apple_key_translation *table, u16 from)
 {
@@ -187,14 +220,18 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	bool do_translate;
 	u16 code = 0;
 
-	if (usage->code == KEY_FN) {
+	u16 fn_keycode = (swap_fn_leftctrl) ? (KEY_LEFTCTRL) : (KEY_FN);
+
+	if (usage->code == fn_keycode) {
 		asc->fn_on = !!value;
-		input_event(input, usage->type, usage->code, value);
+		input_event(input, usage->type, KEY_FN, value);
 		return 1;
 	}
 
 	if (fnmode) {
-		if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
+		if (hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021)
+			table = apple2021_fn_keys;
+		else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
 				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
 			table = macbookair_fn_keys;
 		else if (hid->product < 0x21d || hid->product >= 0x300)
@@ -274,6 +311,14 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 		}
 	}
 
+	if (swap_fn_leftctrl) {
+		trans = apple_find_translation(swapped_fn_leftctrl_keys, usage->code);
+		if (trans) {
+			input_event(input, usage->type, trans->to, value);
+			return 1;
+		}
+	}
+
 	return 0;
 }
 
@@ -344,6 +389,14 @@ static void apple_setup_input(struct input_dev *input)
 
 	for (trans = apple_iso_keyboard; trans->from; trans++)
 		set_bit(trans->to, input->keybit);
+
+	for (trans = apple2021_fn_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+
+	if (swap_fn_leftctrl) {
+		for (trans = swapped_fn_leftctrl_keys; trans->from; trans++)
+			set_bit(trans->to, input->keybit);
+	}
 }
 
 static int apple_input_mapping(struct hid_device *hdev, struct hid_input *hi,
@@ -599,6 +652,10 @@ static const struct hid_device_id apple_devices[] = {
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
+		.driver_data = APPLE_HAS_FN },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
+		.driver_data = APPLE_HAS_FN },
 
 	{ }
 };
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 93faf083e550..3267e2da30e6 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -176,6 +176,7 @@
 #define USB_DEVICE_ID_APPLE_IRCONTROL3	0x8241
 #define USB_DEVICE_ID_APPLE_IRCONTROL4	0x8242
 #define USB_DEVICE_ID_APPLE_IRCONTROL5	0x8243
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021   0x029c
 
 #define USB_VENDOR_ID_ASUS		0x0486
 #define USB_DEVICE_ID_ASUS_T91MT	0x0185
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 2e1b95f73c64..d2ca1fc3d37e 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -301,6 +301,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021) },
 #endif
 #if IS_ENABLED(CONFIG_HID_APPLEIR)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL) },
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 8255010b03d0..3c3c41742af6 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2059,7 +2059,7 @@ static int wacom_allocate_inputs(struct wacom *wacom)
 	return 0;
 }
 
-static int wacom_register_inputs(struct wacom *wacom)
+static int wacom_setup_inputs(struct wacom *wacom)
 {
 	struct input_dev *pen_input_dev, *touch_input_dev, *pad_input_dev;
 	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
@@ -2078,10 +2078,6 @@ static int wacom_register_inputs(struct wacom *wacom)
 		input_free_device(pen_input_dev);
 		wacom_wac->pen_input = NULL;
 		pen_input_dev = NULL;
-	} else {
-		error = input_register_device(pen_input_dev);
-		if (error)
-			goto fail;
 	}
 
 	error = wacom_setup_touch_input_capabilities(touch_input_dev, wacom_wac);
@@ -2090,10 +2086,6 @@ static int wacom_register_inputs(struct wacom *wacom)
 		input_free_device(touch_input_dev);
 		wacom_wac->touch_input = NULL;
 		touch_input_dev = NULL;
-	} else {
-		error = input_register_device(touch_input_dev);
-		if (error)
-			goto fail;
 	}
 
 	error = wacom_setup_pad_input_capabilities(pad_input_dev, wacom_wac);
@@ -2102,7 +2094,34 @@ static int wacom_register_inputs(struct wacom *wacom)
 		input_free_device(pad_input_dev);
 		wacom_wac->pad_input = NULL;
 		pad_input_dev = NULL;
-	} else {
+	}
+
+	return 0;
+}
+
+static int wacom_register_inputs(struct wacom *wacom)
+{
+	struct input_dev *pen_input_dev, *touch_input_dev, *pad_input_dev;
+	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
+	int error = 0;
+
+	pen_input_dev = wacom_wac->pen_input;
+	touch_input_dev = wacom_wac->touch_input;
+	pad_input_dev = wacom_wac->pad_input;
+
+	if (pen_input_dev) {
+		error = input_register_device(pen_input_dev);
+		if (error)
+			goto fail;
+	}
+
+	if (touch_input_dev) {
+		error = input_register_device(touch_input_dev);
+		if (error)
+			goto fail;
+	}
+
+	if (pad_input_dev) {
 		error = input_register_device(pad_input_dev);
 		if (error)
 			goto fail;
@@ -2352,6 +2371,20 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 			goto fail;
 	}
 
+	error = wacom_setup_inputs(wacom);
+	if (error)
+		goto fail;
+
+	if (features->type == HID_GENERIC)
+		connect_mask |= HID_CONNECT_DRIVER;
+
+	/* Regular HID work starts now */
+	error = hid_hw_start(hdev, connect_mask);
+	if (error) {
+		hid_err(hdev, "hw start failed\n");
+		goto fail;
+	}
+
 	error = wacom_register_inputs(wacom);
 	if (error)
 		goto fail;
@@ -2366,16 +2399,6 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 			goto fail;
 	}
 
-	if (features->type == HID_GENERIC)
-		connect_mask |= HID_CONNECT_DRIVER;
-
-	/* Regular HID work starts now */
-	error = hid_hw_start(hdev, connect_mask);
-	if (error) {
-		hid_err(hdev, "hw start failed\n");
-		goto fail;
-	}
-
 	if (!wireless) {
 		/* Note that if query fails it is not a hard failure */
 		wacom_query_tablet_data(wacom);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 9b2a5a6917fc..46dd5a93a375 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2461,7 +2461,14 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 				wacom_wac->hid_data.tipswitch);
 		input_report_key(input, wacom_wac->tool[0], sense);
 		if (wacom_wac->serial[0]) {
-			input_event(input, EV_MSC, MSC_SERIAL, wacom_wac->serial[0]);
+			/*
+			 * xf86-input-wacom does not accept a serial number
+			 * of '0'. Report the low 32 bits if possible, but
+			 * if they are zero, report the upper ones instead.
+			 */
+			__u32 serial_lo = wacom_wac->serial[0] & 0xFFFFFFFFu;
+			__u32 serial_hi = wacom_wac->serial[0] >> 32;
+			input_event(input, EV_MSC, MSC_SERIAL, (int)(serial_lo ? serial_lo : serial_hi));
 			input_report_abs(input, ABS_MISC, sense ? id : 0);
 		}
 
diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index a43fa730a513..4097ae62e9a4 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -197,6 +197,8 @@ struct aspeed_pwm_tacho_data {
 	u8 fan_tach_ch_source[16];
 	struct aspeed_cooling_device *cdev[8];
 	const struct attribute_group *groups[3];
+	/* protects access to shared ASPEED_PTCR_RESULT */
+	struct mutex tach_lock;
 };
 
 enum type { TYPEM, TYPEN, TYPEO };
@@ -531,6 +533,8 @@ static int aspeed_get_fan_tach_ch_rpm(struct aspeed_pwm_tacho_data *priv,
 	u8 fan_tach_ch_source, type, mode, both;
 	int ret;
 
+	mutex_lock(&priv->tach_lock);
+
 	regmap_write(priv->regmap, ASPEED_PTCR_TRIGGER, 0);
 	regmap_write(priv->regmap, ASPEED_PTCR_TRIGGER, 0x1 << fan_tach_ch);
 
@@ -548,6 +552,8 @@ static int aspeed_get_fan_tach_ch_rpm(struct aspeed_pwm_tacho_data *priv,
 		ASPEED_RPM_STATUS_SLEEP_USEC,
 		usec);
 
+	mutex_unlock(&priv->tach_lock);
+
 	/* return -ETIMEDOUT if we didn't get an answer. */
 	if (ret)
 		return ret;
@@ -938,6 +944,7 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+	mutex_init(&priv->tach_lock);
 	priv->regmap = devm_regmap_init(dev, NULL, (__force void *)regs,
 			&aspeed_pwm_tacho_regmap_config);
 	if (IS_ERR(priv->regmap))
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 33371f7a4c0f..d06e88477588 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -393,7 +393,7 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 }
 
 static int create_core_attrs(struct temp_data *tdata, struct device *dev,
-			     int attr_no)
+			     int index)
 {
 	int i;
 	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
@@ -405,13 +405,20 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
 	};
 
 	for (i = 0; i < tdata->attr_size; i++) {
+		/*
+		 * We map the attr number to core id of the CPU
+		 * The attr number is always core id + 2
+		 * The Pkgtemp will always show up as temp1_*, if available
+		 */
+		int attr_no = tdata->is_pkg_data ? 1 : tdata->cpu_core_id + 2;
+
 		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
 			 "temp%d_%s", attr_no, suffixes[i]);
 		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
 		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
 		tdata->sd_attrs[i].dev_attr.attr.mode = S_IRUGO;
 		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
-		tdata->sd_attrs[i].index = attr_no;
+		tdata->sd_attrs[i].index = index;
 		tdata->attrs[i] = &tdata->sd_attrs[i].dev_attr.attr;
 	}
 	tdata->attr_group.attrs = tdata->attrs;
@@ -469,27 +476,22 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	u32 eax, edx;
-	int err, index, attr_no;
+	int err, index;
 
 	/*
-	 * Find attr number for sysfs:
-	 * We map the attr number to core id of the CPU
-	 * The attr number is always core id + 2
-	 * The Pkgtemp will always show up as temp1_*, if available
+	 * Get the index of tdata in pdata->core_data[]
+	 * tdata for package: pdata->core_data[1]
+	 * tdata for core: pdata->core_data[2] .. pdata->core_data[NUM_REAL_CORES + 1]
 	 */
 	if (pkg_flag) {
-		attr_no = PKG_SYSFS_ATTR_NO;
+		index = PKG_SYSFS_ATTR_NO;
 	} else {
-		index = ida_alloc(&pdata->ida, GFP_KERNEL);
+		index = ida_alloc_max(&pdata->ida, NUM_REAL_CORES - 1, GFP_KERNEL);
 		if (index < 0)
 			return index;
-		pdata->cpu_map[index] = topology_core_id(cpu);
-		attr_no = index + BASE_SYSFS_ATTR_NO;
-	}
 
-	if (attr_no > MAX_CORE_DATA - 1) {
-		err = -ERANGE;
-		goto ida_free;
+		pdata->cpu_map[index] = topology_core_id(cpu);
+		index += BASE_SYSFS_ATTR_NO;
 	}
 
 	tdata = init_temp_data(cpu, pkg_flag);
@@ -521,20 +523,20 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 		}
 	}
 
-	pdata->core_data[attr_no] = tdata;
+	pdata->core_data[index] = tdata;
 
 	/* Create sysfs interfaces */
-	err = create_core_attrs(tdata, pdata->hwmon_dev, attr_no);
+	err = create_core_attrs(tdata, pdata->hwmon_dev, index);
 	if (err)
 		goto exit_free;
 
 	return 0;
 exit_free:
-	pdata->core_data[attr_no] = NULL;
+	pdata->core_data[index] = NULL;
 	kfree(tdata);
 ida_free:
 	if (!pkg_flag)
-		ida_free(&pdata->ida, index);
+		ida_free(&pdata->ida, index - BASE_SYSFS_ATTR_NO);
 	return err;
 }
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index b9e9562f5034..de82fb0cb1d5 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -543,21 +543,18 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
 			/* SM supports sendonly-fullmember, otherwise fallback to full-member */
 			rec.join_state = SENDONLY_FULLMEMBER_JOIN;
 	}
-	spin_unlock_irq(&priv->lock);
 
 	multicast = ib_sa_join_multicast(&ipoib_sa_client, priv->ca, priv->port,
-					 &rec, comp_mask, GFP_KERNEL,
+					 &rec, comp_mask, GFP_ATOMIC,
 					 ipoib_mcast_join_complete, mcast);
-	spin_lock_irq(&priv->lock);
 	if (IS_ERR(multicast)) {
 		ret = PTR_ERR(multicast);
 		ipoib_warn(priv, "ib_sa_join_multicast failed, status %d\n", ret);
 		/* Requeue this join task with a backoff delay */
 		__ipoib_mcast_schedule_join_thread(priv, mcast, 1);
 		clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
-		spin_unlock_irq(&priv->lock);
 		complete(&mcast->done);
-		spin_lock_irq(&priv->lock);
+		return ret;
 	}
 	return 0;
 }
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index facfdc8fb122..585bf7392539 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -763,7 +763,6 @@ static int atkbd_probe(struct atkbd *atkbd)
 {
 	struct ps2dev *ps2dev = &atkbd->ps2dev;
 	unsigned char param[2];
-	bool skip_getid;
 
 /*
  * Some systems, where the bit-twiddling when testing the io-lines of the
@@ -777,6 +776,11 @@ static int atkbd_probe(struct atkbd *atkbd)
 				 "keyboard reset failed on %s\n",
 				 ps2dev->serio->phys);
 
+	if (atkbd_skip_getid(atkbd)) {
+		atkbd->id = 0xab83;
+		return 0;
+	}
+
 /*
  * Then we check the keyboard ID. We should get 0xab83 under normal conditions.
  * Some keyboards report different values, but the first byte is always 0xab or
@@ -785,18 +789,17 @@ static int atkbd_probe(struct atkbd *atkbd)
  */
 
 	param[0] = param[1] = 0xa5;	/* initialize with invalid values */
-	skip_getid = atkbd_skip_getid(atkbd);
-	if (skip_getid || ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
+	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
 
 /*
- * If the get ID command was skipped or failed, we check if we can at least set
+ * If the get ID command failed, we check if we can at least set
  * the LEDs on the keyboard. This should work on every keyboard out there.
  * It also turns the LEDs off, which we want anyway.
  */
 		param[0] = 0;
 		if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
 			return -1;
-		atkbd->id = skip_getid ? 0xab83 : 0xabba;
+		atkbd->id = 0xabba;
 		return 0;
 	}
 
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 3f1ae63233cb..18c46194dcd1 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -121,6 +121,9 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 		generic_handle_irq(irq_linear_revmap(b->domain, irq));
 	} while (status);
 out:
+	/* Don't ack parent before all device writes are done */
+	wmb();
+
 	chained_irq_exit(chip, desc);
 }
 
diff --git a/drivers/leds/trigger/ledtrig-panic.c b/drivers/leds/trigger/ledtrig-panic.c
index d735526b9db4..2fc04418a87e 100644
--- a/drivers/leds/trigger/ledtrig-panic.c
+++ b/drivers/leds/trigger/ledtrig-panic.c
@@ -67,10 +67,13 @@ static long led_panic_blink(int state)
 
 static int __init ledtrig_panic_init(void)
 {
+	led_trigger_register_simple("panic", &trigger);
+	if (!trigger)
+		return -ENOMEM;
+
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &led_trigger_panic_nb);
 
-	led_trigger_register_simple("panic", &trigger);
 	panic_blink = led_panic_blink;
 	return 0;
 }
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6b074c2202d5..3cc28b283607 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1034,6 +1034,7 @@ struct super_type  {
 					  struct md_rdev *refdev,
 					  int minor_version);
 	int		    (*validate_super)(struct mddev *mddev,
+					      struct md_rdev *freshest,
 					      struct md_rdev *rdev);
 	void		    (*sync_super)(struct mddev *mddev,
 					  struct md_rdev *rdev);
@@ -1160,8 +1161,9 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 
 /*
  * validate_super for 0.90.0
+ * note: we are not using "freshest" for 0.9 superblock
  */
-static int super_90_validate(struct mddev *mddev, struct md_rdev *rdev)
+static int super_90_validate(struct mddev *mddev, struct md_rdev *freshest, struct md_rdev *rdev)
 {
 	mdp_disk_t *desc;
 	mdp_super_t *sb = page_address(rdev->sb_page);
@@ -1665,7 +1667,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	return ret;
 }
 
-static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
+static int super_1_validate(struct mddev *mddev, struct md_rdev *freshest, struct md_rdev *rdev)
 {
 	struct mdp_superblock_1 *sb = page_address(rdev->sb_page);
 	__u64 ev1 = le64_to_cpu(sb->events);
@@ -1761,13 +1763,15 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 		}
 	} else if (mddev->pers == NULL) {
 		/* Insist of good event counter while assembling, except for
-		 * spares (which don't need an event count) */
-		++ev1;
+		 * spares (which don't need an event count).
+		 * Similar to mdadm, we allow event counter difference of 1
+		 * from the freshest device.
+		 */
 		if (rdev->desc_nr >= 0 &&
 		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
 		    (le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
 		     le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL))
-			if (ev1 < mddev->events)
+			if (ev1 + 1 < mddev->events)
 				return -EINVAL;
 	} else if (mddev->bitmap) {
 		/* If adding to array with a bitmap, then we can accept an
@@ -1788,8 +1792,38 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 		    rdev->desc_nr >= le32_to_cpu(sb->max_dev)) {
 			role = MD_DISK_ROLE_SPARE;
 			rdev->desc_nr = -1;
-		} else
+		} else if (mddev->pers == NULL && freshest && ev1 < mddev->events) {
+			/*
+			 * If we are assembling, and our event counter is smaller than the
+			 * highest event counter, we cannot trust our superblock about the role.
+			 * It could happen that our rdev was marked as Faulty, and all other
+			 * superblocks were updated with +1 event counter.
+			 * Then, before the next superblock update, which typically happens when
+			 * remove_and_add_spares() removes the device from the array, there was
+			 * a crash or reboot.
+			 * If we allow current rdev without consulting the freshest superblock,
+			 * we could cause data corruption.
+			 * Note that in this case our event counter is smaller by 1 than the
+			 * highest, otherwise, this rdev would not be allowed into array;
+			 * both kernel and mdadm allow event counter difference of 1.
+			 */
+			struct mdp_superblock_1 *freshest_sb = page_address(freshest->sb_page);
+			u32 freshest_max_dev = le32_to_cpu(freshest_sb->max_dev);
+
+			if (rdev->desc_nr >= freshest_max_dev) {
+				/* this is unexpected, better not proceed */
+				pr_warn("md: %s: rdev[%pg]: desc_nr(%d) >= freshest(%pg)->sb->max_dev(%u)\n",
+						mdname(mddev), rdev->bdev, rdev->desc_nr,
+						freshest->bdev, freshest_max_dev);
+				return -EUCLEAN;
+			}
+
+			role = le16_to_cpu(freshest_sb->dev_roles[rdev->desc_nr]);
+			pr_debug("md: %s: rdev[%pg]: role=%d(0x%x) according to freshest %pg\n",
+				     mdname(mddev), rdev->bdev, role, role, freshest->bdev);
+		} else {
 			role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
+		}
 		switch(role) {
 		case MD_DISK_ROLE_SPARE: /* spare */
 			break;
@@ -2691,7 +2725,7 @@ static int add_bound_rdev(struct md_rdev *rdev)
 		 * and should be added immediately.
 		 */
 		super_types[mddev->major_version].
-			validate_super(mddev, rdev);
+			validate_super(mddev, NULL/*freshest*/, rdev);
 		if (add_journal)
 			mddev_suspend(mddev);
 		err = mddev->pers->hot_add_disk(mddev, rdev);
@@ -3593,7 +3627,7 @@ static void analyze_sbs(struct mddev *mddev)
 		}
 
 	super_types[mddev->major_version].
-		validate_super(mddev, freshest);
+		validate_super(mddev, NULL/*freshest*/, freshest);
 
 	i = 0;
 	rdev_for_each_safe(rdev, tmp, mddev) {
@@ -3608,7 +3642,7 @@ static void analyze_sbs(struct mddev *mddev)
 		}
 		if (rdev != freshest) {
 			if (super_types[mddev->major_version].
-			    validate_super(mddev, rdev)) {
+			    validate_super(mddev, freshest, rdev)) {
 				pr_warn("md: kicking non-fresh %s from array!\n",
 					bdevname(rdev->bdev,b));
 				md_kick_rdev_from_array(rdev);
@@ -6453,7 +6487,7 @@ static int add_new_disk(struct mddev *mddev, mdu_disk_info_t *info)
 			rdev->saved_raid_disk = rdev->raid_disk;
 		} else
 			super_types[mddev->major_version].
-				validate_super(mddev, rdev);
+				validate_super(mddev, NULL/*freshest*/, rdev);
 		if ((info->state & (1<<MD_DISK_SYNC)) &&
 		     rdev->raid_disk != info->raid_disk) {
 			/* This was a hot-add request, but events doesn't
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index b98abe927d06..e2fcc09a18cd 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -44,7 +44,6 @@
  */
 
 #include <linux/blkdev.h>
-#include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/raid/pq.h>
 #include <linux/async_tx.h>
@@ -6330,18 +6329,7 @@ static void raid5d(struct md_thread *thread)
 			spin_unlock_irq(&conf->device_lock);
 			md_check_recovery(mddev);
 			spin_lock_irq(&conf->device_lock);
-
-			/*
-			 * Waiting on MD_SB_CHANGE_PENDING below may deadlock
-			 * seeing md_check_recovery() is needed to clear
-			 * the flag when using mdmon.
-			 */
-			continue;
 		}
-
-		wait_event_lock_irq(mddev->sb_wait,
-			!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags),
-			conf->device_lock);
 	}
 	pr_debug("%d stripes handled\n", handled);
 
diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index f4748cfd904b..7aa6c966ba0d 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -247,7 +247,7 @@ static int ddb_probe(struct pci_dev *pdev,
 	ddb_unmap(dev);
 	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
-	return -1;
+	return stat;
 }
 
 /****************************************************************************/
diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index 86a76f35a9a1..03bf575fd31a 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -195,25 +195,16 @@ static int rga_setup_ctrls(struct rga_ctx *ctx)
 static struct rga_fmt formats[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_ARGB32,
-		.color_swap = RGA_COLOR_RB_SWAP,
+		.color_swap = RGA_COLOR_ALPHA_SWAP,
 		.hw_format = RGA_COLOR_FMT_ABGR8888,
 		.depth = 32,
 		.uv_factor = 1,
 		.y_div = 1,
 		.x_div = 1,
 	},
-	{
-		.fourcc = V4L2_PIX_FMT_XRGB32,
-		.color_swap = RGA_COLOR_RB_SWAP,
-		.hw_format = RGA_COLOR_FMT_XBGR8888,
-		.depth = 32,
-		.uv_factor = 1,
-		.y_div = 1,
-		.x_div = 1,
-	},
 	{
 		.fourcc = V4L2_PIX_FMT_ABGR32,
-		.color_swap = RGA_COLOR_ALPHA_SWAP,
+		.color_swap = RGA_COLOR_RB_SWAP,
 		.hw_format = RGA_COLOR_FMT_ABGR8888,
 		.depth = 32,
 		.uv_factor = 1,
@@ -222,7 +213,7 @@ static struct rga_fmt formats[] = {
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_XBGR32,
-		.color_swap = RGA_COLOR_ALPHA_SWAP,
+		.color_swap = RGA_COLOR_RB_SWAP,
 		.hw_format = RGA_COLOR_FMT_XBGR8888,
 		.depth = 32,
 		.uv_factor = 1,
diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index 2811f612820f..0e98b450ae01 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -117,8 +117,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/*
 	 * TODO: These stk1160_dbg are very spammy!
-	 * We should 1) check why we are getting them
-	 * and 2) add ratelimit.
+	 * We should check why we are getting them.
 	 *
 	 * UPDATE: One of the reasons (the only one?) for getting these
 	 * is incorrect standard (mismatch between expected and configured).
@@ -161,7 +160,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/* Let the bug hunt begin! sanity checks! */
 	if (lencopy < 0) {
-		stk1160_dbg("copy skipped: negative lencopy\n");
+		printk_ratelimited(KERN_DEBUG "copy skipped: negative lencopy\n");
 		return;
 	}
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index dd938a5d0409..6b7526669875 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1247,6 +1247,7 @@ config MFD_DAVINCI_VOICECODEC
 
 config MFD_TI_AM335X_TSCADC
 	tristate "TI ADC / Touch Screen chip support"
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP
 	select REGMAP_MMIO
diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index e03f4883858a..5947c1305527 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -984,7 +984,8 @@ static int alb_upper_dev_walk(struct net_device *upper, void *_data)
 	if (netif_is_macvlan(upper) && !strict_match) {
 		tags = bond_verify_device_path(bond->dev, upper, 0);
 		if (IS_ERR_OR_NULL(tags))
-			BUG();
+			return -ENOMEM;
+
 		alb_send_lp_vid(slave, upper->dev_addr,
 				tags[0].vlan_proto, tags[0].vlan_id);
 		kfree(tags);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index adac5df0d6b4..26ccaf173ba7 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -823,7 +823,6 @@ int aq_nic_set_link_ksettings(struct aq_nic_s *self,
 		default:
 			err = -1;
 			goto err_exit;
-		break;
 		}
 		if (!(self->aq_nic_cfg.aq_hw_caps->link_speed_msk & rate)) {
 			err = -1;
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index f42f7a6e1559..abe01562729f 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -454,7 +454,6 @@ static int enic_grxclsrule(struct enic *enic, struct ethtool_rxnfc *cmd)
 		break;
 	default:
 		return -EINVAL;
-		break;
 	}
 
 	fsp->h_u.tcp_ip4_spec.ip4src = flow_get_u32_src(&n->keys);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e4162c2271e3..9c4c892bfc83 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1798,6 +1798,7 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 
 		/* if any of the above changed restart the FEC */
 		if (status_change) {
+			netif_stop_queue(ndev);
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(ndev);
 			fec_restart(ndev);
@@ -1807,6 +1808,7 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 		}
 	} else {
 		if (fep->link) {
+			netif_stop_queue(ndev);
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(ndev);
 			fec_stop(ndev);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 97cf144a4ff9..491e5c776306 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4966,7 +4966,7 @@ static int i40e_pf_wait_queues_disabled(struct i40e_pf *pf)
 {
 	int v, ret = 0;
 
-	for (v = 0; v < pf->hw.func_caps.num_vsis; v++) {
+	for (v = 0; v < pf->num_alloc_vsi; v++) {
 		if (pf->vsi[v]) {
 			ret = i40e_vsi_wait_queues_disabled(pf->vsi[v]);
 			if (ret)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
index eee277c1bedf..b1788ddffcb2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
@@ -123,14 +123,14 @@ static s32 ixgbe_init_phy_ops_82598(struct ixgbe_hw *hw)
 		if (ret_val)
 			return ret_val;
 		if (hw->phy.sfp_type == ixgbe_sfp_type_unknown)
-			return IXGBE_ERR_SFP_NOT_SUPPORTED;
+			return -EOPNOTSUPP;
 
 		/* Check to see if SFP+ module is supported */
 		ret_val = ixgbe_get_sfp_init_sequence_offsets(hw,
 							    &list_offset,
 							    &data_offset);
 		if (ret_val)
-			return IXGBE_ERR_SFP_NOT_SUPPORTED;
+			return -EOPNOTSUPP;
 		break;
 	default:
 		break;
@@ -213,7 +213,7 @@ static s32 ixgbe_get_link_capabilities_82598(struct ixgbe_hw *hw,
 		break;
 
 	default:
-		return IXGBE_ERR_LINK_SETUP;
+		return -EIO;
 	}
 
 	return 0;
@@ -283,7 +283,7 @@ static s32 ixgbe_fc_enable_82598(struct ixgbe_hw *hw)
 
 	/* Validate the water mark configuration */
 	if (!hw->fc.pause_time)
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 
 	/* Low water mark of zero causes XOFF floods */
 	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
@@ -292,7 +292,7 @@ static s32 ixgbe_fc_enable_82598(struct ixgbe_hw *hw)
 			if (!hw->fc.low_water[i] ||
 			    hw->fc.low_water[i] >= hw->fc.high_water[i]) {
 				hw_dbg(hw, "Invalid water mark configuration\n");
-				return IXGBE_ERR_INVALID_LINK_SETTINGS;
+				return -EINVAL;
 			}
 		}
 	}
@@ -369,7 +369,7 @@ static s32 ixgbe_fc_enable_82598(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_dbg(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	/* Set 802.3x based flow control settings. */
@@ -438,7 +438,7 @@ static s32 ixgbe_start_mac_link_82598(struct ixgbe_hw *hw,
 				msleep(100);
 			}
 			if (!(links_reg & IXGBE_LINKS_KX_AN_COMP)) {
-				status = IXGBE_ERR_AUTONEG_NOT_COMPLETE;
+				status = -EIO;
 				hw_dbg(hw, "Autonegotiation did not complete.\n");
 			}
 		}
@@ -478,7 +478,7 @@ static s32 ixgbe_validate_link_ready(struct ixgbe_hw *hw)
 
 	if (timeout == IXGBE_VALIDATE_LINK_READY_TIMEOUT) {
 		hw_dbg(hw, "Link was indicated but link is down\n");
-		return IXGBE_ERR_LINK_SETUP;
+		return -EIO;
 	}
 
 	return 0;
@@ -594,7 +594,7 @@ static s32 ixgbe_setup_mac_link_82598(struct ixgbe_hw *hw,
 	speed &= link_capabilities;
 
 	if (speed == IXGBE_LINK_SPEED_UNKNOWN)
-		return IXGBE_ERR_LINK_SETUP;
+		return -EINVAL;
 
 	/* Set KX4/KX support according to speed requested */
 	else if (link_mode == IXGBE_AUTOC_LMS_KX4_AN ||
@@ -701,9 +701,9 @@ static s32 ixgbe_reset_hw_82598(struct ixgbe_hw *hw)
 
 		/* Init PHY and function pointers, perform SFP setup */
 		phy_status = hw->phy.ops.init(hw);
-		if (phy_status == IXGBE_ERR_SFP_NOT_SUPPORTED)
+		if (phy_status == -EOPNOTSUPP)
 			return phy_status;
-		if (phy_status == IXGBE_ERR_SFP_NOT_PRESENT)
+		if (phy_status == -ENOENT)
 			goto mac_reset_top;
 
 		hw->phy.ops.reset(hw);
@@ -727,7 +727,7 @@ static s32 ixgbe_reset_hw_82598(struct ixgbe_hw *hw)
 		udelay(1);
 	}
 	if (ctrl & IXGBE_CTRL_RST) {
-		status = IXGBE_ERR_RESET_FAILED;
+		status = -EIO;
 		hw_dbg(hw, "Reset polling failed to complete.\n");
 	}
 
@@ -789,7 +789,7 @@ static s32 ixgbe_set_vmdq_82598(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 	/* Make sure we are using a valid rar index range */
 	if (rar >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", rar);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	rar_high = IXGBE_READ_REG(hw, IXGBE_RAH(rar));
@@ -814,7 +814,7 @@ static s32 ixgbe_clear_vmdq_82598(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 	/* Make sure we are using a valid rar index range */
 	if (rar >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", rar);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	rar_high = IXGBE_READ_REG(hw, IXGBE_RAH(rar));
@@ -845,7 +845,7 @@ static s32 ixgbe_set_vfta_82598(struct ixgbe_hw *hw, u32 vlan, u32 vind,
 	u32 vftabyte;
 
 	if (vlan > 4095)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* Determine 32-bit word position in array */
 	regindex = (vlan >> 5) & 0x7F;   /* upper seven bits */
@@ -964,7 +964,7 @@ static s32 ixgbe_read_i2c_phy_82598(struct ixgbe_hw *hw, u8 dev_addr,
 		gssr = IXGBE_GSSR_PHY0_SM;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, gssr) != 0)
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	if (hw->phy.type == ixgbe_phy_nl) {
 		/*
@@ -993,7 +993,7 @@ static s32 ixgbe_read_i2c_phy_82598(struct ixgbe_hw *hw, u8 dev_addr,
 
 		if (sfp_stat != IXGBE_I2C_EEPROM_STATUS_PASS) {
 			hw_dbg(hw, "EEPROM read did not pass.\n");
-			status = IXGBE_ERR_SFP_NOT_PRESENT;
+			status = -ENOENT;
 			goto out;
 		}
 
@@ -1003,7 +1003,7 @@ static s32 ixgbe_read_i2c_phy_82598(struct ixgbe_hw *hw, u8 dev_addr,
 
 		*eeprom_data = (u8)(sfp_data >> 8);
 	} else {
-		status = IXGBE_ERR_PHY;
+		status = -EIO;
 	}
 
 out:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index 1e49716f52bc..298a1f2424a8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -117,7 +117,7 @@ static s32 ixgbe_setup_sfp_modules_82599(struct ixgbe_hw *hw)
 		ret_val = hw->mac.ops.acquire_swfw_sync(hw,
 							IXGBE_GSSR_MAC_CSR_SM);
 		if (ret_val)
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		if (hw->eeprom.ops.read(hw, ++data_offset, &data_value))
 			goto setup_sfp_err;
@@ -144,7 +144,7 @@ static s32 ixgbe_setup_sfp_modules_82599(struct ixgbe_hw *hw)
 
 		if (ret_val) {
 			hw_dbg(hw, " sfp module setup not complete\n");
-			return IXGBE_ERR_SFP_SETUP_NOT_COMPLETE;
+			return -EIO;
 		}
 	}
 
@@ -159,7 +159,7 @@ static s32 ixgbe_setup_sfp_modules_82599(struct ixgbe_hw *hw)
 	usleep_range(hw->eeprom.semaphore_delay * 1000,
 		     hw->eeprom.semaphore_delay * 2000);
 	hw_err(hw, "eeprom read at offset %d failed\n", data_offset);
-	return IXGBE_ERR_SFP_SETUP_NOT_COMPLETE;
+	return -EIO;
 }
 
 /**
@@ -184,7 +184,7 @@ static s32 prot_autoc_read_82599(struct ixgbe_hw *hw, bool *locked,
 		ret_val = hw->mac.ops.acquire_swfw_sync(hw,
 					IXGBE_GSSR_MAC_CSR_SM);
 		if (ret_val)
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		*locked = true;
 	}
@@ -219,7 +219,7 @@ static s32 prot_autoc_write_82599(struct ixgbe_hw *hw, u32 autoc, bool locked)
 		ret_val = hw->mac.ops.acquire_swfw_sync(hw,
 					IXGBE_GSSR_MAC_CSR_SM);
 		if (ret_val)
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		locked = true;
 	}
@@ -400,7 +400,7 @@ static s32 ixgbe_get_link_capabilities_82599(struct ixgbe_hw *hw,
 		break;
 
 	default:
-		return IXGBE_ERR_LINK_SETUP;
+		return -EIO;
 	}
 
 	if (hw->phy.multispeed_fiber) {
@@ -541,7 +541,7 @@ static s32 ixgbe_start_mac_link_82599(struct ixgbe_hw *hw,
 				msleep(100);
 			}
 			if (!(links_reg & IXGBE_LINKS_KX_AN_COMP)) {
-				status = IXGBE_ERR_AUTONEG_NOT_COMPLETE;
+				status = -EIO;
 				hw_dbg(hw, "Autoneg did not complete.\n");
 			}
 		}
@@ -794,7 +794,7 @@ static s32 ixgbe_setup_mac_link_82599(struct ixgbe_hw *hw,
 	speed &= link_capabilities;
 
 	if (speed == IXGBE_LINK_SPEED_UNKNOWN)
-		return IXGBE_ERR_LINK_SETUP;
+		return -EINVAL;
 
 	/* Use stored value (EEPROM defaults) of AUTOC to find KR/KX4 support*/
 	if (hw->mac.orig_link_settings_stored)
@@ -861,8 +861,7 @@ static s32 ixgbe_setup_mac_link_82599(struct ixgbe_hw *hw,
 					msleep(100);
 				}
 				if (!(links_reg & IXGBE_LINKS_KX_AN_COMP)) {
-					status =
-						IXGBE_ERR_AUTONEG_NOT_COMPLETE;
+					status = -EIO;
 					hw_dbg(hw, "Autoneg did not complete.\n");
 				}
 			}
@@ -927,7 +926,7 @@ static s32 ixgbe_reset_hw_82599(struct ixgbe_hw *hw)
 	/* Identify PHY and related function pointers */
 	status = hw->phy.ops.init(hw);
 
-	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (status == -EOPNOTSUPP)
 		return status;
 
 	/* Setup SFP module if there is one present. */
@@ -936,7 +935,7 @@ static s32 ixgbe_reset_hw_82599(struct ixgbe_hw *hw)
 		hw->phy.sfp_setup_needed = false;
 	}
 
-	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (status == -EOPNOTSUPP)
 		return status;
 
 	/* Reset PHY */
@@ -974,7 +973,7 @@ static s32 ixgbe_reset_hw_82599(struct ixgbe_hw *hw)
 	}
 
 	if (ctrl & IXGBE_CTRL_RST_MASK) {
-		status = IXGBE_ERR_RESET_FAILED;
+		status = -EIO;
 		hw_dbg(hw, "Reset polling failed to complete.\n");
 	}
 
@@ -1093,7 +1092,7 @@ static s32 ixgbe_fdir_check_cmd_complete(struct ixgbe_hw *hw, u32 *fdircmd)
 		udelay(10);
 	}
 
-	return IXGBE_ERR_FDIR_CMD_INCOMPLETE;
+	return -EIO;
 }
 
 /**
@@ -1155,7 +1154,7 @@ s32 ixgbe_reinit_fdir_tables_82599(struct ixgbe_hw *hw)
 	}
 	if (i >= IXGBE_FDIR_INIT_DONE_POLL) {
 		hw_dbg(hw, "Flow Director Signature poll time exceeded!\n");
-		return IXGBE_ERR_FDIR_REINIT_FAILED;
+		return -EIO;
 	}
 
 	/* Clear FDIR statistics registers (read to clear) */
@@ -1387,7 +1386,7 @@ s32 ixgbe_fdir_add_signature_filter_82599(struct ixgbe_hw *hw,
 		break;
 	default:
 		hw_dbg(hw, " Error on flow type input\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	/* configure FDIRCMD register */
@@ -1546,7 +1545,7 @@ s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		break;
 	default:
 		hw_dbg(hw, " Error on vm pool mask\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	switch (input_mask->formatted.flow_type & IXGBE_ATR_L4TYPE_MASK) {
@@ -1555,13 +1554,13 @@ s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		if (input_mask->formatted.dst_port ||
 		    input_mask->formatted.src_port) {
 			hw_dbg(hw, " Error on src/dst port mask\n");
-			return IXGBE_ERR_CONFIG;
+			return -EIO;
 		}
 	case IXGBE_ATR_L4TYPE_MASK:
 		break;
 	default:
 		hw_dbg(hw, " Error on flow type mask\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	switch (ntohs(input_mask->formatted.vlan_id) & 0xEFFF) {
@@ -1582,7 +1581,7 @@ s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		break;
 	default:
 		hw_dbg(hw, " Error on VLAN mask\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	switch ((__force u16)input_mask->formatted.flex_bytes & 0xFFFF) {
@@ -1594,7 +1593,7 @@ s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		break;
 	default:
 		hw_dbg(hw, " Error on flexible byte mask\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	/* Now mask VM pool and destination IPv6 - bits 5 and 2 */
@@ -1823,7 +1822,7 @@ static s32 ixgbe_identify_phy_82599(struct ixgbe_hw *hw)
 
 	/* Return error if SFP module has been detected but is not supported */
 	if (hw->phy.type == ixgbe_phy_sfp_unsupported)
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 
 	return status;
 }
@@ -1862,13 +1861,13 @@ static s32 ixgbe_enable_rx_dma_82599(struct ixgbe_hw *hw, u32 regval)
  *  Verifies that installed the firmware version is 0.6 or higher
  *  for SFI devices. All 82599 SFI devices should have version 0.6 or higher.
  *
- *  Returns IXGBE_ERR_EEPROM_VERSION if the FW is not present or
- *  if the FW version is not supported.
+ *  Return: -EACCES if the FW is not present or if the FW version is
+ *  not supported.
  **/
 static s32 ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
 {
-	s32 status = IXGBE_ERR_EEPROM_VERSION;
 	u16 fw_offset, fw_ptp_cfg_offset;
+	s32 status = -EACCES;
 	u16 offset;
 	u16 fw_version = 0;
 
@@ -1882,7 +1881,7 @@ static s32 ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
 		goto fw_version_err;
 
 	if (fw_offset == 0 || fw_offset == 0xFFFF)
-		return IXGBE_ERR_EEPROM_VERSION;
+		return -EACCES;
 
 	/* get the offset to the Pass Through Patch Configuration block */
 	offset = fw_offset + IXGBE_FW_PASSTHROUGH_PATCH_CONFIG_PTR;
@@ -1890,7 +1889,7 @@ static s32 ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
 		goto fw_version_err;
 
 	if (fw_ptp_cfg_offset == 0 || fw_ptp_cfg_offset == 0xFFFF)
-		return IXGBE_ERR_EEPROM_VERSION;
+		return -EACCES;
 
 	/* get the firmware version */
 	offset = fw_ptp_cfg_offset + IXGBE_FW_PATCH_VERSION_4;
@@ -1904,7 +1903,7 @@ static s32 ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
 
 fw_version_err:
 	hw_err(hw, "eeprom read at offset %d failed\n", offset);
-	return IXGBE_ERR_EEPROM_VERSION;
+	return -EACCES;
 }
 
 /**
@@ -2037,7 +2036,7 @@ static s32 ixgbe_reset_pipeline_82599(struct ixgbe_hw *hw)
 
 	if (!(anlp1_reg & IXGBE_ANLP1_AN_STATE_MASK)) {
 		hw_dbg(hw, "auto negotiation not completed\n");
-		ret_val = IXGBE_ERR_RESET_FAILED;
+		ret_val = -EIO;
 		goto reset_pipeline_out;
 	}
 
@@ -2086,7 +2085,7 @@ static s32 ixgbe_read_i2c_byte_82599(struct ixgbe_hw *hw, u8 byte_offset,
 
 		if (!timeout) {
 			hw_dbg(hw, "Driver can't access resource, acquiring I2C bus timeout.\n");
-			status = IXGBE_ERR_I2C;
+			status = -EIO;
 			goto release_i2c_access;
 		}
 	}
@@ -2140,7 +2139,7 @@ static s32 ixgbe_write_i2c_byte_82599(struct ixgbe_hw *hw, u8 byte_offset,
 
 		if (!timeout) {
 			hw_dbg(hw, "Driver can't access resource, acquiring I2C bus timeout.\n");
-			status = IXGBE_ERR_I2C;
+			status = -EIO;
 			goto release_i2c_access;
 		}
 	}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 39c5e6fdb72c..40c5baa191c9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -30,7 +30,7 @@ static s32 ixgbe_write_eeprom_buffer_bit_bang(struct ixgbe_hw *hw, u16 offset,
 					     u16 words, u16 *data);
 static s32 ixgbe_detect_eeprom_page_size_generic(struct ixgbe_hw *hw,
 						 u16 offset);
-static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw);
+static s32 ixgbe_disable_pcie_primary(struct ixgbe_hw *hw);
 
 /* Base table for registers values that change by MAC */
 const u32 ixgbe_mvals_8259X[IXGBE_MVALS_IDX_LIMIT] = {
@@ -124,7 +124,7 @@ s32 ixgbe_setup_fc_generic(struct ixgbe_hw *hw)
 	 */
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == ixgbe_fc_rx_pause) {
 		hw_dbg(hw, "ixgbe_fc_rx_pause not valid in strict IEEE mode\n");
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	/*
@@ -215,7 +215,7 @@ s32 ixgbe_setup_fc_generic(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_dbg(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	if (hw->mac.type != ixgbe_mac_X540) {
@@ -500,7 +500,7 @@ s32 ixgbe_read_pba_string_generic(struct ixgbe_hw *hw, u8 *pba_num,
 
 	if (pba_num == NULL) {
 		hw_dbg(hw, "PBA string buffer was null\n");
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	ret_val = hw->eeprom.ops.read(hw, IXGBE_PBANUM0_PTR, &data);
@@ -526,7 +526,7 @@ s32 ixgbe_read_pba_string_generic(struct ixgbe_hw *hw, u8 *pba_num,
 		/* we will need 11 characters to store the PBA */
 		if (pba_num_size < 11) {
 			hw_dbg(hw, "PBA string buffer too small\n");
-			return IXGBE_ERR_NO_SPACE;
+			return -ENOSPC;
 		}
 
 		/* extract hex string from data and pba_ptr */
@@ -563,13 +563,13 @@ s32 ixgbe_read_pba_string_generic(struct ixgbe_hw *hw, u8 *pba_num,
 
 	if (length == 0xFFFF || length == 0) {
 		hw_dbg(hw, "NVM PBA number section invalid length\n");
-		return IXGBE_ERR_PBA_SECTION;
+		return -EIO;
 	}
 
 	/* check if pba_num buffer is big enough */
 	if (pba_num_size  < (((u32)length * 2) - 1)) {
 		hw_dbg(hw, "PBA string buffer too small\n");
-		return IXGBE_ERR_NO_SPACE;
+		return -ENOSPC;
 	}
 
 	/* trim pba length from start of string */
@@ -746,10 +746,10 @@ s32 ixgbe_stop_adapter_generic(struct ixgbe_hw *hw)
 	usleep_range(1000, 2000);
 
 	/*
-	 * Prevent the PCI-E bus from from hanging by disabling PCI-E master
+	 * Prevent the PCI-E bus from hanging by disabling PCI-E primary
 	 * access and verify no pending requests
 	 */
-	return ixgbe_disable_pcie_master(hw);
+	return ixgbe_disable_pcie_primary(hw);
 }
 
 /**
@@ -805,7 +805,7 @@ s32 ixgbe_led_on_generic(struct ixgbe_hw *hw, u32 index)
 	u32 led_reg = IXGBE_READ_REG(hw, IXGBE_LEDCTL);
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* To turn on the LED, set mode to ON. */
 	led_reg &= ~IXGBE_LED_MODE_MASK(index);
@@ -826,7 +826,7 @@ s32 ixgbe_led_off_generic(struct ixgbe_hw *hw, u32 index)
 	u32 led_reg = IXGBE_READ_REG(hw, IXGBE_LEDCTL);
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* To turn off the LED, set mode to OFF. */
 	led_reg &= ~IXGBE_LED_MODE_MASK(index);
@@ -904,11 +904,8 @@ s32 ixgbe_write_eeprom_buffer_bit_bang_generic(struct ixgbe_hw *hw, u16 offset,
 
 	hw->eeprom.ops.init_params(hw);
 
-	if (words == 0)
-		return IXGBE_ERR_INVALID_ARGUMENT;
-
-	if (offset + words > hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+	if (words == 0 || (offset + words > hw->eeprom.word_size))
+		return -EINVAL;
 
 	/*
 	 * The EEPROM page size cannot be queried from the chip. We do lazy
@@ -962,7 +959,7 @@ static s32 ixgbe_write_eeprom_buffer_bit_bang(struct ixgbe_hw *hw, u16 offset,
 
 	if (ixgbe_ready_eeprom(hw) != 0) {
 		ixgbe_release_eeprom(hw);
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	for (i = 0; i < words; i++) {
@@ -1028,7 +1025,7 @@ s32 ixgbe_write_eeprom_generic(struct ixgbe_hw *hw, u16 offset, u16 data)
 	hw->eeprom.ops.init_params(hw);
 
 	if (offset >= hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+		return -EINVAL;
 
 	return ixgbe_write_eeprom_buffer_bit_bang(hw, offset, 1, &data);
 }
@@ -1050,11 +1047,8 @@ s32 ixgbe_read_eeprom_buffer_bit_bang_generic(struct ixgbe_hw *hw, u16 offset,
 
 	hw->eeprom.ops.init_params(hw);
 
-	if (words == 0)
-		return IXGBE_ERR_INVALID_ARGUMENT;
-
-	if (offset + words > hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+	if (words == 0 || (offset + words > hw->eeprom.word_size))
+		return -EINVAL;
 
 	/*
 	 * We cannot hold synchronization semaphores for too long
@@ -1099,7 +1093,7 @@ static s32 ixgbe_read_eeprom_buffer_bit_bang(struct ixgbe_hw *hw, u16 offset,
 
 	if (ixgbe_ready_eeprom(hw) != 0) {
 		ixgbe_release_eeprom(hw);
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	for (i = 0; i < words; i++) {
@@ -1142,7 +1136,7 @@ s32 ixgbe_read_eeprom_bit_bang_generic(struct ixgbe_hw *hw, u16 offset,
 	hw->eeprom.ops.init_params(hw);
 
 	if (offset >= hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+		return -EINVAL;
 
 	return ixgbe_read_eeprom_buffer_bit_bang(hw, offset, 1, data);
 }
@@ -1165,11 +1159,8 @@ s32 ixgbe_read_eerd_buffer_generic(struct ixgbe_hw *hw, u16 offset,
 
 	hw->eeprom.ops.init_params(hw);
 
-	if (words == 0)
-		return IXGBE_ERR_INVALID_ARGUMENT;
-
-	if (offset >= hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+	if (words == 0 || offset >= hw->eeprom.word_size)
+		return -EINVAL;
 
 	for (i = 0; i < words; i++) {
 		eerd = ((offset + i) << IXGBE_EEPROM_RW_ADDR_SHIFT) |
@@ -1262,11 +1253,8 @@ s32 ixgbe_write_eewr_buffer_generic(struct ixgbe_hw *hw, u16 offset,
 
 	hw->eeprom.ops.init_params(hw);
 
-	if (words == 0)
-		return IXGBE_ERR_INVALID_ARGUMENT;
-
-	if (offset >= hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+	if (words == 0 || offset >= hw->eeprom.word_size)
+		return -EINVAL;
 
 	for (i = 0; i < words; i++) {
 		eewr = ((offset + i) << IXGBE_EEPROM_RW_ADDR_SHIFT) |
@@ -1328,7 +1316,7 @@ static s32 ixgbe_poll_eerd_eewr_done(struct ixgbe_hw *hw, u32 ee_reg)
 		}
 		udelay(5);
 	}
-	return IXGBE_ERR_EEPROM;
+	return -EIO;
 }
 
 /**
@@ -1344,7 +1332,7 @@ static s32 ixgbe_acquire_eeprom(struct ixgbe_hw *hw)
 	u32 i;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM) != 0)
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	eec = IXGBE_READ_REG(hw, IXGBE_EEC(hw));
 
@@ -1366,7 +1354,7 @@ static s32 ixgbe_acquire_eeprom(struct ixgbe_hw *hw)
 		hw_dbg(hw, "Could not acquire EEPROM grant\n");
 
 		hw->mac.ops.release_swfw_sync(hw, IXGBE_GSSR_EEP_SM);
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	/* Setup EEPROM for Read/Write */
@@ -1419,7 +1407,7 @@ static s32 ixgbe_get_eeprom_semaphore(struct ixgbe_hw *hw)
 		swsm = IXGBE_READ_REG(hw, IXGBE_SWSM(hw));
 		if (swsm & IXGBE_SWSM_SMBI) {
 			hw_dbg(hw, "Software semaphore SMBI between device drivers not granted.\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 	}
 
@@ -1447,7 +1435,7 @@ static s32 ixgbe_get_eeprom_semaphore(struct ixgbe_hw *hw)
 	if (i >= timeout) {
 		hw_dbg(hw, "SWESMBI Software EEPROM semaphore not granted.\n");
 		ixgbe_release_eeprom_semaphore(hw);
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	return 0;
@@ -1503,7 +1491,7 @@ static s32 ixgbe_ready_eeprom(struct ixgbe_hw *hw)
 	 */
 	if (i >= IXGBE_EEPROM_MAX_RETRY_SPI) {
 		hw_dbg(hw, "SPI EEPROM Status error\n");
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	return 0;
@@ -1715,7 +1703,7 @@ s32 ixgbe_calc_eeprom_checksum_generic(struct ixgbe_hw *hw)
 	for (i = IXGBE_PCIE_ANALOG_PTR; i < IXGBE_FW_PTR; i++) {
 		if (hw->eeprom.ops.read(hw, i, &pointer)) {
 			hw_dbg(hw, "EEPROM read failed\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 
 		/* If the pointer seems invalid */
@@ -1724,7 +1712,7 @@ s32 ixgbe_calc_eeprom_checksum_generic(struct ixgbe_hw *hw)
 
 		if (hw->eeprom.ops.read(hw, pointer, &length)) {
 			hw_dbg(hw, "EEPROM read failed\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 
 		if (length == 0xFFFF || length == 0)
@@ -1733,7 +1721,7 @@ s32 ixgbe_calc_eeprom_checksum_generic(struct ixgbe_hw *hw)
 		for (j = pointer + 1; j <= pointer + length; j++) {
 			if (hw->eeprom.ops.read(hw, j, &word)) {
 				hw_dbg(hw, "EEPROM read failed\n");
-				return IXGBE_ERR_EEPROM;
+				return -EIO;
 			}
 			checksum += word;
 		}
@@ -1786,7 +1774,7 @@ s32 ixgbe_validate_eeprom_checksum_generic(struct ixgbe_hw *hw,
 	 * calculated checksum
 	 */
 	if (read_checksum != checksum)
-		status = IXGBE_ERR_EEPROM_CHECKSUM;
+		status = -EIO;
 
 	/* If the user cares, return the calculated checksum */
 	if (checksum_val)
@@ -1845,7 +1833,7 @@ s32 ixgbe_set_rar_generic(struct ixgbe_hw *hw, u32 index, u8 *addr, u32 vmdq,
 	/* Make sure we are using a valid rar index range */
 	if (index >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", index);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	/* setup VMDq pool selection before this RAR gets enabled */
@@ -1897,7 +1885,7 @@ s32 ixgbe_clear_rar_generic(struct ixgbe_hw *hw, u32 index)
 	/* Make sure we are using a valid rar index range */
 	if (index >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", index);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	/*
@@ -2146,7 +2134,7 @@ s32 ixgbe_fc_enable_generic(struct ixgbe_hw *hw)
 
 	/* Validate the water mark configuration. */
 	if (!hw->fc.pause_time)
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 
 	/* Low water mark of zero causes XOFF floods */
 	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
@@ -2155,7 +2143,7 @@ s32 ixgbe_fc_enable_generic(struct ixgbe_hw *hw)
 			if (!hw->fc.low_water[i] ||
 			    hw->fc.low_water[i] >= hw->fc.high_water[i]) {
 				hw_dbg(hw, "Invalid water mark configuration\n");
-				return IXGBE_ERR_INVALID_LINK_SETTINGS;
+				return -EINVAL;
 			}
 		}
 	}
@@ -2212,7 +2200,7 @@ s32 ixgbe_fc_enable_generic(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_dbg(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	/* Set 802.3x based flow control settings. */
@@ -2269,7 +2257,7 @@ s32 ixgbe_negotiate_fc(struct ixgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 		       u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm)
 {
 	if ((!(adv_reg)) ||  (!(lp_reg)))
-		return IXGBE_ERR_FC_NOT_NEGOTIATED;
+		return -EINVAL;
 
 	if ((adv_reg & adv_sym) && (lp_reg & lp_sym)) {
 		/*
@@ -2321,7 +2309,7 @@ static s32 ixgbe_fc_autoneg_fiber(struct ixgbe_hw *hw)
 	linkstat = IXGBE_READ_REG(hw, IXGBE_PCS1GLSTA);
 	if ((!!(linkstat & IXGBE_PCS1GLSTA_AN_COMPLETE) == 0) ||
 	    (!!(linkstat & IXGBE_PCS1GLSTA_AN_TIMED_OUT) == 1))
-		return IXGBE_ERR_FC_NOT_NEGOTIATED;
+		return -EIO;
 
 	pcs_anadv_reg = IXGBE_READ_REG(hw, IXGBE_PCS1GANA);
 	pcs_lpab_reg = IXGBE_READ_REG(hw, IXGBE_PCS1GANLP);
@@ -2353,12 +2341,12 @@ static s32 ixgbe_fc_autoneg_backplane(struct ixgbe_hw *hw)
 	 */
 	links = IXGBE_READ_REG(hw, IXGBE_LINKS);
 	if ((links & IXGBE_LINKS_KX_AN_COMP) == 0)
-		return IXGBE_ERR_FC_NOT_NEGOTIATED;
+		return -EIO;
 
 	if (hw->mac.type == ixgbe_mac_82599EB) {
 		links2 = IXGBE_READ_REG(hw, IXGBE_LINKS2);
 		if ((links2 & IXGBE_LINKS2_AN_SUPPORTED) == 0)
-			return IXGBE_ERR_FC_NOT_NEGOTIATED;
+			return -EIO;
 	}
 	/*
 	 * Read the 10g AN autoc and LP ability registers and resolve
@@ -2407,8 +2395,8 @@ static s32 ixgbe_fc_autoneg_copper(struct ixgbe_hw *hw)
  **/
 void ixgbe_fc_autoneg(struct ixgbe_hw *hw)
 {
-	s32 ret_val = IXGBE_ERR_FC_NOT_NEGOTIATED;
 	ixgbe_link_speed speed;
+	s32 ret_val = -EIO;
 	bool link_up;
 
 	/*
@@ -2506,15 +2494,15 @@ static u32 ixgbe_pcie_timeout_poll(struct ixgbe_hw *hw)
 }
 
 /**
- *  ixgbe_disable_pcie_master - Disable PCI-express master access
+ *  ixgbe_disable_pcie_primary - Disable PCI-express primary access
  *  @hw: pointer to hardware structure
  *
- *  Disables PCI-Express master access and verifies there are no pending
- *  requests. IXGBE_ERR_MASTER_REQUESTS_PENDING is returned if master disable
- *  bit hasn't caused the master requests to be disabled, else 0
- *  is returned signifying master requests disabled.
+ *  Disables PCI-Express primary access and verifies there are no pending
+ *  requests. -EALREADY is returned if primary disable
+ *  bit hasn't caused the primary requests to be disabled, else 0
+ *  is returned signifying primary requests disabled.
  **/
-static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
+static s32 ixgbe_disable_pcie_primary(struct ixgbe_hw *hw)
 {
 	u32 i, poll;
 	u16 value;
@@ -2523,23 +2511,23 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 	IXGBE_WRITE_REG(hw, IXGBE_CTRL, IXGBE_CTRL_GIO_DIS);
 
 	/* Poll for bit to read as set */
-	for (i = 0; i < IXGBE_PCI_MASTER_DISABLE_TIMEOUT; i++) {
+	for (i = 0; i < IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT; i++) {
 		if (IXGBE_READ_REG(hw, IXGBE_CTRL) & IXGBE_CTRL_GIO_DIS)
 			break;
 		usleep_range(100, 120);
 	}
-	if (i >= IXGBE_PCI_MASTER_DISABLE_TIMEOUT) {
+	if (i >= IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT) {
 		hw_dbg(hw, "GIO disable did not set - requesting resets\n");
 		goto gio_disable_fail;
 	}
 
-	/* Exit if master requests are blocked */
+	/* Exit if primary requests are blocked */
 	if (!(IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_GIO) ||
 	    ixgbe_removed(hw->hw_addr))
 		return 0;
 
-	/* Poll for master request bit to clear */
-	for (i = 0; i < IXGBE_PCI_MASTER_DISABLE_TIMEOUT; i++) {
+	/* Poll for primary request bit to clear */
+	for (i = 0; i < IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT; i++) {
 		udelay(100);
 		if (!(IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_GIO))
 			return 0;
@@ -2547,13 +2535,13 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 
 	/*
 	 * Two consecutive resets are required via CTRL.RST per datasheet
-	 * 5.2.5.3.2 Master Disable.  We set a flag to inform the reset routine
-	 * of this need.  The first reset prevents new master requests from
+	 * 5.2.5.3.2 Primary Disable.  We set a flag to inform the reset routine
+	 * of this need.  The first reset prevents new primary requests from
 	 * being issued by our device.  We then must wait 1usec or more for any
 	 * remaining completions from the PCIe bus to trickle in, and then reset
 	 * again to clear out any effects they may have had on our device.
 	 */
-	hw_dbg(hw, "GIO Master Disable bit didn't clear - requesting resets\n");
+	hw_dbg(hw, "GIO Primary Disable bit didn't clear - requesting resets\n");
 gio_disable_fail:
 	hw->mac.flags |= IXGBE_FLAGS_DOUBLE_RESET_REQUIRED;
 
@@ -2575,7 +2563,7 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 	}
 
 	hw_dbg(hw, "PCIe transaction pending bit also did not clear.\n");
-	return IXGBE_ERR_MASTER_REQUESTS_PENDING;
+	return -EALREADY;
 }
 
 /**
@@ -2600,7 +2588,7 @@ s32 ixgbe_acquire_swfw_sync(struct ixgbe_hw *hw, u32 mask)
 		 * SW_FW_SYNC bits (not just NVM)
 		 */
 		if (ixgbe_get_eeprom_semaphore(hw))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		gssr = IXGBE_READ_REG(hw, IXGBE_GSSR);
 		if (!(gssr & (fwmask | swmask))) {
@@ -2620,7 +2608,7 @@ s32 ixgbe_acquire_swfw_sync(struct ixgbe_hw *hw, u32 mask)
 		ixgbe_release_swfw_sync(hw, gssr & (fwmask | swmask));
 
 	usleep_range(5000, 10000);
-	return IXGBE_ERR_SWFW_SYNC;
+	return -EBUSY;
 }
 
 /**
@@ -2757,7 +2745,7 @@ s32 ixgbe_blink_led_start_generic(struct ixgbe_hw *hw, u32 index)
 	s32 ret_val;
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/*
 	 * Link must be up to auto-blink the LEDs;
@@ -2803,7 +2791,7 @@ s32 ixgbe_blink_led_stop_generic(struct ixgbe_hw *hw, u32 index)
 	s32 ret_val;
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	ret_val = hw->mac.ops.prot_autoc_read(hw, &locked, &autoc_reg);
 	if (ret_val)
@@ -2963,7 +2951,7 @@ s32 ixgbe_clear_vmdq_generic(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 	/* Make sure we are using a valid rar index range */
 	if (rar >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", rar);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	mpsar_lo = IXGBE_READ_REG(hw, IXGBE_MPSAR_LO(rar));
@@ -3014,7 +3002,7 @@ s32 ixgbe_set_vmdq_generic(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 	/* Make sure we are using a valid rar index range */
 	if (rar >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", rar);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	if (vmdq < 32) {
@@ -3091,7 +3079,7 @@ static s32 ixgbe_find_vlvf_slot(struct ixgbe_hw *hw, u32 vlan, bool vlvf_bypass)
 	 * will simply bypass the VLVF if there are no entries present in the
 	 * VLVF that contain our VLAN
 	 */
-	first_empty_slot = vlvf_bypass ? IXGBE_ERR_NO_SPACE : 0;
+	first_empty_slot = vlvf_bypass ? -ENOSPC : 0;
 
 	/* add VLAN enable bit for comparison */
 	vlan |= IXGBE_VLVF_VIEN;
@@ -3115,7 +3103,7 @@ static s32 ixgbe_find_vlvf_slot(struct ixgbe_hw *hw, u32 vlan, bool vlvf_bypass)
 	if (!first_empty_slot)
 		hw_dbg(hw, "No space in VLVF.\n");
 
-	return first_empty_slot ? : IXGBE_ERR_NO_SPACE;
+	return first_empty_slot ? : -ENOSPC;
 }
 
 /**
@@ -3135,7 +3123,7 @@ s32 ixgbe_set_vfta_generic(struct ixgbe_hw *hw, u32 vlan, u32 vind,
 	s32 vlvf_index;
 
 	if ((vlan > 4095) || (vind > 63))
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/*
 	 * this is a 2 part operation - first the VFTA, then the
@@ -3596,7 +3584,8 @@ u8 ixgbe_calculate_checksum(u8 *buffer, u32 length)
  *
  *  Communicates with the manageability block. On success return 0
  *  else returns semaphore error when encountering an error acquiring
- *  semaphore or IXGBE_ERR_HOST_INTERFACE_COMMAND when command fails.
+ *  semaphore, -EINVAL when incorrect parameters passed or -EIO when
+ *  command fails.
  *
  *  This function assumes that the IXGBE_GSSR_SW_MNG_SM semaphore is held
  *  by the caller.
@@ -3609,7 +3598,7 @@ s32 ixgbe_hic_unlocked(struct ixgbe_hw *hw, u32 *buffer, u32 length,
 
 	if (!length || length > IXGBE_HI_MAX_BLOCK_BYTE_LENGTH) {
 		hw_dbg(hw, "Buffer length failure buffersize-%d.\n", length);
-		return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		return -EINVAL;
 	}
 
 	/* Set bit 9 of FWSTS clearing FW reset indication */
@@ -3620,13 +3609,13 @@ s32 ixgbe_hic_unlocked(struct ixgbe_hw *hw, u32 *buffer, u32 length,
 	hicr = IXGBE_READ_REG(hw, IXGBE_HICR);
 	if (!(hicr & IXGBE_HICR_EN)) {
 		hw_dbg(hw, "IXGBE_HOST_EN bit disabled.\n");
-		return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		return -EIO;
 	}
 
 	/* Calculate length in DWORDs. We must be DWORD aligned */
 	if (length % sizeof(u32)) {
 		hw_dbg(hw, "Buffer length failure, not aligned to dword");
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	dword_len = length >> 2;
@@ -3651,7 +3640,7 @@ s32 ixgbe_hic_unlocked(struct ixgbe_hw *hw, u32 *buffer, u32 length,
 	/* Check command successful completion. */
 	if ((timeout && i == timeout) ||
 	    !(IXGBE_READ_REG(hw, IXGBE_HICR) & IXGBE_HICR_SV))
-		return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		return -EIO;
 
 	return 0;
 }
@@ -3671,7 +3660,7 @@ s32 ixgbe_hic_unlocked(struct ixgbe_hw *hw, u32 *buffer, u32 length,
  *  in these cases.
  *
  *  Communicates with the manageability block.  On success return 0
- *  else return IXGBE_ERR_HOST_INTERFACE_COMMAND.
+ *  else return -EIO or -EINVAL.
  **/
 s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
 				 u32 length, u32 timeout,
@@ -3688,7 +3677,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
 
 	if (!length || length > IXGBE_HI_MAX_BLOCK_BYTE_LENGTH) {
 		hw_dbg(hw, "Buffer length failure buffersize-%d.\n", length);
-		return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		return -EINVAL;
 	}
 	/* Take management host interface semaphore */
 	status = hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_SW_MNG_SM);
@@ -3718,7 +3707,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
 
 	if (length < round_up(buf_len, 4) + hdr_size) {
 		hw_dbg(hw, "Buffer not large enough for reply message.\n");
-		status = IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		status = -EIO;
 		goto rel_out;
 	}
 
@@ -3749,8 +3738,8 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
  *
  *  Sends driver version number to firmware through the manageability
  *  block.  On success return 0
- *  else returns IXGBE_ERR_SWFW_SYNC when encountering an error acquiring
- *  semaphore or IXGBE_ERR_HOST_INTERFACE_COMMAND when command fails.
+ *  else returns -EBUSY when encountering an error acquiring
+ *  semaphore or -EIO when command fails.
  **/
 s32 ixgbe_set_fw_drv_ver_generic(struct ixgbe_hw *hw, u8 maj, u8 min,
 				 u8 build, u8 sub, __always_unused u16 len,
@@ -3786,7 +3775,7 @@ s32 ixgbe_set_fw_drv_ver_generic(struct ixgbe_hw *hw, u8 maj, u8 min,
 		    FW_CEM_RESP_STATUS_SUCCESS)
 			ret_val = 0;
 		else
-			ret_val = IXGBE_ERR_HOST_INTERFACE_COMMAND;
+			ret_val = -EIO;
 
 		break;
 	}
@@ -3884,14 +3873,14 @@ static s32 ixgbe_get_ets_data(struct ixgbe_hw *hw, u16 *ets_cfg,
 		return status;
 
 	if ((*ets_offset == 0x0000) || (*ets_offset == 0xFFFF))
-		return IXGBE_NOT_IMPLEMENTED;
+		return -EOPNOTSUPP;
 
 	status = hw->eeprom.ops.read(hw, *ets_offset, ets_cfg);
 	if (status)
 		return status;
 
 	if ((*ets_cfg & IXGBE_ETS_TYPE_MASK) != IXGBE_ETS_TYPE_EMC_SHIFTED)
-		return IXGBE_NOT_IMPLEMENTED;
+		return -EOPNOTSUPP;
 
 	return 0;
 }
@@ -3914,7 +3903,7 @@ s32 ixgbe_get_thermal_sensor_data_generic(struct ixgbe_hw *hw)
 
 	/* Only support thermal sensors attached to physical port 0 */
 	if ((IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_LAN_ID_1))
-		return IXGBE_NOT_IMPLEMENTED;
+		return -EOPNOTSUPP;
 
 	status = ixgbe_get_ets_data(hw, &ets_cfg, &ets_offset);
 	if (status)
@@ -3974,7 +3963,7 @@ s32 ixgbe_init_thermal_sensor_thresh_generic(struct ixgbe_hw *hw)
 
 	/* Only support thermal sensors attached to physical port 0 */
 	if ((IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_LAN_ID_1))
-		return IXGBE_NOT_IMPLEMENTED;
+		return -EOPNOTSUPP;
 
 	status = ixgbe_get_ets_data(hw, &ets_cfg, &ets_offset);
 	if (status)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 3d361557a63a..343f076da6a6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3244,7 +3244,7 @@ static int ixgbe_get_module_eeprom(struct net_device *dev,
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 	struct ixgbe_hw *hw = &adapter->hw;
-	s32 status = IXGBE_ERR_PHY_ADDR_INVALID;
+	s32 status = -EFAULT;
 	u8 databyte = 0xFF;
 	int i = 0;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ef92438e4e6d..999ce27ccea6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2759,7 +2759,6 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 eicr = adapter->interrupt_event;
-	s32 rc;
 
 	if (test_bit(__IXGBE_DOWN, &adapter->state))
 		return;
@@ -2793,14 +2792,13 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
 		}
 
 		/* Check if this is not due to overtemp */
-		if (hw->phy.ops.check_overtemp(hw) != IXGBE_ERR_OVERTEMP)
+		if (!hw->phy.ops.check_overtemp(hw))
 			return;
 
 		break;
 	case IXGBE_DEV_ID_X550EM_A_1G_T:
 	case IXGBE_DEV_ID_X550EM_A_1G_T_L:
-		rc = hw->phy.ops.check_overtemp(hw);
-		if (rc != IXGBE_ERR_OVERTEMP)
+		if (!hw->phy.ops.check_overtemp(hw))
 			return;
 		break;
 	default:
@@ -5463,7 +5461,7 @@ static int ixgbe_non_sfp_link_config(struct ixgbe_hw *hw)
 {
 	u32 speed;
 	bool autoneg, link_up = false;
-	int ret = IXGBE_ERR_LINK_SETUP;
+	int ret = -EIO;
 
 	if (hw->mac.ops.check_link)
 		ret = hw->mac.ops.check_link(hw, &speed, &link_up, false);
@@ -5882,13 +5880,13 @@ void ixgbe_reset(struct ixgbe_adapter *adapter)
 	err = hw->mac.ops.init_hw(hw);
 	switch (err) {
 	case 0:
-	case IXGBE_ERR_SFP_NOT_PRESENT:
-	case IXGBE_ERR_SFP_NOT_SUPPORTED:
+	case -ENOENT:
+	case -EOPNOTSUPP:
 		break;
-	case IXGBE_ERR_MASTER_REQUESTS_PENDING:
-		e_dev_err("master disable timed out\n");
+	case -EALREADY:
+		e_dev_err("primary disable timed out\n");
 		break;
-	case IXGBE_ERR_EEPROM_VERSION:
+	case -EACCES:
 		/* We are running on a pre-production device, log a warning */
 		e_dev_warn("This device is a pre-production adapter/LOM. "
 			   "Please be aware there may be issues associated with "
@@ -7685,10 +7683,10 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 	adapter->sfp_poll_time = jiffies + IXGBE_SFP_POLL_JIFFIES - 1;
 
 	err = hw->phy.ops.identify_sfp(hw);
-	if (err == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (err == -EOPNOTSUPP)
 		goto sfp_out;
 
-	if (err == IXGBE_ERR_SFP_NOT_PRESENT) {
+	if (err == -ENOENT) {
 		/* If no cable is present, then we need to reset
 		 * the next time we find a good cable. */
 		adapter->flags2 |= IXGBE_FLAG2_SFP_NEEDS_RESET;
@@ -7714,7 +7712,7 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 	else
 		err = hw->mac.ops.setup_sfp(hw);
 
-	if (err == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (err == -EOPNOTSUPP)
 		goto sfp_out;
 
 	adapter->flags |= IXGBE_FLAG_NEED_LINK_CONFIG;
@@ -7723,8 +7721,8 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 sfp_out:
 	clear_bit(__IXGBE_IN_SFP_INIT, &adapter->state);
 
-	if ((err == IXGBE_ERR_SFP_NOT_SUPPORTED) &&
-	    (adapter->netdev->reg_state == NETREG_REGISTERED)) {
+	if (err == -EOPNOTSUPP &&
+	    adapter->netdev->reg_state == NETREG_REGISTERED) {
 		e_dev_err("failed to initialize because an unsupported "
 			  "SFP+ module type was detected.\n");
 		e_dev_err("Reload the driver after installing a "
@@ -7794,7 +7792,7 @@ static void ixgbe_service_timer(struct timer_list *t)
 static void ixgbe_phy_interrupt_subtask(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
-	u32 status;
+	bool overtemp;
 
 	if (!(adapter->flags2 & IXGBE_FLAG2_PHY_INTERRUPT))
 		return;
@@ -7804,11 +7802,9 @@ static void ixgbe_phy_interrupt_subtask(struct ixgbe_adapter *adapter)
 	if (!hw->phy.ops.handle_lasi)
 		return;
 
-	status = hw->phy.ops.handle_lasi(&adapter->hw);
-	if (status != IXGBE_ERR_OVERTEMP)
-		return;
-
-	e_crit(drv, "%s\n", ixgbe_overheat_msg);
+	hw->phy.ops.handle_lasi(&adapter->hw, &overtemp);
+	if (overtemp)
+		e_crit(drv, "%s\n", ixgbe_overheat_msg);
 }
 
 static void ixgbe_reset_subtask(struct ixgbe_adapter *adapter)
@@ -10635,9 +10631,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = hw->mac.ops.reset_hw(hw);
 	hw->phy.reset_if_overtemp = false;
 	ixgbe_set_eee_capable(adapter);
-	if (err == IXGBE_ERR_SFP_NOT_PRESENT) {
+	if (err == -ENOENT) {
 		err = 0;
-	} else if (err == IXGBE_ERR_SFP_NOT_SUPPORTED) {
+	} else if (err == -EOPNOTSUPP) {
 		e_dev_err("failed to load because an unsupported SFP+ or QSFP module type was detected.\n");
 		e_dev_err("Reload the driver after installing a supported module.\n");
 		goto err_sw_init;
@@ -10849,7 +10845,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* reset the hardware with the new settings */
 	err = hw->mac.ops.start_hw(hw);
-	if (err == IXGBE_ERR_EEPROM_VERSION) {
+	if (err == -EACCES) {
 		/* We are running on a pre-production device, log a warning */
 		e_dev_warn("This device is a pre-production adapter/LOM. "
 			   "Please be aware there may be issues associated "
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c
index 5679293e53f7..fe7ef5773369 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c
@@ -24,7 +24,7 @@ s32 ixgbe_read_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size, u16 mbx_id)
 		size = mbx->size;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->read(hw, msg, size, mbx_id);
 }
@@ -43,10 +43,10 @@ s32 ixgbe_write_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size, u16 mbx_id)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 
 	if (size > mbx->size)
-		return IXGBE_ERR_MBX;
+		return -EINVAL;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->write(hw, msg, size, mbx_id);
 }
@@ -63,7 +63,7 @@ s32 ixgbe_check_for_msg(struct ixgbe_hw *hw, u16 mbx_id)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->check_for_msg(hw, mbx_id);
 }
@@ -80,7 +80,7 @@ s32 ixgbe_check_for_ack(struct ixgbe_hw *hw, u16 mbx_id)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->check_for_ack(hw, mbx_id);
 }
@@ -97,7 +97,7 @@ s32 ixgbe_check_for_rst(struct ixgbe_hw *hw, u16 mbx_id)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->check_for_rst(hw, mbx_id);
 }
@@ -115,12 +115,12 @@ static s32 ixgbe_poll_for_msg(struct ixgbe_hw *hw, u16 mbx_id)
 	int countdown = mbx->timeout;
 
 	if (!countdown || !mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	while (mbx->ops->check_for_msg(hw, mbx_id)) {
 		countdown--;
 		if (!countdown)
-			return IXGBE_ERR_MBX;
+			return -EIO;
 		udelay(mbx->usec_delay);
 	}
 
@@ -140,12 +140,12 @@ static s32 ixgbe_poll_for_ack(struct ixgbe_hw *hw, u16 mbx_id)
 	int countdown = mbx->timeout;
 
 	if (!countdown || !mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	while (mbx->ops->check_for_ack(hw, mbx_id)) {
 		countdown--;
 		if (!countdown)
-			return IXGBE_ERR_MBX;
+			return -EIO;
 		udelay(mbx->usec_delay);
 	}
 
@@ -169,7 +169,7 @@ static s32 ixgbe_read_posted_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size,
 	s32 ret_val;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	ret_val = ixgbe_poll_for_msg(hw, mbx_id);
 	if (ret_val)
@@ -197,7 +197,7 @@ static s32 ixgbe_write_posted_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size,
 
 	/* exit if either we can't write or there isn't a defined timeout */
 	if (!mbx->ops || !mbx->timeout)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	/* send msg */
 	ret_val = mbx->ops->write(hw, msg, size, mbx_id);
@@ -217,7 +217,7 @@ static s32 ixgbe_check_for_bit_pf(struct ixgbe_hw *hw, u32 mask, s32 index)
 		return 0;
 	}
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
@@ -238,7 +238,7 @@ static s32 ixgbe_check_for_msg_pf(struct ixgbe_hw *hw, u16 vf_number)
 		return 0;
 	}
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
@@ -259,7 +259,7 @@ static s32 ixgbe_check_for_ack_pf(struct ixgbe_hw *hw, u16 vf_number)
 		return 0;
 	}
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
@@ -295,7 +295,7 @@ static s32 ixgbe_check_for_rst_pf(struct ixgbe_hw *hw, u16 vf_number)
 		return 0;
 	}
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
@@ -317,7 +317,7 @@ static s32 ixgbe_obtain_mbx_lock_pf(struct ixgbe_hw *hw, u16 vf_number)
 	if (p2v_mailbox & IXGBE_PFMAILBOX_PFU)
 		return 0;
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
index e085b6520dac..25675b2d21eb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
@@ -7,7 +7,6 @@
 #include "ixgbe_type.h"
 
 #define IXGBE_VFMAILBOX_SIZE        16 /* 16 32 bit words - 64 bytes */
-#define IXGBE_ERR_MBX               -100
 
 #define IXGBE_VFMAILBOX             0x002FC
 #define IXGBE_VFMBMEM               0x00200
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 919a7af84b42..cece955da150 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -101,7 +101,7 @@ s32 ixgbe_read_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 	csum = ~csum;
 	do {
 		if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 		ixgbe_i2c_start(hw);
 		/* Device Address and write indication */
 		if (ixgbe_out_i2c_byte_ack(hw, addr))
@@ -149,7 +149,7 @@ s32 ixgbe_read_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 			hw_dbg(hw, "I2C byte read combined error.\n");
 	} while (retry < max_retry);
 
-	return IXGBE_ERR_I2C;
+	return -EIO;
 }
 
 /**
@@ -178,7 +178,7 @@ s32 ixgbe_write_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 	csum = ~csum;
 	do {
 		if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 		ixgbe_i2c_start(hw);
 		/* Device Address and write indication */
 		if (ixgbe_out_i2c_byte_ack(hw, addr))
@@ -214,7 +214,7 @@ s32 ixgbe_write_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 			hw_dbg(hw, "I2C byte write combined error.\n");
 	} while (retry < max_retry);
 
-	return IXGBE_ERR_I2C;
+	return -EIO;
 }
 
 /**
@@ -261,8 +261,8 @@ static bool ixgbe_probe_phy(struct ixgbe_hw *hw, u16 phy_addr)
  **/
 s32 ixgbe_identify_phy_generic(struct ixgbe_hw *hw)
 {
+	u32 status = -EFAULT;
 	u32 phy_addr;
-	u32 status = IXGBE_ERR_PHY_ADDR_INVALID;
 
 	if (!hw->phy.phy_semaphore_mask) {
 		if (hw->bus.lan_id)
@@ -281,7 +281,7 @@ s32 ixgbe_identify_phy_generic(struct ixgbe_hw *hw)
 		if (ixgbe_probe_phy(hw, phy_addr))
 			return 0;
 		else
-			return IXGBE_ERR_PHY_ADDR_INVALID;
+			return -EFAULT;
 	}
 
 	for (phy_addr = 0; phy_addr < IXGBE_MAX_PHY_ADDR; phy_addr++) {
@@ -404,8 +404,7 @@ s32 ixgbe_reset_phy_generic(struct ixgbe_hw *hw)
 		return status;
 
 	/* Don't reset PHY if it's shut down due to overtemp. */
-	if (!hw->phy.reset_if_overtemp &&
-	    (IXGBE_ERR_OVERTEMP == hw->phy.ops.check_overtemp(hw)))
+	if (!hw->phy.reset_if_overtemp && hw->phy.ops.check_overtemp(hw))
 		return 0;
 
 	/* Blocked by MNG FW so bail */
@@ -453,7 +452,7 @@ s32 ixgbe_reset_phy_generic(struct ixgbe_hw *hw)
 
 	if (ctrl & MDIO_CTRL1_RESET) {
 		hw_dbg(hw, "PHY reset polling failed to complete.\n");
-		return IXGBE_ERR_RESET_FAILED;
+		return -EIO;
 	}
 
 	return 0;
@@ -495,7 +494,7 @@ s32 ixgbe_read_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr, u32 device_type,
 
 	if ((command & IXGBE_MSCA_MDI_COMMAND) != 0) {
 		hw_dbg(hw, "PHY address command did not complete.\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	/* Address cycle complete, setup and write the read
@@ -522,7 +521,7 @@ s32 ixgbe_read_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr, u32 device_type,
 
 	if ((command & IXGBE_MSCA_MDI_COMMAND) != 0) {
 		hw_dbg(hw, "PHY read command didn't complete\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	/* Read operation is complete.  Get the data
@@ -554,7 +553,7 @@ s32 ixgbe_read_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
 						phy_data);
 		hw->mac.ops.release_swfw_sync(hw, gssr);
 	} else {
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 
 	return status;
@@ -599,7 +598,7 @@ s32 ixgbe_write_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr,
 
 	if ((command & IXGBE_MSCA_MDI_COMMAND) != 0) {
 		hw_dbg(hw, "PHY address cmd didn't complete\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	/*
@@ -627,7 +626,7 @@ s32 ixgbe_write_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr,
 
 	if ((command & IXGBE_MSCA_MDI_COMMAND) != 0) {
 		hw_dbg(hw, "PHY write cmd didn't complete\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	return 0;
@@ -652,7 +651,7 @@ s32 ixgbe_write_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
 						 phy_data);
 		hw->mac.ops.release_swfw_sync(hw, gssr);
 	} else {
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 
 	return status;
@@ -997,7 +996,7 @@ s32 ixgbe_reset_phy_nl(struct ixgbe_hw *hw)
 
 	if ((phy_data & MDIO_CTRL1_RESET) != 0) {
 		hw_dbg(hw, "PHY reset did not complete.\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	/* Get init offsets */
@@ -1054,12 +1053,12 @@ s32 ixgbe_reset_phy_nl(struct ixgbe_hw *hw)
 				hw_dbg(hw, "SOL\n");
 			} else {
 				hw_dbg(hw, "Bad control value\n");
-				return IXGBE_ERR_PHY;
+				return -EIO;
 			}
 			break;
 		default:
 			hw_dbg(hw, "Bad control type\n");
-			return IXGBE_ERR_PHY;
+			return -EIO;
 		}
 	}
 
@@ -1067,7 +1066,7 @@ s32 ixgbe_reset_phy_nl(struct ixgbe_hw *hw)
 
 err_eeprom:
 	hw_err(hw, "eeprom read at offset %d failed\n", data_offset);
-	return IXGBE_ERR_PHY;
+	return -EIO;
 }
 
 /**
@@ -1085,10 +1084,10 @@ s32 ixgbe_identify_module_generic(struct ixgbe_hw *hw)
 		return ixgbe_identify_qsfp_module_generic(hw);
 	default:
 		hw->phy.sfp_type = ixgbe_sfp_type_not_present;
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 	}
 
-	return IXGBE_ERR_SFP_NOT_PRESENT;
+	return -ENOENT;
 }
 
 /**
@@ -1113,7 +1112,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_fiber) {
 		hw->phy.sfp_type = ixgbe_sfp_type_not_present;
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 	}
 
 	/* LAN ID is needed for sfp_type determination */
@@ -1128,7 +1127,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 
 	if (identifier != IXGBE_SFF_IDENTIFIER_SFP) {
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 	status = hw->phy.ops.read_i2c_eeprom(hw,
 					     IXGBE_SFF_1GBE_COMP_CODES,
@@ -1319,7 +1318,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core0 ||
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1)) {
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 
 	/* Anything else 82598-based is supported */
@@ -1343,7 +1342,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 		}
 		hw_dbg(hw, "SFP+ module not supported\n");
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 	return 0;
 
@@ -1353,7 +1352,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 		hw->phy.id = 0;
 		hw->phy.type = ixgbe_phy_unknown;
 	}
-	return IXGBE_ERR_SFP_NOT_PRESENT;
+	return -ENOENT;
 }
 
 /**
@@ -1380,7 +1379,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_fiber_qsfp) {
 		hw->phy.sfp_type = ixgbe_sfp_type_not_present;
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 	}
 
 	/* LAN ID is needed for sfp_type determination */
@@ -1394,7 +1393,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 
 	if (identifier != IXGBE_SFF_IDENTIFIER_QSFP_PLUS) {
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 
 	hw->phy.id = identifier;
@@ -1462,7 +1461,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 		} else {
 			/* unsupported module type */
 			hw->phy.type = ixgbe_phy_sfp_unsupported;
-			return IXGBE_ERR_SFP_NOT_SUPPORTED;
+			return -EOPNOTSUPP;
 		}
 	}
 
@@ -1522,7 +1521,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 			}
 			hw_dbg(hw, "QSFP module not supported\n");
 			hw->phy.type = ixgbe_phy_sfp_unsupported;
-			return IXGBE_ERR_SFP_NOT_SUPPORTED;
+			return -EOPNOTSUPP;
 		}
 		return 0;
 	}
@@ -1533,7 +1532,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 	hw->phy.id = 0;
 	hw->phy.type = ixgbe_phy_unknown;
 
-	return IXGBE_ERR_SFP_NOT_PRESENT;
+	return -ENOENT;
 }
 
 /**
@@ -1553,14 +1552,14 @@ s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 	u16 sfp_type = hw->phy.sfp_type;
 
 	if (hw->phy.sfp_type == ixgbe_sfp_type_unknown)
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 
 	if (hw->phy.sfp_type == ixgbe_sfp_type_not_present)
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 
 	if ((hw->device_id == IXGBE_DEV_ID_82598_SR_DUAL_PORT_EM) &&
 	    (hw->phy.sfp_type == ixgbe_sfp_type_da_cu))
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 
 	/*
 	 * Limiting active cables and 1G Phys must be initialized as
@@ -1581,11 +1580,11 @@ s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 	if (hw->eeprom.ops.read(hw, IXGBE_PHY_INIT_OFFSET_NL, list_offset)) {
 		hw_err(hw, "eeprom read at %d failed\n",
 		       IXGBE_PHY_INIT_OFFSET_NL);
-		return IXGBE_ERR_SFP_NO_INIT_SEQ_PRESENT;
+		return -EIO;
 	}
 
 	if ((!*list_offset) || (*list_offset == 0xFFFF))
-		return IXGBE_ERR_SFP_NO_INIT_SEQ_PRESENT;
+		return -EIO;
 
 	/* Shift offset to first ID word */
 	(*list_offset)++;
@@ -1604,7 +1603,7 @@ s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 				goto err_phy;
 			if ((!*data_offset) || (*data_offset == 0xFFFF)) {
 				hw_dbg(hw, "SFP+ module not supported\n");
-				return IXGBE_ERR_SFP_NOT_SUPPORTED;
+				return -EOPNOTSUPP;
 			} else {
 				break;
 			}
@@ -1617,14 +1616,14 @@ s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 
 	if (sfp_id == IXGBE_PHY_INIT_END_NL) {
 		hw_dbg(hw, "No matching SFP+ module found\n");
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
 
 err_phy:
 	hw_err(hw, "eeprom read at offset %d failed\n", *list_offset);
-	return IXGBE_ERR_PHY;
+	return -EIO;
 }
 
 /**
@@ -1719,7 +1718,7 @@ static s32 ixgbe_read_i2c_byte_generic_int(struct ixgbe_hw *hw, u8 byte_offset,
 
 	do {
 		if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		ixgbe_i2c_start(hw);
 
@@ -1835,7 +1834,7 @@ static s32 ixgbe_write_i2c_byte_generic_int(struct ixgbe_hw *hw, u8 byte_offset,
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
 
 	if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	do {
 		ixgbe_i2c_start(hw);
@@ -2077,7 +2076,7 @@ static s32 ixgbe_get_i2c_ack(struct ixgbe_hw *hw)
 
 	if (ack == 1) {
 		hw_dbg(hw, "I2C ack was not received.\n");
-		status = IXGBE_ERR_I2C;
+		status = -EIO;
 	}
 
 	ixgbe_lower_i2c_clk(hw, &i2cctl);
@@ -2149,7 +2148,7 @@ static s32 ixgbe_clock_out_i2c_bit(struct ixgbe_hw *hw, bool data)
 		udelay(IXGBE_I2C_T_LOW);
 	} else {
 		hw_dbg(hw, "I2C data was not set to %X\n", data);
-		return IXGBE_ERR_I2C;
+		return -EIO;
 	}
 
 	return 0;
@@ -2245,7 +2244,7 @@ static s32 ixgbe_set_i2c_data(struct ixgbe_hw *hw, u32 *i2cctl, bool data)
 	*i2cctl = IXGBE_READ_REG(hw, IXGBE_I2CCTL(hw));
 	if (data != ixgbe_get_i2c_data(hw, i2cctl)) {
 		hw_dbg(hw, "Error - I2C data was not set to %X.\n", data);
-		return IXGBE_ERR_I2C;
+		return -EIO;
 	}
 
 	return 0;
@@ -2315,22 +2314,24 @@ static void ixgbe_i2c_bus_clear(struct ixgbe_hw *hw)
  *  @hw: pointer to hardware structure
  *
  *  Checks if the LASI temp alarm status was triggered due to overtemp
+ *
+ *  Return true when an overtemp event detected, otherwise false.
  **/
-s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
+bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
 {
 	u16 phy_data = 0;
+	u32 status;
 
 	if (hw->device_id != IXGBE_DEV_ID_82599_T3_LOM)
-		return 0;
+		return false;
 
 	/* Check that the LASI temp alarm status was triggered */
-	hw->phy.ops.read_reg(hw, IXGBE_TN_LASI_STATUS_REG,
-			     MDIO_MMD_PMAPMD, &phy_data);
-
-	if (!(phy_data & IXGBE_TN_LASI_STATUS_TEMP_ALARM))
-		return 0;
+	status = hw->phy.ops.read_reg(hw, IXGBE_TN_LASI_STATUS_REG,
+				      MDIO_MMD_PMAPMD, &phy_data);
+	if (status)
+		return false;
 
-	return IXGBE_ERR_OVERTEMP;
+	return !!(phy_data & IXGBE_TN_LASI_STATUS_TEMP_ALARM);
 }
 
 /** ixgbe_set_copper_phy_power - Control power for copper phy
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index c56baad04ee6..aeee56e58597 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -153,7 +153,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw);
 s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 					u16 *list_offset,
 					u16 *data_offset);
-s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw);
+bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw);
 s32 ixgbe_read_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
 				u8 dev_addr, u8 *data);
 s32 ixgbe_read_i2c_byte_generic_unlocked(struct ixgbe_hw *hw, u8 byte_offset,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 9b463ef62be5..847a33427db8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1261,7 +1261,7 @@ static int ixgbe_rcv_msg_from_vf(struct ixgbe_adapter *adapter, u32 vf)
 		break;
 	default:
 		e_err(drv, "Unhandled Msg %8.8x\n", msgbuf[0]);
-		retval = IXGBE_ERR_MBX;
+		retval = -EIO;
 		break;
 	}
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 41bcbb337e83..d25ac9869d5e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1243,7 +1243,7 @@ struct ixgbe_nvm_version {
 #define IXGBE_PSRTYPE_RQPL_SHIFT    29
 
 /* CTRL Bit Masks */
-#define IXGBE_CTRL_GIO_DIS      0x00000004 /* Global IO Master Disable bit */
+#define IXGBE_CTRL_GIO_DIS      0x00000004 /* Global IO Primary Disable bit */
 #define IXGBE_CTRL_LNK_RST      0x00000008 /* Link Reset. Resets everything. */
 #define IXGBE_CTRL_RST          0x04000000 /* Reset (SW) */
 #define IXGBE_CTRL_RST_MASK     (IXGBE_CTRL_LNK_RST | IXGBE_CTRL_RST)
@@ -1806,7 +1806,7 @@ enum {
 /* STATUS Bit Masks */
 #define IXGBE_STATUS_LAN_ID         0x0000000C /* LAN ID */
 #define IXGBE_STATUS_LAN_ID_SHIFT   2          /* LAN ID Shift*/
-#define IXGBE_STATUS_GIO            0x00080000 /* GIO Master Enable Status */
+#define IXGBE_STATUS_GIO            0x00080000 /* GIO Primary Enable Status */
 
 #define IXGBE_STATUS_LAN_ID_0   0x00000000 /* LAN ID 0 */
 #define IXGBE_STATUS_LAN_ID_1   0x00000004 /* LAN ID 1 */
@@ -2188,8 +2188,8 @@ enum {
 #define IXGBE_PCIDEVCTRL2_4_8s		0xd
 #define IXGBE_PCIDEVCTRL2_17_34s	0xe
 
-/* Number of 100 microseconds we wait for PCI Express master disable */
-#define IXGBE_PCI_MASTER_DISABLE_TIMEOUT	800
+/* Number of 100 microseconds we wait for PCI Express primary disable */
+#define IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT	800
 
 /* RAH */
 #define IXGBE_RAH_VIND_MASK     0x003C0000
@@ -3493,10 +3493,10 @@ struct ixgbe_phy_operations {
 	s32 (*read_i2c_sff8472)(struct ixgbe_hw *, u8 , u8 *);
 	s32 (*read_i2c_eeprom)(struct ixgbe_hw *, u8 , u8 *);
 	s32 (*write_i2c_eeprom)(struct ixgbe_hw *, u8, u8);
-	s32 (*check_overtemp)(struct ixgbe_hw *);
+	bool (*check_overtemp)(struct ixgbe_hw *);
 	s32 (*set_phy_power)(struct ixgbe_hw *, bool on);
 	s32 (*enter_lplu)(struct ixgbe_hw *);
-	s32 (*handle_lasi)(struct ixgbe_hw *hw);
+	s32 (*handle_lasi)(struct ixgbe_hw *hw, bool *);
 	s32 (*read_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
 				      u8 *value);
 	s32 (*write_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
@@ -3649,45 +3649,6 @@ struct ixgbe_info {
 	const u32			*mvals;
 };
 
-
-/* Error Codes */
-#define IXGBE_ERR_EEPROM                        -1
-#define IXGBE_ERR_EEPROM_CHECKSUM               -2
-#define IXGBE_ERR_PHY                           -3
-#define IXGBE_ERR_CONFIG                        -4
-#define IXGBE_ERR_PARAM                         -5
-#define IXGBE_ERR_MAC_TYPE                      -6
-#define IXGBE_ERR_UNKNOWN_PHY                   -7
-#define IXGBE_ERR_LINK_SETUP                    -8
-#define IXGBE_ERR_ADAPTER_STOPPED               -9
-#define IXGBE_ERR_INVALID_MAC_ADDR              -10
-#define IXGBE_ERR_DEVICE_NOT_SUPPORTED          -11
-#define IXGBE_ERR_MASTER_REQUESTS_PENDING       -12
-#define IXGBE_ERR_INVALID_LINK_SETTINGS         -13
-#define IXGBE_ERR_AUTONEG_NOT_COMPLETE          -14
-#define IXGBE_ERR_RESET_FAILED                  -15
-#define IXGBE_ERR_SWFW_SYNC                     -16
-#define IXGBE_ERR_PHY_ADDR_INVALID              -17
-#define IXGBE_ERR_I2C                           -18
-#define IXGBE_ERR_SFP_NOT_SUPPORTED             -19
-#define IXGBE_ERR_SFP_NOT_PRESENT               -20
-#define IXGBE_ERR_SFP_NO_INIT_SEQ_PRESENT       -21
-#define IXGBE_ERR_NO_SAN_ADDR_PTR               -22
-#define IXGBE_ERR_FDIR_REINIT_FAILED            -23
-#define IXGBE_ERR_EEPROM_VERSION                -24
-#define IXGBE_ERR_NO_SPACE                      -25
-#define IXGBE_ERR_OVERTEMP                      -26
-#define IXGBE_ERR_FC_NOT_NEGOTIATED             -27
-#define IXGBE_ERR_FC_NOT_SUPPORTED              -28
-#define IXGBE_ERR_SFP_SETUP_NOT_COMPLETE        -30
-#define IXGBE_ERR_PBA_SECTION                   -31
-#define IXGBE_ERR_INVALID_ARGUMENT              -32
-#define IXGBE_ERR_HOST_INTERFACE_COMMAND        -33
-#define IXGBE_ERR_FDIR_CMD_INCOMPLETE		-38
-#define IXGBE_ERR_FW_RESP_INVALID		-39
-#define IXGBE_ERR_TOKEN_RETRY			-40
-#define IXGBE_NOT_IMPLEMENTED                   0x7FFFFFFF
-
 #define IXGBE_FUSES0_GROUP(_i)		(0x11158 + ((_i) * 4))
 #define IXGBE_FUSES0_300MHZ		BIT(5)
 #define IXGBE_FUSES0_REV_MASK		(3u << 6)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index de563cfd294d..fb4ced963c88 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -84,7 +84,7 @@ s32 ixgbe_reset_hw_X540(struct ixgbe_hw *hw)
 	status = hw->mac.ops.acquire_swfw_sync(hw, swfw_mask);
 	if (status) {
 		hw_dbg(hw, "semaphore failed with %d", status);
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 
 	ctrl = IXGBE_CTRL_RST;
@@ -103,7 +103,7 @@ s32 ixgbe_reset_hw_X540(struct ixgbe_hw *hw)
 	}
 
 	if (ctrl & IXGBE_CTRL_RST_MASK) {
-		status = IXGBE_ERR_RESET_FAILED;
+		status = -EIO;
 		hw_dbg(hw, "Reset polling failed to complete.\n");
 	}
 	msleep(100);
@@ -220,7 +220,7 @@ static s32 ixgbe_read_eerd_X540(struct ixgbe_hw *hw, u16 offset, u16 *data)
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_read_eerd_generic(hw, offset, data);
 
@@ -243,7 +243,7 @@ static s32 ixgbe_read_eerd_buffer_X540(struct ixgbe_hw *hw,
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_read_eerd_buffer_generic(hw, offset, words, data);
 
@@ -264,7 +264,7 @@ static s32 ixgbe_write_eewr_X540(struct ixgbe_hw *hw, u16 offset, u16 data)
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_write_eewr_generic(hw, offset, data);
 
@@ -287,7 +287,7 @@ static s32 ixgbe_write_eewr_buffer_X540(struct ixgbe_hw *hw,
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_write_eewr_buffer_generic(hw, offset, words, data);
 
@@ -324,7 +324,7 @@ static s32 ixgbe_calc_eeprom_checksum_X540(struct ixgbe_hw *hw)
 	for (i = 0; i < checksum_last_word; i++) {
 		if (ixgbe_read_eerd_generic(hw, i, &word)) {
 			hw_dbg(hw, "EEPROM read failed\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 		checksum += word;
 	}
@@ -349,8 +349,7 @@ static s32 ixgbe_calc_eeprom_checksum_X540(struct ixgbe_hw *hw)
 
 		if (ixgbe_read_eerd_generic(hw, pointer, &length)) {
 			hw_dbg(hw, "EEPROM read failed\n");
-			return IXGBE_ERR_EEPROM;
-			break;
+			return -EIO;
 		}
 
 		/* Skip pointer section if length is invalid. */
@@ -361,7 +360,7 @@ static s32 ixgbe_calc_eeprom_checksum_X540(struct ixgbe_hw *hw)
 		for (j = pointer + 1; j <= pointer + length; j++) {
 			if (ixgbe_read_eerd_generic(hw, j, &word)) {
 				hw_dbg(hw, "EEPROM read failed\n");
-				return IXGBE_ERR_EEPROM;
+				return -EIO;
 			}
 			checksum += word;
 		}
@@ -398,7 +397,7 @@ static s32 ixgbe_validate_eeprom_checksum_X540(struct ixgbe_hw *hw,
 	}
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = hw->eeprom.ops.calc_checksum(hw);
 	if (status < 0)
@@ -419,7 +418,7 @@ static s32 ixgbe_validate_eeprom_checksum_X540(struct ixgbe_hw *hw,
 	 */
 	if (read_checksum != checksum) {
 		hw_dbg(hw, "Invalid EEPROM checksum");
-		status = IXGBE_ERR_EEPROM_CHECKSUM;
+		status = -EIO;
 	}
 
 	/* If the user cares, return the calculated checksum */
@@ -456,7 +455,7 @@ static s32 ixgbe_update_eeprom_checksum_X540(struct ixgbe_hw *hw)
 	}
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return  IXGBE_ERR_SWFW_SYNC;
+		return  -EBUSY;
 
 	status = hw->eeprom.ops.calc_checksum(hw);
 	if (status < 0)
@@ -491,7 +490,7 @@ static s32 ixgbe_update_flash_X540(struct ixgbe_hw *hw)
 	s32 status;
 
 	status = ixgbe_poll_flash_update_done_X540(hw);
-	if (status == IXGBE_ERR_EEPROM) {
+	if (status == -EIO) {
 		hw_dbg(hw, "Flash update time out\n");
 		return status;
 	}
@@ -541,7 +540,7 @@ static s32 ixgbe_poll_flash_update_done_X540(struct ixgbe_hw *hw)
 			return 0;
 		udelay(5);
 	}
-	return IXGBE_ERR_EEPROM;
+	return -EIO;
 }
 
 /**
@@ -576,7 +575,7 @@ s32 ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 		 * SW_FW_SYNC bits (not just NVM)
 		 */
 		if (ixgbe_get_swfw_sync_semaphore(hw))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		swfw_sync = IXGBE_READ_REG(hw, IXGBE_SWFW_SYNC(hw));
 		if (!(swfw_sync & (fwmask | swmask | hwmask))) {
@@ -600,7 +599,7 @@ s32 ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 	 * bits in the SW_FW_SYNC register.
 	 */
 	if (ixgbe_get_swfw_sync_semaphore(hw))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	swfw_sync = IXGBE_READ_REG(hw, IXGBE_SWFW_SYNC(hw));
 	if (swfw_sync & (fwmask | hwmask)) {
 		swfw_sync |= swmask;
@@ -623,11 +622,11 @@ s32 ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 			rmask |= IXGBE_GSSR_I2C_MASK;
 		ixgbe_release_swfw_sync_X540(hw, rmask);
 		ixgbe_release_swfw_sync_semaphore(hw);
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 	ixgbe_release_swfw_sync_semaphore(hw);
 
-	return IXGBE_ERR_SWFW_SYNC;
+	return -EBUSY;
 }
 
 /**
@@ -681,7 +680,7 @@ static s32 ixgbe_get_swfw_sync_semaphore(struct ixgbe_hw *hw)
 	if (i == timeout) {
 		hw_dbg(hw,
 		       "Software semaphore SMBI between device drivers not granted.\n");
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	/* Now get the semaphore between SW/FW through the REGSMP bit */
@@ -698,7 +697,7 @@ static s32 ixgbe_get_swfw_sync_semaphore(struct ixgbe_hw *hw)
 	 */
 	hw_dbg(hw, "REGSMP Software NVM semaphore not granted\n");
 	ixgbe_release_swfw_sync_semaphore(hw);
-	return IXGBE_ERR_EEPROM;
+	return -EIO;
 }
 
 /**
@@ -769,7 +768,7 @@ s32 ixgbe_blink_led_start_X540(struct ixgbe_hw *hw, u32 index)
 	bool link_up;
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* Link should be up in order for the blink bit in the LED control
 	 * register to work. Force link and speed in the MAC if link is down.
@@ -805,7 +804,7 @@ s32 ixgbe_blink_led_stop_X540(struct ixgbe_hw *hw, u32 index)
 	u32 ledctl_reg;
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* Restore the LED to its default value. */
 	ledctl_reg = IXGBE_READ_REG(hw, IXGBE_LEDCTL);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 9277d57c4a70..7b1471226fd8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -206,13 +206,13 @@ static s32 ixgbe_reset_cs4227(struct ixgbe_hw *hw)
 	}
 	if (retry == IXGBE_CS4227_RETRIES) {
 		hw_err(hw, "CS4227 reset did not complete\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	status = ixgbe_read_cs4227(hw, IXGBE_CS4227_EEPROM_STATUS, &value);
 	if (status || !(value & IXGBE_CS4227_EEPROM_LOAD_OK)) {
 		hw_err(hw, "CS4227 EEPROM did not load successfully\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	return 0;
@@ -350,13 +350,13 @@ static s32 ixgbe_identify_phy_x550em(struct ixgbe_hw *hw)
 static s32 ixgbe_read_phy_reg_x550em(struct ixgbe_hw *hw, u32 reg_addr,
 				     u32 device_type, u16 *phy_data)
 {
-	return IXGBE_NOT_IMPLEMENTED;
+	return -EOPNOTSUPP;
 }
 
 static s32 ixgbe_write_phy_reg_x550em(struct ixgbe_hw *hw, u32 reg_addr,
 				      u32 device_type, u16 phy_data)
 {
-	return IXGBE_NOT_IMPLEMENTED;
+	return -EOPNOTSUPP;
 }
 
 /**
@@ -463,7 +463,7 @@ s32 ixgbe_fw_phy_activity(struct ixgbe_hw *hw, u16 activity,
 		--retries;
 	} while (retries > 0);
 
-	return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+	return -EIO;
 }
 
 static const struct {
@@ -511,7 +511,7 @@ static s32 ixgbe_get_phy_id_fw(struct ixgbe_hw *hw)
 	hw->phy.id |= phy_id_lo & IXGBE_PHY_REVISION_MASK;
 	hw->phy.revision = phy_id_lo & ~IXGBE_PHY_REVISION_MASK;
 	if (!hw->phy.id || hw->phy.id == IXGBE_PHY_REVISION_MASK)
-		return IXGBE_ERR_PHY_ADDR_INVALID;
+		return -EFAULT;
 
 	hw->phy.autoneg_advertised = hw->phy.speeds_supported;
 	hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_100_FULL |
@@ -568,7 +568,7 @@ static s32 ixgbe_setup_fw_link(struct ixgbe_hw *hw)
 
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == ixgbe_fc_rx_pause) {
 		hw_err(hw, "rx_pause not valid in strict IEEE mode\n");
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	switch (hw->fc.requested_mode) {
@@ -600,8 +600,10 @@ static s32 ixgbe_setup_fw_link(struct ixgbe_hw *hw)
 	rc = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_SETUP_LINK, &setup);
 	if (rc)
 		return rc;
+
 	if (setup[0] == FW_PHY_ACT_SETUP_LINK_RSP_DOWN)
-		return IXGBE_ERR_OVERTEMP;
+		return -EIO;
+
 	return 0;
 }
 
@@ -675,7 +677,7 @@ static s32 ixgbe_iosf_wait(struct ixgbe_hw *hw, u32 *ctrl)
 		*ctrl = command;
 	if (i == IXGBE_MDIO_COMMAND_TIMEOUT) {
 		hw_dbg(hw, "IOSF wait timed out\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	return 0;
@@ -715,7 +717,8 @@ static s32 ixgbe_read_iosf_sb_reg_x550(struct ixgbe_hw *hw, u32 reg_addr,
 		error = (command & IXGBE_SB_IOSF_CTRL_CMPL_ERR_MASK) >>
 			 IXGBE_SB_IOSF_CTRL_CMPL_ERR_SHIFT;
 		hw_dbg(hw, "Failed to read, error %x\n", error);
-		return IXGBE_ERR_PHY;
+		ret = -EIO;
+		goto out;
 	}
 
 	if (!ret)
@@ -750,9 +753,9 @@ static s32 ixgbe_get_phy_token(struct ixgbe_hw *hw)
 	if (token_cmd.hdr.cmd_or_resp.ret_status == FW_PHY_TOKEN_OK)
 		return 0;
 	if (token_cmd.hdr.cmd_or_resp.ret_status != FW_PHY_TOKEN_RETRY)
-		return IXGBE_ERR_FW_RESP_INVALID;
+		return -EIO;
 
-	return IXGBE_ERR_TOKEN_RETRY;
+	return -EAGAIN;
 }
 
 /**
@@ -778,7 +781,7 @@ static s32 ixgbe_put_phy_token(struct ixgbe_hw *hw)
 		return status;
 	if (token_cmd.hdr.cmd_or_resp.ret_status == FW_PHY_TOKEN_OK)
 		return 0;
-	return IXGBE_ERR_FW_RESP_INVALID;
+	return -EIO;
 }
 
 /**
@@ -942,7 +945,7 @@ static s32 ixgbe_checksum_ptr_x550(struct ixgbe_hw *hw, u16 ptr,
 		local_buffer = buf;
 	} else {
 		if (buffer_size < ptr)
-			return  IXGBE_ERR_PARAM;
+			return  -EINVAL;
 		local_buffer = &buffer[ptr];
 	}
 
@@ -960,7 +963,7 @@ static s32 ixgbe_checksum_ptr_x550(struct ixgbe_hw *hw, u16 ptr,
 	}
 
 	if (buffer && ((u32)start + (u32)length > buffer_size))
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	for (i = start; length; i++, length--) {
 		if (i == bufsz && !buffer) {
@@ -1012,7 +1015,7 @@ static s32 ixgbe_calc_checksum_X550(struct ixgbe_hw *hw, u16 *buffer,
 		local_buffer = eeprom_ptrs;
 	} else {
 		if (buffer_size < IXGBE_EEPROM_LAST_WORD)
-			return IXGBE_ERR_PARAM;
+			return -EINVAL;
 		local_buffer = buffer;
 	}
 
@@ -1148,7 +1151,7 @@ static s32 ixgbe_validate_eeprom_checksum_X550(struct ixgbe_hw *hw,
 	 * calculated checksum
 	 */
 	if (read_checksum != checksum) {
-		status = IXGBE_ERR_EEPROM_CHECKSUM;
+		status = -EIO;
 		hw_dbg(hw, "Invalid EEPROM checksum");
 	}
 
@@ -1203,7 +1206,7 @@ static s32 ixgbe_write_ee_hostif_X550(struct ixgbe_hw *hw, u16 offset, u16 data)
 		hw->mac.ops.release_swfw_sync(hw, IXGBE_GSSR_EEP_SM);
 	} else {
 		hw_dbg(hw, "write ee hostif failed to get semaphore");
-		status = IXGBE_ERR_SWFW_SYNC;
+		status = -EBUSY;
 	}
 
 	return status;
@@ -1401,7 +1404,7 @@ static s32 ixgbe_write_iosf_sb_reg_x550(struct ixgbe_hw *hw, u32 reg_addr,
 		error = (command & IXGBE_SB_IOSF_CTRL_CMPL_ERR_MASK) >>
 			 IXGBE_SB_IOSF_CTRL_CMPL_ERR_SHIFT;
 		hw_dbg(hw, "Failed to write, error %x\n", error);
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 out:
@@ -1544,7 +1547,7 @@ static s32 ixgbe_setup_ixfi_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 
 	/* iXFI is only supported with X552 */
 	if (mac->type != ixgbe_mac_X550EM_x)
-		return IXGBE_ERR_LINK_SETUP;
+		return -EIO;
 
 	/* Disable AN and force speed to 10G Serial. */
 	status = ixgbe_read_iosf_sb_reg_x550(hw,
@@ -1566,7 +1569,7 @@ static s32 ixgbe_setup_ixfi_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 		break;
 	default:
 		/* Other link speeds are not supported by internal KR PHY. */
-		return IXGBE_ERR_LINK_SETUP;
+		return -EINVAL;
 	}
 
 	status = ixgbe_write_iosf_sb_reg_x550(hw,
@@ -1597,7 +1600,7 @@ static s32 ixgbe_supported_sfp_modules_X550em(struct ixgbe_hw *hw, bool *linear)
 {
 	switch (hw->phy.sfp_type) {
 	case ixgbe_sfp_type_not_present:
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 	case ixgbe_sfp_type_da_cu_core0:
 	case ixgbe_sfp_type_da_cu_core1:
 		*linear = true;
@@ -1616,7 +1619,7 @@ static s32 ixgbe_supported_sfp_modules_X550em(struct ixgbe_hw *hw, bool *linear)
 	case ixgbe_sfp_type_1g_cu_core0:
 	case ixgbe_sfp_type_1g_cu_core1:
 	default:
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -1646,7 +1649,7 @@ ixgbe_setup_mac_link_sfp_x550em(struct ixgbe_hw *hw,
 	 * there is no reason to configure CS4227 and SFP not present error is
 	 * not accepted in the setup MAC link flow.
 	 */
-	if (status == IXGBE_ERR_SFP_NOT_PRESENT)
+	if (status == -ENOENT)
 		return 0;
 
 	if (status)
@@ -1704,7 +1707,7 @@ static s32 ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 		break;
 	default:
 		/* Other link speeds are not supported by internal PHY. */
-		return IXGBE_ERR_LINK_SETUP;
+		return -EINVAL;
 	}
 
 	status = mac->ops.write_iosf_sb_reg(hw,
@@ -1739,7 +1742,7 @@ ixgbe_setup_mac_link_sfp_n(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	/* If no SFP module present, then return success. Return success since
 	 * SFP not present error is not excepted in the setup MAC link flow.
 	 */
-	if (ret_val == IXGBE_ERR_SFP_NOT_PRESENT)
+	if (ret_val == -ENOENT)
 		return 0;
 
 	if (ret_val)
@@ -1789,7 +1792,7 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	/* If no SFP module present, then return success. Return success since
 	 * SFP not present error is not excepted in the setup MAC link flow.
 	 */
-	if (ret_val == IXGBE_ERR_SFP_NOT_PRESENT)
+	if (ret_val == -ENOENT)
 		return 0;
 
 	if (ret_val)
@@ -1799,7 +1802,7 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	ixgbe_setup_kr_speed_x550em(hw, speed);
 
 	if (hw->phy.mdio.prtad == MDIO_PRTAD_NONE)
-		return IXGBE_ERR_PHY_ADDR_INVALID;
+		return -EFAULT;
 
 	/* Get external PHY SKU id */
 	ret_val = hw->phy.ops.read_reg(hw, IXGBE_CS4227_EFUSE_PDF_SKU,
@@ -1898,7 +1901,7 @@ static s32 ixgbe_check_link_t_X550em(struct ixgbe_hw *hw,
 	u16 i, autoneg_status;
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 
 	status = ixgbe_check_mac_link_generic(hw, speed, link_up,
 					      link_up_wait_to_complete);
@@ -2081,9 +2084,9 @@ static s32 ixgbe_setup_sgmii_fw(struct ixgbe_hw *hw, ixgbe_link_speed speed,
  */
 static void ixgbe_fc_autoneg_sgmii_x550em_a(struct ixgbe_hw *hw)
 {
-	s32 status = IXGBE_ERR_FC_NOT_NEGOTIATED;
 	u32 info[FW_PHY_ACT_DATA_COUNT] = { 0 };
 	ixgbe_link_speed speed;
+	s32 status = -EIO;
 	bool link_up;
 
 	/* AN should have completed when the cable was plugged in.
@@ -2101,7 +2104,7 @@ static void ixgbe_fc_autoneg_sgmii_x550em_a(struct ixgbe_hw *hw)
 	/* Check if auto-negotiation has completed */
 	status = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_GET_LINK_INFO, &info);
 	if (status || !(info[0] & FW_PHY_ACT_GET_LINK_INFO_AN_COMPLETE)) {
-		status = IXGBE_ERR_FC_NOT_NEGOTIATED;
+		status = -EIO;
 		goto out;
 	}
 
@@ -2305,18 +2308,18 @@ static s32 ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
  * @hw: pointer to hardware structure
  * @lsc: pointer to boolean flag which indicates whether external Base T
  *	 PHY interrupt is lsc
+ * @is_overtemp: indicate whether an overtemp event encountered
  *
  * Determime if external Base T PHY interrupt cause is high temperature
  * failure alarm or link status change.
- *
- * Return IXGBE_ERR_OVERTEMP if interrupt is high temperature
- * failure alarm, else return PHY access status.
  **/
-static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
+static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc,
+				       bool *is_overtemp)
 {
 	u32 status;
 	u16 reg;
 
+	*is_overtemp = false;
 	*lsc = false;
 
 	/* Vendor alarm triggered */
@@ -2348,7 +2351,8 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
 	if (reg & IXGBE_MDIO_GLOBAL_ALM_1_HI_TMP_FAIL) {
 		/* power down the PHY in case the PHY FW didn't already */
 		ixgbe_set_copper_phy_power(hw, false);
-		return IXGBE_ERR_OVERTEMP;
+		*is_overtemp = true;
+		return -EIO;
 	}
 	if (reg & IXGBE_MDIO_GLOBAL_ALM_1_DEV_FAULT) {
 		/*  device fault alarm triggered */
@@ -2362,7 +2366,8 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
 		if (reg == IXGBE_MDIO_GLOBAL_FAULT_MSG_HI_TMP) {
 			/* power down the PHY in case the PHY FW didn't */
 			ixgbe_set_copper_phy_power(hw, false);
-			return IXGBE_ERR_OVERTEMP;
+			*is_overtemp = true;
+			return -EIO;
 		}
 	}
 
@@ -2398,12 +2403,12 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
  **/
 static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 {
+	bool lsc, overtemp;
 	u32 status;
 	u16 reg;
-	bool lsc;
 
 	/* Clear interrupt flags */
-	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc);
+	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, &overtemp);
 
 	/* Enable link status change alarm */
 
@@ -2482,21 +2487,20 @@ static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 /**
  * ixgbe_handle_lasi_ext_t_x550em - Handle external Base T PHY interrupt
  * @hw: pointer to hardware structure
+ * @is_overtemp: indicate whether an overtemp event encountered
  *
  * Handle external Base T PHY interrupt. If high temperature
  * failure alarm then return error, else if link status change
  * then setup internal/external PHY link
- *
- * Return IXGBE_ERR_OVERTEMP if interrupt is high temperature
- * failure alarm, else return PHY access status.
  **/
-static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw)
+static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw,
+					  bool *is_overtemp)
 {
 	struct ixgbe_phy_info *phy = &hw->phy;
 	bool lsc;
 	u32 status;
 
-	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc);
+	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, is_overtemp);
 	if (status)
 		return status;
 
@@ -2628,7 +2632,7 @@ static s32 ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
 	u16 speed;
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 
 	if (!(hw->mac.type == ixgbe_mac_X550EM_x &&
 	      !(hw->phy.nw_mng_if_sel & IXGBE_NW_MNG_IF_SEL_INT_PHY_MODE))) {
@@ -2671,7 +2675,7 @@ static s32 ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
 		break;
 	default:
 		/* Internal PHY does not support anything else */
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	return ixgbe_setup_ixfi_x550em(hw, &force_speed);
@@ -2703,7 +2707,7 @@ static s32 ixgbe_led_on_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
 	u16 phy_data;
 
 	if (led_idx >= IXGBE_X557_MAX_LED_INDEX)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* To turn on the LED, set mode to ON. */
 	hw->phy.ops.read_reg(hw, IXGBE_X557_LED_PROVISIONING + led_idx,
@@ -2725,7 +2729,7 @@ static s32 ixgbe_led_off_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
 	u16 phy_data;
 
 	if (led_idx >= IXGBE_X557_MAX_LED_INDEX)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* To turn on the LED, set mode to ON. */
 	hw->phy.ops.read_reg(hw, IXGBE_X557_LED_PROVISIONING + led_idx,
@@ -2749,8 +2753,9 @@ static s32 ixgbe_led_off_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
  *
  *  Sends driver version number to firmware through the manageability
  *  block.  On success return 0
- *  else returns IXGBE_ERR_SWFW_SYNC when encountering an error acquiring
- *  semaphore or IXGBE_ERR_HOST_INTERFACE_COMMAND when command fails.
+ *  else returns -EBUSY when encountering an error acquiring
+ *  semaphore, -EIO when command fails or -ENIVAL when incorrect
+ *  params passed.
  **/
 static s32 ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
 				     u8 build, u8 sub, u16 len,
@@ -2761,7 +2766,7 @@ static s32 ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
 	int i;
 
 	if (!len || !driver_ver || (len > sizeof(fw_cmd.driver_string)))
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 
 	fw_cmd.hdr.cmd = FW_CEM_CMD_DRIVER_INFO;
 	fw_cmd.hdr.buf_len = FW_CEM_CMD_DRIVER_INFO_LEN + len;
@@ -2786,7 +2791,7 @@ static s32 ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
 
 		if (fw_cmd.hdr.cmd_or_resp.ret_status !=
 		    FW_CEM_RESP_STATUS_SUCCESS)
-			return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+			return -EIO;
 		return 0;
 	}
 
@@ -2843,7 +2848,7 @@ static s32 ixgbe_setup_fc_x550em(struct ixgbe_hw *hw)
 	/* Validate the requested mode */
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == ixgbe_fc_rx_pause) {
 		hw_err(hw, "ixgbe_fc_rx_pause not valid in strict IEEE mode\n");
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	/* 10gig parts do not have a word in the EEPROM to determine the
@@ -2878,7 +2883,7 @@ static s32 ixgbe_setup_fc_x550em(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_err(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	switch (hw->device_id) {
@@ -2922,8 +2927,8 @@ static s32 ixgbe_setup_fc_x550em(struct ixgbe_hw *hw)
 static void ixgbe_fc_autoneg_backplane_x550em_a(struct ixgbe_hw *hw)
 {
 	u32 link_s1, lp_an_page_low, an_cntl_1;
-	s32 status = IXGBE_ERR_FC_NOT_NEGOTIATED;
 	ixgbe_link_speed speed;
+	s32 status = -EIO;
 	bool link_up;
 
 	/* AN should have completed when the cable was plugged in.
@@ -2949,7 +2954,7 @@ static void ixgbe_fc_autoneg_backplane_x550em_a(struct ixgbe_hw *hw)
 
 	if (status || (link_s1 & IXGBE_KRM_LINK_S1_MAC_AN_COMPLETE) == 0) {
 		hw_dbg(hw, "Auto-Negotiation did not complete\n");
-		status = IXGBE_ERR_FC_NOT_NEGOTIATED;
+		status = -EIO;
 		goto out;
 	}
 
@@ -3123,21 +3128,23 @@ static s32 ixgbe_reset_phy_fw(struct ixgbe_hw *hw)
 /**
  * ixgbe_check_overtemp_fw - Check firmware-controlled PHYs for overtemp
  * @hw: pointer to hardware structure
+ *
+ * Return true when an overtemp event detected, otherwise false.
  */
-static s32 ixgbe_check_overtemp_fw(struct ixgbe_hw *hw)
+static bool ixgbe_check_overtemp_fw(struct ixgbe_hw *hw)
 {
 	u32 store[FW_PHY_ACT_DATA_COUNT] = { 0 };
 	s32 rc;
 
 	rc = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_GET_LINK_INFO, &store);
 	if (rc)
-		return rc;
+		return false;
 
 	if (store[0] & FW_PHY_ACT_GET_LINK_INFO_TEMP) {
 		ixgbe_shutdown_fw_phy(hw);
-		return IXGBE_ERR_OVERTEMP;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 /**
@@ -3187,8 +3194,7 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 
 	/* Identify the PHY or SFP module */
 	ret_val = phy->ops.identify(hw);
-	if (ret_val == IXGBE_ERR_SFP_NOT_SUPPORTED ||
-	    ret_val == IXGBE_ERR_PHY_ADDR_INVALID)
+	if (ret_val == -EOPNOTSUPP || ret_val == -EFAULT)
 		return ret_val;
 
 	/* Setup function pointers based on detected hardware */
@@ -3396,8 +3402,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 
 	/* PHY ops must be identified and initialized prior to reset */
 	status = hw->phy.ops.init(hw);
-	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED ||
-	    status == IXGBE_ERR_PHY_ADDR_INVALID)
+	if (status == -EOPNOTSUPP || status == -EFAULT)
 		return status;
 
 	/* start the external PHY */
@@ -3413,7 +3418,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 		hw->phy.sfp_setup_needed = false;
 	}
 
-	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (status == -EOPNOTSUPP)
 		return status;
 
 	/* Reset PHY */
@@ -3437,7 +3442,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 	status = hw->mac.ops.acquire_swfw_sync(hw, swfw_mask);
 	if (status) {
 		hw_dbg(hw, "semaphore failed with %d", status);
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 
 	ctrl |= IXGBE_READ_REG(hw, IXGBE_CTRL);
@@ -3455,7 +3460,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 	}
 
 	if (ctrl & IXGBE_CTRL_RST_MASK) {
-		status = IXGBE_ERR_RESET_FAILED;
+		status = -EIO;
 		hw_dbg(hw, "Reset polling failed to complete.\n");
 	}
 
@@ -3551,7 +3556,7 @@ static s32 ixgbe_setup_fc_backplane_x550em_a(struct ixgbe_hw *hw)
 	/* Validate the requested mode */
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == ixgbe_fc_rx_pause) {
 		hw_err(hw, "ixgbe_fc_rx_pause not valid in strict IEEE mode\n");
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	if (hw->fc.requested_mode == ixgbe_fc_default)
@@ -3608,7 +3613,7 @@ static s32 ixgbe_setup_fc_backplane_x550em_a(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_err(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	status = hw->mac.ops.write_iosf_sb_reg(hw,
@@ -3704,7 +3709,7 @@ static s32 ixgbe_acquire_swfw_sync_x550em_a(struct ixgbe_hw *hw, u32 mask)
 			return 0;
 		if (hmask)
 			ixgbe_release_swfw_sync_X540(hw, hmask);
-		if (status != IXGBE_ERR_TOKEN_RETRY)
+		if (status != -EAGAIN)
 			return status;
 		msleep(FW_PHY_TOKEN_DELAY);
 	}
@@ -3748,7 +3753,7 @@ static s32 ixgbe_read_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, mask))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = hw->phy.ops.read_reg_mdi(hw, reg_addr, device_type, phy_data);
 
@@ -3774,7 +3779,7 @@ static s32 ixgbe_write_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, mask))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_write_phy_reg_mdi(hw, reg_addr, device_type, phy_data);
 	hw->mac.ops.release_swfw_sync(hw, mask);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index a4be04debe67..31da51b74c16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -227,11 +227,13 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 
 	ft->g = kcalloc(MLX5E_ARFS_NUM_GROUPS,
 			sizeof(*ft->g), GFP_KERNEL);
-	in = kvzalloc(inlen, GFP_KERNEL);
-	if  (!in || !ft->g) {
-		kvfree(ft->g);
-		kvfree(in);
+	if (!ft->g)
 		return -ENOMEM;
+
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in) {
+		err = -ENOMEM;
+		goto err_free_g;
 	}
 
 	mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
@@ -251,7 +253,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 		break;
 	default:
 		err = -EINVAL;
-		goto out;
+		goto err_free_in;
 	}
 
 	switch (type) {
@@ -273,7 +275,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 		break;
 	default:
 		err = -EINVAL;
-		goto out;
+		goto err_free_in;
 	}
 
 	MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
@@ -282,7 +284,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ft->g[ft->num_groups] = mlx5_create_flow_group(ft->t, in);
 	if (IS_ERR(ft->g[ft->num_groups]))
-		goto err;
+		goto err_clean_group;
 	ft->num_groups++;
 
 	memset(in, 0, inlen);
@@ -291,18 +293,20 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ft->g[ft->num_groups] = mlx5_create_flow_group(ft->t, in);
 	if (IS_ERR(ft->g[ft->num_groups]))
-		goto err;
+		goto err_clean_group;
 	ft->num_groups++;
 
 	kvfree(in);
 	return 0;
 
-err:
+err_clean_group:
 	err = PTR_ERR(ft->g[ft->num_groups]);
 	ft->g[ft->num_groups] = NULL;
-out:
+err_free_in:
 	kvfree(in);
-
+err_free_g:
+	kfree(ft->g);
+	ft->g = NULL;
 	return err;
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
index c8d0b1016a64..6dae2e23eacc 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
@@ -571,11 +571,13 @@ static int enable_bars(struct nfp6000_pcie *nfp, u16 interface)
 	const u32 barcfg_msix_general =
 		NFP_PCIE_BAR_PCIE2CPP_MapType(
 			NFP_PCIE_BAR_PCIE2CPP_MapType_GENERAL) |
-		NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT;
+		NFP_PCIE_BAR_PCIE2CPP_LengthSelect(
+			NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT);
 	const u32 barcfg_msix_xpb =
 		NFP_PCIE_BAR_PCIE2CPP_MapType(
 			NFP_PCIE_BAR_PCIE2CPP_MapType_BULK) |
-		NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT |
+		NFP_PCIE_BAR_PCIE2CPP_LengthSelect(
+			NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT) |
 		NFP_PCIE_BAR_PCIE2CPP_Target_BaseAddress(
 			NFP_CPP_TARGET_ISLAND_XPB);
 	const u32 barcfg_explicit[4] = {
diff --git a/drivers/net/fjes/fjes_hw.c b/drivers/net/fjes/fjes_hw.c
index 9c652c04375b..c3fa8db69b9e 100644
--- a/drivers/net/fjes/fjes_hw.c
+++ b/drivers/net/fjes/fjes_hw.c
@@ -235,21 +235,25 @@ static int fjes_hw_setup(struct fjes_hw *hw)
 
 	mem_size = FJES_DEV_REQ_BUF_SIZE(hw->max_epid);
 	hw->hw_info.req_buf = kzalloc(mem_size, GFP_KERNEL);
-	if (!(hw->hw_info.req_buf))
-		return -ENOMEM;
+	if (!(hw->hw_info.req_buf)) {
+		result = -ENOMEM;
+		goto free_ep_info;
+	}
 
 	hw->hw_info.req_buf_size = mem_size;
 
 	mem_size = FJES_DEV_RES_BUF_SIZE(hw->max_epid);
 	hw->hw_info.res_buf = kzalloc(mem_size, GFP_KERNEL);
-	if (!(hw->hw_info.res_buf))
-		return -ENOMEM;
+	if (!(hw->hw_info.res_buf)) {
+		result = -ENOMEM;
+		goto free_req_buf;
+	}
 
 	hw->hw_info.res_buf_size = mem_size;
 
 	result = fjes_hw_alloc_shared_status_region(hw);
 	if (result)
-		return result;
+		goto free_res_buf;
 
 	hw->hw_info.buffer_share_bit = 0;
 	hw->hw_info.buffer_unshare_reserve_bit = 0;
@@ -260,11 +264,11 @@ static int fjes_hw_setup(struct fjes_hw *hw)
 
 			result = fjes_hw_alloc_epbuf(&buf_pair->tx);
 			if (result)
-				return result;
+				goto free_epbuf;
 
 			result = fjes_hw_alloc_epbuf(&buf_pair->rx);
 			if (result)
-				return result;
+				goto free_epbuf;
 
 			spin_lock_irqsave(&hw->rx_status_lock, flags);
 			fjes_hw_setup_epbuf(&buf_pair->tx, mac,
@@ -287,6 +291,25 @@ static int fjes_hw_setup(struct fjes_hw *hw)
 	fjes_hw_init_command_registers(hw, &param);
 
 	return 0;
+
+free_epbuf:
+	for (epidx = 0; epidx < hw->max_epid ; epidx++) {
+		if (epidx == hw->my_epid)
+			continue;
+		fjes_hw_free_epbuf(&hw->ep_shm_info[epidx].tx);
+		fjes_hw_free_epbuf(&hw->ep_shm_info[epidx].rx);
+	}
+	fjes_hw_free_shared_status_region(hw);
+free_res_buf:
+	kfree(hw->hw_info.res_buf);
+	hw->hw_info.res_buf = NULL;
+free_req_buf:
+	kfree(hw->hw_info.req_buf);
+	hw->hw_info.req_buf = NULL;
+free_ep_info:
+	kfree(hw->ep_shm_info);
+	hw->ep_shm_info = NULL;
+	return result;
 }
 
 static void fjes_hw_cleanup(struct fjes_hw *hw)
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index bf03db40d4f0..fb1e28a29892 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -474,6 +474,10 @@ ppp_async_ioctl(struct ppp_channel *chan, unsigned int cmd, unsigned long arg)
 	case PPPIOCSMRU:
 		if (get_user(val, p))
 			break;
+		if (val > U16_MAX) {
+			err = -EINVAL;
+			break;
+		}
 		if (val < PPP_MRU)
 			val = PPP_MRU;
 		ap->mru = val;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 331d74f9281b..2b012d7165cd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2727,10 +2727,11 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 {
 	vq_callback_t **callbacks;
 	struct virtqueue **vqs;
-	int ret = -ENOMEM;
-	int i, total_vqs;
 	const char **names;
+	int ret = -ENOMEM;
+	int total_vqs;
 	bool *ctx;
+	u16 i;
 
 	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
 	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by
@@ -2767,8 +2768,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		callbacks[rxq2vq(i)] = skb_recv_done;
 		callbacks[txq2vq(i)] = skb_xmit_done;
-		sprintf(vi->rq[i].name, "input.%d", i);
-		sprintf(vi->sq[i].name, "output.%d", i);
+		sprintf(vi->rq[i].name, "input.%u", i);
+		sprintf(vi->sq[i].name, "output.%u", i);
 		names[rxq2vq(i)] = vi->rq[i].name;
 		names[txq2vq(i)] = vi->sq[i].name;
 		if (ctx)
diff --git a/drivers/net/wan/lmc/lmc_proto.c b/drivers/net/wan/lmc/lmc_proto.c
index f600075e84a2..7ae39a2b6340 100644
--- a/drivers/net/wan/lmc/lmc_proto.c
+++ b/drivers/net/wan/lmc/lmc_proto.c
@@ -103,17 +103,13 @@ __be16 lmc_proto_type(lmc_softc_t *sc, struct sk_buff *skb) /*FOLD00*/
     switch(sc->if_type){
     case LMC_PPP:
 	    return hdlc_type_trans(skb, sc->lmc_device);
-	    break;
     case LMC_NET:
         return htons(ETH_P_802_2);
-        break;
     case LMC_RAW: /* Packet type for skbuff kind of useless */
         return htons(ETH_P_802_2);
-        break;
     default:
         printk(KERN_WARNING "%s: No protocol set for this interface, assuming 802.2 (which is wrong!!)\n", sc->name);
         return htons(ETH_P_802_2);
-        break;
     }
     lmc_trace(sc->lmc_device, "lmc_proto_tye out");
 
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 979ac31a77a0..527bca8f7deb 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -647,9 +647,10 @@ void ath9k_htc_txstatus(struct ath9k_htc_priv *priv, void *wmi_event)
 	struct ath9k_htc_tx_event *tx_pend;
 	int i;
 
-	for (i = 0; i < txs->cnt; i++) {
-		WARN_ON(txs->cnt > HTC_MAX_TX_STATUS);
+	if (WARN_ON_ONCE(txs->cnt > HTC_MAX_TX_STATUS))
+		return;
 
+	for (i = 0; i < txs->cnt; i++) {
 		__txs = &txs->txstatus[i];
 
 		skb = ath9k_htc_tx_get_packet(priv, __txs);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 780dab276829..9c5a7ea1479e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6366,6 +6366,18 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192eu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x818c, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* D-Link DWA-131 rev C1 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3312, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* TP-Link TL-WN8200ND V2 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0126, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Mercusys MW300UM */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0100, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Mercusys MW300UH */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0104, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
 #endif
 { }
 };
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
index 5cf29f5a4b54..e6ac496e898e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
@@ -72,7 +72,7 @@ u32 rtl8723e_phy_query_rf_reg(struct ieee80211_hw *hw,
 							    rfpath, regaddr);
 	}
 
-	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
@@ -104,7 +104,7 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 			original_value = rtl8723_phy_rf_serial_read(hw,
 								    rfpath,
 								    regaddr);
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
@@ -113,7 +113,7 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 		rtl8723_phy_rf_serial_write(hw, rfpath, regaddr, data);
 	} else {
 		if (bitmask != RFREG_OFFSET_MASK) {
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
index 1263b12db5dc..bbbbf61d7bcf 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
@@ -64,7 +64,7 @@ u32 rtl8723be_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	spin_lock_irqsave(&rtlpriv->locks.rf_lock, flags);
 
 	original_value = rtl8723_phy_rf_serial_read(hw, rfpath, regaddr);
-	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
@@ -92,7 +92,7 @@ void rtl8723be_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path path,
 	if (bitmask != RFREG_OFFSET_MASK) {
 			original_value = rtl8723_phy_rf_serial_read(hw, path,
 								    regaddr);
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data = ((original_value & (~bitmask)) |
 				(data << bitshift));
 		}
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index f2181170386d..92e32e17aaa7 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -97,13 +97,12 @@ module_param_named(hash_cache_size, xenvif_hash_cache_size, uint, 0644);
 MODULE_PARM_DESC(hash_cache_size, "Number of flows in the hash cache");
 
 static void xenvif_idx_release(struct xenvif_queue *queue, u16 pending_idx,
-			       u8 status);
+			       s8 status);
 
 static void make_tx_response(struct xenvif_queue *queue,
-			     struct xen_netif_tx_request *txp,
+			     const struct xen_netif_tx_request *txp,
 			     unsigned int extra_count,
-			     s8       st);
-static void push_tx_responses(struct xenvif_queue *queue);
+			     s8 status);
 
 static void xenvif_idx_unmap(struct xenvif_queue *queue, u16 pending_idx);
 
@@ -201,13 +200,9 @@ static void xenvif_tx_err(struct xenvif_queue *queue,
 			  unsigned int extra_count, RING_IDX end)
 {
 	RING_IDX cons = queue->tx.req_cons;
-	unsigned long flags;
 
 	do {
-		spin_lock_irqsave(&queue->response_lock, flags);
 		make_tx_response(queue, txp, extra_count, XEN_NETIF_RSP_ERROR);
-		push_tx_responses(queue);
-		spin_unlock_irqrestore(&queue->response_lock, flags);
 		if (cons == end)
 			break;
 		RING_COPY_REQUEST(&queue->tx, cons++, txp);
@@ -458,12 +453,7 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 	for (shinfo->nr_frags = 0; nr_slots > 0 && shinfo->nr_frags < MAX_SKB_FRAGS;
 	     nr_slots--) {
 		if (unlikely(!txp->size)) {
-			unsigned long flags;
-
-			spin_lock_irqsave(&queue->response_lock, flags);
 			make_tx_response(queue, txp, 0, XEN_NETIF_RSP_OKAY);
-			push_tx_responses(queue);
-			spin_unlock_irqrestore(&queue->response_lock, flags);
 			++txp;
 			continue;
 		}
@@ -489,14 +479,8 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 
 		for (shinfo->nr_frags = 0; shinfo->nr_frags < nr_slots; ++txp) {
 			if (unlikely(!txp->size)) {
-				unsigned long flags;
-
-				spin_lock_irqsave(&queue->response_lock, flags);
 				make_tx_response(queue, txp, 0,
 						 XEN_NETIF_RSP_OKAY);
-				push_tx_responses(queue);
-				spin_unlock_irqrestore(&queue->response_lock,
-						       flags);
 				continue;
 			}
 
@@ -990,7 +974,6 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 					 (ret == 0) ?
 					 XEN_NETIF_RSP_OKAY :
 					 XEN_NETIF_RSP_ERROR);
-			push_tx_responses(queue);
 			continue;
 		}
 
@@ -1002,7 +985,6 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 
 			make_tx_response(queue, &txreq, extra_count,
 					 XEN_NETIF_RSP_OKAY);
-			push_tx_responses(queue);
 			continue;
 		}
 
@@ -1428,8 +1410,35 @@ int xenvif_tx_action(struct xenvif_queue *queue, int budget)
 	return work_done;
 }
 
+static void _make_tx_response(struct xenvif_queue *queue,
+			     const struct xen_netif_tx_request *txp,
+			     unsigned int extra_count,
+			     s8 status)
+{
+	RING_IDX i = queue->tx.rsp_prod_pvt;
+	struct xen_netif_tx_response *resp;
+
+	resp = RING_GET_RESPONSE(&queue->tx, i);
+	resp->id     = txp->id;
+	resp->status = status;
+
+	while (extra_count-- != 0)
+		RING_GET_RESPONSE(&queue->tx, ++i)->status = XEN_NETIF_RSP_NULL;
+
+	queue->tx.rsp_prod_pvt = ++i;
+}
+
+static void push_tx_responses(struct xenvif_queue *queue)
+{
+	int notify;
+
+	RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(&queue->tx, notify);
+	if (notify)
+		notify_remote_via_irq(queue->tx_irq);
+}
+
 static void xenvif_idx_release(struct xenvif_queue *queue, u16 pending_idx,
-			       u8 status)
+			       s8 status)
 {
 	struct pending_tx_info *pending_tx_info;
 	pending_ring_idx_t index;
@@ -1439,8 +1448,8 @@ static void xenvif_idx_release(struct xenvif_queue *queue, u16 pending_idx,
 
 	spin_lock_irqsave(&queue->response_lock, flags);
 
-	make_tx_response(queue, &pending_tx_info->req,
-			 pending_tx_info->extra_count, status);
+	_make_tx_response(queue, &pending_tx_info->req,
+			  pending_tx_info->extra_count, status);
 
 	/* Release the pending index before pusing the Tx response so
 	 * its available before a new Tx request is pushed by the
@@ -1454,32 +1463,19 @@ static void xenvif_idx_release(struct xenvif_queue *queue, u16 pending_idx,
 	spin_unlock_irqrestore(&queue->response_lock, flags);
 }
 
-
 static void make_tx_response(struct xenvif_queue *queue,
-			     struct xen_netif_tx_request *txp,
+			     const struct xen_netif_tx_request *txp,
 			     unsigned int extra_count,
-			     s8       st)
+			     s8 status)
 {
-	RING_IDX i = queue->tx.rsp_prod_pvt;
-	struct xen_netif_tx_response *resp;
-
-	resp = RING_GET_RESPONSE(&queue->tx, i);
-	resp->id     = txp->id;
-	resp->status = st;
-
-	while (extra_count-- != 0)
-		RING_GET_RESPONSE(&queue->tx, ++i)->status = XEN_NETIF_RSP_NULL;
+	unsigned long flags;
 
-	queue->tx.rsp_prod_pvt = ++i;
-}
+	spin_lock_irqsave(&queue->response_lock, flags);
 
-static void push_tx_responses(struct xenvif_queue *queue)
-{
-	int notify;
+	_make_tx_response(queue, txp, extra_count, status);
+	push_tx_responses(queue);
 
-	RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(&queue->tx, notify);
-	if (notify)
-		notify_remote_via_irq(queue->tx_irq);
+	spin_unlock_irqrestore(&queue->response_lock, flags);
 }
 
 static void xenvif_idx_unmap(struct xenvif_queue *queue, u16 pending_idx)
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 066e9e00de11..0d5be37660aa 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -605,14 +605,20 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
 		if (status & MSI_STATUS){
 			unsigned long imsi_status;
 
+			/*
+			 * The interrupt status can be cleared even if the
+			 * MSI status remains pending. As such, given the
+			 * edge-triggered interrupt type, its status should
+			 * be cleared before being dispatched to the
+			 * handler of the underlying device.
+			 */
+			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
 			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
 				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
 					virq = irq_find_mapping(port->inner_domain, bit);
 					generic_handle_irq(virq);
 				}
 			}
-			/* Clear MSI interrupt status */
-			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
 		}
 	}
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eb507751c115..99a8a24ea79d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -611,10 +611,13 @@ static void quirk_amd_dwc_class(struct pci_dev *pdev)
 {
 	u32 class = pdev->class;
 
-	/* Use "USB Device (not host controller)" class */
-	pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
-	pci_info(pdev, "PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
-		 class, pdev->class);
+	if (class != PCI_CLASS_SERIAL_USB_DEVICE) {
+		/* Use "USB Device (not host controller)" class */
+		pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
+		pci_info(pdev,
+			"PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
+			class, pdev->class);
+	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
 		quirk_amd_dwc_class);
@@ -3532,6 +3535,19 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
 			       PCI_CLASS_DISPLAY_VGA, 8, quirk_no_pm_reset);
 
+/*
+ * Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a reset
+ * (i.e., they advertise NoSoftRst-). However, this transition does not have
+ * any effect on the device: It continues to be operational and network ports
+ * remain up. Advertising this support makes it seem as if a PM reset is viable
+ * for these devices. Mark it as unavailable to skip it when testing reset
+ * methods.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcb84, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf6c, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf70, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf80, quirk_no_pm_reset);
+
 /*
  * Thunderbolt controllers with broken MSI hotplug signaling:
  * Entire 1st generation (Light Ridge, Eagle Ridge, Light Peak) and part
diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index fe909fd8144f..ae94e1e66bcc 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -64,7 +64,7 @@ static int omap_usb_set_vbus(struct usb_otg *otg, bool enabled)
 {
 	struct omap_usb *phy = phy_to_omapusb(otg->usb_phy);
 
-	if (!phy->comparator)
+	if (!phy->comparator || !phy->comparator->set_vbus)
 		return -ENODEV;
 
 	return phy->comparator->set_vbus(phy->comparator, enabled);
@@ -74,7 +74,7 @@ static int omap_usb_start_srp(struct usb_otg *otg)
 {
 	struct omap_usb *phy = phy_to_omapusb(otg->usb_phy);
 
-	if (!phy->comparator)
+	if (!phy->comparator || !phy->comparator->start_srp)
 		return -ENODEV;
 
 	return phy->comparator->start_srp(phy->comparator);
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 43d8ed577e70..d8cee80e8df8 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -160,13 +160,13 @@ static int vendor_resource_matches(struct pnp_dev *dev,
 static void pnpacpi_parse_allocated_vendor(struct pnp_dev *dev,
 				    struct acpi_resource_vendor_typed *vendor)
 {
-	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid, 16)) {
-		u64 start, length;
+	struct { u64 start, length; } range;
 
-		memcpy(&start, vendor->byte_data, sizeof(start));
-		memcpy(&length, vendor->byte_data + 8, sizeof(length));
-
-		pnp_add_mem_resource(dev, start, start + length - 1, 0);
+	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid,
+				    sizeof(range))) {
+		memcpy(&range, vendor->byte_data, sizeof(range));
+		pnp_add_mem_resource(dev, range.start, range.start +
+				     range.length - 1, 0);
 	}
 }
 
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 664f957012cd..aab990339051 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -381,6 +381,7 @@ static void virtio_rpmsg_release_device(struct device *dev)
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
 
+	kfree(rpdev->driver_override);
 	kfree(vch);
 }
 
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index c49986eba47b..1e087a206f48 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -330,17 +330,16 @@ static void fcoe_ctlr_announce(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *sel;
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 
 	kfree_skb(fip->flogi_req);
 	fip->flogi_req = NULL;
 	list_for_each_entry(fcf, &fip->fcfs, list)
 		fcf->flogi_sent = 0;
 
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 	sel = fip->sel_fcf;
 
 	if (sel && ether_addr_equal(sel->fcf_mac, fip->dest_addr))
@@ -710,7 +709,6 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 {
 	struct fc_frame *fp;
 	struct fc_frame_header *fh;
-	unsigned long flags;
 	u16 old_xid;
 	u8 op;
 	u8 mac[ETH_ALEN];
@@ -744,11 +742,11 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 		op = FIP_DT_FLOGI;
 		if (fip->mode == FIP_MODE_VN2VN)
 			break;
-		spin_lock_irqsave(&fip->ctlr_lock, flags);
+		spin_lock_bh(&fip->ctlr_lock);
 		kfree_skb(fip->flogi_req);
 		fip->flogi_req = skb;
 		fip->flogi_req_send = 1;
-		spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+		spin_unlock_bh(&fip->ctlr_lock);
 		schedule_work(&fip->timer_work);
 		return -EINPROGRESS;
 	case ELS_FDISC:
@@ -1725,11 +1723,10 @@ static int fcoe_ctlr_flogi_send_locked(struct fcoe_ctlr *fip)
 static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 	int error;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 	LIBFCOE_FIP_DBG(fip, "re-sending FLOGI - reselect\n");
 	fcf = fcoe_ctlr_select(fip);
 	if (!fcf || fcf->flogi_sent) {
@@ -1740,7 +1737,7 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 		fcoe_ctlr_solicit(fip, NULL);
 		error = fcoe_ctlr_flogi_send_locked(fip);
 	}
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 	mutex_unlock(&fip->ctlr_mutex);
 	return error;
 }
@@ -1757,9 +1754,8 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 	fcf = fip->sel_fcf;
 	if (!fcf || !fip->flogi_req_send)
 		goto unlock;
@@ -1786,7 +1782,7 @@ static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 	} else /* XXX */
 		LIBFCOE_FIP_DBG(fip, "No FCF selected - defer send\n");
 unlock:
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 }
 
 /**
diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 2f151708b59a..13ecf554762e 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -3398,7 +3398,7 @@ static enum sci_status isci_io_request_build(struct isci_host *ihost,
 		return SCI_FAILURE;
 	}
 
-	return SCI_SUCCESS;
+	return status;
 }
 
 static struct isci_request *isci_request_from_tag(struct isci_host *ihost, u16 tag)
diff --git a/drivers/scsi/libfc/fc_fcp.c b/drivers/scsi/libfc/fc_fcp.c
index 4fae253d4f3d..faea7333c7e8 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -282,6 +282,11 @@ static int fc_fcp_send_abort(struct fc_fcp_pkt *fsp)
 	if (!fsp->seq_ptr)
 		return -EINVAL;
 
+	if (fsp->state & FC_SRB_ABORT_PENDING) {
+		FC_FCP_DBG(fsp, "abort already pending\n");
+		return -EBUSY;
+	}
+
 	per_cpu_ptr(fsp->lp->stats, get_cpu())->FcpPktAborts++;
 	put_cpu();
 
@@ -1692,7 +1697,7 @@ static void fc_fcp_rec_error(struct fc_fcp_pkt *fsp, struct fc_frame *fp)
 		if (fsp->recov_retry++ < FC_MAX_RECOV_RETRY)
 			fc_fcp_rec(fsp);
 		else
-			fc_fcp_recovery(fsp, FC_ERROR);
+			fc_fcp_recovery(fsp, FC_TIMED_OUT);
 		break;
 	}
 	fc_fcp_unlock_pkt(fsp);
@@ -1710,11 +1715,12 @@ static void fc_fcp_recovery(struct fc_fcp_pkt *fsp, u8 code)
 	fsp->status_code = code;
 	fsp->cdb_status = 0;
 	fsp->io_status = 0;
-	/*
-	 * if this fails then we let the scsi command timer fire and
-	 * scsi-ml escalate.
-	 */
-	fc_fcp_send_abort(fsp);
+	if (!fsp->cmd)
+		/*
+		 * Only abort non-scsi commands; otherwise let the
+		 * scsi command timer fire and scsi-ml escalate.
+		 */
+		fc_fcp_send_abort(fsp);
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 706aca3f7c25..53b661793268 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -32,6 +32,7 @@
 struct lpfc_sli2_slim;
 
 #define ELX_MODEL_NAME_SIZE	80
+#define ELX_FW_NAME_SIZE	84
 
 #define LPFC_PCI_DEV_LP		0x1
 #define LPFC_PCI_DEV_OC		0x2
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index c6caacaa3e7a..7db4e893e10e 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -11428,7 +11428,7 @@ lpfc_write_firmware(const struct firmware *fw, void *context)
 int
 lpfc_sli4_request_firmware_update(struct lpfc_hba *phba, uint8_t fw_upgrade)
 {
-	uint8_t file_name[ELX_MODEL_NAME_SIZE];
+	char file_name[ELX_FW_NAME_SIZE] = {0};
 	int ret;
 	const struct firmware *fw;
 
@@ -11437,7 +11437,7 @@ lpfc_sli4_request_firmware_update(struct lpfc_hba *phba, uint8_t fw_upgrade)
 	    LPFC_SLI_INTF_IF_TYPE_2)
 		return -EPERM;
 
-	snprintf(file_name, ELX_MODEL_NAME_SIZE, "%s.grp", phba->ModelName);
+	scnprintf(file_name, sizeof(file_name), "%s.grp", phba->ModelName);
 
 	if (fw_upgrade == INT_FW_UPGRADE) {
 		ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 967d94844b30..58765a62fc15 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -173,10 +173,8 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	int scr;
 	u8 cdm = 0;
 	u32 speed;
-	u8 bits_per_word;
 
 	/* Start with the generic configuration for this device. */
-	bits_per_word = spi->bits_per_word;
 	speed = spi->max_speed_hz;
 
 	/*
@@ -184,9 +182,6 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	 * the transfer to overwrite the generic configuration with zeros.
 	 */
 	if (t) {
-		if (t->bits_per_word)
-			bits_per_word = t->bits_per_word;
-
 		if (t->speed_hz)
 			speed = min(t->speed_hz, spi->max_speed_hz);
 	}
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 14df89510396..d384c09d681a 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -638,7 +638,7 @@ static void ad5933_work(struct work_struct *work)
 		struct ad5933_state, work.work);
 	struct iio_dev *indio_dev = i2c_get_clientdata(st->client);
 	__be16 buf[2];
-	int val[2];
+	u16 val[2];
 	unsigned char status;
 	int ret;
 
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index c1ab0dbda8a9..e68dbd13110b 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -235,6 +235,10 @@
 #define MAX310x_REV_MASK		(0xf8)
 #define MAX310X_WRITE_BIT		0x80
 
+/* Crystal-related definitions */
+#define MAX310X_XTAL_WAIT_RETRIES	20 /* Number of retries */
+#define MAX310X_XTAL_WAIT_DELAY_MS	10 /* Delay between retries */
+
 /* MAX3107 specific */
 #define MAX3107_REV_ID			(0xa0)
 
@@ -600,12 +604,19 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 
 	/* Wait for crystal */
 	if (xtal) {
-		unsigned int val;
-		msleep(10);
-		regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &val);
-		if (!(val & MAX310X_STS_CLKREADY_BIT)) {
+		bool stable = false;
+		unsigned int try = 0, val = 0;
+
+		do {
+			msleep(MAX310X_XTAL_WAIT_DELAY_MS);
+			regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &val);
+
+			if (val & MAX310X_STS_CLKREADY_BIT)
+				stable = true;
+		} while (!stable && (++try < MAX310X_XTAL_WAIT_RETRIES));
+
+		if (!stable)
 			dev_warn(dev, "clock is not stable yet\n");
-		}
 	}
 
 	return (int)bestfreq;
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index c65f9194abb0..800cb94e4b91 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -24,6 +24,7 @@
 #include <linux/tty_flip.h>
 #include <linux/spi/spi.h>
 #include <linux/uaccess.h>
+#include <linux/units.h>
 #include <uapi/linux/sched/types.h>
 
 #define SC16IS7XX_NAME			"sc16is7xx"
@@ -1406,9 +1407,12 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
 
 	/* Setup SPI bus */
 	spi->bits_per_word	= 8;
-	/* only supports mode 0 on SC16IS762 */
+	/* For all variants, only mode 0 is supported */
+	if ((spi->mode & SPI_MODE_X_MASK) != SPI_MODE_0)
+		return dev_err_probe(&spi->dev, -EINVAL, "Unsupported SPI mode\n");
+
 	spi->mode		= spi->mode ? : SPI_MODE_0;
-	spi->max_speed_hz	= spi->max_speed_hz ? : 15000000;
+	spi->max_speed_hz	= spi->max_speed_hz ? : 4 * HZ_PER_MHZ;
 	ret = spi_setup(spi);
 	if (ret)
 		return ret;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 898df2e43945..774cefe4e1f0 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -43,8 +43,8 @@
 #define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
 #define USB_PRODUCT_TUSB8041_USB3		0x8140
 #define USB_PRODUCT_TUSB8041_USB2		0x8142
-#define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
-#define HUB_QUIRK_DISABLE_AUTOSUSPEND		0x02
+#define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	BIT(0)
+#define HUB_QUIRK_DISABLE_AUTOSUSPEND		BIT(1)
 
 #define USB_TP_TRANSMISSION_DELAY	40	/* ns */
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
@@ -2331,17 +2331,25 @@ static int usb_enumerate_device_otg(struct usb_device *udev)
 			}
 		} else if (desc->bLength == sizeof
 				(struct usb_otg_descriptor)) {
-			/* Set a_alt_hnp_support for legacy otg device */
-			err = usb_control_msg(udev,
-				usb_sndctrlpipe(udev, 0),
-				USB_REQ_SET_FEATURE, 0,
-				USB_DEVICE_A_ALT_HNP_SUPPORT,
-				0, NULL, 0,
-				USB_CTRL_SET_TIMEOUT);
-			if (err < 0)
-				dev_err(&udev->dev,
-					"set a_alt_hnp_support failed: %d\n",
-					err);
+			/*
+			 * We are operating on a legacy OTP device
+			 * These should be told that they are operating
+			 * on the wrong port if we have another port that does
+			 * support HNP
+			 */
+			if (bus->otg_port != 0) {
+				/* Set a_alt_hnp_support for legacy otg device */
+				err = usb_control_msg(udev,
+					usb_sndctrlpipe(udev, 0),
+					USB_REQ_SET_FEATURE, 0,
+					USB_DEVICE_A_ALT_HNP_SUPPORT,
+					0, NULL, 0,
+					USB_CTRL_SET_TIMEOUT);
+				if (err < 0)
+					dev_err(&udev->dev,
+						"set a_alt_hnp_support failed: %d\n",
+						err);
+			}
 		}
 	}
 #endif
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 4f221ca7aad1..9f96c1c701eb 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -574,21 +574,37 @@ static int start_transfer(struct fsg_dev *fsg, struct usb_ep *ep,
 
 static bool start_in_transfer(struct fsg_common *common, struct fsg_buffhd *bh)
 {
+	int rc;
+
 	if (!fsg_is_set(common))
 		return false;
 	bh->state = BUF_STATE_SENDING;
-	if (start_transfer(common->fsg, common->fsg->bulk_in, bh->inreq))
+	rc = start_transfer(common->fsg, common->fsg->bulk_in, bh->inreq);
+	if (rc) {
 		bh->state = BUF_STATE_EMPTY;
+		if (rc == -ESHUTDOWN) {
+			common->running = 0;
+			return false;
+		}
+	}
 	return true;
 }
 
 static bool start_out_transfer(struct fsg_common *common, struct fsg_buffhd *bh)
 {
+	int rc;
+
 	if (!fsg_is_set(common))
 		return false;
 	bh->state = BUF_STATE_RECEIVING;
-	if (start_transfer(common->fsg, common->fsg->bulk_out, bh->outreq))
+	rc = start_transfer(common->fsg, common->fsg->bulk_out, bh->outreq);
+	if (rc) {
 		bh->state = BUF_STATE_FULL;
+		if (rc == -ESHUTDOWN) {
+			common->running = 0;
+			return false;
+		}
+	}
 	return true;
 }
 
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index c203b2e7b838..b58ca66dc3ae 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -147,6 +147,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0x85F8) }, /* Virtenio Preon32 */
 	{ USB_DEVICE(0x10C4, 0x8664) }, /* AC-Services CAN-IF */
 	{ USB_DEVICE(0x10C4, 0x8665) }, /* AC-Services OBD-IF */
+	{ USB_DEVICE(0x10C4, 0x87ED) }, /* IMST USB-Stick for Smart Meter */
 	{ USB_DEVICE(0x10C4, 0x8856) },	/* CEL EM357 ZigBee USB Stick - LR */
 	{ USB_DEVICE(0x10C4, 0x8857) },	/* CEL EM357 ZigBee USB Stick */
 	{ USB_DEVICE(0x10C4, 0x88A4) }, /* MMB Networks ZigBee USB Device */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index c0e385b3f4ae..5014f45c7c6a 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2269,6 +2269,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0111, 0xff) },			/* Fibocom FM160 (MBIM mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a3, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index b7ba15d0ed6c..5570c50d005d 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -184,6 +184,8 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x413c, 0x81d0)},   /* Dell Wireless 5819 */
 	{DEVICE_SWI(0x413c, 0x81d1)},   /* Dell Wireless 5818 */
 	{DEVICE_SWI(0x413c, 0x81d2)},   /* Dell Wireless 5818 */
+	{DEVICE_SWI(0x413c, 0x8217)},	/* Dell Wireless DW5826e */
+	{DEVICE_SWI(0x413c, 0x8218)},	/* Dell Wireless DW5826e QDL */
 
 	/* Huawei devices */
 	{DEVICE_HWI(0x03f0, 0x581d)},	/* HP lt4112 LTE/HSPA+ Gobi 4G Modem (Huawei me906e) */
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 7a58f629155d..3321333a1186 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2490,12 +2490,11 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
 /* Create a new message. */
 struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
 {
-	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
+	/* Make sure all padding within the structure is initialized. */
+	struct vhost_msg_node *node = kzalloc(sizeof(*node), GFP_KERNEL);
 	if (!node)
 		return NULL;
 
-	/* Make sure all padding within the structure is initialized. */
-	memset(&node->msg, 0, sizeof node->msg);
 	node->vq = vq;
 	node->msg.type = type;
 	return node;
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 2c7f6211c360..b12caa1acf53 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -37,7 +37,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 	const struct afs_addr_list *alist;
 	struct afs_server *server = NULL;
 	unsigned int i;
-	int seq = 0, diff;
+	int seq = 1, diff;
 
 	rcu_read_lock();
 
@@ -45,6 +45,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 		if (server)
 			afs_put_server(net, server);
 		server = NULL;
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_addr_lock, &seq);
 
 		if (srx->transport.family == AF_INET6) {
@@ -100,7 +101,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 {
 	struct afs_server *server = NULL;
 	struct rb_node *p;
-	int diff, seq = 0;
+	int diff, seq = 1;
 
 	_enter("%pU", uuid);
 
@@ -112,7 +113,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 		if (server)
 			afs_put_server(net, server);
 		server = NULL;
-
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_lock, &seq);
 
 		p = net->fs_servers.rb_node;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 902ab00bfd7a..51f21cd61422 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1899,7 +1899,8 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 	u64 bytes_left, end;
 	u64 aligned_start = ALIGN(start, 1 << 9);
 
-	if (WARN_ON(start != aligned_start)) {
+	/* Adjust the range to be aligned to 512B sectors if necessary. */
+	if (start != aligned_start) {
 		len -= aligned_start - start;
 		len = round_down(len, 1 << 9);
 		start = aligned_start;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c76277ccf03b..a4c0fc19c5e8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3037,6 +3037,10 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 				kfree(range);
 				goto out;
 			}
+			if (range->flags & ~BTRFS_DEFRAG_RANGE_FLAGS_SUPP) {
+				ret = -EOPNOTSUPP;
+				goto out;
+			}
 			/* compression requires us to start the IO */
 			if ((range->flags & BTRFS_DEFRAG_RANGE_COMPRESS)) {
 				range->flags |= BTRFS_DEFRAG_RANGE_START_IO;
@@ -5339,6 +5343,11 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 		goto out;
 	}
 
+	if (sa->create && is_fstree(sa->qgroupid)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index cb584c044f8a..0c86409a316e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6842,7 +6842,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	}
 
 	if (arg->flags & ~BTRFS_SEND_FLAG_MASK) {
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index fcfba2af5f98..729a67700a4f 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4216,12 +4216,14 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 			       struct inode *dir,
 			       int mds, int drop, int unless)
 {
-	struct dentry *parent = NULL;
 	struct ceph_mds_request_release *rel = *p;
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	int force = 0;
 	int ret;
 
+	/* This shouldn't happen */
+	BUG_ON(!dir);
+
 	/*
 	 * force an record for the directory caps if we have a dentry lease.
 	 * this is racy (can't take i_ceph_lock and d_lock together), but it
@@ -4231,14 +4233,9 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 	spin_lock(&dentry->d_lock);
 	if (di->lease_session && di->lease_session->s_mds == mds)
 		force = 1;
-	if (!dir) {
-		parent = dget(dentry->d_parent);
-		dir = d_inode(parent);
-	}
 	spin_unlock(&dentry->d_lock);
 
 	ret = ceph_encode_inode_release(p, dir, mds, drop, unless, force);
-	dput(parent);
 
 	spin_lock(&dentry->d_lock);
 	if (ret && di->lease_session && di->lease_session->s_mds == mds) {
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index c6fe9914440e..368128c30e60 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1370,8 +1370,7 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	if (!f.file)
 		goto out;
 
-	/* RED-PEN how should LSM module know it's handling 32bit? */
-	error = security_file_ioctl(f.file, cmd, arg);
+	error = security_file_ioctl_compat(f.file, cmd, arg);
 	if (error)
 		goto out_fput;
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 1897833a4668..4d96eb591f5d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -727,12 +727,12 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	if (unlikely(ret < 0)) {
 		spin_lock(&dentry->d_lock);
-		if (dentry->d_lockref.count > 1) {
-			dentry->d_lockref.count--;
+		if (WARN_ON_ONCE(dentry->d_lockref.count <= 0)) {
 			spin_unlock(&dentry->d_lock);
 			return true;
 		}
-		return false;
+		dentry->d_lockref.count--;
+		goto locked;
 	}
 
 	/*
@@ -783,6 +783,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * else could have killed it and marked it dead. Either way, we
 	 * don't need to do anything else.
 	 */
+locked:
 	if (dentry->d_lockref.count) {
 		spin_unlock(&dentry->d_lock);
 		return true;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 8875fac9f958..df390979058f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5192,11 +5192,16 @@ __acquires(bitlock)
 static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
 					   ext4_group_t grp)
 {
-	if (grp < ext4_get_groups_count(sb))
-		return EXT4_CLUSTERS_PER_GROUP(sb) - 1;
-	return (ext4_blocks_count(EXT4_SB(sb)->s_es) -
-		ext4_group_first_block_no(sb, grp) - 1) >>
-					EXT4_CLUSTER_BITS(sb);
+	unsigned long nr_clusters_in_group;
+
+	if (grp < (ext4_get_groups_count(sb) - 1))
+		nr_clusters_in_group = EXT4_CLUSTERS_PER_GROUP(sb);
+	else
+		nr_clusters_in_group = (ext4_blocks_count(EXT4_SB(sb)->s_es) -
+					ext4_group_first_block_no(sb, grp))
+				       >> EXT4_CLUSTER_BITS(sb);
+
+	return nr_clusters_in_group - 1;
 }
 
 static bool ext4_trim_interrupted(void)
@@ -5208,13 +5213,15 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
 		ext4_grpblk_t max, ext4_grpblk_t minblocks)
 {
-	ext4_grpblk_t next, count, free_count;
+	ext4_grpblk_t next, count, free_count, last, origin_start;
 	bool set_trimmed = false;
 	void *bitmap;
 
+	last = ext4_last_grp_cluster(sb, e4b->bd_group);
 	bitmap = e4b->bd_bitmap;
-	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
+	if (start == 0 && max >= last)
 		set_trimmed = true;
+	origin_start = start;
 	start = max(e4b->bd_info->bb_first_free, start);
 	count = 0;
 	free_count = 0;
@@ -5223,7 +5230,10 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 		start = mb_find_next_zero_bit(bitmap, max + 1, start);
 		if (start > max)
 			break;
-		next = mb_find_next_bit(bitmap, max + 1, start);
+
+		next = mb_find_next_bit(bitmap, last + 1, start);
+		if (origin_start == 0 && next >= last)
+			set_trimmed = true;
 
 		if ((next - start) >= minblocks) {
 			int ret = ext4_trim_extent(sb, start, next - start, e4b);
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 287631bb09e7..2c368d67a33a 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -616,6 +616,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		goto out;
 	o_end = o_start + len;
 
+	*moved_len = 0;
 	while (o_start < o_end) {
 		struct ext4_extent *ex;
 		ext4_lblk_t cur_blk, next_blk;
@@ -671,7 +672,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		 */
 		ext4_double_up_write_data_sem(orig_inode, donor_inode);
 		/* Swap original branches with new branches */
-		move_extent_per_page(o_filp, donor_inode,
+		*moved_len += move_extent_per_page(o_filp, donor_inode,
 				     orig_page_index, donor_page_index,
 				     offset_in_page, cur_len,
 				     unwritten, &ret);
@@ -681,9 +682,6 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		o_start += cur_len;
 		d_start += cur_len;
 	}
-	*moved_len = o_start - orig_blk;
-	if (*moved_len > len)
-		*moved_len = len;
 
 out:
 	if (*moved_len) {
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index f4b3d450dead..97af09d6e7e6 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -227,17 +227,24 @@ struct ext4_new_flex_group_data {
 						   in the flex group */
 	__u16 *bg_flags;			/* block group flags of groups
 						   in @groups */
+	ext4_group_t resize_bg;			/* number of allocated
+						   new_group_data */
 	ext4_group_t count;			/* number of groups in @groups
 						 */
 };
 
+/*
+ * Avoiding memory allocation failures due to too many groups added each time.
+ */
+#define MAX_RESIZE_BG				16384
+
 /*
  * alloc_flex_gd() allocates a ext4_new_flex_group_data with size of
  * @flexbg_size.
  *
  * Returns NULL on failure otherwise address of the allocated structure.
  */
-static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned long flexbg_size)
+static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
 {
 	struct ext4_new_flex_group_data *flex_gd;
 
@@ -245,17 +252,18 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned long flexbg_size)
 	if (flex_gd == NULL)
 		goto out3;
 
-	if (flexbg_size >= UINT_MAX / sizeof(struct ext4_new_group_data))
-		goto out2;
-	flex_gd->count = flexbg_size;
+	if (unlikely(flexbg_size > MAX_RESIZE_BG))
+		flex_gd->resize_bg = MAX_RESIZE_BG;
+	else
+		flex_gd->resize_bg = flexbg_size;
 
-	flex_gd->groups = kmalloc_array(flexbg_size,
+	flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
 					sizeof(struct ext4_new_group_data),
 					GFP_NOFS);
 	if (flex_gd->groups == NULL)
 		goto out2;
 
-	flex_gd->bg_flags = kmalloc_array(flexbg_size, sizeof(__u16),
+	flex_gd->bg_flags = kmalloc_array(flex_gd->resize_bg, sizeof(__u16),
 					  GFP_NOFS);
 	if (flex_gd->bg_flags == NULL)
 		goto out1;
@@ -292,7 +300,7 @@ static void free_flex_gd(struct ext4_new_flex_group_data *flex_gd)
  */
 static int ext4_alloc_group_tables(struct super_block *sb,
 				struct ext4_new_flex_group_data *flex_gd,
-				int flexbg_size)
+				unsigned int flexbg_size)
 {
 	struct ext4_new_group_data *group_data = flex_gd->groups;
 	ext4_fsblk_t start_blk;
@@ -393,12 +401,12 @@ static int ext4_alloc_group_tables(struct super_block *sb,
 		group = group_data[0].group;
 
 		printk(KERN_DEBUG "EXT4-fs: adding a flex group with "
-		       "%d groups, flexbg size is %d:\n", flex_gd->count,
+		       "%u groups, flexbg size is %u:\n", flex_gd->count,
 		       flexbg_size);
 
 		for (i = 0; i < flex_gd->count; i++) {
 			ext4_debug(
-			       "adding %s group %u: %u blocks (%d free, %d mdata blocks)\n",
+			       "adding %s group %u: %u blocks (%u free, %u mdata blocks)\n",
 			       ext4_bg_has_super(sb, group + i) ? "normal" :
 			       "no-super", group + i,
 			       group_data[i].blocks_count,
@@ -1584,8 +1592,7 @@ static int ext4_flex_group_add(struct super_block *sb,
 
 static int ext4_setup_next_flex_gd(struct super_block *sb,
 				    struct ext4_new_flex_group_data *flex_gd,
-				    ext4_fsblk_t n_blocks_count,
-				    unsigned long flexbg_size)
+				    ext4_fsblk_t n_blocks_count)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
@@ -1609,7 +1616,7 @@ static int ext4_setup_next_flex_gd(struct super_block *sb,
 	BUG_ON(last);
 	ext4_get_group_no_and_offset(sb, n_blocks_count - 1, &n_group, &last);
 
-	last_group = group | (flexbg_size - 1);
+	last_group = group | (flex_gd->resize_bg - 1);
 	if (last_group > n_group)
 		last_group = n_group;
 
@@ -1965,8 +1972,9 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	ext4_fsblk_t o_blocks_count;
 	ext4_fsblk_t n_blocks_count_retry = 0;
 	unsigned long last_update_time = 0;
-	int err = 0, flexbg_size = 1 << sbi->s_log_groups_per_flex;
+	int err = 0;
 	int meta_bg;
+	unsigned int flexbg_size = ext4_flex_bg_size(sbi);
 
 	/* See if the device is actually as big as what was requested */
 	bh = sb_bread(sb, n_blocks_count - 1);
@@ -2107,8 +2115,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	/* Add flex groups. Note that a regular group is a
 	 * flex group with 1 group.
 	 */
-	while (ext4_setup_next_flex_gd(sb, flex_gd, n_blocks_count,
-					      flexbg_size)) {
+	while (ext4_setup_next_flex_gd(sb, flex_gd, n_blocks_count)) {
 		if (jiffies - last_update_time > HZ * 10) {
 			if (last_update_time)
 				ext4_msg(sb, KERN_INFO,
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index ad0486beee2c..fffc7a9de04b 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -548,7 +548,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		 */
 		if (dest == NEW_ADDR) {
 			f2fs_truncate_data_blocks_range(&dn, 1);
-			f2fs_reserve_new_block(&dn);
+			do {
+				err = f2fs_reserve_new_block(&dn);
+				if (err == -ENOSPC) {
+					f2fs_bug_on(sbi, 1);
+					break;
+				}
+			} while (err &&
+				IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
+			if (err)
+				goto err;
 			continue;
 		}
 
@@ -556,12 +565,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
-				err = f2fs_reserve_new_block(&dn);
-				while (err &&
-				       IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION))
+				do {
 					err = f2fs_reserve_new_block(&dn);
-				/* We should not get -ENOSPC */
-				f2fs_bug_on(sbi, err);
+					if (err == -ENOSPC) {
+						f2fs_bug_on(sbi, 1);
+						break;
+					}
+				} while (err &&
+					IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
 				if (err)
 					goto err;
 			}
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 2f452b5ee731..893bc59658da 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -76,10 +76,10 @@
  */
 static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 			int nblocks);
-static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval);
-static int dbBackSplit(dmtree_t * tp, int leafno);
-static int dbJoin(dmtree_t * tp, int leafno, int newval);
-static void dbAdjTree(dmtree_t * tp, int leafno, int newval);
+static void dbSplit(dmtree_t *tp, int leafno, int splitsz, int newval, bool is_ctl);
+static int dbBackSplit(dmtree_t *tp, int leafno, bool is_ctl);
+static int dbJoin(dmtree_t *tp, int leafno, int newval, bool is_ctl);
+static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl);
 static int dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc,
 		    int level);
 static int dbAllocAny(struct bmap * bmp, s64 nblocks, int l2nb, s64 * results);
@@ -2184,7 +2184,7 @@ static int dbFreeDmap(struct bmap * bmp, struct dmap * dp, s64 blkno,
 		 * system.
 		 */
 		if (dp->tree.stree[word] == NOFREE)
-			dbBackSplit((dmtree_t *) & dp->tree, word);
+			dbBackSplit((dmtree_t *)&dp->tree, word, false);
 
 		dbAllocBits(bmp, dp, blkno, nblocks);
 	}
@@ -2270,7 +2270,7 @@ static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 			 * the binary system of the leaves if need be.
 			 */
 			dbSplit(tp, word, BUDMIN,
-				dbMaxBud((u8 *) & dp->wmap[word]));
+				dbMaxBud((u8 *)&dp->wmap[word]), false);
 
 			word += 1;
 		} else {
@@ -2310,7 +2310,7 @@ static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 				 * system of the leaves to reflect the current
 				 * allocation (size).
 				 */
-				dbSplit(tp, word, size, NOFREE);
+				dbSplit(tp, word, size, NOFREE, false);
 
 				/* get the number of dmap words handled */
 				nw = BUDSIZE(size, BUDMIN);
@@ -2417,7 +2417,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 			/* update the leaf for this dmap word.
 			 */
 			rc = dbJoin(tp, word,
-				    dbMaxBud((u8 *) & dp->wmap[word]));
+				    dbMaxBud((u8 *)&dp->wmap[word]), false);
 			if (rc)
 				return rc;
 
@@ -2450,7 +2450,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 
 				/* update the leaf.
 				 */
-				rc = dbJoin(tp, word, size);
+				rc = dbJoin(tp, word, size, false);
 				if (rc)
 					return rc;
 
@@ -2602,14 +2602,14 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 		 * that it is at the front of a binary buddy system.
 		 */
 		if (oldval == NOFREE) {
-			rc = dbBackSplit((dmtree_t *) dcp, leafno);
+			rc = dbBackSplit((dmtree_t *)dcp, leafno, true);
 			if (rc)
 				return rc;
 			oldval = dcp->stree[ti];
 		}
-		dbSplit((dmtree_t *) dcp, leafno, dcp->budmin, newval);
+		dbSplit((dmtree_t *) dcp, leafno, dcp->budmin, newval, true);
 	} else {
-		rc = dbJoin((dmtree_t *) dcp, leafno, newval);
+		rc = dbJoin((dmtree_t *) dcp, leafno, newval, true);
 		if (rc)
 			return rc;
 	}
@@ -2638,7 +2638,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 				 */
 				if (alloc) {
 					dbJoin((dmtree_t *) dcp, leafno,
-					       oldval);
+					       oldval, true);
 				} else {
 					/* the dbJoin() above might have
 					 * caused a larger binary buddy system
@@ -2648,9 +2648,9 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 					 */
 					if (dcp->stree[ti] == NOFREE)
 						dbBackSplit((dmtree_t *)
-							    dcp, leafno);
+							    dcp, leafno, true);
 					dbSplit((dmtree_t *) dcp, leafno,
-						dcp->budmin, oldval);
+						dcp->budmin, oldval, true);
 				}
 
 				/* release the buffer and return the error.
@@ -2698,7 +2698,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
  *
  * serialization: IREAD_LOCK(ipbmap) or IWRITE_LOCK(ipbmap) held on entry/exit;
  */
-static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
+static void dbSplit(dmtree_t *tp, int leafno, int splitsz, int newval, bool is_ctl)
 {
 	int budsz;
 	int cursz;
@@ -2720,7 +2720,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
 		while (cursz >= splitsz) {
 			/* update the buddy's leaf with its new value.
 			 */
-			dbAdjTree(tp, leafno ^ budsz, cursz);
+			dbAdjTree(tp, leafno ^ budsz, cursz, is_ctl);
 
 			/* on to the next size and buddy.
 			 */
@@ -2732,7 +2732,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
 	/* adjust the dmap tree to reflect the specified leaf's new
 	 * value.
 	 */
-	dbAdjTree(tp, leafno, newval);
+	dbAdjTree(tp, leafno, newval, is_ctl);
 }
 
 
@@ -2763,7 +2763,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
  *
  * serialization: IREAD_LOCK(ipbmap) or IWRITE_LOCK(ipbmap) held on entry/exit;
  */
-static int dbBackSplit(dmtree_t * tp, int leafno)
+static int dbBackSplit(dmtree_t *tp, int leafno, bool is_ctl)
 {
 	int budsz, bud, w, bsz, size;
 	int cursz;
@@ -2814,7 +2814,7 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
 				 * system in two.
 				 */
 				cursz = leaf[bud] - 1;
-				dbSplit(tp, bud, cursz, cursz);
+				dbSplit(tp, bud, cursz, cursz, is_ctl);
 				break;
 			}
 		}
@@ -2842,7 +2842,7 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
  *
  * RETURN VALUES: none
  */
-static int dbJoin(dmtree_t * tp, int leafno, int newval)
+static int dbJoin(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 {
 	int budsz, buddy;
 	s8 *leaf;
@@ -2897,12 +2897,12 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
 			if (leafno < buddy) {
 				/* leafno is the left buddy.
 				 */
-				dbAdjTree(tp, buddy, NOFREE);
+				dbAdjTree(tp, buddy, NOFREE, is_ctl);
 			} else {
 				/* buddy is the left buddy and becomes
 				 * leafno.
 				 */
-				dbAdjTree(tp, leafno, NOFREE);
+				dbAdjTree(tp, leafno, NOFREE, is_ctl);
 				leafno = buddy;
 			}
 
@@ -2915,7 +2915,7 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
 
 	/* update the leaf value.
 	 */
-	dbAdjTree(tp, leafno, newval);
+	dbAdjTree(tp, leafno, newval, is_ctl);
 
 	return 0;
 }
@@ -2936,15 +2936,20 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
  *
  * RETURN VALUES: none
  */
-static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
+static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 {
 	int lp, pp, k;
-	int max;
+	int max, size;
+
+	size = is_ctl ? CTLTREESIZE : TREESIZE;
 
 	/* pick up the index of the leaf for this leafno.
 	 */
 	lp = leafno + le32_to_cpu(tp->dmt_leafidx);
 
+	if (WARN_ON_ONCE(lp >= size || lp < 0))
+		return;
+
 	/* is the current value the same as the old value ?  if so,
 	 * there is nothing to do.
 	 */
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 52bae3f5c914..ea2c8f0fe832 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -646,6 +646,11 @@ int dtSearch(struct inode *ip, struct component_name * key, ino_t * data,
 		for (base = 0, lim = p->header.nextindex; lim; lim >>= 1) {
 			index = base + (lim >> 1);
 
+			if (stbl[index] < 0) {
+				rc = -EIO;
+				goto out;
+			}
+
 			if (p->header.flag & BT_LEAF) {
 				/* uppercase leaf name to compare */
 				cmp =
@@ -1983,7 +1988,7 @@ static int dtSplitRoot(tid_t tid,
 		do {
 			f = &rp->slot[fsi];
 			fsi = f->next;
-		} while (fsi != -1);
+		} while (fsi >= 0);
 
 		f->next = n;
 	}
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index b45cc109e506..00800c8c6f07 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -2194,6 +2194,9 @@ static int diNewExt(struct inomap * imap, struct iag * iagp, int extno)
 	/* get the ag and iag numbers for this iag.
 	 */
 	agno = BLKTOAG(le64_to_cpu(iagp->agstart), sbi);
+	if (agno >= MAXAG || agno < 0)
+		return -EIO;
+
 	iagno = le32_to_cpu(iagp->iagnum);
 
 	/* check if this is the last free extent within the
diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index f1a705d15904..97d91c1686b8 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -184,15 +184,15 @@ int jfs_mount(struct super_block *sb)
 	}
 	jfs_info("jfs_mount: ipimap:0x%p", ipimap);
 
-	/* map further access of per fileset inodes by the fileset inode */
-	sbi->ipimap = ipimap;
-
 	/* initialize fileset inode allocation map */
 	if ((rc = diMount(ipimap))) {
 		jfs_err("jfs_mount: diMount failed w/rc = %d", rc);
 		goto err_ipimap;
 	}
 
+	/* map further access of per fileset inodes by the fileset inode */
+	sbi->ipimap = ipimap;
+
 	return rc;
 
 	/*
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index 64bc81363c6c..3802b42e1cb4 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -105,7 +105,13 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	nilfs_transaction_commit(inode->i_sb);
 
  mapped:
-	wait_for_stable_page(page);
+	/*
+	 * Since checksumming including data blocks is performed to determine
+	 * the validity of the log to be written and used for recovery, it is
+	 * necessary to wait for writeback to finish here, regardless of the
+	 * stable write requirement of the backing device.
+	 */
+	wait_on_page_writeback(page);
  out:
 	sb_end_pagefault(inode->i_sb);
 	return block_page_mkwrite_return(ret);
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 140b663e91c7..18feb9c7c706 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -472,9 +472,10 @@ static int nilfs_prepare_segment_for_recovery(struct the_nilfs *nilfs,
 
 static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 				     struct nilfs_recovery_block *rb,
-				     struct page *page)
+				     loff_t pos, struct page *page)
 {
 	struct buffer_head *bh_org;
+	size_t from = pos & ~PAGE_MASK;
 	void *kaddr;
 
 	bh_org = __bread(nilfs->ns_bdev, rb->blocknr, nilfs->ns_blocksize);
@@ -482,7 +483,7 @@ static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 		return -EIO;
 
 	kaddr = kmap_atomic(page);
-	memcpy(kaddr + bh_offset(bh_org), bh_org->b_data, bh_org->b_size);
+	memcpy(kaddr + from, bh_org->b_data, bh_org->b_size);
 	kunmap_atomic(kaddr);
 	brelse(bh_org);
 	return 0;
@@ -521,7 +522,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 			goto failed_inode;
 		}
 
-		err = nilfs_recovery_copy_block(nilfs, rb, page);
+		err = nilfs_recovery_copy_block(nilfs, rb, pos, page);
 		if (unlikely(err))
 			goto failed_page;
 
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index fdcbed6ee832..7d1860d33723 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1702,7 +1702,6 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
 				    b_assoc_buffers) {
-			set_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
 				if (bh->b_page != bd_page) {
 					lock_page(bd_page);
@@ -1713,6 +1712,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 				}
 				break;
 			}
+			set_buffer_async_write(bh);
 			if (bh->b_page != fs_page) {
 				nilfs_begin_page_io(fs_page);
 				fs_page = bh->b_page;
@@ -1798,7 +1798,6 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
 				    b_assoc_buffers) {
-			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
 				clear_buffer_uptodate(bh);
 				if (bh->b_page != bd_page) {
@@ -1807,6 +1806,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 				}
 				break;
 			}
+			clear_buffer_async_write(bh);
 			if (bh->b_page != fs_page) {
 				nilfs_end_page_io(fs_page, err);
 				fs_page = bh->b_page;
@@ -1894,8 +1894,9 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				 BIT(BH_Delay) | BIT(BH_NILFS_Volatile) |
 				 BIT(BH_NILFS_Redirected));
 
-			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh == segbuf->sb_super_root) {
+				set_buffer_uptodate(bh);
+				clear_buffer_dirty(bh);
 				if (bh->b_page != bd_page) {
 					end_page_writeback(bd_page);
 					bd_page = bh->b_page;
@@ -1903,6 +1904,7 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				update_sr = true;
 				break;
 			}
+			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh->b_page != fs_page) {
 				nilfs_end_page_io(fs_page, 0);
 				fs_page = bh->b_page;
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 33294dee7d7f..0050aa56b0fa 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -590,6 +590,7 @@ static int ramoops_init_przs(const char *name,
 	}
 
 	zone_sz = mem_sz / *cnt;
+	zone_sz = ALIGN_DOWN(zone_sz, 2);
 	if (!zone_sz) {
 		dev_err(dev, "%s zone size == 0\n", name);
 		goto fail;
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 689f615471ab..a059f1d968b7 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -163,6 +163,7 @@ struct mipi_dsi_device_info {
  * struct mipi_dsi_device - DSI peripheral device
  * @host: DSI host for this peripheral
  * @dev: driver model device node for this peripheral
+ * @attached: the DSI device has been successfully attached
  * @name: DSI peripheral chip type
  * @channel: virtual channel assigned to the peripheral
  * @format: pixel format for video mode
@@ -172,6 +173,7 @@ struct mipi_dsi_device_info {
 struct mipi_dsi_device {
 	struct mipi_dsi_host *host;
 	struct device dev;
+	bool attached;
 
 	char name[DSI_DEV_NAME_SIZE];
 	unsigned int channel;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 766ea96bf5b8..269754890879 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -44,7 +44,11 @@ struct bpf_map_ops {
 	/* funcs called by prog_array and perf_event_array map */
 	void *(*map_fd_get_ptr)(struct bpf_map *map, struct file *map_file,
 				int fd);
-	void (*map_fd_put_ptr)(void *ptr);
+	/* If need_defer is true, the implementation should guarantee that
+	 * the to-be-put element is still alive before the bpf program, which
+	 * may manipulate it, exists.
+	 */
+	void (*map_fd_put_ptr)(struct bpf_map *map, void *ptr, bool need_defer);
 	u32 (*map_gen_lookup)(struct bpf_map *map, struct bpf_insn *insn_buf);
 	u32 (*map_fd_sys_lookup_elem)(void *ptr);
 	void (*map_seq_show_elem)(struct bpf_map *map, void *key,
diff --git a/include/linux/device.h b/include/linux/device.h
index bccd367c11de..0714d6e5d500 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1581,6 +1581,9 @@ do {									\
 	WARN_ONCE(condition, "%s %s: " format, \
 			dev_driver_string(dev), dev_name(dev), ## arg)
 
+extern __printf(3, 4)
+int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
+
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 50128c36f0b4..6e869419ab17 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -827,7 +827,8 @@ static inline int dmaengine_slave_config(struct dma_chan *chan,
 
 static inline bool is_slave_direction(enum dma_transfer_direction direction)
 {
-	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM);
+	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM) ||
+	       (direction == DMA_DEV_TO_DEV);
 }
 
 static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 3bdaa92a2cab..88496ba45c48 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -182,6 +182,7 @@ enum  hrtimer_base_type {
  * @hang_detected:	The last hrtimer interrupt detected a hang
  * @softirq_activated:	displays, if the softirq is raised - update of softirq
  *			related settings is not required then.
+ * @online:		CPU is online from an hrtimers point of view
  * @nr_events:		Total number of hrtimer interrupt events
  * @nr_retries:		Total number of hrtimer interrupt retries
  * @nr_hangs:		Total number of hrtimer interrupt hangs
@@ -206,7 +207,8 @@ struct hrtimer_cpu_base {
 	unsigned int			hres_active		: 1,
 					in_hrtirq		: 1,
 					hang_detected		: 1,
-					softirq_activated       : 1;
+					softirq_activated       : 1,
+					online			: 1;
 #ifdef CONFIG_HIGH_RES_TIMERS
 	unsigned int			nr_events;
 	unsigned short			nr_retries;
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index e65dace667d3..9a3ded44fb60 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -466,6 +466,12 @@
  *	simple integer value.  When @arg represents a user space pointer, it
  *	should never be used by the security module.
  *	Return 0 if permission is granted.
+ * @file_ioctl_compat:
+ *	@file contains the file structure.
+ *	@cmd contains the operation to perform.
+ *	@arg contains the operational arguments.
+ *	Check permission for a compat ioctl operation on @file.
+ *	Return 0 if permission is granted.
  * @mmap_addr :
  *	Check permissions for a mmap operation at @addr.
  *	@addr contains virtual address that will be used for the operation.
@@ -1563,6 +1569,8 @@ union security_list_options {
 	void (*file_free_security)(struct file *file);
 	int (*file_ioctl)(struct file *file, unsigned int cmd,
 				unsigned long arg);
+	int (*file_ioctl_compat)(struct file *file, unsigned int cmd,
+				unsigned long arg);
 	int (*mmap_addr)(unsigned long addr);
 	int (*mmap_file)(struct file *file, unsigned long reqprot,
 				unsigned long prot, unsigned long flags);
@@ -1861,6 +1869,7 @@ struct security_hook_heads {
 	struct hlist_head file_alloc_security;
 	struct hlist_head file_free_security;
 	struct hlist_head file_ioctl;
+	struct hlist_head file_ioctl_compat;
 	struct hlist_head mmap_addr;
 	struct hlist_head mmap_file;
 	struct hlist_head file_mprotect;
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 76d5490231a7..3ac7b92b35b9 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3004,6 +3004,7 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
+#define PCI_DEVICE_ID_INTEL_HDA_ARL	0x7728
 #define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
 #define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
 #define PCI_DEVICE_ID_INTEL_E6XX_CU	0x8183
diff --git a/include/linux/security.h b/include/linux/security.h
index 273877cf47bf..817af8ef3aef 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -322,6 +322,8 @@ int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int security_file_ioctl_compat(struct file *file, unsigned int cmd,
+			       unsigned long arg);
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags);
 int security_mmap_addr(unsigned long addr);
@@ -834,6 +836,13 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
 	return 0;
 }
 
+static inline int security_file_ioctl_compat(struct file *file,
+					     unsigned int cmd,
+					     unsigned long arg)
+{
+	return 0;
+}
+
 static inline int security_mmap_file(struct file *file, unsigned long prot,
 				     unsigned long flags)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 16158fe097a8..23a232d6db69 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -153,6 +153,7 @@ struct spi_device {
 #define	SPI_MODE_1	(0|SPI_CPHA)
 #define	SPI_MODE_2	(SPI_CPOL|0)
 #define	SPI_MODE_3	(SPI_CPOL|SPI_CPHA)
+#define	SPI_MODE_X_MASK	(SPI_CPOL|SPI_CPHA)
 #define	SPI_CS_HIGH	0x04			/* chipselect active high? */
 #define	SPI_LSB_FIRST	0x08			/* per-word bits-on-wire */
 #define	SPI_3WIRE	0x10			/* SI/SO signals shared */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2ff814c92f7f..bbe89b1cbf63 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -120,6 +120,7 @@ union bpf_attr;
 #define __TYPE_IS_LL(t) (__TYPE_AS(t, 0LL) || __TYPE_AS(t, 0ULL))
 #define __SC_LONG(t, a) __typeof(__builtin_choose_expr(__TYPE_IS_LL(t), 0LL, 0L)) a
 #define __SC_CAST(t, a)	(__force t) a
+#define __SC_TYPE(t, a)	t
 #define __SC_ARGS(t, a)	a
 #define __SC_TEST(t, a) (void)BUILD_BUG_ON_ZERO(!__TYPE_IS_LL(t) && sizeof(t) > sizeof(long))
 
diff --git a/include/linux/units.h b/include/linux/units.h
new file mode 100644
index 000000000000..a0af6d2ef4e5
--- /dev/null
+++ b/include/linux/units.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNITS_H
+#define _LINUX_UNITS_H
+
+#include <linux/kernel.h>
+
+#define HZ_PER_KHZ		1000UL
+#define KHZ_PER_MHZ		1000UL
+#define HZ_PER_MHZ		1000000UL
+
+#define MILLIWATT_PER_WATT	1000UL
+#define MICROWATT_PER_MILLIWATT	1000UL
+#define MICROWATT_PER_WATT	1000000UL
+
+#define ABSOLUTE_ZERO_MILLICELSIUS -273150
+
+static inline long milli_kelvin_to_millicelsius(long t)
+{
+	return t + ABSOLUTE_ZERO_MILLICELSIUS;
+}
+
+static inline long millicelsius_to_milli_kelvin(long t)
+{
+	return t - ABSOLUTE_ZERO_MILLICELSIUS;
+}
+
+#define MILLIDEGREE_PER_DEGREE 1000
+#define MILLIDEGREE_PER_DECIDEGREE 100
+
+static inline long kelvin_to_millicelsius(long t)
+{
+	return milli_kelvin_to_millicelsius(t * MILLIDEGREE_PER_DEGREE);
+}
+
+static inline long millicelsius_to_kelvin(long t)
+{
+	t = millicelsius_to_milli_kelvin(t);
+
+	return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DEGREE);
+}
+
+static inline long deci_kelvin_to_celsius(long t)
+{
+	t = milli_kelvin_to_millicelsius(t * MILLIDEGREE_PER_DECIDEGREE);
+
+	return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DEGREE);
+}
+
+static inline long celsius_to_deci_kelvin(long t)
+{
+	t = millicelsius_to_milli_kelvin(t * MILLIDEGREE_PER_DEGREE);
+
+	return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DECIDEGREE);
+}
+
+/**
+ * deci_kelvin_to_millicelsius_with_offset - convert Kelvin to Celsius
+ * @t: temperature value in decidegrees Kelvin
+ * @offset: difference between Kelvin and Celsius in millidegrees
+ *
+ * Return: temperature value in millidegrees Celsius
+ */
+static inline long deci_kelvin_to_millicelsius_with_offset(long t, long offset)
+{
+	return t * MILLIDEGREE_PER_DECIDEGREE - offset;
+}
+
+static inline long deci_kelvin_to_millicelsius(long t)
+{
+	return milli_kelvin_to_millicelsius(t * MILLIDEGREE_PER_DECIDEGREE);
+}
+
+static inline long millicelsius_to_deci_kelvin(long t)
+{
+	t = millicelsius_to_milli_kelvin(t);
+
+	return DIV_ROUND_CLOSEST(t, MILLIDEGREE_PER_DECIDEGREE);
+}
+
+static inline long kelvin_to_celsius(long t)
+{
+	return t + DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS,
+				     MILLIDEGREE_PER_DEGREE);
+}
+
+static inline long celsius_to_kelvin(long t)
+{
+	return t - DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS,
+				     MILLIDEGREE_PER_DEGREE);
+}
+
+#endif /* _LINUX_UNITS_H */
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 7ec1cdb66be8..e514508bdc92 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -43,12 +43,6 @@ struct unix_skb_parms {
 
 #define UNIXCB(skb) 	(*(struct unix_skb_parms *)&((skb)->cb))
 
-#define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
-#define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
-#define unix_state_lock_nested(s) \
-				spin_lock_nested(&unix_sk(s)->lock, \
-				SINGLE_DEPTH_NESTING)
-
 /* The AF_UNIX socket */
 struct unix_sock {
 	/* WARNING: sk has to be the first member */
@@ -72,6 +66,20 @@ static inline struct unix_sock *unix_sk(const struct sock *sk)
 	return (struct unix_sock *)sk;
 }
 
+#define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
+#define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
+enum unix_socket_lock_class {
+	U_LOCK_NORMAL,
+	U_LOCK_SECOND,	/* for double locking, see unix_state_double_lock(). */
+	U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(). */
+};
+
+static inline void unix_state_lock_nested(struct sock *sk,
+				   enum unix_socket_lock_class subclass)
+{
+	spin_lock_nested(&unix_sk(sk)->lock, subclass);
+}
+
 #define peer_wait peer_wq.wait
 
 long unix_inq_len(struct sock *sk);
diff --git a/include/net/llc_pdu.h b/include/net/llc_pdu.h
index 49aa79c7b278..581cd37aa98b 100644
--- a/include/net/llc_pdu.h
+++ b/include/net/llc_pdu.h
@@ -262,8 +262,7 @@ static inline void llc_pdu_header_init(struct sk_buff *skb, u8 type,
  */
 static inline void llc_pdu_decode_sa(struct sk_buff *skb, u8 *sa)
 {
-	if (skb->protocol == htons(ETH_P_802_2))
-		memcpy(sa, eth_hdr(skb)->h_source, ETH_ALEN);
+	memcpy(sa, eth_hdr(skb)->h_source, ETH_ALEN);
 }
 
 /**
@@ -275,8 +274,7 @@ static inline void llc_pdu_decode_sa(struct sk_buff *skb, u8 *sa)
  */
 static inline void llc_pdu_decode_da(struct sk_buff *skb, u8 *da)
 {
-	if (skb->protocol == htons(ETH_P_802_2))
-		memcpy(da, eth_hdr(skb)->h_dest, ETH_ALEN);
+	memcpy(da, eth_hdr(skb)->h_dest, ETH_ALEN);
 }
 
 /**
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index dd7a7b3e53f4..7fdc42645410 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -538,6 +538,9 @@ struct btrfs_ioctl_clone_range_args {
  */
 #define BTRFS_DEFRAG_RANGE_COMPRESS 1
 #define BTRFS_DEFRAG_RANGE_START_IO 2
+#define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		\
+					 BTRFS_DEFRAG_RANGE_START_IO)
+
 struct btrfs_ioctl_defrag_range_args {
 	/* start of the defrag operation */
 	__u64 start;
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index cc00be102b9f..39774870c864 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -238,9 +238,11 @@ enum nft_rule_attributes {
 /**
  * enum nft_rule_compat_flags - nf_tables rule compat flags
  *
+ * @NFT_RULE_COMPAT_F_UNUSED: unused
  * @NFT_RULE_COMPAT_F_INV: invert the check result
  */
 enum nft_rule_compat_flags {
+	NFT_RULE_COMPAT_F_UNUSED = (1 << 0),
 	NFT_RULE_COMPAT_F_INV	= (1 << 1),
 	NFT_RULE_COMPAT_F_MASK	= NFT_RULE_COMPAT_F_INV,
 };
diff --git a/kernel/audit.c b/kernel/audit.c
index 471d3ad910aa..5fb87eccb8c2 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -498,15 +498,19 @@ static void auditd_conn_free(struct rcu_head *rcu)
  * @pid: auditd PID
  * @portid: auditd netlink portid
  * @net: auditd network namespace pointer
+ * @skb: the netlink command from the audit daemon
+ * @ack: netlink ack flag, cleared if ack'd here
  *
  * Description:
  * This function will obtain and drop network namespace references as
  * necessary.  Returns zero on success, negative values on failure.
  */
-static int auditd_set(struct pid *pid, u32 portid, struct net *net)
+static int auditd_set(struct pid *pid, u32 portid, struct net *net,
+		      struct sk_buff *skb, bool *ack)
 {
 	unsigned long flags;
 	struct auditd_connection *ac_old, *ac_new;
+	struct nlmsghdr *nlh;
 
 	if (!pid || !net)
 		return -EINVAL;
@@ -518,6 +522,13 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
 	ac_new->portid = portid;
 	ac_new->net = get_net(net);
 
+	/* send the ack now to avoid a race with the queue backlog */
+	if (*ack) {
+		nlh = nlmsg_hdr(skb);
+		netlink_ack(skb, nlh, 0, NULL);
+		*ack = false;
+	}
+
 	spin_lock_irqsave(&auditd_conn_lock, flags);
 	ac_old = rcu_dereference_protected(auditd_conn,
 					   lockdep_is_held(&auditd_conn_lock));
@@ -1204,7 +1215,8 @@ static int audit_replace(struct pid *pid)
 	return auditd_send_unicast_skb(skb);
 }
 
-static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
+static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
+			     bool *ack)
 {
 	u32			seq;
 	void			*data;
@@ -1296,7 +1308,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				/* register a new auditd connection */
 				err = auditd_set(req_pid,
 						 NETLINK_CB(skb).portid,
-						 sock_net(NETLINK_CB(skb).sk));
+						 sock_net(NETLINK_CB(skb).sk),
+						 skb, ack);
 				if (audit_enabled != AUDIT_OFF)
 					audit_log_config_change("audit_pid",
 								new_pid,
@@ -1529,9 +1542,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
  * Parse the provided skb and deal with any messages that may be present,
  * malformed skbs are discarded.
  */
-static void audit_receive(struct sk_buff  *skb)
+static void audit_receive(struct sk_buff *skb)
 {
 	struct nlmsghdr *nlh;
+	bool ack;
 	/*
 	 * len MUST be signed for nlmsg_next to be able to dec it below 0
 	 * if the nlmsg_len was not aligned
@@ -1544,9 +1558,12 @@ static void audit_receive(struct sk_buff  *skb)
 
 	audit_ctl_lock();
 	while (nlmsg_ok(nlh, len)) {
-		err = audit_receive_msg(skb, nlh);
-		/* if err or if this message says it wants a response */
-		if (err || (nlh->nlmsg_flags & NLM_F_ACK))
+		ack = nlh->nlmsg_flags & NLM_F_ACK;
+		err = audit_receive_msg(skb, nlh, &ack);
+
+		/* send an ack if the user asked for one and audit_receive_msg
+		 * didn't already do it, or if there was an error. */
+		if (ack || err)
 			netlink_ack(skb, nlh, err, NULL);
 
 		nlh = nlmsg_next(nlh, &len);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 0c17aab3ce5f..44f53c06629e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -469,7 +469,7 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 
 	old_ptr = xchg(array->ptrs + index, new_ptr);
 	if (old_ptr)
-		map->ops->map_fd_put_ptr(old_ptr);
+		map->ops->map_fd_put_ptr(map, old_ptr, true);
 
 	return 0;
 }
@@ -485,7 +485,7 @@ static int fd_array_map_delete_elem(struct bpf_map *map, void *key)
 
 	old_ptr = xchg(array->ptrs + index, NULL);
 	if (old_ptr) {
-		map->ops->map_fd_put_ptr(old_ptr);
+		map->ops->map_fd_put_ptr(map, old_ptr, true);
 		return 0;
 	} else {
 		return -ENOENT;
@@ -509,8 +509,9 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
 	return prog;
 }
 
-static void prog_fd_array_put_ptr(void *ptr)
+static void prog_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
+	/* bpf_prog is freed after one RCU or tasks trace grace period */
 	bpf_prog_put(ptr);
 }
 
@@ -598,8 +599,9 @@ static void *perf_event_fd_array_get_ptr(struct bpf_map *map,
 	return ee;
 }
 
-static void perf_event_fd_array_put_ptr(void *ptr)
+static void perf_event_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
+	/* bpf_perf_event is freed after one RCU grace period */
 	bpf_event_entry_free_rcu(ptr);
 }
 
@@ -640,7 +642,7 @@ static void *cgroup_fd_array_get_ptr(struct bpf_map *map,
 	return cgroup_get_from_fd(fd);
 }
 
-static void cgroup_fd_array_put_ptr(void *ptr)
+static void cgroup_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
 	/* cgroup_put free cgrp after a rcu grace period */
 	cgroup_put(ptr);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3f3ed33bd2fd..8e379b667a0f 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -677,7 +677,7 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 
 	if (map->ops->map_fd_put_ptr) {
 		ptr = fd_htab_map_get_ptr(map, l);
-		map->ops->map_fd_put_ptr(ptr);
+		map->ops->map_fd_put_ptr(map, ptr, true);
 	}
 }
 
@@ -1337,7 +1337,7 @@ static void fd_htab_map_free(struct bpf_map *map)
 		hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
 			void *ptr = fd_htab_map_get_ptr(map, l);
 
-			map->ops->map_fd_put_ptr(ptr);
+			map->ops->map_fd_put_ptr(map, ptr, false);
 		}
 	}
 
@@ -1378,7 +1378,7 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
 
 	ret = htab_map_update_elem(map, key, &ptr, map_flags);
 	if (ret)
-		map->ops->map_fd_put_ptr(ptr);
+		map->ops->map_fd_put_ptr(map, ptr, false);
 
 	return ret;
 }
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 9670ee5ee74e..051c5e40792c 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -102,7 +102,7 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 	return inner_map;
 }
 
-void bpf_map_fd_put_ptr(void *ptr)
+void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
 	/* ptr->ops->map_free() has to go through one
 	 * rcu grace period by itself.
diff --git a/kernel/bpf/map_in_map.h b/kernel/bpf/map_in_map.h
index 6183db9ec08c..1e652a7bf60e 100644
--- a/kernel/bpf/map_in_map.h
+++ b/kernel/bpf/map_in_map.h
@@ -18,7 +18,7 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 			const struct bpf_map *meta1);
 void *bpf_map_fd_get_ptr(struct bpf_map *map, struct file *map_file,
 			 int ufd);
-void bpf_map_fd_put_ptr(void *ptr);
+void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer);
 u32 bpf_map_fd_sys_lookup_elem(void *ptr);
 
 #endif
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 9db7f2f93fae..a818ad6ade9c 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -596,11 +596,11 @@ static int crc32_threadfn(void *data)
 	unsigned i;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -609,7 +609,7 @@ static int crc32_threadfn(void *data)
 		for (i = 0; i < d->run_threads; i++)
 			*d->crc32 = crc32_le(*d->crc32,
 			                     d->unc[i], *d->unc_len[i]);
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -639,12 +639,12 @@ static int lzo_compress_threadfn(void *data)
 	struct cmp_data *d = data;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
 			d->ret = -1;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -653,7 +653,7 @@ static int lzo_compress_threadfn(void *data)
 		d->ret = lzo1x_1_compress(d->unc, d->unc_len,
 		                          d->cmp + LZO_HEADER, &d->cmp_len,
 		                          d->wrk);
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -791,7 +791,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 
 			data[thr].unc_len = off;
 
-			atomic_set(&data[thr].ready, 1);
+			atomic_set_release(&data[thr].ready, 1);
 			wake_up(&data[thr].go);
 		}
 
@@ -799,12 +799,12 @@ static int save_image_lzo(struct swap_map_handle *handle,
 			break;
 
 		crc->run_threads = thr;
-		atomic_set(&crc->ready, 1);
+		atomic_set_release(&crc->ready, 1);
 		wake_up(&crc->go);
 
 		for (run_threads = thr, thr = 0; thr < run_threads; thr++) {
 			wait_event(data[thr].done,
-			           atomic_read(&data[thr].stop));
+				atomic_read_acquire(&data[thr].stop));
 			atomic_set(&data[thr].stop, 0);
 
 			ret = data[thr].ret;
@@ -843,7 +843,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 			}
 		}
 
-		wait_event(crc->done, atomic_read(&crc->stop));
+		wait_event(crc->done, atomic_read_acquire(&crc->stop));
 		atomic_set(&crc->stop, 0);
 	}
 
@@ -1124,12 +1124,12 @@ static int lzo_decompress_threadfn(void *data)
 	struct dec_data *d = data;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
 			d->ret = -1;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -1142,7 +1142,7 @@ static int lzo_decompress_threadfn(void *data)
 			flush_icache_range((unsigned long)d->unc,
 					   (unsigned long)d->unc + d->unc_len);
 
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -1330,7 +1330,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		}
 
 		if (crc->run_threads) {
-			wait_event(crc->done, atomic_read(&crc->stop));
+			wait_event(crc->done, atomic_read_acquire(&crc->stop));
 			atomic_set(&crc->stop, 0);
 			crc->run_threads = 0;
 		}
@@ -1366,7 +1366,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 					pg = 0;
 			}
 
-			atomic_set(&data[thr].ready, 1);
+			atomic_set_release(&data[thr].ready, 1);
 			wake_up(&data[thr].go);
 		}
 
@@ -1385,7 +1385,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 
 		for (run_threads = thr, thr = 0; thr < run_threads; thr++) {
 			wait_event(data[thr].done,
-			           atomic_read(&data[thr].stop));
+				atomic_read_acquire(&data[thr].stop));
 			atomic_set(&data[thr].stop, 0);
 
 			ret = data[thr].ret;
@@ -1416,7 +1416,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 				ret = snapshot_write_next(snapshot);
 				if (ret <= 0) {
 					crc->run_threads = thr + 1;
-					atomic_set(&crc->ready, 1);
+					atomic_set_release(&crc->ready, 1);
 					wake_up(&crc->go);
 					goto out_finish;
 				}
@@ -1424,13 +1424,13 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		}
 
 		crc->run_threads = thr;
-		atomic_set(&crc->ready, 1);
+		atomic_set_release(&crc->ready, 1);
 		wake_up(&crc->go);
 	}
 
 out_finish:
 	if (crc->run_threads) {
-		wait_event(crc->done, atomic_read(&crc->stop));
+		wait_event(crc->done, atomic_read_acquire(&crc->stop));
 		atomic_set(&crc->stop, 0);
 	}
 	stop = ktime_get();
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index dd27e632b1ba..9049ca636e17 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -34,6 +34,8 @@
 	| MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED			\
 	| MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK)
 
+static DEFINE_MUTEX(membarrier_ipi_mutex);
+
 static void ipi_mb(void *info)
 {
 	smp_mb();	/* IPIs should be serializing but paranoid. */
@@ -64,6 +66,7 @@ static int membarrier_global_expedited(void)
 		fallback = true;
 	}
 
+	mutex_lock(&membarrier_ipi_mutex);
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct task_struct *p;
@@ -104,6 +107,7 @@ static int membarrier_global_expedited(void)
 	 * rq->curr modification in scheduler.
 	 */
 	smp_mb();	/* exit from system call is not a mb */
+	mutex_unlock(&membarrier_ipi_mutex);
 	return 0;
 }
 
@@ -144,6 +148,7 @@ static int membarrier_private_expedited(int flags)
 		fallback = true;
 	}
 
+	mutex_lock(&membarrier_ipi_mutex);
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct task_struct *p;
@@ -182,6 +187,7 @@ static int membarrier_private_expedited(int flags)
 	 * rq->curr modification in scheduler.
 	 */
 	smp_mb();	/* exit from system call is not a mb */
+	mutex_unlock(&membarrier_ipi_mutex);
 
 	return 0;
 }
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index bf74f43e42af..0eb5b6cc6d93 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -970,6 +970,7 @@ static int enqueue_hrtimer(struct hrtimer *timer,
 			   enum hrtimer_mode mode)
 {
 	debug_activate(timer, mode);
+	WARN_ON_ONCE(!base->cpu_base->online);
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
@@ -1887,6 +1888,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	cpu_base->online = 1;
 	return 0;
 }
 
@@ -1953,6 +1955,7 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
 	raw_spin_unlock(&new_base->lock);
+	old_base->online = 0;
 	raw_spin_unlock(&old_base->lock);
 
 	return 0;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a05b735b96ac..e858522cbd15 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1346,6 +1346,7 @@ void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 	ktime_t idle_sleeptime, iowait_sleeptime;
+	unsigned long idle_calls, idle_sleeps;
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
@@ -1354,9 +1355,13 @@ void tick_cancel_sched_timer(int cpu)
 
 	idle_sleeptime = ts->idle_sleeptime;
 	iowait_sleeptime = ts->iowait_sleeptime;
+	idle_calls = ts->idle_calls;
+	idle_sleeps = ts->idle_sleeps;
 	memset(ts, 0, sizeof(*ts));
 	ts->idle_sleeptime = idle_sleeptime;
 	ts->iowait_sleeptime = iowait_sleeptime;
+	ts->idle_calls = idle_calls;
+	ts->idle_sleeps = idle_sleeps;
 }
 #endif
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d2903d8834fe..788b89e98338 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -676,7 +676,7 @@ __poll_t ring_buffer_poll_wait(struct ring_buffer *buffer, int cpu,
 		work = &buffer->irq_work;
 	else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
-			return -EINVAL;
+			return EPOLLERR;
 
 		cpu_buffer = buffer->buffers[cpu];
 		work = &cpu_buffer->irq_work;
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 4b0bde304ad7..8cb4ddb88601 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1133,8 +1133,10 @@ register_snapshot_trigger(char *glob, struct event_trigger_ops *ops,
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	if (tracing_alloc_snapshot_instance(file->tr) != 0)
-		return 0;
+	int ret = tracing_alloc_snapshot_instance(file->tr);
+
+	if (ret < 0)
+		return ret;
 
 	return register_trigger(glob, ops, data, file);
 }
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 83c2a0598c64..33c463967bb3 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -574,7 +574,12 @@ __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 				}
 
 				memcpy(elt->key, key, map->key_size);
-				entry->val = elt;
+				/*
+				 * Ensure the initialization is visible and
+				 * publish the elt.
+				 */
+				smp_wmb();
+				WRITE_ONCE(entry->val, elt);
 				atomic64_inc(&map->hits);
 
 				return entry->val;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 078f1461e074..170609a4d5f0 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1529,7 +1529,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
 	 */
 	dtc->wb_thresh = __wb_calc_thresh(dtc);
 	dtc->wb_bg_thresh = dtc->thresh ?
-		div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
+		div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
 
 	/*
 	 * In order to avoid the stacked BDI deadlock we need
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index 74042b9d7f73..231eae2f1685 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -120,12 +120,16 @@ static int vlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 	if (data[IFLA_VLAN_INGRESS_QOS]) {
 		nla_for_each_nested(attr, data[IFLA_VLAN_INGRESS_QOS], rem) {
+			if (nla_type(attr) != IFLA_VLAN_QOS_MAPPING)
+				continue;
 			m = nla_data(attr);
 			vlan_dev_set_ingress_priority(dev, m->to, m->from);
 		}
 	}
 	if (data[IFLA_VLAN_EGRESS_QOS]) {
 		nla_for_each_nested(attr, data[IFLA_VLAN_EGRESS_QOS], rem) {
+			if (nla_type(attr) != IFLA_VLAN_QOS_MAPPING)
+				continue;
 			m = nla_data(attr);
 			err = vlan_dev_set_egress_priority(dev, m->from, m->to);
 			if (err)
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 7c902a1efbbf..01952a520d6f 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1552,10 +1552,12 @@ EXPORT_SYMBOL(inet_current_timestamp);
 
 int inet_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 {
-	if (sk->sk_family == AF_INET)
+	unsigned int family = READ_ONCE(sk->sk_family);
+
+	if (family == AF_INET)
 		return ip_recv_error(sk, msg, len, addr_len);
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family == AF_INET6)
+	if (family == AF_INET6)
 		return pingv6_ops.ipv6_recv_error(sk, msg, len, addr_len);
 #endif
 	return -EINVAL;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6936f703758b..3e15c1b388ae 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1140,6 +1140,12 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	if (unlikely(!rt))
 		return -EFAULT;
 
+	cork->fragsize = ip_sk_use_pmtu(sk) ?
+			 dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
+
+	if (!inetdev_valid_mtu(cork->fragsize))
+		return -ENETUNREACH;
+
 	/*
 	 * setup for corking.
 	 */
@@ -1156,12 +1162,6 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 		cork->addr = ipc->addr;
 	}
 
-	cork->fragsize = ip_sk_use_pmtu(sk) ?
-			 dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
-
-	if (!inetdev_valid_mtu(cork->fragsize))
-		return -ENETUNREACH;
-
 	cork->gso_size = ipc->gso_size;
 
 	cork->dst = &rt->dst;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 00648a478c6a..712186336997 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -733,6 +733,7 @@ static void tcp_push(struct sock *sk, int flags, int mss_now,
 		if (!test_bit(TSQ_THROTTLED, &sk->sk_tsq_flags)) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAUTOCORKING);
 			set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);
+			smp_mb__after_atomic();
 		}
 		/* It is possible TX completion already happened
 		 * before we set TSQ_THROTTLED.
diff --git a/net/ipv6/addrconf_core.c b/net/ipv6/addrconf_core.c
index 66a1a0eb2ed0..9c2c7baa3929 100644
--- a/net/ipv6/addrconf_core.c
+++ b/net/ipv6/addrconf_core.c
@@ -180,19 +180,26 @@ const struct ipv6_stub *ipv6_stub __read_mostly = &(struct ipv6_stub) {
 EXPORT_SYMBOL_GPL(ipv6_stub);
 
 /* IPv6 Wildcard Address and Loopback Address defined by RFC2553 */
-const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;
+const struct in6_addr in6addr_loopback __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LOOPBACK_INIT;
 EXPORT_SYMBOL(in6addr_loopback);
-const struct in6_addr in6addr_any = IN6ADDR_ANY_INIT;
+const struct in6_addr in6addr_any __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_ANY_INIT;
 EXPORT_SYMBOL(in6addr_any);
-const struct in6_addr in6addr_linklocal_allnodes = IN6ADDR_LINKLOCAL_ALLNODES_INIT;
+const struct in6_addr in6addr_linklocal_allnodes __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LINKLOCAL_ALLNODES_INIT;
 EXPORT_SYMBOL(in6addr_linklocal_allnodes);
-const struct in6_addr in6addr_linklocal_allrouters = IN6ADDR_LINKLOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_linklocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LINKLOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_linklocal_allrouters);
-const struct in6_addr in6addr_interfacelocal_allnodes = IN6ADDR_INTERFACELOCAL_ALLNODES_INIT;
+const struct in6_addr in6addr_interfacelocal_allnodes __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_INTERFACELOCAL_ALLNODES_INIT;
 EXPORT_SYMBOL(in6addr_interfacelocal_allnodes);
-const struct in6_addr in6addr_interfacelocal_allrouters = IN6ADDR_INTERFACELOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_interfacelocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_INTERFACELOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_interfacelocal_allrouters);
-const struct in6_addr in6addr_sitelocal_allrouters = IN6ADDR_SITELOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_sitelocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_SITELOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_sitelocal_allrouters);
 
 static void snmp6_free_dev(struct inet6_dev *idev)
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index d59f2341bfec..1ff2860dd3ff 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2477,7 +2477,7 @@ static int __init afiucv_init(void)
 {
 	int err;
 
-	if (MACHINE_IS_VM) {
+	if (MACHINE_IS_VM && IS_ENABLED(CONFIG_IUCV)) {
 		cpcmd("QUERY USERID", iucv_userid, sizeof(iucv_userid), &err);
 		if (unlikely(err)) {
 			WARN_ON(err);
@@ -2485,11 +2485,7 @@ static int __init afiucv_init(void)
 			goto out;
 		}
 
-		pr_iucv = try_then_request_module(symbol_get(iucv_if), "iucv");
-		if (!pr_iucv) {
-			printk(KERN_WARNING "iucv_if lookup failed\n");
-			memset(&iucv_userid, 0, sizeof(iucv_userid));
-		}
+		pr_iucv = &iucv_if;
 	} else {
 		memset(&iucv_userid, 0, sizeof(iucv_userid));
 		pr_iucv = NULL;
@@ -2523,17 +2519,13 @@ static int __init afiucv_init(void)
 out_proto:
 	proto_unregister(&iucv_proto);
 out:
-	if (pr_iucv)
-		symbol_put(iucv_if);
 	return err;
 }
 
 static void __exit afiucv_exit(void)
 {
-	if (pr_iucv) {
+	if (pr_iucv)
 		afiucv_iucv_exit();
-		symbol_put(iucv_if);
-	}
 
 	unregister_netdevice_notifier(&afiucv_netdev_notifier);
 	dev_remove_pack(&iucv_packet_type);
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 5cba9199c3c9..fc7507ccc667 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -227,6 +227,8 @@ static int llc_ui_release(struct socket *sock)
 	if (llc->dev)
 		dev_put(llc->dev);
 	sock_put(sk);
+	sock_orphan(sk);
+	sock->sk = NULL;
 	llc_sk_free(sk);
 out:
 	return 0;
@@ -926,14 +928,15 @@ static int llc_ui_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  */
 static int llc_ui_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
+	DECLARE_SOCKADDR(struct sockaddr_llc *, addr, msg->msg_name);
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc = llc_sk(sk);
-	DECLARE_SOCKADDR(struct sockaddr_llc *, addr, msg->msg_name);
 	int flags = msg->msg_flags;
 	int noblock = flags & MSG_DONTWAIT;
+	int rc = -EINVAL, copied = 0, hdrlen, hh_len;
 	struct sk_buff *skb = NULL;
+	struct net_device *dev;
 	size_t size = 0;
-	int rc = -EINVAL, copied = 0, hdrlen;
 
 	dprintk("%s: sending from %02X to %02X\n", __func__,
 		llc->laddr.lsap, llc->daddr.lsap);
@@ -953,22 +956,29 @@ static int llc_ui_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		if (rc)
 			goto out;
 	}
-	hdrlen = llc->dev->hard_header_len + llc_ui_header_len(sk, addr);
+	dev = llc->dev;
+	hh_len = LL_RESERVED_SPACE(dev);
+	hdrlen = llc_ui_header_len(sk, addr);
 	size = hdrlen + len;
-	if (size > llc->dev->mtu)
-		size = llc->dev->mtu;
+	size = min_t(size_t, size, READ_ONCE(dev->mtu));
 	copied = size - hdrlen;
 	rc = -EINVAL;
 	if (copied < 0)
 		goto out;
 	release_sock(sk);
-	skb = sock_alloc_send_skb(sk, size, noblock, &rc);
+	skb = sock_alloc_send_skb(sk, hh_len + size, noblock, &rc);
 	lock_sock(sk);
 	if (!skb)
 		goto out;
-	skb->dev      = llc->dev;
+	if (sock_flag(sk, SOCK_ZAPPED) ||
+	    llc->dev != dev ||
+	    hdrlen != llc_ui_header_len(sk, addr) ||
+	    hh_len != LL_RESERVED_SPACE(dev) ||
+	    size > READ_ONCE(dev->mtu))
+		goto out;
+	skb->dev      = dev;
 	skb->protocol = llc_proto_type(addr->sllc_arphrd);
-	skb_reserve(skb, hdrlen);
+	skb_reserve(skb, hh_len + hdrlen);
 	rc = memcpy_from_msg(skb_put(skb, copied), msg, copied);
 	if (rc)
 		goto out;
diff --git a/net/llc/llc_core.c b/net/llc/llc_core.c
index 64d4bef04e73..4900a27b5176 100644
--- a/net/llc/llc_core.c
+++ b/net/llc/llc_core.c
@@ -135,22 +135,15 @@ static struct packet_type llc_packet_type __read_mostly = {
 	.func = llc_rcv,
 };
 
-static struct packet_type llc_tr_packet_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_TR_802_2),
-	.func = llc_rcv,
-};
-
 static int __init llc_init(void)
 {
 	dev_add_pack(&llc_packet_type);
-	dev_add_pack(&llc_tr_packet_type);
 	return 0;
 }
 
 static void __exit llc_exit(void)
 {
 	dev_remove_pack(&llc_packet_type);
-	dev_remove_pack(&llc_tr_packet_type);
 }
 
 module_init(llc_init);
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index a61d6df6e5f6..75bdeee325eb 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -202,11 +202,12 @@ void nf_logger_put(int pf, enum nf_log_type type)
 		return;
 	}
 
-	BUG_ON(loggers[pf][type] == NULL);
-
 	rcu_read_lock();
 	logger = rcu_dereference(loggers[pf][type]);
-	module_put(logger->me);
+	if (!logger)
+		WARN_ON_ONCE(1);
+	else
+		module_put(logger->me);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nf_logger_put);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e0c224dea316..94f1104b0487 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -26,6 +26,7 @@
 #include <net/sock.h>
 
 #define NFT_MODULE_AUTOLOAD_LIMIT (MODULE_NAME_LEN - sizeof("nft-expr-255-"))
+#define NFT_SET_MAX_ANONLEN 16
 
 unsigned int nf_tables_net_id __read_mostly;
 
@@ -3184,6 +3185,9 @@ static int nf_tables_set_alloc_name(struct nft_ctx *ctx, struct nft_set *set,
 		if (p[1] != 'd' || strchr(p + 2, '%'))
 			return -EINVAL;
 
+		if (strnlen(name, NFT_SET_MAX_ANONLEN) >= NFT_SET_MAX_ANONLEN)
+			return -EINVAL;
+
 		inuse = (unsigned long *)get_zeroed_page(GFP_KERNEL);
 		if (inuse == NULL)
 			return -ENOMEM;
@@ -7337,16 +7341,10 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 	data->verdict.code = ntohl(nla_get_be32(tb[NFTA_VERDICT_CODE]));
 
 	switch (data->verdict.code) {
-	default:
-		switch (data->verdict.code & NF_VERDICT_MASK) {
-		case NF_ACCEPT:
-		case NF_DROP:
-		case NF_QUEUE:
-			break;
-		default:
-			return -EINVAL;
-		}
-		/* fall through */
+	case NF_ACCEPT:
+	case NF_DROP:
+	case NF_QUEUE:
+		break;
 	case NFT_CONTINUE:
 	case NFT_BREAK:
 	case NFT_RETURN:
@@ -7366,6 +7364,8 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 		data->verdict.chain = chain;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	desc->len = sizeof(data->verdict);
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index dba16126c7ee..8c4ee49a80fb 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -41,19 +41,20 @@ static void nft_byteorder_eval(const struct nft_expr *expr,
 
 	switch (priv->size) {
 	case 8: {
+		u64 *dst64 = (void *)dst;
 		u64 src64;
 
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 8; i++) {
 				src64 = get_unaligned((u64 *)&src[i]);
-				put_unaligned_be64(src64, &dst[i]);
+				put_unaligned_be64(src64, &dst64[i]);
 			}
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 8; i++) {
 				src64 = get_unaligned_be64(&src[i]);
-				put_unaligned(src64, (u64 *)&dst[i]);
+				put_unaligned(src64, &dst64[i]);
 			}
 			break;
 		}
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 2846d64659f2..763ba07a58ab 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -195,6 +195,7 @@ static const struct nla_policy nft_rule_compat_policy[NFTA_RULE_COMPAT_MAX + 1]
 static int nft_parse_compat(const struct nlattr *attr, u16 *proto, bool *inv)
 {
 	struct nlattr *tb[NFTA_RULE_COMPAT_MAX+1];
+	u32 l4proto;
 	u32 flags;
 	int err;
 
@@ -207,12 +208,18 @@ static int nft_parse_compat(const struct nlattr *attr, u16 *proto, bool *inv)
 		return -EINVAL;
 
 	flags = ntohl(nla_get_be32(tb[NFTA_RULE_COMPAT_FLAGS]));
-	if (flags & ~NFT_RULE_COMPAT_F_MASK)
+	if (flags & NFT_RULE_COMPAT_F_UNUSED ||
+	    flags & ~NFT_RULE_COMPAT_F_MASK)
 		return -EINVAL;
 	if (flags & NFT_RULE_COMPAT_F_INV)
 		*inv = true;
 
-	*proto = ntohl(nla_get_be32(tb[NFTA_RULE_COMPAT_PROTO]));
+	l4proto = ntohl(nla_get_be32(tb[NFTA_RULE_COMPAT_PROTO]));
+	if (l4proto > U16_MAX)
+		return -EINVAL;
+
+	*proto = l4proto;
+
 	return 0;
 }
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e91489b3274c..72936d154c96 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -374,7 +374,7 @@ static void netlink_skb_destructor(struct sk_buff *skb)
 	if (is_vmalloc_addr(skb->head)) {
 		if (!skb->cloned ||
 		    !atomic_dec_return(&(skb_shinfo(skb)->dataref)))
-			vfree(skb->head);
+			vfree_atomic(skb->head);
 
 		skb->head = NULL;
 	}
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 33723d843e47..2e885b7a02a1 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1209,6 +1209,10 @@ void nci_free_device(struct nci_dev *ndev)
 {
 	nfc_free_device(ndev->nfc_dev);
 	nci_hci_deallocate(ndev);
+
+	/* drop partial rx data packet if present */
+	if (ndev->rx_data_reassembly)
+		kfree_skb(ndev->rx_data_reassembly);
 	kfree(ndev);
 }
 EXPORT_SYMBOL(nci_free_device);
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index cd7e01ea8144..5eb71d276706 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -385,7 +385,7 @@ static int rds_recv_track_latency(struct rds_sock *rs, char __user *optval,
 
 	rs->rs_rx_traces = trace.rx_traces;
 	for (i = 0; i < rs->rs_rx_traces; i++) {
-		if (trace.rx_trace_pos[i] > RDS_MSG_RX_DGRAM_TRACE_MAX) {
+		if (trace.rx_trace_pos[i] >= RDS_MSG_RX_DGRAM_TRACE_MAX) {
 			rs->rs_rx_traces = 0;
 			return -EFAULT;
 		}
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 04213afd7710..84a70d7d0285 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -45,6 +45,14 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 
 	_enter("%d", conn->debug_id);
 
+	if (sp && sp->hdr.type == RXRPC_PACKET_TYPE_ACK) {
+		if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
+				  &pkt.ack, sizeof(pkt.ack)) < 0)
+			return;
+		if (pkt.ack.reason == RXRPC_ACK_PING_RESPONSE)
+			return;
+	}
+
 	chan = &conn->channels[channel];
 
 	/* If the last call got moved on whilst we were waiting to run, just
diff --git a/net/rxrpc/conn_service.c b/net/rxrpc/conn_service.c
index 6da7c4bf15e8..4b1564824aed 100644
--- a/net/rxrpc/conn_service.c
+++ b/net/rxrpc/conn_service.c
@@ -29,7 +29,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 	struct rxrpc_conn_proto k;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rb_node *p;
-	unsigned int seq = 0;
+	unsigned int seq = 1;
 
 	k.epoch	= sp->hdr.epoch;
 	k.cid	= sp->hdr.cid & RXRPC_CIDMASK;
@@ -39,6 +39,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&peer->service_conn_lock, &seq);
 
 		p = rcu_dereference_raw(peer->service_conns.rb_node);
diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index f95dc899e989..1140218c077b 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -405,7 +405,6 @@ static int cbs_init(struct Qdisc *sch, struct nlattr *opt,
 {
 	struct cbs_sched_data *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
-	int err;
 
 	if (!opt) {
 		NL_SET_ERR_MSG(extack, "Missing CBS qdisc options  which are mandatory");
@@ -417,6 +416,10 @@ static int cbs_init(struct Qdisc *sch, struct nlattr *opt,
 	if (!q->qdisc)
 		return -ENOMEM;
 
+	spin_lock(&cbs_list_lock);
+	list_add(&q->cbs_list, &cbs_list);
+	spin_unlock(&cbs_list_lock);
+
 	qdisc_hash_add(q->qdisc, false);
 
 	q->queue = sch->dev_queue - netdev_get_tx_queue(dev, 0);
@@ -426,17 +429,7 @@ static int cbs_init(struct Qdisc *sch, struct nlattr *opt,
 
 	qdisc_watchdog_init(&q->watchdog, sch);
 
-	err = cbs_change(sch, opt, extack);
-	if (err)
-		return err;
-
-	if (!q->offload) {
-		spin_lock(&cbs_list_lock);
-		list_add(&q->cbs_list, &cbs_list);
-		spin_unlock(&cbs_list_lock);
-	}
-
-	return 0;
+	return cbs_change(sch, opt, extack);
 }
 
 static void cbs_destroy(struct Qdisc *sch)
@@ -444,15 +437,18 @@ static void cbs_destroy(struct Qdisc *sch)
 	struct cbs_sched_data *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
 
-	spin_lock(&cbs_list_lock);
-	list_del(&q->cbs_list);
-	spin_unlock(&cbs_list_lock);
+	/* Nothing to do if we couldn't create the underlying qdisc */
+	if (!q->qdisc)
+		return;
 
 	qdisc_watchdog_cancel(&q->watchdog);
 	cbs_disable_offload(dev, q);
 
-	if (q->qdisc)
-		qdisc_put(q->qdisc);
+	spin_lock(&cbs_list_lock);
+	list_del(&q->cbs_list);
+	spin_unlock(&cbs_list_lock);
+
+	qdisc_put(q->qdisc);
 }
 
 static int cbs_dump(struct Qdisc *sch, struct sk_buff *skb)
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 6c4a7a5938b7..3ab14678afff 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -167,7 +167,7 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 	}
 	if (smc->conn.lgr && smc->conn.lgr->is_smcd &&
 	    (req->diag_ext & (1 << (SMC_DIAG_DMBINFO - 1))) &&
-	    !list_empty(&smc->conn.lgr->list)) {
+	    !list_empty(&smc->conn.lgr->list) && smc->conn.rmb_desc) {
 		struct smc_connection *conn = &smc->conn;
 		struct smcd_diag_dmbinfo dinfo;
 
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index e2d64c7138c3..699d5ba128fa 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -235,8 +235,9 @@ struct rpc_xprt *xprt_iter_current_entry(struct rpc_xprt_iter *xpi)
 	return xprt_switch_find_current_entry(head, xpi->xpi_cursor);
 }
 
-bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
-			      const struct sockaddr *sap)
+static
+bool __rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
+				const struct sockaddr *sap)
 {
 	struct list_head *head;
 	struct rpc_xprt *pos;
@@ -255,6 +256,18 @@ bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
 	return false;
 }
 
+bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
+			      const struct sockaddr *sap)
+{
+	bool res;
+
+	rcu_read_lock();
+	res = __rpc_xprt_switch_has_addr(xps, sap);
+	rcu_read_unlock();
+
+	return res;
+}
+
 static
 struct rpc_xprt *xprt_switch_find_next_entry(struct list_head *head,
 		const struct rpc_xprt *cur)
diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 4353968bc5a5..c7686ff00f5b 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -958,6 +958,12 @@ int tipc_nl_bearer_add(struct sk_buff *skb, struct genl_info *info)
 
 #ifdef CONFIG_TIPC_MEDIA_UDP
 	if (attrs[TIPC_NLA_BEARER_UDP_OPTS]) {
+		if (b->media->type_id != TIPC_MEDIA_TYPE_UDP) {
+			rtnl_unlock();
+			NL_SET_ERR_MSG(info->extack, "UDP option is unsupported");
+			return -EINVAL;
+		}
+
 		err = tipc_udp_nl_bearer_add(b,
 					     attrs[TIPC_NLA_BEARER_UDP_OPTS]);
 		if (err) {
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0632b494d329..7910b9c88d8b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1123,13 +1123,11 @@ static void unix_state_double_lock(struct sock *sk1, struct sock *sk2)
 		unix_state_lock(sk1);
 		return;
 	}
-	if (sk1 < sk2) {
-		unix_state_lock(sk1);
-		unix_state_lock_nested(sk2);
-	} else {
-		unix_state_lock(sk2);
-		unix_state_lock_nested(sk1);
-	}
+	if (sk1 > sk2)
+		swap(sk1, sk2);
+
+	unix_state_lock(sk1);
+	unix_state_lock_nested(sk2, U_LOCK_SECOND);
 }
 
 static void unix_state_double_unlock(struct sock *sk1, struct sock *sk2)
@@ -1348,7 +1346,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out_unlock;
 	}
 
-	unix_state_lock_nested(sk);
+	unix_state_lock_nested(sk, U_LOCK_SECOND);
 
 	if (sk->sk_state != st) {
 		unix_state_unlock(sk);
diff --git a/net/unix/diag.c b/net/unix/diag.c
index 3183d9b8ab33..d6ceac688def 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -80,7 +80,7 @@ static int sk_diag_dump_icons(struct sock *sk, struct sk_buff *nlskb)
 			 * queue lock. With the other's queue locked it's
 			 * OK to lock the state.
 			 */
-			unix_state_lock_nested(req);
+			unix_state_lock_nested(req, U_LOCK_DIAG);
 			peer = unix_sk(req)->peer;
 			buf[i++] = (peer ? sock_i_ino(peer) : 0);
 			unix_state_unlock(req);
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index d871349036a5..dacb9ceee3ef 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1018,8 +1018,12 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 				list_add(&new->hidden_list,
 					 &hidden->hidden_list);
 				hidden->refcount++;
+
+				ies = (void *)rcu_access_pointer(new->pub.beacon_ies);
 				rcu_assign_pointer(new->pub.beacon_ies,
 						   hidden->pub.beacon_ies);
+				if (ies)
+					kfree_rcu(ies, rcu_head);
 			}
 		} else {
 			/*
diff --git a/security/security.c b/security/security.c
index 21c27424a44b..e8a53164e6b5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -890,6 +890,23 @@ int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return call_int_hook(file_ioctl, 0, file, cmd, arg);
 }
 
+/**
+ * security_file_ioctl_compat() - Check if an ioctl is allowed in compat mode
+ * @file: associated file
+ * @cmd: ioctl cmd
+ * @arg: ioctl arguments
+ *
+ * Compat version of security_file_ioctl() that correctly handles 32-bit
+ * processes running on 64-bit kernels.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_file_ioctl_compat(struct file *file, unsigned int cmd,
+			       unsigned long arg)
+{
+	return call_int_hook(file_ioctl_compat, 0, file, cmd, arg);
+}
+
 static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
 {
 	/*
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 749dbf9f2cfc..a6086a6eb693 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3709,6 +3709,33 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	return error;
 }
 
+static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	/*
+	 * If we are in a 64-bit kernel running 32-bit userspace, we need to
+	 * make sure we don't compare 32-bit flags to 64-bit flags.
+	 */
+	switch (cmd) {
+	case FS_IOC32_GETFLAGS:
+		cmd = FS_IOC_GETFLAGS;
+		break;
+	case FS_IOC32_SETFLAGS:
+		cmd = FS_IOC_SETFLAGS;
+		break;
+	case FS_IOC32_GETVERSION:
+		cmd = FS_IOC_GETVERSION;
+		break;
+	case FS_IOC32_SETVERSION:
+		cmd = FS_IOC_SETVERSION;
+		break;
+	default:
+		break;
+	}
+
+	return selinux_file_ioctl(file, cmd, arg);
+}
+
 static int default_noexec;
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
@@ -7054,6 +7081,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
 	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
 	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
 	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
 	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
 	LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 266eb8ca3381..128a5f464740 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4737,6 +4737,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
 	LSM_HOOK_INIT(file_free_security, smack_file_free_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, smack_file_ioctl),
 	LSM_HOOK_INIT(file_lock, smack_file_lock),
 	LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
 	LSM_HOOK_INIT(mmap_file, smack_mmap_file),
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 9f932e2d6852..6d7ea66f634a 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -516,6 +516,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(path_rename, tomoyo_path_rename),
 	LSM_HOOK_INIT(inode_getattr, tomoyo_inode_getattr),
 	LSM_HOOK_INIT(file_ioctl, tomoyo_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, tomoyo_file_ioctl),
 	LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
 	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
 	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e66d8729c72f..94a97832cf0f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2615,6 +2615,8 @@ static const struct pci_device_id azx_ids[] = {
 	/* Icelake */
 	{ PCI_DEVICE(0x8086, 0x34c8),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* Arrow Lake */
+	{ PCI_DEVICE_DATA(INTEL, HDA_ARL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index cfa958dc2dd5..d97d4286c9d7 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -229,6 +229,7 @@ enum {
 	CXT_FIXUP_MUTE_LED_GPIO,
 	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
+	CXT_PINCFG_SWS_JS201D,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -717,6 +718,17 @@ static const struct hda_pintbl cxt_pincfg_lemote[] = {
 	{}
 };
 
+/* SuoWoSi/South-holding JS201D with sn6140 */
+static const struct hda_pintbl cxt_pincfg_sws_js201d[] = {
+	{ 0x16, 0x03211040 }, /* hp out */
+	{ 0x17, 0x91170110 }, /* SPK/Class_D */
+	{ 0x18, 0x95a70130 }, /* Internal mic */
+	{ 0x19, 0x03a11020 }, /* Headset Mic */
+	{ 0x1a, 0x40f001f0 }, /* Not used */
+	{ 0x21, 0x40f001f0 }, /* Not used */
+	{}
+};
+
 static const struct hda_fixup cxt_fixups[] = {
 	[CXT_PINCFG_LENOVO_X200] = {
 		.type = HDA_FIXUP_PINS,
@@ -868,6 +880,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.chained = true,
 		.chain_id = CXT_FIXUP_HEADSET_MIC,
 	},
+	[CXT_PINCFG_SWS_JS201D] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = cxt_pincfg_sws_js201d,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -939,6 +955,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x8457, "HP Z2 G4 mini", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8458, "HP Z2 G4 mini premium", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
+	SND_PCI_QUIRK(0x14f1, 0x0265, "SWS JS201D", CXT_PINCFG_SWS_JS201D),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT_FIXUP_OLPC_XO),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo T410", CXT_PINCFG_LENOVO_TP410),
@@ -978,6 +995,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_FIXUP_MUTE_LED_GPIO, .name = "mute-led-gpio" },
 	{ .id = CXT_FIXUP_HP_MIC_NO_PRESENCE, .name = "hp-mic-fix" },
 	{ .id = CXT_PINCFG_LENOVO_NOTEBOOK, .name = "lenovo-20149" },
+	{ .id = CXT_PINCFG_SWS_JS201D, .name = "sws-js201d" },
 	{}
 };
 
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 37ad3bee66a4..5ec6e9f251c5 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3313,6 +3313,7 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 				    report, SND_JACK_HEADPHONE);
 		snd_soc_jack_report(rt5645->mic_jack,
 				    report, SND_JACK_MICROPHONE);
+		mutex_unlock(&rt5645->jd_mutex);
 		return;
 	case 4:
 		val = snd_soc_component_read32(rt5645->component, RT5645_A_JD_CTRL1) & 0x0020;
diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 2859f107abc8..4260c8b4257b 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -50,11 +50,21 @@ void uniq(struct cmdnames *cmds)
 	if (!cmds->cnt)
 		return;
 
-	for (i = j = 1; i < cmds->cnt; i++)
-		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
-			cmds->names[j++] = cmds->names[i];
-
+	for (i = 1; i < cmds->cnt; i++) {
+		if (!strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
+			zfree(&cmds->names[i - 1]);
+	}
+	for (i = 0, j = 0; i < cmds->cnt; i++) {
+		if (cmds->names[i]) {
+			if (i == j)
+				j++;
+			else
+				cmds->names[j++] = cmds->names[i];
+		}
+	}
 	cmds->cnt = j;
+	while (j < i)
+		cmds->names[j++] = NULL;
 }
 
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)

