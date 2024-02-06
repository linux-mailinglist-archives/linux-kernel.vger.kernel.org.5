Return-Path: <linux-kernel+bounces-54291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A932A84AD5B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6024928570C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0EB768E9;
	Tue,  6 Feb 2024 04:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjmVBov9"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381B74E06;
	Tue,  6 Feb 2024 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192998; cv=none; b=XvrylBWFfQajwLnSEwRJN/9UzQqpikSnpiyiJuwtUWOAuQCRyoiVLHJT+NkpafixZcKzjBfYrcy9kfVR4Qm+D5jnMkdMpO1LwmluUHvqOHTCBOsrLePJG8NzSN2q+Kjgg2B0bJLM1sAzisrmp1QEYlHyxH1BkX91+w5cMA8EeY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192998; c=relaxed/simple;
	bh=od3mQFAuJO/2MVEighjBGkYYX6HuvW6cjcvOk3GB1nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwp2pNvmwvxmABMFfTJgbqAHp+RZvnRt6rSHt6YSBPEqBlzaOFJoEG1FjZeXpcP9jRHgWX7bakmCD9/LE64kk7KC7voM7fIhAcYvBi7yLit7KyeKHcCuvhEkvzPS6YmHoLcPomDzAiy22MVXBVa91VlVcnpboK7RA/bgr4h7sFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjmVBov9; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf5917f049so60550461fa.2;
        Mon, 05 Feb 2024 20:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707192995; x=1707797795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k/k/Q/dPHVVGDvexiB+hS+6K0XEQOLpNCbXwWIX1VfY=;
        b=bjmVBov9fVDf75sXUrYcQKf0UyBSPcv5LKcoP/83JIakW7bc7EXV4M4e1qUcoVK6/f
         e2tqIKwW60vUv7MBWYYk8oin+yVHHUzrEoydm5Ss9c59r1KO9VrIuXGyD8Db23rIHXeq
         Orlz0JGmv7bluvrL5LIxL7BX7UPQHKEANddsljs2PhOvDGuuBIJgL0H23lj3JFi+e1vy
         bjeUfvrhb6MkR3TKGwqGR2uPgbyMxpbAQ9/FzjfE7pz0DjJQgLbkFHGW9kqStjNpa/38
         CH88bBHMU9QZ/WGa6yTsey0iBP1daJU91RTYLO/3H070L6ruCAihzaCAiPY0JFcsekfF
         Nqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707192995; x=1707797795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/k/Q/dPHVVGDvexiB+hS+6K0XEQOLpNCbXwWIX1VfY=;
        b=L3TPKW5ikZnEG70u4QjfUOCJW4xMT7Zzu4MTcUKSBYCoTtiAQBUl27LztgQytPQ1g1
         bzNVZKmBHxK+YAm1VPqk++eN7oPHaF6fwZZFDCjSMNlFaPB9SvgaCQNGdrvpNLMw0FUj
         lD2nuEryB7L3rH7Fpluwmz/mwTeNweDBj+rrCyvsF7EvLe8WvZx88pbbdTrEe1bxs1/U
         Sn0s84xrjHfkokFsHRygJLKqJVN5R0IqqquZRcbJdL3UOrNYIBaeWEfjvPqqEeZ8VuTB
         twYH0QDf2c2WCMsUuTkW8Etu1L8N7w7y45SkUhy6+api2G7cC2EznPitnslR9k9o8DYD
         i0yg==
X-Gm-Message-State: AOJu0YxLdT+2RdPC7q6e/hhki0rtLahZFBoWpkEMDVQt0vGriyhnnwjV
	geOJwylCu9u7titL9W5KcQhbxf4ev6RnOjEVRjiVCLjpiE5jZfJDSfjLGlSb066tpIHsJ4fSGmU
	cTWAm0tYnztKXrIBHlLniqC6FLAA=
X-Google-Smtp-Source: AGHT+IHPBusPewGXiD+vI/fL3BYTjXz/v4f6lkYZjQ3d8ktq42j9FXOCIsTuOvfMim6qFKzvpdOmwI1rnpKJYaORPt0=
X-Received: by 2002:a2e:b88b:0:b0:2d0:b73d:e0c5 with SMTP id
 r11-20020a2eb88b000000b002d0b73de0c5mr910922ljp.47.1707192994648; Mon, 05 Feb
 2024 20:16:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205152013.3833940-1-chou.cosmo@gmail.com>
 <20240205152013.3833940-2-chou.cosmo@gmail.com> <4a504043-e24d-4119-8c5d-107f0d371110@roeck-us.net>
 <CAOeEDysSZEeKt==zyexLE1GhE5ZpeDHS7sDLRfcC=4JgiogLKQ@mail.gmail.com>
 <a05ec2fe-cfe4-48d8-bff4-9f3689c585d3@roeck-us.net> <CAOeEDyscobVHaAe+72P2wEiucgWUDX=2H2W5dq0P1q8RB=7tzg@mail.gmail.com>
 <cfc51210-4ef1-4df4-bb57-499316fb18fd@roeck-us.net>
In-Reply-To: <cfc51210-4ef1-4df4-bb57-499316fb18fd@roeck-us.net>
From: Cosmo Chou <chou.cosmo@gmail.com>
Date: Tue, 6 Feb 2024 12:16:23 +0800
Message-ID: <CAOeEDyvFP1JUAxABc6kx52EX1Q6POTD1EqddYan7pRVVnh_xFw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] hwmon: Add driver for Astera Labs PT5161L retimer
To: Guenter Roeck <linux@roeck-us.net>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jdelvare@suse.com, corbet@lwn.net, broonie@kernel.org, 
	naresh.solanki@9elements.com, vincent@vtremblay.dev, 
	patrick.rudolph@9elements.com, luca.ceresoli@bootlin.com, bhelgaas@google.com, 
	festevam@denx.de, alexander.stein@ew.tq-group.com, heiko@sntech.de, 
	jernej.skrabec@gmail.com, macromorgan@hotmail.com, forbidden405@foxmail.com, 
	sre@kernel.org, linus.walleij@linaro.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, cosmo.chou@quantatw.com
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 06, 2024 at 12:02 PM +0800, Guenter Roeck wrote:
>
> On 2/5/24 19:53, Cosmo Chou wrote:
> > On Tue, Feb 06, 2024 at 11:26 AM +0800, Guenter Roeck wrote:
> >>
> >> On 2/5/24 19:05, Cosmo Chou wrote:
> >>> On Tue, Feb 06, 2024 at 3:43 AM +0800, Guenter Roeck wrote:
> >>>>
> >>>> On Mon, Feb 05, 2024 at 11:20:13PM +0800, Cosmo Chou wrote:
> >>>>> This driver implements support for temperature monitoring of Astera Labs
> >>>>> PT5161L series PCIe retimer chips.
> >>>>>
> >>>>> This driver implementation originates from the CSDK available at
> >>>>> Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
> >>>>> The communication protocol utilized is based on the I2C/SMBus standard.
> >>>>>
> >>>>> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> >>>>> ---
> >>>> [ ... ]
> >>>>
> >>>>> +static ssize_t pt5161l_debugfs_read_fw_ver(struct file *file, char __user *buf,
> >>>>> +                                        size_t count, loff_t *ppos)
> >>>>> +{
> >>>>> +     struct pt5161l_data *data = file->private_data;
> >>>>> +     int ret;
> >>>>> +     char ver[32];
> >>>>> +
> >>>>> +     mutex_lock(&data->lock);
> >>>>> +     ret = pt5161l_fwsts_check(data);
> >>>>> +     mutex_unlock(&data->lock);
> >>>>> +     if (ret)
> >>>>> +             return ret;
> >>>>> +
> >>>>> +     ret = snprintf(ver, sizeof(ver), "%u.%u.%u\n", data->fw_ver.major,
> >>>>> +                    data->fw_ver.minor, data->fw_ver.build);
> >>>>> +     if (ret < 0)
> >>>>> +             return ret;
> >>>>> +
> >>>>
> >>>> You almost got me here ;-). snprintf() never returns a negative error code,
> >>>> so checking for it is not necessary.
> >>>>
> >>> Oh! You're right.
> >>>
> >>>>> +     return simple_read_from_buffer(buf, count, ppos, ver, ret + 1);
> >>>>
> >>>> Number of bytes written plus 1 ? Why ?
> >>> It's just to include the string terminator '\0'.
> >>>
> >>
> >> If that was needed, it would be risky. snprintf() truncates the output
> >> if the buffer is not large enough. You might want to consider using
> >> scnprintf() instead. But then I am not sure if that is needed in the first
> >> place. Almost all code I checked doesn't do that, and it seems to be likely
> >> that the few drivers who do that are simply wrong. Can you explain why the
> >> string terminator needs to be added to the output ?
> >>
> >> Thanks,
> >> Guenter
> >>
> > It's just in case someone reads and prints this, but with a dirty
> > buffer and doesn't handle the terminator.
>
> That needs a better reason. It is not conceivable that 99% of drivers
> don't do this but this one would need it for some reason. I am not going
> to accept this unless you can show that debugfs files are supposed to
> include a terminating '\0' in the response. This is like claiming that
> printf() should include a terminating '\0' in the output just in case
> the output is read by a broken application which needs to see the
> terminator.
>
> Guenter
>
Agree. Users should handle this by themselves. I'll revise it to align
the behavior.

Thanks
Cosmo

