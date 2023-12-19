Return-Path: <linux-kernel+bounces-5815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E8818FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D176E1F237B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9891E521;
	Tue, 19 Dec 2023 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KiNflcK5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5961DDEA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-425928c24easo24551cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703010967; x=1703615767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cdlfGRn9Pik/X1WCRvEtMyeQFE6g33e6UHtZ+YZ/+mU=;
        b=KiNflcK5VEZUW6/Z5uZaxJ2uz5n1dgrqsB+YYoTxEG1LMxMFFXveUDca/Mv9xCHtmD
         e7B5zCOleYNTNWHQ6fJWibVe1jXECmnlWLjMglt441FtrSXORfZE32jhGxbHvGJxdq+B
         eMfWnC5+zhsj5Yd/Vd+C4p2eEYSJOAAqBwd/r4IBUOSBe2XVOdqwaMAwWVuuW1S/dn7R
         vyCpvZfUe9PrZeWJSjTp6LdHMREGu26DE+KfuqGonkGm+XqjNPVvqlzLotZ3djNrj3MC
         GvBMGx/gcksFimHUE+CrZhVVvzy4SD2+Fl+uIRnKpShl9Ckn7p40548fnAUVxa3n5Wzj
         W4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703010967; x=1703615767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdlfGRn9Pik/X1WCRvEtMyeQFE6g33e6UHtZ+YZ/+mU=;
        b=azOkJjxvSo1yjcyWJnbNcirBiqofcayniKfkdNgrQcLNuWNUnto2nf4q98PmH8jl5c
         iWk1jOBXqPqbSZlUpo6S974bmOsVJZkQcWShcDYY3tBMWG1G1ZFOzm/sdf0ZCF+nlW8w
         e6RzgVOS5rfJ8ZT3ggHT7Q1g8x/cS6mw+pwmPXfxKHLv/8BqsrSaasMAGR1TiVeYPgij
         HjgnWTlnUgeIQ6SJITou+BByJ+JcubPsIXiZjdKkvqR91EcuwFTLwbOcIh/iEdJ1qhMB
         1jypGHeye7cQgtC5h92UM6EiXYBKb9u3hZ0Y53XhD12HkZ/tXebuUA8GG7aRT6zhKWG6
         WG+A==
X-Gm-Message-State: AOJu0Yz5ij6rF40zkkRnLGxP9s9063hzTGhlvvDJzIdOoLrjFa4rYaT5
	ZiABA4gL2UeO9VfYz8ciE22X9f1OIm74o/XTRUKbFUfYYohP
X-Google-Smtp-Source: AGHT+IEBLCNdsO/90AJuMfJS1bbNyublmOBRFluX1ANBAWNG5IR6t4QBsmCeBb7+ZRef/sCDxlO6WJZbnp1+cFls3p8=
X-Received: by 2002:ac8:5d0f:0:b0:425:8bbf:f6b0 with SMTP id
 f15-20020ac85d0f000000b004258bbff6b0mr13822qtx.29.1703010967554; Tue, 19 Dec
 2023 10:36:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219-libstringheader-v4-0-aaeb26495d2f@google.com>
 <20231219-libstringheader-v4-1-aaeb26495d2f@google.com> <2023121938-stargazer-purse-0dc1@gregkh>
In-Reply-To: <2023121938-stargazer-purse-0dc1@gregkh>
From: Tanzir Hasan <tanzirh@google.com>
Date: Tue, 19 Dec 2023 10:35:55 -0800
Message-ID: <CAE-cH4p-TzH3zyJfmSg3r=fw78j8y-0t0dp-NvaLyVYAMULw1w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>, Nick DeSaulniers <nnn@google.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	llvm@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Legal note, this file is NOT copyright Google as no Google employe
> actually wrote the logcal contents of it.
>
> Please be VERY careful when doing stuff like this, it has potentially
> big repercussions, and you don't want to have to talk to lots of
> lawyers a few years from now and explain how you messed it all up :(

Ah, sorry, I didn't realize. Will change right away.

> Nick, odds are there's a Google copyright class that Tanzir should take
> here, if not, I recommend the free LF one that anyone can take online
> that explains the issues here:
>         https://training.linuxfoundation.org/training/open-source-licensing-basics-for-software-developers/

I will take a look, thanks!

> As-is, this change is STRONGLY Nacked by me.
>

Best,
Tanzir Hasan

