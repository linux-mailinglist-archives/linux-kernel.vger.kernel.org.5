Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDBF771073
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjHEQOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 12:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHEQOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 12:14:37 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49F63C3D
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 09:14:35 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ba0f27a4c2so44992731fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691252074; x=1691856874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4X5LeqFwRZ12z0t0SRAdd4hSB7565qztxHR0V8YIUsQ=;
        b=ZdXi5xrrQrMtP7oPExcSSvfWcYTjypvLAPSjl6TaUplewzQ3PZg1/F8E4b1DxABhK/
         eOpiCyCZzJYxQlGUdxzei4fKwD6Jlp1PYfStSdRLtJY4zXbShncJmrFN/9n5MQhmvbx0
         hCEeF98ays3a0OaJ5kIQbbOfUp3DoxRzwsafdlVYOX1lvk9W1s1QrPpRIV+XLKtImvU5
         Nd0Ji4MBd1kDTvqVtRCh/QmC99O2Tnp0onrQuV01AjIQ4fBkVJgam7YDxuf7Pzz+ILmP
         QoQST+xnqyhowG59TMHZFRGNX9DQ8EMzBAfk5FsoMgu2V80xizPthQcFSpV0dYZOJiqf
         WT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691252074; x=1691856874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X5LeqFwRZ12z0t0SRAdd4hSB7565qztxHR0V8YIUsQ=;
        b=SXO2+LEzFZpNCoK+9DcQKRljmvxUSg8wC/VaFcnICCLETMAudAG7V+TyBS/OI5oBae
         AglpEVKLA5c6v9eBcRmJz0iKzVL5D8DUfM0HBQBE/OSXiU/TdZGMQ7hQmHk6BUiLCN3h
         JMWSKYmakvlj1aMikJVR8qxS/gHraDVXjPdpcZ36C7eJ6tlAnVedZy15KObT+xCOqXUQ
         zbJ/abaDXnwtmLyj0QMTACBwyWvBMVsj247bIJwbBwEwxYhDZfdUoBvaRl7tWkJ3isOJ
         oy9iqROVG87/GVQv1php93eHbQxM57EKz7Gx7lhBGfKyqTdpY119RivmlnHxNx+A3K1a
         Ms0Q==
X-Gm-Message-State: AOJu0Yxc7KQzNSTFbWKKjSLjWywWWnJJNeewaMuBgtXb5OeHoafyayq5
        YscU7wVf5N6OC3u4cnVUnIMxDhPerymkdDBNe2w=
X-Google-Smtp-Source: AGHT+IGtX5wIfl3tY9j9ku33ZEqA5uzIH68ru1YtY4ppk1a7rI0YhJOPsqCGL7ic5oeTID5GaICrbg==
X-Received: by 2002:a2e:9694:0:b0:2b6:ec2b:7d77 with SMTP id q20-20020a2e9694000000b002b6ec2b7d77mr3221194lji.6.1691252073817;
        Sat, 05 Aug 2023 09:14:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r5-20020a056000014500b00317dd7b96e7sm1554508wrx.23.2023.08.05.09.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 09:14:33 -0700 (PDT)
Date:   Sat, 5 Aug 2023 19:14:30 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        ivan.orlov0322@gmail.com
Subject: Re: [PATCH] staging: greybus: Refactor gb_audio_gb_get_topology()
 into separate calls
Message-ID: <553ef4ed-9f0a-4ab1-b7f2-0175f6cb4dca@kadam.mountain>
References: <20230804203134.GA618419@madhu-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804203134.GA618419@madhu-kernel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:31:34PM -0500, Madhumitha Prabakaran wrote:
> Refactor gb_audio_gb_get_topology() into separate calls for better modularity.
> 

This is too vague.  Just say "There is a comment which says 'Split into
separate calls' so I have done it."  But actually, please just delete
the comment instead.  This code is already an endless series of wrappers
around wrappers.

Also, please run your patch through scripts/checkpatch.pl.

Btw, I just want to emphasize again that I was 100% serious when I asked
you to delete the comment.

regards,
dan carpenter

