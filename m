Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C557E80042C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377662AbjLAGwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAGwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:52:10 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3873171B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:52:16 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso169807a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701413536; x=1702018336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRkIzUVL8moRADOVLqm0jiXF7LpIsgbB7K5Hlu0moR0=;
        b=3emrjF8tq9YkovhG6MamCwPIG2D3nJ3WyiLVhWXophCXF1ftTYGkB8L/HK27oXqF3h
         Tuxg+02yLCiLNiJ70Ats7xdMaP566lcqGv+LNP2nAuaurXthDJm7+FzR4SnZHbqdL+uQ
         NKhOV9b3LxZb+pLxKfPZ6PTMTuZcV5HeNFGCyBrW0VW4GOk8dX29efOWOh7ckNE0KbSk
         svUah+yWjX89dfvwVCzx3rWI/JbviDrcq/hq5QOJmYhl80gpSQqwfQoWwWPm9i5I/MhR
         3NE1FNHZlKllbQ3vExn+Z6qV9Ij4cx8kFlFUlC8IqEHXvIgI0QGdMkX4W+mS1RKK8tTv
         bRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701413536; x=1702018336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRkIzUVL8moRADOVLqm0jiXF7LpIsgbB7K5Hlu0moR0=;
        b=DvZQ1SnuyGwOUkfp/kRUra1qwIJ3RoBrBA9RDW9Orarow+gOynp7PzozD6skcNjC3x
         rpBmU5LirPZtat0yJShWEF0PW5ai2fZil+pHbvCS3m9eXG6pl0P1lOHSfNRFPrC8Vkim
         D1h4lSvH9CJ9/9bz1iVfAie1uXwF+rWPLVhiiRKoLHXXDj4RfGo7aKiAiDlvlxpyz8Lm
         /3m5TGZVkgYbaQeIveXVhSYYeVAylLUxgT0Umq3OsQfWNMtghvJDaeSbYT7SGO/3WurX
         8Y9Avjm7xRc3JGRiQIEIJYkt9Spfk3FKK2iBLQp3hvzgHzik4VUWzztKF31VLJwSu0xT
         jnFQ==
X-Gm-Message-State: AOJu0YwGgjbFTS7VkK/ROAkI6g+WXJXzqOGtbp6QQMtv1JeHQuGJXc8F
        FOXP0RJr8q069jr0Ts5+lSDxjw==
X-Google-Smtp-Source: AGHT+IGWPGI675H9YKswKjhhnrgi5wfg1KyVPlIuzV/jrOYnGNKTcqiL4Toa+T/GI3sDDyN+6jrgig==
X-Received: by 2002:a05:6a21:99a7:b0:18b:208b:7043 with SMTP id ve39-20020a056a2199a700b0018b208b7043mr33191190pzb.49.1701413536061;
        Thu, 30 Nov 2023 22:52:16 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id y31-20020a056a00181f00b006cd82bddd9dsm2272486pfa.157.2023.11.30.22.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 22:52:15 -0800 (PST)
Date:   Fri, 1 Dec 2023 06:52:11 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>, Todd Kjos <tkjos@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 05/21] binder: fix trivial typo of
 binder_free_buf_locked()
Message-ID: <ZWmCm8zzqJkaop1Z@google.com>
References: <20231102185934.773885-6-cmllamas@google.com>
 <20231107090805.257105-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090805.257105-1-aliceryhl@google.com>
X-Spam-Status: No, score=-16.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:08:05AM +0000, Alice Ryhl wrote:
> It's a bit confusing that the pair of methods binder_alloc_free_buf and
> binder_free_buf_locked are inconsistent in whether they user the alloc_
> prefix. It might be worth it to change them to be consistent?

Right, the prefix is concistent across the APIs but not really for the
local function names. I wouldn't mind adding the "alloc" part, it just
seemed easier to fix the comment and backport that.

--
Carlos Llamas
