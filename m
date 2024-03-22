Return-Path: <linux-kernel+bounces-110871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731088650B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F287285E65
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC8C4A3C;
	Fri, 22 Mar 2024 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sk+QoMQ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F53FEF;
	Fri, 22 Mar 2024 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073478; cv=none; b=VLsGEW2hRmOK85LApkr94j5Kgvh/U8/SmAET1SCu68znrFtuxw079iloYxp295QgXbpPZZVr+Rlyui3r9sl/Mx2pGJbLNKtTazv00g1dvxHHRI+xEjUAxvo05UvtPGJdnwlepGT/O4cUUN5PC9XU7Q4wYmXlFXIdqHErvPPBlE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073478; c=relaxed/simple;
	bh=bRUwXwcq6+UznH+399UPrJYqI6arNzHseoKpLcYfxe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZjuIorBCmMI6r7GsAC1A2hd7h6eEieri127ro8ujC5ef9VfLOXuZM3rAgGA2LO9VfAIfkHShVQdNjRnxjdbg5gRMkWqOYG5y1NtDvZCeNkk6o98gLSjzkcyLA8QHaIMkAVrd69gftjiyQ90m5jjJoIWQrhY6vGTlG9aC11nCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sk+QoMQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1509C433C7;
	Fri, 22 Mar 2024 02:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711073478;
	bh=bRUwXwcq6+UznH+399UPrJYqI6arNzHseoKpLcYfxe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sk+QoMQ/o/oN7+yK5p3GzogBuI4EwkmP2qoj2f+DN+Z5xODTM9DgPF4n9Os1lZTjh
	 amV+GtKXHwvdiF82dE8cM8qjZ1f6GtWr95h9Pdna7Ln074skbhvZY6ZkneJkYdy7KK
	 KWmZI0XYVINaOfi5ZHxZ58ZZ+wI6AcqvWLzcPutkO7pB5peg5FqnMPNYno6sd5MORI
	 Hfd48TIpZhCL152ozoT7t4nko3jiWykPzxCyg7A2kLlZ7KzkJdgIXVmhSncHqsGP80
	 002dQAXzprnGPhlPMBz7lssZCSPJ8sfS5WrUKA1yw6aniyTfcLdPGydVn/LYb+mHgw
	 SyaXf7AfvxwJQ==
Date: Thu, 21 Mar 2024 21:11:15 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-hwmon@vger.kernel.org,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/5] dt-bindings: hwmon: as370: convert to dtschema
Message-ID: <171107347196.3412490.13524573365195502461.robh@kernel.org>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
 <20240321-hwmon_dtschema-v1-1-96c3810c3930@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-hwmon_dtschema-v1-1-96c3810c3930@gmail.com>


On Thu, 21 Mar 2024 19:43:42 +0100, Javier Carrasco wrote:
> Convert existing binding to support validation.
> 
> This is a straightforward conversion with now new properties.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  Documentation/devicetree/bindings/hwmon/as370.txt  | 11 --------
>  .../devicetree/bindings/hwmon/syna,as370.yaml      | 32 ++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 11 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


