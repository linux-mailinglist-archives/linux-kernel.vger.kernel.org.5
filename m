Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EE37A2752
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbjIOTnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbjIOTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:43:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091CF1FD0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:43:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-273e1aec35aso2192808a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694807003; x=1695411803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a6+sswFsC9jOA36RIWjPp2T/q8ZGAafBXoclkZefwbQ=;
        b=dqgnotqsnYIi5a/HnQxT9yvJWcsPXKoTbdz0zQ3erVMxfsBwebSvRgePUHaxdRP9Dz
         KfQ0n7hYc3yYHXxFyXoZealbfy6yqIvjIgqvwo04TTk1aSNEWRyjF9Dm3NCMBFRmy9S1
         yPYcNbfRDsJiH8qwyEiwdiE10W3CaKo8drpaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694807003; x=1695411803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6+sswFsC9jOA36RIWjPp2T/q8ZGAafBXoclkZefwbQ=;
        b=dLJ4n28byJfRmlL3K3R0N1cRX4vM3Qrnt+k39PqQg7uSGPJB0dO+YYAP6w9S3reGwM
         bB48Kaux1dvV8NcgkLJyn1oaw8sh1+cmHDzgr+9b+YWbMtoZCwUMVClA7+cMPoiqzYZN
         +hGKw4434uw8sG+gxuYlXXpDmosRofqJLEhcN2d7KwZfuPLjvx/R9/4sfWGMsE01uAbd
         TPX0v0sfJG91ebuz+eD0JgIlZz8XyO4uLw3UPPai6gwLaiGsfLr1WdWH7APKbQ0VLo60
         po2F8dV+x24nRW4fWv4wX3cUfgw/IZoEVPTiQWule/zVj31e/wosESQO+ussa8lR2X26
         vniw==
X-Gm-Message-State: AOJu0Yz9NF/lKP1fcf+gpPjCfG6FNtiN1gA1q76BIzbWieER7zmR38m0
        5OxcZBpl+6C73NX7/rySAdAIUUlhAplH64pQWjc=
X-Google-Smtp-Source: AGHT+IFSpBH4WxdF3BlGbEDuAyvk2UVoNFNE1yYoSuMa31xAi+uP36IkyDJkx9K3A36VzJvCVoF0AA==
X-Received: by 2002:a17:90a:f3d4:b0:274:6cd3:a533 with SMTP id ha20-20020a17090af3d400b002746cd3a533mr2314769pjb.20.1694807003442;
        Fri, 15 Sep 2023 12:43:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a199700b00267eead2f16sm3640941pji.36.2023.09.15.12.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:43:22 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:43:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Duncan Sands <duncan.sands@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] usb: atm: Use size_add() in call to struct_size()
Message-ID: <202309151243.028CC322D@keescook>
References: <ZQSuboEIhvATAdxN@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSuboEIhvATAdxN@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 01:20:14PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: b626871a7cda ("usb: atm: Use struct_size() helper")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
