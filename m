Return-Path: <linux-kernel+bounces-7024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9068781A09E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4D528BCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9309E38DEC;
	Wed, 20 Dec 2023 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bdch5OHj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962C25768;
	Wed, 20 Dec 2023 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703080975; x=1734616975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K0MixWLpJHlx47htWZ57ys4gmb+eFZdwC0m3BCSY4Sw=;
  b=Bdch5OHjErxw6xT1MWYnRUkPbgX4DBfiG2Lo5IGE6OBGEYlc25Jsx8DB
   kYcWRr4n9BkMVps07FmatOSz+M5/f2tZo4iWXU9M5GNAu7BbPEgvabz8T
   qpAfUdAx49xUhKi9gbQpLd6PI7qJY8QUQRGfa9tpWuO7nSt1t06pgbeu8
   w082PsIR0drIejZ/iM20oVwJh42r6379T7TM0EnWT/SjrJWOxOGWg5EeS
   KPXmvgaXIVJ+5XL8dd9BjZiO6y+dQEC5choZQQKIbq/BQsjS8c/J2B64i
   0oUFh60Bp6DJB6RfNP1zZPfVGdN9onbRReaVRHNsxAYc+7csWE4fZI6yn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2655328"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="2655328"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:02:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1023480546"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="1023480546"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga006.fm.intel.com with SMTP; 20 Dec 2023 06:02:49 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 20 Dec 2023 16:02:48 +0200
Date: Wed, 20 Dec 2023 16:02:48 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	cros-qcom-dts-watchers@chromium.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: typec: ucsi: Add qcm6490-pmic-glink as needing
 PDOS quirk
Message-ID: <ZYL0CJ/X3P0kXMQi@kuha.fi.intel.com>
References: <20231220-fp5-pmic-glink-v1-0-2a1f8e3c661c@fairphone.com>
 <20231220-fp5-pmic-glink-v1-2-2a1f8e3c661c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220-fp5-pmic-glink-v1-2-2a1f8e3c661c@fairphone.com>

On Wed, Dec 20, 2023 at 11:02:57AM +0100, Luca Weiss wrote:
> The QCM6490 Linux Android firmware needs this workaround as well. Add it
> to the list.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 53a7ede8556d..0bd3f6dee678 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -298,6 +298,7 @@ static void pmic_glink_ucsi_destroy(void *data)
>  }
>  
>  static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
> +	{ .compatible = "qcom,qcm6490-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
>  	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
>  	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
>  	{ .compatible = "qcom,sm8350-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
> 
> -- 
> 2.43.0

-- 
heikki

