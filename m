Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB3180D062
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbjLKQCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbjLKPZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:25:43 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131B6E3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:25:49 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67acdcb3ccdso33605756d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702308348; x=1702913148; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RnKL4o3KpZTzZRDhq/XTXx5OFfjh8+mhbmJEdr3M1y0=;
        b=Qw3tWCYTVCmHsEU/ecpIiA77ZnRoFsjRZU6l9F60D8lK45gOU30O9+A8bO+ODYDVAb
         lYUWm4HroeMVwJRQN3VXBeYNAvT03XoiKlJDdfV2sv4fusIBU5a9cp0yBuSnV3faWz1k
         jHNuxmVwM0TfOCZrOu3/MrN9sN5My8NcZa7Mx7ZN7JaYWo/BHDgaZYlDz+tJgoyDnW+e
         9westBZEwRltyXDdocp9R7n8W7wxxeha7cFGp9wrOx3kMV7z79yL13trfDZnAD9Zwm2Q
         1lZhjD6CPLTWTy4f9Yr7jqW8MYLd1amxm5y305IyCEypfLouZaWnYJt89fbHLFxsmmGC
         b/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308348; x=1702913148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnKL4o3KpZTzZRDhq/XTXx5OFfjh8+mhbmJEdr3M1y0=;
        b=Bn1++Fu18A5nE8wXtR4gQfVVCfAaPci+paEkOGrKU9dukSTEmSshfsU2VbSTUI4BIc
         bcJXgGFDl8m/0d7PhPpGIw3JIAVhQgzup0lBeqCs1zuO7ku6Q5oIyYA6fWYxmGjTBjtR
         g8ZoUmBZpYhOaN7evOZG5xaiAi+TS2tmETI+13Ixlm3NMPDPpYNhYsweqqWA7wos0SjA
         Fo/Eter6HlyP0Htx4Atqz0wmDahzymvqz9QNad8QGnTPngRLRuKTDvpF5CvgvPWjzBqp
         Ph4rYuAyVUsZWy3AW0YpV1ZMV8H45EYGB3snDi/wwa/4FJG5aqfjZKkGAo+OD1L9iCxE
         Zm2A==
X-Gm-Message-State: AOJu0YyqFNjjpbRXVfL5QfIAYPxVUASm8iRQNBGuug9LO7RaHDwlHsin
        qk1dSIXYpa9HIbqridsyNbagwQ==
X-Google-Smtp-Source: AGHT+IFBH7z3tXGGZRNgqPM/RvL+eXBGFEzwI0RePPMz6tIXVpWnP6XXwq3tI51ih5ycUdf1eDukDw==
X-Received: by 2002:ad4:5761:0:b0:67a:a721:b193 with SMTP id r1-20020ad45761000000b0067aa721b193mr7280280qvx.78.1702308348225;
        Mon, 11 Dec 2023 07:25:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id dd18-20020ad45812000000b0067a34a4dd3asm3365383qvb.130.2023.12.11.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:25:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rCiAF-00CcR7-Aw;
        Mon, 11 Dec 2023 11:25:47 -0400
Date:   Mon, 11 Dec 2023 11:25:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vacek <neelx@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/ipoib: No need to hold the lock while printing the
 warning
Message-ID: <20231211152547.GC1489931@ziepe.ca>
References: <20231211131051.1500834-1-neelx@redhat.com>
 <20231211132217.GF4870@unreal>
 <20231211132522.GY1489931@ziepe.ca>
 <CACjP9X8+CgoQRjs2Y9A+OwWCVxMhKyqzLhEjaguxMavHsy8VRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACjP9X8+CgoQRjs2Y9A+OwWCVxMhKyqzLhEjaguxMavHsy8VRg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:09:13PM +0100, Daniel Vacek wrote:
> On Mon, Dec 11, 2023 at 2:25 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Dec 11, 2023 at 03:22:17PM +0200, Leon Romanovsky wrote:
> >
> > > Please fill some text in commit message.
> >
> > Yes, explain *why* you are doing this
> 
> Oh, sorry. I did not mention it but there's no particular reason
> really. The @Subject says it all. There should be no logical or
> functional change other than reducing the span of that critical
> section. In other words, just nitpicking, not a big deal.
> 
> While checking the code (and past changes) related to the other issue
> I also sent today I just noticed the way 08bc327629cbd added the
> spin_lock before returning from this function and it appeared to me
> it's clearer the way I'm proposing here.
> 
> Honestly, I was not looking into why the lock is released for that
> completion. And I'm not changing that logic.
> 
> If this complete() can be called with priv->lock held, the cleanup
> would look different, of course.

complete() can be called under spinlocks just fine, AFAIK..

Jason
