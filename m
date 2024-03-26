Return-Path: <linux-kernel+bounces-118569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45CB88BCBD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3F61F3551E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104BD3E476;
	Tue, 26 Mar 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGQgDsUz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAEB17BA6;
	Tue, 26 Mar 2024 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442814; cv=none; b=eC496dHncvMtlPZO5NQi2o4F0qZ3+e/6c2K5bxGn6PnZ1VV8IudWSIIyHMSS3P+Kzw1RQqKg/8K2WzpXP2YKnrxRy/VDdTE7p7wMLItWqBBmkp0A5XvVUfQSQ4SWLnN2gWn91teQSurP2xCk2fkILvTeXnkWWSL+tNdTyuZI2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442814; c=relaxed/simple;
	bh=D5m0ZG9RCn4nBm+14VdPQyaCMy22RRj8GUHoQnlgo58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBAukXECWJi2E7r5gDfgIyflbh6Sj8PBNucfo54lR6s3+eA0/pi+7CP7chyzr+cFoIxzMsdd0uyZYbMil/TaUkB1+7WKMIjEG6JQ9Ewb0TrEYUKlfHI2zJIjgQYXXuv7uLfvuCspsADnL+wdq8NAaI3tdyUCb6rmiWM163OleyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGQgDsUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E4BC43390;
	Tue, 26 Mar 2024 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711442813;
	bh=D5m0ZG9RCn4nBm+14VdPQyaCMy22RRj8GUHoQnlgo58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MGQgDsUzOh85KnHUXSzUCF4JBzoNz0X/+wL6VV+TkvqUpFclLdvHhdHWI931bS3HM
	 7J2pB9RXs6V6jBHYMJQDuaE/9ecfso72XIRiYkTXalNdydF34/iWqaZGU2W5U08O1R
	 JZZ25FrnP3g6bYmTBc2RNHkpxax3guUf6Gggs+9NF5y/DAI1V+VJNgmLAmXeSY2Mh6
	 GcUbY07QeHx2Vp17h5oC+EegH+PY6QOo27eHPP+lM/hI8sIT7sCaU6CCF9xyQ0q6i/
	 2w5Vb417xg3GZWbp+mRcVauDW28h/QvRKn/NOWVRoEM58DB5Eqe14aXmV3tARLdtGU
	 fX/jmT1lmIRPw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d68651e253so84912521fa.0;
        Tue, 26 Mar 2024 01:46:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWynWRe7ScWUfkKQTb4hHojhvl7lFU1aZOJXVdQU1RxIs5Bj/1Fu9j45J2DUkPjVqKtHenZwNAh1NotRE6bKFQ0DLfjz4PLI6IZsSBt+zquVOJUkexx4lSEvI5g41VM6x8JN0uRE7O0TtFqXmTITpnrsr9Dp5hU+PFu/7acs5IKog==
X-Gm-Message-State: AOJu0YxFxpEB4EEE3PzyqVGTL9PHrSdR+AC7NktZsuNvBWUmXNvhw6VK
	bwXcfQsfcoizeQNJyms0Nsl/RFRY/5w9QI4xYT5K8ufOqmsV/I8NRXFAVLoxQ2MJXULpMLskR9r
	AIPEn/C/YREzWUMnNj3rqDp8lvw8=
X-Google-Smtp-Source: AGHT+IHTYZhU4AuzglO/Tss8SBqXtC85d+iybnnr6HV5QnZ2k+bE8F3ypVPeOaFi/iVVRvayMUjGaymwh3LLa5f0OmE=
X-Received: by 2002:a2e:a4ae:0:b0:2d4:a925:d5bc with SMTP id
 g14-20020a2ea4ae000000b002d4a925d5bcmr5329014ljm.16.1711442812199; Tue, 26
 Mar 2024 01:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324234027.1354210-1-sashal@kernel.org> <20240324234027.1354210-34-sashal@kernel.org>
 <20240325010435.GA23652@lst.de> <ZgFfc2b6VsX_QSu4@sashalap> <20240326074029.GB9773@lst.de>
In-Reply-To: <20240326074029.GB9773@lst.de>
From: Song Liu <song@kernel.org>
Date: Tue, 26 Mar 2024 01:46:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7FREFLrAnt2iYDRoJG0d=OXm-5vy3OCJ7MOJDp2SE9GQ@mail.gmail.com>
Message-ID: <CAPhsuW7FREFLrAnt2iYDRoJG0d=OXm-5vy3OCJ7MOJDp2SE9GQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 033/238] md: implement ->set_read_only to hook into
 BLKROSET processing
To: Christoph Hellwig <hch@lst.de>, linux-raid <linux-raid@vger.kernel.org>, 
	Li Nan <linan666@huaweicloud.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Li Nan,

Could you please look into this (back port 9674f54e41ff to older stable
kernels)? If there is no clean back port, I would recommend we not do
the back port.

Thanks,
Song

On Tue, Mar 26, 2024 at 12:40=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Mon, Mar 25, 2024 at 07:26:43AM -0400, Sasha Levin wrote:
> > On Mon, Mar 25, 2024 at 02:04:35AM +0100, Christoph Hellwig wrote:
> >> How did we end up backporting all these block layer API changes?
> >
> > They were brought in as a dependency for 9674f54e41ff ("md: Don't clear
> > MD_CLOSING when the raid is about to stop").
> >
> > It's possible to work around bringing them during backport, but I
> > preferred to bring the dependencies instead.
>
> I really don't see what these giant backports bring us.  If people
> want all the changes they'd just be better off on a modern kernel
> rather than these frankenkernels.  The automatic backporting is
> gettind way out of hand.  If the MD maintainers want
> 9674f54e41ff, maybe they can send a tailor made backport?

