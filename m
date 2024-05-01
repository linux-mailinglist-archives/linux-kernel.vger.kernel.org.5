Return-Path: <linux-kernel+bounces-164967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8218B8590
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA271F23424
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47C84D13B;
	Wed,  1 May 2024 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4ideLHM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE44B5AE;
	Wed,  1 May 2024 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714544843; cv=none; b=J9sHb67ZOSPwamM2cEk1lqGaKgybCUV/7r3cA1rS812GuAQ/lL/DqeFlfkGKrYl4CaUh5OkKq/9In9P/h0Octw+8aCeCZ5saAWxGY0wEZOQstweMVu+b8Vh+fbSMSdEifFUlP7pvJIkMyrMzldZVGc5jOS4/wgllbeFN8J6BdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714544843; c=relaxed/simple;
	bh=37X+IwcyQX/u8S3wrYqyvxciCf3LtStmlkt5TMXRXnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay/xKSEHtLqlQz/Yhasb3zPWm8wvhfPSk7XAoCtkz1HPsIjc3XEGhKu1Gw13IwK2FaL3/A3t59bEt/UP6xsbjTE1h7IsWnhg+TKWuq2/ZP1eNeuyRCY3M5MXOM+rxnywn1ux+ea4QJCwWIErJDdR1K4i9Xl8FTjtjqMpFcUP9n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4ideLHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484BBC113CC;
	Wed,  1 May 2024 06:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714544842;
	bh=37X+IwcyQX/u8S3wrYqyvxciCf3LtStmlkt5TMXRXnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4ideLHMNquVIYFopTxmXvD0XQNjYagqHqXTbY9V9vpkmdXM8r26MBHV9ckNoIRm5
	 CNxAxu0ro1vP8kbebW6MBeaTvrzzQJ1kYoUnOMjfrlQbyESdcaYyN/h6V6DbLYSMGW
	 YTuBJpoeU90f0EmMwnpwU39W7yHFXATsc2bQptUq7Oaub7qcgnfHlDT5tKxVA1dI8R
	 /9C3M45sqGvbIPeDHSzXg+UK39zl7vc992IfLqlIP3mZa8Xp+2WPIWJjV+bHNI04Ru
	 HSPik00dcKinfisM9SCoyOw+oNS8BYbRABpl8TsY80isdCMRN65oWPMct/+AQs4w6c
	 ImjXgqxPubeLA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s23R5-000000008DI-3tyr;
	Wed, 01 May 2024 08:27:24 +0200
Date: Wed, 1 May 2024 08:27:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Doug Anderson <dianders@chromium.org>,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Bluetooth: qca: add missing firmware sanity checks
Message-ID: <ZjHgy9m8Sh0t9S4y@hovoldconsulting.com>
References: <20240430170741.15742-1-johan+linaro@kernel.org>
 <20240430170741.15742-2-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430170741.15742-2-johan+linaro@kernel.org>

On Tue, Apr 30, 2024 at 07:07:39PM +0200, Johan Hovold wrote:
> Add the missing sanity checks when parsing the firmware files before
> downloading them to avoid accessing and corrupting memory beyond the
> vmalloced buffer.
> 
> Fixes: 83e81961ff7e ("Bluetooth: btqca: Introduce generic QCA ROME support")
> Cc: stable@vger.kernel.org	# 4.10
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)

>  static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
> @@ -532,7 +556,9 @@ static int qca_download_firmware(struct hci_dev *hdev,
>  	memcpy(data, fw->data, size);
>  	release_firmware(fw);
>  
> -	qca_tlv_check_data(hdev, config, data, soc_type);
> +	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
> +	if (ret)
> +		return ret;

Bah, I realised late last night that I had forgotten to fix this error
path before posting v2. This was supposed to say

	goto out;

to make sure the firmware buffer is released in case we ever encounter
malformed firmware.

I'll send a follow-up patch.

Johan

