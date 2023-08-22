Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF0783761
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjHVBcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjHVBb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:31:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD59101;
        Mon, 21 Aug 2023 18:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9DAB634D8;
        Tue, 22 Aug 2023 01:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D741DC433C8;
        Tue, 22 Aug 2023 01:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692667915;
        bh=49eHcrHLDlh1F4t90rBZwAdq8ZBzeayw4JNVHCRy2To=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EmLSq83nVEdwX++ZYaMe/h2/CK1Dk/5P7HbZG0UA3bq5HaX1ahgW9YTP+VAOmtMvU
         B2KTN824UNzKgrJeibChau3XnJtEj5aiVuqD5BMm5bBT4gGRW2Sjgtpgte6g5/bDSV
         cwlu/svAPGSKzAyULanjtaMDEyDFCLpGXRTzJrGFgWStEtvTIxJU1a0mZbfJouRNPV
         nhFYKG94ktibvTVEqNHN4FOlawvOn8TzYj23MZRprHJoFQtFWpgqu5zbZKpWS+HrTK
         f00pKVtlOxqtCRsY8SUrplLm/4wFcoQ1qIataeRae1Bx5Z4cBoR5xUzRoAXiX38CiR
         1i2swGFkdCt4w==
Message-ID: <8f8c8da7-b5a4-63b4-96fb-31a53721b5f2@kernel.org>
Date:   Mon, 21 Aug 2023 18:31:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: manual merge of the mm-stable tree with the
 arc-current tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vineet Gupta <vgupta@kernel.org>
Cc:     Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230822082841.7948474d@canb.auug.org.au>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20230822082841.7948474d@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 15:28, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the mm-stable tree got a conflict in:
>
>    arch/arc/Kconfig
>
> between commit:
>
>    f798f91e7f5f ("ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user")
>
> from the arc-current tree and commit:
>
>    06dfae39d200 ("arc: mm: convert to GENERIC_IOREMAP")
>
> from the mm-stable tree.
>
> BTW, if the "select GENERIC_IOREMAP" had been put in its (alphabetical)
> proper place, this conflict would not have occurred ...
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>

Thx a bunch Stephen.

-Vineet
