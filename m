Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02D475B826
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjGTTjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjGTTjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:39:02 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B242118
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:39:01 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bb07d274feso708200a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689881940; x=1690486740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+940zjds4bSCgKIfbB+4h4F9JhiabKtFHTSYiorpkM=;
        b=xau+BeGnyS2usHyzCT7o9jXEktoyvjp12ixYPPNawQWUEIL8od5FVs5CDnn4V+m+14
         03ETb6Yu9BgA0hg5yr1GbgpLd6Z/14Cw7l8DFTxwCO68I26BO45HQ2FXM9ZkY8OcoYMZ
         sMvj+Ocq77RIpGaVwk8NRGvSixQYqx2bIAV1knjJfDOWUQD4fhY5tz5scW3HbkrUj42A
         bpx4qQgEW8OKH/m8WPkpAJMXOKzhDjuxfeBQjL3HwabE6t2n1eannNNzhs2TxLwsk1NQ
         Coxd4j4se52HFavrFh+adE+QB0HS8Gzd3om1nqCv0Rtfzrl8pJsHAnVaMXm8i84nj/vA
         THeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881940; x=1690486740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+940zjds4bSCgKIfbB+4h4F9JhiabKtFHTSYiorpkM=;
        b=AOyjBD8o3oaDYhOkxQuYjQAEKonX7s2Drl97JXZNR8/YDZ1QCBhU9jL6RodEweJ0zN
         UOuTbFLq7pJ/I0+pcpz9B/QIwnUrPG9LvYRI7PUn7pAz/lASIi+39GEc5cyU6B7UjBVe
         oizY8uT5jNvrN7HT8a0Tso/KJbsuhzK14iBdd7+zWMFr19gABDWcP9rvW21CivJPxEvw
         /4PrFlHfzDDM9RzX+2kesmYXcoIdMyNgmVMly2TDPAE0Ru8L4FS5ZB/EsygAUQQbew83
         f969nznw9f/HV5ZcYlHhpa8UTQgj501E3q87IP4TrgBMLv/b3zjQOMMKutaY5BUpNuMx
         nZmw==
X-Gm-Message-State: ABy/qLam04jM8h0xhTgXo70kxkBL4qux3RTbl+YjFdN78Y8HqajTTK9q
        bmc+xRoi7cAvjTs8d58MmmDWFojclyzenzxyWlL05A==
X-Google-Smtp-Source: APBJJlHxlB8o/cqiFOLqYhuTYMWBF3q2dKdZ0BspgF6BWNj8zk5Ho3Qo5xNlFK8k7e+JM/0rKSf9LuvJuG2y4pHZdaw=
X-Received: by 2002:a05:6830:1d85:b0:6b9:6ffd:91e6 with SMTP id
 y5-20020a0568301d8500b006b96ffd91e6mr3881194oti.32.1689881940658; Thu, 20 Jul
 2023 12:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230714-topic-lpass_lpi_cleanup-v1-0-dc18b5bd14f7@linaro.org>
In-Reply-To: <20230714-topic-lpass_lpi_cleanup-v1-0-dc18b5bd14f7@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Jul 2023 21:38:49 +0200
Message-ID: <CACRpkdYBNOWC1NfBd6dXCFrP3zRK3kDeL_H=HyfFk=e1bko=eA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Clean up LPASS_LPI probe
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        cros-qcom-dts-watchers@chromium.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Fri, Jul 14, 2023 at 2:40=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:

> Some SoCs (like SM6115 or SC7280 with various firmwares) expect a single
> clock for the LPASS pinctrl.
>
> This serires addresses that by simplifying the probe code and relying
> on bindings to sanction the correct number of clocks. That allows us to
> shoot down another downstream-ism.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Patch 1 & 2 applied to the pinctrl tree, please funnel patch 3 through
the SoC tree.

Yours,
Linus Walleij
