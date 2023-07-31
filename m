Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADEA768B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjGaFry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGaFro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:47:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B24187;
        Sun, 30 Jul 2023 22:47:43 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f8614ce5so3766378b3a.3;
        Sun, 30 Jul 2023 22:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690782463; x=1691387263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+HRNBzo/qk4p+BIc9TZwiNlB7VBCZ2dA5FyipQo78Xs=;
        b=OukY5C5CCQlfGTpESJ+tm6WLhJxVyH6iycemjaCOzO0uVNsJGdzbmYuQHaVJrg41FK
         FMi8DGcjv76iBbVaoV0qC4R1CLsJFq/ArT3WKMj1+vGfcqqWdVejhODSqEHg1VLKQerZ
         zhUNXpvLPYahGkOI+WxIEyb7NZr4SJJHRT2PeE1bQg9G9VSvnTYh1eOXshAD6p5O7ijL
         W/AYEn0pJvmXK6ydbICJDZiXdrUL7jNQ87lsLwTvrqLv/IUwqZ2S/bW/qdwGJoOr/ZeK
         z8uyejUXTo2tU0Rf+s7yS6JabigohK1WRT2kDqsEPwOQY9C/fgaJsUAOC38Ux8DneVwB
         N/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690782463; x=1691387263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HRNBzo/qk4p+BIc9TZwiNlB7VBCZ2dA5FyipQo78Xs=;
        b=EmSsPQ2RknS9eg4u2ggmZJdwP5AR0SLD1SPI9lMgS+Dxc92+zd/RztJL1k8y9pgJmO
         SRCcs/0X5WIZcB1m/n6C7KfjaCRZqLkiZAOdsu/w3v97QZw3nXVkMPS5bGvBie4/S4r/
         4gl/GqQ/96pZN1C9/c/mN4FQPyQ1iCcm1/Bu+iJpOT+ZBpxpn5wx/lEx0uqZ1rtEZDcZ
         bB4WxOQmVmLOsoYnNGGDFn7ufYqgv3m9lQSEhWNuWg2iONbNEazRnFiv+fc5dBQmO2Za
         RAiolETvIQIFE54fZvm+dWzphMneLUWoPzgvPZwg9nOjRk0TaKbtJHPHk+g2dxipwd8s
         yg7Q==
X-Gm-Message-State: ABy/qLaEUG/4Dkiai6OK+NMPJBNa7EAySAhTtQ8B6JKF+kkv2AirMflr
        4xhmiKPPxdAEd4v5mQ/IZY61+BK+Z9Q=
X-Google-Smtp-Source: APBJJlENMP5lfVIloG4A2pbfiWUB5ecywH4BICT8jySkKOuwTyZuvhrscil7ZeUY+F+39yVnx1f4mA==
X-Received: by 2002:a05:6a00:10d5:b0:682:7d8a:f891 with SMTP id d21-20020a056a0010d500b006827d8af891mr11121595pfu.20.1690782463163;
        Sun, 30 Jul 2023 22:47:43 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6d25:c0f1:d8d5:201c])
        by smtp.gmail.com with ESMTPSA id ey14-20020a056a0038ce00b00686bdff1d6fsm6524147pfb.77.2023.07.30.22.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 22:47:42 -0700 (PDT)
Date:   Sun, 30 Jul 2023 22:47:40 -0700
From:   'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
To:     "Jingle.Wu" <jingle.wu@emc.com.tw>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        phoenix@emc.com.tw, josh.chen@emc.com.tw, dave.wang@emc.com.tw
Subject: Re: [PATCH]  Input: elan_i2c - Implement inhibit/uninhibit functions.
Message-ID: <ZMdK/Gnhb3p9NVCC@google.com>
References: <20230531090340.1035499-1-jingle.wu@emc.com.tw>
 <ZJ4MVbTnBT5sM5XR@google.com>
 <000001d9af07$3c003a20$b400ae60$@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d9af07$3c003a20$b400ae60$@emc.com.tw>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingle,

On Wed, Jul 05, 2023 at 02:09:18PM +0800, Jingle.Wu wrote:
> HI Dmitry:
> 
> 1.
> > +static void elan_input_lid_event(struct input_handle *handle, 
> > +unsigned
> int type,
> > +			     unsigned int code, int value) {
> > +	struct elan_tp_data *data, *n;
> > +
> > +	if (type == EV_SW && code == SW_LID) {
> > +		list_for_each_entry_safe(data, n,
> &elan_devices_with_lid_handler, 
> > +list) {
> 
> Why do you need the "_safe()" variant here?
> -> Because I took the above link as reference.  
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3
> 578852/7/drivers/hid/hid-multitouch.c#394

It is wrong there too. The _safe() variant protects list traversal when
the list is being modified by the same thread, here we do not do that.

> 
> 2. 
> > +	data->lid_switch = true;
> > +	INIT_LIST_HEAD(&data->list);
> > +	INIT_WORK(&data->lid_work, lid_work_handler);
> > +	list_add_tail(&data->list, &elan_devices_with_lid_handler);
> 
> It looks like you call elan_create_lid_handler() from elan_probe() which
> means it can be called several times (we should not assume there is only one
> controller), I do not see it being destroyed in remove() either, so it will
> break if you bind/unbind the driver.
> 
> I also not sure why you need the list of you have a handler per device.
> 
> -> If the elan_create_lid_handler() function not be put into probe(), the
> lid
> handler would be invalid in elan private data("struct elan_tp_data *data").
> Or do you have any suggestions for it? Thanks.

The handler's connect() is called for each matching device so you can
tie it up at that time.

> 
> 3.
> > +	error = elan_create_lid_handler(data);
> > +	if (error)
> > +		dev_err(dev, "failed to create lid handler: %d\n", error);
> 
> Do we need this on _ALL_ devices with ELan controllers, or just certain
> ones? If we need this on all devices how did it work before?
> 
> -> Yes, we need this on all device.
> In Chromeos kernel v5.4 before, the elan_inhibit()/uninhibit function was
> built and worked
> successfully in elan_i2c_driver.
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads
> /chromeos-5.4/drivers/input/mouse/elan_i2c_core.c#353

We have the Elan touchpad driver without this functionality for many
years. I am aware that certain devices need this, but the fact that
Chrome OS kernel 5.4 (which is only used on a subset of Chromebooks) has
it does not necessarily mean that this functionality is needed on _ALL_
devices.

Thanks.

-- 
Dmitry
