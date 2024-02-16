Return-Path: <linux-kernel+bounces-68549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CBA857C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65A21F21D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28BA78B60;
	Fri, 16 Feb 2024 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwMlX+4h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F177F32;
	Fri, 16 Feb 2024 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084508; cv=none; b=PRwixDBq+/OccRfOpWBmHDbazwAgVEaxgHsYzDy8/2Ls9wqVjTa1uzEgpczGE/ZZV/VGM3dP1DRu8+izuV9Oh1ZXyBNrwHj47rOpvJWt5d85pp5s/NzjxBkT77Re7j1gzeTJXtC91lw5wAQ0hyxJt+1ijTYpIU6V8BUOQMunOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084508; c=relaxed/simple;
	bh=SA/YJ6YmFTOGSDTYSeuOE5s7qE3eDZedvAeQG7HfBNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9LDmpim4UDAxNzuqteU9rrGwAtWlZ5WOxR6Ss+s7xPskiwPCd3BMosdBQzn4RVEDQe6q5P7UEgCrWmVQXELjmKhcP2gJ+Gbxj/GdbPWmF0JHijR27r9GcZ5M5snrpdDCCAHY0AH5fLLDIKX4cBKAZAvHmoiEqz+s6VC0PyLDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwMlX+4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F07C433C7;
	Fri, 16 Feb 2024 11:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708084508;
	bh=SA/YJ6YmFTOGSDTYSeuOE5s7qE3eDZedvAeQG7HfBNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dwMlX+4hqM+35ItC8oNX4wJDYCVxbor87inn8l4hyq0tf2GMmp8agL4soLMrlJJqM
	 WxiwKGHpH0Mvj2aXIh8NrBeR6cPI8OBJaWMOiAa7lIPG/ZXhCz/ibiRdKkTFmFvINX
	 ofgrzg5VKifW+lgTUjoOqkdZm53MDOuFiKHDqBCcXOIOBzYGML7Vq8+6V/ArIxpjOn
	 0sKCbSLY4VBA9matMdN4zZroOun1234EwOHTaaLYx7EGGu10clW6gz2BRnB8nO+BR3
	 8Wj4PQIvXKek9vf7HGGxpHTFqJLKiNn1YEDlH6p1mlyyyq9466UlWHid1j5CxEY2Yq
	 rQddtYw1gETJg==
Date: Fri, 16 Feb 2024 11:54:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/3] docs: iio: add documentation for device buffers
Message-ID: <20240216115455.676a7947@jic23-huawei>
In-Reply-To: <CAMknhBFD54XotZrGeZK_48G=FDOWAr1vAf0pQwO=8o05jsTFRA@mail.gmail.com>
References: <20240213081720.17549-1-ramona.gradinariu@analog.com>
	<20240213081720.17549-3-ramona.gradinariu@analog.com>
	<CAMknhBFD54XotZrGeZK_48G=FDOWAr1vAf0pQwO=8o05jsTFRA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


A few follow up comments on your David's review
Anything I deleted didn't need a comment as all made sense to me!

> 
> > +to 0, for devices with a single buffer.  
> 
> Is /sys/bus/iio/devices/deviceX/buffer (without the Y) for backwards
> compatibility?

Yes. For these docs I'd not mention it. New software should be aware of multiple
buffers being possible and not use it. Same is true of the scan_elements directory.
If we really want to mention it, say buffer/ and scan_elements are for backwards
compatibility and should not be used in new userspace software.

They aren't going anywhere, but better people start from a multibuffer world!

> 
> > +
> > +Read / Write attribute which states the total number of data samples (capacity)
> > +that can be stored by the buffer.
> > +
> > +Enable
> > +------
> > +
> > +Read / Write attribute which starts / stops the buffer capture. This file should
> > +be written last, after length and selection of scan elements.  
> 
> Could be useful here to mention that writing a non-zero value here to
> enable the buffer may result in an error, such as EINVAL, e.g. if an
> invalid configuration was selected, like choosing a combination of
> scan elements that don't match one of the valid scan masks.

Be careful to not refer to matching.  Could be a subset.  I'd refer to
"an unsupported combination of channels" or something like that.


> > +directory. The scan elements attributes are presented below.
> > +
> > +**_en**
> > +
> > +Read/ Write attribute used for enabling a channel. If and only if its value
> > +is non zero, then a triggered capture will contain data samples for this
> > +channel.
> > +
> > +**_index**
> > +
> > +Read-only positive integer attribute specifying the position of the channel in  
> 
> Isn't 0 a valid scan index? So non-negative? Or unsigned?

Yes - unsigned would be my preference.

> 
> > +the buffer. Note these are not dependent on what is enabled and may not be
> > +contiguous. Thus for user-space to establish the full layout these must be used
> > +in conjunction with all _en attributes to establish which channels are present,
> > +and the relevant _type attributes to establish the data storage format.
> > +  
> 
> It would also be nice to get an example on the binary layout for
> something that has multiple channels enabled. In particular with the
> data alignment, e.g. when you have a 16-bit word followed by a 64-bit
> word.
> 

Agreed - the padding is sometimes not what people expect.

> 
> > +**_type**
> > +
> > +Read-only attribute containing the description of the scan element data storage
> > +within the buffer and hence the form in which it is read from user space. Format
> > +is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift], where:
> > +
> > +- **be** or **le** specifies big or little endian.
> > +- **s** or **u**, specifies if signed (2's complement) or unsigned.
> > +- **bits**, is the number of valid data bits.
> > +- **storagebits**, is the number of bits (after padding) that it occupies in the
> > +  buffer.
> > +- **repeat**, specifies the number of bits/storagebits repetitions. When the
> > +  repeat element is 0 or 1, then the repeat value is omitted.
> > +- **shift**, if specified, is the shift that needs to be applied prior to
> > +  masking out unused bits.
> > +
> > +For example, a driver for a 3-axis accelerometer with 12 bit resolution where
> > +data is stored in two 8-bits registers as follows:
> > +
> > +.. code-block:: bash  
> 
> Doesn't look like this should use "bash" styling.
> 
> > +
> > +          7   6   5   4   3   2   1   0
> > +        +---+---+---+---+---+---+---+---+
> > +        |D3 |D2 |D1 |D0 | X | X | X | X | (LOW byte, address 0x06)
> > +        +---+---+---+---+---+---+---+---+
> > +
> > +          7   6   5   4   3   2   1   0
> > +        +---+---+---+---+---+---+---+---+
> > +        |D11|D10|D9 |D8 |D7 |D6 |D5 |D4 | (HIGH byte, address 0x07)
> > +        +---+---+---+---+---+---+---+---+
> > +
> > +will have the following scan element type for each axis:
> > +
> > +.. code-block:: bash
> > +
> > +        $ cat /sys/bus/iio/devices/iio:device0/buffer0/in_accel_y_type
> > +        le:s12/16>>4
> > +
> > +A user space application will interpret data samples read from the buffer as two
> > +byte little endian signed data, that needs a 4 bits right shift before masking
> > +out the 12 valid bits of data.  
> 
> Is it always assumed that scan data is `raw` and needs to be
> multiplied by `scale` for that channel to convert it to SI (or IIO
> standard) units?

Definitely by far the most common case but there are a few exceptions where
there isn't a _raw attribute but only an _input one where the assumption is
processed data.  Tricky to mention that here without adding complexity.
Maybe just add some weasel words to hint there are corners not covered by
this doc.

> 
> > +
> > +Please see Documentation/ABI/testing/sysfs-bus-iio for a complete description of
> > +the attributes.  
> 
> Is it also worth mentioning
> ``Documentation/ABI/testing/sysfs-bus-iio-dma-buffer`` here?

I'd not do that until we have a section for these docs on dma buffers which
are different in a bunch of ways. Would just be a potential source of
confusion.

Jonathan
  


