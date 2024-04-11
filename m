Return-Path: <linux-kernel+bounces-140449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3416E8A14D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D9F28BE53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7170E2E3E8;
	Thu, 11 Apr 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwCgss3g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7B1E4A0;
	Thu, 11 Apr 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839249; cv=none; b=pPEYcCFc0qn18WvMW730pMwFnAQOVqVJsnAFtoc2F/ehL7eYQIXpyhnzGMcMZeydqOSa/78kfokOxqnBTcr6/0OoyzIaBK3Ndn/kYIDtK3LA4NTzTtbWlwfnsR2tr00/EnLdZqW/2PnYfIIedfZcIQLJhKsTXwTBAqtFWRxUMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839249; c=relaxed/simple;
	bh=dMnVrSeiidIlbr66OTFEWIhvA4lf9BbkyCkOQCepohg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pz6g6kDpzcnd2aQtWYRGJ6U5RmWexekRXZOQ1dZf6eRkPL6b91JbkWFrXBHUS+rC/Nwh0H3hXtVc5V9uxMt2+/JmDt8fCFKDE9Msy726TGWnFuWO/1l2WPsc/pcm2n3XYDEGjL3vtppinG6NSJgqiHQSRB6qLkg/Csd2So9ORVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwCgss3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B16C43390;
	Thu, 11 Apr 2024 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712839249;
	bh=dMnVrSeiidIlbr66OTFEWIhvA4lf9BbkyCkOQCepohg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RwCgss3gD85XT1dm6xfaAKJQjZao1iOH02Bgv8dO0LwFLJGkc0hhdhoJRkE8d17TP
	 Fqk1nUtW2FddZZgX9+2ed4X4JDDPUoaDYevu6KVeJEnrTi2IPd4+CV/+oQuDl8fWmR
	 YmEsuZhPQ6297Jrvtrlp1Hd7+96adYkOcZ40Sq8StcBAT+hD95RrxEwqOCNmyk2gFb
	 2a+4NN5zlo3enF5mkIASp9aaui1L0Yon42iN8ceCEbilGgcTwHBx8nBnNwnfUJm+jh
	 7mNyIa/z/+VzP8H5qbfli/GRi1VuBp+dc1UFWMzJHE2GC2soN5wCCB6A6Nn6K4Oq5h
	 v/i7VWKg1ndiQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so32112671fa.3;
        Thu, 11 Apr 2024 05:40:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzsV0BkhApoffQSGxykStMUQQvGDns/ANkE5kGkrTfdhxRxGCPniu+81kVArI7DMUAsxwvhvRA3Dnj53pP82HaADXUNFNlVhtZ4UNd6xdPtGtcKEERmft1QneZBm+trA8fVTMwJsTQFw==
X-Gm-Message-State: AOJu0Yy8tawn2x4C4rwf14MsbFUTVakT7f1W2xfT0V/hAkNm5GU/xxgY
	ZyOpjZIuVZ+LkJSNbgBCOawaxrFcRZjVOl+xcLEjrN088c7dkYKtOo2M/Ie/0DbcVudZhpK39QL
	PYJCXW+RCtcckyF7WvC262Prg8g==
X-Google-Smtp-Source: AGHT+IHWRzCQdp4OTkI2oKPiNczWNw1xHfbRN/I/I/y+rHBhTtEi99cXz1F4/SyFjaIEJKFCI4yFigdnDiL/oTSAN54=
X-Received: by 2002:a2e:9e51:0:b0:2d8:6606:9e61 with SMTP id
 g17-20020a2e9e51000000b002d866069e61mr3660614ljk.48.1712839247829; Thu, 11
 Apr 2024 05:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411154858.522858c5@canb.auug.org.au>
In-Reply-To: <20240411154858.522858c5@canb.auug.org.au>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Apr 2024 07:40:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJy0tMYEv_JMEPAeHPiJsoPC=0_Tzuq0wj5pGSHKb5BOw@mail.gmail.com>
Message-ID: <CAL_JsqJy0tMYEv_JMEPAeHPiJsoPC=0_Tzuq0wj5pGSHKb5BOw@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the devicetree tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:49=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi all,
>
> The following commit is also in the pci tree as a different commit
> (but the same patch):
>
>   680ee54f272e ("dt-bindings: PCI: rockchip,rk3399-pcie: add missing maxI=
tems t
> o ep-gpios")

Now dropped.

>
> This is commit
>
>   267870fdbd01 ("dt-bindings: PCI: rockchip,rk3399-pcie: Add missing maxI=
tems to ep-gpios")
>
> in the pci tree.
>
> --
> Cheers,
> Stephen Rothwell

