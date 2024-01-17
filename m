Return-Path: <linux-kernel+bounces-28442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD42482FE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A6C1C243E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D0C1C13;
	Wed, 17 Jan 2024 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WSVO/x5f"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89A01385
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 01:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456289; cv=none; b=GMF/vMqscYL9lBfvl8NTyjNy3lVV9y7rNbciXzslRPkC+28fecy/vbgU6ODq+S5jUf+se1yfz+tdWA7KuPLmm1++JZU9ryv1ul5PttJNPD8CAuZoHdvgSuXeRnuy/vyejbUFNcC0hs5RizY49x8OxMDn+OQKguG3DAyigAXFGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456289; c=relaxed/simple;
	bh=JiFl8+epB08Zl1NjWmOkd5YBmmVt1tz60AanHbyhe74=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=OsBMFxCX4+4x1xS8ZMWIpvgA78ocvEIquEArCKVagSgswLTU+NKdeR0wM+j3RyC+Xl0tLcVdPovuZ6URSrf5xBaRzgO4/jkXsSrf0n4hgluvAVzSBH/XrF6e3C4V+4ZWYIK55SbkG0Ujw8fPrepSI182YogxAuPYK3vKrwyjfrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WSVO/x5f; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e7b03fbbeso2148797e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 17:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1705456286; x=1706061086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuqIUbDsdh5jhxBSCU/cWA/zJ4KgisT+JkTQXpz8Tck=;
        b=WSVO/x5fPuwycl8CKwhFYhlFQ2iuk+/Q+WP73E2OWp47eDqAZvO8JOgOZjyBuc1Cn0
         AJ7awd+USytZferI/JjYDnK67pQQrV5LeAtKJVvaG9Zmsj8neM14oOZHOoqqBD4ko1OG
         Y9uUJfNsm1Nxaf6gicO+7IZ5oQXUS0ez+d+psJGBMCIoDgING/OxL8ZoXImz2aVj9UxK
         6wAva0pJ0yom/6k82pjnXIAxA9fGYmiwIIPI+eFR+y+cZB1/dORnG4JYWuI0JJdouju4
         60ve3QcDn5mP1VKCyT/c/DWIcNwNCr1vSLp7yQMGiYORvEAih8Lc79pNC3TfBI2n/GiM
         MzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705456286; x=1706061086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuqIUbDsdh5jhxBSCU/cWA/zJ4KgisT+JkTQXpz8Tck=;
        b=WQAKlv8O3GjVfi2O2JO9V6uspj+JAxtZrU07L0ZlSFtPz60iO5MLRrOF7hNqegJIhk
         oNc1aJRvMEsjJc7+uPCdPDDtB10/+ut0eLZw3jhRimd0ftb+K5ms7kkzrJCfunFqIqN2
         u9JJZBCT5RPJAduKn2JzjSit6o5I54wSKiY+lqIl+ZMz1xoWOgdS8boWPkRKbG9nuWI/
         3+Xn0PYXtVFxn7dm4143S+PVymTO7S36ZI+tR09N5nNyBm9P7dVdXXbaT5ONlXLGzstz
         Z6F9IEe4WRmEbAkStcwMRLdv+ybAjiqw8r0v8C8T/ZLqbvYnJ8TMnpbtJ8ijFIW9cpkq
         jxFw==
X-Gm-Message-State: AOJu0YxVjJe2bOZjzF2BjrSwiXWDbGWFcWSmraYqm4dfdOh7OMXF97xQ
	973geZ0Pk7rncaIyRqyVoTW79YffsaFlt4NzNMzCLP/CiwP+YA==
X-Google-Smtp-Source: AGHT+IGSZGVErl8CE6vVHqGEfu+HqhgYcJ1/cHQdOu9XRTxwKHDsrmulx1Hy8i6xvbz0AzG309SuCm4l5ayMKINp6R4=
X-Received: by 2002:a2e:4e02:0:b0:2cd:3731:9c52 with SMTP id
 c2-20020a2e4e02000000b002cd37319c52mr278711ljb.2.1705456285645; Tue, 16 Jan
 2024 17:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116193542.711482-1-tmenninger@purestorage.com>
 <04d22048-737a-4281-a43f-b125ebe0c896@lunn.ch> <CAO-L_44YVi0HDk4gC9QijMZrYNGoKtfH7qsXOwtDwM4VrFRDHw@mail.gmail.com>
 <da87ce82-7337-4be4-a2af-bd2136626c56@lunn.ch>
In-Reply-To: <da87ce82-7337-4be4-a2af-bd2136626c56@lunn.ch>
From: Tim Menninger <tmenninger@purestorage.com>
Date: Tue, 16 Jan 2024 17:51:13 -0800
Message-ID: <CAO-L_46kqBrDdYP7p3He0cBF1OP7TJKnhYK1NR_gMZf2n_928A@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Make *_c45 callbacks agree with
 phy_*_c45 callbacks
To: Andrew Lunn <andrew@lunn.ch>
Cc: f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 3:21=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Hi Andrew,
> >
> > It bubbles up as EIO (the translation happens in get_phy_c45_ids when
> > get_phy_c45_devs_in_pkg fails) and ultimately causes the probe to fail.
> >
> > The EIO causes the scan to stop and fail immediately - the way I read
> > mdiobus_scan_bus_c45, only ENODEV is permissible.
>
> O.K. At minimum, this should be added to the commit message.
>
> However, i'm wondering if this is the correct fix. I would prefer that
> the scan code just acts on the -EOPNOTSUPP the same was as
> -ENODEV. Maybe the error code from phy_c45_probe_present() should be
> returned as is. And mdiobus_scan_bus_c45() is extended to handle
> -EOPNOTSUPP ?
>
>             Andrew

Noted about the commit message.

To return -EOPNOTSUPP high enough up that the mdiobus_scan function(s) can
directly handle it would mean at minimum, these functions have -EOPNOTSUPP
added to their respective list of possible return values:
    - get_phy_c45_ids (static)
    - phy_get_c45_ids
    - get_phy_device
    - mdiobus_scan (static)
    - mdiobus_scan_c22 (static)
    - mdiobus_scan_c45 (static)

I didn't look beyond to see whether any callers of phy_get_c45_ids or
get_phy_device also return errors as-are, but it feels a little broad in
scope to me.

My impression is still that the read_c45 function should agree with the
phy_read_c45 function, but that isn't a hill I care to die on if you still
think otherwise. Thoughts?

