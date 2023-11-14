Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B547EB0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjKNNZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjKNNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:25:20 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9DC1AD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:25:17 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5b383b4184fso66159247b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699968316; x=1700573116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoUNc+UAMR3MkcBlAcrSJl9LJzMRrhGFdSqk/t7tLSM=;
        b=fBMyya43uwflzhsrjshepPwpjcpaZ+MEWuW6SX/FOAyW5XyZRhyVF6ukISflJHlMLk
         I9LugwlWj6M+fplTzON5UlxWw05w3cIG9YFMOFYCQN6meGptaMchYdg2yZoipJKdTGgG
         oq4DsZkfS/ri57qXN8wB+t4UnID1AcDQiKJKviJ9stm3RvDimZDtRvZhs1aGamJVv1LV
         d3Mxptgog5ZbFEJ2ERSjufOVA8kLKDj6/VqeiKyqMSi1m+oEczryQSeipm/SRcmc5MDL
         4lNJzPsJ8FGbUce2J0jCR1hwjlHw5XyaOFrck5P9ry0K6sLzb3Xsu6omnf+W7qwMlQQh
         pStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699968316; x=1700573116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoUNc+UAMR3MkcBlAcrSJl9LJzMRrhGFdSqk/t7tLSM=;
        b=cZlDkVdghsojvaOQxgCUWh+PvCM8A/I+8AkRCHl3wUvBKixYyogydXJzkuuE7emqx3
         cqMr8S6vavv73zr6ViaETfpoi8Wscn+gMvr3OSVJ4dVyPf+RUTQ6STnqs1fYAx/Syz50
         cCuZMG91NftTMis6LHyUXyAM30BbGblH4u3Fk08Ehqu63QrOaYpWOSb9HXrvZ1/BF43Z
         jF2Nfqt2/zuGrypEko/lnJHWSi3y/NEWtPR5nJeE2mREpbjbOKGyiBvmW6gXo9nV7z/J
         wnnhHKFaVVkgN6/pZ9SkzyQ3mDUklDq7xzyFl5qG98YbD9+cXJUsjQmn3xkFxqKYpv3f
         gffA==
X-Gm-Message-State: AOJu0YyzY96y2e6gSL/3Bik3S7+Ci6syVASdWb5FvU+a1Xv1YZwhRCdm
        QyVwIIUOR+ifZDgo+1y7E5ErmskCkYSAFNlnLIU+Xw==
X-Google-Smtp-Source: AGHT+IE0TPtkA1XauwwaY0dSJjd8MxN/U0JrfOVEfCPnoUdkrWeESQDbuceXf62dLQcX3EcI35RVKcfmZwK9dNIcsKU=
X-Received: by 2002:a81:7189:0:b0:5a7:c8f3:de4b with SMTP id
 m131-20020a817189000000b005a7c8f3de4bmr9606681ywc.8.1699968316538; Tue, 14
 Nov 2023 05:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20230814093621.23209-1-brgl@bgdev.pl> <20230814093621.23209-3-brgl@bgdev.pl>
 <875y54ci86.ffs@tglx> <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx> <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
 <87sf87aw36.ffs@tglx> <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
 <87il91c04a.ffs@tglx> <CAMRc=MfB=sMEmK02Y6SaG1T4PFZW2OD+box7NNoDY3KM1AchLA@mail.gmail.com>
 <87o7ir8hlh.ffs@tglx> <CAMRc=Mf9f9MxfRY+=Et9+wO5fZr61SRthcGhoHZsJ6-x6k+BgQ@mail.gmail.com>
 <873502971b.ffs@tglx> <CAMRc=Meigus=WOGwM-fStkhtDeKyTd+9vZH19HoP+U1xpwYx9Q@mail.gmail.com>
 <87msya6wmf.ffs@tglx> <CAMRc=Md6NA6-rBWL1ti66X5Rt3C4Y2irfrSZnCo3wQSCqT6nPQ@mail.gmail.com>
 <877cpd7a96.ffs@tglx> <CAMRc=MfNaydT8gnvusKdJrNrtjKVE4LTqdanh3+WNd5QF-2q_Q@mail.gmail.com>
 <87y1hb1ckk.ffs@tglx> <CAMRc=Meq6qrXsbDQiQHJ8t9tTh2V5Fb2ut6TcWYd5CKJwGBiAg@mail.gmail.com>
 <CAMRc=MeWPcaiB12f_R5jR+b-THZgHYS2bx3KypX+o5Afz1ebyg@mail.gmail.com>
In-Reply-To: <CAMRc=MeWPcaiB12f_R5jR+b-THZgHYS2bx3KypX+o5Afz1ebyg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 14:25:05 +0100
Message-ID: <CACRpkdZw2Z=PnfJvoj4pJ2gd_j32DUJjUiJAQj0LrB4uPXdOgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 9:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> I am at LPC and will present a talk on Wednesday 5:15pm at the kernel
> summit about object life-time issues. I'll reference this problem
> among others. Please consider it in your schedules, I think it'll be
> useful to discuss it in person as it's a generic problem in many
> driver subsystems.

I'm sadly not at LPC, but this sounds very relevant and I'd love to know
what you conclude (if we're lucky maybe LWN catches it in a writeup).

Yours,
Linus Walleij
