Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE41D7BE5C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377096AbjJIQCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjJIQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:02:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DD399
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:02:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c7373cff01so41703175ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696867351; x=1697472151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VBo7/M8weK7GqJKgsmfZy4H/ddypVZXezIGNc/laBIM=;
        b=gL6h0k5VVMBjDMJOPDCAChakBz/wXsEo6uNJ4kH0G/X0fAPjMgZ9W4v89lzqTRPAmV
         OFjEgn/K7ii/k9/uUnCvyiROzS6spfyytS20e92g13MKOth1lGpSsDdmoayzKpCOfGCR
         J9jf/PzmIKYBEbbFeaQ4jCzerQrff3DRdxWCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867351; x=1697472151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBo7/M8weK7GqJKgsmfZy4H/ddypVZXezIGNc/laBIM=;
        b=dpC5VsK0ig5yIpD25GKmwmkKYGAua2SnE8vHqOHFIU49+lyAE6gVR2GFmHms/IolHI
         dnjf3ATRCUnPzB881sipoldFJfwMAUHa/W6NrhkgG0QhpHWIzz3LNtbP8/HPEvK+Jznv
         64ouoGf1YZn/ohwc6W0JHfY2QliHm9FTKTtUdrz1PIXaD3hty+aiA0wWq/CsbIWFOeJh
         81E3JBf2T9NE7rEpuiO91DF6LVLNc5mqPwfV5Tb6Huok82mM/sF5PW3sWc/bizoE6IYn
         rCpSzrKrFn57vdxhW6u3uQ3jW3emcnG28fOmzHP/9BK8VGBGEvwB5+96/jf4mY1pUwvd
         pITQ==
X-Gm-Message-State: AOJu0YyieipyL0Owcf7j64aYyJJaH+Ro5K1glSdhkHkTvZBB2EFOjLmU
        bedWT32yZBHd0wd9Ykt+2d9WZw==
X-Google-Smtp-Source: AGHT+IHzup/xAx1ifpxmi3UryQvmiHkOx8P4Nc2On1Fyx56aKemvsYmRNFsp4H4ofYMWZ2mFLT5hmQ==
X-Received: by 2002:a17:902:cecb:b0:1c0:cbaf:6954 with SMTP id d11-20020a170902cecb00b001c0cbaf6954mr21386914plg.25.1696867351114;
        Mon, 09 Oct 2023 09:02:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f7-20020a17090274c700b001bc445e2497sm9742768plt.79.2023.10.09.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:02:30 -0700 (PDT)
Date:   Mon, 9 Oct 2023 09:02:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        stable@vger.kernel.org, Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-bluetooth@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mark bacmp() and bacpy() as __always_inline
Message-ID: <202310090902.10ED782652@keescook>
References: <20231009134826.1063869-1-arnd@kernel.org>
 <2abaad09-b6e0-4dd5-9796-939f20804865@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2abaad09-b6e0-4dd5-9796-939f20804865@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:36:55PM +0200, Arnd Bergmann wrote:
> On Mon, Oct 9, 2023, at 15:48, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > These functions are simple wrappers around memcmp() and memcpy(), which
> > contain compile-time checks for buffer overflow. Something in gcc-13 and
> > likely other versions makes this trigger a warning when the functions
> > are not inlined and the compiler misunderstands the buffer length:
> >
> > In file included from net/bluetooth/hci_event.c:32:
> > In function 'bacmp',
> >     inlined from 'hci_conn_request_evt' at 
> > net/bluetooth/hci_event.c:3276:7:
> > include/net/bluetooth/bluetooth.h:364:16: error: 'memcmp' specified 
> > bound 6 exceeds source size 0 [-Werror=stringop-overread]
> >   364 |         return memcmp(ba1, ba2, sizeof(bdaddr_t));
> >       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Use the __always_inline annotation to ensure that the helpers are
> > correctly checked. This has no effect on the actual correctness
> > of the code, but avoids the warning. Since the patch that introduced
> > the warning is marked for stable backports, this one should also
> > go that way to avoid introducing build regressions.
> >
> > Fixes: d70e44fef8621 ("Bluetooth: Reject connection with the device 
> > which has same BD_ADDR")
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Lee, Chun-Yi <jlee@suse.com>
> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Sorry, I have to retract this, something went wrong on my
> testing and I now see the same problem in some configs regardless
> of whether the patch is applied or not.

Perhaps turn them into macros instead?

-- 
Kees Cook
