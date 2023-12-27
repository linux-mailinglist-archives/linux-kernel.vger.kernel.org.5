Return-Path: <linux-kernel+bounces-12249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 157D381F1F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D70B2277E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B84481B1;
	Wed, 27 Dec 2023 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eggVdzBz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923F1481A5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703709986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETSoQRxfgvbQsUGVfMARPpHrfpkDsi6rR1IIAc9SXNw=;
	b=eggVdzBz8duLUZds+RAkxIzWzEHU2P1626IROI5McHc4gMbHWIpI0pSl5tP7PHX/l5G+Mz
	Y1h5wH55yVIJA4M8s2laHPhh8O/CTumQYkzXAkxVHOr4Sa+Q/y6LhIMbFWIcquOqsuamqm
	Xs2J7w5ZT9qCvYD5ZvUM2qDA0whHa+k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-ML2QJNDjNx24pHzzbAMkmw-1; Wed, 27 Dec 2023 15:46:25 -0500
X-MC-Unique: ML2QJNDjNx24pHzzbAMkmw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d17446f11so63619825e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 12:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703709983; x=1704314783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETSoQRxfgvbQsUGVfMARPpHrfpkDsi6rR1IIAc9SXNw=;
        b=JJ3ArVGrkJVZeHJ+VsWhDBGU5qqOQoAIms6cGvWIwQ69ObL+ZOE+tLok+snfnLdICJ
         uZl9oNNj66vYW7asEiiLMBlN0IQhXaRTaK3+ClUXTeaYvjj2HyQZeONFwmWMAFoXKUL/
         /0rAWfiHYn5NdNUDU+9HkHuM34btP6hG0axf0Hl3Pt/EbulDsgHzGDyJyCPN9yjO69D2
         4r0VmdUgvIIuuGWwRTwYwV9sVLgZTGlmtXWYdfgLd12HK/cU1a83G+0x7mrHlqNmpWUa
         qR4lR3W5I+zWWdZVjE2Ord+s3dFHrQWMpajXehFq/zqiRChTnXlb1f1uF7TrH4iKU24x
         s6kQ==
X-Gm-Message-State: AOJu0Yxkf2YkIbaQ+coo09pIM8bE9BHKEA+yC+OEsjfNAQgSQarup6nH
	5T/eF5sAujMCH7AwCgzX7ql8gTQM9EDGK9qleRZFMdbj8Rij/4jTwdoYeCKokroEnNM6XPsu6mN
	CdZKKrjI8EjlPMHufyFfuV0rtavXmZ3gE
X-Received: by 2002:a05:600c:3d8a:b0:40d:54a0:29ce with SMTP id bi10-20020a05600c3d8a00b0040d54a029cemr2947550wmb.133.1703709982997;
        Wed, 27 Dec 2023 12:46:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOg5pnHMb6g7uRWA+2wauaFdkDulAIcmWbfUnDij749D0a6xHeNCmxQJQ6CFmWnRMRA0neGQ==
X-Received: by 2002:a05:600c:3d8a:b0:40d:54a0:29ce with SMTP id bi10-20020a05600c3d8a00b0040d54a029cemr2947547wmb.133.1703709982647;
        Wed, 27 Dec 2023 12:46:22 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b0040d5335079dsm14836616wmb.47.2023.12.27.12.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 12:46:21 -0800 (PST)
Date: Wed, 27 Dec 2023 15:46:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Gabriel Somlo <somlo@cmu.edu>, kernel@pengutronix.de,
	qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] firmware: qemu_fw_cfg: Convert to platform remove
 callback returning void
Message-ID: <20231227154549-mutt-send-email-mst@kernel.org>
References: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
 <8d7d86a24ea36985845c17b6da0933fedbf99ad8.1703693980.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d7d86a24ea36985845c17b6da0933fedbf99ad8.1703693980.git.u.kleine-koenig@pengutronix.de>

On Wed, Dec 27, 2023 at 05:26:30PM +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I don't mind.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/firmware/qemu_fw_cfg.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 1448f61173b3..03da9a4354f8 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -731,7 +731,7 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> -static int fw_cfg_sysfs_remove(struct platform_device *pdev)
> +static void fw_cfg_sysfs_remove(struct platform_device *pdev)
>  {
>  	pr_debug("fw_cfg: unloading.\n");
>  	fw_cfg_sysfs_cache_cleanup();
> @@ -739,7 +739,6 @@ static int fw_cfg_sysfs_remove(struct platform_device *pdev)
>  	fw_cfg_io_cleanup();
>  	fw_cfg_kset_unregister_recursive(fw_cfg_fname_kset);
>  	fw_cfg_kobj_cleanup(fw_cfg_sel_ko);
> -	return 0;
>  }
>  
>  static const struct of_device_id fw_cfg_sysfs_mmio_match[] = {
> @@ -758,7 +757,7 @@ MODULE_DEVICE_TABLE(acpi, fw_cfg_sysfs_acpi_match);
>  
>  static struct platform_driver fw_cfg_sysfs_driver = {
>  	.probe = fw_cfg_sysfs_probe,
> -	.remove = fw_cfg_sysfs_remove,
> +	.remove_new = fw_cfg_sysfs_remove,
>  	.driver = {
>  		.name = "fw_cfg",
>  		.of_match_table = fw_cfg_sysfs_mmio_match,
> -- 
> 2.43.0


