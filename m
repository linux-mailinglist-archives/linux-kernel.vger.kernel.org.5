Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F87F7E83F8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344246AbjKJUbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbjKJUbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:31:31 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7036C39CFA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:52:34 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-280c371ff69so91220a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699627954; x=1700232754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCYW7xe4/6WtMRC077jmdho114qUuHMiZgjwwKBclXc=;
        b=djPrlP2HKEtQ2FxiU+Shp9adfBl0AveHDgm1lJCpM4LHc25UYMoTjpI47PVMAk+rBu
         0spuo6lWfexpzw8+5EYzrVY1QDllckRG3cmXR7ONSuwxg3DXgRleSVO5mei++p+niim6
         FmuDS4zaJauQCwJXhB80yDGWa8SVJlFK38l9CJipFMyVN9bGSwUtyX50B6Ro5uZIR1mx
         anS8oX7YZ1Yc2h4Qr1k3eVh430SH+OeF95JEJnGtFS3j0suQRz650IhXt03f0WDDZ4lq
         VmjUogrNW1xPCUgefqGWN+dUa2B8qFA5B2hQ0jC4P55rXnxalkEGw0jlw2FuqkrH+8YS
         sN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627954; x=1700232754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCYW7xe4/6WtMRC077jmdho114qUuHMiZgjwwKBclXc=;
        b=DlT2FpF2t+TnoTW37UGprs9268fgd606iI0p8jf31qwci+OpHTVjYHD/YqTypcn3ou
         a7+RX3+jF6amccYxIWgnU7gO33W3whL4kfZXtKmwt/4i7Rq0NOp2ZvfBxCjd/7mdNPN+
         RA7xleAM5Z0n2AcMgtPPZwz3xwTnkPIW9LxkDBqZk/Tl24FVima0ZFI6i9/phwT/+hd+
         2JIIt6aL1BQgQYpiJlXKo9mfBC1tHySh56aajapiByg35bc1PtarwcAbUbZFcDsuZP2T
         feKe9iexveEhUyKY8WzdLaAq++VpPsjTURszaA3dRDW5VJIa7i/W8leMXfJzRW10sWLP
         XYNQ==
X-Gm-Message-State: AOJu0YyPt4OQjyW3xbj/VIMV50yScGvTD0SjUgGqogTN3nPJKH0CMvIo
        MpSQAGPTyomwfeZ7/6rVJ0hEstbMqe8=
X-Google-Smtp-Source: AGHT+IHeslzBkBgaKXUFscEMuU7zc4TueGrQxq0vGUGBzwH+9fs6mWgegO6Phe2dlCQHiHyxNO18cg==
X-Received: by 2002:a17:90b:2b86:b0:280:2bcc:65be with SMTP id rs6-20020a17090b2b8600b002802bcc65bemr7838853pjb.2.1699627953730;
        Fri, 10 Nov 2023 06:52:33 -0800 (PST)
Received: from visitorckw-System-Product-Name (IP-216-168.cs.nctu.edu.tw. [140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d20-20020a17090ac25400b002777001ee76sm1710908pjx.18.2023.11.10.06.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 06:52:32 -0800 (PST)
Date:   Fri, 10 Nov 2023 22:52:29 +0800
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] platform/chrome: Implement quickselect for median
 calculation
Message-ID: <ZU5DrcuiVolHpY4Q@visitorckw-System-Product-Name>
References: <20231109185439.1535962-1-visitorckw@gmail.com>
 <ZU3GbHTA3x19h2Zi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU3GbHTA3x19h2Zi@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize for all the foolish mistakes I've made.
I'll separate this patch series into two patches and submit v2 later.
