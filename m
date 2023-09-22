Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A127AADEE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjIVJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjIVJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:28:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFD5194;
        Fri, 22 Sep 2023 02:28:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3831BC433C9;
        Fri, 22 Sep 2023 09:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695374925;
        bh=1N0RINgSti7GRzCMQyRJ+M265Zpr0LcGBAeXkkytdkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A5NdbWWyfeQM/bF2iQ2T5AUgeg79reBVyxgFzUiKXbM67xK/NrTLd1oohP74mkBl1
         iIjMYzjzNI/6mPqWZp2kv3iCxemEu3ir0qK/ygNglaJS0Ti+WpoDhRR7vO6lNm3AYJ
         fN4lAXYOcKRM+UgWuVU5icQERgIgHYCTqwgI1luk=
Date:   Fri, 22 Sep 2023 11:28:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH] PM: hibernate: use __get_safe_page() rather than
 touching the list.
Message-ID: <2023092227-underline-gave-cbef@gregkh>
References: <20230921170045.4189251-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921170045.4189251-1-bgeffon@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 01:00:45PM -0400, Brian Geffon wrote:
> We found at least one situation where the safe pages list was empty and
> get_buffer() would gladly try to use a NULL pointer.
> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> Fixes: 8357376 ("swsusp: Improve handling of highmem")
> Cc: stable@vger.kernel.org
> 
> Change-Id: Ibb43a9b4ac5ff2d7e3021fdacc08e116650231e9

Please always use checkpatch.pl so that maintainers don't have to ask
you to use checkpatch.pl :(
