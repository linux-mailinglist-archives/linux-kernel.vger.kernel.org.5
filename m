Return-Path: <linux-kernel+bounces-22493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4C6829E90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C775B26A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9374CB42;
	Wed, 10 Jan 2024 16:26:11 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681F2EAF3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cca8eb0509so49883301fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704903967; x=1705508767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfvoYtYkbzDXHtGRwOM1QCrlo2eljFi0z5edX71eLKY=;
        b=cqKrdW5wOl/JzHhQZcUEUSFOvoLXi2Xgnmiw6YnMkuGN2wBy+I8mWIoaOZ5FG7fo4D
         zmSDEGTkPb27ysNDXIcwhOM9kVv4DWZsOd4sLhiW3mWv0Geylwi/gySWJ3Leyrp4xvRQ
         DvVGZ/wLlUzwGaWuj80LDjTAabJqAwequ/ntClc1MjWdfDSiWS6eK4/aEqs2fCA/NTUt
         tqJwq8fxsfD/MCX8KC6b45sUPF5YV8lOqH+dWzIiWlPjH7+N6i166rW4fJP1xn3farfI
         B19XxupcLdVLrVwxFQa6iAg86YCh+cvp2WZz9RNDg1aLcyEdvmEB/ydIRfSSxKTu5l9h
         G2OA==
X-Gm-Message-State: AOJu0YzjpcA8Ipe9Gz9h6Dv7TfvDHE2K29YkT4wTyBMzOyQJrRfvtJZZ
	0zU1YJ9FOMHJJjffuy9oW7cAj3oOmPxQYg==
X-Google-Smtp-Source: AGHT+IEVs+xyVwt4UQS24B8oQO5lqQufVl+ayFFGyT6H6lzcZdBuuN6yfFhOXTcFgmrdfJA4P3zbrg==
X-Received: by 2002:a19:f601:0:b0:50e:7cbf:ac9d with SMTP id x1-20020a19f601000000b0050e7cbfac9dmr483958lfe.127.1704903966818;
        Wed, 10 Jan 2024 08:26:06 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id d1-20020a056512368100b0050ea285c47bsm694601lfs.64.2024.01.10.08.26.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 08:26:06 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e7b273352so4538130e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:26:06 -0800 (PST)
X-Received: by 2002:a05:6512:b92:b0:50e:7bed:3e9a with SMTP id
 b18-20020a0565120b9200b0050e7bed3e9amr734101lfv.28.1704903966413; Wed, 10 Jan
 2024 08:26:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <938ebce3-74c5-4fcf-9de3-849271d3581d@kernel.org>
 <20240110130456.142763-1-neal@gompa.dev> <20240110155233.GA623732@nvidia.com>
In-Reply-To: <20240110155233.GA623732@nvidia.com>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 10 Jan 2024 11:25:29 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_P6-3PWNxM4HCzcgM=H4Y1vmywaM3gbwK0gAe0UVoZGw@mail.gmail.com>
Message-ID: <CAEg-Je_P6-3PWNxM4HCzcgM=H4Y1vmywaM3gbwK0gAe0UVoZGw@mail.gmail.com>
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: jirislaby@kernel.org, dhowells@redhat.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, pinskia@gmail.com, kent.overstreet@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:52=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Wed, Jan 10, 2024 at 08:04:53AM -0500, Neal Gompa wrote:
> > Hey all,
> >
> > I would like to speak in support of this too. It is not uncommon
> > to see operating systems code written in C++ (notable examples are
> > Haiku OS, Serenity OS, and Zircon/Fuschia) and I do feel that there
> > are benefits to C++ for Linux code. Modern C++ (such as C++14 and
> > newer), offers a lot of nice base language features that can make
> > some of the kind of stuff that Linux does easier (as H. Peter Anvin
> > has detailed in his post[1]).
>
> Me too. If we are serious considering Rust I think C++20 deserves a
> fair shake as well. Especially since I heard the C++ working group is
> apparently looking at future C++ extensions for Rust-esque memory
> safety these days.
>
> I personally think the kernel community would have an easier and more
> incremental time swallowing C++ than it would Rust, and C++17 is
> already mature with fully working stable compilers. In particular I
> feel someone familiar with C would have a easier ramp up to some
> imagined "kernel C++20 subset" than to Rust.
>
> Further, I feell that having a single base line of "all code compiles
> in a C++20 compiler" and localized variations of what idiomatic style
> and features different parts use would be ultimately more maintainable
> than intermixing C and Rust togther.
>
> I've also got a fair bit of experience with C++17 and I would add to
> HPA's note that the modern idiomatic usage of C++17 is *way* different
> than older versions. If someone was traumatized by early 2000's or
> 1990's C++ then it is not entirely fair to carry that to modern
> C++17. Especially when combined with a modern environment with
> something like clangd to help grok the code. (Though SFINAE is still
> an inscrutable terror)
>


For what it's worth, I'm totally in favor of C++20 as well. I've
mostly written C++17 as of late and it is really nice to me, but I'm
genuinely excited about C++20 and newer revisions.

I also think that Linux adopting C++ and intentionally adopting safety
features that exist and are being added to C++ over time would also
further encourage the ecosystem to use them as well as make the Linux
codebase much easier to work with.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

