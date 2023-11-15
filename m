Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A3A7ED77A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjKOWoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKOWoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:44:14 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE69195
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:44:11 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77bb668d941so6730685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700088250; x=1700693050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PnPNvgYVe/a3KXEsnvx4GNWysFw45MMaqeVr2951f4Q=;
        b=XlkCkQTRQrayA+u8rRgICNJcT9kOdTf1G87HZs9BvjdaHpNVJ84Q5IPEee9tEq6V2Q
         QlboSang2I73/U1smTY2yLLJR3116OdJpm3yKCacKkBLjWk74mQOQs1PshL0Ys/QDE0q
         YHPaRTkazBrwX2PV1YeTDOGHu3PVqGdayIMZYnxTM1VFrkO4hzjBM0u/DX8vOqvRgY3E
         GT/6dwkGGANrKUV5DdMKGe6gw4nRpWauSEjCgBkXQ4znBwbzRggxzVktvYqKOzvRa2bG
         MaseNbnig/MmS5uMXYTwkkOpi64FhbzvPKh1hEYfhyd55Me0cENWZ83Yz71Y8K/pli2w
         D3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700088250; x=1700693050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnPNvgYVe/a3KXEsnvx4GNWysFw45MMaqeVr2951f4Q=;
        b=XmctVlHqHzlY1HAT+Bkp7goy1zT9yNCrCGiKi7jGO3MVWFyT+TOz/j1Yehc7cznpuG
         aAUiJ/jlw2Q1Zkj9g8ORYKLIPBIPdad1hUPs+G325pYa2ZVSHS005eSEFIgVrNrZGJFA
         i/Nm/V0CTeHC3YuzOnCEqyhpomDoVyWMwbRDsZDkVUNoLIsJ6es3f/8dP6aQ7VLrd/7m
         F3XsCcSyow5SzyE7NnBMH806ulQcscuDGbxYwYl5Pl+FIEDdcqTbos1YtdVZD3HLywm4
         iWLyzIwRUJ9Lg8Y4hK6mRYc7rDguaRnyZ1Ds8+dymyqgsuEUPjPEcu6d9qO0HwaV2Ccz
         02EA==
X-Gm-Message-State: AOJu0Ywic9ly9LCui36XjgZdPMdmOPy7ZhjJdujoB+xRZ4ewpBPVvb0P
        U8TVSeLQvO443lLWxtIMSBtamg==
X-Google-Smtp-Source: AGHT+IEXDa9AqDk6k23ASNVZlgKVGyl4b96qGCZ+OOAUM0YbtOUy7P5HZ7bH5z4OmceD3xsVsN2MMQ==
X-Received: by 2002:a05:620a:480e:b0:77b:c47e:727f with SMTP id eb14-20020a05620a480e00b0077bc47e727fmr7898555qkb.28.1700088250234;
        Wed, 15 Nov 2023 14:44:10 -0800 (PST)
Received: from localhost (ip-185-104-139-34.ptr.icomera.net. [185.104.139.34])
        by smtp.gmail.com with ESMTPSA id s19-20020a05620a16b300b00772662b7804sm3815744qkj.100.2023.11.15.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 14:42:58 -0800 (PST)
Date:   Wed, 15 Nov 2023 17:42:17 -0500
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     mripard@kernel.org
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        kernel-janitors@vger.kernel.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, kv-team <kv-team@linaro.org>
Subject: Re: [RFC] drm/tests: annotate intentional stack trace in
 drm_test_rect_calc_hscale()
Message-ID: <8489c4db-6639-43f5-b6c4-8598652cdce6@suswa.mountain>
References: <02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain>
 <CA+G9fYuA643RHHpPnz9Ww7rr3zV5a0y=7_uFcybBSL=QP_sQvQ@mail.gmail.com>
 <7b58926a-a7c3-4ad0-b8a3-56baf36939ca@kadam.mountain>
 <s4blvjs4ipcqdzodmgsbvgegqh2kxgdnoerpwthvc57hpsulu5@gb2kh7vbv7nq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s4blvjs4ipcqdzodmgsbvgegqh2kxgdnoerpwthvc57hpsulu5@gb2kh7vbv7nq>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:58:12PM +0100, mripard@kernel.org wrote:
> > But a similar thing is happening here where we have so many bogus
> > warnings that we missed a real bug.
> 
> IIRC, there was a similar discussion for lockdep issues. IMO, any
> (unintended) warning should trigger a test failure.
> 
> I guess that would require adding some intrumentation to __WARN somehow,
> and also allowing tests to check whether a warning had been generated
> during their execution for tests that want to trigger one.

I think this is a good idea.  I was looking at how lockdep prints
warnings (see print_circular_bug_header()).  It doesn't use WARN() it
prints a bunch of pr_warn() statements and then a stack trace.  We would
have to have a increment the counter manually in that situation.

I'm writing a script to parse a dmesg and collect Oopses.  So now I know
to look for WARN(), lockdep, and KASAN.  What other bugs formats do we
have?  Probably someone like the syzbot devs have already has written a
script like this?

regards,
dan carpenter
