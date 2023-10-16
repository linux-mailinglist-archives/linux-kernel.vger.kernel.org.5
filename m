Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1967CA562
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjJPKbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPKbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:31:15 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5A883
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:31:11 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a2a3fb0713so163047039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697452270; x=1698057070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHWSQJKtMXCWVI/E5eOzEROfLgP71p7LecbnV+U6P7I=;
        b=MfXhJK4JhdQ/5ofKovV4S+Z6n2mySVgneYP5Kgb7pj/eCdxHpeVxMLOH6MsUHgb0qQ
         uPXLKmCcu6slh5dh2390zuFoKT3bEWga6+pY6KsqmbWf7UazCiXzyFiIHzsHw5yqUJPU
         WovM5C0biVbC3PZj5AviRr3TcwzKHklTr1NUagJc20INV+fNg1fvktnFbuE92bebjvo/
         7vK8acUJp92/WNZaF4rOLdvt05VXjQMVsxMJJu3Y1L/F/HVbY7KeM+fophytj4JfejjS
         sehlq5UFi5RZO2TiXTWTyr5z26qb59IanC+TpLOG/GlzL7NXoe4fsv+J615BkvaIsiBW
         ch2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697452270; x=1698057070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHWSQJKtMXCWVI/E5eOzEROfLgP71p7LecbnV+U6P7I=;
        b=qwz2SSdRI3xcRy/qSa6DnrNxFY+dvmYBay+q10K1b6RQcPuBcFKvCT/gG25gGi2uYo
         1KtRzzgo6shhfD9DJ+uLJSZmiobdT7X8fg/95Du29v7e/3jraW5jR9Nui4zyyj51tTcP
         oS6EpEzdkenT/O6tSSqd7SxkOwo0M8VgNlr8HfwDXaNxwmmBe1DOCxJa5K7sO8ubQ3cQ
         9S+6Fmewy1ghEms8eUSciLFqpd4wfF0b+kVhX+pQtbTL5mU4ikar9mLOcM/grDq16CnI
         IVvTNEvH+yq4ijXZwv4t8eRTkv/hS0Wm3LCWVoxJM3wLKHlD318QTqi7j9rmvP+c8ZA+
         Jf7A==
X-Gm-Message-State: AOJu0Yxnac4KFpBK8nFK9jzYqwG8bdODgxhkDMUEb0RNo/UL0gxVDKBB
        of7GNf2I3EQBgwvoNCe87Yv8Fg==
X-Google-Smtp-Source: AGHT+IHWr7fM55d01cKjE928H1Akt2xUw5mdHfzkkoOM8Wkiffh/9SIMwKwbsA0gswo63rEq1vbl6Q==
X-Received: by 2002:a5d:8713:0:b0:792:9a3e:2dd with SMTP id u19-20020a5d8713000000b007929a3e02ddmr34733470iom.3.1697452270730;
        Mon, 16 Oct 2023 03:31:10 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id j18-20020aa79292000000b006875df4773fsm17789509pfa.163.2023.10.16.03.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:31:10 -0700 (PDT)
Date:   Mon, 16 Oct 2023 16:01:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, rafael@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6] cpufreq: qcom-nvmem: add support for IPQ8074
Message-ID: <20231016103106.kyeritota2mnutcm@vireshk-i7>
References: <20231013172033.3549476-1-robimarko@gmail.com>
 <20231016033202.i54nequofzea6mfd@vireshk-i7>
 <20231016082239.2onlrqp4bpcgxhbt@vireshk-i7>
 <CAOX2RU5paPXyG-1Fbp+T9+Aycwno9DQ8ugMwUr_8iNhhc3HiHA@mail.gmail.com>
 <CAA8EJpq9=dtemYLCeL8=+q1x_i8Gp2duMSAo90ZttgaejBXCdg@mail.gmail.com>
 <CAOX2RU6K7h8Xc0SGK2CeOCaAaimKRf9eqhMYAaySXxQLZiUNtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX2RU6K7h8Xc0SGK2CeOCaAaimKRf9eqhMYAaySXxQLZiUNtg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-23, 10:43, Robert Marko wrote:
> Ok, I understand now, the thing is that the ID-s were added for
> socinfo initially but recently
> I finally had somebody with access to the Oak HW so I added them to
> cpufreq as well.
> 
> What can I do to help this get resolved?

Rebased over Bjorn's commit (which he already sent in his Arm SoC pull
request) and applied your patch again.

-- 
viresh
