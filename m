Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CEE79A469
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbjIKH1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjIKH1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:27:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999C8CCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:27:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so827980f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694417250; x=1695022050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyNRJsgDnT0Q1wv9e4Yhzfbl/njbmsE4L07P0lJyW3k=;
        b=u1Gyjua/NAJ+ui+tSAZUYCfRHILudJ+sRaJ8BAx64xKYROiUN3LSW6vEdOw2oLtIdP
         2nnyrCb9YY9rwlapAnzdmMXeuqLdEIfL3oPSY3rXI942tq8FO4konwYTXeKbBwEkx6Vb
         i2u7LKif9sY7Hv3BozT7TPQkJYDNaawZK13cGPlM6oBfTuMnvFKstiw2sDnvXGkfhabc
         gB0njW9ogvpahtusGe2w2daZ60/YbTZkoQu40JYypdF47ZyKxSamlTuDiAQoRXc9nJU2
         pdU5wtEysRg56a1sY+saKaZVKgATmPYTdjkUDn8XVAn7xYxStIYwFSQNiFprTYlIfwC/
         PG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694417250; x=1695022050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyNRJsgDnT0Q1wv9e4Yhzfbl/njbmsE4L07P0lJyW3k=;
        b=A54rYFvbmb/z3ASvmd4lL09jVJLjd3KTdnyXEyZT0xXa5kpucmlCWMy3230OxWoHmQ
         k4iPcHO47erv/AqzOr9/9qpnfOgdReDJ8b2kdH+npY8aJFJtv+rBSsETADojOCuNMoje
         ZNVmwJWdt6effUCsUtYWu/K2cQUM9mK1Ipi6lFNwAd7YHhblJ4wdpWwJqPLgc7OWFKfe
         ur+RIQloDhArbLfm38xLRgKruoUOqU0lM+3FYWvhBpWC6pHetzrJUlx0xkRpBoL9gIEo
         mVJXB/NNW5Vsa4XRHaeq5Ly2J99MNG3mlJPnL5hUuRWGl/9rd9QXwH6BwYspGZ+0h+Z2
         zijQ==
X-Gm-Message-State: AOJu0YwsMfGwx9bYX0VK8005x5ZzBC9tEpCzPlTXQAaltr4m2cgi+qZo
        uWcRaNFDCyFyEt0qQYjNIFtp1g==
X-Google-Smtp-Source: AGHT+IGdBfloYgMq0Mc9JPKNVTFK1Kj770gyf2LEnnuCfIgLbNILenUucwmxL1Rn2ZvcDwzJG4mIDQ==
X-Received: by 2002:adf:f589:0:b0:319:7b66:7803 with SMTP id f9-20020adff589000000b003197b667803mr6607879wro.55.1694417250043;
        Mon, 11 Sep 2023 00:27:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 14-20020a056000154e00b0031f8be5b41bsm6289336wry.5.2023.09.11.00.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 00:27:29 -0700 (PDT)
Date:   Mon, 11 Sep 2023 10:27:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     liulongfang <liulongfang@huawei.com>
Cc:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Zaibo Xu <xuzaibo@huawei.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon/hpre - Fix a erroneous check after
 snprintf()
Message-ID: <6b9ada4d-0bfc-43c6-9793-be6762c1bbba@kadam.mountain>
References: <73534cb1713f58228d54ea53a8a137f4ef939bad.1693858632.git.christophe.jaillet@wanadoo.fr>
 <ZPaSCOX1F9b36rxV@gondor.apana.org.au>
 <00bdcfec-6cc1-e521-ceaa-d16d6341ca16@wanadoo.fr>
 <71bf9b84-462f-405e-91aa-fb21fc6ffbd5@moroto.mountain>
 <258d6883-f572-9ac7-f6c6-73c34b9d5b63@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <258d6883-f572-9ac7-f6c6-73c34b9d5b63@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 09:58:56AM +0800, liulongfang wrote:
> On 2023/9/7 19:15, Dan Carpenter wrote:
> > On Tue, Sep 05, 2023 at 07:27:47AM +0200, Marion & Christophe JAILLET wrote:
> >>>
> >>> The other snprintf in the same file also looks suspect.
> >>
> >> It looks correct to me.
> >>
> >> And HPRE_DBGFS_VAL_MAX_LEN being 20, it doesn't really matter. The string
> >> can't be truncated with just a "%u\n".
> >>
> > 
> > drivers/crypto/hisilicon/hpre/hpre_main.c
> >    884          ret = snprintf(tbuf, HPRE_DBGFS_VAL_MAX_LEN, "%u\n", val);
> >    885          return simple_read_from_buffer(buf, count, pos, tbuf, ret);
> > 
> > You can't pass the return value from snprintf() to simple_read_from_buffer().
> > Otherwise the snprintf() checking turned a sprintf() write overflow into
> > a read overflow, which is less bad but not ideal.  It needs to be
> > scnprintf().
> >
> 
> Here only one "%u" data is written to buf, the return value ret cannot exceed 10,
> and the length of tbuf is 20.
> How did the overflow you mentioned occur?

Why are we using snprintf() if the overflow can't occur?  We could just
use sprintf().

The reason why we prefer to use snprintf() is because we are trying
extra hard to avoid buffer overflows.  Belt and suspenders.  The
overflow can't happen because we measured but even if we messed up we
are still safe.

We should apply that same logic to the next line.  Even if an overflow
occurs, then we still want to be safe.  And the way to do that is to
change snprintf() to scnprintf().

It is always incorrect to assume that snprintf() cannot overflow.  It is
a mismatch.  snprintf() is for careful people, and if we are going to be
careful then we have to be careful everywhere within the function
boundary.  Outside of the function boundary then we can have different
assumptions, but within the function boundary then we have to logically
consistent.

It's the same logic as checking for NULL consistently.

	foo->bar = frob();
	if (!foo)
		return -EINVAL;

This code is wrong.  Even if foo can never be NULL and the code can
never crash, it is a logic inconsistency so it is wrong.

regards,
dan carpenter
