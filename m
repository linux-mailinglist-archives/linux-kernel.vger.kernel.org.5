Return-Path: <linux-kernel+bounces-67833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3102D85719E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B898B20E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B729145B03;
	Thu, 15 Feb 2024 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e47L7sLl"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222612C53A;
	Thu, 15 Feb 2024 23:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708039990; cv=none; b=iQZgea46/aVXiHxiJGbXUWRK7q+s6XWCBlyIilDLYtzDVbbPc65aJ96G4c17q/BCrh4MwFkeAWtrQMeTkBTziY14A5SHN0UzsNbVU0s4Q6c8tyeJusaiq1crV6B/yC0MrPZpayYmeKlOiNkKJX61/7kHDkcZXEG5PA6CepebfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708039990; c=relaxed/simple;
	bh=ogDnkah+1kseDBaMGbqErn7uqANEFp4Tc516iZ0KoSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yv+qsZAm0Y8JKW3OJJ2HGXxNWkvNB+a1yPtDW2JW9ulJj9utMW9zbA5FpAcHyTGAPhlBVWo8vcOUJ1gFxlaANoFoVshP4LlZlPcEiAXgXgTZAH4l+KkbtnXZ5pDE64YvCp++NluccrnbWuwvnEeE4zqI/F5iSCUsf/+A2ZIjDV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e47L7sLl; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5116ec49081so1764622e87.2;
        Thu, 15 Feb 2024 15:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708039985; x=1708644785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daKJLiXz02A2IhuUMvvcuGUrV+LM5fm3TkypFzv3PXc=;
        b=e47L7sLly43p6+pt6AdDawJ2fx6U2VS/X64HxL92mjO0SNMlyuSanb7TAd6LSkj2f4
         IZkkTKyye5QPn1rJz/62IyV5ZL9dTDUzaxMI7b/4MYUV33fremvlaoM36UVYO/nsnB91
         hA3YsuosmKMMbhRJ9JN+roYFk4gzl7vpe8ea1UblL3dTP5z52WWmjm54uHpS0BS8FmF1
         Evphur3aYj1B0ikdxayMKcPNJTuSteM9CtONUij3iwwIydZICt3fmFF+zfqqqdKKyDfV
         ht0QmkPgis4mh35isqNJRDnHAKeaPY4sXIDMUNp8i4PgkMBeA0wD7vU/XFEJHVz/4SiH
         KTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708039985; x=1708644785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daKJLiXz02A2IhuUMvvcuGUrV+LM5fm3TkypFzv3PXc=;
        b=AQGUCCMzmXt11cP9eY+y+raAbyfcF6EkJduX4dcnnF//rO1Jvwge+6JJf+99Mf2GzD
         u+5mEmRiCID9IqciwnO1rCv0+RYhKxHh+tv5uLYyIDQNxuL5BGXhLc0hyqljWnlJTMLY
         eZzsJi7weU16UB5XUhYcOO2Sx3wX6w9ROSfPV7/sgFNcurZdudMdZL+psv5zPdwyv9Kf
         LJs8bE6FKdhecbzHeh8WSjpzCwirP+VXzY93rxMZ7i116JqSeVwWLlhT8DCeiier4Itz
         dQ1hQCrm5WqFNxcm0UyhS4wWQvDSP4VOGG31SobdhOTFIx1HZyEhwtZSh8PNu53K45oU
         OsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxUGpIZkjW3MWd7T/bwtkFmZw82JoyjqxUiFfWLupZN9u3GXqMJlyBjVmP6BYo4qyHFB+CKywHQpuVMJMHzg7BCNA8GvgO/Yx2DCSSAQBuJHM8MYJn5W5mjiU/8SbseXGgCkDf
X-Gm-Message-State: AOJu0Yza3zBAPoJNak0arqtg387BCWKR3ZMvhm0c3hAIuwwkccX91jvF
	gqKI4aiHqSKuGo5vqEfvoGu6OByNsPMeA9LEiofJmvUS3dWpyQw1z3dT6if9tDTuiSQ3edaSZuC
	SIMJN8P8K16HEj26/x0WTKjoa8IKXexr+KrB1BA==
X-Google-Smtp-Source: AGHT+IENE8wf43qBl0Zp/ufGQixz/JdkekROujmuqvnHC8RivAR2m57lA0A1PMlQoGO6fQcrDbwFtrvrszZ9J489ujM=
X-Received: by 2002:a05:6512:200e:b0:512:8dad:2918 with SMTP id
 a14-20020a056512200e00b005128dad2918mr1038613lfb.53.1708039984757; Thu, 15
 Feb 2024 15:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213200900.41722-1-rand.sec96@gmail.com> <20240214170203.5bf20e2d@kernel.org>
In-Reply-To: <20240214170203.5bf20e2d@kernel.org>
From: Rand Deeb <rand.sec96@gmail.com>
Date: Fri, 16 Feb 2024 02:32:54 +0300
Message-ID: <CAN8dotmVcmpqxO0SyPvit20Ny-tU3OMHr0LLoXRQ3bpPTS5WqA@mail.gmail.com>
Subject: Re: [PATCH] dl2k: Fix potential NULL pointer dereference in receive_packet()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, deeb.rand@confident.ru, 
	lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 4:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 13 Feb 2024 23:09:00 +0300 Rand Deeb wrote:
> > +                     if (skb =3D=3D NULL) {
>
> if (!skb) is more common
>
> > +                             np->rx_ring[entry].fraginfo =3D 0;
> > +                             printk (KERN_INFO
> > +                                    "%s: receive_packet: "
> > +                                    "Unable to re-allocate Rx skbuff.#=
%d\n",
> > +                                    dev->name, entry);
>
> no prints on allocation failure, please, there logs will include OOM
> splats already. A counter as suggested by Jake would be better.
> --
> pw-bot: cr

Dear Jakub,
Thank you for your feedback and suggestions.

Regarding your comment on using `(!skb)` instead of `(skb =3D=3D NULL)`, I
understand that `(!skb)` is more common and is also recommended by `
checkpatch.pl`. However, I chose to keep the original code style and logic
to maintain consistency and avoid confusion, especially for other
developers who might be familiar with the existing format. The same
applies to the `printk` statement. In the same function, there is an exact
block of code used; should I fix it too?

