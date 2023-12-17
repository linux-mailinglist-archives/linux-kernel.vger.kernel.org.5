Return-Path: <linux-kernel+bounces-2625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E80C815FA4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4108D1C21EC6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFD044C6E;
	Sun, 17 Dec 2023 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCPmTgEk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B44439A;
	Sun, 17 Dec 2023 14:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC81C433C8;
	Sun, 17 Dec 2023 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702822824;
	bh=0kS8S8R84nY5Gw3olTVvDdLp04UV9KJ0nbMM2OX300w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VCPmTgEkC+sHkO1Iqbtw6NRbG/b9Gem6DxpLDQYzV4FvrmCHSth9JwkiVxYikjRFE
	 I1IckCI3ZbDMYFVR0HPEfjTYC9k20jH7hyb7BhEtBN+OkFEfimlVUnM2CwbYSsFyMJ
	 g6x7EtDu3pl29TJI1qoS/+QNWHK2lREPFjrpmCktdFoq3sQPHMO7Kox570RKm8tQSU
	 KoN6uTRTbK2LRhtYTOO75GAmaQE0/wY4bXeBkH1metE6TfSW1HvY/lT8uxDKyybLiM
	 DfvwpuiOupxxcsmkkTMkfTQUi9mL69tIcGRA0y+3QvH2q2ZpzIrL3pWeq3gWlDOze+
	 oFk3t4/w76bzA==
Date: Sun, 17 Dec 2023 14:20:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Walle <michael@walle.cc>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <20231217142005.5d776025@jic23-huawei>
In-Reply-To: <20231215133512.28735-2-mitrutzceclan@gmail.com>
References: <20231215133512.28735-1-mitrutzceclan@gmail.com>
	<20231215133512.28735-2-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 15:34:58 +0200
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Reviewed-by: Michael Walle <michael@walle.cc> # for gpio-regmap
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

LGTM.  If no other comments come in I'll pick this up once those
DT issues Rob's bot pointed out are tidied up.

Jonathan


