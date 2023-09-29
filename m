Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA4B7B2BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjI2FqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjI2Fp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:45:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339E91BE1;
        Thu, 28 Sep 2023 22:45:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C260C433C7;
        Fri, 29 Sep 2023 05:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695966306;
        bh=/vumVkPq8i6Y4/EDQkA1BHMVdr9OA0iL0EbIdZlpzes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zz7u3/SgIDEKIWKUsBEhfKrJWFigoQxGAc7v8WNwNQCyFbCcSIi1yX/NpjsyYVLDT
         ow1h5RE/Eb4wBUSu25Ogie8nUO1ZMyKMlorJGLlbStie2sM8Z/r1jl1sp3FtM/eFPH
         0B4TqdizH/y3H2iZEaPhxHpr2iCuhsVb6rKqwy5c=
Date:   Fri, 29 Sep 2023 07:45:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Graf <graf@amazon.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] misc: Add Nitro Secure Module driver
Message-ID: <2023092918-sulfide-stonework-f6b7@gregkh>
References: <20230928224645.19768-1-graf@amazon.com>
 <20230928224645.19768-2-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928224645.19768-2-graf@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:46:44PM +0000, Alexander Graf wrote:
> +/* Register this as a misc driver */
> +#define NSM_DEV_NAME          "nsm"
> +#define NSM_IOCTL_MAGIC       0x0A
> +#define NSM_IO_REQUEST        _IOWR(NSM_IOCTL_MAGIC, 0, struct nsm_message)

You have an ioctl for this driver, yet no include/uapi/ file for it?
How is userspace supposed to know about this and use it?

thanks,

greg k-h
