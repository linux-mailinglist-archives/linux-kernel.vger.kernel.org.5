Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975B87D7D66
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbjJZHKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZHKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:10:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953F518D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:10:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-408382da7f0so4344735e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698304201; x=1698909001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c7fEK5aXyqEKNX44SGAggLq1zICRl4jXqY0Tzaon+wY=;
        b=Hh2frqlbTmS+SAF6Sj02GcbyUbHD67lgvOaVCLfTEGTupG6gmvUWwXDRVMz0mkT7Rt
         hbIi+zEg/KDoeN10DR0Qkav9iBpzLiPLQQ0qYY4CFJUOhQddEdwNzC/k70Of17ZdU1ij
         cPneWckHn50q+Sx+AJTrGKkor/rnUi1HZYg5b8FLu9oPkRINohZtEFiy1B9CEdpdKoia
         0kneXaXJDbelN8dm8muHSC2sSj0RiqQV9vhlJed9qp1qymFVNxZvE5vytebJDX4uN2sU
         m6Dt0JzT3QOkT3bmjbonmdKA6BivS8HLmKYg/al+Xqd5OwqOekdVWM7XQQdrwDcIIQ1v
         fSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698304201; x=1698909001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7fEK5aXyqEKNX44SGAggLq1zICRl4jXqY0Tzaon+wY=;
        b=EHyvuTcluwPYERWF/52OZib3CKwTDR/UxQK6Tuc184kvGZIBCvjiQLbsnEGVQYC3we
         6gHg7OrKpq7eyCkxC4EIE13IajAcyWwAlTNa+m/SMb09PXieTK1Wq0gbiPVLuaVOzMZC
         eKLFVlVx5MFtNhRNRjlfZfBQlLZlWjzlhs9lBEcNpGosZZoMYeRNTRuWBDT/RXCKoT6b
         2vInnLBVqxZ6DFsV6u4YWOebtwrV6VnaNHi8bgFqC1iVoV7AGLrfyLuzDQLYxQdbM5op
         bCKCq25RqZ9KEvVn/JVLbx06jZaxY26zqz+JlsxqjgMpt67S4jm0WRxRryFLp0Ngc2CF
         EAKw==
X-Gm-Message-State: AOJu0YzBsW34F2WRop67pY6nHqJ3kgrQORdfcrJ8bfvXn4tf+BFOxtDr
        cKwqwe63cw2qP3CWEhQnmPpLeQ==
X-Google-Smtp-Source: AGHT+IGaxyNX9QK9vfCs3UP2UmC2UTrq44i+jptffy+/gtg0PWTyu6iNg8pwtl+f/kkIMVqoQMPalw==
X-Received: by 2002:a05:600c:5493:b0:406:5463:3f51 with SMTP id iv19-20020a05600c549300b0040654633f51mr13710896wmb.25.1698304200933;
        Thu, 26 Oct 2023 00:10:00 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c029400b003fe23b10fdfsm1678918wmk.36.2023.10.26.00.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:10:00 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:09:52 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] staging: rtl8192e: Convert array rx_ring[] to
 rx_ring
Message-ID: <e9bcae14-4667-48af-b7f0-1e4fd9bd9560@kadam.mountain>
References: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 07:43:26AM +0200, Philipp Hortmann wrote:
> Remove some functions that always return false or zero.
> Remove a loop that is always executed one time and convert arrays to variables.
> Remove some unused constants.
> 
> Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
> Transferred this patch over wlan connection of rtl8192e.
> 
> Philipp Hortmann (10):
>   staging: rtl8192e: Remove HTIOTActIsDisableMCS14()
>   staging: rtl8192e: Remove HTIOTActIsDisableMCS15()
>   staging: rtl8192e: Remove HTIOTActIsDisableMCSTwoSpatialStream()
>   staging: rtl8192e: Remove HTIOTActIsDisableEDCATurbo()
>   staging: rtl8192e: Remove loops with constant MAX_RX_QUEUE
>   staging: rtl8192e: Convert array rx_ring[] to variable rx_ring
>   staging: rtl8192e: Convert array rx_buf[][] to array rx_buf[]
>   staging: rtl8192e: Convert array rx_ring_dma[] to variable rx_ring_dma
>   staging: rtl8192e: Convert array rx_idx[] to variable rx_idx
>   staging: rtl8192e: Remove unused constants starting with MAX_RX_QUEUE
> 

Looks good to me.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

