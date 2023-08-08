Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C426F774BF5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjHHVBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjHHVAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:00:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFA330C0;
        Tue,  8 Aug 2023 13:59:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so9678707e87.2;
        Tue, 08 Aug 2023 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691528368; x=1692133168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YptjaSK25c+LT9Dq7yPSnNM+eMfZSyQd6iKMJ7jTM1Y=;
        b=sZK+zJ1JWprxyHsNiCXibbwJ5LfUc94PxC84/VHbEISOquUIyQsncIFf9jsa/l944b
         vIN52UtCgD+GlbKOMvFT6BfSIE7p5+U5s5UxVTMJ+yjV7fzMFgumJJDPkU2hSuYRhVPH
         sN4W72IzbUeKWnQzIuD4thaUWl8ov1rdprFKplQHRc9zOLfP1FrgeXJcFJhG0nXmy2SH
         bMw9lrg6AESG8YgaDNoFwmvpGFAalB/7u3LgIkCRpkdmcq6NtUltDlDI9eGXHhtV+A+y
         sKeXXrE/fXuCBDM4XDCSaaIZ2uLKXKbdiuLKsClFqjzG5qRWVlZHmftGx5KHrP0wIhro
         9VCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691528368; x=1692133168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YptjaSK25c+LT9Dq7yPSnNM+eMfZSyQd6iKMJ7jTM1Y=;
        b=jmHbQaOS06//nurW3wiJE84yRyhtqySIApQisILlfiv4KG1WZY/yS0ss6g7i0YO/FT
         ysRZZLHL/7V/k5hf8sxvsOwVlkf/FsJD7aAbBzDee/gciq00S5mht+W2Ltv6ZOKm+Ih2
         1hp5ctb9UUgigCRjC0upPLXqRr+bask0xkicFS3d/GyH6LusJ34hHQqOjPAKHakZfhkZ
         tLIHFbBkK0hNIlBTGZE8jorG0UQTnhvaE49qkYoAR2PwPdjk4vpMa0EOQ4gcv+p9cIcA
         e9Npz3hX1x2Q9tCVBxSLFy7SCsYVQfWXKdtiynEDwURdLqNi+cXmKA0/CgE3Fol6nTe1
         hQ6w==
X-Gm-Message-State: AOJu0YxqMMGD7oMcinIY4owWlw5b++c3hQgaUQ+pfRkOQBebvGqNmcWo
        mSjuyaCKlynjB5U0qF/zYbQ=
X-Google-Smtp-Source: AGHT+IE5QO7/2mwuLU5kziUoaIoYXM/KZLHOk0t03y5qCm3M8qEdwaFJYMxcz+sB2cAtgD1rXaDKNw==
X-Received: by 2002:a05:6512:3b90:b0:4fd:c785:58b with SMTP id g16-20020a0565123b9000b004fdc785058bmr560301lfv.4.1691528367697;
        Tue, 08 Aug 2023 13:59:27 -0700 (PDT)
Received: from mobilestation (89-109-46-22.dynamic.mts-nn.ru. [89.109.46.22])
        by smtp.gmail.com with ESMTPSA id j20-20020ac253b4000000b004fbdba4b075sm2013185lfh.57.2023.08.08.13.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 13:59:26 -0700 (PDT)
Date:   Tue, 8 Aug 2023 23:59:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Set default value if reg-io-width isn't
 specified
Message-ID: <4dhdiqmyd2ytpxjv3ph2shxmfu4cg7sshpip7qic6rmqlbfen3@knn33heekvu3>
References: <20230807001621.196776-1-hayashi.kunihiko@socionext.com>
 <az7wvv5f42mnuuwkqzpfmwg4ngvl4jvpcfmns7d6lhzogc4qdi@ox64l6i7b44r>
 <213763b3-5a8b-3a88-54f1-024325f7fe80@socionext.com>
 <1505ec01-186d-451a-9164-d42796954c01@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505ec01-186d-451a-9164-d42796954c01@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 01:46:08PM +0100, Mark Brown wrote:
> On Tue, Aug 08, 2023 at 09:00:18AM +0900, Kunihiko Hayashi wrote:
> > On 2023/08/08 7:57, Serge Semin wrote:
> > > On Mon, Aug 07, 2023 at 09:16:21AM +0900, Kunihiko Hayashi wrote:
> 
> > > > According to the dt-bindings, the default value of reg-io-width is 4.
> > > > However, the value becomes zero when reg-io-width isn't specified.
> 
> > > This semantic is implied by the dw_read_io_reg() and dw_write_io_reg()
> > > methods. It doesn't seem like that much necessary duplicating it in the
> > > property parse procedure, if not to say - redundant.
> 
> > I see. Currently since the variable reg_io_width has no other references
> > other than dw_{read, write}_io_reg(), it means the default value is taken
> > if this is zero.
> 
> > So, I think we should be careful when actually using the value of
> > this variable.
> 
> It does feel like a sensible robustness improvement,

I wouldn't call it "a sensible improvement" in this context, but
merely something like "a data-field/property coherency fixup".

> even if it's not
> fixing a specific issue now it might save us from future issues.

Such issues are very unlikely to happen unless somebody would try to
use the dw_spi.reg_io_width field separately from the denoted methods.
If one does, what he would have needed to make sure is that the field
always takes a correct value which would have led to this patch anyway
but at least it would have got a firm justification.

So to speak I wouldn't have bothered with merging the patch now at
least without changing the patch log which would have had to be
reduced to just the first paragraph with additional message stating
that the change just makes sure that the field is in a coherent state
with the DT-property value in order to improve the code
maintainability.

-Serge(y)
