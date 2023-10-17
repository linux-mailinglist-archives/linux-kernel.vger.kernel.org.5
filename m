Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAF47CC424
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343740AbjJQNOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQNOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:14:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B9BED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:14:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC96AC433C7;
        Tue, 17 Oct 2023 13:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697548469;
        bh=4Ynp8qt72JNt3BDC3l87JhLBKu58eC5RE+4kwFTcik8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WhBx8Sk0X+QVFI/EHjaRgHxFh9bzGNs1T8ApZR4xqKCZz1TemsNYiSeJGP1uEUvPS
         isqszJBh9u4owDEA3zOP2efmq32PmBPC8SnrzYW7Rs7VYnmK2+CDS7UKtI22jok+jK
         RYYbiynVpmYCmEnRWrvr6fHaiuy6BAeP/6BbnnpE=
Date:   Tue, 17 Oct 2023 15:14:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kris Chaplin <kris.chaplin@amd.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Conor Dooley <conor@kernel.org>
Subject: Re: w1: coding-style - naming for master/slave for new driver and dt
 binding
Message-ID: <2023101739-tinker-squabble-237f@gregkh>
References: <91104ef7-c9a6-4c65-aad0-61ecb3c29ea0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91104ef7-c9a6-4c65-aad0-61ecb3c29ea0@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 10:38:49AM +0100, Kris Chaplin wrote:
> Hello Krzystof,
> 
> During review of my dt-bindings patches for a new w1 driver
> (https://lkml.org/lkml/2023/10/13/959), there was mention that the use of
> 'master' is not considered great terminology nowadays.  Are there any plans
> to replace the usage of master/slave in w1 as mentioned in
> Documentation/process/coding-style.rst ?  As we are in the final stages of
> our W1 soft IP development, I believe there is a small window in which we
> can align on our new IP name if appropriate, prior to my next round of patch
> submission for amd,axi-w1-master and get the binding to match.

For new stuff, please use new terminology, but there's no need to change
existing code if you aren't going to be touching it.

thanks,

greg k-h
