Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7A7808DF5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379597AbjLGQtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjLGQt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:49:29 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BEA10E9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:49:35 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54c64316a22so1579986a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701967773; x=1702572573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lyhxrpfp+75Q27I2sJ7iqWke8b01A5JKGENoBisxmEg=;
        b=AKFSE2nn8up7/3MihhTlBfvCIVqqCEXmTUMrcD+XNfiNs4F31JlhyMThn9bpL9KwL4
         ym/nFsxeuaayt/M1OinexvKROMnW0u42hIVINs/wjkBmhw55TkREPDAHGNw4KIHfKBNC
         KpfuZkwm0O4Pl/TEa3LHuffGsmkDo34O+5Rrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701967773; x=1702572573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lyhxrpfp+75Q27I2sJ7iqWke8b01A5JKGENoBisxmEg=;
        b=SSwJkTjxIXwnBUAwtBNcw3iadqinyUSehxWRKW2n1gOSvchhi0HdHSBnEHj3jdYAwI
         0p7zRdq5srbGoUyre0M/jj2XUM9MMVsU8eGtQKrcHhHDKCkV9EEkfogKu0N7RHvmVPbe
         2wfRnxDj88loOwy32PNPBJN0Ve2sCd3IZj1Axi4fln7BCUa2v811h6UIDwWEVBo3tor1
         0mBL7pWmQEx1pXaPee2yOAC3amTnNovAt20KCs99O1uNQmYve0hZAgz2psjsijgOW1Ue
         Z7618HX14uMVpIw+4m8Ed4hbnX4Uj90fblosYslpeocH7mKEMJ4nlPvQARcR3YUt4cXS
         LBGQ==
X-Gm-Message-State: AOJu0YzRj0HB5GH1ID1waHjXQ80MIHqTlSgCmA5++G36uoes+kkxwav+
        MXrswn8NtYY0Sb/cNyrctbFDA/NfLquo+f7sJLhb9086
X-Google-Smtp-Source: AGHT+IGGu51MBg9cZJvjDC5DfOTqnlGHjQaBI4NkZICfKLt0Vtoc19SXME9jPMEeTnwPhGh6TbSJ9A==
X-Received: by 2002:a05:6402:3595:b0:54c:792a:bf09 with SMTP id y21-20020a056402359500b0054c792abf09mr2349730edc.45.1701967772947;
        Thu, 07 Dec 2023 08:49:32 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id cx14-20020a05640222ae00b0054cb07a17ebsm23366edb.31.2023.12.07.08.49.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 08:49:32 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40b422a274dso82555e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:49:32 -0800 (PST)
X-Received: by 2002:a05:600c:22d8:b0:40b:4221:4085 with SMTP id
 24-20020a05600c22d800b0040b42214085mr206272wmg.1.1701967772109; Thu, 07 Dec
 2023 08:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid>
 <CAMSo37XcwAn9znSQ8202LUTdBKLDz94QJ9i43aXya5LHs-4GiQ@mail.gmail.com> <87wmtqnk3y.fsf@kernel.org>
In-Reply-To: <87wmtqnk3y.fsf@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Dec 2023 08:49:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VHHCsjJmVWDXN4g3U=-_SLWc2iWqbAdZPOykn+QMQojw@mail.gmail.com>
Message-ID: <CAD=FV=VHHCsjJmVWDXN4g3U=-_SLWc2iWqbAdZPOykn+QMQojw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Don't touch the CE interrupt registers after
 power up
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Yongqin Liu <yongqin.liu@linaro.org>, ath10k@lists.infradead.org,
        Abhishek Kumar <kuabhs@chromium.org>,
        Youghandhar Chintala <quic_youghand@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <jstultz@google.com>,
        Viktor Martensson <vmartensson@google.com>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 7, 2023 at 6:49=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote:
>
> > Recently during our Android build test on the Dragonboard 845c board,
> > with the Android Common Kernel android11-5.4-lts and android12-5.4-lts =
branches,
> >
> > we found there are some ufshcd related changes printed,
> > and the serial console gets stuck, no response for input,
> > and the Android boot is stuck at the animation window.
> >
> > The problem is reported here
> >     https://issuetracker.google.com/issues/314366682
> > You could check there for more log details.
> >
> > And with some bisection, I found it's related to this commit,
> > when I revert this commit, the problem is gone.
> >
> > So replied here, not sure if you have any idea about it,
> > or any suggestions on what we should do next to resolve the problem?
>
> FWIW we don't support Android kernels, only kernel.org releases.

Right. If the problem also reproduces on mainline Linux then that
would be interesting to know. I think db845c is at least somewhat well
supported by mainline so it should be possible to test it there.

If I had to guess, I'd think that probably the CE interrupts are
firing nonstop for you and not getting handled. Then those constant
interrupts are (presumably) causing the UFS controller to timeout. If
this is true, the question is: why? Maybe you could use ftrace to
confirm this by adding some traces to
ath10k_snoc_per_engine_handler()? There's a way to get ftrace buffers
dumped on panic (or, if you use kdb, it has a command for it).

If this reproduces on mainline and it's not obvious how to fix this, I
don't object to a revert. As per the description of the original
patch, the problem being fixed was fairly rare and I didn't have a way
to reproduce it. The fix seemed safe to me and we've been using it on
Chromebooks based on sc7180, but if it had to get reverted it wouldn't
be the end of the world.

-Doug
