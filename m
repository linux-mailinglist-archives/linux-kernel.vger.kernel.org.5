Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C150760C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjGYHmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjGYHmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:42:35 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9332117
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:42:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bba2318546so14308995ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690270941; x=1690875741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kewmDoSwKZcyBAfVPaIo9+Biv1FObKhjKX+FUtEeF3k=;
        b=PA+fK6qXbHqYwEPVsLMv/2Ju1Mxrp9vScm/JmrJ7HPHfkOnZsCfnzfbxllwJPkxjV1
         Hk+IVr0kEUHskUZVuUq0VBT5mNuJxc96HduKH0ezuRL7do8qgxgB5SJUIfF82pObwC+h
         DXogbpdgn4C88+PsK3UNW0ZRNiXMoH9yh1/8x+wkMS5HtFRThUCrNALaEnu6+1tC3zjg
         oljAojsu5/XpZUccb55Q7m1LgEJwQk8oQLqFk4Gtsd0p8otmccReDMDX0k/dXvdfJYN+
         1LRWKACoE9ytjmLGfZfsjzn8+flAvCFYSQ/A1/Xt8FrfiBLsq+M0dwuZn/P5E3gUNYnN
         GI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690270941; x=1690875741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kewmDoSwKZcyBAfVPaIo9+Biv1FObKhjKX+FUtEeF3k=;
        b=jxjIqPhpo5xw9i+4yNG8OHuj715cmCzSUuk1krztxAcdTHmuJTBRXqyNS/Y2BUcwL0
         db+HYhAnJx1grSiCqE53zXFbO6pcJEVzYNpktq7ynb2nE9XoycQIAniGklz5e6BaLciI
         IZqTYbdOd6Yrf4s9Sxta3IqmSU/5WBh+QTo4XcWrt74VmKBBfAruHxXeKtcdejzE46MO
         8pfhItO5y2sri8uT2zR8GjPhw0ep9PyVl2iCRnDnvgiGZWBZsP1aMyBZogA4rA68DQuP
         8TUVJrLnyDMi8/rrGQ8gRa/N+EaL3rIUMlQNpWkslFVHwkatzbVoL+vOKrpXpi8F8llq
         Dfgg==
X-Gm-Message-State: ABy/qLZzX4tDNintqjPLRtNe1Ws7PWCZCmfHNdyjtvtMdpsHNIa4gVhQ
        TGZXAltTtZjiYjXRznaUopeefQ==
X-Google-Smtp-Source: APBJJlHHSoNX8d5INhseTullEgrqBEXbHGAfAD9IQElyfVzOxJEv7mdJAxFRTer6Win8HqYFlgHQew==
X-Received: by 2002:a17:903:2341:b0:1b8:a31b:ac85 with SMTP id c1-20020a170903234100b001b8a31bac85mr15445663plh.41.1690270941395;
        Tue, 25 Jul 2023 00:42:21 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001b8a85489a3sm10254527pla.262.2023.07.25.00.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:42:20 -0700 (PDT)
Date:   Tue, 25 Jul 2023 13:12:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH V3 1/2] xen: Update dm_op.h from Xen public header
Message-ID: <20230725074218.zcgbkkx5pfgszimu@vireshk-i7>
References: <ffae9d7021829fea19fd93fda3c30b52b0af923e.1690190453.git.viresh.kumar@linaro.org>
 <1498bef6-ded0-1b1f-a5ca-e8755800b489@suse.com>
 <20230725070914.m3dxlokedrgjlgcu@vireshk-i7>
 <3770f13f-0621-48af-4c79-880a0ffaa8a6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3770f13f-0621-48af-4c79-880a0ffaa8a6@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-23, 09:18, Jan Beulich wrote:
> I question that use, btw, but it is not up to me to decide whether to
> accept such a layering violation in Linux. dm-op is, as its name says,
> for device models to use. Your intended use doesn't fall in that
> category, aiui. Imo the present contents of dm_op.h in Linux is indeed
> all a kernel is supposed to know about, unless it was to gain in-kernel
> device models.

Is there any other way by which an interrupt can be raised for the
guest VM ? I was only aware of this method and so implemented it like
this.

I am open to suggestions on this.

-- 
viresh
