Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D237A8689
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjITO3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjITO3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:29:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091FAAF;
        Wed, 20 Sep 2023 07:29:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40475103519so66396225e9.0;
        Wed, 20 Sep 2023 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695220178; x=1695824978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbEDq7up+2av+UowrxSaLUVDq8oiBtv48vtfULYOFCc=;
        b=fcbfos+K01Yaw+4vgMVUWIFqT6WAvtWjjhcnVr0eTl7pIhslK33Nprx+9aLYSEpaO4
         0/jL49nAOAL3vwyVYCzFnpi7Et45dbM5tYZtElZwdGisvoUF3u7gXBSYWDspoolAqO31
         1TT5NRzC5yI1hD9JNKLszo/zxPO7gfng3Oj2ZhvcAFqMRWUJfmF2APiENfw+rC/RvtgI
         /56EWpnoZfNDID7dUQuzusmCKv4+g1hUxJKxMWdwBhD3pdx1w7bz35/oiXRKS7rqWCMn
         PyhplPBMcpUlzPRYNjm3cRfLplDWBGwRjF7ouT3oGDgPPtua50ODfkRDEEMImWgCFRdG
         uMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695220178; x=1695824978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbEDq7up+2av+UowrxSaLUVDq8oiBtv48vtfULYOFCc=;
        b=HV6k0rO8jQQRy6dggkSPfIpXXLlw0ze/+Cg3r19EMqbh6ofb1yA9sOEZMJFDF5Hqja
         vUSmtWu8PrY0nYcglwwKQyvqVNaLmQFT8rmjg3/GUyUzU+yUbPr8oa+TnX5csCS9sxYz
         a5mLjys+kVzhYTSo1lHjZQ9WAOfvJL6ytmzdvr4WyCNtTt1k2CQ+z3CcUWdE2JjwNji+
         HHleVdK2OoH/fbILd/cNz3lCLLtTh2zl0duwexYZTuigcJu9OicbSBu5sPn/hW2ZvRXv
         0w2pbpIzOAvN1yVy6V+K4s+BuBiFKDwS1T+YSwiotQy6rSiLxl7kLXKeYRWdDuFP759D
         pvDg==
X-Gm-Message-State: AOJu0YzOP7kXRt9oqJt8ZOtQ7QDdDzdNpPoMKV7CX6aAVU6OCgzpxLMK
        b/tgolhMtIwiLkXDBtuPWbY=
X-Google-Smtp-Source: AGHT+IHFnj3OMWSAXxv8HTF+t0ucfprw6Yty9B4mSM036wvuJLVMh4HapMjxkWqeP5T3FJHwb0t3AA==
X-Received: by 2002:a7b:cb86:0:b0:402:f07c:4b48 with SMTP id m6-20020a7bcb86000000b00402f07c4b48mr2266845wmi.28.1695220177989;
        Wed, 20 Sep 2023 07:29:37 -0700 (PDT)
Received: from primary ([212.34.23.120])
        by smtp.gmail.com with ESMTPSA id f11-20020adff58b000000b003180027d67asm18670891wro.19.2023.09.20.07.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:29:37 -0700 (PDT)
Date:   Wed, 20 Sep 2023 10:29:34 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com, ryanmacdonald@geotab.com
Subject: Re: [PATCH v5 02/15] USB: typec: Add cmd timeout and response delay
Message-ID: <ZQsBzl2LBj0SQAqt@primary>
References: <20230917152639.21443-1-alkuor@gmail.com>
 <20230917152639.21443-3-alkuor@gmail.com>
 <ZQgqII6+wplL8AjG@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQgqII6+wplL8AjG@kuha.fi.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:44:48PM +0300, Heikki Krogerus wrote:
> On Sun, Sep 17, 2023 at 11:26:26AM -0400, Abdel Alkuor wrote:
> > Some commands in tps25750 take longer than 1 second
> > to complete, and some responses need some delay before
> > the result becomes available.
> > 
> > Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> > ---
> >  drivers/usb/typec/tipd/core.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> > index 37b56ce75f39..a8aee4e1aeba 100644
> > --- a/drivers/usb/typec/tipd/core.c
> > +++ b/drivers/usb/typec/tipd/core.c
> > @@ -284,7 +284,8 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
> >  
> >  static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
> >  			     size_t in_len, u8 *in_data,
> > -			     size_t out_len, u8 *out_data)
> > +			     size_t out_len, u8 *out_data,
> > +			     u32 cmd_timeout_ms, u32 res_delay_ms)
> 
> It looks like 1s/0s is still the "default", so you could have just
> made this old function a wrapper:
> 
> static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
> 			     size_t in_len, u8 *in_data,
> 			     size_t out_len, u8 *out_data)
> {
>         return tps6598x_exec_cmd_tmo(tps, cmd, in_len, in_data, out_len, out_data, 1000, 0);
> }
Sounds good. I will change it in v6.
> 
> thanks,
> 
> -- 
> heikki

Thanks,
Abdel
