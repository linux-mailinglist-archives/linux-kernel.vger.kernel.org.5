Return-Path: <linux-kernel+bounces-128348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 577F789599C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B43D1F2472B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A196F14B06C;
	Tue,  2 Apr 2024 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkQzNcao"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5D7A724;
	Tue,  2 Apr 2024 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074965; cv=none; b=as3lIYekEBzfDUxAXXo+vHAWH3lPqTgz1o49uiPyySV2mseN582U3K+HpSedrxvuXvuKHGQypra09KCYVR3JPs0LpQvoJ8aNMgUCkmEM8A82AqEJNQYp8bcKGFRd7p1GN1UPoBAID4M78vAW8p2HTjwEOdrd/rDn/EEMeoHidKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074965; c=relaxed/simple;
	bh=TTK9Ecf0wm/vTr19oRkExfQrntAv/w6u+rTBVzSrC0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iokVEWeo8AqFlWVPmyOa5HOJwDcR/HBnbzOphLsgm/7cKejL01NQot3uJbuj5lU4m5IH56qQiCpcbFNClsxaA650/GhVSAvduMVK0H+DeuPCJDayIDAigJFD/G/jvP6mtHohQ7bZwtmcuH1LdfhFMGWc97MCb5x7TcbMGrIAGXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkQzNcao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011B0C433F1;
	Tue,  2 Apr 2024 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712074965;
	bh=TTK9Ecf0wm/vTr19oRkExfQrntAv/w6u+rTBVzSrC0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkQzNcaoCwevoUeoCLg4BigA8IMxCym7HiDT863zs7+Pii441q8F35tDtduy0ntgy
	 OR3v9fQ2dWUHIO6KDEaXsVRIq4tB+k89JgOa4cvaeKsHPsvMn+CRYv2xSIpTTYXqdM
	 PCfraHV8VszI12uB8TzuR+1mgJY2ZaYcm+1jzCihNBCc4h3PAHCKcUqdeJvH7l3oTg
	 d2Ui3/vaHlSo010byYBDrGruOgLSKbKZXXo2aWgg6B+1OrX9LQJjM9nbQ73/Ljew62
	 mCeOWqsU2ePllVu3Xf2ABoO9bwdcC8B03yzuxUQU+9m3QhbELg1VI58BjrKi5zxxhz
	 ghOi+Qlloj8YA==
Date: Tue, 2 Apr 2024 11:22:42 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc: phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-leds@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 1/3] dt-bindings: leds: Add Silergy SY7802 flash LED
Message-ID: <171207496054.248936.15074257911967114651.robh@kernel.org>
References: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
 <20240401-sy7802-v2-1-1138190a7448@apitzsch.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240401-sy7802-v2-1-1138190a7448@apitzsch.eu>


On Mon, 01 Apr 2024 23:23:55 +0200, André Apitzsch wrote:
> Document Silergy SY7802 flash LED driver devicetree bindings.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  .../devicetree/bindings/leds/silergy,sy7802.yaml   | 100 +++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


