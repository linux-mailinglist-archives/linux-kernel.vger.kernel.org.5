Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B0A807120
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378611AbjLFNrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378530AbjLFNrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:47:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15FFD4F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:47:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48689C433C7;
        Wed,  6 Dec 2023 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701870444;
        bh=pN7ek/mF4Oc2DQGrSxYppSDy2KSxkWe9q08aNujDOf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jd4z+QBc8VWOIMuZ7yOWg1WhiF/HO0ejs5m34x9xAZGHeqT9sds1JobDii52CWUNF
         K/Uv1RajgOejBlAW/B/n4/jO8ubSb5yP4v8tvLWGiXWX/4FCw40OtqtWKOmEbs8m5m
         Ynzs+yYj2LMtjNmlgg64T7JL7rwhkh13fA1b3W5QASdTvD+biyWdLtpehhZJwMywxT
         oSpr5j2d/PdYOG2WYdYCJ5x/pD97Ox0/qGeeIsoOBGQ3yN3npZRL+VZbGJ5VfFC1q2
         TwdXoVgukkE1CRGIKVEraeXTg/zOpeuq58A/zW0R5K43QHbENJbH9JASGFzZ0crlx9
         bLUwMEcTwMd7g==
Date:   Wed, 6 Dec 2023 13:47:19 +0000
From:   Lee Jones <lee@kernel.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, m.brock@vanmierlo.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [Patch v8 0/6] ledtrig-tty: add additional tty state evaluation
Message-ID: <20231206134719.GF3375667@google.com>
References: <20231109085038.371977-1-fe@dev.tdt.de>
 <170142723852.3350831.6373465907279189004.b4-ty@kernel.org>
 <8acd2694429af4f7205db7d7bb39eab6@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8acd2694429af4f7205db7d7bb39eab6@dev.tdt.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2023, Florian Eckert wrote:

> 
> 
> On 2023-12-01 11:40, Lee Jones wrote:
> > On Thu, 09 Nov 2023 09:50:32 +0100, Florian Eckert wrote:
> > > Changes in v8:
> > > ==============
> > > - As requested by greg k-h [6], I have send the patch 2/7 of this
> > > series
> > >   about the memory leak also to stable.vger.kernel.org [7]. This has
> > >   already received a 'Reviewed-by' from Uwe [8].
> > > - As requested by Maarten, I have adopted his suggestion to invert
> > > the LED
> > >   blink, so that I do not have to save the 'state' in the tty data
> > >   struct [9].
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/6] tty: add new helper function tty_get_tiocm
> >       commit: 5d11a4709f552fa139c2439fead05daeb064a6f4
> > [2/6] leds: ledtrig-tty: free allocated ttyname buffer on deactivate
> >       (no commit info)
> > [3/6] leds: ledtrig-tty: change logging if get icount failed
> >       (no commit info)
> > [4/6] leds: ledtrig-tty: replace mutex with completion
> >       (no commit info)
> > [5/6] leds: ledtrig-tty: make rx tx activitate configurable
> >       (no commit info)
> > [6/6] leds: ledtrig-tty: add additional line state evaluation
> >       (no commit info)
> 
> I think that was a mistake? Patchset v9 is the correct patchset [1]?
> 
> Thanks for applying v9 [1]

It's automated.  Not sure what happened now.

Please check to ensure the correct set was applied.

-- 
Lee Jones [李琼斯]
