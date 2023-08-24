Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE8D786FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbjHXMx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241409AbjHXMxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:53:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74DF1BCD;
        Thu, 24 Aug 2023 05:53:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so8333394a12.0;
        Thu, 24 Aug 2023 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692881596; x=1693486396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a0dA5RBeqQfeg878QxKWVqpPWMWAEfr+8oDDT8byqQI=;
        b=RF9ui2WSjGQ6tmIHflrg+sz4KTW/5vgSY49OnreCxBuh47WCh2TVPJN2SWvHan34x6
         7dMRs5M2Zwk1kUYgd0htxegkIac+deoicYBbw/Ae6dinHTXopD3TeHHrzG1Ofd9SWh9m
         eJsySo1U5huPIruN039gIwHmO1969eNLjH0MgilRVMsTrKwA2zEgn1qOPixVDif3Uy7Q
         Ece8Ux/sbUttbFOlbjkczeYSZ/eI7wYNEjJxI+OZS8b9jZHN9j/ckQYKmU+MGUb7bVIq
         Uc3xpWczTuQQfIDWKXPjpclTztR0waA6/9RTQlQjCLt+oDEPRcBviiTdVdUSaCJGmFrX
         /PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692881596; x=1693486396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0dA5RBeqQfeg878QxKWVqpPWMWAEfr+8oDDT8byqQI=;
        b=IyU4MHuRRledJQpNtckcriXQdkwXtZZp4fcA1XVBxN27CPubtWL1+PEOLJ5cUGLWB/
         d6y69tVPnlGy+3rx3NlzGi8FzLjXJKBooFjHjeNxShekKvBYxoPyVG0tj1XWZJFnWYvM
         eO52euJtd2dfQ6oRc6L+laF6eEiZaNf3YtYPGYRX85CefOLe07afgTfaES8PbhNobuia
         Cb2KszCnDp2SzDEVkM/AbPnPPa+p4n8xyQKjaiUs/Frbf3aPbiRjoq98fPJ1tV2Wx/Zx
         RD9fItaSXC7kHHmxWq4Y42Dyd21N8Ok6KVgkeQ+McUemCNDTZrsWOoHLQ3ObhkI5zrpN
         j4ag==
X-Gm-Message-State: AOJu0Ywx7gm/SeavgUz3MUILuvtIN0jicgleDyctLoKfdOukbYGzeLMy
        moMh5RHlNX+hPLDyY1DXMjA=
X-Google-Smtp-Source: AGHT+IHv0X6KM0uXkODlETxpSedIundnk78PbDvW0KmpO6HfL0/XBwc9GqUwPP4VLqm9gGglEBBxLg==
X-Received: by 2002:aa7:dd47:0:b0:523:ad6e:7d00 with SMTP id o7-20020aa7dd47000000b00523ad6e7d00mr9713493edw.6.1692881595960;
        Thu, 24 Aug 2023 05:53:15 -0700 (PDT)
Received: from fedora ([85.93.123.158])
        by smtp.gmail.com with ESMTPSA id v14-20020a056402184e00b0052a3edff5c3sm1362554edy.87.2023.08.24.05.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 05:53:15 -0700 (PDT)
Date:   Thu, 24 Aug 2023 14:53:13 +0200
From:   Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, quic_jhugo@quicinc.com,
        nipun.gupta@amd.com, tzimmermann@suse.de, ogabbay@kernel.org,
        mathieu.poirier@linaro.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, linux@zary.sk, arnd@arndb.de,
        yangyicong@hisilicon.com, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com
Subject: Re: [PATCHv5 2/4] wiegand: add Wiegand bus driver
Message-ID: <ZOdSudrhg/9u3a9N@fedora>
References: <20230824111015.57765-1-m.zatovic1@gmail.com>
 <20230824111015.57765-3-m.zatovic1@gmail.com>
 <2023082420-quaking-barley-47b4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023082420-quaking-barley-47b4@gregkh>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:40:35PM +0200, Greg KH wrote:
> On Thu, Aug 24, 2023 at 01:10:13PM +0200, Martin Zaťovič wrote:
> > +static inline void wiegand_controller_put(void *ptr)
> 
> Why is this a void *?  It should be "struct wiegand_controller *"

It is a void* because it is being passed to devm_add_action_or_reset()
and this function only accepts a pointer to a function that accepts a void*
parameter. I am not sure if there is a way around it.

> 
> Please never use void * if at all possible.
> 
> > +static inline void wiegand_unregister_driver(struct wiegand_driver *wdrv)
> > +{
> > +	if (wdrv)
> 
> How could this ever be true?
> 
> > +		driver_unregister(&wdrv->driver);
> > +}
> > +
> > +static inline struct wiegand_driver *to_wiegand_driver(struct device_driver *drv)
> > +{
> > +	return drv ? container_of(drv, struct wiegand_driver, driver) : NULL;
> 
> How could drv be NULL?
> 
> And you should make this a const *, right?

Will fix the other issues. Thank you!

> 
> thanks,
> 
> greg k-h
