Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34CB7E2785
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjKFOsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjKFOsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:48:36 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C41AB6;
        Mon,  6 Nov 2023 06:48:34 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ce2add34c9so2670860a34.1;
        Mon, 06 Nov 2023 06:48:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699282113; x=1699886913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXUwQRgKYin84qt/NzMuWPYKQwAgJAzQ8CP9C3QMnWk=;
        b=vvnLp1dgP1f73NpMVittH9GfaRp+k6pV7teZGfkB+9VCSjyhmF7LTLphqMlsP4WIz0
         pIGru6LsYhcmVCxFqctIavqEdc1VbLUrIH2CmlNdYtKiN90JjaBDiJ2lVOnomH54dvGM
         6YB2WiDKOUFnKtv8RYJUy6bVlA4/3TwhLrBPj7FkznUtS4PRCJwEPpeeTMiGtoopADSW
         onTgd+J0l8FI0yV72y6Nz3pc2xhEUS6bZYySM0asJvRBn+kEBmN4ULqn1AKDqyCN/hEE
         QqNVvMai6ZzCSwl46vIKMvHgLPez2Rgrfb5dNscD4M+6VOzkBuOW1XThSiB+zGWvXzUM
         wddQ==
X-Gm-Message-State: AOJu0YyXxMfEdwjf2a3k4pucVLBMtbEurlkBjvlPwic0rCua6f4RXqhY
        O42p+zQ9+5zsNbSdo6Cyiw==
X-Google-Smtp-Source: AGHT+IEUkOSozraK2toTye88mFjUT63PkKYjXw5R8snconc3gVvDkuHgI4cJmHvVc/G6yXILft5QbQ==
X-Received: by 2002:a05:6870:af4a:b0:1ea:7f54:77af with SMTP id uy10-20020a056870af4a00b001ea7f5477afmr31023062oab.10.1699282113677;
        Mon, 06 Nov 2023 06:48:33 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m2-20020a9d7e82000000b006d32010d5a9sm1272976otp.71.2023.11.06.06.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 06:48:33 -0800 (PST)
Received: (nullmailer pid 321808 invoked by uid 1000);
        Mon, 06 Nov 2023 14:48:31 -0000
Date:   Mon, 6 Nov 2023 08:48:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ziqi Chen <quic_ziqichen@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com,
        linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: ufs: Add msi-parent for UFS MCQ
Message-ID: <20231106144831.GA317907-robh@kernel.org>
References: <1698835699-28550-1-git-send-email-quic_ziqichen@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698835699-28550-1-git-send-email-quic_ziqichen@quicinc.com>
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

On Wed, Nov 01, 2023 at 06:48:13PM +0800, Ziqi Chen wrote:
> The Message Signaled Interrupts (MSI) has been introduced
> to UFS driver since the MCQ be enabled.

Not really relevant when a driver supported MSI, but the when the h/w 
did. Has UFS always supported MSI? It was added in some version of the 
spec?

> Hence in UFS DT
> node we need to give the msi-parent property that point
> to the hardware entity which serves as the MSI controller
> for this UFS controller.
> 
> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-common.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> index bbaee4f5..42309bb 100644
> --- a/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> +++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> @@ -73,6 +73,8 @@ properties:
>      description:
>        Specifies max. load that can be drawn from VCCQ2 supply.
>  
> +  msi-parent: true
> +
>  dependencies:
>    freq-table-hz: [ clocks ]
>  
> -- 
> 2.7.4
> 
