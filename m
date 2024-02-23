Return-Path: <linux-kernel+bounces-78794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FBE8618EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024281C23799
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3906A12B173;
	Fri, 23 Feb 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/s2q3Wu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF212D1E1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708252; cv=none; b=htp8jP9sTCFpubWghxdRGpWuxUwuZeFehn3AJ1AcV6Z8vKGow8xHCvR9CEx4Ol1pf/XNvWmvUh8DIZ9BVy21vCeZ6Pb4sRvv9y2VXgXzi7g1hLn8GNqqP2dq03/UP7O79OVdqZH0DTag53kgJjPt/6lu1ytUBHOXlAKgfGTpcHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708252; c=relaxed/simple;
	bh=pYpfvjVyKJQ8crPvbDZLLP1IDgxmSyhVvhjwuhWMvTc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DbbjxsiZnZB40Rb/Zs1ckNbMRkBumkggnBZKprg92NW0anCwoGEvoDKrsErtUELyFkcSVnGbo4JEAsz1Nx0ABbJuwkp8twryLGZn57DjVjdcYcPathPEM7RM5vfj+uXgDnXTDqqEPaN+vxiiKgfz52M5HF+IRNAk/T/jqKfHwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/s2q3Wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E98CC433F1;
	Fri, 23 Feb 2024 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708252;
	bh=pYpfvjVyKJQ8crPvbDZLLP1IDgxmSyhVvhjwuhWMvTc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e/s2q3WulQqMg8Tq/dHZdkfQ/0iDkCZrnfrIVxBhHt2sE5dlhW+YP4A0z990BnVfn
	 hbHB2d9z9Z9R79gchs1DBvFxLX/RNYhgWXkNb7VoLf6VlJUr8/Fs2uvHnio9B5KbrP
	 QCI7+dSfrdu80CZeKmB3fl034M62PP/uR1dIAwCGCcRkNZoGIZMAfCSzoR+XdNwGm0
	 rg6hYcHK38uEzummIuDZxZ8vkwiSSoQ9+YMnkEoR2bkBdfSKz/nOPBKErlo6q5SbcZ
	 y88DvIb/rQ5fGSRMCGhGGCIe2GEoI/lfZYaRMZnYu/UPD8nTBzp3S02Ewn7FKBLhzc
	 83N8lGqEo3jMw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Michael Brunner <michael.brunner@kontron.com>
Cc: linux@roeck-us.net, mibru@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <af8756be81c9062f9543d2e5d9373cf5e7877b1e.camel@kontron.com>
References: <09855448430a5f090dbe09cbb269959a08881ee7.camel@kontron.com>
 <8ec638c2-93b6-48e4-8ac4-965072b1d5af@roeck-us.net>
 <de6bc09c779a4b4fa2ddaa1fa3a595de323b7f5a.camel@kontron.com>
 <20240223105242.GR10170@google.com>
 <34ae1832d52a3f03994843d01cd1d9a0ecb7a72d.camel@kontron.com>
 <af8756be81c9062f9543d2e5d9373cf5e7877b1e.camel@kontron.com>
Subject: Re: (subset) [PATCH RESEND] mfd: kempld-core: don't replace
 resources provided by ACPI
Message-Id: <170870825079.1761522.12154066677073415030.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:10:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 23 Feb 2024 12:39:12 +0000, Michael Brunner wrote:
> The current implementation to retrieve ACPI resources is faulty
> and may cause issues that even can lead to non-booting systems.
> 
> When adding data from an ACPI device, the resources are already
> assigned to the platform device. Therefore there is no need to
> retrieve the resource list from ACPI and manually assign it to
> the platform device. Also there shouldn't be any BIOS in the wild
> anymore, that does not have resources added to the KEMPLD ACPI
> data.
> 
> [...]

Applied, thanks!

[1/1] mfd: kempld-core: don't replace resources provided by ACPI
      commit: 8f4585bae2d30813e06000497905de7d4cfe6aea

--
Lee Jones [李琼斯]


