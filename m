Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042697C4433
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjJJWfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjJJWfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:35:32 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C6498
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:35:30 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fe6da0049so256842339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696977329; x=1697582129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbnEdKq2z/F673J0PyLo1dcLzZBfT0ZL+5O9D0Q9H3k=;
        b=b5VghDhb2Ysz4Ub07PijViWG/KRXCZFORn0pshqvZqNxUZKfNK6QAx8789LgeNPJMZ
         OAON8/chzN7eWxghmbPNC6uyoD4C5YYX3wzgtqBzqUXkfqvdBg7GPHi+fljDRkWMx5w/
         x4S32AT4ySLuYKHGy0d7/fC5g/iWCsIO0N5CYYfcNUU2MbIYBik7m+cJIl8uh8T9SWe9
         CfQJIjTOIYII4mVu7db8q0goVVb+S9wlC1LfUEk5q7b7T+lbYXo96MfQcM/jmx8sC2+q
         CQagDUc7k05icWWrGt6wDWsneYg1O6MyGGAOiuS1aUmWtjSt8RqsdzNVFP/6NrBMdCte
         IJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977329; x=1697582129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbnEdKq2z/F673J0PyLo1dcLzZBfT0ZL+5O9D0Q9H3k=;
        b=uf7kFwK6Iu41AI1pX8hZuQPWQGlWtvlwBtn3l37SO7b5hPtj2+KjexTz0mAcPE6tIy
         Jo1s2EPxD2XXVNqPg1nEJcRLdqEPZDJobeszmQICudpfytF9VFlFxQ9Aj0/ZdiBo4aN2
         Exe5PeGLhV0Ju1kG1/JoaBD5U+OZxVXdagmfsUjV5OnyWLC7GNPi8CEn+qUeeXx2SGCa
         3ig+rZDx42oT9RRzwrZs2nDnhLxLZg+nuPbDDuLy86dvEFxBznocwAvTMqD0a91NxHli
         BZsdeZ+mLf7C2GmYMXQRvJ+1TLEDC5eIU0AIJpE+VVa5g95oO6gWSp0c0zpMeEK3/v1G
         kVdg==
X-Gm-Message-State: AOJu0Yzlnm1wueDsCBHLCPRVbkHitMpwcLU2CN/mJXhqjEWu42tW/LpV
        jHhKlx1s5zVC1S14qCOMsrOr5A==
X-Google-Smtp-Source: AGHT+IE79Ek/gb463rp8bLbwMC/z4YopcNOtHcxvez3Rikw2zfNOxy/a5n3J8for9IZJ2q5BpTQahQ==
X-Received: by 2002:a6b:6f09:0:b0:790:a073:f122 with SMTP id k9-20020a6b6f09000000b00790a073f122mr19043765ioc.2.1696977329595;
        Tue, 10 Oct 2023 15:35:29 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id q21-20020a02a315000000b0042b2df337ccsm2907113jai.76.2023.10.10.15.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:35:28 -0700 (PDT)
Date:   Tue, 10 Oct 2023 22:35:26 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] e100: replace deprecated strncpy with strscpy
Message-ID: <20231010223526.2qc4q64txfoi64lq@google.com>
References: <20231009-strncpy-drivers-net-ethernet-intel-e100-c-v1-1-ca0ff96868a3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-ethernet-intel-e100-c-v1-1-ca0ff96868a3@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 11:41:01PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> The "...-1" pattern makes it evident that netdev->name is expected to be
> NUL-terminated.
>
> Meanwhile, it seems NUL-padding is not required due to alloc_etherdev
> zero-allocating the buffer.
>
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
>
> This is in line with other uses of strscpy on netdev->name:
> $ rg "strscpy\(netdev\->name.*pci.*"
>
> drivers/net/ethernet/intel/e1000e/netdev.c
> 7455:   strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> 10839:  strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/intel/e100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> index d3fdc290937f..01f0f12035ca 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -2841,7 +2841,7 @@ static int e100_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	netdev->netdev_ops = &e100_netdev_ops;
>  	netdev->ethtool_ops = &e100_ethtool_ops;
>  	netdev->watchdog_timeo = E100_WATCHDOG_PERIOD;
> -	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
> +	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
>  	nic = netdev_priv(netdev);
>  	netif_napi_add_weight(netdev, &nic->napi, e100_poll, E100_NAPI_WEIGHT);
>
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231009-strncpy-drivers-net-ethernet-intel-e100-c-4547179d9f2c
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

Hi, this patch was bundled up with some others. It has a new home:

https://lore.kernel.org/all/20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com/
