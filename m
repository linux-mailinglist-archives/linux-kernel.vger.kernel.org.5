Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62A7F6B91
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 06:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjKXFFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 00:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXFFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 00:05:20 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB760D6C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 21:05:26 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1f9460cb66cso940195fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 21:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700802326; x=1701407126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSqVVlNqay+tkbRQW9+dH1P4yW/ANJSftxzN49AnClI=;
        b=NPjepY7dWhIrtAkquUq71j4etkz/UIfEg93n4qluwjGcJo9tvR7kCy8HbfZMT69Vfb
         3AIudzb1GbM+EboKZ1pywajMjOsASyNab2yonYDZw5SRm61prIckA6KrCQuMJLpB/WMr
         vuIsV0TBjVD9DhlLG2HcOI8zxfYFZ+vK/fyRTRHn9MCdvLIjKA+pLm8d1GHModY2WMPS
         mZ7dWf/HAvek1pHaNTUi8dAItJo2hv8G1q/y1BF7l9JswzmEbW0hafb5AEborbG0Chth
         LccFFPVFo2Qa5fIH3FPFABdCBjrUnJ4//tw6bHbQvpn11KpxSUSXidraQEpZVqOt+IgZ
         SY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700802326; x=1701407126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSqVVlNqay+tkbRQW9+dH1P4yW/ANJSftxzN49AnClI=;
        b=CcgW8cbJH229/u0Yu+d1GtLEwLPovJVVybXZq/bOZe71LCSKep06/VCZ1xeOxVd9e2
         PsSX+4mplaAUfFnQhW94d9eInpVg6x9Zpl9K8Y9Xf4wKn1MZjh2Soo9EGh6wNZ3BYkLz
         dZcMa/DdPsdzHuHh2vQ5x1yVw0kQlbVBgwTrJr6z84N14p5xpFVbdhbQu/6PPeg7BOYi
         7Md2FDkBUXShaUXvthqdthaVJ9aEVsQSFcV9Jj861DfPHyR0zSpLYtV2sasP3XPh7khW
         EvJOS9EqKn/bHznW9zki0BTmQyRAD1cXDkjT9Qi1wPeXeb+qUgrA/sGn7h+0jzlXybb5
         H0AQ==
X-Gm-Message-State: AOJu0YxaBjFkSM0peyTIT3k5oQxKj+Tma7enDzjEFmFETDcxJdLkIow1
        i0kw3k1lD+Nwtvfqbxx+9tItYtC1lFE1dSyPEj4BhYqzQxlD9YUv
X-Google-Smtp-Source: AGHT+IFB5hLdEj2Vo3fmacGt2M6/9IlhJVsJ7X1oKygLIIziwPw2RA7a2JJFveCBHs2/AbOlS1f1+OTbypCtVFPqtnI=
X-Received: by 2002:a05:6871:5315:b0:1f9:a468:dd01 with SMTP id
 hx21-20020a056871531500b001f9a468dd01mr2133739oac.53.1700802325856; Thu, 23
 Nov 2023 21:05:25 -0800 (PST)
MIME-Version: 1.0
References: <MEYP282MB3659BA22E1535379D06A0D3583B8A@MEYP282MB3659.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB3659BA22E1535379D06A0D3583B8A@MEYP282MB3659.AUSP282.PROD.OUTLOOK.COM>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 24 Nov 2023 10:35:14 +0530
Message-ID: <CAK9=C2V4Gkx6tcymNdm=WmPv+vqFgJ=0hm2hrPw7kS0qGP79yg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] irqchip: Add RISC-V advanced PLIC driver
To:     =?UTF-8?B?6LCiIOazog==?= <xiebo_60@live.com>
Cc:     "Alistair.Francis@wdc.com" <Alistair.Francis@wdc.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 8:33=E2=80=AFAM =E8=B0=A2 =E6=B3=A2 <xiebo_60@live.=
com> wrote:
>
> Hello all,
>
>
> I have a question regarding the handling of potential issues during the M=
SI interrupt sending process. It appears that if the APLIC target register'=
s value is modified during the MSI interrupt sending process, it could pote=
ntially lead to MSI interrupt send failures. The code doesn't seem to accou=
nt for this scenario or take appropriate measures.
>
> I am reaching out to seek clarification on whether this situation has bee=
n considered and if there are specific reasons for not addressing it in the=
 code. Your insights into this matter would be highly appreciated.
>
> Thank you for your time, and I look forward to your response.

This has been taken care of in the IMSIC driver in the irq_set_affinity()
because the IMSIC driver manages the re-writing of MSI messages
upon IRQ affinity changes.

Please look at PATCH7 and PATCH8 of the "[PATCH v11 00/14] Linux
RISC-V AIA Support" series.
(Refer, https://www.spinics.net/lists/devicetree/msg643764.html)

Regards,
Anup

>
> Best regards
>
>
>
