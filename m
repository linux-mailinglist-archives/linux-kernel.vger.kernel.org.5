Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6213E80CAFF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343620AbjLKN2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKN2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:28:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5B8B3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:28:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D2CC433C7;
        Mon, 11 Dec 2023 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702301327;
        bh=0CpLD8dRzQ8OFlBx0wOWEw/1qMni4oZG0S8sbx9hVhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dW0Kee/ZC/h61mXDknAqmvMfOFO0E1U9zx6VF2/UZ9beG6QCr1xu6V0qN73VNbPXx
         Q+PiKV7Tnabq9/0lDvLtQb7M0kTOW4LKuJtUej29Bw5YRkfw2vnhjg7vEtq6NsLIjD
         6ipgtF1qCFuxc1ZzywO7uPqpiOwpB5+tkmRVxnnyQulDrtSpW4uRiOUMg/b6+QiSS7
         bERbLXwUi8b/CjBdwKdzIIgX0+ijf30d2OQ+aUpUhhL1v1lz6IO52hcVdQCFOE39GX
         dz7BIjQjdDzQ4fXnL/j8SDiuvtMmZZh1AmCdyiTvPZrzTQrsvd5M6KDQnmaAJVdig0
         S8Kyaih/VTytA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rCgLm-0007HX-1E;
        Mon, 11 Dec 2023 14:29:34 +0100
Date:   Mon, 11 Dec 2023 14:29:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 0/2] ASoC: qcom: Limit Digital gains on speaker
Message-ID: <ZXcOvl1tUWmwGalB@hovoldconsulting.com>
References: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
 <ZXbDY1iA_DQLIzqq@hovoldconsulting.com>
 <2023121146-hunger-crane-7dee@gregkh>
 <2023121113-walrus-outmost-ec34@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121113-walrus-outmost-ec34@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 01:54:39PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 11, 2023 at 01:40:52PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Dec 11, 2023 at 09:08:03AM +0100, Johan Hovold wrote:
> > > On Mon, Dec 04, 2023 at 12:47:34PM +0000, srinivas.kandagatla@linaro.org wrote:

> > > These were unfortunately not marked for stable, but could you pick them
> > > up for 6.6?
> > > 
> > > The upstream commits are:
> > > 
> > > 	fb9ad2448508 ("ASoC: ops: add correct range check for limiting volume")
> > > 	716d4e5373e9 ("ASoC: qcom: sc8280xp: Limit speaker digital volumes")
> > 
> > Now queued up, thanks.
> 
> Oops, no, this breaks the build on 6.6.y, can you send a series that is
> at least built for this series successfully?  :)

Sorry about that. I was not aware of the asoc interface rename that went
into 6.7.

Just sent a backport of the series here:

	https://lore.kernel.org/r/20231211132608.27861-1-johan+linaro@kernel.org

Johan
