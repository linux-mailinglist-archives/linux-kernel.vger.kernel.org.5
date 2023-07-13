Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB85F7517DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjGMFHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjGMFHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:07:32 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DBD2117
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:07:29 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3458a08310aso1050565ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689224849; x=1691816849;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ou+/AMUWC7joCVNmag6sw3RtGqRei5bDSw1wDuy1BkE=;
        b=qqy9rJG37MIbEnaPdNoC3ezqwvhnARn912lvK++1KDXpb2lb2qGTeGx/wjt7mMESb9
         VifeeoyM3YAe7/SZa4FNCtFqUvJXyoHZ4pClNiCdfQ8I8lgV7dUp8ILCI1Cv7Q03+yR4
         8FLB4lJNPjI4/NDWrTDzN+pkCvToKcyDdb2bYE69ACAjT7sqkEJ2cv9iCYhrl17DCMmq
         29shv7tj6RH+4+imBcKmCTtKAfFLnk5das/gtltoWgqnx4NNhzaXOmIkQQ2KlaBJ1+FK
         sozw9XItkdqq0ZzhPklN48rae8Z28E5PDBhi2/9WbrJlp9nm1hLVnTs4x0FYu/NpR+sS
         qVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689224849; x=1691816849;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ou+/AMUWC7joCVNmag6sw3RtGqRei5bDSw1wDuy1BkE=;
        b=LCCp2pM49Km3JeqZWyZIRMybPbGvS+90P/fEQuHBujJaDaWXmm7g1KvGvdlhdE89pi
         Z3y4EHN5txZGEPBX0a06hjplvzoUURcpv0YCiTMr6o8GsjJdhlTnugwwZ8V/ieXup9aS
         AuwCENmceUBzyqnUvYcrHMVqwA0gJoTV7O3SrfpYapjIfqXhhw3XV9BBASUHIdlV0xYY
         I4TMB2Ro3P1Ta8ixlyUOjLwzTYcUYRUwTFSRScKV/jsgFVFUuQBraC6HeJ/CCz7akn5m
         Tzo0hgVSb8G67RWyos3SKmBL//UrOQ2UOupOe7si61oBTQCSptibyE0LzExlH23O+Sy6
         vazQ==
X-Gm-Message-State: ABy/qLYhTu3URM4UFHZ1IEZnpPob8JuMXiqFNVNeZnft1csS7ONY8cST
        pEN9oGPDmA+yhb99UUzfj1ZN
X-Google-Smtp-Source: APBJJlEWRAqol6EDBEjFvvsLTm1hWktCwxA7ISq3LgRqBFuGegzWV2H+iwj/MwqoiyEYk2Jvksp2kA==
X-Received: by 2002:a92:2902:0:b0:346:4c73:baef with SMTP id l2-20020a922902000000b003464c73baefmr481571ilg.30.1689224849128;
        Wed, 12 Jul 2023 22:07:29 -0700 (PDT)
Received: from thinkpad ([117.207.27.112])
        by smtp.gmail.com with ESMTPSA id b6-20020aa78106000000b00682c1db7551sm4475133pfi.49.2023.07.12.22.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 22:07:28 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:37:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 10/14] scsi: ufs: core: Add OPP support for scaling
 clocks and regulators
Message-ID: <20230713050711.GC3047@thinkpad>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-11-manivannan.sadhasivam@linaro.org>
 <20230713040142.3nsrzezvi2hsp52e@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713040142.3nsrzezvi2hsp52e@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 09:31:42AM +0530, Viresh Kumar wrote:
> On 12-07-23, 16:02, Manivannan Sadhasivam wrote:
> > +static int ufshcd_opp_set_rate(struct ufs_hba *hba, unsigned long freq)
> > +{
> > +	struct dev_pm_opp *opp;
> > +
> > +	opp = dev_pm_opp_find_freq_floor_indexed(hba->dev,
> > +						 &freq, 0);
> > +	if (IS_ERR(opp))
> > +		return PTR_ERR(opp);
> > +
> > +	dev_pm_opp_put(opp);
> 
> You can't free the OPP while you are still using it :)
> 

Ah... will fix it!

- Mani

> > +
> > +	return dev_pm_opp_set_opp(hba->dev, opp);
> > +}
> 
> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
