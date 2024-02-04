Return-Path: <linux-kernel+bounces-51945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 251708491B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8412D2825F3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5529C13D;
	Sun,  4 Feb 2024 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkzET7ls"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD13FBE4C;
	Sun,  4 Feb 2024 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089554; cv=none; b=ICUe8Eic07Ynx0t0OX76jveg26GcosmHZnsfnEqADmXsd/pKsZLPdsvOKfshPRX5Yy/3SjmN4dAp8E+ZQqAyCD+qU6Oiewy7IcVlUwWnO6sCWsdBTFC+Bi+GR9ocGZ5yyQ5BVbX7/qb7pM4k/uxV6ArjEWH8esEGNIyIh2ExjLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089554; c=relaxed/simple;
	bh=weao2nZbuJbl0lCTTQA6jQBl3YJvBZE2uI/j1YAW7sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5YsxhFcwdkSttuZBg6CUvPXtwsBejT0rW7pkPIeVSr16adWlK2nL050JeCWgOypHHnYQN7a9cLhjKe3lnXIfj1Bdco+EXkzMS2wrudW6cc8M7PidQDxAaynCATXVIjo1q9ANJedQHIgY40Bw2QKottOyt40pZeQHV39AnBiYog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkzET7ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEBCC43390;
	Sun,  4 Feb 2024 23:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707089553;
	bh=weao2nZbuJbl0lCTTQA6jQBl3YJvBZE2uI/j1YAW7sc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fkzET7lsImBZI4+lhRM3QHl8vkm0OknStQgXOTjySvOaGEYcGOTmm5YsKuHCa3Xge
	 OCgUljIHx2oM8U9QTHiGs4JktbY5pIhezWSPlzvfp6uXeh8gLoUfq8mJ+zV35yPPQ4
	 FuyouX0u31inPG8Ea1RE0xh0s5kWV7v/z47uMB698k4ohsghVIFX6cEU/iA0QziTxH
	 23NY6Eqd1x5LoSbLRUpw2Pw8fmNYXJ/ropVOaWT3YH8WM+EkwmurBZIRekroSkfV8C
	 TdcutF5h49h2Gh71nPjhvsnFJYF3lHF+rMwUJn8LhbypqtrzaYoTZ9lIH5mkdD5wuN
	 fGTQ/ZMf7KfhA==
Message-ID: <3dd03711-cbcd-4c91-8c69-f8f28e61de50@kernel.org>
Date: Mon, 5 Feb 2024 08:32:31 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_parport: make pata_parport_bus_type const
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240204-bus_cleanup-ata-v1-1-2bdc1fadf356@marliere.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240204-bus_cleanup-ata-v1-1-2bdc1fadf356@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/24 00:23, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the pata_parport_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research


