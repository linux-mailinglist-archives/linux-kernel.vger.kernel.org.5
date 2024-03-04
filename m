Return-Path: <linux-kernel+bounces-91221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7468870B64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157421C22208
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA717A736;
	Mon,  4 Mar 2024 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="darkKDg7"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12A82E636;
	Mon,  4 Mar 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583548; cv=none; b=HoUqS3WZIH/IlVKQEPuJbqU3/TDDtFlTVi6Z4KpmK74qmnNmOPM5znjFl7DT925uUDyXWHjVutwUy5Cju8vOQF0id+YSdtk38S3/5I/ibb3r1HJhp2L8hOHwl8wd4gsLIj2Nga+x2KwXgAb2unuOLf7OPZrKGw3WURw/1GpMVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583548; c=relaxed/simple;
	bh=M+/xdlz1QvqpEWGoIZLkPz4ZJeD4ax74ffb0kjZ9s/Q=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=S5sGFpBch7piDrM9SfCW3E0VFRPrUTk19xE70/1r/9eRlipveJRfWd5N5Wf4Mbt6JDbVhBBnWuPMwog2ojSfVoByYja4wtse20oWpskC+Wz9Ps9C9Ml/GZ/4HKM4oq/fW1OVO4EVSGSTOxsOq5/R8H79UOR4DpauCuO9JzhJ1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=darkKDg7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51336ab1fb7so3251246e87.1;
        Mon, 04 Mar 2024 12:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709583545; x=1710188345; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=6pv+kY8whLJz4MmGOfFA47yW+Q8l6/NhyCVwVLlKeGI=;
        b=darkKDg7/IObHgJbP8vwHKvXgeaIPh3i4iI4o4sSHD5dib1kgKW8B3e+Qk46LSoVJ5
         RulbDzdMGYi3N3SNbe5hvzd05phaHWtrxO3z5t/deZW1Z/S/JEj+d+UHHpxct+jipUWG
         CB4Pc0y3q+QoYR8xMQsY1ELwADznppkrMQrgE7Nmo6zTjXODWEK0BMQXAl7Op4NjU4jB
         01eFuTGprYWWF24T/SLji0Omt8N2QptaDJ09qc51iH98bx4f5eaP1Plwtn11eZ6Uh/5k
         pzRgB+UHHqjwJQ9B7CIAQ3B9X0D6PBkunIZC67/ju6mfR+NReCRDQhx+T/u7N9SzZYI1
         wIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583545; x=1710188345;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pv+kY8whLJz4MmGOfFA47yW+Q8l6/NhyCVwVLlKeGI=;
        b=FZ6UkSj+kDZH040+JvN35h65VmCkMS/XTOJ/qdbehSPDp+e6qkDVfAN0YnuygJieIK
         oKZi5No+WOtkC+91A703d6UNeCYFcY72n+u2G3mponFFeA7S7fr58dbGqC5PhtkH1rZq
         BqNQaOsPmXlq0KyygdfZhhmVNYN+nweXANAkH1J1+shQo0ARyPpzw/BnKpquzOYj/pAQ
         ijuR3o6oizEH8Bmkk31k83PiCRYqM9N94JgB+wlAF6TrpWBa/060jl4c4lWOhYMVE9eB
         JquCFpwlv/zDNk4l4g+3NNNjr1DMO1h0fLd0wjM+T38e0SHV/DNzxwovWbuQCfVyMEKz
         Qe1w==
X-Forwarded-Encrypted: i=1; AJvYcCXRmu+P1YZljd4wDQAtZ0A/JVVTxoojhAwrl4nsrW+5VloqqPtrroVdtjg3e+9ZBTn3se9Ar4gv7WArjP2WIWp4wG+uChvzXBMf2lY=
X-Gm-Message-State: AOJu0Yz5PqSPbhjQHWxswjhXeffMtJ0n/pIi3vsZXW5BoPqUBj0VJyRw
	VamMw1UCnQyhN9jHNwWTiUzbcvMPOx8y0ySebnIrDqW9D0qgLXaZ
X-Google-Smtp-Source: AGHT+IGsTnaWlja6vmBn9D40KwtWWwwyFRSUL8wYXJjqhn5b3Kql6hYAYTxHXCaCeXVGsnLuR6EOpw==
X-Received: by 2002:ac2:599b:0:b0:512:f6d3:9998 with SMTP id w27-20020ac2599b000000b00512f6d39998mr6359192lfn.17.1709583544520;
        Mon, 04 Mar 2024 12:19:04 -0800 (PST)
Received: from razdolb ([89.208.103.172])
        by smtp.gmail.com with ESMTPSA id h5-20020a056512350500b00513342ba90csm1351993lfs.22.2024.03.04.12.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:19:04 -0800 (PST)
References: <20240229165333.227484-1-mike.rudenko@gmail.com>
 <20240229165333.227484-7-mike.rudenko@gmail.com>
 <170957098683.566498.5256791258269936446@ping.linuxembedded.co.uk>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>,
 Tommaso Merciai <tomm.merciai@gmail.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v3 06/20] media: i2c: ov4689: Refactor ov4689_set_ctrl
Date: Mon, 04 Mar 2024 23:17:34 +0300
In-reply-to: <170957098683.566498.5256791258269936446@ping.linuxembedded.co.uk>
Message-ID: <875xy1hhsc.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Kieran,

On 2024-03-04 at 16:49 GMT, Kieran Bingham <kieran.bingham@ideasonboard.com> wrote:

> Hi Mikhail,
>
> I love this series. ;-)

Thanks! :)

> Quoting Mikhail Rudenko (2024-02-29 16:53:19)
>> Introduce local variable for regmap within the ov4689_set_ctrl
>> function. This adjustment eliminates repetition within the function.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>
> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>
>> ---
>>  drivers/media/i2c/ov4689.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index 56bf1d964e43..1bc00404f3fb 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -580,10 +580,11 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>  {
>>         struct ov4689 *ov4689 =
>>                 container_of(ctrl->handler, struct ov4689, ctrl_handler);
>> +       struct regmap *regmap = ov4689->regmap;
>>         struct device *dev = ov4689->dev;
>>         int sensor_gain;
>>         s64 max_expo;
>> -       int ret;
>> +       int ret = 0;
>>
>>         /* Propagate change of current control to all related controls */
>>         switch (ctrl->id) {
>> @@ -603,16 +604,15 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>         switch (ctrl->id) {
>>         case V4L2_CID_EXPOSURE:
>>                 /* 4 least significant bits of exposure are fractional part */
>> -               ret = cci_write(ov4689->regmap, OV4689_REG_EXPOSURE,
>> -                               ctrl->val << 4, NULL);
>> +               cci_write(regmap, OV4689_REG_EXPOSURE, ctrl->val << 4, &ret);
>>                 break;
>>         case V4L2_CID_ANALOGUE_GAIN:
>>                 ret = ov4689_map_gain(ov4689, ctrl->val, &sensor_gain);
>> -               cci_write(ov4689->regmap, OV4689_REG_GAIN, sensor_gain, &ret);
>> +               cci_write(regmap, OV4689_REG_GAIN, sensor_gain, &ret);
>>                 break;
>>         case V4L2_CID_VBLANK:
>> -               ret = cci_write(ov4689->regmap, OV4689_REG_VTS,
>> -                               ctrl->val + ov4689->cur_mode->height, NULL);
>> +               cci_write(regmap, OV4689_REG_VTS,
>> +                         ctrl->val + ov4689->cur_mode->height, &ret);
>>                 break;
>>         case V4L2_CID_TEST_PATTERN:
>>                 ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
>> --
>> 2.43.0
>>


--
Best regards,
Mikhail Rudenko

