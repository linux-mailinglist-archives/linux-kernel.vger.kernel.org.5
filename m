Return-Path: <linux-kernel+bounces-58487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A95C84E70C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091521F22334
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB61C12838B;
	Thu,  8 Feb 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubFkWRO+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D2128370;
	Thu,  8 Feb 2024 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414381; cv=none; b=OCogHSveWzLXdfmaMds6Vn4+oqKXRac8X/RVx2OrOzLdPGEkDN9fR6/6fPr4CKBSwacuaS7ejqljxjO2N31VU9OfSyDEE8npYvWq+O70kDuiW5M9QZy8SykC3sKI3TuqxLJZ3p6WhA48OU/eHXrVaqrbv6PU8lK9PhjyxTUsJX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414381; c=relaxed/simple;
	bh=gZJ1hTmX3rC/1A0BTzbCh0fkTFyn8b6e1vTOiU0fHEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/5xMiDTR+J/oS3ymqLJrQL5d/G12Ypw1/MjbzH/U9K6KIjceKAs9U64ZPIkez7kQumvtQUWppwtiMpLvbrFhNBhRchSyMuQjqkPQAb1IqJ3120BthFMUePlKYUgCptYBw4RM+53jPxfwTS+Rdl8X0WRpe1kbFzpVrtUrN8ghBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubFkWRO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F28C43394;
	Thu,  8 Feb 2024 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707414380;
	bh=gZJ1hTmX3rC/1A0BTzbCh0fkTFyn8b6e1vTOiU0fHEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ubFkWRO+Dt0b+aIf9MU5tfq9j0tuGoPJ+jJcLq5UoBglzXRgpL94u1Ao3H9LCJvd/
	 t/c0uDSX7nq//dHreOoJPMuSLy/SLdhG0VYv7zCnsicT95CciqzuTsAtqe7jnfgGia
	 koTLAj5i0H4jQ/2OA/5G7/06FqEnv5zO9cftMjfo8qDy+kO9JQ4Dbfqsc15pUtgGNK
	 XM6tcnglWkfKUF10bYsAgIyvcVFra5s2bgTeEJNL3liINNiZwQxN6SllfSc5lW2F56
	 8ofSAH3u0UvNQJ3UOkeFNhQOcvMEnyS3iXzpHQ+0319+KdOEss8Qeh+lVdlugfRcMZ
	 eE900ZqZTj9zw==
Date: Thu, 8 Feb 2024 17:46:16 +0000
From: Lee Jones <lee@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, andy.shevchenko@gmail.com,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: (subset) [PATCH v4 1/6] spi: cs42l43: Tidy up header includes
Message-ID: <20240208174616.GY689448@google.com>
References: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
 <170740158622.1056271.11724106959925085700.b4-ty@kernel.org>
 <ZcUSIoAXmYsm0Lui@ediswmail9.ad.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcUSIoAXmYsm0Lui@ediswmail9.ad.cirrus.com>

On Thu, 08 Feb 2024, Charles Keepax wrote:

> On Thu, Feb 08, 2024 at 02:13:06PM +0000, Lee Jones wrote:
> > On Mon, 29 Jan 2024 15:25:52 +0000, Charles Keepax wrote:
> > > Including some missing headers.
> > > 
> > > 
> > 
> > Applied, thanks!
> > 
> > [1/6] spi: cs42l43: Tidy up header includes
> >       commit: 0863c47b4147b948a23f03031ac880096512a878
> 
> Thanks all, sorry about the confusion I really should have kept
> including the blurb I did on the first version of the patch that
> pointed this out explicitly.

No problem.  I would have probably missed it anyway!

-- 
Lee Jones [李琼斯]

