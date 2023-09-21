Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDF27A9D54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjIUTbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjIUTaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:30:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6D1AE27C;
        Thu, 21 Sep 2023 11:05:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-530fa6859c8so312485a12.1;
        Thu, 21 Sep 2023 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695319510; x=1695924310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqILmRrkFisrRKmaW78QkaeJdw1v2LLslqXL7U2Qibs=;
        b=BKMK3ifbBuaPCo/LzaurD48Or9f2gU/X7gy3sLysWVSBH5FzEVSRRfCyi64THGHjS2
         vSofqPsAePS6iZVHilYNej+1tmFm0UJpFsDJmTXoc234U2wf3n2YvYrcv/AEv18DJXTQ
         LM4/Z/5V/iuxDBxl6DGZuaWJaNdbw7Jcna2LicTtmJPjBp45ESC6OOGBbOKVrvGbfdZC
         lOZJIug1uXAY1fJODN/JpDroxyslHWo9kXuGeAUBFEQHDEQdEUPi7Qlrj0H4kO8JIIze
         aFr+xzIwxXUkiF7nIjOvK0jji37ZVXPYQvzAyZBx29de1Hzv4IbZi7nyApSjNWaPYyY0
         CIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319510; x=1695924310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqILmRrkFisrRKmaW78QkaeJdw1v2LLslqXL7U2Qibs=;
        b=YHZoMD3JOI38EyQ+zIjQbqmNnRZThRA8+IeHv1DpYip1p1AN+ipythqb7KlS+C5bpJ
         te6nwx9aULIxASMF350Hz+7yvH5AJ+ngaTaR/bTYommdsWoPM8LjxpbhkmV49CTp9TP9
         G4ieaGQ4GJ4U1D4W3N7H34Yui/kIkpXIslWFSOAHhfDpMY+50/MXjSPiRs3b8Q6XHTJb
         3cWLeLEGzFuSzBGUzL1RNHSAMQv0aoXC+uCayf9x13I70OPrQbw+EHnrdXOTR23xTWU4
         gq4eJ2J7gIXDk/aZMh8iziWqOEfC7IlsjLvnJr/ExgtSujju1wuZiH0m4EYDQ7IiS64W
         sJOw==
X-Gm-Message-State: AOJu0YwB7dSraJqbiMtJ0QjBoeXSkcVZhHOaJdaPgyvRkp1SzEXY18o2
        jXf/Rcs3x4yJZOtFWP5eMM62jh0TTO8=
X-Google-Smtp-Source: AGHT+IF+oKDTsosZGaZ2uvEa7WyXJpyPAvqXNP8oaQypnhzCu6F2pFqji6uAa0WEyjJeWR0GnqpeNA==
X-Received: by 2002:a05:600c:3b82:b0:401:c717:ec69 with SMTP id n2-20020a05600c3b8200b00401c717ec69mr4204678wms.4.1695276610627;
        Wed, 20 Sep 2023 23:10:10 -0700 (PDT)
Received: from [10.0.0.26] ([178.160.241.68])
        by smtp.gmail.com with ESMTPSA id h4-20020a056000000400b0031aef72a021sm748255wrx.86.2023.09.20.23.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 23:10:10 -0700 (PDT)
Message-ID: <285260c6-b9ff-b5f5-4e98-03ab4d6514c9@gmail.com>
Date:   Thu, 21 Sep 2023 10:10:08 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/2] ALSA: Add new driver for MARIAN M2 sound card
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        skhan@linuxfoundation.org
References: <20230920151610.113880-1-ivan.orlov0322@gmail.com>
 <20230920151610.113880-2-ivan.orlov0322@gmail.com>
 <87edisvny4.wl-tiwai@suse.de>
Content-Language: en-US
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <87edisvny4.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 19:55, Takashi Iwai wrote:
>> +	spin_lock(&marian->reglock);
>> +	marian_generic_set_dco(marian, ucontrol->value.integer.value[0]);
>> +	spin_unlock(&marian->reglock);
> 
> The control get/put callbacks can sleep, hence usually it's
> spin_lock_irq().  Or if the all places for this lock are sleepable
> context, use a mutex instead.
> 

Alright, it looks like reglock is used in sleepable context only, so 
I'll replace it with mutex. Thanks!

>> +static int marian_control_pcm_loopback_info(struct snd_kcontrol *kcontrol,
>> +					    struct snd_ctl_elem_info *uinfo)
>> +{
>> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
>> +	uinfo->count = 1;
>> +	uinfo->value.integer.min = 0;
>> +	uinfo->value.integer.max = 1;
>> +
>> +	return 0;
> 
> This can be replaced with snd_ctl_boolean_mono_info.
> 
>

Oh, I forgot to use 'snd_ctl_boolean_mono_info' here. Will be done.

>> +}
>> +
>> +static int marian_control_pcm_loopback_get(struct snd_kcontrol *kcontrol,
>> +					   struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct marian_card *marian = snd_kcontrol_chip(kcontrol);
>> +
>> +	ucontrol->value.integer.value[0] = marian->loopback;
>> +
>> +	return 0;
>> +}
>> +
>> +static int marian_control_pcm_loopback_put(struct snd_kcontrol *kcontrol,
>> +					   struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct marian_card *marian = snd_kcontrol_chip(kcontrol);
>> +
>> +	marian->loopback = ucontrol->value.integer.value[0];
> 
> Better to normalize with !!ucontrol->value.integer.value[0].
> The value check isn't done as default.
> 
Will be fixed, thanks!

>> +static int marian_control_pcm_loopback_create(struct marian_card *marian)
>> +{
>> +	struct snd_kcontrol_new c = {
>> +		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
>> +		.name = "Loopback",
> 
> Better to have "Switch" suffix.
>

Yeah, and I guess some other controls also have to be renamed. Will be 
done :)

>> +static int marian_m2_output_frame_mode_create(struct marian_card *marian, char *label, u32 idx)
>> +{
>> +	struct snd_kcontrol_new c = {
>> +		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>> +		.name = label,
>> +		.private_value = idx,
>> +		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
> 
> Does this have to be VOLATILE?  Some others look also dubious.
> Basically you set the value via this mixer element, then it's
> persistent.
>

As I understand, some controls which depend on external inputs (like the 
'Input 1 Freq', which measures frequency on the Input 1), should be 
volatile, right?

This one definitely shouldn't, so I will change it to persistent.

Thank you for your prompt reply and review!

--
Kind regards,
Ivan Orlov

> 
> thanks,
> 
> Takashi

