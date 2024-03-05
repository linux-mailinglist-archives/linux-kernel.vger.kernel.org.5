Return-Path: <linux-kernel+bounces-92849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557B88726D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769DC1C21579
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2D81AAC4;
	Tue,  5 Mar 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0NkO5z9e"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF9914A89
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664371; cv=none; b=NxQrg/qIeNothBq5ZlQ4Hr9pRojue6TthbAzoO+rdVVRSWwK3qnIuUk5i9Qx+oTZXy/3MYUIOesFBXszkUROG+nFVTGp1Wm/TZygrs3hTtwunzHS8aenaDSlCcnV9iU1IlfV+PsLbbCVjFVu7ON8p9On5hnZPFjKf0sN0/3i+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664371; c=relaxed/simple;
	bh=/LnC5euhEkvi9g1j+7vW5UYkJX4X5vpM3r4mGJPrFEg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buoGO8cAKRoZ8OHbT8RiJJ1Ok06wTXcuBoVFf+hksHI7DDAS5lXYfQVNsL+d7AZ62r2q6lSATmlpVWLDyifxX/L8rwuR86oOc9nTyXkMqUDZIPa1QzdPEQjoXJB4EvR/bcykYP9aP7IgpfAIoNI/n5lOzwKtRq+fc6SiUghaM4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0NkO5z9e; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7db1a21e83fso1847287241.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 10:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709664369; x=1710269169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LnC5euhEkvi9g1j+7vW5UYkJX4X5vpM3r4mGJPrFEg=;
        b=0NkO5z9eHBBB8c4HLJt5KzYl8vzSyf036prTFWY//2W3n6vrC1bXcEHP7YUfpVe0j+
         vKdncZ/RiSFVto+0aObY23X4I0k8/ewTAmgcFCJFx/N5fpupkbLRvt3jaH3ZhT2x6Ayd
         NsZZrySLSbWcmANsr+eWe0eTlAPLOFHOK9rf0pYulzBjQAEiHJpAGffA0ga128aQqc5k
         nqDQrMRlJc04UOEM1lgnEyq/Z3jNqoFykAvw7HLNolCvvoxqcPNFzREJlQd6XorX4RN5
         +ABOC3rSWwtyyPC1wneTbUk0SeTRYcwa/HZVefyCtWK+3+rGCCjrrbFdW1pUtsB95Jhx
         h3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664369; x=1710269169;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LnC5euhEkvi9g1j+7vW5UYkJX4X5vpM3r4mGJPrFEg=;
        b=NEsOi+8vGHBvJ/lNJFOdkOs3kvHYAf+igLj7kE5LQemoa02zrE7xX9uwP4wY/2Ze/z
         oaSyis9ypsb27EvL53A3yxeKBzce0gtQ7atNLMZ55Q3t4AvxYw/ey4JmSI4W3lK2lN/d
         ULoVwyPy1fzLfrqFe1pdLVHSYlkrHvx9skAYaNV0TZU83qV6i7PHkRsJkJr69gzh/unk
         p7Qm7QG1pahUBoxTr+eJy/rQcVzf8mVde6ZFroWBeOBI2W1ZYWVMAr1PNhnl2f9pRqT2
         27lllZJ69GJU3gGPxdDlE7oxEum2OTBc7A05wq/tX5rhkB5DlyAmTkbprYtnSwqW5sfq
         fysw==
X-Forwarded-Encrypted: i=1; AJvYcCWKjs4pKqCFqZ+s2YuXBQPlMZBr39RP3HgfYzdFJ238gwSTtUaTY+b4MZ0Lg4kr8dju0GMAFFlToAsN2LrkYNUsVbM0i2OgSynjpLDo
X-Gm-Message-State: AOJu0YzVs4kOuuNBAePA6ga8veXHDMTmYSp5MkhJ51z1qJcxp2Qn+9cY
	dJ9FeU5qOMI3i39lXK4t7fjb6FV+RU/Z9YlMwK7J3JAzfKx8Qnx38IARQg41DQt/bnVsu2MfY3+
	0TG3wcmLIc9vDl4CFIlWvLzHVxeSpwgNWedFedg==
X-Google-Smtp-Source: AGHT+IF5LNAsCj9uKlcwQ0xjZDOIljAtQYkRhUygWidZvqbCJ3ZfBiva71D6xRf4C+MFbeWe6buOKgtt6R5YNX1ju3A=
X-Received: by 2002:a05:6122:3214:b0:4d3:4aad:22d4 with SMTP id
 ci20-20020a056122321400b004d34aad22d4mr3579962vkb.0.1709664368851; Tue, 05
 Mar 2024 10:46:08 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Mar 2024 10:46:08 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <CAL_JsqJjo1SBcf=ZLi=iunaHiX6Mt5H6wkoPcecnZmiAcAyihw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303104853.31511-1-brgl@bgdev.pl> <CAMuHMdXWdKZjjZc39iXfa6Nohtn+Xm9YvcF+YoRpNzCgeWD8tA@mail.gmail.com>
 <CAL_JsqJjo1SBcf=ZLi=iunaHiX6Mt5H6wkoPcecnZmiAcAyihw@mail.gmail.com>
Date: Tue, 5 Mar 2024 10:46:08 -0800
Message-ID: <CAMRc=McBf8Fbacnxozr+=-7AFQ0EOXbaG+zUhkNEb9g1mihmMw@mail.gmail.com>
Subject: Re: [PATCH] of: make for_each_property_of_node() available to to !OF
To: Rob Herring <robh+dt@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 18:56:04 +0100, Rob Herring <robh+dt@kernel.org> said:
>
> Long term, I want to make struct device_node opaque. So if we really
> want to fix this, I think we'd want to convert this to use an iterator
> function. Though I guess any user would be mucking with struct
> property too, so the whole loop would need to be reworked. So in
> conclusion, don't use for_each_property_of_node(). :) Shrug.
>

I basically just need to get the list of all properties of a node. Even just
names. I'm working on a testing driver that needs to request all GPIOs assigned
to it over DT so it must find all `foo-gpios` properties.

How about:

int of_node_for_each_property(struct device_node *dn, int
(*func)(struct property *, void *), void *data)

as the iterator? You didn't say if you want to make struct property opaque as
well but even then it can be used with provided interfaces.

Bart

