Return-Path: <linux-kernel+bounces-110414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8944885EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54151C23441
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBBA137922;
	Thu, 21 Mar 2024 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtqT0y/O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06F133293;
	Thu, 21 Mar 2024 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039805; cv=none; b=dCTzM7HLkAn0oHXABKqx70taMxhcL0F03ghfVDWulb/PdCIl8nSoWE58bLas7Un6MiDAMQh/ZZKQt9/1kkmXad3TxohD6m3HigPnTQljY5yu27afZApHidhZH8rjSoUSY/NcKvAP+6oAiKfhogbVoFH5dMbJ/4ifguJx/ciYam4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039805; c=relaxed/simple;
	bh=w2Bqt6REQUEc+8oa6MIooOGrzfcrj9voWZaWUSHqPuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKiR87cKdsmdyayLAluaQe3IlDhyaKnHQB4BMGyVrs1HT+K9OadDSZ2ldn6Cz/dP7TfpLoabX2KVvf0gchhyG4mk8BOK1XTRoON9LRCD2iWeUvS5Ezsimt08SWSKc5PkAcV3B8rM519UyZGycUREKelSylBi3GhQvWKxzBrMrTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtqT0y/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BE0C433C7;
	Thu, 21 Mar 2024 16:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711039805;
	bh=w2Bqt6REQUEc+8oa6MIooOGrzfcrj9voWZaWUSHqPuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GtqT0y/OApt57zU/6zOp0QcpNwdLdc/civObjsZIGNZ9lrNnrhc0YdJPdUMzLsloK
	 SeP16xNS6lGmkgUfVa7DgPNuCEnd/YNGH9xbvGNm6IkNrJqM1BYtR4NClGIR5A6sXp
	 uxX6YUFv7Cku0wnqN2QJPJ7SDhSKe3qL+mJNXFtXq827NIN6ZRw0IFgAYXZhKrtaW8
	 CYctxuhxMyp3zovwJbt5QzC2lrVi7Dzg4yHBb+0R0sAutVm3YaVf2F8RRKpYO79mlI
	 4cPkS0To4Doap820iEjEgfTcZRZiy7rRQljqqT2iLq67mOMtYiaf2oFeK3EcYuM7aA
	 aSmjHPVEZow9w==
Date: Thu, 21 Mar 2024 11:50:02 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: max6650: convert to dtschema
Message-ID: <20240321165002.GA2087900-robh@kernel.org>
References: <20240321-hwmon_yaml-v2-0-74fa8eb60ec9@gmail.com>
 <20240321-hwmon_yaml-v2-2-74fa8eb60ec9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-hwmon_yaml-v2-2-74fa8eb60ec9@gmail.com>

On Thu, Mar 21, 2024 at 05:33:18PM +0100, Javier Carrasco wrote:
> Convert existing bindings to dtschema to support validation.
> 
> This is a straightforward conversion with no new properties.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/max6650.txt          | 28 ---------
>  .../devicetree/bindings/hwmon/maxim,max6650.yaml   | 70 ++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 28 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

