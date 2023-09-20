Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A553C7A8823
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjITPV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbjITPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:21:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECEFF1;
        Wed, 20 Sep 2023 08:21:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-404314388ceso74827955e9.2;
        Wed, 20 Sep 2023 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695223302; x=1695828102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ndytcNwjogwuE9vld+zk4GipkAa+bZ+yvXsaST4Qa4=;
        b=mU5MtFcPsEz1Suw8Cs6gzx+xPJo+gW1GoTAbvkIIqMMGjdnZkChub/XCR2DeI1wDl5
         DnHmcr/w1qSiVdGLYOifNvKuJwePOAzTclOWYHG3iChVUaJbc5LQvYWyuGjjAmizFoG1
         KtDoIEoJieHZS4Cty1AwpihlU2CuJDoif2GpFKTLPJyTWS2IPEC35PUwB8Q+kmhAzbuo
         wDvRGNgtKlAoneVZFsq23CvKWp/f7W20kRBR6Uv/6EgUkCRqXJjndQadBhAa2RTFVgAr
         XKh/uioisOtTxwvBEVmbyTfVPFLZM+PqFrVqIRe7931X0tODCRBC7UgOKBCXfIv2IU+6
         WU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695223302; x=1695828102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ndytcNwjogwuE9vld+zk4GipkAa+bZ+yvXsaST4Qa4=;
        b=qNtHMhwlpL5o+B0lNATc8qPmvPTVdz48JA3lTb4aQVAZZSuJPTxBsOBOKUJJoGhZuF
         TZNMpeNMUwJVCRuOMhUlH1hselJ51ToDGmNp/TcufEufnwMmdtsfS1TSyD60k7mbQVLe
         zfnO6CULMTJdrBzvQ3elcLyve53nBBISTxwLZ8ASb1mTkWDUTcNnKwYf5gkKWI+d6x/2
         TGDjcxPwmlHbQrOcx0V5mQAA+33fXtAcOHBHxJ9sZp54gWXsv6gIqF9k5wyN1V8mTB1/
         3wI43XsBb0IQ3oObguZdBGHtz4GCQ8ciIzp7XU4NlalQwq1nkWc4lWpAJ+Cy+8YowyyL
         ci3w==
X-Gm-Message-State: AOJu0Yx8f1VBG9LLyhtDejib2y4VzXWjubXHq95devqqEn/0/KRmR1Vl
        ENjao39nm2GKYbFwq+qgjGo=
X-Google-Smtp-Source: AGHT+IFqlLk7XhluQ0MPa1+L883EOj4GTHCKbmC7suG1Q8L8HSn3/4TKpm+v92OpbRxvZRhbbZp4kA==
X-Received: by 2002:a5d:51cd:0:b0:317:3c89:7f03 with SMTP id n13-20020a5d51cd000000b003173c897f03mr2726596wrv.5.1695223301943;
        Wed, 20 Sep 2023 08:21:41 -0700 (PDT)
Received: from primary ([212.34.23.120])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d62c9000000b00317afc7949csm18775710wrv.50.2023.09.20.08.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:21:41 -0700 (PDT)
Date:   Wed, 20 Sep 2023 11:21:38 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com, ryan.eleceng@gmail.com
Subject: Re: [PATCH v5 00/15] Add TPS25750 USB type-C PD controller support
Message-ID: <ZQsOAi2bkBk8zHMr@primary>
References: <20230917152639.21443-1-alkuor@gmail.com>
 <ZQhXXeVo6LaZe20a@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQhXXeVo6LaZe20a@kuha.fi.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 04:57:49PM +0300, Heikki Krogerus wrote:
> On Sun, Sep 17, 2023 at 11:26:24AM -0400, Abdel Alkuor wrote:
> > From: Abdel Alkuor <abdelalkuor@geotab.com>
> > 
> > TPS25750 USB type-C PD controller has the same register offsets as
> > tps6598x. The following is a summary of incorporating TPS25750 into
> > TPS6598x driver:
> > 
> > - Only Check VID register (0x00) for TPS6598x and cd321x, as TPS25750 doesn't
> >   have VID register.
> > 
> > - TypeC port registration will be registered differently for each PD
> >   controller. TPS6598x uses system configuration register (0x28) to get
> >   pr/dr capabilities. On the other hand, TPS25750 will use data role property
> >   and PD status register (0x40) to get pr/dr capabilities as TPS25750 doesn't
> >   have register 0x28 supported.
> > 
> > - TPS25750 requires writing a binary configuration to switch PD
> >   controller from PTCH mode to APP mode which needs the following changes:
> >   - Add PTCH mode to the modes list.
> >   - Add an argument to tps6598x_check_mode to return the current mode.
> >   - Currently, tps6598x_exec_cmd has cmd timeout hardcoded to 1 second,
> >     and doesn't wait before checking DATA_OUT response. In TPS25750, patch 4CCs
> >     take longer than 1 second to execute and some requires a delay before
> >     checking DATA_OUT. To accommodate that, cmd_timeout and response_delay will
> >     be added as arguments to tps6598x_exec_cmd.
> >   - Implement applying patch sequence for TPS25750.
> > 
> > - In pm suspend callback, patch mode needs to be checked and the binary
> >   configuration should be applied if needed.
> > 
> > - For interrupt, TPS25750 has only one event register (0x14) and one mask
> >   register (0x16) of 11 bytes each, where TPS6598x has two event
> >   and two mask registers of 8 bytes each. Both TPS25750 and TPS65986x
> >   shares the same bit field offsets for events/masks/clear but many of
> >   there fields are reserved in TPS25750, the following needs to be done in
> >   tps6598x_interrupt:
> >   - Read EVENT1 register as a block of 11 bytes when tps25750 is present
> >   - Write CLEAR1 register as a block of 11 bytes when tps25750 is present
> >   - Add trace_tps25750_irq
> >   - During testing, I noticed that when a cable is plugged into the PD
> >     controller and before PD controller switches to APP mode, there is a
> >     lag between dr/pr updates and PlugInsertOrRemoval Event, so a check
> >     for dr/pr change needs to be added along TPS_REG_INT_PLUG_EVENT check
> > 
> > - Add TPS25750 traces for status and power status registers. Trace for
> >   data register won't be added as it doesn't exist in the device.
> > 
> > - Configure sleep mode for TPS25750.
> 
> This looks mostly okay, but I'm a bit uncomfortable with flags like
> is_tps25750.
> 
> I think a better way would be to supply driver data. In it you would
> have a callback for everything that needs to be customised.
> 
> struct tipd_data {
>         int (*interrupt)(int irq, void *data);
>         ...
> };
> ...
> static const struct tipd_data tps25750_data = {
>         .interrupt = tps25750_interrupt,
> ...
> 
> Something like that. You can on top of that still check
> device_is_compatible(dev, "...") in some places.
>
Sounds good. I will create callbacks factory struct as you suggested
and remove the flag.
> 
> thanks,
> 
> -- 
> heikki

Thanks,
Abdel
