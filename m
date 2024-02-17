Return-Path: <linux-kernel+bounces-70044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E4B859238
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C29C280F8B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B257E58C;
	Sat, 17 Feb 2024 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNM0/DH1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D81C282;
	Sat, 17 Feb 2024 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708199925; cv=none; b=o1Ri+kjT5FSRipmZvgnsy0xWL1x6NwPRKUTKaQhDI3PkwSY+UZpVG+7kkGMgohCIii1OHveCwALJqBGG0qR5z68muVqVFZi8y0qpQ0b6dDqahOoHoWwoGia5ozHMSFDtOt17oE4UpD8+0LG/BJjcDJlvEhaK781Irf/yyi0Qf50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708199925; c=relaxed/simple;
	bh=kr77AtVMqS/g0XUszwpsQ/nIr7wANyKOpwUEUT5u+vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dam0XDrZtYQm2i3HLmEFhaVsvN5f+tamplqYqYAAZqKfJm2F2LS2yqhvMp4zIo6EECPtMVq0z+BDvaGu1UFEuHt+ivh9lfE+6sawmEueAZ2M4JfU/+3R2QOBfizP03z7tAdTWKx2kYjWd/xOoscXGIirXq7Nf1pSM3h/Gm9T3F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNM0/DH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87EBC433F1;
	Sat, 17 Feb 2024 19:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708199925;
	bh=kr77AtVMqS/g0XUszwpsQ/nIr7wANyKOpwUEUT5u+vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dNM0/DH1qT0LZJ9f3Lxvw/QaFrwV1IPcB1ryw9buPDBGdYrArrba2+Z9mUy6S/H+m
	 sOevE5KO5i5F0OmowtlnEv7pdHVryv7S+w/PblMYJmXR7VfMIIP/UCucDO5tLlZWV5
	 qB/ROzTdFAZGh2JEgQOCDBP9vGDsuZKoh3wgslqP1j+l0W7Hv+7nqBHE1V9B6YQVcJ
	 fCFLz9g6plC1tQ2wSP7UuAtOykO9asiGOgETMmYBbKj60/XAC9Tx8r9a8zMbFo32YH
	 qoxQU/ivRLIur6Lnnsc/YlmSfU7RumgQJcngus8B9b0xQmM3t2UWvK/1Znnvsoiuhf
	 /ndDd/g1STGkA==
Date: Sat, 17 Feb 2024 13:58:41 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Guru Das Srinagesh <quic_gurus@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 00/12] arm64: qcom: add and enable SHM Bridge support
Message-ID: <htsty5siakcu2nxxapiuq7pgs27tjwkb3yxgmfs3bonsl6kylw@joa2viypstoa>
References: <20240205182810.58382-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205182810.58382-1-brgl@bgdev.pl>

On Mon, Feb 05, 2024 at 07:27:58PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We've established the need for using separate secured memory pools for
> SCM and QSEECOM

Where has this need been established, what is the actual problem you're
solving with this series?

Does SCM and QSEECOM, as it's implemented in the kernel today, not work
satisfactory?

> as well as the upcoming scminvoke driver.
> 

Is smcinvoke driver upstreaming blocked by not transitioning the scm
driver to a "secure memory pool"?

Is this happening now, or do we need to merge this series when that day
comes?

> It's also become clear that in order to be future-proof, the new
> allocator must be an abstraction layer of a higher level as the SHM
> Bridge will not be the only memory protection mechanism that we'll see
> upstream. Hence the rename to TrustZone Memory rather than SCM Memory
> allocator.
> 
> Also to that end: the new allocator is its own module now and provides a
> Kconfig choice menu for selecting the mode of operation (currently
> default and SHM Bridge).
> 
> Tested on sm8550 and sa8775p with the Inline Crypto Engine and
> remoteproc.
> 

It's reasonable to assume from mentioning of this (and Andrew's t-b),
that the patchset has only been tested on recent platforms that indeed
does implement shmbridge. Can you please share the list of other
platforms that you've tested this on, and can you please get someone
from IPQ to also give their r-b or t-b?

Regards,
Bjorn

> v6 -> v7:
> - fix a Kconfig issue: TZMEM must select GENERIC_ALLOCATOR
> 
> v5 -> v6:
> Fixed two issues reported by autobuilders:
> - add a fix for memory leaks in the qseecom driver as the first patch for
>   easier backporting to the v6.6.y branch
> - explicitly cast the bus address stored in a variable of type dma_addr_t
>   to phys_addr_t expected by the genpool API
> 
> v4 -> v5:
> - fix the return value from qcom_tzmem_init() if SHM Bridge is not supported
> - remove a comment that's no longer useful
> - collect tags
> 
> v3 -> v4:
> - include linux/sizes.h for SZ_X macros
> - use dedicated RCU APIs to dereference radix tree slots
> - fix kerneldocs
> - fix the comment in patch 14/15: it's the hypervisor, not the TrustZone
>   that creates the SHM bridge
> 
> v2 -> v3:
> - restore pool management and use separate pools for different users
> - don't use the new allocator in qcom_scm_pas_init_image() as the
>   TrustZone will create an SHM bridge for us here
> - rewrite the entire series again for most part
> 
> v1 -> v2:
> - too many changes to list, it's a complete rewrite as explained above
> 
> Bartosz Golaszewski (12):
>   firmware: qcom: add a dedicated TrustZone buffer allocator
>   firmware: qcom: scm: enable the TZ mem allocator
>   firmware: qcom: scm: smc: switch to using the SCM allocator
>   firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocator
>   firmware: qcom: scm: make qcom_scm_ice_set_key() use the TZ allocator
>   firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
>   firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ
>     allocator
>   firmware: qcom: qseecom: convert to using the TZ allocator
>   firmware: qcom: scm: add support for SHM bridge operations
>   firmware: qcom: tzmem: enable SHM Bridge support
>   firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
>   arm64: defconfig: enable SHM Bridge support for the TZ memory
>     allocator
> 
>  MAINTAINERS                                   |   8 +
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/firmware/qcom/Kconfig                 |  31 ++
>  drivers/firmware/qcom/Makefile                |   1 +
>  .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 281 +++++---------
>  drivers/firmware/qcom/qcom_scm-smc.c          |  30 +-
>  drivers/firmware/qcom/qcom_scm.c              | 179 +++++----
>  drivers/firmware/qcom/qcom_scm.h              |   6 +
>  drivers/firmware/qcom/qcom_tzmem.c            | 365 ++++++++++++++++++
>  drivers/firmware/qcom/qcom_tzmem.h            |  13 +
>  include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
>  include/linux/firmware/qcom/qcom_scm.h        |   6 +
>  include/linux/firmware/qcom/qcom_tzmem.h      |  28 ++
>  13 files changed, 685 insertions(+), 268 deletions(-)
>  create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
>  create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
>  create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h
> 
> -- 
> 2.40.1
> 

