Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B800765963
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjG0RBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjG0RBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:01:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4318DF7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:01:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686b9920362so935718b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690477299; x=1691082099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NrdhbFq2TllUS3d1FOZRRA3ctMM7rEJWO6QWxhxN4X0=;
        b=gwKxjNrjlnXnzgiB40rgMiBl0/QtgC8VUcyszpZozy4dcwVgAWS2E8bfdp7c2YpL2f
         5K1p3ziPEsFBp9RabGxDWzD4SQH6S3e8EASPNAMSMVBUt0T7osetBpBmUJH8w16wFkCj
         LSWPtmArmmchxRrkcE2YLqO7umBc5u/VxmrX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477299; x=1691082099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrdhbFq2TllUS3d1FOZRRA3ctMM7rEJWO6QWxhxN4X0=;
        b=Qtxc+A+tCtdHAko6Mw2e3xVywfiotbAfKGcpDINy/aUmmzKshOCZNsZ5iSLtunQ8fM
         pCX3ISFAiRjcNAjpCFeZPQkc2ECHFD4xOy9E5+BOloYauacMhkj99MS2QWUheLqCEPFI
         vSiGDk5UYR81pdwPlAKylapZ165dMZpjwCMdi6T4FpeCZMlagnJtkQ4MTvtdV8r1pCy2
         +sBIgRqrDsK5q3RlKoblGmRLKlsHdcvVoPo2SzF4G1/2AzherLbhC+f6RGCdLcxb9bOF
         qPutjEat9r7zxhv5k4SgDNxk5m0qXPt7vyz4DB2+JJ+ruUzeuoRhKgLCVCoiAWB9lXSe
         h8Lw==
X-Gm-Message-State: ABy/qLbxrzqQsvSPGfUQNFdtnetw2vzrwkiWOI+q3jct817jAKxKvW/v
        z+Lsnq9or8uq+7nkXqtAuuORNg==
X-Google-Smtp-Source: APBJJlFApVlNeR4dyVr69s6M57WJ+jQYcGl2/Dm1rae4njEHS0rUSMH2qUw00/brVLWB60QevPBe0A==
X-Received: by 2002:aa7:8894:0:b0:66c:2d4e:4772 with SMTP id z20-20020aa78894000000b0066c2d4e4772mr6049993pfe.13.1690477298723;
        Thu, 27 Jul 2023 10:01:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z17-20020aa785d1000000b006829b27f252sm1766012pfn.93.2023.07.27.10.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:01:37 -0700 (PDT)
Date:   Thu, 27 Jul 2023 10:01:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: Replace strlcpy with strscpy
Message-ID: <202307270959.900E3A345E@keescook>
References: <20230703181256.3712079-1-azeemshaikh38@gmail.com>
 <169047317159.2400214.7882697833368890001.b4-ty@chromium.org>
 <87tttpz6ne.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tttpz6ne.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 07:00:21PM +0300, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Mon, 03 Jul 2023 18:12:56 +0000, Azeem Shaikh wrote:
> >> strlcpy() reads the entire source buffer first.
> >> This read may exceed the destination size limit.
> >> This is both inefficient and can lead to linear read
> >> overflows if a source string is not NUL-terminated [1].
> >> In an effort to remove strlcpy() completely [2], replace
> >> strlcpy() here with strscpy().
> >> 
> >> [...]
> >
> > Applied, thanks!
> >
> > [1/1] wifi: mt76: Replace strlcpy with strscpy
> >       https://git.kernel.org/kees/c/535c78cbc0c4
> 
> Why did you take this? mt76 is in active development so risk of
> conflicts is high.

There didn't seem to be any further activity for 3 weeks, and it was a
relatively mechanical change. I can drop it from my tree. What's needed
for it to be picked up through wireless?

-Kees

-- 
Kees Cook
