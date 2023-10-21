Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86F47D1BD8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjJUI72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 04:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUI71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 04:59:27 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4FFA6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 01:59:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507e85ebf50so787268e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697878764; x=1698483564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSwg440wrKhxzi4Nkn3o8cAc4S4zNJPVYbiVkpDxWbU=;
        b=ixvQTgt70i4j5loydt+125sWhqoSwMs0gjVOIXUxPsdCnSzMxl2jWMJCgbDaC8Hx0N
         tUg0yG+3CfaRop0bTmMAWUp0zMTxk7CTtcThcpb2BH0pd0aXI3YrIaWFhfxy+OC4FFHz
         Os7gsjIbzFTWOUGYI4+8nZ4JanfEbHe9LgjcqATB5HTx0UlS907eZdEBEM0ZkWp3+Axi
         qDVEii1O4QvhDFxuT9pMGC9k0T/Jc67a8fG8mA5sqxaeCafGbz1wx58aDkzef0p8mvxG
         yBWnMFqaI9UtQpKBW4D0igw5e4zJdNsCugQtt71UajhIA1NTC+WrSr35qnEwGG4Sebqe
         TSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697878764; x=1698483564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSwg440wrKhxzi4Nkn3o8cAc4S4zNJPVYbiVkpDxWbU=;
        b=AOhhXI2CenrGXXNSwU8JSKlaQpRtiEG8YWRO9eaPsmRDrc475s1Uo7ayzRh8p+7EtC
         spTd7gXuVbDich1a/lVlTcjtJODySnvObMxi8cV/2GE4s0wDFVM7dt3+C2b/HT7UQ1cd
         xItWTGrlfazgOG+v33b0Uuc2jsDDbS8ZeEbdx/MS7+V+iqlp7ZVQGRuCjXdUEPXeJnDV
         7mI6S36IWBLOmkbMzi3Mpo5n16Zc1OLdvypiSfti65M4Xuzc9GPJTZ1jFnJFE7pKOGnw
         nuOkvThtdl+ZdCbx96h7GfzDUW0UpcfiiRbvQY+mbGj30qeZ+DffD3+r3brE1b9peAcn
         dBAg==
X-Gm-Message-State: AOJu0YymQOZBEHI835twMT77UPTDapu/Vz5q2qJiWKL+fJX7b9eC1yMO
        6lu0LgsyFj2v1QEFwqz1NLU=
X-Google-Smtp-Source: AGHT+IFflAxVmB8sFEQDUCHUnmO5qofTQafZCiOyw5fLTsst+5WlUdDVvpWG0V4Q4SIhjuak3ELMvw==
X-Received: by 2002:a05:6512:3b87:b0:507:b15b:8b93 with SMTP id g7-20020a0565123b8700b00507b15b8b93mr3566173lfv.69.1697878763561;
        Sat, 21 Oct 2023 01:59:23 -0700 (PDT)
Received: from HP-ENVY-Notebook (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.gmail.com with ESMTPSA id a12-20020ac25e6c000000b00505713722b9sm780928lfr.38.2023.10.21.01.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 01:59:23 -0700 (PDT)
Date:   Sat, 21 Oct 2023 10:59:21 +0200
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Fix warnings due to introduction of new
 typedefs
Message-ID: <ZTOS6eaygOA6nRKD@HP-ENVY-Notebook>
References: <20231021081409.67570-1-bergh.jonathan@gmail.com>
 <2023102111-sneak-abreast-8061@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102111-sneak-abreast-8061@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 10:32:29AM +0200, Greg KH wrote:

Hi

>  This looks like a new version of a previously submitted patch, but you
>  did not list below the --- line any changes from the previous version.

This patch is a *new* patch which replaced a previous *series* of patches
so it was considered a *new* standalone patch, rather than a new version 
of the original series. 
  
> - Your patch did many different things all at once, making it difficult
>   to review.  All Linux kernel patches need to only do one thing at a
>   time.  If you need to do multiple things (such as clean up all coding
>   style issues in a file/driver), do it in a sequence of patches, each
>   one doing only one thing.

This patch only addresses removal of typedefs from the declarations 
and fixes up the implmentations that relied on those typedefs. The previous
advice was to not make breaking changes across patches, so this patch 
represents code changes which are as atomic as possible in a single patch
without breaking the build. It does not mix formatting / other changes
with the code change. 
