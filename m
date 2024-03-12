Return-Path: <linux-kernel+bounces-100100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5318791C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEFD2B2204B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4555978679;
	Tue, 12 Mar 2024 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Stw4074s"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247427828D;
	Tue, 12 Mar 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710238711; cv=none; b=hjBGk381Xbt2g+PNQhGdvQgGlslNftGVdAHxvOxwfPSzZaUyCMM43Msuu35B7yKneExYKw7oTPARH+m7gZVFvVSj9ZwPdQUajt7jIOeyF1VgJQ90GvZl9Upa69l9lAZ/fNdyBJk3h+y1cFGKXRlcgrECFnvWY1mAWC7dBKvV/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710238711; c=relaxed/simple;
	bh=+vzRwUzxMTDEpVxojsrJfPSG+44198EEiXVjMk0b4lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQGmC0oxI+PAleX1PCRVI2ie3fxDKOvRfDvhrVWNnKFiQBTaBVnW12S5TKgotmq/x5LBQKVosor/Z21L2YtB2qq9QWxf98SZy6B+/uty3dkKoTfrotyZfvfvt/dmmGqZcZyfSLahdgghBya2l1WMM503/V+5c53zEPkfI2HIEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Stw4074s; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4727e38ec10so761046137.1;
        Tue, 12 Mar 2024 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710238709; x=1710843509; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v/TtoKF7cuacbpGcpjgtdgMi1EiHHySKw9WaAnGkjzM=;
        b=Stw4074sgdE9AP5hnID13kQYwLbicDbVjcuO+DX27zkZK7NYleyxY0qGGw4iuX9YME
         iy/CFVldq/CjXJdig/1JvYM28G6aegjk+/CulBb8soIcdpfwDIh4PrXnk/lhM3cQWfTp
         7U0GTSmUVqYEXcnU+P93RY77RzWbizDy5EQ/2QGccZgd1Q3FexYMRhJUN+zLrzkhceCK
         Mh8HdxOFOCicRDIlOy+XVQ3wY0nX0PkJprvEHXukGseDP0Qv/v87zzTCHiYlrzfSw7U5
         m2EBv1ldgh/cC3GNxKyagknxMQaU6ZvojF9M65cUARk7QNbJBd9dA3K4cwwOLKvaaQqR
         crAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710238709; x=1710843509;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/TtoKF7cuacbpGcpjgtdgMi1EiHHySKw9WaAnGkjzM=;
        b=RKG5KSCtj1ac37F7M1Gtwjxu8T50MwvjqKqxGg9kLrFHRCzRHn0t/MRHjxKO76LNi4
         ZUMFmpvV8WaBCQ5MGHjsgU3PyjMEglvxnkDAZfHRPyGk+a4ElD4gIcT1oLgis4Paan76
         YopXkIu+d9by3rsmd8c4EQcFhEK+9NQNr8JLgdLTCM7RIUnjnDBIcZZ6Gz0CrZus8OZ3
         JNjjXqKaRbK/ASfxl3OuwZNI23v043HsumxR0ZUplOyF6Do7Np264zJLw6Sh+AVlLzo9
         Rk/JBcXEioLSyvv6J5sP3x3mhMgIjfMyVPKzpjwZ90yim46i9+r2jy7aXle7tuWhtmn0
         xFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXul2iPYk6U122Pjhmk8TFoztW39gOd0tDQzh1hYP2AbhYisMRhLOSk+DWhP01y4yoeeV8IkgD2pV8T09+fLvOP/NfYHaY4kn95RVzvXOq2WSdE3aQFfjEX94/yO6gGFiNwAuib
X-Gm-Message-State: AOJu0YynZ23wCo1syx4X88e1pKdLRDtaJpcOmCgWyAqdFUFfpbKzv4do
	4/PfBz8dswBL81YA7vLK09pCpC9HEQmggv4ySMISewPAa9p2b+Dgx9QCJCZ1w0GV/vnTVfpZz7I
	WAbuo1VAUkAM/rY77yK3T/tKtGsU=
X-Google-Smtp-Source: AGHT+IHg34ksh5Vb8nFOPwXj8ahKVbhIjUruuiOlKBdvSNe99Anup77tCH67cK21OhJVVEyLM9Hc3BDc70tkwVkn0OQ=
X-Received: by 2002:a67:f041:0:b0:472:64f5:f0a5 with SMTP id
 q1-20020a67f041000000b0047264f5f0a5mr5959821vsm.18.1710238708956; Tue, 12 Mar
 2024 03:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312094259.770554-1-e.velu@criteo.com> <fd37860e-306f-42bf-9a1d-e4d98ddf338c@molgen.mpg.de>
In-Reply-To: <fd37860e-306f-42bf-9a1d-e4d98ddf338c@molgen.mpg.de>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Tue, 12 Mar 2024 11:18:17 +0100
Message-ID: <CAL2JzuzjRTHzKPVU9+zfFeEgfDQPeRDUuaUjsqgDfgQ865en8Q@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v3] i40e: Prevent setting MTU if greater
 than MFS
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Erwan Velu <e.velu@criteo.com>, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

> Am 12.03.24 um 10:42 schrieb Erwan Velu:
> > Commit 6871a7de705b6f6a4046f0d19da9bcd689c3bc8e from iPXE project is
> > setting the MFS to 0x600 = 1536.
>
> Please add a link, as most people do not have the iPXE archive checked
> out. Maybe also add the commit message summary.
I will, thanks.

> > At boot time the i40e driver complains about it with
> > the following message but continues.
> >
> >       MFS for port 1 has been set below the default: 600
> Hmm, but 1536 > 600. So the log message is incorrect?

As mentioned earlier in the commit message, the 600 is 0x600 = 1536.
I can offer a patch to report it in decimal or add an explicit 0x prefix.

> > If the MTU size is increased, the driver accept it but large packets will not
> accept*s*
Fixed.


[...]
> > At least, this commit prevents setting up an MTU greater than the current MFS.
> > It will avoid being in the position of having an MTU set to 9000 on the
> > netdev with a firmware refusing packets larger than 1536.
> Maybe add the new log message.
Done.

> One last formal nit: Please use a line length limit of 75 characters per
> line.
Done.

> > +     mfs = pf->hw.phy.link_info.max_frame_size;
> > +     max_mtu = mfs - I40E_PACKET_HDR_PAD;
> > +     if (new_mtu > max_mtu) {
> > +             netdev_err(netdev, "Error changing mtu to %d, Max is %d. MFS is too small.\n",
> > +                        new_mtu, max_mtu);
>
> The other log messages capitalize MTU.
Yeah but the exact previous one was in the same case. Shall I bump all
of them to upper or lower cast ?


> The rest looks reasonable.
Thx for the review.

