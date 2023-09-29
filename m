Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C667B2A61
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 04:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjI2Cum convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 22:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2Cul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 22:50:41 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B5A199;
        Thu, 28 Sep 2023 19:50:39 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 700051610EE;
        Fri, 29 Sep 2023 02:50:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id A544A20027;
        Fri, 29 Sep 2023 02:50:34 +0000 (UTC)
Message-ID: <6691251158ab59ba4090de26012c34788df8f2ed.camel@perches.com>
Subject: Re: [PATCH v2 0/2] get_maintainer: add patch-only keyword matching
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com
Date:   Thu, 28 Sep 2023 19:50:33 -0700
In-Reply-To: <CAFhGd8rrHp1V4NpExpdNwWV4FAdLYhixLMB5HGygNSe7NKPUMA@mail.gmail.com>
References: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
         <5707f3bef3ecd8220a8bf7c8b72c72c53e65b666.camel@perches.com>
         <CAFhGd8rtnvipRVAKRQAEcyGqCknVmx+bd2NMT7mCuTZjhrqULA@mail.gmail.com>
         <137a309b313cc8a295f3affc704f0da049f233aa.camel@perches.com>
         <CAKwvOdnGzTvSXf7VeyG8tPEONpqSgkDiBTmgJbUUWsRHzbc5JQ@mail.gmail.com>
         <CAFhGd8rrHp1V4NpExpdNwWV4FAdLYhixLMB5HGygNSe7NKPUMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: A544A20027
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: 5xixkbu59k9o8g7sqycinttjxqw69de6
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18SMS8seIrSvtwoS3n4bmBAsLDqJtnCq64=
X-HE-Tag: 1695955834-846205
X-HE-Meta: U2FsdGVkX18yDD9OHLgsbFvLnLfxCEVZlzJH7frzznTv2PLAc9oPZBsnOZMoVzeqJ6GrO9u0urcGMWlpUJOsNV8cHdPcO9Rlby8zWFvaHRENI/QC06GW1s6hiL29LgEQ24lNFom3TTRM+Ae3luf2W4A0fCuh0mL+OaCVPIFY/euP99U5NEDeaWIo7FNcdzswBG1HkKPrOHXQxe5xYEAyxxWCziTXXh1dblXiZXeEG5SNV6VvETd2NrhNzvnC5GE9v7K5HFYyhmAQBasTzehGvpdEDCObr+joSmG2gjZ3QgyKPgKvDTi09i/a34rb/08cIlXU2jQ4GNLj+CV2KIMs7DwWGLe0J6PRLD8fV19JkAL9x3TXQ5AqR4mING2bBAmIBPGpv5R6H6J963fU3CXO5a8dkrIUZMPkXkDgCUX6ZrU=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-29 at 11:07 +0900, Justin Stitt wrote:
> On Fri, Sep 29, 2023 at 12:52 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > 
> > On Wed, Sep 27, 2023 at 11:09 PM Joe Perches <joe@perches.com> wrote:
> > > 
> > > On Thu, 2023-09-28 at 14:31 +0900, Justin Stitt wrote:
> > > > On Thu, Sep 28, 2023 at 2:01 PM Joe Perches <joe@perches.com> wrote:
> > > > > 
> > > > > On Thu, 2023-09-28 at 04:23 +0000, Justin Stitt wrote:
> > > > > > Changes in v2:
> > > > > > - remove formatting pass (thanks Joe) (but seriously the formatting is
> > > > > >   bad, is there opportunity to get a formatting pass in here at some
> > > > > >   point?)
> > > > > 

LG G7 Battery Replacement | Guide | Is it actually a Samsung? I t
> > > > > Why?  What is it that makes you believe the formatting is bad?
> > > > > 
> > > > 
> > > > Investigating further, it looked especially bad in my editor. There is
> > > > a mixture of
> > > > tabs and spaces and my vim tabstop is set to 4 for pl files. Setting this to
> > > > 8 is a whole lot better. But I still see some weird spacing
> > > > 
> > > 
> > > Yes, it's a bit odd indentation.
> > > It's emacs default perl format.
> > > 4 space indent with 8 space tabs, maximal tab fill.
> > > 
> > 
> > Oh! What?! That's the most surprising convention I've ever heard of
> > (after the GNU C coding style).  Yet another thing to hold against
> > perl I guess. :P
> > 
> > I have my editor setup to highlight tabs vs spaces via visual cues, so
> > that I don't mess up kernel coding style. (`git clang-format HEAD~`
> > after a commit helps).  scripts/get_maintainer.pl has some serious
> > inconsistencies to the point where I'm not sure what it should or was
> > meant to be.  Now that you mention it, I see it, and it does seem
> > consistent in that regard.
> > 
> > Justin, is your formatter configurable to match that convention?
> > Maybe it's still useful, as long as you configure it to stick to the
> > pre-existing convention.
> 
> Negative, all the perl formatters I've tried will convert everything to spaces.
> The best I've seen is perltidy.
> 
> https://gist.github.com/JustinStitt/347385921c80a5212c2672075aa769b6

emacs with cperl mode works fine.

I don't know much about vim, but when I open this file in vim
it looks perfectly normal and it's apparently properly syntax
highlighted.

