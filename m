Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EE77B1258
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjI1GJk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 02:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1GJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:09:38 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD7899;
        Wed, 27 Sep 2023 23:09:36 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id E02EF1208E3;
        Thu, 28 Sep 2023 06:09:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 3CF0520025;
        Thu, 28 Sep 2023 06:09:32 +0000 (UTC)
Message-ID: <137a309b313cc8a295f3affc704f0da049f233aa.camel@perches.com>
Subject: Re: [PATCH v2 0/2] get_maintainer: add patch-only keyword matching
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com
Date:   Wed, 27 Sep 2023 23:09:31 -0700
In-Reply-To: <CAFhGd8rtnvipRVAKRQAEcyGqCknVmx+bd2NMT7mCuTZjhrqULA@mail.gmail.com>
References: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
         <5707f3bef3ecd8220a8bf7c8b72c72c53e65b666.camel@perches.com>
         <CAFhGd8rtnvipRVAKRQAEcyGqCknVmx+bd2NMT7mCuTZjhrqULA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: d7fqwmokkq5kfxxtzgzn3gegcormsb3p
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 3CF0520025
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+FqDn4VJxmBi1YH6dCdp9LKcI52YXn62E=
X-HE-Tag: 1695881372-161195
X-HE-Meta: U2FsdGVkX1+tEvnQKoggFUWcmCpgX3G0a9W3Z4uVrc8hP+JwscwmhypG7KnHNpTKQWK3KRDNiZbfQf0QrO0d56XXW8uV9mfXUxcp4xsh+Ti+LeI3aTm6tQHCkVWLEsm9cqpdvzX9s1dDgRkTYWBQdeuXlj/SPhhbrCWXTx7UZfw48op9U8K1kGXsbP1jMT43dCDlNxWFz1MSWj4hwjqShexodnNUAkLIIGfoa7vNEgKuGT8Mpi0WXL/DF7853BMBZFPekFeofrB1CsUVP/6infi05vulObR/6tnusNeWlDgcWR4jNBy9hxcNgXAj/CFXbW0dmWeHRvaPHlpfaM2Y06nFdoGOSfXgl9tAOSBp66a+JoVsQPOsTDSRGd5VDCNC
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-28 at 14:31 +0900, Justin Stitt wrote:
> On Thu, Sep 28, 2023 at 2:01 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Thu, 2023-09-28 at 04:23 +0000, Justin Stitt wrote:
> > > Changes in v2:
> > > - remove formatting pass (thanks Joe) (but seriously the formatting is
> > >   bad, is there opportunity to get a formatting pass in here at some
> > >   point?)
> > 
> > Why?  What is it that makes you believe the formatting is bad?
> > 
> 
> Investigating further, it looked especially bad in my editor. There is
> a mixture of
> tabs and spaces and my vim tabstop is set to 4 for pl files. Setting this to
> 8 is a whole lot better. But I still see some weird spacing
> 

Yes, it's a bit odd indentation.
It's emacs default perl format.
4 space indent with 8 space tabs, maximal tab fill.

