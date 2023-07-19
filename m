Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC41759D67
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjGSSey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGSSex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:34:53 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9FE172E;
        Wed, 19 Jul 2023 11:34:51 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a3b7f992e7so5239582b6e.2;
        Wed, 19 Jul 2023 11:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689791691; x=1690396491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zB3LqaQOpxPJYwif4dg7PP8NO7JhQYJx3rk9rfePgRI=;
        b=sZLLVyqR78ajdxdJHROMDKeiim+tsSBC7Doq8OA2a6WYX8MuJvUhuAluVq+3VFJLlK
         oLTA2juhLCAcIY6NERmhFQeiwCBbCS2zqVYyQkbCku+UWR0o3z++PEf2hLlv7NahgaUC
         g9V/3zVyDJbpzuzLasPfEIIltYLpPmXLqle2rBGE2NuKDh2VXiSIXK0sWX1moE+9qsfJ
         Ron7EmeuSMGqtWBWdIHUjG+srNSong0ggeQNUKhseK3HSO24gcnWU5O4ZxCEQvQRz287
         mZtuibPDKOFtj4tnmh++ZHg1jl+P9OAMZ7t9LKLCTiLHLg7EH4Yb2LBVw9H/CaZZGBL0
         iLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689791691; x=1690396491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zB3LqaQOpxPJYwif4dg7PP8NO7JhQYJx3rk9rfePgRI=;
        b=Ne012Wl1UyhrPYKXeB0xE9YX4GP96noB1f0FhNntymbetcIXmmgWr3zhRnNbX8AvNj
         0ZzfleduQmSNomCnSgQisLq8cnmP3/8dsJe7XuAmCvLNMJ2C7iulmqSJwJMmg3ZBOE/X
         iPAJvWw65Z0N9Fu2F3xBqnNrp9PcT5vvO8D1aIAWuSZ22AAgCuUjOe56I6Hdf8sQOl0H
         wPYRJzkw7T585J1WSeRxu7BnklRq4Kyh5YZaE4TTKApTp6x2XTzkRx4mMB4Jw1xf1eEz
         bqB/KluMKkzTnVm9OWvLXqtHltNT4wH5KB5uZ5Sdze0HFC7IwArLXvedC5w3GT3dko0n
         oTkQ==
X-Gm-Message-State: ABy/qLby17psLg8RCcf6qKIODnc8z2V58U0be262G140c4sc1Q9wTxn2
        8Ej7VjwUqdmXuma7dme7bqo=
X-Google-Smtp-Source: APBJJlFKsJea+5vnfv1R81R+wWwNE1UK699TDwpRwgftPIDPhtEwB4ecDpnEhBSkW82ZLwxxdqnyqg==
X-Received: by 2002:a05:6808:9bc:b0:3a4:317d:eb7c with SMTP id e28-20020a05680809bc00b003a4317deb7cmr3228451oig.0.1689791690896;
        Wed, 19 Jul 2023 11:34:50 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id y7-20020a056808130700b003a3860b375esm2042016oiv.34.2023.07.19.11.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 11:34:50 -0700 (PDT)
Message-ID: <a0402bdc-0a5b-7530-3253-efe376b6cffc@gmail.com>
Date:   Wed, 19 Jul 2023 14:19:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] docs: Move rustdoc output, cross-reference it
Content-Language: en-US
To:     Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net,
        ojeda@kernel.org
Cc:     jani.nikula@linux.intel.com, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org, rust-for-linux@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230718151534.4067460-1-carlos.bilbao@amd.com>
 <20230718151534.4067460-2-carlos.bilbao@amd.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230718151534.4067460-2-carlos.bilbao@amd.com>
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

On 7/18/23 12:15, Carlos Bilbao wrote:
> Generate rustdoc documentation with the rest of subsystem's documentation
> in Documentation/output. Add a cross reference to the generated rustdoc in
> Documentation/rust/index.rst if Sphinx target rustdoc is set.
> 
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
