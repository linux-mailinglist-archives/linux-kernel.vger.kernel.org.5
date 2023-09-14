Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC93C7A0EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjINUCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjINUCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:02:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E226BC;
        Thu, 14 Sep 2023 13:02:46 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-573c62b3cd2so1032634a12.3;
        Thu, 14 Sep 2023 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694721765; x=1695326565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9kaqIbiQMAt0qlEWTpOzlY6l1PPJ/Q7QNkCIjKHZSY=;
        b=PTsQQNcnexJIgMspZAd+C0u2Vi+ewaw5pteVbmX2uRMMpI6W7xWf8PVF78Y93G+awb
         Gi14Y7jczypsYnkl4zERvE+cBWKHFSdfe0tQCOJLad8z6XkRpfFT0sz2Vv9H+rXsJ60q
         6OoMB0cjq3PLqM6luTtIRIyzCLrChhg/jZgTXf3l+vTyrFAVJp5kALCS0aEJ0yIPTQMG
         d0nCUE86zOULR8YC8PSbIhxh5JEv6sNcNeQF1YRePJtB/yPHDmsxnR0WeHK4DKwVIkcv
         hoMEEINee+FU2fZiMwD/V6UYk1YYcgD+k2WRNG4irgRpYipa+9NA28zRf8DcfHJTI7LG
         lUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694721765; x=1695326565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9kaqIbiQMAt0qlEWTpOzlY6l1PPJ/Q7QNkCIjKHZSY=;
        b=K9pK2jWpjOcWaUTu50b51OlMRNle1q9PbS7Lo4XYLd0P2hzkfkNJN8fukYePxnAe+l
         jR92NH/8EUw2zUrz+qzmNF2m7dMvYnkxdNxYZKnejrwY6UMXoL2iXUjssko8P4c3ORrn
         WfNMrRLdqJQ7j5N+aka+tCTac0y0Z3MVOT9/3Ib696RqFnav0tgGywHYAG/NIj+9/9qA
         6Wwmgd1qHZ3t6FWPJtzduXvG084xJa9pgxkHOv/+yaV8PyKgTgLR/U71j83edTyauffK
         6Ft61Nlfmx0oi6qx3qwhl5rs3KlsfPFoA5NRNWjtxRUNFVct9G1Mixw4TW6ulCHuWnm/
         X+Nw==
X-Gm-Message-State: AOJu0Yxklwoxe1B8U95NGd03i9cuQpV0PUBuJZn15SkOrn0ntJJiWcm3
        vYNDAmOeZEKxx2gWrlwwEn/8rigHLIaBYSNYt0nG9Pfmzqk=
X-Google-Smtp-Source: AGHT+IF0AonOjgLve5XE/1tDMMKqZ4Phey7WW/x6Zy6mHY7woUjaH+9Urd+32q7KgKeFme4YyXkDWu1Gt6tz2NfKmV0=
X-Received: by 2002:a05:6a20:7d85:b0:13a:12c2:359e with SMTP id
 v5-20020a056a207d8500b0013a12c2359emr7914124pzj.2.1694721765383; Thu, 14 Sep
 2023 13:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230913211449.668796-1-jcmvbkbc@gmail.com> <20230913211449.668796-2-jcmvbkbc@gmail.com>
 <d7bf0ae3-d263-4231-9656-2b7af4b372a3@linaro.org> <20230914-stumbling-smother-2b048381952c@spud>
In-Reply-To: <20230914-stumbling-smother-2b048381952c@spud>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 14 Sep 2023 13:02:34 -0700
Message-ID: <CAMo8BfJTr2q5+8jmUsDPsWY795udvO3vb-fEMUrsLuiFuV-eFw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: serial: document esp32-uart bindings
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 7:48=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
> On Thu, Sep 14, 2023 at 07:55:35AM +0200, Krzysztof Kozlowski wrote:
> > On 13/09/2023 23:14, Max Filippov wrote:
> > > +description: |
> > > +  ESP32 UART controller is a part of ESP32 SoC series.
> >
> > 1. Company name?
> > 2. ESP32 SoC series suggests esp32 is a series.
> >
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - description: UART controller for the ESP32 SoC
> > > +        const: esp,esp32-uart
> >
> > Also, the vendor prefix looks incorrect, so again - what is the company
> > name?
>
> esp32 is made by expressif, which would match with "esp" as a vendor
> prefix.

It's 'Espressif', but otherwise yes, this is a registered vendor prefix. Se=
e
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml?h=3Dv6.6-rc1#n443

--=20
Thanks.
-- Max
