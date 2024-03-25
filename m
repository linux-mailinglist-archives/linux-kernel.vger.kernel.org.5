Return-Path: <linux-kernel+bounces-117764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D5788AF46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C880D1C3F6F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC77779CD;
	Mon, 25 Mar 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm6uYaT8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF44C92;
	Mon, 25 Mar 2024 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393501; cv=none; b=s5e4JNqPXnv5O7L76duyI/wkTO+E9mnxUpsCgE8+b0BRZGuVBAv5LarMf9hPGMqgjCToxwo9WxLDqg6JV/9KAPZktPmnp5adsUFbH9dce6YT8d1nIARXm/STv05dkHrux3QUEenmQQmp8vzayLmif2eJNm6wKGWYvXLxvblqIFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393501; c=relaxed/simple;
	bh=PCXWRBZ3KUg5nUnH8IGx9fSZU8eB9QHi4G/KXrmD2Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sp/Vq0w2DQtlOU3IloUGBJskXP7+pIkepe20BYwi454/VC6rEpc4Hl0m+xV9BPUTLLg146UdeGCz25y2e8ZQTYGBcQMNhNfiktX0I4CEVGpx1PpinZB4tF2zIP/6hEldS4TyxdrnQfChh9Z2CZcScR1mxClcJNaNUczxQrPGTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm6uYaT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2B8C433F1;
	Mon, 25 Mar 2024 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711393500;
	bh=PCXWRBZ3KUg5nUnH8IGx9fSZU8eB9QHi4G/KXrmD2Zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xm6uYaT8FsQir59HCSm1zzR2KDNdLZQRG9aCcNX3/Zh88DVwtYNAYjaFe+XgxWnoR
	 qtxYUziyHqAgnkyg8eZidqqDwzP8qTteuN9S4QK5zAXxX3JUMdaUsh2jeTjWVIU1Dg
	 T2HREYnAK1e0+V9Z3Ctjo9X5XT8WBkQYRmva8kOfmGEX9D/CAGGyI4w6tASPxtKIUK
	 LlouIXt8BIKWTJCoBvtUU0cgsmVmmx4GePPi45O3v1QEWU9iD8JyVEwnuZS+bQQqQc
	 fIE3aie2ImuX1J6wCP9UUc4zOcsCOcaUW59W70Gb1s97pZvjaVGuauDQjQHf7l2+8t
	 tKGKi8BPAi11Q==
Date: Mon, 25 Mar 2024 19:04:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH v5 7/7] iio: adc: ad7380: add support for ad738x-4 4
 channels variants
Message-ID: <20240325190441.6387056d@jic23-huawei>
In-Reply-To: <CAMknhBH0E258geq8WOKf3X0r7VngdDoSfNB5g6KTGBzEoUtMqA@mail.gmail.com>
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
	<20240319-adding-new-ad738x-driver-v5-7-ce7df004ceb3@baylibre.com>
	<20240324131059.77fa8e68@jic23-huawei>
	<CAMknhBH0E258geq8WOKf3X0r7VngdDoSfNB5g6KTGBzEoUtMqA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Mar 2024 10:01:29 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Sun, Mar 24, 2024 at 8:11=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Tue, 19 Mar 2024 11:11:28 +0100
> > Julien Stephan <jstephan@baylibre.com> wrote:
> > =20
> > > Add support for ad7380/1/2/3-4 parts which are 4 channels
> > > variants from ad7380/1/2/3
> > >
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com> =20
> > This and other patches I didn't comment on all look good to me.
> > So just those minor few bits and bobs for v6 and I'll pick this up
> > if nothing else comes in.
> > =20
>=20
> Hi Jonathan, as a reminder, this is the driver we dropped from the 6.9
> cycle. We still don't have a patch prepared for the resolution boost
> feature that may require us to reconsider some of our userspace
> interface choices here. Hopefully we can get that sorted out in the
> next 6 weeks, but I just wanted to make you aware ahead of time so
> that we don't end up in the same situation in case things don't go as
> planned again. Do you have "usual" way you prefer to handle a
> situation like this?

My preferences:

Post as an RFC with a comment on what is unresolved.
I'll still review the RFC but won't apply until you let me know it's
good to go (ideally by posting a non RFC version)

Jonathan

