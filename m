Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71DE7F2799
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjKUIgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKUIgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:36:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20FE11A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:36:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750A6C433C8;
        Tue, 21 Nov 2023 08:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700555803;
        bh=7oU59AhZacys6APydlz0Q8zZkl6P3NympOdU5R/Oc3U=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cpb9mDKcB5aYYed7/kjYr2pzaCQItJgAcs9utMW+k9X7jToQQgP7pHDWeSDu1pvd+
         IJFlrlA03ZbHNtnk9BzkOuDIGU3CEAk6xv1M6ASc0KATmaRIl5b+reje3db8mmgN8H
         TdnWxZvMVeAEwDhTAnZrg+6r3KaFPcLWzEQzqhduG/Tb7u56TW4SCdXb0gOEuqXjR+
         JP27xIXD2jLV807at3tVO0bjmPjI4XwFzWHMDmfbYdA0htNmacVaQMnM2Os/gD6PQH
         1UKyjaXhtG6C09i7ziufdGN2b38d6MHp9Ncua8TnvY7s/Sxc3VG/NSY9C74E6+lM4t
         xRPbVUGkWFcLQ==
Date:   Tue, 21 Nov 2023 09:36:40 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Charles Yi <be286@163.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: fix a crash in hid_debug_events_release
In-Reply-To: <20231031043239.157943-1-be286@163.com>
Message-ID: <nycvar.YFH.7.76.2311210936160.29220@cbobk.fhfr.pm>
References: <20231031043239.157943-1-be286@163.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023, Charles Yi wrote:

> hid_debug_events_release() access released memory by
> hid_device_release(). This is fixed by the patch.
> 
> When hid_debug_events_release() was being called, in most case,
> hid_device_release() finish already, the memory of list->hdev
> freed by hid_device_release(), if list->hdev memory
> reallocate by others, and it's modified, zeroed, then
> list->hdev->debug_list_lock occasioned crash come out.

I have applied the changelog changes proposed by Rahul and applied, 
thanks.

-- 
Jiri Kosina
SUSE Labs

