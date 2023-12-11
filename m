Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755EB80C9DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbjLKMcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjLKMci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:32:38 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47319A1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:32:44 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ce72faf1e8so2545104b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702297964; x=1702902764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fPAVPWVAnFaXRPunJWiaKjsDd+rTNd09tI3XdhhqUCE=;
        b=usgg7FDHN+saXk9YACblrr5Eg+cZCNFOCqgTl1UrLTlEaWJNdfpYDXopBykztVo3JE
         GQnY2CJf6vj+Qco7cXVQ8NgiPbExjDYVKeywjJEGJlDROGoF4R5z0MDITdv8lnfcCkGm
         NKNMwGR7a31oKTaq1dg4ecQqLMtuk3MJRGE6bwYXpU8c7sEQC6xHliO4sDjps92J8UAd
         y1qJ1vWh17NzWodY4LFnaQ9xHQRlVKzreCYFaXQYJF3KIlbcG3b73QHecLmFOUTUS6Zk
         nS8ZJsioRtV9tOQv1mWNrpn23zxyneRqZYGYz9Xe8TFX2U4qm3ffrcJjNUf+TTDcrfp8
         W3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297964; x=1702902764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPAVPWVAnFaXRPunJWiaKjsDd+rTNd09tI3XdhhqUCE=;
        b=rS/LIzlPCUQavyPH6zQ/qjxE9QrJ6CjFZ9mjZZP/ArzagZVem+mW7Q9qGUPCsA4BmZ
         tQt80b7KOPI8w5XFpFF46K0cgVIa5cB02kXZ9/gn2IXsCwQrnDauMfwTSsceho4OAx0+
         0F71OJlcE4eBt+TGeEDQidlKEUmLsnDrMW8QMfpvDsQ4jSs5a6hHzYG4J37AtbekpGVw
         LQdR8x94EN32fac/C59Yy39a6+5xsGs+jH09P/vLxOHXUpSr6N/4XHa3bxrCzVJWBDQZ
         1FYhDy9GUL72R6Y7ilcEBqJ18rN2GUGA/yWP3x+xif21EJZzRSSEsIZTcJdQySRIxrtd
         P6Lg==
X-Gm-Message-State: AOJu0YxS49jwNFg2+Yd+ZG3Gri49e0xIKAyVLVy9T/W5PiZPuE1tkCa/
        DSS0LYxd7tu2JOpU5t7GVcsr
X-Google-Smtp-Source: AGHT+IGAj7mad8cH/r7AaL9JchtXkKhavxCYBULU5Feeu5CuqlFYGtjyc51OnSPI5ahkTCVMWMKpaQ==
X-Received: by 2002:a05:6a00:23c5:b0:6cb:a653:d927 with SMTP id g5-20020a056a0023c500b006cba653d927mr2166554pfc.3.1702297963665;
        Mon, 11 Dec 2023 04:32:43 -0800 (PST)
Received: from thinkpad ([117.207.26.193])
        by smtp.gmail.com with ESMTPSA id p1-20020a056a000a0100b006c06779e593sm6424692pfh.16.2023.12.11.04.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:32:43 -0800 (PST)
Date:   Mon, 11 Dec 2023 18:02:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_vpernami@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: qcom,qmp: Add PCIe
 qcom,refclk-always-on property
Message-ID: <20231211123232.GD2894@thinkpad>
References: <20231201111033.GL4009@thinkpad>
 <f844cd1e-7e4f-4836-bc9a-2e1ed13f064f@linaro.org>
 <20231201123054.GM4009@thinkpad>
 <3a7376aa-18a2-41cb-a4c9-680e735ce75b@linaro.org>
 <20231206131009.GD12802@thinkpad>
 <ZXGVjY9gYMD6-xFJ@hovoldconsulting.com>
 <20231207101252.GJ2932@thinkpad>
 <ZXHDCNosx8PCUzao@hovoldconsulting.com>
 <20231207132032.GL2932@thinkpad>
 <ZXHKcToXzTgoDCLW@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXHKcToXzTgoDCLW@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 02:36:49PM +0100, Johan Hovold wrote:
> On Thu, Dec 07, 2023 at 06:50:32PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Dec 07, 2023 at 02:05:12PM +0100, Johan Hovold wrote:
> > > On Thu, Dec 07, 2023 at 03:42:52PM +0530, Manivannan Sadhasivam wrote:
> > > > On Thu, Dec 07, 2023 at 10:51:09AM +0100, Johan Hovold wrote:
> 
> > > > > Shouldn't that be
> > > > > 
> > > > > 	qcom,broken-clkreq
> > > > > 
> > > > > since its the CLKREQ# signal used to request REFCLK that is broken, not
> > > > > the REFCLK itself?
> > > > > 
> > > > 
> > > > Darn... You are right. I got carried away by the initial property name. Thanks
> > > > for spotting!
> > > 
> > > Thinking some more on this after hitting send: It may still be wrong
> > > with a 'broken-clkreq' property in the PHY instead of in the controller
> > > (or endpoint).
> > > 
> > > Could there not be other ways to handle a broken clkreq signal so that
> > > this really should be a decision made by the OS, for example, to disable
> > > L1 substates and clock PM?
> > 
> > One has to weigh the power consumption between keeping refclk always on and
> > disabling L1SS. Chaitanya, can you measure power consumption in both cases?
> 
> Sure, my point was just that that's a policy decision and not something
> that should be encoded in the devicetree (as was initially proposed).
> 
> And that the right place for the renamed property is not necessarily in
> the PHY node either.
> 
> > > Simply leaving the refclk always on in the PHY seems like a bit of a
> > > hack and I'm not even sure that can be considered correct.
> > 
> > I wouldn't agree it is a hack, even though it may sound like one. The option to
> > keep refclk always on in the PHY is precisely there for usecase like this.
> 
> I just skimmed the spec so perhaps I'm missing something, but there's
> definitely wordings in there that explicitly says that L1 PM substates
> must not be enabling unless you have a functioning CLKREQ# signal.
> 

I checked 'PCI Express Base spec 4.0', and there is a wording in 'Section 5.5
L1 PM Substates':

For L1 PM ... each port must have a unique instance of the signal (CLKREQ#) and
the upstream and downstream port CLKREQ# signals must be connected.

So yes, we should not enable L1 PM substates in this case. And also it appears
to me that the property should be part of the controller node, since CLKREQ# is
handled by the controller instance.

- Mani

> Johan

-- 
மணிவண்ணன் சதாசிவம்
