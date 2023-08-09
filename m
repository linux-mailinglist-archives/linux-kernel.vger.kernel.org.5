Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F75775EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjHIMVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjHIMV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:21:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6F31BF7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1141363814
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23921C433C8;
        Wed,  9 Aug 2023 12:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691583688;
        bh=lxZkcW9VfEj3r2MbCwShiHqYNarVQxG41BuXDQ8GgCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nz30+GzhOTK9fL0ZJ4cTrBOZFLpZ3sdqUgow83Xco/6qcAjpScI44oujP/EGDCoOK
         XmpeKrDlZl9R9qbM4g+JiMlU4HuoWQ8mAj007vCUnbmbLznXwt6xJgqlSiqyzh7f9g
         VZD0jKqzQwv+NRSVcmaTbh1CdgVFCcONJiiTS8dM=
Date:   Wed, 9 Aug 2023 14:21:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: prefer strscpy over strncpy
Message-ID: <2023080952-maroon-waviness-9621@gregkh>
References: <20230805075114.15186-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805075114.15186-1-straube.linux@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 09:51:14AM +0200, Michael Straube wrote:
> Replace strncpy with strscpy in two places where the destination buffer
> should be NUL-terminated. Found by checkpatch.
> 
> WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90

If a global search/replace could be done, it would have happend a long
time ago.

How was this tested?  The functions work differently, are you sure there
is no change in functionality here?

thanks,

greg k-h
