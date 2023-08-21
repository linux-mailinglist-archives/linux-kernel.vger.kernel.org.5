Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA8F782FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbjHUR6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbjHUR6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:58:21 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5925110
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:58:19 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34c5fec2a95so8082895ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692640699; x=1693245499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VO7CqkZaWBLiIGdh7lLoGYUME5rEgXf0vHV0ET/DQ4I=;
        b=J/nJI76KbZl0ewpd6a4QQocNI0MU8TuWe+tGp3TWHfSOKSEshF2YysO76h2QcsD5Sa
         1AAmZCC0SU+278oKJ4TUpB92w3o4rcFkH+OCm2jqJPyFX3mawJlo5FlfkEurUJpGisYw
         fnhsvHsXFvIB6HNtTsFLDitPJgI2RcGGLmo/GGOWAEY7bOOx3l8Tllgc4YDwe17hH/j/
         io69ZHNlUblXDv7L2T2Yho15jVX70fQhnMRShKubXqCLSWEDPCYb8HQYH/RsBQ2+0DMS
         lIMJ41nLTECxSBGGTnXGrvSAZashNBgeN4u/LQDngOQdC7TB0gapo0v/ZJacVIKDrMvL
         1VYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692640699; x=1693245499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VO7CqkZaWBLiIGdh7lLoGYUME5rEgXf0vHV0ET/DQ4I=;
        b=AU8b7Ddzt33HVIzUs8N88JaAVQSZHfuoLWwG/EBye6i9I8h9nuBykcc+hYyFM2evkF
         gT6hOgizGX2w9+neA9z8Ub+8AFe5YHW/3tEaesMn9sPwqIo63KR8j7yGXWuNUSw7BWLe
         Pj3WXvBGTQAsOfjfnEIQ3EItpw/u88YDGcAaBHshh9ihVOsGhH7ep9KGw+fchTqjc7iz
         UYacKdZtRpaGtvdJWfNpjZtJfuNSbyvoxdU3f29Jzc5H0vii9Z2tO/nElBrOKwTToey6
         zNS0yMDPN77LJ++APEbAr022BPjVKncITlzu66TT/+qrE27fvj4ELfPRDpVESnZwYhQi
         tT0w==
X-Gm-Message-State: AOJu0YyC8tKoV01ITtYnt9nfBJwk2IJCIBoEQRTQasDPfKMxHoiLcACy
        0FFOo01fvk19kqqp0r4Q7YUIKA==
X-Google-Smtp-Source: AGHT+IGkHyZEbiS6/affVkgXWOrYtnRRrvDxQUudZYT2rii37KNbUnKBbkjrtnncM2NUD7PhgR7rGA==
X-Received: by 2002:a92:c5d3:0:b0:349:2cd0:4368 with SMTP id s19-20020a92c5d3000000b003492cd04368mr7726845ilt.18.1692640699077;
        Mon, 21 Aug 2023 10:58:19 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2289:93a7:5faa:cd11])
        by smtp.gmail.com with ESMTPSA id v10-20020a63ac0a000000b0055b61cd99a1sm6557997pge.81.2023.08.21.10.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 10:58:18 -0700 (PDT)
Date:   Mon, 21 Aug 2023 11:58:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc:     Rob Herring <robh@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v3] dt-bindings: remoteproc: add Tightly Coupled Memory
 (TCM) bindings
Message-ID: <ZOOltyWikpxc/hII@p14s>
References: <1689964908-22371-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20230724161632.GA3686365-robh@kernel.org>
 <MN0PR12MB5953E72D7950581A8FB5AD82B711A@MN0PR12MB5953.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB5953E72D7950581A8FB5AD82B711A@MN0PR12MB5953.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 12:57:39PM +0000, Pandey, Radhey Shyam wrote:
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Monday, July 24, 2023 9:47 PM
> > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> > Cc: andersson@kernel.org; mathieu.poirier@linaro.org;
> > krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; Simek, Michal
> > <michal.simek@amd.com>; Levinsky, Ben <ben.levinsky@amd.com>; Shah,
> > Tanmay <tanmay.shah@amd.com>; linux-remoteproc@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> > Subject: Re: [PATCH v3] dt-bindings: remoteproc: add Tightly Coupled
> > Memory (TCM) bindings
> > 
> > On Sat, Jul 22, 2023 at 12:11:48AM +0530, Radhey Shyam Pandey wrote:
> > > Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> > > UltraScale+ platform. It will help in defining TCM in device-tree
> > > and make it's access platform agnostic and data-driven.
> > 
> > From the subject, it sounds like this is a binding for all of remoteproc for
> > TCMs.
> > 
> > Otherwise,
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> Thanks for the review. Just checking if this patch will be taken through
> devicetree or remoteproc tree?


Please send the driver changes and I'll pickup everything at once.

Thanks,
Mathieu
