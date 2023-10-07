Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C82E7BC566
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbjJGHKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbjJGHKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:10:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D5CB9;
        Sat,  7 Oct 2023 00:10:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E38FC433C8;
        Sat,  7 Oct 2023 07:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696662617;
        bh=xeHnT2C9sh0AspYV0KkPiTMG27K+EQ5856aRmwIk09A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fMbgk3mvwmCKY+R93LchM3ZW+Lp4DVA55slkhxzmhqnr9EaXW9SolajgfqOOvMY3b
         LduunjkUaxB69wOJ6ZHKli0w4PwWDsmlN1FlDrucGV1YTL8DsmnbCYXD4Bey8M8ZEA
         uqIyTwP9PJOOYL9sUKASzMYu20O38sAVbx27jUcM=
Date:   Sat, 7 Oct 2023 09:10:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Zeng <zengyhkyle@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: nullptr-deference in perf
Message-ID: <2023100758-astronaut-comrade-9abe@gregkh>
References: <ZSDxDZR5hoaKTCdP@westworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSDxDZR5hoaKTCdP@westworld>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 10:47:57PM -0700, Kyle Zeng wrote:
> Hi there,
> 
> I found a nullptr dereference in perf subsystem and it affects at least
> v5.10 and v6.1 stable trees. (the same poc cannot trigger the crash in
> the mainline).

Can you use 'git bisect' to find the patch that fixes this?

thanks,

greg k-h
