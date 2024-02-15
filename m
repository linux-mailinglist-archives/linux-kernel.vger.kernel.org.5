Return-Path: <linux-kernel+bounces-67135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248828566E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CFA2B2A8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D3A131E3D;
	Thu, 15 Feb 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ABKTEcJJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ABKTEcJJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6844C132461;
	Thu, 15 Feb 2024 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009389; cv=none; b=gesmKtM0pzegseiEhTpoWn1nw/2W7miqlTEZ4WCpLH/0vKI5DBjFMK8x+qUsoKbTG/kmpUhyWtUC5Wsc37DtAzd48jExC8KeV5QQtwePaFL3BM2n8WXK9J0PMuBGW6L1zUal2Q85OcIveOw3TjZP11rKRCWWrNL0l3KFtbD0Z7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009389; c=relaxed/simple;
	bh=pKMvWqSNpDH5j4f/4uVNlDSGuJRg//bt7SddzxfDlNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkYDSWFmS7Rrt7kMNgPRFNwdgEReK3OfalRZ196An3vQM3nxPDg/JiN52GAtPYvErt+m13BLgUmDFsPzMSKgEJlmTZIM0XomYHhAsBHeyPT2Ka5DWAMxJkqsrFjPtaRMLTWeTgw+aLDO4hGcpAfoB7XFyCtyQwkPWgojS7qKI/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ABKTEcJJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ABKTEcJJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A23C21B5D;
	Thu, 15 Feb 2024 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708009383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxPcn+LcDwI0imoN5yBcv9TPZ+gXrqFYsp2y4Ttalwg=;
	b=ABKTEcJJ3FBZ6D2q3Xg6DBoo6MiwYn7vsZqpXGeTiLJO9cKmdj70oK7LDOpTn3KsPAiK61
	f6bZ4YwN2ALDs2YvF2s7QxigQMKYHLG8l9Q9Y4chcOEzEkRNFw34YoN5xVf7XbDI7wyKbz
	SJNsDHB/nvP6BGdVQMEqTCVJ0WYvtPg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708009383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxPcn+LcDwI0imoN5yBcv9TPZ+gXrqFYsp2y4Ttalwg=;
	b=ABKTEcJJ3FBZ6D2q3Xg6DBoo6MiwYn7vsZqpXGeTiLJO9cKmdj70oK7LDOpTn3KsPAiK61
	f6bZ4YwN2ALDs2YvF2s7QxigQMKYHLG8l9Q9Y4chcOEzEkRNFw34YoN5xVf7XbDI7wyKbz
	SJNsDHB/nvP6BGdVQMEqTCVJ0WYvtPg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C395613A53;
	Thu, 15 Feb 2024 15:03:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UIOiLaYnzmUibwAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 15 Feb 2024 15:03:02 +0000
Message-ID: <0bd8c620-7f80-44c4-ade3-b3d7951b48d8@suse.com>
Date: Thu, 15 Feb 2024 16:03:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Documentation: Document the Linux Kernel CVE process
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, corbet@lwn.net,
 workflows@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 security@kernel.org, linux@leemhuis.info, Kees Cook <keescook@chromium.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Sasha Levin <sashal@kernel.org>,
 Lee Jones <lee@kernel.org>
References: <2024021500-laziness-grimace-ed80@gregkh>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <2024021500-laziness-grimace-ed80@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.96
X-Spamd-Result: default: False [-1.96 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 R_MIXED_CHARSET(0.83)[subject];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,leemhuis.info,chromium.org,linuxfoundation.org,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 15.02.24 13:10, Greg Kroah-Hartman wrote:
> The Linux kernel project now has the ability to assign CVEs to fixed
> issues, so document the process and how individual developers can get a
> CVE if one is not automatically assigned for their fixes.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> v4: Add MAINTAINER entry
>      Lots of tiny wording changes based on many reviews
>      Collected some Reviewed-by: tags
>      Fixed documenation build by properly referencing the security
>      process documentation file.
> v3: fix up wording in security-bugs.rst based on the changes to the cve
>      assignment process from v1, thanks to a private reviewer for
>      pointing that out.
> v2: Grammer fixes based on review from Randy
>      Updated paragraph about how CVE identifiers will be assigned
>      (automatically when added to stable trees, or ask us for one
>      directly before that happens if so desired)
> 
>   Documentation/process/cve.rst           | 120 ++++++++++++++++++++++++
>   Documentation/process/index.rst         |   1 +
>   Documentation/process/security-bugs.rst |   5 +-
>   MAINTAINERS                             |   5 +
>   4 files changed, 128 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/process/cve.rst
> 
> diff --git a/Documentation/process/cve.rst b/Documentation/process/cve.rst
> new file mode 100644
> index 000000000000..6b244d938694
> --- /dev/null
> +++ b/Documentation/process/cve.rst
> @@ -0,0 +1,120 @@

..

> +Invalid CVEs
> +------------
> +
> +If a security issue is found in a Linux kernel that is only supported by
> +a Linux distribution due to the changes that have been made by that
> +distribution, or due to the distribution supporting a kernel version
> +that is no longer one of the kernel.org supported releases, then a CVE
> +can not be assigned by the Linux kernel CVE team, and must be asked for
> +from that Linux distribution itself.
> +
> +Any CVE that is assigned against the Linux kernel for an actively
> +supported kernel version, by any group other than the kernel assignment
> +CVE team should not be treated as a valid CVE.  Please notify the
> +kernel CVE assignment team at <cve@kernel.org> so that they can work to
> +invalidate such entries through the CNA remediation process.

Today we (the Xen security team) are allocating CVEs for Xen-related
kernel security bugs.

Does this mean we should do that via cve@kernel.org in future, or are
you happy us continuing our process as today? If the latter, I think
this should be noted somehow in this document in order to avoid complaints
regarding CVEs allocated by us.


Juergen (on behalf of the Xen security team)

