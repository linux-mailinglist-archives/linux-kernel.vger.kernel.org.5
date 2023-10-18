Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF07CDB50
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjJRMJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjJRMJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:09:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FC998
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:09:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5A9C433C7;
        Wed, 18 Oct 2023 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697630977;
        bh=ECoYOChLpMH0wQ/4Cp6xSH3pqN205jSH5KJ4idgqFLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7yCG907o4JmZqBBMGF6XzwrXWkNU9QDWw4rTcrvLHJnN3kUhv7VQhQWw8IN5f/OE
         //773GmKndlnuvUiSbBUgT8V2XNU7kIFnteZcL5egJyBz1GqisjXgLe49q3BA47hVe
         0o2/QCsKrC0x+f6qo96Mx4WGzWh4llFaLHoq76zx1P688ZBW06Qrb635YclnCPF4MB
         70VOFoG09ZjULw7gmhLdUE4ROJGQjE5vPD5sQ4iCwMU4EpcXZWB2hjbBrY8f6xIrdM
         l7x52D/ASmalqZYCEUjzx/uAEH8falEWi3k/0USLGMs70MGjYbdJMLuZNm+1tbnK9+
         4uXmuaenZACvw==
Date:   Wed, 18 Oct 2023 14:09:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Klara Modin <klarasmodin@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: fix mtime handing in __fat_write_inode
Message-ID: <20231018-wildfremd-vererben-77de947de51a@brauner>
References: <20231018-amtime-v1-1-e066bae97285@kernel.org>
 <CABq1_vhoWrKuDkdogeHufnPn68k9RLsRiZM6H8fp-zoTwnvd_Q@mail.gmail.com>
 <d727d2c860f28c5c1206b4ec2be058b87d787e4f.camel@kernel.org>
 <CABq1_vj4ewSP246V8-nEZMURgiNFtdChvwojRRPrp81e5P=J+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABq1_vj4ewSP246V8-nEZMURgiNFtdChvwojRRPrp81e5P=J+A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 02:03:11PM +0200, Klara Modin wrote:
> Den ons 18 okt. 2023 kl 13:55 skrev Jeff Layton <jlayton@kernel.org>:
> >
> > Many thanks for the bug report and testing! Do you mind if we add your
> > Tested-by: for this patch?
> >
> Not at all, please do.
> 
> Thanks,
> Tested-by: Klara Modin <klarasmodin@gmail.com>

Added, thanks!
