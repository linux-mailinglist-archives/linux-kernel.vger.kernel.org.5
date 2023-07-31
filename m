Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601A6768A59
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjGaDc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGaDcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:32:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AFB189;
        Sun, 30 Jul 2023 20:32:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-522294c0d5bso5280543a12.2;
        Sun, 30 Jul 2023 20:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690774341; x=1691379141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qN7NEm8kJ8Lg4BhAheGJ8bEapl5h32Ub6hisYq5saj8=;
        b=k9s2U5iYbLF9Q9em+E7+oVYuLwHwh3AmH0cKkLWUSo//TF6EVRN7cYz8ULkqwIHMMk
         2CZmiqKbXZdWLOfpPO08TQ9+2tk18cMltEYrFNkSgZnkTcKp4PyKW/B4v0kMcpWneP5N
         Mqmhly+u+N0AwwTNFZ1m7twxiA//DzwdgpWW+muKx9MIvhyBMvJae3Fq49sBSmb2RegU
         2wXS0hr2HgCBk634Mo1NZMBuuiooiAAMxy/dQ3kTEiVuPEXcaxHetmpQWWJXYm5XzLXy
         Q6cMKkNYieJGmWS2axFFpPhhzIOHtc2IXrVxfiV5FiAfLUA2VzRCQrd5ZyZVtI2pUtzk
         x+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690774341; x=1691379141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qN7NEm8kJ8Lg4BhAheGJ8bEapl5h32Ub6hisYq5saj8=;
        b=C3zP5+9HDLnzyEfxG5xJzpxsJz3QQdJiz5zQYH0tMnxYgZjN/mYth+S/tDf/wpmkBL
         I9uAzYRQmS96xaRNAdamox3R0UGOBtOAOmSLbdjLY0zYaPFSKS5zAvaPoxs/qX8ZFwlw
         4AF00wFeD/mATwAyfHl9JT1jX57hiaRJJlbd07KoG0pRmiLa+Z1sSvTG1stgc0lYL0A9
         G8rn+cw0PUEgZI+veZ39BCFGtybShhVT5Gta+H9oJKp1q+MzzQV2ith4pFlYiF4tDh7+
         FM9Lz197LLZSo2ZpeXBz9lSTcxSikzsfA6085gOj91ySexmjRyx9tkPNTM/yDtjclUTS
         8LtQ==
X-Gm-Message-State: ABy/qLaXITlSMXCbMcY7BI0fjtrj5YZzZKVhMBf3J49dH2ede2F5Z69M
        tEDjnFT/NIMMYLp4bM4ljWRkBCA4voaeltv/1Bg=
X-Google-Smtp-Source: APBJJlFRYHJwJWavld9Z7LIKd9SdNykbKrJzbQCOcMnNmAKp4Gf7qQUrpy7gt3vIZKJIxZzoya+XNXJtdLXJ2EyeBsc=
X-Received: by 2002:a17:906:768d:b0:993:ce9d:6fc1 with SMTP id
 o13-20020a170906768d00b00993ce9d6fc1mr5398653ejm.3.1690774341113; Sun, 30 Jul
 2023 20:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
 <20230729134318.1694467-8-keguang.zhang@gmail.com> <2ee2336c-d54f-6fb7-0142-8d0e08cce25b@linaro.org>
 <CAJhJPsXbW-JkzPTH+fHW3PD9J9+s0_F3Fbs3sb44tC12iTCk-Q@mail.gmail.com>
In-Reply-To: <CAJhJPsXbW-JkzPTH+fHW3PD9J9+s0_F3Fbs3sb44tC12iTCk-Q@mail.gmail.com>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 31 Jul 2023 11:32:04 +0800
Message-ID: <CAJhJPsXT+T7z4Av6tsQX00CAh8p6r-2ypggY+_iDufZhxToAWQ@mail.gmail.com>
Subject: Re: [PATCH 07/17] MIPS: loongson32: Convert UART platform device to DT
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:04=E2=80=AFAM Keguang Zhang <keguang.zhang@gmail=
.com> wrote:
>
> On Sun, Jul 30, 2023 at 4:26=E2=80=AFPM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 29/07/2023 15:43, Keguang Zhang wrote:
> > > Add UART device nodes for Loongson-1 boards,
> > > and drop the legacy platform devices and data accordingly.
> > >
> > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > ---
> > >  arch/mips/boot/dts/loongson/loongson1.dtsi    | 54 +++++++++++++++++=
++
> >
> > Same problem - DTS is always separate. It seems you made this mistake
> > everywhere, so entire patchset needs to be fixed. Keep all DTS - your
> > base board and extending it - at the end of the patchset and squash it.
> > There is little point to add new DTS in steps (e.g. first add incomplet=
e
> > broken DTS and then immediately fix it... no, instead just add correct
> > and complete DTS).
> >
> Sorry. I thought it would be easier to review for split patches.
> Thanks for the explanation.
> Will send v2 with one complete DTS.

Hello Thomas,
May I ask your opinion about the way to delete the obsolete platform device=
s?
Should I delete them in one patch? Or in separated patches?
Thanks!

> >
> > Best regards,
> > Krzysztof
> >
>
>
> --
> Best regards,
>
> Keguang Zhang



--=20
Best regards,

Keguang Zhang
