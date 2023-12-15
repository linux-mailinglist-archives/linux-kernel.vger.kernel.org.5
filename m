Return-Path: <linux-kernel+bounces-474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3B08141B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268C7284627
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A127846C;
	Fri, 15 Dec 2023 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rfKLXTCp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C04C8F5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d337dc9697so2242795ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702620723; x=1703225523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wOXaGzvgVP+Ia0/UDMbOQwQQtbhyKSmRbsrbtlBwUSY=;
        b=rfKLXTCpBy0CTPhaUxeUrVZrL7VJ7aDDv73ggmustN9iYGfW8A1eerYw1F0dqOmF14
         ViJOIRGznCNtjK3fM3Pn5qVJ9q/dTR0Vk0AKG/SBaNVprJczeGyLkGNQz4sFg891wCic
         4OvXEnVm5JNvL+pPspiIbplA67+yuBIkd7huLE76awZyf5pwfa5YWfzAT+/n6mWHjrRz
         04ECnfZmkWzOOB8O81XMNzrSdyUSn4+HOwFT7mzZpFzEb741y0XUYB3iUENeteRyUHJb
         9IU4Mxgknd8UhP1Yq2KMqg0HKCnDBIYy/8ajppFvBpdG8pWSR1ch5oOcWfMiS5popY8z
         I+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702620723; x=1703225523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOXaGzvgVP+Ia0/UDMbOQwQQtbhyKSmRbsrbtlBwUSY=;
        b=pdYMRNAbA6d6yhgIeSKynh/7mw6Ju9vj0F5Bx/ldNs8YGFQf3wgQhst7hw4Yo0/PAJ
         UuYGMNnjviuBmd8fYrOEucAZDG2E5uaV57Vf8rEdX6Tkma6QhIO2Myx6pmrd+h+EWfyp
         lo6b5R1p3l82sBzdZ7vRCAcVNqcu3p1MG2gXteqQQzs/6AtRGoOgpg4AMev0IqZP8euK
         0C7Es+OztlGLpADhwtrj8dnZBcGsvsTaSOsX2iVHxqi4WyJDWXf2kMS4C+icx+vtaUaU
         +Qnmx5XPhcXIElFkFghVEYditUVCgyU1t8n00dwhJrfXC40URXxrIM+Y/B9x4XfF/+9I
         TazA==
X-Gm-Message-State: AOJu0YxW1vfFoBJwodGixL8SX6iS4Pe8RqqPuirwt06vgNSgJCUtmp5f
	IzJEnVwfBo/StGm6dc8yYkEMMA==
X-Google-Smtp-Source: AGHT+IGhqJAmOcth9R/b7SX6bbjFFFe/G4w8UHqroHFWCY7yrLdPhjQ7splkIAlcuKZR2bRyx2aK3Q==
X-Received: by 2002:a17:903:2cc:b0:1d3:488e:a4b7 with SMTP id s12-20020a17090302cc00b001d3488ea4b7mr6255436plk.128.1702620723282;
        Thu, 14 Dec 2023 22:12:03 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902ea0d00b001d1d27259cesm13370464plg.180.2023.12.14.22.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 22:12:02 -0800 (PST)
Date: Fri, 15 Dec 2023 11:41:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <harald.mommer@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Harald.Mommer@gmail.com,
	quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [virtio-dev] [RFC PATCH v1 3/3] SPI: Add virtio SPI driver (V4
 draft specification).
Message-ID: <20231215061159.hc2pkdm3pwvdbyys@vireshk-i7>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
 <20231027161016.26625-4-Harald.Mommer@opensynergy.com>
 <20231213095339.rurjk6mxjeap7tye@vireshk-i7>
 <97c55071-642c-45bd-8c70-ecdcc3e48b75@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97c55071-642c-45bd-8c70-ecdcc3e48b75@opensynergy.com>

+ Michael and Cornelia

Hello Harald,

On 14-12-23, 17:52, Harald Mommer wrote:
> On 13.12.23 10:53, Viresh Kumar wrote:
> > On 27-10-23, 18:10, Harald Mommer wrote:
> > > +	struct virtqueue *vqs[VIRTIO_SPI_QUEUE_COUNT];
> > There is no need to make this configurable since the specification
> > fixes it to 1. You can simplify this a bit.
> Yes, i2c makes it "struct virtqueue *vq;" and this makes also sense here.

Please add a blank line before and after your responses. It becomes very
difficult otherwise and one may end up missing some of the comments,
especially with bottom posting.

> > > +	/*
> > > +	 * Simple implementation: Process message by message and wait for each
> > > +	 * message to be completed by the device side.
> > > +	 */
> > And why not send all the messages once and speed this thing up ? Just
> > like how I2C does it.
> 
> Because this is more complicated when I looked into i2c. First I wanted to
> have a working driver which can be delivered to our internal project. This
> internal project has no sophisticated performance requirements. Better to
> have something for the internal project when you have to deliver to them
> instead of having nothing at all because you wanted initially too much
> nobody asked for.
> 
> To minimize risk and not to extend the scope of my existing tickets too much
> I will address your comment not by a code change but by a comment in the
> code. Nothing is broken, this is an optimization only.

I understand that the current implementation is good enough for your
use case. But you are trying to upstream this and there are more users
who will end up using it. Qualcomm is one for example, who is
upstreaming the spec.

I think the changes required shouldn't be huge and can be taken care
of easily, unless there is a big blocker. Given that I2C already
implements it that way, I think it would be easier to do it now from
the first implementation itself, since it isn't already merged.

Please see if that can be done, or I will write an incremental patch
for this.

> > > +#ifdef DEBUG
> > Drop all temporary things please.
> 
> This is an RFC patch, not an integration request. Until the spec is accepted
> by OASIS the driver is code under development tracking a moving target and
> will have to remain RFC. Removing debug aids is something to be addressed
> before we are going for non-RFC.

Since this is up for review, I would have liked to see a version
closer to what is supposed to be merged. It doesn't harm to keep all
such changes in a separate commit which you don't post to LKML. That
makes it easier for reviewers to go through stuff without getting
distracted with small things.

> > > +static void virtio_spi_read_config(struct virtio_device *vdev)
> > > +{
> > > +	struct spi_master *master = dev_get_drvdata(&vdev->dev);
> > > +	struct virtio_spi_priv *priv = vdev->priv;
> > > +	u16 bus_num;
> > > +	u16 cs_max_number;
> > > +	u8 support_delays;
> > > +
> > > +	bus_num = virtio_cread16(vdev,
> > > +				 offsetof(struct virtio_spi_config, bus_num));
> > > +	cs_max_number = virtio_cread16(vdev, offsetof(struct virtio_spi_config,
> > > +						      chip_select_max_number));
> > > +	support_delays =
> > > +		virtio_cread16(vdev, offsetof(struct virtio_spi_config,
> > > +					      cs_timing_setting_enable));
> > Instead of reading values separately, you can also read the entire
> > configuration structure in a single call to virtio_cread_bytes.
> 
> Cannot.
> 
> Virtio spec 4.2.2.2 Driver Requirements: MMIO Device Register Layout
> 
> ...
> For the device­-specific configuration space, the driver MUST use 8 bit wide
> accesses for 8 bit wide fields, 16 bit wide and aligned accesses for 16 bit
> wide fields and 32 bit wide and aligned accesses for 32 and 64 bit wide
> fields.

Fair point. I wonder if other implementations have got it wrong now.

Michael / Cornelia,

What's the right thing to do here ? I am not sure why that
driver-normative was even required for MMIO.

> > > +static int virtio_spi_probe(struct virtio_device *vdev)
> > > +{
> > > +	struct virtio_spi_priv *priv;
> > > +	struct spi_master *master;
> > > +	int err;
> > > +	u16 csi;
> > > +
> > > +	err = -ENOMEM;

I was only suggesting to use:

int err = -ENOMEM;

:)

> > Why not do it with the definition itself ?
> 
> Replaced in the meantime all definitions containing the word "master" by the
> word controller when they existed so I'm not using the compatibility layer
> containing preprocessor definitions any more. For some reason there is no
> function spi_alloc_controller() so this here is the only one which cannot be
> replaced. It's already the function.
> 
> Update: In newer kernels there is now an identical spi_alloc_host(). Why now
> host instead of controller?

IIUC, both master/slave are called controllers here.

And with below commit:

commit b8d3b056a78d ("spi: introduce new helpers with using modern naming")

Master => Host
Slave => Target

I guess eventually Master and Slave interfaces will be removed, and we
are in the transition phase for now.

> I get mad.A lot of people still use
> spi_alloc_master().But this is a new driver so a change to spi_alloc_host()
> is most probably required.

Right.

> > > +	master = spi_alloc_master(&vdev->dev, sizeof(struct virtio_spi_priv));
> > sizeof(*priv)
> 
> Some people do it this way, others the other way.

Documentation/process/coding-style.rst

14) Allocating memory

...

	p = kmalloc(sizeof(*p), ...);

The alternative form where struct name is spelled out hurts readability and
introduces an opportunity for a bug when the pointer variable type is changed
but the corresponding sizeof that is passed to a memory allocator is not.

> > and there is a devm_* variant too that you can use.
> Not that I'm aware of now.There is spi_alloc_host() as alternative
> frequently used now.

Yeah, that also has a devm_* variant.

Thanks.

-- 
viresh

