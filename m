Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBF77D0381
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346557AbjJSVGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjJSVGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:06:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A54136;
        Thu, 19 Oct 2023 14:06:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82639C433CA;
        Thu, 19 Oct 2023 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697749601;
        bh=VY5heIBy9yftU7sYBNfoeKWqOwP4esxHzVS+2WzNFSc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CEmtcQ4IqPvbJWnxJuekiXHzD9SNs3kIEH+DgJzWzEXC5Q9YETxOU8YLkGXLGKUZD
         LnmoApJt7vYJgs5O6OxnIm6mCL+WZifbVTrMqDFyj3j8n9WK/u6a9JGGVw0FrIB4e/
         5Ec87wTgg1DWo6q0vAky2XeorzhdFNdrkoUOS4P4rw4/UPgQSM3wprhoratuzDCwjB
         dpQ00Eth8jNgLt60yQ1zOZOn/zmFE6+XPNVVZMV4Pm/yvRQKlzTdZ+j12nTp2epE08
         GyWZqkZRb5O9qqcNfO4bl/jOeKK02zywE9o1qXRgg2cMd9Y5eLwNO91bQAmpyZ/uK/
         stJt683nTgvqw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-507bd19eac8so145444e87.0;
        Thu, 19 Oct 2023 14:06:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YwhovISxy2sJd/SVg0h9ENC8NbYVn3plQw43ETPCgGXMeSnYVka
        Q5pmUT2rtWgSMUDowAY8tGJCY2/AukgH8qPzLA==
X-Google-Smtp-Source: AGHT+IFNNqLHq7e9rbvmn7g8Kf+819v49MVg4TY+Jdh4Fqqqe3ifpRBgvC9663PPxlQqPustO9R2FgtjwWcYakFNqKY=
X-Received: by 2002:ac2:5464:0:b0:504:3c1f:cbd9 with SMTP id
 e4-20020ac25464000000b005043c1fcbd9mr2295837lfn.16.1697749599708; Thu, 19 Oct
 2023 14:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231005160550.2423075-1-quic_devipriy@quicinc.com>
 <20231005160550.2423075-4-quic_devipriy@quicinc.com> <169710517252.1166696.13811645504228005200.b4-ty@kernel.org>
In-Reply-To: <169710517252.1166696.13811645504228005200.b4-ty@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 19 Oct 2023 16:06:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKdvnb7c_oMaMsQiJQzm1YF5uV+Tb9nQSgX0_+tP1KD8g@mail.gmail.com>
Message-ID: <CAL_JsqKdvnb7c_oMaMsQiJQzm1YF5uV+Tb9nQSgX0_+tP1KD8g@mail.gmail.com>
Subject: Re: (subset) [PATCH V15 3/4] dt-bindings: mfd: qcom,tcsr: Add
 simple-mfd support for IPQ6018
To:     Lee Jones <lee@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thierry.reding@gmail.com, ndesaulniers@google.com, trix@redhat.com,
        baruch@tkos.co.il, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Devi Priya <quic_devipriy@quicinc.com>,
        linux-pwm@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 5:06=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 05 Oct 2023 21:35:49 +0530, Devi Priya wrote:
> > Update the binding to include pwm as the child node to TCSR block and
> > add simple-mfd support for IPQ6018.
> >
> >
>
> Applied, thanks!
>
> [3/4] dt-bindings: mfd: qcom,tcsr: Add simple-mfd support for IPQ6018
>       commit: b4a32d218d424b81a58fbd419e1114b1c1f76168

This is dependent on patch 2 being applied.

Rob
