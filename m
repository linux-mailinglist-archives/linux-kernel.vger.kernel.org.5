Return-Path: <linux-kernel+bounces-57857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4381F84DE41
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0831F2A2C6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8836E2BF;
	Thu,  8 Feb 2024 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TV+Jl6Hv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PJ8H54sj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TV+Jl6Hv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PJ8H54sj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E0A6BB43;
	Thu,  8 Feb 2024 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388011; cv=none; b=T5mJiUyOuRR2CNsY0c0oyBRg8s8gy7LlJUB8XKY6Ir2fkdvJSgJCx34DvLp/kqoomUhFq19+RWBa8OJR3hwjqf4C84nj2KMTsehk4qyWJBOPVSebdsh+Yn8tHQV2sa/QL6rBQ4Q5RtNu7Kyn39S18EeBnZQkn+clJgHxeX9DLhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388011; c=relaxed/simple;
	bh=UtxUE6IoeJgtEm9lYVXJ8l65gnFyjvidFV2NZr3vEOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAwl+uAvsnASmXQEJyRBDmtjKIaF86d0g6uYQ+28deW9j2zGxM/dElOCKtWlxPCKYQ0dzv/M0nVwWcQvqdjyCgjrzjyLkf8xcXS27e5OqSiLJdmzVBkYBM+4tk74xejsczcUwCLNoLYeUtyYZ0Y1Vy2BG/D0PXNO28T0HRVs1kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TV+Jl6Hv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PJ8H54sj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TV+Jl6Hv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PJ8H54sj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4DE021E40;
	Thu,  8 Feb 2024 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707388007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7l1Hzsbgh/dM4Eg7kH6VEERVic/fqlclsX/STOV6QiU=;
	b=TV+Jl6HvUdJGEofKQUWenxE09osqYOqfchXsSq80AiDF3LNosGBALEx2KsYWLENzfRb+s6
	mKM69lmHHG7fZLnbtiUocXhyjNxPYZt1z/dpuvZQ6pU3oY/HuM9qe8Nu6lyig3Y5cgk0xL
	d8k4LvfccCNwf73MXHha6nxDtRUtlrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707388007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7l1Hzsbgh/dM4Eg7kH6VEERVic/fqlclsX/STOV6QiU=;
	b=PJ8H54sjYEBVpkvSFT7e7/3P8QpOR0Ws3WHPd7/+zzES+CxtKJBTnoz/yv9Fap/PPmMjTf
	nAYlDrWaXXtBGzBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707388007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7l1Hzsbgh/dM4Eg7kH6VEERVic/fqlclsX/STOV6QiU=;
	b=TV+Jl6HvUdJGEofKQUWenxE09osqYOqfchXsSq80AiDF3LNosGBALEx2KsYWLENzfRb+s6
	mKM69lmHHG7fZLnbtiUocXhyjNxPYZt1z/dpuvZQ6pU3oY/HuM9qe8Nu6lyig3Y5cgk0xL
	d8k4LvfccCNwf73MXHha6nxDtRUtlrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707388007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7l1Hzsbgh/dM4Eg7kH6VEERVic/fqlclsX/STOV6QiU=;
	b=PJ8H54sjYEBVpkvSFT7e7/3P8QpOR0Ws3WHPd7/+zzES+CxtKJBTnoz/yv9Fap/PPmMjTf
	nAYlDrWaXXtBGzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEB541326D;
	Thu,  8 Feb 2024 10:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ENvCLmasxGUJKAAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Thu, 08 Feb 2024 10:26:46 +0000
Message-ID: <e7b4a82d-8942-4e7b-bd4d-3a3ede42a85e@suse.de>
Date: Thu, 8 Feb 2024 13:26:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] net: ipconfig: remove wait for drivers
Content-Language: en-US
To: David Ventura <david@davidv.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Xiongwei Song <xiongwei.song@windriver.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>
References: <20240208093722.246930-1-david@davidv.dev>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240208093722.246930-1-david@davidv.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.25 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.16)[69.11%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.25



On 2/8/24 12:35, David Ventura wrote:
> Currently ip autoconfiguration has a hardcoded delay of 10ms.

The subject line should be prefixed with net-next

> 
> Make the delay configurable via the new `ip.dev_wait_ms` argument, and
> set the default value to 0ms.
>     
> 
>     David
> 
> 
> 

