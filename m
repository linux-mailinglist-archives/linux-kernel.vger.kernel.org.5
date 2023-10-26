Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465107D7C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbjJZFZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjJZFZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:25:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DF210E;
        Wed, 25 Oct 2023 22:25:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEDFC433C7;
        Thu, 26 Oct 2023 05:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698297938;
        bh=HDy4nPUhUEA+7ki5tSQI5vsOl44X4cw66wI/6D9BcvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaKkc1JZ0ZYD96p07p/5Ssa+dZVPhvisnyV2/NE5tPFyc1uiC4vuDJIwsP+fQZGO5
         aaDk8bI56zM5vaPDRmWFcSAVEoUF967GD2CXTzXDi+S7eJ95m2kvuNoq4ehY7lm3Fi
         FtmL/qrEPHWiDp8UNYI/CbsVVw13ZWr12nf83lOs=
Date:   Thu, 26 Oct 2023 07:25:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Message-ID: <2023102624-moonshine-duller-3043@gregkh>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> Some users want to use the struct device pointer to see if the
> device is big endian in terms of Open Firmware specifications,
> i.e. if it has a "big-endian" property, or if the kernel was
> compiled for BE *and* the device has a "native-endian" property.
> 
> Provide inline helper for the users.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/property.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
