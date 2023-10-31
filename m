Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440AC7DCBC5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbjJaL1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjJaL1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:27:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E2BDB;
        Tue, 31 Oct 2023 04:27:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D41F321AA3;
        Tue, 31 Oct 2023 11:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698751621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30knWgI7g6iE7LoSoi4ZZIFV7YnKnwQtSASUA8at7Tw=;
        b=Vym5b+HKQevF4Nz/d/59xFjiHqLQWMpoCkjXMFGkYacikmIDk2iwUaJ/KRmo+twaNgL7t5
        pjWawntVtuWE0WjXbx6USIJ3ubQSWgWnBGoN9ZZ3yC64p+YhPR4isq74K1xHcQu+FHlyd+
        Zn+Lu3Lp0L2mUwq34J6qLmY5sTMzDGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698751621;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30knWgI7g6iE7LoSoi4ZZIFV7YnKnwQtSASUA8at7Tw=;
        b=2bmeYfYw2Ro+UcRyWyN6cx3ub5NYOFwODxXw5/Ue8ZZTMCG/dcqs0nkHDD4MvFJbW5mrEl
        Bt0Sd/XaYow4euBA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4AA242CF31;
        Tue, 31 Oct 2023 11:26:59 +0000 (UTC)
Date:   Tue, 31 Oct 2023 12:26:58 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: dummy-tools: Add support for
 -fpatchable-function-entry
Message-ID: <20231031112658.GM6241@kitsune.suse.cz>
References: <20231030083222.28509-1-msuchanek@suse.de>
 <CAK7LNAQRQ41bXiBFViXE94gObx+3qu5xQxWTXKfO6NYj=v0=9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQRQ41bXiBFViXE94gObx+3qu5xQxWTXKfO6NYj=v0=9A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 03:08:53PM +0900, Masahiro Yamada wrote:
> On Mon, Oct 30, 2023 at 5:32 PM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > dummy-gcc does not produce the output
> > gcc-check-fpatchable-function-entry.sh expects. Add a base64 encoded
> > output of the second test.
> >
> > Fixes: 0f71dcfb4aef ("powerpc/ftrace: Add support for -fpatchable-function-entry")
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> 
> 
> 
> I prefer this one
> https://lore.kernel.org/linux-kbuild/20231030113416.5208-1-jirislaby@kernel.org/T/#u
> 
> 
> Does it work for you?

Yes, that also works.

Thanks

Michal

> 
> 
> 
> 
> 
> >  scripts/dummy-tools/gcc | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
> > index 07f6dc4c5cf6..8ab81a905cc2 100755
> > --- a/scripts/dummy-tools/gcc
> > +++ b/scripts/dummy-tools/gcc
> > @@ -73,6 +73,25 @@ if arg_contain -Wa,--version "$@"; then
> >         exit 0
> >  fi
> >
> > +if arg_contain -fpatchable-function-entry=2 "$@"; then
> > +       base64 -d <<-EOF
> > +       CS5maWxlCSI8c3RkaW4+IgoJLm1hY2hpbmUgcG93ZXI4CgkuYWJpdmVyc2lvbiAyCgkuc2VjdGlv
> > +       bgkiLnRleHQiCgkuYWxpZ24gMgoJLnAyYWxpZ24gNCwsMTUKCS5nbG9ibCBmdW5jCgkudHlwZQlm
> > +       dW5jLCBAZnVuY3Rpb24KZnVuYzoKLkxGQjA6CgkuY2ZpX3N0YXJ0cHJvYwouTENGMDoKMDoJYWRk
> > +       aXMgMiwxMiwuVE9DLi0uTENGMEBoYQoJYWRkaSAyLDIsLlRPQy4tLkxDRjBAbAoJLmxvY2FsZW50
> > +       cnkJZnVuYywuLWZ1bmMKCS5zZWN0aW9uCV9fcGF0Y2hhYmxlX2Z1bmN0aW9uX2VudHJpZXMsImF3
> > +       byIsQHByb2diaXRzLC5MUEZFMAoJLmFsaWduIDMKCS44Ynl0ZQkuTFBGRTAKCS5zZWN0aW9uCSIu
> > +       dGV4dCIKLkxQRkUwOgoJbm9wCglub3AKCWFkZGlzIDksMiwuTEFOQ0hPUjBAdG9jQGhhCglsd2Eg
> > +       MywuTEFOQ0hPUjBAdG9jQGwoOSkKCWJscgoJLmxvbmcgMAoJLmJ5dGUgMCwwLDAsMCwwLDAsMCww
> > +       CgkuY2ZpX2VuZHByb2MKLkxGRTA6Cgkuc2l6ZQlmdW5jLC4tZnVuYwoJLmdsb2JsIHgKCS5zZWN0
> > +       aW9uCSIuYnNzIgoJLmFsaWduIDIKCS5zZXQJLkxBTkNIT1IwLC4gKyAwCgkudHlwZQl4LCBAb2Jq
> > +       ZWN0Cgkuc2l6ZQl4LCA0Cng6CgkuemVybwk0CgkuaWRlbnQJIkdDQzogKFNVU0UgTGludXgpIDEz
> > +       LjIuMSAyMDIzMDkxMiBbcmV2aXNpb24gYjk2ZTY2ZmQ0ZWYzZTM2OTgzOTY5ZmI4Y2RkMTk1NmY1
> > +       NTFhMDc0Yl0iCgkuc2VjdGlvbgkubm90ZS5HTlUtc3RhY2ssIiIsQHByb2diaXRzCg==
> > +       EOF
> > +       exit 0
> > +fi
> > +
> >  if arg_contain -S "$@"; then
> >         # For scripts/gcc-x86-*-has-stack-protector.sh
> >         if arg_contain -fstack-protector "$@"; then
> > --
> > 2.42.0
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
