Return-Path: <linux-kernel+bounces-16135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BA882397E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402281C24A7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C77E6;
	Thu,  4 Jan 2024 00:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/OhUouo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09542367;
	Thu,  4 Jan 2024 00:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD01C433C7;
	Thu,  4 Jan 2024 00:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704327354;
	bh=PQSQaWGIFy6CX+nXdrF2dhNFv4Stmlq/cXbCvLt/kS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/OhUouodemCO7MsPxXjy50JIFcBMMH1YcKMwZlznv/nNyLDcE3oWzDSFjGRv4cUi
	 F0egIAh9maLR7HScfZipVxtc7xFow7YZA2DthHBHST0bFiWPPblLE15j5Gzlzh1eR9
	 oZLd2dybgKlrlzb4Zs1S8/nNyi2+6x3GkiQHXtswxUUeMl2Qp0Ocv8eKlwWCncp+FM
	 YCaa5IWeKk6/DLKo2IQ1vV0PuBD/2+uVhPJNbsz8gaI8yAyV6VV5CvY33ty0IVVsOQ
	 nO8IVla5Ui6kdIdRlRvLPfr5ZOt/Izyr662dpdTWAnyHhFVU4Zscx1CnGv8vmFkcZo
	 mb6o//1s3QuHA==
Received: (nullmailer pid 2128936 invoked by uid 1000);
	Thu, 04 Jan 2024 00:15:52 -0000
Date: Wed, 3 Jan 2024 17:15:52 -0700
From: Rob Herring <robh@kernel.org>
To: baneric926@gmail.com
Cc: jdelvare@suse.com, linux@roeck-us.net, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kcfeng0@nuvoton.com, DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com, naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Message-ID: <20240104001552.GA2096243-robh@kernel.org>
References: <20231222013352.3873689-1-kcfeng0@nuvoton.com>
 <20231222013352.3873689-2-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222013352.3873689-2-kcfeng0@nuvoton.com>

On Fri, Dec 22, 2023 at 09:33:50AM +0800, baneric926@gmail.com wrote:
> From: Naresh Solanki <naresh.solanki@9elements.com>
> 
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>   patternProperties:
>     "^fan@[0-2]":
>       type: object
>       $ref: fan-common.yaml#
>       unevaluatedProperties: false
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> ---
>  .../devicetree/bindings/hwmon/fan-common.yaml | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml

Please implement my comments on v10.

Rob

