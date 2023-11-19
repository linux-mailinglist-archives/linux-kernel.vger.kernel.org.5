Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75D7F075F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjKSQM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjKSQMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:12:21 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91A9D4C;
        Sun, 19 Nov 2023 08:12:17 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso1624915fac.0;
        Sun, 19 Nov 2023 08:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700410336; x=1701015136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9wcYFKu/4xwRGovh8aoKJ15XNK5juyU7wr0t4x+NYk=;
        b=ljqIYSHzIntXMPWLRcKiNlag8AFB04m3NlVVwoOu9zPz0mS6SAseQdiaAZ8Ysvhope
         3btVUubVHQm2SP4vZ2YYxEpZbJjysmiVIFDZlgl0Ah2P3i6kjgoxYTA3R/3q7n9h6B/D
         lUpHXQzmFMdOzBJG3GvG5IJ0ecQeqtr5gagVfs1/8IWxMwT7ZW+2lLoQvdExyg2JhN/2
         0OUOFSqoclquDd0vXI+5CITGVlUTK0bhc1VfDtW7OG5biT/RlzWKGS01EKeqBdTTR0hD
         eAdFHo2wVbxiN/HQ61pn8lG5WIX+t5kEuIKp1AXqHGyN+XWJuhxAgpdjId/Q5GDF9hw4
         /Mow==
X-Gm-Message-State: AOJu0Yydwk6/Jqj+NWqJIekUXgh6ySFKZLIG/ClBk1+gXQDfTzcrGwxL
        c5peEdtXwVoFz874y/qo/A==
X-Google-Smtp-Source: AGHT+IFCMFrZti8PpN/lFswF46l2wJq6Hul90zROrny7QB9J/yWMCYjnlFUfsW9EBVsNr0UEmHva6g==
X-Received: by 2002:a05:6871:a417:b0:1ea:2447:5181 with SMTP id vz23-20020a056871a41700b001ea24475181mr3714421oab.9.1700410336292;
        Sun, 19 Nov 2023 08:12:16 -0800 (PST)
Received: from herring.priv ([2607:fb90:45e3:889f:15b4:1348:6d64:224b])
        by smtp.gmail.com with ESMTPSA id w8-20020a9d6748000000b006d4760cc054sm895328otm.3.2023.11.19.08.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 08:12:12 -0800 (PST)
Received: (nullmailer pid 276534 invoked by uid 1000);
        Sun, 19 Nov 2023 16:12:08 -0000
Date:   Sun, 19 Nov 2023 10:12:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Wronek <davidwronek@gmail.com>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Joe Mason <buddyjojo06@outlook.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        hexdump0815@googlemail.com, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v2 3/8] dt-bindings: phy: Add QMP UFS PHY compatible for
 SC7180
Message-ID: <170041032722.276472.12995165912744202570.robh@kernel.org>
References: <20231117201720.298422-1-davidwronek@gmail.com>
 <20231117201720.298422-4-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117201720.298422-4-davidwronek@gmail.com>
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


On Fri, 17 Nov 2023 21:08:35 +0100, David Wronek wrote:
> Document the QMP UFS PHY compatible for SC7180
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

