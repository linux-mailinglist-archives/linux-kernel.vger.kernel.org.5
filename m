Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECB280A985
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjLHQoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjLHQoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:44:37 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6FE10C0;
        Fri,  8 Dec 2023 08:44:44 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6d9e179b217so1048021a34.0;
        Fri, 08 Dec 2023 08:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053884; x=1702658684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQNz+xvqRdVvhqlnaesIupD2ZldVHm05D8bBXCEt6fE=;
        b=bnEUnLu9z/HvvSg9LYf76G0Opbg12q4r8gQBAzhEPpmFod4HOLl1pbFuUT6EqwtEu6
         kXAo9HJBWVfMuv6YHqtGLx7WCpzORdrsxNXtMA2HW9W2F9zdD2c0iCNgVxeht+5+4uw/
         re77XRv8pHt4aJzlyd+GTqJEPOb0gT/lLuN3R2NqNGhQUSrArKzCsnqXSdC63wZ/kGze
         G72jOieR7ZPzqBp3krrf8KObf2J83eRuaSP9W2Nbcj04QY8Xif0HXX+oDShF3W5FIP7g
         fCKDvTInIF42CvihB3RxuBgwyCoUt3+MpmtU1a2JnoT47KhSFmtXAbsmRysj6Pjugqdp
         OUcg==
X-Gm-Message-State: AOJu0Yy75NfjRN7KbgOOB7iHfxdIlq882h4LDizJrYOk5PBE77vnLz5p
        brmfkMBkORWqTdyzfcLwuVg1+NJNiQ==
X-Google-Smtp-Source: AGHT+IEElGzMDgsf5XKgsEJBooUGCELsszhJ/I7kKbKCN+yZO/mIQ5M8oB94icul6SeFg7QJKz8wzw==
X-Received: by 2002:a9d:6a4a:0:b0:6d9:a5ef:a2c7 with SMTP id h10-20020a9d6a4a000000b006d9a5efa2c7mr372426otn.9.1702053883797;
        Fri, 08 Dec 2023 08:44:43 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w26-20020a056830061a00b006ce28044207sm349258oti.58.2023.12.08.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:44:43 -0800 (PST)
Received: (nullmailer pid 1748007 invoked by uid 1000);
        Fri, 08 Dec 2023 16:44:41 -0000
Date:   Fri, 8 Dec 2023 10:44:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, tzimmermann@suse.de,
        conor+dt@kernel.org, airlied@gmail.com, hjc@rock-chips.com,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        mripard@kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: drm: rockchip: convert
 inno_hdmi-rockchip.txt to yaml
Message-ID: <170205385847.1747356.13765108616438619401.robh@kernel.org>
References: <49c6afec-022f-02de-99a0-d409b64da198@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49c6afec-022f-02de-99a0-d409b64da198@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 04 Dec 2023 18:39:03 +0100, Johan Jonker wrote:
> Convert inno_hdmi-rockchip.txt to yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Note for rob+dt:
>   Used enum to "soon" be able to add "rockchip,rk3128-inno-hdmi"
> 
> Changed V1:
>   Rename file to more common layout
>   Add/fix hdmi_out port example
> ---
>  .../display/rockchip/inno_hdmi-rockchip.txt   |  49 ---------
>  .../display/rockchip/rockchip,inno-hdmi.yaml  | 103 ++++++++++++++++++
>  2 files changed, 103 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
> 

Applied, thanks!

