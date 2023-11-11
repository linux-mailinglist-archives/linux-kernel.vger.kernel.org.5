Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E447E8718
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 01:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjKKA5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 19:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKKA5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 19:57:01 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CEC422D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:56:57 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-587b1231dbeso1362558eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1699664216; x=1700269016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WJjV0M8MGipSibP/l63xjUDxPGkLG8AjMcqPGszYTU=;
        b=tuqhm9i2u/aQ7PoskTQCu9yyc1Xbr0z8N1FpX/NJnt+Tb7RWfemd7GMxL+oCL+3c0z
         VJ9iZfdGDgmKXNccLi6CDEV49HMJD7gGULK+xPwBPAPd+jiDUGKu+7GYHP4D3cnGhX/e
         PElAtWOw1HDPcu92ZzNYAJaFCK3+aFsM/ihEYzc25ofE1JSYsoEJyHogQhzAtOJ288dN
         d23aBRx8DKj/EQwO2mPgALX9M35XdfcuTUAiH1hjLoEgEknuNoZpG5Aa9SMlx5lXBMQV
         F26o41Jdu34xXCewj0+C+8NCE/IXTY/M8Bn/FlLN5IudCqGtdchy2ftPJ9Y18llLhRwA
         LIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699664216; x=1700269016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WJjV0M8MGipSibP/l63xjUDxPGkLG8AjMcqPGszYTU=;
        b=kzsIXH52HYAa7XoPljTzaO7BFQrtiGJj7xKBVvUrGPbHZfRDre+ureJi5di57pwAhI
         4avh58SeAAbQtaScnAwnsaJ/1RbCJA/hwxHtvlF/O2p3zWqMFSMl6bVPGp1YX9vV+w6e
         bf+FYCiJvGMXWlLi5fphY2PvpfpE2c5lgx1kOVWAS4NAmhCN9WG4nCggHntPAUroVNyW
         9ytLVcPb0GwjeExbytHZ1ypmmQeUCabLFKC3Pv3+pTcY8fymk5rkQSJ5hozUHTNi3UGJ
         +kSuv1hmoO7sqlDltmg3in7ZJgreBd3zEnnIBBEFeK5lTWBF1u84XXnV9W45rEBAlupb
         7o+w==
X-Gm-Message-State: AOJu0Yx9MxfxPWkeHb5iX5kIZpCHLkvrNE3Sq1dBJoolHwgu59eNIISU
        H4cqxqDZysrbCr0A5BlP8O/7IrNTMuTWttxJaV8=
X-Google-Smtp-Source: AGHT+IGX3k4QQhob2VPoP+c6SxcbxGB2OaDpjeV49tKk6N1SJY4rWQ5U6++lwQ6APk6XaIzKjwMPLA==
X-Received: by 2002:a05:6358:e9c5:b0:16b:c414:ae2 with SMTP id hc5-20020a056358e9c500b0016bc4140ae2mr660358rwb.8.1699664216492;
        Fri, 10 Nov 2023 16:56:56 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id w12-20020a63f50c000000b005b8ebef9fa0sm295729pgh.83.2023.11.10.16.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 16:56:55 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1r1cIu-00Ays6-25;
        Sat, 11 Nov 2023 11:56:52 +1100
Date:   Sat, 11 Nov 2023 11:56:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH v9 0/3] [PATCH v9 0/3] Introduce provisioning primitives
Message-ID: <ZU7RVKJIzm8ExGGH@dread.disaster.area>
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 05:01:35PM -0800, Sarthak Kukreti wrote:
> Hi,
> 
> This patch series is version 9 of the patch series to introduce
> block-level provisioning mechanism (original [1]), which is useful for
> provisioning space across thinly provisioned storage architectures (loop
> devices backed by sparse files, dm-thin devices, virtio-blk). This
> series has minimal changes over v8[2], with a couple of patches dropped
> (suggested by Dave).
> 
> This patch series is rebased from the linux-dm/dm-6.5-provision-support
> [3] on to (a12deb44f973 Merge tag 'input-for-v6.7-rc0' ...). The final 
> patch in the series is a blktest (suggested by Dave in 4) which was used
> to test out the provisioning flow for loop devices on sparse files on an
> ext4 filesystem.

What happened to the XFS patch I sent to support provisioning for
fallocate() operations through XFS?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
