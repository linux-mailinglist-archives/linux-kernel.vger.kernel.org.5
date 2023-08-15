Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5875B77D3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbjHOUCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbjHOUCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:02:20 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D831BF1;
        Tue, 15 Aug 2023 13:02:12 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34aa0845837so7834035ab.1;
        Tue, 15 Aug 2023 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692129731; x=1692734531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tT5nENGTmtsOYaR4AN3QL0P9N1DvYamQQ82TaK4qYbI=;
        b=SbsqkqKIDGgCa8iOgg9dZ0sLrGB/ekFHLh2DdUkobgkBz+efDovWBaO3EIwaLQuWfk
         sSnIckgSBuNgud2LSHQKFeP0lBt5V/QdD9+G2qqBGUu9kADcHAeUevKbab8+KoR7JO5v
         WSVcFft2NBCZJ9188STPSzXxEOP61FEuUGwotV20dJWsazOVJZkYQNSvkC6pyBANxEJh
         dOa44DZ9kYCCrZEQERWF3jrp9OuCo0ZIm/xkDbTsPB2iQKw6tuQOD6SF8/6GMXKwWqVP
         FZluJydRUrQ8BmZfQ8/tKmlbbkgCv+8+PbldjDsmPVbjT5RmHh6N6wOe/XSuk2CgYYRE
         HOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692129731; x=1692734531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tT5nENGTmtsOYaR4AN3QL0P9N1DvYamQQ82TaK4qYbI=;
        b=EelbEOmU7uqmDMpj7HNpA61radnoXk97ZzGf1AvR/88FGKYlraQ0gfI62zTrNNQsP/
         ePtJ2Yep9KS4oxNFYUIcWt5ZLlJq3VuNWW0BNp5DsVfJeEBsZA28bxyfyY2qR6TvWLgr
         oHI5AGBjELZ//9ta/7sSFB0OsRQ5BIrO75vtKU3EevVzseah74PJDTQme0k1dEZVw7z4
         0D63vAD3a+vTMzlMJlb6tYstgc59I+PrHhSXDR7+7qtm+XiKjS99OAjHCjQq4eRSmJlk
         6+tsr1B2nFTDth5GjwgI++sgycGuyinxHIQQA01yC+RESxy3OgRjp+hf2Kw7pg2W/j+M
         LSjQ==
X-Gm-Message-State: AOJu0YzLldKwdjyIu5Z20Euv5gGLIVpczui2S28VZzjAIb0+mk7jhUp2
        ifZAarN9OR8FbvnIAPWNV78=
X-Google-Smtp-Source: AGHT+IGS8MmNpGPFfriIYC8OKL4AZomFcn3qdOXgE/pPXsyeZLsfp82UV4wMFbJrnbxGdo6TX2X4nw==
X-Received: by 2002:a05:6e02:1b08:b0:347:70ae:542d with SMTP id i8-20020a056e021b0800b0034770ae542dmr19828995ilv.7.1692129731295;
        Tue, 15 Aug 2023 13:02:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id da25-20020a0566384a5900b004249d9e81besm3660836jab.131.2023.08.15.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:02:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 15 Aug 2023 13:02:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     RD Babiera <rdbabiera@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: typec: bus: verify partner exists in
 typec_altmode_attention
Message-ID: <794a4438-6414-4266-bb03-3b36614ba395@roeck-us.net>
References: <20230814180559.923475-1-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814180559.923475-1-rdbabiera@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 06:05:59PM +0000, RD Babiera wrote:
> Some usb hubs will negotiate DisplayPort Alt mode with the device
> but will then negotiate a data role swap after entering the alt
> mode. The data role swap causes the device to unregister all alt
> modes, however the usb hub will still send Attention messages
> even after failing to reregister the Alt Mode. type_altmode_attention
> currently does not verify whether or not a device's altmode partner
> exists, which results in a NULL pointer error when dereferencing
> the typec_altmode and typec_altmode_ops belonging to the altmode
> partner.
> 
> Verify the presence of a device's altmode partner before sending
> the Attention message to the Alt Mode driver.
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v1:
> * Only assigns pdev if altmode partner exists in typec_altmode_attention
> * Removed error return in typec_altmode_attention if Alt Mode does
>   not implement Attention messages.
> * Changed tcpm_log message to indicate that altmode partner does not exist,
>   as it only logs in that case.
> ---
> Changes since v2:
> * Changed tcpm_log message to accurately reflect error
> * Revised commit message
> ---
> Changes since v3:
> * Fixed nits
> ---
>  drivers/usb/typec/bus.c           | 12 ++++++++++--
>  drivers/usb/typec/tcpm/tcpm.c     |  3 ++-
>  include/linux/usb/typec_altmode.h |  2 +-
>  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> index fe5b9a2e61f5..e95ec7e382bb 100644
> --- a/drivers/usb/typec/bus.c
> +++ b/drivers/usb/typec/bus.c
> @@ -183,12 +183,20 @@ EXPORT_SYMBOL_GPL(typec_altmode_exit);
>   *
>   * Notifies the partner of @adev about Attention command.
>   */
> -void typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
> +int typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
>  {
> -	struct typec_altmode *pdev = &to_altmode(adev)->partner->adev;
> +	struct altmode *partner = to_altmode(adev)->partner;
> +	struct typec_altmode *pdev;
> +
> +	if (!partner)
> +		return -ENODEV;
> +
> +	pdev = &partner->adev;
>  
>  	if (pdev->ops && pdev->ops->attention)
>  		pdev->ops->attention(pdev, vdo);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(typec_altmode_attention);
>  
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5a7d8cc04628..77fe16190766 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1877,7 +1877,8 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  			}
>  			break;
>  		case ADEV_ATTENTION:
> -			typec_altmode_attention(adev, p[1]);
> +			if (typec_altmode_attention(adev, p[1]))
> +				tcpm_log(port, "typec_altmode_attention no port partner altmode");
>  			break;
>  		}
>  	}
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index 350d49012659..28aeef8f9e7b 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -67,7 +67,7 @@ struct typec_altmode_ops {
>  
>  int typec_altmode_enter(struct typec_altmode *altmode, u32 *vdo);
>  int typec_altmode_exit(struct typec_altmode *altmode);
> -void typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
> +int typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
>  int typec_altmode_vdm(struct typec_altmode *altmode,
>  		      const u32 header, const u32 *vdo, int count);
>  int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,
> 
> base-commit: f176638af476c6d46257cc3303f5c7cf47d5967d
> -- 
> 2.41.0.694.ge786442a9b-goog
> 
