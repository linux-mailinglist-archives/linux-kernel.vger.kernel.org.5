Return-Path: <linux-kernel+bounces-6537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E14819A16
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E400B282A56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EB118E1F;
	Wed, 20 Dec 2023 08:07:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F81775F;
	Wed, 20 Dec 2023 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D4F7B10096644;
	Wed, 20 Dec 2023 09:07:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 81B894F3E; Wed, 20 Dec 2023 09:07:33 +0100 (CET)
Date: Wed, 20 Dec 2023 09:07:33 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Howard Chiu <howard10703049@gmail.com>
Cc: robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz, Potin.Lai@quantatw.com,
	Howard Chiu <howard.chiu@quantatw.com>
Subject: Re: [PATCH v8] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Message-ID: <20231220080733.GA30641@wunner.de>
References: <20211207094923.422422-1-howard.chiu@quantatw.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207094923.422422-1-howard.chiu@quantatw.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 07, 2021 at 05:49:24PM +0800, Howard Chiu wrote:
> Initial introduction of Facebook Bletchley equipped with
> Aspeed 2600 BMC SoC.
[...]
> +		tpmdev@0 {
> +			compatible = "tcg,tpm_tis-spi";

What's the chip used on this board?  Going forward, the DT schema for TPMs
requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".


> +			spi-max-frequency = <33000000>;
> +			reg = <0>;
> +		};
> +	};

