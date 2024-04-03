Return-Path: <linux-kernel+bounces-129707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6E4896EC0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC43282932
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF66E1465B5;
	Wed,  3 Apr 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YX3rn5Gw"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D41465A3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712146405; cv=none; b=K2TtbdYN6+TqNd5zqoTTK7zQ55VDMcDwtRXKVmjRxXHDlpjApSpu8Ak+bFmz5bT8J6rMnVZ86GJNcnXcJ0TxuL6dv+NPTn8obMEKMD6UNorsbYS8Go8wOIqL+i9KiJ7r48Wva5IFFGrtRlkuPkzDeK+94VecD530fo5Gs0d7rtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712146405; c=relaxed/simple;
	bh=hPesv8A+iZqlRr7D/fKBzdPB01WTru5uB9GQT6XWXBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wtaa77vSPijrqwK4cNavIJrKTV4L3gMHcL5Mklf8akxZcyTU8x/4yqXbI+v/or8gCTBuFfnjYzfEtn/LYdPbV4rOPkNOvY/gfyzjtfBMPABFqJfjwkRN8hB6QHxqdq6Kyup5WPMtKi7ZmyC/OCtxe8bBQSfC+LUsKPVLXUmJL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YX3rn5Gw; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a4f608432bso3929163eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712146403; x=1712751203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjRKejsFXZQk8rarEOCmsLs+7H5bp8Y0BYC9TTvN18I=;
        b=YX3rn5GwaosHxCHilbTPQCORORsaR4ajnbYDhjFcP92Mkbg49O9Tk7I5KVy1WHDA42
         06nyR1r0pi4BIZ1b6bCH/WzefoX+i89NKjG2fbxRbf+xJ3NHT9UKA60TkOGNv0hYpWxK
         TsE2Or3IPL4+OFNWrQtTrMiuuVyMwTdph4sT+VnHsgV0O8tTwxZXJbLouyXx+vNiB1S+
         1MQpSkVUihGin50cZpGRHJqZ0lSNDyOkhOeiEbRJu/DD2T4CizsUB9lnJhYKvszcAIdQ
         +RSO+zY+DavmK+eV0BqFf2kYym4ErtHoEoFmePlhZwlQeXaxgmzlMZ2qtvaHMIrL5FOx
         Oz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712146403; x=1712751203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjRKejsFXZQk8rarEOCmsLs+7H5bp8Y0BYC9TTvN18I=;
        b=bKoZDJ6yhIaBCdiuvDgp9Cpj+Cj3E2CRAvmfXTB90gTQQc0hViHDVI725Y+xHh6c3X
         lG0J+RU31rBDfG6GgOyeOw0RqKXK2jD5sCuYFK7t7Etyod01N1o2e9QMHxE1GWOnr18I
         te9x594drKKAXGjZaz3g+UgU1q5NL/joTXskllRr8c7kxiegUqEGsjryxlvWurzrm+S0
         6v6ziQCWPbKdJgbyFGVHbziQyYq7mr/uZoW+/gD8qD8iYn6S9Aml+4RSnA173kFnh7lG
         H/VrtR6jEl6Lp5jf3xw+ZPQ0jYMhLsqsY8z5MvwKlnxdW3zJu7TsPRoMnqklmUIKOWJe
         VFQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmC7d0/6+8Er0RzWYnpgwx7RcSAQYUWWxmwbJulT5xQsIY7Jx7nnZe+Tzig706jtaIZWQmHeR1vJ774bm944W6jPiR//p8Usj5z2a+
X-Gm-Message-State: AOJu0YxvY4ZOcqdYnsKR7tz7WCDmM96hKTTNts1EIq1ndjKYAah2OZTE
	NWOb4e6Bz5XseZb8IzC0Py77+H95OXbB7f1wt5f/QnBO9bsMZRSl2qWw/E+uSyGfoYQxnGh+j0F
	B2dQXyZw49rbLCw/PXvA/Dfpf4ZeddTKYdRl43g==
X-Google-Smtp-Source: AGHT+IFbaWK7QqXfEXj6KV33OwI/JaywKWSpgbqcwNxYrTYrdHmVOJ3P8JY85HhjUaZGh1s/c302EEresHr+B2qWtQg=
X-Received: by 2002:a05:6820:99b:b0:5a5:8b0a:60cb with SMTP id
 cg27-20020a056820099b00b005a58b0a60cbmr14955489oob.1.1712146403337; Wed, 03
 Apr 2024 05:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325151105.135667-1-balint.dobszay@arm.com>
In-Reply-To: <20240325151105.135667-1-balint.dobszay@arm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 3 Apr 2024 14:13:12 +0200
Message-ID: <CAHUa44H-7V8SjEt6Xj5+hW-nAVMkuRC=pwvsgyGyzcgVaOXTYw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] TEE driver for Trusted Services
To: Balint Dobszay <balint.dobszay@arm.com>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	sumit.garg@linaro.org, corbet@lwn.net, sudeep.holla@arm.com, 
	rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 4:11=E2=80=AFPM Balint Dobszay <balint.dobszay@arm.=
com> wrote:
>
> This series introduces a TEE driver for Trusted Services [1].
>
> Trusted Services is a TrustedFirmware.org project that provides a
> framework for developing and deploying device Root of Trust services in
> FF-A [2] Secure Partitions. The project hosts the reference
> implementation of Arm Platform Security Architecture [3] for Arm
> A-profile devices.
>
> The FF-A Secure Partitions are accessible through the FF-A driver in
> Linux. However, the FF-A driver doesn't have a user space interface so
> user space clients currently cannot access Trusted Services. The goal of
> this TEE driver is to bridge this gap and make Trusted Services
> functionality accessible from user space.
>
> Changelog:
> v3[7] -> v4:
>   - Remove unnecessary callbacks from tstee_ops
>   - Add maintainers entry for the new driver
>
> v2[6] -> v3:
>   - Add patch "tee: Refactor TEE subsystem header files" from Sumit
>   - Remove unnecessary includes from core.c
>   - Remove the mutex from "struct ts_context_data" since the same
>     mechanism could be implemented by reusing the XArray's internal lock
>   - Rename tee_shm_pool_op_*_helper functions as suggested by Sumit
>   - Replace pr_* with dev_* as previously suggested by Krzysztof
>
> v1[5] -> v2:
>   - Refactor session handling to use XArray instead of IDR and linked
>     list (the linked list was redundant as pointed out by Jens, and IDR
>     is now deprecated in favor of XArray)
>   - Refactor tstee_probe() to not call tee_device_unregister() before
>     calling tee_device_register()
>   - Address comments from Krzysztof and Jens
>   - Address documentation comments from Randy
>   - Use module_ffa_driver() macro instead of separate module init / exit
>     functions
>   - Reformat max line length 100 -> 80
>
> RFC[4] -> v1:
>   - Add patch for moving pool_op helper functions to the TEE subsystem,
>     as suggested by Jens
>   - Address comments from Sumit, add patch for documentation
>
> [1] https://www.trustedfirmware.org/projects/trusted-services/
> [2] https://developer.arm.com/documentation/den0077/
> [3] https://www.arm.com/architecture/security-features/platform-security
> [4] https://lore.kernel.org/linux-arm-kernel/20230927152145.111777-1-bali=
nt.dobszay@arm.com/
> [5] https://lore.kernel.org/lkml/20240213145239.379875-1-balint.dobszay@a=
rm.com/
> [6] https://lore.kernel.org/lkml/20240223095133.109046-1-balint.dobszay@a=
rm.com/
> [7] https://lore.kernel.org/lkml/20240305101745.213933-1-balint.dobszay@a=
rm.com/
>
>
> Balint Dobszay (4):
>   tee: optee: Move pool_op helper functions
>   tee: tstee: Add Trusted Services TEE driver
>   Documentation: tee: Add TS-TEE driver
>   MAINTAINERS: tee: tstee: Add entry
>
> Sumit Garg (1):
>   tee: Refactor TEE subsystem header files
>
>  Documentation/tee/index.rst         |   1 +
>  Documentation/tee/ts-tee.rst        |  71 ++++
>  MAINTAINERS                         |  10 +
>  drivers/tee/Kconfig                 |   1 +
>  drivers/tee/Makefile                |   1 +
>  drivers/tee/amdtee/amdtee_private.h |   2 +-
>  drivers/tee/amdtee/call.c           |   2 +-
>  drivers/tee/amdtee/core.c           |   3 +-
>  drivers/tee/amdtee/shm_pool.c       |   2 +-
>  drivers/tee/optee/call.c            |   2 +-
>  drivers/tee/optee/core.c            |  66 +---
>  drivers/tee/optee/device.c          |   2 +-
>  drivers/tee/optee/ffa_abi.c         |   8 +-
>  drivers/tee/optee/notif.c           |   2 +-
>  drivers/tee/optee/optee_private.h   |  14 +-
>  drivers/tee/optee/rpc.c             |   2 +-
>  drivers/tee/optee/smc_abi.c         |  11 +-
>  drivers/tee/tee_core.c              |   2 +-
>  drivers/tee/tee_private.h           |  35 --
>  drivers/tee/tee_shm.c               |  66 +++-
>  drivers/tee/tee_shm_pool.c          |   2 +-
>  drivers/tee/tstee/Kconfig           |  11 +
>  drivers/tee/tstee/Makefile          |   3 +
>  drivers/tee/tstee/core.c            | 480 ++++++++++++++++++++++++++++
>  drivers/tee/tstee/tstee_private.h   |  92 ++++++
>  include/linux/tee_core.h            | 306 ++++++++++++++++++
>  include/linux/tee_drv.h             | 285 ++---------------
>  include/uapi/linux/tee.h            |   1 +
>  28 files changed, 1094 insertions(+), 389 deletions(-)
>  create mode 100644 Documentation/tee/ts-tee.rst
>  create mode 100644 drivers/tee/tstee/Kconfig
>  create mode 100644 drivers/tee/tstee/Makefile
>  create mode 100644 drivers/tee/tstee/core.c
>  create mode 100644 drivers/tee/tstee/tstee_private.h
>  create mode 100644 include/linux/tee_core.h
>
> --
> 2.34.1
>

I'm picking up this patch set.

Thanks,
Jens

