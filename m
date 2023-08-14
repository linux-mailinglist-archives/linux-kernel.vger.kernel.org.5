Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1390377B539
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjHNJOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjHNJNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2F6AD;
        Mon, 14 Aug 2023 02:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41326648E3;
        Mon, 14 Aug 2023 09:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF27FC433C7;
        Mon, 14 Aug 2023 09:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692004415;
        bh=KEl0WjzhsYH00h3btT+tK17v6e+veb0lNNV8BHlMGfo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Ao5OxByRCAkz/IF507lGgLQuDHYgQvIo0C/4fb/pnw3oDPpDSojqAdTwdmns/eoyt
         d5uescLUcYBKvgeEOTFjFu/R2PTvGXS32cisA7uXb9RTrCakfXJnEIVUHb+nEKOeup
         uwioltWhBflBbGjhfJJZiUJ99dYKvYVjhe09X9gmqOaHjAT2zfH4Tbb9aGV/WA7FKz
         N8lz8AFV8KpXrQju7x+HSUerpvbjJIu+hmPtYxaveUEINspMf0SeCOfQIuEv5TCGI4
         xGcYtc3MpwGc01Mtx82hLD/aT7kMzBqdsbpvpLEEBlhAGVVO2oFWU1THUxOJW0BXGG
         eUKKJCKRdK0wQ==
Date:   Mon, 14 Aug 2023 11:13:31 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
cc:     Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sensor-hub: Allow multi-function sensor devices
In-Reply-To: <20230528092427.42332-1-daniel.thompson@linaro.org>
Message-ID: <nycvar.YFH.7.76.2308141113200.14207@cbobk.fhfr.pm>
References: <20230528092427.42332-1-daniel.thompson@linaro.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2023, Daniel Thompson wrote:

> The Lenovo Yoga C630 has a combined keyboard and accelerometer that
> interfaces via i2c-hid. Currently this laptop either has a working
> keyboard (if CONFIG_HID_SENSOR_HUB is disabled) or a working accelerometer.
> only works on kernels. Put another way, most distro kernels enable
> CONFIG_HID_SENSOR_HUB and therefore cannot work on this device since the
> keyboard doesn't work!
> 
> Fix this by providing a richer connect mask during the probe. With this
> change both keyboard and screen orientation sensors work correctly.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

Applied. Sorry for the delay,

-- 
Jiri Kosina
SUSE Labs

