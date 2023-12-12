Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA8880F978
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377191AbjLLVex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbjLLVev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:34:51 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CDDCE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:34:57 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so4439922b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702416897; x=1703021697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hVaNEiqljo3E3EXGRWD9OJDtRSGtGupo/F0W9RJyA9Y=;
        b=ePJaVRCYQkAmb4oTX3Ee5XFGGvlkk+Lj44VWmjS3GCTcZ9WsuXCwZbgjCJdksJIUo0
         rRtHi4uC1FIQdZCZ73eAJGr1PtytVk5Jz0qsYULnSJKVWXQk7vlLX57PIgGuZOaiAi+y
         rxrBXQ3i9wL2oyairnKxarpJ04rgvvf96kc+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416897; x=1703021697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVaNEiqljo3E3EXGRWD9OJDtRSGtGupo/F0W9RJyA9Y=;
        b=LuNmtzu7W2Imwp/ujCnz5ZjnXYgXqrw8mJTHVGAsupE2Vtnu+cBErfVAQUDhAZKu83
         hzFGCTr5jWcTy/LOYi4fZrqBVQmrgiHhDpMgQowmvYRc0borQdex332+Y2RrFwb8Qo8v
         082G07g021hqQpkJtKsnSjrSqNyaLiMS4zTbmWCwFuEnvD3fOPW2Vx+9/JbPyhETCv0b
         aBVjbEJbS8XkcpqlpjtbQfDB+EwfXXGcmJYOlOt4mJQhgvAMDnIhs+TCWT5Y2IxI/4EV
         pnd3VaG9meZfFepfyZZjBb916PwHfySwxL1QqMRov/kcE9b+qZotP82zoA5tDVUH2/pK
         AFMQ==
X-Gm-Message-State: AOJu0YwnXfS1J0eW7PQ6pP4YWqfNtuA8i4GimSeZEoUnU87dTu9HVUnF
        p+mowm+crpMOBKrbTWrQMPBflw==
X-Google-Smtp-Source: AGHT+IGrjdrYE8TdMjASxj4xkbtqabKRt1i/GLLm6pVTSOTn+15PoLIG2QekdDTvI5rmHrrxiENUQg==
X-Received: by 2002:a05:6a20:734f:b0:17b:1f76:86ee with SMTP id v15-20020a056a20734f00b0017b1f7686eemr7870972pzc.16.1702416897330;
        Tue, 12 Dec 2023 13:34:57 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx4-20020a056a001e0400b006cbb71186f7sm8557572pfb.29.2023.12.12.13.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:34:56 -0800 (PST)
Date:   Tue, 12 Dec 2023 13:34:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/2] VMCI: Remove handle_arr_calc_size()
Message-ID: <202312121334.459D42A1F@keescook>
References: <84e7f2d8e7c4c2eab68f958307d56546978f76e3.1702125347.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e7f2d8e7c4c2eab68f958307d56546978f76e3.1702125347.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 01:36:14PM +0100, Christophe JAILLET wrote:
> Use struct_size() instead of handle_arr_calc_size().
> This is much more conventional.
> 
> While at it, use size_add() when computing the needed size in
> vmci_handle_arr_append_entry(). This prevents from (unlikely) overflow
> when computing the new size to reallocate.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
