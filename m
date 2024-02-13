Return-Path: <linux-kernel+bounces-63695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D14485335E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC11B21B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2957897;
	Tue, 13 Feb 2024 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTbqkkuS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19041E529;
	Tue, 13 Feb 2024 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835300; cv=none; b=NVkuh6KrWJwBE9CWApg/BmeAkZ/4ZSJ904gmDNfOI8ReVF83DkgAvFcwGbqpgAXwiUf1hVLiOHV7LAavkVfGJXgGJfcHGquVTPHYHnBBs/O6SfCi93egNBS3gMQWzs5cof8XZ03M6k5l4nDzkaWUQAkGXnwoIJbB8Kefs7XkdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835300; c=relaxed/simple;
	bh=3FaIpb2tO3xwMxqfhDPf3xKwredvzh+qclLg9QTU2Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf017AHrt1/O4mNGHLDK/bp6Xq1jQiMGbvRvusciXrmi1m6o/jlA0XOf/eEqjNxEv4cjjGur2XsdKW737kdvstJo8cTeMI4Q4ZnIYIRhJf82Lx0CqgRd/jKE0YAcTqSeCZGObA6edCIBKoHzW9O/9EVI0SmGs72VqFaw/9qOz9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTbqkkuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF6BC433C7;
	Tue, 13 Feb 2024 14:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707835300;
	bh=3FaIpb2tO3xwMxqfhDPf3xKwredvzh+qclLg9QTU2Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTbqkkuSVWxD8Cd4KI8EMEQ6uSh8NP9kXnjOSwweuPSp7MvKyEujKabSjlCt89RrA
	 +Xrg7orBllVYqODtOxgj81S14b4FSJiQ9tNl/uezVYeRGk1m1Fyg1j0bI41KW669TX
	 rCtaJ3mSQSNP+JTg8T3Jt5cjxpUji0CjtusWsctr0TU1RaeTkgkAlCb8Uc21qrMKtO
	 QBCZWUCiEsaphO3Cg9sCrQ2MDtpDLlfuaWlsYWlQG/6PuEpaSeLB8bWM6lpfuc6H+Y
	 5ZNWxqMUH4DQaSOVoZFroExonN6SRn1SlcgvmkcaZvuL2JLO3uUC6NKUX8Oj9sP1kF
	 UNoVtem33Ot5g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rZtyu-000000000KV-05UP;
	Tue, 13 Feb 2024 15:41:56 +0100
Date: Tue, 13 Feb 2024 15:41:56 +0100
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
Message-ID: <Zct_tB-y7HbZU1dp@hovoldconsulting.com>
References: <20231227180306.6319-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227180306.6319-1-johan+linaro@kernel.org>

Hi Luiz,

On Wed, Dec 27, 2023 at 07:03:06PM +0100, Johan Hovold wrote:
> The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
> device address in MSB order when setting it using the
> EDL_WRITE_BD_ADDR_OPCODE command.
> 
> Presumably, this is the case for all non-ROME devices which all use the
> EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
> use a different command and expect the address in LSB order).
> 
> Reverse the little-endian address before setting it to make sure that
> the address can be configured using tools like btmgmt or using the
> 'local-bd-address' devicetree property.
> 
> Note that this can potentially break systems with boot firmware which
> has started relying on the broken behaviour and is incorrectly passing
> the address via devicetree in MSB order.
> 
> Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
> Cc: stable@vger.kernel.org      # 5.1
> Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Can we go ahead and merge this one to get this fixed in 6.8?

I've spoken to Bjorn Andersson at Qualcomm about this and he is in
favour of doing so. The only people actually using the devicetree
property should be the Chromium team and they control their own boot
firmware and should be able to update it in lockstep (and Android uses
some custom hacks to set the address that are not in mainline).

Johan

