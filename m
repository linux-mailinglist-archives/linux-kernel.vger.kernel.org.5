Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396EF7D9DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345512AbjJ0QEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjJ0QEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:04:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8AFE3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:04:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c5cd27b1acso20148625ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698422659; x=1699027459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxlKg2ZQ3RoZNDmMa69SR5WTeNAq3sPQXyEwWMiM4L0=;
        b=gltRgHuxY5o+P9g8ANEyv7rF4oMAu8FIHcpnYD/5q7/eNceH04wzejDhIno07mL6Pr
         3nVPbxE5240aE2cqX3uE/cAP70WQz1okaESaCJGc6A5Qs1jTJZxO9tvZ2pye9/3jEzrU
         Mtfav1SapZ2jtlMqsHlAkmQQASaxG+Gtl+hJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698422659; x=1699027459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxlKg2ZQ3RoZNDmMa69SR5WTeNAq3sPQXyEwWMiM4L0=;
        b=nM88DclHRAhxrIVihw6OSGKnCQ5t0bcyHcqIHq9gjNq1xz5chwxR9ES0ft9Lz27sIT
         RM12mtFKRGSHg2hKTbnmS4fS/sembpAaZUUYq6Fzy05LhuoWIQ/alAlJizia50vjTR2i
         sIa9EfK7GP4Gx07jsXz0Lguh16iMYhZukmGVXedaZL5se63iJKgd72h9lXHuCyFIbKfA
         b2JTx17pwtfz56ughJmB6Nc0DwCi7oLxTUYjeGQtSkYJHEQDj1Zuon588PX4/uxgBEA2
         LbbNwss+vxwVaqp85AvlJqpv4h3lL7M8M5vKVtBCUWtc0STA6iwwqTQm3RbGthIrPcZm
         3g0w==
X-Gm-Message-State: AOJu0YzwWaWAwG4Ekwvg7MDl20BwWu46H57fT0G01FCdJOlL58HvXqQc
        L25sfWvyyR4aMuX17/qXDdpLAA==
X-Google-Smtp-Source: AGHT+IFqUCba7aRtPkUHObTTG1ZiQw4DS+HcqIGAlBr7TQQWpqIfOztfjD7ggjl7XY1/UrvlIXSV6A==
X-Received: by 2002:a17:902:ce83:b0:1ca:77e9:3863 with SMTP id f3-20020a170902ce8300b001ca77e93863mr3771879plg.31.1698422652677;
        Fri, 27 Oct 2023 09:04:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z5-20020a170902ee0500b001b8b1f6619asm1750005plb.75.2023.10.27.09.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 09:04:12 -0700 (PDT)
Date:   Fri, 27 Oct 2023 09:04:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: hpsa: replace deprecated strncpy
Message-ID: <202310270901.B49F63CD5@keescook>
References: <20231026-strncpy-drivers-scsi-hpsa-c-v2-1-2fe2d05122fd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-strncpy-drivers-scsi-hpsa-c-v2-1-2fe2d05122fd@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 11:13:41PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Instances of strncpy()'ing a string into a buffer and manually
> NUL-terminating followed by sccanf with just "%d" as the format
> specifier can be accomplished by strscpy() and kstrtoint().
> 
> strscpy() guarantees NUL-termination on the destination buffer and
> kstrtoint is better way of getting strings turned into ints.
> 
> For the last two strncpy() use cases in init_driver_version(), we can
> actually drop this function entirely.
> 
> Firstly, we are kmalloc()'ing driver_version. Then, we are calling
> init_driver_version() which memset's it to 0 followed by a strncpy().
> The pattern is 1) allocating memory for a string, 2) setting all bytes
> to NUL, 3) copy bytes from another string + ensure NUL-padded.
> 
> For these, we can just stack allocate driver_version and
> old_driver_version. This simplifies the code greatly as we don't have
> any malloc/free or strncpy's.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - use stack for buffers (thanks Kees)
> - use kstrtoint (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20231026-strncpy-drivers-scsi-hpsa-c-v1-1-75519d7a191b@google.com
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/scsi/hpsa.c | 53 ++++++++++++++++++++---------------------------------
>  1 file changed, 20 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index af18d20f3079..4d42fbb071cf 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -452,18 +452,18 @@ static ssize_t host_store_hp_ssd_smart_path_status(struct device *dev,
>  					 struct device_attribute *attr,
>  					 const char *buf, size_t count)
>  {
> -	int status, len;
> +	int status;
>  	struct ctlr_info *h;
>  	struct Scsi_Host *shost = class_to_shost(dev);
>  	char tmpbuf[10];
>  
>  	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>  		return -EACCES;
> -	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
> -	strncpy(tmpbuf, buf, len);
> -	tmpbuf[len] = '\0';
> -	if (sscanf(tmpbuf, "%d", &status) != 1)
> +
> +	strscpy(tmpbuf, buf, sizeof(tmpbuf));
> +	if (kstrtoint(tmpbuf, 0, &status))

I actually meant:

	if (kstrtoint(buf, 0, &status))

I don't see any reason for "tmpbuf" at all.

> @@ -7234,25 +7234,15 @@ static int hpsa_controller_hard_reset(struct pci_dev *pdev,
>  	return 0;
>  }
>  
> -static void init_driver_version(char *driver_version, int len)
> -{
> -	memset(driver_version, 0, len);
> -	strncpy(driver_version, HPSA " " HPSA_DRIVER_VERSION, len - 1);
> -}
> -
>  static int write_driver_ver_to_cfgtable(struct CfgTable __iomem *cfgtable)
>  {
> -	char *driver_version;
>  	int i, size = sizeof(cfgtable->driver_version);
> +	char driver_version[sizeof(cfgtable->driver_version)] =
> +						HPSA " " HPSA_DRIVER_VERSION;
>  
> -	driver_version = kmalloc(size, GFP_KERNEL);
> -	if (!driver_version)
> -		return -ENOMEM;
> -
> -	init_driver_version(driver_version, size);
>  	for (i = 0; i < size; i++)
>  		writeb(driver_version[i], &cfgtable->driver_version[i]);
> -	kfree(driver_version);
> +
>  	return 0;
>  }
>  
> @@ -7268,21 +7258,18 @@ static void read_driver_ver_from_cfgtable(struct CfgTable __iomem *cfgtable,
>  static int controller_reset_failed(struct CfgTable __iomem *cfgtable)
>  {
>  
> -	char *driver_ver, *old_driver_ver;
> -	int rc, size = sizeof(cfgtable->driver_version);
> -
> -	old_driver_ver = kmalloc_array(2, size, GFP_KERNEL);
> -	if (!old_driver_ver)
> -		return -ENOMEM;
> -	driver_ver = old_driver_ver + size;
> +	char driver_ver[sizeof(cfgtable->driver_version)] = "";
> +	char old_driver_ver[sizeof(cfgtable->driver_version)] =
> +						HPSA " " HPSA_DRIVER_VERSION;
> +	int rc;
>  
>  	/* After a reset, the 32 bytes of "driver version" in the cfgtable
>  	 * should have been changed, otherwise we know the reset failed.
>  	 */
> -	init_driver_version(old_driver_ver, size);
>  	read_driver_ver_from_cfgtable(cfgtable, driver_ver);
> -	rc = !memcmp(driver_ver, old_driver_ver, size);
> -	kfree(old_driver_ver);
> +	rc = !memcmp(driver_ver, old_driver_ver,
> +		     sizeof(cfgtable->driver_version));
> +
>  	return rc;
>  }
>  /* This does a hard reset of the controller using PCI power management

These two look good now; thanks!

-Kees

-- 
Kees Cook
