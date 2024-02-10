Return-Path: <linux-kernel+bounces-60510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE1E8505E0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4317C1F24B49
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BAB5D48C;
	Sat, 10 Feb 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAWob1/N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C315C5E0;
	Sat, 10 Feb 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707588207; cv=none; b=J4yv/006ltf/fF+mvveXDt4aNg5bD3GT/EqdIhM2zQB/fEUi1rX+6Z3LKPcW6ltUTVKuGDsYP0Ts8ay7PJ27ItZLjlLTK8hFz53ZZLtPrxgiTfWT0fgoBFvOvwgj+V08Np9kLnpsrZtIe6CUQKcLuUkWPStrbEK3mSR2kaTcTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707588207; c=relaxed/simple;
	bh=F/HvI1bBKYZ8GxyFLiKJuElMro7KT5JI+q4W1Ocubyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGqq/pBXnHAy64BZwtsH9DbQF0qlpFKzyzzXEwC88v7VSWG7Ft2seYn0qVNnmTi7f60GTy25iCYXwT+BO2H/MpUkFiRDvxHLor2Vhph6WJThqovsLC6yLNr7LOjUeNJ9jIiu6Td/CQGAr7TNqrpaype0RPE1HOxUMfwue77YeEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAWob1/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895D7C433F1;
	Sat, 10 Feb 2024 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707588207;
	bh=F/HvI1bBKYZ8GxyFLiKJuElMro7KT5JI+q4W1Ocubyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vAWob1/NGPF9cZTUOi+RAvQufsPwRWHo06J78soZ9OTgc4P1DVDuZ6qGpr8u+HjuZ
	 Cpw939x20zmwT3A4i+3DXrQ9Qwhy6F6QILcEeMTBHOEO+026iq6H+Lg89SeKOwMqq5
	 LslFtzxgwoqPo9Z69LZ0Be7Q0KK7/kBx6izVCyJ2lufBsMduzzH6ZzHHy+ZKBQhVPK
	 9DMMK4qRWzXUILQhcqoZaNIYaoX8ljMlPLLgfl6FYspu4FFuccbU1X6mJ6s/X3IbHx
	 4NlCiDNMAaGKBXX7GBe2ao2THnxpJJTeM4tcDB10VQr6/k6SxqR83lp4vKOJlsOk6H
	 79bHt3wNSmuVw==
Date: Sat, 10 Feb 2024 18:03:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>
Cc: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] docs: iio: add documentation for device buffers
Message-ID: <20240210180315.78ee8135@jic23-huawei>
In-Reply-To: <20240208100126.183697-3-ramona.gradinariu@analog.com>
References: <20240208100126.183697-1-ramona.gradinariu@analog.com>
	<20240208100126.183697-3-ramona.gradinariu@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 12:01:25 +0200
Ramona Gradinariu <ramona.gradinariu@analog.com> wrote:

> Add documentation for IIO device buffers describing buffer
> attributes and how data is structured in buffers using
> scan elements.
> 
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> ---
> changes in v3:
>  - new patch
>  Documentation/iio/iio_devbuf.rst | 121 +++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst      |   1 +
>  2 files changed, 122 insertions(+)
>  create mode 100644 Documentation/iio/iio_devbuf.rst
> 
> diff --git a/Documentation/iio/iio_devbuf.rst b/Documentation/iio/iio_devbuf.rst
> new file mode 100644
> index 000000000000..0563b65316cb
> --- /dev/null
> +++ b/Documentation/iio/iio_devbuf.rst
> @@ -0,0 +1,121 @@
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
> +2. Buffer attributes
> +====================
> +
> +An IIO buffer has an associated attributes directory under
> +/sys/bus/iio/iio:deviceX/buffer/. Here are some of the existing attributes:
Given this is new documentation, can we make it compliant from the start with
multiple buffer support?  bufferY



> +3. Scan elements
> +================
> +
> +The meta information associated with a channel reading placed in a buffer is
> +called a scan element. The important bits configuring scan elements are exposed
> +to userspace applications via the /sys/bus/iio/iio:deviceX/scan_elements/

Reference the bufferY directory not scan_elements for this as well.

..
> +
> +A user space application will interpret data samples read from the buffer as two
> +byte little endian signed data, that needs a 4 bits right shift before masking
> +out the 12 valid bits of data. 

I can't remember how you do it, but if possible can we have a cross reference to the
autogenerated ABI docs.  I want those to remain the 'official' definition of ABI
with this (excellent btw!) document being the user friendly cut down version.

Thanks!

Jonathan

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


