Return-Path: <linux-kernel+bounces-2923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6BE816457
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A968D1C20DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDD023D7;
	Mon, 18 Dec 2023 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrncG6P/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA083C0D;
	Mon, 18 Dec 2023 02:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6da5250357fso2011402a34.2;
        Sun, 17 Dec 2023 18:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702866730; x=1703471530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7iDfR9gqFIKBbwdorWXDs6zFQNPE6rkq2OxXyUMYp7M=;
        b=WrncG6P/Rest1mGeNd4zZtfe99ZDu1ot77FuOxU8rKR8Ho3gFlFO+8oixILet+SPRO
         KmPAX6ZiI4DmpxJXSzyNmI+RL7YwLgOMmyDMSrnkiXCGpn3bvWrXOdocAu0+9nSBzb73
         Vdd+UaA7ZF1/BKvliPYDb12E8M+XJfvJeilCaHcbcasl59Ezoco+xbYenOEfIsCAYu9M
         ES7DNR1/nqM+AZLo8qQK0Bn00CjGz10p05u9KSYe88ZsJci48ZyxLN8cyeGpX0wUR4UM
         Fig36NjmFsH3PuL4Y36uOc/JxhtYTq714UYjgH5PVj5EXx7tKfYTB+i3ztq/ci0SBPKO
         AlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702866730; x=1703471530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iDfR9gqFIKBbwdorWXDs6zFQNPE6rkq2OxXyUMYp7M=;
        b=HnkxBLCkJm5g7zUT+ONoCr0sOUgx42e7CdSJmRE2BwxChDN58nOsqxr71NbhjoR4w7
         sGCDWJWkGeiiI3ga+YUt5JmHamMSDipzZGOCWryq1kxUa9odLP0KXHcYUKd5/Wra2ErB
         mLhMzwkHnEufUE/qIynqYpWidz/O2nTjZUdV+AOpFhYExVAbz2W746Ei9P8oGW4eOMCf
         lRvbN63ilixtBT3A0BFQeW18I/rUsK7lS3i05lQv+0f/Eso76SP+dVhOUjiUICvM+V4F
         ixDIPHc/6HKvNTGwX2pMDfziQ+CuhHzhodcTrGVKu9PuWEmBi2Z27dlwPjNc1+q9HndS
         kDng==
X-Gm-Message-State: AOJu0YzaFMJl86m+pnAR7JKaYbLKdIKD/ED8kiAEr10uD1PBGsxNxb4i
	E/5u0+4AWCYziMmq4z4Gov/0Xpds7e8L6e6wPss=
X-Google-Smtp-Source: AGHT+IG5XXaO//tvIR0OZSVEnw/470w5MK5XqgQhMl5oKfv07MK3HF1Zmh0u+AwTIrnDSA3v9WKJcQBK94g6Am/kMMk=
X-Received: by 2002:a05:6870:c18c:b0:203:56b9:7eba with SMTP id
 h12-20020a056870c18c00b0020356b97ebamr7866919oad.36.1702866730099; Sun, 17
 Dec 2023 18:32:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215085630.984892-1-chunyan.zhang@unisoc.com>
 <20231215085630.984892-5-chunyan.zhang@unisoc.com> <fd927698-6aa3-4a6b-988c-fc82663235ca@linaro.org>
In-Reply-To: <fd927698-6aa3-4a6b-988c-fc82663235ca@linaro.org>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 18 Dec 2023 10:31:33 +0800
Message-ID: <CAAfSe-tTvxLCAdSCCgEw8HMFaVVfOytoowY_Fb2F0H-vo+cCmA@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: sprd: Add support for Unisoc's UMS9620
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Orson Zhai <orsonzhai@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Dec 2023 at 18:36, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/12/2023 09:56, Chunyan Zhang wrote:
> > Add basic support for Unisoc's UMS9620, with this patch,
> > the board ums9620-2h10 can run into console.
> >
>
> ...
>
> > +
> > +     soc: soc {
>
> Are you sure you do not have here W=1 warnings?

Do you mean warnings generated by running "make W=1"? I tried just now
and didn't see warnings on this dts.

Thanks,
Chunyan

