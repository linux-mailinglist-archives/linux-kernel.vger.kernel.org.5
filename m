Return-Path: <linux-kernel+bounces-2828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8910816286
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9841F21A9B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC0848CDA;
	Sun, 17 Dec 2023 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dec3LUzO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9EE487A4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40b5155e154so29858195e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 13:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702849272; x=1703454072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c/yvbsSjMKGQvv3uw5Bh6Dq/DFlsTHYL/+Ws2+BkUR0=;
        b=Dec3LUzOKNq2Q0a/K8vC4E4x1Jc/1j0UK8pHSKyICHgkGT2iBaOiNozYZ8LnKiSW0l
         oZDqgWJ0riboC/tAphikqmK/KJaMt3kBfN5R2mbyhKFAbptIhy06ENvTkEdVI125RS4T
         YzhLot4h4fjqUvSTcmLKUa/9J4pXdMUEhk+pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702849272; x=1703454072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/yvbsSjMKGQvv3uw5Bh6Dq/DFlsTHYL/+Ws2+BkUR0=;
        b=WfPUb6o3RIa1qXaIVRDXXyWrwmpXAMH1kT0PDMScSYH8D0X9uOc+saKF43DZNQ4wTm
         a/KlQvYwbCdLmlQHwlTVmOnHT88mJvoncZqhyXBN4ZkhOby+Y/Ax6IDIgci6JtVVd1tl
         FLT0K29Og2T0E21TWv9ErEpdp8Z7hLqGBwvGqyEWkfYCuMCNKb7H5DRHJlcooPhYKmyi
         ndhEoPI1cRZffEgaKCIMWho8fX9CrEtXzFTPzcNDVMmTy54G5RgP/7LFLjrScg+qbB44
         ppuNS3089jLLHreymhgW1pZMP/uJIEUXRNiwW4fIztxyUN1XGRk8HNmJiwkKoPxg9W3g
         fsNw==
X-Gm-Message-State: AOJu0YzthqUghHauzITZ5DmmTMMcKLj5RQTDtpfcUUBKXy2CoXN7FiIE
	MJ2JCN3Rd4iJeCZ/ICLGYRGez3gh26R+J42XUiMux63U
X-Google-Smtp-Source: AGHT+IHOw85abRay5RDtF3K+SXmjqXc/17KToqyrgFDFwKBZqNIFn+7CB1nVLkuFs2sdq/OD2XHt1Q==
X-Received: by 2002:a05:600c:1f1a:b0:40c:314a:42e with SMTP id bd26-20020a05600c1f1a00b0040c314a042emr7409155wmb.246.1702849272697;
        Sun, 17 Dec 2023 13:41:12 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id lm11-20020a17090718cb00b00a1cf3fce937sm13366077ejc.162.2023.12.17.13.41.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 13:41:11 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c31f18274so30135335e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 13:41:11 -0800 (PST)
X-Received: by 2002:a05:600c:21c7:b0:40c:31ec:eaf with SMTP id
 x7-20020a05600c21c700b0040c31ec0eafmr7398457wmj.205.1702849271236; Sun, 17
 Dec 2023 13:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213163443.70490-1-brgerst@gmail.com> <20231213163443.70490-4-brgerst@gmail.com>
 <CAHk-=whXt7QZV+HDA8=PN1pTBSNTL0ZJrcqtc4af=FtJpjPQeQ@mail.gmail.com> <C7EB5080-639B-41EE-B494-869D5D6F60A7@zytor.com>
In-Reply-To: <C7EB5080-639B-41EE-B494-869D5D6F60A7@zytor.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 17 Dec 2023 13:40:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgOxf3u-4qp9z+50y93dw2aj_nnx3Y8zLo_GGBA4U92BQ@mail.gmail.com>
Message-ID: <CAHk-=wgOxf3u-4qp9z+50y93dw2aj_nnx3Y8zLo_GGBA4U92BQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/sigreturn: Reject system segements
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Michal Luczaj <mhal@rbox.co>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Dec 2023 at 13:08, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On December 13, 2023 10:54:00 AM PST, Linus Torvalds <torvalds@linuxfoundation.org> wrote:
]> >Side note: the SS/CS checks could be stricter than the usual selector tests.
> >
> >In particular, normal segments can be Null segments. But CS/SS must not be.
> >
> >Also, since you're now checking the validity, maybe we shouldn't do
> >the "force cpl3" any more, and just make it an error to try to load a
> >non-cpl3 segment at sigreturn..
> >
> >That forcing was literally just because we weren't checking it for sanity...
> >
> >           Linus
>
> Not to mention that changing a null descriptor to 3 is wrong.

I don't think it is. All of 0-3 are "Null selectors". The RPL of the
selector simply doesn't matter when the index is zero, afaik.

But we obviously only do this for CS/SS, which can't be (any kind of)
Null selector and iret will GP on them regardless of the RPL in the
selector.

              Linus

