Return-Path: <linux-kernel+bounces-19329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62540826B75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25171F22DFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B925013AE2;
	Mon,  8 Jan 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="oFAkI/Ra"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB0134A9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9b2c8e2a4so1646884b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 02:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1704709080; x=1705313880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n+s3i7ULFHDXKn2RzndAY0qvbKNroYnauIf17/cWotw=;
        b=oFAkI/RaHvTEn+Ixmbw7ZRawBLNAtHB6SLIjX0lzeO7/EsTexeDtYmbRRoMQ7LW/9F
         2jYHNXWJBZthxzbE4QekzXbRJPkm3MO0B0PUV8rhJsug2FWIzbAYLsUYDjkTWM2ttXRj
         nrShPAvbjv1N+Cp67khiIl8wY0Z3mM4TZbrbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704709080; x=1705313880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+s3i7ULFHDXKn2RzndAY0qvbKNroYnauIf17/cWotw=;
        b=KXjRcAqQ777/CJPRVmW94lJ+5COHUliUobHCoppTMsRUrN8LjOznSqfIm9xxpVlGh5
         IYNwj9wa8wS4SG07xF2bFOzGSLl8QZexrbxwudF26xtkc7zfq0nk7kNXTgBn3hGVqtvp
         VOJVC8uTMAQz9aJxVgE/YmTQEeOmEbQpoPZt2hxbOnamQxyVqyeLEjr9dwS+VGNUX3hO
         Opv6/BQ+6z9AqdqjuBZ765mh/z+T7HluBiIYVQEkxOHLbSEXKeLlWAnGmX+qbDIz2cOt
         /wMBcjP7F9S0NQIZdUm1guhL2C+1Q7dVhqsO/VwpsZ1Yf40HCH71HkBqOQTxQ/Cc5op9
         iqrQ==
X-Gm-Message-State: AOJu0YyLVVB4rzynyShu8LjkjMNjmT18Zq63kMTmA0XCRSYboT/rU7Lp
	QahK0Q5gkbDAUXAgbp+e6cGVcoaAwDIZo1/7HgjjghY9bMwHrw==
X-Google-Smtp-Source: AGHT+IGyPSfYxH/22q7ASb9c1WAWmZu4q6xeNojRnrTqhB37yGNb8zC6qt7WFB43LtXSHSzRyKHf+vfeNCdNFNxXlmc=
X-Received: by 2002:a05:6a00:1ad3:b0:6d8:e153:f884 with SMTP id
 f19-20020a056a001ad300b006d8e153f884mr7325344pfv.30.1704709079932; Mon, 08
 Jan 2024 02:17:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108093221.1477020-1-daniel@0x0f.com> <20240108093221.1477020-3-daniel@0x0f.com>
 <CAMuHMdX44A6+BNByuvbCC2gcM5vAipbaGAK7L8Vh8q3tMynBbQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX44A6+BNByuvbCC2gcM5vAipbaGAK7L8Vh8q3tMynBbQ@mail.gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Mon, 8 Jan 2024 19:17:49 +0900
Message-ID: <CAFr9PX=g+tVRYwhXkrPK421RW7ba1M1H2pM_AR6sJNx+oTFwjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] m68k: Fix interrupt stack frames for 68000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gerg@linux-m68k.org, fthain@linux-m68k.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Geert,

On Mon, 8 Jan 2024 at 18:56, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> I think it would be better to use the classic m68k stack frame.
> That would pave the way for building a single nommu kernel for
> MC680[012346]0 that runs on e.g. any Amiga.
> MC68000 and Coldfire are incompatible anyway.

Ok, I'll work that out. I have an A600 with an 020 board so I could
actually test it on real hardware. :)

Cheers,

Daniel

