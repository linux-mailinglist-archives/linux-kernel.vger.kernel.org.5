Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566217FE0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjK2UPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjK2UPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:15:42 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66671D69
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:15:48 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c5fb06b131so148163a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701288948; x=1701893748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jotP4vYpPJo//cpTI3uXY4V9lpzWkYj/fK6F2WyIseA=;
        b=hcdfwa4TYcjUsd4YezCO6cbH/PkKleuvxCuGnZoxGifuXLSJvfQZOm/1KrNR32M4CY
         TzKCy+vq+86ljb5r9bxSkTOK/rwW8sUqP023BbJ0FDV+beFBFTstZ49SRNuEFe99uSdW
         2K3KvdnptVVMNAWbLYfloZ86JP7odnEBhv8pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288948; x=1701893748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jotP4vYpPJo//cpTI3uXY4V9lpzWkYj/fK6F2WyIseA=;
        b=kjmF5r+juyK09cKZCTxZqYd39wlR9aUdu4WcZeQ7hZWHESrEOwgCes5RpO6pfWgmR4
         v0b7PawYDSFXjueBH/8ZErLURMpYXTiy6Zh82mGvsGOBRuZo7czyftBNibeDqT6KiU0V
         YkESnME+1/j4oGWBUU8tSYSaTfPtd6ZMDar7u09UEHfQ2S4Gw5Cpg1thkW9+awX7v9g8
         NnMC8rD/1xO40L8EsTBm1/x8obd3TOecZmKHPY4uYRchu9zokXBlCs4sZyI18BLB7fvi
         IeTO+o7hP6Ex9tJeL6jZxSlcf8Z22x/t/grsRZX/1FINvdcl0duBcNEM6SZR8A1Us2ul
         cT3w==
X-Gm-Message-State: AOJu0Yxvi5LulPS0nPzZnCBu0CwlDnYopqpsHyyghFOe8OUWyW5cVViT
        UGJ7vs0IgUNq5RyCRphX7BYhzA==
X-Google-Smtp-Source: AGHT+IG534o8LlbEMOfFzpwYToM7hK+n/JXeWeW9JF2pDdVckMCGK6vCE97PcNRJj6shzwBCP8zRfA==
X-Received: by 2002:a05:6a20:e113:b0:18c:5c04:a55e with SMTP id kr19-20020a056a20e11300b0018c5c04a55emr17283060pzb.49.1701288947811;
        Wed, 29 Nov 2023 12:15:47 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7850f000000b006cde291d429sm194972pfn.39.2023.11.29.12.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:15:47 -0800 (PST)
Date:   Wed, 29 Nov 2023 12:15:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: Replace zero-length arrays with
 flexible-array members
Message-ID: <202311291215.9BBCD8E@keescook>
References: <ZWYv/ywR/qxUhVSU@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWYv/ywR/qxUhVSU@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:22:55PM -0600, Gustavo A. R. Silva wrote:
> Fake flexible arrays (zero-length and one-element arrays) are
> deprecated, and should be replaced by flexible-array members.
> 
> So, replace zero-length arrays with flexible-array members
> in multiple structures.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

These look like straight-forward conversions. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
