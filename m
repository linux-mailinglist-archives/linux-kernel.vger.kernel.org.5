Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281417D1FAF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 22:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjJUU5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 16:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUU5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 16:57:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1898D1A3;
        Sat, 21 Oct 2023 13:57:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A375C433C7;
        Sat, 21 Oct 2023 20:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697921828;
        bh=gqGmE6hmHvzhPKtWB4NehmQpHW7mbANBLZnc6WG6YJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyttQU58CWrhRfBzn9vkTAZne6ABof1EmVRLNkvpJdIPs5eDNlj1wKRidSFwBzBnO
         AcElIhIFTTsx0VKJu/qW9eKgw7AJybRw5xJZvJsZW68sWlaXzHGMP9YCkG3PZRj6hy
         CKVwQgMlzKAEJ1V7Fj8FhNrd6hqXCyGCHf8+e0fQ=
Date:   Sat, 21 Oct 2023 22:57:06 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] misc: rtsx: add to support new card reader rts5264
Message-ID: <2023102153-paramedic-washboard-29e3@gregkh>
References: <121ced554a9e4f4791018e8f6a72d586@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <121ced554a9e4f4791018e8f6a72d586@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 08:13:46AM +0000, Ricky WU wrote:
> In order to support new chip rts5264, the definitions of some internal
> registers and workflow have to be modified.

That is fine, but that should be a single patch, right?

> Added rts5264.c rts5264.h for independent functions of the new chip rts5264

And then add new support in a new patch, this is still too big as one
patch to attempt to review it properly.  Would you like to review this
as-is?

thanks,

greg k-h
