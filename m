Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D480E932
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346165AbjLLKeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLLKeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:34:09 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610E9AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:34:14 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d331f12f45so4424295ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702377254; x=1702982054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yONHT2o8AvXEqFY+vlUlHd0KuAOs7YqS8bCdnIAlUsw=;
        b=fvVt75vqraL75IXs3lEh+iItOu/yV3UXCsD+xxAn+nVPdz+ncyPrQ5AtDijBzJ0rnA
         3Gu1IQAFc+q9GcTVXQCIJn5cz5HNf9p2qjc0BKguKDFXABKAuzh9jZWmzy75jd+cSbQt
         +rDWfCA0zGkxngJKBcnU3cebQ4DaXuvZuS5ok4GJmsUt6VZ+TnZAViclddxlw8fwj8F9
         phyUNGQM+NSppLydOcLoyB75mx6mwPnjTnKvL9OAydkdmyPuZJpRbdzjOyPr+aYtWHBj
         xspqNXT3M3ny9r25c4dFeMGLFvl6H+dda2GfohgukUH5AvmWJJ2zkRSSYEWpyu39VE2U
         ffXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702377254; x=1702982054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yONHT2o8AvXEqFY+vlUlHd0KuAOs7YqS8bCdnIAlUsw=;
        b=lyEhkMLyQjDkp3ZIBsu6mU4IRwAZfG5V02c4dpZFpqnoNts+0Ht1dQ6e8E/SqJW4is
         WMo+ewiPVwaxxwdZPney1OLgc1lVP2p75nIfq2Xf47BEXDjJ7oX0iNURm/oiAU96R+9Y
         owJrMVsiiGra3/y8O1uWFflNX34nvzsQXhoBYksY/whXwScFbIuNL8XmWNiyyMIuWL9x
         fVRe1z+szyaFZduFS8Tx94K/8sfzIOmUWRtR+E4O2uH7l3ovUhKK/cgP9czDi2Hc32Wp
         zrTcojCCTNAaNXddb18jRCz0vM82A7mAzTMczkPUZNhoq5IdPJi41dYXHh9d4KcYVzdf
         YlDg==
X-Gm-Message-State: AOJu0Yxap/tELWal+r0nvcm7jB0dfbNdV4PyyoJOXBFNPjnBQajXxwIy
        E8TKsoVD72IZN7pVo5rmAlWm8Q==
X-Google-Smtp-Source: AGHT+IE83uS0bfgt2WGdT+m3M7qJlgTsnZt4smAeY57uMMQCJ9VZvSWZFb4i8SHRs4EgPisEUKAdug==
X-Received: by 2002:a17:903:2301:b0:1d0:6ffe:1e91 with SMTP id d1-20020a170903230100b001d06ffe1e91mr3173440plh.116.1702377253779;
        Tue, 12 Dec 2023 02:34:13 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001d340c71ccasm549027plb.275.2023.12.12.02.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:34:13 -0800 (PST)
Date:   Tue, 12 Dec 2023 16:04:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Harald Mommer <Harald.Mommer@opensynergy.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Haixu Cui <quic_haixcui@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harald.Mommer@gmail.com,
        quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [virtio-dev] [RFC PATCH v1 2/3] virtio-spi: Add virtio-spi.h (V4
 draft specification).
Message-ID: <20231212103411.wbjmr5mefmxfnsib@vireshk-i7>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
 <20231027161016.26625-3-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027161016.26625-3-Harald.Mommer@opensynergy.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harald,

I have reviewed the specifications changes recently and here is an
attempt to go through the kernel code too.

I hope you would be sending a new version soon as there are few
changes in the spec already.

On 27-10-23, 18:10, Harald Mommer wrote:
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> Add initial virtio-spi.h header for virtio SPI. The header file is
> compliant to the virtio SPI draft specification V4.
> 
> Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
> ---
>  include/uapi/linux/virtio_spi.h | 130 ++++++++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 include/uapi/linux/virtio_spi.h
> 
> diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
> new file mode 100644
> index 000000000000..9cf4335784ef
> --- /dev/null
> +++ b/include/uapi/linux/virtio_spi.h
> @@ -0,0 +1,130 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */

Maybe this should be:

SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause

?

> +/*
> + * Copyright (C) 2023 OpenSynergy GmbH
> + */
> +#ifndef _LINUX_VIRTIO_VIRTIO_SPI_H
> +#define _LINUX_VIRTIO_VIRTIO_SPI_H
> +
> +#include <linux/types.h>
> +#include <linux/virtio_types.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_config.h>
> +
> +// clang-format off

Why do we want to avoid clang-format here ?

> +/* Sample data on trailing clock edge */
> +#define VIRTIO_SPI_CPHA (1u << 0)
> +/* Clock is high when IDLE */
> +#define VIRTIO_SPI_CPOL (1u << 1)
> +/* Chip Select is active high */
> +#define VIRTIO_SPI_CS_HIGH (1u << 2)
> +/* Transmit LSB first */
> +#define VIRTIO_SPI_MODE_LSB_FIRST (1u << 3)
> +
> +/*
> + * Beware: From here on the bits do not match any more the Linux definitions!
> + */

Not sure if this is really required here. We are talking about the
interface defined by the Virtio protocol here and there can be
mismatch with Linux definitions.

> +/* Loopback mode */
> +#define VIRTIO_SPI_MODE_LOOP (1u << 4)
> +
> +/* All config fields are read-only for the Virtio SPI driver */
> +struct virtio_spi_config {

Can you please add proper doc style comments for the structures ?

> +	/* /dev/spidev<bus_num>.CS. For Linux must be >= 0 and <= S16_MAX */
> +	__le16 bus_num;
> +	/* # of /dev/spidev<bus_num>.CS with CS=0..chip_select_max_number -1 */
> +	__le16 chip_select_max_number;
> +	/*
> +	 * 0: physical SPI master doesn't support cs timing setting"
> +	 * 1:_physical SPI master supports cs timing setting
> +	 * TODO: Comment on this, unclear and naming not good!
> +	 * Meant is probably word_delay_ns, cs_setup_ns and cs_delay_hold_ns
> +	 * while cs_change_delay_inactive_ns may be supportable everywhere
> +	 * Or all are meant. And the naming mismatch is the cs_ when the most
> +	 * critical word_delay_ns which cannot be supported everywhere is also
> +	 * affected.
> +	 */
> +	u8 cs_timing_setting_enable;
> +	/* Alignment and future extension */
> +	u8 reserved[3];
> +};
> +
> +/*
> + * @slave_id: chipselect index the SPI transfer used.
> + *
> + * @bits_per_word: the number of bits in each SPI transfer word.
> + *
> + * @cs_change: whether to deselect device after finishing this transfer
> + *     before starting the next transfer, 0 means cs keep asserted and
> + *     1 means cs deasserted then asserted again.
> + *
> + * @tx_nbits: bus width for write transfer.
> + *     0,1: bus width is 1, also known as SINGLE
> + *     2  : bus width is 2, also known as DUAL
> + *     4  : bus width is 4, also known as QUAD
> + *     8  : bus width is 8, also known as OCTAL
> + *     other values are invalid.
> + *
> + * @rx_nbits: bus width for read transfer.
> + *     0,1: bus width is 1, also known as SINGLE
> + *     2  : bus width is 2, also known as DUAL
> + *     4  : bus width is 4, also known as QUAD
> + *     8  : bus width is 8, also known as OCTAL
> + *     other values are invalid.
> + *
> + * @reserved: for future use.
> + *
> + * @mode: SPI transfer mode.
> + *     bit 0: CPHA, determines the timing (i.e. phase) of the data
> + *         bits relative to the clock pulses.For CPHA=0, the
> + *         "out" side changes the data on the trailing edge of the
> + *         preceding clock cycle, while the "in" side captures the data
> + *         on (or shortly after) the leading edge of the clock cycle.
> + *         For CPHA=1, the "out" side changes the data on the leading
> + *         edge of the current clock cycle, while the "in" side
> + *         captures the data on (or shortly after) the trailing edge of
> + *         the clock cycle.
> + *     bit 1: CPOL, determines the polarity of the clock. CPOL=0 is a
> + *         clock which idles at 0, and each cycle consists of a pulse
> + *         of 1. CPOL=1 is a clock which idles at 1, and each cycle
> + *         consists of a pulse of 0.
> + *     bit 2: CS_HIGH, if 1, chip select active high, else active low.
> + *     bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
> + *         first, else LSB first.
> + *     bit 4: LOOP, loopback mode.
> + *
> + * @freq: the transfer speed in Hz.
> + *
> + * @word_delay_ns: delay to be inserted between consecutive words of a
> + *     transfer, in ns unit.
> + *
> + * @cs_setup_ns: delay to be introduced after CS is asserted, in ns
> + *     unit.
> + *
> + * @cs_delay_hold_ns: delay to be introduced before CS is deasserted
> + *     for each transfer, in ns unit.
> + *
> + * @cs_change_delay_inactive_ns: delay to be introduced after CS is
> + *     deasserted and before next asserted, in ns unit.
> + */
> +struct spi_transfer_head {
> +	__u8 slave_id;
> +	__u8 bits_per_word;
> +	__u8 cs_change;
> +	__u8 tx_nbits;
> +	__u8 rx_nbits;
> +	__u8 reserved[3];
> +	__le32 mode;
> +	__le32 freq;
> +	__le32 word_delay_ns;
> +	__le32 cs_setup_ns;
> +	__le32 cs_delay_hold_ns;
> +	__le32 cs_change_delay_inactive_ns;
> +};
> +
> +struct spi_transfer_result {
> +#define VIRTIO_SPI_TRANS_OK 0
> +#define VIRTIO_SPI_TRANS_ERR 1

Maybe just define them above the struct.

> +	__u8 result;
> +};
> +// clang-format on
> +
> +#endif /* #ifndef _COQOS_VIRTIO_VIRTIO_SPI_H */

s/_COQOS_VIRTIO_VIRTIO_SPI_H/_LINUX_VIRTIO_VIRTIO_SPI_H/

-- 
viresh
