Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A747DF73D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377057AbjKBP7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347663AbjKBP7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:59:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2D4187;
        Thu,  2 Nov 2023 08:58:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319BCC433C7;
        Thu,  2 Nov 2023 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698940737;
        bh=TZxJFL5OibED8+/9pa412vgNlmClfWKXxC9WGoztNWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=09E3HOS+W4nL+5nkvv9jyfGBRlFy+24B88zNuHEqR0IJZpeYbhhwHhLi8PkyEQuhp
         JuEMlTj2za4RQvRx13msamnOU497gjP3BWlyQ9NENFROLoQSNH2yHvKS48al+oNKQA
         xfko74CFww1olV7l7vIBj/k8lpJRKHqlxm51juQM=
Date:   Thu, 2 Nov 2023 16:58:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Message-ID: <2023110235-viewless-postage-9832@gregkh>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh>
 <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
 <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 05:33:40PM +0200, Andy Shevchenko wrote:
> On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> > > > Some users want to use the struct device pointer to see if the
> > > > device is big endian in terms of Open Firmware specifications,
> > > > i.e. if it has a "big-endian" property, or if the kernel was
> > > > compiled for BE *and* the device has a "native-endian" property.
> > > > 
> > > > Provide inline helper for the users.
> > > 
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Thank you, Greg.
> > 
> > Bart, would it be still possible to take this into next?
> > I would like to have at least this patch applied (with the first user)
> > to allow conversion of others (I have some more users of new API).
> 
> Okay, seems we missed v6.7 with this, can you then prepare an immutable
> branch / tag with this, so other maintainers can pull in case it's needed?
> (I have something against tty already and perhaps something else, let's
>  see.)

After -rc1 is out, I'll look into it, can't do anything until then,
sorry...

greg k-h
