Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457037BC7FA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 15:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343917AbjJGNeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 09:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbjJGNea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 09:34:30 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE94AB;
        Sat,  7 Oct 2023 06:34:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso2582264b3a.0;
        Sat, 07 Oct 2023 06:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696685669; x=1697290469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHz8h1IkNoJYOBkhdwj05oCOGyc21CHK7uqUSGGbcr8=;
        b=FpF6gF1OqdxTyB9acEEd5FfNS7IPVtSsSMNYSDPkW8qRHaFd5G0pQSH+yMr/Hu/GCE
         dI8v995ptr7wYcbcm3G8BHQU2tS7pnoBAucjqu8Q+InRtNblv6cQuTiV8nYcjAItIq0l
         YnfQszUKQtQl6CrDLkfqt/4r/60seIfZdiT9ab1j48I8+tNX4qq5y7kqRtdmfy//qOjL
         7a6fZ0rLCu+CXJ10+6+MaJJOEidfwzdcdLNOET4k4iNfiyx37zbW09IZwQUf+DvlYGfL
         ccejaDqnKhJVbFCVUh9lLMnZTH2r8uIHQH5CZZ3bFhbCIU3VszGjVowDFeYCBOA6WkwN
         jOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696685669; x=1697290469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHz8h1IkNoJYOBkhdwj05oCOGyc21CHK7uqUSGGbcr8=;
        b=GhZD1lzIPzbkODVIL40njtTCZNCmKhqiLrlB5w3txWmIPNFJ4K7Kwck0dL3O64iMwJ
         IKKs/pJsrUvpcGY7hadsZ0sTVuUFk9Z4pkB2tc6+TBEVyogpYD67/bGHfW5rXvru8u1E
         yMrfooDFPPlARdoTBbFj9/rMr8oeJSSci1Mtgyyy+uVYlMAWtujnmPIPuKae4TzhpH+h
         xdlWYmakpxCaplkbHVyt/Ge6Qe0y85dbNhF+3XMIbrFcItQ6R1U49mVDxHjohfxurehh
         ZdncrXfOB7lAo3L+oQn6L58hFG7851OBy+K5869sFi00sa7iMlsNhA+qSKhQhxGUDaDz
         vYmw==
X-Gm-Message-State: AOJu0Yw2iin546um1849Uwx3MrDUOnrr76mmqA08yGs8ZaJUJ0NK1Ex/
        k1WolS0u/+/3/WM7Ou4C3t1EDBPMc0k=
X-Google-Smtp-Source: AGHT+IH2hrrjm9BHJCyl0gJBNau49wo82ltiFlh29BpgDdHVmfuRXsVQq9rCseUNiPwjS45CXPkA9A==
X-Received: by 2002:a05:6a20:12c9:b0:15c:b7ba:6a4d with SMTP id v9-20020a056a2012c900b0015cb7ba6a4dmr12915023pzg.50.1696685668880;
        Sat, 07 Oct 2023 06:34:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001c71ec1866fsm5878676plb.258.2023.10.07.06.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 06:34:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 7 Oct 2023 06:34:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xing Tong Wu <xingtong_wu@163.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        xingtong.wu@siemens.com, jan.kiszka@siemens.com,
        tobias.schaffner@siemens.com, cedric.hombourger@siemens.com,
        gerd.haeussler.ext@siemens.com
Subject: Re: [PATCH] watchdog: wdat_wdt: Add timeout value as a param in ping
 method
Message-ID: <3767ca06-2c66-4f7d-84d8-8e77b1ab87e1@roeck-us.net>
References: <20231007082125.4699-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007082125.4699-1-xingtong_wu@163.com>
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

On Sat, Oct 07, 2023 at 04:21:25PM +0800, Xing Tong Wu wrote:
> From: Xing Tong Wu <xingtong.wu@siemens.com>
> 
> According to the WDAT spec that states about WATCHDOG_ACTION_SET_COUNTDOWN_PERIOD:
> "This action is required if WATCHDOG_ACTION_RESET does not explicitly write a new
> countdown value to a register during a reset."
> And that implies, WATCHDOG_ACTION_RESET may write a countdown value, thus may come
> with a WATCHDOG_INSTRUCTION_WRITE_COUNTDOWN, thus need the timeout value as parameter
> or would otherwise write 0.
> The watchdog for SIONCT6126 need a entry WATCHDOG_INSTRUCTION_WRITE_COUNTDOWN for
> WATCHDOG_ACTION_RESET action, I send this patch to support it.
> 
> Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/wdat_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index 0ba99bed59fc..650fdc7996e1 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -269,7 +269,7 @@ static int wdat_wdt_stop(struct watchdog_device *wdd)
>  
>  static int wdat_wdt_ping(struct watchdog_device *wdd)
>  {
> -	return wdat_wdt_run_action(to_wdat_wdt(wdd), ACPI_WDAT_RESET, 0, NULL);
> +	return wdat_wdt_run_action(to_wdat_wdt(wdd), ACPI_WDAT_RESET, wdd->timeout, NULL);
>  }
>  
>  static int wdat_wdt_set_timeout(struct watchdog_device *wdd,
> -- 
> 2.25.1
> 
