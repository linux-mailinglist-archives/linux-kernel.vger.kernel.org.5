Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECA6800445
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377676AbjLAHDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjLAHDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:03:14 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DEE10FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:03:20 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cde14ff73bso1505972b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701414200; x=1702019000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMEdf1FdkV1e8UjaU/Z2KGnMvmVIdcPbO53kxg05dm4=;
        b=PlxD4pxW1zioe7ZA8nFQTDr7leJ0aRd8o2wq+0qSpaI87Gar5IPsx6fXNGCkmZH9ed
         h1RUq3vKxg2xgYx6vDYlnmYBAngy14aAK4FLx+ktDrEAIzwY59eycMapAexHcZosCFYo
         X/b+qaxXKCbOSQgDkjQIFD+6LPQG6hoiTTyMYgftduUsJiTA45iNXb6e1NEpKhh50N3k
         UycxWIKVx9HOo44RXENtYXcTeNc5rnzHwPwq7XRKWTdX1oIfCGBAgZvFucJWX38cRahI
         wd7asjVEh7t1HMrsit+o0IuV+dPSuH2c647sZdfyuJ+a0V+IexjyWNTqfVMchi2O29Go
         bj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701414200; x=1702019000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMEdf1FdkV1e8UjaU/Z2KGnMvmVIdcPbO53kxg05dm4=;
        b=nM7tua2hmnWGrOqifK1JZLQEaKkCcZsJLGdCqMDUqn6Os98UQWXzRVh18a69qckt+1
         Ki5HjnVbZQIGvP/U9FOU/MwWXtk1bHd/MyzNh75EjL260Kz0ra4CEF08ljGEOK5fIiT3
         7vVTNwpxno26ME95eTHV9JKm3cX9AXiInIYJ+2KTz5ni7xL37HMrEX/RQwScyqQqsz9i
         vsq+uddIh/EhJ6qE0u9Uw+mNC+YYVISY3M3FP8hlHS0NmsS5FUjE9xzhovz0XPQ+sIZ/
         y1yagADLc0qlZ+2yJU9wYxrVEbIT7Dcf3XBns00Z+TxC8DSxIltL7Q1O9WuOIpY3h6NX
         uPJw==
X-Gm-Message-State: AOJu0YwQO1sr6zcX99tz2Ax/yQReNAMvZ216nhBe73CYa4ytDNr9Pqwe
        SxNJFcT3ODm7sJbkd6qksIL2Fg==
X-Google-Smtp-Source: AGHT+IHIMoa6YBxzhRTUFUYU42GWFywLHqejzOWeKWw0oV+KzBy6D9BO8WmZuhAG8hi7n8le9F7qaQ==
X-Received: by 2002:a05:6a20:729c:b0:187:a455:2758 with SMTP id o28-20020a056a20729c00b00187a4552758mr26864579pzk.30.1701414199718;
        Thu, 30 Nov 2023 23:03:19 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id y11-20020a62f24b000000b006cde1cef719sm2276188pfl.152.2023.11.30.23.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:03:19 -0800 (PST)
Date:   Fri, 1 Dec 2023 07:03:15 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
Subject: Re: [PATCH 09/21] binder: split up binder_update_page_range()
Message-ID: <ZWmFM8R2di2252k8@google.com>
References: <20231102185934.773885-10-cmllamas@google.com>
 <20231107090815.258324-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090815.258324-1-aliceryhl@google.com>
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:08:15AM +0000, Alice Ryhl wrote:
> Carlos Llamas <cmllamas@google.com> writes:
> > The binder_update_page_range() function performs both allocation and
> > freeing of binder pages. However, these two operations are unrelated and
> > have no common logic. In fact, when a free operation is requested, the
> > allocation logic is skipped entirely. This behavior makes the error path
> > unnecessarily complex. To improve readability of the code, this patch
> > splits the allocation and freeing operations into separate functions.
> > 
> > No functional changes are introduced by this patch.
> > 
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> The part below err_vm_insert_page_failed was a bit tricky, but I agree
> that this is correct.

Yes, this was a big reason behind this patch.

--
Carlos Llamas
