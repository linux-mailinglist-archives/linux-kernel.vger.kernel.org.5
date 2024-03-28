Return-Path: <linux-kernel+bounces-122767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2B988FCF1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681AD29B1F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC17CF21;
	Thu, 28 Mar 2024 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=holoscopio.com header.i=@holoscopio.com header.b="VPL5dvFP"
Received: from grilo.cascardo.info (trem.minaslivre.org [195.201.110.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A450158239;
	Thu, 28 Mar 2024 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.110.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621527; cv=none; b=e0EEfoW5ldWjXbijJhba8AAqA4A/J2MQQCCQZys8AC/tengKQBI5gtOCJSdoTSV+PWIqs1Xc71Yj/sDJav8qAjCwhF4gPRs1XEXqmjWzcyAzUZ2Rxysf65F1QIGvnKM9qgDrj1vHEIpzmajYC22Mvb8vL3C07jmrsEQ+H7+3kag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621527; c=relaxed/simple;
	bh=d8qZMuxobQ9NQ+uTJ8eeu7ofwq5oepk3x8NbHvHajl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuapznrTWJdt2aBYklSCphdU0DDeLi+GAyC+a7uPgZEXnN0AF0hevmUpnZeKy8A+O0eHh3vmx5zu54X2vMk+ZKdPiJBM6+F+Lk8rvWsZ9Wa3Jqd8zdUaOZg+Js+OB2YWCNyuhCI6MUu2VNBpPHTNSO/0dWR7gp2WFVr6TWZ40Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holoscopio.com; spf=pass smtp.mailfrom=holoscopio.com; dkim=pass (2048-bit key) header.d=holoscopio.com header.i=@holoscopio.com header.b=VPL5dvFP; arc=none smtp.client-ip=195.201.110.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holoscopio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holoscopio.com
Received: from siri.cascardo.eti.br (unknown [IPv6:2804:431:e7c5:1ab4:6a17:29ff:fe00:4f38])
	by grilo.cascardo.info (Postfix) with ESMTPSA id D24D0206F1A;
	Thu, 28 Mar 2024 07:25:02 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=holoscopio.com;
	s=mail; t=1711621511;
	bh=d8qZMuxobQ9NQ+uTJ8eeu7ofwq5oepk3x8NbHvHajl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPL5dvFPC9/KvtZR7dhL29GCVfdBABB9ilSj2h62jCjgj3jNASCQmKccKddwNUR2u
	 YsVTDl1IneRVDN1sl2i083vS8wXNrCVnJeOoACNhfDVrxV18sQ8S9BGenJczRpc0Be
	 hohraa2sTtoUaUhF6GKan9BOWJJh9vKv40DsXWvSZ8CFpj1l2j2YugcG3nCrZSpzJf
	 JfbYHtAZWZs34rq1Uaa4aI5+BoEcImc7aJd1GiXE1WUhnk4JeGzQjUFYCYDv3tgZLf
	 OXY2vM83OKFEOE5Zt+d53o4HmJWd36MVVemcJCkR9kV1WBaVNfjBsxNUEWR4fE5V9u
	 fdb8VgUNzIKZw==
Date: Thu, 28 Mar 2024 07:24:59 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Daniel Oliveira Nascimento <don@syst.com.br>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Matan Ziv-Av <matan@svgalib.org>,
	Mattia Dongili <malattia@linux.it>,
	Azael Avalos <coproscefalo@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jeff Sipek <jsipek@vmware.com>, Ajay Kaher <akaher@vmware.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-input@vger.kernel.org,
	netdev@vger.kernel.org, chrome-platform@lists.linux.dev,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 06/19] platform: classmate-laptop: drop owner assignment
Message-ID: <ZgVFe4MRgQNZW4WM@siri.cascardo.eti.br>
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
 <20240327-b4-module-owner-acpi-v1-6-725241a2d224@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-b4-module-owner-acpi-v1-6-725241a2d224@linaro.org>

On Wed, Mar 27, 2024 at 08:43:53AM +0100, Krzysztof Kozlowski wrote:
> ACPI bus core already sets the .owner, so driver does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

> ---
>  drivers/platform/x86/classmate-laptop.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
> index 2edaea2492df..87462e7c6219 100644
> --- a/drivers/platform/x86/classmate-laptop.c
> +++ b/drivers/platform/x86/classmate-laptop.c
> @@ -434,7 +434,6 @@ static const struct acpi_device_id cmpc_accel_device_ids_v4[] = {
>  };
>  
>  static struct acpi_driver cmpc_accel_acpi_driver_v4 = {
> -	.owner = THIS_MODULE,
>  	.name = "cmpc_accel_v4",
>  	.class = "cmpc_accel_v4",
>  	.ids = cmpc_accel_device_ids_v4,
> @@ -660,7 +659,6 @@ static const struct acpi_device_id cmpc_accel_device_ids[] = {
>  };
>  
>  static struct acpi_driver cmpc_accel_acpi_driver = {
> -	.owner = THIS_MODULE,
>  	.name = "cmpc_accel",
>  	.class = "cmpc_accel",
>  	.ids = cmpc_accel_device_ids,
> @@ -754,7 +752,6 @@ static const struct acpi_device_id cmpc_tablet_device_ids[] = {
>  };
>  
>  static struct acpi_driver cmpc_tablet_acpi_driver = {
> -	.owner = THIS_MODULE,
>  	.name = "cmpc_tablet",
>  	.class = "cmpc_tablet",
>  	.ids = cmpc_tablet_device_ids,
> @@ -996,7 +993,6 @@ static const struct acpi_device_id cmpc_ipml_device_ids[] = {
>  };
>  
>  static struct acpi_driver cmpc_ipml_acpi_driver = {
> -	.owner = THIS_MODULE,
>  	.name = "cmpc",
>  	.class = "cmpc",
>  	.ids = cmpc_ipml_device_ids,
> @@ -1064,7 +1060,6 @@ static const struct acpi_device_id cmpc_keys_device_ids[] = {
>  };
>  
>  static struct acpi_driver cmpc_keys_acpi_driver = {
> -	.owner = THIS_MODULE,
>  	.name = "cmpc_keys",
>  	.class = "cmpc_keys",
>  	.ids = cmpc_keys_device_ids,
> 
> -- 
> 2.34.1
> 

