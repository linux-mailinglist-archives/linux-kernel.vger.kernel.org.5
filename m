Return-Path: <linux-kernel+bounces-117457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF0788ABB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282BCC613E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332E41327FA;
	Mon, 25 Mar 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vzirc6cE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uHCF2M3k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vzirc6cE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uHCF2M3k"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4AA131E59;
	Mon, 25 Mar 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383644; cv=none; b=Y+ygxwrbLi3wumE9lKguE65CIYsg2xG6Mnz8CScDwSH9ZmFUlwJ1fD6LTfsEie4l53HVse5vbg8V81lpmjuwyRtmpWmdM5NxjYKt3QwxAYpCuRIkJQqunB36AB3MnkHT6K4uYImyWQXiT3RSLbO9ZnQOd1mkev82DYevfe6bt+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383644; c=relaxed/simple;
	bh=7BMVtVx/bH0fO02qrr8S0bUjiPTP37rHyaopN4ZoMIU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrdDl8P3s05HMg0I+La3kDZLybmrOLVMQB4oK7n+63zmXV6PkqIc6kzQ1418B99fQ9yO/U7lBh47J/2X3ysI0yXvo9pp9bmWyPy5AK8y/B6c4xBxukd+e3uqXgnv4h6480Lw5i76PY4mGmaMoUUsT2sV40bTCgtSlC0LBRegl34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vzirc6cE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uHCF2M3k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vzirc6cE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uHCF2M3k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E060934766;
	Mon, 25 Mar 2024 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711383639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sxzjX7HfXAUn1C7M5TP/T3y2Vg/0dHDr0qhtHQYG8KY=;
	b=Vzirc6cE0bcwjSF03MgWfwmCWx5bXfCGenTlcOmM+Bo65muaz3JqEvmVbPSkHmHMDklAsm
	ElpxMYx+Foon7rZji4L7Y1iHFMzJ8xFGLFCGWQqk+fkxQcPe9L+D9MiEmpO/5YRUVHAZeE
	TiVGJRRUzcLMOi2bEKbpBXc1bd4K3DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711383639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sxzjX7HfXAUn1C7M5TP/T3y2Vg/0dHDr0qhtHQYG8KY=;
	b=uHCF2M3kV267N4iy5xqhHRXw4BMOI0KKQiJd3C8hHKazp8fthYjpxslges+fwh4iiIlYAP
	reb61G5LXDZiTcAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711383639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sxzjX7HfXAUn1C7M5TP/T3y2Vg/0dHDr0qhtHQYG8KY=;
	b=Vzirc6cE0bcwjSF03MgWfwmCWx5bXfCGenTlcOmM+Bo65muaz3JqEvmVbPSkHmHMDklAsm
	ElpxMYx+Foon7rZji4L7Y1iHFMzJ8xFGLFCGWQqk+fkxQcPe9L+D9MiEmpO/5YRUVHAZeE
	TiVGJRRUzcLMOi2bEKbpBXc1bd4K3DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711383639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sxzjX7HfXAUn1C7M5TP/T3y2Vg/0dHDr0qhtHQYG8KY=;
	b=uHCF2M3kV267N4iy5xqhHRXw4BMOI0KKQiJd3C8hHKazp8fthYjpxslges+fwh4iiIlYAP
	reb61G5LXDZiTcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A551813503;
	Mon, 25 Mar 2024 16:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4/D1JlekAWYyFgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 25 Mar 2024 16:20:39 +0000
Date: Mon, 25 Mar 2024 17:20:40 +0100
Message-ID: <87msqmwaef.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	"Simon Trimmer" <simont@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Set the init_done flag before component_add()
In-Reply-To: <20240325145510.328378-1-rf@opensource.cirrus.com>
References: <20240325145510.328378-1-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.06
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.06 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-1.05)[87.70%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Vzirc6cE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uHCF2M3k
X-Rspamd-Queue-Id: E060934766

On Mon, 25 Mar 2024 15:55:10 +0100,
Richard Fitzgerald wrote:
> 
> From: Simon Trimmer <simont@opensource.cirrus.com>
> 
> Initialization is completed before adding the component as that can
> start the process of the device binding and trigger actions that check
> init_done.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")

Thanks, applied now.


Takashi

