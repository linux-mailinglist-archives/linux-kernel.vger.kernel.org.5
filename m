Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7501B7D2F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjJWKIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJWKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:08:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8AD70;
        Mon, 23 Oct 2023 03:08:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9be3b66f254so439993266b.3;
        Mon, 23 Oct 2023 03:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698055726; x=1698660526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NoLI+1gjuvGhtQcIYLFoNDRARHSfjJdsWzkAT+zoGXc=;
        b=BThUPZ+nb/A0ORA6ToamCPQADyflKS2RePmRSxV5WHnI9AiySPY1fV1D1AjLmhCMjR
         B8DVujk9XbwBZ6rXRBTNjm9N+loZSmDmfjp4WfebLXixYqh4dv0eVUanTI83bkjoAzN0
         DP6Z5ECioAfOkj5heW9yS3GZ4y4VQElH3Lf0jAinYQ5TyTUzCNNPpNtRS1Ke36vcRBdv
         fNL+Y+JpyZS7z3FvOARBHtsWAHxe1PfmAvsjA8+cg3KIAa+loTAoB4JM7iAOt1SeCZxm
         vf1V0+H4J2yG2//qQsCVzorV4XOTM9eNoqvGHIrno2oQaHf7jfi7YIPyB8tW+jEGcqY6
         MVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698055726; x=1698660526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NoLI+1gjuvGhtQcIYLFoNDRARHSfjJdsWzkAT+zoGXc=;
        b=ccm0B45OPNvVu3zicpk0v0Y+Hk1iFsyOaY4+YQN8MJoGE9pehxSkB+NbN6cdVk/flr
         oLlEaJIppjgqocTT443jW/k2BfGsnbMWZPfOd1IbrkT14wyv4ddzOqdoAJw5GFvJn2gA
         ZMfy7LSBOj8gpvHvKVHEfawXWsc0iW/UHj+MiWcJ9XoBAbq6/ZXOc6g41q6QTe1F4V/8
         JIFaSsyN8r0o8/ZxfEPqYbGQJ6IygcW07XtyQgYSVidZNm+s+5/fp5/SA9y7izyLR7NK
         irqx1uugnaqJr5Uk9dGTpQjsfdK+y8UWJgPDdkUZFftet7EbhtcU37Fnflfls4VWycO6
         Jfpw==
X-Gm-Message-State: AOJu0Yzn71XsD+WqOy5qdmlrBXNWWNjSBHdK+UY8FFu6utgvhLZBy/YX
        Otndsg2XmcdfT1Ik2KtYJda4R+cekcVFcj02/vrgw11eWYQ0xYgIy6Q=
X-Google-Smtp-Source: AGHT+IHH5k41rDtCP7EilOm3nbP1rmpcCZAvRbEfUvewcW1efh55jqPAh4r4JGYS//ROncv6/E0AMMI0cpirb/riDaQ=
X-Received: by 2002:a17:907:e91:b0:9bf:6200:fe33 with SMTP id
 ho17-20020a1709070e9100b009bf6200fe33mr7738331ejc.16.1698055725602; Mon, 23
 Oct 2023 03:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231023090230.43210-1-lukapanio@gmail.com> <20231023090230.43210-2-lukapanio@gmail.com>
 <26b65551-1437-4e21-947e-1628052b7c36@linaro.org>
In-Reply-To: <26b65551-1437-4e21-947e-1628052b7c36@linaro.org>
From:   Luka Panio <lukapanio@gmail.com>
Date:   Mon, 23 Oct 2023 12:08:32 +0200
Message-ID: <CACi=Ov6YLoOvqUqdJArGvEWsODUcwkfyTpdLX4RB+eBNLbn7RA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial
 device tree
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Slow down with these resends. You are spamming us way too much. One
>version of your patchset per day. Max.
Ok, sorry.

>I don't understand why decided to ignore my advice.
I thought it was your suggestion to switch to GPL-2.0-only?
or you wanted to say that it should be "GPL-2.0-only OR BSD-2-Clause
"? Sorry didn't got that
Thanks,
Luka Panio

P.S. Sorry for duplicated message if you got it
