Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE87C4C22
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbjJKHlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344853AbjJKHlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:41:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC549D;
        Wed, 11 Oct 2023 00:41:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1273EC433C7;
        Wed, 11 Oct 2023 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697010063;
        bh=xojuYyZEzekfqidOZQDtyBJacPApzgvzcHgdq6gxwVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4CB4snjUny5nkzFFDsZr9tvsGDLPtVL+G1uPbUcJ0XVe9PoN5Nk9q0YWeByoIQys
         Bg+Z3hWYKvDbyvfcPt79U1JR+2B6h0m10LqEeHL4fOoOsbWeu7A8VRuLqVfL+90Pa/
         gqrtVFAjy/tBRUkg2Bk9h1Ez3mzSekZULbHpDvGs=
Date:   Wed, 11 Oct 2023 09:41:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-wireless@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Pavel Machek <pavel@ucw.cz>, Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
Message-ID: <2023101115-wackiness-gracious-00a2@gregkh>
References: <20231010155444.858483-1-arnd@kernel.org>
 <2023101051-unmasked-cleaver-79b3@gregkh>
 <87y1g94szz.fsf@kernel.org>
 <d081871c-977c-43e9-afa3-a3c3e5880fea@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d081871c-977c-43e9-afa3-a3c3e5880fea@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:24:55AM +0200, Arnd Bergmann wrote:
> Debian on the other just enables every driver, so there
> is no good way to know what they actually use.

Yeah, as you point out, we can't go by distro kernel configs as they
obviously error on the side of "build everything!".  But your openwrt
info is good, thanks for that, that's a huge hint that no one uses those
drivers anymore.

greg k-h
