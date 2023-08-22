Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50947842AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbjHVOAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjHVOAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:00:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B661B2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2DAF65766
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8487C433C8;
        Tue, 22 Aug 2023 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692712817;
        bh=NrD9UemlBO40PAoAA9SC+zqbx2mCIVVDLvocYpaGj+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YayRxsBuQZ50xU6J4ZgpuSfESWc9MR6hZ0hg2Dg7lgchuXGhLGHRCKXxZ6AaALnKv
         xmE8wFpnCCH7AKmY5aSQaS5/xSUabtwjtgAoy3q9mh2Mf469VY5AgbpswUU01GzimZ
         u0cS7q35RZVIo6dv64yUX65VAeSxFk+YZqMOkkzs=
Date:   Tue, 22 Aug 2023 16:00:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] misc: fastrpc: fixes for v6.5
Message-ID: <2023082251-slighting-unreal-7b15@gregkh>
References: <20230811115643.38578-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811115643.38578-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:56:40PM +0100, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> Here are some fixes in fastrpc driver mostly around audio process domain
> and secure memory allocation.
> 
> Can you please apply them for v6.5
> 
> thanks,
> Srini
> 
> Ekansh Gupta (3):
>   misc: fastrpc: Fix remote heap allocation request
>   misc: fastrpc: Fix incorrect DMA mapping unmap request
>   misc: fastrpc: Pass proper scm arguments for static process init
> 
>  drivers/misc/fastrpc.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> -- 
> 2.25.1
> 

Ick, sorry, it's too late for 6.5, I'll queue these up for 6.6-rc1 and
then they can be backported into 6.5.1

thanks,

greg k-h
