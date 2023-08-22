Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027FC784045
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjHVMDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjHVMDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5A293
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:03:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3499D61EA3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9ECC433C8;
        Tue, 22 Aug 2023 12:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692705829;
        bh=o0CAO/rJUxsXuZqz8OMH4p7eYcZMQ4fti8Kr4Nu533E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fk28g16m8GvoL8+NZW3s0+irekJLY6V0t21BeZRYnxZIkmtblq0ikSizyvC7yMDKp
         0N4kRZ4uzaRA9peLjPjP4dDplJTxmlWw/tFWtHSC2tOap6DCSSlTZZXFTA8r4IHSGb
         JVERt4/0+1dgCF94fXm+6zRfKTEOsXIHeoi9p4p8=
Date:   Tue, 22 Aug 2023 14:03:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, gongruiqi1@huawei.com
Subject: Re: [PATCH] lkdtm: use the return value of strim()
Message-ID: <2023082228-breath-submitter-7a1e@gregkh>
References: <20230817142117.972418-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817142117.972418-1-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 10:21:17PM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> Make use of the return value of strim() to achieve left-trim as well as
> right-trim, which prevents the following unusual fail case:
> 
>  # echo " EXCEPTION" > /sys/kernel/debug/provoke-crash/DIRECT
>  sh: write error: Invalid argument

And that is correct, don't use leading whitespace, the kernel is not
there to parse it away :)

thanks,

greg k-h
