Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBED800473
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377707AbjLAHKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjLAHKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:10:52 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4CE170C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:10:58 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cddc59e731so1654544b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701414658; x=1702019458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPeYY7yP4lwEckam/gxWhbSUYcJHiotQsNkzaHB7yV8=;
        b=MTeSglVW0tUkLYIf1tHsIuYg5fvKggya+jrd0J6QeVB7GVI80FQxTycf27+Q8qoz8j
         17G+RF7nXLGBk3/MAoalgFJa9OUt5uKXbVng5oR+LbpfYcKz8EeWrvpmZJJ7L6nOYj9e
         5166AAXUCaaR24RdqArHj+HR2T2Vc6jUWsi+XGEi+CQSI0cHfP2DCozR4bnDYJs4JM71
         ucQbFD+znWhMv6ZCl3haRJHMEy1jC2+FvmvLd4GPjLpnZP8/QzyskWvXo7MA2vpFkVOO
         E6D60JNRUxCGmBPgCqEzqmSCpENaOsWy6uwjfThBjsB8pim/Ndt9aJBo9s+fAa3jI24u
         e/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701414658; x=1702019458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPeYY7yP4lwEckam/gxWhbSUYcJHiotQsNkzaHB7yV8=;
        b=gYpQ9qV3cqVW0x0fs1abhkk6V2E/o+3WPa/2Cb6pNa+ppZ7WOzttLN98XTkphGuFhL
         zdRsiCkd23CCr7/RqqJa2zr3Onbz/vSRPhsJZX1Hcd87/Le6/3FLZC41BuWdok5UeXn0
         kguJtU1VtecsjaCHYQ12XALOByWWzg3jJLao5JXEhGrGrH20Ltudjcq3IsaFJmigDxlK
         Ycm+a6VZw2Z0FjY6hWsD07lI/+i58zO7L5aUFYQYW1+MXoQIgQwxhOWhr4/bVy2edwVD
         qemNzKYyLzXqDIOcXA65vBQx00YAIkJiWS6GXwgXzjQzRyBI7kEpTyoKhN0k0olOo5Kt
         DM2w==
X-Gm-Message-State: AOJu0YwkD5FYGElYYfeBBN2YLQd2S6ojtAohvrUOI6Gw62g2E1XPAdC/
        ukDHtJsSkGstgyTx9DlOz/ubsazWKPNwSWHFjzRqXg==
X-Google-Smtp-Source: AGHT+IHgR89G7K4srWE1joNruHuB/eKkiYOFI4uAzXcfg1xgA5r7uqYJl6NgQoDGpkUUNYMWGRXGCA==
X-Received: by 2002:a05:6a00:1590:b0:6cc:b448:3652 with SMTP id u16-20020a056a00159000b006ccb4483652mr20679946pfk.19.1701414657653;
        Thu, 30 Nov 2023 23:10:57 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id i5-20020aa787c5000000b006cb7e61cfa7sm2321617pfo.36.2023.11.30.23.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:10:57 -0800 (PST)
Date:   Fri, 1 Dec 2023 07:10:53 +0000
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
Subject: Re: [PATCH 10/21] binder: do unlocked work in binder_alloc_new_buf()
Message-ID: <ZWmG_XidVJ8XIeuH@google.com>
References: <20231102185934.773885-11-cmllamas@google.com>
 <20231107090818.258621-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090818.258621-1-aliceryhl@google.com>
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

On Tue, Nov 07, 2023 at 09:08:18AM +0000, Alice Ryhl wrote:
> I found a few issues in this patch:
> 
> Consolidating the overflow check into one if statement like this doesn't
> catch all cases of integer overflow. For example, if all three sizes are
> 9223372036854775816, then the computed size will be 9223372036854775832,
> so this would not trigger the overflow check.

Thanks for pointing this out, you are right.

I don't understand the reasoning behind using size_t for the uapi. It
just made things more complicated than needed. These sizes are much
larger than the maximum buffer size of SZ_4M.

Anyway, I've fixed this for v2.

> 
> Carlos Llamas <cmllamas@google.com> writes:
> >  	mutex_unlock(&alloc->mutex);
> > +
> > +	if (IS_ERR(buffer))
> > +		goto out;
> > +
> > +	buffer->data_size = data_size;
> > +	buffer->offsets_size = offsets_size;
> > +	buffer->async_transaction = is_async;
> > +	buffer->extra_buffers_size = extra_buffers_size;
> > +	buffer->pid = pid;
> 
> With this change, if there is a concurrent call to
> debug_low_async_space_locked, then there is a data race on the
> async_transaction field. Similarly for print_binder_buffer.
> 
> Perhaps these writes should be moved before the mutex_unlock?

Also fixed, thanks!

--
Carlos Llamas
