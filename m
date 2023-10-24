Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1877D5C19
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344256AbjJXUEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343931AbjJXUEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:04:52 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC93110C9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 13:04:49 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7c7262d5eso50342137b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 13:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698177889; x=1698782689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVAbANXp0EE+0d4oW9xtpYRorj1M/cLLrnm2DJJ699U=;
        b=W0qOXJUYufeX7YnjuxWbS+Nejf4NWjUXU2mczkv3gbixSORoAevNE/Sl0FRTpTQjDW
         li/oIrjWnCJ2Yf1B7W2lXdv8DqBUid+b1QpED5RvQ9ADwPiFNPMZqeWbIKLc/hC3Oi5m
         +ay0GdiWo7TZxIDUOcaSpxYEFqRmzAo8SUZYoVOAA7hq3/328AdHFjKV9RXnGKl+PFA8
         DJ2Lgfs01UMWSZpYrcUItN/eu7ntmrBPHw1iQTmr3l2Vg7/0pczfmK2IBaYIEpo0QWWX
         n1SO07NBYl7D0mxi8wRn4cfDNtzFZFo7hmcQoZn7DBLRzdUYOFM/bWulOs0f8BSdNk8y
         5Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177889; x=1698782689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVAbANXp0EE+0d4oW9xtpYRorj1M/cLLrnm2DJJ699U=;
        b=ipnx53o+pZBQXx+/lCWQHIAXLmdxf5bNR6ht8yqntGgq1GljBeDFGY8vtCAz9fvzv/
         S12v8p/GFvVC4odP0j7SsehHN7w1nYmfU6x/YNCxhufZCaEMsWWujbhC5AELayhPIh9e
         uZk/vGM9Qlb6oILVGDO5RWbpgGsNRf01LkMYX2XvRoJsWUskNDckJX1ew5EHi7QoLreZ
         kEXXUDnCRsEQF6e2zvExxNtWhNml3aQqpgt83OLuvQUeibRucoIEwUHlqcLWwqPrxNXb
         7VXpw2YqHmxRtg9t94FdmIvPWejQ/FCvOhAVcnywLLSuJPznVcG3dPPwWpxsfmrq9JmP
         N3+g==
X-Gm-Message-State: AOJu0Ywilib6g4h+VNdQ0L1D0tdVW+4y34SL4qjzeT0MLJfVa4hJ9kQk
        fXqnys0coupsAZezsJMqgsU/QFfFUg+9TPx4GwrFNg==
X-Google-Smtp-Source: AGHT+IEUgNxJjKrz0nd2I1uU4RPgPHlVfmbMZ1dQGcjU8PMkwdFh+iGnBNsSn0kKET1VoRgHJoEQTVk+TFQcmQm5wVc=
X-Received: by 2002:a05:690c:10:b0:5a7:b53f:c304 with SMTP id
 bc16-20020a05690c001000b005a7b53fc304mr15947380ywb.37.1698177888974; Tue, 24
 Oct 2023 13:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <1696440338-12561-1-git-send-email-quic_mojha@quicinc.com>
 <f3a4c114-b430-47ce-a746-4a840994dc58@quicinc.com> <CAA8EJpr0Nnn5Tr=2CBAADYfNU6cnKuq==x5L5YQoko9C=3q2tg@mail.gmail.com>
 <d6f48748-22c4-4e4c-a1e9-7a6940b9b432@quicinc.com>
In-Reply-To: <d6f48748-22c4-4e4c-a1e9-7a6940b9b432@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 24 Oct 2023 23:04:37 +0300
Message-ID: <CAA8EJpqd-1=sFd3Hm-XbAq8WJfY+hL2Hd5mc23RnCimMbQM69w@mail.gmail.com>
Subject: Re: [PATCH 0/3 v7] Misc SCM changes
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        p.zabel@pengutronix.de, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 at 19:00, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
> On 10/24/2023 8:38 PM, Dmitry Baryshkov wrote:
>
> On Tue, 24 Oct 2023 at 16:31, Kathiravan Thirumoorthy
> <quic_kathirav@quicinc.com> wrote:
>
> On 10/4/2023 10:55 PM, Mukesh Ojha wrote:
>
> I have given version to this series as v7 as it has already
> gone through v6 and later got added to minidump patch series
> However, these 3 patches can go independently and has no
> relation with minidump hence, separated it from minidump series.
>
> Mukesh, Can you rebase this series on top of linux-next, since there is
> a conflict?
>
>
> Bjorn, after rebase is done, will you able to pick it up for v6.7 if
> there is a time? These patches(#1  and #3) are required for the crash
> dump collection on IPQ9574 and IPQ5332 SoCs.
>
> It is not obvious that they are fixes for the crash. You did not add
> Fixes tags, you didn't follow
> Documentation/process/stable-kernel-rules.rst. Cover letter is
> useless. How can we guess that they are urgent / important?
>
>
> Dmitry,

Could you please turn off HTML message composition. For example your
message completely messed up the quoting in the text above.

> These patches are not the *fixes* for the existing crashes, these are req=
uired to *enable* the crash dump / ram dump collection by boot loader when =
qcom_scm.download_mode is set to 1 on IPQ9574 and IPQ5332 SoCs.

Please excuse me, I misread your message, mea culpa. Indeed, they are
not a fix for the existing error...

>
> Reason why I *requested* to pick it up for 6.7 if possible is, initial ve=
rsion is submitted in Jan 2023 by Poovendhan[1] and then later Mukesh integ=
rated the initial series into his minidump series. Then I separated out the=
se patches[2] from mindump series since there is no dependency for these pa=
tches to be part of minidump series but unfortunately again integrated back=
 into the minidump series. Finally Mukesh again separated out these patches=
 now.
>
> Since there are no active comments to be addressed, I was hoping this ser=
ies to be picked for 6.7. As long as these patches doesn't go out of the ra=
dar, I'm fine :)
>


--
With best wishes
Dmitry
