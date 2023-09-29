Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87287B38F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjI2R1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjI2R1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:27:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3EA1BFD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:36 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c752caeaa6so103245ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696008396; x=1696613196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgWJstEGJd48Eg1HdzFdOilLMPMqmWhwLsi9bYeQl7s=;
        b=R11ri71zTmA5emJGU5mz5LjwNMZA1cCORaTtco5nfVll1TcZLsagRgajqn5QjUsLdL
         bO/I3H/6VJpyCkesYCHixGyzmUnW8GtEREaPiLSeh26totC5vRaBm74rQviNDNsuVMYD
         PEd8RePwhMCbAyOVm36MobRdHCt+WR3Dr2aJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008396; x=1696613196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgWJstEGJd48Eg1HdzFdOilLMPMqmWhwLsi9bYeQl7s=;
        b=ZtI757WJGhsndTH1MIcQEpciu3XjBLAEZWjjtES6fuycbjkaIMFIEilE+WtDgKiGCi
         5yUbtFT1KegjGx5agK8vQTkA/+u/8y4ROyHWjcEsGUcRBGbq67atXA4BfQgP1Smie+Sf
         MQx0kLxHae46te5EBoDz7Vyb5MPAakhdvEVRbn/qFOr7g6/GN+1OlWzn92eAXKeetds+
         CthIhASvCAC3+VPDeVfpYhnJSoohT6M+6Zz1I/UrnuuFY2Boeo3t0tTkY6V9nEKeHU4c
         8tJ+TD/0RqHRI5v73v2rSgw2xYvsg7FGZvrFRoE/xzKdzQrJaxCDkXkvAXwtCYWB/Ntt
         FlVQ==
X-Gm-Message-State: AOJu0YwbTw4vgaVx0c8EvpO03ChnCVVoRxyrcRSIu9v7u2Ij/i7UHYCV
        QXwiCqV89d5xZUWDfw4MWASodQ==
X-Google-Smtp-Source: AGHT+IG3mCcEa8WVJpFPvOj0b5dGwRnh2/1kFQNVIYL87dKwC/DqhQALhB/xIzmN0rioBZhmbty5Cw==
X-Received: by 2002:a17:90a:bd8d:b0:268:e5db:6e19 with SMTP id z13-20020a17090abd8d00b00268e5db6e19mr4483958pjr.20.1696008396220;
        Fri, 29 Sep 2023 10:26:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id oj3-20020a17090b4d8300b00276fc32c0dasm1701460pjb.4.2023.09.29.10.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:26:35 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:26:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: 6fire: Fix undefined behavior bug in struct
 comm_runtime
Message-ID: <202309291024.14F6DA0@keescook>
References: <ZRb0WiViajjqcyKT@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRb0WiViajjqcyKT@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 05:59:22PM +0200, Gustavo A. R. Silva wrote:
> `struct urb` is a flexible structure, which means that it contains a
> flexible-array member at the bottom. This could potentially lead to an
> overwrite of the objects following `receiver` in `struct comm_runtime`,
> among them some function pointers.
> 
> Fix this by placing the declaration of object `receiver` at the end of
> `struct comm_runtime`.
> 
> Fixes: ddb6b5a96437 ("ALSA: 6fire: fix DMA issues with URB transfer_buffer usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Should these mention -Wflex-array-member-not-at-end ?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
