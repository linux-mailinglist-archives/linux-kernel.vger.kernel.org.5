Return-Path: <linux-kernel+bounces-161478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584D18B4C8D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D613C1F215C3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DACF6F525;
	Sun, 28 Apr 2024 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8f6n0MD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38486138C;
	Sun, 28 Apr 2024 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714320004; cv=none; b=jzLZx/JsHQs544JxO3uRSFQ9gMcKs3moxgWSeRM5TlFnLgvawoorsQXL05V5VpOyeus6MNLLv43+8QcbDdC8k237G8skPHE29BAhwUdm9B1GtI0XJG/muOTdhHd/14Uxh4CT3n44V24ynNhgQrEoYe+BTOgSpj5zAj9ecxbUZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714320004; c=relaxed/simple;
	bh=qZ0Fbfj1vweWLzzSL3bdrgPz202m45WYfRUmedFWYPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoOp9cuASFbXiI2qyy1tzTMoDU15jCIHUpCtq4kvYTpUzu8yvykXu6UlqQfTlMv9hetjIo536WfKwnWqQqj2wxoQEvGKuptHPMlUENlOMZGtfhStTJZE1a5t0Wr4r2Uh0JOljmcSocUGGRB/U4WjQU3iKrzrBiukBxj0hLkujGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8f6n0MD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E29DC113CC;
	Sun, 28 Apr 2024 15:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714320003;
	bh=qZ0Fbfj1vweWLzzSL3bdrgPz202m45WYfRUmedFWYPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o8f6n0MD1/mOag26J70muvOPH6wBJdaZmNh9iJvxENVSFU5+U1AKlFejHUu+SmBf0
	 oPfnXjqLoSImXJ9XjfC+N5XMzcCMlcskOw8F4v0A9LAa22fTOr9s3S38SPnuGIx6aY
	 /9fXK/6kuXkGdUbo4faynMRv5/6jBB991XJn+gtBYb02gCHxCE/B/t7g5CXWXDKsQ7
	 JugizA2qoCnbBdVYEE0bDRG7aNajcmrROa4PD9kb7oceVt/mJfqFRmRi+0TqNt6Qlq
	 T3CXKsAH3WneCXAyxD1EhsjD0fq33ZfXK5ER92naBoTM5slJ/gvTt0z1TO1fWGkq9t
	 UOL6I8zogFVfg==
Message-ID: <79127b00-4349-48bd-9023-259c72cc47dd@kernel.org>
Date: Sun, 28 Apr 2024 17:59:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] enable USB on Pixel 6 (Oriole)
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240423-usb-dts-gs101-v1-0-3421b0371298@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240423-usb-dts-gs101-v1-0-3421b0371298@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/04/2024 22:52, André Draszik wrote:
> These patches enable USB in peripheral mode on Pixel 6.
> 
> We can only support peripheral mode at this stage, as the MAX77759 TCPCI
> controller used on Pixel 6 to do the role selection doesn't have a(n
> upstream) Linux driver. Therefore the role is defaulted to peripheral
> without any endpoints / ports.
> 
> For the same reason, we can not detect the orientation of a SS USB-C cable
> and therefore it will only establish a link in SS mode in one of the
> possible orientations of the cable. In all other cases, the link will be HS.
> 
> This series has a dependency on other patches, please see below.
> 
> I have mainly tested this as CDC ECM Ethernet device using the following:
> 
>     mount -t configfs configfs /sys/kernel/config/
>     modprobe libcomposite
>     modprobe usb_f_ecm
>     mkdir /sys/kernel/config/usb_gadget/g3
>     cd /sys/kernel/config/usb_gadget/g3
> 
>     echo 0xadad > idVendor
>     echo 0xddaa > idProduct
>     mkdir strings/0x409
>     echo 01234567 > strings/0x409/serialnumber
>     echo ADADAD > strings/0x409/manufacturer
>     cat /proc/device-tree/model > strings/0x409/product
>     # create the function (name must match a usb_f_<name> module such as 'acm')
>     mkdir functions/ecm.usb0
>     # stable MAC addresses
>     echo "6e:27:3a:b9:40:87" > functions/ecm.usb0/dev_addr
>     echo "ca:49:84:b0:3b:bc" > functions/ecm.usb0/host_addr
> 
>     mkdir configs/c.1
>     ln -s functions/ecm.usb0 configs/c.1/
>     echo $(ls -1 /sys/class/udc/) > UDC
> 
>     ifconfig usb0 192.168.1.2 up
> 
> at which point the other side should detect it and network communication
> becomes possible (once the other side also configures its network
> interface).
> 
> Due to the clock IDs, this series depends on the bindings patch
> "dt-bindings: clock: google,gs101-clock: add HSI0 clock management unit" of
> the series in
> https://lore.kernel.org/r/20240423-hsi0-gs101-v1-0-2c3ddb50c720@linaro.org
> 

This is weird. The patchset applied cleanly without DTS parts from above
set, but then failed to build. Obviously, because it depends on DTS,
even though it is not explicitly said here...

But when I applied DTS from above, these two patches fail to apply, so I
really wonder how this was organized in the first place. Please rebase.

Best regards,
Krzysztof


