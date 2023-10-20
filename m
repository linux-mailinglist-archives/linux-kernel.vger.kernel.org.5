Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF127D160C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjJTTB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTTB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:01:56 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD4114
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:01:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c16757987fso16891101fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1697828512; x=1698433312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+rNwtsqBRU4k0b40DC9TyN3y9Xu8Yggpfh/XWF4qWmY=;
        b=df2L0RDCcllQp3bJL/HfYYNogRQRjZXKPeA/Vr8Vwe6gGwH5j83YlXuJlZpjJfB8aa
         yw9isFFhaw5VXFTuGId+Uul4OLZdllTjxhJBBoOLOkgmVmNEwDjO5iEtehEF1qePEgIn
         eTF+bFjM0TqM98xOI5v6Xozif9OCTEloDORH3rYZJbFih9e2JUNL+sKK8f2yUl0tUr5f
         f5MyMKM5mUzmA+I7tP9nfeKmGcq4NVVjdub/upgNPrnpMMBriV0oJlPRYwGecCjFD8VV
         /vksq3jiImwvOUlUlW1fDtBPfp4GOYfgpkptVlwNzNZWuHLQCpJo90IBtM8+504pf8/m
         uBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697828512; x=1698433312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rNwtsqBRU4k0b40DC9TyN3y9Xu8Yggpfh/XWF4qWmY=;
        b=gRIMDaVJbCdDFNXlWBej9Es7ZuPPbfROZrXBHie8mJyKX6D7Pdn4sNl6YCm7b2lvep
         E7RANn/zpEZbAD94wACfdU14GCnVsSZ0s8O7BE+5jLiAWqJWnV7wE943BvBOnYKsAxiK
         7HFdDd53e55vJKkfa7/oMkfz1xNEY/dFl4NiDkvknSvE7iqY07txPY9v13cAhkvzx3uR
         GBuReXHOiSMmZ6dj1VNCFZy5ZRs7iRj4YeF3smfDBeKeJ4r4/KCpplqTSfVNMOwesv8V
         4zaiJ4BKHLqJTniP93mGf+NsF/BC3nuGLP7K0Kjp5iYzSoDG4VsLqVEsGU3/hiH9/dt2
         Qv5A==
X-Gm-Message-State: AOJu0YwF2OEGgOn7BBwR33dER5jjUkihGATJ0hmgw21LsRnNTC1hnnaX
        g0ENAZ5YPlRb7WHbqtz62EpL+Q==
X-Google-Smtp-Source: AGHT+IE47nBA9ytsrzVwsDYVlnvKftOrPtSFjGHR+mjdn/HhdGWaG/rDK3adcbET1UhwFzS2ARF4eQ==
X-Received: by 2002:a2e:b896:0:b0:2c5:103b:b0af with SMTP id r22-20020a2eb896000000b002c5103bb0afmr1977821ljp.24.1697828512390;
        Fri, 20 Oct 2023 12:01:52 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id az20-20020a05600c601400b004054dcbf92asm2781208wmb.20.2023.10.20.12.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 12:01:51 -0700 (PDT)
Date:   Fri, 20 Oct 2023 20:01:49 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdrom: Missing a blank line after declarations
Message-ID: <ZTLOnUgfWDHHkHvK@equinox>
References: <20231015172846.7275-1-edson.drosdeck@gmail.com>
 <ZS2eKOZF2J7q7zkE@equinox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS2eKOZF2J7q7zkE@equinox>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 09:33:44PM +0100, Phillip Potter wrote:
> 
> Hi Edson,
> 
> Thanks for the patch, looks good to me, will send on for inclusion. That
> said, I will also tweak the title/commit description to a more imperative
> style, given that this description itself currently triggers
> checkpatch.pl due to line length.
> 
> Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Regards,
> Phil

Hi Edson,

After conversing with the Block maintainer (Jens Axboe) it has been
decided that this will not infact be merged, as all it does is introduce
newlines and patches of this type generally just cause problem for
auto-application of patches to stable kernel branches. Thank you anyway
though, and by all means feel free to send other CD-ROM patches my way
in future.

Regards,
Phil
