Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016ED8013EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379592AbjLAUIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379559AbjLAUIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:08:30 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821EEF2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:08:37 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35d4de84195so4123815ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 12:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701461317; x=1702066117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5X67UT48wg/5S+eDppQqxVPicA/oErz3kVT5PTAiSag=;
        b=ehX/+cx3iPY6svSaiLZ9VzvRWANI0cJqQli64GM088iKs7vFTwHY7bMzd7RNL2vvlQ
         mK5M/jAhNKEezESaxjUOrwTu+11OxWM2rkjP3h6CA6WkuR6YGfiug5tZqbqrNop9rmlY
         wMvsyxaFsyDCGKmv5xNVja5rJcjj8boCISxjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701461317; x=1702066117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5X67UT48wg/5S+eDppQqxVPicA/oErz3kVT5PTAiSag=;
        b=oXIPXMgit2LJJpJRowGllUcNxKe97UxuI921tQRTCRClKzGgQgDfRUGKWPa3GxT2hZ
         g+g5ucj2T7dN0edjVRQ0E7Hvrn8jNYkwqEZhEaTkYAycGoSCqHOxeWNlRfsXybuIXyL9
         QHTlxMbMMiMb5ryPXUzTyWE9olP5AB2K9q+er41pcRcCGAAQAeMbiN5oiqVhKUuXkrAo
         eFXEge7pvx8pTf4Bhetupxkae0cmhZt91cIbQm5jXYQdyb6y/vYy+n27daZ4joT/E9Z0
         nzsq9URVRCmdBuCHU54TT8A9dWFpu5dHqMjR/dbDoeRineg38C/3iEOABvEPFPdWZ238
         RLgw==
X-Gm-Message-State: AOJu0YwqFONLUvxaVfmPtWgXhNgATXe6Cei+O6AfMerQQcShIUSb30ot
        4aCr0KZDCXRiXwt3maS1viQJIQ==
X-Google-Smtp-Source: AGHT+IGafXXzfp/Kjl2w6ZU4AO7+2S3gpE7t2D/zhikZhTXGjbpHML5z+Irzs9a1Q+blMY1vw9EvXA==
X-Received: by 2002:a92:dc10:0:b0:35c:a639:bce3 with SMTP id t16-20020a92dc10000000b0035ca639bce3mr76174iln.1.1701461316905;
        Fri, 01 Dec 2023 12:08:36 -0800 (PST)
Received: from localhost (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with UTF8SMTPSA id bt10-20020a056e02248a00b0035cafe5d3d6sm778ilb.32.2023.12.01.12.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 12:08:36 -0800 (PST)
Date:   Fri, 1 Dec 2023 20:08:36 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Anand Moon <linux.amoon@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Rob Herring <robh@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RESEND PATCH v2 2/3] usb: misc: onboard_usb_hub: Add support
 for clock input
Message-ID: <ZWo0ZjKDsZKa6RyA@google.com>
References: <20231127112234.109073-1-frieder@fris.de>
 <20231127112234.109073-2-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127112234.109073-2-frieder@fris.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 12:22:25PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Most onboard USB hubs have a dedicated crystal oscillator but on some
> boards the clock signal for the hub is provided by the SoC.
> 
> In order to support this, we add the possibility of specifying a
> clock in the devicetree that gets enabled/disabled when the hub
> is powered up/down.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Acked-by: Matthias Kaehlcke <mka@chromium.org>
