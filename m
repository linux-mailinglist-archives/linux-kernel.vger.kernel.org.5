Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3FD7BA4E1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjJEQMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240911AbjJEQLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:11:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CC4712A4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:50:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D146C433C8;
        Thu,  5 Oct 2023 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696521047;
        bh=1aXKNsvGURh4L9T8WGFdA+ZIToURAZxeUT/05vEWaGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSN4m25cCRn0BzAiJYOMhg7WW6wdT+WR7sHQ3Kg2hsNBJqn3PC4fCcqKAphAg4zaN
         g5mkH1WGWvFgXij0AY90JnjR2ac2064NslL+4tsCJOCv/9caFXoECUg8MHjeYlCVey
         bEnHsA1rwwmzLEKdkETqdi+n7pDnrBolx0zoue+FDgeUrFFa+AS4HDV/3IQwz+nefL
         Lmhaqo2W+4yrMF6D0/VCcTYpSt6shN0CcreHdIe+dkZmIWoOxH8vGcyyk1njw+Ce8w
         w8onggZobPdN2T/Oqd7pHotg19Waf6zklGh+YVyF/I+FuSsLua0YG3TmRg8wl5kh+6
         Ku59kEjbRWUTg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qoQcy-0004cn-0l;
        Thu, 05 Oct 2023 17:51:04 +0200
Date:   Thu, 5 Oct 2023 17:51:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>
Subject: Re: [PATCH 3/3] staging: greybus: fw-management: make fw_mgmt_class
 constant
Message-ID: <ZR7baCUNIrJzJQ05@hovoldconsulting.com>
References: <2023100533-broadband-hunk-9e91@gregkh>
 <2023100534-catty-moodiness-099e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100534-catty-moodiness-099e@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 03:58:36PM +0200, Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, making all 'class' structures to be declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at load time.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Johan Hovold <johan@kernel.org>
