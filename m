Return-Path: <linux-kernel+bounces-60880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D7B850A8A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433651C21B10
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9524D5C8E5;
	Sun, 11 Feb 2024 17:19:31 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE86C5C8FB;
	Sun, 11 Feb 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671971; cv=none; b=htfVwN5PBX4smesG5hldRlwBUjQufG6REdsnjmj1IpECHJauguspJ4dNxUUbuDjpCbpfbMqiGqBUdLJS9I/IJjJdnbf2gVYsRs/yFGbbsf3pB9oU+66D5s3kqzWL8LJE7Pkukk91MeDh0U1fx5Ls0ZMJBcLGEi1yiJ37s3LY43I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671971; c=relaxed/simple;
	bh=tmRILceoo1jZqIaugfbYrGkCcLlq2wsdDRgfARcE6Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/a10RBH0XoW16WVhL+3LA7vtfoiy3NZueWeCGfE5YpvncrB7b6uP5tZCIK+j2kIQSwxm/7B7Hk27LL6AzZm3p43MNCEzl9StfZpZIc+CEqYClZvyyOn8/L0njpft8XbHEqOriCkQYUkBrNLjw8XIUxnRnjX0JqTMJ57IWj1qm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rZDUE-0006km-Df; Sun, 11 Feb 2024 18:19:26 +0100
Message-ID: <7a0cd63f-8a83-4dc5-8763-63dcdae8d68a@leemhuis.info>
Date: Sun, 11 Feb 2024 18:19:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Acp5x probing regression introduced between kernel
 6.7.2 -> 6.7.4
Content-Language: en-US, de-DE
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 broonie@kernel.org, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
References: <CAD_nV8BG0t7US=+C28kQOR==712MPfZ9m-fuKksgoZCgrEByCw@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAD_nV8BG0t7US=+C28kQOR==712MPfZ9m-fuKksgoZCgrEByCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707671969;4e117639;
X-HE-SMSGID: 1rZDUE-0006km-Df

[CCing a few people]

On 11.02.24 15:34, Ted Chang wrote:
> 
> I noticed 6.7.4  has introduced a regression for the steam deck. The LCD
> steam deck can no longer probe the acp5x audio chipset anymore. This
> regression does not affect the 6.8.x series.  I did not test kernel
> 6.7.3 because Opensuse tumbleweed skipped the update on my machine.

Thx for your report. FWIW, problems like this can be caused by all
sorts of changes, but obviously those in the area of audio support
are most likely to cause this. There are just a few in the 
v6.7.2..v6.7.4 range[1]. Among them a commit that is related to
acp5x, that's why I CCed its author as well (Venkata Prasad Potturu). 

Maybe one of the new recipients will have an idea. If not, you most
likely will have to bisect this and check if mainline is affected
as well.[2]

Ciao, Thorsten

[1]
$ git log --oneline  v6.7.2..v6.7.4 sound/ 
f3570675bf09af ASoC: codecs: wsa883x: fix PA volume control
2f8e9b77ca2fea ASoC: codecs: lpass-wsa-macro: fix compander volume hack
5b465d6384e4eb ASoC: codecs: wcd938x: fix headphones volume controls
1673211a38012e ASoC: qcom: sc8280xp: limit speaker volumes
242b5bffa23a9c ASoC: codecs: rtq9128: Fix TDM enable and DAI format control flow
2c272ff9859601 ASoC: codecs: rtq9128: Fix PM_RUNTIME usage
4a28302b2c681e ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140
e37a96941fdd53 ALSA: hda: intel-dspcfg: add filters for ARL-S and ARL
ffa3eea886c6fe ALSA: hda: Intel: add HDA_ARL PCI ID support
4b6986b170f2f2 ASoC: amd: Add new dmi entries for acp5x platform
e38ad4ace20b4d ALSA: hda: Refer to correct stream index at loops
a434c75e0671f9 soundwire: fix initializing sysfs for same devices on different buses
 
[2] I'm working on a guide that describes what's needed:
https://www.leemhuis.info/files/misc/How%20to%20bisect%20a%20Linux%20kernel%20regression%20%e2%80%94%20The%20Linux%20Kernel%20documentation.html

> Steps to reproduce the problem
> 1. Obtain a steam deck
> 2. Install kernel 6.7.4
> 3. Boot the device and you will see dummy output in gnome shell
> 
> Observed kernel logs.
> 
> [    8.755614] cs35l41 spi-VLV1776:00: supply VA not found, using dummy regulator
> [    8.760506] cs35l41 spi-VLV1776:00: supply VP not found, using dummy regulator
> [    8.777148] cs35l41 spi-VLV1776:00: Cirrus Logic CS35L41 (35a40), Revision: B2
> [    8.777471] cs35l41 spi-VLV1776:01: supply VA not found, using dummy regulator
> [    8.777532] cs35l41 spi-VLV1776:01: supply VP not found, using dummy regulator
> [    8.777709] cs35l41 spi-VLV1776:01: Reset line busy, assuming shared reset
> [    8.788465] cs35l41 spi-VLV1776:01: Cirrus Logic CS35L41 (35a40), Revision: B2
> [    8.877280] snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
> [    8.877595] snd_hda_intel 0000:04:00.1: Handle vga_switcheroo audio client
> [    8.889913] snd_acp_pci 0000:04:00.5: enabling device (0000 -> 0002)
> [    8.890063] snd_acp_pci 0000:04:00.5: Unsupported device revision:0x50
> [    8.890129] snd_acp_pci: probe of 0000:04:00.5 failed with error -22
> [    8.906136] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu]
> 
> 
> No kernel module in use shown.
> 
> 04:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD]
> ACP/ACP3X/ACP6x Audio Coprocessor [1022:15e2] (rev 50)
> Subsystem: Valve Software Device [1e44:1776]
> Flags: fast devsel, IRQ 70, IOMMU group 4
> Memory at 80380000 (32-bit, non-prefetchable) [size=256K]
> Capabilities: <access denied>
> Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x, snd_pci_acp5x,
> snd_pci_acp6x, snd_acp_pci, snd_rpl_pci_acp6x, snd_pci_ps,
> snd_sof_amd_renoir, snd_sof_amd_rembrandt, snd_sof_amd_vangogh,
> snd_sof_amd_acp63
> 
> 
> Information for package kernel-default:
> ---------------------------------------
> Repository     : openSUSE-Tumbleweed-Oss
> Name           : kernel-default
> Version        : 6.7.4-1.1
> Arch           : x86_64
> Vendor         : openSUSE
> Installed Size : 240.3 MiB
> Installed      : Yes
> Status         : up-to-date
> Source package : kernel-default-6.7.4-1.1.nosrc
> Upstream URL   : https://www.kernel.org/ <https://www.kernel.org/>
> Summary        : The Standard Kernel
> Description    : 
>     The standard kernel for both uniprocessor and multiprocessor systems.
> 
> 
>     Source Timestamp: 2024-02-06 05:32:37 +0000
>     GIT Revision: 01735a3e65287585dd830a6a3d33d909a4f9ae7f
>     GIT Branch: stable
> 
> Handle 0x0000, DMI type 0, 26 bytes
> BIOS Information
> 	Vendor: Valve
> 	Version: F7A0120
> 	Release Date: 12/01/2023
> 	Address: 0xE0000
> 	Runtime Size: 128 kB
> 	BIOS Revision: 1.20
> 	Firmware Revision: 1.16
> 
> #regzbot introduced: v6.7.2..v6.7.4
> 

