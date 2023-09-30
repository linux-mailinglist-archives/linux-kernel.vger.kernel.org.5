Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4B7B43E1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 23:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjI3VPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 17:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjI3VPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 17:15:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A380BDA;
        Sat, 30 Sep 2023 14:15:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27730028198so2493288a91.1;
        Sat, 30 Sep 2023 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696108538; x=1696713338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/AUqgF8lMKzgSbvOmwzmjKFAxVhmDDJ8R8DNGFdnJYo=;
        b=EbrORv/6pH5tJv/kOpdrWssMD72sgZcMjgwRz2o4XcIudmgD8GyP+J5MCsP+ecErCl
         yB8GlxbXKCt3i7tGyTCraLlCZgG9BhCmElDNCHrPO6POStPM7kQrEw4+NLBs1CAj6EPJ
         +uCEyvucYesJtcBHh4LhepqWatqll2plznXkSshQxZB2wTio6snac7157VlnHF12Pa8N
         OPr9ksMFzcmvq8u38ee4LA8zKwdmWZxs4JiTozLYdqr44ZB/YflNhE3h4Sqz5Rc0dR0z
         qivf6ZcY/X1lVTWahygWBtBltmuudQ1OjQg3KHCSD8oNLoVYcZPR3C+3q77mp4HcClVA
         oZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696108538; x=1696713338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AUqgF8lMKzgSbvOmwzmjKFAxVhmDDJ8R8DNGFdnJYo=;
        b=bvflpAK7aTmPvAFkBACZhrqNzYkXlR4/P1WyaYxTwiAvgNYsDHjGYtJLN0MPsrs4T/
         Gt48aWLuYoJDLMuyX7+oKSiZ4kT5AZvCMNuuBd3GDoJjOIYRU0kPl81MxgLQEocCABww
         rpHuATRwt3n++EDqw3MI4DehQgZ0Go3Nlunarur5xmmEoExz8wj+u5g1g28WzgFQzWjC
         upywDWJMQGwUurrXZMrZRNF3FM0K2BqLRt03iJfog7rHArYPZiKciNWohCfOkg7Wizo1
         MNXZKskNp5PdNxldYoozR+WsVI9a3q+QfJLNUg+7qbO76uKqdPxdRPPImfcj869bK+vc
         fo+w==
X-Gm-Message-State: AOJu0YyOYGmgq7pVXIrnZlWOLzro4xtUVjWfEE8W6U5xNIHJ6K4+n2iT
        sMNfdRgzaWw/uej7pccUyHs=
X-Google-Smtp-Source: AGHT+IFzg3N3NlymADBVErUJad5Lw28dhPNubjAJ/iZFrgewTm9VUjI/uta7SmfeBC5q8Jqm95xTUA==
X-Received: by 2002:a17:902:dac8:b0:1c6:2902:24f9 with SMTP id q8-20020a170902dac800b001c6290224f9mr8852156plx.1.1696108537884;
        Sat, 30 Sep 2023 14:15:37 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id y24-20020a1709027c9800b001c3267ae31bsm19082666pll.301.2023.09.30.14.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 14:15:37 -0700 (PDT)
Date:   Sat, 30 Sep 2023 14:15:34 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     John Stultz <jstultz@google.com>
Cc:     Mahesh Bandewar
         =?utf-8?B?KOCkruCkueClh+CktiDgpKzgpILgpKHgpYfgpLXgpL4=?=
         =?utf-8?B?4KSwKQ==?= <maheshb@google.com>,
        Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/4] time: add ktime_get_cycles64() api
Message-ID: <ZRiP9mgFjLpKHj8N@hoboy.vegasvil.org>
References: <20230929023737.1610865-1-maheshb@google.com>
 <CANDhNCqb5JzEDOdAnocanR2KFbokrpMOL=iNwY3fTxcn_ftuZQ@mail.gmail.com>
 <CAF2d9jgeGLCzbFZhptGzpUnmMgLaRysyzBmpZ+dK4sxWdmR5ZQ@mail.gmail.com>
 <CANDhNCro+AQum3eSmKK5OTNik2E0cFxV_reCQg0+_uTubHaDsA@mail.gmail.com>
 <CANDhNCryn8TjJZRdCvVUj88pakHSUvtyN53byjmAcyowKj5mcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCryn8TjJZRdCvVUj88pakHSUvtyN53byjmAcyowKj5mcA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:06:46AM -0700, John Stultz wrote:
> But I still think we should avoid exporting the raw cycle values
> unless there is some extremely strong argument for it

Looks like the argument was based on a misunderstanding of what
CLOCK_MONOTONIC_RAW actually is.  So, please, let's not expose the raw
cycle counter value.

Thanks,
Richard

