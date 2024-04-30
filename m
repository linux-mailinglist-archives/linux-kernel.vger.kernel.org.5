Return-Path: <linux-kernel+bounces-164138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89B08B79A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485F928696D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C650317BB26;
	Tue, 30 Apr 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUp7ugBJ"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6317B51F;
	Tue, 30 Apr 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487213; cv=none; b=XAemE22s6yXtzGs/zv/fIobhbR3iAzkfomImN8s+vVHFyZHfuiVRpYaE6hQF7+34QoDzjf/hDscPZuZ6ZyKOp3BPHgfbNCCuPGEZhjF6TugqyrfV2YlfYLBPk4q/fVhzykO4GqRvSniOC7SQNaqg1Lu1PA7w8PCMn4VRltwwa4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487213; c=relaxed/simple;
	bh=YHCQtjphXshwVqzUSAjOkDLpjpy5GbeBEQC3/9BHAXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PumrwMFJhLWxxG1F22huZHL2N3eBiriYrOFNTvlEWD2Jf72Gj7Z67w5owV5jEm8VRz62mVd+sTOl8rXOzV8g9SVtDWBWbBsCCrFZsxn8w1IYw+VEMaOfvZ19aAtQPeTO2eFwlsooeMFzRnuV+88NMlSWHNsUCxB85FpMbgewN0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUp7ugBJ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6eb6b9e1808so2699399a34.3;
        Tue, 30 Apr 2024 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714487210; x=1715092010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8khSCxXJCwi9khL8crRhkrXjbgJsoFGy/y55ZpSA9U=;
        b=OUp7ugBJaSP8os3B2+84lyE+eZLrMAqjTSXOd7UEweoWbbQfd3Hm0hTw0nLSU7+Tyk
         XDxrgq2hg3xghYNv46ur/K9Ok2yB1RvQcPa0ZKVZMwYMz4/pZJZuwBVm/3Zx+IzM/cI+
         2QOYBPbd4QfpdiIdBuy7gLsHuofI2ej+7YIf+vDZwmNrH7MWyhjAdlNRcQgTZzOpal1R
         fNNAwx3Hhrpn3StJSwCTK35a1bovo/iKBHDL3v/Fw8EpJ2/w0qnK3AjWPG0+thp7pZeN
         bvdNu/Y/rdlaBkdzzqvbJ9NAptpjRh2e818k3SWSVfCLzESyFZ9I5UA6YWwORuBnBJTF
         W+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714487210; x=1715092010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8khSCxXJCwi9khL8crRhkrXjbgJsoFGy/y55ZpSA9U=;
        b=sOOM83u98L7ExInXRjW5ZODGYg1Pb63BWmm69+Ow8WwchZ+mYXecISC/gIVB0ZMnDK
         5UKgvcooex5G9+2z5rLV+nJRcW2Z+F9OLasq4a64bW1gskV4MRLL0ui35wb+8AKd63jy
         qDizCwR9ZsFKwW9aoyf7PiosCgrS23UAf+F7Vswi+eHd7DzJyCYMoS+dKQ3Ez1Mo4oAk
         Tg2XYTVkICJa9hikm+st3UTdhcd6BmaKxEv9Tv85t0SDNFI0l0p3IUzpfmrBc6R8gFhE
         JLv2p+sjBD1m4XJ/MCSn5ggNmu+L0/7Q2+jLK0HneCGuEG3o78dW88NAkYb5gQmuGVfy
         4m9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeA/s8gSZaNz4jYsI5NMNTbcD6iBp6klVeW0+5ipx5Zp2opXkqa5nq0hpjESkXXjdUkdakzKf0KYE3UGn0ix6Xo7kcRyjwAT6/+aRepBRWTOLIpWmCM8/5ByToC98yA9Jdh717QfUy
X-Gm-Message-State: AOJu0YwCJhqqmFi82tZAEGZ/9KT1K98/iApFtixtTjLqSngqJqDjz2QH
	dh21a/i4mbeCRcUyIZRP+QQ0xX8o1B+MAXUlQ7HNkhHBsMoeNoNsgmpGygpcoXUkN8ZI75HNeFJ
	10VniXNUiKmEXuyIhLzTbn+qWPT7bqg==
X-Google-Smtp-Source: AGHT+IH9x0LG2biuI13dWDJBzAICvj25gjg6iNMjcBSP/8vXYZmMMiKm8HjOEkEslMfStmh69O4cVv79dJWr5R/mIyA=
X-Received: by 2002:a9d:7502:0:b0:6ee:21cc:ac91 with SMTP id
 r2-20020a9d7502000000b006ee21ccac91mr7492491otk.32.1714487210673; Tue, 30 Apr
 2024 07:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430131330.1555849-1-marc.ferland@sonatest.com> <20240430145935.0000055d@Huawei.com>
In-Reply-To: <20240430145935.0000055d@Huawei.com>
From: Marc Ferland <marc.ferland@gmail.com>
Date: Tue, 30 Apr 2024 10:26:38 -0400
Message-ID: <CAMRMzCBva+o5Mgkxue5F3o5AnAokDAXMhCNXqacPOPTGWwisCQ@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5592r: fix temperature scale
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marc Ferland <marc.ferland@sonatest.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 9:59=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 30 Apr 2024 09:13:30 -0400
> marc.ferland@gmail.com wrote:
>
> > From: Marc Ferland <marc.ferland@sonatest.com>
> >
> > For temperature readings, the remainder is returned as nano Celsius
> > _but_ we mark it as IIO_VAL_INT_PLUS_MICRO. This results in incorrect
> > temperature reporting through hwmon for example. I have a board here
> > which reports the following when running 'sensors':
> >
> > iio_hwmon-isa-0000
> > Adapter: ISA adapter
> > temp1:        +93.3=C2=B0C
> >
> > With the patch applied, it returns the correct temperature:
> >
> > iio_hwmon-isa-0000
> > Adapter: ISA adapter
> > temp1:        +30.5=C2=B0C
> >
> > Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
>
> IIO temperature units are milli celcius, so I'm not following
> the argument here.  The driver might be reporting in pico celcius
> I suppose?  Call out that this is the scale factor though, so
> it corresponds to 1LSB hence a small number is certainly plausible..
>
> Reasonable to argue it's taking the integer and dividing by 10^9 hence
> INT_PLUS_NANO is the right answer, but it isn't nano celsius.
>

Oups! you're obviously right. I'll update my commit message and resend.
Marc

