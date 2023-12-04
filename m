Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A0E803A74
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344763AbjLDQgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344666AbjLDQg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:36:29 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A821AC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:36:35 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7b359dad0e7so42558839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701707794; x=1702312594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=us8gsjHarIzs7ZFxugV7AhwY15FOF2F+Lt1IT0vCWcg=;
        b=2v+inNOoVN+RdPntZFXEOBSYl40N39myJY1BPWjuXl78dL4v1xuLZ6Z0pt7wynm5iS
         1uHyMlVSvOvKqtpRRF6wyNGGmfYCcsvseBggFBSXOOBB4qzqMdyTTbZ/mcCEF6MnLrIq
         9vioo8PJPiuD/Y9w6Ux8ZVP3QeV8SdFzii2HY50+uhxbSAi/8bpzFNtsaSrUGaXynoSi
         VbULkOPQWo5N1i3yp+ZAwlYryvJbXwc+TZxs619yL5UiOtN+1/KU5vTJCHiubLSgtqA1
         x7XXFv9+OqwSBcgUQ663fRD9VhELsA84/m18bod9dn05WOKIPLDOd2bN7rVpWiPOxUou
         gSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707794; x=1702312594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=us8gsjHarIzs7ZFxugV7AhwY15FOF2F+Lt1IT0vCWcg=;
        b=Nk7Mm11XD4zgWpq7SSLCW+aI2fNTuafWacEmj0X9b54AIXUR2o3dHfahZOX9kMQj4M
         4+gWRbmg/9qXqInN7A2allyD25vjrarBobhwFX6K6lWyZ+U0a4JJVu4hEuuk2/JbG0tt
         f5yuhyoBV8JwOlUMqHLiUqjtE8BzqnXElLjkNcJM87f5RpL4wn7Lm3KD7ZviCAsK7Iwz
         HWqsZv95a/k95oLfO9MTZWpe5eyFbWiIkZOn8oL9tGIYJePU9Hi0oXAv/xA8KhFkM9gB
         KaY8V51/eSJLYhwdqW0WmCHLDtAFN1MIMkI+8NgdWPtU/Sx76qRxRdlMU3uXoL/unkuz
         4qKg==
X-Gm-Message-State: AOJu0Yy5qz6h9r2as1Fa4Uo5a6WIlM9dIZcDReS5md1z1bGfBwwYagkt
        BDImEPp+437M07PE4S+GfK3WEE0intB6KyqOxNuW2w==
X-Google-Smtp-Source: AGHT+IHjyjAJhwSe8ziMBMJFBByJmIMEmcQoExQzbnRV5GgqgZMiLUrJK7LGu8JmfnoWGWjP1iGjpQ==
X-Received: by 2002:a5e:8303:0:b0:7b4:2e28:2343 with SMTP id x3-20020a5e8303000000b007b42e282343mr5979763iom.1.1701707794411;
        Mon, 04 Dec 2023 08:36:34 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p21-20020a02b395000000b0046667bf4555sm2636149jan.34.2023.12.04.08.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:36:33 -0800 (PST)
Message-ID: <438a8b44-ea5f-4e13-bd7e-e1c2e2a481c4@kernel.dk>
Date:   Mon, 4 Dec 2023 09:36:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tee: Use iov_iter to better support shared buffer
 registration
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <20231129164439.1130903-1-arnaud.pouliquen@foss.st.com>
 <CAFA6WYP=_BPt_x1FxeVdAdB_mMjdz8QzvkfFXx-5msy8PZG6nA@mail.gmail.com>
 <60b67bd5-36c3-4318-9a2b-bcf172681d45@foss.st.com>
 <CAFA6WYN9eJ1vGTKfGXy7M709=aGkg1oF3odK7iGRUBokbKtqzw@mail.gmail.com>
 <40902a86-3b88-45bc-bb6f-2de0eb48dc9d@foss.st.com>
 <CAFA6WYPGkpVN-XP7eAzLXMReRi7FBp3boKzhMfasasuE=XWBow@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFA6WYPGkpVN-XP7eAzLXMReRi7FBp3boKzhMfasasuE=XWBow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 5:42 AM, Sumit Garg wrote:
> IMO, access_ok() should be the first thing that import_ubuf() or
> import_single_range() should do, something as follows:
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 8ff6824a1005..4aee0371824c 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1384,10 +1384,10 @@ EXPORT_SYMBOL(import_single_range);
> 
>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
>  {
> -       if (len > MAX_RW_COUNT)
> -               len = MAX_RW_COUNT;
>         if (unlikely(!access_ok(buf, len)))
>                 return -EFAULT;
> +       if (len > MAX_RW_COUNT)
> +               len = MAX_RW_COUNT;
> 
>         iov_iter_ubuf(i, rw, buf, len);
>         return 0;
> 
> Jens A., Al Viro,
> 
> Was there any particular reason which I am unaware of to perform
> access_ok() check on modified input length?

This change makes sense to me, and seems consistent with what is done
elsewhere too.

-- 
Jens Axboe

