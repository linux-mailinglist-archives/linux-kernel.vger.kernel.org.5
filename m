Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F917B6568
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbjJCJYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbjJCJYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:24:03 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EC2AB;
        Tue,  3 Oct 2023 02:24:00 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c00df105f8so8236731fa.2;
        Tue, 03 Oct 2023 02:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696325038; x=1696929838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o02q/FIkDaGrgLqoN/Aj/vG1/YJOsTbj5fKhJBGnD2E=;
        b=MnxE3v6QRLo92+y+2fiAfySUbDOh6InYpNKU1hzuWvyyhtYdOS1bOQL+43d+Zt5+ho
         jTvp2EKPSrdktA8XrJwZwrhf6K+xLXkeWiFSG77AmouKm4SHO/fW4jU/FQmjMDfXe1YF
         Znx/mXwcHj0mOT3+Bmwmc/d+Cl65Uou9qIX9Q/x62buBnIzZV7NCcQUr+MFB7GOAFVim
         mh7WOAAGw4E+PgFCgmmDtO/Y9Q/Od+kv3kFfT+hkA9IcnzHq5a6uYB9o/Bd+aIMIDajA
         VUZgvxX/+fIHWfM0EZLIper7c4as0lnMfKhKL3CTpaRSTfaf2pXjcbtGRaWnKQXzbgvO
         XoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696325038; x=1696929838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o02q/FIkDaGrgLqoN/Aj/vG1/YJOsTbj5fKhJBGnD2E=;
        b=Bjwyv0hEuuxT1ynUg00yvCKfTKOBxs+lsmKMqfZC7dgKXfYmDlOk6Q2sXg8wWwdD+k
         DNyoDBtZFwIkjp87P29U6CRstouzco5bFCETqepyLh/uxz0xundvlGxBE65WGXDBEgZB
         PfyMpJidJyLrFNLu3A/9Rr40giQLbhKSL8FyRF/eZAob+9ZRfuDL82Xr+HM3YBuOkmI3
         fUwqfD174cThIn6MtZGI+5O9P8L/Va3xzH+WN9XxH4TsNK5Y0hzhi2k0sunNJ5fPM6G6
         1utmFzonQAEOOlzaNyfmXBMm+Vo/4Oy/teXUYdLOoIzXrTFE+T3Dm2Ag81Na8u2d+gGf
         lRtA==
X-Gm-Message-State: AOJu0Yxfq7PlOlhEFJ0SXj0eRtssFDjTYk2bsyU8136gpsN/9q0X4Q47
        lBZ0LYFSobyi7jUlmF5AbunudclfmfFueyCxMoE=
X-Google-Smtp-Source: AGHT+IG3BDQNI/pILbidS9xryMvAbSkn6Y/6bkHT63bOwqPMoRRoTSL7+zz03ry1Fl2f/uI9CfxqrOri93gbzoU0eQc=
X-Received: by 2002:a2e:9b04:0:b0:2bd:e3e:1a23 with SMTP id
 u4-20020a2e9b04000000b002bd0e3e1a23mr10574736lji.45.1696325038173; Tue, 03
 Oct 2023 02:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231002161350.64229-1-tmaimon77@gmail.com> <2023100323-reunite-upfront-8922@gregkh>
 <CAP6Zq1jHzRP1Ytzk8YXyR8ppAP=ZoPvPkYvC2yMRfTt5140zqw@mail.gmail.com> <0298e4a7-0f40-41d6-82f3-327d2fe493cc@linaro.org>
In-Reply-To: <0298e4a7-0f40-41d6-82f3-327d2fe493cc@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 3 Oct 2023 12:23:46 +0300
Message-ID: <CAP6Zq1ghiUhecvtC7gpKtbP11QTU8Js0wCk_sTFqjUf=d6KK1A@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 0/3] usb: ChipIdea: add Nuvoton NPCM UDC support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, peter.chen@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        xu.yang_2@nxp.com, peng.fan@nxp.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Appreciate your clarifications

Thanks,

Tomer

On Tue, 3 Oct 2023 at 11:32, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 03/10/2023 08:56, Tomer Maimon wrote:
> > Hi Greg,
> >
> > Forgot to add in Acked-by: Peter Chen <peter.chen@kernel.org> in V3,
> > Resend the patch set with the Ack.
> >
> > Should I do it differently?
>
> If it is RESEND after some time (min. 2 weeks), then it is fine. If you
> added tags or changed something, make a new version. If you resend for
> any other reason (assuming resend is valid), please mention shortly why
> do you resend (e.g. "My company email servers maybe blocked it, so
> resending without changes").
>
> Best regards,
> Krzysztof
>
