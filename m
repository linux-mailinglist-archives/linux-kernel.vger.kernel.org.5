Return-Path: <linux-kernel+bounces-74916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 335B585DFFB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF37288838
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81BA7FBA3;
	Wed, 21 Feb 2024 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0SIR5uir";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tOZDWPpL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0SIR5uir";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tOZDWPpL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E77F7FF;
	Wed, 21 Feb 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526363; cv=none; b=ZeOFlPqCKAW0iqDBKhH/94TV6mc/E8xNZ8NFaQKQ2LJb9shAFJeVmNnZgitQTrsDe8rRd5cyNmkerz6qUFY+R3m4vjndHTmxIXjzSVXy0X4CHsO0XA5Wv++1P2QJrMBWJ9nX6NAq36VuORc0wTAl/yXgeT35OFoDajcpSWqRiII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526363; c=relaxed/simple;
	bh=Zn0BseuQkmmh6vAFvy7pHLwUNwBkUXzj8zV8iLPjIos=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=DMWcgm/0WdS2/b/X05uJ80tgY+xgsNr05UurY/5xuy2XuwwsTkKAgZFnmyAa8wX8fkBZ9whK1AyzwOW0uEgOJ8HdVSa95dBnATH8PhNx1nhE9OwfMrRqWmrgKS9jTFzL6D2J3wvYqMXuRY/PCPmhYa1Q5z2hgttNnIS47yT5ekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0SIR5uir; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tOZDWPpL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0SIR5uir; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tOZDWPpL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AECB61FB61;
	Wed, 21 Feb 2024 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708526356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6RAoZrdFXkqE1k2+e20CrnN2FndK5vpgXvjb5BS0aZQ=;
	b=0SIR5uirwc712vPOS/DWARtvti9lslaFoMz28UlPgO5hOnjkMRolsGMhNU0SN+uymeOBoa
	aq1z5s4HA6oiaLTbL8iDWE3od7szP2Y/R2DMVuNri2qxZUQO1AyfX4sVB9kAQwQFxMeKT1
	Rlm2K9fK8+92BC8jGvAKIrBdXKQwLQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708526356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6RAoZrdFXkqE1k2+e20CrnN2FndK5vpgXvjb5BS0aZQ=;
	b=tOZDWPpLAw1q4inRnkK1EIVuwIc6OW0d5BeV/uOCbZup1eUtFSQ0YD4/cgYofiu8c2Afqb
	ppg9oumkBP2JXoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708526356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6RAoZrdFXkqE1k2+e20CrnN2FndK5vpgXvjb5BS0aZQ=;
	b=0SIR5uirwc712vPOS/DWARtvti9lslaFoMz28UlPgO5hOnjkMRolsGMhNU0SN+uymeOBoa
	aq1z5s4HA6oiaLTbL8iDWE3od7szP2Y/R2DMVuNri2qxZUQO1AyfX4sVB9kAQwQFxMeKT1
	Rlm2K9fK8+92BC8jGvAKIrBdXKQwLQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708526356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6RAoZrdFXkqE1k2+e20CrnN2FndK5vpgXvjb5BS0aZQ=;
	b=tOZDWPpLAw1q4inRnkK1EIVuwIc6OW0d5BeV/uOCbZup1eUtFSQ0YD4/cgYofiu8c2Afqb
	ppg9oumkBP2JXoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94D9513A69;
	Wed, 21 Feb 2024 14:39:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wpqYIxQL1mX3BQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 21 Feb 2024 14:39:16 +0000
Message-ID: <96481a45-3547-4d23-ad34-3a8f1d90c1cd@suse.cz>
Date: Wed, 21 Feb 2024 15:39:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Linux Wireless <linux-wireless@vger.kernel.org>,
 ath11k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: ath11k allocation failure on resume breaking wifi until power cycle
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0SIR5uir;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tOZDWPpL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: AECB61FB61
X-Spam-Flag: NO

Hi,

starting with 6.8 rc series, I'm experiencing problems on resume from s2i=
dle
on my laptop, which is Lenovo T14s Gen3:

LENOVO 21CRS0K63K/21CRS0K63K, BIOS R22ET65W (1.35 )
ath11k_pci 0000:01:00.0: wcn6855 hw2.1
ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_i=
d 0x400c1211
ath11k_pci 0000:01:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01=
-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3=
=2E6510.37

The problem is an allocation failure happening on resume from s2idle. Aft=
er
that the wifi stops working and even a reboot won't fix it, only a
poweroff/poweron cycle of the laptop.

This is order 4 (costly order), GFP_NOIO (maybe it's originally GFP_KERNE=
L
but we restrict to GFP_NOIO during resume) allocation, thus it's impossib=
le
to do memory compaction and the page allocator gives up. Such high-order
allocations should have a fallback using smaller pages, or maybe it could=
 at
least retry once the restricted GFP_NOIO context is gone.

I don't know why it never happened before 6.8, didn't spot anything obvio=
us
and it happens too unreliably to go bisect. Any idea?

Thanks,
Vlastimil

[732882.110209] PM: suspend entry (s2idle)
[732882.139804] Filesystems sync: 0.029 seconds
[732882.438176] Freezing user space processes
[732882.441755] Freezing user space processes completed (elapsed 0.003 se=
conds)
[732882.441760] OOM killer disabled.
[732882.441762] Freezing remaining freezable tasks
[732882.444088] Freezing remaining freezable tasks completed (elapsed 0.0=
02 seconds)
[732882.444092] printk: Suspending console(s) (use no_console_suspend to =
debug)
[732884.655267] ACPI: EC: interrupt blocked
[761943.498644] ACPI: EC: interrupt unblocked
[761943.669927] [drm] PCIE GART of 1024M enabled (table at 0x000000F43FC0=
0000).
[761943.669980] amdgpu 0000:33:00.0: amdgpu: SMU is resuming...
[761943.672444] amdgpu 0000:33:00.0: amdgpu: SMU is resumed successfully!=

[761943.686840] nvme nvme0: 16/0/0 default/read/poll queues
[761943.824606] mhi mhi0: Requested to power ON
[761943.824625] mhi mhi0: Power on setup success
[761943.916072] [drm] VCN decode and encode initialized successfully(unde=
r DPG Mode).
[761943.916162] [drm] JPEG decode initialized successfully.
[761943.916171] amdgpu 0000:33:00.0: amdgpu: ring gfx_0.0.0 uses VM inv e=
ng 0 on hub 0
[761943.916176] amdgpu 0000:33:00.0: amdgpu: ring comp_1.0.0 uses VM inv =
eng 1 on hub 0
[761943.916178] amdgpu 0000:33:00.0: amdgpu: ring comp_1.1.0 uses VM inv =
eng 4 on hub 0
[761943.916181] amdgpu 0000:33:00.0: amdgpu: ring comp_1.2.0 uses VM inv =
eng 5 on hub 0
[761943.916183] amdgpu 0000:33:00.0: amdgpu: ring comp_1.3.0 uses VM inv =
eng 6 on hub 0
[761943.916185] amdgpu 0000:33:00.0: amdgpu: ring comp_1.0.1 uses VM inv =
eng 7 on hub 0
[761943.916187] amdgpu 0000:33:00.0: amdgpu: ring comp_1.1.1 uses VM inv =
eng 8 on hub 0
[761943.916189] amdgpu 0000:33:00.0: amdgpu: ring comp_1.2.1 uses VM inv =
eng 9 on hub 0
[761943.916191] amdgpu 0000:33:00.0: amdgpu: ring comp_1.3.1 uses VM inv =
eng 10 on hub 0
[761943.916194] amdgpu 0000:33:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv=
 eng 11 on hub 0
[761943.916196] amdgpu 0000:33:00.0: amdgpu: ring sdma0 uses VM inv eng 1=
2 on hub 0
[761943.916198] amdgpu 0000:33:00.0: amdgpu: ring vcn_dec_0 uses VM inv e=
ng 0 on hub 8
[761943.916200] amdgpu 0000:33:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv=
 eng 1 on hub 8
[761943.916201] amdgpu 0000:33:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv=
 eng 4 on hub 8
[761943.916203] amdgpu 0000:33:00.0: amdgpu: ring jpeg_dec uses VM inv en=
g 5 on hub 8
[761944.187417] mhi mhi0: Wait for device to enter SBL or Mission mode
[761945.327441] kworker/u32:45: page allocation failure: order:4, mode:0x=
40c00(GFP_NOIO|__GFP_COMP), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0=

[761945.327467] CPU: 0 PID: 19318 Comm: kworker/u32:45 Not tainted 6.8.0-=
rc3-1.gae4495f-default #1 openSUSE Tumbleweed (unreleased) 493b6d5b382c60=
3654d7a81fc3c144d59a1dfceb
[761945.327473] Hardware name: LENOVO 21CRS0K63K/21CRS0K63K, BIOS R22ET65=
W (1.35 ) 08/08/2023
[761945.327477] Workqueue: events_unbound async_run_entry_fn
[761945.327488] Call Trace:
[761945.327493]  <TASK>
[761945.327501]  dump_stack_lvl+0x47/0x60
[761945.327514]  warn_alloc+0x13a/0x1b0
[761945.327525]  ? srso_alias_return_thunk+0x5/0xfbef5
[761945.327533]  ? __alloc_pages_direct_compact+0xab/0x210
[761945.327540]  __alloc_pages_slowpath.constprop.0+0xd3e/0xda0
[761945.327551]  __alloc_pages+0x32d/0x350
[761945.327563]  ? mhi_prepare_channel+0x127/0x2d0 [mhi 40df44e07c05479f7=
a6e7b90fba9f0e0031a7814]
[761945.327580]  __kmalloc_large_node+0x72/0x110
[761945.327589]  __kmalloc+0x37c/0x480
[761945.327594]  ? mhi_map_single_no_bb+0x77/0xf0 [mhi 40df44e07c05479f7a=
6e7b90fba9f0e0031a7814]
[761945.327608]  ? mhi_prepare_channel+0x127/0x2d0 [mhi 40df44e07c05479f7=
a6e7b90fba9f0e0031a7814]
[761945.327618]  mhi_prepare_channel+0x127/0x2d0 [mhi 40df44e07c05479f7a6=
e7b90fba9f0e0031a7814]
[761945.327633]  __mhi_prepare_for_transfer+0x44/0x80 [mhi 40df44e07c0547=
9f7a6e7b90fba9f0e0031a7814]
[761945.327644]  ? __pfx_____mhi_prepare_for_transfer+0x10/0x10 [mhi 40df=
44e07c05479f7a6e7b90fba9f0e0031a7814]
[761945.327654]  device_for_each_child+0x5c/0xa0
[761945.327663]  ? __pfx_pci_pm_resume+0x10/0x10
[761945.327675]  ath11k_core_resume+0x65/0x100 [ath11k a5094e22d7223135c4=
0d93c8f5321cf09fd85e4e]
[761945.327701]  ? srso_alias_return_thunk+0x5/0xfbef5
[761945.327708]  ath11k_pci_pm_resume+0x32/0x60 [ath11k_pci 830b7bfc3ea80=
ebef32e563cafe2cb55e9cc73ec]
[761945.327716]  ? srso_alias_return_thunk+0x5/0xfbef5
[761945.327720]  dpm_run_callback+0x8c/0x1e0
[761945.327730]  device_resume+0x104/0x340
[761945.327735]  ? __pfx_dpm_watchdog_handler+0x10/0x10
[761945.327741]  async_resume+0x1d/0x30
[761945.327746]  async_run_entry_fn+0x32/0x120
[761945.327749]  process_one_work+0x168/0x330
[761945.327756]  worker_thread+0x2f5/0x410
[761945.327762]  ? __pfx_worker_thread+0x10/0x10
[761945.327764]  kthread+0xe8/0x120
[761945.327771]  ? __pfx_kthread+0x10/0x10
[761945.327775]  ret_from_fork+0x34/0x50
[761945.327783]  ? __pfx_kthread+0x10/0x10
[761945.327786]  ret_from_fork_asm+0x1b/0x30
[761945.327797]  </TASK>
[761945.327799] Mem-Info:
[761945.327802] active_anon:85190 inactive_anon:2100593 isolated_anon:0
                 active_file:218016 inactive_file:72616 isolated_file:0
                 unevictable:4 dirty:16 writeback:0
                 slab_reclaimable:65077 slab_unreclaimable:61659
                 mapped:215500 shmem:119880 pagetables:26327
                 sec_pagetables:0 bounce:0
                 kernel_misc_reclaimable:0
                 free:215403 free_pcp:0 free_cma:0
[761945.327810] Node 0 active_anon:340760kB inactive_anon:8402372kB activ=
e_file:872064kB inactive_file:290464kB unevictable:16kB isolated(anon):0k=
B isolated(file):0kB mapped:862000kB dirty:64kB writeback:0kB shmem:47952=
0kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:858112kB writeback_tmp:0kB=
 kernel_stack:39728kB pagetables:105308kB sec_pagetables:0kB all_unreclai=
mable? no
[761945.327817] Node 0 DMA free:9728kB boost:0kB min:68kB low:84kB high:1=
00kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_fil=
e:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB =
managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cm=
a:0kB
[761945.327824] lowmem_reserve[]: 0 1702 14665 14665 14665
[761945.327831] Node 0 DMA32 free:77516kB boost:17620kB min:25456kB low:2=
7412kB high:29368kB reserved_highatomic:0KB active_anon:8568kB inactive_a=
non:823088kB active_file:50028kB inactive_file:22392kB unevictable:0kB wr=
itepending:0kB present:1863376kB managed:1797148kB mlocked:0kB bounce:0kB=
 free_pcp:0kB local_pcp:0kB free_cma:0kB
[761945.327838] lowmem_reserve[]: 0 0 12962 12962 12962
[761945.327844] Node 0 Normal free:774368kB boost:134256kB min:193928kB l=
ow:208844kB high:223760kB reserved_highatomic:2048KB active_anon:332192kB=
 inactive_anon:7579284kB active_file:822036kB inactive_file:268072kB unev=
ictable:16kB writepending:64kB present:13601792kB managed:13281984kB mloc=
ked:16kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[761945.327851] lowmem_reserve[]: 0 0 0 0 0
[761945.327856] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*25=
6kB 1*512kB (U) 1*1024kB (U) 2*2048kB (UM) 1*4096kB (M) =3D 9728kB
[761945.327876] Node 0 DMA32: 9173*4kB (UME) 3963*8kB (UME) 556*16kB (UME=
) 5*32kB (U) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D=
 77452kB
[761945.327894] Node 0 Normal: 141767*4kB (UME) 25812*8kB (UME) 6*16kB (U=
M) 10*32kB (U) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
=3D 773980kB
[761945.327913] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_s=
urp=3D0 hugepages_size=3D1048576kB
[761945.327916] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_s=
urp=3D0 hugepages_size=3D2048kB
[761945.327918] 418102 total pagecache pages
[761945.327920] 7560 pages in swap cache
[761945.327921] Free swap  =3D 15019516kB
[761945.327922] Total swap =3D 15097852kB
[761945.327923] 3870291 pages RAM
[761945.327924] 0 pages HighMem/MovableOnly
[761945.327925] 96668 pages reserved
[761945.327926] 0 pages cma reserved
[761945.327927] 0 pages hwpoisoned
[761945.329521] ath11k_pci 0000:01:00.0: failed to resume hif during resu=
me: -12
[761945.329532] ath11k_pci 0000:01:00.0: failed to resume core: -12
[761945.329534] ath11k_pci 0000:01:00.0: PM: dpm_run_callback(): pci_pm_r=
esume+0x0/0xf0 returns -12
[761945.329555] ath11k_pci 0000:01:00.0: PM: failed to resume async: erro=
r -12
[761948.524212] ath11k_pci 0000:01:00.0: wmi command 16387 timeout
[761948.524226] ath11k_pci 0000:01:00.0: failed to send WMI_PDEV_SET_PARA=
M cmd
[761948.524235] ath11k_pci 0000:01:00.0: failed to enable dynamic bw: -11=

[761948.524240] ------------[ cut here ]------------
[761948.524242] Hardware became unavailable upon resume. This could be a =
software issue prior to suspend or a hardware issue.
[761948.524300] WARNING: CPU: 8 PID: 19308 at net/mac80211/util.c:2593 ie=
ee80211_reconfig+0x9f/0x14e0 [mac80211]
[761948.524407] Modules linked in: uinput snd_usb_audio snd_usbmidi_lib s=
nd_ump snd_rawmidi tun usbhid ccm michael_mic rfcomm snd_seq_dummy snd_hr=
timer snd_seq snd_seq_device af_packet cmac algif_hash algif_skcipher af_=
alg bnep btusb btrtl btintel btbcm btmtk bluetooth ecdh_generic qrtr_mhi =
uvcvideo videobuf2_vmalloc uvc videobuf2_memops videobuf2_v4l2 videodev c=
dc_mbim cdc_wdm option cdc_ncm videobuf2_common cdc_ether usb_wwan usbnet=
 mc usbserial mii qrtr snd_soc_acp6x_mach snd_soc_dmic snd_acp6x_pdm_dma =
snd_sof_amd_acp63 snd_sof_amd_vangogh snd_sof_amd_rembrandt snd_sof_amd_r=
enoir snd_sof_amd_acp snd_sof_pci ath11k_pci snd_sof_xtensa_dsp snd_ctl_l=
ed ath11k snd_sof intel_rapl_msr snd_hda_codec_realtek snd_sof_utils inte=
l_rapl_common qmi_helpers snd_hda_codec_generic snd_hda_codec_hdmi ext4 e=
dac_mce_amd snd_soc_core mbcache snd_hda_intel jbd2 snd_intel_dspcfg snd_=
compress nls_iso8859_1 snd_pcm_dmaengine snd_intel_sdw_acpi mac80211 nls_=
cp437 snd_pci_ps kvm_amd snd_hda_codec snd_rpl_pci_acp6x snd_acp_pci liba=
rc4
[761948.524554]  snd_acp_legacy_common vfat think_lmi snd_hda_core fat kv=
m snd_pci_acp6x snd_hwdep pcspkr firmware_attributes_class thinkpad_acpi =
wmi_bmof snd_pcm cfg80211 snd_pci_acp5x irqbypass snd_rn_pci_acp3x ledtri=
g_audio platform_profile tiny_power_button snd_timer snd_acp_config thund=
erbolt snd_soc_acpi rfkill snd snd_pci_acp3x mhi soundcore k10temp i2c_pi=
ix4 thermal ac fan joydev amd_pmc acpi_tad button nvme_fabrics fuse efi_p=
store configfs dmi_sysfs ip_tables x_tables dm_crypt essiv authenc truste=
d asn1_encoder tee amdgpu crct10dif_pclmul crc32_pclmul polyval_clmulni p=
olyval_generic gf128mul ghash_clmulni_intel sha512_ssse3 amdxcp i2c_algo_=
bit sha256_ssse3 drm_ttm_helper sha1_ssse3 ttm drm_exec gpu_sched xhci_pc=
i drm_suballoc_helper xhci_pci_renesas drm_buddy nvme drm_display_helper =
xhci_hcd nvme_core aesni_intel hid_multitouch ucsi_acpi typec_ucsi cec hi=
d_generic video nvme_auth crypto_simd cryptd roles usbcore ccp rc_core t1=
0_pi battery sp5100_tco typec wmi i2c_hid_acpi i2c_hid serio_raw btrfs bl=
ake2b_generic
[761948.524737]  libcrc32c crc32c_intel xor raid6_pq dm_mirror dm_region_=
hash dm_log dm_mod msr efivarfs
[761948.524760] CPU: 8 PID: 19308 Comm: kworker/u32:35 Not tainted 6.8.0-=
rc3-1.gae4495f-default #1 openSUSE Tumbleweed (unreleased) 493b6d5b382c60=
3654d7a81fc3c144d59a1dfceb
[761948.524769] Hardware name: LENOVO 21CRS0K63K/21CRS0K63K, BIOS R22ET65=
W (1.35 ) 08/08/2023
[761948.524774] Workqueue: events_unbound async_run_entry_fn
[761948.524785] RIP: 0010:ieee80211_reconfig+0x9f/0x14e0 [mac80211]
[761948.524859] Code: 02 00 00 41 c6 86 85 05 00 00 00 4c 89 f7 e8 b8 99 =
fb ff 41 89 c4 85 c0 0f 84 0d 03 00 00 48 c7 c7 78 22 f7 c1 e8 21 fc 61 e=
3 <0f> 0b eb 2d 84 c0 0f 85 9d 01 00 00 c6 87 85 05 00 00 00 e8 89 99
[761948.524863] RSP: 0018:ffffa54446f87ca0 EFLAGS: 00010286
[761948.524868] RAX: 0000000000000000 RBX: ffff954060a38538 RCX: 00000000=
00000027
[761948.524871] RDX: ffff95432ee27808 RSI: 0000000000000001 RDI: ffff9543=
2ee27800
[761948.524874] RBP: ffff954060a383c0 R08: 0000000000000000 R09: ffffa544=
46f87c28
[761948.524876] R10: 3fffffffffffffff R11: 000000000000029d R12: 00000000=
fffffff5
[761948.524879] R13: 0000000000000000 R14: ffff954060a38900 R15: ffff9540=
000516b0
[761948.524882] FS:  0000000000000000(0000) GS:ffff95432ee00000(0000) knl=
GS:0000000000000000
[761948.524886] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[761948.524889] CR2: 00007ff78fcce000 CR3: 00000001f2836000 CR4: 00000000=
00750ef0
[761948.524893] PKRU: 55555554
[761948.524895] Call Trace:
[761948.524902]  <TASK>
[761948.524905]  ? ieee80211_reconfig+0x9f/0x14e0 [mac80211 88f80e81ca85a=
e5f15ce53415437ca743102923d]
[761948.524976]  ? __warn+0x81/0x130
[761948.524988]  ? ieee80211_reconfig+0x9f/0x14e0 [mac80211 88f80e81ca85a=
e5f15ce53415437ca743102923d]
[761948.525059]  ? report_bug+0x171/0x1a0
[761948.525068]  ? srso_alias_return_thunk+0x5/0xfbef5
[761948.525078]  ? up+0x16/0x60
[761948.525086]  ? handle_bug+0x3c/0x80
[761948.525094]  ? exc_invalid_op+0x17/0x70
[761948.525099]  ? asm_exc_invalid_op+0x1a/0x20
[761948.525111]  ? ieee80211_reconfig+0x9f/0x14e0 [mac80211 88f80e81ca85a=
e5f15ce53415437ca743102923d]
[761948.525182]  ? srso_alias_return_thunk+0x5/0xfbef5
[761948.525188]  ? schedule+0x32/0xd0
[761948.525196]  ? srso_alias_return_thunk+0x5/0xfbef5
[761948.525202]  ? srso_alias_return_thunk+0x5/0xfbef5
[761948.525208]  ? schedule_timeout+0x147/0x160
[761948.525213]  ? srso_alias_return_thunk+0x5/0xfbef5
[761948.525219]  ? select_task_rq_fair+0x56b/0x1790
[761948.525229]  ? srso_alias_return_thunk+0x5/0xfbef5
[761948.525235]  ? lock_timer_base+0x61/0x80
[761948.525248]  wiphy_resume+0x85/0x1b0 [cfg80211 a8d6a294fa4c66aee495b6=
5b853635f40249069a]
[761948.525316]  ? __pfx_wiphy_resume+0x10/0x10 [cfg80211 a8d6a294fa4c66a=
ee495b65b853635f40249069a]
[761948.525358]  dpm_run_callback+0x8c/0x1e0
[761948.525369]  device_resume+0x104/0x340
[761948.525374]  ? __pfx_dpm_watchdog_handler+0x10/0x10
[761948.525380]  async_resume+0x1d/0x30
[761948.525385]  async_run_entry_fn+0x32/0x120
[761948.525389]  process_one_work+0x168/0x330
[761948.525395]  worker_thread+0x2f5/0x410
[761948.525401]  ? __pfx_worker_thread+0x10/0x10
[761948.525403]  kthread+0xe8/0x120
[761948.525410]  ? __pfx_kthread+0x10/0x10
[761948.525414]  ret_from_fork+0x34/0x50
[761948.525431]  ? __pfx_kthread+0x10/0x10
[761948.525435]  ret_from_fork_asm+0x1b/0x30
[761948.525444]  </TASK>
[761948.525445] ---[ end trace 0000000000000000 ]---
[761948.525534] ------------[ cut here ]------------
[761948.525536] WARNING: CPU: 8 PID: 19308 at net/mac80211/driver-ops.c:4=
1 drv_stop+0xf5/0x100 [mac80211]
[761948.525580] Modules linked in: uinput snd_usb_audio snd_usbmidi_lib s=
nd_ump snd_rawmidi tun usbhid ccm michael_mic rfcomm snd_seq_dummy snd_hr=
timer snd_seq snd_seq_device af_packet cmac algif_hash algif_skcipher af_=
alg bnep btusb btrtl btintel btbcm btmtk bluetooth ecdh_generic qrtr_mhi =
uvcvideo videobuf2_vmalloc uvc videobuf2_memops videobuf2_v4l2 videodev c=
dc_mbim cdc_wdm option cdc_ncm videobuf2_common cdc_ether usb_wwan usbnet=
 mc usbserial mii qrtr snd_soc_acp6x_mach snd_soc_dmic snd_acp6x_pdm_dma =
snd_sof_amd_acp63 snd_sof_amd_vangogh snd_sof_amd_rembrandt snd_sof_amd_r=
enoir snd_sof_amd_acp snd_sof_pci ath11k_pci snd_sof_xtensa_dsp snd_ctl_l=
ed ath11k snd_sof intel_rapl_msr snd_hda_codec_realtek snd_sof_utils inte=
l_rapl_common qmi_helpers snd_hda_codec_generic snd_hda_codec_hdmi ext4 e=
dac_mce_amd snd_soc_core mbcache snd_hda_intel jbd2 snd_intel_dspcfg snd_=
compress nls_iso8859_1 snd_pcm_dmaengine snd_intel_sdw_acpi mac80211 nls_=
cp437 snd_pci_ps kvm_amd snd_hda_codec snd_rpl_pci_acp6x snd_acp_pci liba=
rc4
[761948.525657]  snd_acp_legacy_common vfat think_lmi snd_hda_core fat kv=
m snd_pci_acp6x snd_hwdep pcspkr firmware_attributes_class thinkpad_acpi =
wmi_bmof snd_pcm cfg80211 snd_pci_acp5x irqbypass snd_rn_pci_acp3x ledtri=
g_audio platform_profile tiny_power_button snd_timer snd_acp_config thund=
erbolt snd_soc_acpi rfkill snd snd_pci_acp3x mhi soundcore k10temp i2c_pi=
ix4 thermal ac fan joydev amd_pmc acpi_tad button nvme_fabrics fuse efi_p=
store configfs dmi_sysfs ip_tables x_tables dm_crypt essiv authenc truste=
d asn1_encoder tee amdgpu crct10dif_pclmul crc32_pclmul polyval_clmulni p=
olyval_generic gf128mul ghash_clmulni_intel sha512_ssse3 amdxcp i2c_algo_=
bit sha256_ssse3 drm_ttm_helper sha1_ssse3 ttm drm_exec gpu_sched xhci_pc=
i drm_suballoc_helper xhci_pci_renesas drm_buddy nvme drm_display_helper =
xhci_hcd nvme_core aesni_intel hid_multitouch ucsi_acpi typec_ucsi cec hi=
d_generic video nvme_auth crypto_simd cryptd roles usbcore ccp rc_core t1=
0_pi battery sp5100_tco typec wmi i2c_hid_acpi i2c_hid serio_raw btrfs bl=
ake2b_generic
[761948.525742]  libcrc32c crc32c_intel xor raid6_pq dm_mirror dm_region_=
hash dm_log dm_mod msr efivarfs
[761948.525752] CPU: 8 PID: 19308 Comm: kworker/u32:35 Tainted: G        =
W          6.8.0-rc3-1.gae4495f-default #1 openSUSE Tumbleweed (unrelease=
d) 493b6d5b382c603654d7a81fc3c144d59a1dfceb
[761948.525756] Hardware name: LENOVO 21CRS0K63K/21CRS0K63K, BIOS R22ET65=
W (1.35 ) 08/08/2023
[761948.525758] Workqueue: events_unbound async_run_entry_fn
[761948.525761] RIP: 0010:drv_stop+0xf5/0x100 [mac80211]
[761948.525803] Code: 0b 00 48 85 c0 74 0c 48 8b 78 08 48 89 de e8 72 f2 =
04 00 65 ff 0d 83 d9 1d 3e 0f 85 39 ff ff ff 0f 1f 44 00 00 e9 2f ff ff f=
f <0f> 0b 5b e9 2e 79 4a e4 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90
[761948.525805] RSP: 0018:ffffa54446f87c00 EFLAGS: 00010246
[761948.525808] RAX: 0000000000000000 RBX: ffff954060a38900 RCX: 00000000=
00000000
[761948.525809] RDX: 0000000080000000 RSI: 0000000000000286 RDI: ffff9540=
60a38900
[761948.525811] RBP: ffff954060a38900 R08: 0000000000000400 R09: 00000000=
00000000
[761948.525812] R10: 0000000000000000 R11: 00000000000000bf R12: ffff9540=
60a391d0
[761948.525814] R13: ffff954060a38e10 R14: 0000000000000000 R15: ffff9540=
4a4a9c08
[761948.525816] FS:  0000000000000000(0000) GS:ffff95432ee00000(0000) knl=
GS:0000000000000000
[761948.525818] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[761948.525820] CR2: 00007ff78fcce000 CR3: 00000001f2836000 CR4: 00000000=
00750ef0
[761948.525822] PKRU: 55555554
[761948.525823] Call Trace:
[761948.525825]  <TASK>
[761948.525827]  ? drv_stop+0xf5/0x100 [mac80211 88f80e81ca85ae5f15ce5341=
5437ca743102923d]
[761948.525869]  ? __warn+0x81/0x130
[761948.525872]  ? drv_stop+0xf5/0x100 [mac80211 88f80e81ca85ae5f15ce5341=
5437ca743102923d]
[761948.525915]  ? report_bug+0x171/0x1a0
[761948.525920]  ? handle_bug+0x3c/0x80
[761948.525924]  ? exc_invalid_op+0x17/0x70
[761948.525927]  ? asm_exc_invalid_op+0x1a/0x20
[761948.525934]  ? drv_stop+0xf5/0x100 [mac80211 88f80e81ca85ae5f15ce5341=
5437ca743102923d]
[761948.525977]  ieee80211_do_stop+0x52e/0x7b0 [mac80211 88f80e81ca85ae5f=
15ce53415437ca743102923d]
[761948.526028]  ? srso_alias_return_thunk+0x5/0xfbef5
[761948.526032]  ? srso_alias_return_thunk+0x5/0xfbef5
[761948.526037]  ieee80211_stop+0x58/0x180 [mac80211 88f80e81ca85ae5f15ce=
53415437ca743102923d]
[761948.526083]  __dev_close_many+0xaa/0x120
[761948.526092]  dev_close_many+0x99/0x160
[761948.526098]  dev_close+0x6a/0x90
[761948.526103]  cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211 a8d=
6a294fa4c66aee495b65b853635f40249069a]
[761948.526149]  wiphy_resume+0xc1/0x1b0 [cfg80211 a8d6a294fa4c66aee495b6=
5b853635f40249069a]
[761948.526193]  ? __pfx_wiphy_resume+0x10/0x10 [cfg80211 a8d6a294fa4c66a=
ee495b65b853635f40249069a]
[761948.526235]  dpm_run_callback+0x8c/0x1e0
[761948.526241]  device_resume+0x104/0x340
[761948.526246]  ? __pfx_dpm_watchdog_handler+0x10/0x10
[761948.526251]  async_resume+0x1d/0x30
[761948.526255]  async_run_entry_fn+0x32/0x120
[761948.526259]  process_one_work+0x168/0x330
[761948.526263]  worker_thread+0x2f5/0x410
[761948.526267]  ? __pfx_worker_thread+0x10/0x10
[761948.526270]  kthread+0xe8/0x120
[761948.526273]  ? __pfx_kthread+0x10/0x10
[761948.526278]  ret_from_fork+0x34/0x50
[761948.526282]  ? __pfx_kthread+0x10/0x10
[761948.526285]  ret_from_fork_asm+0x1b/0x30
[761948.526293]  </TASK>
[761948.526294] ---[ end trace 0000000000000000 ]---
[761948.526362] ieee80211 phy0: PM: dpm_run_callback(): wiphy_resume+0x0/=
0x1b0 [cfg80211] returns -11
[761948.526410] ieee80211 phy0: PM: failed to resume async: error -11
[761948.530973] OOM killer enabled.
[761948.530978] Restarting tasks ... done.
[761948.536832] random: crng reseeded on system resumption
[761948.634424] PM: suspend exit
[761951.724396] ath11k_pci 0000:01:00.0: wmi command 16387 timeout
[761951.724421] ath11k_pci 0000:01:00.0: failed to send WMI_PDEV_SET_PARA=
M cmd
[761951.724434] ath11k_pci 0000:01:00.0: failed to enable PMF QOS: (-11
[761954.924404] ath11k_pci 0000:01:00.0: wmi command 16387 timeout
[761954.924428] ath11k_pci 0000:01:00.0: failed to send WMI_PDEV_SET_PARA=
M cmd
[761954.924441] ath11k_pci 0000:01:00.0: failed to enable PMF QOS: (-11
[761958.124403] ath11k_pci 0000:01:00.0: wmi command 16387 timeout
[761958.124427] ath11k_pci 0000:01:00.0: failed to send WMI_PDEV_SET_PARA=
M cmd
[761958.124440] ath11k_pci 0000:01:00.0: failed to enable PMF QOS: (-11
[761961.324096] ath11k_pci 0000:01:00.0: wmi command 16387 timeout
[761961.324110] ath11k_pci 0000:01:00.0: failed to send WMI_PDEV_SET_PARA=
M cmd
[761961.324117] ath11k_pci 0000:01:00.0: failed to enable PMF QOS: (-11

