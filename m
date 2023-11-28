Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125077FB078
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjK1CwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjK1CwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:52:06 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E01E192;
        Mon, 27 Nov 2023 18:52:12 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1f03d9ad89fso2896295fac.1;
        Mon, 27 Nov 2023 18:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701139930; x=1701744730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EfABTQ9iYuQCs8o1rViw9knyA1nBxcD72JLNmeR5v8=;
        b=EvJ0pqO0h3ivhca3OKZiAAlUIVZRA3JzUzuW4TdrTQPG/iREL18dUdpNNn02VRiQwG
         fgvzDbX5dkzrXVGiN6gDz6m1fVyZ9dHncH8zkVmfVViPU2yxegOM48mbHJDnabEUh5uC
         7tTi5eil8IXfXbG40krTEGEGGfD6AriICSnMqI/NUuQ8KYjiCoaIX4NqdqlExJjkJqux
         vfu8CPg/6kucnd0F5HifRjtHCjikw91sGs2jSIMV4hHsJVMaanL1pi+lvzIxYvHgiKzy
         nTR8f6ZwPaB/C54I5OFHcqZPpN1g4dtRTRlQHa6R8pUVtXPRJQp4zytMGkXGGSY+rBxB
         LHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701139930; x=1701744730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EfABTQ9iYuQCs8o1rViw9knyA1nBxcD72JLNmeR5v8=;
        b=wZn/P7eJ3M1ABmkW8a65V+9RagBUst8GGziUSFsxEW0XnUbtFRwdvTdNllYyoMt3Ss
         O1AxlOWDxeiNzlu2a2YsVppjcxnMCNm/762qFyYjIw4bc8tJs3R3YlBGJ/uC69LsHkuB
         IdPPndL5zSAAbbWqHMNmoyKxF4GTIacTdqZPC5b1SBy9tD7amao9/IZ7YzB6ufeMW2qH
         QoQX43rKSqVA+5HW41NolJ6kgKWBUCboMVemhZwHzPFUdi9YEJGmUTS0auVEYrur0F8q
         M3169zTywLNSTd+5pojMFQICDyXRRwQQ1o7OyV2z0qCM3ggXlbkpnIlngHHEJ2kCm/+a
         yrnA==
X-Gm-Message-State: AOJu0Yzxe24zLlFbUCY1dRDx6NQ4ySxz6qOMKN0vtVxB25veW6BvzBEB
        zIMenMbnHy6ADFnr9wU+SPg=
X-Google-Smtp-Source: AGHT+IHUN5mSU4AhYoQ7Xn3rIS2ajtcExOdKV26E8K0W+b+fllVnLXF1WRypBZL+zbQRRJb9F36u4Q==
X-Received: by 2002:a05:6870:8191:b0:1fa:2bbf:b7a0 with SMTP id k17-20020a056870819100b001fa2bbfb7a0mr11717943oae.43.1701139930456;
        Mon, 27 Nov 2023 18:52:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gs12-20020a056870ab8c00b001fa2a638df2sm1474873oab.51.2023.11.27.18.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 18:52:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 27 Nov 2023 18:52:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.4 000/152] 5.4.262-rc4 review
Message-ID: <9a597542-c1d7-4ec0-9a43-5000915af325@roeck-us.net>
References: <20231126154329.848261327@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154329.848261327@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 03:46:07PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.262 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 

For v5.4.261-153-gec4ef9e1:

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 464 pass: 464 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
