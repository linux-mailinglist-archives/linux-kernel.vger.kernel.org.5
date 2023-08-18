Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8B0780E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377819AbjHROpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377911AbjHROpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAF513D;
        Fri, 18 Aug 2023 07:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39FED67D6E;
        Fri, 18 Aug 2023 14:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C4CC433C7;
        Fri, 18 Aug 2023 14:45:10 +0000 (UTC)
Message-ID: <c79a2a0d-9510-b514-3b94-bc1d68e3d53b@xs4all.nl>
Date:   Fri, 18 Aug 2023 16:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] Improve V4L2 M2M job scheduler
Content-Language: en-US, nl
To:     Hsia-Jun Li <randy.li@synaptics.com>, linux-media@vger.kernel.org
Cc:     ayaka@soulik.info, hans.verkuil@cisco.com, tfiga@chromium.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        hiroh@chromium.org, linux-kernel@vger.kernel.org,
        nicolas@ndufresne.ca
References: <20230704040044.681850-1-randy.li@synaptics.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230704040044.681850-1-randy.li@synaptics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2023 06:00, Hsia-Jun Li wrote:
> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> 
> The first patch is an old patch, I resend it again.
> I want to make the work thats parses the bitstream
> to extract the sequence information or video resolution
> as a part of V4L2 schedule. Such a work would also
> consume the device's resources likes remote CPU
> time.
> 
> Although reuse a flag which no current driver may
> not be a good idea. I could add a new flag for that
> if people like that.
> 
> The second is a patch offering a generic solution
> for tracking buffers which have been pushed to
> hardware(or firmware). It didn't record which buffer
> that hardware(firmware) still holds for future
> decoding(likes the reference buffer), while it
> has been sent to the user(dequeue). We may need
> a flag for this work.

I am dropping this series from patchwork: clearly this generated
a lot of discussion, and I think that needs to come to a conclusion.

BTW, I believe that at minimum the codec-specific parts in
v4l2-mem2mem.c should be split off in their own source (v4l2-m2m-codec.c?).

I agree with Tomasz that mem2mem.c was originally for simple m2m devices,
and adding all sorts of codec specific code to that source doesn't make
it easier to follow.

Regards,

	Hans

> 
> Hsia-Jun(Randy) Li (1):
>   media: v4l2-mem2mem: add a list for buf used by hw
> 
> Randy Li (1):
>   media: v4l2-mem2mem: allow device run without buf
> 
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 30 +++++++++++++++++---------
>  include/media/v4l2-mem2mem.h           | 10 ++++++++-
>  2 files changed, 29 insertions(+), 11 deletions(-)
> 

