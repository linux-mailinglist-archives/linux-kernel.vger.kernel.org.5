Return-Path: <linux-kernel+bounces-97773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC379876F39
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF66282360
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A299262B6;
	Sat,  9 Mar 2024 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0BDGP7h"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2E18E01;
	Sat,  9 Mar 2024 04:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709960221; cv=none; b=AMrgLPPo2tLc2oZWkSIAFrn2ry6r56bBFQT30eCaxbWHSaNwPq9lqvmDMwUn6mAPUvBDFVNfZRj4XQBq6Ab3ACTw7Fbft/LPaZAFeW7oRRmBZbzv20VbZjsaMe9dalgCaeb5I08h6oVzlKsnT4a8E52duxzuTzRjLm659MVdbQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709960221; c=relaxed/simple;
	bh=d9fTii0v4jXPGCNKSpMW3BW0Oh5wmwA6rFnVlNFT3pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4ZwZoT6Co1V0Gq/xL0N4d6MM/h6rSBjkOENMune7VxuYOZRA+aMtAVpUZNucfkh+bae3TFmBmY+UKtZRPxFDlQ54PEBNhkEAlwUAMEW8j0buM2R7kF3mSnJT6aynngOBSTTjrvChto2FMLJ5iCUbuO5Pjqcs1cfVzlfcdOGPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0BDGP7h; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7db68ed7bb1so1137835241.2;
        Fri, 08 Mar 2024 20:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709960219; x=1710565019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osWZlmBqOmSJdGGGdtztOJyldzmIVm2zqkCVbfLVzA4=;
        b=Y0BDGP7hly6pdJxinZ9Eg/P4glR44Lh+cTKlhzN6yDZ7o6LNWBfjcEXaX9Gv04S08r
         yErCS3zipI4VNQTCeUnWyvJBqj8FgrTOope4lK5DRYek2hO0RsnZZQEmmGXuQs+ZpqKr
         49DmnE4vToWixOSm3vO1c89prU0DFASx4bXhNxdzFOWwvMcv7fvb5Df0YpcjThOc6AXi
         5kcy2vu58einN5/qGlb734ONbAlajL6zfpt2ySVfjMEXPt00MWDgTfy9w7z8tAMIWwfh
         MURUyyJNbN9yNQhV2XHAq1b00IqU1jD1ZnbENXgQMd9DBN0znjd1x+d+JI98l/PRq5Ad
         IrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709960219; x=1710565019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osWZlmBqOmSJdGGGdtztOJyldzmIVm2zqkCVbfLVzA4=;
        b=i50NRCPwgPsUsqzFUu1zaA1WIbFRYlTCO3S1PW6aIjNrS6RzfhvMbe47AjMVF3ZXkp
         nAjFK1MHKOcbertz1/tqZbsCF9QeAXH+X0ftmlxPk9X8d/w+eYAycU5AmFWZC3OEoly8
         TtPfG+2it6wGyrmecTwZYENLlOkxNBEKsJVnsaZM1a4C14d+kO+hIfqvVMcNn0ZHLSsM
         /J+2CqU78NFUwb5MdbJHxhOCs3E5J41j0TjfvTRCMaL9BAPBXF3TeZ6RIPU0G/o8obWw
         VNVXRJ7+LfbW+tNItfhxnJlzz15m5ENyhGC+HOx9puGrIhEoHTsXBqhRjE1MMfDd2Ibj
         934Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKj19/udj3dTtNBjCn4vAM0fVlTBTy30v5YlRT+9APqBpOy/ReYf8m+SpsFLtuttD/W4ost6Ux3fxHcnfkOHnCq7+mR7FSrQsaqzbgsU0Phdoq4FF3vA1HoRyU0zWktfniqVGuFi7YBKWQ
X-Gm-Message-State: AOJu0YzIgXcTwKyfr/l0+Y/+A0tjdFSJFNMt6txRPtmhfJzO0A5NLKlQ
	EJ0HWtb83PtwLI9EnBkWDA8mmmjAfvwliIVSYA04Dj0b/Wn+JgTxQKuFD5H0di32gbhG74xw00f
	bujFrTw1hJuF8eFouSyFQpvlKxGE=
X-Google-Smtp-Source: AGHT+IEfPvgGnvOmPfBz0ryFMzUkH06078cz1HC6iNd3lI3FsufJVZobQkeMZtVIXfrhk9y3sc87ratO3Pr925fF/94=
X-Received: by 2002:a05:6102:9a1:b0:472:eeb3:5c34 with SMTP id
 f1-20020a05610209a100b00472eeb35c34mr849041vsb.9.1709960218874; Fri, 08 Mar
 2024 20:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222081135.173040-1-21cnbao@gmail.com> <CAGsJ_4wMGNDcgc3pqSUicYoH7Z_miczkT=uwZU+yhDF0fd57Rg@mail.gmail.com>
 <20240308192334.845b27504a663ec8af4f2aad@linux-foundation.org>
 <CAGsJ_4xSwNZmHN5GvipS-1kELX2NBwHxoGE=aG4sekm1LcYVPw@mail.gmail.com>
 <20240308203641.7fbe7e939b3483bd83b9769d@linux-foundation.org> <20240308204251.43d7e518ba95fb4ce22f8d4d@linux-foundation.org>
In-Reply-To: <20240308204251.43d7e518ba95fb4ce22f8d4d@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 9 Mar 2024 12:56:47 +0800
Message-ID: <CAGsJ_4xYUSdEV4N8i3KqNL+dz2kWx3JWgqtMypk0KW539M4SVQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] zswap: remove the memcpy if acomp is not sleepable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: herbert@gondor.apana.org.au, chriscli@google.com, chrisl@kernel.org, 
	ddstreet@ieee.org, linux-kernel@vger.kernel.org, sjenning@redhat.com, 
	vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>, davem@davemloft.net, 
	hannes@cmpxchg.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org, 
	zhouchengming@bytedance.com, nphamcs@gmail.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 12:42=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 8 Mar 2024 20:36:41 -0800 Andrew Morton <akpm@linux-foundation.or=
g> wrote:
>
> > > Okay, I understand. Since this patch improves zswap's performance, I =
wanted
> > > it to be integrated sooner to contribute. However, I'm perfectly will=
ing to
> > > respect your concerns and adhere to the community's best practices.
> > >
> >
> > OK.  I very much doubt if anyone is running those drivers on mm.git, so
> > adding it now isn't likely to hurt.
> >
> > So I'll merge it now and shall aim to get it upstream very late in the
> > next merge window.
>
> Nope.  mm.git won't build without acomp_is_async().
>
> We can merge the zswap patch via the crypto tree.  Acked-by: me.

Herbert Acked the acomp_is_async() patch in v5 instead of picking it up
into crypto:
https://lore.kernel.org/linux-mm/ZdWKz43tTz2XY4ca@gondor.apana.org.au/

>
> Or please just resend the zswap change after 6.9-rc1 is released.
>

Thanks
Barry



Thanks
Barry

