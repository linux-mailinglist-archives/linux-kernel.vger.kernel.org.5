Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F711792B2D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbjIEQtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345430AbjIEEIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:08:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A5CCB;
        Mon,  4 Sep 2023 21:08:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so1838855f8f.0;
        Mon, 04 Sep 2023 21:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693886917; x=1694491717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2SDAUpknhys9o+6tPMB0iQft2FfIs0q3U3aWMpY+Rw=;
        b=kFCzvx1rB8rNTH0ey2839A7o04LLo0QpzLdQbB4Ie0zHyxH7ANUoe78q4v1qJNegFf
         kPhOqKDIK94F0pKMNL1/7/8dcRYH23AOj7Fa0DQw1c3KiUhVoDrPNCQalT/ogEoYfJC6
         Vxk6YuSdcum7pWm4I/3KzmDCAfK1gO0alQkjw9Ny0U46sC34ott92cNjSX0Al0KSM8iF
         aGVjxAhAw/iDHS12ychN/PrPhg0t/FNx+CFhUIf2UOwVvcwNRKH75uvtvdqhr1cGHTaL
         dQcLxF2bkydLW91qVNlzoiDNSY2zc4YFEpLZzgKaMGIhOM6cquO69qmwLBO9Mh9y/3wY
         QzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693886917; x=1694491717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2SDAUpknhys9o+6tPMB0iQft2FfIs0q3U3aWMpY+Rw=;
        b=lK/DHNGxsaB6vLm/8tgeEwLSnLXRDwXxtmqRBohIc9tzdICgVUpwLdW8D7ywz101YD
         Puj18sFxpuy8FC4q23dnLGs08LIgnpeNIkxofqMNTEbOLcv/sRjeO2AhA7tEFmngKR3X
         X5/md3oewGu0ObXdlki7OBwkWU9LaSnfkclIyOIXz2khkWtzKcDYbALo0pLDFnGCrao+
         nEDK7B2Ma4c2mpGZuyYuQ/F7tzTxQ1QK2sY27O3DcZsMHFZ3xjyXL1DtsXi8SSu5Bae+
         0u5klcROh2hqwcsPZQW1fGXobPLm7x2htP/LmvCSGdjYAMVyUlLvT+DvP1HDhyJRrVxr
         /40Q==
X-Gm-Message-State: AOJu0Yxl2R9ui2mvGBXm/4lj+/0x0qhqNpRft2LuXfD0Q8K6YByaIz6V
        h4uphWuQxPWzK2+9Or8kr3o=
X-Google-Smtp-Source: AGHT+IEhLMAL77uDRJa7fHqfmvc43+KTiHZ7By1R8NBsBj7DRTfZmee4HsR+96MVsm8712C/neD7zA==
X-Received: by 2002:adf:eac7:0:b0:31a:dbd1:bf6 with SMTP id o7-20020adfeac7000000b0031adbd10bf6mr8688921wrn.68.1693886917228;
        Mon, 04 Sep 2023 21:08:37 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id r19-20020adfa153000000b0031f2dea4810sm11819574wrr.61.2023.09.04.21.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 21:08:36 -0700 (PDT)
Date:   Tue, 5 Sep 2023 05:08:35 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] OpenRISC updates for 6.6
Message-ID: <ZPapw7PQse62TjT+@antec>
References: <ZPYuGlUw9K2PcShj@antec>
 <CAHk-=wgbKyC6DTA7OyrtbtuDELaxyJSatkKF75FGWJQGKqXWZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgbKyC6DTA7OyrtbtuDELaxyJSatkKF75FGWJQGKqXWZA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 03:37:31PM -0700, Linus Torvalds wrote:
> On Mon, 4 Sept 2023 at 12:21, Stafford Horne <shorne@gmail.com> wrote:
> >
> >   https://github.com/openrisc/linux.git tags/for-linus
> 
> Nothing new there. Forgot to push?

Oh Yes, I forgot to push.  the tag is pushed now.  Let me know if you need to send
another mail to trigger your process, ohterwise it is there.

I will figure out why my tooling didn't warn about the unpushed branch.

-Stafford
