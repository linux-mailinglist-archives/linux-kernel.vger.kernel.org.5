Return-Path: <linux-kernel+bounces-133371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D5B89A2F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162A4B21B30
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0EE171677;
	Fri,  5 Apr 2024 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDJcu+WA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1456116F8EF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336199; cv=none; b=qV9aXUFQUa7h5eqBtFCj8+4TwHIrWXNQwuM28M4hWkO5JXAed8lcb3P9qOdn8d8nLFFkfP/KxfFzqGEXYyk1g4DgO3L2og4pkJ8B8VKnCSYl6ZWekVsGcA7WylzgT5KTjnH+sYOA7PyNrJHcQBiQjjnSnafQqvCQlNdu30vorSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336199; c=relaxed/simple;
	bh=Hm4a0vwcuAQavPCbZcpiJ3TprdlvjCYP1GTkAfXbqjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1LXROM9E299w08sPdbvPM62lAuZOrsYCatgLHbT2rSh9y6mUh6QP5ZzxB4dbM2FRXgTMUfSUypFn7swBLhbKupoktPXYUF9F8tdu9l3I0a1valBz+JvzbOPLZWM9Z98TI0rn0AYkvz7gBnHMWYBYQZvaGG42HEKyFSAF4rRBRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDJcu+WA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2717C433C7;
	Fri,  5 Apr 2024 16:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712336198;
	bh=Hm4a0vwcuAQavPCbZcpiJ3TprdlvjCYP1GTkAfXbqjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDJcu+WAGnxu44A42BGkD+5NN7zbVo0oioF5DUJwstfwVAWjqmP7Ww/gmzc2e8hL+
	 XBeSqXYUdjkBZkY8WF8owO6Wg/vVckmyAmGYNc4/F3gQYoaVb5hmEHRN8DTOt+IR5U
	 a/mrVFR+TLCnQyVAJfBG0O0jmoE7TYWJZz3qMTPuWi9NfNbQSKo7COAwDT7O1yRpBy
	 PzfwCmAknHeWGTgsGKvqt1hxE/FJr7dCbkp3eWjYs/iZXLcmdciHxAL4FB2FOr34Z7
	 xSOY3gZ1F6cIKF1fP6uGVr0gpYstz0fBG8XYrfRzVjug3ZpWgFMDlxn/olqu9GIcbt
	 1n0RIyxHdZayQ==
Date: Fri, 5 Apr 2024 22:26:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] net: phy: core: make phy_class constant
Message-ID: <ZhAtQngu2uChbCCt@matsya>
References: <20240305-class_cleanup-phy-v1-1-106013a644dc@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-class_cleanup-phy-v1-1-106013a644dc@marliere.net>

On 05-03-24, 15:18, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the phy_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.

why is this tagged net: ...??
This has nothing to do with networking!

> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/phy/phy-core.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 7f9b4de772ee..5776d44fd32f 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -20,7 +20,12 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  
> -static struct class *phy_class;
> +static void phy_release(struct device *dev);
> +static const struct class phy_class = {
> +	.name = "phy",
> +	.dev_release = phy_release,
> +};
> +
>  static struct dentry *phy_debugfs_root;
>  static DEFINE_MUTEX(phy_provider_mutex);
>  static LIST_HEAD(phy_provider_list);
> @@ -706,7 +711,7 @@ struct phy *of_phy_simple_xlate(struct device *dev,
>  	struct phy *phy;
>  	struct class_dev_iter iter;
>  
> -	class_dev_iter_init(&iter, phy_class, NULL, NULL);
> +	class_dev_iter_init(&iter, &phy_class, NULL, NULL);
>  	while ((dev = class_dev_iter_next(&iter))) {
>  		phy = to_phy(dev);
>  		if (args->np != phy->dev.of_node)
> @@ -969,7 +974,7 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
>  	device_initialize(&phy->dev);
>  	mutex_init(&phy->mutex);
>  
> -	phy->dev.class = phy_class;
> +	phy->dev.class = &phy_class;
>  	phy->dev.parent = dev;
>  	phy->dev.of_node = node ?: dev->of_node;
>  	phy->id = id;
> @@ -1238,14 +1243,13 @@ static void phy_release(struct device *dev)
>  
>  static int __init phy_core_init(void)
>  {
> -	phy_class = class_create("phy");
> -	if (IS_ERR(phy_class)) {
> -		pr_err("failed to create phy class --> %ld\n",
> -			PTR_ERR(phy_class));
> -		return PTR_ERR(phy_class);
> -	}
> +	int err;
>  
> -	phy_class->dev_release = phy_release;
> +	err = class_register(&phy_class);
> +	if (err) {
> +		pr_err("failed to register phy class");
> +		return err;
> +	}
>  
>  	phy_debugfs_root = debugfs_create_dir("phy", NULL);
>  
> @@ -1256,6 +1260,6 @@ device_initcall(phy_core_init);
>  static void __exit phy_core_exit(void)
>  {
>  	debugfs_remove_recursive(phy_debugfs_root);
> -	class_destroy(phy_class);
> +	class_unregister(&phy_class);
>  }
>  module_exit(phy_core_exit);
> 
> ---
> base-commit: 00ca8a15dafa990d391abc37f2b8256ddf909b35
> change-id: 20240305-class_cleanup-phy-668a148b2acd
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>

-- 
~Vinod

