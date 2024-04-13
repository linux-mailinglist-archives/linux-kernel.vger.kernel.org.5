Return-Path: <linux-kernel+bounces-143834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691578A3E01
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B8B1C20F87
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB51537F0;
	Sat, 13 Apr 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcoiN0q3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA9205E24;
	Sat, 13 Apr 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713029363; cv=none; b=UEUENag/C9Sgw0LYjAKQTEqp9H/OKtHMToSJTsPG6krcIpI8t4YeHPw27BAQJCkWSeo8bW6JaCGC1y9B+qqs3dcd2c/5dvj6QHKngdnV5tpGzqdO0qewmbdqePW9nNjV+c+q5/qbhqAL9eXHhhepkxqhsP7ybPd50zvyjESUWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713029363; c=relaxed/simple;
	bh=gLX/d4udAtxo3/eeFT7vzMA2kaACKSU25JIk9PgcH2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDGCoY8oDOSxPVAaQzy8QauheqZuzpEjC9EEupYI3TYdlzqRl7p+bcY699wnGdSmRdoyer271vuh4FxJQZ+9qmaEl9NEREDisgzWQrl7Nni4hIIrk6GrVW1ACKhlsQGdQJzC/sVymVFX6XPNzJarpwmHonOj2aDUmKlKxuxjo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcoiN0q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A4FC113CD;
	Sat, 13 Apr 2024 17:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713029363;
	bh=gLX/d4udAtxo3/eeFT7vzMA2kaACKSU25JIk9PgcH2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DcoiN0q3StGmoI7dENP//m05r2FcevmheiL7ijUAWkSBininwNzMyXJgK3k3RUNGZ
	 F9VvgPZPzJ5AUivBCtzG9EOTlcR8TyLeLeKiEH/2W66/VE5UOvzJLD9KfcZHLLSj7j
	 zCc+lJmavs1K3K9S/wo1Y+HTI+i4al6nP9sFs0aWxEbuNILZVAERn6Xn2guoOYfmn6
	 061t0f8h9gGc26i3CeT/30013E+8IlgGNj69dwbVU4o4Gq9kDC56+8JJ+YR/12fHPt
	 KmQ2DWLPsgXyr3V12VDCAKrmScBExAez6m8aswkMy/uuyVwfUxwiLga9xyEBtlNQ1B
	 Peuihr5AQV+1Q==
Date: Sat, 13 Apr 2024 18:29:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexandru.tachici@analog.com, lars@metafoo.de, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
Subject: Re: [PATCH v5 5/5] iio: adc: ad7192: Add AD7194 support
Message-ID: <20240413182902.7de12fd4@jic23-huawei>
In-Reply-To: <20240413151152.165682-6-alisa.roman@analog.com>
References: <20240413151152.165682-1-alisa.roman@analog.com>
	<20240413151152.165682-6-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Apr 2024 18:11:52 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The user can dynamically configure them in the devicetree.
> 
> Also modify config AD7192 description for better scaling.
> 
> Moved ad7192_chip_info struct definition to allow use of callback
> function parse_channels().
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
The rest of this series looks good to me.

Jonathan


