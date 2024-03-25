Return-Path: <linux-kernel+bounces-117729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA32288B1D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EAB9BA1652
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6066556B6D;
	Mon, 25 Mar 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xeztjbt9"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFCD804;
	Mon, 25 Mar 2024 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391955; cv=none; b=Ps7+oux/UGYOkAcIkitbMwk0YoIVDXEvEBCcXAnYCD87k2BFHy8Y1+cMeSAHDfVqY1UQnFf5sBchmlWW4SyidBpZ5ee/hMRBNKO2/e80GJPp3A8tpyZgyMoibvR4vKZNgNt8NTL9WYYSG1KrFNmhz3Bq+dDegKpmGpGFKqzrMZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391955; c=relaxed/simple;
	bh=nFwzYKXU3PDENa5lkJ8uYCOEicrv86o7Knmj0aH6USo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftfgl/XX7rVojCCUEn8qfSyumKxQUIukVG6MLoKA4owI6AB/le6uemXYGaRQw0XtRIlRcibRKG/XXBZMmA4Hog2LE+bF+p+FiUx+L7K49NcS1844EwHcAgvL7oifyMMDKyvSIqHHR7Z+O6GaeEcDAUd7mN61uNjlBY91illJzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xeztjbt9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso2282993a12.2;
        Mon, 25 Mar 2024 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711391954; x=1711996754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFwzYKXU3PDENa5lkJ8uYCOEicrv86o7Knmj0aH6USo=;
        b=Xeztjbt9zXvodJ7LJUBw6JHuGGYBPcY0ncOAcePTXllfRyIRwUJSMDVyeTbM6wtN9j
         mAeoI+WTa/KSt69WqUlv4Id/DikyyJHh5tvcJZUuLy3+Dbh1tpb1QHyLLlU2F/fJTmR7
         tGbdNdYX4neOLP6AwaXVBZl4TwgqaYG44XTT1t+KF1fDcrcm0E2FSHV8KQdjcknm21XH
         fsKZyBm4jgmMCkE+q4hc3+UXw1jIdr3HrcyyJXusRtoOGVqt33wdzK7YB67srQR0ry1m
         dquGhn8e6Bpi/exEI3FqUpnwMVb1hQC2DhEuk1gijB5y0kjqzOL8IA+RXKGFApk9Wd/o
         c3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391954; x=1711996754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFwzYKXU3PDENa5lkJ8uYCOEicrv86o7Knmj0aH6USo=;
        b=hhc5RDpNVpA3zuN4YfuYYnTIfkJ4LLHq3LnmKrVxUtEohJI36atGS8JQvMIv6vDDCl
         iR06V8GHjMbGksVri3+7YX9RWl9SxHG79FzP9OSaPGp7gHHtAQ/hZ/Bj7zlM0Pvp5hlZ
         ApYzdJudeWqQ0NtBdt+vt47f/Jnds0duBTSyvScV8Grnu2u9Ua5lNGVlERDClVyp1WQL
         DxW7LxbX0/O4YOaNHnCBr6senoJZZkSPANStWCZaY05owCB4rdkd9mwGoLXbFCmKegHi
         fmnp+jk3novLvMbgvuaKAQ2obeyg1eNBwpcs89GCliPqiCuS87+vDW+Dv/vVx5vnx0wX
         iccg==
X-Forwarded-Encrypted: i=1; AJvYcCUnksF/3slnl28iLQv6//2xD1msRdYmDb6LvXETuGWy+xPgaYeLE3nBhIUzt+6lU6ORWtMRSJHoEeK+PneNj9QC4iel1Ww1euWjMfLig5v484ZR+CCieMBTomqyDgJQ/QH1oGTNDO4sUXFEWBr66ZeJoELSnNnb5z+w1vdz9ofdmOASDOSt
X-Gm-Message-State: AOJu0YwPf1vAshEggT89f4wqhCOyxmKqpI2Y1F9UdcCpok5YQx5khQCQ
	jMPtVcXmoxcshJ/UGtRDzYo8SHVVrLOGSvdMNgv7eepXbrkpzAyuTNxO57G9bBhRATQMQDMM7+E
	Rz/u5p9ZhhDvxU1CwbCxT6PmSL8A=
X-Google-Smtp-Source: AGHT+IHB8Kf1FiMvd2QhpeI+M3oeri4uBSNnj55Ko8tFwUgHv4S6Z6z6cTiW6P4RuVTjs9xt/tzUaKUsVOQZ+M6sbfQ=
X-Received: by 2002:a17:90a:16c2:b0:29a:3c70:1525 with SMTP id
 y2-20020a17090a16c200b0029a3c701525mr4879792pje.45.1711391953686; Mon, 25 Mar
 2024 11:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0cdb78b1-7763-4bb6-9582-d70577781e61@tuxedocomputers.com>
 <7228f2c6-fbdd-4e19-b703-103b8535d77d@redhat.com> <730bead8-6e1d-4d21-90d2-4ee73155887a@tuxedocomputers.com>
 <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com> <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
 <1bc6d6f0-a13d-4148-80cb-9c13dec7ed32@redhat.com> <b70b2ea8-abfd-4d41-b336-3e34e5bdb8c6@tuxedocomputers.com>
 <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com> <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
 <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
 <ZdZ2kMASawJ9wdZj@duo.ucw.cz> <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
 <a21f6c49-2c05-4496-965c-a7524ed38634@gmail.com> <825129ea-d389-4c6c-8a23-39f05572e4b4@redhat.com>
 <adbfdf6c-fb59-4fae-a472-17b04dd8a3f6@tuxedocomputers.com>
 <1fb08a74-62c7-4d0c-ba5d-648e23082dcb@tuxedocomputers.com> <aec1d22d-9e59-4dfc-b108-5ba339b0e76a@redhat.com>
In-Reply-To: <aec1d22d-9e59-4dfc-b108-5ba339b0e76a@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 Mar 2024 19:38:46 +0100
Message-ID: <CANiq72kPXsTjzptK7tSC=RygEpWHJHz1-QXuZv8qPHfGLyzrDw@mail.gmail.com>
Subject: Re: In kernel virtual HID devices (was Future handling of complex RGB
 devices on Linux v3)
To: Hans de Goede <hdegoede@redhat.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linux-input@vger.kernel.org, 
	ojeda@kernel.org, linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, 
	Gregor Riepl <onitake@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 3:25=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> +Cc: Bentiss, Jiri

Cc'ing Andy and Geert as well who recently became the
maintainers/reviewers of auxdisplay, in case they are interested in
these threads (one of the initial solutions discussed in a past thread
a while ago was to extend auxdisplay).

Cheers,
Miguel

