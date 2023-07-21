Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325C875D535
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGUTro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGUTrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:47:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F65C1BDC;
        Fri, 21 Jul 2023 12:47:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51f90f713b2so3243810a12.1;
        Fri, 21 Jul 2023 12:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689968860; x=1690573660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nA3Pns8mvIJQOTrEI1N3xKZhdVzhsIFRAg0Zm6mZSM=;
        b=N8SCnJOnjvjmxU76Ltt7k8YNUwhLghZcCQrPxOieBz+bJjCrowS/k6GUIk9i5vckHL
         PNpX9uNqv1KKXQLeA3Gm3P8uGe/Ho9ZNDtIx48a2YqAomt43SK+Kj2cJBu7JbyDrnbv6
         OC3OlO2+OFjukhLphMyacobkfKgWxVEGbqojOTZLcYX7QhaEBx9KGMvLhdUoxL3Kxlqw
         p584g2ILGHeuDL1r5cNALFbGPFLVPgwXweXGYi1SxQBw1lzTI9KjzVHbc4BHr+YJe+8G
         hNDZVPmDjLiYjypw8jZsoXj3f+8+y0iZoqcVgEO1ASLP1vkzxKSonFbTLeJaPgXi1jhX
         ZG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689968860; x=1690573660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nA3Pns8mvIJQOTrEI1N3xKZhdVzhsIFRAg0Zm6mZSM=;
        b=gIjMImFd41fmwZKm+Z/smLuPLMaIzYmDcPc6xUXcDGWDeDph4U4GBWdhWqDEtH3eov
         v676mAdleNsBWMOSkhC/BKBgHa6DWQLWMtKEaMe7LNfO18C9NfYMPzmGsiiqqDpzDcYC
         WFmC2M82EV1plw442fqDQlZHZaOlT6mLTtlC1F78gK0Su0D9LOVyr2mVSZBYHi5ykNfH
         d4hrzujukPe63bjMzrn/nL3H+KRQ32owQyIq76ZZGBTkCUot2m30+tXDoxFvv3ZajNUA
         q7m8r3GlU0TtIRgqiMDVy1j1hbKhSQD+h/4TrmzIq0FnhuWzuY4lkuYnAPXyTbJQQ2Qk
         3JIA==
X-Gm-Message-State: ABy/qLaqdB7z2mbC2hMtvygHjQC/bxKL83Y7OepS07M2M8yqTvlB8Qwn
        ea86UY4VC7vhbdyZ5miCJ3GRwvh2iXwdeQ==
X-Google-Smtp-Source: APBJJlFz32aitBdnhrdrDgNC9LNUWcu+Rg8GdwkCwRPHf1TAxFkUiSvcfrGmnPHG4CTfca4CdWsbnA==
X-Received: by 2002:aa7:c70b:0:b0:51e:28eb:30c6 with SMTP id i11-20020aa7c70b000000b0051e28eb30c6mr2479096edq.34.1689968859417;
        Fri, 21 Jul 2023 12:47:39 -0700 (PDT)
Received: from [192.168.4.4] (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id r19-20020aa7cfd3000000b0051de018af1esm2474654edy.59.2023.07.21.12.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 12:47:39 -0700 (PDT)
Message-ID: <a95bdc44-68e6-8d31-0c8a-24b83fb4c613@gmail.com>
Date:   Fri, 21 Jul 2023 21:47:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/2] iio: add MCP4728 I2C DAC driver
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1689857295.git.andrea.collamati@gmail.com>
 <3d08130fcb093fea3f755848690db9b2c8e1cb75.1689857295.git.andrea.collamati@gmail.com>
 <20230720201311.0142db3d@jic23-huawei>
From:   Andrea Collamati <andrea.collamati@gmail.com>
In-Reply-To: <20230720201311.0142db3d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

thank you for your first review.

See below.

On 7/20/23 21:13, Jonathan Cameron wrote:

>> +
>> +	outbuf[1] = ch->ref_mode << MCP4728_CMD_VREF_POS;
>> +
>> +	if (data->powerdown) {
>> +		u8 mcp4728_pd_mode = ch->pd_mode + 1;
>> +
>> +		outbuf[1] |= mcp4728_pd_mode << MCP4728_CMD_PDMODE_POS;
>> +	}
>> +
>> +	outbuf[1] |= ch->g_mode << MCP4728_CMD_GAIN_POS;
> FIELD_PREP()
>
>> +	outbuf[1] |= ch->dac_value >> 8;
>> +	outbuf[2] = ch->dac_value & 0xff;
> put_unaligned_be16()
>
outbuf[1] contains other data (gain mode, powerdown  mode, etc) in addition to dac value. Using put_unaligned_be16 will probably reset them.

Something like this could be the solution?

#defineMCP4728_DAC_H_FIELD GENMASK(3, 0)

#defineMCP4728_DAC_L_FIELD GENMASK(7, 0)

...

outbuf[1] |= FIELD_PREP(MCP4728_DAC_H_FIELD, ch->dac_value>> 8);

outbuf[2] = FIELD_PREP(MCP4728_DAC_L_FIELD, ch->dac_value);


>> +		return 0;
>> +}
>> +
>> +// powerdown mode
>> +static const char *const mcp4728_powerdown_modes[] = { "1kohm_to_gnd",
>> +						       "100kohm_to_gnd",
>> +						       "500kohm_to_gnd" };
>> +
>> +static int mcp4728_get_powerdown_mode(struct iio_dev *indio_dev,
>> +				      const struct iio_chan_spec *chan)
>> +{
>> +	struct mcp4728_data *data = iio_priv(indio_dev);
>> +
>> +	return data->channel_data[chan->channel].pd_mode;
>> +}
>> +
>> +static int mcp4728_set_powerdown_mode(struct iio_dev *indio_dev,
>> +				      const struct iio_chan_spec *chan,
>> +				      unsigned int mode)
>> +{
>> +	struct mcp4728_data *data = iio_priv(indio_dev);
>> +
>> +	data->channel_data[chan->channel].pd_mode = mode;
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t mcp4728_read_powerdown(struct iio_dev *indio_dev,
>> +				      uintptr_t private,
>> +				      const struct iio_chan_spec *chan,
>> +				      char *buf)
>> +{
>> +	struct mcp4728_data *data = iio_priv(indio_dev);
>> +
>> +	return sysfs_emit(buf, "%d\n", data->powerdown);
>> +}
>> +
>> +static ssize_t mcp4728_write_powerdown(struct iio_dev *indio_dev,
>> +				       uintptr_t private,
>> +				       const struct iio_chan_spec *chan,
>> +				       const char *buf, size_t len)
>> +{
>> +	struct mcp4728_data *data = iio_priv(indio_dev);
>> +	bool state;
>> +	int ret;
>> +
>> +	ret = kstrtobool(buf, &state);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (state)
>> +		ret = mcp4728_suspend(&data->client->dev);
>> +	else
>> +		ret = mcp4728_resume(&data->client->dev);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return len;
> Don't support custom powering down. If this is needed it should be
> using the existing power management flows.

Could you explain better? I have extended customized powering down because I took as reference  the driver mcp4725.c and  I extended to multichannel.

How should I change it?

> Might have been more interesting if it were per channel, but it's not.
> (and I have no idea off the top of my head on how we would deal with it
> if it were per channel).

MCP4728 can handle power down per channel...

There are two bits per each channel the could be

00 => No Power Down

01 => 1kohm_to_gnd

10 => 100kohm_to_gnd

11 => 500kohm_to_gnd

>
>> +				mcp4728_resume);
>> +
>> +static int mcp4728_init_channels_data(struct mcp4728_data *data)
>> +{
>> +	u8 inbuf[MCP4728_READ_RESPONSE_LEN];
>> +	int ret;
>> +	unsigned int i;
>> +
>> +	ret = i2c_master_recv(data->client, inbuf, MCP4728_READ_RESPONSE_LEN);
>> +	if (ret < 0) {
>> +		dev_err(&data->client->dev,
>> +			"failed to read mcp4728 conf. Err=%d\n", ret);
>> +		return ret;
>> +	} else if (ret != MCP4728_READ_RESPONSE_LEN) {
>> +		dev_err(&data->client->dev,
>> +			"failed to read mcp4728 conf. Wrong Response Len ret=%d\n",
>> +			ret);
>> +		return -EIO;
>> +	}
>> +
>> +	for (i = 0; i < MCP4728_N_CHANNELS; i++) {
> Unusual to read back existing values from the device rather than resetting it into a clean
> state. What is your reasoning?

MCP4728 has an EEPROM memory.

Under the reset conditions, the device uploads the
EEPROM data into both of the DAC input and output
registers simultaneously.

My reasoning was that the driver syncs with device at probe time and let the user change each channel parameters via iio_chan_spec_ext_info.


Thank you again.

        Andrea


