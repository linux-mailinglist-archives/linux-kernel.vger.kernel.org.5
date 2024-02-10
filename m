Return-Path: <linux-kernel+bounces-60442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE01850500
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABC528407B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA665BAFF;
	Sat, 10 Feb 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwW9dlAL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4FA5BAC1;
	Sat, 10 Feb 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707580360; cv=none; b=AvZHv0NCLV0A3JA01os15BrKVwLh6eRQpDsRdumxkGRPeFa1TyTrqv8oE/Ge4IJv4QZqGYJeFBoQRgzzsyUaBnU+28hvq3+/dEBncJLX4iwKum2sakBgWTusvkUW2qfZ0dd/ETyqVZNYbYFU4W7yB4Fw3fJKfsbccMU7OuAE8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707580360; c=relaxed/simple;
	bh=KmRdhdIm1e1YU1Z6SApSOHV6og3dM5i8UxxHp/UIxk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1OqDFRBZfx9IeG/KN9j0Aw3hQ7Dgs08Rjfhqmq+p0dLEnJRLCYTdVTFNVxVPdAMANML2QBOmdiLWV3QA80XcpJ2su7S2YB7NZFLA6vX5NG9e7aLiZxybdF+qK7W5vKtsnKuVu6YwZXq7PqH9KijBKpa60PqopyTaFullwyikaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwW9dlAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C405C433F1;
	Sat, 10 Feb 2024 15:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707580359;
	bh=KmRdhdIm1e1YU1Z6SApSOHV6og3dM5i8UxxHp/UIxk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rwW9dlAL5q+YfP+CFq1zy21CHbAgsmxykad3Z/AfpPIYlpGU/jy4LJEXB7hMXySP7
	 q/WeSdF1IJ5H7kXv4Pp1VI2QcsKXAGG0skbk9y7YsEFgYtuCFB2wSzrtungydqpQLU
	 zgdg2i64goXJFGyCR8DZxF3DxqYlLLD9x7LwaJQWoI4ZPDUByJRORw+h2OityoT/qI
	 gP28VBMucnmfn2pVXcT0lmECdQ7sOVeHzRDcmszK3SYREmRmJ9unUdVtHsHza7DqsM
	 YWJOLDHUAfSb40EEk5rmOYpi6xWyYgSmM8fRXG/57Ptf6Yr1upNzfSEqnLJj97NR0R
	 dZwd9Mcb+StwQ==
Date: Sat, 10 Feb 2024 15:52:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: alexandru.tachici@analog.com, alisa.roman@analog.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com,
 krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.hennerich@analog.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 3/5] iio: adc: ad7192: Use standard attribute
Message-ID: <20240210155226.5e509845@jic23-huawei>
In-Reply-To: <20240208172459.280189-4-alisa.roman@analog.com>
References: <20240208172459.280189-1-alisa.roman@analog.com>
	<20240208172459.280189-4-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 19:24:57 +0200
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Replace custom attribute filter_low_pass_3db_frequency_available with
> standard attribute.
> 
> Store the available values in ad7192_state struct.
> 
> The function that used to compute those values replaced by
> ad7192_update_filter_freq_avail().
> 
> Function ad7192_show_filter_avail() is no longer needed.
> 
> Note that the initial available values are hardcoded.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Looks good. Thanks for tidying this up.

I've nothing to add to other reviews that have already come in for v3.

Thanks,

Jonathan

