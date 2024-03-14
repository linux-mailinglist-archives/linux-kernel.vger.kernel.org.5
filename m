Return-Path: <linux-kernel+bounces-103141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F0787BB84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F251FB22B05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91B6CDC1;
	Thu, 14 Mar 2024 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF6XUeDt"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7975A0F8;
	Thu, 14 Mar 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413184; cv=none; b=CgQB0QbUEAOn+5516S3eVV2Y7uTHYvbe3k8knqO9wDPoeY6f9BqPv2oTF3+UWd2ElAY37raS4nKAClTw5PCyp/xBt8vJCRt6mRXcnD+/yCrXptZ6sVMMVFU10Du1iF1F1TeVVhBKxfl+65gfx+u3R56cy+3dJHCganEkowwxBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413184; c=relaxed/simple;
	bh=buQnea26j+8dhh6vgk5dGfI3tbGChwwJ0eYVzH6CwK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXgSfVHQ9x05qxkOhi13pOjihlTtEvPXzZNafCK59q7w4YAWyAkH4gfZgJwMCdC/sWTKscN2XXFoZmliZ0tJjtaFLVUAeNYJ3Qb5R186Lqnqln3XDtD5ELqLNC1y0/rmszAbDHjiNTH+UJ55aedRsFp5O3wZbjCzXCJVlg4vMCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF6XUeDt; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513c53ed3d8so1166096e87.3;
        Thu, 14 Mar 2024 03:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710413181; x=1711017981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buQnea26j+8dhh6vgk5dGfI3tbGChwwJ0eYVzH6CwK4=;
        b=KF6XUeDt++qu+gdEmPbPgS1WcAaDC/i5hvMEaIOAPU9dsv8z9g5z4p2kR7YNsWjVH9
         5hV1riqNRanOfCGfDvsV4p6TN0BhU1/8iovbkmlqWlV8kUd0L63jQdeJVM7RmdW+uq9s
         Vz9kzlztHQzI7+WdkkgIOlioM6TygI5eTg1IwbfyCBa6xqU6biGFkBG/HgEnqBehZnN0
         +1Ib488TLu3VNHsDHasslUBTGyk9gtHGnjvQXTWPKV822fN7RyXzeT/POKpg70bfIXzX
         0ZhMdYWAbj6l2cEA5UD/bKMeLkXcwUUkdggxJjKp4yayHVEvV/9ttKVNwo4LoM0JH9sK
         pdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710413181; x=1711017981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buQnea26j+8dhh6vgk5dGfI3tbGChwwJ0eYVzH6CwK4=;
        b=WJSat3xqfx+pESsdUsus9rW3bA33DWpeN3t5mFySRIKOy1PkSf0C3GGkVn15t5bGJn
         OKPctbBwjD5ofEGIpBEm5Z9pUCCe6dUCOj8zuIFJpuHXQrDUkg3tGGzhDYvUc6WzCHAW
         HNM520S6oQ+MfT9J4ktILGXP3PBT+w61OpPi2vAoKlOTuo2gpPZuxhCGxQm17cUy5GTc
         DvdTDFgGozqoLbWmFVQeWSBYpITNaJvhw6Ujt/pLkQ5mWAY2TQs6lTSdJI0vzxIbDTW9
         yuB8kTMkyuWduYYZalBweyd+ZNdV9+fDyL/bw9ndTSZ/6xRf/4Rng4EzWDNfxgMfAH4N
         pFgA==
X-Forwarded-Encrypted: i=1; AJvYcCUBqLymo3o2N6/z2DnwZUnCkXqWH/xctjQz7uCOxxDfHPlG3GpKEWq6sk2lTWSczNuAvMXmhi5GmBdqQ7CVj/pugbGiqcYtKw9ejLyAFz6QzEmc06O6lF/uq+/ZVZYwxiG87g4rwV6auhj9XQ+b
X-Gm-Message-State: AOJu0Yw/V/7iP+RsCxwH7+53pRKxhcseR9PVRs0QE3zLAAwNwT4BcAFr
	+0GODUoZfhokt6HLMNT+YY3HwXCwnGOhA+ZsdVHvtZ2zAyUUmcepDWuzcJuGm+zt3ze2TD5jv+T
	tJOeSFMh+c5HXuqqkBGEuF6Lyrno=
X-Google-Smtp-Source: AGHT+IHGe7qL489UBBQrSWBp+4/FcTTXyNvb4IcbV2nB6rNI2vsN7vBawglg3ZWbzqt8LH8y/i14Ba8kOJ8TZPelQ6E=
X-Received: by 2002:a19:6914:0:b0:513:d101:b965 with SMTP id
 e20-20020a196914000000b00513d101b965mr831706lfc.63.1710413180952; Thu, 14 Mar
 2024 03:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYSPR04MB7084FCAF74B4CFA30D386B698A2A2@TYSPR04MB7084.apcprd04.prod.outlook.com>
 <87cyrxm7ua.ffs@tglx>
In-Reply-To: <87cyrxm7ua.ffs@tglx>
From: Enlin Mu <enlinmu@gmail.com>
Date: Thu, 14 Mar 2024 18:45:54 +0800
Message-ID: <CAAfh-jOu0hG1hfWX9kL_gOXkSLXEVGNkddP-azO=pjNAKsRGhA@mail.gmail.com>
Subject: Re: [PATCH] hrtimer:Add get_hrtimer_cpu_base()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Enlin Mu <enlin.mu@outlook.com>, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=8814=E6=
=97=A5=E5=91=A8=E5=9B=9B 18:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Mar 13 2024 at 05:30, Enlin Mu wrote:
> > From: Enlin Mu <enlin.mu@unisoc.com>
> >
> > On the Arm platform,arch_timer may occur irq strom,
> > By using the next_timer of hrtimer_cpu_base, it is
> > possible to quickly locate abnormal timers.
> > As it is an out of tree modules,the function needs
> > to be exproted.
>
> No. We are not exporting for out of tree code.
Can you explain it?

