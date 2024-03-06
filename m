Return-Path: <linux-kernel+bounces-93535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0C887311A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4780282497
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE745D8FB;
	Wed,  6 Mar 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGcPyRcD"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69295D47A;
	Wed,  6 Mar 2024 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715030; cv=none; b=YVAHR7zB7RcA3CB9ThrvydWormOT3jGsgc5zAerYRiRjP2UZny0SWbUvAjEq/eq6qhL1zOOxWmC/jBDG+kSIDi+eGBgkLxSFh/lLMKZqiD8p9Ce+Hx+XhpPNvFGuSuEZ9h5UURM37Y+aT+v8Oq2fBBQUC2k5yphCX2Lt+Ea3Q7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715030; c=relaxed/simple;
	bh=7jG67fGId0CdX9CLJmVsTwSsrzWZShXWdZdV4aiHbCs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=U1724MMMq8vI/+B9Bx+GsYSgPuYPg9watuDd0m8scTsfkpFaci6omwRuxOhPJJ5BgVvu2Bjh56BQUhSYi/oDAPF5mXBAXxbKLQcHYe/DD2w0bxLBoxtwlC9Qws/kcrIxVwd3nP3ydwWC69zzp+OJjVJNz1EXVOG2lW+5NS6ev7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGcPyRcD; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc74435c428so7254599276.2;
        Wed, 06 Mar 2024 00:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709715028; x=1710319828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhvGossaIFikEDdBLhLIr5Ze7xMtGtGJ5kS7C2G6lPo=;
        b=aGcPyRcDQBktnFBP4Oqr36jLirJUjP7B0St1tiFqsF4a0WN/y/SsvWC5eou5jJfRNW
         039jFcHE/OkxVMSEYzkS13xph2JYHYOq7GNFNaf3nX/ugqG5bcMl8CjYY9W2fLmfqsXI
         tKBLGwXN2Viyllb+/ByDpWa09wEyeFKmCGy1MM0RNgY+cGfBAtly/n7d3ioKX3p7it//
         5U0LBLkvUmQOia8DZo5Ni0QofnhV0y7S5SLV6xgt4y5rqwggWi2Faxff1K8OejqDYsLX
         8qT5lsB7lEBfxIo7+YaRKey3TMxUAdqJtLxrKse/8B3a7rhd6uMG13Lq+9hKUhYQQuw0
         dZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709715028; x=1710319828;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bhvGossaIFikEDdBLhLIr5Ze7xMtGtGJ5kS7C2G6lPo=;
        b=p3x1WQi4Ay5pfigPQyUqMwk+ylQwm+ZLuAmHhGJiBspwa5v42Hm74VpJg6/UXwyoJL
         foLw0VfZmCx7su3YcYAVIirYmKs3FzxlVhgeM8DXmdEU/UupFKQf5Q/jAWoYYkcTJg9T
         83cU2sotXb0X7ePuIN8LycqjC1yrJOZXQKgb3/QPsFSRwjh+AipZNxKn83oNOxYyZc2U
         vpXAdg60RxN+fAAbJZV8cReVH3V3yPGhnvodD+RBX6m/QmtNoC6y6bzdfyBnnDS+ELtx
         cV3C1SByfI1hPL5lpS2o3SUw/vx7RPgWGUZ3MwcWzfLzfXqY4ba8Gy/U+nJ3nGFTlH0L
         g3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCCwL4S7t/JxS/0WtEROOSh4BPwFXMK3cXroICZ9KStb6/tQBSlyWJZRNzDJ/7fSXGRns0nHKbsuUxNuI5jiQRCse5D2Rp7gwveLXWGCFkUxzsU2NCWpQxM7HDCRR/CgZK9ABS
X-Gm-Message-State: AOJu0Yz1IwtiMT0+zehWrQ2isffKDmGkV6N1Jd0Q7sJg+MW/Vvpw/zOy
	BrVJ5S1yvqdp/cvc/oS+uTBFJM9+tow3ecQi6qW4AQDcvolJotsG
X-Google-Smtp-Source: AGHT+IHo0fVyrwRdqqDFiDf/4hTnJ0mdwUKvvIdtVbtQ7ZmcIh6wtGxbKUnfXd7ZYkwMcDEuQy1C8g==
X-Received: by 2002:a25:aa8b:0:b0:dc2:2b0d:613e with SMTP id t11-20020a25aa8b000000b00dc22b0d613emr11442609ybi.10.1709715027798;
        Wed, 06 Mar 2024 00:50:27 -0800 (PST)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id k26-20020ac8605a000000b0042efc6ad5a9sm1740625qtm.23.2024.03.06.00.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 00:50:27 -0800 (PST)
Date: Wed, 06 Mar 2024 03:50:27 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <65e82e533857c_a463929462@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZeXQup48+X6U9TQ/@tpad>
References: <ZeXQup48+X6U9TQ/@tpad>
Subject: Re: [PATCH net-next -v3] net/core/dev.c: enable timestamp static key
 if CPU isolation is configured
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> 
> For systems that use CPU isolation (via nohz_full), creating or destroying
> a socket with

- timestamping (SOCK_TIMESTAMPING_RX_SOFTWARE) might cause a
+ SO_TIMESTAMP, SO_TIMESTAMPNS or SO_TIMESTAMPING with flag
+ SOF_TIMESTAMPING_RX_SOFTWARE will cause a

> static key to be enabled/disabled. This in turn causes undesired
> IPIs to isolated CPUs.
> 
> So enable the static key unconditionally, if CPU isolation is enabled,
> thus avoiding the IPIs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

> diff --git a/net/core/dev.c b/net/core/dev.c
> index c588808be77f..15a32f5900e6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -155,6 +155,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/page_pool/types.h>
>  #include <net/page_pool/helpers.h>
> +#include <linux/sched/isolation.h>
>  
>  #include "dev.h"
>  #include "net-sysfs.h"
> @@ -11851,3 +11852,14 @@ static int __init net_dev_init(void)
>  }
>  
>  subsys_initcall(net_dev_init);
> +
> +static int __init net_dev_late_init(void)
> +{
> +	/* avoid static key IPIs to isolated CPUs */
> +	if (housekeeping_enabled(HK_TYPE_MISC))
> +		net_enable_timestamp();
> +
> +	return 0;
> +}
> +
> +late_initcall(net_dev_late_init);
> 

Can this be included in the existing net_dev_init
subsys_initcall?

Aside from that small question LGTM.

