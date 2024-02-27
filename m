Return-Path: <linux-kernel+bounces-83120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88637868EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2D11C24026
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFCA139597;
	Tue, 27 Feb 2024 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGqDWjBg"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E33139584;
	Tue, 27 Feb 2024 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032978; cv=none; b=XCc/FpNHOZdq1xbJJAIMZdI/yIVN0IiSrecz12sOmRWhc4CWXxWvmX/QO4nUQDyOcnLtDSyGNQzOIebfwiVmnLcikYJps5lmbNeCLIKD/jezIVpmGPqr6jq9Hqeggx2oC9YeNiRiawAfUCCE5be1GnrXKqD26+biCbWLGPHzYG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032978; c=relaxed/simple;
	bh=QY4nbgOuk+mXWv3xkTbITplpajvEJ025OOgFX9xwXwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huSCwMwv3y1700xdh7A2Mzzch5fff5qWAwxA+YjsCpTjC0Kq2VadhYR8LP9EfRKLlcSH+qkLO/PIKtUlFPn8Cxb/2ToXP+LZ+o/3pVyMdqCDMP9Pi0Cnzx+lIji0h3cfcithP9lO4CiTY9hObuvqkXq5nTRdpMNbMHT2GW1bmB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGqDWjBg; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d862e8b163so1625584a12.1;
        Tue, 27 Feb 2024 03:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709032976; x=1709637776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QY4nbgOuk+mXWv3xkTbITplpajvEJ025OOgFX9xwXwY=;
        b=iGqDWjBgiWudzk47jlrZp36RrIjbKcbFWW86fbfsuwzci0j4IJf2ccbvv4sj11Pstf
         1948zU8x7MuaugHaXuq64P9uCDw/N+puvNmysUAk/dpLkCeszjESXNezU1zZKm9JX1i9
         vpYR1wnaEtIW9xXZEZMSy1U8AhlrBlGWxtLnOr1m+Kqf312pexflEr+ZPIsyihUNJqog
         IlRIbplEOrroTZNeO6v6+jVK2F2rC54EB6F6xJseGx3N2ikquPiaMA0b0gt+S75x6zT+
         zUzomsto32iMzzZyL3iptjGmW3cL0lCBWLoLu9ZaFtAH3Y7YrsmzgWRph4hhcHM7x1vR
         IL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709032976; x=1709637776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QY4nbgOuk+mXWv3xkTbITplpajvEJ025OOgFX9xwXwY=;
        b=Yhm+D4dsN1xBW1DBubGWygObnHz/GnncXVrORP2xBK23cjFA78le6v1AUZVaqyRjz5
         XHCWoiE1LxrjdjgN4+XLgo+ilOL+pstpyegNCF5+Dpxmru6oLcx2zVNWUVow4zwRx3yy
         quxzqX2tTAaiik3nSHV/mElgqeqcX7L0a7WmtstsegpkNi/khl82V+ODsJOd2vHqHZ1l
         huEe1eDcxoNTsCSHZDtm48AW4/NSfGSJbu9B+pDAS0UbLklGFSDj8bk8Q/4pEvwUqOAO
         IczdmcT4jBJsxIUDEHkIc3/QY/qXT4VdNdb0P4qOOEgVaJ/uQCeac4o5cx5oI30sp1qG
         6kRg==
X-Forwarded-Encrypted: i=1; AJvYcCWNj9SccRMG67uojeYgEGlf70p6k0dQEeV5JLuUA3jI2/FfzRQZV8kNZHHwirHL49Jb7JAHIITxoE+/j/7RTL4vn4fLtNC8ZZaYdZEeH3vnqH7lbcpEID/cy9MiFTuYJL4aH8B/
X-Gm-Message-State: AOJu0YwABEyvmCdJtQtEb8f5mPaoTHEixLOKUVBjgyb2R5EXma8fZ/7/
	JYxTTjbKM7OBKtjPkJT3AEyVgN5iOVXnabfAHMLG7e8iPULBscwvDDku6V4PprOtlPdFkbEykCl
	paY39rLtVhcq9sKd2kCWLPdiiURY=
X-Google-Smtp-Source: AGHT+IE0g4gz/AJh8ctNvdwvdxsSJdx65J6LrAWRk2GE4ybSaPORkjlWpPHcp88bD8t3qkbSG9kpRv5Jds29ELRnFio=
X-Received: by 2002:a17:90a:2ca1:b0:298:b2e1:48dc with SMTP id
 n30-20020a17090a2ca100b00298b2e148dcmr7893411pjd.4.1709032976582; Tue, 27 Feb
 2024 03:22:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226091325.53986-1-steffen@innosonix.de> <20240226091325.53986-2-steffen@innosonix.de>
In-Reply-To: <20240226091325.53986-2-steffen@innosonix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Feb 2024 08:22:45 -0300
Message-ID: <CAOMZO5Ak=rtnwm_St5DUKWgWVz47bdR1vyE397eN3GxbjxNVQQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net: dsa: mv88e6xxx: 6320/21 read cmode on serdes ports
To: =?UTF-8?Q?Steffen_B=C3=A4tz?= <steffen@innosonix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 6:15=E2=80=AFAM Steffen B=C3=A4tz <steffen@innosoni=
x.de> wrote:
>
> On the mv88e6320 and 6321 switch family, port 0/1 are serdes only ports.
> Modified the mv88e6352_get_port4_serdes_cmode function to pass a port
> number since the register set of the 6352 is equal on the 6320/21 familie=
s.
>
> Signed-off-by: Steffen B=C3=A4tz <steffen@innosonix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

