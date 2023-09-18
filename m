Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2117A5260
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjIRSxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIRSxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:53:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F41FC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:53:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fb6fd2836so4500486b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695063217; x=1695668017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fls6eHK/VoWhh9zGUQ26SVKwaVE3FE+29yF389UjAk=;
        b=XJrFjVkfuiy4JKewFTPL2JSB8KSrZGsml5EpkV+J4G7cBgKGttryVNxxXrGcFphyBH
         NoapfN6idSVrK4DAJrWdrxGLhl21qogkJUEblwIt80XlnPosafsomtl2yyQXmujT9VA3
         OgEk5cbgXUllMEM6yvoheyEmd1VpBTKgTRBrHNmJUUur2U/+unXpIRtWpx5iAXNtbjXF
         xFgfrCV/RXbBhCxEF6csL5cssVId5oa4Tf7sbGk3aFssXIwUi8WGSXydkawpZrUuwTpq
         9Pzt1NQNBc1dV6TnMa2BbT/k0QLVf4aYILlNN+h1LnPO5MNoAloAjw7waWYEoeT4rq6O
         bA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063217; x=1695668017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fls6eHK/VoWhh9zGUQ26SVKwaVE3FE+29yF389UjAk=;
        b=ukDuVVWxdV/ePwNEtRGDmspGkXCbA8VpYlOglOaMQcXfgIF6rYs2DTQkqrkS3gqbpV
         hRgd/W+iGqhOQzg7jYZrNxSrkW3BCOMMgiviAdBomsGsEVDW1NUrnrRVmA873McYJiuz
         +uufKtaY/KdsdJaJNFT18sEkGWQVI7jZO5CcLiArfoZwhQoX+aIl9FFy/ZLsg+iDezfM
         cbPt+YPV3h7NBBxaKKx4qdxVxO5k9l179l4W6e7entOQymCLqxx8g97K8u6xf/2nJsK6
         ziDlBPdTKyVeE8GOYDpXOuuGc+ekTNndSGeCulUX6EaPCZcsDA0nS6rvjJ9ABMp2iZ/T
         +tcg==
X-Gm-Message-State: AOJu0Yya1ZKjx60HFOF8LhS0cBJRUqvikhMKPUCnM7fKTZCa09eRsJs5
        Ng4EuxSUp391kr2pu28qS3857kVgLFoi/Q==
X-Google-Smtp-Source: AGHT+IHdtF39bermYxStiMRc63GXFpRbrmwzTvTuxtLBUIjUdiMZYWagvfr8wBei9OeO423S4YVjAw==
X-Received: by 2002:a05:6a00:3994:b0:690:2ecd:a593 with SMTP id fi20-20020a056a00399400b006902ecda593mr11452907pfb.26.1695063216635;
        Mon, 18 Sep 2023 11:53:36 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id ay8-20020a056a00300800b006906de1b981sm2961901pfb.179.2023.09.18.11.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:53:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 18 Sep 2023 08:53:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix missed pwq_release_worker creation in
 wq_cpu_intensive_thresh_init()
Message-ID: <ZQicr0tJPPLGaKq8@slm.duckdns.org>
References: <20230911082722.453-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911082722.453-1-qiang.zhang1211@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:27:22PM +0800, Zqiang wrote:
> Currently, if the wq_cpu_intensive_thresh_us is set to specific
> value, will cause the wq_cpu_intensive_thresh_init() early exit
> and missed creation of pwq_release_worker. this commit therefore
> create the pwq_release_worker in advance before checking the
> wq_cpu_intensive_thresh_us.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Applied to wq/for-6.6-fixes.

Thanks.

-- 
tejun
