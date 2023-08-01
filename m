Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC24076BB41
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjHARaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjHARab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:30:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009A5E71
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:30:28 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-563e6524aaeso3446270a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690911028; x=1691515828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5UkfaFNS6PyQamzbmmCA96R1ctLMlDtPFxg5rPKFvn0=;
        b=ig03R9f26Io9mZRy/gthUxgE3w+/0k7snxeJgxSl6+mwRNVWizC02DNjIQDq8m3xrH
         Vg840aKGAHvEdMCDs04jyfu3tyarRhBnRM84RJCzWd5nUxZPZ8k7tWC/tinCeIEbqtOf
         4Xd/hpUfIMEz1/0zzW7kCpw/bOi703v2qdmP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911028; x=1691515828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UkfaFNS6PyQamzbmmCA96R1ctLMlDtPFxg5rPKFvn0=;
        b=H6Ia4ybs3H9gCQcrw6wSolxIxs3LAW00m2rhK4auWyu0zVRBGm7elKSbNoRlvbmtok
         VOYtK9YdX6VAGxI9VOkmkTlFmHcquXxgg+x0aRIXyBNzbAOupokkeJVbQNwa3nUr2CFJ
         aURBEEyw6kM1eZIb7biqclwOF0fbVzRaHYATjU5d9dJ/bovfBXB1c5tGdKusZddAVIpx
         qudwlDBFW8V0d/ZACRk+BGUYSOU8zftyMM1HhbhLWki+0Nyxh+jwpTNRrGrB4RX2zrs0
         utTRqE5TRUNkK1HgrFu/IY1AxlYddkT1M+rPW+tXqbbAgzGnMKfLAs9UQzJ36qrKxRDq
         KLew==
X-Gm-Message-State: ABy/qLYZQH4INbnIia7Dd3Pw6ddkE9Ww0xBpQQbSKjUM20wLjCV1o0Wc
        lbx30R3tW3m9mZBJrfni3/yc7g==
X-Google-Smtp-Source: APBJJlGeRYdG7+8sYbdVaQYLv/kApU8rzcyO+v9cxR1ZM3lkg/IZowd6BZdBE5G926/17ajA741tIw==
X-Received: by 2002:a17:90a:46c7:b0:262:e742:f40a with SMTP id x7-20020a17090a46c700b00262e742f40amr10648695pjg.44.1690911028158;
        Tue, 01 Aug 2023 10:30:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z136-20020a63338e000000b0056001f43726sm10106893pgz.92.2023.08.01.10.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:30:27 -0700 (PDT)
Date:   Tue, 1 Aug 2023 10:30:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Ian Lin <ian.lin@infineon.com>,
        Wright Feng <wright.feng@cypress.com>,
        Hector Martin <marcan@marcan.st>,
        Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ramesh Rangavittal <ramesh.rangavittal@infineon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ryohei Kondo <ryohei.kondo@cypress.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Brian Henriquez <brian.henriquez@cypress.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <SHA-cyfmac-dev-list@infineon.com>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        petr@tesarici.cz, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH v1 3/3] wifi: brcm80211: change channel_list to a
 flexible array
Message-ID: <202308011028.BC462D29E@keescook>
References: <cover.1690904067.git.petr.tesarik.ext@huawei.com>
 <c18a31a293fb5ba5d7a845c4b5052516ff724a9f.1690904067.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c18a31a293fb5ba5d7a845c4b5052516ff724a9f.1690904067.git.petr.tesarik.ext@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 05:36:42PM +0200, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> The channel list is in fact a flexible array, but it has a length of 1 to
> make sure there is enough room for the special chanspec -1 when the struct
> is allocated on stack to abort a scan.

There is patch series proposing a way to put flex array structures with
a compile-time-known size on the stack. Would that help for this series?
https://lore.kernel.org/netdev/20230801111923.118268-1-przemyslaw.kitszel@intel.com/

-Kees

>
-- 
Kees Cook
