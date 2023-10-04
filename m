Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452A17B8C69
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245435AbjJDTOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245299AbjJDTOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:14:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7511716
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:07:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso129940b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696446452; x=1697051252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mmNik5aKqwyxs68unDpIIbqTko6Y8PdAAVqQYM1wSd8=;
        b=QwyRqMqssGqkyrhJjcrLTlV4CoFFbxXkgVLWksi9ED+6GOCAcjGhxMK79Bb6GjfMG7
         b8BSqYg8Hqy8ENkxmPppJKXEhWefJOfZevSFO/o7FhyuDOiJF8LYAGZtAwL0uFdUaq0u
         DAPWne7rZdFV5XgDP4y9gN3egSmuUhT2Astso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696446452; x=1697051252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmNik5aKqwyxs68unDpIIbqTko6Y8PdAAVqQYM1wSd8=;
        b=lujPWrxA5RQCTiM6Wg+3tAOck2v8pJT/P/agzLOaYJIICP8yAMVFQVkoVi6B9TR61t
         Mjco6B0RD+qk1xo8BTwaNTqrCuPrv9LfEidC7350M/T2Ekf6+P1MtC8oesZibTKip2MT
         RI9Z6WxMQrBShNHuxYL6yqgO+Au4AcfE3mm9eLArrzrIz226BsNxnnGK9Bee8KuVBoY9
         7T5hQ1KRcmVMxUx9f+QWNH0FCltPphV4eVKzavYxftg3PQScUWmHcuHwY5++E6IqwAkl
         BTdfVfKn8GS3qY09bY8UjtAVyAPQhq8maisJZUYjDR0dwTVnZ7gjQPcnTu/Nw6nUheKm
         gn6g==
X-Gm-Message-State: AOJu0YxMxLlQEpcY1lAHXuo8ZWkK1YraduwXT/CJfQYMJ6RA93R7EkZt
        dp4ILdjYbl7vn5Us9nq9k1qfGw==
X-Google-Smtp-Source: AGHT+IH2zJUqh9x6F0RceLYlBv/BSl+4IpxiNNAbI4M2CvVxq/jsPEavCuV+UdE3lk2GCtDpPmoTNw==
X-Received: by 2002:a05:6a21:181:b0:13a:6bca:7a84 with SMTP id le1-20020a056a21018100b0013a6bca7a84mr3886938pzb.44.1696446451736;
        Wed, 04 Oct 2023 12:07:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006889664aa6csm3576439pfv.5.2023.10.04.12.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:07:31 -0700 (PDT)
Date:   Wed, 4 Oct 2023 12:07:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 62/89] pstore: convert to new timestamp accessors
Message-ID: <202310041207.A2F1A4E0@keescook>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
 <20231004185347.80880-60-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004185347.80880-60-jlayton@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:52:47PM -0400, Jeff Layton wrote:
> Convert to using the new inode timestamp accessor functions.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
