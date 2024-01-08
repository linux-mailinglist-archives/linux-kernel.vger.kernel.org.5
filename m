Return-Path: <linux-kernel+bounces-19081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CC1826798
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 05:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA3F1C215DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F59379F4;
	Mon,  8 Jan 2024 04:27:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0664C79C2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 04:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [209.85.160.179])
	by gateway (Coremail) with SMTP id _____8BxHLuveZtlOAgDAA--.1634S3;
	Mon, 08 Jan 2024 12:27:28 +0800 (CST)
Received: from mail-qt1-f179.google.com (unknown [209.85.160.179])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Axqt2seZtlvvcGAA--.18355S3;
	Mon, 08 Jan 2024 12:27:26 +0800 (CST)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-427e83601c4so15527751cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 20:27:26 -0800 (PST)
X-Gm-Message-State: AOJu0YxwsIgP7HzpXwpsuPtzChLf58BeV++w/ZCeAEZ4PoJxYFS49G0p
	OHHCKiXT0+8i9qrLN92qx37Ro+dj84q0gJyxPfOJeyfNo5h7sA==
X-Google-Smtp-Source: AGHT+IGKnCG8TykNKu6ZAbyjwnzNC87gaoIpVZsuDDN+mlXo4QRoj8lgmpTyYllZ7a5FmM235WXdm/gN/LQ8AnX4xlE=
X-Received: by 2002:a05:620a:272a:b0:783:251a:e5d9 with SMTP id
 b42-20020a05620a272a00b00783251ae5d9mr445312qkp.21.1704684114109; Sun, 07 Jan
 2024 19:21:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106065941.180796-1-wangrui@loongson.cn> <CANiq72=M5TrUL+9Z0nqKKcD=KHwyDA79fNYHgU2EJ+7u6Ct8qw@mail.gmail.com>
In-Reply-To: <CANiq72=M5TrUL+9Z0nqKKcD=KHwyDA79fNYHgU2EJ+7u6Ct8qw@mail.gmail.com>
From: WANG Rui <wangrui@loongson.cn>
Date: Mon, 8 Jan 2024 11:21:43 +0800
X-Gmail-Original-Message-ID: <CAHirt9hd4W25p1kVNYXbEXrLj6NgT5r=EPWsoOmHZzS1qGR-yA@mail.gmail.com>
Message-ID: <CAHirt9hd4W25p1kVNYXbEXrLj6NgT5r=EPWsoOmHZzS1qGR-yA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Enable initial Rust support
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:AQAAf8Axqt2seZtlvvcGAA--.18355S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF1Utw17JryrZFykCF1DCFX_yoW8GF45p3
	Z2yryxKr4UJr9rJF17Ar1xXw1qyrn5Gw15Jwn5G3yUAw1UJr13Jr1UKF45tFyDGr1xCr4j
	yF1jvF1DAF4DJrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==

Hello,

On Sun, Jan 7, 2024 at 10:29=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Jan 6, 2024 at 8:04=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wro=
te:
> >
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >  Architecture  Level of support  Constraints
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > +``loongarch`` Maintained
>
> On top of what Huacai said, it would be nice to add another character
> and realign the table so that `loongarch` it doesn't overflow (perhaps
> best done in an additional, previous patch).

Thanks Huacai, Miguel.

>
> > +    } else if cfg.has("LOONGARCH") {
>
> Would it be possible to do it without a custom target in
> `scripts/generate_rust_target.rs`? If it is not possible (e.g. there
> is something that you cannot tweak otherwise on top of a built-in
> target via the CLI flags), it is fine to use a custom target for the
> moment.
>
> For instance, this is how ARM is doing it:
> https://lore.kernel.org/rust-for-linux/20231020155056.3495121-1-Jamie.Cun=
liffe@arm.com/
>

Thanks for your comments. I noticed that the refactoring of the build
system to support the use of Rust built-in targets is still ongoing.
Could this take some time? In the meantime, let's proceed with the
generation method.

> Thanks!
>
> Cheers,
> Miguel
>

--=20
Rui


