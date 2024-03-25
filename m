Return-Path: <linux-kernel+bounces-117958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5142788B1C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71851F621F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DB55BACF;
	Mon, 25 Mar 2024 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZSoDOZk"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAEB59B7A;
	Mon, 25 Mar 2024 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399343; cv=none; b=tQXnT8JfxYOZdPD8Ur7EHWksj5aNW+/aN2IFMWyv6Oxf6m2obivboowHfSYmbZY6fo9r9nYMg6JBJfvlXu3VDRjSiI9i7hZdc+9476Qf7vWZ5d4Xfw2yAN47lDFBnzExet/CIv7+qnfZGFt+yvPig/Qe0rNtQLwNY7OwKa9wx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399343; c=relaxed/simple;
	bh=pC5vrAPVRrli7aVerpJXftZIlMpAFTi4jMQt7h4ZxrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzIWzUEP5zwlZyQF42YUGhhO9si1+UiG2iAdIjhMCdkUEw3dp6VkVPQY8TmIyqC25Fmjw2DN8RcsenDSxjLBr5LrPrc0/9QcGohA1VJaLub3orrCCEk+H8hJpVsDageo/GYZEOD4SzTciE/vBJfiUU+bE+vRD5HM9F2pQORJ7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZSoDOZk; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4d436ab8a36so1718231e0c.0;
        Mon, 25 Mar 2024 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399341; x=1712004141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC5vrAPVRrli7aVerpJXftZIlMpAFTi4jMQt7h4ZxrI=;
        b=kZSoDOZkCE2wiK8BJANGHbxXzk9AofnVNrgN1A191Ywsgnm7MFva3fnrq7cH4HCwPT
         oPesowAik9GmqoUhvq/P39YEALAeLrsIi35WszYRj5yyb+QDWKRI1Mdm+6MyrCQO6WwY
         CADlUArxfsRHAi1N6G66snQH3snQjTBQeUtKgujW1Sp4guez6bDy3HyHUWkl7XlRewBw
         0yjbk7mP1vSSR/zKdJJAgpDhcqb9Db7f1FBCrjtdIIzvM7qdQUz7Te8qPyw9Z+6hHRQ4
         kSlpSEfWroI0lYo4zdOLjfumFa/uJVo4WGHYpSRJN7iCUx+y3l9P9XZLAfytmjhoXF2x
         Q/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399341; x=1712004141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pC5vrAPVRrli7aVerpJXftZIlMpAFTi4jMQt7h4ZxrI=;
        b=kb+BY6Itx7uVaONxwhlMl6LIHnnYixsXu86bWPGe1XJActEBIRwbiaSrylWDENDcJE
         8hf8I3kF3nIM9zyBX1dBUv7nu1Xft8LXTljRxSb9+fnQPK+wC368j+FfVHgGe6ish6Ke
         0tMd3xmSudscH+7JIqCZKThAnD53SWqkQxJEZ2WQ6wo1MPbTHV5DKWJoXbf+IlkY84DN
         UK/9I+nfS6IQ2VewKvba5EPB6mdb9oOhkV7H75UCdUM2dvyG557LK+2tV/m5i2NsWyp/
         1vKzcZs4L+Y9d/2gr7Gm8LvNNTTIRwErCxNgtCG2WALJjTzFQ+Jhfwx9OeKG97vs8LJp
         RlWw==
X-Forwarded-Encrypted: i=1; AJvYcCWdVXeXMrhTznQWAsbMsfZRTnri9mZfW3u+en6BYpER9JIzM9TuTw2B5r1ShkeUaoGvRmkyu7EDmhumaxOGsgPINALaJbCgpG3aeObqouRs/pl1H21k6M3Mxe43yHuWpU/gIJ3g
X-Gm-Message-State: AOJu0YwCQHebOT9iGUkZ+NRkkUqHDPcley/bc6FWLQUKggiTHQ0x5pji
	Su3hSxz4FKOOmEAH81k4sSINMu2tReZt0TvVFK9a+8WM+EAR7EfH069eVXYi9eJWtyZrOOCSi3/
	ihYy1UgfIBrUxZ0/VgTfpfd3DcZI=
X-Google-Smtp-Source: AGHT+IH7wuhgmBTWbyrg+4XcDEHdWND0NjDNLBpIvKN4mkdZZQN8XR1XJeS5EOpuSlmMzDRKFnCCBvt8g0qFPa8ecr0=
X-Received: by 2002:a05:6122:1da0:b0:4d4:1340:df12 with SMTP id
 gg32-20020a0561221da000b004d41340df12mr6403898vkb.0.1711399339236; Mon, 25
 Mar 2024 13:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-8-paweldembicki@gmail.com> <20e792ad-33ce-43a6-8ed0-8db6e1a25c27@gmail.com>
 <20240308130929.4kgctmtzecbpajao@skbuf>
In-Reply-To: <20240308130929.4kgctmtzecbpajao@skbuf>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Mon, 25 Mar 2024 21:42:07 +0100
Message-ID: <CAJN1Kkw0ufQC0k9LdQCkdVN0+7SD+MM9aZxNxdFnKunC8+MvWA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/16] net: dsa: vsc73xx: Add vlan filtering
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pt., 8 mar 2024 o 14:09 Vladimir Oltean <olteanv@gmail.com> napisa=C5=82(a)=
:
>
> On Tue, Mar 05, 2024 at 03:51:11PM -0800, Florian Fainelli wrote:
> > On 3/1/24 14:16, Pawel Dembicki wrote:
> > > This patch implements VLAN filtering for the vsc73xx driver.
> > >
> > > After starting VLAN filtering, the switch is reconfigured from QinQ t=
o
> > > a simple VLAN aware mode. This is required because VSC73XX chips do n=
ot
> > > support inner VLAN tag filtering.
> > >
> > > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > > ---
> >
> > [snip]
> >
> > [snip]
> >
> > Have to admit the logic is a bit hard to follow, but that is also becau=
se of
> > my lack of understanding of the requirements surrounding the use of
> > tag_8021q.
>
> It's not only that. The code is also a bit hard on the brain for me.
>
> An alternative coding pattern would be to observe that certain hardware
> registers (the egress-untagged VLAN, the PVID) depend on a constellation
> of N input variables (the bridge VLAN filtering state, the tag_8021q
> active state, the bridge VLAN table). So, to make the code easier to
> follow and to ensure correctness, in theory a central function could be
> written, which embeds the same invariant logic of determining what to
> program the registers with, depending on the N inputs. This invariant
> function is called from every place that modifies any of the N inputs.
>
> What Pawe=C5=82 did here was to have slightly different code paths for
> modifying the hardware registers, each code path adjusted slightly on
> the state change transition of individual inputs.
>
> This was a design choice on which I commented very early on, stating
> that it's unusual but that I can go along with it. It is probably very
> ingrained with the choice of the untagged_storage[] and pvid_storage[]
> arrays, the logic of swapping the storage with the hardware at VLAN
> filtering state change, and thus very hard to change at this stage of
> development.

I have to admit that it wasn't an optimal implementation. I focused on
the wrong priorities, which led me astray. I prepared v7 and I tried
to maximize simplicity. I hope it will be more acceptable than the v6
version.

