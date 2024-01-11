Return-Path: <linux-kernel+bounces-23019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248DC82A667
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE5F1F24099
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE251117;
	Thu, 11 Jan 2024 03:17:23 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A0CEBF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [209.85.128.172])
	by gateway (Coremail) with SMTP id _____8AxDLu+XZ9lQSAEAA--.4080S3;
	Thu, 11 Jan 2024 11:17:19 +0800 (CST)
Received: from mail-yw1-f172.google.com (unknown [209.85.128.172])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx39+cXZ9lbD0OAA--.37461S3;
	Thu, 11 Jan 2024 11:16:45 +0800 (CST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5eefd0da5c0so49063407b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:16:45 -0800 (PST)
X-Gm-Message-State: AOJu0YzUxDlX7fOHnFNBIQDRin1kHadoApSe7KF0GJcen6vkYlybTp5k
	Ev0WTka8bE0ig0MB+lhRqGtG/85HxaJLWZiP2uebefrfFwQNdg==
X-Google-Smtp-Source: AGHT+IE0jL+bvqrnpNSoLgCBevWtqVOaR8GEN8q+0+2xHB17kVQZvWuMgDwBezaXS10AurEkDRQMW6cTOsUlvENQfZQ=
X-Received: by 2002:a25:83c9:0:b0:dbd:b599:19a1 with SMTP id
 v9-20020a2583c9000000b00dbdb59919a1mr582736ybm.73.1704943002704; Wed, 10 Jan
 2024 19:16:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108032117.215171-1-wangrui@loongson.cn> <ZZ2fn0scbDKBXWe5@boqun-archlinux>
 <CAHirt9iox8FGV2wrMyxwFRjab2avfOcyLKvBc9K=AqiHxqHXKg@mail.gmail.com>
 <ZZ38XMQw18mw2sTA@Boquns-Mac-mini.home> <CAHirt9jQSVvBF=1wc=sT9FxngeSP30P4FDpu8m0JH_0fOPSO-w@mail.gmail.com>
 <CANiq72=X3cggAn0HLMi7jVFAfypBhog=ZkPB57yfaX4ZUzT-HA@mail.gmail.com>
In-Reply-To: <CANiq72=X3cggAn0HLMi7jVFAfypBhog=ZkPB57yfaX4ZUzT-HA@mail.gmail.com>
From: WANG Rui <wangrui@loongson.cn>
Date: Thu, 11 Jan 2024 11:16:31 +0800
X-Gmail-Original-Message-ID: <CAHirt9hdtGSsEofxDb0FCtcFeAw9n9LKJALz23Qdqh4n2=Ua5A@mail.gmail.com>
Message-ID: <CAHirt9hdtGSsEofxDb0FCtcFeAw9n9LKJALz23Qdqh4n2=Ua5A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Rust enablement for LoongArch
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:AQAAf8Bx39+cXZ9lbD0OAA--.37461S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E
	87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2
	Ij64vIr41l4c8EcI0En4kS14v26r4a6rW5MxAqzxv26xkF7I0En4kS14v26r4a6rW5MxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==

On Wed, Jan 10, 2024 at 6:50=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Jan 10, 2024 at 3:49=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wr=
ote:
> >
> > LLVM 17 doesn't work. The minimum LLVM version required for LoongArch
> > is 18.0.0. This is the reason why we have updated the
> > scripts/min-tool-version.sh. [1]
> >
> > [1] https://lore.kernel.org/loongarch/20240108033138.217032-1-wangrui@l=
oongson.cn/
>
> Thanks! Is this targeted at 6.9?

6.8

Regards,
Rui

>
> Cheers,
> Miguel
>


