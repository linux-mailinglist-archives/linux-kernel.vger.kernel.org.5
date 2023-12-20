Return-Path: <linux-kernel+bounces-6548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D3819A38
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C07286AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF8B19BA9;
	Wed, 20 Dec 2023 08:14:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD118E02;
	Wed, 20 Dec 2023 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 218AE300002D8;
	Wed, 20 Dec 2023 09:14:02 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 10C0DAEC0; Wed, 20 Dec 2023 09:14:02 +0100 (CET)
Date: Wed, 20 Dec 2023 09:14:02 +0100
From: Lukas Wunner <lukas@wunner.de>
To: rentao.bupt@gmail.com
Cc: Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	taoren@fb.com
Subject: Re: [PATCH v2 3/6] ARM: dts: aspeed: Common dtsi for Facebook
 AST2600 Network BMCs
Message-ID: <20231220081402.GA3831@wunner.de>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-4-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805222818.8391-4-rentao.bupt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 05, 2021 at 03:28:15PM -0700, rentao.bupt@gmail.com wrote:
> This common descirption is included by all Facebook AST2600 Network BMC
> platforms to minimize duplicated device entries across Facebook Network
> BMC device trees.
[...]
> --- /dev/null
> +++ b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
[...]
> +		tpmdev@0 {
> +			compatible = "tcg,tpm_tis-spi";

What's the chip used on this board?  Going forward, the DT schema for TPMs
requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".


> +			spi-max-frequency = <33000000>;
> +			reg = <0>;
> +		};

