Return-Path: <linux-kernel+bounces-76917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA00985FE96
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D0F2829E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DCE15530F;
	Thu, 22 Feb 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q2QzjfdH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zyQ3Frww";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q2QzjfdH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zyQ3Frww"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB59F1552F5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621347; cv=none; b=gSMhgX5+txQW8Ai395B9YWPIuMcHxlL5ftQQUUFzREmX5OarKm7WjF4kj3fBgYuCDBDNcYoM2ppukegHqg7Z9dQI88AHDrHQa1YvTTPM4r5kLJcsPJb97doT1mekf5rxwpS5vAJtlaOjVjA3A9mTiMT6U7CWtb/emoUNoZXKoWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621347; c=relaxed/simple;
	bh=Otwg0s0yngddDxcSY4m5qW+cCqDwGxFtTGVIh2GYHSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiCRBsW8geZ58ci5wKotvDW6qy0QNNvRYL8CPFDT9v1RiR7mGswHxi2AziEpnMX/1K6Qh6w0BfFAO9g1LjAqizgj2uKC+yjUFOjHbYGflR2EUpVI1ChvksT97Kp2rECDZv9JsTAv+ov6BCG1FENUTinQJtvG5fGMGhCnSCPQ1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q2QzjfdH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zyQ3Frww; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q2QzjfdH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zyQ3Frww; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0876E22040;
	Thu, 22 Feb 2024 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708621335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLucWJAnSoNf82M7QH7aDsfl6ohwEWpNqi7zovHhgTk=;
	b=q2QzjfdHd5YffiUmCT5S74RFu/H3Wl8qNGgac1dXuh76sRccZS+SHdnQYIN+HBgi7fjLvn
	YwMiJXnBPogtzlYtvTccsbUqVl7uzyxnmfhvT0x58Uak4CF6vZ0LS6TevsnDxJAWEwiAkf
	ZdbyK9LBKukLWcRLqavsewlhLR8y3E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708621335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLucWJAnSoNf82M7QH7aDsfl6ohwEWpNqi7zovHhgTk=;
	b=zyQ3FrwwpKxW+a2lRJUo42X3qXwU971H7n9y+5ymLLEsE2QSSaWnVDGJEEPkWvRzJij2EO
	jC6SxQ7cJQ9qYGBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708621335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLucWJAnSoNf82M7QH7aDsfl6ohwEWpNqi7zovHhgTk=;
	b=q2QzjfdHd5YffiUmCT5S74RFu/H3Wl8qNGgac1dXuh76sRccZS+SHdnQYIN+HBgi7fjLvn
	YwMiJXnBPogtzlYtvTccsbUqVl7uzyxnmfhvT0x58Uak4CF6vZ0LS6TevsnDxJAWEwiAkf
	ZdbyK9LBKukLWcRLqavsewlhLR8y3E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708621335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLucWJAnSoNf82M7QH7aDsfl6ohwEWpNqi7zovHhgTk=;
	b=zyQ3FrwwpKxW+a2lRJUo42X3qXwU971H7n9y+5ymLLEsE2QSSaWnVDGJEEPkWvRzJij2EO
	jC6SxQ7cJQ9qYGBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E93FD13419;
	Thu, 22 Feb 2024 17:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Fot9NxZ+12XJBwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 22 Feb 2024 17:02:14 +0000
Date: Thu, 22 Feb 2024 18:02:09 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Message-ID: <hxr2hztb64dank3jvbnrlciaebo4k2qkkrg3brhrppizeyelpo@ewupxurl7iqm>
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
 <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
 <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
 <609e0031-e97c-466b-8cbd-47755374b117@suse.de>
 <3xhhdconprn3vvkky4yj4iazku4eiqxl6l6rw6z5tivvdjwaby@ts7satqbih7w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3xhhdconprn3vvkky4yj4iazku4eiqxl6l6rw6z5tivvdjwaby@ts7satqbih7w>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q2QzjfdH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zyQ3Frww
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: 0876E22040
X-Spam-Flag: NO

On Thu, Feb 22, 2024 at 08:45:04AM +0100, Daniel Wagner wrote:
> On Thu, Feb 22, 2024 at 07:46:12AM +0100, Hannes Reinecke wrote:
> > On 2/21/24 17:37, Daniel Wagner wrote:
> > > On Wed, Feb 21, 2024 at 04:53:44PM +0100, Hannes Reinecke wrote:
> > > In this case yes, I've tested on top of this patch. This breaks the loop
> > > where the provided key is invalid or is missing. The loop would happy
> > > retry until reaching max of retries.
> > 
> > But that's to be expected, no?
> 
> Why? If the key is wrong/missing it will be likely wrong/missing the
> next retry again. So what's the point in retrying?
> 
> > After all, that's _precisely_ what
> > NVME_SC_DNR is for;
> > if you shouldn't retry, that bit is set.
> > If it's not set, you should.
> 
> Okay, in this case there is a bug in the auth code somewhere.

With the change below nvme/041 also passes:

modified   drivers/nvme/host/fabrics.c
@@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -475,7 +475,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid 0: authentication setup failed\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		ret = nvme_auth_wait(ctrl, 0);
@@ -540,8 +540,9 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		/* Secure concatenation is not implemented */
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
-				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+				 "qid %d: secure concatenation is not supported\n",
+				 qid);
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -549,7 +550,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid %d: authentication setup failed\n", qid);
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 		} else {
 			ret = nvme_auth_wait(ctrl, qid);
 			if (ret)

Is this what you had in mind?

