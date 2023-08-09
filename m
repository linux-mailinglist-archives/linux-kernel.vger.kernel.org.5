Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E3A776A83
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjHIUrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjHIUrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67D618E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691614007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=85iBUVX8eS0NmdKzdH/Axj5AnNYS26psyU6bLHIwJdo=;
        b=XLra2P8QellNuOJ3MH4x2QIUfUkT3FihSfqci6NmXvqWYyGEcv8e3Cz+M93ygecKO6+aY0
        5khbiHaOpLmOLJ5riL6iAaG+0vkyt0ECBb4vkoJ3H2+xVDiG+uE6aTS0jxWGnDQWQCxh+w
        js2vIW3MnO8WikbXWErofjjScQc9B1E=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-EKscTOp9NzWYpOOAyNRQ7Q-1; Wed, 09 Aug 2023 16:46:45 -0400
X-MC-Unique: EKscTOp9NzWYpOOAyNRQ7Q-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1bb691357d8so201705fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 13:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691614004; x=1692218804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85iBUVX8eS0NmdKzdH/Axj5AnNYS26psyU6bLHIwJdo=;
        b=Jhj/rorg4BN4kbsot1z9aRBdq/2PwaFciHzVXNtHkv+u5y9bzxcnyVO3GdTuTVvG9K
         1wgOzQl9VAakvlgA44p9njcbIxi3sR+JuKE+qzCdJuDV2tPwIvDkXO8eoUJ6gTjt0A/q
         rYOnBIjxZA+rE5mBnuFSnYxMeKJWYf0DpI2/g0uv0/+mavDxT7r3JVNyuklnz70V2AJu
         U94sCzUYNblR+GK3bZnROWkJPd7RMylFauuh1MohpVwVPIf9aFE4NFw+3ctLFk4ik/Oi
         5z9RMD7pjrge6Nk7J8Dy8THLHnC/G1JSyRa8rnnEJ3ZZnV/EyKVzm9YUvvZIEOxf8MSS
         fsew==
X-Gm-Message-State: AOJu0YyZicFnR6KhTePgqpO35wxiBJwLNDKF9btg6HeA5/H6bYAE69Jn
        5cswyCaUDaYTuodSLnw+u/XOQePP/8l3ye29QI9JaG9n18203NDck7EHH8cIDT26kMq8QUcA2tE
        ixjxAMc1QoAycFzS1K1JQw/Zu
X-Received: by 2002:a05:6870:5582:b0:1bf:d05f:f77 with SMTP id n2-20020a056870558200b001bfd05f0f77mr409989oao.48.1691614004597;
        Wed, 09 Aug 2023 13:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTQI8VRZ5ZtLNFhgexiawYP5A6CmaRJ60ckOfjRSba4+LVLgx2G+xZX97LXEEFCJ6PqJ2IWA==
X-Received: by 2002:a05:6870:5582:b0:1bf:d05f:f77 with SMTP id n2-20020a056870558200b001bfd05f0f77mr409962oao.48.1691614004283;
        Wed, 09 Aug 2023 13:46:44 -0700 (PDT)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id d8-20020a0ce448000000b0063d26033b74sm4733922qvm.39.2023.08.09.13.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:46:43 -0700 (PDT)
Date:   Wed, 9 Aug 2023 16:46:43 -0400
From:   Eric Chanudet <echanude@redhat.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8540p-ride: enable rtc
Message-ID: <xraquthrzcadd7aucxym4e4x72barlq6dbmbsbxcn7pbr2yehv@amyzztu3xmcg>
References: <20230718145105.3464105-1-echanude@redhat.com>
 <dtussvqzf7x5p633pxt3julkffhzt5rxwp3aghs4ocj5odq4la@ed6jhcv76hbk>
 <20230808213646.GK1428172@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808213646.GK1428172@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 02:36:46PM -0700, Bjorn Andersson wrote:
> On Fri, Jul 21, 2023 at 08:59:30PM -0700, Bjorn Andersson wrote:
> > On Tue, Jul 18, 2023 at 10:46:10AM -0400, Eric Chanudet wrote:
> > > diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> > [..]
> > > +&pmm8540a_sdam_7 {
> > > +	status = "okay";
> > > +
> > > +	rtc_offset: rtc-offset@ac {
> > > +		reg = <0xac 0x4>;
> > 
> > I'm still trying to get confirmation that this is a good choice.
> > 
> 
> I'm recommended that you use 0xa0 from SDAM2, "preferably in the second
> PMM8540", instead.
> 
> Can you please give this a try, Eric?

That worked, the offset was saved and read back upon rebooting from the
system. I did get a defer on some tests waiting for the second pmic,
which I presume is not surprising:
[    0.257064] spmi spmi-0: PMIC arbiter version v5 (0x50020000)
[    8.340386] platform c440000.spmi:pmic@0:rtc@6000: error -EPROBE_DEFER: wait for supplier /soc@0/spmi@c440000/pmic@4/nvram@b110/rtc-offset@a0
[    8.393201] platform c440000.spmi:pmic@0:rtc@6000: error -EPROBE_DEFER: wait for supplier /soc@0/spmi@c440000/pmic@4/nvram@b110/rtc-offset@a0
[    8.465407] rtc-pm8xxx c440000.spmi:pmic@0:rtc@6000: registered as rtc0
[    8.479612] rtc-pm8xxx c440000.spmi:pmic@0:rtc@6000: setting system clock to 2023-08-09T19:16:08 UTC (1691608568)

Here is the v3 with the changes:
    https://lore.kernel.org/linux-arm-msm/20230809203506.1833205-1-echanude@redhat.com

Thank you again for the feedback.

-- 
Eric Chanudet

