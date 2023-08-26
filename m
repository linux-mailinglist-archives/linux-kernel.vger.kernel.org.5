Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9C478990A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjHZUcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjHZUcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 16:32:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F012812B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:32:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso449125166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693081955; x=1693686755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PE9rZFLJE37KfD4a/UIuVo+Dsin6CGfHTs/lNm1wAFY=;
        b=sNNHyRTnLjffOF9k4gRZR066bax1rmjkf/WD7nNhtm4nn0wDtMuMD8M4RC4POw/jzf
         24ltZOIk9PRmwFFBRcUPySu9hAvuCGMkmHgjAT1/C4/iQXvwe0elrg7ZypdHKF2rPaoU
         QS9kRIV3RDGtnCHVQfb5CECxTBFKo0casMTSRTUMkCmPSCLC/HGjH1LNFTBB20z2WIzE
         NYEqiFrUIn2+sMk05/y2ZsfR65R/nav+f1BEjzi2ojdy8jNl77WAmewVZPHKvnVsFHMW
         LjDllz4wqDPxrDdWGGpL+cF9Kj+jhqJcSicvgPoZUuZEniS6MvCiWbGwsnanLCgkhQt5
         fXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693081955; x=1693686755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE9rZFLJE37KfD4a/UIuVo+Dsin6CGfHTs/lNm1wAFY=;
        b=hcj9kajVFom+XaIyiP6y1laiOdi7JDYRAKDoMCqsH2ISKOkBF8eYil1xvS329e1oIH
         GlzB3TsWBDa2WGhFBXcpIzUn+c1AJAa1015Jmu0YUd/G53xACwKuqAX5Ayl/l2Kpxb+H
         S/A+8sWavthssfNfuuwq2uF/zepPNaDyM2put1djcjXE7Hb6JJp+ffJR9guTfQRa2r9E
         /wO1FphWsQ4+AIKZ2HQQPiTXjCprjBuT6gkzLj6w3CbiCGqZGRf25/lAR18syNp6Pfdi
         hucKJPH5xjlW0eAvxUAJfahkXxBxBcwX2SYMQQekuVamlPZ6o/CXXAFfBW3fKOWIlJpA
         775A==
X-Gm-Message-State: AOJu0YxsrxKgYgfVXyaxPRlgkMIs0YnNJWGc0Y0D3auzwPcObMf3Cca9
        2aaFE/TSibymP8LMXb+Ik5w=
X-Google-Smtp-Source: AGHT+IHbqiHt+ugtV8o2hCN3fAJ5kGysqFKzACJkCK3IX47e27JTky7b/SKEEBVMvLpxNUYoL5lepA==
X-Received: by 2002:a17:906:51db:b0:9a2:295a:9bbc with SMTP id v27-20020a17090651db00b009a2295a9bbcmr6730316ejk.37.1693081955216;
        Sat, 26 Aug 2023 13:32:35 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id v17-20020a17090606d100b0098669cc16b2sm2565556ejb.83.2023.08.26.13.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 13:32:34 -0700 (PDT)
Date:   Sat, 26 Aug 2023 22:32:33 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/4] staging: vme_user: fix check alignment of open
 parenthesis in vme_fake.c
Message-ID: <ZOphYXeTMM+QhnTk@nam-dell>
References: <ZOoWgZ7ZnGyWHUKe@alolivei-thinkpadt480s.gru.csb>
 <ZOpWxBjONs0QpFlU@nam-dell>
 <ZOpfUjRy3jDwZixX@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOpfUjRy3jDwZixX@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 05:23:46PM -0300, Alexon Oliveira wrote:
> On Sat, Aug 26, 2023 at 09:47:16PM +0200, Nam Cao wrote:
> > On Sat, Aug 26, 2023 at 12:13:05PM -0300, Alexon Oliveira wrote:
> > > Fixed all CHECK: Alignment should match open parenthesis
> > > as reported by checkpatch to adhere to the Linux kernel
> > > coding-style guidelines.
> > > 
> > > Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> > 
> > Patch series should be in a single email thread. But your 4 patches are sent
> > separately :(
> >
> 
> Hmm, ACK, I didn't know that.
> 
> > Have a look at how your patches are sent on https://lore.kernel.org/linux-staging/
> > and you will see what I am referring to.
> > 
> 
> Indeed they were sent as separate emails.
> 
> > Here's an example of how patch series should be:
> > https://lore.kernel.org/linux-staging/736c8159-90e9-4575-3c22-5a62515d5c03@gmail.com/T/#t
> >
> 
> Please, if you don't mind me to ask, how's the best way to do that?
> I've already wrote the cover letter, generated the patches' files again,
> but I don't know how is the best way to send them as you instructed me
> using mutt.

You must use the argument "--thread=shallow" while generating patch series
with git format-patch. Then mutt should correctly send them in a single thread.

The instructions can also be found here:
https://kernelnewbies.org/FirstKernelPatch

Best regards,
Nam 
