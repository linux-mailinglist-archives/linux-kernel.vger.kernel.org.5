Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F797FAAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjK0UFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0UFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:05:38 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A591B4;
        Mon, 27 Nov 2023 12:05:44 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58d564b98c9so1453475eaf.2;
        Mon, 27 Nov 2023 12:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701115544; x=1701720344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMyoTTuiVRpV0VWXyFvNZKLDihVgmMriBAWsa2DwHI0=;
        b=lvthBOVF4pXAvfKioKy6FHS7Oi15t1d8wmIkri6nUA+B9Aivf02CbDbdWIheQ4n5RV
         KqkzyYsfby4aX/leX58qKAWfNrIVYCW2XYsjoA4wfeRrerpqXU7dg3ksh/tE9S2EfQcz
         bh9cAJrdZisN3lvn1KSJ8Q9ABns/v1CqRFJpm8Bw/vQgm6r/TdiZMbj8/G9kHJC50RKN
         MzAHVfqhewXobuscirUipoYPKHkUMTaFgWIbTdrboA1i3b7FIaMny/1R0PJQ/klHfKG+
         klBLVps4XcCiwGg+sZVcS20jyBDU+DyDaU+ymo9iRfDL6ToTTFXcQMpYekVwlG1u/0nm
         DrfQ==
X-Gm-Message-State: AOJu0Yznwvfo6vOv8VUZJigCJv851aYt6yZIwonwibiRwmQSqW5YxYpn
        B65ksPR4GCnywzb/qfGMbIBAOl/sRA==
X-Google-Smtp-Source: AGHT+IEm2dvkEYWOa5k7Lp49fIFe8GAkRT/1/cuPFrC1po7M0Zy3Z5WDXjsy6YMeqTpNiVPUT9YIkA==
X-Received: by 2002:a05:6820:1ca0:b0:58a:67b1:47ca with SMTP id ct32-20020a0568201ca000b0058a67b147camr15227339oob.6.1701115544080;
        Mon, 27 Nov 2023 12:05:44 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f193-20020a4a58ca000000b0054f85f67f31sm506600oob.46.2023.11.27.12.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 12:05:43 -0800 (PST)
Received: (nullmailer pid 2955904 invoked by uid 1000);
        Mon, 27 Nov 2023 20:05:42 -0000
Date:   Mon, 27 Nov 2023 14:05:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: connector: usb: add accessory mode
 description
Message-ID: <170111554173.2955721.9059512533870935138.robh@kernel.org>
References: <20231121202925.2481471-1-dmitry.baryshkov@linaro.org>
 <20231121202925.2481471-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121202925.2481471-2-dmitry.baryshkov@linaro.org>
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


On Tue, 21 Nov 2023 22:26:59 +0200, Dmitry Baryshkov wrote:
> Add description of the USB-C Accessory Modes supported on the particular
> USB-C connector. This is required for devices like Qualcomm SM8150-HDK,
> which have no other way to express accessory modes supported by the
> hardware platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/connector/usb-connector.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

