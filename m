Return-Path: <linux-kernel+bounces-134692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7CC89B526
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A758F281525
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3D11366;
	Mon,  8 Apr 2024 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQDfuOvA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E17F8;
	Mon,  8 Apr 2024 01:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712538870; cv=none; b=HDQN7DiTSzQmqOSnaUWzhDLC1k1cvIdGLWq+waICoQJrOiPd52Cen5qfz1e4FWMMLagQd6C9E8HQAnNLyJsuM828fNqQORf5rYmqbE0BZBTYS0INpg3V/rk51RFTYrBtsB4Q9hB64Fpuk4XKKheYoHdMnR6lLj2ThdGzcZqj31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712538870; c=relaxed/simple;
	bh=GqEdiBp5ieYyqmJ1RTfUzDPbNO7tDtm5skxShOYL/7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpOkt/q4IfDWQ6Xy83nnk1BqSfRXyRieTFSJ/iwnctYAvKSiIBKMYHKq1PPy8dl3/fvb3rzuABs+S+aghezIdTiEgPzNqSs07yOxfRuEZsxQkm5GKOhYya6/aMYokcr8niYcqhHy6LmYMsZVPPtD8xIu0GaWW/EVXhXvADdNEUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQDfuOvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A882C433F1;
	Mon,  8 Apr 2024 01:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712538870;
	bh=GqEdiBp5ieYyqmJ1RTfUzDPbNO7tDtm5skxShOYL/7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nQDfuOvAB6WNo3A679VpTAcL0W+pCNmOdAJ1XfcgLw8hUVjXb4pYh6FBXRm/LpOKU
	 ZS/nZ719VD9lZf3R2FXrUj2YRa/pExv3bdFzyxmt9WTCHKuEEs9qtV9ADg+YYcVyGE
	 SaThRCDU1NKS3r8XisnOZmpRVF2F9RLDt7sZH/6g05yBDarzq7+Nm/qJGmXgGPwaUP
	 Up8tyddAmw94GSiQcqyvZo110vWvriU4/vjFWHU7DVBZFhKjP/XpCK5eEkgENVsFIn
	 9Z6azt7D3mQcQ0MALvOWwmLWzGMXSxPEX7+to/RuWYw+vQOHy513zsCKr7ux20AMrh
	 HXosx8HXF4A/A==
Message-ID: <f7ac109c-0d31-440c-8820-159c5713b1e1@kernel.org>
Date: Mon, 8 Apr 2024 10:14:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ata: add HAS_IOPORT dependencies
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <20240404092936.3127972-1-schnelle@linux.ibm.com>
 <20240404092936.3127972-2-schnelle@linux.ibm.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240404092936.3127972-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/24 18:29, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
> compile time. We thus need to add HAS_IOPORT as dependency for those
> drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Applied to for-6.10. Thanks !

-- 
Damien Le Moal
Western Digital Research


