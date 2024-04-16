Return-Path: <linux-kernel+bounces-146362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA7A8A6436
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FDE1F21D50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6226E5E8;
	Tue, 16 Apr 2024 06:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIlrJZRH"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79127715;
	Tue, 16 Apr 2024 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249776; cv=none; b=uaYFwyULm/m57WPE7uQF3AguvaJHI7MdcenBt4kBOXEOu9xSVAssN8N8RT+ZFrtpOA7x5plEI0ggQhUxUsSO5xjlmDPFvkzOR0KmjbXbOnU7eq97FFRd1tCy/qfHrR0eioO+Pn1VnLUhcaZqymoGu+x+mzizEKu5YWTER3A9P4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249776; c=relaxed/simple;
	bh=vjFvnJ0DiF9W1/ez3ol+TtAwoJAYGfl60BD9NBAXzl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPRk19IPA2PILiHGtjjjHTFL8/f7E5/WzhWHwHgwJziZod2hBb725Vc0fiKjUEYj/ebup40wwqVFIFBfm9jbZG7/qG1ZYeejJ/spyLmPAt0BTwzGH8sd1KfN3s+9HIWsl755vRyNX31ZYDXFJotuIzMBFoT35coD1dvmksVMJww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIlrJZRH; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so5741071a12.3;
        Mon, 15 Apr 2024 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713249773; x=1713854573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/1YqI6k5U8HVHmH5m/IhhTHjeui5HKnPZc4Ol9mPwQ=;
        b=lIlrJZRHEVLDo2i3RNkTdcx1E3TFGj3xTri+nIcWkienCaKSilTqcFdyqOKuwPAjJO
         IRsAVm3ajGaDfhCwoOqpNu6lHaU+HSelcjws5sshHv/p02f3tZ+FdqLO/prG6Tz16vEe
         0ZlycMR0+fuCgyaCbIFjvbskKdsSev3qcgioDnuOwZHeP6lV5EIkjt5O5QV/ooq1UyKu
         nFAOMzItGjmGWw9eptMgPQKI/7T31a9cdd7Xl8FC3+yhNLm21XY0RoQuDkOp7Vxr6gmL
         1blW1BL2csswGjYZ7d+nWRWzGb8vIfZAHGXC9khWiLbV0Nz0HbZIi9XDzgtiooyAPMpB
         mCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713249773; x=1713854573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/1YqI6k5U8HVHmH5m/IhhTHjeui5HKnPZc4Ol9mPwQ=;
        b=YnoW025KplFMEaetZtu36l+e+EnEfz6AR1cPQg9H4DfW1bg5Oc1H2TI+1HeLoYR+ov
         vuXLd+VMogpMhv5VKaGHJUzDefSFmmNh+rkErh3PHgtenHr+gM9BMIZ70EqI+MwIl2aZ
         X9t4ZSgqNX2rdsrZqmIAjWSMyPWA68+4iW2cwA0b6PlM5rgSCcVHYBHHQUoNH+3S4A0o
         tj+EsgjcnhJN28lwnac5ZZhkVycb10DFqKzncy/GBF72ZdcT0syG5xsJnOB4QfxSpUuo
         PtuYTrAossOFZWcKW0STed023G01TYOvZ6UYnRm1aEwDJKKdaGrTaPrpYCW5A33MX2Cp
         h/gw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Q2D4OdJRBn+bCLhJ61UFN4oYoifKIQHke+HE3xCDBiDsPjD8x9LDu0/sKdG+QZ1D0H5t9MEGqhFa7/7s9A/9Liz52uKB3ZhgvyS2XPDDywxLmXGD5DVsOkI3NBPdDe4OPQDh
X-Gm-Message-State: AOJu0YxsKKdQQ6gzFbnNBjPbqdKM8GaIntTkTZZoL1kYm5YlteChOee0
	nLzbGh4oaKezFwDcOtIlwa8TsdcjQm5TfWUOJjfjJcI6qS8LcC16nefQ3vDnrwc2cdgByGDxtfW
	WlR9vLrF7ICI/3oHTJ8hb1vDsDLE=
X-Google-Smtp-Source: AGHT+IEz/zqNTegclXfAY2q29JbjdLcNOEGz75t1I3AgJ6ydg3/K4qxTBZJ5XEBwywK7nRm+Z0wyM2EwCRX0o7Q+ZKc=
X-Received: by 2002:a17:906:35ce:b0:a52:71af:405d with SMTP id
 p14-20020a17090635ce00b00a5271af405dmr2462563ejb.56.1713249772816; Mon, 15
 Apr 2024 23:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYPYF-nNB2oiXfXwjPG0VVB2Bd8Q8kAq+74J=R+4HkngWw@mail.gmail.com>
 <ZhzYCZyfsWgYWxIe@Laptop-X1> <CAEkJfYOebGdmKLtn4HXHJ2-CMzig=M+Sc7T0d6ghZcXY_iY5YA@mail.gmail.com>
 <12281.1713195788@famine>
In-Reply-To: <12281.1713195788@famine>
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 16 Apr 2024 14:42:41 +0800
Message-ID: <CAEkJfYOP_fDODxtNc5SvYeYgbvQ86FPLhaecQQXExqtFBbEgyQ@mail.gmail.com>
Subject: Re: [PATCH net v1] drivers/net/bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, andy@greyhouse.net, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:43=E2=80=AFPM Jay Vosburgh
<jay.vosburgh@canonical.com> wrote:
>         The submitting-patches.rst file in Documentation/ isn't
> explicit, but the intent seems to be that Reported-by is for a bug
> report from a third party that isn't involved in creating the fix.  I
> don't think you need it here, just a Signed-off-by.
>

Sure, I will change it in my next submission.

> >> > Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> >> > ---
> >> >  drivers/net/bonding/bond_options.c | 3 ++-
> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/net/bonding/bond_options.c
> >> > b/drivers/net/bonding/bond_options.c
> >> > index 4cdbc7e084f4..db8d99ca1de0 100644
> >> > --- a/drivers/net/bonding/bond_options.c
> >> > +++ b/drivers/net/bonding/bond_options.c
> >> > @@ -1214,7 +1214,8 @@ static int bond_option_arp_ip_targets_set(stru=
ct
> >> > bonding *bond,
> >> >      __be32 target;
> >> >
> >> >      if (newval->string) {
> >> > -        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL=
)) {
> >> > +        if (!(strlen(newval->string)) ||
> >> > +            !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NU=
LL)) {
> >> >              netdev_err(bond->dev, "invalid ARP target %pI4 specifie=
d\n",
> >> >                     &target);
> >>
> >> Do we need to init target first if !(strlen(newval->string)) ?
> >>
> >Good question. I think we don't need to init target first, since in
> >original logic in4_pton() also leave target untouched if any error
> >occurs. If !(strlen(newval->string)), bond_option_arp_ip_targets_set()
> >just ret and target is still untouched. But I am not sure about it.
>
>         I think the original code is incorrect, as target will be
> uninitialized if in4_pton() fails.  The netdev_err() message shouldn't
> include target at all, it will never contain useful information.
>
>         -J

Yes I think you are right. I will remove the target address in fmt
string in my next submission.

Best,
Yue

