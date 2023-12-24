Return-Path: <linux-kernel+bounces-10610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2FA81D75A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 01:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234FE1F21D77
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 00:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C6262F;
	Sun, 24 Dec 2023 00:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT1xG/wM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B9190;
	Sun, 24 Dec 2023 00:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5942c83c97fso1772014eaf.1;
        Sat, 23 Dec 2023 16:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703376480; x=1703981280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH/XJuSscVimadN+6htDE4Pbf9Ag1leUGBOfxxjvsqE=;
        b=dT1xG/wMS/x5KClYOjaLzn6VYb9yeRO9+a6FmBpw0w58iRjE4DVaj6ADeAiy9nMPIM
         XBAHnwPkaTCCPfcr89iLQDxyG5TBg4W4iNogj0Q9Kzc23qqnrstZPh+LxWsL9vC4eH82
         5MFGnuGcUl/5QwyIgjgai3NOOnqMFHguICp+aPFysfLUd5qOVPn0g0HRRYywEQH56rkZ
         i3Li/MXaxxNnNjxKqPoWTdw1tkWKd4872F0j3vPCPwRj/O2twV1ZmJCNFE+Qg4lsH1oF
         gw/UK1LU9nHF+MD9xEetzbm3eo7KLOCOVHsvDB0dRbGw50dHx8SUHqUdIh/BARo6LUkg
         lkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703376480; x=1703981280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mH/XJuSscVimadN+6htDE4Pbf9Ag1leUGBOfxxjvsqE=;
        b=Hasx4vYilHpbBR6HeuSoH5UIB85LaYAIStOcZR+yyRRY/ywGer2ZNF1K7meuhDJr/l
         llLs7egH6t/YV2MQAXUCV+T7ToMV2qM5N+Xn0f0HmvMSHDXIhZakpoQNZicJ3eoYIFkz
         +kqFHAwTy9Hron6xtgAbYX7Blt4E+YCnC3djrZf8rq+hgSf2K0Bxh7FR60unSmknW1hr
         OxCGVo7q6o7/LTtPoXKtoJfgQ+ulxI8ZZPria85mir+l3R6ggyTQVAC1oQrhynPNN6zl
         /p9DZelp8yLStGjZFJVQXOCiDsccD55i7aeoiC77E4U3dkoQ6/86W3PRofr/PgraFW16
         fDiQ==
X-Gm-Message-State: AOJu0YwRiigWH7wkDH/YBGyfMReBHH0Chg+WUfn48p83wQ9UQVMi45OB
	ohxZ/PAox2vhcuYzk28MdJ6fm9iJjrZjRtO+y1k=
X-Google-Smtp-Source: AGHT+IGmruJyaWFI9jMngVnqF9R+SWkg/WC0/VLm5IuhmrIjbtlLlauBGchbUe19YPqx/v124ZPs1r4WRaMTrP2SSfQ=
X-Received: by 2002:a4a:8c61:0:b0:594:5bbd:9acb with SMTP id
 v30-20020a4a8c61000000b005945bbd9acbmr521758ooj.2.1703376480317; Sat, 23 Dec
 2023 16:08:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222234237.44823-1-alexhenrie24@gmail.com> <20231223152235.15713-1-dan@danm.net>
In-Reply-To: <20231223152235.15713-1-dan@danm.net>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Sat, 23 Dec 2023 17:07:24 -0700
Message-ID: <CAMMLpeTCZDakqdkxm+jvQHxbRXhCYd4_PK+VVqMAmZHjSPuPRw@mail.gmail.com>
Subject: Re: [REGRESSION] net/ipv6/addrconf: Temporary addresses with short
 lifetimes generating when they shouldn't, causing applications to fail
To: Dan Moulding <dan@danm.net>
Cc: bagasdotme@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 8:22=E2=80=AFAM Dan Moulding <dan@danm.net> wrote:
>
> > Sorry for the unintended consequences, and thank you for the detailed
> > explanation. Does this patch fix the problem for you?
>
> Thanks. I think this patch may resolve the application-level issues
> I'm seeing.
>
> However, it looks to me like this would still violate the RFC. The
> temoporary address' preferred liftime must be lower than /both/ the
> preferred lifetime of the public address and TEMP_PREFERRED_LIFETIME -
> DESYNC_FACTOR.
>
> These two existing lines ensure that it will meet the requirement:
>
>         cfg.preferred_lft =3D cnf_temp_preferred_lft + age - idev->desync=
_factor;
>         cfg.preferred_lft =3D min_t(__u32, ifp->prefered_lft, cfg.preferr=
ed_lft);
>
> Once that has been computed, cfg.preferred_lft is already at its
> maximum allowed value. There is no case where the RFC allows
> increasing that value after doing that computation.

TEMP_PREFERRED_LIFETIME is an administratively set variable: The user
can change it to whatever they want whenever they want, and the
operating system can adjust it automatically too. It might be more
clear to increase cnf_temp_preferred_lft before those two lines, but
the effect is the same as increasing cfg.preferred_lft afterwards.
Unless there's something else I'm missing, I don't see how this
approach could violate the RFC.

> I think the safest thing to do is revert this change, and try to find
> some other way to achieve the goal of preventing the user from
> administratively setting a preferred lifetime that prevents temporary
> addresses from being generated, when the user wants to use the privacy
> extensions. For example, this could be done where administratively
> configured values are accepted (wherever that is), and either generate
> a warning or reject the change, if the value provided by the user is
> lower than REGEN_ADVANCE.

It's fine to revert the commit for version 6.7 (after all, I think
everyone wants a break for the holidays). Hopefully by version 6.8 we
can agree on a way to support users who want to randomize their IPv6
address as frequently as the network allows.

-Alex

