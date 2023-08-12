Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935B3779D68
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 07:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjHLF5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 01:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjHLF5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 01:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0922D44;
        Fri, 11 Aug 2023 22:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73C6764359;
        Sat, 12 Aug 2023 05:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FE9C433C7;
        Sat, 12 Aug 2023 05:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691819834;
        bh=uZAQzoFipmUZFtQmE1dYQ0dK9Re2VCDZAO2Fa835pA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vYEDECX3e+qlIBCjFXTFoSXjDWaaE3HBOjxoaqJdu6VtlSmIxpWiGua1+T8qOcdzY
         pO6pRKDpltvo/7GsGENkwomPvYHIOodRH6i48t8iZQd8T/y03ueN3e2yH4W6tT/Ug6
         DPYuEpoM7flDE9oQ8I42t41AsaFvymolriNXb46A=
Date:   Sat, 12 Aug 2023 07:57:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     August Wikerfors <git@augustwikerfors.se>
Cc:     stable@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        nilskruse97@gmail.com, David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <2023081258-marital-idly-e4da@gregkh>
References: <ZMgHE2wu4T4OfrTR@kbusch-mbp>
 <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
 <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
 <20230731201047.GA14034@lst.de>
 <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com>
 <20230801112403.GA3972@lst.de>
 <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
 <ZMlrGNw5OMW3yxId@kbusch-mbp.dhcp.thefacebook.com>
 <b2e741b3-b581-40fe-2c28-e4660f52003d@amd.com>
 <0f422dbe-2e3f-4401-be87-2963cbbc1234@augustwikerfors.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f422dbe-2e3f-4401-be87-2963cbbc1234@augustwikerfors.se>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:19:35PM +0200, August Wikerfors wrote:
> On 2023-08-01 22:34, Mario Limonciello wrote:
> > If you can still change it before sending out can you add a stable tag
> > as well?
> 
> This didn't get added in time, so, stable team, please backport:
> 
> 688b419c57c1 ("nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G")

Now queued up to 6.4.y and 6.1.y, thanks.

greg k-h
