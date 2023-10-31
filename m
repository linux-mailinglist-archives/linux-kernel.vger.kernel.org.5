Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A47DCB4C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjJaLC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJaLCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:02:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7975DC1;
        Tue, 31 Oct 2023 04:02:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF11C433C8;
        Tue, 31 Oct 2023 11:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698750173;
        bh=AUPbo52ebpfYsn9y2k1CRAadrJQ1kLwIo/nND/DXiUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHu5pvSCKVL1UpZ4Ih9+Rv/ffF0e4ucFFEHohvBxCQD4wws7SpkmrC84be7DL/hSV
         BeRyNkaz7jqOkUcY0ZnNafcsMHsIkm59t8WBgWpT8jfLJiK/PIEAogssDwNttEXV7C
         UXcuMhJ8GUPRJ7eN8JFFH4OdlN6TlWTrSF57zuNHxJMxMpDptjWQxleIuZL10938mm
         WjHdCjqTlgg/93rj9r8eYNtV0Diiyv2KONn0eUuO2+4y0HEJrK9Kxt5Ru/jXMGwkeD
         tUomc7YmmYRxcNjVaBfjiY06Gokcoa5OAxhYS+pJIE2U6JPUBzEvhqiQMNLJq7AzDh
         2fH0hmH3yFHkQ==
Date:   Tue, 31 Oct 2023 12:02:47 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <20231031-proviant-anrollen-d2245037ce97@brauner>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev>
 <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
 <20231019153040.lj3anuescvdprcq7@f>
 <20231019155958.7ek7oyljs6y44ah7@f>
 <ZTJmnsAxGDnks2aj@dread.disaster.area>
 <CAGudoHHqpk+1b6KqeFr6ptnm-578A_72Ng3H848WZP0GoyUQbw@mail.gmail.com>
 <ZTYAUyiTYsX43O9F@dread.disaster.area>
 <CAGudoHGzX2H4pUuDNYzYOf8s-HaZuAi7Dttpg_SqtXAgTw8tiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHGzX2H4pUuDNYzYOf8s-HaZuAi7Dttpg_SqtXAgTw8tiw@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The follow up including a statement about "being arsed" once more was
> to Christian, not you and was rather "tongue in cheek".

Fyi, I can't be arsed to be talked to like that.

> Whether the patch is ready for reviews and whatnot is your call to
> make as the author.

This is basically why that patch never staid in -next. Dave said this
patch is meaningless without his other patchs and I had no reason to
doubt that claim nor currently the cycles to benchmark and disprove it.
