Return-Path: <linux-kernel+bounces-42770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54EE84066F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463081F264B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BC1629FF;
	Mon, 29 Jan 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am2M/Eo4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08A629E6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534012; cv=none; b=PxGcuWkz0o0e/aVEbF33v6QhGC6nQEAiqARfJxrmEE435GiahVfExo8pEDrPAaB6ucOmD+G5kZ4YrzB+D/8DxZwKD/Ivap9SxUbJxvhATfzcB6z/Dg56wnQfFdQjTjSm7lX/39ur3HCqUA7g3x7lbGpmnR82UCqKJAKeAb7Jur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534012; c=relaxed/simple;
	bh=XwV0g2CwZMqMa5ckxPruOdi/ginAlkrdcW+c2mTUjDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SZF29r1JErs8HyGb4JlhcyaRNVlFdUTkJQelKqwPgC+4PNhXBxief/41sae0gyeaNyHjcHl5kc+n2IoIYTSruxLcCtbmk/Rj9xcVOijvuRsaG2tVnNzJn+DS95ge1IOuiX7XpRL1HTFvL2Iyj5aUKZN+GdxbUt97vS2J7Uct2t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am2M/Eo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A332C43390;
	Mon, 29 Jan 2024 13:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706534012;
	bh=XwV0g2CwZMqMa5ckxPruOdi/ginAlkrdcW+c2mTUjDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Am2M/Eo4OE1Vjhaomxy9ec6vwabgFvHqb6ib1y4Rp2WQq9s0A7abA2plJcwAUA5Qa
	 5Kk9MKQCKaeSsR7RIUzFGmjL63GFSrkwYvbAkzlVuDYjTR3+ujIzTXnddGpDWsKh0P
	 V32KM7lWya6JLujbQ6LO10zEHIly1UnfEsou6m7QkAgvh9p0kLq5N/VJjcyU1Z2QlZ
	 fJ78SK7FmIXTf3Nc15dlKBJj+UIcmtrfIh3oH1mqBKg1zfmqc05xJdET27r9gdRzUx
	 XZEPfapeqL3Zhrpe4tlw6yiEbLtIKpYcfFselT4gwNH23WP8G5OGr9VE4jUSJ1xI43
	 RM6Q8iKkxsEhg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org,  michael@walle.cc,  miquel.raynal@bootlin.com,
  richard@nod.at,  jaimeliao@mxic.com.tw,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mtd: spi-nor: mark the flash name as obsolete
In-Reply-To: <20231215082138.16063-3-tudor.ambarus@linaro.org> (Tudor
	Ambarus's message of "Fri, 15 Dec 2023 10:21:36 +0200")
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
	<20231215082138.16063-3-tudor.ambarus@linaro.org>
Date: Mon, 29 Jan 2024 14:13:29 +0100
Message-ID: <mafs07cjsth8m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 15 2023, Tudor Ambarus wrote:

> The flash name is unreliable as we saw flash ID collisions. Mark the
> name as obsolete.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

