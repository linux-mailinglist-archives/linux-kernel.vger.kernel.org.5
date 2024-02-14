Return-Path: <linux-kernel+bounces-64627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 928BF854104
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08BEBB27448
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A9F4683;
	Wed, 14 Feb 2024 01:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ETcEgzvH"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791C565C;
	Wed, 14 Feb 2024 01:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873196; cv=none; b=EN9BL+CK5QaEdeEtsQS0WDlvq9cyLEhKt8xwMKzHDbd1rei1M9HBJX8zzggyLIbd9dA5LQ+sa06aPVfKaIJ8aIhIpItpwU38ysb3ZN/v0qXtVU578khsiDHm8FLS/JL07mFoibVFfKbVckfBMVr4LpwD/qa647VvzeGD7ZsI3Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873196; c=relaxed/simple;
	bh=IU2OyFsQSVkAVr6UneiocCkeAITKZ3ZEmhwNcNy7hFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aQZE4o32MvYgoKlQJPYLK+wQuTKy8ieTSjzEB2TrWLfefj6S1mP6ENOoZpFg721soaASvWWfESlLeedGWuz6fd9G6K3/R4ReR1esV0BkxpMQJjw9AHfM3sOHCpJR1vlqUeQdVUTnOX6vJrqXobU292MzIoKOPtWPfsFRfNr79TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ETcEgzvH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=/wMGEfoDa+2xdWbURYcG40lcr0z9t7tTiyBtN2BKVpU=; b=ETcEgzvH0k7Uj7GCd+90TYaDFo
	pUXj2sRb2o08kjMHhb2m8ZuOzz9rpX+y6ZmICED6qp5cvzotnClUdKn7NhwN+WR1qpwgOHntHmpTO
	yZ8/cldY/aQ9OATNcOiWnKiW8c64jq/1Ffn8knWKuXk6LYFD4u8dWYy2vMHQS6jiohCGcH1DEvfcc
	GZKTXEfgmXSw1LW/rv31gDepBIl9HHLCLxsYW3RATGtT74rKtoHEDGewncNJYb5FwosgB5mEVwEE0
	q8vncAtOd4e5aXWQZcK+OT2Ss6rMUYAdhlnzIKLw+8u0Q72iGFMY9fD4TCHNsKQZfiuM6YrvyQP8H
	GJMFfEpw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra3pp-0000000BQ1J-3eYZ;
	Wed, 14 Feb 2024 01:13:13 +0000
Message-ID: <6076dba6-496e-4cae-be76-a30e006d3b77@infradead.org>
Date: Tue, 13 Feb 2024 17:13:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] docs: iio: add documentation for device buffers
Content-Language: en-US
To: Ramona Gradinariu <ramona.gradinariu@analog.com>, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, linux-iio@vger.kernel.org
References: <20240213081720.17549-1-ramona.gradinariu@analog.com>
 <20240213081720.17549-3-ramona.gradinariu@analog.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240213081720.17549-3-ramona.gradinariu@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/24 00:17, Ramona Gradinariu wrote:
> Add documentation for IIO device buffers describing buffer
> attributes and how data is structured in buffers using
> scan elements.
> 
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> ---
> changes in v4:
>  - documented multiple buffer support
>  - reworked scan elements section
>  - added reference to ABI docs
>  Documentation/iio/iio_devbuf.rst | 125 +++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst      |   1 +
>  2 files changed, 126 insertions(+)
>  create mode 100644 Documentation/iio/iio_devbuf.rst
> 
> diff --git a/Documentation/iio/iio_devbuf.rst b/Documentation/iio/iio_devbuf.rst
> new file mode 100644
> index 000000000000..e99143efb4d7
> --- /dev/null
> +++ b/Documentation/iio/iio_devbuf.rst
> @@ -0,0 +1,125 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============================
> +Industrial IIO device buffers
> +=============================
> +
> +1. Overview
> +===========
> +
> +The Industrial I/O core offers a way for continuous data capture based on a
> +trigger source. Multiple data channels can be read at once from
> +/dev/iio:deviceX character device node, thus reducing the CPU load.
> +
> +Devices with buffer support feature an additional sub-folder in the

folder or directory?

> +/sys/bus/iio/devices/deviceX/ folder hierarchy, called bufferY, where Y defaults

folder or directory?

> +to 0, for devices with a single buffer.
> +
> +2. Buffer attributes
> +====================
> +
> +An IIO buffer has an associated attributes directory under

directory or folder?

Just be consistent, please.

> +/sys/bus/iio/iio:deviceX/bufferY/. The attributes are described below.
> +

What are the corresponding attribute names?

> +Length
> +------
> +
> +Read / Write attribute which states the total number of data samples (capacity)
> +that can be stored by the buffer.
> +
> +Enable
> +------
> +
> +Read / Write attribute which starts / stops the buffer capture. This file should
> +be written last, after length and selection of scan elements.
> +
> +Watermark
> +---------
> +
> +Read / Write positive integer attribute specifying the maximum number of scan
> +elements to wait for.
> +
> +Poll will block until the watermark is reached.
> +
> +Blocking read will wait until the minimum between the requested read amount or
> +the low water mark is available.

           watermark
> +
> +Non-blocking read will retrieve the available samples from the buffer even if
> +there are less samples then watermark level. This allows the application to

                          than the

> +block on poll with a timeout and read the available samples after the timeout
> +expires and thus have a maximum delay guarantee.
> +
> +Data available
> +--------------
> +
> +Read-only attribute indicating the bytes of data available in the buffer. In the
> +case of an output buffer, this indicates the amount of empty space available to
> +write data to. In the case of an input buffer, this indicates the amount of data
> +available for reading.
> +
> +Scan elements
> +-------------
> +
> +The meta information associated with a channel reading placed in a buffer is

That line gives me -ENOPARSE. Can it be improved?

> +called a scan element. The scan elements are configurable per buffer, thus they
> +are exposed to userspace applications via the /sys/bus/iio/iio:deviceX/bufferY/
> +directory. The scan elements attributes are presented below.
> +
> +**_en**
> +
> +Read/ Write attribute used for enabling a channel. If and only if its value
> +is non zero, then a triggered capture will contain data samples for this

      non-zero,

> +channel.
> +
> +**_index**
> +
> +Read-only positive integer attribute specifying the position of the channel in
> +the buffer. Note these are not dependent on what is enabled and may not be
> +contiguous. Thus for user-space to establish the full layout these must be used

                        userspace
as above.

> +in conjunction with all _en attributes to establish which channels are present,
> +and the relevant _type attributes to establish the data storage format.
> +
> +**_type**
> +
> +Read-only attribute containing the description of the scan element data storage
> +within the buffer and hence the form in which it is read from user space. Format
> +is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift], where:
> +
> +- **be** or **le** specifies big or little endian.
> +- **s** or **u**, specifies if signed (2's complement) or unsigned.

         no comma  ^

> +- **bits**, is the number of valid data bits.

    no comma ^

> +- **storagebits**, is the number of bits (after padding) that it occupies in the

      no comma      ^

> +  buffer.
> +- **repeat**, specifies the number of bits/storagebits repetitions. When the

  no comma     ^

> +  repeat element is 0 or 1, then the repeat value is omitted.
> +- **shift**, if specified, is the shift that needs to be applied prior to

  no comma    ^

> +  masking out unused bits.
> +
> +For example, a driver for a 3-axis accelerometer with 12 bit resolution where

                                                         12-bit

> +data is stored in two 8-bits registers as follows:

                         8-bit            is as follows:

> +
> +.. code-block:: bash
> +
> +          7   6   5   4   3   2   1   0
> +        +---+---+---+---+---+---+---+---+
> +        |D3 |D2 |D1 |D0 | X | X | X | X | (LOW byte, address 0x06)
> +        +---+---+---+---+---+---+---+---+
> +
> +          7   6   5   4   3   2   1   0
> +        +---+---+---+---+---+---+---+---+
> +        |D11|D10|D9 |D8 |D7 |D6 |D5 |D4 | (HIGH byte, address 0x07)
> +        +---+---+---+---+---+---+---+---+
> +
> +will have the following scan element type for each axis:
> +
> +.. code-block:: bash
> +
> +        $ cat /sys/bus/iio/devices/iio:device0/buffer0/in_accel_y_type
> +        le:s12/16>>4
> +
> +A user space application will interpret data samples read from the buffer as two

     userspace
for consistency.
                                                                             as two-

> +byte little endian signed data, that needs a 4 bits right shift before masking

        little-endian

> +out the 12 valid bits of data.
> +
> +Please see Documentation/ABI/testing/sysfs-bus-iio for a complete description of
> +the attributes.
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index db341b45397f..206a0aff5ca1 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -8,6 +8,7 @@ Industrial I/O
>     :maxdepth: 1
> 
>     iio_configfs
> +   iio_devbuf
> 
>  Industrial I/O Kernel Drivers
>  =============================
> --
> 2.34.1
> 
> 

-- 
#Randy

