Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FC276E010
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjHCGNC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Aug 2023 02:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjHCGM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96783272C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 23:12:10 -0700 (PDT)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528--Tk1P5JGNMG5bhsBZ6S_Og-1; Thu, 03 Aug 2023 02:12:08 -0400
X-MC-Unique: -Tk1P5JGNMG5bhsBZ6S_Og-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6bc56f23c65so963948a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 23:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691043128; x=1691647928;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PclpYqCH63o/7EbB151IjCBiyPLFzNdla2ERVVKFqV8=;
        b=lBMqPhSVfgEftsxmeLJelIuMWcWUlIj3A11ShTsFAkFuHpr1657U+VGC6Dy5bWuk3x
         2kG1kRYLLYhkAYO35m5yAtKC8tF+A3qMjcv7tWrnGMqFqY3csOL9eo7A3S7MJ3bq7mFM
         XIWOLYGH+P7IYGlloExA2I4Xsu9gQF1k0ZH2BM9mGw2D6dOpBp+nVZpPd4odkUuW+8Kn
         AXxoD8gnbnCf3zCa5sZfmdlDL7gHLs12akBTS0dk8v/laNlI751KlCiI9auR+82AyanL
         pu5Bh5H9toQmM1kiyuN4c6v09wL3NX+B9dcSbJVEUzlwH82sf40wS+QoMKFG+YHdWX31
         OWyg==
X-Gm-Message-State: ABy/qLaD1qBVsZoh883p7W6//MpmwpvqPlf2Q/9s1pksX7QmgMXFoFHr
        0talIfRymTaI/JAmrr9T6Az6v1xwEHnnJMI5761rIy99ypGb0i7gNREKeib+4NrPL58Ln5LReJX
        tKC34J5j2fhzl8k+MeFI9xr7+
X-Received: by 2002:a05:6871:612:b0:1ad:e92:62e1 with SMTP id w18-20020a056871061200b001ad0e9262e1mr23687273oan.54.1691043127866;
        Wed, 02 Aug 2023 23:12:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHS2DsU4Eh8oiwpO8PbZCofaG7KV4HOa4kFX9NdmO3QgQN6/y2JXtScFIx0Z/yy0aTGdZ761g==
X-Received: by 2002:a05:6871:612:b0:1ad:e92:62e1 with SMTP id w18-20020a056871061200b001ad0e9262e1mr23687260oan.54.1691043127621;
        Wed, 02 Aug 2023 23:12:07 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a801:d380:694f:4f52:764c:4b7f? ([2804:1b3:a801:d380:694f:4f52:764c:4b7f])
        by smtp.gmail.com with ESMTPSA id a18-20020a05687103d200b001b047298a44sm7211716oag.52.2023.08.02.23.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 23:12:07 -0700 (PDT)
Message-ID: <e7bbf95cb0b79dc4f508f554675af4d1138fdfe8.camel@redhat.com>
Subject: Re: [RFC PATCH v1 0/2] Deduplicating RISCV cmpxchg.h macros
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 03 Aug 2023 03:12:03 -0300
In-Reply-To: <ZMsboVmlrWhjfNJd@andrea>
References: <20230406082018.70367-1-leobras@redhat.com>
         <ZC7/LzV53KsZ/cSn@andrea>
         <2f301cd6c4009248c5eb6af00f12f36f3127ca10.camel@redhat.com>
         <ZMsboVmlrWhjfNJd@andrea>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-08-03 at 05:14 +0200, Andrea Parri wrote:
> > > LGTM.  AFAICT, this would need to be rebased, cf. e.g.
> > > 
> > >   a8596dda1fbf7e ("arch: rename all internal names __xchg to __arch_xchg")
> > > 
> > > from the tip tree.
> > > 
> > >   Andrea
> > 
> > Thanks for the heads up!
> > I will update this and re-send!
> > 
> > 
> > And sorry about the delay :(
> > For some weird reason neither the cover letter, nor your message reached my
> > gmail, and just now looking at lore I could find your message. 
> 
> All's well that ends well.  ;-)  Thanks,
> 
>   Andrea
> 

Superseded by v2:
https://patchwork.kernel.org/project/linux-riscv/list/?series=772422&state=%2A&archive=both

Leo

