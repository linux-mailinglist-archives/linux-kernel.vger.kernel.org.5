Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8B57E5ABE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjKHP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjKHP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:59:13 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09537172E;
        Wed,  8 Nov 2023 07:59:11 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d2fedd836fso4446913a34.1;
        Wed, 08 Nov 2023 07:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699459150; x=1700063950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SB2xZBeUHY9tW0Z5bPgemVNWFJ1fMH1n44RF7oFvdo=;
        b=kq9PZNd1flJY9AOGFu4dqU1wuabV2Zr30DlKi9Q0QokKP/eOQpIRyq08RD8usareN2
         w41Xj0y7bGJwXSwwj4OIA42Rg6FBhwNEJ4mocMCiIFjVtFy1/JvCZ+rtjjJqhlbW5cZw
         5o8WRvNV5VSnUx81hBSQwk29UiEB5MUFTMJoCOlQMen1yrbWLUXU/lSAQhfgJRnE+dSJ
         Ra8UZfzLoy9RphBrzY6R6/BEXg4WsUuclj8ysjNvfRJUIIWIzGPpx7N9UwmL+RRGQQkF
         JE9IVMxzkeUETK8s1mQwdnyWbkOUsFT/8JSh7omB4j6iI73yKEAI1bmCtq1uUTcs9kGJ
         SU5Q==
X-Gm-Message-State: AOJu0YyZnorpdI7hEk7/PrUXIGJ0nICUf7n4e7hkTCPzVI5WKvofTAoR
        o+7DEc7qY3pXbDwJRVgUhA==
X-Google-Smtp-Source: AGHT+IFPkHmc9Gut1oDzvsyGl3MaVkOIp9Cv5V7L2F3h+o/eVBBXPzNdpmWGSNoWy6Av9Z8q2d08ew==
X-Received: by 2002:a05:6830:1641:b0:6be:fc8b:40fc with SMTP id h1-20020a056830164100b006befc8b40fcmr2058226otr.36.1699459150302;
        Wed, 08 Nov 2023 07:59:10 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n14-20020a056820054e00b00581d57c908esm2421269ooj.36.2023.11.08.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:59:09 -0800 (PST)
Received: (nullmailer pid 2202207 invoked by uid 1000);
        Wed, 08 Nov 2023 15:59:05 -0000
Date:   Wed, 8 Nov 2023 09:59:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kris Chaplin <kris.chaplin@amd.com>
Cc:     thomas.delev@amd.com, michal.simek@amd.com,
        krzysztof.kozlowski@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: w1: Add YAML DT schema for AMD AXI
 w1 host and MAINTAINERS entry
Message-ID: <20231108155905.GA2198732-robh@kernel.org>
References: <20231107180814.615933-1-kris.chaplin@amd.com>
 <20231107180814.615933-2-kris.chaplin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107180814.615933-2-kris.chaplin@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 10:06:51AM -0800, Kris Chaplin wrote:
> Add YAML DT schema for the AMD AXI w1 host IP.

Sorry for not noticing earlier, but if there's another spin, drop 'YAML 
DT schema for ' from the subject. You already said that with 
'dt-bindings'.

Acked-by: Rob Herring <robh@kernel.org>

> 
> This hardware guarantees protocol timing for driving off-board devices such
> as thermal sensors, proms, etc using the 1wire protocol.  The IP has a register
> to detect hardware version and so the binding does not have an explict version
> number.
> 
> Add MAINTAINERS entry for DT schema.
> 
> Co-developed-by: Thomas Delev <thomas.delev@amd.com>
> Signed-off-by: Thomas Delev <thomas.delev@amd.com>
> Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/w1/amd,axi-1wire-host.yaml       | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
