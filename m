Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998AA7CFB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345703AbjJSNsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345498AbjJSNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:48:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E344D11F;
        Thu, 19 Oct 2023 06:48:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b26a3163acso5365522b3a.2;
        Thu, 19 Oct 2023 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697723280; x=1698328080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BliccIy+de7xYxoFZodWYzkchyJ1PaiIyTfG2nYkRFE=;
        b=gqqEwHzbG0McYFx8GMqTPSWdCip0PYCi1yNxGxhRtvzOOokj98T49P5qJBZPFOQNml
         x8JL/lKST7uBxTGDXVCGymUPd1FQG1TEf4krgedZJVy/qouOOkGHZ4m+xZsgMzP1yK7b
         iNFLFItN37OwrO/piP4Y6coMVmqLMmrtYnQsBhCIBSnkBePOOFmHM7gvgHjLgkilG2YL
         oDJRJ13sRboFvJDFRv5C6XWWTi20HuAIVNPH3rwIlR2hS7RyIUY2DVAS5xLCeZlqYCP4
         ZOhCpIGjSsUSEEslHEvawchRJLZFgiHY9v4RExNexEeV1LmZFsW97OxFzR6AXG5yG1fX
         j1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697723280; x=1698328080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BliccIy+de7xYxoFZodWYzkchyJ1PaiIyTfG2nYkRFE=;
        b=qYpd6UQ7Vx2IHBI1i94FtB/AtmrduxLZ5B7MOT7nbapyXMYckeI9PLnn7k1Woz+J3Y
         gl/4fPBKHKMrgH675vNn0uIQmxhL1Ty8vWsSZT+OTuW5mgs3S0wOxICdJxYgqBkT3gx/
         3avGrARrApw4ybPwUB/sxTYrzNMGD+VqgezKbkiXmp78zPrqRA5O+nOaz9u6wTXlkYMB
         5ErjEtdnGxHW+35setK1dqXw6iYgzPFo9Sc/NMQ02W2owIzfpJwwMAPZZbJFd4BjBpgT
         LkM8upLQMDvk+GyioK33243hSwH+nQhRbgqL9iTaGyXAFOw/BKRHB8Qym1w6Zsv6hmfx
         AfgA==
X-Gm-Message-State: AOJu0YxUGKrJ3lCa/xeqDNcF54sl1AG09Zryt+2qzUHLp6RnDQVX5k/l
        dCtIJ3XipNFck0IM/tKSv9ZkJ9rYjZJkFQ==
X-Google-Smtp-Source: AGHT+IFls3pZjV2ctOYZBjQmps7xxPwUMRdJUFsqmphuiHlQtlyJ71NSndQuEO/mqkcOewM5dQq+Fw==
X-Received: by 2002:a05:6a00:1408:b0:68f:fa05:b77a with SMTP id l8-20020a056a00140800b0068ffa05b77amr2241339pfu.31.1697723280325;
        Thu, 19 Oct 2023 06:48:00 -0700 (PDT)
Received: from ubuntu ([122.167.60.51])
        by smtp.gmail.com with ESMTPSA id w28-20020aa7955c000000b0068fe76cdc62sm5252528pfq.93.2023.10.19.06.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:48:00 -0700 (PDT)
Date:   Thu, 19 Oct 2023 06:47:55 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Simon Horman <horms@kernel.org>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH v2 1/2] staging: qlge: Fix coding style in qlge.h
Message-ID: <20231019134755.GB3373@ubuntu>
References: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
 <cec5ab120f3c110a4699757c8b364f4be1575ad7.1697657604.git.nandhakumar.singaram@gmail.com>
 <20231019122740.GG2100445@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019122740.GG2100445@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:27:40PM +0200, Simon Horman wrote:
> On Wed, Oct 18, 2023 at 12:46:00PM -0700, Nandha Kumar Singaram wrote:
> > Replace all occurrnces of (1<<x) by BIT(x) to get rid of checkpatch.pl
> > "CHECK" output "Prefer using the BIT macro"
> > 
> > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> 
> Thanks Nandha,
> 
> these changes look good to me.
> But I would like to ask if not updating
> Q_LEN_V and LEN_V is intentional.

Thanks for the review Simon.

I have already sent a patch for Q_LEN_V and LEN_V and it is accepted
by greg k-h, so didn't updated here.

regards,
Nandha Kumar Singaram
