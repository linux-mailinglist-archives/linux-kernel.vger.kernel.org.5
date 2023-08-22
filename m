Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD2C784380
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbjHVOKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjHVOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:10:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A942CEB;
        Tue, 22 Aug 2023 07:09:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a68d23f51so919076b3a.2;
        Tue, 22 Aug 2023 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692713315; x=1693318115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66PozHNDvh/miQcrv08kMaTHrwFW+whkzko67cfaVXM=;
        b=KXPacQPhSZfaP5VbfGz22Af3EDfuMvGZEcLcQPaAeF7msJjijYUDwzrQAUgFX2wyrc
         VY2aJSAuZaOjQmSNS7S3ntYcp0+GVWGgb1MCYEtwYR1luHkSGPTab+Extdp9pUSVMSt8
         WkxcuN+dEcPZgUv7Sx4zeJJWDG2X8ll+E1+V6U0Bj86aqxYHXY7hejesr7TuIQAup4MB
         Hn3pCoY7KnkngTlphODXlL1sytKm9qbiaWF6aHEHs9DGxMGDX71fMNnqx50qaQkA52KI
         6kbRWkGbLbwUc05g+zLsYtyW0pOmySscasvsr1cxkUz58pwpF6xl2GsX20irZ/ZTosCf
         ma4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692713315; x=1693318115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66PozHNDvh/miQcrv08kMaTHrwFW+whkzko67cfaVXM=;
        b=SeIqnoMHM++8o/Xl4Q1rgoF01hPrG5uirnhWOWa8OGxaTRCz5bGdPLL4jkmyT/R6ev
         yIGfvGaMijSPZyuEicjTAReEL/3vqODPu/Oo4NKbs6Hyf1TZawnGwvaBynQ2HG2VSfGn
         v3T/bItgQ4baed8PVhdzxmZkCVDk1w8DF22/Jr9cmafxronLFPHhpXv1JdEP5SFEc0XS
         TGQ7uMWi+Fbfg8c9dgXIoZvBv0n1GYxu+/OpV5PUfHcOUWC5Y2cdrlxcWIrKVU+DIWGn
         c7jDHt5XqyoKTmOoFicIMfnZF8xpRzf61MCvSoFXQu4COn6yUYqrfJnQ3sDPnAdg4oJE
         dSIg==
X-Gm-Message-State: AOJu0Yzo5G7aTzxcdyNzH0UBzv7X5RFLrNZBH9VXTKKX2odZXH0v3FrS
        LQU+EZcLkYz2XPJXSyq/UTQ=
X-Google-Smtp-Source: AGHT+IGwBcGEzMNvmZP3MWGhyYXJ9xMMvQjKJWpLgaZ8NJrUrfGxCaj416i4JqFWInh0XGeVtq4BSA==
X-Received: by 2002:a05:6a00:1994:b0:688:49e6:d113 with SMTP id d20-20020a056a00199400b0068849e6d113mr11963647pfl.34.1692713314838;
        Tue, 22 Aug 2023 07:08:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s5-20020aa78285000000b0067ab572c72fsm7744851pfm.84.2023.08.22.07.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:08:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 22 Aug 2023 07:08:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] watchdog: imx2_wdt: Improve dev_crit() message
Message-ID: <37f5e3d0-c841-4270-8424-7b4a8c16de7c@roeck-us.net>
References: <20230822135255.1013981-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822135255.1013981-1-festevam@gmail.com>
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

On Tue, Aug 22, 2023 at 10:52:55AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> After issuing a "poweroff" command the board goes through the
> expected power-off sequence and turns it off completely:
> 
> systemd-shutdown[1]: Powering off.
> imx2-wdt 30280000.watchdog: Device shutdown: Expect reboot!
> reboot: Power down
> 
> The "Expect reboot!" message is misleading because in the
> power-off case, no reboot is expected to happen at all.
> 
> Avoid the confusion by removing the "Expect reboot!" message.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Not sure if the message should be there in the first place.
Anyway,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/imx2_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 1a27665a2f53..42e8ffae18dd 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -374,7 +374,7 @@ static void imx2_wdt_shutdown(struct platform_device *pdev)
>  		 */
>  		imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
>  		imx2_wdt_ping(wdog);
> -		dev_crit(&pdev->dev, "Device shutdown: Expect reboot!\n");
> +		dev_crit(&pdev->dev, "Device shutdown.\n");
>  	}
>  }
>  
> -- 
> 2.34.1
> 
