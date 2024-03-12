Return-Path: <linux-kernel+bounces-99713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C33D5878C20
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DA61F221EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F29186A;
	Tue, 12 Mar 2024 01:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imYFvMpX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384887E2;
	Tue, 12 Mar 2024 01:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710205735; cv=none; b=YFfYI+x/Y+Tap2Bx24XPIRG+PsZU/Miq+BesnJ0ny6elz1yn1q2/Y7AdoR+i2QVWDZdFk2PVLPHP7WstlCfKSBlA203c/cOsKR6NpPE09njRQQhfSZzHZZYO5srt2WBMVZrHRZh1TkQtGckik2MOBG1LfMvDsu42thN8vydLRd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710205735; c=relaxed/simple;
	bh=TxXimNigu2jc8mFmQSAEvcxnaz7nmbWqb5sDCHugcRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3Ou0tyJHqZObPbpQbQcnwKM6FT/cUsYJgGnE68Bu26rLoKV8d2ldHtoOA33vdTxMrSvQbsNuec+mZOW2mO6YBguci8M7F9ZRDBNIFPkHGfSLGZfVjyQKZUjL4f6ckForEMdPUe83nogZ40Vn0zY7DsW+ibqHQUcGHXLALJtRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imYFvMpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E07C433C7;
	Tue, 12 Mar 2024 01:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710205734;
	bh=TxXimNigu2jc8mFmQSAEvcxnaz7nmbWqb5sDCHugcRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=imYFvMpXDN2U3ixgZX1yDV8jBWFy2ANoWaWUFzC4foQOAAWMVzWhc9CGVkKTP/4Z5
	 OmH9C3wCNFrb3/FMFO3QeAx3OG5YJHvo1rHg09L67BGCJdMIWtBOkUYScP5DvM6LYu
	 oRa3w0ZNyHCeAo0gW12K/vzuIrJb+yywwyK0fiNuOoc5JZA6UsAmznsOq7b8t6ohh8
	 EvaWdIHifHRAhbP7nVhaVhRZp0WT0nzcIK97KW2NJOfh+8JdhDbviMjNqfbY+uXTNc
	 4v6u4szqnX3ihJT3g8qEY/azt9q06y6dya6gcjW8Q2ksCUBl9ctBdTnvA556JPki+9
	 E33P24MSugbCw==
Date: Mon, 11 Mar 2024 18:08:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v11 4/9] dt-bindings: net: convert
 hisi-femac.txt to YAML
Message-ID: <20240311180853.5e3a6a41@kernel.org>
In-Reply-To: <SEZPR06MB69596EB6D2097DB14FF5C9C6962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
References: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
	<20240309-net-v11-4-eb99b76e4a21@outlook.com>
	<SEZPR06MB6959090F2C45C3E5D6B3F9F496262@SEZPR06MB6959.apcprd06.prod.outlook.com>
	<20240311090341.32509303@kernel.org>
	<SEZPR06MB69596EB6D2097DB14FF5C9C6962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 08:49:21 +0800 Yang Xiwen wrote:
> >> Still not very correct here. In downstream the core can also have an
> >> external PHY. The internal phy is also optional. So maybe this clock
> >> should be optional.  
> > You are responding to yourself 4 min after posting?
> > What is the purpose of your comments?  
> 
> Just to remind others or myself this can be improved. But i think it's 
> ready to be applied. There won't be similar design in mainline soon i think.

It's a fairly uncommon thing to do, normally such notes should either
be comments in the code or notes in the commit message.

In any case - the merge window for v6.9 has started, we won't be able
to merge these changes for the next 2 weeks :(

