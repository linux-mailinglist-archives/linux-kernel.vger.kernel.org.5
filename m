Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F03380B0AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 00:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjLHXpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 18:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLHXpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 18:45:22 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99F4171C;
        Fri,  8 Dec 2023 15:45:28 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-425922f5b89so12789291cf.0;
        Fri, 08 Dec 2023 15:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702079128; x=1702683928; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YjiMTyTYq0iaoICIneQ1GFZjHnofXDyC38RnLJ083b4=;
        b=I7Mhz6vKilDTs0tLcoGB9sojDxqoKq3FssRw/891geVR+MOpsTyim9Hd/mcdwgZSR2
         1406PqcDN1lwckNb8SxIPnG8GL6cqkioqtqheXeiOS/s1zFrWS1H78pEOBygbIOO0dB9
         W1r24bcPCbTCeAOKxisz5NtSOmfZO3kTgD6psVW+ftBtmzNXFD5ZJyK8H/lqgmeVv6so
         l0Juo7rblufUbKsJn0mjDbI9nbmdQJz6bN7AqOXAuAHY9f2yzBY7Ial2eTx0YdJ7hFVL
         bSvtktS+OyFUn0zh3nDpaEvsxRsb1gcbFKURxhIqumK1loPdzQ6F+OSlL25BeK9fHc2o
         mG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702079128; x=1702683928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjiMTyTYq0iaoICIneQ1GFZjHnofXDyC38RnLJ083b4=;
        b=H6S29zethVHpckm/Y2rZJIJBOTGuLOH+tKS27Y51hyc+V+WFpMOPb6Js+YzAR6bN1I
         CqT7bm+qSeVFg0iwVGZAgGuejAPfySxWi906lLEIMwIu7XHyfXK1Edv/opFpPs/sN65d
         JEZOKbyR7H0M/3SOiVp6aZuTdgsEFUxhDBD+sP6X3r/YWs2g5Rj2xcfqDEBbhs3aygN4
         kYQ5kCW5l3Dp9pI5hUzsypafuy5jYWI+Bs/1wk2UeRRnKetdSGL25Bu+MccG0f8tW9kl
         jxONUtY0pcpZ0mueskFs+phicg47+CYKXvnN1BmQVEnlFJtAlAAtPa0iWI5s671ZNPZZ
         o3/A==
X-Gm-Message-State: AOJu0YxM2b6W0ZRGU23JKzueTZ5tppcElTJLRPDjiqLD18RdOX69sWJR
        KLWkMvBL4L7sigUuVkFTax0=
X-Google-Smtp-Source: AGHT+IFc2XIzsdgLtCJLn4PA5X0f5QOsTdKCu/ux5g+EbzKT72TDTN5x2/zKjSPLrCbAITjzuZThoA==
X-Received: by 2002:a05:622a:491:b0:425:a68c:98e7 with SMTP id p17-20020a05622a049100b00425a68c98e7mr1069510qtx.12.1702079127865;
        Fri, 08 Dec 2023 15:45:27 -0800 (PST)
Received: from google.com ([205.220.129.31])
        by smtp.gmail.com with ESMTPSA id c26-20020ac8519a000000b0042542920ec9sm1164692qtn.27.2023.12.08.15.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 15:45:27 -0800 (PST)
Date:   Fri, 8 Dec 2023 23:45:02 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Arnd Bergmann' <arnd@arndb.de>, Zack Rusin <zackr@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Raul Rangel <rrangel@chromium.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] input/vmmouse: Fix device name copies
Message-ID: <ZXOp5y4F2aoRq2UT@google.com>
References: <20231127204206.3593559-1-zack@kde.org>
 <ZWzLvctpo1nNTMOo@google.com>
 <d180f06b-64b0-4885-9794-5127c297a0f0@app.fastmail.com>
 <f3e6cab719c646bf91265b6fd2887061@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3e6cab719c646bf91265b6fd2887061@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 09:14:49PM +0000, David Laight wrote:
> From: Arnd Bergmann
> > Sent: 03 December 2023 20:51
> > On Sun, Dec 3, 2023, at 19:41, Dmitry Torokhov wrote:
> > > On Mon, Nov 27, 2023 at 03:42:06PM -0500, Zack Rusin wrote:
> > >> From: Zack Rusin <zackr@vmware.com>
> > >>
> > >> Make sure vmmouse_data::phys can hold serio::phys (which is 32 bytes)
> > >> plus an extra string, extend it to 64.
> > >>
> > >> Fixes gcc13 warnings:
> > >> drivers/input/mouse/vmmouse.c: In function ‘vmmouse_init’:
> > >> drivers/input/mouse/vmmouse.c:455:53: warning: ‘/input1’ directive output may be truncated writing
> > 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
> > >>   455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
> > >>       |                                                     ^~~~~~~
> > >> drivers/input/mouse/vmmouse.c:455:9: note: ‘snprintf’ output between 8 and 39 bytes into a
> > destination of size 32
> > >>   455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
> > >>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >>   456 |                  psmouse->ps2dev.serio->phys);
> > >>       |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > This simply wastes 32 bytes. It is perfectly fine to truncate phys
> > > (which does not happen in real life).
> > >
> > > -Wformat-truncation is disabled in normal builds, folks should stop
> > > using it with W=1 as well.
> > 
> > It does find real bugs, and we are fairly close to being able
> > to enable it by default once the remaining warnings are all
> > fixed.
> > 
> > It also doesn't waste any memory

... at this time ...

> > in this specific case since
> > vmmouse_data is currently at 168 bytes, which gets rounded
> > up to either 192 or 256 bytes anyway. I'd suggest using
> > the minimum size that is large enough though, in this case
> > 39 bytes for the string I guess.

This assumes we never change how our allocators work to provide better
memory packing.

> 
> That rather depends on whether any of the earlier char[] lengths
> have been rounded up to a 'nice' value.
> 
> I'd also have thought that dangerous overflows would come from
> unbounded %s formats, not fixed size strings or integers that are
> always small.
> 
> There really ought to be a sane method of telling gcc not to bleat
> about snprintf() potentially overflowing the target.

Yes, that would be my preference before we enable this warning globally.

Thanks.

-- 
Dmitry
