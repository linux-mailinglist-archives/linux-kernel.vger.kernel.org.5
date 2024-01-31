Return-Path: <linux-kernel+bounces-45939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8417A843816
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE31286A42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733BE5DF23;
	Wed, 31 Jan 2024 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d8vqVUys";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d8vqVUys"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C34F5D91D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686970; cv=none; b=embvmB+CZae0nP0nr5nL9BABFMQI9WBur5AKX8pQfSFVdiw9YBDc8Z1JxcRwSVG42XntvaoAOt7lcZBfhO4vSLrnr+1dKeiie96lGHyQW7V84qLuqmyISPpRKYaGO9gArmOfJ71EQJWCuH5BiEA6wFYnBlcbV9ATFfgiUHqguAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686970; c=relaxed/simple;
	bh=4KKkTrbwPu5ft0acqG3EPuy+AZwQW4V5ebRq7oZxEUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiZoui/2BEk+zbVFRG2ehzWpt4OCourV+qYNYUxMJYrJyUqgNbHjLTLqnlkfYlfeqHPExRLzxeWUAsNy0/m4OkH2wK7HWPmN+ip3Y8+wiWZsds/DyJ0mBYkbITKU1uSKOCrNrafKIf4/f7m6S8Q349NUGHlZ1z67WDzUX65ANZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d8vqVUys; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d8vqVUys; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7956D22101;
	Wed, 31 Jan 2024 07:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706686966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zjt9KyKsqTWBc+lH+CWv0C2loE0PPkI+cOIqFoZTqOc=;
	b=d8vqVUyspqDrkgW6kJPeUhj2eTsAz9mbU7WG38ZXoYVCBWLH60vR+z4Vo7Q03IaQFHCugb
	N5F1KPqoEJRpNh8dHAq7Wkt2W1XLKXzDa2qpTgCDH5TIluKiAGjU8aiVAn0jHds5a22ErW
	irFZgJu8hoAfgpaq5GgHg+Q7PU3uH3k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706686966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zjt9KyKsqTWBc+lH+CWv0C2loE0PPkI+cOIqFoZTqOc=;
	b=d8vqVUyspqDrkgW6kJPeUhj2eTsAz9mbU7WG38ZXoYVCBWLH60vR+z4Vo7Q03IaQFHCugb
	N5F1KPqoEJRpNh8dHAq7Wkt2W1XLKXzDa2qpTgCDH5TIluKiAGjU8aiVAn0jHds5a22ErW
	irFZgJu8hoAfgpaq5GgHg+Q7PU3uH3k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C984C1347F;
	Wed, 31 Jan 2024 07:42:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kjmgKPX5uWWPOgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 31 Jan 2024 07:42:45 +0000
Date: Wed, 31 Jan 2024 08:42:34 +0100
From: Michal Hocko <mhocko@suse.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs,hugetlb: Fix NULL pointer dereference in
 hugetlbs_fill_super
Message-ID: <Zbn56u1kg4yQAThE@tiehlicka>
References: <20240130210418.3771-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240130210418.3771-1-osalvador@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Tue 30-01-24 22:04:18, Oscar Salvador wrote:
> When configuring a hugetlb filesystem via the fsconfig() syscall, there i=
s a
> possible NULL dereference in hugetlbfs_fill_super() caused by assigning
> NULL to ctx->hstate in hugetlbfs_parse_param() when the requested pagesize
> is non valid.
>=20
> E.g: Taking the following steps:
>=20
>      fd =3D fsopen("hugetlbfs", FSOPEN_CLOEXEC);
>      fsconfig(fd, FSCONFIG_SET_STRING, "pagesize", "1024", 0);
>      fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
>=20
> Given that the requested "pagesize" is invalid, ctxt->hstate will be repl=
aced
> with NULL, losing its previous value, and we will print an error:
>=20
>  ...
>  ...
>  case Opt_pagesize:
>  ps =3D memparse(param->string, &rest);
>  ctx->hstate =3D h;
>  if (!ctx->hstate) {
>          pr_err("Unsupported page size %lu MB\n", ps / SZ_1M);
>          return -EINVAL;
>  }
>  return 0;
>  ...
>  ...
>=20
> This is a problem because later on, we will dereference ctxt->hstate in
> hugetlbfs_fill_super()
>=20
>  ...
>  ...
>  sb->s_blocksize =3D huge_page_size(ctx->hstate);
>  ...
>  ...
>=20
>  Causing below Oops.
>=20
>  Fix this by replacing cxt->hstate value only when then pagesize is known=
 to be valid.
>=20
>  kernel: hugetlbfs: Unsupported page size 0 MB
>  kernel: BUG: kernel NULL pointer dereference, address: 0000000000000028
>  kernel: #PF: supervisor read access in kernel mode
>  kernel: #PF: error_code(0x0000) - not-present page
>  kernel: PGD 800000010f66c067 P4D 800000010f66c067 PUD 1b22f8067 PMD 0
>  kernel: Oops: 0000 [#1] PREEMPT SMP PTI
>  kernel: CPU: 4 PID: 5659 Comm: syscall Tainted: G            E      6.8.=
0-rc2-default+ #22 5a47c3fef76212addcc6eb71344aabc35190ae8f
>  kernel: Hardware name: Intel Corp. GROVEPORT/GROVEPORT, BIOS GVPRCRB1.86=
B.0016.D04.1705030402 05/03/2017
>  kernel: RIP: 0010:hugetlbfs_fill_super+0xb4/0x1a0
>  kernel: Code: 48 8b 3b e8 3e c6 ed ff 48 85 c0 48 89 45 20 0f 84 d6 00 0=
0 00 48 b8 ff ff ff ff ff ff ff 7f 4c 89 e7 49 89 44 24 20 48 8b 03 <8b> 48=
 28 b8 00 10 00 00 48 d3 e0 49 89 44 24 18 48 8b 03 8b 40 28
>  kernel: RSP: 0018:ffffbe9960fcbd48 EFLAGS: 00010246
>  kernel: RAX: 0000000000000000 RBX: ffff9af5272ae780 RCX: 0000000000372004
>  kernel: RDX: ffffffffffffffff RSI: ffffffffffffffff RDI: ffff9af555e9b000
>  kernel: RBP: ffff9af52ee66b00 R08: 0000000000000040 R09: 0000000000370004
>  kernel: R10: ffffbe9960fcbd48 R11: 0000000000000040 R12: ffff9af555e9b000
>  kernel: R13: ffffffffa66b86c0 R14: ffff9af507d2f400 R15: ffff9af507d2f400
>  kernel: FS:  00007ffbc0ba4740(0000) GS:ffff9b0bd7000000(0000) knlGS:0000=
000000000000
>  kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  kernel: CR2: 0000000000000028 CR3: 00000001b1ee0000 CR4: 00000000001506f0
>  kernel: Call Trace:
>  kernel:  <TASK>
>  kernel:  ? __die_body+0x1a/0x60
>  kernel:  ? page_fault_oops+0x16f/0x4a0
>  kernel:  ? search_bpf_extables+0x65/0x70
>  kernel:  ? fixup_exception+0x22/0x310
>  kernel:  ? exc_page_fault+0x69/0x150
>  kernel:  ? asm_exc_page_fault+0x22/0x30
>  kernel:  ? __pfx_hugetlbfs_fill_super+0x10/0x10
>  kernel:  ? hugetlbfs_fill_super+0xb4/0x1a0
>  kernel:  ? hugetlbfs_fill_super+0x28/0x1a0
>  kernel:  ? __pfx_hugetlbfs_fill_super+0x10/0x10
>  kernel:  vfs_get_super+0x40/0xa0
>  kernel:  ? __pfx_bpf_lsm_capable+0x10/0x10
>  kernel:  vfs_get_tree+0x25/0xd0
>  kernel:  vfs_cmd_create+0x64/0xe0
>  kernel:  __x64_sys_fsconfig+0x395/0x410
>  kernel:  do_syscall_64+0x80/0x160
>  kernel:  ? syscall_exit_to_user_mode+0x82/0x240
>  kernel:  ? do_syscall_64+0x8d/0x160
>  kernel:  ? syscall_exit_to_user_mode+0x82/0x240
>  kernel:  ? do_syscall_64+0x8d/0x160
>  kernel:  ? exc_page_fault+0x69/0x150
>  kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0x76
>  kernel: RIP: 0033:0x7ffbc0cb87c9
>  kernel: Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 48 89 f=
8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d=
 01 f0 ff ff 73 01 c3 48 8b 0d 97 96 0d 00 f7 d8 64 89 01 48
>  kernel: RSP: 002b:00007ffc29d2f388 EFLAGS: 00000206 ORIG_RAX: 0000000000=
0001af
>  kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffbc0cb87c9
>  kernel: RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
>  kernel: RBP: 00007ffc29d2f3b0 R08: 0000000000000000 R09: 0000000000000000
>  kernel: R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>  kernel: R13: 00007ffc29d2f4c0 R14: 0000000000000000 R15: 0000000000000000
>  kernel:  </TASK>
>  kernel: Modules linked in: rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dn=
s_resolver(E) nfs(E) lockd(E) grace(E) sunrpc(E) netfs(E) af_packet(E) brid=
ge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) intel_rapl_msr(E) int=
el_rapl_common(E) iTCO_wdt(E) intel_pmc_bxt(E) sb_edac(E) iTCO_vendor_suppo=
rt(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) =
rfkill(E) ipmi_ssif(E) kvm(E) acpi_ipmi(E) irqbypass(E) pcspkr(E) igb(E) ip=
mi_si(E) mei_me(E) i2c_i801(E) joydev(E) intel_pch_thermal(E) i2c_smbus(E) =
dca(E) lpc_ich(E) mei(E) ipmi_devintf(E) ipmi_msghandler(E) acpi_pad(E) tin=
y_power_button(E) button(E) fuse(E) efi_pstore(E) configfs(E) ip_tables(E) =
x_tables(E) ext4(E) mbcache(E) jbd2(E) hid_generic(E) usbhid(E) sd_mod(E) t=
10_pi(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) polyval_clmuln=
i(E) ahci(E) xhci_pci(E) polyval_generic(E) gf128mul(E) ghash_clmulni_intel=
(E) sha512_ssse3(E) sha256_ssse3(E) xhci_pci_renesas(E) libahci(E) ehci_pci=
(E) sha1_ssse3(E) xhci_hcd(E) ehci_hcd(E) libata(E)
>  kernel:  mgag200(E) i2c_algo_bit(E) usbcore(E) wmi(E) sg(E) dm_multipath=
(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) sc=
si_common(E) aesni_intel(E) crypto_simd(E) cryptd(E)
>  kernel: Unloaded tainted modules: acpi_cpufreq(E):1 fjes(E):1
>  kernel: CR2: 0000000000000028
>  kernel: ---[ end trace 0000000000000000 ]---
>  kernel: RIP: 0010:hugetlbfs_fill_super+0xb4/0x1a0
>  kernel: Code: 48 8b 3b e8 3e c6 ed ff 48 85 c0 48 89 45 20 0f 84 d6 00 0=
0 00 48 b8 ff ff ff ff ff ff ff 7f 4c 89 e7 49 89 44 24 20 48 8b 03 <8b> 48=
 28 b8 00 10 00 00 48 d3 e0 49 89 44 24 18 48 8b 03 8b 40 28
>  kernel: RSP: 0018:ffffbe9960fcbd48 EFLAGS: 00010246
>  kernel: RAX: 0000000000000000 RBX: ffff9af5272ae780 RCX: 0000000000372004
>  kernel: RDX: ffffffffffffffff RSI: ffffffffffffffff RDI: ffff9af555e9b000
>  kernel: RBP: ffff9af52ee66b00 R08: 0000000000000040 R09: 0000000000370004
>  kernel: R10: ffffbe9960fcbd48 R11: 0000000000000040 R12: ffff9af555e9b000
>  kernel: R13: ffffffffa66b86c0 R14: ffff9af507d2f400 R15: ffff9af507d2f400
>  kernel: FS:  00007ffbc0ba4740(0000) GS:ffff9b0bd7000000(0000) knlGS:0000=
000000000000
>  kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  kernel: CR2: 0000000000000028 CR3: 00000001b1ee0000 CR4: 00000000001506f0
>=20
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Fixes: 32021982a324 ("hugetlbfs: Convert to fs_context")
AFAICS

Thanks!

--=20
Michal Hocko
SUSE Labs

