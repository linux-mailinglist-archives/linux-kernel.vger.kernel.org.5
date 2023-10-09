Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440AB7BE7E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377438AbjJIR2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377385AbjJIR2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:28:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5B5F7;
        Mon,  9 Oct 2023 10:28:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8241C433C8;
        Mon,  9 Oct 2023 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696872509;
        bh=XeJQWQeVS+Z959sNWhClnEBeDr2ttRN3kcOS/XN2N4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fk6lL5grLPZ9sK0mvLd4sew0+j8Xef2fLBZSUEtN3ERXHDbxRaZRP/zCR+l/MMhto
         QRlJKL7RSlsmMxJgehfxktanKG4eKphWsqGhsSTkCMAiSQL0J74Nb8mNYhyfhRcf++
         3QcI2Qc0zinBkK5igUqMVHzMlQElmND2qQ/uWz8A=
Date:   Mon, 9 Oct 2023 19:28:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] drivers/counter: add local variable for newly
 allocated attribute_group**
Message-ID: <2023100912-glare-broiling-cc7d@gregkh>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-4-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009165741.746184-4-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:57:37PM +0200, Max Kellermann wrote:
> This allows the compiler to keep the pointer in a register and
> prepares for making the struct field "const".

Again, nothing about registers makes sense here.

thanks,

greg k-h
