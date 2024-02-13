Return-Path: <linux-kernel+bounces-63880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB5A8535E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6EDB23485
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C75F86B;
	Tue, 13 Feb 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVP+CvKX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E621F5DF29;
	Tue, 13 Feb 2024 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841376; cv=none; b=K07cNbZ4F7WJMYDcDbgm+8/K9uLB3TPm97TvjGXFUOBaQABT8gKUF67WleQn3URnhOsWKtVbGlUevGycWQ66TQkwkk9DVikGZH282ADAcXdTg8Y90w1XEVxfoARSq8YT8Cbg95UqXR8wMJsGRqGbwXkM+JjDMEFJ+EpC8X9xmgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841376; c=relaxed/simple;
	bh=fIA3aW5055vv1BXBHHsVw8iX52W5DJjKmsOOkP5CEOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWW/9U9rwifg9RjlsFkOTpUa30uof+kjgLHxWbQG9YY2U9j0mHbSQKcUkWwl7svJlNP8C3Jl5hyOb6qBnmPGdVy7Zr0k98wxA4/uo7cAxBOkxwSpM7tAZouC0AvZ39Cseyhv9ZCo0fz9Btop7/RkxACf3/I1VQVMHV+1NrBfzBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVP+CvKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42176C433C7;
	Tue, 13 Feb 2024 16:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707841375;
	bh=fIA3aW5055vv1BXBHHsVw8iX52W5DJjKmsOOkP5CEOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVP+CvKXLN2IKTMoEchWXFyhJqcf3W9QPSa9HL6H21RFwpwmkpcE772G1X04awM4a
	 dLCQKig+UVubCJErl6XIEgLSMruRQBA2dmrSvzpgXwvTO5kgLOVcoGler+6KZqvc43
	 SFRzErUhfjYzcsblvSLvA6PqIVYAjserVRUddT9GlF4NDQ8oB/gf8iKcSrsYqhNg21
	 N0/m2saji6yKlWp+LxwDYa8ZsRyAs867jmU/9kbuJO5+fd5xp+Pzrub75X+Zsp1eKV
	 y3EY1JptS3gPXgik+q53L+uiRUOK6CwqYhNJhptbfSDTOTRlML44F3mfq7oCKYCfaz
	 2mN7gD8gPILug==
Date: Tue, 13 Feb 2024 10:22:53 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] docs: dt: writing-schema: clarify that schema should
 describe hardware
Message-ID: <170784137234.1471609.28208145468139925.robh@kernel.org>
References: <20240212150524.81819-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212150524.81819-1-krzysztof.kozlowski@linaro.org>


On Mon, 12 Feb 2024 16:05:22 +0100, Krzysztof Kozlowski wrote:
> The 'title' and 'description' fields in Devicetree schema is supposed to
> describe hardware, not the binding itself.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/writing-schema.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!


