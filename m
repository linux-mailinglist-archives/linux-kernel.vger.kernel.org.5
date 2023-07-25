Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8449762153
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjGYSau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGYSas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:30:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9951FC4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:30:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99b78fda9a8so657019466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690309843; x=1690914643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CGUzsI7Hg5HNN48tuYY6ykJTqafYlRSVvbn1sDRD8w=;
        b=JUmjXdRhL66LHdPkRMkuIN5iWzTxkJc6rQYOcxurp+tLhXyInV9K3UYMaku6hCMGd6
         sAQz7FRE4lSIQGTsn3+EU3LjhA+GuIwbXCwMvQGQclXDCTLpoowqxb9qh4Gw3IiZUbzS
         TcIRxEgoYNRyrYeMkmyuJHJXPbbODNhizVB8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690309843; x=1690914643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CGUzsI7Hg5HNN48tuYY6ykJTqafYlRSVvbn1sDRD8w=;
        b=k28OY4otgW3r5TsylPaP5wRrkxZ3MqsGUDfIXiGYMSECT/6yoLkc6M5sGSgmm401E1
         FS6pBCA3lNJPtOorEBE1KWMTcD2SzymKiCb8fqFYuKG+sWgULZgBaTtMFJdWJCVMnM0A
         UP6B6IecnYXrMVkLFv53TymCkuMx8LiU7K1Rihhb00ROiGJkLnBHeEMu9i7hYtvcEKAM
         RmH6aV0/+pbpFux5LOX365oQ6nf/piXbp6Gt1dVc62DuUSdEIjMgqIyiHgHn2uLTNQ+F
         sjF1FsaVwsrt3g0nndnCLxOVPaFQieCE8GiPwPh3LmxkXujSMqcNxG5ZZRDz3LSeEMK5
         6RFw==
X-Gm-Message-State: ABy/qLYKUidUVea035VTcmShnf9Pt6o+X0TBeDF6LSKk4Vaefr7s8esa
        QmE4RvRaBwbH7lrC283kjGg2z685/LgAVk6AT/WOsfnR
X-Google-Smtp-Source: APBJJlE03SC7LuCu1w2ceowYKjxPVM/QxxXbdrDlRNj9TA5um31QxhUPPtf0CnWjSuk1o9uRhwBrYg==
X-Received: by 2002:a17:906:7a53:b0:98e:933:2909 with SMTP id i19-20020a1709067a5300b0098e09332909mr13595248ejo.22.1690309843727;
        Tue, 25 Jul 2023 11:30:43 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id ks27-20020a170906f85b00b0097404f4a124sm8542267ejb.2.2023.07.25.11.30.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 11:30:43 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so2234a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:30:43 -0700 (PDT)
X-Received: by 2002:a50:c311:0:b0:521:f642:7183 with SMTP id
 a17-20020a50c311000000b00521f6427183mr134357edb.1.1690309842907; Tue, 25 Jul
 2023 11:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
 <20230725110226.2.Id4a39804e01e4a06dae9b73fd2a5194c4c7ea453@changeid> <1e7225c2-3ac6-43d0-a1cc-e9a207d263d4@sirena.org.uk>
In-Reply-To: <1e7225c2-3ac6-43d0-a1cc-e9a207d263d4@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Jul 2023 11:30:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uw99A6w5J_x7QoMH6Vv_zsFaSHNFGQPcJYMT2dbdi_+Q@mail.gmail.com>
Message-ID: <CAD=FV=Uw99A6w5J_x7QoMH6Vv_zsFaSHNFGQPcJYMT2dbdi_+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spi-qcom-qspi: Add mem_ops to avoid PIO for
 badly sized reads
To:     Mark Brown <broonie@kernel.org>
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 25, 2023 at 11:24=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Tue, Jul 25, 2023 at 11:02:27AM -0700, Douglas Anderson wrote:
> > In the patch ("spi: spi-qcom-qspi: Fallback to PIO for xfers that
> > aren't multiples of 4 bytes") we detect reads that we can't handle
> > properly and fallback to PIO mode. While that's correct behavior, we
> > can do better by adding "spi_controller_mem_ops" for our
> > controller. Once we do this then the caller will give us a transfer
> > that's a multiple of 4-bytes so we can DMA.
>
> This is more of an optimisation for the case where we're using flash -
> if someone has hung some other hardware off the controller (which seems
> reasonable enough if they don't need it for flash) then we'll not use
> the mem_ops.

Right. That's why I also have the first patch in the series too. The
first patch ensures correctness and the second patch makes things more
optimal for when we're using flash. Do you want me to re-submit the
patch with wording that makes this more obvious?

Note that it's pretty likely someone wouldn't use this SPI controller
for anything other than SPI flash. While it's theoretically possible,
the controller is intended for SPI flash (supports dual and quad SPI
modes) and is only half duplex.

-Doug
