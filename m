Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AA87C46D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbjJKArg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344367AbjJKArf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:47:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6CE8E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:47:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AC9C433C7;
        Wed, 11 Oct 2023 00:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696985253;
        bh=GML/tjgAq13M4+96lhLvoGtPl4yhrUdZshloPeDdWqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ryjEudkJcuUfG9yZePCjX40V0FqAFEM5mudN5TtbVVdwCNZM7Zb3feRbDMR9cUeK2
         j3JWZN1mGsjcmDty1myc9gr/NchebGTRsncb1SHyXdCF55oSmZsux8VETkAEb+SvXK
         bp8UmQI/amPTbQ6zfWyumJgv7PQiW+a1CI1Iy7ClAflXAC5SX7duC1fErtPQnB9/bQ
         m8yOoVyNO8dTv36WGZ+ECuHhJTAqaJ8B3I2OSFIuRNgTUoG51sIIzUn6gNBZ8xojjr
         bWBJqQ1raQpgyxM311FIJfki/PYhBtcrLJB2AfSzd+OmcaduwanDfvLFhVefPdjUmS
         cUFPvdMhA5oAg==
Date:   Tue, 10 Oct 2023 17:47:31 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] igbvf: replace deprecated strncpy with strscpy
Message-ID: <20231010174731.3a1d454e@kernel.org>
In-Reply-To: <CAFhGd8ppobxMnvrMT4HrRkf0LvHE1P-utErp8Tk22Fb9OO=8Rw@mail.gmail.com>
References: <20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com>
        <5dc78e2f-62c1-083a-387f-9afabac02007@intel.com>
        <CAFhGd8ppobxMnvrMT4HrRkf0LvHE1P-utErp8Tk22Fb9OO=8Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 14:41:10 -0700 Justin Stitt wrote:
> > Thanks Justin for these patches, please make sure you mark the subject
> > line as per the netdev rules:
> > [PATCH net-next v1] etc etc  
> 
> Sure, I'll resend!

Please do read the netdev rules Jesse pointed you at.
Maybe it's the combined flow of strncpy and __counted_by patches
but managing the state of the "hardening" patches is getting 
a bit tedious :(

Please group them into reasonable series. Do not repost withing 24h.
Do not have more than 15 patches for networking pending at any given
time. That's basically the gist of our "good citizen" rules.
