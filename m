Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115BE7D1B8B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjJUHlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjJUHbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:31:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCDBD63
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 00:31:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3664EC433C8;
        Sat, 21 Oct 2023 07:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697873502;
        bh=4aCY97D7gtFSBIsEYv9Z4lDXkkXAFhhDXDhjPDd2rDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SRAKAYNQFm06+a9XsQMxjCug6MRGysuYpzMk/7+FSh3OwvODg72Nn5XuregA9+cSW
         SyRERx7RqllOuJwOmuPOcglhFLl60zfHtEcAP90MAYeYfVlD1BaRDeD+Nd7lhn/5Pc
         Mec1kd3YySmkNBVx/leNYWKGipZVzrIlF6MLJpjg=
Date:   Sat, 21 Oct 2023 09:31:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: octeon: Fix remaining instances affected by
 removal of typedefs
Message-ID: <2023102105-islamist-nursery-9ebd@gregkh>
References: <20231021000340.56889-1-bergh.jonathan@gmail.com>
 <20231021000340.56889-3-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021000340.56889-3-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 02:03:40AM +0200, Jonathan Bergh wrote:
> Update the remaining instances in ethernet.c file affected by removal 
> of the typedefs from octeon-stubs.h

You can not break the build in one patch, and then fix it up in a second
one, sorry, that's not how kernel development works.  Each patch needs
to work properly on its own.

thanks,

greg k-h
