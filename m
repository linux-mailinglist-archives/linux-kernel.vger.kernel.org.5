Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA3D7D8A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbjJZV33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjJZV31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:29:27 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2B41AD;
        Thu, 26 Oct 2023 14:29:26 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b3e13fc1f7so859017b6e.0;
        Thu, 26 Oct 2023 14:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698355765; x=1698960565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnAK5BMlF65lkOhM6iM+quZLKYFUSHIiyg2Q3m6WDFU=;
        b=dIWA8WgYRGqD5kFRQq+O6ny8zjtiovR+39CqBDXbcEVmqrT1NFCtwuehUHD3BCAPeN
         Hn2gCACaalNQH6NYUiRSAJBpZm2JumigO7bhWJqMm6rImKJUKCb4c+Xz8Vu9bG7bLt6e
         /z+dJP0lwEOacsTB6+DGqPgY3sHUvYW1z0aYQbmVdHkJRM/Q7kRxkUMjwotZLIHjNBix
         QF6a+h9bjSCqToy0x99Z5RxCSzTzlcSmjfqyhRgU1hEAfASC5fgUmQ23xmYhmZUMuGkP
         sPlpdgAid3L301K/lfM3roxqpL2xLKzTUEUcpO7fAkxcsysqsq7b5fuASe/nqyOijwU1
         niLQ==
X-Gm-Message-State: AOJu0YwJpy4FSGMxpCg9X0XUKu1xEeJkPKwDk48dbL8LKV3ILpiXJeDt
        32aOyuAhC5yXX8jRNR1uoA==
X-Google-Smtp-Source: AGHT+IG1gRj0pulAuQsLZu6sq3vQCwadJlWXJhhddMZzGEnP0a5eixxD92pxkIor2GWEbVLwANIoKA==
X-Received: by 2002:aca:910:0:b0:3ac:a11a:4879 with SMTP id 16-20020aca0910000000b003aca11a4879mr607322oij.39.1698355765257;
        Thu, 26 Oct 2023 14:29:25 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a4-20020a05680802c400b003b2ef9778absm36251oid.46.2023.10.26.14.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 14:29:24 -0700 (PDT)
Received: (nullmailer pid 429792 invoked by uid 1000);
        Thu, 26 Oct 2023 21:29:23 -0000
Date:   Thu, 26 Oct 2023 16:29:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] dt-bindings: qcom,pdc: document the SM8650 Power Domain
 Controller
Message-ID: <169835576333.429734.9986265830513498097.robh@kernel.org>
References: <20231025-topic-sm8650-upstream-bindings-pdc-v1-1-42f62cc9858c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-pdc-v1-1-42f62cc9858c@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Oct 2023 09:27:36 +0200, Neil Armstrong wrote:
> Document the Power Domain Controller on the SM8650 Platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
> ---
>  Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

