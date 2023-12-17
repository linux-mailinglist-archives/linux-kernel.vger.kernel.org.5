Return-Path: <linux-kernel+bounces-2629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75343815FB5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1675FB21F82
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0231444C77;
	Sun, 17 Dec 2023 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEE90Lne"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C27446D3;
	Sun, 17 Dec 2023 14:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14ECC433C8;
	Sun, 17 Dec 2023 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702823391;
	bh=1H1tix+lWo7PRIC9NukKzUsFE9MnvTSilpRM7bAhnMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tEE90LnelQAWfxyJmnOzbsKSTycoB8VfXixfekQSuwjBeCFYAV82M0I8slIeh9L44
	 yv/Qy2H3HhPVidtZSkmE4cjXQkmEkN/NLISwoud2AmfE239dUdQLncBF9SBJnQ+YMi
	 Fh5KICsf7aammduEeHNyqdPNmgtv+NmVuBQ9pzyR6PUEHBwgqtLFZQHZY6i1mOsDhL
	 wSgRM4+gs12Mtoc8xJZY//QV4WcnzODBFhHcxzDcHGBYAD1RnoqnnAirexxCr5xuFh
	 gjr7eKQNY9WvxntIlfPK+Awg10FyFIuvalEeEJtyt6ihEXyuub0pVyWVB9cwvu0uwM
	 5/8CqEsiRL5uA==
Date: Sun, 17 Dec 2023 14:29:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH v3 3/3] iio: adc: ad7380: new driver for AD7380 ADCs
Message-ID: <20231217142935.56426fba@jic23-huawei>
In-Reply-To: <20231215-ad7380-mainline-v3-3-7a11ebf642b9@baylibre.com>
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
	<20231215-ad7380-mainline-v3-3-7a11ebf642b9@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 04:32:04 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new driver for the AD7380 family ADCs.
> 
> The driver currently implements basic support for the AD7380, AD7381,
> AD7383, and AD7384 2-channel differential ADCs. Support for additional
> single-ended and 4-channel chips that use the same register map as well
> as additional features of the chip will be added in future patches.
> 
> Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
LGTM.  Just the Ack from Mark on patch 1 needed now I think
(unless other reviews come in of course!)

Jonathan
> +


