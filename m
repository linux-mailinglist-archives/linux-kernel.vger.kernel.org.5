Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D4B7BF2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442206AbjJJGNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442156AbjJJGNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:13:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA6B7;
        Mon,  9 Oct 2023 23:13:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F79C433C7;
        Tue, 10 Oct 2023 06:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696918385;
        bh=ZfqLYJFXsYULZ9kLmOcOxhIz5rXVpjEDCEx3JH61F7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wxcONk+DexdaaHvwD3JZbwLM348jrwMvQC6eK3sR8FBG46vvHZbdUNfkif9XhyIfs
         41egRCHQmz0KJjQbGVt0bUBNVsLDio+W+0VOdLDh0BJhdIT7AEjuY9NrkA4yqkB71G
         eVz8biTxCyF4MfSkpgbzUJ327NU3h4hTybDCPHo4=
Date:   Tue, 10 Oct 2023 08:13:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Graf <graf@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Kyunghwan Kwon <k@mononn.com>
Subject: Re: [PATCH v4 1/2] Import CBOR library
Message-ID: <2023101010-overwrite-parakeet-91d5@gregkh>
References: <20231009212053.2007-1-graf@amazon.com>
 <20231009212053.2007-2-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009212053.2007-2-graf@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 09:20:52PM +0000, Alexander Graf wrote:
> To fully support the Nitro Secure Module communication protocol, we need
> to encode and decode CBOR binary data. Import an MIT licensed library
> from https://github.com/libmcu/cbor (commit f3d1696f886) so that we can
> easily consume CBOR data.

What is "CBOR"?  I don't see a description of it here.

And I guess you are going to keep this in sync with upstream?  Or do you
really need the full library here (you #ifdef the float stuff out), does
your module really need all of the functionality and complexity of this
library, or can it use just a much smaller one instead?

> On top of the upstream code base, I added kernel module as well as
> kernel header path awareness and made checkpatch happy.

If only the one module needs this, why not put it in the directory for
the module itself, and then when/if anyone else needs it, it could be
moved?

thanks,

greg k-h
