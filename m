Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DFF76A033
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjGaSSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjGaSSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:18:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9ADFB;
        Mon, 31 Jul 2023 11:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9310061253;
        Mon, 31 Jul 2023 18:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6403CC433C7;
        Mon, 31 Jul 2023 18:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690827528;
        bh=nA2HY/secIyeR0dLcyOtcvRUq6sWYkW9OKihqqNxehw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U1iKk8nbQaYdhqBScm+HXMK83XXkjFrwLj7DvJ5SFOMC2BtjhMynQwuValsxzeDYc
         kq90UBArG95KNlyEulM6VqUX02xlerzDHft2OmWFpmCZhapWQtUCtJGNvJV5/hAEmK
         8nRutoGpvZsbJKXnJShiorvC9evqGbHy5XvOSLf0vNNZO7VLzUfQcW/RHk6Hjtl38U
         bxeTa3Yzys4A8NgsK+qzNdXwhkaaJRKQj7Ek4bdBDhuonAxOkrTRxZIhYRSrZNesuM
         KTCtplGX4dJM7IoHD1FxInxfvZYPCpCrccYh0dIQwVC1CI5Iu0C0cWtqnVHn8otn2m
         NJU1fCyjy9wvg==
Date:   Mon, 31 Jul 2023 12:18:45 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        kernel-janitors@vger.kernel.org,
        Mark O'Donovan <shiftee@posteo.net>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [1/2] nvme-auth: unlock mutex in one place only
Message-ID: <ZMf7BUH3ZD+GA7TA@kbusch-mbp>
References: <20230727134748.4163796-1-shiftee@posteo.net>
 <28d11fc5-743f-0810-8ab7-3fa2a3f98c65@web.de>
 <20230731135152.GA6016@lst.de>
 <d51771bc-32a6-7424-ba02-bcc8ab9bf3f8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51771bc-32a6-7424-ba02-bcc8ab9bf3f8@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 07:46:25PM +0200, Markus Elfring wrote:
> >> Are imperative change descriptions still preferred?
> >
> > It doesn't fucking matter.
> 
> Do you exaggerate here?
> 
> If not:
> Does such a feedback really indicate that you would intentionally like to
> disagree with specific requirements from the Linux development documentation
> (for a discussed patch)?

The subject is already in the imperative voice, and there's really
nothing furthur to elaborate that would help justify this patch's
inclusion. I'm not sure what point you're trying to make here.
