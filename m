Return-Path: <linux-kernel+bounces-164187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB68B7A68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C67286FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80681152799;
	Tue, 30 Apr 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md9DlZ6f"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200B3C482;
	Tue, 30 Apr 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488165; cv=none; b=DgNnvw9aw9mlC3FKfA38TUO/EXzDIUMzVxgHvhWZ2uORVBoR/KMBT3jm9oPtpT7W/Jl4IaYwyuXuIVnGNCSJccgYTuRLH3RhZR4zRyepE0QRWD1d55dei9eqFp4oi3VvJhqrk4O8kYI2Zxv6Whp9aix4Th4jZRfFkfrRfIqOqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488165; c=relaxed/simple;
	bh=h8/Mbp6p56Npf/fPA4rJY97puUbrdQSR9GWsAJfrmSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmv5z2pIZQbV1gnvf8M1snLPET5VuSwh/3F8y2nGwZ75ex7DIyEXaBBXorRCrw3v+KY1miFuEsKr2rkqb5jecmWXOO+hIDw9bdmoQI7dfSTe1RFEd+NTmNsnQRfMWoAx3XqFfK/dslmUG+P3XmF6TXsDaPZb4KhkTPzEueQsLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md9DlZ6f; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5acdbfa6e95so1367577eaf.3;
        Tue, 30 Apr 2024 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714488163; x=1715092963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ga3LR4xPWZc/MiF0Ow7nqK5yfqhw78RS6dhFYPGNBmw=;
        b=Md9DlZ6fDioEjZCy1WvEbZ0LsJ55Ib5VJSrCp2k+Ki88le8dVXNDQTFTt7HQhNpW9B
         H02X+JeM4ISMSONd46UTguMbRG5RTKRVYnn+StU98iKGMAZQ75Cnw3EGZ50lIPDYPjlq
         /vNJpLKLAJM41RrJefwwBQMAgcEyMlrSVZ2LKy/qUGWEbb5Z0jsCIF79tyGc9vhFSQaX
         kASvdDOVWvCd9pivKPrSAUSSONl/X1XQxrmtlA5PavoB9PFrzyvR8k5Wi7lf40OlmfVm
         5gS5G4whUnnOB2m1ho3y9Qa4hySyhFXw2UD9Q6Er4zzpCLIz+IYRJ7OebbtitTeMDKll
         uSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714488163; x=1715092963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ga3LR4xPWZc/MiF0Ow7nqK5yfqhw78RS6dhFYPGNBmw=;
        b=jCLFCjizCdWlsU6AUHIehbiQcO30EA1vXO7WwBEoWNUO/gBzYnCiVWQ0+nyvueMFlS
         te5qmxSVFt64EkZyd77HogkbCCjqRQniIBVA6A+Ye5SHtK+jygNYxSHQTAByyseROoNZ
         mJ8vegjWftW4DTq62TCg5DGG5rrC/by+0AfMuNa68gXX2pK2OSvO82EnLKazhoQIW9uc
         CHbw5SAO3PCa9n2ukroXpcAiNTn8LSDkqdEYOt6AsIp/ixsyV3KN00j+lwzKtHcTEZ/k
         +cx5uDLUxbLKbsyIQLcdXN5Bs2pf6p6xWNOvaiK4hNCNuSPCPAMB6c0YsEWSWNGrnHwH
         U1VA==
X-Forwarded-Encrypted: i=1; AJvYcCVINyy4x/SkB4wojismK+tUQw8sT9KejmqO3jdlODj9eIvMX34viZlZnNI30KzD8IyjnJFT4uT6NtBCrEerk0DvhocRDCm8EB1c+Hs=
X-Gm-Message-State: AOJu0YzCtmTbQzoCDVV2V+7gYlijvTqD8CsUx+8nSBOUxUX1lTOTKh2b
	AaCLjXheErYb5AdUMp2NQF25g0B70H96/gkf1YoacHzeqIuhMz2GAlzLp7/NjilF7IFP7GSOyPQ
	piopXRkIjQi/qNejaQVf9Pl78OLYD4oBsJ3Rnxao9
X-Google-Smtp-Source: AGHT+IED4pFtujpp/uBmJH/iT/20/N0UlzyDZ/+EznoMEnNAjS32v8MY8tGs9rC94Y1N1nK6dj/SmEIm9kr6BcdTZuQ=
X-Received: by 2002:a05:6808:1a26:b0:3c8:4b12:107b with SMTP id
 bk38-20020a0568081a2600b003c84b12107bmr16414645oib.2.1714488163160; Tue, 30
 Apr 2024 07:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNmEtrN9DK-XmESaPm_1xpXm8A+juE+44Jf6AK5JE0+TQ@mail.gmail.com>
 <874jcl7e83.wl-tiwai@suse.de> <CABXGCsMmRFW3EYJ3UvNd-LO7ZTOyoNqjc_3OAmaCDSL=LuxJqg@mail.gmail.com>
 <87v851e2di.wl-tiwai@suse.de> <CABXGCsNMBRUaY-V8mhUQKdq+CQW5+eGUWL_YCJWXo0cgh9bGJQ@mail.gmail.com>
 <87h6glt9zc.wl-tiwai@suse.de> <CABXGCsMcazRvmiN4XtiHQCE9=dB=M=VsRqB=v+RPmtuhBL29DA@mail.gmail.com>
 <a6f4e20ea2a68f56a7d2c4d76280bca44d6bf421.camel@gmail.com>
 <CABXGCsPdqfXeZUw1ocx8O3NdOEb+h4yQ77+zdNpcwP_4JrYXuQ@mail.gmail.com>
 <CABXGCsMTbmU4CP8CHUqRVXWkGiErFtEVG4COy6RSRWsAuK_-CQ@mail.gmail.com>
 <87pluedgx5.wl-tiwai@suse.de> <87jzkmdghh.wl-tiwai@suse.de>
 <CABXGCsP-e5CjqCFztiym=zjQ=Z00uxYcQPFACEbTwjV=BHEdJQ@mail.gmail.com>
 <87jzkfo0ty.wl-tiwai@suse.de> <CABXGCsMPLWm8xVZ3mk-e8FJht4FjdxEREov0DFKMooMD0BvRyw@mail.gmail.com>
 <87r0enm4m0.wl-tiwai@suse.de>
In-Reply-To: <87r0enm4m0.wl-tiwai@suse.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 30 Apr 2024 19:42:32 +0500
Message-ID: <CABXGCsOxkM+ohzudsTg=e5x=UATArAx0zCLnGHFwHHXs9Rz6VA@mail.gmail.com>
Subject: Re: regression/bisected/6.9 commit 587d67fd929ad89801bcc429675bda90d53f6592
 decrease 30% of gaming performance
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 5:12=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
> Where and how...?  That important piece is missing in you info...
> And, it's likely a false-positive detection by lockdep.
>
> When you disable lockdep, does it still show any performance down?

Of course without "lockdep" performance is even better than the commit
587d67fd929a just reverted.
- mainline kernel without changes with lockdep - 13244 [1]
- mainline kernel with reverted 587d67fd929a with lockdep - 19218 [2]
- mainline kernel without changes without lockdep - 22440 [3]

I think I get what you're saying: after a false-positive detection,
lockdep is partially disabled. Yes?
How do I understand that lockdep has partially turned off?
I would expect to see such a message in the kernel log " INFO: lockdep
is turned off."
But in my case this message didn't appear.
In any case, sorry for wasting your time.

[1] https://postimg.cc/G4NPHMyk
[2] https://postimg.cc/1n0D7sYH
[3] https://postimg.cc/nMYHWRcF

--=20
Best Regards,
Mike Gavrilov.

