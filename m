Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981237C438C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjJJWOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjJJWN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:13:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3641E9D;
        Tue, 10 Oct 2023 15:13:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso1122855666b.1;
        Tue, 10 Oct 2023 15:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696976036; x=1697580836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPW6yvv0EUrkLCJYPx2iwf8Z7uT45wdZr5DJERiSkTk=;
        b=Yxtcwh1gTlb+F7BNCQmz59qA4N7ZUcp6X/DLMU8hIBmhF8RfMbch369E6WGgNkR/FZ
         5SOHjhcJaRvJ8oJYBjDfrSupPmJCeIZ/RlcBJ8ciaF7jIEJe69V0TDipq1hc5MuAtVNS
         sdyi8cMbA0TuFD0H9OpCRwXD+t6b2RFYmNXkGfjGGQoHz6NXqvqQtxNyxgclyf1fJbQS
         IQK40zT/SrcFDk3SgeYHKBF70Nvh+oqt5V0yRlBifBIOmMUM+j/EwT2L1GcJwIa/PHOA
         kTsLYhjpQM25E4pq0DUEfGcSrjnCIlYofmTOX6e5gvJc60E6Jefz9qQPILtj/rHEFJPR
         Z6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976036; x=1697580836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPW6yvv0EUrkLCJYPx2iwf8Z7uT45wdZr5DJERiSkTk=;
        b=uL4XQ6RduqyNIRUExLH3W9cswADyVp4jI9T7we4SxvY09Qi9FxkmmLqkwdUQDwst03
         MKOJnpF5UnA0B8ygaxcKzZtkA+knjMJdp1SSRj+CQuxeskdkoqDQOLtFvKuyBK3bg/PI
         XBXIF9+bc6W/FFYUPgMei9frSjRxOxEXal9JdU4N7Ijs7M+kg6Osh0wtHQdEO1Lx+0fU
         ayDfHUmf5zfh49SLqnZbwiyOV+dL2lkwG4vKgRBCVdXxhAQfo4ac4xK1eVT1cA4EftTJ
         ODwWPkH+k+f5QKKenaI0d2DSauKjXlHQnqQ2K09wTJGA1D1tf4PoUCJWHxSN44Usy3e+
         HwQg==
X-Gm-Message-State: AOJu0YxxjUHjFWbA1EXKhalT5SkXqL9NjB51fRYt8bOAXD+jRfCE+Qm5
        b5ukpOraOYnnPmoaI07CE4s=
X-Google-Smtp-Source: AGHT+IEQkWCEIGavtYFVPAaIRoQ36/Ul5QZ/lbRWK4GaysFUrF7toCoZPU95Zhv8Lb7l1OBotw/bQA==
X-Received: by 2002:a17:906:2215:b0:9ae:4536:728e with SMTP id s21-20020a170906221500b009ae4536728emr19362414ejs.72.1696976036576;
        Tue, 10 Oct 2023 15:13:56 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id ci24-20020a170906c35800b009a2235ed496sm9100228ejb.141.2023.10.10.15.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:13:56 -0700 (PDT)
Date:   Wed, 11 Oct 2023 01:13:54 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] net: dsa: vsc73xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <20231010221354.nk3fnypx64rvwr7e@skbuf>
References: <20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com>
 <20231010112051.zgefbx2c3tjneudz@skbuf>
 <CAFhGd8pF04DCbMJFOR+93azqzWYZ2aE9FByp7yVVJR90g7MN9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhGd8pF04DCbMJFOR+93azqzWYZ2aE9FByp7yVVJR90g7MN9g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:44:42AM -0700, Justin Stitt wrote:
> Wow, thanks for the feedback here. I agree that the current
> proposal is problematic. I wonder what you think about
> using a ternary to avoid smelly code dupe:
> 
> for (i = 0; i < 3; i++) {
>         cnt = vsc73xx_find_counter(vsc, indices[i], false);
>         ethtool_sprintf(&buf, "%s", cnt ? cnt->name : "");
> }

Looks like that would address my comment, and it looks okay.
