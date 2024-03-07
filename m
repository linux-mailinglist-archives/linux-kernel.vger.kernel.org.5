Return-Path: <linux-kernel+bounces-95303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5BC874BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F41282EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767CA85272;
	Thu,  7 Mar 2024 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gQuH5amm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gQuH5amm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1382D7C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806103; cv=none; b=RxJ40GfP/g8+9L4ebP7h0tyuGOH2PJjCiRmzBMTu9/UOw6Ku+A94QPAvp47aN1miy0vKi0dFy3ay94V4Lgp4SDiempmdic63WvUUeFtegSzygy7LXkKWkLJGMBZZ/5vYnV6pt4Byb1PuRIkaReclH5hknD38YuwE6j5Jby/NXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806103; c=relaxed/simple;
	bh=u1BeVEStfTVYy2ekidNvE4jcEDCW4RUp0X1My4jHj+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CktB8YWPI2jPCfku5jru4LspmmXqnu3mKJ2lKnlP5UQiO46m/Jmyj9CNDIK+nO9q7ZFw2EaRcKLbU9jB76izMnZFmrWUtcuJN99sbhrxN/4rJdXZ9IhrbWjviJ04G0TcHBUwWL+f8FUqr/SbGh66npMIHwhC1ZxKk4Snq19NIio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gQuH5amm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gQuH5amm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40EF13ED26;
	Thu,  7 Mar 2024 09:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709805512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4pnrjXN4d9AFRPdRmsFT41jSzmt0rQd4GqOAPZ193MY=;
	b=gQuH5ammyXXQ/WXbgqswEOv/NjVn1i4APC6Gf9+IkwCoqeQOZrdJ3mYMNb0M2jJ6qeNAb2
	9RhYCkVxYNwBz1eBw0h/ZjpfabhItPXG4maHN0TnOJJOr+0HWks/c83+2MEAYn7Z3b15su
	SZTcf+c4fkb5ICKjmvOcgoxcKGt/QlU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709805512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4pnrjXN4d9AFRPdRmsFT41jSzmt0rQd4GqOAPZ193MY=;
	b=gQuH5ammyXXQ/WXbgqswEOv/NjVn1i4APC6Gf9+IkwCoqeQOZrdJ3mYMNb0M2jJ6qeNAb2
	9RhYCkVxYNwBz1eBw0h/ZjpfabhItPXG4maHN0TnOJJOr+0HWks/c83+2MEAYn7Z3b15su
	SZTcf+c4fkb5ICKjmvOcgoxcKGt/QlU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29C0012FC5;
	Thu,  7 Mar 2024 09:58:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hVw3B8eP6WUQIQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 07 Mar 2024 09:58:31 +0000
Date: Thu, 7 Mar 2024 10:58:19 +0100
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52592: libbpf: Fix NULL pointer dereference in
 bpf_object__collect_prog_relos
Message-ID: <ZemPuxhM_ZZ-khTh@tiehlicka>
References: <2024030645-CVE-2023-52592-4693@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030645-CVE-2023-52592-4693@gregkh>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gQuH5amm
X-Spamd-Result: default: False [-4.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -4.81
X-Rspamd-Queue-Id: 40EF13ED26
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed 06-03-24 06:45:50, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos
> 
> An issue occurred while reading an ELF file in libbpf.c during fuzzing:
> 
> 	Program received signal SIGSEGV, Segmentation fault.
> 	0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
> 	4206 in libbpf.c
> 	(gdb) bt
> 	#0 0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
> 	#1 0x000000000094f9d6 in bpf_object.collect_relos () at libbpf.c:6706
> 	#2 0x000000000092bef3 in bpf_object_open () at libbpf.c:7437
> 	#3 0x000000000092c046 in bpf_object.open_mem () at libbpf.c:7497
> 	#4 0x0000000000924afa in LLVMFuzzerTestOneInput () at fuzz/bpf-object-fuzzer.c:16
> 	#5 0x000000000060be11 in testblitz_engine::fuzzer::Fuzzer::run_one ()
> 	#6 0x000000000087ad92 in tracing::span::Span::in_scope ()
> 	#7 0x00000000006078aa in testblitz_engine::fuzzer::util::walkdir ()
> 	#8 0x00000000005f3217 in testblitz_engine::entrypoint::main::{{closure}} ()
> 	#9 0x00000000005f2601 in main ()
> 	(gdb)
> 
> scn_data was null at this code(tools/lib/bpf/src/libbpf.c):
> 
> 	if (rel->r_offset % BPF_INSN_SZ || rel->r_offset >= scn_data->d_size) {
> 
> The scn_data is derived from the code above:
> 
> 	scn = elf_sec_by_idx(obj, sec_idx);
> 	scn_data = elf_sec_data(obj, scn);
> 
> 	relo_sec_name = elf_sec_str(obj, shdr->sh_name);
> 	sec_name = elf_sec_name(obj, scn);
> 	if (!relo_sec_name || !sec_name)// don't check whether scn_data is NULL
> 		return -EINVAL;
> 
> In certain special scenarios, such as reading a malformed ELF file,
> it is possible that scn_data may be a null pointer
> 
> The Linux kernel CVE team has assigned CVE-2023-52592 to this issue.

OK, so this one is quite interesting. This is a userspace tooling
gaining a kernel CVE. Is this just an omission or is this really
expected.

Also what is the security threat model here? If a malformed ELF file is
loaded then the process gets SEGV which is perfectly reasonable thing to
do.

Thanks!
-- 
Michal Hocko
SUSE Labs

