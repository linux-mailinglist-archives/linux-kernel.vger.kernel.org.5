Return-Path: <linux-kernel+bounces-133305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB66889A20A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D422843B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEC617106A;
	Fri,  5 Apr 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/LhSlfy"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261F16FF30;
	Fri,  5 Apr 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333041; cv=none; b=aeg/i9CHK3QZ7mTykUcLMujnXeyET2e4OgF6f2EY17NpA05fSIhL6mraTqAUWACawIOiFBRjo5UBJSA8HeSDaO3flokh8mzwHVkJzNUATPj+/tDOKuXPe3YQs/V+kK0S7oH3lt1gaqVxUSyLMDJV5iPcIudev1Hj8fPmLAn9I3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333041; c=relaxed/simple;
	bh=XZEbvzuSGL/q8fWAhduZQ1/BD/N6nnhdCQ9Uj8IkLD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YW7suM23lAhc1kedxbN8R/pcxPA9VWB3mS6jn7L0XEYiTc0XUPg7d9Uqw7JZRRMrPY0Q13dxjjWIyNYaTnS7v7/uifUfgqLHeJlZkYJQfoBTsusPJnVWzhj6zS/Hj7ydJtxP3zMLuFaeqOGxHJxd2cHcyzYEHTZZVSEpsyO1Itk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/LhSlfy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e244c7cbf8so20894395ad.0;
        Fri, 05 Apr 2024 09:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712333040; x=1712937840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etbSwzYuABShtb+O6Ks2+ioR0GpoW20VrH8Vqwfvekc=;
        b=O/LhSlfymIxX+AB66D074I6kkAn2sNQy4E3jLFLpx8XjatqqZm/X82DPglf9f66Z0+
         cJslajx92fKH2NwCKOeBdufELmx+mW9nuEcCJM91v84JObjFkVDF5EALV7JQxhhWQQQ6
         AkpQiPIF6xg5Ommq27M/uiLDJq/P2itFkapyUFmkLwFMVCB7X00LGCx+rrJ3ycDdljuu
         +cyEKm+9Fb0JD4vkyMxZJEow5ZZfCji2yOHI9XLrnldMBR+iANQf7tq5nhXW1XF+GUek
         6JlgZl6RoMS1F6o7WN1DAtHpl/paitSoRLqdBXcdqtGO4kh6zEGojD9gSSAcs96vJZg8
         SmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333040; x=1712937840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etbSwzYuABShtb+O6Ks2+ioR0GpoW20VrH8Vqwfvekc=;
        b=JBCUAdrslRKRJs7NKQOZgIQlO/zthOaq72dPaimaUX73wzRAQ1kTkAMuHCVGbFqWFc
         v+94A6Qd1qLZpmFJ0FzDps33pTqoOTCMHI2pZZdB7gvbTZRP8cSOjM4AZ6IgyrIy7PpY
         XhOsyg2DXz2gcabvLjrZZy6vccjoaxJH7lZBkBfOvRiI7Muj32qi89t8Mr4bdCx9YpVm
         j0yuSzwJ1V5oJ4O6d9k3VskyrwwNL9AdLPSw7K6hMLlMDlEC8lM1d9KCT6KbNoGQq3yV
         Q9/fax/v50x5e84qmwbj0bDr6AxLR00C8OTJynb+2xNVzpTU1Ui5QoA9JlNh1TXQu7RK
         Lvhw==
X-Forwarded-Encrypted: i=1; AJvYcCUna/TLsQwdVvJ5nr+cCmLvmnLv1mr9ANPIuYHIFu3tJ1CBsX8NzP0pmw4F3RbA1JTnHfBBlp7AW1zeILqjXcU2TDxVeXWdMIHUpP1GnhcXnTnzXerbacxMwU6QxyC9zY77qhpuzg==
X-Gm-Message-State: AOJu0YykM6tjRTMRuiDk6ALGpb3Nu3S1nc3xABtJcybgew5S1UfMzeTV
	96hbSCKh1x2GxbGLmIzez46rM6yFQ6qBAKyhd++4hdK1cWqPTE657NCHqcdlyLzI/E83+841vMU
	Y6uGvZyNwLLAP4H7fsxkEtEsoRDl4TWeM
X-Google-Smtp-Source: AGHT+IHtg0bOFEUGXO3Rcvw1vYQBIFhqv/Q71ImZaJBf3ONgwUEQAilOGCikPeqFD/kJi4YqaRmPl71ZJuLlK6IzDm4=
X-Received: by 2002:a17:902:f813:b0:1dd:c288:899f with SMTP id
 ix19-20020a170902f81300b001ddc288899fmr1583349plb.18.1712333039584; Fri, 05
 Apr 2024 09:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405141907.166334-1-richard120310@gmail.com>
In-Reply-To: <20240405141907.166334-1-richard120310@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Apr 2024 12:03:48 -0400
Message-ID: <CAEjxPJ7C=fq3uM0t_uQJ00ZZbieMP5ZO3BXMVY7FzB0ENJU1Nw@mail.gmail.com>
Subject: Re: [PATCH] netlink: Remove the include of files doesn't exist
To: I Hsin Cheng <richard120310@gmail.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, eparis@parisplace.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 10:19=E2=80=AFAM I Hsin Cheng <richard120310@gmail.c=
om> wrote:
>
> The file for /security/selinux/security.h and the file for
> /include/linux/selinux_netlink.h are no long exist. However the
> preprocessor still performs the inclusion of those files, these
> behaviors should be removed to ensure it's bug-free.
>
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>

NAK. You are incorrect on both counts and evidently didn't try compiling.
At a purely source level, I agree it might look confusing, but the
Makefile adds the security/selinux/include directory (where security.h
lives) to the include path and selinux_netlink.h lives under
include/uapi/linux which is auto-magically included.

> ---
>  security/selinux/netlink.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
> index 1760aee71..8ce36abaa 100644
> --- a/security/selinux/netlink.c
> +++ b/security/selinux/netlink.c
> @@ -13,11 +13,9 @@
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/skbuff.h>
> -#include <linux/selinux_netlink.h>
>  #include <net/net_namespace.h>
>  #include <net/netlink.h>
>
> -#include "security.h"
>
>  static struct sock *selnl __ro_after_init;
>
> --
> 2.34.1
>

