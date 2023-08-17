Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E4777F20B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348847AbjHQIZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348866AbjHQIZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:25:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0962D70;
        Thu, 17 Aug 2023 01:25:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D2191F891;
        Thu, 17 Aug 2023 08:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692260702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TmocHHvNgZSEHajeJTwl4x/GbVKpBHV2b0XjC5ZX+Fc=;
        b=AuCz21+t7b0SH96ljESLfRcjEvH/pmmF/vfamLPSMFsQhoJ8iP/7stTQcnloeDTEUhU59E
        KmnTSSBP70NB03NrePyda77ebDHVMeyhjBr6GDHbw36uHanIla2Gg+JiN9gWom6PCB0BrR
        B+smquGO2ZhnwyL6npMdP0hDkuzTwKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692260702;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TmocHHvNgZSEHajeJTwl4x/GbVKpBHV2b0XjC5ZX+Fc=;
        b=3L9sn6D6nNu1JLyt0G7q4pvJhAtyFKqehmo1xIOqeu6/NbO0tCzBx1omKFBk5D7Sdo8pa5
        AZZamwf2USjNq8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29F2E1392B;
        Thu, 17 Aug 2023 08:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6dK6CV7Z3WQ/VAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 17 Aug 2023 08:25:02 +0000
Date:   Thu, 17 Aug 2023 10:25:12 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v3 00/13] Switch to allowed_host
Message-ID: <5h333eqhtw252sjw6axjewlb5bbb5ze7awekczxe3kie2lnhw6@manyer42khct>
References: <20230811093614.28005-1-dwagner@suse.de>
 <1098c6a6-50cb-8704-9041-03c431155dfb@grimberg.me>
 <6e3i34utxot67jod2opzksdufcnfypycule5kkrcfaezxxvyg4@ixifxnti4wqy>
 <ky6hb7se4hd5hgvwd7uwxm6pxgznxo5jp4fjr474qf3pepoipo@g2g2wtb2hvn3>
 <ly6ksjwuh5jzju6hsvos35b7rmj43gpdyjbp23s4qoi3ups5eh@zx2s3bkznujc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ly6ksjwuh5jzju6hsvos35b7rmj43gpdyjbp23s4qoi3ups5eh@zx2s3bkznujc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:58:58AM +0000, Shinichiro Kawasaki wrote:
> On Aug 16, 2023 / 21:18, Shin'ichiro Kawasaki wrote:
> [...]
> > I think the 13th patch worth spending some more time, and other 12 patches
> > from 1 to 12 have consensus. If there is no other voice, I will apply the
> > patches from 1 to 12 tomorrow.
> 
> I've applied the patches from 1 to 12. Of note is that I added "export" to the
> new, three def_* variables in nvme/rc to avoid shellcheck warnings.

Thanks. This one of the reasons why I included patch #13, to use these
newly introduced def_* variables.

> Anyway, thank you for the clean up and fixes!

You're welcome!
