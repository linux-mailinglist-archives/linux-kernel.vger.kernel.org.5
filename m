Return-Path: <linux-kernel+bounces-28868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE8A8303FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9301F24F65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60CF1CFB7;
	Wed, 17 Jan 2024 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="styaGKmK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="acYuKKYP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="styaGKmK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="acYuKKYP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73614AA5;
	Wed, 17 Jan 2024 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488990; cv=none; b=h5Xj6a8HHWPweOfQQDtLW+OiADIaXvhm/UDmXdC/WKXIo7ASlC5QzL4wtvmSF7nb9jjpRRquZq2MT/gtykpStcFWPjyNqrLiGKbIYggWTFNPvtW1qCg2A9EIbq/yD5sidfroOTQRCVkTpFGSYHlVLoqug4MAoi7GD2D4t+pQ308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488990; c=relaxed/simple;
	bh=WSGgAjBCNFTlFNiRizxkXoOuda2eNlpwVgzMjk2JrEU=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=onMSHCOUvjhl6CXmgLNkDK220R+Iv8QxBKNUphM7zkvDIO8oI3YApJpyRYzkxYdlXb4IbzOIjcho55lbXSBeEdobtZ5YpryZnPaZa3y/2HEPNWYr/0XhKvjJABEsqO6o/BLDE1RHqvpN2b+b2zwFFqDS7032lcmECaMwxw6QH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=styaGKmK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=acYuKKYP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=styaGKmK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=acYuKKYP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B2651FBF2;
	Wed, 17 Jan 2024 10:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705488987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/I5YOhlPZDB0xCXK6u+NS0O9D8UoMYtDZ/TUkUtwk1Q=;
	b=styaGKmK7tv1QTbE0Pf3u/0+YE7O7Z2/uW8YD4onOkDb/cErc4tbHMAfN05avlwMVr3zFT
	ighay/d+y+cfahaxRPgDEwnd7iGEGI5iVmNwdorQijXp7NTVA8MLEtpFupCzthXOhdehpS
	uiGbvYg9aU2eGzA1eG02fG0JhnRh82k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705488987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/I5YOhlPZDB0xCXK6u+NS0O9D8UoMYtDZ/TUkUtwk1Q=;
	b=acYuKKYPUiFqKzuymrfl73fv8gm0GAjTFE2S7Z8pvyWDqdMNmgotp757zT1ki/0uWozy+y
	MsKc/qy/Qqxds7BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705488987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/I5YOhlPZDB0xCXK6u+NS0O9D8UoMYtDZ/TUkUtwk1Q=;
	b=styaGKmK7tv1QTbE0Pf3u/0+YE7O7Z2/uW8YD4onOkDb/cErc4tbHMAfN05avlwMVr3zFT
	ighay/d+y+cfahaxRPgDEwnd7iGEGI5iVmNwdorQijXp7NTVA8MLEtpFupCzthXOhdehpS
	uiGbvYg9aU2eGzA1eG02fG0JhnRh82k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705488987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/I5YOhlPZDB0xCXK6u+NS0O9D8UoMYtDZ/TUkUtwk1Q=;
	b=acYuKKYPUiFqKzuymrfl73fv8gm0GAjTFE2S7Z8pvyWDqdMNmgotp757zT1ki/0uWozy+y
	MsKc/qy/Qqxds7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6707313751;
	Wed, 17 Jan 2024 10:56:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z1SwF1uyp2V0OQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 17 Jan 2024 10:56:27 +0000
Date: Wed, 17 Jan 2024 11:56:26 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Dick Kennedy <dick.kennedy@broadcom.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: Re: [PATCH] scsi: lpfc: use unsigned type for num_sge
Message-ID: <bhbx4emtgs4dxwryeorgq2igq3b2lu3k2ycdyn4ebwpbw4kxtp@aijstnvpilho>
References: <20231220162658.12392-1-dwagner@suse.de>
 <CAGx+d6cGuC8S2+_ipyKMtOxNQ5a0RW_H46jrwWJjwRx5TRw-ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGx+d6cGuC8S2+_ipyKMtOxNQ5a0RW_H46jrwWJjwRx5TRw-ww@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=styaGKmK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=acYuKKYP
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.02 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[50.17%]
X-Spam-Score: -3.02
X-Rspamd-Queue-Id: 7B2651FBF2
X-Spam-Flag: NO

Hi Dick,

On Fri, Dec 22, 2023 at 10:04:50AM -0800, Dick Kennedy wrote:
> The change is good, however, I  don't think this was really the
> problem.

I tried to write the commit message based on the bug report we got. So
yes, it's possible the it is not correct as I was not really involved
and might missinterpret it.

> We would  like to know if this patch really solved an issue they
> observed.

Yes, it fixes the reported problem.

>  A good data point to know is what adapter they're using.

A bunch of different HPE cards which show this log entry: SN1700E,
SN1610E and SN1200E.

>  If that adapter supports hybrid sgl (i.e. phba->cfg_xpsgl), then we
>  would have set the max sg_tablesize = LPFC_MAX_SG_TABLESIZE = 0xffff.
> 
>  But even then, this patch implies that dma_map_sg() returned a crazy
>  huge amount with the MSB set.

Sure, though this seems to be the case.

One noteworthy information is that DIF needs to be enabled to trigger
it:

# cat /sys/module/lpfc/parameters/lpfc_enable_bg
1
# cat /sys/module/lpfc/parameters/lpfc_prot_guard
2

Thanks,
Daniel

