Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6AF753C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbjGNNtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjGNNtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:49:42 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8AF3580;
        Fri, 14 Jul 2023 06:49:41 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so17647465e9.1;
        Fri, 14 Jul 2023 06:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342580; x=1691934580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ehiH+nJa6KAQHmBUdX/E6O673kcIIwUhMgPN51VMJA=;
        b=KQpHRNzV9d4rrGez7i5omKcEbADoom4mJ8ZEHRHQ5PEy9sG0IYvjW9tcm2vVX4IQPq
         e31HrZZeNLr9+QcFcZH7LxOJ/ph0d09C7MPZTiOD+w5A/Fmvi733AaV7SxthTxo9Vcjl
         buv0qODvX769MqoWNCjn5SLSpbaAVnXiebNnakYGzbQ4jD0IMwddmTUbiqtzhawIB6Ml
         /CA7WyAL8wB7MDg/QUQN/1xV1oGSgB1xbvDmfq0p6fLVdLUIbkn+7AMwzwq2HUGgcpks
         34g9G+DvH+KqhAvvdGAzV/zUcUpFwzBOofOVed9rBqsgvlsFed+5+m17fkr5V5OENV3X
         /glQ==
X-Gm-Message-State: ABy/qLbV7G4lOlwuIkvt36umUEho9qwaD6uL0CeGGz63iGatbaKjZM9S
        WkiY+kY70RvueIaUQaQrM+E=
X-Google-Smtp-Source: APBJJlGt8SdB6gDAyhKo1Eu8jIkbcnT8cYjPbi2+Y4GcwmoOJFFp73Lo1ZucaHJqPFgip/vUDfK91w==
X-Received: by 2002:a05:600c:240a:b0:3f9:b430:199b with SMTP id 10-20020a05600c240a00b003f9b430199bmr3992071wmp.15.1689342579485;
        Fri, 14 Jul 2023 06:49:39 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-018.fbsv.net. [2a03:2880:31ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d4492000000b00315a1c160casm10900178wrq.99.2023.07.14.06.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:49:39 -0700 (PDT)
Date:   Fri, 14 Jul 2023 06:49:37 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, sergey.senozhatsky@gmail.com,
        tj@kernel.org, stephen@networkplumber.org,
        Dave Jones <davej@codemonkey.org.uk>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] netconsole: Append kernel version to message
Message-ID: <ZLFScfJtt/9ClORF@gmail.com>
References: <20230707132911.2033870-1-leitao@debian.org>
 <ZLE0g9NXYZvlGcyy@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLE0g9NXYZvlGcyy@alley>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 01:41:55PM +0200, Petr Mladek wrote:
> On Fri 2023-07-07 06:29:11, Breno Leitao wrote:
> > @@ -254,6 +267,11 @@ static ssize_t extended_show(struct config_item *item, char *buf)
> >  	return snprintf(buf, PAGE_SIZE, "%d\n", to_target(item)->extended);
> >  }
> >  
> > +static ssize_t release_show(struct config_item *item, char *buf)
> > +{
> > +	return snprintf(buf, PAGE_SIZE, "%d\n", to_target(item)->release);
> 
> I have learned recently that sysfs_emit() was preferred over snprintf() in the
> _show() callbacks.

I didn't know either, I just read about it in the thread. Thanks for the
heads up. We probably want to change it for the other _show() structs.

> > +}
> > +
> >  static ssize_t dev_name_show(struct config_item *item, char *buf)
> >  {
> >  	return snprintf(buf, PAGE_SIZE, "%s\n", to_target(item)->np.dev_name);
> > @@ -366,6 +389,38 @@ static ssize_t enabled_store(struct config_item *item,
> >  	return err;
> >  }
> >  
> > +static ssize_t release_store(struct config_item *item, const char *buf,
> > +			     size_t count)
> > +{
> > +	struct netconsole_target *nt = to_target(item);
> > +	int release;
> > +	int err;
> > +
> > +	mutex_lock(&dynamic_netconsole_mutex);
> > +	if (nt->enabled) {
> > +		pr_err("target (%s) is enabled, disable to update parameters\n",
> > +		       config_item_name(&nt->item));
> > +		err = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +
> > +	err = kstrtoint(buf, 10, &release);
> > +	if (err < 0)
> > +		goto out_unlock;
> > +	if (release < 0 || release > 1) {
> > +		err = -EINVAL;
> > +		goto out_unlock;
> > +	}
> 
> You might consider using:
> 
> 	bool enabled;
> 
> 	err = kstrtobool(buf, &enabled);
> 	if (err)
> 		goto unlock;
> 
> 
> It accepts more input values, for example, 1/0, y/n, Y/N, ...
> 
> Well, I see that kstrtoint() is used also in enabled_store().
> It might be confusing when "/enabled" supports only "1/0"
> and "/release" supports more variants.

Right. we probably want to move a few _stores to kstrtobool(). Here is
what I have in mind:
	* enabled_store()
	* release_store()
	* extended_store()

That said, there are two ways moving forward:

1) I forward fix it. I've send v3 earlier today[1], I can send a patch
on top of it.
2) I fix this in a v4 patch. Probably a patchset of 3 patches:
	a) Move the current snprintf to emit_sysfs()
	b) Move kstrtoint() to kstrtobool()
	c) This new feature using emit_sysfs() and kstrtobool().

What is the best way moving forward?


Thanks for the review!
[1] Link: https://lore.kernel.org/all/20230714111330.3069605-1-leitao@debian.org/
