Return-Path: <linux-kernel+bounces-61807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 295D08516CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D93D1C22EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1EA3D39A;
	Mon, 12 Feb 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xSawaPic";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QZhkOOp+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J6GLEGtQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G0qU2Bag"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E73A8CD;
	Mon, 12 Feb 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747180; cv=none; b=pybwYbVuNL+8Wd4OC+fFCwy3tshpnq0mjY4IQqJHAVFNSmiMSPhHsUeKW34XgXgtS0AsnxAxk9y62hP80rJ2NrttFpa22cwbDoJTJ9qjdPoeexXf61kVDBjeKfBwigPBD36z7u82POxoLHWY+5Ux7JNbemO5UM3okniDMNMeK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747180; c=relaxed/simple;
	bh=GYhlagCBg897+OGv4+/f3ExmqbsdQnuk2znU7U8INuw=;
	h=Date:Message-ID:From:To:Subject:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2u5+KNdU6yqm3slGfJ1i/ZZZxTmPeMOlYLTt4jap77o3JXEO8BQDBbKIh1g+hTN1r/izOLQW9Xq7UWZNL5LIfTg5oQd8aWJJOwFuuSiKkDKzqnqnr0NlakNtS8KrjsjsdZQJuzCzmdqyH0QUmVeMuB3S6tQaGdjddN1J4mo39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xSawaPic; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QZhkOOp+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J6GLEGtQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G0qU2Bag; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E372E1FBBE;
	Mon, 12 Feb 2024 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707747176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IEu9WkINfW6CP+gZKc/GcleDEcGsj+rgjeQGnih5CQ=;
	b=xSawaPicajxkB2VlHQB+2Ewg0rrn9rZZNdgcBLVU9S3t4kr5ccY4RY0lhoCI++k7Aa0+Ba
	4m0yHt7ITsshYLlrEnkOY4bS4aEJ2WSnXHocfL6YXSOKwvsg5irZm0FJ1fbXJChnXbaKmZ
	2pCBoLKMj6YScez/ShOWqjJmiPfNLG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707747176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IEu9WkINfW6CP+gZKc/GcleDEcGsj+rgjeQGnih5CQ=;
	b=QZhkOOp+wZWvoEr4wz3izNJIa+cQRhZ6wykvR6ae/vILLk/OtVbPCrDGCX3Mmi/6jiRFUe
	UkmJIBU/oS+Yu2DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707747175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IEu9WkINfW6CP+gZKc/GcleDEcGsj+rgjeQGnih5CQ=;
	b=J6GLEGtQsG5czWr+rJBgtHxI0H7A+6SHQdpWTVK9K88IgVS7MR2Z0UrRp7c1X+RG6DBeX+
	y267JAeSmYzoLZua5B6d7eQc9sLKboEU6PvZJn7zvrIN8TLsXe/5j1miBsQ+b2cUg5mEpY
	3/8AUdkbUNnjqYdqJ3k+cTDPkLQVnek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707747175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IEu9WkINfW6CP+gZKc/GcleDEcGsj+rgjeQGnih5CQ=;
	b=G0qU2BagTLoJcuTHl/p/hKUhYJE14BLUJmfqbKPoOFWhhSjOOYq5EUw5/lvGqwbU06krec
	KEOVjnCE5rd/LRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E78612FF7;
	Mon, 12 Feb 2024 14:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0VsUJWcnymVCUAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 12 Feb 2024 14:12:55 +0000
Date: Mon, 12 Feb 2024 15:12:55 +0100
Message-ID: <871q9hwz2w.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Subject: Re: [REGRESSION] Acp5x probing regression introduced between kernel 6.7.2 -> 6.7.4
Cc: stable@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	broonie@kernel.org,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <878r3qxcyr.wl-tiwai@suse.de>
References: <CAD_nV8BG0t7US=+C28kQOR==712MPfZ9m-fuKksgoZCgrEByCw@mail.gmail.com>
	<7a0cd63f-8a83-4dc5-8763-63dcdae8d68a@leemhuis.info>
	<878r3qxcyr.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J6GLEGtQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=G0qU2Bag
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,leemhuis.info:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E372E1FBBE
X-Spam-Level: 
X-Spam-Score: -4.31
X-Spam-Flag: NO

On Mon, 12 Feb 2024 10:13:00 +0100,
Takashi Iwai wrote:
> 
> On Sun, 11 Feb 2024 18:19:25 +0100,
> Linux regression tracking (Thorsten Leemhuis) wrote:
> > 
> > [CCing a few people]
> > 
> > On 11.02.24 15:34, Ted Chang wrote:
> > > 
> > > I noticed 6.7.4  has introduced a regression for the steam deck. The LCD
> > > steam deck can no longer probe the acp5x audio chipset anymore. This
> > > regression does not affect the 6.8.x series.  I did not test kernel
> > > 6.7.3 because Opensuse tumbleweed skipped the update on my machine.
> > 
> > Thx for your report. FWIW, problems like this can be caused by all
> > sorts of changes, but obviously those in the area of audio support
> > are most likely to cause this. There are just a few in the 
> > v6.7.2..v6.7.4 range[1]. Among them a commit that is related to
> > acp5x, that's why I CCed its author as well (Venkata Prasad Potturu). 
> > 
> > Maybe one of the new recipients will have an idea. If not, you most
> > likely will have to bisect this and check if mainline is affected
> > as well.[2]
> > 
> > Ciao, Thorsten
> > 
> > [1]
> > $ git log --oneline  v6.7.2..v6.7.4 sound/ 
> > f3570675bf09af ASoC: codecs: wsa883x: fix PA volume control
> > 2f8e9b77ca2fea ASoC: codecs: lpass-wsa-macro: fix compander volume hack
> > 5b465d6384e4eb ASoC: codecs: wcd938x: fix headphones volume controls
> > 1673211a38012e ASoC: qcom: sc8280xp: limit speaker volumes
> > 242b5bffa23a9c ASoC: codecs: rtq9128: Fix TDM enable and DAI format control flow
> > 2c272ff9859601 ASoC: codecs: rtq9128: Fix PM_RUNTIME usage
> > 4a28302b2c681e ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140
> > e37a96941fdd53 ALSA: hda: intel-dspcfg: add filters for ARL-S and ARL
> > ffa3eea886c6fe ALSA: hda: Intel: add HDA_ARL PCI ID support
> > 4b6986b170f2f2 ASoC: amd: Add new dmi entries for acp5x platform
> 
> This one is the only relevant change, I suppose.
> The machine matches with 'Valve Jupiter'.
> 
> Interestingly, the system seems working with 6.8-rc3, so some piece
> might be missing.  Or simply reverting this patch should fix.

In the bugzilla entry, the reporter confirmed that the revert of the
commit 4b6986b170f2f2 fixed the problem.

#regzbot introduced: 4b6986b170f2f2


Takashi

> 
> 
> Takashi
> 
> > e38ad4ace20b4d ALSA: hda: Refer to correct stream index at loops
> > a434c75e0671f9 soundwire: fix initializing sysfs for same devices on different buses
> >  
> > [2] I'm working on a guide that describes what's needed:
> > https://www.leemhuis.info/files/misc/How%20to%20bisect%20a%20Linux%20kernel%20regression%20%e2%80%94%20The%20Linux%20Kernel%20documentation.html
> > 
> > > Steps to reproduce the problem
> > > 1. Obtain a steam deck
> > > 2. Install kernel 6.7.4
> > > 3. Boot the device and you will see dummy output in gnome shell
> > > 
> > > Observed kernel logs.
> > > 
> > > [    8.755614] cs35l41 spi-VLV1776:00: supply VA not found, using dummy regulator
> > > [    8.760506] cs35l41 spi-VLV1776:00: supply VP not found, using dummy regulator
> > > [    8.777148] cs35l41 spi-VLV1776:00: Cirrus Logic CS35L41 (35a40), Revision: B2
> > > [    8.777471] cs35l41 spi-VLV1776:01: supply VA not found, using dummy regulator
> > > [    8.777532] cs35l41 spi-VLV1776:01: supply VP not found, using dummy regulator
> > > [    8.777709] cs35l41 spi-VLV1776:01: Reset line busy, assuming shared reset
> > > [    8.788465] cs35l41 spi-VLV1776:01: Cirrus Logic CS35L41 (35a40), Revision: B2
> > > [    8.877280] snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
> > > [    8.877595] snd_hda_intel 0000:04:00.1: Handle vga_switcheroo audio client
> > > [    8.889913] snd_acp_pci 0000:04:00.5: enabling device (0000 -> 0002)
> > > [    8.890063] snd_acp_pci 0000:04:00.5: Unsupported device revision:0x50
> > > [    8.890129] snd_acp_pci: probe of 0000:04:00.5 failed with error -22
> > > [    8.906136] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu]
> > > 
> > > 
> > > No kernel module in use shown.
> > > 
> > > 04:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD]
> > > ACP/ACP3X/ACP6x Audio Coprocessor [1022:15e2] (rev 50)
> > > Subsystem: Valve Software Device [1e44:1776]
> > > Flags: fast devsel, IRQ 70, IOMMU group 4
> > > Memory at 80380000 (32-bit, non-prefetchable) [size=256K]
> > > Capabilities: <access denied>
> > > Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x, snd_pci_acp5x,
> > > snd_pci_acp6x, snd_acp_pci, snd_rpl_pci_acp6x, snd_pci_ps,
> > > snd_sof_amd_renoir, snd_sof_amd_rembrandt, snd_sof_amd_vangogh,
> > > snd_sof_amd_acp63
> > > 
> > > 
> > > Information for package kernel-default:
> > > ---------------------------------------
> > > Repository     : openSUSE-Tumbleweed-Oss
> > > Name           : kernel-default
> > > Version        : 6.7.4-1.1
> > > Arch           : x86_64
> > > Vendor         : openSUSE
> > > Installed Size : 240.3 MiB
> > > Installed      : Yes
> > > Status         : up-to-date
> > > Source package : kernel-default-6.7.4-1.1.nosrc
> > > Upstream URL   : https://www.kernel.org/ <https://www.kernel.org/>
> > > Summary        : The Standard Kernel
> > > Description    : 
> > >     The standard kernel for both uniprocessor and multiprocessor systems.
> > > 
> > > 
> > >     Source Timestamp: 2024-02-06 05:32:37 +0000
> > >     GIT Revision: 01735a3e65287585dd830a6a3d33d909a4f9ae7f
> > >     GIT Branch: stable
> > > 
> > > Handle 0x0000, DMI type 0, 26 bytes
> > > BIOS Information
> > > 	Vendor: Valve
> > > 	Version: F7A0120
> > > 	Release Date: 12/01/2023
> > > 	Address: 0xE0000
> > > 	Runtime Size: 128 kB
> > > 	BIOS Revision: 1.20
> > > 	Firmware Revision: 1.16
> > > 
> > > #regzbot introduced: v6.7.2..v6.7.4
> > > 

