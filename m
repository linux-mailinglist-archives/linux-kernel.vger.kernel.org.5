Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C217C764840
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjG0HQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjG0HQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:16:20 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFF64C1F;
        Thu, 27 Jul 2023 00:10:24 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a3efebcc24so591019b6e.1;
        Thu, 27 Jul 2023 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690441755; x=1691046555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SrVMcJaiWF7KD0e83n1wWN/h1bRPzpDZzElVjjRIGJ8=;
        b=eChxa/bYZfkEfABlte77NDn3pYRGD9A4QmmOP3XkK5IDxmWzs1lnP8WpF6p2MD0rSS
         nnHeIGivngApgu6X10Px1VgH7fNYgbRwGs04ctdZt0lCJusTgS7uzoZS7zbkPuceCeSK
         Z6u+EtRinFkVw+Tg4U9fLQbX67tvPqkAThzK7Q732b9dA249nYW6EC7OTSYalW5MSwtT
         eonZBH1LZJ5Ey5+Nnyro4KQ1IU6RPIETm8ddLostN4bdQ91XzbVgU2OpnVoXlFkoD4We
         If4pPzxKI/AHd2djjQ5C6r/cGTGYTzOwpqaXGd4MVgvcoRUgBQySGuLwEAyKXcgK8joL
         jz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690441755; x=1691046555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrVMcJaiWF7KD0e83n1wWN/h1bRPzpDZzElVjjRIGJ8=;
        b=VA6s4UKpH+HPwMIX39drMe+9YSAvWeTDYpCJS7fXvLjkCrkc39+pjwik/PJd6iss2t
         IpssvJyLJ1sARF5Zxc0eflR92Q+xuEn4CG2RJlcA+aCESohxxaChErsGmszVM3mZM1H8
         1sDbNZtLkGCGXNRS5Ju7LBR0pSL8d2ZCXIek7ivtW23LI4ovIMJSvl9t1HuNlBJy0k6l
         rwhZTQ6Ud+OUvuOhDx3s5rLAThndzaiK5A3B00aj/NDVHHnV8QLwUdarmNMcte0/2Ss+
         v7IdboUrz6HVu5Pg6qFXSnaCNiRqjEx+wWU84yN7Fc/q1TMqeYh8cKTCxh+FXxyAwj5w
         LItw==
X-Gm-Message-State: ABy/qLbqhA+ZSwOzM2ErPlzI6IUuyDxHDVPLuxaW99iae9rDNugsbuIg
        i5uo6X+yTCeDuQPp2M8m0czJCgz95f4CkiJLgek=
X-Google-Smtp-Source: APBJJlEj7UE50F6k1/Di5V5cbfEIDx0jY4UZVoLZKjDQko4yELUj+ek3MjQ4zVwZYiPCUlsZXBQxC6+BEIPzneoUiOE=
X-Received: by 2002:a05:6808:1704:b0:3a3:eabe:7fc0 with SMTP id
 bc4-20020a056808170400b003a3eabe7fc0mr2648260oib.7.1690441754838; Thu, 27 Jul
 2023 00:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230715100211.14726-1-jonas.gorski@gmail.com> <8b70a042-bd9e-6c4d-dc71-07d807a1f960@linaro.org>
In-Reply-To: <8b70a042-bd9e-6c4d-dc71-07d807a1f960@linaro.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 27 Jul 2023 09:09:03 +0200
Message-ID: <CAOiHx=miGEbTg-4D6NfjsJLGEbUOdZDYn4F3NbdA_5NQFV5Vbw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: convert spi-brcm63xx.txt to YAML
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 at 09:32, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> (snip)
>
> With above:
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof

Thanks for the review, I applied the suggested changes and sent out a v2.

Regards,
Jonas
