Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2BE7573DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjGRGOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjGRGOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:14:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C70A19A5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:13:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f122ff663eso8487409e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689660769; x=1692252769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rgbFWSWr6W8QdzbGv+j4ji6jKVEolY8RLpgGW8ZQcUk=;
        b=qEc7J7XzLk3yZ6Pxd2/40r/WoJdPYmeWrLsUgjcqMlcfY7rOu43o8lem+5oNlRS7wU
         edQVTiNgVRPTfhjWTFANoqkKWAsuYvLwJph5mn9dNqWzcf57WQXrwyi6SxG/ERdaDeiF
         Bik0tXddl0iVVt/f3U+M/7otRHoAzjKfWkHgtKmU4hkn5XfXlTEMI2t6wg4oVDPSNL2n
         kYjL21xTAdE/WDDDdjungWKeJU/pXjNGumWKTHlWdu3yADbzR1ROYuzk0sMeeR9VWotm
         6chP/AlvhhPQQZCVZcVB9xM0w9sUkGfOdbZiJwT36BxSitNqCl4BCEFfjTjIVuC5oMxO
         1o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689660769; x=1692252769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgbFWSWr6W8QdzbGv+j4ji6jKVEolY8RLpgGW8ZQcUk=;
        b=ITjvFDlzf6FflAewuv1c1axnvIB6iZtrku/LqhFJ5qfhN8A5S4VSukQ1qn0YppK9+A
         5L8Tyk+BEO0+mmBkmXpRxbfMxxWbztSXqTnxX1twxdGbQtwWcLYRvxGMtwCCFyXtJ61s
         T/b0F0G+c5G+W3HdZJXCtKiQgaGjtZAclX+w4xwLk00oHxOUf4B7rkRgRiZ+PVCu390c
         5bF0dLc2zbL3GcM8l1YoghpJSTlvLCCjRBxy3H7eCPwq2PrMV/A3S/RfOVOpCWGWJhQi
         Sju9PG0jY6KFcg8rVsOhv3mMcZp8/D6+4CbAckIkAm2spd2YRO04uBhATI3YoXPM3fdX
         SdTA==
X-Gm-Message-State: ABy/qLZKywFx7cF+zZoCOAcnS3l+uVnFuqEW1M01NpKNFVDiyZx6Vbos
        sSHaNt0mprv9CpLlmqIts+EH+w==
X-Google-Smtp-Source: APBJJlH3PS0/PK72s53EFLRDXW5H0201i7mmM9m1dz6YPI4GTgTZe76ZXIbpK/bSNjshQs4B6YKGzQ==
X-Received: by 2002:a05:6512:45a:b0:4f8:5696:6bbc with SMTP id y26-20020a056512045a00b004f856966bbcmr7830812lfk.29.1689660768889;
        Mon, 17 Jul 2023 23:12:48 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c248200b003faef96ee78sm9596812wms.33.2023.07.17.23.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 23:12:46 -0700 (PDT)
Date:   Tue, 18 Jul 2023 09:12:43 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] driver core: Fix an error handling path in
 fw_devlink_create_devlink()
Message-ID: <cce2a2ac-e0e7-45ec-9093-88e7acf78865@kadam.mountain>
References: <858b140b276ceab52a84ce0d4f924b0c411560d1.1689618373.git.christophe.jaillet@wanadoo.fr>
 <CAGETcx91Vm60Os5fw7-kNQ6bGjYaPhOeEutyBy_GLQA62f6vfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx91Vm60Os5fw7-kNQ6bGjYaPhOeEutyBy_GLQA62f6vfA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 11:57:51AM -0700, Saravana Kannan wrote:
> > ---
> >  drivers/base/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 3dff5037943e..854c1fab742c 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2107,7 +2107,8 @@ static int fw_devlink_create_devlink(struct device *con,
> >             fwnode_ancestor_init_without_drv(sup_handle)) {
> >                 dev_dbg(con, "Not linking %pfwf - might never become dev\n",
> >                         sup_handle);
> > -               return -EINVAL;
> > +               ret = -EINVAL;
> > +               goto out;
> >         }
> >
> >         ret = -EAGAIN;

It would have been more obvious that put_device() is a no-op if this
ret = -EAGAIN were changed to "return -EAGAIN;".  That would probably
silence some sort of static checker warning...

regards,
dan carpenter
