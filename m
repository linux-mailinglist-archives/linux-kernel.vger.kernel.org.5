Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976697F9232
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjKZK3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:29:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F5FFD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:29:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B637FC433C8;
        Sun, 26 Nov 2023 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700994559;
        bh=f+nbJIhiGBaPFaiV+IIHo2OURbKlwrFmj3SbvRtEevY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CE+FzQ2TQ/1pNSPO/OWVj8T5lKg0890qO7mvXIZoMLNwjFMKmxLs5W/Y0x3OZvyve
         FiQuY8DYfp60px5dTcn6Ecrg9mdBHMLPEuEgN0SeUnLC0ZIg7IeAjp9Z/jPzv17rV8
         rXlA3FIyUKom5vwYJqa2gn7bcmldRJ47uXsJx414=
Date:   Sun, 26 Nov 2023 10:29:16 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gary Rookard <garyrookard@fastmail.org>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] staging: rtl8192e: renamed variable nDataRate
Message-ID: <2023112622-jigsaw-scrambler-d385@gregkh>
References: <20231125223432.13780-1-garyrookard@fastmail.org>
 <20231125223432.13780-5-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125223432.13780-5-garyrookard@fastmail.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 05:34:31PM -0500, Gary Rookard wrote:
> -u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
> +u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 n_data_rate)

Why are you keeping the "n"?  It's not needed, right?  Remember, these
were written in "Hungarian notation" which uses the variable name to
denote the type of the variable, so "n" means "number" perhaps?  So it
can be dropped.

thanks,

greg k-h
