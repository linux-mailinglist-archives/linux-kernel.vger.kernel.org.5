Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4861A75DDBA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 19:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGVRQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 13:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGVRQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 13:16:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AB5E67;
        Sat, 22 Jul 2023 10:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2549860BA4;
        Sat, 22 Jul 2023 17:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1427CC433C7;
        Sat, 22 Jul 2023 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690046162;
        bh=UtehOe8WTVzu8GcIyD+eOJNbkMTE6KmMtq2wqtqtVng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qET9tvS3S2dwl9ETuKZlL040FF+aM/XHYro776mxCqW+nsMoM5ISL4u1reAkJ1860
         2laI4MwIHd3hbR+2wIdGvoplEHJFh5X5ByEsoL9sIU20IUi1HkJJWVanJynn9jZY5x
         a7OFSXvhXXdqfRT2ubOBafRAYaV9cxGPJDg55aBLxwFKyUb7U0WetKsFNbxBMzTg+v
         706tAy0HE8W/78BInYFumAOYSWsEc81QcdUzB3yxqS7xEzA+tkqnAivkAIWlx/8LQ3
         Cd3BahUskSzhPhwQ5lpog/GLCUaVqN9wTYuDFzvYUfR8fleIXv/n4M85HFoEpMk5rA
         10l8qAod0WTYQ==
Date:   Sat, 22 Jul 2023 18:15:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     George Stark <gnstark@sberdevices.ru>, lars@metafoo.de,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, kernel@sberdevices.ru
Subject: Re: [PATCH v2 2/2] iio: adc: meson: improve error logging at probe
 stage
Message-ID: <20230722181559.02c8362c@jic23-huawei>
In-Reply-To: <ZLphZzO20QW+t1m/@smile.fi.intel.com>
References: <20230721102413.255726-1-gnstark@sberdevices.ru>
        <20230721102413.255726-3-gnstark@sberdevices.ru>
        <ZLphZzO20QW+t1m/@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 13:43:51 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Jul 21, 2023 at 01:23:09PM +0300, George Stark wrote:
> > Add log messages for errors that may occur at probe stage  
> 
> the probe

British English - excellent ! :) (I argue this one far too often in
specification committees :)


> 
> stage.
> 

I can tidy this up, but the patch will be a while anyway given the fix
needs to work it's way into the upstream for my togreg branch (and I need
to have send a pull request for togreg as well).

Jonathan

