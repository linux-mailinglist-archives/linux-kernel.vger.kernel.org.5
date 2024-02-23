Return-Path: <linux-kernel+bounces-78682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0680486172A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F621C21ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E4284A37;
	Fri, 23 Feb 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc8rCg66"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E474C79;
	Fri, 23 Feb 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704634; cv=none; b=MlcTRCAjrtRuDD3X+t1llnKONUfNUOxDEqF0y3NUjoLpRfuBO50ao0UY5Da+72OZveuD5N4eJqlHc8kO7RC8IcIN3+mDoMVOanJVSnqYpAYdyzOrUXbdgabTETvoNt1I+4GT2gULFon3mgjH8CkvUBKMScxrgvnIiVOJukklNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704634; c=relaxed/simple;
	bh=hScOEA0o05SAaamC0JWgMbFJp6tumeWuBRSNlFaxeSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJR9Swf0zMv1ZaEJs8nYzHSYkkCMLgKuYU6TthMyopIncPAVg4SjhfujdyGU6kvI1XgkHymUkdcJrPZow2wbgyLYK7KEk+fFQvMEKMFc3BoJZpccLuYXtrsFvvimndfoCOGF0CItHto7BkpFvS2rMAJNIA7K4bj3GW5JqZpcLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc8rCg66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C82C433F1;
	Fri, 23 Feb 2024 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704634;
	bh=hScOEA0o05SAaamC0JWgMbFJp6tumeWuBRSNlFaxeSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kc8rCg66XxEWex+0uO+rRofR2MjuROJ8zIjbnN79NMjv/kLxGkmG88uDQO9qWwUag
	 1iK9t8d1gV/3Y0csjq7BjLqAlMN9Gkt3YAu71SRr0WSrCTSQFM4NVJEEyoILV/wHGo
	 BtcQWC4qdJEQI3ocYD6Wh+PiYngrQxjaxMXkUrJ6g3hsil27QEivlFvfZrD1Gw4kPz
	 SfWlvUC9hZHlt0y3XYg18E69fQls5wxo1yijxpkmOgBQ4xIZgHAreKaXTQ65xGOjVu
	 8rdx6/yMIUQgyonU7hqMJsdSoKh6Ii4NYew6o0nGBLN+gGknaEkbRS0Ip8xZHGaF37
	 PPv020QAWDTOg==
Date: Fri, 23 Feb 2024 09:10:32 -0700
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, David Yang <mmyangfl@gmail.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] dt-bindings: clock: hisilicon: add clock
 definitions for Hi3798MV200
Message-ID: <20240223161032.GA2654356-robh@kernel.org>
References: <20240223-clk-mv200-v4-0-3e37e501d407@outlook.com>
 <20240223-clk-mv200-v4-6-3e37e501d407@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-clk-mv200-v4-6-3e37e501d407@outlook.com>

On Fri, Feb 23, 2024 at 03:40:16AM +0800, Yang Xiwen wrote:
> Add clock definitions for core CRG and mcu CRG for Hi3798MV200 SoC.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../dt-bindings/clock/hisilicon,hi3798mv200-crg.h  | 150 +++++++++++++++++++++
>  .../clock/hisilicon,hi3798mv200-sysctrl.h          |  21 +++
>  2 files changed, 171 insertions(+)

This should be squashed into the previous patch. The ack remains.

