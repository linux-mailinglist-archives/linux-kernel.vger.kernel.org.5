Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D278175ED09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGXICr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGXICe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:02:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DFB1B4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:02:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8b4749013so32639455ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690185745; x=1690790545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Po9pQRZ/q0l1v90fsouYbF4Y7A8coEOIwxXQK/g5x80=;
        b=Mo7fY7TnjVvd3tMfcTkVQSB95u/uNJ1NSTBjUA0p3K0DUMv2uFXwSpe3aGjKQK2VnA
         dB9YJ0pjMUk2BhJLRhrjo1ppVL9KkesLTbe7b+6GJ7HKvLbJCh/uOxIDo6x79HaAILW/
         4OXqEMzasa/Z2Yx+hn4hciFPT1Z+sM0CgIhbNeX8U41WpgY3cgh9xXKWC/S+xTmvlFlj
         UisCf0eisyfrJbVMJQJZ16dnDruKyAVlMT8NAQbxiWiO2xhEqMSvaYNe0zhWzfdeePEd
         2ShLCnWWe7MjIwn5nQiq0wExfSHzy1FlvKLyv8OqkDuri5KnXJt5kza3n2TpJFaGvTO9
         4JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690185745; x=1690790545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Po9pQRZ/q0l1v90fsouYbF4Y7A8coEOIwxXQK/g5x80=;
        b=EFcPP+sYH95lkg8eL2LfGRjYK7hzlqhBnk7fa3rLv1UG4fMHgOC6J7o29ap5f0g5ql
         /4+BcJnlk4D8E7uJ46KiKOxPI+4CL+iUxV53SA+rlBGqnWAkwwVyQGO9d8009K7JiNVX
         4fNKj74vGhMFyaIQn/rFqe2TVO4iJuobycNz4c86VaOCXU1sMPlSjyiOEcpQeukcFJsE
         w2zq2iS7KsyqJMXRt9v5r0vapp6ah9r1kN1H5IaWbq+KFxeqs/ss+eo0Wbza0wFYpt5O
         zEgLqRpjZLFiA2GBWv0AAHOADup784yQjI5yW+got8f+B0QQcpIM0KT6P+uxWZ5d9NvE
         XWFw==
X-Gm-Message-State: ABy/qLa0+kL3OHHFY46mQPck5EfNAwvG8FBBjoV94r+YseG/1MA1ktOk
        2eFIBWWUz+7qRyBougDjm0Mvlw==
X-Google-Smtp-Source: APBJJlG1kMDbQVntm5M1zd32dTabRF9d4QCoISaVRhQUWeX3UV8ag6YZvPTEjHK1pFZZ/tOTYO2IFQ==
X-Received: by 2002:a17:902:ea08:b0:1ac:aba5:7885 with SMTP id s8-20020a170902ea0800b001acaba57885mr12533742plg.47.1690185744988;
        Mon, 24 Jul 2023 01:02:24 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001b6740207d2sm8149549plg.215.2023.07.24.01.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:02:24 -0700 (PDT)
Date:   Mon, 24 Jul 2023 13:32:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] OPP: Couple of smatch warning fixes
Message-ID: <20230724080222.pn7iuzi2ku5q6efp@vireshk-i7>
References: <20230721124634.63612-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721124634.63612-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-23, 18:16, Manivannan Sadhasivam wrote:
> Hi Viresh,
> 
> This series has a couple of fixes spotted by smatch tool in the OPP core.
> This is on top of v6.5-rc1, so could be merged separately.
> 
> - Mani
> 
> Manivannan Sadhasivam (2):
>   OPP: Fix potential null ptr dereference in
>     dev_pm_opp_get_required_pstate()
>   OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()
> 
>  drivers/opp/core.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Applied. Thanks.

-- 
viresh
