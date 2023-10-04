Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48A07B79E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241516AbjJDITg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJDITe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:19:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F20783
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:19:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4054496bde3so17911505e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696407570; x=1697012370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8z/4YehLMwn0d5/6ji2uFPyw6gM7Nr4mX0lM3QuniaI=;
        b=IOKooFediiWxAacIeNiKMXdLvpLokTM+IgYo9nY26NF+C6W3XgtqjYVaMWqSbGsejq
         VVaywXi8djUuhSVGVlhbjTyjlMszS1XBKdTViMuMDUOAIwSel+Gjbz8NWB8uzHDpp1Mo
         C6ibbWiJn0H2Q274kHxq82MhE0SRMasE4P2foyQF1O9BvUanqHkHrJdUxBHQZK8FD9VJ
         NmcmsU31soUYVu0NDVMzmQ6jLkf9jXMkz+D6paLitQqg+s6rHQ8xR8pw5/KxhBVAQxbP
         5XMLkA15KzRt/g6JVO2vDWdfkTqTbO+5/NPVBS3JAPnQ1N8hVPNNIgZraWoIktihAbRm
         5vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696407570; x=1697012370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z/4YehLMwn0d5/6ji2uFPyw6gM7Nr4mX0lM3QuniaI=;
        b=bogZEb2IJH7ztStYHujs8+ydrbGfl9p9F+mt3sPDmKF10aJIa5esHgZG/8UeHUjb0w
         N/I9DiPA6nRzuOC9HXFW/ZQsYDz3dmF76rTTTv4GHno9Ih7Kh21ImqPf4lYh/d7DYyxe
         Jl6HlrIIy43VLcCuMH92PAQr/aMJEp6tA5MwTwnedT+VDdX9TDBt7/JViYpRe4QsvHBN
         wSFmY9ShtyMGm8q5ZvQp+gE4Dt/CLDlzhI3NDvVFnVeCSWIZxFuIE7Kx5vIqYAGsgBA0
         x3JxgcD0Q/bfS6flFy0jL8aqHiRZqGPWU1HVY4D0e7U4SC6ds+dar/OUOR+x1PS4EV9q
         JX9A==
X-Gm-Message-State: AOJu0Yymy0mAHUyxA7lEmLOMikVOhoLFUglx03k7sCch5AHe7Iytssge
        N+pGkFGhvzD9j58GKEXjsy8lFdQy2phYLF2YxMM=
X-Google-Smtp-Source: AGHT+IFK4nCCGrfSXMqGa0esse8M51syZ49qBeOft1p8FRmhLG4m7dAiNa1K2GCEy+d277Nub/Qn+w==
X-Received: by 2002:a7b:cc8f:0:b0:401:dc7e:b688 with SMTP id p15-20020a7bcc8f000000b00401dc7eb688mr1540088wma.6.1696407570013;
        Wed, 04 Oct 2023 01:19:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z9-20020a7bc7c9000000b004060f0a0fd5sm892268wmk.13.2023.10.04.01.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:19:29 -0700 (PDT)
Date:   Wed, 4 Oct 2023 11:19:26 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] staging: rtl8192e: Remove unused functions related
 to removed reset
Message-ID: <755719c2-c42c-426e-8e2d-09ffefd9e028@kadam.mountain>
References: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 07:53:01PM +0200, Philipp Hortmann wrote:
> Remove unused functions rtl92e_dm_backup_state(), 
> rtl92e_dm_restore_state() and rtl92e_cam_restore(). Remove unused
> variables. Most parts are leftover from the previous patch series.
> 
> Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
> Transferred this patch over wlan connection of rtl8192e.
> 
> Philipp Hortmann (8):
>   staging: rtl8192e: Remove unused function rtl92e_dm_backup_state()
>   staging: rtl8192e: Remove unused function rtl92e_dm_restore_state()
>   staging: rtl8192e: Remove unused function rtl92e_cam_restore()
>   staging: rtl8192e: Remove unused variable last_ratr
>   staging: rtl8192e: Remove unused variable rate_adaptive_disabled
>   staging: rtl8192e: Remove unused variable rfc_txpowertrackingindex
>   staging: rtl8192e: Remove unused/constant parameter mesh_flag and
>     shutdown
>   staging: rtl8192e: Remove constant parameter from
>     rtllib_stop_protocol()
> 

These all look good.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

