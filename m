Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8A4789766
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjHZOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjHZOaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:30:39 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA38C2114;
        Sat, 26 Aug 2023 07:30:35 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d749f57cb22so1810937276.3;
        Sat, 26 Aug 2023 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693060235; x=1693665035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvh0gnFOci9F17zwv3KMgcjPQL/TOV+qDBGB8fHE2PU=;
        b=g5r7pjTEkafPoBaT9fYE1qAEKEye3bzeP4nDKGpAyZB1eGsjI6SUbK4A6VypMt+TRs
         VdXiil33c45m778Gtj6/TtkFe6v5XZElKp3vPJi7ExzbP3PH6tgLxw5uwHgQ6NhxkSn+
         fOpu7XWjByfTZJn3IWs3E/CM+w3Wez3gD2ft1DrZp8Hfb657Z17A/niZb+Uf4yKqL2T/
         yrZPlIfQgn9IGlTbnjxRd2OmabmvYoMxC6r4ezL7m6rY0VRxlkJJxda6AphuMLgabfsG
         GOqKHNax1RD6s7NJSwJaOdRD1HZyPVFxCz5PUDYH8G/RqsscnpW26bcp5w7uX76k8JUx
         gtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693060235; x=1693665035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvh0gnFOci9F17zwv3KMgcjPQL/TOV+qDBGB8fHE2PU=;
        b=D9/3v5zkpewW5fjJ4SIlF/vWddSENTnAJau57gRBSGgeXN1UMR+Z7FyjPaBDhsULVr
         lGyQY7N5re6l8EIdGgEeLYXrpjJ1TRz4PafhMV6OGtqWN7DbFvM9cjNLsJ7rPhXrztSe
         lpTln3zxWAq9fyL2HbiNUWsOJwqDs9sOIxwqwEoiARQu36S8++7sfmpLGGoXVc8iJPPh
         /kECsrlKGrtCX+7jmC0+1BFG1RCy+FMn6WRI+ETzBu/DazWqzuN6H8PdkGEG1NhQt3wr
         u6Hknqfu9Fh5RtFLKOfXH+ZnMnwBLLaSdraWdP+ZyvUIMU93359dvSQRcdtxLW0lu4jo
         dZVg==
X-Gm-Message-State: AOJu0YxucuPR1wpAnuwH1KIzn40nynVYVHqWwLBi/7PxBBrbF8Oco1/e
        zWLX3qc3LG6SdvEUeGezvRU1W9OE01XjFYW1Q+0=
X-Google-Smtp-Source: AGHT+IGzj2iHONz/JcssQobtfZzLUybni01Fd2V2VfTb96CB4tzuNhQ76r1ArOzGd8ZiS5vJYwCkF21YyherLbz9RlQ=
X-Received: by 2002:a25:8211:0:b0:d29:3f14:9d96 with SMTP id
 q17-20020a258211000000b00d293f149d96mr22348703ybk.56.1693060234919; Sat, 26
 Aug 2023 07:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230822162333.752217fa@canb.auug.org.au> <CANiq72=DA1A5YyrWAPHEr+by_pac4R0-GemurbLWYNrSAUNSzw@mail.gmail.com>
 <20230822222036.3462aa57@canb.auug.org.au> <CANiq72nvbkYQ0bPb0aRs0jNZGgFwg8TMek4b0n3jrgxd2X4h3A@mail.gmail.com>
 <c954b4aa-9bf7-9583-0b9d-05f33bb0a595@linuxfoundation.org> <CANiq72kwPbHDrR13EWdmWTevU4r9wJzp4exV5rS1x-tD0gh9DA@mail.gmail.com>
In-Reply-To: <CANiq72kwPbHDrR13EWdmWTevU4r9wJzp4exV5rS1x-tD0gh9DA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 26 Aug 2023 16:30:23 +0200
Message-ID: <CANiq72nHS6S0p+_JLWHeMTY+KS0HtcU7bXy2ijcDDoO2-E4YyQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the kunit-next tree
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 6:29=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On our pull I will let Linus know about the conflict -- perhaps you
> can point him to our PR if yours goes out later (when are you sending
> it? I was planning to send mine tomorrow) and/or you can tell him the

Here is the link to the PR in case you decide to refer Linus to it or simil=
ar:

    https://lore.kernel.org/rust-for-linux/20230824214024.608618-1-ojeda@ke=
rnel.org/

Hope that helps!

Cheers,
Miguel
