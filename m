Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B01A759D6F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjGSSfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjGSSfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:35:15 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EBC1FDD;
        Wed, 19 Jul 2023 11:35:10 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-565a8d9d832so19121eaf.1;
        Wed, 19 Jul 2023 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689791709; x=1690396509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2abvvyLPjfrwEoupsEOTHIOOMVyeM8JABW3sZpsX+c=;
        b=Chuf4XrWiNI7GbdlQoLbjIxxVRqU1yzyfCDc4BQIjKBgDx2WgfJQcj4NUjz0nCS3ek
         j4jESGCDHbPCBUNw51V2wD3QubnkA1OoNm5SzkzdRyi74QRuTeiEmWYuZYLflw5HQnBa
         xwWa+wvLDRi55jBintfVIEeDaQHH7ImaeK1Fql4rYRd8ZmwwjlKfw1+l6be6eoHUw0j0
         +Bsq0xLIg84wNoxSp+tOuGvXN83V8v+ohOc131z/m0RXr4IztZi+3IHddMCyZbFI9ljl
         R4seAXcy1C0E6maCx6997/u6qFWUCras2W94/SvUY+1kNI2OGacC6Ab12zx53zWqh9ny
         Ex4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689791709; x=1690396509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2abvvyLPjfrwEoupsEOTHIOOMVyeM8JABW3sZpsX+c=;
        b=ZiOtLtfmZhO5AX7byRdH16ptuBuse6bVaVxiebauCzxLCAp1qlGX3sSMJHxzjUR/DB
         AXgryNJ5oMrM/4EYwNzEruHaMeikbMPIY/DGFqpdACo38PGIvu9EFYXnMgUqD022hTyI
         ABlvBVDmbMVuGamRotu8nQodPp9F3H40LZgJT1qQIO/FricXwjN8WoqpwpSKJB190Su9
         4zT1znyloN5Iceg2y++bpFc+XMyb2WTJbEKHQkAUdjt2bIEjSGZbMO2ldVTZnbTKdgA9
         RToaH/QaecFCHG2P3qNVivBzkNbTo1J25m/FwI+IIes8Nj5AMbPR9iV3mo3PDVAxSIlz
         ysXg==
X-Gm-Message-State: ABy/qLZDdxmzBlxGlWdnIvWGTjimt02DCJuiYAvQveYy6ftzWaLSfZgj
        AR4WIyepmpoZ1nJfR7ObuAA=
X-Google-Smtp-Source: APBJJlGBGnmfeQj7NSDv1T5T78KoUYPTK0sESCJ9Z0C+0mL3eOOy1dFM1lzgwsUas3vnUqkRaINgAA==
X-Received: by 2002:a05:6808:50:b0:39c:59e2:dd79 with SMTP id v16-20020a056808005000b0039c59e2dd79mr319800oic.36.1689791709468;
        Wed, 19 Jul 2023 11:35:09 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id y7-20020a056808130700b003a3860b375esm2042016oiv.34.2023.07.19.11.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 11:35:09 -0700 (PDT)
Message-ID: <a1dcf888-ee91-f6e5-fe8b-db186a7864e2@gmail.com>
Date:   Wed, 19 Jul 2023 14:39:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs: rust: clarify what 'rustup override' does
Content-Language: en-US
To:     Trevor Gross <tmgross@umich.edu>, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
        corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230718054416.861412-1-tmgross@umich.edu>
 <20230718054416.861412-3-tmgross@umich.edu>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230718054416.861412-3-tmgross@umich.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 02:44, Trevor Gross wrote:
> The behavior of 'rustup override' is not very well known. This patch is
> a small edit that adds details about what it does, so users have a better
> understanding of how it affects their system toolchain (i.e., it does
> not affect system toolchain and only sets a directory-specific
> override).
> 
> Signed-off-by: Trevor Gross <tmgross@umich.edu>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
