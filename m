Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18902782CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjHUO5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjHUO53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:57:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B8BE8;
        Mon, 21 Aug 2023 07:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D8EA613EA;
        Mon, 21 Aug 2023 14:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423BEC433C8;
        Mon, 21 Aug 2023 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692629844;
        bh=81+nv/icHm8Osb2n8YAqxJA369nqyLSBAVtVs6fRHWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DgPUKUyomJkxjqH/7WJuL/3m4moNAp9/mTDCRqUrNAL+4z68IXfmQgcbLokALLFqP
         6dAVTMdCToCgORIvzJ9/5nuyWn0P1j38qlrldcENRtmmlU3KGd5x2qGBYdjb7FgpoM
         qxs9z2HWW4kXAjVMNzqVMLPqr3arCGkbiVQ0dpIoNqRixt7mjrSo/wlbbhMaUbVg+e
         idpYDhrYcfmUN9M75Irvs57od8f1L0I2OgOI9khHO7hErhlG2Flzby0iWZAajP4RoF
         6g8m+eXKiAP6XmgwcpfjCG0hjBnsfTTVAl9j+Q/IIECnIHZZdAlFf4B4YPkYArRPzG
         s4Qkvzq5u0hkA==
Date:   Mon, 21 Aug 2023 07:57:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag
 to give credits to who sponsored the patch
Message-ID: <20230821075723.17944dcb@kernel.org>
In-Reply-To: <CAMuHMdVY7vaU8wpJrMD4HNkQwkJD0Rd9sL-xFDYXxJEcP91yuw@mail.gmail.com>
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
        <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
        <20230817232348.GC1175@pendragon.ideasonboard.com>
        <28289906-4fd1-26aa-b1c4-eb393ac52d48@benettiengineering.com>
        <CAMuHMdVY7vaU8wpJrMD4HNkQwkJD0Rd9sL-xFDYXxJEcP91yuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 09:40:59 +0200 Geert Uytterhoeven wrote:
> Personally, I would respond "I'm sorry, but the only advertising
> space we offer are Copyright headers (for employees) and
> "user+customer@..." or "name (customer) user@..." (for contractors).

+1

> And this is a separate tag, so it's harder for the analysis tools
> (whose output your customers must be interested in, too?) to
> match the tag to the actual Author/Reviewer/...

I think that's a key point. Having a separate tag denote the sponsor
would make analysis a lot harder. We'd need to start writing parsers
with much more context awareness.
