Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED8979DC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbjILWor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjILWop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:44:45 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBBE10EB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:44:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so9079645ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694558681; x=1695163481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ah5Op9UHzow67q6STiy57YfblgAJa0Z+MzvCC70G7KA=;
        b=jNrYjBG/wjffg70U1TBRnyQx74GjrLWbL9+B4S24Xlc190bNhNUX11uVMIoo2WoMGn
         RbXYIME3rJfjszbE4zOAPsPoIS0mhSqjDBepBhGyBRj7bzmJ0IV1dR2VNvLAHOlrqly+
         TTTegmVLNml1EVQInH+mJ4reT33aG/vthATMp8eDuDCCarE2N3tz+/eSAfDXowu+gYi5
         cnB6hdnuz+6Vk2nrbXv/9KsinxVxCZle2d2+ScpPe+8UtovNpmt+3znnhGFr36rizLWQ
         hXOUw6YVaPUYvHeSoyoBJuuJs1KSXjQBjWMxxAAtNBfNIvYIqewLwmna/y0l2jUi/JPu
         QtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694558681; x=1695163481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah5Op9UHzow67q6STiy57YfblgAJa0Z+MzvCC70G7KA=;
        b=TC408P3xdAdBUg45AkGaXVNlRmkphD/3+j3p1VrGVMIspIhrz7p6+pjiE6PtKasZBf
         F/Swiwm10cLUBNJkF6SMrKvsyq3oftHsEzo1ThAUqR2NPJ6EmJ1vj6LRWRlcjIJqT/5B
         sSIiRX/4NVDBjuOuYcOYs0EodPhi2UybKVsauCRo5Dy0s/fsqOcDbLeKDO0YLvY4VvKX
         P3xCZ/55htM3KxiEDtmC586jl5RzDqno6MLajdm9HCynJtctRltizXIQ3E3Hu8bZOjfy
         JA9HStdfj5QMEbNZLYlwjzCgCAOFyBRtAYtM7RpEl60+sIgjleCvfTZC5blGYRgDCxW2
         A/Vw==
X-Gm-Message-State: AOJu0YzEukSbUFDQECIkcaZEyxEFqfFFGd+LH7j8YIPTKHBUXwgzlxrz
        lTBDosS680xGYVsfT3Yp48bw+g==
X-Google-Smtp-Source: AGHT+IHBXmbSUte83WfShO2qynzMF12my3Babt8JezgZzeHlmJ5Kp5tUIevLyDLaZgj1jaa/IH5ZVg==
X-Received: by 2002:a17:903:120d:b0:1bb:994c:bc43 with SMTP id l13-20020a170903120d00b001bb994cbc43mr1283734plh.18.1694558681467;
        Tue, 12 Sep 2023 15:44:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001bba3a4888bsm8957634pld.102.2023.09.12.15.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:44:40 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qgC7Z-00EPVj-2t;
        Wed, 13 Sep 2023 08:44:37 +1000
Date:   Wed, 13 Sep 2023 08:44:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Wang Jianchao <jianchwa@outlook.com>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] xfs: use roundup_pow_of_two instead of ffs during
 xlog_find_tail
Message-ID: <ZQDp1fNUgmJevXLr@dread.disaster.area>
References: <63b3742c-0efe-c096-c737-a0e0419480bd@outlook.com>
 <CY8PR05MB9378060FDF6C7E15589EB668CDF1A@CY8PR05MB9378.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR05MB9378060FDF6C7E15589EB668CDF1A@CY8PR05MB9378.namprd05.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:20:56PM +0800, Wang Jianchao wrote:
> 
> In our production environment, we find that mounting a 500M /boot
> which is umount cleanly needs ~6s. One cause is that ffs() is
> used by xlog_write_log_records() to decide the buffer size. It
> can cause a lot of small IO easily when xlog_clear_stale_blocks()
> needs to wrap around the end of log area and log head block is
> not power of two. Things are similar in xlog_find_verify_cycle().
> 
> The code is able to handed bigger buffer very well, we can use
> roundup_pow_of_two() to replace ffs() directly to avoid small
> and sychronous IOs.
> 
> Changes in V1:
>  - Also replace the ffs in xlog_find_verify_cycle()

Change logs go either below the --- line or in the cover letter,
not the commit itself.

Other than that, the change looks ok. The use of ffs() was added in
2002 simply to make buffers a power-of-2 size. I don't think it had
anything to do with trying to maximise the actual buffer size at
all, otherwise it would have made to use fls() like
roundup_pow_of_two() does...

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
