Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC57D5BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbjJXTyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344323AbjJXTyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:54:43 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36219F;
        Tue, 24 Oct 2023 12:54:41 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5849fc56c62so1527424eaf.3;
        Tue, 24 Oct 2023 12:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177281; x=1698782081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4P06uBzRipjLzoJkzz9LoHUG6EOJqfFmfgLk3ncgqU=;
        b=DooPxiaizi7/RpogsBzZEL7ncXKnoLymqyUnfylA8zUPePA5VEo19jiGEds1IFlFVJ
         ZUEP0leFhxviN3gvydJXn5FYSrZgzTjrSo1Sd6F/0ZMAXjb1LPxVkNUlvr2Mg9/sc6a0
         6P5+lRp6Z3jxPTwtWCW3/f6FBh6iy6AAzTrlwkGkZCiqmi4VYLuNbcOGYkAngq3dosRh
         +CcPJASSEaIARC3TD/HCm9bLpMk918gbQFXr9Vv8lkwikKt09dvD3WbZOZ0xKA8yGB5n
         hMtg7Us0L4hJ1G1yniWL2NSU4Gd7KLJFFNoce0+sLAh0s3BUUZyxPbAxXtMP/FtZ6gfX
         ydxg==
X-Gm-Message-State: AOJu0YyW5hN3bi4blBuQboe8nJedR4YBSVbfMM3xRNvoFjKKj+drwaSp
        pLxEKROK5Za8dkjUV4Pkhg==
X-Google-Smtp-Source: AGHT+IGJlL1IDM7XNuSkK/cZeKu2ijhkQt/tcYgIoTGAD6lhjIkGNrjtnZ7Di/EIt0MnbI4/V2YbFA==
X-Received: by 2002:a05:6870:9728:b0:1e9:e02e:f4c8 with SMTP id n40-20020a056870972800b001e9e02ef4c8mr16749561oaq.54.1698177280866;
        Tue, 24 Oct 2023 12:54:40 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i1-20020a056870344100b001ea7e2adbc2sm2298295oah.1.2023.10.24.12.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:54:40 -0700 (PDT)
Received: (nullmailer pid 458983 invoked by uid 1000);
        Tue, 24 Oct 2023 19:54:39 -0000
Date:   Tue, 24 Oct 2023 14:54:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>
Cc:     Nik Bune <n2h9z4@gmail.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, skhan@linuxfoundation.org, t-kristo@ti.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: davinci-wdt: convert txt to yaml
Message-ID: <20231024195439.GA455431-robh@kernel.org>
References: <20231021171323.113208-1-n2h9z4@gmail.com>
 <20231023-sanitizer-blank-44916ffa043b@spud>
 <229b7c61-f1fb-4a38-9479-d65349c72956@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <229b7c61-f1fb-4a38-9479-d65349c72956@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 07:12:16PM +0200, Krzysztof Kozlowski wrote:
> On 23/10/2023 19:02, Conor Dooley wrote:
> > I'd swear I replied here already, but I checked on lore and saw
> > nothing...
> 
> You're almost right:
> https://lore.kernel.org/all/20231022120328.137788-1-n2h9z4@gmail.com/
> Different binding, but same things to fix. :)

Welcome to the blur of DT maintainership. :)

Rob
