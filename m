Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33427D58D8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343912AbjJXQkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjJXQkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:40:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4ED118
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:40:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F35C433C7;
        Tue, 24 Oct 2023 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698165629;
        bh=rylJe4Rc3q0Rz0TuHurMIpDQo/OOGpbf+xH/9dzoVaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XpNTtW3fLW8m3HpDOZ82+nYQdXslJ/8hM19GCct+5xUPz3g2q/m03RAbCpOp49c/w
         8cH+Qk2Mvas8LXvo+WEq0nsanpF1cY9yZ3XknjRZI06VLksEPyyO+mhtkXMY151q+H
         ysWJuvtCCLCES3G9tNAQ7YeBZkFmbL5A6ANnCXITHqoY1FfwbY1rxCwjqWwLJDEGTa
         D2ZSyTd6ifZp52qGHRKkwUn60vQEvwVO1Z+QQ8zqD9v2z6xkxqZIdG9BsMb3yWppIA
         PnF8WYtNDk7gH8j947IZTAkBy4mCJbFmsXKE/tOvIPtx7r6NKl011xECiuUY4xyfN8
         YVuKpk0dA1bgg==
Date:   Tue, 24 Oct 2023 10:40:26 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, hare@suse.de
Subject: Re: [PATCH v2 0/3] nvme-tcp: always set valid seq_num in dhchap reply
Message-ID: <ZTfzetR5o_RUfJGK@kbusch-mbp>
References: <20231023140003.58019-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023140003.58019-1-shiftee@posteo.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 02:00:00PM +0000, Mark O'Donovan wrote:
> The first patch is a small unrelated fix which makes it clear that the
> response data section of the Success1 message is not optional.
> 
> The second patch removes use of the host sequence number (S2) as an
> indicator of bi-directional authentication.
> 
> The third patch causes us to always set the host sequence number (S2)
> to a non-zero value instead of the 0 value reserved for the secure
> channel feature.

Should these go in now for 6.6? We're pretty close to the end. If for
6.7, there is a merge conflict that I think would be easiest resolved if
I wait until the block tree resyncs after the 6.7 merge window opens.
