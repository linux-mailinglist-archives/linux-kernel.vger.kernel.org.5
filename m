Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2353D80147F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379616AbjLAUbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379640AbjLAUbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:31:13 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0D31712
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:31:16 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7b3a8366e13so80522439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 12:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701462675; x=1702067475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+EUuqZuvrB4W59cRhl0cknB02foDINxSF3GIXDLo+U=;
        b=GS7SyIQt4TbMYhRb0L8VzN5lBXG8UAwXGFWEQraQRAVBfSKe+KRLp5NcHHXdkDaZBX
         Rsf877zuMjw3eaP036cRzS9V1k56TiWS5G3skOjL/BsPBlOeK8a6ZHn55VmBpTfUhPLy
         ZQV+EGWW4taxNwGfTWPJN0aq/k8F2tIYQC0SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701462675; x=1702067475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+EUuqZuvrB4W59cRhl0cknB02foDINxSF3GIXDLo+U=;
        b=YOiJpwV9IEg7vscpGlEgLaP940ckMjl6SVizr5CRwIwaxNVku7A5HQTADMHkX+4zm4
         lfIiDEOxvOeDUXYr+jLxt4OqRlchvDwTExiOgp5K2jVQYNXbwEZp7kI+Z0ddBgnJSVgK
         MYmccRNry8jmKvM4s6C0tTCWd6RJHSjv90Us4Q1R7HezEursE3O6RpygUC+ap8piZX02
         vBDtKSwCOgmRCy/ZFr9J2jIzy1W35O5mPXkOMb7nq1j3a2MLQh+rNLRjBtwgrbnnsGPD
         fYK8FK5EKw6pwpk8exJI97tbyEZ5uH9ftmUioZ8D2RmVIiBzEacgS1y+MwrG4GZ3UcDy
         9D1A==
X-Gm-Message-State: AOJu0YzLXzJ9rVKskrPN0a0+btKxmt/mWRoZx3XOqW+QvsTgOirMD+lJ
        C5xrfMV3sLKl+JmRPpeyiZ6fUXBvw5KfwVHoRtU=
X-Google-Smtp-Source: AGHT+IEz0TtG8++a6j8TNO+x64tCKqqrWpTZU+KMFbvdVOawUs5BYTTq0W7rjH14ItqcqrDHOzHHtQ==
X-Received: by 2002:a05:6602:82:b0:7b3:ef90:a56f with SMTP id h2-20020a056602008200b007b3ef90a56fmr127647iob.4.1701462675503;
        Fri, 01 Dec 2023 12:31:15 -0800 (PST)
Received: from localhost (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with UTF8SMTPSA id s1-20020a02ad01000000b00466844b037asm1040222jan.100.2023.12.01.12.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 12:31:15 -0800 (PST)
Date:   Fri, 1 Dec 2023 20:31:14 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Anand Moon <linux.amoon@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Icenowy Zheng <uwu@icenowy.me>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RESEND PATCH v2 3/3] usb: misc: onboard_usb_hub: Add support
 for Cypress CY7C6563x
Message-ID: <ZWpCkolQOWOwKedB@google.com>
References: <20231127112234.109073-1-frieder@fris.de>
 <20231127112234.109073-3-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127112234.109073-3-frieder@fris.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 12:22:26PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The Cypress CY7C6563x is a 2/4-port USB 2.0 hub. Add support for
> this hub in the driver in order to bring up reset, supply or clock
> dependencies.
> 
> There is no reset pulse width given in the datasheet so we expect
> a minimal value of 1us to be enough. This hasn't been tested though
> due to lack of hardware which has the reset connected to a GPIO.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Acked-by: Matthias Kaehlcke <mka@chromium.org>
