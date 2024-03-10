Return-Path: <linux-kernel+bounces-98249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D23A87776B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AD21F211AB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D0381AA;
	Sun, 10 Mar 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR9bO0Ho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B87210FB;
	Sun, 10 Mar 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710083228; cv=none; b=S8LAyEKbRqXonjo/PdlvUCsmJMLwPqt82QC+0QDZn5zAQq+YRVtatqa/HXGICLiCHphrtkoSAv6jeB82gx5zSZto2gvAf4H4kNkF8CCeOVV/GHFqaRB9ZT8N6JqyqyaBV0bKAE7z8dEoB/E1y1ojiQ6PdYafO5jeiFbv3LlPv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710083228; c=relaxed/simple;
	bh=Uo9l+ZSD6+D8MDMbJX0ym9Al9u5UzvzXxvOld3GHnrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLmEk7SjFevOhO66hMNa24bLML+sOE77N1yRE0G2uhKza0/NFixcLgbHW2fVTsXKN7zC1N48ny7Kel0MVwwlwrE7a1Ar939KVklMiri/WDAqj6nj6YqNrZkjNLry6G6mpEuB64jjJNqB3sVL6xp3LzbGF7TRzMou20ZLACbL0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR9bO0Ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7200C433F1;
	Sun, 10 Mar 2024 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710083227;
	bh=Uo9l+ZSD6+D8MDMbJX0ym9Al9u5UzvzXxvOld3GHnrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CR9bO0HooPBNWBeLh23LJxM7B7RYoqhCVj3oH+cXlzN0voW2yjBnGap1fbn97HnzN
	 +1cGFucEwZVSb2cf5kScgc+WYYYjjcC2f/y8/bfd3gVIXQXaNHyljJtsXazUxaShVN
	 kUa1O32wOTcdP7LAB1YtT51CuzAORGp8b/EmH+U7IL9jMSO8vXrOKndrymZ+Q/ta80
	 cbxnSOBvj4gJWayCivdfF2d3LrCfom7yXx1lp7FPzzPenp7dX6vNbF7wBK7fxpB02U
	 UIEVoInPNax81fJKs99Ea0BQ+uWejMzNoXjQTOPAFROumkJzQLKWCAoVEMQVWTjyg1
	 AKUZQY0epZt0w==
Date: Sun, 10 Mar 2024 15:06:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dlechner@baylibre.com
Subject: Re: [PATCH v3 0/3] Add support for additional AD717x models
Message-ID: <20240310150651.7ea9bb63@jic23-huawei>
In-Reply-To: <20240306110956.13167-1-mitrutzceclan@gmail.com>
References: <20240306110956.13167-1-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 13:09:53 +0200
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> This patch series adds support for the Analog Devices AD7172-2, AD7175-8,
>  AD7177-2 ADCs within the AD7173 driver.
> 
>  Datasheets:
>  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-4.pdf
>  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7175-8.pdf
>  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7177-2.pdf
> 
> This series depends on patch series AD7173
>   https://lore.kernel.org/all/20240228110622.25114-1-mitrutzceclan@gmail.com/
Applied to the togreg-normal branch of iio.git and pushed out for 0-day to
take a look.  This is 3.10 material now given timing.

Thanks,

Jonathan

