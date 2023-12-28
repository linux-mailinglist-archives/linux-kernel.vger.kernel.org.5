Return-Path: <linux-kernel+bounces-12524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE5B81F615
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62A2AB21517
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC0A63B6;
	Thu, 28 Dec 2023 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="aNzKnepD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A85671;
	Thu, 28 Dec 2023 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703753163; x=1704357963; i=deller@gmx.de;
	bh=fJqDTgVLl8Hra1HS/8kXEcwI5ggM5ehurfeNCFKVkRo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=aNzKnepDp5ls3Dlaq4KAWwhDHXutRqzTKOnJ49xVn71GkXf3oc1jTB1ylj8kWuUa
	 pAMErwiRW/SXyry7u3mA/FDpz0RhRcPDrl+Uogil24o1SO4Wv2xLKCGCL5Svd7MTv
	 IDo/iWwVdYlEmwFUceYQdlyAbRtMYl3ZMMZAbJc3o6T0jjGegK8AJfYa6XXxjNgBm
	 tvvSpCG48lQzgXMNg1QXQHJXoVzb9lntmvBslAlwCigbiYJYzEoRIER2QWyPcabHO
	 W/Ofgytsh78I0miKscfc8ft6X1MTug4upeU9O3ZnuKwkSsRobHaI3bXESMx2vDrQG
	 rVWOnEyPvJdgnu6OFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.144.42]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1qjzNA2EYV-00aEW9; Thu, 28
 Dec 2023 09:46:03 +0100
Message-ID: <5585dee0-452e-48e1-8fae-bab1eccc8e97@gmx.de>
Date: Thu, 28 Dec 2023 09:46:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 12/14] net: add SO_DEVMEM_DONTNEED
 setsockopt to release RX frags
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20231218024024.3516870-1-almasrymina@google.com>
 <20231218024024.3516870-13-almasrymina@google.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20231218024024.3516870-13-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1CJx57+OhafBv9nyT31t7uQ69mk+ew1K2kNcH6rFX0c45RB+gGy
 ufI14Cm8vmaThhO5jaxQvDyvLAWtFiQlfaHTcJS4nB8lOMjTcvgmDuzQaGlOkq7toMFGuct
 zqbYviNagfmrU856z6PHOnBOrCw7DcXKPftPJzyBf4M7avOEBNEWpfWrIhkttSBq8A8JxQe
 pFg22iUZNQcuQ678QWpIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HAEGlgqLqvw=;Yc26w74KRUPPguj5A2LYqQ7u48p
 AIRjX4iaj5Zy5fGQdeKRRAXNq1BzQBE8eWh8LR17/DePFZYNObhlvCC2mj69r2eWwhQzanlAa
 +HELes4lt6c5hBk9++z9KyTJ0D5caZtqAKEQqFVuHeDeVUFxpHo0xMHLWrbRyMUPJhK5vs4Ap
 Tmy1e96VS6DceBVpyW7SAeAyvDm6u6bocgKNzq0MMpXIqJPzmrfXvvOWq5/lsYDZbmXtI4r/+
 2DG1q/szvVou+nH10738+CenehQy7MiK+5xGjN84awqsJeoNnS890LBBRCSnAvLAdRmjk8yHD
 RYIYpFoWAfFMRQOW4NmyL3zLgyak9RpBRGRzJnvwY40RKKEw3YwbWQUgl5XnEk0JNk2TNRtH8
 VekeA/M5ZClF++YakLgeUXDibg9geldaxLup0Y9x/1K6rsLEhwy9ieFn6CpX6mZBiKLy5uW74
 H2Txk883FAJRtHZSXWEd3iHpPWqAoa4Su7qDq7vJvNAj4Tv7Awc9jDWBiuWVayJ64xH70qWZe
 AqZrvflNzwT+4wXK73E6/+SE2T/DAVgQ7J9wJTZBBa6utPMm9HLRuU28cpJXiLzFNMIPBRfMe
 2FtEI8SYYcIABHoswAtAxAOSfiou83RHk063MZ5jL11uuWUjjDGKIRv+yZ1j3xCwRtyVFNsRG
 Rd0COP10AReF2n7kdcP+N9/E3UqtFiSkagtHyagv5YQa38u6s7PVdnHVT4yhJ4rNNoG4RTWrX
 6JKDlwrRP6W9iLHIsA+Pe+BIAsTKuAnhEcUXzpvQ2RquJh7dcyxbgAn3OQ9ChWoRzbbqZTQb8
 aijPpoTGHulP2ayJtISjOgekfa+2QVI+T3bgqBWVoBTVOmBLpUe8S3GJbU4gGRjwnZbnYQxC0
 UkvP22uqsQwqKw04noJG/vDXKWa3eX269Mc0bbBF4RxlekL6pMAyd2PVTBzz7xERAhvsC5+gW
 1jjbhBMKEIBr2tQ0+ORZwiHN/nE=

Hi Mina,

On 12/18/23 03:40, Mina Almasry wrote:
> Add an interface for the user to notify the kernel that it is done
> reading the devmem dmabuf frags returned as cmsg. The kernel will
> drop the reference on the frags to make them available for re-use.
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
>
> Changes in v1:
> - devmemtoken -> dmabuf_token (David).
> - Use napi_pp_put_page() for refcounting (Yunsheng).
> - Fix build error with missing socket options on other asms.
>
> ---
>   arch/alpha/include/uapi/asm/socket.h  |  8 ++++-
>   arch/mips/include/uapi/asm/socket.h   |  6 ++++
>   arch/parisc/include/uapi/asm/socket.h |  6 ++++
>   arch/sparc/include/uapi/asm/socket.h  |  6 ++++
>   include/uapi/asm-generic/socket.h     |  1 +
>   include/uapi/linux/uio.h              |  4 +++
>   net/core/sock.c                       | 45 +++++++++++++++++++++++++++
>   7 files changed, 75 insertions(+), 1 deletion(-)
>
...
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include=
/uapi/asm/socket.h
> index be264c2b1a11..6b8674399363 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -132,6 +132,12 @@
>   #define SO_PASSPIDFD		0x404A
>   #define SO_PEERPIDFD		0x404B
>
> +#define SO_DEVMEM_DONTNEED	0x404C
> +#define SO_DEVMEM_LINEAR	0x404D
> +#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF	0x404E
> +#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF


Could you please change this ^^ for parisc to use the same constants as
the generic version below (97-99).
Although 0x404c is the logical successor, I'd prefer to be in sync
with other generic code if possible...

Thanks!
Helge

...

> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generi=
c/socket.h
> index 25a2f5255f52..1acb77780f10 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -135,6 +135,7 @@
>   #define SO_PASSPIDFD		76
>   #define SO_PEERPIDFD		77
>
> +#define SO_DEVMEM_DONTNEED	97
>   #define SO_DEVMEM_LINEAR	98
>   #define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
>   #define SO_DEVMEM_DMABUF	99


