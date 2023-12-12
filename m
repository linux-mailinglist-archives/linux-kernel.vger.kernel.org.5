Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFE180ED42
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjLLNUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjLLM0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:26:10 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E8ED0;
        Tue, 12 Dec 2023 04:26:16 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50c02628291so5895860e87.0;
        Tue, 12 Dec 2023 04:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702383975; x=1702988775; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=jDXYMaw1sbntLAVDHeEmPBhzTFML5db/VpzOyY7cHic=;
        b=AaoCNquIixiVz/sNvhnKBOvmdT69RI3CDVjSimb7j8OKAdNU5ydkk/0ergVkjGuSNy
         Bt1nsaN6q7glhbq+m5Ukgbs/fxBDiB1EZUPrVyReFdulpG/zzI9uZhroAHOEfv6Zcd/f
         dm50uiVqdAQrdqFNFu8svE382SlFKKFS5zuQGQSk2hIN/BZX3XnkFw2cRSYkrVMKLfuc
         KfmxCIX9Rc4XTZsZkQ45Mcvfr/sbgNSYsa89TETlcOqK6YbVd25kpTUnmQ2DmKLMSHer
         LsPJjExl0VBpZWALtNT5W24WjYII17KSrU5QF7tKWHgqs0gsq/2wkiSPK67s7Id2Ykk7
         VuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702383975; x=1702988775;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDXYMaw1sbntLAVDHeEmPBhzTFML5db/VpzOyY7cHic=;
        b=qNZ+buYnjSKgp6EKdSODG09uvKuYw4tl4WlSX++ZeEfFX2MNH2rlOUMZ6TsEYAH6sk
         sDB0tnpVB8XPk/mBlV5ZYL6Gr+1k7f/ykKZmIp9wykPgmXVdcWVXbJc+MdlQJ/9aPGAA
         e/Vel6Tc3spUnLW2yrhivtmOX5cvdkIktYKNOJ9E84AC1jT0Plp3Q6eSwTituHfFB6q2
         rx/AZi2sNJc3Rm0IDaK8k415MJZ1RVKPo3aAPWbEQqNJ6GgaSNvhAoRSQyMtrdN0M2n6
         VRLS0mwtxd3GNfY0OzEEeLVz+kV2OV85XAPGv68Tljj0m7FEo6CzyNFWJ9Bdnviu8DYt
         8N6Q==
X-Gm-Message-State: AOJu0Yz7ldfXSgE8VsQosgpFFD3Ra/D9EhMzdVxmkj4cbOI8r4mVfIcz
        yGbluxSblxm/KReuwr0Gin8=
X-Google-Smtp-Source: AGHT+IG+wKzm5+bzSB/GcsQVOOmtuyN5ujoI9rs9Fi0kUEnxctzEKSBCI1fsFkUHAXH2ku79m60ahw==
X-Received: by 2002:ac2:5466:0:b0:50b:eedd:edc6 with SMTP id e6-20020ac25466000000b0050beeddedc6mr2897740lfn.42.1702383974760;
        Tue, 12 Dec 2023 04:26:14 -0800 (PST)
Received: from razdolb (95-24-149-38.broadband.corbina.ru. [95.24.149.38])
        by smtp.gmail.com with ESMTPSA id t17-20020a056512069100b0050bf1e8950esm1333018lfe.10.2023.12.12.04.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:26:14 -0800 (PST)
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
 <20231211175023.1680247-6-mike.rudenko@gmail.com>
 <20231211181106.GD27535@pendragon.ideasonboard.com>
User-agent: mu4e 1.10.7; emacs 29.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 05/19] media: i2c: ov4689: Refactor ov4689_set_ctrl
Date:   Tue, 12 Dec 2023 15:25:27 +0300
In-reply-to: <20231211181106.GD27535@pendragon.ideasonboard.com>
Message-ID: <87y1dzppy2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-12-11 at 20:11 +02, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Mikhail,
>
> Thank you for the patch.
>
> On Mon, Dec 11, 2023 at 08:50:08PM +0300, Mikhail Rudenko wrote:
>> Introduces local variables for regmap and the control value within the
>> ov4689_set_ctrl function. This adjustment eliminates repetition within
>> the function.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index 8c120d7f7830..42700ecfbe0e 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -584,7 +584,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>  {
>>  	struct ov4689 *ov4689 =
>>  		container_of(ctrl->handler, struct ov4689, ctrl_handler);
>> +	struct regmap *regmap = ov4689->regmap;
>>  	struct device *dev = ov4689->dev;
>> +	s32 val = ctrl->val;
>
> For ctrl->val, I think the code is clearer without this change. When
> reading the function, seeing "val", I need to look up what it is, while
> seeing "ctrl->val" gives me more context and makes (in my opinion) the
> code more readable.

Agreed, will revert to ctrl->val in v2.

>>  	int sensor_gain;
>>  	s64 max_expo;
>>  	int ret;
>> @@ -593,7 +595,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>  	switch (ctrl->id) {
>>  	case V4L2_CID_VBLANK:
>>  		/* Update max exposure while meeting expected vblanking */
>> -		max_expo = ov4689->cur_mode->height + ctrl->val - 4;
>> +		max_expo = ov4689->cur_mode->height + val - 4;
>>  		__v4l2_ctrl_modify_range(ov4689->exposure,
>>  					 ov4689->exposure->minimum, max_expo,
>>  					 ov4689->exposure->step,
>> @@ -607,36 +609,34 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>  	switch (ctrl->id) {
>>  	case V4L2_CID_EXPOSURE:
>>  		/* 4 least significant bits of exposure are fractional part */
>> -		ret = cci_write(ov4689->regmap, OV4689_REG_EXPOSURE,
>> -				ctrl->val << 4, NULL);
>> +		cci_write(regmap, OV4689_REG_EXPOSURE, val << 4, &ret);
>>  		break;
>>  	case V4L2_CID_ANALOGUE_GAIN:
>> -		ret = ov4689_map_gain(ov4689, ctrl->val, &sensor_gain);
>> +		ret = ov4689_map_gain(ov4689, val, &sensor_gain);
>>
>> -		cci_write(ov4689->regmap, OV4689_REG_GAIN_H,
>> +		cci_write(regmap, OV4689_REG_GAIN_H,
>>  			  (sensor_gain >> OV4689_GAIN_H_SHIFT) &
>>  			  OV4689_GAIN_H_MASK, &ret);
>>
>> -		cci_write(ov4689->regmap, OV4689_REG_GAIN_L,
>> +		cci_write(regmap, OV4689_REG_GAIN_L,
>>  			  sensor_gain & OV4689_GAIN_L_MASK,
>>  			  &ret);
>>  		break;
>>  	case V4L2_CID_VBLANK:
>> -		ret = cci_write(ov4689->regmap, OV4689_REG_VTS,
>> -				ctrl->val + ov4689->cur_mode->height, NULL);
>> +		cci_write(regmap, OV4689_REG_VTS,
>> +			  val + ov4689->cur_mode->height, &ret);
>>  		break;
>>  	case V4L2_CID_TEST_PATTERN:
>> -		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
>> +		ret = ov4689_enable_test_pattern(ov4689, val);
>>  		break;
>>  	default:
>>  		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
>> -			 __func__, ctrl->id, ctrl->val);
>> +			 __func__, ctrl->id, val);
>>  		ret = -EINVAL;
>>  		break;
>>  	}
>>
>>  	pm_runtime_put(dev);
>> -
>>  	return ret;
>>  }
>>
>> --
>> 2.43.0
>>


--
Best regards,
Mikhail Rudenko
