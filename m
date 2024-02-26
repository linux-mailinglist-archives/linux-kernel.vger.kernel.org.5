Return-Path: <linux-kernel+bounces-81328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A33B867447
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B17BB21F65
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EAE5FEEF;
	Mon, 26 Feb 2024 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4y9tUjt"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935E5FEF0
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949136; cv=none; b=C8AddR5MV+nsb6lZRr6fvdddOtGP9PicGiNi71je6ztX4gigF0fZ9Ksf+QQWrDbLzajSr5I5tAG6enRFZyvGwqB+p/jHn9ma2EGUMpbmrU2BoMzvqVRmAjrzDUmknHw/D/XBrbSxa+ENOpZgRueWksIuvZla9nnUY6C6QuJ0mLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949136; c=relaxed/simple;
	bh=HXalZqslNQYwXLbvprw7luRqbREUSPpfMkDGT29SA9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mX1SrFk66uTOyFd/OuiD5Hde5s7iaBAK7hqFu++gIGS3JW17lCvb/eBg3vxibKr/ZCnXILdQJxPTuhDkCwO+0Nxdb6UDxwH3w5OCGZPaSPiA4a2RYXpnZ6I+LOK2XmJ+YQCMr7KH0Kg3uYs/WeuTFp7OTRo6k48bbuijoR3QWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4y9tUjt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso3053049a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708949131; x=1709553931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu6KL11qTKrcmMChj9XCg4X5h9VHj+gjehFCETsIZJQ=;
        b=Z4y9tUjt7ohJQYO3q8q5owmyL+u/rsU9NrIudtJuJhp4JGifSP7h0/3o06Ge52jDbW
         h12eilqDZmKtvHHVbjkqK1LktdAkanPSUEjJwKNMfEB1Z9bDgn9UuHyyecSfnDXveDk7
         tj6JfF4/VCkXdmXXQ9FcUGbiD7j8P9QlVCpxzTXssF35bDTDustYJetNBspyy++MiZ2T
         Ziq8YUy43o46rQ30M4BkUQH+Cf8Kc22rRrjGs0ISjUNoKvmtupCdp+/BOlW1jXy3Cnvy
         L2qvJJ+1DCBFcAgV3c4r0ASe5Ba/E7+dlSSdH0uVH5US5iz/dOMXpOv//PHVLSaE3ny0
         N/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708949131; x=1709553931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu6KL11qTKrcmMChj9XCg4X5h9VHj+gjehFCETsIZJQ=;
        b=dVA6syokLqjoKo1++OpqdENgbmldzFIrMftGTiSepr3I/fZpjTTRs8lduXS4Op5v/X
         X/Yz1+S6gKbSHj1XW1/l9bJA/WomyCKf9qwp+izwcfEoWIH5hVCQVXKDyhh7y6SWJFrV
         1xC+4BB6pcWNLySOYHOed662own+bQTjBjbSWMv3yDTouw5OwtWQ3bg082r+Il+U0LgT
         83cuEbAbd9U/152NFtvpbddqPCXGIMDDVNtHYsmsuFlLDO0dkA8y58nj3NegATG5LmkM
         GwrzO/9Mi6ZDKPTyAWRba6iE47Hsu+MvwvfqHgY16573Xs3dnFDkUtTgAEsztzSdHLeY
         kCtA==
X-Forwarded-Encrypted: i=1; AJvYcCWnXh/6ZDCu3b0aRc18IC5vweOvP22EPEceJQsQsHXDSxliCfziiIuSlfcK4DI1FbedLcf3eGkIwPcfKeyPzVEPAPIabaEspGLIwaB0
X-Gm-Message-State: AOJu0Yy7ts/gykPp2spijqT70H7e3reMfTdxaI02sOjWgUniU6tpPGST
	CxyLnkrI+JIwqccAQALpM1tjR38fBcXIQEmzOQVNhIonamdOdCnb10JUNaRZi/eY187zi0rXG7m
	Wtv4suye3wfazmVIYNXwfirBuKkwge3OB/DhMVA==
X-Google-Smtp-Source: AGHT+IHmfjaGpQl0WdulrJo6xIdeIlMXBi5NQiG4QYx3lDG+bwg4WfzJO0SpEobO9IMKBdAxql4xZmiVPncCQOQXODs=
X-Received: by 2002:a17:906:1949:b0:a43:3b2:bcf9 with SMTP id
 b9-20020a170906194900b00a4303b2bcf9mr3251769eje.5.1708949130946; Mon, 26 Feb
 2024 04:05:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226075225.44881-1-meir6264@gmail.com> <96ab1a91-7682-4aed-a522-ceaed0dbf56c@moroto.mountain>
In-Reply-To: <96ab1a91-7682-4aed-a522-ceaed0dbf56c@moroto.mountain>
From: meir elisha <meir6264@gmail.com>
Date: Mon, 26 Feb 2024 14:05:19 +0200
Message-ID: <CAHdEp89HhwiBuQEqTP8nTTy0VPrLr5PKWi8mKLx6wFzeTb9eXw@mail.gmail.com>
Subject: Re: [PATCH v3] Staging: rtl8723bs: Remove spaces before tabs in rtw_set_auth
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Ruan Jinjie <ruanjinjie@huawei.com>, Yang Yingliang <yangyingliang@huawei.com>, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan

Thanks for the response.
Not sure I got the problem here.
In V2 I removed spaces and deleted dead code. In V3 I just removed
spaces after tabs (reverting the dead code changes).
I'll want to create a seperate patch for the dead code deletion later on.
What am I missing here?

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 26 =D7=91=D7=A4=D7=91=D7=A8=D7=B3 2024 =D7=91-12:23 =D7=9E=D7=90=D7=AA=
 =E2=80=AADan Carpenter=E2=80=AC=E2=80=8F
<=E2=80=AAdan.carpenter@linaro.org=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Mon, Feb 26, 2024 at 09:52:25AM +0200, Meir Elisha wrote:
> > Remove spaces before tabs to improve coding style.
> >
> > Signed-off-by: Meir Elisha <meir6264@gmail.com>
> > ---
> > Changes in v3: subject and description changed, revert dead code change=
s
> > Changes in v2: remove dead code
> >
>
> Sorry that I was not clear.  This needs to be split into two patches:
> [patch 1] delete dead code
> [patch 2] remove spaces before tabs
>
> regards,
> dan carpenter
>

