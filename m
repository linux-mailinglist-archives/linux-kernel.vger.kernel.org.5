Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A6A7EFF47
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 12:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjKRLfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 06:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKRLfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 06:35:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35CCD72
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:35:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D285EC433C8;
        Sat, 18 Nov 2023 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700307318;
        bh=OgG2e3JDQ+aMaFQKaQHhqxbxwXDPAGQ1d6SyxmbzQdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scYJ4WjYaxXhSxGGMBk8baExUYwt1smeRQtnrHSE1PQUGYddkffPEMQViJ6Em65dW
         PVnfVVo0a7IvuOeICohX8JQS0877utTtVEnz5sq9xpDwPzddIvc/FlazUBMIDHWTuu
         LcW2yEPshGCBN/aR66RHgN4PNpeDTCR/vh1drtrg=
Date:   Sat, 18 Nov 2023 06:35:14 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
        rust-for-linux@vger.kernel.org, Laura Abbott <laura@labbott.name>
Subject: Re: [PATCH v2 1/5] export_report: Rehabilitate script
Message-ID: <2023111809-mayday-citable-4fbd@gregkh>
References: <20231118025748.2778044-1-mmaurer@google.com>
 <20231118025748.2778044-2-mmaurer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118025748.2778044-2-mmaurer@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 02:54:42AM +0000, Matthew Maurer wrote:
> * modules.order has .o files when in a build dir, support this
> * .mod.c source layout has changed, update regexes to match
> * Add a stage 3, to be more robust against additional .mod.c content

When you have to list different things you do in a patch, that is a huge
hint that you need to break up your patch into smaller pieces.

Remember, each patch can only do one logical thing.  I know it feels
odd, but it makes it easier to review.

This patch, as-is, is nothing that I would be able to take, please make
it a series.

thanks,

greg k-h
