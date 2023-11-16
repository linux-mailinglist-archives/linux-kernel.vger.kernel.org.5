Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349B37EE788
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345509AbjKPTdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345396AbjKPTdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:33:40 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F40F1A8;
        Thu, 16 Nov 2023 11:33:37 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1f0f94a08a0so630692fac.2;
        Thu, 16 Nov 2023 11:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163216; x=1700768016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkmGaGx6joEa6J0Jj96iNjaP76PYzEK6iIhkmIlAEro=;
        b=fLk/yXsChX/HrZryoIckiAY92ykrFQ9IMeMeH19pJAvl85/uzi5kH9fpwY+B35upub
         QMRQ6W/sutICfDRg/4zvGJmQFQ8iEmWD5l9r6qdYgDUhsZqey9FNpBMBOXiTmQOVOsO/
         KYFae7hsLbS1/tuiqt8Cr+UJ+y5V2hJMGrDKa36ORO7wmxqbhFfYReuiwL4gLzRLdpyx
         2y/mcdEuzcc91Lwfu4LEVow5ujJa8zNNdcdW6vwaa821rUo1tzDA/b763j8ir0WXFw9L
         X2HmnN2JYkV5gpT4L68cAYiELThpy7sL/fShJqyMN/ZUkq26DbZ1gie+RguWQJeYZW/b
         CoNg==
X-Gm-Message-State: AOJu0YysvQq0Bg7O4cCpH6SvpWh9Rocoorsj5QQHsNm41uAWmd9sWHiI
        0e084SHmjtbABrDPdjB7/Q==
X-Google-Smtp-Source: AGHT+IEJ6KtcvmJnzRL/yu37jlc0/FgxicWC9xy4vOrZGNNUDi6XPpcFPtwVzTZTJb9me2KL0xpSjA==
X-Received: by 2002:a05:6870:a40e:b0:1ef:c07e:b54c with SMTP id m14-20020a056870a40e00b001efc07eb54cmr19331127oal.57.1700163216669;
        Thu, 16 Nov 2023 11:33:36 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k13-20020a05687022cd00b001dd5857e243sm3203oaf.14.2023.11.16.11.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:33:36 -0800 (PST)
Received: (nullmailer pid 3082890 invoked by uid 1000);
        Thu, 16 Nov 2023 19:33:29 -0000
Date:   Thu, 16 Nov 2023 13:33:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: clock: Convert keystone-gate.txt to
 YAML
Message-ID: <170016320918.3082828.13768134867496352248.robh@kernel.org>
References: <20231114212911.429951-1-afd@ti.com>
 <20231114212911.429951-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114212911.429951-2-afd@ti.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Nov 2023 15:29:09 -0600, Andrew Davis wrote:
> Convert keystone-gate.txt to ti,keystone,psc-clock.yaml.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
> 
> Changes for v2:
>  - Fix dt_binding_check warning
> 
>  .../bindings/clock/keystone-gate.txt          | 29 ---------
>  .../bindings/clock/ti,keystone,psc-clock.yaml | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/keystone-gate.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,keystone,psc-clock.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

