Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5642756183
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGQLZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGQLZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:25:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A285F10D0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:25:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so44441755e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689593111; x=1692185111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Ys1YN2HOQPJOEjXN2Csu3md0LswG0ZSrzC1ZYuVgkU=;
        b=R5NPDI6zbqhzkhZaXbu1D6Lnni6a89Z2vr7sySP/graqSVqAte7SS3M/rcmoPa5p1u
         s353AmKlRE1g9Vjny40WxOCSBI/t0qQuxXK3n1Cj6LL3RsoxbDJJJSng4R6rq6MCKZnr
         y6o7kA8Rdh0fCLEptcjaFY6jfe/ypeS8eEwzNUaPCbEGANzUbGWMV3+G0mfg+vgdn/TZ
         7KWkZolmbGLW0DBKcsCJnwtOCWbFPXXzQZi4FhcWWqnGJ/hsCNyvo0yn+BpWIPhQ/D3K
         8qbkBwhUNtjokCaKNvJEHIv4hsZVqaRk7lCUh/Jn7VjskQEBOvMwKTZmcZ/2AmqqsOwQ
         0irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689593111; x=1692185111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ys1YN2HOQPJOEjXN2Csu3md0LswG0ZSrzC1ZYuVgkU=;
        b=LE2OTmcZ1m03V+NI8nuF6gr1iElSc/teDwLoKexQzNdMoRzelp3x8wCYA1cJ4E62I3
         aQzCEo4tLIwasjWUVbRRdf8Z2CKd+RswYtEjUBlIKjrBNKHptAJT5oNjpM1FvZ3gFBUx
         Y+fgZkv5E2MzcPNX3SegIejQPu1Xpfq7C0ICIOhWOc5HhyJcb7yk6VgKO4ePAepu9FSE
         BX/Yhk8TIqKUdU881OS0shAes+P5RMazfpkGOBx8ZL0uuTGp7C2bNym1hl8i+GEMwBgG
         sp5YxPibf9STqLZ+ouchafXi7Ok9RqFQN0uoYbh3pWcTxfrtwX3dre7R8weNoixiF8eY
         8Htg==
X-Gm-Message-State: ABy/qLYgsQfaJFnguBY7gPSGTNt/Iynr2MHs0GUF+ltIyvu9sD8gXJOv
        a00+3S9gAk3oyUYpBuDXWGN7/DHq/Pv04by73h8=
X-Google-Smtp-Source: APBJJlHpol2ylHXvu1RA4C+qcwPwHZ9exr9Mc6FepvcBhLgXwr5+sMLw/YyfAhjDrwacLIcI/Y6sTw==
X-Received: by 2002:a7b:c7c5:0:b0:3fb:cf8e:c934 with SMTP id z5-20020a7bc7c5000000b003fbcf8ec934mr10093708wmk.27.1689593111086;
        Mon, 17 Jul 2023 04:25:11 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bc5d6000000b003fa968e9c27sm7695338wmk.9.2023.07.17.04.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 04:25:09 -0700 (PDT)
Date:   Mon, 17 Jul 2023 14:25:06 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     joeyli <jlee@suse.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Chun-Yi Lee <joeyli.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: hci_event: Ignore NULL link key in
 hci_link_key_notify_evt()
Message-ID: <7cc32a46-b4f6-4d92-bf72-24fdbb8f3eca@kadam.mountain>
References: <20230714161210.20969-1-jlee@suse.com>
 <8eeb958e-d947-2f6d-5942-d30746cf1268@web.de>
 <20230717055150.GO5866@linux-l9pv.suse>
 <7cae670e-b7c5-470b-536b-ab03513cd0a3@web.de>
 <20230717102310.GS5866@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717102310.GS5866@linux-l9pv.suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 06:23:10PM +0800, joeyli wrote:
> Hi Markus,
> 
> On Mon, Jul 17, 2023 at 08:15:56AM +0200, Markus Elfring wrote:
> > >> …
> > >>> We can ignore null link key in the handler of "Link Key Notification
> > >>> event" to relieve the attack. …
> > …
> > > Sorry for I didn't capture your point.
> > 
> > Did you provide sufficient justification for a possible addition of the tag “Fixes”?
> >
> 
> This patch is against a CVE. The issue is not introduced by any old kernel
> patch. So I think it doesn't need Fixes: tag.

You should probably put a Fixes tag against when the feature was
introduced.  (Kernel's prior to that were not affected by the CVE).

regards,
dan carpenter

