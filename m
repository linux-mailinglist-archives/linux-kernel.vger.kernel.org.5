Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A0A777090
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjHJGkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjHJGkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:40:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC3EE4D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:40:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 52FB26607214;
        Thu, 10 Aug 2023 07:40:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691649606;
        bh=uOhqG4fispv1HyT2wcQA5GUwaFe6s8niX9CF29QCBcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=or8l/s2hclUj6kLR9o2yS5mQ0v212t2y9IL2hyekXL5y/QRFsn/r/gWKOJmhkXFTk
         dpbClVxX715GI5WgilckC5gJzAt/ZG93CUo9LAaV8VFGbWD8V8TQMQkSRqknXIR56k
         ybaSjGUW3QNhQ8/A8QLeRq7JrCrpv+MogMLOr+5PKaGQvThzk+GK21iBpYND1RCsnc
         ODYv5POT0b5o+du806UAiaSYD9huuZXyWgsTMyc9YIWIrJc9AIoXbKw7LtqtlTEML8
         WgzYDtJcBA/vuSZIhu9EqDIa0Z7wrEjpQwQ2pjZGiHjs1J2HsnS/D44VrSFmUsIs1O
         MBZnw3JUzcvTQ==
Date:   Thu, 10 Aug 2023 08:40:02 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        ndesaulniers@google.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, trix@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        naresh.kamboju@linaro.org, dakr@redhat.com
Subject: Re: [PATCH 1/2] drm/exec: use unique instead of local label
Message-ID: <20230810084002.636cc827@collabora.com>
In-Reply-To: <20230809153755.GA832145@dev-arch.thelio-3990X>
References: <20230731123625.3766-1-christian.koenig@amd.com>
        <20230809153755.GA832145@dev-arch.thelio-3990X>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 08:37:55 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> Hi Christian,
> 
> Can this be applied to drm-misc? Other drivers are starting to make use
> of this API and our builds with clang-17 and clang-18 have been broken
> for some time due to this.

Queued to drm-misc-next.
