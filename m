Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0567D7E0FFB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 15:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjKDO4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 10:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjKDO4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 10:56:52 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A91B2;
        Sat,  4 Nov 2023 07:56:50 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a8ada42c2aso34972577b3.3;
        Sat, 04 Nov 2023 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699109809; x=1699714609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0hrUGgZzYgQp76NmKrhuU8kV8DbyX9ea8P9JmtBgvE=;
        b=gR0SUYGHNJKH8QGgB7Bh30cdcWECcLqNKByT3I382L6sh0p8kSFZiijZ2vY4elLEZ1
         FIaOhVyHqSqNeAHA6ZNn5yU2pAgDfJJuJLbrZj4Rz/GmJ14bt50aWXjLHTv7OlFq7H/2
         e1P800WJTzh4NzGEusaH7WC6U/pXT/8+GHJQ27DPHehOc1dEuFPDQpXeckl/fV/qCvLh
         ybxvCKB3Y4NU2CdnAVrGPF+eW1qLfIXaDKNw400KV2CaRzViu3cRu/vbgsLIMCBll1cd
         C9rn4yTkSrO/uDfMbhYdgWaxh8yRouttlD+gU/ARKlNI/E7Z7kr2wL4cra+g+L6VLaSh
         +RdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699109809; x=1699714609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0hrUGgZzYgQp76NmKrhuU8kV8DbyX9ea8P9JmtBgvE=;
        b=QjiQEBhlWerkdLUVX2VRI2rsv0sKBWQMOWXu6RFavVM+Sz3Yx7yFvEpl8z3cleXM4S
         nC2ij7KH1zt0paWE06vImuaBgcpNS2yAqDZbDnZ/KMzFr37AHFU/B9Z+uvZNXBXaofMw
         hNN4XAqJRXLlnioo0BzjgTxeeBLjGk6DN2DG2DkF3IBFuQcoe6Y9JBYm6USewZqfnaMH
         hi8rjeusQICTXVtYxhS5mSkUq8E/YH/PPTTZV+DrZ5d6/2cmJkw6fhHuV6dNTl2cT+98
         X2irNYMGXGZMS8MgR0WBiehbXCpzlRGoltmqLP01KNMm+Kie4Jgj0uJSP6SpRjPo+Kad
         hnvg==
X-Gm-Message-State: AOJu0YxrO38m1kS9pX2KX0ERm+Z9uD1kCNYCt7aBhEKMEGB29qXvXURN
        mhYNtNMz4frdnxTUek6NY6U=
X-Google-Smtp-Source: AGHT+IG3DlQ2ys8YYCKek9u9alXx+xRcKJPuMFbnpSTCIHzhWHTU5a0l7hMtymZwgh2h7Lku0YeO8A==
X-Received: by 2002:a0d:d5cd:0:b0:5a7:c8d4:c254 with SMTP id x196-20020a0dd5cd000000b005a7c8d4c254mr5399245ywd.0.1699109809473;
        Sat, 04 Nov 2023 07:56:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ci7-20020a05690c0a8700b005a7b8fddfedsm2114839ywb.41.2023.11.04.07.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 07:56:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 4 Nov 2023 07:56:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] hwmon: (dell-smm) Add support for WMI SMM interface
Message-ID: <efb7e4b9-487e-41a4-883f-4bfd29712bb8@roeck-us.net>
References: <20231103185716.11007-1-W_Armin@gmx.de>
 <20231103185716.11007-8-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103185716.11007-8-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 07:57:14PM +0100, Armin Wolf wrote:
> Some Dell machines like the Dell Optiplex 7000 do not support
> the legacy SMM interface, but instead expect all SMM calls
> to be issued over a special WMI interface.
> Add support for this interface so users can control the fans
> on those machines.
> 
> Tested-by: <serverror@serverror.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
[ ... ]

> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index a78ddd83cda0..0b3e63c21d26 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -106,6 +106,7 @@ MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
>  static const char * const allow_duplicates[] = {
>  	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
>  	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
> +	"F1DDEE52-063C-4784-A11E-8A06684B9B01", /* dell-smm-hwmon */

This would require an ack from its maintainer, which you did not Cc:.
That means I won't be able to apply this patch.

Guenter

>  	NULL
>  };
> 
> --
> 2.39.2
> 
