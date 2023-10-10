Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6347BFEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjJJOPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjJJOPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:15:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38992C6;
        Tue, 10 Oct 2023 07:15:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405361bb94eso58351385e9.0;
        Tue, 10 Oct 2023 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696947329; x=1697552129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P5isVXg9lzMhXFoyFy+8mWJrz6qew5JiLkShGec5vJc=;
        b=cIEB9tM7A4qeWisgatdUalKC57G+HJia/jQQs9bhWRFdEPC8JaO7/VXOBsIt2zl1fh
         N1CW9ddHAsn4SZvJ+qiI5+sU6+fo4mP5h9fINXWHV4CrSHjORfUq0ZhaQBGCnqQJVC6L
         jaJEviP8GxJwsuSVC/Pp+rtXwlohHz589GnymyextdYPruoMsO00/VQVN/+wRMOJia/u
         LPcNVZtyOCZ+Z2iTHCBO/xWMf/LygLrkT7UtTKYn0RuctlOe3WpEzxLpKjLHVfzMGqoS
         D9aLhGkB/J9ct/DgFUez/fsSxqLYzRI47hoqdO17qjbbYKdLCkKO3pqrTig+ARlXCj3t
         Bujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696947329; x=1697552129;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5isVXg9lzMhXFoyFy+8mWJrz6qew5JiLkShGec5vJc=;
        b=uY0zEYxBeMcylVIz3tF0pBpF+0XAj42pTLAvzcB/RgMlpQTDKJJepyO75RkCCyWV45
         0UY32qVu4cIUbeMZfOTTfcEepBsErdvZjbvYAuw8Vm1tSM04r5mD3hUKImTFvp013uOo
         K79lu+MBpUjJzsgT80ePtXSldTwrf2BbFBxYX+HLrSHOcmmZTvRkOeFVSjt5f53lDU5D
         nH6HND//rBSOU6f/ADUoKyFOrDsruHcGBzA/1HJAg1R5vgmss4kHQqRqXKKLr7a8slnE
         a+nZ3C0zmKQR1kINc/hY6iZL7WXNrpDLkyxHoVT1D0Vi+MbQZGtTX/o0qZHNKcRG3PY0
         /9Xg==
X-Gm-Message-State: AOJu0YzO0aQqfnr/yGS3CX06wHvbYU5iqdrRFbrLXQ1cr8EmQEnk+DAd
        GJOysrQ2mEL2d8HGqgCIkJjLVHx+XvxX/g==
X-Google-Smtp-Source: AGHT+IElqAelb44dzmendgb/GJEYBDTka4QOYwofMc9QMo4cJicO++fSzWjTQOs3hVBxf4rU5sELXA==
X-Received: by 2002:a05:600c:296:b0:405:3d04:5f4c with SMTP id 22-20020a05600c029600b004053d045f4cmr16774846wmk.38.1696947329504;
        Tue, 10 Oct 2023 07:15:29 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id hn8-20020a05600ca38800b00405959bbf4fsm14231905wmb.19.2023.10.10.07.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:15:29 -0700 (PDT)
Message-ID: <65255c81.050a0220.141f8.7b8f@mx.google.com>
X-Google-Original-Message-ID: <ZSVcf8gprpILpc5l@Ansuel-xps.>
Date:   Tue, 10 Oct 2023 16:15:27 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 4/4] ARM: dts: qcom: ipq8064: Add CPU OPP table
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-4-robimarko@gmail.com>
 <e255dcbd-6342-49e6-9bfe-17a47b2a3c8a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e255dcbd-6342-49e6-9bfe-17a47b2a3c8a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:40:32PM +0200, Konrad Dybcio wrote:
> 
> 
> On 9/30/23 12:21, Robert Marko wrote:
> > From: Christian Marangi <ansuelsmth@gmail.com>
> > 
> > Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
> > Use opp-supported-hw binding to correctly enable and disable the
> > frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
> > 1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
> > 1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> Christian/Robert, can you provide a downstream source for this?
> 

Sure, consider that everything is with +/-5%.

Qsdk ships with these values but I will link a more secure source that
is from a very old qsdk source where march-msm was still used instead of
dt.

Here the source [1]. Confirmed by internal verification and also other
qsdk. At first view you might be scared by confusion but...

- _lite = ipq8062
- nothing = ipq8064
- tn_3 = ipq8065

and the psv are both in number and slow, nominal, fast and faster and
they all reflect efuse values.

There is on the left frequency and on the right voltage.

[1] https://github.com/Getnear/R7800/blob/master/git_home/linux.git/sourcecode/arch/arm/mach-msm/acpuclock-ipq806x.c

-- 
	Ansuel
