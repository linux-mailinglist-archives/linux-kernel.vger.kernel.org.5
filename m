Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7C87C8C32
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjJMRSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMRS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:18:29 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D86695;
        Fri, 13 Oct 2023 10:18:27 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57b8a0f320dso1235750eaf.1;
        Fri, 13 Oct 2023 10:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697217507; x=1697822307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgAKqPHYQN2+v/UdYgMUVpm2fAWRPSdaV+0AqLJ7UuA=;
        b=K7mHn75WkVl2JyO3Yo2Tuj2KXNmw6wBh3kkmACUaFr5vtOc7hkFKm6YKG6VQwrAs+6
         GZ5+SStoOPnRMz+r13I9r+R5oS7RSadOcXpaewuCSZGAX3tkONc6HbiyLoLbNQ2op8Mo
         m9QeoHG+tgQVPnBtCMSv8+aECVpxfZh/2irrIZc6Ly+ITLZoh2fBPdevAimRy8P9I3EJ
         ECIjgPcXmBUU2egnw+gtpR2CL+P58/w7ToP+ycgabJNoJgYNNSqGUajh5MA5wZQTtbs3
         4sY4XwhBDDsajQ2kz8DUjjEVz6K4evzEXhoOBPBVDj9zq9xeJ0uGGY6zcPC+NyExKlAf
         urLA==
X-Gm-Message-State: AOJu0YxaIcN2WztLG+tVPWTPD0LMiWK3xZw7lmYLipXnrMs3oZ0x1Jqa
        LndQhKYwUkqEWYPvq1W9ow==
X-Google-Smtp-Source: AGHT+IGgt77eqQ08RYINJdoQGQ5E2EeTIExfXtozEo1oCbj5TOG4WrjCU1pNmGTmUpyOFD8bEent+w==
X-Received: by 2002:a4a:e3cc:0:b0:581:4148:d4e2 with SMTP id m12-20020a4ae3cc000000b005814148d4e2mr12077717oov.1.1697217506825;
        Fri, 13 Oct 2023 10:18:26 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q9-20020a4aac49000000b0057e7c1118b9sm3024483oon.31.2023.10.13.10.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:18:23 -0700 (PDT)
Received: (nullmailer pid 38315 invoked by uid 1000);
        Fri, 13 Oct 2023 17:18:22 -0000
Date:   Fri, 13 Oct 2023 12:18:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kris Chaplin <kris.chaplin@amd.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        thomas.delev@amd.com, michal.simek@amd.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
Subject: Re: [PATCH 1/2] dt-bindings: w1: Add YAML DT Schema for AMD w1
 master and MAINTAINERS entry
Message-ID: <20231013171822.GA4177785-robh@kernel.org>
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231013093109.37165-2-kris.chaplin@amd.com>
 <f864dd17-7848-4a83-bd8b-2093d11a153a@linaro.org>
 <20231013-january-caliber-2e7acbee15ec@spud>
 <c58fbddb-cda1-e0de-8ad9-e4701c2c73cb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c58fbddb-cda1-e0de-8ad9-e4701c2c73cb@amd.com>
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

On Fri, Oct 13, 2023 at 04:23:15PM +0100, Kris Chaplin wrote:
> 
> On 13/10/2023 16:07, Conor Dooley wrote:
> > On Fri, Oct 13, 2023 at 05:04:32PM +0200, Krzysztof Kozlowski wrote:
> > > 
> > > That's a quite generic compatible. axi is ARM term, 1-wire is the name
> > > of the bus and master is the role. Concatenating three common words does
> > > not create unique device name. Compatibles are supposed to be specific
> > > and this is really relaxed. Anything can be over AXI, everything in
> > > 1wire is 1wire and every master device is a master.
> > Given the vendor (and the title of the binding) this is almost certainly
> > an FPGA IP core, so the generic name is understandable. Using the exact
> > name of the IP in the AMD/Xilinx catalog probably is the best choice?
> 
> Indeed this is an Programmable Logic IP core - the official name of the core
> in our catalog is axi_1wire_master.  It is a soft HDL core.

Only 1 version of it (ever)? Like other PL IP, it needs a version number 
(and not v1, v2, etc. made up by you). Really, your versioning scheme 
should be documented (like 
bindings/sifive/sifive-blocks-ip-versioning.txt), but Xilinx started 
versioning stuff some time back.

Also, 'master' is not considered great terminology nowadays. Perhaps the 
catalog name should be updated. 

Rob
