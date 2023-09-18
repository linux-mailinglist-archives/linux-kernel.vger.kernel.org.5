Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609897A55A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjIRWKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRWKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:10:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE441A4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:10:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52c88a03f99so5801150a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695075034; x=1695679834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cdEF7nCED5R30iyTFsZxBU1Z4z2XSwzZIeAj9BGmVQM=;
        b=Mg/g8nh/E+XPgt1MNj86VHL22Fg+nzdo54jOi9tLzswkrfjIuFOB4+HzO78Ny7UEey
         wC8CmYy3RQIX79LNarFkoujPPitlULEw7jPibtl1N/M9Dn/anidAyxrQodx6aMkuxk9Z
         UxFWCFRcSB9E2tTlmg/ROFHkg+UJDESpOTTD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695075034; x=1695679834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdEF7nCED5R30iyTFsZxBU1Z4z2XSwzZIeAj9BGmVQM=;
        b=sXlsMpcoF2Nf2+YJ/eQnPW1tlozF8ZMyGwsk37TOWXW4meGkfA6OI27VtHkf5vMQf1
         exKThF+HOCiDZzOZwPOBqTSMwf4yctxOSEBG+yTcWbgjgWCZEWxFQ95HOXxQ1zcxxBHH
         fHLVxHg4oKXF3sOQb2jP+yRz+JscCm/ySr/BQvnh9rNjCRkF6Afc4/yTO2UBOUxLlcxI
         e4NBmI8YoDZUxlJtM8eKMn3SHw4i3z9eeWyNTFp8xTd8+mOtscj+HFlSPxQV0r84zymL
         WOEFWgf5huPmMqRnutSb/A5Tu6wVdGOvZiN4o0tLEDg87OwdzQQ2kqbpalXeYGUVyb2V
         v5uw==
X-Gm-Message-State: AOJu0Yw/CiwYsjV4DUeKjBYlf11msdYrgNqJxpkV32C7WuB0Q1NFcTjy
        KTk1JlCPeYyaJWoNxHY/P+a84XOu7rDYTTa396AdmHUb
X-Google-Smtp-Source: AGHT+IFl1JVoTYb9Vll1PdgmagP1VL7xwLDLwpmsxkt6fMcJ4etyPrm+j+svZ7E9TxfAfBw4cULZFw==
X-Received: by 2002:a05:6402:22d3:b0:530:8d55:9c6f with SMTP id dm19-20020a05640222d300b005308d559c6fmr8671633edb.2.1695075033980;
        Mon, 18 Sep 2023 15:10:33 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id ee17-20020a056402291100b005308fa6ef7fsm5058170edb.16.2023.09.18.15.10.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 15:10:33 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-31f7638be6eso4770706f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:10:33 -0700 (PDT)
X-Received: by 2002:a5d:66c3:0:b0:317:c2a9:9b0c with SMTP id
 k3-20020a5d66c3000000b00317c2a99b0cmr8618121wrw.50.1695075033116; Mon, 18 Sep
 2023 15:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
 <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com>
 <e321d3cfaa5facdc8f167d42d9f3cec9246f40e4.camel@kernel.org>
 <CAHk-=wgxpneOTcf_05rXMMc-djV44HD-Sx6RdM9dnfvL3m10EA@mail.gmail.com> <2020b8dfd062afb41cd8b74f1a41e61de0684d3f.camel@kernel.org>
In-Reply-To: <2020b8dfd062afb41cd8b74f1a41e61de0684d3f.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Sep 2023 15:10:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whACfXMFPP+dPdsJmuF0F6g+YHfUtOxiESM+wxvZ22-GA@mail.gmail.com>
Message-ID: <CAHk-=whACfXMFPP+dPdsJmuF0F6g+YHfUtOxiESM+wxvZ22-GA@mail.gmail.com>
Subject: Re: [GIT PULL] timestamp fixes
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 13:56, Jeff Layton <jlayton@kernel.org> wrote:
>
> We may have a problem with the ctime update though, since you pointed it
> out. We have this in inode_set_ctime_current(), in the codepath where
> the QUERIED bit isn't set:
>
>                 /*
>                  * If we've recently updated with a fine-grained timestamp,
>                  * then the coarse-grained one may still be earlier than the
>                  * existing ctime. Just keep the existing value if so.
>                  */
>                 ctime.tv_sec = inode->__i_ctime.tv_sec;
>                 if (timespec64_compare(&ctime, &now) > 0)
>                         return ctime;
>
> The ctime can't be set via utimes(), so that's not an issue here, but we
> could get a realtime clock jump backward that causes this to not be
> updated like it should be.
>
> I think (like you suggest above) that this needs some bounds-checking
> where we make sure that the current coarse grained time isn't more than
> around 1-2 jiffies earlier than the existing ctime. If it is, then we'll
> go ahead and just update it anyway.
>
> Thoughts?

Ack, that sounds about right to me.

Christian - I'm just going to assume that you'll sort this out and
I'll get a new pull request at some point. Holler if you think
something else is needed, ok?

              Linus
