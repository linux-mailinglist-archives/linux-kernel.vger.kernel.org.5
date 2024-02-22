Return-Path: <linux-kernel+bounces-76139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DBA85F362
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48D91B24BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364CB36B1E;
	Thu, 22 Feb 2024 08:45:48 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA648364DB;
	Thu, 22 Feb 2024 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591547; cv=none; b=em3t7780JfZ5x5Ut2J9fmOSD2ABrQ0bWNpatb7Njy5GlAv2pNE3QfZugkJ/3BEZyhhjcCxTZa+vIbe1ZUU/UOXc8gAIe1vQfY8u6xo051mKX28fgoCz1Sod8CJZBiX/7zVorxe5nxHM/w/F0/RaPkSpvivXqvfl4SFv2mS86+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591547; c=relaxed/simple;
	bh=G6pJusdxfo/StmdSDCJwZ13Ah6NJAoqBsCsfEVn7mZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPtOcKqjUgtaoqqy+ExtTSE1tqX4QyDZYvtGNSlRwslxsYty4bU5E9M79h50bHK9QYdsVxGpLJ13g+EokbFX3RSO10MUZQ1mF/AgYUsf1d+GGMQdaG3Mgj6I7iOLr/3dREjKlD3jk6xo3+nMYXAtPiX90u/0/4EL6/mUMjDdixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6083befe2a7so43018667b3.0;
        Thu, 22 Feb 2024 00:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708591544; x=1709196344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6Kahe0OhfDh8S9J/Rqow+4MQwXRJQIenHOLMamoIBc=;
        b=FH2/Zk4X72f21hMjxaEH3E5vAX92m/R6jUQCGDDVWtumPUKvJrVS2UHx+k5g8gnDxz
         1Hhklpus20hMat3DiGnni8P5GfrP3Ht2a/kjPZRu2JeVhSj1L3+ww9bh2FZcASfqBpD1
         kzEstfIDz7jLU0//iS1jjnRgc0B9WroQ+alu9YvbmGwDJx/CbkTaDY234BXAGuh6ey+q
         J0XjCuVYswHD9llSVADZq00MfCzFZNet8gtBPwCg9vhNmWM9TPQAo6PcrbeN1Rrg01Nq
         kwEEfCLc0sGIqaHQIBaz7/2rtuMZbn7Iufx8EYAxHcT6ohj4+n6je6yersbpKXjMaj0x
         FlOw==
X-Forwarded-Encrypted: i=1; AJvYcCUH18r4xpDkw9jLE9LNQuL6+qHJeUu/wkXxGoOS1tAofCS+cLGCLKycTz4/lEeYn1hw/OYz7QZU3WXimJ0KutF7zZ2WzPaKrdpYwvPZ0mazFb2FnDyRvEXvAFaasahbLdddrJyC
X-Gm-Message-State: AOJu0YxkYYwx33iK3X1DuPZOYnE0tvdwYIXob6oHQ+jXw9zE+ewkSSy/
	Rhsbx0uzi++RM5+PrkYtQ/ueblXwmCv+cpAsgtiqE61Iq3ymt0e64QMsXvSzEwA=
X-Google-Smtp-Source: AGHT+IGF+dRSvcMxBNNOg1ynn3soI72ikCxXwuc7lOaQdaZCyklUFkZ8gehNldEe5Wcn5VVPB51SEA==
X-Received: by 2002:a81:7c55:0:b0:607:910c:9cb3 with SMTP id x82-20020a817c55000000b00607910c9cb3mr20192534ywc.36.1708591544246;
        Thu, 22 Feb 2024 00:45:44 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id t17-20020a81c251000000b006049de6fa26sm2890781ywg.57.2024.02.22.00.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 00:45:43 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607f94d0b7cso67746937b3.3;
        Thu, 22 Feb 2024 00:45:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnKcEAfDEGqalXSShjLs0WL/HpVAjYU+SMsytZi+IRFXd6manV+dhZv8SiNxZfxnQBQUwhWn5mtEAN1DtEz83voRQC0T+fWOXuY+Gf8WDhYjyPKml7IetzTKkRU5Tr/3asqhNh
X-Received: by 2002:a81:6d8b:0:b0:608:7a3f:d0a4 with SMTP id
 i133-20020a816d8b000000b006087a3fd0a4mr4680838ywc.24.1708591543772; Thu, 22
 Feb 2024 00:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-ps3-gelic-null-deref-v1-1-f4fe159c7cb0@kernel.org>
In-Reply-To: <20240221-ps3-gelic-null-deref-v1-1-f4fe159c7cb0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2024 09:45:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXSmf6cKxzzXBYC5Zrkj6QR+2EhB4346d3g-RNTS+W7AQ@mail.gmail.com>
Message-ID: <CAMuHMdXSmf6cKxzzXBYC5Zrkj6QR+2EhB4346d3g-RNTS+W7AQ@mail.gmail.com>
Subject: Re: [PATCH RFC net] ps3/gelic: Fix possible NULL pointer dereference
To: Simon Horman <horms@kernel.org>
Cc: Geoff Levand <geoff@infradead.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Jeff Garzik <jeff@garzik.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Wed, Feb 21, 2024 at 5:57=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
> Fix possible NULL pointer dereference in gelic_card_release_tx_chain()
>
> The cited commit introduced a netdev variable to
> gelic_card_release_tx_chain() which is set unconditionally on each
> iteration of a for loop.
>
> It is set to the value of tx_chain->tail->skb->dev.  However, in some
> cases it is assumed that tx_chain->tail->skb may be NULL. And if that
> occurs, setting netdev will cause a NULl pointer dereference.

Thanks for your patch!

> Given the age of this code I do wonder if this can occur in practice.
> But to be on the safe side this patch assumes that it can and aims to
> avoid the dereference in the case where tx_chain->tail->skb may be NULL.

The compiler may also lazy-load netdev until it's actually used,
avoiding the crash?

> Fixes: 589866f9f1cb ("PS3: gelic: Add support for dual network interface"=
)
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

