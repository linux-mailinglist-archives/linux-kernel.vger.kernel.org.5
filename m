Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE587B61E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbjJCG6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239431AbjJCG6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:58:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D0E3;
        Mon,  2 Oct 2023 23:57:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c2907ff9fcso6305531fa.1;
        Mon, 02 Oct 2023 23:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696316219; x=1696921019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FfJA992CYJJutCMUynHW6oD9A3N9/SE/3LR+g9biDIU=;
        b=bTwfs7L04E8205Zp94tf4kO5JbgWa7zz74uS+KbbmokvpbEQ+QC0MG8hUiCYJiJ5ZA
         rvGKtvUdooA0kfo4x1BatCV7hGt6yh2O/Z11I8xst/cB+8QAzsJvNxzso9SfnJnm12Vp
         OH6UTLnQmRkBehwVOkv+NzvfY+IrUaNeIYWwusRD0GMTCoDOW7kGou4U4+bhvlKUNY4d
         OOmsa8ptfKZ58kri0Q2N9Xsb4Dv8k+4ilxuLcUlVD07Xg/l0r25vkzp+wfUK/3ubcESK
         dxYjQd7LHiyoRwQZoqd5LFISHKOknfeipfHsEPx/9CEKrPWxTVz7WkuIKgdkP6aMLWk0
         A4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696316219; x=1696921019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfJA992CYJJutCMUynHW6oD9A3N9/SE/3LR+g9biDIU=;
        b=eNrsBoejTvfRnLGgU9WYqCUP/DADmzwsRG1mjZfCjO6e6xpaoQyGNTl6iFdZedZszU
         +ntaSemI8L7zqBnKFEPQJGw4cK60n9KeTTkbZVdK0zjPBRsZEoYXn3Qu49NWDEqpUuFI
         W9omhDi5rhTKDeaBBi6R11NCtTOpCvfjqTnCh+x4EndIgcQhwtVAbZ+F5yMwCQQcL0E7
         HkQES3vzWxYnTiyE8WXNqPN0pB+5+x5lEAIT5/jSXn3uV0maSZf80xtel7bKQRjUjji1
         e9MJsWhxe12YaVbtT8FQnQuf3g9wsqJgbopnxrAyevNLWxenXIExs7RD1G7hwUUlo2AO
         m64g==
X-Gm-Message-State: AOJu0YwmI94qCfJNAgUOVP+8HBCkhJws+oJoLU6tiz82e0e1H6xIXk6i
        Xzt0DDBn1GWPdtAEsMnSr6DQUqtGdtMNXA/yHn+x3Y1+fWM=
X-Google-Smtp-Source: AGHT+IFLFq9eofBLjO0jeIK4HsMzYgv8vQ7e1Y0vQC4/hrIVwD6V82Ydlk1ILG9yNFedzZcLLM4kyR4SmgsvF0boR7E=
X-Received: by 2002:a05:651c:212:b0:2bc:dcd6:97b1 with SMTP id
 y18-20020a05651c021200b002bcdcd697b1mr12546204ljn.47.1696316218684; Mon, 02
 Oct 2023 23:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231002161350.64229-1-tmaimon77@gmail.com> <2023100323-reunite-upfront-8922@gregkh>
In-Reply-To: <2023100323-reunite-upfront-8922@gregkh>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 3 Oct 2023 09:56:47 +0300
Message-ID: <CAP6Zq1jHzRP1Ytzk8YXyR8ppAP=ZoPvPkYvC2yMRfTt5140zqw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 0/3] usb: ChipIdea: add Nuvoton NPCM UDC support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     peter.chen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xu.yang_2@nxp.com,
        peng.fan@nxp.com, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Forgot to add in Acked-by: Peter Chen <peter.chen@kernel.org> in V3,
Resend the patch set with the Ack.

Should I do it differently?


On Tue, 3 Oct 2023 at 09:51, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Oct 02, 2023 at 07:13:47PM +0300, Tomer Maimon wrote:
> > This patch set add USB device controller for the NPCM Baseboard
> > Management Controllers (BMC).
> >
> > NPCM UDC driver is a part of the USB ChipIdea driver.
> >
> > Adding CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag to modify the vbus_active
> > parameter to active in case the ChipIdea USB IP role is device-only and
> > there is no otgsc register.
> >
> > BMC NPCM7XX and BMC NPCM8XX has ten identical NPCM UDC modules,
> >
> > The NPCM UDC were tested on NPCM845 evaluation board.
> >
> > Addressed comments from:
> >  - Krzysztof Kozlowski : https://www.spinics.net/lists/kernel/msg4951321.html
>
> Why is this a RESEND?
>

Thanks,

Tomer
