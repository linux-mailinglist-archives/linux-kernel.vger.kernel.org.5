Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA3275E4DF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 22:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGWUey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 16:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjGWUew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:34:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F267E47
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 13:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690144489; bh=XYiZJ2jot0aZ7DKW0zRairdqLpabOc0SityZqj2Qrtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMTIRSkEi66mlag/l6s26h0J6XJQZkLWDcWMt91mNzbGhhx/sTvydKatd4ButE/gB
         elkJwJ2mAPgWd0CoYmt6RJ8RyaBA0r3tD8FRgSb9zP+AZbU8nxkkmpl4IsW7z6HssQ
         Et8elkEHlKoiNRtM1cdU5+atcwVvf8vQVxMH9lOI=
Date:   Sun, 23 Jul 2023 22:34:49 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Wei Shuyu <wsy@dogben.com>
Cc:     ilkka.prusi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: WARNING: at mm/gup.c:1101 __get_user_pages in 6.4.3
Message-ID: <8fbc7879-09b2-4b1c-86e0-f8835b675843@t-8ch.de>
References: <CAJuPgPMp_B-TcBq0NWJcaL-aF4YEcJvx0ain7qVOLb-trVqrsQ@mail.gmail.com>
 <7c6b632270d0c250c5791a6db5dc3e9e@dogben.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c6b632270d0c250c5791a6db5dc3e9e@dogben.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-24 02:41:24+0800, Wei Shuyu wrote:
> I can trigger this reliably by visiting chrome://crash/
> 
> [  444.608793] ------------[ cut here ]------------
> [  444.608795] WARNING: CPU: 7 PID: 901 at mm/gup.c:1101

This should be the same as 
https://lore.kernel.org/lkml/202307041023.bcdbbfc0-oliver.sang@intel.com/

Which was triaged to the chrome crashpad library.

The false positive is also fixed on master with
commit 6cd06ab12d1a ("gup: make the stack expansion warning a bit more targeted").

> [..]
