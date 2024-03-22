Return-Path: <linux-kernel+bounces-110872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5702588650E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A658285E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502231A38D7;
	Fri, 22 Mar 2024 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJhgH++Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2879EF;
	Fri, 22 Mar 2024 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073495; cv=none; b=j5GpZcnCaFEQeTs34B93CV3KuKSAYRtW3f8E8bspYuaTsZ8tOmhT6WMNVakO8XjV9VdWbi+VG2WLfp6V25edOEM6AM7Uqn4XhAvf88ZfWV9YHbpJdO2/DOyKeO64uoL/1/if/QIyjLL3BUhrccIrvuzwk8Lk78/NqrJlXY8jCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073495; c=relaxed/simple;
	bh=hTimIg/uJvJvo33vzYiVEAj++VGGp4ijV/ldwZKy7lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVzgTcyBPrfl+gphEnh0SMi3pVKIcrJ1yZMQrbcvh6JKesLsmgs+MS1VGLmMV2W2H/I2yQUuU4gxb/K/p8qjNBAb4asO+I4fqLQM+i0MjECRPQ5uryBwrUY9AgdWg5ZsolgFq9Yjn+kT5VFtoKPi0vFVkeCZEpL9zfntJ79xbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJhgH++Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349B1C433C7;
	Fri, 22 Mar 2024 02:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711073495;
	bh=hTimIg/uJvJvo33vzYiVEAj++VGGp4ijV/ldwZKy7lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJhgH++QCxZilOdvUxNAsQcun1SHsliSNVVl22bCa7Iw7BcByjzNZOSK1ZpNjvNzZ
	 x3/bxo4bT3nmMQ24kLMyCEbtCalw/C3MazKim4o67bMXeEunUHiDV83WPfj21Vs09N
	 fbdoXAve+4lHld/d9Xb8l8u43aBvXs8zNZbxzsAqZ6yrydFLmkOD5gkN6b70PkJj4t
	 qR3DnuxBk1r4OqUY4mDx2AAaK5TT9SWnzTf1W7zh8S8cQIJjy8iyevsjEYArXaJK8o
	 1G/cjOY8CNW+yEiKznZqRESnUbLVHLYwJTyEHzpKPiFazPRNQoDyXqi3b1rv/hlF16
	 EqenATDQjlMUQ==
Date: Thu, 21 Mar 2024 21:11:33 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Conor Dooley <conor+dt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] dt-bindings: hwmon: pwm-fan: drop text file
Message-ID: <171107349078.3413056.7212721308899572705.robh@kernel.org>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
 <20240321-hwmon_dtschema-v1-3-96c3810c3930@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-hwmon_dtschema-v1-3-96c3810c3930@gmail.com>


On Thu, 21 Mar 2024 19:43:44 +0100, Javier Carrasco wrote:
> This binding was converted to dtschema a year ago.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


