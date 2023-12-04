Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02A080379C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345986AbjLDOxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjLDOxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:53:37 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDAAA1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:53:43 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d06819a9cbso12857095ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701701623; x=1702306423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQOlfQnSbB5TCtBCKGGFhs8uxHpVYXRs+V4cIcLSkWk=;
        b=ewLdFtB2dXQMa9DnwhQ7dQfLrdDm+CWW7KrCgzsSTGFLz92JQCAvK8yY9l83CPL7oZ
         BKUDBE7kewwTcdDZXO6e8UhBegXOxtu03jlxgQ2CJjyxMOEFObdq4aWNCcXKQHLxqPck
         9ZJrkNwAks9cP8JgZhe6ccyGkdfzlgmXyXrcDKRHNb65yE0dJK1uyc09xXax2ZvqolMR
         esHNtoryNvPvQnS9yxmRUXw2de0NO6MnIVlP4Q85MrM6/2PlnxtQgmtQeQp7ZsHYcgOa
         vHG0j76TUd9h0GG3LNoNJHsIaEz85t+51X4Eqh7ccnax0JYj/cjex5Jqpi0HdmIfp8Nj
         /cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701623; x=1702306423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQOlfQnSbB5TCtBCKGGFhs8uxHpVYXRs+V4cIcLSkWk=;
        b=SI8LwbeiutvB+4V73Ydg39s1NPRNtdz8up5BywvRadTT4p0xFNK+rUpdKWLsVK422z
         T3CPMqr7y2s177VTDTOj1lePySgXKB31ipLY/T+MpPCp07xd1kXrvHGFUP7EAJA/Mkis
         IS5PiOYupD5cJ6lelVgoKUnNW424eweKAB2Y/n4Exa8XMWudHmVUK67swfQnxi8/9nNG
         8/+UGBeLKIDnGnWNZigQoNbCHR7SmB37NxEto8yj4XWe0DLO9O5GF/hBQJbO7KnSKwfT
         kBZIy4gQU4GnG0uzZSLHxwVjltBQD6QPMo5I7H3Yfk1itzydtmgBD8nmH6V1A6vZq/FB
         PLmg==
X-Gm-Message-State: AOJu0YxOEaNAwgkcunBQiRvDEE/ldOowL4qjow11mOOpDLdc5fAfbiZz
        1YSDpRQb0eqeIJ7OvpMz5yPbsA==
X-Google-Smtp-Source: AGHT+IHox/9kF8l9FG96W0KL+7akkXC0lZgYWpweHuKYWOPas9Cc+WmJIBJfYvUMHV5j/1FVKIILMw==
X-Received: by 2002:a17:902:ceca:b0:1d0:76f4:e41b with SMTP id d10-20020a170902ceca00b001d076f4e41bmr1544783plg.45.1701701623269;
        Mon, 04 Dec 2023 06:53:43 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ea8c00b001c736b0037fsm6727717plb.231.2023.12.04.06.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:53:42 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:53:39 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com
Subject: Re: [PATCH v2 23/28] binder: document the final page calculation
Message-ID: <ZW3n8w7L5ZJ_mlFK@google.com>
References: <20231201172212.1813387-24-cmllamas@google.com>
 <20231204115727.42370-1-aliceryhl@google.com>
 <ZW3kjj6KC73zpnw4@google.com>
 <CAH5fLgjmN4xYHZc=ZVdwOMMTEk4PwXwnqvXWSJrE1J-2xaKL7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgjmN4xYHZc=ZVdwOMMTEk4PwXwnqvXWSJrE1J-2xaKL7g@mail.gmail.com>
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

On Mon, Dec 04, 2023 at 03:43:54PM +0100, Alice Ryhl wrote:
> You could also just remove the `next_used_page` part entirely. This
> means that you will sometimes call `binder_lru_freelist_del` on a page
> that's in use, but that's just a no-op.

Yes, that is right and I did look into this. The WARN_ON(!on_lru) checks
are a bit confusing when it's a no-op as you mention. The purpose though
is to assert the "algorithm" of add/del pages from the lru is somewhat
correct (particularly the page range).

--
Carlos Llamas
