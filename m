Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B2D7BC667
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 11:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbjJGJVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 05:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJGJVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 05:21:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1087B9;
        Sat,  7 Oct 2023 02:21:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31520C433C8;
        Sat,  7 Oct 2023 09:21:27 +0000 (UTC)
Message-ID: <eeeb183e-f6ed-4158-8852-04da5e452d9b@xs4all.nl>
Date:   Sat, 7 Oct 2023 11:21:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: v4l2-event: Annotate struct v4l2_subscribed_event
 with __counted_by
Content-Language: en-US, nl
To:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     lijian <lijian@yulong.com>, linux-media@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922174951.work.160-kees@kernel.org>
 <169662411867.2154917.2192633783167073007.b4-ty@chromium.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <169662411867.2154917.2192633783167073007.b4-ty@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2023 22:28, Kees Cook wrote:
> On Fri, 22 Sep 2023 10:49:52 -0700, Kees Cook wrote:
>> Prepare for the coming implementation by GCC and Clang of the __counted_by
>> attribute. Flexible array members annotated with __counted_by can have
>> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
>> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
>> functions).
>>
>> As found with Coccinelle[1], add __counted_by for struct v4l2_subscribed_event.
>> Additionally, since the element count member must be set before accessing
>> the annotated flexible array member, move its initialization earlier.
>>
>> [...]
> 
> Since this is a trivial change and it's been 2 week without further
> discussion, I'll snag this patch.

Ah, I picked this up for media as well. Same for the other patch.
You should have gotten an email from patchwork on Oct 3 that it was accepted.

I think I should be more pro-active and reply when I pick up patches from
non-media developers instead of relying on patchwork. It seems that it is
easy to miss emails from patchwork.

Regards,

	Hans

> 
> Applied to for-next/hardening, thanks!
> 
> [1/1] media: v4l2-event: Annotate struct v4l2_subscribed_event with __counted_by
>       https://git.kernel.org/kees/c/b1a20bbd4687
> 
> Take care,
> 

