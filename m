Return-Path: <linux-kernel+bounces-5469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C44818AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036DCB23EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A81CA81;
	Tue, 19 Dec 2023 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XccugP6V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="548TD8AN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XccugP6V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="548TD8AN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B801C69D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4AF4E1F7C9;
	Tue, 19 Dec 2023 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702998902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7e5XCCyINAJ+NzY1e0bqdj0ZqmCV70DZ2zp5UsU/L/o=;
	b=XccugP6V9mOSqAF3XMjc+FNyX8RyzRFKXkiS9xTrx3Kk3dsKooTXU1QtJyn2fsn9yNn6x/
	HY7gu1MzDv/mNjDyNSepFtSpZjyT53Q0kSB3Yw5og6bzY7uS1SfZxsmOl4UmBgwv1XKpkk
	Ors64/EJkLoNClSQR+pIf4V2IsJOheA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702998902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7e5XCCyINAJ+NzY1e0bqdj0ZqmCV70DZ2zp5UsU/L/o=;
	b=548TD8ANtNA0cf5N0kK6iobtEySQVB71WWm72LLAHrEeJs7oaNoruMJp/y99lWtmEnxe27
	8LOM8Cdn9GNVpjCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702998902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7e5XCCyINAJ+NzY1e0bqdj0ZqmCV70DZ2zp5UsU/L/o=;
	b=XccugP6V9mOSqAF3XMjc+FNyX8RyzRFKXkiS9xTrx3Kk3dsKooTXU1QtJyn2fsn9yNn6x/
	HY7gu1MzDv/mNjDyNSepFtSpZjyT53Q0kSB3Yw5og6bzY7uS1SfZxsmOl4UmBgwv1XKpkk
	Ors64/EJkLoNClSQR+pIf4V2IsJOheA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702998902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7e5XCCyINAJ+NzY1e0bqdj0ZqmCV70DZ2zp5UsU/L/o=;
	b=548TD8ANtNA0cf5N0kK6iobtEySQVB71WWm72LLAHrEeJs7oaNoruMJp/y99lWtmEnxe27
	8LOM8Cdn9GNVpjCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 36DF013B9B;
	Tue, 19 Dec 2023 15:15:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9vLjC3azgWUyfgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 19 Dec 2023 15:15:02 +0000
Date: Tue, 19 Dec 2023 16:15:01 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v3 01/16] nvmet: report ioccsz and iorcsz for disc ctrl
Message-ID: <zxwj5jupg7rlbtdrqloecw3ta4oybfguue5hrdlf2j3o35xusv@wp6kq4kujfli>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-2-dwagner@suse.de>
 <e0eb22cd-9959-44cb-b913-4c1be9a2a2f6@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0eb22cd-9959-44cb-b913-4c1be9a2a2f6@suse.de>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -7.79
X-Spamd-Result: default: False [-7.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.99)[99.96%]
X-Spam-Flag: NO

On Tue, Dec 19, 2023 at 08:24:58AM +0100, Hannes Reinecke wrote:
> > +	 * Disable in-capsule data for Metadata capable controllers.
> > +	 */
> > +	cmd_capsule_size = sizeof(struct nvme_command);
> > +	if (!ctrl->pi_support)
> > +		cmd_capsule_size += req->port->inline_data_size;
> > +	id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);
> 
> Why the division by 16?

The unit size is 16 bytes:

  I/O Queue Command Capsule Supported Size (IOCCSZ): This field defines the
  maximum I/O command capsule size in 16 byte units.

