Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9840E77E973
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344319AbjHPTMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344724AbjHPTMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:12:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3529826A0;
        Wed, 16 Aug 2023 12:12:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-688769faa09so1364041b3a.2;
        Wed, 16 Aug 2023 12:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692213136; x=1692817936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUxQtzAvxn5wMlUvvgAAU6yViv0NwyF3TSGjuAQvdk4=;
        b=oAk1zgzxFyDAzQ/tPy3vjbGQ1SNAEfP+D3+5tBdes/lds4x+bZPvD8zooasxmINK3p
         UH4oBYH0UH4PsXA8PYk0ZG3QVi05+hvts3zPcvrqI+YHpEtf683NGzALXdaib4xCjbNr
         /HCuN5NEZY2OJWUyHPwxr+gS3Xf8DTTTK1waF95hB7t4v10pU2CU8eNAIWwarajJF033
         2aQxlzHfbvdlqRIbISHagbizvNBJ5wPaZK5ebqfux7YVUFoybsFZ/Gi2kcBlEVFNkRlW
         v4gGdq+1QtB4n5xGh4PHNY8milQp4UPfqDeHqoymm2iSyGNHni7CPslStZwfmrNocoQr
         GJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692213136; x=1692817936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUxQtzAvxn5wMlUvvgAAU6yViv0NwyF3TSGjuAQvdk4=;
        b=cg4EwIgwD8/FN9Tm9PbkiBoP+MmCq//jVBeLqnl13BhbYOUBUSetdAJnHl1ZBTMQvn
         Wuk7W56Lsjxd4MuzSYW/zhHQe3f89BsbL9rwIArIgMPCI2sPVjE0qhx6zuDNylx73SOk
         aJ4ueEJxM0Kl4YxM2bHRo/c2njgRwNbl+jdvjqpVu6YGIVBHa907bZVCTSmaJLYKnv85
         DEpcgZVUXfw29W+5igOL7xtMzYawiqmj3Yfx3h4nmU0jQdFswY0Gtjxvnf5DO/KdzlSr
         AlmTbkyTGoEqjdv86noSfNuRaL1sMgT5j+4BsEk+z0JCvI+UQaohp9Nw/hqHBl7e0XsX
         +XLg==
X-Gm-Message-State: AOJu0YyCDhqbyPEjqabchKtcpBU8DN0YOLKJ+aYoUokFFI2CK8Ycf5aR
        VmI4SNDbu9ukGIfNaEfFFqA=
X-Google-Smtp-Source: AGHT+IFgVe3Z4fhdFFJttNsSX5HhKfDbfGs8s3UaqjCMtX2YpTSdFENYDXbMwsVCycEMP1mgTCUTFg==
X-Received: by 2002:a05:6a20:dd94:b0:13d:6c5a:1887 with SMTP id kw20-20020a056a20dd9400b0013d6c5a1887mr2590414pzb.20.1692213136423;
        Wed, 16 Aug 2023 12:12:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fe23-20020a056a002f1700b0067b643b814csm11413469pfb.6.2023.08.16.12.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 12:12:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Aug 2023 12:12:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 0/7] rtc: Add support for limited alarm timer offsets
Message-ID: <6ffc915e-ca91-4b64-b7a5-f13f60df8b1d@roeck-us.net>
References: <20230816133936.2150294-1-linux@roeck-us.net>
 <20230816150353137debc5@mail.local>
 <8079bdf4-f790-451b-a2c2-be4e23c0c3a1@roeck-us.net>
 <20230816161435bd2bbd4a@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816161435bd2bbd4a@mail.local>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 06:14:35PM +0200, Alexandre Belloni wrote:
> On 16/08/2023 08:50:12-0700, Guenter Roeck wrote:
> > > I'm fine with the series, however, this doesn't solve the issue for RTCs
> > > that have an absolute limit on the alarm (as opposed to an offset to the
> > > current time/date).
> > > 
> > 
> > I thought that is checked by rtc_valid_range() in rtc_set_alarm().
> > Am I missing something ? Of course that assumes that the absolute
> > maximum alarm timeout matches range_max, but I didn't find any
> > drivers where that would not be the case.
> > 
> 
> There are RTCs where this is not the case. When this is far away in the
> future enough, the usual solution is to clip range_max which works but
> is not really great intellectually.
> 
Do you have an example, by any chance ?

Thanks,
Guenter

> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
