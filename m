Return-Path: <linux-kernel+bounces-110808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86BE88642B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4698284536
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADEB3A8CB;
	Thu, 21 Mar 2024 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/6lmD7X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470917745;
	Thu, 21 Mar 2024 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065498; cv=none; b=TK3MH6c47BM0bBOY4JvTG1QTOFoDzEuOS2o5XYM2YcJGpKoOAgxOb+fI3nCfmuKAguG3naxRrX6Sx5Zbx6LfM8o2qVGb5q3WzN0bSDNELQr0hITptUvBB469SrGYgPImiqa209pErT/8XG4uNPB4YilKSYncpYxkj8oVCvCK+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065498; c=relaxed/simple;
	bh=5byoxZjd92VRK0quOasxrtcb67LjRXgcowLPE2Mx+eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMs9dP5wJlzLq1fFRdG294SEVxDGBoGZLn2cDTaF/Gi0gOho3nzZHqKP/fN9ZR3JJhdRUkbtxiRY1NG7FXBGxwpFJjsxZUuLZNHUyKbB37zforJJSjiYhfyUA89Ke+WJCqgfSlifJD6qL5kj4MulNTrsI+iUxzLYLtK3SVQRd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/6lmD7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B198BC43390;
	Thu, 21 Mar 2024 23:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711065497;
	bh=5byoxZjd92VRK0quOasxrtcb67LjRXgcowLPE2Mx+eQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m/6lmD7XXIKKrrK810YlPqYsme0bcE+TAoOeiuANEzorxT1afitg2YjE1kUuU3Gd0
	 L5x6rWrFBBvEsqckWBd9tz6JMMPA1ygVDqsKhVBoaHqhvzc3K4DgTq4uMg4/t2UQIY
	 ns0ztDWPDVpylWIe8xNbGQNzed7zxKc5EGzgDun+lItql2CIsFvpM20hBEPsjB57wV
	 4ya3FOfaIbPtEhfaopvOAPHJIdPx4V2vyc0RtUczCCiNzGZZ4eC+RLKr/riT6wzRsz
	 UvsHA9Re1OGurkrzqFnvVxYjeSiGO9gsO3Qph9f8/0vnETX3turPUzMv3QsMIMRMu9
	 WJWUAaNyyn8uA==
Message-ID: <565d1ac6-2cdc-4168-a8c6-355912a39d75@kernel.org>
Date: Fri, 22 Mar 2024 08:58:15 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci_ceva: return of_property_read_u8_array() error
 code
Content-Language: en-US
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com
References: <1710960665-1391654-1-git-send-email-radhey.shyam.pandey@amd.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1710960665-1391654-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/24 03:51, Radhey Shyam Pandey wrote:
> In the ahci_ceva_probe() error path instead of returning -EINVAL for all
> of_property_read_u8_array() failure types return the actual error code.
> It removes the redundant -EINVAL assignment at multiple places and
> improves the error handling path.
> 
> Reported-by: Markus Elfring <Markus.Elfring@web.de>
> Closes: https://lore.kernel.org/all/9427c0fd-f48a-4104-ac7e-2929be3562af@web.de/
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>  drivers/ata/ahci_ceva.c | 48 ++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
> index 11a2c199a7c2..b54ee80c068f 100644
> --- a/drivers/ata/ahci_ceva.c
> +++ b/drivers/ata/ahci_ceva.c
> @@ -274,62 +274,62 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
>  
>  	/* Read OOB timing value for COMINIT from device-tree */
> -	if (of_property_read_u8_array(np, "ceva,p0-cominit-params",
> -					(u8 *)&cevapriv->pp2c[0], 4) < 0) {
> +	rc = of_property_read_u8_array(np, "ceva,p0-cominit-params",
> +				       (u8 *)&cevapriv->pp2c[0], 4);
> +	if (rc < 0) {
>  		dev_warn(dev, "ceva,p0-cominit-params property not defined\n");
> -		rc = -EINVAL;
>  		goto disable_resources;
>  	}
>  
> -	if (of_property_read_u8_array(np, "ceva,p1-cominit-params",
> -					(u8 *)&cevapriv->pp2c[1], 4) < 0) {
> +	rc = of_property_read_u8_array(np, "ceva,p1-cominit-params",
> +				       (u8 *)&cevapriv->pp2c[1], 4);
> +	if (rc < 0) {

This can be more simply "if (rc)"

>  		dev_warn(dev, "ceva,p1-cominit-params property not defined\n");
> -		rc = -EINVAL;

Here, it may be better to do:

		rc = dev_err_probe(dev, rc, "...");

and remove the dev_warn, as that really should be a dev_err() anyway.
Same pattern for all the other property reads below.

>  		goto disable_resources;
>  	}
>  
>  	/* Read OOB timing value for COMWAKE from device-tree*/
> -	if (of_property_read_u8_array(np, "ceva,p0-comwake-params",
> -					(u8 *)&cevapriv->pp3c[0], 4) < 0) {
> +	rc = of_property_read_u8_array(np, "ceva,p0-comwake-params",
> +				       (u8 *)&cevapriv->pp3c[0], 4);
> +	if (rc < 0) {
>  		dev_warn(dev, "ceva,p0-comwake-params property not defined\n");
> -		rc = -EINVAL;
>  		goto disable_resources;
>  	}
>  
> -	if (of_property_read_u8_array(np, "ceva,p1-comwake-params",
> -					(u8 *)&cevapriv->pp3c[1], 4) < 0) {
> +	rc = of_property_read_u8_array(np, "ceva,p1-comwake-params",
> +				       (u8 *)&cevapriv->pp3c[1], 4);
> +	if (rc < 0) {
>  		dev_warn(dev, "ceva,p1-comwake-params property not defined\n");
> -		rc = -EINVAL;
>  		goto disable_resources;
>  	}
>  
>  	/* Read phy BURST timing value from device-tree */
> -	if (of_property_read_u8_array(np, "ceva,p0-burst-params",
> -					(u8 *)&cevapriv->pp4c[0], 4) < 0) {
> +	rc = of_property_read_u8_array(np, "ceva,p0-burst-params",
> +				       (u8 *)&cevapriv->pp4c[0], 4);
> +	if (rc < 0) {
>  		dev_warn(dev, "ceva,p0-burst-params property not defined\n");
> -		rc = -EINVAL;
>  		goto disable_resources;
>  	}
>  
> -	if (of_property_read_u8_array(np, "ceva,p1-burst-params",
> -					(u8 *)&cevapriv->pp4c[1], 4) < 0) {
> +	rc = of_property_read_u8_array(np, "ceva,p1-burst-params",
> +				       (u8 *)&cevapriv->pp4c[1], 4);
> +	if (rc < 0) {
>  		dev_warn(dev, "ceva,p1-burst-params property not defined\n");
> -		rc = -EINVAL;
>  		goto disable_resources;
>  	}
>  
>  	/* Read phy RETRY interval timing value from device-tree */
> -	if (of_property_read_u16_array(np, "ceva,p0-retry-params",
> -					(u16 *)&cevapriv->pp5c[0], 2) < 0) {
> +	rc = of_property_read_u16_array(np, "ceva,p0-retry-params",
> +					(u16 *)&cevapriv->pp5c[0], 2);
> +	if (rc < 0) {
>  		dev_warn(dev, "ceva,p0-retry-params property not defined\n");
> -		rc = -EINVAL;
>  		goto disable_resources;
>  	}
>  
> -	if (of_property_read_u16_array(np, "ceva,p1-retry-params",
> -					(u16 *)&cevapriv->pp5c[1], 2) < 0) {
> +	rc = of_property_read_u16_array(np, "ceva,p1-retry-params",
> +					(u16 *)&cevapriv->pp5c[1], 2);
> +	if (rc < 0) {
>  		dev_warn(dev, "ceva,p1-retry-params property not defined\n");
> -		rc = -EINVAL;
>  		goto disable_resources;
>  	}
>  

-- 
Damien Le Moal
Western Digital Research


