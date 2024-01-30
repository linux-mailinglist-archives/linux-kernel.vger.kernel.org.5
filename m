Return-Path: <linux-kernel+bounces-44352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E9384209C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F3F1C24A70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55A7664A9;
	Tue, 30 Jan 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OQv7KNAy"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0057867
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609137; cv=none; b=uOXPQ1N7+KxNroXDPQjirfINsZtqAcvI3XF4sC01OaSlHnVVgJSMuJBqTehkcxBQMPjFOB8AFvjRILhcF20Gd8Fv0FariE5IXl6gtzx1FqmLvBC8UxKvGck7r95C+BiwX2jOn+iHjokvPgDWHJxJiXz8sNt+0h5CHwPsVsp10Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609137; c=relaxed/simple;
	bh=DRlRQXLhsU0+cKh3w23bLq1XFJxx5MrK/ImH2gQ3Op4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7h7mP+NthvPnCWCYKjPt2eTg6TeRdcSFWEM4TXw1HQ49wOlGTwc/UibUOLOJvtzsgH3HAlnqqbd+yV1TA371YK07j5uQdOymC0+UU3t9iLhs2xXBA6Ps4zOzICdSZP9XlCIy3VdA73Lkmx3WgukCOTs7eh1Dv5j2j6DbAMbs4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OQv7KNAy; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55ef011e934so2800491a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706609132; x=1707213932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vNUijCkfAL5sfK5WTVaGUY4h4o2ULqP8+6/IA0phaQk=;
        b=OQv7KNAysFMWt3Z2bD4a7Dnjr/Z80w7sYgerEm9uhxdgv7J8nQB5MD/Rr8D9ulFRKY
         TtMO8mK/69gSJLdOy8mtYI0L+t66erGKmw5zuGWcaFmt5ECiN4veuFS93q4cMJzusZQh
         RL7N8qCNdj8m3517q8RsnE+4VpqkiqoHkEDET3i1QBewsVpS3F1AKeZwyaDmGV8Sm0VN
         6nmL1MetEGT7NiwwOF1HRMM1unJ74MbRC3oZjgNtRq1oy23DRr3btqm7vNW2l+l5OR4V
         dD5OsS1UMusbs6kXgHXBIosrW00KLCTdxnvzqXjcjg/uchAaJqJ6jpcbmzH33F2PJjOk
         imwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706609132; x=1707213932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNUijCkfAL5sfK5WTVaGUY4h4o2ULqP8+6/IA0phaQk=;
        b=O/CFlH8thu7iIjK4QeDUMTHQqMCYbrQokCvvbxhi0kMfs7PFE/kKZkGUFOEnLfjTki
         0Avnd3E/EK3jfhLPhgVu6DDe3Qjfq/XpO32n9l+fXnvE6bdl6es2Gi3+1VAvHTNRg9AV
         LCApNOjePEfxmxQeexmMBZAHzndJYkR0bcrNa5sUyk3fqhpZU1vRLAR+3xhIG8WSkiLP
         vGRuut++hu5E2EN4MzS8ko6oDYSYh6diuNLQlR2BtSttpuokkM8LbFqCAeCqvtPlh1R/
         tD0AbM2ezN5jX8mrFjQLpUmIObkf6zGYtVEFFHiUcd7xU/gnhDX16H+WKuEaDsXvLkYM
         qH7Q==
X-Gm-Message-State: AOJu0YwJpKaeXU1qeMGfDSCs0hJOzSz8nBshLHhEqzV1wqjmiES1suj+
	JMVVHnFbMwAUXCNEWSPnUvuBVPhPunqgmStoAIyClgxlZ6gFkFb/c/PaAhmuonw=
X-Google-Smtp-Source: AGHT+IHuiHgGkkgi9w9V6/5T2cGD46YnixDp6OWJTGuzWpVdpX0pdAoc5abTFOTwONmcrsmDfpovrw==
X-Received: by 2002:a17:906:140a:b0:a33:b64f:48c1 with SMTP id p10-20020a170906140a00b00a33b64f48c1mr5919446ejc.21.1706609132502;
        Tue, 30 Jan 2024 02:05:32 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id tl10-20020a170907c30a00b00a3554bb5d22sm3545686ejc.69.2024.01.30.02.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:05:31 -0800 (PST)
Date: Tue, 30 Jan 2024 11:05:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ipv4: Simplify the allocation of slab
 caches in inet_initpeers
Message-ID: <ZbjJ6CB5NgMIfBwk@nanopsycho>
References: <20240130092255.73078-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130092255.73078-1-chentao@kylinos.cn>

Tue, Jan 30, 2024 at 10:22:55AM CET, chentao@kylinos.cn wrote:
>commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
>introduces a new macro.
>Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>to simplify the creation of SLAB caches.
>
>Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>---
> net/ipv4/inetpeer.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
>index e9fed83e9b3c..5bd759963451 100644
>--- a/net/ipv4/inetpeer.c
>+++ b/net/ipv4/inetpeer.c
>@@ -81,10 +81,7 @@ void __init inet_initpeers(void)
> 
> 	inet_peer_threshold = clamp_val(nr_entries, 4096, 65536 + 128);
> 
>-	peer_cachep = kmem_cache_create("inet_peer_cache",
>-			sizeof(struct inet_peer),
>-			0, SLAB_HWCACHE_ALIGN | SLAB_PANIC,
>-			NULL);
>+	peer_cachep = KMEM_CACHE(inet_peer, SLAB_HWCACHE_ALIGN | SLAB_PANIC);

The name is going to be different. Could it be a source of some issue?
My guess is not, just want to make sure.



> }
> 
> /* Called with rcu_read_lock() or base->lock held */
>-- 
>2.39.2
>
>

