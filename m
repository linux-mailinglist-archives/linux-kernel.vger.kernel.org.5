Return-Path: <linux-kernel+bounces-10602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508381D731
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 00:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33211F21DF0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 23:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B4F200BA;
	Sat, 23 Dec 2023 23:17:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F611D55E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fcbbd1dbaso32230775ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 15:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703373442; x=1703978242;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUZpK4dHEqnEesO3MJLqD1Yf+ic5Z6+dFQBYzrg0joE=;
        b=ovjYFcl8OG67EQo+9Htsm0/ZqhR+MvXxgHrCz2tEWvaMsf6hsF6+k/O1hG2E1OQQDT
         aKKwR81UaKNWl0Fr1dFUwddWJGD5C1RUC4F9IHwaL0oAh723b5Pcuu3vuRfnOc1TROQT
         LSacgaApe10RnES2HSteU6Bi/tZJZt6y0LQahwAxB1NMl4sq+gnoFH5xC900jil2GVk3
         WdcJ0DTERjul+OfHA9LLrJ2y5JpALxE9oHg9WqcGJd6WuPWxKPLVK3iY4i6W2pJXJhUz
         3EYYRM9OSRTJqNINFsNcAfDohD4FaKmztZYFmpHRS0d/q+7KAR2B4OL88k+F9kRPZeJX
         G6UQ==
X-Gm-Message-State: AOJu0YwXI9l7i23wZXyREzFeAjorrmZ/9LkSy4c6jhUoWDjXjRH5dVnq
	gD/yxyq2OMczyL5U/v2I2V8y6b2TLQtOVyxO8f6nmfdMFDN8
X-Google-Smtp-Source: AGHT+IHXWjhzq5UX73UJ2Svrl/Lqi/8ZJ7ThNCsst+jNgaqcVzGKDEiQwZy6MgHE5E7M3QOiHQEDc7a4HbTzfF7igPd97frRll+/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:35f:ebc7:6065 with SMTP id
 j10-20020a056e02218a00b0035febc76065mr240526ila.1.1703373442281; Sat, 23 Dec
 2023 15:17:22 -0800 (PST)
Date: Sat, 23 Dec 2023 15:17:22 -0800
In-Reply-To: <2591733.1703373433@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f27a0d060d358835@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dns_resolver_preparse
From: syzbot <syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com>
To: dhowells@redhat.com
Cc: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	jarkko@kernel.org, jmorris@namei.org, keyrings@vger.kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

want either no args or 2 args (repo, branch), got 5

>
> diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> index 2a6d363763a2..f18ca02aa95a 100644
> --- a/net/dns_resolver/dns_key.c
> +++ b/net/dns_resolver/dns_key.c
> @@ -91,8 +91,6 @@ const struct cred *dns_resolver_cache;
>  static int
>  dns_resolver_preparse(struct key_preparsed_payload *prep)
>  {
> -	const struct dns_server_list_v1_header *v1;
> -	const struct dns_payload_header *bin;
>  	struct user_key_payload *upayload;
>  	unsigned long derrno;
>  	int ret;
> @@ -103,27 +101,28 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
>  		return -EINVAL;
>  
>  	if (data[0] == 0) {
> +		const struct dns_server_list_v1_header *v1;
> +
>  		/* It may be a server list. */
> -		if (datalen <= sizeof(*bin))
> +		if (datalen <= sizeof(*v1))
>  			return -EINVAL;
>  
> -		bin = (const struct dns_payload_header *)data;
> -		kenter("[%u,%u],%u", bin->content, bin->version, datalen);
> -		if (bin->content != DNS_PAYLOAD_IS_SERVER_LIST) {
> +		v1 = (const struct dns_server_list_v1_header *)data;
> +		kenter("[%u,%u],%u", v1->hdr.content, v1->hdr.version, datalen);
> +		if (v1->hdr.content != DNS_PAYLOAD_IS_SERVER_LIST) {
>  			pr_warn_ratelimited(
>  				"dns_resolver: Unsupported content type (%u)\n",
> -				bin->content);
> +				v1->hdr.content);
>  			return -EINVAL;
>  		}
>  
> -		if (bin->version != 1) {
> +		if (v1->hdr.version != 1) {
>  			pr_warn_ratelimited(
>  				"dns_resolver: Unsupported server list version (%u)\n",
> -				bin->version);
> +				v1->hdr.version);
>  			return -EINVAL;
>  		}
>  
> -		v1 = (const struct dns_server_list_v1_header *)bin;
>  		if ((v1->status != DNS_LOOKUP_GOOD &&
>  		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
>  			if (prep->expiry == TIME64_MAX)
>

