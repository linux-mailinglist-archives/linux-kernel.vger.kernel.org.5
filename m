Return-Path: <linux-kernel+bounces-53983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2F484A8C9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D72A1F2F150
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C2D5B5D9;
	Mon,  5 Feb 2024 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAOkdP8s"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94F5B5D3;
	Mon,  5 Feb 2024 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707169767; cv=none; b=ad85uhg4qdmmGv4oLTiyzUzWtbICMQkZ1a/6M9q5AEZd1TOlh7vPZOVLtu8m+ZLzPeggzvtT+GzTBvG+ax69U9gGtsB4cqZ4T6k7GwftRBuPAOlCfvOpDC2HDFSdn3mJlqvVqDqKFeFFZyAsS/6dYJ0L/Hzqa3zR3Uueb2B+ayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707169767; c=relaxed/simple;
	bh=H0EgLLQuvRwNSZFPS+M4D5ZE0WJgp0IlRD7jN/I2Mr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfBD3eQ1Rwu+cyGCsHj8Otp6iKiYk2ockLJosc8g/NARrFXOmXFkfCCq1nK5DsAl64NjRuYDgSCfpAikuuxHenE2l7IKKQ3AmkWVU9jVoE11VjZcm92jAdprcTH2lHlMhqHqSH6kbBZGOBdv07+eZL+qd//V1phJKJaqHZQimqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAOkdP8s; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51124db6cf0so4382868e87.0;
        Mon, 05 Feb 2024 13:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707169764; x=1707774564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=djlDB1yai86ULUJKX1P2fQaEEp42bjwvo7JjIo1+7Q8=;
        b=LAOkdP8sxC8IJJ43nPIxjwT3CEXu3ohL7tCla3nkjjYoov6a6awB40fO/0dd9csDNp
         Lq92JmCEZrz7sa1ktiep79uWvsjAiRSx0BWQszAjpFlXAJtqnjlllXYl5TK/SYBfsLVi
         5iyJf+6E0T0mZ0YoDS+jzg/+lwZ/DPW9jVHCzNqflhf4CVLAquiq/LH0YLmt7ibQG6Th
         wDFd86R7GiHewgchzvYSP3Ql/VqTvlsZljam64DtEZC+WHGw6AcQ5aBSaYbHNP4qjjTN
         KYHNNIjbUUXuB++0rz7UJzpLP8fDqIKm+AWNNxhRsWGT096ypuYYd8ztZU+fZQ1VNqVB
         oPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707169764; x=1707774564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djlDB1yai86ULUJKX1P2fQaEEp42bjwvo7JjIo1+7Q8=;
        b=c4ICKs+d//q3kopejj2xJ6ALLPif5H0fspyOemQfmJdfLkx8SJQfGulqdOWhEeo0cD
         uR3nK1iNfX+iBqscxShk2gjVnmitHlJwv8JQSHTbiMUmdITlf9NBvecnjf360m5Dn/A3
         uZXm4Tjn+tjNBJvyUxpFTjx+YyP3HhE87tmZ6SaZt71IVThqe92ALiq7uEKylCIGoS4k
         5PsfAJWSOwk399+/7ZUCH5uNzGOXlMbO+qtEHPWge9jLRbwQFOr+VAVcF3bef7OwjnLL
         2W0y53bbu2ZIGWOKGBXrfipnLxEscc5Hh6noW6jPZr4NcQjOjzg4mANxPPoH8kE8RO4J
         bgHA==
X-Gm-Message-State: AOJu0YyzUpTQzjQvBsnnY4ZTC1AWsyTGpq2w7WRTaLSyBQnrV0znaYtA
	dyuz4nsN8WEfnwFhlTtmRJx1/I+Jx2bucngYOQupKdokU045V0NQgqpLNgZ/q/Um+qUoqldzxmP
	qzRMgLYoGRmtetL4ABncDfscD7Eo=
X-Google-Smtp-Source: AGHT+IHYrmR7V5mvJR0HK2xdaACmd9TsLVqGXkzr2o6HEQCR3RZ7W7y//fmi/nyzfAY+1xuN2ok36G2L8IPmcDHgTpk=
X-Received: by 2002:a19:2d0d:0:b0:511:452b:d8b1 with SMTP id
 k13-20020a192d0d000000b00511452bd8b1mr301314lfj.33.1707169763993; Mon, 05 Feb
 2024 13:49:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-11-ecafd9283a07@gmail.com> <20240201225824.hajwp2dbj7zcbkgp@skbuf>
In-Reply-To: <20240201225824.hajwp2dbj7zcbkgp@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 5 Feb 2024 18:49:12 -0300
Message-ID: <CAJq09z6zqqQfiFcPAWcLpQdJ6_pnswH33wWpCF=vduRvu3HGtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 11/11] net: dsa: realtek: embed dsa_switch
 into realtek_priv
To: olteanv@gmail.com
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
>
> I don't think it would be bad if you could just define a local variable
>
>         struct dsa_switch *ds = &priv->ds;

Yes, I'll use it. It does look better.

Regards,

Luiz

