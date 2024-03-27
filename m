Return-Path: <linux-kernel+bounces-120403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168F988D6E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B6CCB2182C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8613C241EC;
	Wed, 27 Mar 2024 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXFx52Pj"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74763241E1;
	Wed, 27 Mar 2024 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522648; cv=none; b=pAC6nIu8VAhwJAJGCW8Iyh4O6U/i3kC+ZaZreaV9tczxbiXxLtM43KNlF+Sg9u877sJ9csp8rb2fxzi+aIEwdUCCydpX/izjCWonw1SdYpTDK9mGIkfrqv08Tzv3csUOm52XkQhh/O5UBCHKjDSm1d4Mm0GGw9tdeOMHftu5Gag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522648; c=relaxed/simple;
	bh=SLe3EkoAmpsK8G38HlQexQFaGXpkqG9r7/RlGeZTW7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcBTnc9IU94hLZDWOkcOAZy2ogKad6xIy0EXS5ufopfKVNAC5m6w62BTgOUY5/eckbjqT+dqqD3EaPkeGRqOQ+alpaq7gfjbQZfpTgwnZe3K+hV7nqVqMFf4W+2BB91mh225+KTwi4aS+s/GayXmQY6nmWvkLbLjsb97rKs+m18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXFx52Pj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so8110742a12.3;
        Tue, 26 Mar 2024 23:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711522646; x=1712127446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLe3EkoAmpsK8G38HlQexQFaGXpkqG9r7/RlGeZTW7w=;
        b=LXFx52PjjNw0+ED8EE4gfujBsrIZ8MSviDj0zCkd5OpnYXQDqDN5hxrWIzqBvH+Kml
         0l0OcetIto8sO6NJnZZb1/57QS5ErZBmvz2kVzHzqJU6V5rtDXL24nvyoHm5H8tiZJai
         TfOqN/XHSCWDhtiiTQfbVQAQE+RMvjHR67LCNm7F61n8Myb54ftsr4ALssQLQ4WLDGKr
         y1KD41KEAaodh2VpYSE3z0Fz1JtUj8vXFSfQpJJoqqQbRuUJiuJ5jPhXTvgwHCwdMS6Q
         l+NHmvDwi6RpWRwOTeNoFRrwYjJQxDGGh1JAjU70othm26Tc0npe+aXz56YzUFPPw+jM
         IF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711522646; x=1712127446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLe3EkoAmpsK8G38HlQexQFaGXpkqG9r7/RlGeZTW7w=;
        b=RvAUuxifvjdISQ49XXYJhPoXl13BHm+ah1+95ml6bmQp5opvnKs5bKpRKGRJaTIu3X
         8EeChA17hLyI6CmJrX05v7vu572lcgq2+pdxKxx1EaTQPE/0FD0jf7EJWEYZnMsKc8tJ
         heXUQxN7Hps++DoP0PaLsmu4Gm2InELGb9/c3k17pIM6raWW1qIGQL+vzt0QhocEkJj7
         sZYb2nuCKJ+NIcJxCry0Eq5UFxaG0P/9bXOuVBTfgVg9hgFp9AEUpcMi/Avg2kB3Y/ec
         EK6CiKD2BhHFT1z+cTEEai4gwwRkosbo+6EbJdb0yo2cQ/LK25fziJFAMyZ6sEjmrWbN
         DKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrBcEqYY6RI61egIjulf/RZZQhgXHasLvGcg7wDS3S0kg63fPYFzCu5mmt1MsRFm78JsMSxpT8a0/qHn3/s/X+kl76TSeahYuloZ9tg5yvVCJlQlH8wbP55sjLGAUDbIk90yx75y19bWaJbRI4FdwkY9ODSWsdzzYwNxnjer7KTZ0Hu+pHrKg5
X-Gm-Message-State: AOJu0YzHnZObMPn615h1BJIe8BXM8sCo7vY5mA6Nq7WpMQsRoj2E/6Jb
	WREEJjKr3EKbufCX9fK84u5iTaxv7+MWuPFQi+0Kxth3n/QiNflKBams5eWpVdSAy7G1bEb5ImL
	o8OZuJ7blQG5v4LwPNM/58r2IGX0=
X-Google-Smtp-Source: AGHT+IHwC1Xl9gPnTUY6wLcUNw+FjI+7Ejo0bvWGC/bVdJHL3gFSiwCZmJZq1WaW9XmnK7lrUZZaqOkkY5/QxWoufFw=
X-Received: by 2002:a17:906:3c12:b0:a4d:f400:4e17 with SMTP id
 h18-20020a1709063c1200b00a4df4004e17mr2441213ejg.34.1711522645616; Tue, 26
 Mar 2024 23:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711475011.git.balazs.scheidler@axoflow.com> <0c8b3e33dbf679e190be6f4c6736603a76988a20.1711475011.git.balazs.scheidler@axoflow.com>
In-Reply-To: <0c8b3e33dbf679e190be6f4c6736603a76988a20.1711475011.git.balazs.scheidler@axoflow.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 27 Mar 2024 14:56:48 +0800
Message-ID: <CAL+tcoCsrGRWd-oE1xLs7JQ=a8_HUQ_6wx2py5-D6Nxb9jpRjg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] net: udp: add IP/port data to the
 tracepoint udp/udp_fail_queue_rcv_skb
To: Balazs Scheidler <bazsi77@gmail.com>
Cc: kuniyu@amazon.com, netdev@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Balazs Scheidler <balazs.scheidler@axoflow.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 2:05=E2=80=AFAM Balazs Scheidler <bazsi77@gmail.com=
> wrote:
>
> The udp_fail_queue_rcv_skb() tracepoint lacks any details on the source
> and destination IP/port whereas this information can be critical in case
> of UDP/syslog.
>
> Signed-off-by: Balazs Scheidler <balazs.scheidler@axoflow.com>

Looks good to me, thanks!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

