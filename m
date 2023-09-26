Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8677C7AE4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjIZFV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjIZFVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:21:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869621B3;
        Mon, 25 Sep 2023 22:21:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D771BC433C9;
        Tue, 26 Sep 2023 05:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695705661;
        bh=IkHjnktKldZibBZypBimCY9b32eN5qfQ3sPlP4a4HjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctQ3HMDIAhsOfmFDdVBGNnXBdrsroQ74YczJIgr5ZJFlyk0uHq4iVid9mOT5/h55C
         tIIYI2rSmtEOoUsQXnQbfTcKAWUYaI4lcJNB+tt4EaVZuFhc6ygXwc07uPgOKY8K+i
         65oWvjVKTEkoJLilcp6hVsA4jmOx544l+Yj6czrDml+9wyd7zhSr7x1M7Mx841FH12
         AMioTBYOFyGn/aQY/YxSjsn2K9tXk+4MsC3xYOqSh2MmIY4RuF/q/fP/QRTIKJswUm
         m6arh5krW6HJE6EaZmbovq7eFfNkY6Osl9rjOXpg94hgB3cYXdPB47QdHNziwWFu32
         a2aSE5VH7oIeQ==
Date:   Mon, 25 Sep 2023 22:20:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, x86@kernel.org
Subject: Re: [PATCH 2/3] crypto: x86/aesni - Correct the data type in struct
 aesni_xts_ctx
Message-ID: <20230926052059.GC3118@sol.localdomain>
References: <20230925151752.162449-1-chang.seok.bae@intel.com>
 <20230925151752.162449-3-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925151752.162449-3-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 08:17:51AM -0700, Chang S. Bae wrote:
> Currently, every field in struct aesni_xts_ctx is defined as a byte
> array of the same size as struct crypto_aes_ctx. This data type
> is obscure and the choice lacks justification.
> 
> To rectify this, update the field type in struct aesni_xts_ctx to
> match its actual structure.
> 
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/all/ZFWQ4sZEVu%2FLHq+Q@gmail.com/

Please put the "Link" directly after the Suggested-by to make it clear that the
link is for the suggestion.  Thanks!

- Eric
