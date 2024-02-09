Return-Path: <linux-kernel+bounces-59843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160C584FC69
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE632825C3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC4880C1E;
	Fri,  9 Feb 2024 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DHa4PDF6"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87680C11
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505006; cv=none; b=DylolGyjDNp2o1W7AzRpjuhubXirx5l2jjdplmEtZupcArxEkO/CtUxPJESsKNMkvCZ6u4MaMhJcSm72AP5mL1jzUdO3V9FHggsIRdOPyS7ye6rq2LApYmG3k3hxJ8opUaxFA/W/uJ67CCSPpUwDSMyIp4lUWQ8XyTQ23qkRVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505006; c=relaxed/simple;
	bh=j3yz3zK2OhpwzomMfjssQZsBsMxfSLTMxtx3fOWZv+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhWzeUpxTktnzbug/o9k2+wscOUTLbyABOToWre0Uiu5mReohVB3h+f0EXi17Juyw897w1NmDRGCFYGH/YNufyG4wUrbeGCDDeYzQm4M5WYHhpfUOCLQtIVd95mIz3/aOWFUEBIxNX9QoMGFhEPLx614HZ3HOvOvuFxQ0K/cO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=DHa4PDF6; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so1262889276.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 10:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707505003; x=1708109803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6lMp/9wvqY5Jh56RWGR1pr64HWTvr8MzmyKHWGuDKs=;
        b=DHa4PDF65Vo5XE6JvE5agslxkn2I4ZYDRfrZQ6vkA3q3XPyg2TEf7XGeKV5f8/oJVG
         eeR/WxCTCJWi5vtf/IHh9Od8jSw+OLtG1uQZ3Pa2I2aEhy70R5yUyGhGs4gYIOS9pYJY
         ZFy6YuDsP45NUyUI0bzu+QxQUYgal1PsBmEbP89N0hzbhBzj4PD5k5PjFy7K3jjpP5WS
         fVoEy6nSFf0YGhG7pFxOQtF5XEB7YGRhoxvCYawIKtqXerq4FyfHkhp7UlVQvATHO8Tf
         1PgjCXwizsbwkhXFk3CSSAJdzVZrsjKigW3toDdyW/gbKVec7c8vZ6oJYfED1CtkciK7
         VglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505003; x=1708109803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6lMp/9wvqY5Jh56RWGR1pr64HWTvr8MzmyKHWGuDKs=;
        b=BEAUDaGjr/gT/PKCOLK5bIoyDmUSnKgmpv/L20X+F3A5VKUWd1VqnT6cUBuAZsj6w2
         GtUMlBJ41T0ukzPXo6tag9bCZ8nUUEo0OMG9GOqyzLmOXZXPmI85D6IstppVdOLOuMSC
         ez1X9DCdTV+MelTvZV6JF4iw/Q+TIv6ueE1RSsnrAB7SRpurX8mBTHb3dcWe6ipWrBBv
         2LkNuclq+voUCpzX1cmo4eKRLE1yFkub0W0XeN345BSSCft7oOoD1+eHXrY6mTwLY7rZ
         U/rFx+Tb8zuLRNBWIf3Dmpnjrz97twzDK4a/XjI+YDeDvT0y4rdhIKvAwA88vROOQSZw
         +urg==
X-Forwarded-Encrypted: i=1; AJvYcCVd3TMT0Knl9FMWCo926Rb8qm24wx/1Muag5PQCP4t5bMo9+weRoCRmb4YghFjGfpXWpqnh8a9MONYFgkQ+PcRzpHXLGmbuUPVf6B+y
X-Gm-Message-State: AOJu0YwhZHjULTO1P9yiCdx5DuFIDHZsXLNr9y51d2mnOv5QX9EmVSoD
	Tyd9hOk8A6SLFLJgVbgVIIGf3aqyVoeTxwm4/ulgVnTAQwB03ZNqcK8ksXvhFSbutLL9qkIW+A/
	O97KS1ZcCecrceAbZn47Kzz+n4IpaodcYF3q8
X-Google-Smtp-Source: AGHT+IHLJnyQuVDnMonUbnoDDlrrRX/0n7bWglNXMNTa2hezgF/AXMI8jJXOGZfM9ZVwxItaihcgM/jdXOam5HerZ3M=
X-Received: by 2002:a25:ad61:0:b0:dc6:b7c4:3bb0 with SMTP id
 l33-20020a25ad61000000b00dc6b7c43bb0mr36691ybe.27.1707505003275; Fri, 09 Feb
 2024 10:56:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209180656.867546-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240209180656.867546-1-harshit.m.mogalapalli@oracle.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 9 Feb 2024 13:56:34 -0500
Message-ID: <CAM0EoMmc0fVegqtYKDZvBbfFjUSh-fEBPi+Nzjoz++CLAO5qPw@mail.gmail.com>
Subject: Re: [PATCH] net: sched: Remove NET_ACT_IPT from Kconfig
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, darren.kenny@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 1:07=E2=80=AFPM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> After this commit ba24ea129126 ("net/sched: Retire ipt action")
> NET_ACT_IPT is not needed anymore as the action is retired and the code
> is removed.
>
> Clean the Kconfig part as well.
>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
> This is just based on observation.
>
>  net/sched/Kconfig | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/net/sched/Kconfig b/net/sched/Kconfig
> index 470c70deffe2..8180d0c12fce 100644
> --- a/net/sched/Kconfig
> +++ b/net/sched/Kconfig
> @@ -737,16 +737,6 @@ config NET_ACT_SAMPLE
>           To compile this code as a module, choose M here: the
>           module will be called act_sample.
>
> -config NET_ACT_IPT
> -       tristate "IPtables targets"
> -       depends on NET_CLS_ACT && NETFILTER && NETFILTER_XTABLES
> -       help
> -         Say Y here to be able to invoke iptables targets after successf=
ul
> -         classification.
> -
> -         To compile this code as a module, choose M here: the
> -         module will be called act_ipt.
> -
>  config NET_ACT_NAT
>         tristate "Stateless NAT"
>         depends on NET_CLS_ACT
> --
> 2.39.3
>

