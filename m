Return-Path: <linux-kernel+bounces-67446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E03856BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EECC1F20F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FD213848A;
	Thu, 15 Feb 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JZeoGVRo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JZeoGVRo"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA6136672;
	Thu, 15 Feb 2024 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019662; cv=none; b=YULz47o33N1YN14pUVUZV+QPod0kedw1oI/8llfwBD3UIMoAN59jl25jlp118LydFsjduFAeMSKiULPVdpj3LOlgRWThOGBjzBlTi219U2IWPoWLOd7A9hplSDRgjmkNNzdWJzFCcJ4LsB2z4u+eH4bLgn3IVoVg7pEIGv6CeqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019662; c=relaxed/simple;
	bh=qH7biky9xP1Y0Whpp5jMEnFaQMfBiSxbagBkTnig0Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrXJ2or5yGSbdSFsfkwo61oZNLAUvRv/8ewyOkM9KPoTQrGmqvkzkbJYz9gPv22IKpIyTZpgrGZhGnTtewgekJ3Bz6S6x+X6U9OvxLoKb8/LuPP9KtIlWe4RNiOFU7jmowXRBWeR0z3DHIgYkjLVWILLv1UKIHNGdz8KVGLsOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JZeoGVRo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JZeoGVRo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 696D32222A;
	Thu, 15 Feb 2024 17:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708019658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0FF1UMj/P8d9MO82ReOemjt8jp7zZ5pQpvMdZhVLSKo=;
	b=JZeoGVRoC7KYCmbBxlXZ4oHGzp9iL7vjK8rnIKwNtSu4LGfW9p1JWq52xQiGQme6BIf/WA
	yfZP9Th4oLN2JUgUnkSro8xcDwXkeukOkOvJNbECq3Z9L313tWjUKFSWnT4zhqo67NAeTk
	1ZgtjZ0hp+zRqBYAfIguKiPUMFqcmfw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708019658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0FF1UMj/P8d9MO82ReOemjt8jp7zZ5pQpvMdZhVLSKo=;
	b=JZeoGVRoC7KYCmbBxlXZ4oHGzp9iL7vjK8rnIKwNtSu4LGfW9p1JWq52xQiGQme6BIf/WA
	yfZP9Th4oLN2JUgUnkSro8xcDwXkeukOkOvJNbECq3Z9L313tWjUKFSWnT4zhqo67NAeTk
	1ZgtjZ0hp+zRqBYAfIguKiPUMFqcmfw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44EE713A82;
	Thu, 15 Feb 2024 17:54:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PW3aDcpPzmXwGQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 15 Feb 2024 17:54:18 +0000
Date: Thu, 15 Feb 2024 18:54:17 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <Zc5PycMenLBYECAn@tiehlicka>
References: <2024021430-blanching-spotter-c7c8@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021430-blanching-spotter-c7c8@gregkh>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=JZeoGVRo
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-0.981];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.70%]
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 696D32222A
X-Spam-Flag: NO

On Wed 14-02-24 09:00:30, Greg KH wrote:
[...]
> +Process
> +-------
> +
> +As part of the normal stable release process, kernel changes that are
> +potentially security issues are identified by the developers responsible
> +for CVE number assignments and have CVE numbers automatically assigned
> +to them.  These assignments are published on the linux-cve-announce
> +mailing list as announcements on a frequent basis.
> +
> +Note, due to the layer at which the Linux kernel is in a system, almost
> +any bug might be exploitable to compromise the security of the kernel,
> +but the possibility of exploitation is often not evident when the bug is
> +fixed.  Because of this, the CVE assignment team is overly cautious and
> +assign CVE numbers to any bugfix that they identify.  This
> +explains the seemingly large number of CVEs that are issued by the Linux
> +kernel team.

Does the process focus only on assigning CVE numbers to a given upstream
commit(s) withou any specifics of the actual security threat covered by
the said CVE?
-- 
Michal Hocko
SUSE Labs

