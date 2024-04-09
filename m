Return-Path: <linux-kernel+bounces-136961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2730989DA5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA4FB25B0D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEAE12FF73;
	Tue,  9 Apr 2024 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MON71pSk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2512A144;
	Tue,  9 Apr 2024 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669464; cv=none; b=WlGae4+cb633tQvwnAxLf3Sy31VdHwTUN4j7S4XCqL9l1u7SSwImGUO48deSYBD/ogmaiVk0dkM5YfO82hRfrm7kVz/dRnBJmb+RxWIBIA2ERzZMB3QmqVRvU04lak9kNv0ACjESB/eNSKsfgzhJFAqVchcy1w/hz5cik6eoxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669464; c=relaxed/simple;
	bh=C5Pgvgm3baCPKcrkdPQDnpWS7wMXweORPfyVxBxJtII=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=dwCL5MAaZrw6AJ1fBWvDGITeg2wQxyPrOdlKgUEPfdvwuK6KpYDENDOSpZUtKKe5bMQpUtEHpKKDaj8ShKtCSED4IZGlef82ufv76q92pKbCfag1f5n+3GnnJNq2EmudwoTIeXgR6rCzv5vBkm0cSGCjhWr4UBU4Y40Ofkq8c54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MON71pSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFBBC433C7;
	Tue,  9 Apr 2024 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669464;
	bh=C5Pgvgm3baCPKcrkdPQDnpWS7wMXweORPfyVxBxJtII=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MON71pSkaCjpYpANsLx7RFQYqc1znbqTBrx/5arKf7zzStcEH+auE9EvWac6sKC/2
	 8aZD1t4FcuU4M+tDK1y0+SpCRqxxM4UWTl5i/mqFIMv8F7jFFNWX3Z2wmQruIZrLW/
	 Ayz1WZmw6ozS3v7o/Wa7aWdwUzHgZydnHU3GYfNRssq+1Lv1RdNxyzEdBmNWtYeyAd
	 qdPRR+NltcJhLj4uClPmIVa6n+MvWH8CRe963O5ZQE7WBHG/qKmz+MZvFhfPZhv6iu
	 OJi/O++htw1gam3CC0Zg0OUt9Mroi+whS6/3Vp0naNCYvs9XPkb+JzxXxskx2PH8qJ
	 54fncFaIjWtyQ==
Date: Tue, 09 Apr 2024 08:31:02 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240409123556.34299-1-mike.looijmans@topic.nl>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.67250ca5-6a79-4048-b845-3d240ff83a75@emailsignatures365.codetwo.com>
 <20240409123556.34299-1-mike.looijmans@topic.nl>
Message-Id: <171266946179.1029796.4237832991239731761.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: ltc3350-charger:
 Add bindings


On Tue, 09 Apr 2024 14:35:54 +0200, Mike Looijmans wrote:
> The LTC3350 is a backup power controller that can charge and monitor
> a series stack of one to four supercapacitors.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v2:
> Rename to lltc,ltc3350.yaml
> Fix spaces and indentation
> 
>  .../bindings/power/supply/lltc,ltc3350.yaml   | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/lltc,ltc3350.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/lltc,ltc3350.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/power/supply/ltc3350.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/supply/lltc,ltc3350.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240409123556.34299-1-mike.looijmans@topic.nl

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


