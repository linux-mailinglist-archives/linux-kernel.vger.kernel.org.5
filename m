Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2434776DECB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjHCDOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjHCDOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:14:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E0726BA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:14:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso493613a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 20:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691032488; x=1691637288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCmRhEn7acE0EeZXBjc4bZ+e4lkMA3dESMJ2NR80pQI=;
        b=ssFkzkPXHd8jVwKVBEtxh9iKaMto13MD/V5TbGWkQbBZ61LmdngEFvVkkTULDCXVQG
         hl/QcK4D/nJh/ZKUU6XZhZ/v1SQh4rkOYHxbilygY6jtpKnDwhCUZDGY0CvOT2ROV6yK
         Qb+0S3wDgmSwaLMNO7zJHW8w2554Hw36Ehsx44JTlAkr+RCF/hCMi9iCcFZ+8m9lBsU+
         dkop4vz/5G+SYrhkmxCiMIoLjHD7f9Npi1BUSVDVuAWGrKpZt3b4MvuJRXZe7rBq/mO1
         xETBK5iTh3v4wXwVP6vbkaFlOnOIq95ehrLXgLKJU9k52ehrAve3pu69HZXwEVA5sC9B
         5alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691032488; x=1691637288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCmRhEn7acE0EeZXBjc4bZ+e4lkMA3dESMJ2NR80pQI=;
        b=CGgBWU6C2wSTGjOSV1/9+OXYTs2puwW69ky+Q+0ZmVeOOugRfo6tRrAEnnqAEBrqbt
         iOiyPdsCtnvW+xOaRIdTVvkEG22UXzOOO2/lzrm4YgmD2Ziv/JSZ9qNPNXszOWS7dyjj
         TTHDXcpJHW0xyUrHkw2y9xEqAoh9r3WA+HRerriB/pjGFxB6Ye9qt0eTGgL4B8OTLVD0
         hfqo7yKomrmkgLW5FfyKdAM7UI9VltFgtIYNm8zpkvDkv02i+lgu9lbUX5cHTGCRGAY4
         yekhtebYg5gIYpRtVU3441FxWVjxSDRijwcERH+Z9hbmxxhe83EUEl+TP4Tz71sNm/VB
         0S3A==
X-Gm-Message-State: ABy/qLYJTRBQntuprsHsB/+NGkX0fqsYNOKUFvf19XM+baB+BbUs+Rm8
        ++OA+nwjD2Z/O5colVJ90Ak=
X-Google-Smtp-Source: APBJJlHsrCYZaYZH7ZJI99siUd6uXcZkUDZc007Y4cKhbUNk0R7LMiGKBUeM1+7N8o/DL6CetMql7A==
X-Received: by 2002:a17:906:8a75:b0:99b:4afc:7714 with SMTP id hy21-20020a1709068a7500b0099b4afc7714mr6165885ejc.44.1691032487767;
        Wed, 02 Aug 2023 20:14:47 -0700 (PDT)
Received: from andrea (host-82-57-177-142.retail.telecomitalia.it. [82.57.177.142])
        by smtp.gmail.com with ESMTPSA id dc26-20020a170906c7da00b00988e953a586sm9874967ejb.61.2023.08.02.20.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 20:14:47 -0700 (PDT)
Date:   Thu, 3 Aug 2023 05:14:41 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Deduplicating RISCV cmpxchg.h macros
Message-ID: <ZMsboVmlrWhjfNJd@andrea>
References: <20230406082018.70367-1-leobras@redhat.com>
 <ZC7/LzV53KsZ/cSn@andrea>
 <2f301cd6c4009248c5eb6af00f12f36f3127ca10.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f301cd6c4009248c5eb6af00f12f36f3127ca10.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > LGTM.  AFAICT, this would need to be rebased, cf. e.g.
> > 
> >   a8596dda1fbf7e ("arch: rename all internal names __xchg to __arch_xchg")
> > 
> > from the tip tree.
> > 
> >   Andrea
> 
> Thanks for the heads up!
> I will update this and re-send!
> 
> 
> And sorry about the delay :(
> For some weird reason neither the cover letter, nor your message reached my
> gmail, and just now looking at lore I could find your message. 

All's well that ends well.  ;-)  Thanks,

  Andrea
