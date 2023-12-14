Return-Path: <linux-kernel+bounces-47-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7B813B36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87E31C20CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3960A6A32E;
	Thu, 14 Dec 2023 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DcctqYnl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EAA6A016
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c31f18274so82791035e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702584207; x=1703189007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3t3FbK18GrHFwKE4zIkpGcLL7FiHaNow8xNq3R4/QdI=;
        b=DcctqYnloBXyzr6/icFJ5nrbeI/fwc45lTK7zT/zDqs/kq2mNANjqfq2WI1CPbOIkl
         3zpygJURz7qkPfte+tjx80A6gdM+O1FTYI2VvL7SuLYcjzd7H6DpQfdwmDLV9+nXMrPb
         7dTw0mVB00N20UiuwNWRNzFDHCuBoP+J6TIeAJfZc3sS1MAXMzL9Z0GoRoatm7TLOu8j
         8ZZNvlX+vs9HJuG2Y82vknoMM3anREwfsFsat4CTGetqMhnBOOAiPMlJfT5NqSfpdkqn
         3Qd8clBnVZm39r28lU0UGMK8yIuIf8HPnzkmKCt9BujWkP4WutaWkmQdw0Vrw4Oq2nII
         J76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702584207; x=1703189007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3t3FbK18GrHFwKE4zIkpGcLL7FiHaNow8xNq3R4/QdI=;
        b=O2My+nD+T0zIo5Z1GUED/2cgND2B9PeQWM0BPN9FNTuS6IJmFctidl8qdIeY9kOWLn
         XQR6hKg3iqGr7YI6qE6DxD4xyzdo2ARjStHGTbWZC+18iDnFlPNWeyogrt47zGPZZn6h
         bW+ehYzgoEoJh73ZNa7KSMwrTF//nUC5iVjf+3d5Ao9W9QgTQhqNRkl0sX9cF7rmCmtQ
         w/fu3ZUSTvMmdqWATV+VGkCdHHtkMlUc6m+Xit1uLcECJY3+goKq/tT7tsZLS3mJTBcu
         AQ0tkX/ezPvRHqK+Y1Ylar8cXKOGyNIt0O1cvwtSr3Mm6J9AlRU+cn21S36yJyhoe4OI
         d6XA==
X-Gm-Message-State: AOJu0YznJLj1RfcgRm9SXI6suDKGD9qUL300mYHunuBEtQ+NPzHHpiGG
	bAOeYs2TZ5kQsrJgqrwyA+cCQ4bwkfN+Zs8Oxb7OWA==
X-Google-Smtp-Source: AGHT+IFJxGuMnKvxp55N7GC1tz5/h738b4XoM+FeA8fRtBht8xQJ/kBDFL2qAi3ZYkZt7idruFgudyPvdRKWDedOoVg=
X-Received: by 2002:a05:600c:2313:b0:40c:3e43:4183 with SMTP id
 19-20020a05600c231300b0040c3e434183mr4682976wmo.5.1702584207011; Thu, 14 Dec
 2023 12:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-9-almasrymina@google.com> <b07a4eca-0c3d-4620-9f97-b1d2c76642c2@gmail.com>
 <CAHS8izNVFx6oHoo7y86P8Di9VCVe8A_n_9UZFkg5Wnt=A=YcNQ@mail.gmail.com>
 <b1aea7bc-9627-499a-9bee-d2cc07856978@gmail.com> <CAHS8izPry13h49v+PqrmWSREZKZjYpPesxUTyPQy7AGyFwzo4g@mail.gmail.com>
 <661c1bae-d7d3-457e-b545-5f67b9ef4197@gmail.com>
In-Reply-To: <661c1bae-d7d3-457e-b545-5f67b9ef4197@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 14 Dec 2023 12:03:15 -0800
Message-ID: <CAHS8izOY9xm=LBEN8sYwEa3aFB4GWDvJVacom3o4mHZPdHzTUg@mail.gmail.com>
Subject: Re: [net-next v1 08/16] memory-provider: dmabuf devmem memory provider
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 12:37=E2=80=AFPM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
...
> >> If you remove the branch, let it fall into ->release and rely
> >> on refcounting there, then the callback could also fix up
> >> release_cnt or ask pp to do it, like in the patch I linked above
> >>
> >
> > Sadly I don't think this is possible due to the reasons I mention in
> > the commit message of that patch. Prematurely releasing ppiov and not
> > having them be candidates for recycling shows me a 4-5x degradation in
> > performance.
>
> I don't think I follow. The concept is to only recycle a buffer (i.e.
> make it available for allocation) when its refs drop to zero, which is
> IMHO the only way it can work, and IIUC what this patchset is doing.
>
> That's also I suggest to do, but through a slightly different path.
> Let's say at some moment there are 2 refs (e.g. 1 for an skb and
> 1 for userspace/xarray).
>
> Say it first puts the skb:
>
> napi_pp_put_page()
>    -> page_pool_return_page()
>      -> mp_ops->release_page()
>         -> need_to_free =3D put_buf()
>            // not last ref, need_to_free=3D=3Dfalse,
>            // don't recycle, don't increase release_cnt
>
> Then you put the last ref:
>
> page_pool_iov_put_many()
>    -> page_pool_return_page()
>      -> mp_ops->release_page()
>         -> need_to_free =3D put_buf()
>            // last ref, need_to_free=3D=3Dtrue,
>            // recycle and release_cnt++
>
> And that last put can even be recycled right into the
> pp / ptr_ring, in which case it doesn't need to touch
> release_cnt. Does it make sense? I don't see where
> 4-5x degradation would come from
>
>

Sorry for the late reply, I have been working on this locally.

What you're saying makes sense, and I'm no longer sure why I was
seeing a perf degradation without '[net-next v1 10/16] page_pool:
don't release iov on elevanted refcount'. However, even though what
you're saying is technically correct, AFAIU it's actually semantically
wrong. When a page is released by the page_pool, we should call
page_pool_clear_pp_info() and completely disconnect the page from the
pool. If we call release_page() on a page and then the page pool sees
it again in page_pool_return_page(), I think that is considered a bug.
In fact I think what you're proposing is as a result of a bug because
we don't call a page_pool_clear_pp_info() equivalent on releasing
ppiov.

However, I'm reasonably confident I figured out the right thing to do
here. The page_pool uses page->pp_frag_count for its refcounting.
pp_frag_count is a misnomer, it's being renamed to pp_ref_count in
Liang's series[1]). In this series I used a get_page/put_page
equivalent for refcounting. Once I transitioned to using
pp_[frag|ref]_count for refcounting inside the page_pool, the issue
went away, and I no longer need the patch 'page_pool: don't release
iov on elevanted refcount'.

There is an additional upside, since pages and ppiovs are both being
refcounted using pp_[frag|ref]_count, we get some unified handling for
ppiov and we reduce the checks around ppiov. This should be fixed
properly in the next series.

I still need to do some work (~1 week) before I upload the next
version as there is a new requirement from MM that we transition to a
new type and not re-use page*, but I uploaded my changes github with
the refcounting issues resolved in case they're useful to you. Sorry
for the churn:

https://github.com/mina/linux/commits/tcpdevmem-v1.5/

[1] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D809049&st=
ate=3D*

--=20
Thanks,
Mina

