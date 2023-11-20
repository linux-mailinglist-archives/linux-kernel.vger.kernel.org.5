Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC5E7F1882
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjKTQVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjKTQVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:21:43 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE9ED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:21:40 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7789923612dso283123885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700497300; x=1701102100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+cEjF8yivWHKRs1/Mvbzeyp4gbt9nPyK/LY9ULoheM=;
        b=lXCLjvmP+CHaGpri4tFOQW6WKQONMR0Hlj0xoKc+oBLJmkfw+x7efIkl/qg6tUM5Fk
         JToiIyL9aubHpv4y4so+Th1PFanvrm/geMUndoVu9oItTH3zc79uGmoSzVGkzZpm+RSO
         6jcNzG5/VwyLl/U39ovk7sIE/6EsyRknioCytjNN1sOLiLCnA+b/nJlH98aYdMjLBeVa
         MI89Nj+2MZDwC5r0vKiPozQUfbg/aBafhh1CPrUQ1RRfEC/AUM8gqcaxdnQcWCwbOTWA
         XLV5rb8CIk51fXDaw1csBzpJemRWLAs0REoM2HISUPc6hrNnIPqxwjGN5cQFX6jV/S1m
         t0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700497300; x=1701102100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+cEjF8yivWHKRs1/Mvbzeyp4gbt9nPyK/LY9ULoheM=;
        b=HNnVKSHwzhQhBSV/9K7117i2ACkHFGe3NpKza6Id6++LMrHHTjZcxTDlwhDC9qU1UT
         7Pm12saa8CnQbyaiAxigfF586kYexqn4ai1lYN3UG/LIiF8XzPcsc99wBxGtpzdKnKzP
         0ugUVJbADMc051oblNW/YqKZXEDfmpDIZ6MJHWAepuayy9pOGaw2GVQ/zSasCJTBMQNp
         lIIR2qmsGpDrJ0nROs0+QVYv06WOjlezLxz3WdA/dZmsCKOgwTbaKfTCiNY2pPoW0h4j
         6KzaEyRYQNm8XPv6TSRezR0gIFC0YNqkZKLxckqaqKaFG0JflfcdtbpYF/kZJiBSr3rh
         Iy0A==
X-Gm-Message-State: AOJu0YwyB+MOdHMBiMMrbhQjzbda+WE3UDnw5sdPAC3CJGPk2H++IVV3
        GhdvjIreg6ELM1Z2l4mBXvTeJ1qSSwvLXz2pWcz/Og==
X-Google-Smtp-Source: AGHT+IEtPYBbq49KqVNQjGJ/GDDR3Gw4BTcMZhzzT9PPj/JSL5e5Zf0eXOFkX/x3KPc5URlWDs3TZ7+JKzHJiRKIMzs=
X-Received: by 2002:a05:6214:c49:b0:66d:6afb:ba5d with SMTP id
 r9-20020a0562140c4900b0066d6afbba5dmr9779202qvj.24.1700497299711; Mon, 20 Nov
 2023 08:21:39 -0800 (PST)
MIME-Version: 1.0
References: <20231103061715.196294-1-sumit.garg@linaro.org>
 <CAFA6WYNW_cAFVMTpqPQjwBASKDp_b=CpccCzx23jHn_+qoJrDQ@mail.gmail.com>
 <87y1es5xsd.fsf@meer.lwn.net> <CAFA6WYN7ZB0Sgc0gB1rQhhirjoOEeyp2Uokzpwy-KFQ_aJQEVg@mail.gmail.com>
In-Reply-To: <CAFA6WYN7ZB0Sgc0gB1rQhhirjoOEeyp2Uokzpwy-KFQ_aJQEVg@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 20 Nov 2023 17:21:28 +0100
Message-ID: <CAHUa44EqH+_+CbXAAdW=xGpFm8DCB=fhrFZcXgs1OdW7VRJ6-Q@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: Destage TEE subsystem documentation
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, vegard.nossum@oracle.com,
        Rijo-john.Thomas@amd.com, balint.dobszay@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 4:35=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Mon, 20 Nov 2023 at 19:31, Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > Sumit Garg <sumit.garg@linaro.org> writes:
> >
> > > Hi Jonathan,
> > >
> > > If you are fine with this destaging TEE documentation patch then will
> > > you be picking up this patch? Or would you like Jens to pick it up
> > > with your Ack?
> >
> > I'm happy to pick it up.
>
> Thanks.
>
> Jens, can we get your ack here for Jonathan to pick it up?

Sure:
Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens

>
> -Sumit
>
> >
> > Thanks,
> >
> > jon
