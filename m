Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221C27BEBD2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378017AbjJIUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378004AbjJIUnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:43:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6C7A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:43:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c60cec8041so29552765ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696884194; x=1697488994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxz37O2Et+/sEGfnnd7+X/Fbves+7FcqdtNnLD8idyE=;
        b=H++RnMwydgF8xDS9VP8Ht3XKsJsU0rA2UQBgh6b8h2pLI7LSjWBy5vxR307+cK+6f9
         UevaIdvoR3oJkqY43KkVSU8R8UEfqbjb4WzXBmZ82DYon+QtfeNiUGkWcs6QHP+rTFKX
         szbIEE2vdtwtDzsqUBuoEzi/Dlqu1T0z2ctT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696884194; x=1697488994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxz37O2Et+/sEGfnnd7+X/Fbves+7FcqdtNnLD8idyE=;
        b=APZU3wqZr2cIJh2E/6MZSH7c2GKf984gINWPudwqAMRCPtsw1ykYe/PmCDQ6Fervnf
         M/UjVMhKbIcSW/3vZ5MskbllrSlY/CeVIX2i4H2pAU4qzfME44PeHAKpLckWCBk3Qeuc
         1vf1hAuN7ImTc/yvA2k570isdX/JMJW8xdxm5/lcsMMYffwfK4aH7gkSDlyKU8O8iXd5
         4Q0kuXMQy7h9RHD+UEH/WRHBL9E8be+h1bMjqQIIEYRlKz6Y6QpQXP9E2UvZ+qEVC717
         WnlmecIsZ6KP00cumbC7sQnrFALimox7OZWuQZohKETMNZf/3/c1SHkxGRSWOxW3DEdg
         7+Nw==
X-Gm-Message-State: AOJu0Yw2vkbS3MFOcksMpuhvaEpSpO9KOm5KL1KQ0W0HFiBRsQJQeOfL
        mIm0OTpnWMB9CB5X7dT02fmXkQ==
X-Google-Smtp-Source: AGHT+IHpl+jUNGx7N5orhdDTiKGl0l5fjOovy9ReFhg+kLarFO3onKx6wpsiy5cN1Kn/lsnAHiFI0A==
X-Received: by 2002:a17:903:11d2:b0:1b8:8b72:fa28 with SMTP id q18-20020a17090311d200b001b88b72fa28mr16257836plh.58.1696884194272;
        Mon, 09 Oct 2023 13:43:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ij8-20020a170902ab4800b001c1f161949fsm10270953plb.96.2023.10.09.13.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:43:13 -0700 (PDT)
Date:   Mon, 9 Oct 2023 13:43:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        stable@vger.kernel.org, Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        Pauli Virtanen <pav@iki.fi>, Jakub Kicinski <kuba@kernel.org>,
        Claudia Draghicescu <claudia.rosu@nxp.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] Bluetooth: avoid memcmp() out of bounds warning
Message-ID: <202310091342.C99D7BF@keescook>
References: <20231009203137.3125516-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009203137.3125516-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:31:31PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> bacmp() is a wrapper around memcpy(), which contain compile-time
> checks for buffer overflow. Since the hci_conn_request_evt() also calls
> bt_dev_dbg() with an implicit NULL pointer check, the compiler is now
> aware of a case where 'hdev' is NULL and treats this as meaning that
> zero bytes are available:
> 
> In file included from net/bluetooth/hci_event.c:32:
> In function 'bacmp',
>     inlined from 'hci_conn_request_evt' at net/bluetooth/hci_event.c:3276:7:
> include/net/bluetooth/bluetooth.h:364:16: error: 'memcmp' specified bound 6 exceeds source size 0 [-Werror=stringop-overread]
>   364 |         return memcmp(ba1, ba2, sizeof(bdaddr_t));
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Add another NULL pointer check before the bacmp() to ensure the compiler
> understands the code flow enough to not warn about it.  Since the patch
> that introduced the warning is marked for stable backports, this one
> should also go that way to avoid introducing build regressions.
> 
> Fixes: d70e44fef8621 ("Bluetooth: Reject connection with the device which has same BD_ADDR")
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Lee, Chun-Yi" <jlee@suse.com>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

A weird side-effect of the NULL check, but not unreasonable. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
