Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF797D83D2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjJZNrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZNrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:47:14 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53751BD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:47:12 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9a6399cf78so823078276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698328031; x=1698932831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9n8fdUMuomZpDrsqxoqTl0ThgWJwRuU8B75KmpTiCQ=;
        b=MCpUpM7CtFd1Btnkh1HIhaUSCpEnpauHx760oIQliConkLYOX9efKUT96lyZIoWiVZ
         fTVVmVl4xdHL/H5S1eLIavWaW+4vWHHmgtKiKSu899To+qM+s+tgcxNcjoY2VEYmXmoP
         L0lx1M7chS5sMrz6K0xS59X7hRs3uCwpCh0hAvp/ffqQv1E/8fAtE1XcLVLAlfsuKh4v
         RnHok0wD4xBEVbms6KG+lJH+wucy5WAaup5qGuS6OVdRV7qLXIG/MGBSlyyk11tlDN5x
         pTzrOonKfnkDiM5thKG4FDzSTERdbPaHnW2ZQnqt63+svDFc5PAtOcefFz9NUq0/VDvX
         QNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328031; x=1698932831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9n8fdUMuomZpDrsqxoqTl0ThgWJwRuU8B75KmpTiCQ=;
        b=tcDPYciSB3Pob/bSWemnzqWv7TGsNgFDqzUTyif64ldwKiJe5hYTFH6XT1tyYS39/m
         5mhYFLPdv10GuJ9ckoeWe2muoewE4QGKdxI/aRYec6azj936n93stMUbAxpx18s9ELP8
         851P+qb10KLmLGla+t5cOJZgqbnSxzdQCeSpbQk+iWw1jZKUG4uSnw480A0w7DfqytCl
         q1cppTGLaSLH9DMAMGgyzOA/vN79VB1uS5N/imfG1dEtgoult/3+mXp2m6EjRvCtr+R4
         kbpLpbkhpYZDUaTdf3kAPZlhT9SK45cVNdXiQ1OVcB4MGAUpzkSNIOEzbSeeGxV0zXgm
         WXJw==
X-Gm-Message-State: AOJu0YzjTBOHkPSoxlPBG3VwUrhYmQ83AQG8TUkOTBSHLDdpJZKExuXm
        p7bArst/N/uvRddjVCzb5yGK8wmhIeHF65+7qLRjy9/Dp/2Vxb72
X-Google-Smtp-Source: AGHT+IGzqfAtuY+CnvRNbJPNwqa8xrhztIhzvjmFd68cerFhlPPGEGhTxQKguYR027QteX+t5yUAkIEXGQBA9Orufqc=
X-Received: by 2002:a5b:8c5:0:b0:da0:3ec1:f3f with SMTP id w5-20020a5b08c5000000b00da03ec10f3fmr5401782ybq.3.1698328029846;
 Thu, 26 Oct 2023 06:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com> <20231026-mbly-uart-v1-5-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-5-9258eea297d3@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Oct 2023 15:46:58 +0200
Message-ID: <CACRpkdbLqB29gMHYU2sT=3VD6XuOeaFSAdO2=qDS+=KCBi0jPA@mail.gmail.com>
Subject: Re: [PATCH 5/6] tty: serial: amba-pl011: unindent pl011_console_get_options
 function body
To:     =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 12:41=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:

> The whole function body is encapsulated inside an if-condition. Reverse
> the if logic and early return to remove one indentation level.
>
> Also turn two nested ifs into a single one at the end of the function.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
