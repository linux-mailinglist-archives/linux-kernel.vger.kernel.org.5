Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB00C756856
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGQPwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjGQPwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:52:21 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE348197;
        Mon, 17 Jul 2023 08:52:20 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-345df4e68afso25879245ab.0;
        Mon, 17 Jul 2023 08:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689609140; x=1692201140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVZrxPN73Cv9cNK4u8R9Vf4wszeiGMKye4mec7anPTE=;
        b=eEY3MfaswOFxNbvlQkX6KvG2damlF7kHFTcQ+bijtg1SOZvul2w4U0HyGJfkB+gNUQ
         A5h4IHUZDN5PMqcnI97lnXiOQQximq43djqJTo60bzQhhLAmdk0oQmDIRSvicBeInwvD
         A9WIgFrEYfA3zYyd/efy1CJjoGPqwgAPSt83cDXvOW6j11F97f13V7ApIHHPFBoX3lKh
         TEOxV662KCb9mGvNfyJqbuK31Jtq6x30Lr7W/Bf6AgaFYJWWNmrajtFwsbN/uW4OaFn5
         V09PGnk0prreiaeBOmrceMazNVM7AgTof0kK4zYa5xWZwOsewa7X5qIgl0FBJIqWNzcN
         QhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689609140; x=1692201140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVZrxPN73Cv9cNK4u8R9Vf4wszeiGMKye4mec7anPTE=;
        b=E7NzORwKTW8E+k6uTpiNEDKyrCeLnDIWIUtIPtj4Wo2hjYlDJsoXqz64vIMxEe0nF3
         zaA04+0Wc+ye5VAsnXsfQfDzlAZo6SGUWaGOqEiNwsqO8myWbBOwFTipLlUiksUy6AMe
         A13xQtpWDiz42+MmdLq/M7EdAS95rCNngpy/m2GYOWGqYRzbOEoALBwFN48/XYrOv/y1
         xm9BEoHzBLLOFBq9za0rTs/F3w/v04riY0zLnUTCtzh4hW5AkUtfgbR43GSE8tcqvwFc
         RJ1i+c0ETbPP/c8PJfEyoa2UNEic0bkhU6QSmpjRcFfIDF71Zu9im3bJnFOfUkwsZYwT
         jeIQ==
X-Gm-Message-State: ABy/qLZ7bVuBBTjsWBi8HVkkeHf6wZ40UdRmHtoDmCiMi8IuHybK54yl
        U4a/XtfAgLk6B+GsE+tq+kHBBvhluw4=
X-Google-Smtp-Source: APBJJlE+6OwghI/GpdJfLd7w4/xbjX6m2LPCI/iYmBJtXkz2cysco9+8ShrgbB41SbVhuLgw3dkQjQ==
X-Received: by 2002:a05:6e02:152f:b0:348:8b42:47c with SMTP id i15-20020a056e02152f00b003488b42047cmr167195ilu.17.1689609139764;
        Mon, 17 Jul 2023 08:52:19 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1e30:2510:1b57:a9cd])
        by smtp.gmail.com with ESMTPSA id r4-20020a63b104000000b00553b546a638sm12865398pgf.67.2023.07.17.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:52:19 -0700 (PDT)
Date:   Mon, 17 Jul 2023 08:52:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 2] Input: gpio-keys - convert to dev_err_probe()
Message-ID: <ZLVjsK06L0ED9dRK@google.com>
References: <d225a837c50e2b19a41555a8f7ce0f94b1689aa4.1689600353.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d225a837c50e2b19a41555a8f7ce0f94b1689aa4.1689600353.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 03:27:05PM +0200, Geert Uytterhoeven wrote:
> Use the dev_err_probe() helper, instead of open-coding the same
> operation.
> 
> While at it, invert the error checking logic to simplify code flow.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thank you.

-- 
Dmitry
