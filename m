Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E3978B0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjH1MmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjH1Mln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:41:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38C3E5;
        Mon, 28 Aug 2023 05:41:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50098cc8967so5021419e87.1;
        Mon, 28 Aug 2023 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693226498; x=1693831298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=35Zvmo59YN6o3oPAuxnrM8DnmGEhpgbLp58kB3g9lGU=;
        b=KSxh1ke+AfqK9ORplGlqm3Eit0KfK+YhWYLVMtxDY4buQMStb0+QJsms3Ku6pCvCbC
         GLw0DNyl5PcYzZzILkUqyYmoblod2u44FftEatXPsjyxp0rKRN3KJN3cvmQSMslbQoSl
         xJUNbaidTzygQRF1ChfqgNP/kPG/TQ8O8sPo7rU38PTY3JQLH8+DCsAjl+x1p871cbZm
         feRtMbwgiApiSCfvZ3axD0O4iG4b1vAfy6vSB83CuXdDp9121EI+OoTFcYDHyiQNgM83
         qBom01b8lnIiexli8boD9pmqBjvpE/XFzvJx/gomDD0p/BKeIvJ9DxzdmBpR1jxbUK47
         VS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693226498; x=1693831298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35Zvmo59YN6o3oPAuxnrM8DnmGEhpgbLp58kB3g9lGU=;
        b=TNNpZnsj8iz5DKcYa7h8ZTdPeSe7N9/1356QnljzEzmfqU4lMmkRZ4eMAkeWzpKBOZ
         49QkV0woy17bkmzEV8J7dmmRdxIFxxEzzBfroyJ3G/6OjUHy4vyWnpXInrWxPT1b3OZp
         n+aQI5wMJPMNGG6Pxu2GNiQlTPEAiPiyUizhWzupAVOzzQraoM/DLsZi1k2X6WADQx3p
         h4TYn5g8IzJ0xrxbn/WNFy6tL22scMNgEchtQziwk6EfSfZF6htnNzl0WshzbLsAs8XQ
         lIVhiVtkDjjh1gtMaDub9TZMMkaEERVmQkNj6wwKptkWnLJkxxZB5DdBAxnPJ2TxoDXZ
         6+rw==
X-Gm-Message-State: AOJu0YwxCOqr/iyRYHjEOpab62CUcSkKi+SSDdGbx0XVFNtvP5nKHVbD
        1uJGuhVPfdUXNEoOxSZzQeQ=
X-Google-Smtp-Source: AGHT+IFRlAtGX0zI23L+HPcaLdtS//sAFD2U7kQ3HH8Hea5Ggh0g2kh1a/yBtz8lEpewXjLli0HgGg==
X-Received: by 2002:a05:6512:2203:b0:4fe:2d93:2b50 with SMTP id h3-20020a056512220300b004fe2d932b50mr22395653lfu.31.1693226497635;
        Mon, 28 Aug 2023 05:41:37 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id i22-20020ac25236000000b004ff981955cesm1568114lfl.228.2023.08.28.05.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 05:41:37 -0700 (PDT)
Date:   Mon, 28 Aug 2023 15:41:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v3 2/4] dt-bindings: net: Add Loongson-1 Ethernet
 Controller
Message-ID: <mqea2nlysz4x3ff7xhg3fypgiyvrpqz6pwje4kavxoigrdlbtr@k6jw7jqsbkxr>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-3-keguang.zhang@gmail.com>
 <dwe4oyunc2uitullflhryg7kmgeklj5wlx6ztrg5hahl64tkuz@koe4tijgj3bp>
 <c32130ab-27dc-e991-10fd-db0fba25cc97@linaro.org>
 <q7o7wqodz5epyjdj7vlryaseugr2fjhef2cgsh65trw3r2jorm@5z5a5tyuyq4d>
 <d6f796aa-c468-037c-3f53-d0c4306c8890@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6f796aa-c468-037c-3f53-d0c4306c8890@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 09:15:17AM +0200, Krzysztof Kozlowski wrote:
> On 27/08/2023 23:01, Serge Semin wrote:
> > Hi Krzysztof
> > 
> > On Sun, Aug 27, 2023 at 09:56:06AM +0200, Krzysztof Kozlowski wrote:
> >> On 26/08/2023 23:04, Serge Semin wrote:
> >>>> +  clock-names:
> >>>> +    items:
> >>>> +      - const: stmmaceth
> >>>
> >>>   clock-names:
> >>>     const: stmmaceth
> >>> ?
> >>
> > 
> >> The existing syntax is correct. This is a string array.
> > 
> > Could you please clarify whether it's a requirement (always specify
> > items: property for an array) or just an acceptable option (another
> > one is suggested in my comment)? I am asking because:
> > 1. In this case the "clock-names" array is supposed to have only one
> > item. Directly setting "const: stmmaceth" with no items: property
> > shall simplify it.
> > 2. There are single-entry "clock-names" property in the DT-bindings
> > defined as I suggested.
> > 3. There is a "compatible" property which is also a string array but
> > it can be defined as I suggested (omitting the items property).
> > 
> > so based on all of that using the "items:"-based constraint here seems
> > redundant. Am I wrong to think like that? If so in what aspect?
> 

> Syntax is correct in both cases. However the single list compatible
> *cannot grow*, while single list clock might, when developer notices
> that the binding was incomplete. People add binding matching drivers,
> not the hardware, thus having incomplete list of clocks is happening all
> the time.

So it's just a matter of maintainability. Got it. Thanks.

-Serge(y)

> 
> Best regards,
> Krzysztof
> 
