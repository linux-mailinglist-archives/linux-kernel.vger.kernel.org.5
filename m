Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A956979DA90
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjILVIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjILVIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:08:04 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44348199
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 14:08:00 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41517088479so1306341cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 14:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694552879; x=1695157679; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=egxGzUhhTSlw6eh+oTcq4RyJ+o0Gs8EU7IMyqm3dMyQ=;
        b=a0rcTH0xEIG9WJtesXSrVzXgvMspRbXiUNSXBg4zzYcL6SDQb0K1KcleLJtZVXfvaE
         NoErkAAOTDEj//PCVw2iPsXVw7C4diiqQZaUeMeZ75DmLPA0yzegOukPe9F/PWHNU9iW
         Uts+NW/3tU82ZC5ojAY/0SiuYubN8gnAQAD/mMynEqfm3+58FOQQt8nSkt9z6QDdp8jL
         TSdM51zifZA2t6dTDeCy397BSSTIcySSJZBB0E6Lg+ZKndF6k5zpk81RSWJ6l665LT1v
         Yp1bW+G718nXVjDIKRbV8MqQwPCs+RvN3nBn+GTM46k+Uy9ywMU7jvbYGJ327ob5JiF4
         +J4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694552879; x=1695157679;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egxGzUhhTSlw6eh+oTcq4RyJ+o0Gs8EU7IMyqm3dMyQ=;
        b=pgLcbTj/MrYAheu4PaFrUrlhRCpSEqyJ7gaWSyNnT/cmN3WdT55tiRrD5khUIf4EAz
         gO6rQdaJIRk4HgrTFlvpMCbuUa9HnNR4/xEP3l8iV18nEFyZHA1ExnPcLPgGO0DKACPr
         vQRpTR3K3s6WFpYeW0Y6tS693UrgR/2nUBU3lcDR3g000TX5UBPdwQEqPRuU4jRc/YRG
         +dfUgKepQTUTKRV/chaIYwUR8KJbIy7uy12+5cGWVky9qUs9rbfD9u9xzG9kC6H8GrXh
         ThfZw02o3cq8c4q/dSsO531fC4i0VxoV4E3m0W6rxYZrjsYPwFOYz1sqMc5I+YdRnQBO
         8E+g==
X-Gm-Message-State: AOJu0Yyi2SXn5qV1vukc2BLpuf/bNBBdl5eOeYhcGA3wIlxCgSEQML6L
        nXqvQp2nKonBoE3O3gn0+Zze
X-Google-Smtp-Source: AGHT+IHX2AXqKlyfk0SZkTX7HFPuWO3bPRlpekMPreTd/Q1vHChoInHfEjubW4h/TREsud5XXEwf3w==
X-Received: by 2002:a05:6214:2425:b0:64a:3e9b:fa0a with SMTP id gy5-20020a056214242500b0064a3e9bfa0amr4966773qvb.11.1694552879344;
        Tue, 12 Sep 2023 14:07:59 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id q4-20020a0c8cc4000000b00646e0411e8csm4003354qvb.30.2023.09.12.14.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 14:07:58 -0700 (PDT)
Date:   Tue, 12 Sep 2023 17:07:58 -0400
Message-ID: <d476b21729cafb28c1b881113a563b1f.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: reject invalid ebitmaps
References: <20230818152910.176044-1-cgzones@googlemail.com>
In-Reply-To: <20230818152910.176044-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 18, 2023 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Reject ebitmaps with a node containing an empty map or with an incorrect
> highbit.  Both checks are already performed by userspace, the former
> since 2008 (patch 13cd4c896068 ("initial import from svn trunk revision
> 2950")), the latter since v2.7 in 2017 (patch 75b14a5de10a ("libsepol:
> ebitmap: reject loading bitmaps with incorrect high bit")).
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/ebitmap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 77875ad355f7..ac9da819531d 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c

...

> @@ -457,6 +461,13 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>  			map = EBITMAP_SHIFT_UNIT_SIZE(map);
>  		}
>  	}
> +
> +	if (n && n->startbit + EBITMAP_SIZE != e->highbit) {
> +		pr_err("SELinux: ebitmap: high bit %d has not the expected value %ld\n",

That reads a little awkward in English, how about "high bit %d is not
equal to the expected value %ld\n"?

> +		       e->highbit, n->startbit + EBITMAP_SIZE);
> +		goto bad;
> +	}
> +
>  ok:
>  	rc = 0;
>  out:
> -- 
> 2.40.1

--
paul-moore.com
