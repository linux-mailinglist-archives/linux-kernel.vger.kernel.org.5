Return-Path: <linux-kernel+bounces-136701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3289D73C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AF71F240E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FCE839F1;
	Tue,  9 Apr 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzlC0fUL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0D26AEC;
	Tue,  9 Apr 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659647; cv=none; b=eQFk69o9uc+OodIoJnBe2iOaRPUbsYA94FXEpubh3SJo3E1n8B3uxxVT4f7J7a2v1OSQ3T9idGMPkeY/TEMM89GXcAjTL7YeLVzxC/lc3hsvw8RkxIsC8mQaHUr0VBHl55cHrgbYt2ZIcwjTiUeNh3+8uCO4+wSLpnsVcXuIiRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659647; c=relaxed/simple;
	bh=GQyRhDS+e7UvbivEeGp6IgSBe+4m1AsAUSrkuomhjRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtSYYnHJ0YMBPvWnUytjgLQdJsBvyr0jCVvi26WP4kbiKHJMATooDNBDgmunM6P+Mhmsu5L07324/BX1fxWcO3QsqSQ9QABvpQWHBcNgjOZPhKBY2IoysZppEabhqrVeU2T5PLyGGE+mTsZYHrxayF7VKFOjE8Tze712VOuV3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzlC0fUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838EBC433F1;
	Tue,  9 Apr 2024 10:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712659646;
	bh=GQyRhDS+e7UvbivEeGp6IgSBe+4m1AsAUSrkuomhjRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzlC0fUL7LqSHLOPipy7bACooruKGDL+skwtjj/L1kDV3ukMuEnwcg+VSkznIgB3D
	 hi5iK4ocGcWQ7jPXB987vLJv0Lx2G6PjF9FgTgYB45mSTIjTR8z96fZyGeYd5pua36
	 iH7LbtfzjDS/+hXpAM/2yEUnfLd2M8QS4rqmhO1QkNKnHIZcKpXPejNXfJTZdyuC1y
	 KRzQYY0dWS1Czutvs4Onvm44+x7c7FMPNtvNUhU32ulJZsRrqxeEwwxos7SuA+OlXO
	 YHt0bGH1TEf9cQf1Zg1E15lGUjGHKkUzc7zU/zaezgHPy4dfkEp1IyY2cZ9uPV7oSO
	 MFiiuTCZN9GzQ==
Date: Tue, 9 Apr 2024 18:47:23 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Pavan Holla <pholla@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v4 2/2] usb: typec: ucsi: Implement ChromeOS UCSI driver
Message-ID: <ZhUcu1k0Cum-IMVQ@google.com>
References: <20240409-public-ucsi-h-v4-0-e770735222a2@chromium.org>
 <20240409-public-ucsi-h-v4-2-e770735222a2@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409-public-ucsi-h-v4-2-e770735222a2@chromium.org>

On Tue, Apr 09, 2024 at 02:27:37AM +0000, Pavan Holla wrote:
> Implementation of a UCSI transport driver for ChromeOS.

The patch generally looks good to me just a few nits.

> This driver will be loaded if the ChromeOS EC implements a PPM.

Replied in v3, the patch (and the series) don't reflect the message.

> diff --git a/drivers/usb/typec/ucsi/cros_ec_ucsi.c b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> [...]
> +static void cros_ucsi_work(struct work_struct *work)
> +{
> +	struct cros_ucsi_data *udata = container_of(work, struct cros_ucsi_data, work);
> +	u32 cci;
> +	int ret;
> +
> +	ret = cros_ucsi_read(udata->ucsi, UCSI_CCI, &cci, sizeof(cci));
> +	if (ret)
> +		return;

`ret` can be dropped.

> +static const struct platform_device_id cros_ucsi_id[] = {
> +	{ DRV_NAME, 0},

To be neat, append an extra space after `0`.

