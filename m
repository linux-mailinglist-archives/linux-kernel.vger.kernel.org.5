Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49B27768C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjHITdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjHITdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:33:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D702125
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:26:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so32587866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691609162; x=1692213962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjD6SnFC9OBpLFcPn947ZxmbIrE3ZcubJS7r5cKfK/g=;
        b=hkJJ/OK+5utE0Nm6SDF5F8RwnoyMkEd1oh9WNIZQd1hMOJ7X0AwTwXQ8XzlYfqE5qk
         Z4Oiz6py0VjD+E3x2ItjagMRyk9Ie+8a0L6up+JN8EQfv9BP5XwxRPjLEBU6tZWABJHQ
         ImpK8zTkNRAE0ECdB445cP+lWCC7EmxwOsmbf1xQLe+sv+fiC8bpa1gdQ1Q4VPtVezPA
         ki49w8Ibrcw5Cg/gMUUTPJ/SZ2RV3S36x51MHm7n7UOjhmnBFL4e8mXYtQUA3IUqWOCC
         HpKGec9LapvTyfRZYJmAz0eHrT7fAp2MviZakyidkpAu5aCyb+YRTMd0JuggsvELgFnP
         IhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609162; x=1692213962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjD6SnFC9OBpLFcPn947ZxmbIrE3ZcubJS7r5cKfK/g=;
        b=TPEn8+Zx37fwdOv4VxzW0OCukB3JFsoNU2cAYfBdCdQvOzaQr8/JMsMNbp58maDPHj
         XhCTdwTz7m5ZCze61aw0wA89+JQxmcT31oanITwLx8DXNf6T0yr0n4Mekv5mmo96MwFx
         D46R5Z0RuBCRMJKolS0tSvVuB0w1Hi05eiVSSISPWispst10MayQ4B0qkkXrAg2iGlaa
         yTQY79ndnaIm2i0rJ/kDELYS0ZtD99pCQ/+DlG4Q/DqGzgemEUxl/wAkSV2W5zoeUZn0
         GuqYs442USES6lYYsAbdm26TglJAi2qOjtKzuhVuvohhgy7bhCD81WxHR3GYYA/NLFOz
         07MA==
X-Gm-Message-State: AOJu0Yw0yXJIJUXYkUZCERylkxQhp4FUbZ+ieSgK35leQWpE6fYgsAwB
        biBoVdOXD05XUJHNCjMQMT4=
X-Google-Smtp-Source: AGHT+IENJ7d8S4cUWVhvYtD3JCAWasRB5eZFzuCICORT2qGVlynQu6hFwzEIunA7TxVmkTH4KddNeg==
X-Received: by 2002:a17:907:c13:b0:974:fb94:8067 with SMTP id ga19-20020a1709070c1300b00974fb948067mr637357ejc.23.1691609161893;
        Wed, 09 Aug 2023 12:26:01 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id l7-20020a1709066b8700b0099c53c4407dsm8419091ejr.78.2023.08.09.12.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:26:01 -0700 (PDT)
Date:   Wed, 9 Aug 2023 21:26:00 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] staging: vme_user: fix alignment of open parenthesis
 and deleted trailing spaces
Message-ID: <ZNPoSCriq7MYOLlc@nam-dell>
References: <ZNJKTLZ62SZMM6D8@alolivei-thinkpadt480s.gru.csb>
 <ZNOizFnDXojT4s85@nam-dell>
 <ZNO8XmOpylyE0AWS@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNO8XmOpylyE0AWS@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 01:18:38PM -0300, Alexon Oliveira wrote:
> There was indeed and accident commit modifying more than one line in my
> tree, hence the "trailing whitespaces" messages in one of the commits.
> So, to clean evertyhing up, I decided to drop these commits and start
> all over again, from scratch. That way I'm sure I'm not messing up
> anything else. I just sent a fresh patch in another thread.

FYI just in case you are new with git, you can always work on different stuffs
in different git branches. No need to delete your previous works, just create a
new fresh branch.

Best regards,
Nam
