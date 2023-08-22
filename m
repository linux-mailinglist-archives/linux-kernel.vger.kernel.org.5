Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C93784471
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbjHVOfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbjHVOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:35:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1891891
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E82661C1D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF05BC433C8;
        Tue, 22 Aug 2023 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692714928;
        bh=Nqjox9L5vKr6B0wu/RD1MXgp3EyGqfuSBTFcrxCPUEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y5npq7nrHYFFlBbAmGd0cqyJa9SWqczctii06vYFBbJXXkLNLIxv7lWNK4P7Oinmt
         A3thNBaUzP7ixBdU09SGrE0o4pn8dh0O2RPXlktQ10d2jfkSJCCoDsfVlb8eRtwuIO
         +Hm05iSJhg/wm+W431sFIrsIoPK48+5oGn55vtn4=
Date:   Tue, 22 Aug 2023 16:35:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/22] nvmem: patches for v6.6
Message-ID: <2023082251-browsing-moocher-6ecf@gregkh>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
 <2023082217-banter-craftwork-281a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023082217-banter-craftwork-281a@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 04:34:32PM +0200, Greg KH wrote:
> On Mon, Aug 14, 2023 at 05:52:30PM +0100, Srinivas Kandagatla wrote:
> > Here are some nvmem patches slightly more than usual for 6.6 that includes
> > 
> > - Support for NXP eFuse, qcom secure qfprom, QCM2290 nvmem providers
> > - core level cleanup around error handling and layout creation.
> > - few minor cleanups across providers drivers to use better
> >   apis and a typo fix.
> > 
> > Can you please queue them up for 6.6.
> 
> I did, thanks, but your email system needs to be fixed:

Oops, no, I've dropped them as I get the following build warning which
turns into an error, and you can't break the build.  How did you test
these?

drivers/nvmem/sec-qfprom.c: In function ‘sec_qfprom_probe’:
drivers/nvmem/sec-qfprom.c:59:13: error: unused variable ‘ret’ [-Werror=unused-variable]
   59 |         int ret;
      |             ^~~
cc1: all warnings being treated as errors
