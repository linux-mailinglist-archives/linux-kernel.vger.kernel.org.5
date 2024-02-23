Return-Path: <linux-kernel+bounces-78120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C6C860F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7A91F25EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FE25D467;
	Fri, 23 Feb 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biVoo5Gz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2795CDD2;
	Fri, 23 Feb 2024 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683925; cv=none; b=SfwRoND3MmUirRNG5PpSNFTxujtNIY6BlUQvGS7TNRU9SCZ9yr+T4H6PYQsqQWQ1bq/fiW/M9pe7kd25OTg1Rldlj33tdPCRvDgAOkLFyiLo0FockJyFAqH40ar5D+84lhxx/FQptnnz5v35Ce+S4HiSuAyc3dkq5/uZAqZyRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683925; c=relaxed/simple;
	bh=UAKXalfV4EJLOzKqZ5lgk5fK0b5rmyrMA6CAZBOKxdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCb036BYxNoNA0C2/h4Wv0Osp2Ws49v/CjcYaSEx7QTJBrX+FGW1ddBcqXsNWtOM8hbYmvSMt0vbEoCnqUoJT1PQCQUql1PMylH4QjDvLHyeJRUFA2RIyqa5PBe4+mPRCqUIoibyLjqC6l4JRowEF7iYLtyXuKvRWZt67GqsBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biVoo5Gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B480C433F1;
	Fri, 23 Feb 2024 10:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708683924;
	bh=UAKXalfV4EJLOzKqZ5lgk5fK0b5rmyrMA6CAZBOKxdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=biVoo5GzsSKQq0MtzS//PqdxLS7Dw3bUyd9gr//iCqEC7R8E5DJVHOA8SFJUkxNTb
	 2KfFMB2yJtw9/J/3II6NcZkZPO15+ypEVQJp7g4/Gy1yodV5L69646k51/QITjZtb/
	 bNKsS8Y5cjb47Rz6N43K2hBWzt7scl6PuH9BK2U8z3RxtYjqy4ZW1OrFbH1icMJS0f
	 b4VpAMCAF99cRjuVOY27aylqpLptyuuFI0QMV1d7ETDxkZcpZYfUx7xRNV5AfSKWCH
	 ZgTYlUdsbXYS4DIGa3JdN0jIl0Z4Pb062WwEigKSfNmTqR4VnuVjjdCv/+8BN5mlWh
	 0Ct9HQdu9vktA==
Date: Fri, 23 Feb 2024 10:25:17 +0000
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Dharma.B@microchip.com, alexandre.belloni@bootlin.com,
	linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Conor.Dooley@microchip.com, thierry.reding@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, claudiu.beznea@tuxon.dev,
	Hari.PrasathGE@microchip.com, airlied@gmail.com,
	Manikandan.M@microchip.com, sam@ravnborg.org,
	u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org,
	conor+dt@kernel.org, tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org, bbrezillon@kernel.org,
	linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
	daniel@ffwll.ch
Subject: Re: (subset) [linux][PATCH v6 3/3] dt-bindings: mfd: atmel,hlcdc:
 Convert to DT schema format
Message-ID: <20240223102517.GM10170@google.com>
References: <20240202001733.91455-1-dharma.b@microchip.com>
 <20240202001733.91455-4-dharma.b@microchip.com>
 <170738899221.920003.15342446791449663430.b4-ty@kernel.org>
 <cedecdb7-fe4a-42ea-9a11-faa82f84b57d@linaro.org>
 <ffd43756-b24e-4f19-be33-0e33047ad70c@microchip.com>
 <20240220082026.GG10170@google.com>
 <9dbfbeac-3a00-4571-95c0-83e4d47737c5@microchip.com>
 <20240222232118.GA3786028-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222232118.GA3786028-robh@kernel.org>

On Thu, 22 Feb 2024, Rob Herring wrote:

> On Tue, Feb 20, 2024 at 08:30:38AM +0000, Dharma.B@microchip.com wrote:
> > Hi Lee,
> > 
> > On 20/02/24 1:50 pm, Lee Jones wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > > 
> > > On Tue, 20 Feb 2024, Dharma.B@microchip.com wrote:
> > > 
> > >> Hi Krzysztof,
> > >>
> > >> On 12/02/24 3:53 pm, Krzysztof Kozlowski wrote:
> > >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > >>>
> > >>> On 08/02/2024 11:43, Lee Jones wrote:
> > >>>> On Fri, 02 Feb 2024 05:47:33 +0530, Dharma Balasubiramani wrote:
> > >>>>> Convert the atmel,hlcdc binding to DT schema format.
> > >>>>>
> > >>>>> Align clocks and clock-names properties to clearly indicate that the LCD
> > >>>>> controller expects lvds_pll_clk when interfaced with the lvds display. This
> > >>>>> alignment with the specific hardware requirements ensures accurate device tree
> > >>>>> configuration for systems utilizing the HLCDC IP.
> > >>>>>
> > >>>>> [...]
> > >>>>
> > >>>> Applied, thanks!
> > >>>>
> > >>>> [3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
> > >>>>         commit: cb946db1335b599ece363d33966bf653ed0fa58a
> > >>>>
> > >>>
> > >>> Next is still failing.
> > >>>
> > >>> Dharma,
> > >>> You must explain and clearly mark dependencies between patches.
> > >>
> > >> I sincerely apologize for any confusion caused by the oversight. I have
> > >> organized the patches according to their dependencies in the patch
> > >> series, but unfortunately, I neglected to explicitly mention these
> > >> dependencies. I understand the importance of clear communication in our
> > >> collaborative efforts. Please feel free to provide guidance on how I can
> > >> assist you further in resolving this matter.
> > > 
> > > If this continues to be an issue, I can just remove the commit.
> > 
> > There won't be any issue if both pwm and display binding goes before the 
> > mfd binding.
> > 
> > Could you please pick the display binding as well?
> 
> As this is still not resolved, I've applied the display binding. Not 
> ideal, but should fix next.

Works for me.

-- 
Lee Jones [李琼斯]

