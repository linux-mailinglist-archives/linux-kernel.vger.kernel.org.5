Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2687A5CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjISIgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISIgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:36:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E79114;
        Tue, 19 Sep 2023 01:35:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3216b83c208so19047f8f.1;
        Tue, 19 Sep 2023 01:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695112553; x=1695717353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dV2G+63a3oMH14KZWQWuB/v9m43DyF6GjQGhHD+mfFg=;
        b=B+B33f8Kne4c3g/2PKU/9nzD5s6BjIr1ZLhL14kanVox2+hwMI7rsLAaQywWZxcdoU
         tadJ65o18m91/udOeEcwnuQjUvtKg60GDv49AlhnRkFbZyPgK98FjswrTACtSoXUi0CY
         LcEqK1GULXKd5J5yftZhnL6DTy0rJ650ROhSPq1oyuzFgcIhZDZ0bubL5d6yPNd3/cBp
         Q7hLqkp2n4SNXjphotGMn08OCJj9sWUJPM4lb6Y3Q5wxpPHLWoNKZyB5TBznaDV9Fi8L
         KWsyrzRprEn3C40zZRL64l8OdP5+xjW/OrDD5KiARe1TendhrbXsN+vy4FfaLl15MLvS
         X/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695112553; x=1695717353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dV2G+63a3oMH14KZWQWuB/v9m43DyF6GjQGhHD+mfFg=;
        b=ELNhKajho5X2uCVfoBR01NAS80ZKNjJHsoUWKoa0ANzjx5dJscMfrn4rRPy68Iv4zS
         uL+fm7kT2nRqrFIUdZm0iwY7O4Mk/2+OCLP7qf0fXMTTtPFAVmN+EIdXupOk+2QhjUR8
         OT7BdxyC4UthMguD/E4HKh43wi4wFOVrv+fuYRCa+BM40+XU3WynSAZASeCWZ9dgwIWr
         Zg3D9e0dUtkm8zXu+58oMBv97NY8KExn8dxuN9JzXmqcJdm1XgCgv8V9JoCN+x3ywwoT
         FTNXLd0ld0RdEiy2l+kMEjwVW5Be3N36ieQVb4gCU/MIewEMxn2JSYVuoKZgp8T5wXOy
         qQXQ==
X-Gm-Message-State: AOJu0YyG7pmIoitDGmWqgTenAQSKKtfYRJpmLmpKF1H+a2dxr7ALIRYP
        AoDotEY9FQLr9jLI/Vm8NHU=
X-Google-Smtp-Source: AGHT+IHRNxRaJMpDbUET4qhMBAD4AyqktKwC1xzq6pRb+1P6VTrg6DgiBtGa+9/fJ+fj/1iRhCn9/w==
X-Received: by 2002:a5d:43c3:0:b0:31f:84c9:d75f with SMTP id v3-20020a5d43c3000000b0031f84c9d75fmr8965796wrr.4.1695112552745;
        Tue, 19 Sep 2023 01:35:52 -0700 (PDT)
Received: from [10.0.0.26] ([178.160.241.68])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d628f000000b0031f729d883asm14843546wru.42.2023.09.19.01.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 01:35:52 -0700 (PDT)
Message-ID: <8e39a894-e921-51e6-c9bf-b007a08b10fb@gmail.com>
Date:   Tue, 19 Sep 2023 12:35:45 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] ALSA: Add new driver for Marian M2 sound card
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20230918181044.7257-1-ivan.orlov0322@gmail.com>
 <20230918181044.7257-2-ivan.orlov0322@gmail.com>
 <87y1h2y4tr.wl-tiwai@suse.de>
Content-Language: en-US
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <87y1h2y4tr.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/23 11:56, Takashi Iwai wrote:
> On Mon, 18 Sep 2023 20:10:44 +0200,
> Ivan Orlov wrote:
>>
>> +#include <sound/core.h>
>> +#include <sound/control.h>
>> +#include <sound/pcm.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/core.h>
>> +#include <sound/pcm.h>
>> +#include <sound/initval.h>
>> +#include <sound/info.h>
>> +#include <linux/delay.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/interrupt.h>
> 
> We usually include linux/* at first, followed by sound/*.
> 
> 
>> +#define DEBUG
> 
> Any need to define this for the production system?
> 
> 
>> +struct marian_card_descriptor;
>> +struct marian_card;
>> +
>> +struct marian_card_descriptor {
>> +	char *name;
>> +	char *port_names;
>> +	unsigned int speedmode_max;
>> +	unsigned int ch_in;
>> +	unsigned int ch_out;
>> +	unsigned int midi_in;
>> +	unsigned int midi_out;
>> +	unsigned int serial_in;
>> +	unsigned int serial_out;
>> +	unsigned int wck_in;
>> +	unsigned int wck_out;
>> +
>> +	unsigned int dma_bufsize;
>> +
>> +	void (*hw_constraints_func)(struct marian_card *marian,
>> +				    struct snd_pcm_substream *substream,
>> +				    struct snd_pcm_hw_params *params);
>> +	/* custom function to set up ALSA controls */
>> +	void (*create_controls)(struct marian_card *marian);
>> +	/* init is called after probing the card */
>> +	int (*init_card)(struct marian_card *marian);
>> +	void (*free_card)(struct marian_card *marian);
>> +	/* prepare is called when ALSA is opening the card */
>> +	void (*prepare)(struct marian_card *marian);
>> +	void (*set_speedmode)(struct marian_card *marian, unsigned int speedmode);
>> +	void (*proc_status)(struct marian_card *marian, struct snd_info_buffer *buffer);
>> +	void (*proc_ports)(struct marian_card *marian, struct snd_info_buffer *buffer,
>> +			   unsigned int type);
>> +
>> +	struct snd_pcm_hardware info_playback;
>> +	struct snd_pcm_hardware info_capture;
> 
> Do we need this kind of abstraction inside the driver?
> As far as I see, the driver supports only a single model, hence there
> is no real merit of abstracted / indirect function calls.
> 
> So I stop reading at this point.
> 
> 
> thanks,
> 
> Takashi

Hi Takashi,

Thank you for the review! I will send the next version after removing 
all indirections and cleaning the code again.

--
Kind regards,
Ivan Orlov
