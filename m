Return-Path: <linux-kernel+bounces-9934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0217581CD78
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F731F223B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C591D28DBD;
	Fri, 22 Dec 2023 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xf5ySuHd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F625574
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso13467a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703264931; x=1703869731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvL3+601FO4FmDW7IiGM8+XlQhIFBVTWGDHRzdI2Dvg=;
        b=xf5ySuHdhHPJbS/p7B8Yi/wVKVNyga/85BswprStLYqXih6hpGKDsbtUlB/KzJbg5w
         lj+KJaHLY77TwwvK20/Y52S8P/xosT8jSTdRpJvO7SwFMapdRY4s+J0TCt+wtbmBBdpe
         QF0o/iSwWYV3w5j+jZNWWiMlZZvQCACt+/ifd8rXbYco1lspC2HU4NsIiqxLGToMJ7Bc
         q9cjL62nZNGfQU7EUHRPQRzelOgTKwFj6SYGZsSjVg3rL+S6jDVEG0wm/6Q+0XssRa+V
         XbA2sGlLCVYOWQcSaScmkHi7x9lwvgfXjNG4ZpESNnYcHDByMmVA4ecCjMZgvMqa8hcN
         VT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703264931; x=1703869731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvL3+601FO4FmDW7IiGM8+XlQhIFBVTWGDHRzdI2Dvg=;
        b=XFcSkRNr6Ij+FT6pN1IWOXxn0iQHrPF3XN0SW5gjfJ6hJVE43TcWzr4peX1k2VuInE
         WwWRZxwUK4NTRmA+c6JdV4bqgz53rjEUOjbuca9hzgREiDW5WKHYVsSjzsgqujuLp3C7
         Q7kAlYG24hRszOJQDxCTwq2fCV/XtUKkraFe/UEUR9WdcFAcW4NM0oGK3LfJugZf4R6L
         rbru1pdWLdWuGfUnjd0QQ24lozFtSdEzM/w+XpWy4VdWv3lL7PUos+DsC0v4gT0SX9b0
         nKZJLOrAa2Jq/Jexn/RPYL50XlMol7RS5ctJZy5WIYx9BxaiX3LBuiUjp1fn5zp8YMNE
         XBvA==
X-Gm-Message-State: AOJu0YzeiOmkA+d3T9q9rGWmvGn3GHgpfDt8kDVYIUSH1FOfMXZlSJKY
	e2jOyFYutxlMYp8FJyK3IiOchobCUHzj3qTR4jBWrAO3GCFJ
X-Google-Smtp-Source: AGHT+IH79fMt2lbndlOwVElyQ8+edbXGd3G7O8O8KzaRaFwc0qtg8B2j9WmAYooczh/yN+jnNV6CKxIwfZnoumUL+VA=
X-Received: by 2002:a05:6402:33cb:b0:554:53d0:23f1 with SMTP id
 a11-20020a05640233cb00b0055453d023f1mr112130edc.0.1703264930632; Fri, 22 Dec
 2023 09:08:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222-tcp-ao-kref_get_unless_zero-v1-1-551c2edd0136@arista.com>
In-Reply-To: <20231222-tcp-ao-kref_get_unless_zero-v1-1-551c2edd0136@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Dec 2023 18:08:39 +0100
Message-ID: <CANn89i+vgVCCdyy8zwdAfTS1SW7JcFRYkcvu+m-F07yHv6jDcg@mail.gmail.com>
Subject: Re: [PATCH] net/tcp_sigpool: Use kref_get_unless_zero()
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 2:14=E2=80=AFAM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> The freeing and re-allocation of algorithm are protected by cpool_mutex,
> so it doesn't fix an actual use-after-free, but avoids a deserved
> refcount_warn_saturate() warning.
>
> A trivial fix for the racy behavior.
>
> Fixes: 8c73b26315aa ("net/tcp: Prepare tcp_md5sig_pool for TCP-AO")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Reported-by: syzbot <syzkaller@googlegroups.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

