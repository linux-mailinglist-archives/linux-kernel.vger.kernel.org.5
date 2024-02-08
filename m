Return-Path: <linux-kernel+bounces-57333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CD384D718
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4328D1F229EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68240FC18;
	Thu,  8 Feb 2024 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egi9dPin"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB91E49D;
	Thu,  8 Feb 2024 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351731; cv=none; b=gxNg+YGudU93AKDOlqiTJTCX8PVx9ez2J6THIirCHDP1rraUyf1X5Tupt1C99wqHKD7cOVBzIO/8kjYQIURsezo+9g+f+GpSqR8RQkZm+colvSiNJAnKuXZ4Ui0jwCQ1DUlU62aSjEIraJ6bsama2yVt4Tm3zSEFBZuqEh09hgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351731; c=relaxed/simple;
	bh=p4IzyDPH59zg0aZOLIL/Gv3EduhzP79O9vaHv5fMEys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cb9auktRHY6UyMa3lzCgodXN3gJB+TM6eSjtSTn/6PzkyGix266LgsTW5dDfL3WlHwgbRqORnBJqmRgLmGgu8sLX3/eOnURvq4HcTnsPP0TtB7Rl9WW41lbL9+VCyUuX8AyD20R7wOXrp1D+O+JyC6t1XHevlJeekR2+ai97KZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egi9dPin; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59883168a83so536733eaf.2;
        Wed, 07 Feb 2024 16:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707351729; x=1707956529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfVSYGmYGYF0vwybF6QFj3Ki6AjcQEFcATXJTrLCvQI=;
        b=egi9dPinJABBMTrzTwEwvAtlFY8Z/VxZoDwlf0U5xaZy+yYxLpp6OyGoJY5KSFm2sq
         a8o4H6Tb4uDIhNmg5FpiTriSy3WpkL1OUw/II4TVjJvnIbEZiJTWGOkLGerMolpXzeSi
         W0Dazp3n0Rz4GSWaemT5ax74vUgQ06HbzzpyUvTzURP0yXjNMjkadsxV/5sbgSDGWQCI
         kPmUVtfbxTNWctgGYlWNZz43pK1FL2Pos+KMIyTHZlRjqzWbqJ/tWm5oJjaMV7bA1mTg
         ipRcjuax2qqMVU+wwk+e/eP53rK4wpKtSlMKSga1FEB7hBrUqJNuIpMRSP2T6oud81ux
         lmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707351729; x=1707956529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfVSYGmYGYF0vwybF6QFj3Ki6AjcQEFcATXJTrLCvQI=;
        b=uRdA9qusmhGywMkYVLD5DlIMwsYoReNn8N2TVB5MCC+xXMoezyGxzHCNA3zY0mHEw6
         Bftt88BaS+UBNcJtf4/242PMKIk4hhQHPkkt0KJEO2aHMygoxCXmSMKF6iQr0mD9r0sg
         tZkhhYQan8AkBD/eEs0frfpUPg8De1ISbiF2evckc7qjKc95Ta7HdD9pzEuaZSJrPOdB
         E9SYRjLKfNAV2go7tSmvyPEEdg/HXcwJB5ZOaEnUPJ7kz6ZzKtTKqtibs9MakUT3NBsO
         07z8kkLyWNV3nCjju+C1DfvTjlVITlBJiN7Bmd7IywKS2Gcu514xyNLWreizZt0Fe5LY
         JGvg==
X-Gm-Message-State: AOJu0Yydzw0NHiOsK6N9QQZ6uLeMfinlHdDZxMakQkWgbtLExwd1U8Ri
	tXoEBhtPOwB3+Jr/ZDUwWfTCOnzknIILYFjz08vhiErCuZMtnpueUgIbL4mMXdNe9V7s7J4C2/6
	ZtY5GFBeMN8ZRPWJYC+Oa8Ounc8I=
X-Google-Smtp-Source: AGHT+IEGR1t1Xw+DlUF4mrZJ86FLolejaoxPZSNWkPCEkGDxE1kI5zrulvwraF0elKWCk6JARiJPjdzqzrxELqS20EI=
X-Received: by 2002:a4a:7650:0:b0:599:7389:967b with SMTP id
 w16-20020a4a7650000000b005997389967bmr7394200ooe.4.1707351728876; Wed, 07 Feb
 2024 16:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207230430.82801-1-jmaxwell37@gmail.com> <36a95b38-99c5-4fda-b9bf-8b9fb3b67e1c@lunn.ch>
In-Reply-To: <36a95b38-99c5-4fda-b9bf-8b9fb3b67e1c@lunn.ch>
From: Jonathan Maxwell <jmaxwell37@gmail.com>
Date: Thu, 8 Feb 2024 11:21:33 +1100
Message-ID: <CAGHK07Dwv_fkP222WtMeH-E+bqOG8CFGQyNObDtkYbmeD4LELQ@mail.gmail.com>
Subject: Re: [net-next] intel: make module parameters readable in sys filesystem
To: Andrew Lunn <andrew@lunn.ch>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:04=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Feb 08, 2024 at 10:04:30AM +1100, Jon Maxwell wrote:
> > Linux users sometimes need an easy way to check current values of modul=
e
> > parameters. For example the module may be manually reloaded with differ=
ent
> > parameters. Make these visible and readable in the /sys filesystem to a=
llow
> > that.
> >
> > Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> > ---
> >  drivers/net/ethernet/intel/e100.c                 | 6 +++---
> >  drivers/net/ethernet/intel/e1000/e1000_main.c     | 2 +-
> >  drivers/net/ethernet/intel/e1000e/netdev.c        | 2 +-
> >  drivers/net/ethernet/intel/i40e/i40e_main.c       | 2 +-
> >  drivers/net/ethernet/intel/igb/igb_main.c         | 4 ++--
> >  drivers/net/ethernet/intel/igbvf/netdev.c         | 2 +-
> >  drivers/net/ethernet/intel/igc/igc_main.c         | 2 +-
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 6 +++---
> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
> >  9 files changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/i=
ntel/e100.c
> > index 01f0f12035caeb7ca1657387538fcebf5c608322..2d879579fc888abda880e71=
05304941db5d4e263 100644
> > --- a/drivers/net/ethernet/intel/e100.c
> > +++ b/drivers/net/ethernet/intel/e100.c
> > @@ -170,9 +170,9 @@ MODULE_FIRMWARE(FIRMWARE_D102E);
> >  static int debug =3D 3;
> >  static int eeprom_bad_csum_allow =3D 0;
> >  static int use_io =3D 0;
> > -module_param(debug, int, 0);
> > -module_param(eeprom_bad_csum_allow, int, 0);
> > -module_param(use_io, int, 0);
> > +module_param(debug, int, 0444);
>
> ethtool should show you debug. And it is pretty much standardized, it
> should work for most ethernet interfaces which support msglvl. So i
> would say it is better to teach your Linux users how to use ethtool
> for this.

Yes they know about that. But take the scenario where  allow_unsupported_sf=
p
is set 0 after it was set to 1 at boot. That won't be logged.

>
> There might be some value in this change for module parameters which
> are not standardised, but i suggest you drop debug from the patchset.
>

Fair enough makes sense seeing that it can be controlled by ethtool.
I'll submit a v2 with that change.

Regards

Jon

>     Andrew

