Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E681C7B3C7F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjI2WCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjI2WCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:02:37 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACC7F1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:02:32 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1dd1db54d42so5102332fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696024951; x=1696629751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pFhnBf7J1tBbVfb73eVV1woDtz2+p689Zk2WUgYJB3Y=;
        b=s0uPGN0PyUtVslwMYFg6XLPAhlG+xxgGTAWMmN3t/llJXuxJNG/HOn1Xc/42K1A1CX
         Y40OHaCoEnkZDj55xSMA8ip90tEWqShEjFoXgCuFRn0qhk8mkcnw5uyLbX/5N6fSaq/Y
         cI6PJfxJkr8HTT7GV1d2fTJObJdO/cqagNSFSTuedkpitxwQAnXc8dirMPhcWHIOdnff
         /VgHpVuSE0QALtjPlYkdViA5J7rKko0b5vf629QzmU0Q85ZgiyHc11U/6lCGi1/ewzrA
         3MP7JUGBicVtNMN/4vgZoQ94pG+5GKvzpDMUUaZe81sOAlto9EMTODNlX5ZIToP3Xx0M
         fqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696024951; x=1696629751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFhnBf7J1tBbVfb73eVV1woDtz2+p689Zk2WUgYJB3Y=;
        b=SP+kkjaw+d+vrOHV2fTOWV24Qf+inQeBs78+MLwUoJtWCBUDW0LfWWizXOfGAdJA+L
         AQvH/hm9j01yT8Z4Jk72fFFqtfc/iIlXRMGxishbsndcD3Brc9dzoP9KDA08F79HND9D
         KDKLi/h+ZFAqHxqWk5MAgpByLBo1Fsq2skn+HfMSBHKlftVhNM9rdk6Gx8fku4c9V+XA
         ulfYbCIKRKHauG+/ZxR6Q61rFFWj88SDAwiFSLvBqLnOvWoi1xtt1kcGlyrxabq4zmXL
         VJA+BBpoqDxPhIFC7azlWUJLLREq429h3ntnOEkQ9zJOqBOBCyNg0yqEgrWXQHyNA3kj
         tdpQ==
X-Gm-Message-State: AOJu0YxjPSYO1AVN/BwVs8FvgCPiBiJL3rjZ0BLpWlPsvZtaS/Rnzte+
        JfdnR5YkuCFJ+3eleAx/1WjDhQ==
X-Google-Smtp-Source: AGHT+IHEQIrACVZvUoSN4mtaGAxnBzZRZwJJCx+okup5sOevcRx/rulvLcgU9VpVjnvOO1xBKvVfbQ==
X-Received: by 2002:a05:6870:1589:b0:1d5:f43a:3a5c with SMTP id j9-20020a056870158900b001d5f43a3a5cmr6189182oab.45.1696024951123;
        Fri, 29 Sep 2023 15:02:31 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id u6-20020a9d4d86000000b006ba864f5b37sm1986642otk.12.2023.09.29.15.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 15:02:30 -0700 (PDT)
Message-ID: <905052d7-f6f7-8e1c-4ed3-876b1d736225@baylibre.com>
Date:   Fri, 29 Sep 2023 17:02:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 00/27] iio: resolver: move ad2s1210 out of staging
Content-Language: en-US
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Apelete Seketeli <aseketeli@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
From:   David Lechner <dlechner@baylibre.com>
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/23 12:23 PM, David Lechner wrote:
> From: David Lechner <david@lechnology.com>
> 
> v3 changes:
> 
> * Added description of A0/A1 lines in DT bindings.
> * Added power supply regulators to DT bindings.
> * Dropped "staging: iio: Documentation: document IIO resolver AD2S1210
>    sysfs attributes" (these attributes are being removed instead).
> * Dropped applied patches:
>    * "staging: iio: resolver: ad2s1210: fix ad2s1210_show_fault"
>    * "iio: adc: MCP3564: fix the static checker warning"
> * Split "staging: iio: resolver: ad2s1210: fix probe" into multiple patches.
> * Moved sorting imports to separate patch.
> * Renamed fclkin to clkin_hz.
> * Added __be16 sample field to state struct for reading raw samples.
> * Split out new function ad2s1210_single_conversion() from
>    ad2s1210_read_raw().
> * Split out new ad2s1210_get_hysteresis() and ad2s1210_set_hysteresis()
>    functions.
> * Fixed multi-line comment style.
> * Added notes about soft reset not resetting config registers.
> * Made use of FIELD_PREP() macro.
> * Added more explanation to regmap commit message.
> * Removed datasheet names from channel specs.
> * Replaced "staging: iio: resolver: ad2s1210: rename fexcit attribute"
>    with "staging: iio: resolver: ad2s1210: convert fexcit to channel
>    attribute".
> * Replaced "staging: iio: resolver: ad2s1210: add phase_lock_range
>    attributes" with "staging: iio: resolver: ad2s1210: add phase lock
>    range support"
> * Added additional patches to convert custom device attributes to event
>    attributes.
> * Added patch to add channel label attributes.
> 
> v2 changes:
> * Address initial device tree patch feedback
> * Drop "iio: sysfs: add IIO_DEVICE_ATTR_NAMED_RW macro" (related cleanups
>    also dropped for now, will address in a future series if needed)
> * Apply improvements as a series of patches to the staging driver. It is
>    not quite ready for the move out of staging patch yet.
> 
> This series has been tested on actual hardware using a EVAL-AD2S1210 evaluation
> board. (Note: not all device tree features have been implemented in the driver
> since the eval board doesn't support them out of the box. We plan to add them
> later if needed.)
> 
> Most of the questions about dealing with faults from the v2 cover letter
> have been addressed. There is still the question about what to do with
> the current `fault` attribute (it is the only custom device attribute
> remaining from the original staging driver). It was suggested to split it
> out into multiple attributes in a subdirectory. Since we now have events
> for all of the faults, I'm wondering if this is something that is still needed.
> In the current implementation, it is possible to start listening to events,
> clear the faults and then read a sample to trigger events for any current
> faults so we have a way to get current faults already.
> 
> There is also the matter of clearing faults. Writing the excitation
> frequency has a side-effect of clearing the faults, so we could use
> that as the reset. Or we could change the current fault attribute to
> write-only and rename it. Or is there a better way that I have overlooked?
> 
> Once this last issue is addressed, I think this driver will be ready
> for consideration for moving out of staging.
> ---
> David Lechner (27):
>        dt-bindings: iio: resolver: add devicetree bindings for ad2s1210
>        staging: iio: resolver: ad2s1210: fix use before initialization
>        staging: iio: resolver: ad2s1210: remove call to spi_setup()
>        staging: iio: resolver: ad2s1210: check return of ad2s1210_initial()
>        staging: iio: resolver: ad2s1210: remove spi_set_drvdata()
>        staging: iio: resolver: ad2s1210: sort imports
>        staging: iio: resolver: ad2s1210: always use 16-bit value for raw read
>        staging: iio: resolver: ad2s1210: implement IIO_CHAN_INFO_SCALE
>        staging: iio: resolver: ad2s1210: use devicetree to get CLKIN rate
>        staging: iio: resolver: ad2s1210: use regmap for config registers
>        staging: iio: resolver: ad2s1210: add debugfs reg access
>        staging: iio: resolver: ad2s1210: remove config attribute
>        staging: iio: resolver: ad2s1210: rework gpios
>        staging: iio: resolver: ad2s1210: implement hysteresis as channel attr
>        staging: iio: resolver: ad2s1210: refactor setting excitation frequency
>        staging: iio: resolver: ad2s1210: read excitation frequency from control register
>        staging: iio: resolver: ad2s1210: convert fexcit to channel attribute
>        staging: iio: resolver: ad2s1210: convert resolution to devicetree property
>        staging: iio: resolver: ad2s1210: add phase lock range support
>        staging: iio: resolver: ad2s1210: add triggered buffer support
>        staging: iio: resolver: ad2s1210: convert LOT threshold attrs to event attrs
>        staging: iio: resolver: ad2s1210: convert LOS threshold to event attr
>        staging: iio: resolver: ad2s1210: convert DOS overrange threshold to event attr
>        staging: iio: resolver: ad2s1210: convert DOS mismatch threshold to event attr
>        staging: iio: resolver: ad2s1210: rename DOS reset min/max attrs
>        staging: iio: resolver: ad2s1210: implement fault events
>        staging: iio: resolver: ad2s1210: add label attribute support
> 
>   .../bindings/iio/resolver/adi,ad2s1210.yaml        |  177 +++
>   .../Documentation/sysfs-bus-iio-resolver-ad2s1210  |   27 +
>   drivers/staging/iio/resolver/Kconfig               |    1 +
>   drivers/staging/iio/resolver/ad2s1210.c            | 1583 +++++++++++++++-----
>   4 files changed, 1391 insertions(+), 397 deletions(-)
> ---
> base-commit: 5e99f692d4e32e3250ab18d511894ca797407aec
> change-id: 20230925-ad2s1210-mainline-2791ef75e386
> 

In the end, this is what sysfs looks like:


root@analog:~# tree /sys/bus/iio/devices/iio\:device1/
/sys/bus/iio/devices/iio:device1/
├── buffer
│   ├── data_available
│   ├── direction
│   ├── enable
│   ├── length
│   └── watermark
├── buffer0
│   ├── data_available
│   ├── direction
│   ├── enable
│   ├── in_angl0_en
│   ├── in_angl0_index
│   ├── in_angl0_type
│   ├── in_anglvel0_en
│   ├── in_anglvel0_index
│   ├── in_anglvel0_type
│   ├── in_timestamp_en
│   ├── in_timestamp_index
│   ├── in_timestamp_type
│   ├── length
│   └── watermark
├── current_timestamp_clock
├── dev
├── events
│   ├── in_altvoltage0_mag_reset_max
│   ├── in_altvoltage0_mag_reset_max_available
│   ├── in_altvoltage0_mag_reset_min
│   ├── in_altvoltage0_mag_reset_min_available
│   ├── in_altvoltage0_mag_value
│   ├── in_altvoltage0_mag_value_available
│   ├── in_altvoltage0_thresh_falling_value
│   ├── in_altvoltage0_thresh_falling_value_available
│   ├── in_altvoltage0_thresh_rising_value
│   ├── in_altvoltage0_thresh_rising_value_available
│   ├── in_angl1_thresh_rising_hysteresis
│   ├── in_angl1_thresh_rising_hysteresis_available
│   ├── in_angl1_thresh_rising_value
│   ├── in_angl1_thresh_rising_value_available
│   ├── in_phase0_mag_value
│   └── in_phase0_mag_value_available
├── fault
├── in_altvoltage0_label
├── in_altvoltage1_x_label
├── in_altvoltage1_y_label
├── in_angl0_hysteresis
├── in_angl0_hysteresis_available
├── in_angl0_label
├── in_angl0_raw
├── in_angl0_scale
├── in_angl1_label
├── in_anglvel0_label
├── in_anglvel0_raw
├── in_anglvel0_scale
├── in_phase0_label
├── name
├── of_node -> ../../../../../../../../firmware/devicetree/base/axi/spi@e0006000/ad2s1210@0
├── out_altvoltage0_frequency
├── out_altvoltage0_frequency_available
├── out_altvoltage0_label
├── power
│   ├── autosuspend_delay_ms
│   ├── control
│   ├── runtime_active_time
│   ├── runtime_status
│   └── runtime_suspended_time
├── scan_elements
│   ├── in_angl0_en
│   ├── in_angl0_index
│   ├── in_angl0_type
│   ├── in_anglvel0_en
│   ├── in_anglvel0_index
│   ├── in_anglvel0_type
│   ├── in_timestamp_en
│   ├── in_timestamp_index
│   └── in_timestamp_type
├── subsystem -> ../../../../../../../../bus/iio
├── trigger
│   └── current_trigger
├── uevent
└── waiting_for_supplier

8 directories, 72 files

And this is what the output of iio_info looks like:
(note: iio_info does not currently support events so those
attributes are not visible here)

         iio:device1: ad2s1210 (buffer capable)
                 9 channels found:
                         angl0:  (input, index: 0, format: be:U16/16>>0)
                         5 channel-specific attributes found:
                                 attr  0: hysteresis value: 1
                                 attr  1: hysteresis_available value: 0 1
                                 attr  2: label value: position
                                 attr  3: raw value: 12578
                                 attr  4: scale value: 0.000095874
                         anglvel0:  (input, index: 1, format: be:S16/16>>0)
                         3 channel-specific attributes found:
                                 attr  0: label value: velocity
                                 attr  1: raw value: 5
                                 attr  2: scale value: 0.023968449
                         timestamp:  (input, index: 2, format: le:S64/64>>0)
                         phase0:  (input)
                         1 channel-specific attributes found:
                                 attr  0: label value: synthetic reference
                         altvoltage0:  (output)
                         3 channel-specific attributes found:
                                 attr  0: frequency value: 10000
                                 attr  1: frequency_available value: [2000 250 20000]
                                 attr  2: label value: excitation
                         angl1:  (input)
                         1 channel-specific attributes found:
                                 attr  0: label value: tracking error
                         altvoltage1_y:  (input)
                         1 channel-specific attributes found:
                                 attr  0: label value: sine
                         altvoltage0:  (input)
                         1 channel-specific attributes found:
                                 attr  0: label value: monitor signal
                         altvoltage1_x:  (input)
                         1 channel-specific attributes found:
                                 attr  0: label value: cosine
                 3 device-specific attributes found:
                                 attr  0: current_timestamp_clock value: realtime
                                 attr  1: fault value: 0x00
                                 attr  2: waiting_for_supplier value: 0
                 2 buffer-specific attributes found:
                                 attr  0: data_available value: 0
                                 attr  1: direction value: in
                 1 debug attributes found:
                                 debug attr  0: direct_reg_access ERROR: Input/output error (5)
                 Current trigger: trigger0(test)

