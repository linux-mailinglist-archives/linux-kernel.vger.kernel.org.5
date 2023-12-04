Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37912803760
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345934AbjLDOqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjLDOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:46:25 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA2A1715
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:45:46 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d0b2752dc6so5409715ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701701146; x=1702305946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUpQLJnz6spGXdfudxXpxtAg2n16wZAxITJJuVJ6Obk=;
        b=0Rm75Cgsw/4P3YPiGJAbStwJNfEmwLnNbshQ63C732oublHCZC8slK7yE9fKiZbLo8
         Rvhcy+07EJyG3tFlw9VD/80xSp5lYZyKzrKcrzF+R5tPCAtadUWY76LN3q/dwYHSmG01
         8gF90WHn6Fmvyu4j2ruRoaRwiUr9POrRxWjOJOdeVd8UusmJzQswgpF5f4mo4u1JVvAA
         2Zql6qymcCAh05BCc3Np+xCRnLLVGxnTYdQq64p3ppDMj5jTDHHfQGy4LrYAjcPSpEoS
         yrO8R/8Ac0/QB7sBZ6sOBqSWZg3D2lCBnpi8WB/UJ25DDu7NWaGA/NV3V2V0nN3kMccA
         DRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701146; x=1702305946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUpQLJnz6spGXdfudxXpxtAg2n16wZAxITJJuVJ6Obk=;
        b=T/i/xXKRZqcMNo0fCbzLynS6ntIQXUm7P78MCDPnDrstTRHgGcaPVsO0napOjpNiuV
         RTai92cqJXBLH/C3H1pf1sz+JY7soX0GQPvu7/tUfBNz+wIE6txHgZxQqVdUHpiw7Ou+
         XYeNtTiCOT0iVlaD77OTuufrL9SA9PiTqiLYvikljicRD84nTc9SVpFmVmGwlLjOnjBh
         OVr5bndLgRtBt9gxS2EkICPpTLaXiPPVbeAcQC13fQQGVpRHJN0UwHxyiwSrzOYulyXe
         dDlHv/NHz9c3Qvds2oZR4Bl4OYAZXx5LnaUrg32WgiwEDs0HQcn5OFB8kWyU9od/pkQ4
         3UDA==
X-Gm-Message-State: AOJu0Yy5+Y7HZVy1QmtmPYpx8Ojgc8/e6DFnVa+ZAwGMjpxGMZTS0nPp
        YzNE23wSu/GKu98mjxAbpvKmrQ==
X-Google-Smtp-Source: AGHT+IFMhw39D7FsQnfjuN1rEiP/cQ7PQGGaO8SsRg4qsMyilMpHPeXlZ/v+BEqSMHezhM6bTol4OA==
X-Received: by 2002:a17:902:c405:b0:1d0:6ffd:9e09 with SMTP id k5-20020a170902c40500b001d06ffd9e09mr5259772plk.91.1701701145699;
        Mon, 04 Dec 2023 06:45:45 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001d087f68ef8sm3152842pll.37.2023.12.04.06.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:45:45 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:45:42 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com
Subject: Re: [PATCH v2 27/28] binder: reverse locking order in shrinker
 callback
Message-ID: <ZW3mFp2Zo85N8pBE@google.com>
References: <20231201172212.1813387-28-cmllamas@google.com>
 <20231204115743.43597-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204115743.43597-1-aliceryhl@google.com>
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

On Mon, Dec 04, 2023 at 11:57:42AM +0000, 'Alice Ryhl' via kernel-team wrote:
> > +	trace_binder_unmap_kernel_start(alloc, index);
> > +
> > +	page_to_free = page->page_ptr;
> > +	page->page_ptr = NULL;
> > +
> > +	trace_binder_unmap_kernel_end(alloc, index);
> 
> What are these trace calls used for? Previously they wrapped the call to
> __free_page, and happened after the `trace_binder_unmap_user_*` calls.
> 

It also used to wrap an unmap_kernel_range() call, which explains the
naming of the tracepoint I suppose. It looked like this:

	trace_binder_unmap_kernel_start(alloc, index);

	unmap_kernel_range(page_addr, PAGE_SIZE);
	__free_page(page->page_ptr);
	page->page_ptr = NULL;

	trace_binder_unmap_kernel_end(alloc, index);

My thinking was that we care more about the page->page_ptr clearing but
it sounds like we could just drop the tracepoint, we no longer have a
kernel mapped area.

--
Carlos Llamas
