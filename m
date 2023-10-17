Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA37CB9B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjJQEVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjJQEVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:21:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4309F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 21:21:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40776b1ff73so29542075e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 21:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697516477; x=1698121277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSCcyJKKhe9oQwQDqf1wV5AdygiSe6A+VMWBZelRBOg=;
        b=YJ8AHRFTCYB/cJuxDZZuLSMHm/C4yD8PzX9WGV1FWQoS67mkZ84DC4d69VIYNyHjMh
         UnMe4OwlfS82kz9s3jpqQIDmN/+u+JfjLjd/TczbN5VzyUfCtZaafXpHcYqVsSz3RQHu
         f4lnonVwQ1+q2kfMKx1Qz0z7pU6RkBroQWF25v8/gKHY7z0r3KX4H88nqERn9TebRwOJ
         CHHzqq8O4O2xyuwJcGbuPazTJ6vd18AQQ8IYU1Y/7tKGQdOoAn/Ju2ZGuY2RwtODw2Rl
         orpVVG5P/l732H5YLM/uKkNLQlBvrxdUxziEiu6jS79BUi6pWSTr8MkDeTZrsrWAxxie
         Euvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697516477; x=1698121277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSCcyJKKhe9oQwQDqf1wV5AdygiSe6A+VMWBZelRBOg=;
        b=S0YYyAEJLXSxU7u27DwiG/p3ypQBKh0ZSnI2YWQiK2lZtw1izFTTZHOMhxsQQHx1ln
         aqad3TpfCBJr3oD6hfyNYcxGUWRJF75ihNqu/zXqY3B2yzWnI8MzHw27yjPKrBaPCXjm
         S375wHL4WlvzwJf458Ql94TXhhD6qwOjQHaQVzeDXSU2hq8Pcmh6AqEbDq870Rwn7A+U
         683KX0ES6P0Yq+xYp2iTKWfLB5qob7pZ8YNlW1uyu79eljwhmnWhloX06YapTiMxw8FO
         CxllC+a3Yaqskh9BP0ua+b2zgGsDWXurUdx5wVYjjtLBE6PzTVDZ4EO32bANzeE4VP44
         I/Yw==
X-Gm-Message-State: AOJu0Yye8NCV/LsRD/hRn/vi3NVqYEom6Z3CDZbgdgbPHGMqFf2MzXrw
        0CBPdIIsIllZGzAbvf049vD6sg==
X-Google-Smtp-Source: AGHT+IFXi6U+vu92ahA0dSTkSUF4s/rRSRQ+VtC9Ir5a0Pm9QEmodyk0y5hzOYvsChcxJgVJkeg+wg==
X-Received: by 2002:a05:600c:4744:b0:403:9b7:a720 with SMTP id w4-20020a05600c474400b0040309b7a720mr886510wmo.1.1697516477154;
        Mon, 16 Oct 2023 21:21:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b00407752f5ab6sm758943wms.6.2023.10.16.21.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 21:21:16 -0700 (PDT)
Date:   Tue, 17 Oct 2023 07:21:13 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>,
        Nam Cao <namcao@linutronix.de>, outreachy@lists.linux.dev,
        manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        coiby.xu@gmail.com, gregkh@linuxfoundation.org,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Add bool type to qlge_idc_wait()
Message-ID: <32b0e468-6943-431c-9f71-68fc41727914@kadam.mountain>
References: <ZSoxLxs45bIuBrHg@gilbert-PC>
 <20231014065813.mQvFyjWb@linutronix.de>
 <20231014071423.UgDor1v0@linutronix.de>
 <ZSpIPippZFtMw2aG@gilbert-PC>
 <78f321db-bc09-06e8-b4ef-ac56ab91e187@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78f321db-bc09-06e8-b4ef-ac56ab91e187@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 04:19:09PM +0200, Przemek Kitszel wrote:
> On 10/14/23 09:50, Gilbert Adikankwu wrote:
> > On Sat, Oct 14, 2023 at 09:14:23AM +0200, Nam Cao wrote:
> > > On Sat, Oct 14, 2023 at 08:58:13AM +0200, Nam Cao wrote:
> > > > On Sat, Oct 14, 2023 at 07:11:59AM +0100, Gilbert Adikankwu wrote:
> > > > > Reported by checkpatch:
> > > > > 
> > > > > WARNING: else is not generally useful after a break or return
> > > > > 
> > > > 
> > > > What checkpatch is telling you here is that the "else" is redundant and
> > > > can be removed. Although your patch suppresses the warning, it makes the
> > > > code messier :(
> > > 
> > > Ah wait, after reading Julia's comment, I realize that the "else" is not
> > > redundant at all. Seems like checkpatch.pl is lying. So ignore what I
> > > said.
> > 
> > Thanks
> > 
> > 
> 
> Could you consider fixing checkpatch instead?

Parsing C is quite hard and checkpatch is never going to do it well.
It might be fun to start this project but it's kind of doomed.  Doomed
projects can be an educational experience as well.

The way to do it might be to add a new in_else_if variable which tracks
if you are in an else if block.  You would look at the indent level and
try the curly braces.  Then if the previous thing was an else_if silence
the warning.

But also it's fine that checkpatch prints the occasional incorrect
warning because it teaches people to be more careful.

Another thing is that when you introduce a bug, you should always
consider if other people have done that before as well.  Perhaps do
a `git log -p --grep "else is not generally useful"` and see if everyone
else did it correctly and if reviewers caught the mistakes.

regards,
dan carpenter


