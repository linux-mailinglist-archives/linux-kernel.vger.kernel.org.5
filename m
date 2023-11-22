Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8617F439A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343844AbjKVKVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjKVKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:21:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2B39F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:21:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581E7C433C7;
        Wed, 22 Nov 2023 10:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700648460;
        bh=9e1LIluOfXARPyC/bVSfAb9OwVt3KSz5gYLI4Y5ZeHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/ezXvIakcPxV8p+CN65gSJqDgElaFm2obrgPpefLT1zITfJQfTLgauIu52moOqOW
         dBHaU2dOSPrV0MoDcPwUmb3CudqVroOjy/XUVbCqimLPHn0haod/SdAUjQ3OkQte9r
         tBR/CKLmL7pVexUrP6v4G37r2DELeLNy8oMtYaOv6yzGgM+qlDbOb7lnp8PkCSyTxI
         qYS2jMN2QLNOwGCfxZdCKAqNOlIboALQazeq+haskvO0UijLzl9EkNohsUueKZKDml
         AKiVsRIFz1HZpVG84V0D4AeD6P3wjzs09CHE0XhtnAecLxiwaMooeL8JMXeWliozRY
         CKGDW3U4GPnmA==
Date:   Wed, 22 Nov 2023 11:20:56 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: linux-next: manual merge of the kvm tree with the vfs-brauner
 tree
Message-ID: <20231122-kartierung-bewilligen-0706aed5fd12@brauner>
References: <20231122125539.5a7df3a3@canb.auug.org.au>
 <20231122071040.GA4104@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122071040.GA4104@lst.de>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 08:10:40AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 12:55:39PM +1100, Stephen Rothwell wrote:
> > index 06142ff7f9ce,bf2965b01b35..000000000000
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@@ -203,9 -203,8 +203,10 @@@ enum mapping_flags 
> >   	/* writeback related tags are not used */
> >   	AS_NO_WRITEBACK_TAGS = 5,
> >   	AS_LARGE_FOLIO_SUPPORT = 6,
> > - 	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
> > + 	AS_RELEASE_ALWAYS = 7,	/* Call ->release_folio(), even if no private data */
> > + 	AS_UNMOVABLE	= 8,	/* The mapping cannot be moved, ever */
> >  +	AS_STABLE_WRITES,	/* must wait for writeback before modifying
> >  +				   folio contents */
> >   };
> 
> Note that AS_STABLE_WRITES, is a fix for 6.7, so this will probably

Yes, I plan on sending a fixes pr on Friday. I've wanted this in -next
for a few days.
