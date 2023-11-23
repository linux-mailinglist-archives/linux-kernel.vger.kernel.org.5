Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6356B7F5D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjKWK4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjKWK4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:56:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E6319D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:56:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F109C433C7;
        Thu, 23 Nov 2023 10:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700736984;
        bh=gt9z2fXP8rR18XrcKMZMdsGzjLqvt8M1v9NHsKRxsQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kdqybyTqD4Y4FUSQcMl/1rVo3cS1vANF+XUMlp6dCnJfWm4swPou6liKrJLJGuGTF
         9OVNuoYabjtga9oPk8Cq2F+gKrZfqqspT3A6b57VIdgHbb4d08Vtwziw97SuKCyL+7
         nKL3bMMzGirj1z287ajtWdQKQACthghTpoCdfZKUhH0iV26oXz71eQhLfnm3uMO3Hf
         4kUWMXgbyO4F/RnL1BdYGv8uFXdQQpbZ7brh3Uxe8aXLIgX59W50HggzVfta0ED0VQ
         WRIn3UDWShg4wBMiphUFfizpCK8LMFi9YEjdfyO++z9IW0PYbI6NU55jfGZw7zaZ7d
         wKcdJYp8r+loA==
Date:   Thu, 23 Nov 2023 10:56:20 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: Expand led_colors[] array
Message-ID: <20231123105620.GG1184245@google.com>
References: <20231030054757.3476-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231030054757.3476-1-jszhang@kernel.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023, Jisheng Zhang wrote:

> commit 472d7b9e8141 ("dt-bindings: leds: Expand LED_COLOR_ID
> definitions") expands LED_COLOR_ID definitions for dt-binding. However,
> it doesn't expand the led_colors[] array in leds core, so if any of
> the newly expaned LED_COLOR_ID definitions is used, the sysfs will
> emit null in the led's name color part. Let's expand the led_colors[]
> array too.
> 
> Before the commit:
> /sys/class/leds # ls
> (null):indicator-0
> 
> After the commit:
> /sys/class/leds # ls
> orange:indicator-0
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/leds/led-core.c | 5 +++++
>  1 file changed, 5 insertions(+)

This already exists as:

  a067943129b4e leds: core: Add more colors from DT bindings to led_colors

-- 
Lee Jones [李琼斯]
