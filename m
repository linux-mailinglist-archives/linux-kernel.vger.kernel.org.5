Return-Path: <linux-kernel+bounces-135122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B90F89BB64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB643B2173C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8C44086F;
	Mon,  8 Apr 2024 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxude+Sn"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95C4F88E;
	Mon,  8 Apr 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567714; cv=none; b=umlpWp+5x6ynx3BcF9KX6Pz2bKLxqYOUVoFIY6La+5HQZRIaW1t1qNyCtGuYjEVTyPMuhqna3NzMtcPmjh90QCA0WEE6V6LfaJPeSD1cf+8TAZsCUHnlUVLiqd9kxdjRF1uMzoU+RwIQGHS8Q59SUsoDiRz7sN7z/vqHIMQKXsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567714; c=relaxed/simple;
	bh=KGD3W6aq68+NPokgw+0+sWAPCU/hHUxMf8/mo80TM78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtYyzz7GEVu6rgFwtRB1XdxgKrBbcPh4S7JUA3Wc+/ZXIAY2LYpnDGJR51W7AQIxSlT7jiAz4LTTSy99zyXgtTzLMCLv4t5Q3ztjXoBpUxyzBtuF1E69fOt/F2E8MbwwF5eCMlbHI1hUsFwH4yqRxOvNXqUhQP7qC/OA1vCBp9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lxude+Sn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3544868a12.1;
        Mon, 08 Apr 2024 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712567712; x=1713172512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SODhvkyPr8ZXgSMnOcyIX8Jn66g5MUzZsrQq4BDBvik=;
        b=Lxude+Snbomur48czUwZ/ZSGbfbue0wkhm2cuEZjfSxxPDV9ogqxaCyruT3oCZVcKj
         isXFQuik82Ek8gho8JGXKs3o5PgKinH73Xh4hHlfDv7uYUZQppOQLVBHcj+0JrJR87DH
         NgxJsThzz6m1HY2VIiWMXMNWEwSKPZIiZ9TQEfKJooVcokVOHZGU2fNzQfURJcKtVoP8
         rp8bJ0RqO7OoTI7IzadtQBjd/WYJbQqngcz6mCIzLv1Dj3NwBJqUB6meJjbj0j7aXb7+
         iMl/AyyfiaYCZi1QRZTeykLpHPvcwixNZEegS4q4EfleZi4idy1fw7wE+Z/aCJPCG4Cq
         ZCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567712; x=1713172512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SODhvkyPr8ZXgSMnOcyIX8Jn66g5MUzZsrQq4BDBvik=;
        b=f1lZ2jbvqGrR5ZboYWKV3/dTFUPibjJfBycXj4NROwDqspKUWwySZBKFJ5FMOfeD0A
         oC1LM0+PApdzIEzEoXkpUThh3WxjrKWXnuRdmCBJILgdyZRPT93c2pVHR1EPLCI6WNF5
         J9IRUulNsJ7vR5Kwjh6SUK6sOj0rkSvBG/8/VQON9v/cxSZbzmpag4Rd0IFmLb6Hytoo
         sgxRdd+D/y8lnMeIGwAN+AOt1BAOAITnvvQtmnmzHf/rbiMzaJgMpdIKJczUxWRKWo7x
         Z2byTePjKWmy5ZIY5x6iuwSZCBUPrlRyxU0kH0Jdn8phV3tlSiznvs3A1XkqgLnyrVES
         aK6A==
X-Forwarded-Encrypted: i=1; AJvYcCVizLE2KwrM3S9cSkXbt99jM3F/UAotSEAOOK0+Hqv2+c3Tz/hKfDIF7RGlWUEW3tKj30JZtPVBMBxZF7WOQ/W9wEJvZhu21o1++jAagCQfUKb3MEWXp0z9Vc4EO2nJMqFw881y
X-Gm-Message-State: AOJu0YxuT8XYkgWngUrt/q1WZjgwCcWx4+Mkkxd4E+HZbHYt7de8tKiV
	01jKbji4ZlLtlN16BLxSCktK0MTBv13MABvmrQdR3ZutjCunM7IE
X-Google-Smtp-Source: AGHT+IE7+14HQRa0mb17vd6OZ8hOiE6B2jP3CDkq3cOHzcHSDFQg4qVWBhArFH6l6rGKBVbFqP3sKg==
X-Received: by 2002:a05:6a21:3a94:b0:1a7:7620:2bd1 with SMTP id zv20-20020a056a213a9400b001a776202bd1mr2282653pzb.44.1712567711775;
        Mon, 08 Apr 2024 02:15:11 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r14-20020a17090a560e00b002a46c730a5csm5646262pjf.39.2024.04.08.02.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 02:15:11 -0700 (PDT)
Date: Mon, 8 Apr 2024 17:15:07 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com>,
	davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: global-out-of-bounds Read in
 __nla_validate_parse
Message-ID: <ZhO1m9aSxElXTvri@Laptop-X1>
References: <000000000000c30be606158f33db@google.com>
 <CANn89iLq3PdiuS=qYAtUKFcrd24z2Kw8k=gMNcBcaEFkTWpd0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLq3PdiuS=qYAtUKFcrd24z2Kw8k=gMNcBcaEFkTWpd0g@mail.gmail.com>

On Mon, Apr 08, 2024 at 07:40:00AM +0200, Eric Dumazet wrote:
> Probably caused by
> 
> commit 948dbafc15da900b13c2bc9e244b9e109303907b
> Author: Hangbin Liu <liuhangbin@gmail.com>
> Date:   Mon Apr 1 11:10:03 2024 +0800
> 
>     net: team: use policy generated by YAML spec
> 
>     generated with:
> 
>      $ ./tools/net/ynl/ynl-gen-c.py --mode kernel \
>      > --spec Documentation/netlink/specs/team.yaml --source \
>      > -o drivers/net/team/team_nl.c
>      $ ./tools/net/ynl/ynl-gen-c.py --mode kernel \
>      > --spec Documentation/netlink/specs/team.yaml --header \
>      > -o drivers/net/team/team_nl.h
> 
>     The TEAM_ATTR_LIST_PORT in team_nl_policy is removed as it is only in the
>     port list reply attributes.
> 
>     Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>     Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>     Link: https://lore.kernel.org/r/20240401031004.1159713-4-liuhangbin@gmail.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks for the report, I will check what I missed.

Hangbin

