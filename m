Return-Path: <linux-kernel+bounces-142233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF188A294C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89058283957
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3850289;
	Fri, 12 Apr 2024 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GByw8LHO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510C822606;
	Fri, 12 Apr 2024 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910421; cv=none; b=MNJCaEDdesNt1W6d7mu2tbY/W94Ivg6wrP8Lf0ViURu5E0C8S59W/gO2omKRjtpa70M2PHPJuhP6suXqucUFrEET110yx7rf0Xhx413/rXYxjqkjfEs3ayn7cVdYRc4M9EK0itokYJcWVBHyWwMswBKXIt1FGfyrTRX3MRthNI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910421; c=relaxed/simple;
	bh=wAqK1RFMLsQcT7up5PkLCQlxlFi9Ys+czrU5oGLqLoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvmBJOElOSS2QluxDQPHH2N7j1OG9vdIlFb/PKpnL/rc9QxnYnouBzZtozrg5A797v8dciG2UslkZ18wwUlCsDwICsy5F/GcXDuJlJB3/3Fpy8cD2JAYQ+NZSC+7KkNwIjFzmdsPkhupvYXqF4FHMlEOec+7KmLf4iGV75BQ05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GByw8LHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B808C113CC;
	Fri, 12 Apr 2024 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712910420;
	bh=wAqK1RFMLsQcT7up5PkLCQlxlFi9Ys+czrU5oGLqLoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GByw8LHO2RBVmqjmyc42dp1WMA7H2vaIDuhjJvDFbVfTVNeyXlhpDZBNuZTsmyhXp
	 ZlQ6ZLcgOW5lvuBA8avB9vQ+2yzh4Uzqmt++AE91mTIwxE8ty8bU3HyOWFSxQbz6Dd
	 2ni5EITMX8A8PDcqmdC0wklPougWNJ+XnY2rxPzE=
Date: Fri, 12 Apr 2024 10:26:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
Message-ID: <2024041248-applicant-online-629c@gregkh>
References: <20240411095420.903937140@linuxfoundation.org>
 <0386180b-d01d-81d6-bb7b-d6641ab4d719@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0386180b-d01d-81d6-bb7b-d6641ab4d719@applied-asynchrony.com>

On Thu, Apr 11, 2024 at 09:34:41PM +0200, Holger Hoffstätte wrote:
> On 2024-04-11 11:54, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.8.6 release.
> > There are 143 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> With this -rc1 I see the following WARNING noise on my AMD Zen2 Thinkpad
> during boot:
> 
> --snip--
> Apr 11 16:08:45 hho kernel: [drm] Initialized amdgpu 3.57.0 20150101 for 0000:06:00.0 on minor 0
> Apr 11 16:08:45 hho kernel: ------------[ cut here ]------------
> Apr 11 16:08:45 hho kernel: amdgpu 0000:06:00.0: drm_WARN_ON_ONCE(!dev->mode_config.poll_enabled)
> Apr 11 16:08:45 hho kernel: WARNING: CPU: 10 PID: 728 at drivers/gpu/drm/drm_probe_helper.c:305 drm_kms_helper_poll_enable+0x129/0x130 [drm_kms_helper]
> Apr 11 16:08:45 hho kernel: Modules linked in: sch_fq_codel bpf_preload uvcvideo videobuf2_vmalloc videobuf2_memops uvc videobuf2_v4l2 mousedev videodev videobuf2_common mc snd_ctl_led snd_hda_codec_realtek iwlmvm amdgpu(+) snd_hda_codec_generic mac80211 libarc4 snd_hda_codec_hdmi pkcs8_key_parser edac_mce_amd i2c_algo_bit drm_ttm_helper crct10dif_pclmul crc32_pclmul crc32c_intel ttm snd_hda_intel ghash_clmulni_intel drm_exec snd_intel_dspcfg sha512_ssse3 drm_suballoc_helper amdxcp sha256_ssse3 snd_hda_codec drm_buddy gpu_sched sha1_ssse3 snd_hwdep iwlwifi snd_hda_core lm92 drm_display_helper thinkpad_acpi snd_pcm cec snd_rn_pci_acp3x ledtrig_audio snd_timer wmi_bmof drivetemp drm_kms_helper psmouse rapl r8169 platform_profile snd_acp_config cfg80211 serio_raw realtek k10temp snd_soc_acpi ipmi_devintf snd ucsi_acpi mdio_devres drm snd_pci_acp3x i2c_piix4 soundcore rfkill typec_ucsi ipmi_msghandler libphy video roles typec battery ac wmi i2c_scmi button
> Apr 11 16:08:45 hho kernel: CPU: 10 PID: 728 Comm: (udev-worker) Not tainted 6.8.6 #1
> Apr 11 16:08:45 hho kernel: Hardware name: LENOVO 20U50001GE/20U50001GE, BIOS R19ET32W (1.16 ) 01/26/2021
> Apr 11 16:08:45 hho kernel: RIP: 0010:drm_kms_helper_poll_enable+0x129/0x130 [drm_kms_helper]
> Apr 11 16:08:45 hho kernel: Code: 48 8b 5f 50 48 85 db 75 03 48 8b 1f e8 90 58 f8 e0 48 c7 c1 a0 0a 67 a0 48 89 da 48 c7 c7 84 14 67 a0 48 89 c6 e8 27 b2 a6 e0 <0f> 0b e9 08 ff ff ff 0f 1f 44 00 00 48 b8 e0 ff ff ff 0f 00 00 00
> Apr 11 16:08:45 hho kernel: RSP: 0018:ffffc900005ff918 EFLAGS: 00010296
> Apr 11 16:08:45 hho kernel: RAX: 0000000000000045 RBX: ffff88810173c5b0 RCX: 0000000000000027
> Apr 11 16:08:45 hho kernel: RDX: ffff8887ef69c6c8 RSI: 0000000000000001 RDI: ffff8887ef69c6c0
> Apr 11 16:08:45 hho kernel: RBP: 0000000000000000 R08: 00000000fffeffff R09: 0000000000000001
> Apr 11 16:08:45 hho kernel: R10: 0000000000000000 R11: ffff8887eec80000 R12: ffff88810e380010
> Apr 11 16:08:45 hho kernel: R13: ffff88810e380010 R14: 0000000000000003 R15: ffffffffa03b69ce
> Apr 11 16:08:45 hho kernel: FS:  00007f7472869800(0000) GS:ffff8887ef680000(0000) knlGS:0000000000000000
> Apr 11 16:08:45 hho kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Apr 11 16:08:45 hho kernel: CR2: 00005607b50f5000 CR3: 0000000104f3e000 CR4: 0000000000350ef0
> Apr 11 16:08:45 hho kernel: Call Trace:
> Apr 11 16:08:45 hho kernel:  <TASK>
> Apr 11 16:08:45 hho kernel:  ? drm_kms_helper_poll_enable+0x129/0x130 [drm_kms_helper]
> Apr 11 16:08:45 hho kernel:  ? __warn+0x7d/0x120
> Apr 11 16:08:45 hho kernel:  ? drm_kms_helper_poll_enable+0x129/0x130 [drm_kms_helper]
> Apr 11 16:08:45 hho kernel:  ? report_bug+0x155/0x180
> Apr 11 16:08:45 hho kernel:  ? handle_bug+0x36/0x70
> Apr 11 16:08:45 hho kernel:  ? exc_invalid_op+0x13/0x60
> Apr 11 16:08:45 hho kernel:  ? asm_exc_invalid_op+0x16/0x20
> Apr 11 16:08:45 hho kernel:  ? drm_kms_helper_poll_enable+0x129/0x130 [drm_kms_helper]
> Apr 11 16:08:45 hho kernel:  ? drm_kms_helper_poll_enable+0x129/0x130 [drm_kms_helper]
> Apr 11 16:08:45 hho kernel:  drm_helper_probe_single_connector_modes+0x167/0x4f0 [drm_kms_helper]
> Apr 11 16:08:45 hho kernel:  drm_client_modeset_probe+0x1e0/0x1350 [drm]
> Apr 11 16:08:45 hho kernel:  ? __cond_resched+0x16/0x40
> Apr 11 16:08:45 hho kernel:  ? kmalloc_trace+0xfd/0x280
> Apr 11 16:08:45 hho kernel:  ? __pm_runtime_suspend+0x67/0xb0
> Apr 11 16:08:45 hho kernel:  __drm_fb_helper_initial_config_and_unlock+0x2d/0x490 [drm_kms_helper]
> Apr 11 16:08:45 hho kernel:  ? drm_file_alloc+0x1af/0x250 [drm]
> Apr 11 16:08:45 hho kernel:  ? __cond_resched+0x16/0x40
> Apr 11 16:08:45 hho kernel:  drm_fbdev_generic_client_hotplug+0x62/0xb0 [drm_kms_helper]
> Apr 11 16:08:45 hho kernel:  drm_client_register+0x5a/0x90 [drm]
> Apr 11 16:08:45 hho kernel:  amdgpu_pci_probe+0x465/0x4d0 [amdgpu]
> Apr 11 16:08:45 hho kernel:  local_pci_probe+0x39/0x80
> Apr 11 16:08:45 hho kernel:  pci_device_probe+0xa1/0x1b0
> Apr 11 16:08:45 hho kernel:  really_probe+0x156/0x2e0
> Apr 11 16:08:45 hho kernel:  ? __device_attach_driver+0x100/0x100
> Apr 11 16:08:45 hho kernel:  __driver_probe_device+0x73/0x110
> Apr 11 16:08:45 hho kernel:  driver_probe_device+0x1f/0xe0
> Apr 11 16:08:45 hho kernel:  __driver_attach+0x7d/0x180
> Apr 11 16:08:45 hho kernel:  bus_for_each_dev+0x60/0x90
> Apr 11 16:08:45 hho kernel:  bus_add_driver+0xe4/0x1e0
> Apr 11 16:08:45 hho kernel:  driver_register+0x55/0xf0
> Apr 11 16:08:45 hho kernel:  ? 0xffffffffa020a000
> Apr 11 16:08:45 hho kernel:  do_one_initcall+0x41/0x1c0
> Apr 11 16:08:45 hho kernel:  ? kmalloc_trace+0x1d5/0x280
> Apr 11 16:08:45 hho kernel:  do_init_module+0x60/0x230
> Apr 11 16:08:45 hho kernel:  init_module_from_file+0x79/0xb0
> Apr 11 16:08:45 hho kernel:  __x64_sys_finit_module+0x155/0x280
> Apr 11 16:08:45 hho kernel:  do_syscall_64+0x49/0x110
> Apr 11 16:08:45 hho kernel:  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> Apr 11 16:08:45 hho kernel: RIP: 0033:0x7f7472a740e9
> Apr 11 16:08:45 hho kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 07 ed 0c 00 f7 d8 64 89 01 48
> Apr 11 16:08:45 hho kernel: RSP: 002b:00007ffcff3f42d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> Apr 11 16:08:45 hho kernel: RAX: ffffffffffffffda RBX: 0000564f9b3f5d50 RCX: 00007f7472a740e9
> Apr 11 16:08:45 hho kernel: RDX: 0000000000000004 RSI: 00007f7472c50369 RDI: 0000000000000017
> Apr 11 16:08:45 hho kernel: RBP: 0000000000000004 R08: 00007f7472b43b20 R09: 0000564f9b3af700
> Apr 11 16:08:45 hho kernel: R10: 0000000000000050 R11: 0000000000000246 R12: 00007f7472c50369
> Apr 11 16:08:45 hho kernel: R13: 0000000000020000 R14: 0000564f9b41d6b0 R15: 0000000000000000
> Apr 11 16:08:45 hho kernel:  </TASK>
> Apr 11 16:08:45 hho kernel: ---[ end trace 0000000000000000 ]---
> Apr 11 16:08:45 hho kernel: fbcon: amdgpudrmfb (fb0) is primary device
> --snap--
> 
> This is due to "drm-check-output-polling-initialized-before-disablin.patch" which
> needs a followup patch to work properly, otherwise the above drm_WARN_ON_ONCE
> always fires for the wrong reason.
> 
> The commit in mainline is:
> 
> 048a36d8a608 "drm: Check polling initialized before enabling in drm_helper_probe_single_connector_modes"
> 
> With that commit amdgpu initialisation is happy again: no more WARN_ON_ONCE on boot.

Thanks, now queued up here, and in 6.6.y

greg k-h

