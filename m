Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295A7802B70
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 06:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjLDFvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 00:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDFvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 00:51:44 -0500
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0394995;
        Sun,  3 Dec 2023 21:51:51 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d06fffdb65so5728555ad.2;
        Sun, 03 Dec 2023 21:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701669110; x=1702273910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5NL1uLbK1sraymfKNrOvxe7Sa8n3LFnFTQyyc1u0ww=;
        b=KO+gOA5dj+q71tdMLaHnSwE29D1XAGoUpfr2dOQy0N+1ooVDQLd1S8Qn0mjRHLSAVM
         auWKG3+nvR0zmu7JBMlK3Jr/9b9Vgrsh/E3FAunzOnQd1Fesa4EDJqPoSHzh9SEW8dnI
         97VSyvRhf8QNzul5cOFwDf2viIyd2jXQd6CnBseLRdPTdDyPjBkdDot7aFOh9pdAxG4n
         qUMsbcRfAMO/UcoDKt1nJWwYsEdtnX3dyD2YlEGUxpiwF7b0NKKKFZEOSbGTkWZdztPQ
         QII7mMN/j5kC7En1TG3N7WuIHqzBA0UpAafpb5angjUGYonoiHIeEHXhmwqC1c6fGXBJ
         dz1w==
X-Gm-Message-State: AOJu0YxD0jS8zG7SAm1uUVmXcamNC1jvYxxfmMuIM1zG8D1J0rNEBChL
        Xs2j9IddfMMlMhsjUwsS0RY=
X-Google-Smtp-Source: AGHT+IGCofZ1dgGhh+eMRezv6qFp+yg7XDqPo2+biNkr0GatXm3CMm2KdspU9geYBUSBxJiBPhRMJw==
X-Received: by 2002:a17:902:eac2:b0:1d0:6ffd:6e91 with SMTP id p2-20020a170902eac200b001d06ffd6e91mr1132480pld.137.1701669110354;
        Sun, 03 Dec 2023 21:51:50 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902d2c700b001cc52ca2dfbsm7534147plc.120.2023.12.03.21.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 21:51:49 -0800 (PST)
Date:   Mon, 4 Dec 2023 05:51:48 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     pmartincic@linux.microsoft.com,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC
Message-ID: <ZW1o9BviMl35Da7A@liuwe-devbox-debian-v2>
References: <20231127213524.52783-1-pmartincic@linux.microsoft.com>
 <ZWjfm25xAqvbQYSf@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWjfm25xAqvbQYSf@boqun-archlinux>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TVD_PH_BODY_ACCOUNTS_PRE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:16:43AM -0800, Boqun Feng wrote:
> On Mon, Nov 27, 2023 at 01:35:24PM -0800, pmartincic@linux.microsoft.com wrote:
> > From: Peter Martincic <pmartincic@microsoft.com>
> > 
> > Hyper-V hosts can omit the _SYNC flag to due a bug on resume from modern
> > suspend. In such a case, the guest may fail to update its time-of-day to
> > account for the period when it was suspended, and could proceed with a
> > significantly wrong time-of-day. In such a case when the guest is
> > significantly behind, fix it by treating a _SAMPLE the same as if _SYNC
> > was received so that the guest time-of-day is updated.
> > 
> > This is hidden behind param hv_utils.timesync_implicit.
> > 
> > Signed-off-by: Peter Martincic <pmartincic@microsoft.com>
> 
> Looks good to me.
> 
> Acked-by: Boqun Feng <boqun.feng@gmail.com>

Applied to hyperv-fixes, thanks!
