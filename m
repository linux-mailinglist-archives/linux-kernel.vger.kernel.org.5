Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6A2761829
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjGYMVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjGYMVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:21:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABF8A7;
        Tue, 25 Jul 2023 05:21:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bb2468257fso28551055ad.0;
        Tue, 25 Jul 2023 05:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690287701; x=1690892501;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cnWD3DwULGe/vHl0lzjt4JBf1liZ6Y8f/YvLSUrQM8=;
        b=Gm3OK6GqP9gmG0jDC3GcT5CzT2uazRACBM1RC+SbsRjTTjfbUV41RlASWJGK8AVpnU
         pVm604yn9cZBe8u8VZ0dMuUEXlZgzv+SAaMzHFwtETRjMsz6r+M0gXeEvYj+5TABFepT
         ryfLvgSZYvmwDPQu0Bpc13Odne2uePXvDO8yw9x+yVWZK0Bkr7rvbtdoCh0eKMl1AVLR
         7wmwl1Lin8bYMuFHjDLy+ZIBoCeCINvAB7keABtaSzt/dE+n8/MwoXCAZgWhPGKSHh8y
         oxbzxfuw6BvHG94j+LSHh9OKrabszldtUA8v7MZI8CLKo/GO3UEBGbxhVe5eubURDBXj
         mtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690287701; x=1690892501;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cnWD3DwULGe/vHl0lzjt4JBf1liZ6Y8f/YvLSUrQM8=;
        b=ewjYW68ShYVjOkwCaIXUs+lnjSKjiNdbH37VF+lhQroknzzqUUjmbLh9gAJ8OzmTV2
         b/HIuhLOs9tNDHgixJSqH1SDEgKiP2vQRqr/DnkRJjMZeG6cf27fK4Rv6CtY/ihzDXeE
         XpS6O9RA2YOZfYib9Qc6yaGkkA1xWpyDykPIzil6pdGFJlUQr/9/XMgfx2BEvWkTfdI4
         XooEXeHzc9LBbIVSiOQoDLbtgTywpv5SyHLWb1FgB5W/svhIOxePwGkQgEsjHNbZaS99
         gaL8mXzkPujJsi5x34N1shWxEcflKwSxs6h6u0DxbtpTjk7w6QtRTiow0UdQwrafFRpM
         sagQ==
X-Gm-Message-State: ABy/qLbXg9/PL67gnWSqY52CblHzZfOgwN7Z0ss38GHTY6ZA1U71/3hY
        pkZMC5/s/EEs8vVUc316V+Y=
X-Google-Smtp-Source: APBJJlFPnSG+glgygdNl9mzcy65ryIY4k9fUUs5Tbe48zDuahDXbjWOKghBCMulVzQniXAfGAPzd5g==
X-Received: by 2002:a17:902:d4d2:b0:1b8:b4d5:4c3d with SMTP id o18-20020a170902d4d200b001b8b4d54c3dmr11205357plg.51.1690287701094;
        Tue, 25 Jul 2023 05:21:41 -0700 (PDT)
Received: from ibuprofen.lan (202-79-124-123.east.xps.vectant.ne.jp. [202.79.124.123])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902a71100b001b9c5e07bc3sm10940916plq.238.2023.07.25.05.21.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jul 2023 05:21:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v1] sh: boards: fix CEU buffer size passed to
 dma_declare_coherent_memory()
From:   "D. Jeff Dionne" <djeffdionne@gmail.com>
In-Reply-To: <20230725110942.GB31069@pendragon.ideasonboard.com>
Date:   Tue, 25 Jul 2023 21:21:34 +0900
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        petr@tesarici.cz, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <71E09AAE-1196-4D5A-8AB8-8E07263D0F2A@gmail.com>
References: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
 <20230724171229.GC11977@pendragon.ideasonboard.com>
 <31ad16fe8f1435805185ba8e889512ec181a867e.camel@physik.fu-berlin.de>
 <20230724174331.GD11977@pendragon.ideasonboard.com>
 <314b21abaade55ba55ccdd930f9fdf24028cadf0.camel@physik.fu-berlin.de>
 <20230725110942.GB31069@pendragon.ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 25, 2023, at 20:09, Laurent Pinchart =
<laurent.pinchart@ideasonboard.com> wrote:

> Will you have time to port them to DT, or would you rather focus on
> J-core systems ? Do those boards still boot a mainline kernel ?
>=20
> Dropping Renesas SH board files doesn't preclude anyone from moving =
them
> to DT, all the information will remain in the git history.=20

J-Core developers and engineers are not in favor of gratuitously =
dropping Hitachi/Renesas ports.  That=E2=80=99s our history.

J.=
