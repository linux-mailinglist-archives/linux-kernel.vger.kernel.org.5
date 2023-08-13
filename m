Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC2877A51A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjHMG2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMG2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03928170C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:28:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 158026100F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10819C433C8;
        Sun, 13 Aug 2023 06:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691908084;
        bh=wPNWARJsQstSHuyNFm0qqrPTyQDoewNiu7kynxu5s0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gzNz5vlyXSXMI2bVnPtoxoCDHE8GZufrjdBAuvbJMG4K/PETKJYqnwyweYOFZCfOi
         jjQ/DfaXn+wIhqdx6x7IHqIRGeSrXVNE7D3UlboKZ0ng7qnV9fHL00FK65EsOfxEWr
         pkVK3rjeKJWE5ayhfXJDXfvsk7gHBQXLahrDBkCs=
Date:   Sun, 13 Aug 2023 08:28:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cyrus Ramavarapu <cyrus.ramavarapu@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Remove unnecessary parentheses
Message-ID: <2023081302-ripping-yo-yo-2b44@gregkh>
References: <20230813005326.98905-1-cyrus.ramavarapu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813005326.98905-1-cyrus.ramavarapu@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 08:53:26PM -0400, Cyrus Ramavarapu wrote:
> Remove unnecessary parentheses found by checkpatch.

Please no, don't do this, see the email archives of this list for why I
don't like this type of change (it forces you do have to remember rules
when looking at the code in the future.)

I wish checkpatch would not report this type of issue anymore...

thanks,

greg k-h
