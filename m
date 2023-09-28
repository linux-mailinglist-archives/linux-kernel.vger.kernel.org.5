Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817C17B11ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjI1FIn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 01:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjI1FIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:08:40 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6873B122;
        Wed, 27 Sep 2023 22:08:39 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id EFC084029A;
        Thu, 28 Sep 2023 05:08:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id F14042002B;
        Thu, 28 Sep 2023 05:08:34 +0000 (UTC)
Message-ID: <a3959ab9a9d44444c06ffd0f390cf95dc6bc7f6e.camel@perches.com>
Subject: Re: [PATCH v2 1/2] get_maintainer: add patch-only keyword-matching
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Wed, 27 Sep 2023 22:08:33 -0700
In-Reply-To: <CAFhGd8o8ihYeML6WpiE1-=eeXC+k1yzSEdA-WJXjwB-f9VcHoA@mail.gmail.com>
References: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
         <20230928-get_maintainer_add_d-v2-1-8acb3f394571@google.com>
         <bf9200e2fc9c55187f2b7661a3b5043f56b0deff.camel@perches.com>
         <CAFhGd8o8ihYeML6WpiE1-=eeXC+k1yzSEdA-WJXjwB-f9VcHoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: z1cb3daqrhj93sebxb4qaceau4s1d38b
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: F14042002B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/wBlyl1trwp8454zb4yglEYAVPoRqUPOE=
X-HE-Tag: 1695877714-321605
X-HE-Meta: U2FsdGVkX1/Kp44g5MsFDisPUMFqYNNo6ac8AUAQm42hMWCtwgJlcywvw+2OPjS1QJFm1PzyJL0pQioT1yGvQoEnqHmpb4LtUF/A29Aoonc5Xu2Sdb6uu/nwTWO68PRh1hVOJoa5y+Fl16SLZBO5s1rVcWoQwbY7C2Je5WHTV0TU7HLKHUVEIiR3OGFWjwD+AdUeStf8m4mMU9UioccZOa/ETNNuHvdXr/AiPLNMUXy47b9n0wf2PEIaJrj3vRJW3EE2M9CHCBsNVTYA/X881I09V8q/dKS84jPrZTO5/MWmcyInkGsCFgQXgS5Nzxzh6MHhWej1mr7PCct20fLIb1x7zg73TSgPwR0ZNmwqU2uoZjSE3EV5kBTtP20MQ51pY0iKkagFMR7zEitvX2d7BQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-28 at 14:03 +0900, Justin Stitt wrote:
> On Thu, Sep 28, 2023 at 1:46 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Thu, 2023-09-28 at 04:23 +0000, Justin Stitt wrote:
> > > Add the "D:" type which behaves the same as "K:" but will only match
> > > content present in a patch file.
[]
> > > My opinion: Nack.
> > 
> > I think something like this would be better
> > as it avoids duplication of K and D content.
> 
> If I understand correctly, this puts the onus on the get_maintainer users
> to select the right argument whereas adding "D:", albeit with some
> duplicate code, allows maintainers themselves to decide in exactly
> which context they receive mail.

Maybe, but I doubt it'll be significantly different.


> This could all be a moot point, though, as I believe Konstantin
> is trying to separate out the whole idea of a patch-sender needing
> to specify the recipients of a patch.

As I understand it, by using get_maintainer.

