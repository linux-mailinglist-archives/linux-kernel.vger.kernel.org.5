Return-Path: <linux-kernel+bounces-117718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217EC88B500
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5742EC46F85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CE67F7E5;
	Mon, 25 Mar 2024 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FtKknZmv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9dT88f1e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FtKknZmv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9dT88f1e"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937A5CDE9;
	Mon, 25 Mar 2024 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391618; cv=none; b=MCtvtOvhV6rZEcA5SdRNl9LJ2uT+GYF0KIchLLxXp/XcfAu6dYRtwOdMdf9ihl4q7eAXeygKxu4FqoylYlQO4UP02tf0X6YEyFg0HFHhP9ue0WftQ2g7In8xC1I6LXgpzKdkjliZnlmje1TJ5K4k9PD80k9VpJnUXjIBXhBDOUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391618; c=relaxed/simple;
	bh=b6zVrjZz5F0xAtsYdxu3QThTBor1H8zAGF5g/a8oXLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQYWMTnpDKZZ5akFXQ4sw7h+A1NINch/+uXTqi2MhP0Dy0SkWTsPJI6eaoiIBVf3w+Qo94ZGveLxDBSj8WE8KgjC0P/81FduHqyUeEZypApYQkXxl0aHxyo+oW3B6QupocSAjpBDFyHrZtYPmD1a9ouzsJF9VxCdABo6M5jT4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FtKknZmv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9dT88f1e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FtKknZmv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9dT88f1e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 33AAE5CA49;
	Mon, 25 Mar 2024 18:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711391615;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmIskwzMD6N4laAnS7ep8yM/587fRGFK2+5Vo+0uvLw=;
	b=FtKknZmvpfhJSc/hYowjLbTPkAltbaD9yJpa28tpwzqIMlejg0b/Ce2ApkQVbJlspeyQRD
	jS06xikrkWGa5rRBibNizOJkqF6VbU5uYgAM/N8WOti8tfohkX3H9aEgEnKqCys++7PrnJ
	Lx1XswdY80ngpWJb/vsKMiHt40PiBFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711391615;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmIskwzMD6N4laAnS7ep8yM/587fRGFK2+5Vo+0uvLw=;
	b=9dT88f1eRIKNlWJkPXjAtcBbi4FiXjl5FE+5yXin4WaKFXyZAKNP9F7OUtFID+0lqo+VcH
	WwAuZ74WGbyMxZCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711391615;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmIskwzMD6N4laAnS7ep8yM/587fRGFK2+5Vo+0uvLw=;
	b=FtKknZmvpfhJSc/hYowjLbTPkAltbaD9yJpa28tpwzqIMlejg0b/Ce2ApkQVbJlspeyQRD
	jS06xikrkWGa5rRBibNizOJkqF6VbU5uYgAM/N8WOti8tfohkX3H9aEgEnKqCys++7PrnJ
	Lx1XswdY80ngpWJb/vsKMiHt40PiBFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711391615;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmIskwzMD6N4laAnS7ep8yM/587fRGFK2+5Vo+0uvLw=;
	b=9dT88f1eRIKNlWJkPXjAtcBbi4FiXjl5FE+5yXin4WaKFXyZAKNP9F7OUtFID+0lqo+VcH
	WwAuZ74WGbyMxZCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 214D013A2E;
	Mon, 25 Mar 2024 18:33:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Dgf6B3/DAWbDXwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 25 Mar 2024 18:33:35 +0000
Date: Mon, 25 Mar 2024 19:26:14 +0100
From: David Sterba <dsterba@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 5.10 005/238] btrfs: add and use helper to check if block
 group is used
Message-ID: <20240325182614.GO14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240324234027.1354210-1-sashal@kernel.org>
 <20240324234027.1354210-6-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324234027.1354210-6-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.77
X-Spamd-Result: default: False [-2.77 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.77)[93.62%]
X-Spam-Flag: NO

On Sun, Mar 24, 2024 at 07:36:33PM -0400, Sasha Levin wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> [ Upstream commit 1693d5442c458ae8d5b0d58463b873cd879569ed ]
> 
> Add a helper function to determine if a block group is being used and make
> use of it at btrfs_delete_unused_bgs(). This helper will also be used in
> future code changes.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Please drop this patch from all stable branches unless it's a
prerequisite for some other patch. This is clearly a cleanup.

