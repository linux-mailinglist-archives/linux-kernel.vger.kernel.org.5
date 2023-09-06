Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9667179404F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242566AbjIFPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbjIFPYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:24:46 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7541733;
        Wed,  6 Sep 2023 08:24:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EF799732;
        Wed,  6 Sep 2023 15:24:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EF799732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1694013876; bh=eCJWPxmbGltM8yyS/gebeUQ2VUhtkX6yxucysuzpFHI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=a1UYCaIaCWPGa7TAyKUjkkTNTPPvKYlPWv+erPTOizQOmVURKxz2WPQS4CwPzovTg
         4OlrUunGFYOGXfvvW0MvaqjzDN0B4WvLGXOJip3bJ4Xib+rTsFDgdhdzkusVCsL0kH
         ZRAhsuV6kI54p6LjAhTMVmLg6TMhtebMsjVN+EF4m/aoYaOIAOBsTfgWCVYgx7BPuH
         G/luZpeDS4sJ3MO+jWZTooi9KDdAflIRZ/TAfQmhbAumj1w12AOMqrUAmqJ7epiGih
         GND9wJLS/vLJ3VDOljg6oWxdvhForSKP0J8YRMxcKv0R5A2EUrVe86FtizHw9Dj66s
         UBYVIeVIG3D8A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] docs/mm: Physical Memory: add "Memory map" section
In-Reply-To: <ZPiU7/Rg8g+B58Wa@casper.infradead.org>
References: <20230906074210.3051751-1-rppt@kernel.org>
 <87ledjgy93.fsf@meer.lwn.net> <ZPiU7/Rg8g+B58Wa@casper.infradead.org>
Date:   Wed, 06 Sep 2023 09:24:35 -0600
Message-ID: <87ledj5npo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

>> Have we figured out what mapcount really means yet? :)
>
> Hah!  I know what this field means today!  In two hours time, I might
> be less sure!  (Does LWN want to come along to that MM meeting and write
> it up for an article?)

It's on my radar, not yet sure if I can make it or not.  Wednesdays are
a pain...

jon
