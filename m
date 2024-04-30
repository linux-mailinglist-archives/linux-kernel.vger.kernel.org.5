Return-Path: <linux-kernel+bounces-164240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D018B7B47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D981F230B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BD5143735;
	Tue, 30 Apr 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dJxwK9o4"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8C13D275
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490102; cv=none; b=SjNX7hDJCI4Z21TBN41J5YrSEZdbkANiKA7+fxvQZP/+upDTT/dmah1N2/o0r0KkfoflqNE3MoMfa8I6tugYodKpkwO3kTEGi4HHf0OXSLZwbBciyksj47QDawD0+NmsO18uPwS6t9vGvm56LmIhlajfsrZLiTs0MwI/Mf0Aw+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490102; c=relaxed/simple;
	bh=0q9JnC7AtHArcwRchYNVC63YijyWNbpeWNfZqlO+Gqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/EpEmjnkOR2vvlixvF8jKsdXV1Bk59o/No61lMgAngdA56KeWuCqFvtsqPqbPDHeo8A+gP6TCN6SvTAepdh8XwO0D8FaLoM/3IHS4MkuwH1u6Ns1aCZ/FIDYrZKxliPDDo2iLwtQWJAWT4jwr5x+WQ1xeEkOuuCEfqbBdg+wV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dJxwK9o4; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e0933d3b5fso24612561fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714490098; x=1715094898; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj+NJgrctHbYKvlDUtiq5+hS/4hqbk09ePj0poTKl4I=;
        b=dJxwK9o41dg19i796kwWa4WUkhpF0SkvnQjcKBwEH6fXJjy6lj25JBKPmcPb/IE9oB
         k0fKQ50jwzLec7v6GAbiL30/J3y2JkGs5EXLzDRe8Jo26RuMuVH8Bk7+MIwgqN6rKdty
         QLZlwKS2y1uwUy7nNzOdFW0+SQ53Qn07z3QpBbd2/ujTw1ibIPOyGwnRT7D22IGnlBie
         y/jahfJbfFjgiQcahfyH8rIAeIV1dB1A03GF8CpiYXPurO5SU5B3jTNl7xM9Tk/wRJFR
         PssLVSrisJs6v45O/gnigWhIs2ECW1JSEyz5lpjMcmOEVqilu2ETmj96Yw2Skdhge5IW
         h9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490098; x=1715094898;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj+NJgrctHbYKvlDUtiq5+hS/4hqbk09ePj0poTKl4I=;
        b=kX/FUWoBt9JQ0txtAxcO4u29M7onzNoDGBHxFoR7Tu/ss+7bEjy6yXTVMXsyAtuVUg
         EXpKCm0AiIIMklsorsULomwxxvuqUq3tZPwaCDQEa0YxaNPWIyX8iT3dreth5lL2SBSg
         q/fcFkLTHqyE38Tn3X2zGCEQ80r3d0zivMLJmLEONzZRWcpNScH3ui0X2NLgGM6jtNZ/
         mpcmX0I4bgDSvtyjbXLiP+On2SG/jSJC1PhmmuifOQ6d/VpTC7iw8+gcteC0G2uuNHBd
         MfQJju/eqpkdNttW1Z8uMrQ2W7Xj3Oj3H5f6ZmgK/7cY+U89Hj/LLx8llN+LGAQx4cDb
         cgHA==
X-Forwarded-Encrypted: i=1; AJvYcCUpjnLQ6TZ0Prr1V0df4IJuF4U6cAjk59v8w2LEmDJFWDy+3nqiUVQTL/e36kUTUbWSBeHVXa7OJHOrmMMK28OTpdEhWWAdsUXP4JQW
X-Gm-Message-State: AOJu0YyXORxSUvA7wh5KlBP4HV05uoltRU6wib95H4WMM/nJc/iP6DEf
	X79/dIr404dw4tBj9Q2qBgWuSs24cXTGhRz5O7db0nRAad2fq42TJ+SZKb0PuI4=
X-Google-Smtp-Source: AGHT+IF9v40sox6idzuZNof00mKqtsy+7kllosU/doJrGQv/BB2cC9RjYP5cJN23cV5HQfij89moNw==
X-Received: by 2002:a2e:900e:0:b0:2e0:3132:94d4 with SMTP id h14-20020a2e900e000000b002e0313294d4mr18367ljg.16.1714490097887;
        Tue, 30 Apr 2024 08:14:57 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001eb53dcf458sm6601555plg.188.2024.04.30.08.14.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2024 08:14:57 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:14:49 +0800
From: joeyli <jlee@suse.com>
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20240430151449.GM26307@linux-l9pv.suse>
References: <20240410134858.6313-1-jlee@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134858.6313-1-jlee@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Justin, 

On Wed, Apr 10, 2024 at 09:48:58PM +0800, Lee, Chun-Yi wrote:
> From: Chun-Yi Lee <jlee@suse.com>
> 
> For fixing CVE-2023-6270, f98364e92662 patch moved dev_put() from
> aoecmd_cfg_pkts() to tx() to avoid that the tx() runs into use-after-free.
> 
> But Nicolai Stange found more places in aoe have potential use-after-free
> problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
> and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
> packet to tx queue. So they should also use dev_hold() to increase the
> refcnt of skb->dev.
> 
> This patch adds dev_hold() to those functions and also uses dev_put()
> when the skb_clone() returns NULL.
> 
> Link: https://nvd.nist.gov/vuln/detail/CVE-2023-6270
> Fixes: f98364e92662 ("aoe: fix the potential use-after-free problem in
> aoecmd_cfg_pkts")
> Reported-by: Nicolai Stange <nstange@suse.com>
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>

Do you have any suggestion for this patch? or I missed anything?

Thanks a lot!
Joey Lee

> ---
>  drivers/block/aoe/aoecmd.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
> index cc9077b588d7..fcedbad8e3be 100644
> --- a/drivers/block/aoe/aoecmd.c
> +++ b/drivers/block/aoe/aoecmd.c
> @@ -361,6 +361,7 @@ ata_rw_frameinit(struct frame *f)
>  	}
>  
>  	ah->cmdstat = ATA_CMD_PIO_READ | writebit | extbit;
> +	dev_hold(t->ifp->nd);
>  	skb->dev = t->ifp->nd;
>  }
>  
> @@ -401,7 +402,8 @@ aoecmd_ata_rw(struct aoedev *d)
>  		__skb_queue_head_init(&queue);
>  		__skb_queue_tail(&queue, skb);
>  		aoenet_xmit(&queue);
> -	}
> +	} else
> +		dev_put(f->t->ifp->nd);
>  	return 1;
>  }
>  
> @@ -483,10 +485,13 @@ resend(struct aoedev *d, struct frame *f)
>  	memcpy(h->dst, t->addr, sizeof h->dst);
>  	memcpy(h->src, t->ifp->nd->dev_addr, sizeof h->src);
>  
> +	dev_hold(t->ifp->nd);
>  	skb->dev = t->ifp->nd;
>  	skb = skb_clone(skb, GFP_ATOMIC);
> -	if (skb == NULL)
> +	if (skb == NULL) {
> +		dev_put(t->ifp->nd);
>  		return;
> +	}
>  	f->sent = ktime_get();
>  	__skb_queue_head_init(&queue);
>  	__skb_queue_tail(&queue, skb);
> @@ -617,7 +622,8 @@ probe(struct aoetgt *t)
>  		__skb_queue_head_init(&queue);
>  		__skb_queue_tail(&queue, skb);
>  		aoenet_xmit(&queue);
> -	}
> +	} else
> +		dev_put(f->t->ifp->nd);
>  }
>  
>  static long
> @@ -1395,6 +1401,7 @@ aoecmd_ata_id(struct aoedev *d)
>  	ah->cmdstat = ATA_CMD_ID_ATA;
>  	ah->lba3 = 0xa0;
>  
> +	dev_hold(t->ifp->nd);
>  	skb->dev = t->ifp->nd;
>  
>  	d->rttavg = RTTAVG_INIT;
> @@ -1404,6 +1411,8 @@ aoecmd_ata_id(struct aoedev *d)
>  	skb = skb_clone(skb, GFP_ATOMIC);
>  	if (skb)
>  		f->sent = ktime_get();
> +	else
> +		dev_put(t->ifp->nd);
>  
>  	return skb;
>  }
> -- 
> 2.35.3

