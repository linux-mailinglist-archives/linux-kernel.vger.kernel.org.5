Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D587B98F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbjJDXzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244108AbjJDXz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:55:29 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DE8FF;
        Wed,  4 Oct 2023 16:55:21 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c6591642f2so70354a34.1;
        Wed, 04 Oct 2023 16:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696463721; x=1697068521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdaw17TPVHGyiD6Tf0no/oLm7Yt30YHHY3DBw59SSIQ=;
        b=YYd4n2ynZn5qBiLgpNmfFY1UGdWB5gWI/eURgD+2VQ7o/a8F9fL75IFzYIdx/q6llX
         94r3xcmB9qQUuJssNwKkcZbFgSfHtFppaUH3MMfyUGLi+X3/vRkEz1nicPhb5Q4/8Xdg
         nH4BP5s1Zu8ChyLu0x/3ADtVoUMu0h8WyvhQ+ev27tXhs5kNEir1SCFXkDC+QT9lcXtK
         r6gMZxq/sBahBWMYWcr/PcWA8+sEX+m5f/GuOUloMwH1RD5ZB6wDFpGGnikT6peLdhvh
         /+EWB7bWY+A6aBQkyLBQDifRqZ0WC4NvAECtUDHC6+9QoRof4dQ37e2sTUWISjL8lAaS
         0AVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696463721; x=1697068521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdaw17TPVHGyiD6Tf0no/oLm7Yt30YHHY3DBw59SSIQ=;
        b=n4Zv84plgZgQN5R7rfBjKe9j6wjYaOGNSK7jx1rQSyDUuY4TV6n7er6qWE9HGUXMBq
         E6iMFEvinx3lUKqIYzWy6Zc2BPxyqwcCf011gq1VdHvbKl3Lax4oNCSYvBwkExiNRuY1
         7JxmWG3117d4+uK58clfUaIS556O/28r8PqVhlG4qmJc5eYX/a3FHLTr3kp+oYiE+EDS
         zLJ1OXwTk7t+CrjRRRlTNhAzo9BW/V6ssv5fcTmCjLjD/FXUUN3WjZmSm8rz5mBb2ypT
         TVt4F9BFZB+Qx0/8fopNIOyABmZPhOTK97fjOjjL4thrgorkIidwxWpHqgdjvWmshTUi
         Qf9w==
X-Gm-Message-State: AOJu0YwGBQJjB4cF9XDCuxKOxDr3bb7/RO9UKnRxOgnCr9EvzmXI4e3x
        +KWSureXaTtzTaToWenC4TM6oDxJ4ENcOF1TYVZgYirsq8Q=
X-Google-Smtp-Source: AGHT+IGu+C6bXd32JPd8K3bHik/ZwSwKR6Kd0CF97BR3ckZJlN+4uKlr1OG6TaNIANLEdoYDeQTdNIzlsAe0ZuO4BgE=
X-Received: by 2002:a05:6359:639d:b0:14d:2d2a:97f9 with SMTP id
 sg29-20020a056359639d00b0014d2d2a97f9mr3653612rwb.1.1696463720943; Wed, 04
 Oct 2023 16:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231004230159.33527-1-aford173@gmail.com> <20231004230159.33527-2-aford173@gmail.com>
In-Reply-To: <20231004230159.33527-2-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 4 Oct 2023 20:55:09 -0300
Message-ID: <CAOMZO5BaxoQ9YcFyzVuhoUsLO=wXpMtZDwrGd-XoCaH9-rj3hg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mn: Add sound-dai-cells to micfil node
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 8:02=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> Per the DT bindings, the micfil node should have a sound-dai-cells
> entry.
>
> Fixes: cca69ef6eba5 ("arm64: dts: imx8mn: Add support for micfil")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
