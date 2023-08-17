Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9231177FA28
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352633AbjHQPC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352729AbjHQPCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFE33A87;
        Thu, 17 Aug 2023 08:02:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F996673DE;
        Thu, 17 Aug 2023 15:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CCBC433C7;
        Thu, 17 Aug 2023 15:02:33 +0000 (UTC)
Message-ID: <bacb37eb-16ab-4643-bc67-9ecd9f21f4fc@xs4all.nl>
Date:   Thu, 17 Aug 2023 17:02:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] media: vb2: frame_vector.c: replace WARN_ONCE with a
 comment
Content-Language: en-US, nl
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>
References: <d5e1ee76-75b3-26cb-23ae-cf6ab40597b7@xs4all.nl>
 <CAHk-=wgR3JSopXha1pJh4dRDH-U+jHgqp1zy1nR8OovUQTJgWw@mail.gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <CAHk-=wgR3JSopXha1pJh4dRDH-U+jHgqp1zy1nR8OovUQTJgWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 16:56, Linus Torvalds wrote:
> On Thu, 17 Aug 2023 at 12:41, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>>
>> There are no reports of WARN_ONCE being issued for actual VM_IO cases, so
>> just drop it and instead add a note to the comment before the function.
> 
> Ack. That was meant to catch any (unlikely) strange users, but yeah,
> it can obviously be triggered by "intentional" strange users, ie
> syzbot and friends, so since there seems to be no sign of actual
> real-world use, just removing the WARN_ONCE() is the right thing to
> do.
> 
> I'm assuming I'll get this eventually through the regular media pulls?
> 
>                 Linus

Yes, that's the plan.

Regards,

	Hans
