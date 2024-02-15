Return-Path: <linux-kernel+bounces-66593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B94855EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BBB1C215B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F962AE93;
	Thu, 15 Feb 2024 10:04:47 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA63DDC4;
	Thu, 15 Feb 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991486; cv=none; b=f+z4Gwx2TQ+nLrR38fWDpiO/2LLtIAHfdaz6Xy5l7Q/mnp0cM2HhfpZzIaRkmG3Gd9Uue0OX5AU8cSwiftIZ8rjUaxy8wmImhZGa2QEz/18pknNaJZ00N/M9pNaqlMa9QJzhuOgjn2j9uC7dceZc7J2LuQT5VnS9TQIzgr1eXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991486; c=relaxed/simple;
	bh=Tyw7+TxvzuXkuWqI7H1uznwnX+VLpb2UjvuGUHJA+M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccf8lAesWZkAqJj8AGVXKbgDT0OYk4MRZsYPnPBDS5J4yJcSBnpcrRb8O9TSAgqyaIpIOsrZmDby5CWKwBFM0iK6+5q8DB8oJ3aMnsn0dyJ8b02OnhTldxDx2xsYtiEQT9Iy148w2Tz2qfC/EHnNInH9Qksf2VxsGf5JlZ+xyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5101cd91017so809185e87.2;
        Thu, 15 Feb 2024 02:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707991481; x=1708596281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCWHRvsaoBCtnbyCZ7UWHWquJ4EWk2cm41O1IK5/ZC4=;
        b=Bd5RSgZAPcojF2qkdynllEIKDPfHlMVYx1STDZGwUwxvn9pQ+hFpswNKyjjDlWwyT9
         bv5mlcfvHbtYs8XRFlHH/y5xabXD3u6PsnC1h8Yot91P9gU50n+1oPpxiUh6i1AJusnl
         h/NoOlax0k3lpaO1yXXM2Hit97ufAKpkyuWO6FDoqfeaXIWZzzFJPR5+poBuOzOkTK8X
         KYv9bQfGI9SOSye9ZdiTb+8cIzO2q/X8ydMaSryzIJD471sFLEtIyD5wJG3Jjv63/wM0
         1yGGZijXk27lypOWuW1wiu4z5lRGafXYKEXUj7zU6+w8tcUQrZvcfzyWLYrXX/t8OJdG
         070g==
X-Forwarded-Encrypted: i=1; AJvYcCXhq4IIFm0jfpCyp6wfL46V0NjqX63QAah1NCvOrxwE8bmSo0Gd5JqW3ZD8FXJcpcL9tezb74fPRqLYRDoTuaVkj1aLWk6qUOmiSSUh
X-Gm-Message-State: AOJu0Yyh7KpQaqC8zijtyw2UGXR4oLj5Y/aCqMWZuUqvWYaHhYY0yzQv
	+qsSxUDCws/zfwOpJ7ljqmet06V8jR9AIrlPkSC+/vqJA8UtjxNPtR/jXZwelMv4nw==
X-Google-Smtp-Source: AGHT+IFcM7dwDEyOnwCgDedn5qjZx1tfO6HDfHPsWJZnt427ZSuyz5yDRNIPwKicUUlgZrKpGvMC4Q==
X-Received: by 2002:ac2:4824:0:b0:511:b44b:8052 with SMTP id 4-20020ac24824000000b00511b44b8052mr866074lft.65.1707991481624;
        Thu, 15 Feb 2024 02:04:41 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u13-20020a05651220cd00b0051172bf4e66sm181939lfr.74.2024.02.15.02.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:04:41 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51181d8f52fso836101e87.3;
        Thu, 15 Feb 2024 02:04:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQRRAlAmgCHlfMCz0xnxdK3uA2FbP4zWAumOCCd06SIFvQmNMzKAEkca5Vch1J3HMgFIVjkat+U11K3/oH4qIgfAM4e3cTJ5WxNHfu
X-Received: by 2002:ac2:4285:0:b0:511:7b2c:dd35 with SMTP id
 m5-20020ac24285000000b005117b2cdd35mr875759lfh.45.1707991480977; Thu, 15 Feb
 2024 02:04:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-7-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:04:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU7OyF1-ZjVGCe2o+G9SWmYu7BSDBxgfNgst=vdhY_TOQ@mail.gmail.com>
Message-ID: <CAMuHMdU7OyF1-ZjVGCe2o+G9SWmYu7BSDBxgfNgst=vdhY_TOQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] auxdisplay: linedisp: Move exported symbols to a namespace
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Avoid unnecessary pollution of the global symbol namespace by
> moving library functions in to a specific namespace and import
> that into the drivers that make use of the functions.
>
> For more info: https://lwn.net/Articles/760045/
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

