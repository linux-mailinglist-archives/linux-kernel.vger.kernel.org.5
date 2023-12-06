Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D9B8076D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378820AbjLFRo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjLFRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:44:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60196D46
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:45:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B16C433C7;
        Wed,  6 Dec 2023 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701884700;
        bh=c62MJPU3LWesp61kfHoQtJ5bG1ANKAKahi1+gxMsJV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r5aspjRw8Rlvjs6c8+jncK8NtSzup0/O7zTHTEAcEW7txJRfe7N3ZVtH25fAxZzbm
         MU/UMbiPazp94YUGyQ+aD7SEYumme4Mh2ugMWV35CBHSU3NX4Jk1IQbq+o/ehvH5AN
         t3BHTtnsgb6osvj/I4EaP9PYeCtEeBvuhStznsvgzRY1fKFzvq4TgZ/WQIDTtLmWyE
         fHPPz9HT7xX5tWRUC821Ea61pxviclEJ0fHva85aGhQQxwQ+kFQD2bfAAv3aUuvLyf
         Oc3ok0HxFAtY4zbEdCJcXbqFlpNNxv5nNrv/r3Rfeot82vkdZGAGR40jz6XPkWQy8e
         o+zUmTOI+lVsQ==
Date:   Wed, 6 Dec 2023 17:44:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v7 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series
Message-ID: <20231206174451.301b1cd2@jic23-huawei>
In-Reply-To: <20231204194401.20891-2-petre.rodan@subdimension.ro>
References: <20231204194401.20891-1-petre.rodan@subdimension.ro>
        <20231204194401.20891-2-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Mon,  4 Dec 2023 21:43:59 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Adds driver for digital Honeywell TruStability HSC and SSC series
> pressure and temperature sensors.
> Communication is one way. The sensor only requires 4 bytes worth of
> clock pulses on both i2c and spi in order to push the data out.
> The i2c address is hardcoded and depends on the part number.
> There is no additional GPIO control.
> 
> Datasheet:
> https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [HSC]
> Datasheet:
> https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf [SSC]
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
One trivial comment from me to add to what Andy covered.

> +/*
/**
Looks to be valid kernel-doc. Might as well mark it as such.


> + * hsc_measurement_is_valid() - validate last conversion via status bits
> + * @data: structure containing instantiated sensor data
> + * Return: true only if both status bits are zero
> + *
> + * the two MSB from the first transfered byte contain a status code
> + *   00 - normal operation, valid data
> + *   01 - device in factory programming mode
> + *   10 - stale data
> + *   11 - diagnostic condition
> + */

