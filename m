Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40AD7FA781
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjK0RHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjK0RGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:06:52 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CE93256;
        Mon, 27 Nov 2023 09:06:16 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-589d4033e84so2373507eaf.1;
        Mon, 27 Nov 2023 09:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701104775; x=1701709575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWvJMjZ6wf7DZDfLqz8m8/1Tw1FelhGhcvu4suyu0c8=;
        b=jdx1ut2snO5iTLddkc1kWI8cXB2ZEJ0cXmxBIIJIhFv/P4v6CmBz49k6DmePTNTN/N
         k0NCTZe/+YL0wkdU2ZXZnBMWAenEX+bJHlWA/zRipyue1b+I0va3JI7/AYP4fYUVDOgs
         JzPKiyzoLlYQ1NtCzHBf8PfTiCK+AkqIOd2eVGHh93x67fEm/4CJbINrVhNspBF070Gj
         ZJ/yINJ9xauWyJkeE6gXFcX5aVvhOjY/dCZoKmr5IwgMJv4MIt5A6GVKvPYQTRBQ/JKr
         IuB/nIZ4Qhg4WqRM7+ydXtFDBztQnDkEWKsK4Yp10f7jfAyCxHXKiZ5QjtzsrWN0mK7J
         eG3w==
X-Gm-Message-State: AOJu0YzRZxXimhpu8Y0RukKOihYu+0XWqIcWBDNm7LqMjLdkDHY//sqV
        dIa1cS2QcZzx6Bj4oQI3n4ri5ttatw==
X-Google-Smtp-Source: AGHT+IGomlZxiLfZXj8tSZA4lc0/MxCM/APuXjlf1dCwBFKdZvDLqTjOQLkhFGr26D+VaTkL4m/9Sg==
X-Received: by 2002:a05:6820:220b:b0:58a:128:8ff0 with SMTP id cj11-20020a056820220b00b0058a01288ff0mr13465794oob.5.1701104775517;
        Mon, 27 Nov 2023 09:06:15 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r21-20020a4aea95000000b00581fc1af0a7sm1552890ooh.28.2023.11.27.09.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:06:14 -0800 (PST)
Received: (nullmailer pid 1458096 invoked by uid 1000);
        Mon, 27 Nov 2023 17:06:13 -0000
Date:   Mon, 27 Nov 2023 11:06:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] dt-bindings: qcom,pdc: document the SM8650 Power Domain
 Controller
Message-ID: <170110476457.1456623.11118726147199543641.robh@kernel.org>
References: <20231025-topic-sm8650-upstream-bindings-pdc-v1-1-42f62cc9858c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-pdc-v1-1-42f62cc9858c@linaro.org>
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

Applied, thanks!

