Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB17FA8F8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjK0S2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjK0S2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:28:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4A419B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:28:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E18C433C8;
        Mon, 27 Nov 2023 18:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701109693;
        bh=A1PpNtdBImkzeODYZiAdcGuZw6cwms+82GS4BsmUzsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KaZb2CEJYoixhHKDThGpqB6fr1ifr+9M9JlqykhmcD988oXFfIaI6+FCd3G4SAjBj
         u5+tL8hKK0BWo0+GP5MZ5hIFmybklJAShm29WnMtf54/kKiPgkGCRESR95Tz5Vj8xP
         LfYYkZtQIgrwOlTwL6aQUdiFeZoGAGDerQzeoYB8NAkpHCLnpokAFR2iEn6E9zuDHE
         t62+7eH7tFNiJIUXWvo68Zi79aa9pj2V0UvZM5q1v0W9HDWbkiCHGrJIe5my2/Q5Po
         EXgH1+RdZomDenTDy4DSArLDkF31akBhevG9rq/Cpxc5Tx4/tHk4bGZJgI4nisN9ah
         tjOVu/yfBUSww==
Date:   Mon, 27 Nov 2023 11:28:10 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, hare@suse.de
Subject: Re: [PATCH RESEND] nvme: fine-tune sending of first keep-alive
Message-ID: <ZWTfupMR9IPjB5ox@kbusch-mbp.dhcp.thefacebook.com>
References: <20231124205659.523248-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124205659.523248-1-shiftee@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 08:56:59PM +0000, Mark O'Donovan wrote:
> Keep-alive commands are sent half-way through the kato period.
> This normally works well but fails when the keep-alive system is
> started when we are more than half way through the kato.
> This can happen on larger setups or due to host delays.
> With this change we now time the initial keep-alive command from
> the controller initialisation time, rather than the keep-alive
> mechanism activation time.

Thanks, applied to nvme-6.7.
