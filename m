Return-Path: <linux-kernel+bounces-12219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8015581F17C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3302B283C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBDB46B88;
	Wed, 27 Dec 2023 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="iU2uRpkY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8E1E52B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=n/9nnWnRZ0rimxBlp0vSyLr4rtsMJ7FSkkGqraZvLKI=; b=iU2uRpkY373lNHg703bjxe3fRQ
	Qf/qwQ72U2JKK6U+FV1dRSAk3ZxdwArZoHIWg61bBp2JoM2qPgLNB1bVIyrhzN3x2BQ7iK9ie55UY
	VDmpOvadZuEPCpOYU+jgWFkj0IfqbokpWzmg5tOJf2CdVbTR+K3qlw+Zd+OSH6njDNmLKbUhtI22d
	M/Bwx49pdm3J1jksdYbjGYoEpQ+1NM3hg0AkgKqJ7JR37Cj+4UbP2Mzq6Nj4fWqKzG6PYCt/xsW3y
	eSYkGny+GNdPTpZwkw5U4CnF9A2rlm8AjanCjJN/4vCCDB11KIjKke89YoRrQbaKsarnJvDifHazo
	geRJzsRQ==;
Received: from lfbn-idf3-1-20-89.w81-249.abo.wanadoo.fr ([81.249.147.89]:40104 helo=merlin.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rIZAJ-00019z-Oj by authid <merlins.org> with srv_auth_plain; Wed, 27 Dec 2023 11:02:03 -0800
Received: from merlin by merlin.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1rIZAI-0002RZ-0i;
	Wed, 27 Dec 2023 11:02:02 -0800
Date: Wed, 27 Dec 2023 11:02:02 -0800
From: Marc MERLIN <marc@merlins.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: sof-audio-pci-intel-tgl/soundwire 6.6.8 kernel outputs no sound
 on speakers but works on headphones
Message-ID: <ZYx0qurc3PfaxfT5@merlins.org>
References: <20231223234430.GA11359@merlins.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231223234430.GA11359@merlins.org>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 81.249.147.89
X-SA-Exim-Mail-From: marc@merlins.org

I'm still stuck with no sound :-/
I did more testing and 6.5.0-14-generic from ubuntu gives sound when I
boot it in ubuntu 23, but the same kernel in debian 12, seems to load
but gives a device that only gives sound via headphones. Nothing through
the speakers, and they are not muted (as checked in alsamixer)

I ran a diff between dmesg between the 2 boots, and I do see when
running the same kernel in debian12:
input: sof-soundwire Headset Jack as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input27
input: sof-soundwire HDMI/DP,pcm=5 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input28
input: sof-soundwire HDMI/DP,pcm=6 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input29
input: sof-soundwire HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input30
sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 0x60010000 (msg/reply size: 108/20): -5
sof-audio-pci-intel-tgl 0000:00:1f.3: HW params ipc failed for stream 1
sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at snd_soc_pcm_component_hw_params on 0000:00:1f.3: -5
sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 0x60010000 (msg/reply size: 108/20): -5
sof-audio-pci-intel-tgl 0000:00:1f.3: HW params ipc failed for stream 1
sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at snd_soc_pcm_component_hw_params on 0000:00:1f.3: -5
sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 0x60010000 (msg/reply size: 108/20): -5
sof-audio-pci-intel-tgl 0000:00:1f.3: HW params ipc failed for stream 1
sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at snd_soc_pcm_component_hw_params on 0000:00:1f.3: -5
sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 0x60010000 (msg/reply size: 108/20): -5
sof-audio-pci-intel-tgl 0000:00:1f.3: HW params ipc failed for stream 1
sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at snd_soc_pcm_component_hw_params on 0000:00:1f.3: -5
sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 0x60010000 (msg/reply size: 108/20): -5
sof-audio-pci-intel-tgl 0000:00:1f.3: HW params ipc failed for stream 1


merlin:/boot/sound# dmesg |grep intel-tgl
[   14.629851] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040100
[   14.631966] sof-audio-pci-intel-tgl 0000:00:1f.3: SoundWire enabled on CannonLake+ platform, using SOF driver
[   14.633819] sof-audio-pci-intel-tgl 0000:00:1f.3: enabling device (0000 -> 0002)
[   14.635615] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040100
[   14.637179] sof-audio-pci-intel-tgl 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[   14.650766] sof-audio-pci-intel-tgl 0000:00:1f.3: use msi interrupt mode
[   14.668269] sof-audio-pci-intel-tgl 0000:00:1f.3: hda codecs found, mask 4
[   14.674395] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
[   14.675880] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
[   14.677283] sof-audio-pci-intel-tgl 0000:00:1f.3: unknown sof_ext_man header type 3 size 0x30
[   14.771750] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
[   14.773456] sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
[   14.791223] sof-audio-pci-intel-tgl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:0
[   23.851544] sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 0x60010000 (msg/reply size: 108/20): -5
[   23.851573] sof-audio-pci-intel-tgl 0000:00:1f.3: HW params ipc failed for stream 1
[   23.851575] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at snd_soc_pcm_component_hw_params on 0000:00:1f.3: -5
[   23.852609] sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 0x60010000 (msg/reply size: 108/20): -5
[   23.852622] sof-audio-pci-intel-tgl 0000:00:1f.3: HW params ipc failed for stream 1
[   23.852630] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at snd_soc_pcm_component_hw_params on 0000:00:1f.3: -5
[   23.853634] sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 0x60010000 (msg/reply size: 108/20): -5
[   23.853645] sof-audio-pci-intel-tgl 0000:00:1f.3: HW params ipc failed for stream 1
[   23.853653] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at snd_soc_pcm_component_hw_params on 0000:00:1f.3: -5
[   23.854644] sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 0x60010000 (msg/reply size: 108/20): -5
[   23.854646] sof-audio-pci-intel-tgl 0000:00:1f.3: HW params ipc failed for stream 1
(...) many lines deleted

I realize that userspace is different and it could be a problem
with pipewire and wireplumber, but the ASoC errors above look
like a kernel issue. What do you think?


merlin:/boot/sound$ diff -u inxi_aA_*
--- inxi_aA_deb	2023-12-27 08:22:43.869118470 -0800
+++ inxi_aA_ubnt	2023-12-27 09:23:06.442760237 -0800
@@ -1,9 +1,10 @@
 Audio:
-  Device-1: Intel vendor: Dell driver: sof-audio-pci-intel-tgl
+  Device-1: Intel Raptor Lake-P/U/H cAVS vendor: Dell
+    driver: sof-audio-pci-intel-tgl
     alternate: snd_hda_intel,snd_sof_pci_intel_tgl bus-ID: 0000:00:1f.3
     chip-ID: 8086:51ca class-ID: 0401
-  API: ALSA v: k6.5.0-14-generic status: kernel-api with: aoss
-    type: oss-emulator tools: alsamixer,amixer
-  Server-1: PipeWire v: 0.3.65 status: active with: 1: pipewire-pulse
+  API: ALSA v: k6.5.0-14-generic status: kernel-api
+    tools: alsactl,alsamixer,amixer
+  Server-1: PipeWire v: 0.3.79 status: active with: 1: pipewire-pulse
     status: active 2: wireplumber status: active 3: pipewire-alsa type: plugin
-    4: pw-jack type: plugin tools: pactl,pw-cat,pw-cli,wpctl
+    tools: pw-cat,pw-cli,wpctl

merlin:/boot/sound$ diff -u wpctl_status_*
shows
 Audio
  ├─ Devices:
  │      44. sof-soundwire                       [alsa]
  │  
  ├─ Sinks:
- │  *   53. sof-soundwire Stereo                [vol: 1.00]
+ │      45. sof-soundwire HDMI / DisplayPort 3 Output [vol: 1.00]
+ │      46. sof-soundwire HDMI / DisplayPort 2 Output [vol: 1.00]
+ │      47. sof-soundwire HDMI / DisplayPort 1 Output [vol: 1.00]
+ │      48. sof-soundwire Headphones            [vol: 1.00]
+ │  *   49. sof-soundwire Speaker               [vol: 0.90]
  │  
  ├─ Sink endpoints:
  │  
  ├─ Sources:
+ │      50. sof-soundwire Headset Microphone    [vol: 1.00]
+ │  *   51. sof-soundwire SoundWire microphones [vol: 0.76]

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

