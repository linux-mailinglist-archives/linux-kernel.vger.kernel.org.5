Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9C47DBB64
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjJ3OIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjJ3OIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:08:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60EDC1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:07:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4079ed65582so33024835e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698674878; x=1699279678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+x6+LsrjZdB8dHUELRSubYTsHMKRqi5GBjTWofSCMDk=;
        b=XzR15MZSaJ5rcYRcqgEh7c8vUnMlL5v9R+zWTwbI4usZ3aPhMF5rinw2t9iEsxbYEy
         H5gp4XB4XlAF/bySz4rt+PGc1f9nyW3YWafsXXMnE/bOlaJUML8A/VkrmnMLZRS7GJ3k
         QAHXipYM3oM7fyBAzg8G9PLSi2//LurYS2cgeE8y21NB+MrZWFOi9KJcUk2uz7GvyuvZ
         9DhRI/ZZbSo9WlgwrqMO3uyewsXb+6ijOq3wlwgL9zZFDAO5RLCee/dqzKe0IV2X0e+o
         X6QWMr3R1z9/hSMtDLx0pBB29Is//qmbc7/DrsFFH8bxOV15bcdUt3Miq1oRUyfipYIP
         nqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698674878; x=1699279678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x6+LsrjZdB8dHUELRSubYTsHMKRqi5GBjTWofSCMDk=;
        b=eoUlX7gLRBDP+6aWQhG0+oBU2JsyeiG+vaRk+vNh/J+UY10SmcdDVxAh+U9wvkrEyL
         slJOCb8MDgrhpodCjB5xB6Zklw4IWKm9U9YCIsz3dz62W4XpGrvfeXnhIKjYx2abV31D
         RHxc0jSu3Pdt5xaVjL9ZxlwWM0jgxHoQUejEtcVfeD0z6VtW3Q975BEXnpfQ60m99ds3
         D5MGmZx12B4sw54ucheUZp7/G7ldc1449VOb6/DwYBN9mJ0erpU8wSq7GVWXLrAtSxmA
         OkJUp1Aw6jum7h3Wn5TfDUvYS+juQ2qd0P2vuqIGJ8Pf+PnOsXcKNUrUshRcWwT4GLsH
         Dwlg==
X-Gm-Message-State: AOJu0YwNQQ6HnlIiTEqqAOcSsrS3SyM18CMp0FK54ve072OO4u0pKhIp
        hlVSO2f3p4wAME3gPgV1QPLWkhfy7km8cZLz+4o=
X-Google-Smtp-Source: AGHT+IHa3PONe2ZHFjs1Ut/yXYmZH5eEEBpHXQF4IG+q5Drd25RgyRrQwRp16iOxIIUmK+4amlW37A==
X-Received: by 2002:a05:600c:35cd:b0:406:872d:7725 with SMTP id r13-20020a05600c35cd00b00406872d7725mr8744073wmq.1.1698674878017;
        Mon, 30 Oct 2023 07:07:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d46ca000000b0031980783d78sm8241952wrs.54.2023.10.30.07.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:07:57 -0700 (PDT)
Date:   Mon, 30 Oct 2023 17:07:54 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, ecryptfs@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: Simplify
 ecryptfs_crypto_api_algify_cipher_name()
Message-ID: <72f7eca6-3566-46fd-9ff9-386b4077d55d@kadam.mountain>
References: <2c4bd387e8036854d3338400038fdde8dce3806a.1698672391.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c4bd387e8036854d3338400038fdde8dce3806a.1698672391.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 02:27:32PM +0100, Christophe JAILLET wrote:
> Use kasprintf() instead of hand writing it.
> It is much less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

