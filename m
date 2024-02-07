Return-Path: <linux-kernel+bounces-57054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF6184D366
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F057B24F08
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546DD1272C0;
	Wed,  7 Feb 2024 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="A4wXsdTK"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B388288A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339724; cv=none; b=Cj4sgIOp2+V7sLk3IXh8nW+ohR2E6/Khju2q3th82S0NyiWyPW/4MA9anGqCg7ZftWDI7d7ipgpC7rBfvvBlZzHdkXzzRUfBGPzei5h5DjXaKYgqbTpxwSCQLKzGAM3wj6lY9Wp8EYMIxdeDzIGf7q0+WlLzqX+gLjV+ivVw94o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339724; c=relaxed/simple;
	bh=i46sTbdDr8UdjMnH1rLSXtScrIqetfu9Ima9Qu9Pj74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYwz4qttzoFn8wGSAgKHVrEh2QDNh2x6go45/i2R8+7PUU2JXHDWV2+wpiYW7SGvahdjyIfIzizPLiepR2HJ32KKjgVevO1UwMxuS4zC+sar0S5zvGmciYbssoSlEAWll5QYoMxqDj6TeKU21l3cib65acsFIKVwU1mJMqsQds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=A4wXsdTK; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6e0fe3195so1183180276.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 13:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707339722; x=1707944522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dcafiTmzHGJt+jHQEJxLA8lSwqg1A+ED2VnBp8P9VI=;
        b=A4wXsdTKuuIfH1Sg0HcI+vc1BfDfL1UjtXZksadh33OPEPj8BrVXk7JCzVOiEHsqW+
         YaIkd/f32vniWzTjpYPnBPSjz/yTuS43Ornv1I9RDXWsmglLbT9aG+6YGyG/JIPZVGv7
         DEeVx2k9/eRzV6IxJyQ8A136dmk9aQgi8bbMNhQnAoB49RhNSnDs39DGdJFgsrYJ6A5g
         p9gySvV1kq6g9i+IOqc9Z4tRYRcsIO3JsN9KDQO46OMg7hmqOALmyKAM21t0aIyrBxL4
         k0dAPSE++szFwakPErc7I1o91xp20agfx15Elcwl/mhHKz7Z6TnY6Kaj+O2bnmH/GiS5
         pD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707339722; x=1707944522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dcafiTmzHGJt+jHQEJxLA8lSwqg1A+ED2VnBp8P9VI=;
        b=uuOkHR7bRO35+gZGqZi7H7ZuFyawKLYnzqk9liJ/SvqPShRidxSIZ7SCHsAYQw+6F9
         GF6Gid1EO+DisMcIcF3XTN+Qqibq5LN7R2bB3202uRB/HabazotTEw15S+YOimLpGgxN
         ZOcvO03VbJp86TBoSB2Rur9rkf8ft9buQzjGlzSFIDxwmdtVmtevijmKEYbzRbVIahCQ
         1aWogH+8Gx7KISxo9iSWtLXOWCabdOS1ET64+YYKsQp3J7DOH+qo5tlqwMdn6yFh1YwZ
         VMiq5swaUUOt0AHgtHJtEYitX89OjHb/y3PDbPkYwOMRM40Ea3woXdgkVHBDO0N8u7TK
         wpKA==
X-Forwarded-Encrypted: i=1; AJvYcCUGWRgBdqk+nLL2dEHv892lBpw+1oQ8AGljRMngW9M7tw4ns80mXyFGQBTNizbGSwVfrAT7rvca50qD+/eEYqlyI6L9ytwjM+3NAN9Y
X-Gm-Message-State: AOJu0YyIsUzMKHsA5f4vKlKOgt5G5c8YFxdJP4eFE7FyV4yFCf6xFFch
	UBlHpNSr0Kb8VyuRWiH90EBYhJVlKnWsHuuXnRcxtAVkCEFuZwy98ah3zFqEqAYOHktbcNznaa4
	iES6l7vm+IsNHXUJp5jdpsCnxynyNiG4kTTRp
X-Google-Smtp-Source: AGHT+IHWHwc+iImIuxdQEKCLhBoDAR3fswbF/BKBVg3vDaNMyYhrbfjOZ+ytql1yX9mEi/nLXKqPfN1bNXHb5kejG7Q=
X-Received: by 2002:a25:8212:0:b0:dc6:d574:9371 with SMTP id
 q18-20020a258212000000b00dc6d5749371mr5179044ybk.47.1707339720640; Wed, 07
 Feb 2024 13:02:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207101929.484681-1-leitao@debian.org> <20240207101929.484681-8-leitao@debian.org>
 <20240207073725.4e70235e@kernel.org>
In-Reply-To: <20240207073725.4e70235e@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 7 Feb 2024 16:01:49 -0500
Message-ID: <CAM0EoMmcsRqP9K8PPMe_3B2gn3yEvvSQu5NuAJCWA4gOOj-GhA@mail.gmail.com>
Subject: Re: [PATCH net v2 7/9] net: fill in MODULE_DESCRIPTION()s for net/sched
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, andrew@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed,  7 Feb 2024 02:19:26 -0800 Breno Leitao wrote:
> > --- a/net/sched/em_canid.c
> > +++ b/net/sched/em_canid.c
> > @@ -222,6 +222,7 @@ static void __exit exit_em_canid(void)
> >       tcf_em_unregister(&em_canid_ops);
> >  }
> >
> > +MODULE_DESCRIPTION("CAN Identifier comparison network helpers");
>
> That sounds like it as library for any code, but it's TC extended match.
> Jamal, any suggestion for a good name template for em_ ?

At minimal what Simon said. But let me go over it and do individual respons=
es.

cheers,
jamal

