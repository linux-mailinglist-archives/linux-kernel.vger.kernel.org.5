Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765217854C1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbjHWJ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjHWJzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:55:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0B31715
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B14A65936
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF2FC433C8;
        Wed, 23 Aug 2023 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692781197;
        bh=ovKQBcMOIVI6O+BLk247HKvKdCugt+8Bs5/pRvCFo0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBcaqlcCxO6SyfOpVxrY3rQ9S1R6tAzaAF4XEjdER/PZo1Jd15mooy91hOBHsigrY
         SqAIoPIjyfw509DzzjkHi6G9NU6LTnrla40ILoLIbnwuaNyLBfsogpxFkayI8A1qTt
         x4k/vT9fhA5lSMWN0VqY94ivJog7cz9Wh3eWqgtM=
Date:   Wed, 23 Aug 2023 10:59:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/22] nvmem: patches for v6.6
Message-ID: <2023082305-nutlike-omen-13ca@gregkh>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
 <2023082217-banter-craftwork-281a@gregkh>
 <6e3b58d0-4017-9051-9337-7d86a6be55de@linaro.org>
 <2023082220-cavalry-litigate-9fe3@gregkh>
 <a2cd120c-f09e-de58-b3a6-beaadb199ae4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2cd120c-f09e-de58-b3a6-beaadb199ae4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 09:54:04AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 22/08/2023 18:37, Greg KH wrote:
> > On Tue, Aug 22, 2023 at 06:29:54PM +0100, Srinivas Kandagatla wrote:
> > > 
> > > 
> > > On 22/08/2023 15:34, Greg KH wrote:
> > > > On Mon, Aug 14, 2023 at 05:52:30PM +0100, Srinivas Kandagatla wrote:
> > > > > Here are some nvmem patches slightly more than usual for 6.6 that includes
> > > > > 
> > > > > - Support for NXP eFuse, qcom secure qfprom, QCM2290 nvmem providers
> > > > > - core level cleanup around error handling and layout creation.
> > > > > - few minor cleanups across providers drivers to use better
> > > > >     apis and a typo fix.
> > > > > 
> > > > > Can you please queue them up for 6.6.
> > > > 
> > > > I did, thanks, but your email system needs to be fixed:
> > > 
> > > 
> > > Do you mean Attestation failing part or something else?
> > 
> > Yes:
> > 
> I did not setup patatt in my workflow yet, which is why this is failing
> attestation.

No, this is not for patatt (which would be good to have, I agree.)  This
is due to Linaro, or you, not setting up DKIM properly.

As this works for other Linaro developers, you might want to ask them
how they resolved it.

thanks,

greg k-h
