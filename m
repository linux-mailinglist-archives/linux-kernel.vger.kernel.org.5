Return-Path: <linux-kernel+bounces-25317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78BE82CD6B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB22283E07
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DE7184F;
	Sat, 13 Jan 2024 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hbhhtt8o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDCE136A;
	Sat, 13 Jan 2024 15:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0D8C433C7;
	Sat, 13 Jan 2024 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705158955;
	bh=gi7MLkfj49jWwmlYtMReK8oYZtLf7aFm+9eg8JZZ/6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hbhhtt8oHn9r0LCm2XOzjNQWqZk4/PVY9xB40qPCKV7qVzcuYngvfOro+l0fQP84i
	 OPos3yjOpeQRI0LwVE6AFGOVRDdLa2/78xWsB80esbUh2eFbMDoATl5x3L+XpECcle
	 /FOVvyW3JF4ff2VF9J88a3FEbKRYEsu4HDW6TIL+gptWHiyoQeoDr9ZDMo9kqfMs1F
	 o0joNQQaLbXTAetjOQ/dzt3X4GglBjXBmAwSRbGl4hYN2p7ChqFSiNfmeLcMBLKplD
	 v1KofWhaEGp7Ls/p6geWQLb1Uq6zBXyymaVtYYS8+4qd1cW73q4XkK1Aipf5ckHt0e
	 A3O7uPM+rahfg==
Date: Sat, 13 Jan 2024 15:15:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christian Eggers <ceggers@arri.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: light: as73211: add support for as7331
Message-ID: <20240113151549.2be0463e@jic23-huawei>
In-Reply-To: <4555448.LvFx2qVVIh@n95hx1g2>
References: <20240103-as7331-v2-0-6f0ad05e0482@gmail.com>
	<20240103-as7331-v2-3-6f0ad05e0482@gmail.com>
	<4555448.LvFx2qVVIh@n95hx1g2>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > +struct as73211_data;
> > +
> > +/**
> > + * struct spec_dev_data - device-specific data
> > + * @intensity_scale:  Function to retrieve intensity scale values.
> > + * @channel:          Device channels.
> > + * @num_channels:     Number of channels of the device.
> > + */
> > +struct spec_dev_data {  
> 
> I would call it as73211_spec_dev_data (is the C++ One Definition Rule relevant for
> the kernel?)
> 
> > +	int (*intensity_scale)(struct as73211_data *data, int chan, int *val, int *val2);
> > +	struct iio_chan_spec const *channel;  
> s/channel/channels/
> 
> > +	int num_channels;
> > +};
Both good suggestions so I've applied them both and pushed out a new version of
the togreg tree.

Thanks,
Jonathan

