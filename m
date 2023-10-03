Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8477A7B6E42
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbjJCQVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240305AbjJCQVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:21:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECACAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:20:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-533e7d127d4so1941626a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 09:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696350055; x=1696954855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/uvu5bBvPizSRzo1SPPOiLc73cEkD2LgnLyo2sbR8xc=;
        b=dl1Ld7UGmfwVIJkMTaAeR+cEw7b4xxBdTRFsti1gdbkLM1BdUU9fJunvXlhcsnKvMA
         6HK6mXNWHBdgtu39jq8Ggj0x4THTijjh1Ht86mAcult4F30OGWD6za8+fW8WXT/HFwtA
         39x+NWReu+kdfTcj+iObukADYv54bPv2abie8xdEuOpE+t79SIVPUV7v1as/jOrmzSaj
         s1OL3Du1//vlzZBP+AArY+/bkmKo+1039Pz0g7lo+7TiuAGlphKZL2YnqbKSFBYbZZCR
         hq0aiXQiv13i/MVoJwHbBpSzhzvUlCTB0q3MhxVCklqXkTad0JWih532zVt1FtUx5Hnn
         BSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350055; x=1696954855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uvu5bBvPizSRzo1SPPOiLc73cEkD2LgnLyo2sbR8xc=;
        b=WEfVF/rHvMNFR10/x01osPGQ1gqqaM4cI/S7oGRU+IMh+MnXKAFSx3H7g1M7QVKbH5
         kl75dtrtcniSI/RpV7veCBZ+GwTOHZwNPf6+W4GChhW3gr2SA+Pr71vPwBaqFjg9ZTKb
         x21iCB7/MSOSG7ZvNSlN6evpwCImuI4iViyt3fdEuXF8udEm1TMFBpUHqkJwKAvJf4FW
         rdM5wNqyNWByuhhpp4yhd4Tu1iVJt9uFqPfO4F/Rxxgl8/t6smgGoERAFnGvh7E1Tuhi
         n97rzjjlC5N/taVYq6yW1rLVonsvvldc7TrsCfbGaoVqgEkmuOrWTx1pazKwS6aakznn
         5Liw==
X-Gm-Message-State: AOJu0YxMU3vsVfNDHf6MhNWLEFxwThQtNMiT9UVG+gy3tY+txuYHa0sR
        J60wmoeWV97d9M7WxLt0HA==
X-Google-Smtp-Source: AGHT+IEmiUBLpYOxjQc+g540/CfOFZ+Y33i9y2t7m6IolLTgBfpyWAk/xMmNkVGdaxWpoCk1nmje9g==
X-Received: by 2002:aa7:d7d4:0:b0:533:87c9:4a7d with SMTP id e20-20020aa7d7d4000000b0053387c94a7dmr11978377eds.35.1696350054929;
        Tue, 03 Oct 2023 09:20:54 -0700 (PDT)
Received: from p183 ([46.53.254.179])
        by smtp.gmail.com with ESMTPSA id k21-20020a05640212d500b00537fa467ddasm1073180edx.65.2023.10.03.09.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:20:54 -0700 (PDT)
Date:   Tue, 3 Oct 2023 19:20:53 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] extract and use FILE_LINE macro
Message-ID: <73bedf42-decf-450a-8e54-a318950ddc67@p183>
References: <ebf12ac4-5a61-4b12-b8b0-1253eb371332@p183>
 <202310021033.A5F0159F25@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202310021033.A5F0159F25@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 10:33:49AM -0700, Kees Cook wrote:
> > +#define FILE_LINE	__FILE__ ":" __stringify(__LINE__)
> > +
> >  #endif	/* !__LINUX_STRINGIFY_H */

> > --- a/sound/pci/asihpi/hpidebug.h
> > +++ b/sound/pci/asihpi/hpidebug.h
> > @@ -29,16 +29,15 @@ enum { HPI_DEBUG_LEVEL_ERROR = 0,	/* always log errors */
> >     the start of each message, eg see linux kernel hpios.h */
> >  
> >  #ifdef SOURCEFILE_NAME
> > +#undef FILE_LINE
> >  #define FILE_LINE  SOURCEFILE_NAME ":" __stringify(__LINE__) " "
> 
> Should this drop the trailing " " to match the new macro?

Yes, probably. This SOURCEFILE_NAME is some out of tree stuff.
