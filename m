Return-Path: <linux-kernel+bounces-2505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC120815E17
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 09:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E487BB218FF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D2A1FBB;
	Sun, 17 Dec 2023 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1yKWnsc1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E3185E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso2420352a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 00:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702800914; x=1703405714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60F2ATzAHDKtGPRs2bXfsavW1DI+agjrMkffzWa7PLI=;
        b=1yKWnsc1BiM/fv7trNG8kQ87EY1/JstLrlFwfBUvc8OjDg99cqspvqkcyJmMR0E2Pu
         IBJIrdcVKB5XxXsUk6i/F0oYY6WcMflL6QCk8LIc/B7TYvyro6ZyCJw/BNkc6yeU9AIr
         bcgYYadSydATY2Q6C2bquuaACBsQjmCFVakZdM1RdSvC+I5J0KovIKZr85wILy8CTh7o
         H43/pn7pKNv3RlApzXykOOpd26Qqj8wi9xly5QkzpnLBD1/8akurJMcAb4Q099CSyZB5
         2mzQbdyJIukEzllzBRNIucH8pBvhpL9mxTmGlFfZ7zAxQMHv+W46mwV+ibRVxyb3SZtq
         lx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800914; x=1703405714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60F2ATzAHDKtGPRs2bXfsavW1DI+agjrMkffzWa7PLI=;
        b=EdsF3HQNhjzb+4P8t1Vc1+IqU6M8DbcrZSMnC8cvYHjDzb0HYOar7UmaYQS2Wph7Yq
         1joXrQEt4rKIYIKvrf8S0/nml2UlCUEWrS/ds2R/tYNbDrWT7kpGJ/AUPqBcu/OpEika
         Iokzq9vHgv+asehbgfGgaLSKIDDj6VbtTD7YkrBeZc7AD7+tQySemyCsJd9HBPCgPtzl
         SP0nEjYpghS9MeGh28kmFxboOnoyorCIxFHPsNUy2uydiJHFCjdnDeI7oD0QrtmBIIa4
         ypTN41bAJF7nFC+kg2Mibes1JbZCLscIkkkggsxH8uZpoXBrRY7wtAck1cjuYiA0Ppc+
         SXng==
X-Gm-Message-State: AOJu0YzopY101YqUzf/Y/JywOt1XKgi5+XNFA2K15aSVoFWMVZaXDfrd
	bKkq+D5X77UsUPdc6gYYs6nJfi+tEOBUYNFtKkJYNA==
X-Google-Smtp-Source: AGHT+IHQrLXo/6D4cvtJ3HR0M3jIIjNIvh9V5qDlot7YQKT/hN6uzbLZJBzF40qS8xdCqHfqb16F0Y3coMCmYjXpSBA=
X-Received: by 2002:a17:906:8f:b0:a23:26bf:6cd9 with SMTP id
 15-20020a170906008f00b00a2326bf6cd9mr925030ejc.34.1702800913483; Sun, 17 Dec
 2023 00:15:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-3-almasrymina@google.com> <20231215185159.7bada9a7@kernel.org>
 <CAHS8izMcFWu7zSuX9q8QgVNLiOiE5RKsb_yh5LoTKA1K8FUu1w@mail.gmail.com> <84787af3-aa5e-4202-8578-7a9f14283d87@kernel.org>
In-Reply-To: <84787af3-aa5e-4202-8578-7a9f14283d87@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 17 Dec 2023 00:14:59 -0800
Message-ID: <CAHS8izOeCdA+WVRYbieTqaCyadARsOpYttAXh7Lhu-B7RC3Tmg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 2/4] net: introduce abstraction for
 network memory
To: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michael Chan <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, 
	Russell King <linux@armlinux.org.uk>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Jassi Brar <jaswinder.singh@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Ronak Doshi <doshir@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 5:45=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 12/16/23 2:10 PM, Mina Almasry wrote:
> > On Fri, Dec 15, 2023 at 6:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >>
> >> On Wed, 13 Dec 2023 18:05:25 -0800 Mina Almasry wrote:
> >>> +struct netmem {
> >>> +     union {
> >>> +             struct page page;
> >>> +
> >>> +             /* Stub to prevent compiler implicitly converting from =
page*
> >>> +              * to netmem_t* and vice versa.
> >>> +              *
> >>> +              * Other memory type(s) net stack would like to support
> >>> +              * can be added to this union.
> >>> +              */
> >>> +             void *addr;
> >>> +     };
> >>> +};
> >>
> >> My mind went to something like:
> >>
> >> typedef unsigned long __bitwise netmem_ref;
> >>
> >> instead. struct netmem does not exist, it's a handle which has
> >> to be converted to a real type using a helper.
> >
> > Sure thing I can do that. Is it better to do something like:
> >
> > struct netmem_ref;
> >
> > like in this patch:
> >
> > https://lore.kernel.org/linux-mm/20221108194139.57604-1-torvalds@linux-=
foundation.org/
> >
> > Asking because checkpatch tells me not to add typedefs to the kernel,
> > but checkpatch can be ignored if you think it's OK.
> >
> > Also with this approach I can't use container_of and I need to do a
> > cast, I assume that's fine.
> >
>
> Isn't that the whole point of this set - to introduce a new data type
> and avoid casts?

My understanding here the requirements from Jason are:

1. Never pass a non-page to an mm api.
2. If a mangle a pointer to indicate it's not a page, then I must not
call it mm's struct page*, I must add a new type.

I think both requirements are met regardless of whether
netmem_to_page() is implemented using union/container_of or straight
casts. folios implemented something similar being unioned with struct
page to avoid casts. I honestly could go either way on this. The union
provides some self documenting code and avoids casts. The
implementation without the union obfuscates the type and makes it much
more opaque.

I finished addressing the rest of the comments and I have this series
and the next devmem TCP series ready to go, so I fired v2 of this
patchset. If one feels strongly about this let me know and I will
re-spin.

--=20
Thanks,
Mina

