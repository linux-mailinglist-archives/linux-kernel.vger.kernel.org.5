Return-Path: <linux-kernel+bounces-68560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF6857C61
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9102855D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C607869C;
	Fri, 16 Feb 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZj84foK"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096678683;
	Fri, 16 Feb 2024 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085647; cv=none; b=CcAMzpCaUG5ff7Nu115+YMgE3f5vu+xtJtwMKV7MKZDWoV3jSIqiOGRloEUWWElTvj6H7LBEOJTSAyQ3MLaDBjwHijpTZGKhnH4sUKVu0kOpYDD/l6xKdheQdx/j8enRH+RhB+zGGQ3lOzJooW81Hd+GbH4wUTIAUhUwyHX3zj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085647; c=relaxed/simple;
	bh=VMj9NlgrJ7LdeNyUpZVFP+QrFG0xFRbwjelf51j4Cg0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZojJEgdciFI4U6jyJYTKgWm1b2PPMG8EQzxaq42rJmo1cImEV1BMdtxzZvEdpxwDESji3+F49LHR6MpPPZkeYcwCBF+Spqmsy6N/Iah6k7ch2bGPRJi6/Cye1m0+jnXVfdxzFdJ3lJk1jro8KcOksCNMJgS54G0Bf54kIx9leU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZj84foK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51299d29e43so228212e87.2;
        Fri, 16 Feb 2024 04:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708085644; x=1708690444; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rkdzbV/rnonmADQ9a6uxn+CDhcEFmPIuKWZMWrb/984=;
        b=gZj84foKRzwOgXWcFgwxpFVwqrdAg36GQcFdZf+OZRM/LkMMYEeN84kNPy5nAnTMsw
         mC0WieyknezTL01TNMcmo4R3qFznnu25FQEml4LXjbVfAw0Kieen3o9zujF9Li8ifNWc
         8E5ynKg5C7qPjQ61a2X1B3D2rP5X8a5S90zAAkaY2Ag9xohfWr4EYJhactsVSZt/07nB
         L8j9olnEcrJmOeoLR7C1FwgLw/sfPrBh6vr4o9MDMt+bhsHVr6U7Ql4vUuXu4s04aNAk
         Etm737M5Xe0efpejADAVMA85l8VxACcEfajhdJ5aJksyp0OwXYhfnJ514uKAVRrdN72q
         vWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708085644; x=1708690444;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkdzbV/rnonmADQ9a6uxn+CDhcEFmPIuKWZMWrb/984=;
        b=Mhudb7XpV/UZQfobfalYPIiVFezSN86JIVm7/2CZFwUDNtvFH67S9cuXbYIgIoQQkX
         YeaMbvD3eW9aFULl/s4OrMSsBCRSkEW7HoVwaj4oQUJDlDkYBRS18RECGjF7rOGtHdJF
         b/+96YzAi2oCM35FMPSF4hi65wMK7qyeEU8ywSvfMEUWW9H29VTQ6gsK8NvDMzHN5HsT
         jTNkFPwaI8FQYMv+hWMjbbW29DDaa3zkPOe03mJnmbcJmlmJCWi+fGJT9fOudLwXXZAz
         d++U9TzWskKKhqhwBc7AvyFJRWwx69FUogQQ1kAwybwWmh8+vS17pVvn7ZV0CZdv8yUh
         Adng==
X-Forwarded-Encrypted: i=1; AJvYcCV5Th4vC1XQGc4gqfhf+C6ZML6iETaBsprPgAzxUlGo+FrZ6V4Amgg6/cBrRz+vW+Q+xbNb3aqGm98p3dxSW/ycHm7Osj6h//ZeMZPaagypZPt9e3JIWTFFnJvm+OaU0YScUVvQ
X-Gm-Message-State: AOJu0Yx8ocr5mIDFTN58lkEijqWF4mP8tpkcg5tOouHauQ9QMxE14ghu
	UY6oulT1mYoxmv2PRMeT+IuheK0OU0ZnavM1cUkp99EiKLZ7714O
X-Google-Smtp-Source: AGHT+IEIvczXhmrH8KtwKdJv05I6jJEI06QF9mOnMKfmFYWHNTB2LlzG04ufZsBv8cvWt0kiV8c8QA==
X-Received: by 2002:a05:6512:e94:b0:511:9f76:6373 with SMTP id bi20-20020a0565120e9400b005119f766373mr4271833lfb.42.1708085643542;
        Fri, 16 Feb 2024 04:14:03 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id o21-20020a05600c4fd500b00410ab50f70fsm2155981wmq.15.2024.02.16.04.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 04:14:03 -0800 (PST)
Message-ID: <be84a28a6cdf8971a225166b8b4c865e62ee9a9d.camel@gmail.com>
Subject: Re: [net-next] net: ethernet: adi: adin1110: Reduce the MDIO_TRDONE
 poll interval
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ciprian Regus <ciprian.regus@analog.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Dell Jin
 <dell.jin.code@outlook.com>, Amit Kumar Mahapatra
 <amit.kumar-mahapatra@amd.com>, Yang Yingliang <yangyingliang@huawei.com>, 
 netdev@vger.kernel.org
Date: Fri, 16 Feb 2024 13:14:02 +0100
In-Reply-To: <20240216103636.1231815-1-ciprian.regus@analog.com>
References: <20240216103636.1231815-1-ciprian.regus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 12:36 +0200, Ciprian Regus wrote:
> In order to do a clause 22 access to the PHY registers of the ADIN1110,
> we have to write the MDIO frame to the ADIN1110_MDIOACC register, and
> then poll the MDIO_TRDONE bit (for a 1) in the same register. The
> device will set this bit to 1 once the internal MDIO transaction is
> done. In practice, this bit takes ~50 - 60 us to be set.
>=20
> The first attempt to poll the bit is right after the ADIN1110_MDIOACC
> register is written, so it will always be read as 0. The next check will
> only be done after 10 ms, which will result in the MDIO transactions
> taking a long time to complete. Reduce this polling interval to 100 us.
>=20
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/net/ethernet/adi/adin1110.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/adi/adin1110.c
> b/drivers/net/ethernet/adi/adin1110.c
> index d7c274af6d4d..6fca19e6ae67 100644
> --- a/drivers/net/ethernet/adi/adin1110.c
> +++ b/drivers/net/ethernet/adi/adin1110.c
> @@ -467,3 +467,3 @@ static int adin1110_mdio_read(struct mii_bus *bus, in=
t phy_id,
> int reg)
> =C2=A0	ret =3D readx_poll_timeout(adin1110_read_mdio_acc, priv, val,
> -				 (val & ADIN1110_MDIO_TRDONE), 10000, 30000);
> +				 (val & ADIN1110_MDIO_TRDONE), 100, 30000);
> =C2=A0	if (ret < 0)
> @@ -498,3 +498,3 @@ static int adin1110_mdio_write(struct mii_bus *bus, i=
nt phy_id,
> =C2=A0	return readx_poll_timeout(adin1110_read_mdio_acc, priv, val,
> -				=C2=A0 (val & ADIN1110_MDIO_TRDONE), 10000, 30000);
> +				=C2=A0 (val & ADIN1110_MDIO_TRDONE), 100, 30000);
> =C2=A0}


