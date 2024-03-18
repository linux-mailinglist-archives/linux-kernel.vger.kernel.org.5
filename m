Return-Path: <linux-kernel+bounces-106249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC5A87EB63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C34AB217A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424654EB4F;
	Mon, 18 Mar 2024 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/XoVnYI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3738BEF;
	Mon, 18 Mar 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710773289; cv=none; b=ErH4u9WcvlQVNcbU2OM2Q/MtvmfSLrtHcxoZ7te6/MJUwVwACNm6qaObMXZjfqScgcuR7cVkSjrrXnP22OzuGkDx0O3Is/RVB6WJ8C9BwSkpMvMIda1ZS3A1YiOWeYAhSWvssuCLCOQ+wq7nNNZxapyD2CbVCNl5LsO6ocMJR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710773289; c=relaxed/simple;
	bh=fFpQIC1WWlry+MCS3UDnBUqyuPC+yR/ct7UaDoPegoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDAnCLOB3NbKUwe5YokGXFVwMoq+kr1Ai6yMbiJpRZoCXKdprfKlq/h1jh6XwgdNhgGhwI/vuxZNJeIi5zUEEC1yHp7NF51LDx8+7RiJHUpu/Ips9KacP4y4yii0GmRa7lL4gmgUGyzu2DO6ZQ8wxKsV147fpNiSX+yp1Oly168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/XoVnYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6290C433F1;
	Mon, 18 Mar 2024 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710773289;
	bh=fFpQIC1WWlry+MCS3UDnBUqyuPC+yR/ct7UaDoPegoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/XoVnYI5ZdzwSJQsiQPry3j6wkqfmUhZ0Wb/cIZ7LPOs9P9MTvgHrhk4dzJCgnh3
	 iRcaUdDTfJutaZgbQCgrdKQnIZC4PFp67egUc7l3lOD6CqnOJuvSEGJMTy394EgaL+
	 NAnajc6gZDem815pcxkYMvKpr5vo5J5L+6tm85ihFYdCmzAnlZfxDzSp+KHIXLN+zy
	 bgCh7fubqT8eXW2s8zDVnCyJ3k7/HyyaOjTuBi51B4/6L1pgATEJNs7OXiLebUPRPq
	 Bgvej4YQdDedu17o5C6njM8QxJwTTazZDwb4p/Xagrfx0+qo++1Qg7z2to/4EmdOAg
	 c41SuMXcWasgw==
Date: Mon, 18 Mar 2024 09:48:06 -0500
From: Rob Herring <robh@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Doug Anderson <dianders@google.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add new wcn3991
 compatible to fix bd_addr
Message-ID: <20240318144806.GA3963554-robh@kernel.org>
References: <20240318110855.31954-1-johan+linaro@kernel.org>
 <20240318110855.31954-2-johan+linaro@kernel.org>
 <CAA8EJprywWbdoyfAbys=0WzEdAkp0UK1fzzCPzxKRjyk9DrC6Q@mail.gmail.com>
 <Zfg--2_NMPSPTxK-@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfg--2_NMPSPTxK-@hovoldconsulting.com>

On Mon, Mar 18, 2024 at 02:17:47PM +0100, Johan Hovold wrote:
> On Mon, Mar 18, 2024 at 03:00:40PM +0200, Dmitry Baryshkov wrote:
> > On Mon, 18 Mar 2024 at 13:09, Johan Hovold <johan+linaro@kernel.org> wrote:
> > >
> > > Several Qualcomm Bluetooth controllers lack persistent storage for the
> > > device address and instead one can be provided by the boot firmware
> > > using the 'local-bd-address' devicetree property.
> > >
> > > The Bluetooth bindings clearly says that the address should be specified
> > > in little-endian order, but due to a long-standing bug in the Qualcomm
> > > driver which reversed the address some bootloaders have been providing
> > > the address in big-endian order instead.
> > >
> > > The only device out there that should be affected by this is the WCN3991
> > > used in some Chromebooks. To maintain backwards compatibility, mark the
> > > current compatible string as deprecated and add a new
> > > 'qcom,wcn3991-bt-bdaddr-le' for firmware which conforms with the
> > > binding.
> 
> > This compatible doesn't describe new hardware kind. As such, I think,
> > the better way would be to continue using qcom,wcn3991-bt compatible
> > string + add some kind of qcom,bt-addr-le property.
> 
> No, you can't handle backwards compatibility by *adding* a property.

But you could add a property for the not broken case. That's a bit odd, 
but so is your compatible.

> I wanted to avoid doing this, but if we have to support Google's broken
> boot firmware for these devices, then this is how it needs to be done.

Don't Chromebooks update everything together. So maybe we don't care in 
this case?

Rob

