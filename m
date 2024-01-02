Return-Path: <linux-kernel+bounces-14197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80F78218FE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D872C1C21437
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B525FD266;
	Tue,  2 Jan 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vVwIFhjD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aSrVRgSr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vVwIFhjD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aSrVRgSr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345BCA64;
	Tue,  2 Jan 2024 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22BEC1FCEE;
	Tue,  2 Jan 2024 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704188383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6HV5HJpG1KKudNCL8oIywmvIrREkaLBolbe1DzJoFAg=;
	b=vVwIFhjDTTO4c0zm4tHaOvX6OEHGLAgz9YRcYQIvKp+gx57R76BaNzVciF7VFg2prfEBP5
	TBehobeTh9R7bzU69TdBM21gy0zT6ISn5Cs136j8WPJ7zsS+qUxcYIxyo2k9bsxriX9PmS
	oIBjXrOlQTOx2ImxSdTt7TXfLW2aNdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704188383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6HV5HJpG1KKudNCL8oIywmvIrREkaLBolbe1DzJoFAg=;
	b=aSrVRgSr6MVxcpTyo9eLtVgG8cHXTVP7vfKFyckc7DgOOl5KA4BylcoZrXMUL+GGID0QWV
	xhopyGNO694mXBAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704188383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6HV5HJpG1KKudNCL8oIywmvIrREkaLBolbe1DzJoFAg=;
	b=vVwIFhjDTTO4c0zm4tHaOvX6OEHGLAgz9YRcYQIvKp+gx57R76BaNzVciF7VFg2prfEBP5
	TBehobeTh9R7bzU69TdBM21gy0zT6ISn5Cs136j8WPJ7zsS+qUxcYIxyo2k9bsxriX9PmS
	oIBjXrOlQTOx2ImxSdTt7TXfLW2aNdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704188383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6HV5HJpG1KKudNCL8oIywmvIrREkaLBolbe1DzJoFAg=;
	b=aSrVRgSr6MVxcpTyo9eLtVgG8cHXTVP7vfKFyckc7DgOOl5KA4BylcoZrXMUL+GGID0QWV
	xhopyGNO694mXBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1369413AC6;
	Tue,  2 Jan 2024 09:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XRFSBN/Zk2U7DwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 02 Jan 2024 09:39:43 +0000
Message-ID: <0d98192e-f9ac-cc49-fd7e-3551c7af1881@suse.cz>
Date: Tue, 2 Jan 2024 10:39:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: linux-next: manual merge of the rcu tree with the jc_docs tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 "Paul E. McKenney" <paulmck@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231218142537.3b74c770@canb.auug.org.au>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231218142537.3b74c770@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.31
X-Spamd-Result: default: False [-1.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.02)[51.97%];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.19)[-0.960];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 12/18/23 04:25, Stephen Rothwell wrote:
> Hi all,

Hi,


> Today's linux-next merge of the rcu tree got a conflict in:
> 
>   Documentation/admin-guide/kernel-parameters.txt
> 
> between commit:
> 
>   a3a27827452f ("Documentation, mm/unaccepted: document accept_memory kernel parameter")
> 
> from the jc_docs tree and commit:
> 
>   801f246637ed ("doc: Add EARLY flag to early-parsed kernel boot parameters")

in light of that commit, the accept_memory should now have:

 +	accept_memory=  [MM,EARLY]

Jon, can you update it still, or want a followup patch, or perhaps will
suggest Linus to do that as part of the merge?

> 
> from the rcu tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 


