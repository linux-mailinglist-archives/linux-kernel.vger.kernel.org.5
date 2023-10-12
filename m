Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBB87C6957
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjJLJVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjJLJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:21:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32E791;
        Thu, 12 Oct 2023 02:21:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BACC433C8;
        Thu, 12 Oct 2023 09:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697102473;
        bh=SbH4FF+AoysrqBe5kKWS7My653sdFw0g+bfWwXIpZZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKwC4DIp81mBmf/nnA1FLjrVqbEsPK970YamzftlRJTsIi9bcrkBdYbyQqu/j8Jwi
         MrqeGKEaSacHFGr3ZlV+8qz8+gEND1xEpj4+GGkOwjQ/nQ69sMzqSMaVFRe4fYIRvj
         H41/C6eJ6rrxh6ieRFuKsNQ0a1Tb9BD5wBiFDH80HfJZXd9ibWbbzSFlQ3rmYoG7Cl
         taQ3Zur00X1d7RWY/h1U+CtWA25Z2b9NWwwzKtDObQQu3hwo+0Zsj+jLl7JXYZHQvx
         7dkBHX9aFWiD87o0fFkXdSfFCm4mV/S63lpG2BiRxvhBBbTb8yiLQF3l4qIPLAjlTq
         UxSJSBiItIsYg==
Date:   Thu, 12 Oct 2023 10:21:07 +0100
From:   Lee Jones <lee@kernel.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/4] trigger: ledtrig-tty: move variable definition to
 the top
Message-ID: <20231012092107.GE8314@google.com>
References: <20230928132632.200263-1-fe@dev.tdt.de>
 <20230928132632.200263-4-fe@dev.tdt.de>
 <20231002140559.GB8453@google.com>
 <66ca9e2231629a72e098e1b17736ca34@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66ca9e2231629a72e098e1b17736ca34@dev.tdt.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023, Florian Eckert wrote:

> Hello Lee,
> 
> I only got reviews for the fixes and preparations for commits that change
> the
> tty subsystem, but no reaction from the maintainer of the feature I want to
> add to ledtrig-tty for v1 and v2 patchset.
> 
> How should I proceed? Send a v3 with the the requested changes.
> 
> [Patch v2 1/4]: https://lore.kernel.org/linux-leds/20230928132632.200263-1-fe@dev.tdt.de/T/#m913d3822465f35b54dfa24b1dfe4d50e61352980
> Change got a 'Reviewed-by: Jiri Slaby <jirislaby@kernel.org>'.
> Will add this to an upcoming v3 again.
> 
> [Patch v2 2/4] : https://lore.kernel.org/linux-leds/20230928132632.200263-1-fe@dev.tdt.de/T/#m7ee7618894a66fd3c89bed488a2394265a3f8df1
> I missed to add the robot error message to the commit message and also
> missed
> to add the the following 'Reported-by: kernel test robot <lkp@intel.com>'
> and
> 'Closes:
> https://lore.kernel.org/oe-kbuild-all/202309270440.IJB24Xap-lkp@intel.com/'
> to the commit message. Will add this to an upcoming v3.
> 
> And do not wait for the review of the following patches.
> https://lore.kernel.org/linux-leds/20230928132632.200263-1-fe@dev.tdt.de/T/#mc0ecb912fa0e59015ad0a9b4cb491ae9f18c1ea9
> https://lore.kernel.org/linux-leds/20230928132632.200263-1-fe@dev.tdt.de/T/#mba36217323c386ecd900e188bbdf6276c3c96c91

Yes.  I've removed this from my queue.

Better to resend it with the fixes.

-- 
Lee Jones [李琼斯]
