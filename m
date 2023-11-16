Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8615B7EDD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344949AbjKPIoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjKPIoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:44:19 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E7ADA;
        Thu, 16 Nov 2023 00:44:15 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so553268b3a.2;
        Thu, 16 Nov 2023 00:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700124255; x=1700729055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDTg5+JnBZc/hxwjodL5B5OhTMTZhVs8VN7Y0FOjLDo=;
        b=ktgyFnEz9NpZBVay9hA+7vwldvnKiY6cNnVMKbT2e8zLuqDQvxnuPDyK55x4W4Y4Z/
         iFPhmbQpOiXC/YUurCw3Cal4szqUH+zlkFdzfs6MWnh3z5Cf6HAZPpT52FTf7X6lztYV
         GP6RoRa8F4OFT+QYTNwPeLk2mw9ChQpJwUabo2jRCMDxfUJlNX12AG6U8ZG0cv/6XPWF
         Ymk4Oxb4Oqabd7Yr8Ep3vj8uCUxiIo/zsJhW+7AgmQkH4+QHOVi6XFERHgkreBY99sof
         6eU40BT0jQE8CDy0KCteaI3fQSd/+i8FeM3AOwVr7Z/zIryCKcFtUWaI0NJg6AUqRqoL
         Wr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700124255; x=1700729055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDTg5+JnBZc/hxwjodL5B5OhTMTZhVs8VN7Y0FOjLDo=;
        b=Q26SRCLxHXm8WRWMYtx6vlNwK8SV9Z/B4GFZwjShKFEVXs22P5CrHsXH3CQpYohevm
         gMAztdwBitDIbMIY2TMZLb4RpB2h2fU6toqlJizxHUMZ/Fdr248BFifVv/6dD0l2h9yj
         D/F3OMU9eko64ckKikXOuqEoc0NTADr33dYk/p1dP94+l/zVcbaUHbLAN56U7iQ2F2xB
         Huw3feyaMMtIKgGIzkLznR2uni2A4jdv6j1+QWnr9LNZOx3EtReSWHspj7jhoOj92QrN
         cvEL4sG4LgZqLbPI8JSqzeGmQ6ogztMvmjKme9kJwC6Z/IuNLrJdeMgpQPYkWG9M5YM/
         m+Gg==
X-Gm-Message-State: AOJu0YzxTnBFoVnN31pgdBOTvhKw5zyZBazjTTMQIFNkMaVLOu+mQVyf
        XkKwSrcyX/invcjaG3kNA8Y=
X-Google-Smtp-Source: AGHT+IGXgVyguBW1o7hbH4LvItXeUA9x3mWo6UDDL4OaC9i9qHGbfmg5gpM19XDq6I4qRu6/xrJpDg==
X-Received: by 2002:aa7:8d0d:0:b0:6bd:4ab7:5f69 with SMTP id j13-20020aa78d0d000000b006bd4ab75f69mr14533894pfe.12.1700124254912;
        Thu, 16 Nov 2023 00:44:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fn2-20020a056a002fc200b00689f5940061sm4156077pfb.17.2023.11.16.00.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 00:44:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Nov 2023 00:44:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xing Tong Wu <xingtong_wu@163.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingtong.wu@siemens.com,
        tobias.schaffner@siemens.com, gerd.haeussler.ext@siemens.com
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Fix logic error for PWM enable
Message-ID: <2691ceb6-b3d1-471c-b395-c08398a11b72@roeck-us.net>
References: <20231116022330.2696-1-xingtong_wu@163.com>
 <20231116022330.2696-3-xingtong_wu@163.com>
 <4616f6a2-f81d-47cb-9574-2319d04d3f34@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4616f6a2-f81d-47cb-9574-2319d04d3f34@roeck-us.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 12:07:06AM -0800, Guenter Roeck wrote:
> On Thu, Nov 16, 2023 at 10:23:29AM +0800, Xing Tong Wu wrote:
> > From: Xing Tong Wu <xingtong.wu@siemens.com>
> > 
> > The determination of the "pwm_enable" should be based solely on the mode,
> > regardless of the pwm value.
> > According to the specification, the default values for pwm and pwm_enable
> > are 255 and 0 respectively. However, there is a bug in the code where the
> > fan control is actually enabled, but the file "pwm_enable" incorrectly
> > displays "off", indicating that fan control is disabled. This contradiction
> > needs to be addressed and resolved.
> > Solution: Update the logic so that "pwm_enable" is determined by mode + 1,
> > remove the "off" value for "pwm_enable" since it is not specified in the
> > documentation.
> 
> The chip specification is irrelevant. What is relevant is the hwmon ABI,
> which says
> 
> What:           /sys/class/hwmon/hwmonX/pwmY_enable
> Description:
>                 Fan speed control method:
> 
>                 - 0: no fan speed control (i.e. fan at full speed)
> 		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                 - 1: manual fan speed control enabled (using `pwmY`)
>                 - 2+: automatic fan speed control enabled
> 
> which is what the code currently implements or at least tries to
> implement.
> 

As a follow-up, the existing code also handles setting _enable to 0
explicitly by selecting manual mode and setting the pwm value to the
maximum. This does not match the chip specification, but is the best
we can do to match ABI expectations.

That also means that we can not reject setting pwm values if
pwm control is disabled (off) since pwm==255 in manual mode
is equivalent to disabling pwm. Yes, that means that setting pwm
to 254 while pwm_enable==0 automatically enables manual mode,
but that can not be helped. We _could_ possibly combine setting
pwm_enable to manual mode with setting the pwm value to something
other than 255 if it is currently set to 25, but that would be
an optimization, not a bug fix.

Guenter

> Guenter
> 
> > 
> > Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
> > ---
> >  drivers/hwmon/nct6775-core.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
> > index 2111f0cd9787..575db6cb96e9 100644
> > --- a/drivers/hwmon/nct6775-core.c
> > +++ b/drivers/hwmon/nct6775-core.c
> > @@ -900,8 +900,6 @@ static const u16 NCT6116_REG_TSI_TEMP[] = { 0x59, 0x5b };
> >  
> >  static enum pwm_enable reg_to_pwm_enable(int pwm, int mode)
> >  {
> > -	if (mode == 0 && pwm == 255)
> > -		return off;
> >  	return mode + 1;
> >  }
> >  
> > -- 
> > 2.25.1
> > 
> 
