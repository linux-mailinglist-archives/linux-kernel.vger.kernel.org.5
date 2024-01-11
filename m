Return-Path: <linux-kernel+bounces-23026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2177682A674
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2779C1C23169
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4FCEBF;
	Thu, 11 Jan 2024 03:26:09 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC37EBC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [209.85.219.170])
	by gateway (Coremail) with SMTP id _____8DxvuvDX59l4CAEAA--.12414S3;
	Thu, 11 Jan 2024 11:25:55 +0800 (CST)
Received: from mail-yb1-f170.google.com (unknown [209.85.219.170])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxmd2_X59lTkYOAA--.37528S3;
	Thu, 11 Jan 2024 11:25:54 +0800 (CST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbed4b03b48so3793419276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:25:53 -0800 (PST)
X-Gm-Message-State: AOJu0Yz2xYLlftc9ZrNgG9rRXJ/8a/AG6WiB/E5gpu1K285TF7DHYKTf
	rHk+uZRSAhr6POiXuQNzTxVDZ4/j5u4/khAwNEzY1uv+PZR/7Q==
X-Google-Smtp-Source: AGHT+IHpSM/8N7+rGcy92dZLNMFLoixFy6IEJVvgwPI+z5PwBP9sjyoT/Y36ExtZ7DIfK/4FNN0TteYtrQWLIRHMQSQ=
X-Received: by 2002:a05:6902:2511:b0:dbf:e0a:c642 with SMTP id
 dt17-20020a056902251100b00dbf0e0ac642mr686949ybb.112.1704943080724; Wed, 10
 Jan 2024 19:18:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106065941.180796-1-wangrui@loongson.cn> <CANiq72=M5TrUL+9Z0nqKKcD=KHwyDA79fNYHgU2EJ+7u6Ct8qw@mail.gmail.com>
 <CAHirt9hd4W25p1kVNYXbEXrLj6NgT5r=EPWsoOmHZzS1qGR-yA@mail.gmail.com> <CANiq72nw2UHd3Kek-Fmvk_3zE=z56wYJVQJq_syYagru5+wo8g@mail.gmail.com>
In-Reply-To: <CANiq72nw2UHd3Kek-Fmvk_3zE=z56wYJVQJq_syYagru5+wo8g@mail.gmail.com>
From: WANG Rui <wangrui@loongson.cn>
Date: Thu, 11 Jan 2024 11:17:50 +0800
X-Gmail-Original-Message-ID: <CAHirt9hD-yYhA4moQemOPizSGrgdkBgT08UuuZai41gsbGdMog@mail.gmail.com>
Message-ID: <CAHirt9hD-yYhA4moQemOPizSGrgdkBgT08UuuZai41gsbGdMog@mail.gmail.com>
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
X-CM-TRANSID:AQAAf8Dxmd2_X59lTkYOAA--.37528S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xr1rurW3AFWDXr18AF4xGrX_yoW3Xrb_ua
	1DAr97ArW8GFsrA3sIqa1UJFyfWaykGry5u3ykXayvyw1ftan8WrykCFykJwsrCayxGr9a
	9r90ya4093W3ZosvyTuYvTs0mTUanT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
	6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcD73DUUUU

On Wed, Jan 10, 2024 at 7:21=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jan 8, 2024 at 4:22=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wro=
te:
> >
> > Thanks for your comments. I noticed that the refactoring of the build
> > system to support the use of Rust built-in targets is still ongoing.
> > Could this take some time? In the meantime, let's proceed with the
> > generation method.
>
> My pleasure! If you mean the first patch of the arm64 series I linked,
> we have been waiting for a while for that to get merged (hopefully
> 6.9?). So, yeah, as you say, it is probably best to continue with this
> and then you can change it later after the arm64 series lands. Thanks!

Thanks. I'll do it.

Regards,
Rui

>
> Cheers,
> Miguel
>


