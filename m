Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7C97E0EAD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjKDJqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:46:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1F3133;
        Sat,  4 Nov 2023 02:46:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso4742978a12.3;
        Sat, 04 Nov 2023 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699091210; x=1699696010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sMRXFZ9a5n0WAejGgMET0U+udxZ2/riYDgkqBlodOoA=;
        b=dY6fku1f0QJBYjlsRbumjVG7JVYz4LdVqsNFKLfdJcrNC1rEW62dUb83GVAeWp8MB7
         zLi4/yUBeNZsEm5FNvDyOrx3p+hnbeGclF6Pxb9K1CwSWPTMzLVLqFgEeYWlwSyC26CL
         ZHmToN08OME7gJDV3e+nclVBTBlG56tn2AycSlZQ6Sx7r172pPDVopH2Odnmo4m09E3+
         G2y2fs4TOscxi6s45tWWqA27EPsKFH/IugaFhBRpmgTZ9dBIr5AnH4tyHvH3hJ8s5LWd
         Yd4SWf+P+S8bjAqqWNiwdHXIz2iEwS01CmTx0P2WqSIjJywOsh8P2J9Ho+pI1Z3LD8Jw
         L1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699091210; x=1699696010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMRXFZ9a5n0WAejGgMET0U+udxZ2/riYDgkqBlodOoA=;
        b=RNFumUa2QP+a5VS6hi6lZMnK/AklstITuZFAwBV/WzHUgqLVo/+2Y4qVMk9WUrdaoI
         /SnoKfzPLaoIlWB+pVJZgmRL2HYS5UzeWunRtuIK8m7WezKUkq+S8dDcxp4eV7zdySpU
         Uls75syyTWevWgVQdF7t8AuR3MCNt4NP5RjDj2hdjmlU+UWTlJC9v+ELg5S7O2usYV7d
         iXRLseZ0qH0v+d51I+eBmnvUdbZc6kFveo1aym1bIEveWKakI3QnAlZEg08MET+plDHZ
         Odd9VBq8nventvC4ZEC+pfQibW+zP/H7Q3yCRrS/6GfmDtOaViz6wCd8kG+0sZ5mOAUV
         RBDQ==
X-Gm-Message-State: AOJu0Yw4rgDlIw+po5ozSI8zEIf4ZpDA5jf1PijCWlypFBRoF4WFJAmL
        9/VKQy24QyStNfare8gu4q+4eDXcHqiq2vOMaS8=
X-Google-Smtp-Source: AGHT+IFgE0NQlGD0M4l7j719Pb8ZaEiQ+eqi8Pc4FAsy5C602YVUd7JuS86gAslF8m5Y+ntv29cy44nUniCJSPmUUx8=
X-Received: by 2002:a17:906:7955:b0:9dc:ee58:6604 with SMTP id
 l21-20020a170906795500b009dcee586604mr3776894ejo.21.1699091209838; Sat, 04
 Nov 2023 02:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231102210745.1107-1-cang1@live.co.uk> <AS4PR02MB7903A4094564BE28F1F926A6C4A6A@AS4PR02MB7903.eurprd02.prod.outlook.com>
In-Reply-To: <AS4PR02MB7903A4094564BE28F1F926A6C4A6A@AS4PR02MB7903.eurprd02.prod.outlook.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 4 Nov 2023 09:46:13 +0000
Message-ID: <CADVatmPEMnTJy-CTfkPBdG5OE9=eQqTu-v70_AUbpXc_oMax3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2 RESEND] parport: parport_serial: Add Brainboxes
 device IDs and geometry
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     sudip.mukherjee@codethink.co.uk, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Cameron Williams <cang1@live.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 at 21:08, Cameron Williams <cang1@live.co.uk> wrote:
>
> Add device IDs for the Brainboxes UC-203, UC-257, UC-414, UC-475,
> IS-300/IS-500 and PX-263/PX-295 and define the relevant "geometry"
> for the cards.
> This patch requires part 1 of this series.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cameron Williams <cang1@live.co.uk>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


-- 
Regards
Sudip
