Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A7B7DB4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjJ3IC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjJ3ICz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:02:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45656A7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:02:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507c8316abcso5780411e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698652971; x=1699257771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CM1rafXiEjQh9z/wcIlVdv+q/HuJ7vkzwzwaa1ZRZv8=;
        b=news1VHOf2NTXGfMZSrI/mHvLiAnDd/jcCakw0LR9zjZglEp69pWPErNd4HWkxsHJ6
         DCilwNYC+FaAOqEa3akq2xf2XSrXaGfdVNZmrQUSQVZXRKnUOxyvf3+Kg53IeL9yHvcK
         CXsTMw17S6NeOiI2nV83fN6NrLbextcL7rxy6u2Spn9SSmvgT6NcaCfykf9URytaA/ww
         w0jWffNCjQw6R0qVOZPUbl4pTuLVFs/26IZ2sl0KzWqdUUyfmK7wD6YYBx+vNY+9upyj
         3LpRr4ru6XnxHwyPaa+5LTeScO5nkJbnH35mV3Zqn58vYa3Jko/MWONcO+i61hs5RBOk
         4gVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698652971; x=1699257771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CM1rafXiEjQh9z/wcIlVdv+q/HuJ7vkzwzwaa1ZRZv8=;
        b=db7jIUdBZ5ultf/P49x/8+92tZUmEUdee89d8eQiLN5a+3Fjtn8EKy3OIEK7uzsCVL
         E/UuI8d1arqki2bXrSDbMZAAh4pZCfnK/2+dJUdxpAO1tMutC7BiM+wfvZRqKA2O/EOp
         pDBeBKIEYeLQSJjnRQesMqo4kHRaIFHrcW1T1F8U3amXFbrAuXBMksEjbQaHzKdeaTBZ
         7P69PLgB+ubau3amXR/uBaLb38Ksmp34etXqoOLAKX8re7w3hw4YGJpa0opF12TEY8fP
         4bY7pU4muV85kDa2IZ/OBUoivc6J21kt/SsGF0sPyYSOizeKsWTIV7Pv0EHkJOVDNYYE
         g70Q==
X-Gm-Message-State: AOJu0YzI91fDq5RzkLUn+dEHD4YbljVpGYzWDu2j+PUlzjUxBlOV0Wvw
        4RjZDQYV07sz6UGYVmuNHMGOLw==
X-Google-Smtp-Source: AGHT+IFlBT2lR7iH9+vrdj4AlOxYlwFWHp9VTaPuLj3iPhDeJHG5WAxcmSAqXVR9wa9A9YtSw1Cj+g==
X-Received: by 2002:a05:6512:6d1:b0:508:19be:fb2e with SMTP id u17-20020a05651206d100b0050819befb2emr8246693lff.58.1698652971461;
        Mon, 30 Oct 2023 01:02:51 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b003feae747ff2sm12070916wms.35.2023.10.30.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 01:02:51 -0700 (PDT)
Date:   Mon, 30 Oct 2023 11:02:48 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: ti_sci: Fix an off-by-one in
 ti_sci_debugfs_create()
Message-ID: <1a85d4bd-7e90-4a1d-aa55-4d9070fdfc16@kadam.mountain>
References: <880aeea52f3bdde5e3e8843bbedb7fd068a58be2.1698565938.git.christophe.jaillet@wanadoo.fr>
 <6fa05bc4-55ad-4173-9af0-9db713b4d148@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fa05bc4-55ad-4173-9af0-9db713b4d148@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 11:00:59AM +0300, Dan Carpenter wrote:
> On Sun, Oct 29, 2023 at 08:52:36AM +0100, Christophe JAILLET wrote:
> > The ending NULL is not taken into account by strncat(), so switch to
> > strlcat() to correctly compute the size of the available memory when
> > building 'debug_name'.
> > 
> > Because of the difference in the return type between strncat() and
> > strlcat(), some code shuffling is needed.
> > 
> > Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
> 
> The fixes tag isn't really required.

Ah sorry.  It's an off by one.  Yeah, that's a bug even if it doesn't
affect runtime.  I don't know why I didn't read this commit message
better...

regards,
dan carpenter

