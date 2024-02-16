Return-Path: <linux-kernel+bounces-68589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ACB857CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7C3AB22F05
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2431292DE;
	Fri, 16 Feb 2024 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="igJDODRL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g7z39LWD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="igJDODRL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g7z39LWD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1406E58203
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087214; cv=none; b=AAIkyqpVOa+Fw+oW8mVEHk+zH2m+VbTP9zJQ2p9lyDiMbxO6JVTfwr4+vhw2p9ytPMGQFSUsqvPJxIDPeVTWYrNszWiFkBXcVfVpyj7u+siyfimPpnHqOa7RZmh6YCjVWp7REUqi8erq0Iy+GSOfmoIXrE7H7FVel7NbjKXF+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087214; c=relaxed/simple;
	bh=Hq3ZrBIlPG9FIfx0LJGO9qrhRsHdz5WSBwryYJdhF2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjWe5+Gi3FyYZ915hamShpf2oPLp5npqrbwv5C4D+Lmf9A5w5KUz+g0Eb7faTIzFAMV8K+IhMXbQaLf8oMk9ZKeq/74so2jvSpEVPFiq3re63uioukTYZE8yB0lAyi8vvkSqeNDMM8GobKUrStFq7yLF1AaPIUs7lAowbnml+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=igJDODRL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g7z39LWD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=igJDODRL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g7z39LWD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51EB61FB68;
	Fri, 16 Feb 2024 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708087211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SE3qrLWVEbZxr++ON5K97v+oJUCvjFpwWzmyWT38QU=;
	b=igJDODRLJf5ZZ/kNCLeNrPbX3BK5cFBFZl1Suv1lxxiFQE9pVrEIdDgbmtuBChwp1F9Sw3
	tzA7/ZiMC3iO+U73leK9yUA16P2tmSJFbQvwrtk5/0/4jSnPqDY9ZDFtvxdXd4F6+g0/xx
	yIqxM9y7ef87S0VbdQoeHjbYGkZy9og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708087211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SE3qrLWVEbZxr++ON5K97v+oJUCvjFpwWzmyWT38QU=;
	b=g7z39LWDzHF4YqaFQ8QSkxoB7wsTG42z4EvBJyUWPDpRWdWuic0dF37zbo7gLGJrvsRryj
	nunN3xwSgmpXxFDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708087211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SE3qrLWVEbZxr++ON5K97v+oJUCvjFpwWzmyWT38QU=;
	b=igJDODRLJf5ZZ/kNCLeNrPbX3BK5cFBFZl1Suv1lxxiFQE9pVrEIdDgbmtuBChwp1F9Sw3
	tzA7/ZiMC3iO+U73leK9yUA16P2tmSJFbQvwrtk5/0/4jSnPqDY9ZDFtvxdXd4F6+g0/xx
	yIqxM9y7ef87S0VbdQoeHjbYGkZy9og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708087211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SE3qrLWVEbZxr++ON5K97v+oJUCvjFpwWzmyWT38QU=;
	b=g7z39LWDzHF4YqaFQ8QSkxoB7wsTG42z4EvBJyUWPDpRWdWuic0dF37zbo7gLGJrvsRryj
	nunN3xwSgmpXxFDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F7A013343;
	Fri, 16 Feb 2024 12:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id e0kPDqtXz2XTIgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 16 Feb 2024 12:40:11 +0000
Date: Fri, 16 Feb 2024 13:40:10 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v0 5/6] nvme-fc: redesign locking and refcounting
Message-ID: <dotdh6bz2togarj62bjegvlxadicsxl7h42qbt7zkbu7oyyzqc@dw4eafuqtzfd>
References: <20240216084526.14133-1-dwagner@suse.de>
 <20240216084526.14133-6-dwagner@suse.de>
 <c5f27e3c-d034-4a40-bfb5-1bd5ec5f5dfc@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f27e3c-d034-4a40-bfb5-1bd5ec5f5dfc@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.73 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.13)[67.32%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.73

On Fri, Feb 16, 2024 at 12:09:20PM +0100, Hannes Reinecke wrote:
> Hmm. I'm a bit unsure about this; essentially you change the rport
> refcounting (and not just the controller refcounting).
> And the problem here is that rport refcounting is actually tied to
> the driver-internal rports, which have a different lifetime
> (dev_loss_tmo and all that).
> 
> Would it be possible to break this in two, with one patch changing the
> controller/options refcounting and the other one changing the rport
> refcounting?

Yeah, I see. I completely forgot about the dev_loss_tmo thing. I'll try
to split this patch.

