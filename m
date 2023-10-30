Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA117DC0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjJ3UFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjJ3UFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:05:30 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84910F9;
        Mon, 30 Oct 2023 13:05:28 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-da0344eb3fdso4333952276.3;
        Mon, 30 Oct 2023 13:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698696328; x=1699301128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYDTSpQ9dmrM4NDguVsakYFrSE8CmlM1q10cI6GCnmM=;
        b=qIzDmm9nQlgseR6ztO40Rmx0HBMyu8KVtwrSXcT8+9Te66hyISH9d3mOfxKTKdPS3v
         U7lssopf2ECaHjHt9j5lCFVZxdZHAB0pkpxpnvgIqKGPNaASzkl6112vVWTvZHIR0O0h
         GYgFMj+LZsvb2j+4ubOXEmfCBR5amTQTw7awUyxA3j8y58o3z/59fLtJu4PmkxTxCE8N
         EYog/S2qBLizO6mwfIZsvrVa7VKzcNRnPOcYQK/xCVLAkPQ4mYm1EkHEZPhbDLgBzV2y
         nk02JshG8LJbhifIwOYO+tmd/3daAxh5LCb9C4cYkmnGmojCXH9iyAAoYCE8SN2y7RD7
         ieJA==
X-Gm-Message-State: AOJu0YwJ/boANH3LZ06qsQmBHUnxqsCwdVQEbh/eabwDOUPFrQZAvxIG
        XsZ5OqDvaJNRidJMnIC/JSXy+7QSYQ==
X-Google-Smtp-Source: AGHT+IGjrF29BTZX6gEMKbXB6pavKOzr1+W9zU6BVSKxwpR+Km79lLw4rl7fA5/sEC3OAdiFoAY8CA==
X-Received: by 2002:a25:4192:0:b0:d9a:634e:5ad3 with SMTP id o140-20020a254192000000b00d9a634e5ad3mr9826411yba.13.1698696327588;
        Mon, 30 Oct 2023 13:05:27 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6c7:c3eb:a6fd:69b4:aba3:6929])
        by smtp.gmail.com with ESMTPSA id d188-20020a254fc5000000b00d7b957d8ed9sm90632ybb.17.2023.10.30.13.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 13:05:26 -0700 (PDT)
Received: (nullmailer pid 2233224 invoked by uid 1000);
        Mon, 30 Oct 2023 20:05:24 -0000
Date:   Mon, 30 Oct 2023 15:05:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: ti,ds90ub960: Add missing type for
 "i2c-alias"
Message-ID: <169869631496.2231680.1229323026772786534.robh@kernel.org>
References: <20231020170225.3632933-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020170225.3632933-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Oct 2023 12:02:24 -0500, Rob Herring wrote:
> Every DT property needs a type defined, but "i2c-alias" is missing any
> type definition. It's a "uint32", so add a type reference.
> 
> Fixes: 313e8b32c616 ("media: dt-bindings: media: add TI DS90UB960 FPD-Link III Deserializer")
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/media/i2c/ti,ds90ub960.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

