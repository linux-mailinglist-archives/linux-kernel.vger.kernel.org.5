Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6E17DC6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbjJaHLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343497AbjJaHLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:11:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C27C2;
        Tue, 31 Oct 2023 00:11:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507c91582fdso7692654e87.2;
        Tue, 31 Oct 2023 00:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698736299; x=1699341099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WC4FQ8HjBFyDld6QjIj9zYCdwxXzfSzp/WExAXAKuLo=;
        b=csw6TDJadqiDUA0SVy6o82HPm/nM+acyVp/7Ij1m7Miis9H++OkSwy3QmlLryAPQGV
         mXrSIMN+PyzxgDIcn0n35QGUf4TCCTrv4bwoKG9ge18ydAbzOpPMPrtxo9FT26a51HJh
         JxrjENwmP0hZjyyQd2L6FzZ/M1WHJ7wm3bno6QV2zFv0TGUD5YZwWojbjlXBw8NNoHlq
         S+iSTl1reLxSVGUINx/NOc2stNFce9OrH4DqsaJtSesWuPjMamaAyrnNBYc5FVbKXQ4X
         3oJDFUYiTOkiWICqL54qldZ1qpFjBhjiKcBDibgyW3SuZygumhS3Wzf5EFdVm/arw30/
         fqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698736299; x=1699341099;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WC4FQ8HjBFyDld6QjIj9zYCdwxXzfSzp/WExAXAKuLo=;
        b=xSyduuYKBnG3fn3zztObmpySyHJ3XvM+xelVHezNy+MS70mHYd9frxb9siRwupAJzS
         TiUTeoX0cumZF044W25Pil3b7CE7dUDvmliwfLqzL6xAMaJvcbAdDEXC5xW5AR+kDa3R
         7nV7J1USuBCRNWlMYcoP79injgM7+0yaIwGrEZpPnTFFYKdLJ+y1HWaAKksiI2Dj3PBJ
         SfXl0RhfxJx5aa10GoSwwjigR670Q2mQDog9CkIZXsRBzqPPaD2o3RsSkl7Gb56ohTjn
         3tug2WzsaQGKP1jzqzpRH8VBQMf7PbOSuszZzy9j+yloQWfPGFDm4dkRsHd6DhCMLGrf
         RAPQ==
X-Gm-Message-State: AOJu0YyMB8jFpXN/m29AhP0uNt8nyUMOTGqeqjExGYTPJ+TSTQxS1SQ+
        5hPZt3ePexN3ScqKI6m0r6g=
X-Google-Smtp-Source: AGHT+IFmHnzAN0wVPRXBOF2R+/P2XF0dD34/Bpdf81a0le7DmkR0WcDsG7xh6UnJSo3SqA8j3vfkGg==
X-Received: by 2002:a19:f70c:0:b0:503:3278:3221 with SMTP id z12-20020a19f70c000000b0050332783221mr8238406lfe.69.1698736298744;
        Tue, 31 Oct 2023 00:11:38 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24bd1000000b00501c673e773sm115215lfq.39.2023.10.31.00.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 00:11:38 -0700 (PDT)
Message-ID: <d528b45c-123d-4ef7-b110-7efbfef91bc5@gmail.com>
Date:   Tue, 31 Oct 2023 09:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <20231028162025.4259f1cc@jic23-huawei>
 <84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com>
 <6a697c62-6a7c-4b31-bc8e-10f40db0363d@gmail.com>
In-Reply-To: <6a697c62-6a7c-4b31-bc8e-10f40db0363d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/23 12:21, Matti Vaittinen wrote:
> Hi dee Ho peeps,
> 
> On 10/29/23 17:51, Matti Vaittinen wrote:
>> On 10/28/23 18:20, Jonathan Cameron wrote:
>>> On Fri, 27 Oct 2023 18:15:45 +1030
>>> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
>>>
>>>> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor 
>>>> with als
>>>> and clear channels with i2c interface. Hardware interrupt 
>>>> configuration is
>>>> optional. It is a low power device with 20 bit resolution and has
>>>> configurable adaptive interrupt mode and interrupt persistence mode.
>>>> The device also features inbuilt hardware gain, multiple integration 
>>>> time
>>>> selection options and sampling frequency selection options.

...

>>>> +static int apds9306_scale_set(struct apds9306_data *data, int val, 
>>>> int val2)
>>>> +{
>>>> +    int i, ret, time_sel, gain_sel;
>>>> +
>>>> +    /* Rounding up the last digit by one, otherwise matching table 
>>>> fails! */
>>>
>>> Interesting.  Sounds like a question for Matti?
>>
>> Sounds odd indeed. I assume this happens when scale setting is 
>> requested using one of the exact values advertised by the available 
>> scales from the GTS? This does not feel right and the +1 does not ring 
>> a bell to me. I need to investigate what's going on. It would help if 
>> you could provide the values used as val and val2 for the setting.
>>
>> This will take a while from me though - I'll try to get to this next 
>> week. Thanks for pointing out the anomaly!
>>
> 
> I think I have a rough understanding. I did a Kunit test which goes 
> through all the available scales values from the 
> gts->avail_all_scales_table and all integration times, and feeds them to 
> the logic below. It seems the first culprit is hit by:
> val = 0, val2 = 125025502.
> 
> Problem is that the 125025502 is rounded. The exact linearized NANO 
> scale resulting from time multiplier 128, gain multiplier 1 is 
> 125025502.5 - which means we will see rounding.
> 
>>>
>>>> +    if (val2 % 10)
>>>> +        val2 += 1;
> 
> For a while I was unsure if this check works for all cases because I see 
> linearized scales:
> 250051005 - multipliers 1x, 64x
> 83350335 - multipliers 3x, 64x and 6x, 32x
> 27783445 - multipliers 9x, 64x.
> 
> For those we will get + 1 added to val2 even though there is no 
> rounding. It appears this is not a problem because the 
> iio_gts_get_gain() (which is used to figure out the required total gain 
> to get the desired scale) does not require the scale to be formed by 
> exact multiples of gain.

...

> I think it would be very nice if the gts-helpers could do the rounding 
> when computing the available scales, but that'd require some thinking. 
> Fixup patch is still very welcome ;)

I did some further experimenting. Basically, I did a "hack" which always 
rounds up the available-scales values if division results a remainder. 
This way the values advertised by the available_scales did find the 
matching table.

It is a tiny bit icky because for example the scale 6945861.25 becomes 
6945862 in available-scales. Also, I assume that if we "hack" just the 
available-scales and don't fix the rest of the logic, setting 6945862 
will read back as 6945861 (I haven't tested this though). Also, the 
20837583.75 will be 20837583 in available-scales but 20837582 when read 
back, resulting small error. (I haven't tested this either but I assume 
the current GTS code is flooring the 20837583.75 to 20837583.

I am wondering if changing the iio_gts_get_gain() to do rounding instead 
of flooring and changing also the iio_gts_total_gain_to_scale() to 
something like:

int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
				int *scale_int, int *scale_nano)
{
	u64 tmp;
	int rem;

	tmp = gts->max_scale;

	rem = do_div(tmp, total_gain);
	if (total_gain > 1 && rem >= total_gain / 2)
		tmp += 1ULL;

	return iio_gts_delinearize(tmp, NANO, scale_int, scale_nano);
}

would do the trick. It's just that I'm a bit afraid of touching the 
iio_gts_get_gain() - by the very least I need to fire up the GTS tests 
which I implemented but are not in-tree due to the test-device 
dependency... :/

Any thoughts?

>>>> +
>>>> +    ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
>>>> +                     data->intg_time_idx, val, val2, &gain_sel);
>>>> +    if (ret) {
>>>> +        for (i = 0; i < data->gts.num_itime; i++) {
>>>> +            time_sel = data->gts.itime_table[i].sel;
>>>> +
>>>> +            if (time_sel == data->intg_time_idx)
>>>> +                continue;
>>>> +
>>>> +            ret = 
>>>> iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
>>>> +                        time_sel, val, val2, &gain_sel);
>>>> +            if (!ret)
>>>> +                break;
>>>> +        }
>>>> +        if (ret)
>>>> +            return -EINVAL;
>>>> +
>>>> +        ret = apds9306_intg_time_set_hw(data, time_sel);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    }
>>>> +
>>>> +    return apds9306_gain_set_hw(data, gain_sel);
>>>> +}

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

