Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBCF7FC11A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345572AbjK1SKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjK1SKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:10:06 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B61B7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:10:13 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-423d9d508d1so5678721cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701195012; x=1701799812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2GMrLcGcuPvxGptutNWB7kt5k9GOKF04a50so4967s=;
        b=Thc7w8AxMhkvw1AgQt2C6X/i5Fxlz7UPepSBc5NHpyXfhDLfoxuO/MLLXXI0Vl61qt
         gsoxwR1PNM5WFUv1PV3ViisDy65V5Uv889ktHMQu5B0WuwWNYeMa7ehNoXzDPB3B1x6v
         VjuTFtMDzXVVqIxJosMtvgq/CFJ2UjblHTqZJ1FtJLUCZ+TDrHHdoLMM8R8mIlEbykOV
         Va0Evs3OODqMGj8IByH0YLHqHCob3VkfNusz0M7ho3vfDtj/l08lwJy0PJigqRvqhcQS
         3YcmG70SJP0iL25XTZ9wjJBufB5Mv8nfgV/1ux/EiKe/gc/c9FtCZadNnym8OwhgV8fW
         mDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701195012; x=1701799812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2GMrLcGcuPvxGptutNWB7kt5k9GOKF04a50so4967s=;
        b=sTJ5FKCp1aSgqXZ+DEB0XhJoxZEAuwesxAI65FRNxvfGbkHoys+sojmvoVDZfRrMQu
         J7Xf2LFHfSkJZgDangY++e193Z6W2Ken7P23+Su9ggGdNmmJOxtg5VXuk8/xt55Sch5A
         GF78k8uiH4LsYNyUOu1k66Rm6T3QHDMPdpvfSynS3QtYZfVV0BhSxKGgGcHBFAJE0rmX
         xgUp11zSleuK+LyWuL629TAQT+18QHEbSexKELYR6khR2D0m1TFtXieP5g4prF9vNKf9
         Whw9QjRpgfg8XumGoYfroFZhSLSshrLjR106anJI7zC58nYTUkBt3uJHnGLiYfO/KULu
         O2Ig==
X-Gm-Message-State: AOJu0YwZRqT3yXsxC58GAgPML/EM+HUwgfgwGjazld/PDGmbzeFuf/HT
        0U2ig6ePhjRSBS+m9vcyIN3SqQ==
X-Google-Smtp-Source: AGHT+IEcJ1uAsb80kR1B3aJuT1IUjjgas87J8p1OJjPxsDlwIaK05wTXQ3zKeNcgXFK4baOeAFiQ6A==
X-Received: by 2002:a0c:ec4d:0:b0:67a:3efd:d6f6 with SMTP id n13-20020a0cec4d000000b0067a3efdd6f6mr8466084qvq.50.1701195012288;
        Tue, 28 Nov 2023 10:10:12 -0800 (PST)
Received: from aspen.lan ([209.120.180.235])
        by smtp.gmail.com with ESMTPSA id t15-20020a05621421af00b0067a4452d459sm2164807qvc.116.2023.11.28.10.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 10:10:11 -0800 (PST)
Date:   Tue, 28 Nov 2023 13:10:07 -0500
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: mp3309c: fix uninitialized local variable
Message-ID: <20231128181007.GA4431@aspen.lan>
References: <20231128150839.2605003-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128150839.2605003-1-f.suligoi@asem.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 04:08:39PM +0100, Flavio Suligoi wrote:
> In the function "pm3309c_parse_dt_node", when the dimming analog control
> mode (by I2C messages) is enabled, the local variable "prop_levels" is
> tested without any initialization, as indicated by the following smatch
> warning (thanks to Dan Carpenter for the report):

Good to see credit for the reporter but please use a "Reported-by:" tag
for that. There should probably be a "Fixed:" tag too.


> drivers/video/backlight/mp3309c.c:279 pm3309c_parse_dt_node() error: uninitialized symbol 'prop_levels'.
>
> To avoid any problem in case of undefined behavior, we need to initialize
> it to "NULL".
> For consistency, I also initialize the other similar variable
> "prop_pwms" in the same way.

I don't love redundant initializations... but I can live with it ;-) .


Daniel.
