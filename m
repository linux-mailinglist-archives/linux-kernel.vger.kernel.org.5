Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABEC80417A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjLDWRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjLDWRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:17:03 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65BB10F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:17:08 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d001e4cf7cso21071525ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 14:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701728228; x=1702333028; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hFGpzU5KwhNmr20zuJNlExzeMs3xxo7WpAsEm8UJ2O4=;
        b=MHkl++BA9bNNxE03haUv5jX4phvwJSFojRNF0vrQiUp9gCuRK0sGZWbzCJS16xRI2Q
         z9G12BrxasH7B+BArcwnXU9inz8mPoCQYTBhvVSVwkYcabqRNj3Z2laLK5fI10rGju4O
         qnkvq+Ce+DwQmSlhzuVT6QcEHVMfM8Bh9uWcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728228; x=1702333028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFGpzU5KwhNmr20zuJNlExzeMs3xxo7WpAsEm8UJ2O4=;
        b=cVvft71esEblygP6bbkbCW+OJJZx6QLta6zXd4NWONfdong7WxITbJes6t46rXHWyG
         bAIS09Jswjtfb2dEoLTKe7dRK4QUL74j7cJyvpSHIc9gvuugMTK0DHk/tXGsNPW5iEgX
         3cx3OrZvHi10FA50KcQuo2sW2IgxpO/szyE94hhOc0WU++xCVoTX7H0m3ktNQX0UuKQ2
         YeIpLscDGm0Ic5rKjmJM7Hwq+KyW0rU6xeFfJOa219cxubZWAAgBQMLigjL6hXTFvRl/
         zw05LK4MKUeVC/XQv9XGKDsLOhlR4/rcvr4c5Ti7IOGKq6AZmdNeNIwNC4phTjQBy49x
         y6uA==
X-Gm-Message-State: AOJu0YwH7exjxzFERdlAHS+tqeCozYIrN/0r+7gVyVKdqy2GCuOAT12s
        OLQwD2Az/5S9I3VHyu2XcI4/vw==
X-Google-Smtp-Source: AGHT+IGhVQvjJ/un+BNNpI81xkQ/mxT2N3RFluRNHrDTDZt40pDlkYkg5OMdQ3g5vmIN6SN8Nk525w==
X-Received: by 2002:a17:902:a585:b0:1d0:6ffd:ae15 with SMTP id az5-20020a170902a58500b001d06ffdae15mr2071582plb.124.1701728228199;
        Mon, 04 Dec 2023 14:17:08 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902684600b001cf5d4f8f26sm7124981pln.248.2023.12.04.14.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:17:07 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:17:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 12/18] sysctl: treewide: constify the ctl_table
 argument of handlers
Message-ID: <202312041416.9336746D3@keescook>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-12-7a5060b11447@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204-const-sysctl-v2-12-7a5060b11447@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 08:52:25AM +0100, Thomas Weiﬂschuh wrote:
> In a future commit the sysctl core will only use
> "const struct ctl_table". As a preparation for that adapt all the proc
> handlers.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Kees Cook <keescook@chromium.org> # security/*

-- 
Kees Cook
