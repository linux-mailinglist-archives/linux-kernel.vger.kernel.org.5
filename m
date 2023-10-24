Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456D87D46AE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 06:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjJXEM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 00:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJXEMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 00:12:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EBE10D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 21:12:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4079ed65471so33139735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 21:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698120739; x=1698725539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s7s3u7bi0Hk44VLnFMnw7DHZL5GKwqaXp0FXz9TuqLQ=;
        b=FMrQh5Ia3OgFRXOuLa5V01oOiQmM/QLngAgWH2ahvapFcFyLBD7UqhDW9M/5UFDzMZ
         PUgYDJh5+2gSv15ti6fF1j83dNzwaTTsMTkHknHO9YFRJCuDLgp/WIdqlEZCbuNavlgA
         QipevMHipOmQkGWwjoYdWgdDN8aTqW5tJVkIVm4+Nv8F/DiM/CYXAf69LohobhjlJ5yc
         2ok+42jzr7EANE/cEG8a3m6HZT+NwR/W89/MeotjDQqQoqGHOX5xUU2Lq0lSZ5Eoik7j
         z/OF4pc9jLHXV8LHkbGCw2plAV53QExw6cgEQZGAlwciqzrJPfGvlDv4V3dGWUCZCy5w
         OcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698120739; x=1698725539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7s3u7bi0Hk44VLnFMnw7DHZL5GKwqaXp0FXz9TuqLQ=;
        b=FuwuY9k8XeTwdvjdGuv1SXD075DRQhuCwn4iA6uOCZOmZ0IHGw7ZENmW6q+jwTLxPB
         i95Xz7UMlBZ4pkt5AhoaJZ/GvRpj2SYmaIvoMVaPrCsBqpDnQvbHu9/tHsBmV1aNc1Ly
         wxdpNZ4dF9TXadGXs3qSVFzhuuLOsc8NlUxDs8YMw8cy/ily5vsDA/kjFCZGce9NYjLa
         eoCuLoI3TYJAONHjMGU6uBv9RVRKM7Z1bOQoVxFl05pr4vjJ5tPUuAeoJ5WFMS9uRQtr
         f7tl2LQEm1TW3pFsdyX7Png4l5p7Zq7u0m8MbOUao+5yaW6rza2CnzYpwW9bTSqlfJY5
         O8gg==
X-Gm-Message-State: AOJu0YwBPYJQ0yyxMeVV94KpJ6VBPLH72wdbvPbZIvlWNbzAaUjEuNs4
        yuhqxrBwH6G7UqyKBwucydZtUQ==
X-Google-Smtp-Source: AGHT+IGlH793z/rH9C/Fd5V+RxZl8AeFGmuOiIHr6g0/Mg9FTpJdXQRXzLSK1T7/FjtCxgRdGD9rGw==
X-Received: by 2002:a1c:770a:0:b0:401:906b:7e9d with SMTP id t10-20020a1c770a000000b00401906b7e9dmr9435592wmi.18.1698120739402;
        Mon, 23 Oct 2023 21:12:19 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i18-20020a05600c481200b00407b93d8085sm15397033wmo.27.2023.10.23.21.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 21:12:18 -0700 (PDT)
Date:   Tue, 24 Oct 2023 07:12:14 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Bergh <bergh.jonathan@gmail.com>, mchehab@kernel.org,
        gregkh@linuxfoundation.org, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] staging: media: av7110: Fix various whitespace
 checkpatch errors
Message-ID: <0fc4db47-4b05-473f-966e-962a2c671dcf@kadam.mountain>
References: <20231020232332.55024-1-bergh.jonathan@gmail.com>
 <20231020232332.55024-3-bergh.jonathan@gmail.com>
 <b301c9a1-7536-46c5-878e-7cd79e3a4742@kadam.mountain>
 <15f45bbde3f4289b012db7adb8166cf0d45e4fec.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f45bbde3f4289b012db7adb8166cf0d45e4fec.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 08:24:58AM -0700, Joe Perches wrote:
> On Mon, 2023-10-23 at 17:26 +0300, Dan Carpenter wrote:
> > On Sat, Oct 21, 2023 at 01:23:29AM +0200, Jonathan Bergh wrote:
> []
> > > diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
> []
> > > @@ -241,8 +241,8 @@ int av7110_pes_play(void *dest, struct dvb_ringbuffer *buf, int dlen)
> > >  		sync |= DVB_RINGBUFFER_PEEK(buf, 2) << 8;
> > >  		sync |= DVB_RINGBUFFER_PEEK(buf, 3);
> > >  
> > > -		if (((sync &~ 0x0f) == 0x000001e0) ||
> > > -		    ((sync &~ 0x1f) == 0x000001c0) ||
> > > +		if (((sync &~0x0f) == 0x000001e0) ||
> > > +		    ((sync &~0x1f) == 0x000001c0) ||
> > 
> > These should be:
> > 
> > 	if (((sync & ~0x0f) == 0x000001e0) ||
> > 	    ((sync & ~0x1f) == 0x000001c0) ||
> 
> Generally, I believe it would be better to avoid '& ~constant'
> and use the positive form instead
> 
> 	if ((sync & 0xfffffff0) == 0x000001e0) ||
> 	    (sync & 0xffffffe0) == 0x000001c0)
> 

To me it depends on if the 0x0f means something.  It would be better as
a define instead of a magic number.

regards,
dan carpenter

