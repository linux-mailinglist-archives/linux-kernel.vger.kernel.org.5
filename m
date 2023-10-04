Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E24E7B8B4F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbjJDSw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243740AbjJDSw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:52:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71092A7;
        Wed,  4 Oct 2023 11:52:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A96C433C8;
        Wed,  4 Oct 2023 18:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445542;
        bh=x4Pg5cXI3dCKI7KGq5PPllrfX7jO8ITvdEruIzR40UA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VzZFwcE3SXKBH55CeuvlpjLwmP1bWb8ikJ6s5jkw+LmkcV4L2zIXuppz7Hi1cLLyq
         KU4Im2Mx7mNHkm/LayF9xGz4oJpj/S+GfE8WjCE/ganc8cg8GrDvcKlKoh/csUH4B1
         qlL6g1N1r+ga0JBsk45D8vz4M5qJHxWKKh7qPXOkNlGs58KRHNOGTfP49X9pYhTQwk
         lb5sCiJIrlXGvB6CEryfmPXMZZX5IT6ttRQJSFZuBM2jYiQ+ge6y3gbFhJbHbIZj0t
         om9F8loyB34QmwIp+oWS70Q9SIHwbMLv/M2VRRFgHbHLsGsoTsRv1vSS6NJO0kalfs
         J6er07+2ZqL1A==
Date:   Wed, 4 Oct 2023 11:52:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, jschlst@samba.org,
        Doug Brown <doug@schmorgal.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] net: appletalk: remove cops support
Message-ID: <20231004115220.5c3776eb@kernel.org>
In-Reply-To: <20230927090029.44704-2-gregkh@linuxfoundation.org>
References: <20230927090029.44704-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 11:00:30 +0200 Greg Kroah-Hartman wrote:
> The COPS Appletalk support is very old, never said to actually work
> properly, and the firmware code for the devices are under a very suspect
> license.  Remove it all to clear up the license issue, if it is still
> needed and actually used by anyone, we can add it back later once the
> license is cleared up.

Nice, Doug and Arnd also mentioned this in the past so let me add
them to the CC as I apply this...
