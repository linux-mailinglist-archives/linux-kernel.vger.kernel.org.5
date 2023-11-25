Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13517F87C3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 03:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjKYCWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 21:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjKYCWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 21:22:14 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D073B1990;
        Fri, 24 Nov 2023 18:22:19 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so1737301b3a.1;
        Fri, 24 Nov 2023 18:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700878939; x=1701483739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6Q4Y5ag6mftLRcpA4lmiIuMEEPG5geq0zF11PaWQAk=;
        b=kCVqAdFIdyJgcpCu+YYbJu/KkUmNhUcqlOzpJd5TtpQirZJPDzOhEgKbjggsIgu/Ek
         vjeE+IrA5CkCfj6rvcjLnvKII95jZQEcxiNytxpALK6rWiPAATJqUL0z7SDzG0zUXUsz
         yg1K0+69+733DGac2f8lQ+3UsGULk2/mnS0rEIyXFYbq8ZRrvvCWtH3AkfFrrW4mVuKm
         VuB5vSPP49N6OGQn8rMzC0qLGvZASKSIS4sQOOL9Y0Wg8kUkGJUwKyFXFBZ2e/y/eguw
         jj8bD3a/yYJZbG4/TKItVGqH0axu/4zLbd+tjhDZ+4pCFPbnTg8CCVMbjbaww4B1QVNg
         s3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700878939; x=1701483739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6Q4Y5ag6mftLRcpA4lmiIuMEEPG5geq0zF11PaWQAk=;
        b=LT+D9S42VftD+ZUIzz8vIrJyLSlrd+t6IFRtrmxlRv6LYFwGj3oQAVj9jBvy9GTe9K
         AdYwIGmEkSgVdAFQ17Y5MTMnRT5snKpBBJ3TTXMiHjPt93htNj439qLFjja46zsXgzZd
         FbxQLfQRoVEAXZuV4fJe1p/ownVTeD0ITEMrFrASTrRmLBX70X/IpAkMKgxKutRBQyCM
         1rbeSMa6CMI/j3X2afakr054727uhg9wnaYxq0Devvygl7j7WrhXat97SDoyAKyELepN
         l/MKO1D7NaOuGAkr1k1v/JHaLcj+1r1RKTzFdPykSg2P590Mo1ju4AVmBn601xLep56P
         Dp7w==
X-Gm-Message-State: AOJu0YwHId2OmpeefL9XBJMbYttr73u59UCjDQw1TTloeEDUoJ0+aovR
        zeMLp+uoOKeLG7LdkHShvDo=
X-Google-Smtp-Source: AGHT+IFw3AHG628m5HywZLxtNMTjqHWbU8fcdFIOECJm/eKO6oDt8sg1CVps2oc0Zl/kTYivurKFFQ==
X-Received: by 2002:a05:6a20:a11d:b0:18a:da90:68ec with SMTP id q29-20020a056a20a11d00b0018ada9068ecmr6094966pzk.2.1700878939207;
        Fri, 24 Nov 2023 18:22:19 -0800 (PST)
Received: from Gentoo ([192.166.114.90])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7810c000000b006cac1688153sm3436852pfi.69.2023.11.24.18.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 18:22:18 -0800 (PST)
Date:   Sat, 25 Nov 2023 10:22:11 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8250-xiaomi-elish: Sort ufs node
Message-ID: <ZWFaUxn46ymXDZz4@Gentoo>
References: <20231124135713.5610-1-lujianhua000@gmail.com>
 <20231124135713.5610-2-lujianhua000@gmail.com>
 <4011c83f-6f3f-426b-9bfc-d0d8f6b01ac0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4011c83f-6f3f-426b-9bfc-d0d8f6b01ac0@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 04:54:20PM +0100, Krzysztof Kozlowski wrote:
> On 24/11/2023 14:57, Jianhua Lu wrote:
> > ufs node isn't in a right place, 'f' is front of 's', so move it to
> > above usb node.
> 
> Please not.
> 
> If we change the order to match DTSI, then this patch would be wrong.
> 
Acked. I will drop this patch.
> Best regards,
> Krzysztof
> 
