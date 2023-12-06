Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46D8070D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378515AbjLFN00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378478AbjLFN0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:26:22 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3919ED71;
        Wed,  6 Dec 2023 05:26:28 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9bd3ec4f6so87403431fa.2;
        Wed, 06 Dec 2023 05:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701869186; x=1702473986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3sIhfDT+5Uo8u+SaAKl1HY/QwZqblPvSAxqf2hisKU=;
        b=auPhkiNwekoxhVOKKoTLOrNop7pv/Ql2DKUTAdtfh6/9kLm4e5WcAhCyB0BLWF/82L
         ay0KBppwEjDoTDAWI90Ai2zg4OlXtDy9eg0sUKDkUOxer3m1vD2ybwns3TjhcODafLKs
         WvrXJ6oIj2M0ns1CGrc7L2MdmHIsfKJdHwveHrXC1451IeWew1NVvr3GMIsK+NeKpTCW
         TE229E78sXlrL4G0ya7T0oELB1+vWlGd9qjaRBu6sDnyVuFtOm89IQ1jQV0QwEbnirDw
         MUI2KLPvhcz0d4M+1B2bSlZIraPcy7nW3+vWpiXdsK5rZvKsPZGAKRyjJKqZE/854aTc
         HSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701869186; x=1702473986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3sIhfDT+5Uo8u+SaAKl1HY/QwZqblPvSAxqf2hisKU=;
        b=uAGk3l4gBowbv0WijKdq08TCgUXIxz1PWf22tH8zWfy/nNWxKWx8vyd2omxwQR8vla
         DLmVWnccZj/++sdzI78rAd/OQ0TIRimugYFLH4O7rsuv8+03js6BfDxs40q1lAQ8JmHb
         GxxGGBbkL5VO0oUz1Cmxy5KVViJQdw/YH3JUfKR43EMus7oiCN7iBmPTAPUR/y+/rgd0
         hEGhc1xLBy/Mc29By+oQ3NYFy6unHT6Kv2sF9jNgRb5hDkFkAhc/bth7cTqhezO90Pg5
         GgJojkweI5hIAu4KFWl/DiYHoRRNGg7QQSUV3PMtVbBtjNcT2ue/O51JEYeHYYODV88r
         BY/w==
X-Gm-Message-State: AOJu0Yx2e9wxzf/MLASBQvkBsJCqhnFni0cYaWR6GizeGp3NlZDbH2Ic
        o9xwdx2olxLzqiT4djr+LmA=
X-Google-Smtp-Source: AGHT+IF/3/O+lRxfcjlZj5S9IZLV6IYSTw6CFIYRNs7/vndFIUU1NMf+Vz+sn9MCrJ6O7QF/vkBl0g==
X-Received: by 2002:a2e:2c11:0:b0:2c9:d773:894b with SMTP id s17-20020a2e2c11000000b002c9d773894bmr358870ljs.30.1701869185872;
        Wed, 06 Dec 2023 05:26:25 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q186-20020a2e2ac3000000b002ca03b29031sm972751ljq.72.2023.12.06.05.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:26:25 -0800 (PST)
Date:   Wed, 6 Dec 2023 16:26:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Prasad Sodagudi <psodagud@quicinc.com>, kernel@quicinc.com
Subject: Re: [PATCH net-next v3 0/3] Ethernet DWMAC5 fault IRQ support
Message-ID: <eudnbxyuf5yl2cuoyx6527l47amdwzlejwpwtyrpkyvbb4s6ng@lgpoqzr4rltt>
References: <cover.1701695218.git.quic_jsuraj@quicinc.com>
 <rw5vfdvre5rt4rwytfsp3qy6sgsdr3dm6oefr4sap2aqbvpw42@c2dxz42tucby>
 <zzkw5obc3z5fndowmrycy77gtjf6wscvkj7klnn34f3ycs3her@hmh5aebpbi3s>
 <0a5f769e-a474-40c6-a886-135716e90dd2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a5f769e-a474-40c6-a886-135716e90dd2@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:18:07PM +0530, Suraj Jaiswal wrote:
> Hi @serge,
> there is some more DT_CHECKER warning & need to fix that before uploading the new patch .
> Will fix the warning & then will update the version ,
> 
> Thanks
> Suraj

Ok. Thanks.

-Serge(y)

> 
> On 12/5/2023 3:35 PM, Serge Semin wrote:
> > Hi Suraj
> > 
> > On Mon, Dec 04, 2023 at 02:16:12PM -0600, Andrew Halaney wrote:
> >> On Mon, Dec 04, 2023 at 06:56:14PM +0530, Suraj Jaiswal wrote:
> >>> Add support to listen Ethernet HW safery IRQ. The safety IRQ will be
> >>
> >> s/safery/safety/
> >>
> >>> triggered for ECC, DPP, FSM error.
> >>>
> >>> Changes since v3:
> >>
> >> This is listed as v3 in the subject, but it should now be v4 since the
> >> last version was v3.
> > 
> > There are several style-type problems I would like to share. But as
> > Andrew correctly noted the series version was incorrectly left
> > unchanged. Please resubmit the series with the version incremented.
> > I'll send my comments to that new thread so the discussion history and
> > the lore archive would look cleaner. Thanks.
> > 
> > -Serge(y)
> > 
> >>
> >>> - Fix DT_CHECKER warning
> >>> - use name safety for the IRQ.
> >>>  
> >>>
> >>> Suraj Jaiswal (3):
> >>>   dt-bindings: net: qcom,ethqos: add binding doc for safety IRQ for
> >>>     sa8775p
> >>>   arm64: dts: qcom: sa8775p: enable safety IRQ
> >>>   net: stmmac: Add driver support for DWMAC5 safety IRQ Support
> >>>
> >>>  .../devicetree/bindings/net/qcom,ethqos.yaml   |  9 ++++++---
> >>>  .../devicetree/bindings/net/snps,dwmac.yaml    |  5 +++--
> >>>  arch/arm64/boot/dts/qcom/sa8775p.dtsi          | 10 ++++++----
> >>>  drivers/net/ethernet/stmicro/stmmac/common.h   |  1 +
> >>>  drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
> >>>  .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++++++
> >>>  .../ethernet/stmicro/stmmac/stmmac_platform.c  |  9 +++++++++
> >>>  7 files changed, 45 insertions(+), 9 deletions(-)
> >>>
> >>> -- 
> >>> 2.25.1
> >>>
> >>
> >>
