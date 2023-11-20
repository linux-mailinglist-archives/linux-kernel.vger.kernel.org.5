Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C437F1DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjKTT7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjKTT7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:59:41 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05929AA;
        Mon, 20 Nov 2023 11:59:38 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso3000181fac.3;
        Mon, 20 Nov 2023 11:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700510377; x=1701115177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJBR3xUJ90fNqoXNnd3g+YCrJa3COLV0n8rrwwfxSX0=;
        b=HY2eAvDDZiv24MeUWpSyl1qqkiuL1mapjg+3F3u3TKKJGWTOXnm7oDXOKS4z4zBFig
         Q6Ky8FPySafYaDOM0eOWuHuhgE2Mn+0nht0fJ7To2OdNm8z8pdTTKHgSs6AWGyA8zNlI
         y3puLE5Xi0kGnn7AlQN8m5/5/ixWbrjll5qFZlgT2BzlNwCO+XBkf9ZHFaAKjW78gm+/
         TiFLFJkqYUwoQ3d7tnaJlF/kyFMLJGr5XmV2MyYybeW/F1U+2gmT4rDHI71gj1ziT2zy
         eP7APQWObOzJww5I+5nKueGH38lfFNdRD5SOarJb/G8gxdFI1vu1bzYP/VRxAx5LhCci
         8qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700510377; x=1701115177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJBR3xUJ90fNqoXNnd3g+YCrJa3COLV0n8rrwwfxSX0=;
        b=NaySBAPx8cGPyXe0ZkCGdnlV8KJ9gxv7QDTDOfhFnFTGGnSDtCXQW1Jy5ZJwf7fiwA
         lu5oO7ujGm8wsINJWjjblUTsCrnSGD/BnD9CowiHqolBOeRkeORLvRBSwYtqK9s6W2MB
         agd2iuJFSeBPfEEgDl644i+p0bnzXGTiuOyCKl12706JPb6W/pHxzLJemOc3lEPr0MJf
         FfrzvlZUQ0MHkjG8VPD6P7EsvQlJ+Xqyn0tbaxQ+IS1qE2WY5i5UXkrMBsoT1P40gSpp
         6VnGK+Q761qEbswSEO1mT5BS/25ttGv/IR/UloxqIM5TdGZXroQPSZ7qcp6RICkiftFR
         y4Xg==
X-Gm-Message-State: AOJu0YwwbHaBHom7UgsBslcNthzTqNlaCW7ZL2FeU5xZ6+MAosBgsOHE
        mi83PuLrOzO5GO1i+ITsMWpxja96pJ7DPpNGAZtfD9cU
X-Google-Smtp-Source: AGHT+IHErDTudVD9D0Xs6J9fHo53Jc2qgzfK4kq24U4ws4Et4usKh7Ru6ZcV/W943JLQEEu6O9dDRJe1Gv7tRXOquxI=
X-Received: by 2002:a05:6871:82b:b0:1e9:dd4b:d0aa with SMTP id
 q43-20020a056871082b00b001e9dd4bd0aamr9331470oap.48.1700510377374; Mon, 20
 Nov 2023 11:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20231022090633.792831-1-sergio.paracuellos@gmail.com> <513bc341-25b8-5a57-d760-861a3e88a4a1@linaro.org>
In-Reply-To: <513bc341-25b8-5a57-d760-861a3e88a4a1@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 20 Nov 2023 20:59:25 +0100
Message-ID: <CAMhs-H8A0p=nFSnU9pRn=rTC_=CH6jXFQdYgZdimFNq9+dVqSw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of the Ralink architecture
To:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc:     linux-mips@vger.kernel.org, john@phrozen.org,
        tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org
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

On Wed, Oct 25, 2023 at 2:58=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 22/10/23 11:06, Sergio Paracuellos wrote:
> > Its been a while since I am making contributions to this architecture.
> > Hence add myself as maintainer.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> > Hi John, if you are not ok with this please let me know. In other case
> > please ack this patch. I can add myself as Reviewer if you prefer to
> > maintain alone this.
> >
> > Thanks in advance for your time!
> >
> > Best regards,
> >      Sergio Paracuellos
> >
> >   MAINTAINERS | 1 +
> >   1 file changed, 1 insertion(+)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Thomas, can you take this patch through the mips tree?

Thanks,
    Sergio Paracuellos
