Return-Path: <linux-kernel+bounces-60846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8723850A1D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3EF71C20F4D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C6E5B689;
	Sun, 11 Feb 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="bwD08rAe"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822815D460;
	Sun, 11 Feb 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666297; cv=none; b=uKHX5S1xTHtlcQ7zt44bGL62KNiAqmZAcsN/NZOcPg6dUFCq3/+D96/Tmmw2xM+BzbdZ3U6rMCN59s6Cqd82dkGLT21z7qNVISvt8xzXi7wyjLFA+5gIt9oKN8p1CGvUv9lpj9l23qbB9w5eo77+l/EFSkJQ4+YSw2xzU63dWq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666297; c=relaxed/simple;
	bh=02hlsE3fIeUkpdG/W45CI6vNfgQ7OGsQBobYHKiWcTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFjcXm/67CB8p6zH9kYJLxa56LX6N2qyvr9XEG3MiM9Vui20ga0r31Ei1AX1HbnOkJgqatB0Fu94WVvhWPKfayhAvB/TNPHJ5uqPU6y/VPCVqQctyFNgDiZMt3eXSsWZzs5anIZLkWngwe1NwSNJi+uOKYx/3/53upO5hAX+owo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=bwD08rAe; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 5426E20751;
	Sun, 11 Feb 2024 16:44:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707666283;
	bh=tAZNyiysoPkFJigXlxkqXvpyemn+vj6wg0E7daVSflM=; h=From:To:Subject;
	b=bwD08rAeNi+64JMXiP3XA2VtDpTi7cmj50ioN6lj1Rfj2rLJzf61w/veV2+pAwoBr
	 TCAK3OFqIfeiCT4k7nP2UcdPvyPV/jaRn7ZDVtsnKU2R6uOGce28y9lX+Oa0o58E0q
	 a2ubtFvKk8VJu5N02m2N3SonJxEp8+mP+WeK/A9Yn0A6LjmjhsTaOMVl88sKlNfFKP
	 gzHiCU0AIvWZZF5w5ha7+qeHXFJGs9y8aCQcd3p88QhJ4OQo9BzVi3813VzloR6a58
	 TJCoFyOYa2txRZgQXdnPPgTi5V284r+2rG1eFUwhO3KvKjNEIaTpoGRfzSSJjnzsu+
	 jqh+YM2QxzuEQ==
Date: Sun, 11 Feb 2024 16:44:11 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/9] Fix MMC properties on Sitara devices
Message-ID: <20240211154411.GA3360@francesco-nb>
References: <20240207225526.3953230-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207225526.3953230-1-jm@ti.com>

Hello Judith and TI folks,

On Wed, Feb 07, 2024 at 04:55:17PM -0600, Judith Mendez wrote:
> This patch series aims to add or fix MMC properties:
> OTAPDLY/ITAPDLY.
> 
> The DLL properties ti,trm-icp and ti,driver-strength-ohm
> should also be updated since only AM64x and AM62p devices
> have a DLL to enable, so remove these properties when not
> applicable.

Do you have any reference regarding this change? TI reference manual or
anything like that?

No change needed in sdhci_am654.c? It seems that `drv_strength` is written
to some register unconditionally, is it ok to do so?

Do this change implies that there is no way to configure the drive
strength on such SoCs and MMC/SD trace impedance must be the nominal
50ohm?

Thanks,
Francesco


