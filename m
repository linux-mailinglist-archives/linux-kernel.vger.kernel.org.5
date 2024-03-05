Return-Path: <linux-kernel+bounces-92017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0FA8719C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF151F242E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3834E535B9;
	Tue,  5 Mar 2024 09:41:53 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3807C4CB2E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631712; cv=none; b=Er3EDIpJTFlZgdJdBcfeDkfh8AsLzOFvVH9KPovdDKcL4zFPMwA6LPTdfKolihg8vhHLz/B9v+SJ9Q/lSXDMMAbcw5VVt377PVa6Zpay7xgWFuHw5KCPUmmqYDfwuEuUILKb3ZnA2PR5DTz+2eEiX0saLrpnG/L/aL0rmXk2pI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631712; c=relaxed/simple;
	bh=Z2qwct6XTybj5nj/8GILqcSdKhOgcrszVOS6anSnpTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMsp1x3a2NB0qrh8rKucN9UZVFF6EepDl68Ij1e0vvmAgPU1rlU3thFrK74r6lCshLSWOTZTKQuDGlCF3YE/wQfYQE8Fwqo358oOmzpbE0nSdnISZx13MLlU9RxM3JrmVjXiVoEEbekFxnsh/BI1fCuF+yMKsmeJWSnh9i42CyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [209.85.216.46])
	by gateway (Coremail) with SMTP id _____8AxeejU6OZlmbIUAA--.32398S3;
	Tue, 05 Mar 2024 17:41:42 +0800 (CST)
Received: from mail-pj1-f46.google.com (unknown [209.85.216.46])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxPs_S6OZlEXVOAA--.11212S3;
	Tue, 05 Mar 2024 17:41:39 +0800 (CST)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29a5f100c1aso3194785a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:41:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTYfN4lRfVB4cGEfQqPWjUWTvcgLoge/ads7W8ZPXQMkoRqpW9vB6iLdq5YK++kHSdp04ZGk0I8jvW4jBwA+w/6ohslQQiMtyQAXTl
X-Gm-Message-State: AOJu0YySYoyF5yIVDt2G9yRxFsyHw7ut5cr0WLcDeLvuYtvlHE0ISUiE
	IavWi2beyLsHEKwWq9tiuclMrbesQQOH8Yp2rJghMrigmE+CK7GA+9JIZqQRb0C/jilhTFBibCF
	Qo9CtFXA5zEMziZRAp+u9wFgrVnWf2u2ehD3NWQ==
X-Google-Smtp-Source: AGHT+IFCOgUQy6Yrg/hGm/YPDL5pf6cIPrfQwg8VzhOdB0PFiQXbjuVLpWWugLmSn2Wclxftxj3A7UzLgXYKuu6Ie90=
X-Received: by 2002:a25:1803:0:b0:dc6:aebb:168e with SMTP id
 3-20020a251803000000b00dc6aebb168emr8119664yby.26.1709622525779; Mon, 04 Mar
 2024 23:08:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304141426.163517-1-wangrui@loongson.cn> <CANiq72mvdVrzN19PC8pNrvuBLkOEEQ3yX0WG6JcWc+RVaSM2nA@mail.gmail.com>
In-Reply-To: <CANiq72mvdVrzN19PC8pNrvuBLkOEEQ3yX0WG6JcWc+RVaSM2nA@mail.gmail.com>
From: WANG Rui <wangrui@loongson.cn>
Date: Tue, 5 Mar 2024 15:08:35 +0800
X-Gmail-Original-Message-ID: <CAHirt9iNPjHfMRS792E1MHbCQk1v6GnNVcb6LAvhskyyVg8bPw@mail.gmail.com>
Message-ID: <CAHirt9iNPjHfMRS792E1MHbCQk1v6GnNVcb6LAvhskyyVg8bPw@mail.gmail.com>
Subject: Re: [PATCH] loongarch: rust: Switch to use built-in rustc target
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, WANG Xuerui <kernel@xen0n.name>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:AQAAf8CxPs_S6OZlEXVOAA--.11212S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtryxWrWkCF48Cw13Gw17urX_yoWkXrb_X3
	W7Cr1kGF1UuFs7Za48JrWruFn0q345tay3Z3ykXFsrXr95Zan8WFyDGa4av3Zay3yxWFs3
	Kr1Fvwn8uw12gosvyTuYvTs0mTUanT9S1TB71UUUU8UqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbf8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Mq2tUUUUU==

On Tue, Mar 5, 2024 at 12:09=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Mar 4, 2024 at 3:14=E2=80=AFPM WANG Rui <wangrui@loongson.cn> wro=
te:
> >
> > This commit switches to using the built-in rustc
> > loongarch64-unknown-none-softfloat target for LoongArch.
> >
> > The Rust samples have been tested with this commit.
> >
> > Signed-off-by: WANG Rui <wangrui@loongson.cn>
> > ---
> > base-commit: ("rust: Refactor the build target to allow the use of buil=
tin targets")
>
> I couldn't apply it on top of commit f82811e22b48 in arm64's tree
> (which is the base? -- the offset differs significantly in the arch
> Makefile), but I nevertheless applied it manually on top of that one,
> build-tested it for loongarch64 and boot-tested it for x86_64:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>

Oops. The actual base is tag next-20240228. I just want to make it
clear that this patch needs to be based on ("rust: Refactor the build
target to allow the use of builtin targets").

Thanks!

Regards,
Rui

>
> Thanks!
>
> Cheers,
> Miguel
>


