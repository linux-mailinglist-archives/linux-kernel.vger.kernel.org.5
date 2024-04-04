Return-Path: <linux-kernel+bounces-131393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B24E89870C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56DB295794
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C767127B69;
	Thu,  4 Apr 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1P2aKLH"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7A8127B50;
	Thu,  4 Apr 2024 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232890; cv=none; b=OXrfX9kgqKytUuyUPc0IRy108UipVCM//hu+tbskNfJoWc/w8+fdzDno+bnlkxJWTvzOOwrBkA0WZVTKzNYEhTSnT4b7qMa71v4y25+wM35irNDhJE+AiC6XTbhu1N4KXxdJTW9PGdshej3CF+guH3h+flTp/nOgKxY0fUGlYZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232890; c=relaxed/simple;
	bh=rOAdoL6tHaMG/zwN7wWRADpEydV7O+1IUICz69AHOf8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz83CGo+JO20UzxOcHZkN+mnli3w7d0cJahlP3/5BPJBH+5hu55BJvCID1fXZsMM0wIBFex6CB+QGGucLX8JBeOvC0WyLxaIOCJtaNkyQ+sv/GNGGarHcT2/qYVCivcTOlPuuQevR4nutZjPnbMFVKNlkQ3vHdcxoYNYRRWjdDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1P2aKLH; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d85da5a7d1so2520071fa.0;
        Thu, 04 Apr 2024 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712232887; x=1712837687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0bUZo/pGzDNuYFiyOW47yNiCIYxU4kzybrhVLN1vRNs=;
        b=R1P2aKLHuiyQDlVyrvuve7a+OjWxN6n1HwpPApPQ1tjKjzJHLlhlxKqilli4tY+PwI
         H6LEzKShyGm6v437490SQnKprn26vkw9FJMSOnnJt+ja1utBbRJZsQQcLL1SShBmUE+K
         wJWyz66wnj7UAHGnVcEY8QwdmloOK8claXpoMSMpgudEPCkASY4eiXWtXnp/8VuNEkiD
         66Abyt9dlhzfSGQ3v5hDjFfy2kuKxrfV1aM9teBDto0c0WNIJqc1sGoeqe+2S0SfZZ1N
         ISjrcsBHuJP32cg0beai7L0X4EyUfTk9jmIVvB+c0vKGuN60P0SbLFev7yEecpX+ajZo
         Qpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712232887; x=1712837687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bUZo/pGzDNuYFiyOW47yNiCIYxU4kzybrhVLN1vRNs=;
        b=OVrf1sfovlASQmHZpllBnw1yih7uj8a4cmg0Hgq7konUiuN1J/ChsgsSieg9U5YlH8
         809i2rnKYBv9JV8tPQIs9Aj5425Slx2wGIJ3tbQ+QyH/Q/JvQCtsiqX0EctVV0L/n9tX
         CcPrO7mDz1b6C4uKpB83TjQJgCcTUPGxuCnGcbcqTGXx8feEq/skBuAase+sMg95ARCJ
         kmZEK8z5X0CUsjP0Pk+u0G2DX8zxVyEx1+0E9rjv37jO96nOsk3vOcGTfbPn/ZZParU1
         JdXRq9N2WrQpOsYoFq9eLY79W+rqlriaSUgVl8SihXY3a6a7GqCE/ok6zwhwbC0ZbMC+
         njHw==
X-Forwarded-Encrypted: i=1; AJvYcCVqkFCeRFmXORs/taE7UzmccEHMC2P1IRWYuXI05ouXiNCt8wBlsKEQV14Rplk2egwhmrexTkGAnWlXAZkCdBmVIcwyGwABGvOOPrXd4jNo3Bijxm3BEdiu4TIEo96fmzSPlJ3JBR826g==
X-Gm-Message-State: AOJu0YzoY+cIGaXpE6M+NkDuhNDbBr28qPc74IIcN4EFkoblA5pu/xGA
	9e+gFjz59JNxtXGg44ipWyNMRG4TEWQioXaLYKZXI6f3lcLsLPjNm8cRdFfF
X-Google-Smtp-Source: AGHT+IFx9UQY4y+jjtNaDdJmgXCy8TISkHZLbhqawJtLmLtM00wjEtv0sQJ4gIIXFwtWO1M1e8b/CA==
X-Received: by 2002:a2e:bb84:0:b0:2d6:d044:aab5 with SMTP id y4-20020a2ebb84000000b002d6d044aab5mr817311lje.11.1712232886526;
        Thu, 04 Apr 2024 05:14:46 -0700 (PDT)
Received: from pc636 (host-90-235-13-217.mobileonline.telia.com. [90.235.13.217])
        by smtp.gmail.com with ESMTPSA id u22-20020a2e8556000000b002d834cb0400sm532238ljj.17.2024.04.04.05.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:14:46 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 4 Apr 2024 14:14:43 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the rcu tree
Message-ID: <Zg6Zs76UDYQsJTWM@pc636>
References: <20240404083923.358c23da@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404083923.358c23da@canb.auug.org.au>

Hello!

> Hi all,
> 
> In commit
> 
>   a55be9aacc45 ("rcu: Do not release a wait-head from a GP kthread")
> 
> Fixes tag
> 
>   Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() users")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 654f59c6bc95 ("rcu: Support direct wake-up of synchronize_rcu() users")
> 
I have a question. Could you please clarify why those commits are in the linux-next?
Those commits have to go over RCU tree. It looks like i am missing something but
please elaborate.

--
Uladzislau Rezki


