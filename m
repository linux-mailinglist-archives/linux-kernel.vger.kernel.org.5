Return-Path: <linux-kernel+bounces-137474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ADA89E2A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D425B21DEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512A3156F28;
	Tue,  9 Apr 2024 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eu9mbLZo"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF19815699E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687765; cv=none; b=KtQZqZCJW5/hTou4qzMiOkzNNvi8jjCp6usQixzv2EWXV+Ty3kr7SbX6L0rq5Hjf9Sfs0TRy7QWkpr2rSDGSnCEfXiHjBIea7WTt9kyJmr7QeCvz/0402/hxiOFHb/dfkKHoD69J4CpRWAN5Ijn5ggbX+nPD77Vw4hx+ZNBajqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687765; c=relaxed/simple;
	bh=j9TG5GT2bm5f12k0wO1eiofVRp0n6wIqcOXsL0BwkFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXRGxg7tq75h8hQ8/PcayZFZduTtkVPfOaqjdDor7V+LtAcGu/5GU0a0q/zD0NqZ0NeFuw3+yKeaY1F2Q+kxeAdpRGhqfGL3cJAprCIr2cXcn8cxPhl44OCXya9rXGKYX4QKaM/10mH6pSiOd3mFUAVqK1GBwoL+QtayuYutzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eu9mbLZo; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e346224bdso4031465a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712687762; x=1713292562; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HGww5shByoRtigKjyGumtH/aUmzgn4PTucgk8lmHAG0=;
        b=eu9mbLZoZvSWQsaCu6gYkgGbN+Mvw0DxpOr8JzTbS9KUztH0pU667W4foVXT1N8FNe
         RbAjoU7/G7xS3o2i2sLw03iqHEYPHOA1MA/KMaGKAuMTJwzk2ybJOthna/zcqQmtiY76
         HjxnR8nduhHwVynrP6lzpCAvVHBNhuv2DUSa4CCWaAAvasR9sIeTnSLko3Wzh5s4ygd9
         XHl7uKA/LoxSdshRIIvK1QXeCojosWErMOXPBLf3aVh6CDuYmpU/zyO3aYD+8kuSTWed
         0NPLKcAGxTqDRQsfGOTBCp2dHzaEddfoo3MVin2vfFgNEsnUaHligj9Fb87+PfNWVn+J
         p10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712687762; x=1713292562;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGww5shByoRtigKjyGumtH/aUmzgn4PTucgk8lmHAG0=;
        b=EzTvzUsGAO5jzha9TK1yRB7pKmX+WqFBn+3YEeLehWIQYDzm1zh5q32MeqdINVz2dB
         eQLIMWOabaWW5wgoNmnA7t/s9KnZtRoH5OcU6gYSuxg0TESCkzWhdoEVUAvB5n3Fs6O5
         75RDGhNwWb+WSPD69ASPFwa2wDSMA1DTEY5/t01jTQEcK2iYjs3UTnLk4dcQAQyGBcQO
         k3Dw9JglGIGxXXbrqGTHF9VLgFhu26WR+C1Fr8R8i2FWmDqP88gmY8jKIQQ8FJ6Vx+k9
         y4TLcbTTCdfojzi0RQa/baSPKhjREX9wd0nRoRGdSsMSWBTeiYvreEFVGHRzzwULajjh
         AWwg==
X-Forwarded-Encrypted: i=1; AJvYcCWT+hFqRatJB417EJKjFwYXqHNPuIoWm5unwoewJwe/VpFjwbjLbp3QN4nLVrVAzRdQDf2QCyVF7KFPX7EYZmgyJg7xMpn7zJgmxFY/
X-Gm-Message-State: AOJu0YxmZpu1KyJasEA0KWpruJKbaes8ChroGcR4tH9XEqapCUnr08se
	G93HNAHWOeecGu2B+9zcSn8Bp60qgGYen9ojDm1xAh4kAyU4znr42wM6H0dsVQQ=
X-Google-Smtp-Source: AGHT+IFaht7HdhRywiHGuwHdU1xBpV5+E0e6kNNFSowSW+ic2P9pxCzAKkSehDZy1PtHmBeQAY/6EQ==
X-Received: by 2002:a50:cd95:0:b0:56d:c548:6af8 with SMTP id p21-20020a50cd95000000b0056dc5486af8mr243371edi.9.1712687762116;
        Tue, 09 Apr 2024 11:36:02 -0700 (PDT)
Received: from aspen.lan ([95.90.216.199])
        by smtp.gmail.com with ESMTPSA id eo9-20020a056402530900b0056c1380a972sm5450742edb.74.2024.04.09.11.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 11:36:01 -0700 (PDT)
Date: Tue, 9 Apr 2024 19:35:58 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] kdb: replace deprecated strncpy
Message-ID: <20240409183558.GA7510@aspen.lan>
References: <20240405-strncpy-kernel-debug-kdb-kdb_io-c-v2-1-d0bf595ab301@google.com>
 <20240405095144.GB2890893@aspen.lan>
 <CAFhGd8q99emm1SFJSs=L7Pn0A79vCtDHtTD5XUbVCNh=DDadaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8q99emm1SFJSs=L7Pn0A79vCtDHtTD5XUbVCNh=DDadaQ@mail.gmail.com>

On Mon, Apr 08, 2024 at 05:46:42PM -0700, Justin Stitt wrote:
> On Fri, Apr 5, 2024 at 2:51 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > >                       len_tmp = strlen(p_tmp);
> > > -                     strncpy(cp, p_tmp+len, len_tmp-len + 1);
> > > +                     strscpy(cp, p_tmp+len, len_tmp-len + 1);
> >
> > Again, I really don't think the third argument provides the number of
> > characters in the destination buffer.
> >
>
> Right, the third argument is the length of the "remaining" characters
> from the completion point.

Which is not how strscpy() is designed to be used.


> if you type "tes" and press tab then kallsyms_symbol_complete() will
> populate p_tmp with "test". Prior to rendering to the user, @cp points
> to "s", we need to catch the user up and print the rest of the symbol
> name since they've already typed "tes" we only need to print out "t".

I'm more concerned about the case where you fill the buffer entirely
then move the cursor left until you get to the tes and then press Tab.
I think at the point we write too many bytes to cp.


> len_tmp is the length of the entire symbol part as returned by
> kallsyms_symbol_complete() and len is the length of only the
> user-typed symbol. Therefore, the amount of remaining characters to
> print is given by len_tmp-len (and +1 for a NUL-byte).
>
> So, yeah, you're right. This isn't the length of the destination but I
> don't see why we can't use memcpy() (or strscpy()) and have this not
> be considered "broken". The pointer arithmetic checks out.

The problem with substituting strncpy() with memcpy() is that is *not*
obviously wrong... but it could be subtly wrong.

We can see that the person who originally wrote this code made a pretty
serious mistake with strncpy() and the third argument if garbage. It is
therefore important to figure out what the *correct* value for argument
#3 should have been *before* we attempt to replace strncpy() with
anything.

Transforming something we know to be broken without fixing it first
means it is impossible to know if the transformation is correct or not.
Hence the original question, how do we know there is enough space
after cp to store the string?


Daniel.

