Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF17CA176
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjJPIWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:22:45 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB80A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:22:42 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-57b74782be6so2253645eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697444562; x=1698049362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/odFgUPd/TzHJ6cTRt/k7sNsldydATviDSiz8fUMkbQ=;
        b=Fgz5RHWZsJSSjv7HmrFUaX8BLhaGjLGRyHMmeWUDrwSZPGiLoKaPv1mSOAE27rCw/t
         7qFrzzk/7YfYv54QowkjsF+DRRhtVSb3nYz8xyGZbqotxABLXVpwnDm/+6iYoNSOT0+z
         oLk1kSSGIs5d1eZQ4QQ3W2zGbwh2HXaDeH2bZNC/z6m8WngDAKOwn6rIMMqiHKepEYkL
         oOmrl5sg1ggGaaOJGuBk/sjJAXzNO2unXB3pTrdZh0+iBcPswZVTawZ1E5tgZwMqH500
         IMZ7tYP7Yw3Rk9TdVblDDeZ2JoElFDitb4/DSKOBeYUrKpINSNI/ohtMWpSj7qweDhZS
         WNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697444562; x=1698049362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/odFgUPd/TzHJ6cTRt/k7sNsldydATviDSiz8fUMkbQ=;
        b=J6szfwGTPDJGOHs+emeMHK8itT8wU2T1/d81+3XronBN5mkRcDlIwg4ItiOIDryD27
         BTDBH9n5UEW08Az4H7lSdT/Ivr6ghbnoewkolJsjWPXIYjAkl6V/yojcLDwK3VzKYtJm
         IzD3JIVGQQdGzr0AtIvt7hYGKrcEtOwp73vAY3LuksTA75sjOMzgE4A2VTE/SQ0jM3Bh
         H2isk7RmUto3NMdHgkf998fhqsdmTPqnBxGeUFbtFJQ22YXpqw/7kb7LKHEVr991ZQ+7
         LjfzJIPurzagBNoiyIHc68Y93rO4rd6CGXdsSDkzEVhpzWC6qhrYMlbfQX/N7nnePg1p
         YfWg==
X-Gm-Message-State: AOJu0YwkOTnA1BOpfocRjFW6PTxQ3UTScVd9bsXWrce7dJ4bVRy1ipzO
        FeOlMvD+uubEalzcQe8BIUlLMg==
X-Google-Smtp-Source: AGHT+IE7Si7IA37fPaHZ3OJTV+h3Cez0SCioe/bQyrEyrJz99TyMpW10Rr0DvT99Ga4mErQhMGo9Ng==
X-Received: by 2002:a05:6358:24a6:b0:134:d617:e2c9 with SMTP id m38-20020a05635824a600b00134d617e2c9mr41494869rwc.29.1697444562223;
        Mon, 16 Oct 2023 01:22:42 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id 19-20020aa79153000000b00692754580f0sm17506952pfi.187.2023.10.16.01.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:22:41 -0700 (PDT)
Date:   Mon, 16 Oct 2023 13:52:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ilia.lin@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6] cpufreq: qcom-nvmem: add support for IPQ8074
Message-ID: <20231016082239.2onlrqp4bpcgxhbt@vireshk-i7>
References: <20231013172033.3549476-1-robimarko@gmail.com>
 <20231016033202.i54nequofzea6mfd@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016033202.i54nequofzea6mfd@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-23, 09:02, Viresh Kumar wrote:
> On 13-10-23, 19:20, Robert Marko wrote:
> > IPQ8074 comes in 3 families:
> > * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
> > * IPQ8172/IPQ8173/IPQ8174 (Oak) up to 1.4GHz
> > * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
> > 
> > So, in order to be able to share one OPP table lets add support for IPQ8074
> > family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
> > 
> > IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
> > will get created by NVMEM CPUFreq driver.
> > 
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> > Changes in v6:
> > * Split IPQ8074 from the IPQ8064 as IPQ8064 has additional dependencies.
> 
> Applied. Thanks.

And it failed to build, please fix it. Dropped from my tree now.

-- 
viresh
