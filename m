Return-Path: <linux-kernel+bounces-52511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C4F849927
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2891C2088A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B12618EB3;
	Mon,  5 Feb 2024 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0SfTXx8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776118E29;
	Mon,  5 Feb 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133527; cv=none; b=hpP1Fwq0rMvxj7U9LXMTBRnpe3e/3PrWWL/p2WpAU06plIwab6vszB7Jn/uM1fNViUrLX9FKz0N+iIObZXmeGvxEhZsHTAhUdbzBDEpO97WSqOSGKah/YI42rn+rId73oszhpYSEf3dfzbwR4jirAwRLBPZl89fvQL1AtNqgCao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133527; c=relaxed/simple;
	bh=BYs4rQ5/k64xGn6SgCJXpRb/M2MgU+YyuM9pGGjE//A=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKiTyql6li8pP12HY8cjk2/vQCwpjlRnfqbZpLjOhNDhHCRZB0TRF78P9PSBlZpR4+/T+O9fwDYgjL9tQtqgsHFij2ybd17i3CqyuLVMQI+MAccFKm6jf7uFybh+mWCLlX0KludQ8775GpzraIqdOj2fOEGQnKpO6zjIv+6vzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0SfTXx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C396C43390;
	Mon,  5 Feb 2024 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707133527;
	bh=BYs4rQ5/k64xGn6SgCJXpRb/M2MgU+YyuM9pGGjE//A=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=S0SfTXx8sAXPGWHPW5VvRr1z+i13fTvnBD3aKcRF9YWbPdt6+xWiOHp4J4sglj/Kc
	 Eqbx+DkKxXtmtSCMTgApk06HNiqPUFkdqNSabgr/yHD7XhW6DWYBf9zB91Dd+mhvgl
	 zrNhUVHpin/TssQbqpOTWgD4RLJXTIUGegXQCJ0wktuqhYl1sFIcsYL8wUkmV+BvtM
	 s+EYbkeogcz1Ke+nixtIW4C+JfQnct5cKdirN3qXtIv3hrT57hk+6POf1IQiN2A31u
	 1kXRcZIMsqT3l5NHpdRJoEJpsHukCSoIKxYyLpIr7TvEaWHl/jmo9E8Tapw0n2Wagl
	 HiQewaybecxIw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-216f774c827so2168726fac.2;
        Mon, 05 Feb 2024 03:45:27 -0800 (PST)
X-Gm-Message-State: AOJu0Yw/d9GN+IQulgrN9f264SCUN9ZOIyDxlvdPkd7b1ghzt0dhfI6j
	qYg+OIp0q/q3v+WLPFVDidmG5tGerUDVBZ0ldeOlnYnMAWq5g6gb2epnkb9SWfyuReuVunvc5Th
	cEUFU7S0pL8XjFO2F3jQ2H9vj6BQ=
X-Google-Smtp-Source: AGHT+IHu/+HFGmE2r7T4qO2GHHTOgOupQdOpPq3Oc1albNYbexHWY+wrxHuQsxQlyPKaYaaEnje8UB0J1O68leH5rmQ=
X-Received: by 2002:a05:6870:4c0d:b0:219:9c12:ba14 with SMTP id
 pk13-20020a0568704c0d00b002199c12ba14mr645100oab.47.1707133526341; Mon, 05
 Feb 2024 03:45:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:d11:0:b0:514:c0b3:431 with HTTP; Mon, 5 Feb 2024
 03:45:25 -0800 (PST)
In-Reply-To: <20240205111917.181490-1-pchelkin@ispras.ru>
References: <20240205111917.181490-1-pchelkin@ispras.ru>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 5 Feb 2024 20:45:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-dMgmGUEow6B4pJRCUtmmgE0Qy+5CVEOTuMZA+O3gpQQ@mail.gmail.com>
Message-ID: <CAKYAXd-dMgmGUEow6B4pJRCUtmmgE0Qy+5CVEOTuMZA+O3gpQQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2024-02-05 20:19 GMT+09:00, Fedor Pchelkin <pchelkin@ispras.ru>:
> ksmbd_iov_pin_rsp_read() doesn't free the provided aux buffer if it
> fails. Seems to be the caller's responsibility to clear the buffer in
> error case.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Applied it to #ksmbd-for-next-next.
Thanks for your patch!

