Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2897379FDEB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbjINIKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbjINIKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:10:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200001BE6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:10:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-404314388ceso4509505e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694679039; x=1695283839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jjz+NUe5hgs2hIHHXxH6w/00yPGwJQXYEzuFex6noc0=;
        b=b14A8v2tIkMxCndyUJTBBgwmgZz+bAcWL6peuOZvQjrdSAI8VYWfJsnUYV0bd/+mBd
         qS8CpmHcmkzSSUO/MuUM2ewfn5EZwS0gVxhPvbuZMOKmvuJRCDVl5rUT4xNCI31tlpnI
         6t8aYxOvjejoC11GOniEiLBLQeND53GUAaXJEBpwsJE//rwDlqwZgsXHZ7+Gg6jUdJ+r
         utacaLfh+1upIAyG3SF1++zrs3f9dFaqeVHw/pRnBjYwNDjVI3PwPBDDCmHS/5u4obL6
         +hAeS7aoV70UEbRQlqG40Jl3TTifsLp7A2+Fb7F7zPAFEm4VKO1tDbkd7wPj9B14IGSD
         npjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694679039; x=1695283839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jjz+NUe5hgs2hIHHXxH6w/00yPGwJQXYEzuFex6noc0=;
        b=U7mU6wfG7i7BkEocS4h6VLpSkQPv2O2+qSC+ZLSOB9MgBN5qU9v21r/IJoIP0aXIs7
         X5bQroERPKbOf7vb8xatJ72wa89mZGCWpNrp3eITKgUNAHKk0++JuGR+aH2/vtNfcH8h
         G8qml2lfttmeFRiznfXJ6WiV3O7iLsgp53kTMYNs4Av7gGfejlv40QFNsKgP628jPToA
         gZFG3muBBq/2ySjntbd6P0VjuYHzmYudfN2lO9imCwYHiV+laUAJMaY7I/No+/ed2WMF
         jkug07hUpLUjPZPG9Ocde2D6JEBuqjluj8T+1wu6c/nKbdxjW9vwOZdh+/5mlBtSdpHG
         9XWw==
X-Gm-Message-State: AOJu0YzQ1EQ7JyH5OZKO6WIfD/CD3C2EwEcsR7Z2M1Gv4cC3MvN5njqg
        /oxRmFUOAMEKLUTHNayLuDwpZw==
X-Google-Smtp-Source: AGHT+IE2bWZZmlPTiRjEI+ekUEDONcxec7lp5Jn5BWw+Jld3Ytewru9YGgQRWN15rYA/XM5ICyPfhg==
X-Received: by 2002:a1c:f717:0:b0:401:bf87:989c with SMTP id v23-20020a1cf717000000b00401bf87989cmr3984627wmh.34.1694679039623;
        Thu, 14 Sep 2023 01:10:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0ac400b004030c778396sm4152155wmr.4.2023.09.14.01.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 01:10:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mateusz Majewski <m.majewski2@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] ARM: dts: exynos: enable polling in Exynos 4210
Date:   Thu, 14 Sep 2023 10:10:31 +0200
Message-Id: <169467902473.16247.10096195941299515281.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911133417.14042-1-m.majewski2@samsung.com>
References: <CGME20230911133431eucas1p2631e7060cecb0914933ed45b837cf8eb@eucas1p2.samsung.com> <20230911133417.14042-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Sep 2023 15:34:14 +0200, Mateusz Majewski wrote:
> It seems that thermal in Exynos 4210 is broken without this, as it will
> never decrease cooling after increasing it.
> 
> 

Applied, thanks!

[1/1] ARM: dts: exynos: enable polling in Exynos 4210
      https://git.kernel.org/krzk/linux/c/ef399736c3ba77fb82d778b1b7285baa65a7e079

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
