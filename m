Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBFA800474
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjLAHMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLAHMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:12:13 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406DBB6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:12:20 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b83c4c5aefso126262b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701414739; x=1702019539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRj7rwJmjk4sqfGJObODWeeU/ipL8kGI/CkkCS5s80k=;
        b=YUw+3lDkapv+rqlKwig8FmO1OQPfmpGOq3/Ma4/ZRKdSGUfO0znJoj1/U3kxcdKjyN
         bbuNG540rrPyBrJVe0v3P9ZIVl7MJE793FQCcE1P+pM03MKrAv5QTv+/aQAXqbv2OsjY
         uLiDtewlSF3AZ3b6fcuYclEdOc/KYuioIPRY5d4mndH84b/rT28A1Ac6oAQioq4ZW/HZ
         vCXHMyHFxRtU8Ww7urJWzlfgN91h4iXNo6kp7OKeXP473M53ST76JAa5jsy+NRWaWcqr
         hszEY6W7t+QDGO4xgF7E7yo4yHdZG0c787P4tKe97MJ2CF05uVgUA8oAUS718nSBANCm
         LvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701414739; x=1702019539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRj7rwJmjk4sqfGJObODWeeU/ipL8kGI/CkkCS5s80k=;
        b=Pxc1d9QPbEYCRsOhfy1Z1JSORlFuDfFmajyTAQ+eAcsXwlxcw5mweYMEyQfer8h3Vx
         HsQKwU1isd74hIiNXax0aJ99jgWL92Ic/cdYgDSszk6qkXHxSwHEG86OoLkeVP+Folds
         gw+E+YS6FL3Sho/76g596UFe5LDjWtnsd+sEK+j8ugrrOy6S+Dtlia7PVY0WU0Vpv8IP
         M4Lr2k1Gv7/rVmcJ719m9FGWAC4UmS9BdyDNT7iDrLc/HG/Eeynw7YA1F+dWXFcqBs+D
         MR0mAalFwvThYKoO0Fueqdmy9pxkPZilfGB0gMv3JJDh0PsXKKsH4LfZGOLaK4+51BLv
         +ePw==
X-Gm-Message-State: AOJu0YysMOEEbPyE/HeaFM/yi5zsqStocQwCP1ls+z5OYrNvKx7aEYzh
        ADWa6kvACLg0CGPQP3I6SWoSrQ==
X-Google-Smtp-Source: AGHT+IHbAUNjcI5O42Ussg6bjp2iqSjWbcDPJMqMEgr5UrD7XRUfHOonN9NYYz9izgaelFDlmqV1dA==
X-Received: by 2002:a05:6808:1242:b0:3ae:5c89:dcc2 with SMTP id o2-20020a056808124200b003ae5c89dcc2mr2117772oiv.34.1701414739396;
        Thu, 30 Nov 2023 23:12:19 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id ff11-20020a056a002f4b00b006cb797722e6sm2326308pfb.109.2023.11.30.23.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:12:18 -0800 (PST)
Date:   Fri, 1 Dec 2023 07:12:15 +0000
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
Subject: Re: [PATCH 13/21] binder: relocate low space calculation
Message-ID: <ZWmHT4CfFdadT1bB@google.com>
References: <20231102185934.773885-14-cmllamas@google.com>
 <20231107090826.259454-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090826.259454-1-aliceryhl@google.com>
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

On Tue, Nov 07, 2023 at 09:08:26AM +0000, Alice Ryhl wrote:
> Carlos Llamas <cmllamas@google.com> writes:
> > Move the low async space calculation to debug_low_async_space_locked().
> > This logic not only fits better here but also offloads some of the many
> > tasks currently done in binder_alloc_new_buf_locked().
> > 
> > No functional change in this patch.
> > 
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> One suggestion below, but I'm fine either way.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> 
> Carlos Llamas <cmllamas@google.com> writes:
> > +		if (debug_low_async_space_locked(alloc))
> > +			buffer->oneway_spam_suspect = true;
> 
> You could avoid a branch here like this:
> 

Sure, sounds good to me.

--
Carlos Llamas
