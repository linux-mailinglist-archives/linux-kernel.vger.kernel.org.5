Return-Path: <linux-kernel+bounces-152001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F98AB737
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA79B1C20EED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773A713D29E;
	Fri, 19 Apr 2024 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaLtepc3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD0513D290
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565464; cv=none; b=qE8dLq3DowP6rtzWJZm1W0xJe5e5sI+ZtGn+kbVJ3zrxrKwWdubfJ0cvvB2/U5UPXnDd3FeYNavCsk5++Yf4ES5WRLG2gbXBwt2E4eWqLYGvbyVHYXamYL2EhdH8AAZWWvmMccbFebaHRQ3NMOoVe+gMyCbDZYmRh3fF+v8Bc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565464; c=relaxed/simple;
	bh=crBhB2ie1F22E8YCMI+PCb5RvOF5rOwI3h+5kfzyq7o=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=mF8VF1zm1CzCXyUA/DZgz3UN9UGGy8TcWKUP6Oh3adQ/43o0VTg1H3aBphrSiBChOC4q5aHe6scKsECLumrROSmnuCVDUs+84Mk9Hp4eYuuUFJhck+3b+8r92mAVFrtOvItZAZRbfL5nYqK9j1EM47nmyhDPD/Y6sSl8M2uxwhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaLtepc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38863C072AA;
	Fri, 19 Apr 2024 22:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713565464;
	bh=crBhB2ie1F22E8YCMI+PCb5RvOF5rOwI3h+5kfzyq7o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QaLtepc3EiMLJtMmI13qAWR2cc6IlLl/nkn6AOjP7RfdgBQmzT2zUfGSHxGM6NN7s
	 wC+5olEjg5pgaKSw5xMBRq+USrz8r8hhVOnj0lTZsY4HN129wjyK7TAoASwN42pS98
	 nr9/xGxSpd9NExf5mPtm/c7o8oS7/3RxjXuuaPDAKMRkSuv0ftPYozuLSaQLuNJBv+
	 OyMBEDez4nCoaGVLs2cDyKtsmmacWuJiLndZX44ZjcyZ05X1lzJMQjllAutrF1ABx2
	 qJGtfvpNA9dSAFi6KOwh07Bz3toDKfWCNhUd2/bfNeRcDhW1FxzVT+K1CGXWNQd0iH
	 utquCdwsjEvUQ==
Date: Fri, 19 Apr 2024 17:24:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, quentin.schulz@theobroma-systems.com
In-Reply-To: <20240418210332.2394871-1-heiko@sntech.de>
References: <20240418210332.2394871-1-heiko@sntech.de>
Message-Id: <171356537191.48026.7238978785873260892.robh@kernel.org>
Subject: Re: [PATCH 0/2] Add support for the dual-role dwc3 controllers on
 rk3588-tiger


On Thu, 18 Apr 2024 23:03:30 +0200, Heiko Stuebner wrote:
> A comment fix and then the addition of the nodes for the dwc3 controllers
> using the newly merged usbdp phys.
> 
> Heiko Stuebner (2):
>   arm64: dts: rockchip: fix comment for upper usb3 port
>   arm64: dts: rockchip: add dual-role usb3 hosts to rk3588 Tiger-Haikou
> 
>  .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 60 ++++++++++++++++++-
>  .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 15 +++++
>  2 files changed, 74 insertions(+), 1 deletion(-)
> 
> --
> 2.39.2
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y rockchip/rk3588-tiger-haikou.dtb' for 20240418210332.2394871-1-heiko@sntech.de:

arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: /extcon-usb3: failed to match any schema with compatible: ['linux,extcon-usb-gpio']






