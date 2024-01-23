Return-Path: <linux-kernel+bounces-35041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B9E838AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F681F2340F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F171A5DF0C;
	Tue, 23 Jan 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/nYxYtO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7875D72F;
	Tue, 23 Jan 2024 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003421; cv=none; b=MEivkq3r6yXjD80Byr6fUsA87Bbl5rMm8VidiYVzdOODZloO7fkwsLiMP0GxfPP5YCalQrYCArSaPOnAdqmkFgLkHsk1RHA6euDPmsB23ZXZTIc3pm8RunErXfLrsI71QeVRFcMWNtcJYu2/rNymtECL3Z33wPK9x8dea7Pkr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003421; c=relaxed/simple;
	bh=9BExhrmqoHD9gvDqNZduVxiWMelKYXXILPkBvgv+4JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAv58Wx2K/JiPB5YNN+RZimaHbbUX9/WypDCkiFwo6jxF1UGWms3fSoo/Hen2YkDM0j9els1L4D+jsFQKj7KT3Yuus2plCSEffbrgbWmtqOuOSYT7v6U9X9d2gslCvt3IBCGX+rJHEoTAsxQYEwCLdUb0uMdQWLGEISnVbBkShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/nYxYtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C92C433C7;
	Tue, 23 Jan 2024 09:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706003420;
	bh=9BExhrmqoHD9gvDqNZduVxiWMelKYXXILPkBvgv+4JE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t/nYxYtOn03LMZvMPFvgjtLjRAk8LljMm/aUiPO4yjbJSX/SSUSnxeo8a4EhpLb68
	 o4Lcb20yoXIH7HuPQvaOaGb0fr0j7AoSbn3j/88n9XBEfCOHCX54S8qcSDVSpq/FX7
	 /vvsQ7WErwGtTr77NYIDnDm/4PfoLS2yd3DQo5fRfTrDoNKXDsphsD2jXemIcTAYef
	 QS7IVD2ECu6mdoBT30gagPXxeRuPbdyu99v9XaEH+tZvGAjZRow0zPTZdXGDxJrqzl
	 8WoJR4+9cICf+op2mwuOdy2ADwSoAHFaW5BfDpbUMXDDzz3+iWVXmzbQggdYN1rz0X
	 utoOzgsIaqDQA==
Message-ID: <50f79727-d82a-4122-9b3e-66dd09027ab5@kernel.org>
Date: Tue, 23 Jan 2024 11:50:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 21/22] net: fill in MODULE_DESCRIPTION()s for
 cpsw-common
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 abeni@redhat.com, edumazet@google.com,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org, weiwan@google.com, Rob Herring <robh@kernel.org>,
 Alex Elder <elder@linaro.org>, Simon Horman <horms@kernel.org>,
 "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>,
 "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-22-leitao@debian.org>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240122184543.2501493-22-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/01/2024 20:45, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the TI CPSW switch module.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/ethernet/ti/cpsw-common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw-common.c b/drivers/net/ethernet/ti/cpsw-common.c
> index 26dc906eae90..57fe936bb177 100644
> --- a/drivers/net/ethernet/ti/cpsw-common.c
> +++ b/drivers/net/ethernet/ti/cpsw-common.c
> @@ -90,4 +90,5 @@ int ti_cm_get_macid(struct device *dev, int slave, u8 *mac_addr)
>  }
>  EXPORT_SYMBOL_GPL(ti_cm_get_macid);
>  
> +MODULE_DESCRIPTION("TI CPSW Switch common module");
>  MODULE_LICENSE("GPL");

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

