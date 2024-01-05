Return-Path: <linux-kernel+bounces-17353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB353824C2A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF54B22F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F011102;
	Fri,  5 Jan 2024 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ernErT6u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8248C1FA5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 00:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-556ea884968so1247714a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 16:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704414808; x=1705019608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jW3PYuiGpDI9Y46QXBSVasJWKk1a/5VUlFNdiuTF92c=;
        b=ernErT6usSQRpmdsB80aw7LSVXlUr1RFLRLbmZLGyq9qYDV2huWTEHCJ8OkPclNIBx
         1YmDlOUI+FIQ8Fsui7htTWqKaFbP6rm7ww1LRcMQTRdE99lClYmxiSL7wOofxV6jvgBe
         GP3CsM95Lq/z1lXynVyNRL6SZbO3ElSmiah48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704414808; x=1705019608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jW3PYuiGpDI9Y46QXBSVasJWKk1a/5VUlFNdiuTF92c=;
        b=ZiRis2YZzBZRh+2ElvHYX8+IZKzp2H8RcGIFg/4f4UA0ZZ68dPHub/AS4JYhlfCTBM
         K3nrXgjiDoC4g2gH5SKn+FKcvQ95C982i4mU6uYizR8p4HpQzeFG+ehEFsgmoA5gdIVr
         9uqpCBGbYS0o4LkeRv0KETHngrm6V05w1l4UjxC72yKdtzA5lgurvDPBcW2JUvdxH+bU
         wJbac8TSNmmmMAALYxu3heww/70jTdcWfDwcKLHFg7C3ynBmNxtFiea2u6LtummYkjNW
         p09vBHeVIRVgPCK8mKVK84b1MqzhCVbgQgHDmNTRYV0+jpLyDZemrwCb7XyopGjbecwl
         Tj9w==
X-Gm-Message-State: AOJu0YyB5X05tSJ15m82yr8lz0ojeWPyf1+qIzu74eLhy42CR77wGdkh
	ALRawFqhZoxAfMw9n1RZvWDfXF8V5hvdUA6993pSPquIe5DRHCqF
X-Google-Smtp-Source: AGHT+IGPEVi1HTAtZWPjKcKETXABQIBwbsc/O6jvwyxQ4WSQGv3cRS/3vgsVYLuWu5kHrs2dtSpA5Q==
X-Received: by 2002:aa7:d306:0:b0:540:4c04:ab94 with SMTP id p6-20020aa7d306000000b005404c04ab94mr773299edq.42.1704414808696;
        Thu, 04 Jan 2024 16:33:28 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id d8-20020a50fb08000000b0055350d989dasm285657edq.88.2024.01.04.16.33.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 16:33:28 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28005f9b9cso122455366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 16:33:27 -0800 (PST)
X-Received: by 2002:a17:906:489a:b0:a27:7da8:aaee with SMTP id
 v26-20020a170906489a00b00a277da8aaeemr676587ejq.12.1704414807557; Thu, 04 Jan
 2024 16:33:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com>
 <202309231130.ZI5MdlDc-lkp@intel.com> <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
 <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com> <CAFUsyfL0M5P4+4s_b1kvJ_fE-ax8YBK0ammbKfoy7yKs1obzrA@mail.gmail.com>
 <CAFUsyfJduB29c6=BNmTtgoWcHAWA1AZ-sdbhyp02JVhvA6Gp0w@mail.gmail.com>
 <CAFUsyfLuo0_Sm91mqbM8Sbo-ncwnM4RaRq=GxQXDmkAN-nQ3uw@mail.gmail.com> <CAHk-=wgv6h4ru=z8UR5XyutoRKveOetNpwovHburvRgG9NSa3g@mail.gmail.com>
In-Reply-To: <CAHk-=wgv6h4ru=z8UR5XyutoRKveOetNpwovHburvRgG9NSa3g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jan 2024 16:33:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNUucmvTKGmveWzXXe99SpOwU65nFtH-A2_aUpPsAPJQ@mail.gmail.com>
Message-ID: <CAHk-=wiNUucmvTKGmveWzXXe99SpOwU65nFtH-A2_aUpPsAPJQ@mail.gmail.com>
Subject: Re: x86/csum: Remove unnecessary odd handling
To: Noah Goldstein <goldstein.w.n@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, kernel test robot <lkp@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, 
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 15:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, since I looked at the thing originally, and feel like I know
> the x86 side and understand the strange IP csum too, I just applied it
> directly.

I ended up just applying my 40-byte cleanup thing too that I've been
keeping in my own tree since posting it (as the "Silly csum
improvement. Maybe" patch).

I've been running it on my own machine since last June, and I finally
even enabled the csum KUnit test just to double-check it.

               Linus

