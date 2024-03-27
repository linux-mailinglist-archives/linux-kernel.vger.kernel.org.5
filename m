Return-Path: <linux-kernel+bounces-120345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C006F88D612
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E731B22AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144ED18036;
	Wed, 27 Mar 2024 05:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES9KuCqz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDB125DB;
	Wed, 27 Mar 2024 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518643; cv=none; b=fVEK3ik/3ZOwzEIwDQt5+A0du1eIZ8IAaU2UFFIr17rijs0bu57SJjdnTcsL+DRwTN0E4Vy9pYJbAgVa1o9IszS8an1dKdUY1PmoR7wdkn8Sbcqt1e+eOUpUH00bkoqpw2pGR5uYxtb2YSYhTbJdbEFICQVnY5QRTLv/oERTEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518643; c=relaxed/simple;
	bh=jLBpGnJzrkmpn7RrQHTRBiUSa3Q7I21OjJbXmT8JEdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xqms6pAWmUo6h9Hy7CUNTZZmIXCa3hwjJZmXXx238OcD4F8A8f/0OpU3Dxrp6bPoPXnooBRXohhofzJOdRUzCsvQ4ae4I4r6pSp6wlU9mEY4wtxsViQW1CSW8wPln1D6JbWQ3bFgcTaOQS+Cy/oGKiw0OOTjx2yBTWYNKQEau6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES9KuCqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A20C43394;
	Wed, 27 Mar 2024 05:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711518642;
	bh=jLBpGnJzrkmpn7RrQHTRBiUSa3Q7I21OjJbXmT8JEdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ES9KuCqzNRR7D2sIzqx3sEHNE+ovQ3eVPalP2bgIGxII8B8RGU/XeUYZFt2CHaXCl
	 38XAKXxgxTe8IO1mPoKFG6HObsz27q26XpgX1cABsCW0ik/R9SPMMj/Y3OzSCZZWaf
	 Ymr+B8auXXdXsm5ruMJocGoyZfMe3ftDbc5PeV2kyqED96RWIVoCnpokDuG7sSVXgy
	 ZqPLuBPV/6/mrRKJhdRr17ExVj2ZlAaZGkTYN/m6vyCZzHdYLkq1axx0DZ7lrh2186
	 QV5tailHiXAVZ/3rvYMIigcmA5ww04vVm0UNdIPaAERP5xPM61rLDYeRm2aKx/pV5L
	 poDNrlhxrZUyg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d6c8d741e8so58875191fa.3;
        Tue, 26 Mar 2024 22:50:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8myXDtccINGknvriPnGiJlgTiJ9ELoluxqcs/H0pCrruyi4b1zeVJm3A1Kg3OIf1jXfPKImhmw6G2wcZ7vKzPFdv+j230Agc6fhePd1kko/MMxVMeglTpE/BqhXOc+k2GQ8LUSqttjuR2Ax0nnw+QH2x37VwJ+k5u19usWBNueA==
X-Gm-Message-State: AOJu0YxzA+4SSpTaj0IX1khkqtT8+M7L6zX02+HV3A9r9OCfudaMQr8V
	Lj5VakGnqsSjOSYbvedi0yV5LSx66lxpLsha7UfCmfJJcOH9IP8wUzQlncKAZkMxjmFdSkNFcaB
	jWmv3DAN9LY8RS/PbyCkTvLM71iw=
X-Google-Smtp-Source: AGHT+IH8eKnjr6ZkRVVSqbgMuehmp4NU2FdLC9kX4zyT2D51U5p/g2QPYQYlbGp11PVA/yq7eglPHW8ni3RJSapnj2k=
X-Received: by 2002:a2e:9859:0:b0:2d3:1bd0:6bcf with SMTP id
 e25-20020a2e9859000000b002d31bd06bcfmr1086298ljj.8.1711518640898; Tue, 26 Mar
 2024 22:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324234027.1354210-1-sashal@kernel.org> <20240324234027.1354210-34-sashal@kernel.org>
 <20240325010435.GA23652@lst.de> <ZgFfc2b6VsX_QSu4@sashalap>
 <20240326074029.GB9773@lst.de> <CAPhsuW7FREFLrAnt2iYDRoJG0d=OXm-5vy3OCJ7MOJDp2SE9GQ@mail.gmail.com>
 <a123d813-bdef-202d-2980-fb74c5a715e5@huaweicloud.com>
In-Reply-To: <a123d813-bdef-202d-2980-fb74c5a715e5@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Tue, 26 Mar 2024 22:50:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7SjGBejv11oCrX-njZ_WfyzXFc7x8X0beBRW_D3H1Ysg@mail.gmail.com>
Message-ID: <CAPhsuW7SjGBejv11oCrX-njZ_WfyzXFc7x8X0beBRW_D3H1Ysg@mail.gmail.com>
Subject: Re: [PATCH 5.10 033/238] md: implement ->set_read_only to hook into
 BLKROSET processing
To: Li Nan <linan666@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-raid <linux-raid@vger.kernel.org>, 
	Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 6:18=E2=80=AFPM Li Nan <linan666@huaweicloud.com> w=
rote:
>
> =E5=9C=A8 2024/3/26 16:46, Song Liu =E5=86=99=E9=81=93:
> > Hi Li Nan,
> >
> > Could you please look into this (back port 9674f54e41ff to older stable
> > kernels)? If there is no clean back port, I would recommend we not do
> > the back port.
> >
>
> There are some conflicts to back port, which are not related to the
> modification of this patch. If necessary, let me know and I can adapt and
> send it :)

I think it is not necessary to back port this to older kernels with conflic=
ts.
The error case exists theoretically. But we never got a bug report for it.

Thanks,
Song

