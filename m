Return-Path: <linux-kernel+bounces-97316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75648768B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5D1286807
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872EDDD7;
	Fri,  8 Mar 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILvJamj0"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF72107
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916204; cv=none; b=MIgcvqdS50+cBAQ55voyPj9AUtDc0P30p1qN0pgRrX9Nl+F5CcFB+BgGKllHV0HYSzd3MmAVcvCTS2/o2JKSnUIPA7Fpbbxh4h+5+iUu932WLKFZrw9kX43Yjk+t+oG6JVH97Ocet7R4+6e5yF3i1bus1LSADaMReKOxzEnHMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916204; c=relaxed/simple;
	bh=r0ks+X+TrbMq/iO/OYuxGWhhqU2jbzwN9Ibe0O/43vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwhU9KzaJ1o5kR2L8O0ZPXeZzryKGuFO5o7thBzgc/7s2wwP/WUnfjuyWErsOro9AsTWEll2eVedyf+x+fvrymB3P5TAKjb2tOrFuaTZSGR+ypI/jGaBsckjAZR4P6ax3EWEY7kyKHX0janXO+wBd/69W86w7j7OxB4hBiJYGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILvJamj0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56781070f38so5871555a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 08:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709916201; x=1710521001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyLxpmRa9vDZTdfVvWg2aO7vI6t1684BUA4BOk13UCE=;
        b=ILvJamj0UlJSU9HjJJdSKT0C4/QfKmPOUuDvVu7Ztg3sfNcIPAScPPwO7UVS5XHhGz
         Ee4hAgoi91Dn2ycb4q84Xqx6MuDlC7hNZ50E/a8ROg++IxfXmBkamaeRWQvEF8cDuG8X
         nJbVZzeOCF/GeXZXqV+Lpde6lZuSG6Q816X1+Kc9YBoVtwqcqLD6r4LOWvL/cH74EHtH
         TAhhMaRJdKugC9n2SwhlIhXR0q4s+nMCBvhQa+7YK+9KF39VR2WBLrQk9SFtL/lI9r9e
         KCssxtGw2Qq2JUOzbcHCfnaWKGGY1CYAoGUjijiNkFUe2/oeG7NRPcxG+GTzUvcHvC3R
         FNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709916201; x=1710521001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyLxpmRa9vDZTdfVvWg2aO7vI6t1684BUA4BOk13UCE=;
        b=CHMlm1ZUQPwUFnDekihntfJjJywMQ2TRbPVsY6ax2D1I3Vifo4hi8+64w2wIJnyGln
         /koRVVWc7NxlSxyjQ/XIHDQX/g0V+TUOpwkUBkINtYLqfLvTRS2+k/nFqcQfDChsIBkM
         qH4sG5NjczC3aduraZNb38UEPdF4vHdNG2wON2Wbc/0EXkw3OdcbDrvCzx7+IoY6NT+7
         cF3IVmk4l79WXxasMlg3UfjK7GcbdWFlhM4Eedlg4Fr9Gd2CVnEFB3iVAJlLKXs/KFG9
         1rj5a+daMdrIVTCwXzT9E/YjyH3KSYwj8fWp4NBv0p3iRZPrsxockd/4xHpLx73qOPtL
         Vhig==
X-Forwarded-Encrypted: i=1; AJvYcCXcOda1h0jTFVObbAI6UIdmbY+z8h/bDRP4PqCeoSjQDb5we5MXXteCMw1CFucOdF20XalABDPkelC0Y1V6wrlC/gBHKLsvUXAP1XTQ
X-Gm-Message-State: AOJu0YwIO0P0oYp1/T5iccZmz+F7lnDsTNo9nkan0l6S6//D+f8JaxNO
	2Bc9VKnf0Kn8Tmi1X42CD29lq7UOJU/UzXTtiYg5Il4CQuo1lNVLnb6kdrEVYOTg0pRWONmj17S
	+0rC773xtHVJTyHXabRdWK/X2kFU=
X-Google-Smtp-Source: AGHT+IEfeIZXRSqypmb9U/23WbS9AVqjeSavKZ/LF+/nDtBRuH3PxWvbMYSILot6HKmpEAjJZMAW26NHGxMVPhHoPl4=
X-Received: by 2002:a17:907:2495:b0:a45:d7fb:8423 with SMTP id
 zg21-20020a170907249500b00a45d7fb8423mr707357ejb.9.1709916201065; Fri, 08 Mar
 2024 08:43:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308015435.100968-1-brookxu.cn@gmail.com> <20240308144208.GA9194@lst.de>
 <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com> <20240308163100.GA17078@lst.de>
In-Reply-To: <20240308163100.GA17078@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Sat, 9 Mar 2024 00:43:12 +0800
Message-ID: <CADtkEecyqONmjRorKOWzToH9y1SVXf3GXXvg_BHcFZ506mPWkA@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag allocation
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=889=E6=97=A5=
=E5=91=A8=E5=85=AD 00:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Mar 09, 2024 at 12:29:27AM +0800, =E8=AE=B8=E6=98=A5=E5=85=89 wro=
te:
> > This works now, but I donot know whether
> > nvme_alloc_admin_tag_set()/nvme_alloc_io_tag_set()
> > will be suitable for all driver in future, such as driver for apple
> > device not use these two funcs
> > to init tagset (anyway it not use these two macros too), so maybe new
> > driver would use these
> > value in other position.
>
> nvme-apply should realy be converted to use the generic helpers,
> I just need some help from the maintainers.  I'll ping them.
noted, that sounds great.

>
> But I'm fine with just taking this bug fix as-is and clean this up
> later.

Sorry for delay to reply, I found the patch have applied just about 10
minutes ago.
According what you plan to do, I think as-is maybe fine, But anyway if
need, I will
send another patch to cleanup, thanks.

