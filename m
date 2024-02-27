Return-Path: <linux-kernel+bounces-83322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5717D86924C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37D31F2C2E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E809113B790;
	Tue, 27 Feb 2024 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="amMilfmY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LSSUDJKG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="amMilfmY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LSSUDJKG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7292F2D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040835; cv=none; b=WySpAxtly2DPk2e4pjyrKtq0DgKUFghETyb1WuQ/8pbDBTdbqPdVjmV5U2tUpAWzKHJ7/q2Z930wz03f705qQ7dHqSuoepVmo6c0oDnc/SNEezAPHf6JUWTRxGaEeSETyI9QYbVZRzoSUJtFTY4jlugVSDcip348Y/VPKtNX4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040835; c=relaxed/simple;
	bh=YCjkphyYd93Pa3k/NBo+cIfQacjcPXiEbrqj9HyhGBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMt//BPHMOgsKrZ7Gp/X9YOirQPXEZgIfDmjFuKjf3k2plFV4AfId9fwW4FkbDTbc2Qg9w+CwjsncRC+9cA1JrGpgxuAdlgZA0lvPH2sahyGmOBN30Ocpe3h6wP+uc3kvDgbAY4IxveFu+Sehg+z4gaE7UC2pDOUIz3JlYtvBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=amMilfmY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LSSUDJKG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=amMilfmY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LSSUDJKG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A69191FD29;
	Tue, 27 Feb 2024 13:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709040831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tlnyDGCnXlqIC5zZC4e+7N/PDrR9e00QBUMoKm3jK4=;
	b=amMilfmYkz7yPAuVUZvIxnN/GkUmJL4y2ynHfWjAVlyrs1VZQJgm53QrD23O9jJBxzjvJm
	ET4b2I+BkhJgmJTczm88rgpTTgkxv0n0vyadZsNVSRoonHZ8kgdSAO3XrZpFIPeiMlxzlg
	2nK5m2KZpQZDakgBR2wDcOszvMdRSYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709040831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tlnyDGCnXlqIC5zZC4e+7N/PDrR9e00QBUMoKm3jK4=;
	b=LSSUDJKGQvxo2mzlVZTygmnzYJCQnbmWQk6eabkiDnFKbb/lpXggAEUZCLXdvp3xexA9rf
	DPtCwJJ6vtRGj5Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709040831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tlnyDGCnXlqIC5zZC4e+7N/PDrR9e00QBUMoKm3jK4=;
	b=amMilfmYkz7yPAuVUZvIxnN/GkUmJL4y2ynHfWjAVlyrs1VZQJgm53QrD23O9jJBxzjvJm
	ET4b2I+BkhJgmJTczm88rgpTTgkxv0n0vyadZsNVSRoonHZ8kgdSAO3XrZpFIPeiMlxzlg
	2nK5m2KZpQZDakgBR2wDcOszvMdRSYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709040831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tlnyDGCnXlqIC5zZC4e+7N/PDrR9e00QBUMoKm3jK4=;
	b=LSSUDJKGQvxo2mzlVZTygmnzYJCQnbmWQk6eabkiDnFKbb/lpXggAEUZCLXdvp3xexA9rf
	DPtCwJJ6vtRGj5Bw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6931313216;
	Tue, 27 Feb 2024 13:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id DOlOFr/k3WUSbgAAn2gu4w
	(envelope-from <clopez@suse.de>); Tue, 27 Feb 2024 13:33:51 +0000
Message-ID: <94330624-1f8b-49b8-8a66-b7adf1f589f4@suse.de>
Date: Tue, 27 Feb 2024 14:33:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2021-46934: i2c: validate user data in compat ioctl
Content-Language: en-US
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2024022750-CVE-2021-46934-79c8@gregkh>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
In-Reply-To: <2024022750-CVE-2021-46934-79c8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=amMilfmY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LSSUDJKG
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.38 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.88)[99.50%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -6.38
X-Rspamd-Queue-Id: A69191FD29
X-Spam-Flag: NO

Hi,

On 27/2/24 10:48, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> i2c: validate user data in compat ioctl
> 
> Wrong user data may cause warning in i2c_transfer(), ex: zero msgs.
> Userspace should not be able to trigger warnings, so this patch adds
> validation checks for user data in compact ioctl to prevent reported
> warnings

What's the security impact here exactly?

-- 
Carlos López
Security Engineer
SUSE Software Solutions

