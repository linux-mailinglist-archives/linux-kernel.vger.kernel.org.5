Return-Path: <linux-kernel+bounces-121678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AA088EC57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D00629EF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D2814D704;
	Wed, 27 Mar 2024 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruBfGl1z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CAB14D6EF;
	Wed, 27 Mar 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559820; cv=none; b=eL+P2EFp/bOWom0O2/O/g1Kmey+wsfOiqrTPJkRbx3D56ZiiKm13tJdODg09Fcb6QLm1QXlwYvpjsS52/sMLLM59yFjZ45akkMN6T3XAWVa+Rpn6eZncEFpz+ek8Y0xreNacCBqY0oaTCzCiJRSHFwRClvi6oq9FyFFGXT8RwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559820; c=relaxed/simple;
	bh=r/RSG6mUMn3MFEGfcrP48X4QYM3mnhTQ1J4LhgfE6Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1OEzwgMUFLLXO2wKgqIXRvluXPqFFFF6LiIyUvfGAzqNhSjK5O/vOKqMiPUa0Gjvi8wRDaqh5NfhwT9McylcOZjWLuN9F9+7E/N5nQJnVQMje4x+/6W10KNVq0lFpHoSKO2A8J8XbHQUFFr+ayJfmmpaeFE7cXgWxaDEE4X7nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruBfGl1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B85C433C7;
	Wed, 27 Mar 2024 17:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559820;
	bh=r/RSG6mUMn3MFEGfcrP48X4QYM3mnhTQ1J4LhgfE6Zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ruBfGl1zj8VTMDZq3OEoNtHwwuGyRWFgkHEQvWwFaV6F6x8CP7o8Y882/EtmBVY+j
	 truhKeNEkAhMaWxppWIABjWEQ2jflM/c3dC7dNYSBD7I/Pyh/nB9VO4Gudb+4aFXwv
	 CZMH2P1ttY3Ym1CVLa2g5B44uV+ERfoUnLbA5YCI6o67rKlpgbuaKdyzEidmzO7EXY
	 hF831watPhX4LBkkR4q0DUcrw+1HmU9Y8rmXjD0dXhRzNcFzsjCSLRKo6eY32bjeop
	 Smq2TosA/ZvKhi9YlmmzPX+560GrI7lraIsDs56ZJNzUL+tfW/iVf6r4G1AOCEpqku
	 shRmtJ4xXZLLQ==
Date: Wed, 27 Mar 2024 12:16:57 -0500
From: Rob Herring <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [RFC PATCH 01/13] dt-bindings: pinctrl: renesas,rzg2l-pinctrl:
 Remove the check from the object
Message-ID: <171155981555.3664329.17622502493229927720.robh@kernel.org>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240326222844.1422948-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326222844.1422948-2-prabhakar.mahadev-lad.rj@bp.renesas.com>


On Tue, 26 Mar 2024 22:28:32 +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Drop the bogus check from object as this didn't really add restriction check.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   | 15 ---------------
>  1 file changed, 15 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


